Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496C4ECADC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349396AbiC3RkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349405AbiC3RkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:40:05 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C7D7630
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:38:19 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso11838665ilu.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2oIcKnlnqDHjWd+W9Yy84Ztea3aN/7HUmr7DlykSF2s=;
        b=KGlP+hnxhPv0YcTafddx/mNVNQCHsTbF4A/A7YS9Cv5aZ+Jg3vbExix9DgzeK1G0EH
         tx0LhGZ/6NG8wHKIKMRSGtkTUVuawEhp2s6bAxDLxIqxQ/IDrxuc+C+0W/mBrLX9c0HQ
         QJbKK/Ef8YVJF4/2iNtcxv/ShUhpAMIPxxbB12/eigcIB+TMlunhfiGgr3iLQH0NuAue
         N+84lrsAOAynO+XVgxnyD0EGqXql31G+HDwRqeKeFjLy1fnJCTt0QM3RgAVOwBxzwxg/
         CJiLRNkAiD5Q1xmigaKoYncmS7Ov9gYL4PkDZBY/texyfp0UasVVIJmu6UgzNK2VrJ9Z
         EJkQ==
X-Gm-Message-State: AOAM530JNGIsQVrakKf3Lx6gqx7ILgbuXFwosxBI2LxABZUvpJzA+3vu
        TcRP2PyMHhlQ4QPVlBFtTFABr+AsW667DuqB9sleesGI7hGg
X-Google-Smtp-Source: ABdhPJwwyUYpS+QlootSwZxeHN3XCi364qT5pjaduUL2NrRbmw5jRYNks15M+Mvf6IVMcY7ju4Cot+KT20QYschP2a8kY7YM7VQ8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2645:b0:323:6661:8694 with SMTP id
 n5-20020a056638264500b0032366618694mr470101jat.307.1648661899103; Wed, 30 Mar
 2022 10:38:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:38:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9d4b005db73020a@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in blkg_free
