Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599295827E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiG0NoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiG0NoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:44:14 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865983E771
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:44:13 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id i16-20020a5d9350000000b0067bce490d06so6167030ioo.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3H/SpwZcX2OIl+VyPiB9jZZf75yV+/54+fXdjRfG9ms=;
        b=Lmoz+71uawzMBmpTVksTD9eNin/NFL7vnt1uKy851a2Q2UE/YeI342mGfN0b5qIU91
         9F7qYELl9esH1D+s7PmKX3fmrPC+MszuDAx+580+cg9ntm/9524JyT1mwwoTWdbO3gg0
         HRlBpbzSP3W2KBaFE30yvVxee7JoEgRdf8+vxREncI9Nbf2oK7s2vYy3fnA+py1D4nWc
         LTFvN2OaBNQJ7TAsnS52i2cMQrevbNmLYwsF5WOjpH23h/h8C+l/y7oCqkRE7A3QMhTp
         vPlteWF2vb6OZUABeTGzRobNkwx2TVq0Y9HP6Egd0wSHUstu71blXYkP7jllHZu2tSTp
         u4KQ==
X-Gm-Message-State: AJIora+I2ltYO8nsAzSSt8DKQqOREHtRHjR1piI9i7W9jCqBN8ezr7Wu
        TOdQcwmG0MrcogeVq2VhSMqq2fZuhOyJv3W1W3m/2yqOKZIH
X-Google-Smtp-Source: AGRyM1tcs81pB6OXWen5wImcyEWgYgf6xdiubdxrbZNj7SztXyq1d09D/xmk6B7Nr/xcmIFuL6euZ0k2qNkNWDuEJNFtbktg3y5p
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3297:b0:341:76ba:dad2 with SMTP id
 f23-20020a056638329700b0034176badad2mr8730083jav.19.1658929452826; Wed, 27
 Jul 2022 06:44:12 -0700 (PDT)
Date:   Wed, 27 Jul 2022 06:44:12 -0700
In-Reply-To: <20220727132847.227-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be44fd05e4c99c48@google.com>
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
INFO: rcu detected stall in ieee80211_iface_work

hrtimer: interrupt took 7516710 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=172/1/0x4000000000000000 softirq=7931/7939 fqs=0 
	(detected by 1, t=10571 jiffies, g=9957, q=578)

============================================
WARNING: possible recursive locking detected
5.13.0-rc6-syzkaller #0 Not tainted
--------------------------------------------
kworker/u4:5/216 is trying to acquire lock:
ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: rcu_dump_cpu_stacks+0xd0/0x3f0 kernel/rcu/tree_stall.h:336

but task is already holding lock:
ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:542 [inline]
ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:708 [inline]
ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3911 [inline]
ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0xc63/0x2080 kernel/rcu/tree.c:2649

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rcu_node_0);
  lock(rcu_node_0);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by kworker/u4:5/216:
 #0: ffff88802de11138 ((wq_completion)phy6){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88802de11138 ((wq_completion)phy6){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff88802de11138 ((wq_completion)phy6){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88802de11138 ((wq_completion)phy6){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88802de11138 ((wq_completion)phy6){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88802de11138 ((wq_completion)phy6){+.+.}-{0:0}, at: process_one_work+0x871/0x1600 kernel/workqueue.c:2247
 #1: ffffc900018cfda8 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1600 kernel/workqueue.c:2251
 #2: ffff88801607cd00 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211/ieee80211_i.h:1003 [inline]
 #2: ffff88801607cd00 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_rx_queued_mgmt+0xe9/0x1870 net/mac80211/ibss.c:1631
 #3: ffff88802deb8170 (&rdev->bss_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:359 [inline]
 #3: ffff88802deb8170 (&rdev->bss_lock){+...}-{2:2}, at: cfg80211_bss_update+0x88/0x1e00 net/wireless/scan.c:1688
 #4: ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:542 [inline]
 #4: ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:708 [inline]
 #4: ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3911 [inline]
 #4: ffffffff8b782218 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0xc63/0x2080 kernel/rcu/tree.c:2649

