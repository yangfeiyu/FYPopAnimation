//
//  ViewController.m
//  FYPopAnimation
//
//  Created by yangfeiyu on 15-4-14.
//  Copyright (c) 2015年 NJJ. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import <objc/runtime.h>

@interface ViewController () <UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned int count = 0;
        Ivar *var = class_copyIvarList([UIGestureRecognizer class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar _var = *(var + i);
//            NSLog(@"%s",ivar_getTypeEncoding(_var));
//            NSLog(@"%s",ivar_getName(_var));
        }
        
        UIGestureRecognizer *gesture = self.navigationController.interactivePopGestureRecognizer;
        
        gesture.enabled = NO;
        UIView *gestureView = gesture.view;
        
        NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
        id gestureRecognizerTarget = [_targets firstObject];
        NSLog(@"%@",gestureRecognizerTarget);
        id target = [gestureRecognizerTarget valueForKey:@"_target"];
        
        SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
        
        UIPanGestureRecognizer *gesture1 = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handleTransition];
        [gestureView addGestureRecognizer:gesture1];
    });
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按钮" style:UIBarButtonItemStylePlain target:self action:@selector(didTapRightButton)];
    
}

- (void)didTapRightButton {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
