Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE36583804
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 06:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiG1EtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 00:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiG1EtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 00:49:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8957250
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:49:07 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id n6-20020a056e02100600b002dde21bcbe5so614183ilj.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0z7KKiTlUD3lnxQuuFn45mKfJhR2UJ9UCs+uF8CFttU=;
        b=VrBV3HxDV4h61ch9dg0xqZw3KUqRoCiqD7jdOJr/vGUbuskzqsl+Xx48HJK50UN5Hp
         nzMsv+StH6mBAkpWizf/fO7zFOFjVuinE9Mcjpupdid2+msb6UIfWOnlxYO6+DKlUTOb
         o7hE3nqVfD04I0jj+d2DrJDiJodo8+Q28e7b5dEg0DELcY0b2jCqd+CHjh3EpbAMJe5W
         rr5UQ89rPiankXDZJ6ldCh/3rqYdcb0vtu0eLQsSVe9QePPudH2eXoMX4HrFGc0LkG+9
         oE4pxgzmqU6xLSfoMPDX1zXf4I9VLvFBBxIsVkRLHi4YBnq1JM/WYDSgsqwn4H/paQWI
         nn5A==
X-Gm-Message-State: AJIora8lwWfQXtPw2Jjzn0oV/0ElpuOO1t4+D9z2sSgXz7JufTfdIhNL
        2nj/p5ZhSce3HcrRT95nOwvCliodJPxsKCP7UfbGBW41sH7x
X-Google-Smtp-Source: AGRyM1u8lPBudE5pLrz3NZpw/V06HIPdRy5HwV/+Wo3bPpsCmZAzCmt/OctDm3ez4N8YW7x3hI+GPT/HBOfm/R2H+9o0HBeSNCST
MIME-Version: 1.0
X-Received: by 2002:a5e:a618:0:b0:67c:27b4:1f93 with SMTP id
 q24-20020a5ea618000000b0067c27b41f93mr8886727ioi.75.1658983746505; Wed, 27
 Jul 2022 21:49:06 -0700 (PDT)
Date:   Wed, 27 Jul 2022 21:49:06 -0700
In-Reply-To: <20220728042901.668-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e612e405e4d640fe@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in tc_modify_qdisc

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (10 ticks this GP) idle=3ae/1/0x4000000000000000 softirq=8207/8207 fqs=0 
	(detected by 1, t=10563 jiffies, g=10445, q=543)

============================================
WARNING: possible recursive locking detected
5.14.0-rc5-syzkaller #0 Not tainted
--------------------------------------------
syz-executor.0/5969 is trying to acquire lock:
ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: rcu_dump_cpu_stacks+0xd0/0x3f0 kernel/rcu/tree_stall.h:337

but task is already holding lock:
ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:543 [inline]
ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:709 [inline]
ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3922 [inline]
ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0xc9a/0x20c0 kernel/rcu/tree.c:2641

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rcu_node_0);
  lock(rcu_node_0);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor.0/5969:
 #0: ffffffff8d0cd4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:72 [inline]
 #0: ffffffff8d0cd4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3be/0xb80 net/core/rtnetlink.c:5571
 #1: ffff88802d07a908 (&sch->q.lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:359 [inline]
 #1: ffff88802d07a908 (&sch->q.lock){+.-.}-{2:2}, at: dev_reset_queue+0x8a/0x130 net/sched/sch_generic.c:1226
 #2: ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:543 [inline]
 #2: ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:709 [inline]
 #2: ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3922 [inline]
 #2: ffffffff8b985018 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0xc9a/0x20c0 kernel/rcu/tree.c:2641

stack backtrace:
CPU: 1 PID: 5969 Comm: syz-executor.0 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
 check_deadlock kernel/locking/lockdep.c:2987 [inline]
 validate_chain kernel/locking/lockdep.c:3776 [inline]
 __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
 rcu_dump_cpu_stacks+0xd0/0x3f0 kernel/rcu/tree_stall.h:337
 print_other_cpu_stall kernel/rcu/tree_stall.h:561 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:709 [inline]
 rcu_pending kernel/rcu/tree.c:3922 [inline]
 rcu_sched_clock_irq+0x1cc6/0x20c0 kernel/rcu/tree.c:2641
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1421
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:get_current arch/x86/include/asm/current.h:15 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x13/0x60 kernel/kcov.c:196
Code: 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 65 8b 05 39 37 8c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 <65> 48 8b 14 25 00 f0 01 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82
RSP: 0018:ffffc90001a9f210 EFLAGS: 00000246
RAX: 0000000000000201 RBX: 00000000028311d6 RCX: 0000000000000000
RDX: ffff88801a873880 RSI: ffffffff816539ca RDI: ffff8880b9c26608
RBP: ffff8880b9c265c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81653947 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88802d07ab40 R14: dffffc0000000000 R15: 0000000000000010
 hrtimer_active+0x17a/0x1f0 kernel/time/hrtimer.c:1615
 hrtimer_try_to_cancel+0x21/0x1e0 kernel/time/hrtimer.c:1328
 hrtimer_cancel+0x13/0x40 kernel/time/hrtimer.c:1443
 taprio_reset+0x72/0x280 net/sched/sch_taprio.c:1622
 qdisc_reset+0xdb/0x730 net/sched/sch_generic.c:977
 dev_reset_queue+0x92/0x130 net/sched/sch_generic.c:1228
 netdev_for_each_tx_queue include/linux/netdevice.h:2337 [inline]
 dev_deactivate_many+0x51c/0xc40 net/sched/sch_generic.c:1294
 dev_deactivate+0xe9/0x1b0 net/sched/sch_generic.c:1317
 qdisc_graft+0xdac/0x1260 net/sched/sch_api.c:1055
 tc_modify_qdisc+0xba4/0x1a60 net/sched/sch_api.c:1674
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5574
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:703 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:723
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2392
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2446
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2475
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f141db04188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd8eafafcf R14: 00007f141db04300 R15: 0000000000022000


Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1589b47a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