From:   syzbot <syzbot+16505ee346651e5d2151@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d888c83fcec7 fs: fix fd table size alignment properly
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1661f2fd700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4022847dc70444
dashboard link: https://syzkaller.appspot.com/bug?extid=16505ee346651e5d2151
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16505ee346651e5d2151@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3706, name: syz-executor.1
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by syz-executor.1/3706:
 #0: ffffffff8bd7f2c0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2524 [inline]
 #0: ffffffff8bd7f2c0 (rcu_callback){....}-{0:0}, at: rcu_core+0x73d/0x1880 kernel/rcu/tree.c:2786
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 2 PID: 3706 Comm: syz-executor.1 Not tainted 5.17.0-syzkaller-13034-gd888c83fcec7 #0
Call Trace:
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
preempt_c[  826.180995][    C2] RSP: 0018:ffffc900022bfc78 EFLAGS: 00000206
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888017b6c060 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817e14b8 R11: 0000000000000001 R12: dffffc0000000000
R13: 00007fff6290d0bc R14: 0000000000000004 R15: 0000000000000000
 do_wait+0x150/0xce0 kernel/exit.c:1494
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1709
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RSP: 002b:00007fff6290d030 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RDX: 0000000040000001 RSI: 00007fff6290d0bc RDI: 00000000ffffffff
RBP: 00007fff6290d0bc R08: 0000000000000000 R09: 00007fff629e5080
5.17.0-syzkaller-13034-gd888c83fcec7 #0 Tainted: G        W        
--------------------------------
syz-executor.1/3706 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff88801a8603a0 (&xa->xa_lock#9){+.?.}-{2:2}, at: xa_destroy+0xb3/0x360 lib/xarray.c:2207
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  blk_mq_init_allocated_queue+0x457/0x13d0 block/blk-mq.c:4053
  blk_mq_init_queue_data block/blk-mq.c:3906 [inline]
  __blk_mq_alloc_disk+0xd1/0x1c0 block/blk-mq.c:3926
  floppy_alloc_disk+0x3d/0x390 drivers/block/floppy.c:4495
  do_floppy_init drivers/block/floppy.c:4576 [inline]
  floppy_async_init+0x316/0x21ca drivers/block/floppy.c:4746
  async_run_entry_fn+0x9d/0x550 kernel/async.c:127
  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
  kthread+0x2e9/0x3a0 kernel/kthread.c:376
irq event stamp: 18620681
hardirqs last disabled at (18620681): [<ffffffff896120de>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (18620681): [<ffffffff896120de>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (18619410): [<ffffffff812c3d7c>] fpu_clone+0x40c/0xc00 arch/x86/kernel/fpu/core.c:611
softirqs last disabled at (18620027): [<ffffffff8146ca53>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (18620027): [<ffffffff8146ca53>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  <Interrupt>

 *** DEADLOCK ***

 #0: ffffffff8bd7f2c0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2524 [inline]
 #0: ffffffff8bd7f2c0 (rcu_callback){....}-{0:0}, at: rcu_core+0x73d/0x1880 kernel/rcu/tree.c:2786
stack backtrace:
CPU: 2 PID: 3706 Comm: syz-executor.1 Tainted: G        W         5.17.0-syzkaller-13034-gd888c83fcec7 #0
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 mark_lock kernel/locking/lockdep.c:4571 [inline]
 mark_usage kernel/locking/lockdep.c:4502 [inline]
 __lock_acquire+0x11e7/0x56c0 kernel/locking/lockdep.c:4983
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 xa_destroy+0xb3/0x360 lib/xarray.c:2207
 blk_mq_release+0x2b1/0x3e0 block/blk-mq.c:3887
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 ca 69 fb f7 48 89 ef e8 12 e9 fb f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> b3 03 ef f7 65 8b 05 ac 4c a1 76 85 c0 74 0a 5b 5d c3 e8 60 f1
RSP: 0018:ffffc900022bfc78 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1b6c0d1
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888017b6c060 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817e14b8 R11: 0000000000000001 R12: dffffc0000000000
R13: 00007fff6290d0bc R14: 0000000000000004 R15: 0000000000000000
 do_wait+0x150/0xce0 kernel/exit.c:1494
 kernel_wait4+0x14c/0x260 kernel/exit.c:1681
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1709
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f23aaa874e7
Code: 89 7c 24 10 48 89 4c 24 18 e8 35 50 02 00 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 10 e8 65 50 02 00 8b 44
RSP: 002b:00007fff6290d030 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000004046 RCX: 00007f23aaa874e7
RDX: 0000000040000001 RSI: 00007fff6290d0bc RDI: 00000000ffffffff
RBP: 00007fff6290d0bc R08: 0000000000000000 R09: 00007fff629e5080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:577
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 2 PID: 3706 Comm: syz-executor.1 Tainted: G        W         5.17.0-syzkaller-13034-gd888c83fcec7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9733
 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
 __mutex_lock+0x9f/0x12f0 kernel/locking/mutex.c:733
 blk_trace_shutdown+0x1d/0x100 kernel/trace/blktrace.c:773
 blk_release_queue+0x16f/0x320 block/blk-sysfs.c:782
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 blkg_free block/blk-cgroup.c:78 [inline]
 __blkg_release+0x105/0x160 block/blk-cgroup.c:102
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 ca 69 fb f7 48 89 ef e8 12 e9 fb f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> b3 03 ef f7 65 8b 05 ac 4c a1 76 85 c0 74 0a 5b 5d c3 e8 60 f1
RSP: 0018:ffffc900022bfc78 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1b6c0d1
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888017b6c060 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817e14b8 R11: 0000000000000001 R12: dffffc0000000000
R13: 00007fff6290d0bc R14: 0000000000000004 R15: 0000000000000000
 do_wait+0x150/0xce0 kernel/exit.c:1494
 kernel_wait4+0x14c/0x260 kernel/exit.c:1681
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1709
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f23aaa874e7
Code: 89 7c 24 10 48 89 4c 24 18 e8 35 50 02 00 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 10 e8 65 50 02 00 8b 44
RSP: 002b:00007fff6290d030 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000004046 RCX: 00007f23aaa874e7
RDX: 0000000040000001 RSI: 00007fff6290d0bc RDI: 00000000ffffffff
RBP: 00007fff6290d0bc R08: 0000000000000000 R09: 00007fff629e5080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 00000000000c9984 R14: 0000000000000007 R15: 00007fff6290d120
 </TASK>
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/2
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff8134abe0>] unwind_next_frame+0x120/0x1ce0 arch/x86/kernel/unwind_orc.c:428
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         5.17.0-syzkaller-13034-gd888c83fcec7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9733
 blk_release_queue+0x1f/0x320 block/blk-sysfs.c:766
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
Code: ff ff ff 48 89 df e8 94 c5 61 f8 e9 55 ff ff ff 4c 89 e7 e8 87 c5 61 f8 eb 96 0f 1f 44 00 00 eb 07 0f 00 2d 77 74 65 00 fb f4 <c3> cc cc cc cc 41 55 41 54 55 48 89 fd 53 e8 b2 b7 16 f8 e8 6d 1d
RAX: 000000000015ed0e RBX: ffff888011942240 RCX: ffffffff895e2821
RBP: 0000000000000002 R08: 0000000000000000 R09: ffff88802cc3b013
R13: 0000000000000002 R14: ffffffff8db634d0 R15: 0000000000000000
 default_idle_call+0x87/0xd0 kernel/sched/idle.c:109
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	ca 69 fb             	lret   $0xfb69
   7:	f7 48 89 ef e8 12 e9 	testl  $0xe912e8ef,-0x77(%rax)
   e:	fb                   	sti
   f:	f7 81 e3 00 02 00 00 	testl  $0x9c257500,0x200e3(%rcx)
  16:	75 25 9c
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 b3 03 ef f7       	callq  0xf7ef03e2 <-- trapping instruction
  2f:	65 8b 05 ac 4c a1 76 	mov    %gs:0x76a14cac(%rip),%eax        # 0x76a14ce2
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	60                   	(bad)
  3f:	f1                   	icebp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