stack backtrace:
CPU: 1 PID: 216 Comm: kworker/u4:5 Not tainted 5.13.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: phy6 ieee80211_iface_work
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_deadlock_bug kernel/locking/lockdep.c:2831 [inline]
 check_deadlock kernel/locking/lockdep.c:2874 [inline]
 validate_chain kernel/locking/lockdep.c:3663 [inline]
 __lock_acquire.cold+0x22f/0x3b4 kernel/locking/lockdep.c:4902
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
 rcu_dump_cpu_stacks+0xd0/0x3f0 kernel/rcu/tree_stall.h:336
 print_other_cpu_stall kernel/rcu/tree_stall.h:560 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:708 [inline]
 rcu_pending kernel/rcu/tree.c:3911 [inline]
 rcu_sched_clock_irq+0x1a79/0x2080 kernel/rcu/tree.c:2649
 update_process_times+0x16d/0x200 kernel/time/timer.c:1796
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1374
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:rol32 include/linux/bitops.h:108 [inline]
RIP: 0010:jhash2 include/linux/jhash.h:129 [inline]
RIP: 0010:hash_stack lib/stackdepot.c:181 [inline]
RIP: 0010:stack_depot_save+0xcf/0x4e0 lib/stackdepot.c:273
Code: 41 89 c0 89 f8 01 df c1 c0 06 44 31 c0 29 c3 41 89 d8 89 c3 01 f8 c1 c3 08 44 31 c3 41 89 d8 29 df 01 c3 41 c1 c0 10 44 31 c7 <41> 89 f8 29 f8 01 df 41 c1 c8 0d 44 31 c0 41 89 c0 29 c3 01 f8 41
RSP: 0018:ffffc900018ce878 EFLAGS: 00000286
RAX: 00000000ba727ad1 RBX: 00000000b859d5f5 RCX: 0000000000000011
RDX: ffffc900018ce93c RSI: 0000000000012b20 RDI: 00000000ba6c0718
RBP: ffffc900018ce8e8 R08: 000000005b24fde7 R09: ffffffff8dbd5dc4
R10: fffff52000319d03 R11: 0000000000084087 R12: 0000000000000013
R13: 0000000000000013 R14: 0000000000012b20 R15: 0000000000012b20
 kasan_save_stack+0x32/0x40 mm/kasan/common.c:40
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:428 [inline]
 __kasan_slab_alloc+0x84/0xa0 mm/kasan/common.c:461
 kasan_slab_alloc include/linux/kasan.h:236 [inline]
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:2914 [inline]
 slab_alloc mm/slub.c:2922 [inline]
 kmem_cache_alloc+0x219/0x3a0 mm/slub.c:2927
 kmem_cache_zalloc include/linux/slab.h:676 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:171
 __debug_object_init+0x7a/0xd10 lib/debugobjects.c:560
 debug_object_init lib/debugobjects.c:615 [inline]
 debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:701
 debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]
 kvfree_call_rcu+0x32/0x8c0 kernel/rcu/tree.c:3588
 cfg80211_update_known_bss+0x833/0xa60 net/wireless/scan.c:1651
 cfg80211_bss_update+0xef/0x1e00 net/wireless/scan.c:1698
 cfg80211_inform_single_bss_frame_data+0x6e8/0xee0 net/wireless/scan.c:2404
 cfg80211_inform_bss_frame_data+0xa7/0xb10 net/wireless/scan.c:2437
 ieee80211_bss_info_update+0x3ce/0xb20 net/mac80211/scan.c:190
 ieee80211_rx_bss_info net/mac80211/ibss.c:1126 [inline]
 ieee80211_rx_mgmt_probe_beacon+0xccd/0x16b0 net/mac80211/ibss.c:1615
 ieee80211_ibss_rx_queued_mgmt+0xe43/0x1870 net/mac80211/ibss.c:1642
 ieee80211_iface_work+0x761/0x9e0 net/mac80211/iface.c:1439
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


Tested on:

commit:         d6765985 Revert "be2net: disable bh with spin_lock in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e98d64080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d43f3e8616689bf
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d694d2080000

