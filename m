Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15234EB569
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiC2Vo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiC2VoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:44:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6733A04
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:42:40 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f7-20020a056602088700b00645ebbe277cso13204017ioz.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M2PV7/NvNeQv/6cvN2UQyzaC5uPl4rNbDHWaa31+KxE=;
        b=2Lm+Cp5uiX2JcZDjexgddRtYuH3b97rb5+lRChrXkJFVgegJvbOD6CC5q2G8kh0Zu8
         jWjTfHHE8EZgFVW3/9rDsMk/+e5/FcpI3oebkdhaRbpLJrRUDVLiFdz0hLoboAKRnhia
         kKCgNjq1yXtKsuJvo9XB+egSSNNLAJoT9HMi2HSmAdmA+5Qwex6VJWLdTXET/8OgIwTM
         L/5wFhkppjAQ8/en2D3IYJ3MitKxAiIeEvoRWvEcBk9VVFsto35U1N/ieOTiZfmjwUOW
         5l8z0NkwozYCgKFlPzflaLoKRYi1BgVjyjbgt8GDbSQl7/PwqEtmN6YV6CkEAyBiGlTC
         fXAw==
X-Gm-Message-State: AOAM5327heiP0GsnSzzkesQUMIs0siOOU8yk75A0RumwO3kxr/gkCF+I
        p0h7laVKlacRUA5FermCn87CMMzmMIHY06qaqCDMulT+i/wL
X-Google-Smtp-Source: ABdhPJzlFbC5teMav8cqcSVfBNO8N0KCR+vf6Sab3F44wx5SDqdQyWZQcE2TEyZ3uEujh9CZHy+YhzYejuUKkiy82AzPtCj6CO6/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a9:b0:323:600c:e42c with SMTP id
 t41-20020a05663834a900b00323600ce42cmr8991938jal.75.1648590159465; Tue, 29
 Mar 2022 14:42:39 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:42:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5cfe505db624e84@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in xa_destroy
From:   syzbot <syzbot+ef9c11f60b926d1682a5@syzkaller.appspotmail.com>
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

HEAD commit:    1930a6e739c4 Merge tag 'ptrace-cleanups-for-v5.18' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133bd72b700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39f9ae4aa54206fb
dashboard link: https://syzkaller.appspot.com/bug?extid=ef9c11f60b926d1682a5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef9c11f60b926d1682a5@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by swapper/1/0:
 #0: ffffffff8bd81e40 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2524 [inline]
 #0: ffffffff8bd81e40 (rcu_callback){....}-{0:0}, at: rcu_core+0x73d/0x1880 kernel/rcu/tree.c:2786
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0-syzkaller-12882-g1930a6e739c4 #0
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
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
Code: ff ff ff 48 89 df e8 c4 8c 63 f8 e9 55 ff ff ff 4c 89 e7 e8 b7 8c 63 f8 eb 96 0f 1f 44 00 00 eb 07 0f 00 2d 57 d4 65 00 fb f4 <c3> cc cc cc cc 41 55 41 54 55 48 89 fd 53 e8 92 e4 17 f8 e8 7d 21
RSP: 0018:ffffc9000045fdf8 EFLAGS: 00000202
RAX: 000000000036c1fd RBX: ffff88801149d700 RCX: ffffffff895dcc51
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff88802cb3af93
R10: ffffed10059675f2 R11: 0000000000000000 R12: ffffed1002293ae0
R13: 0000000000000001 R14: ffffffff8db640d0 R15: 0000000000000000
 default_idle_call+0x87/0xd0 kernel/sched/idle.c:109
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>

================================
WARNING: inconsistent lock state
5.17.0-syzkaller-12882-g1930a6e739c4 #0 Tainted: G        W        
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/1/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff888042c5ba30 (&xa->xa_lock#8){+.?.}-{2:2}, at: xa_destroy+0xb3/0x360 lib/xarray.c:2207
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5641 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:349 [inline]
  xa_insert include/linux/xarray.h:772 [inline]
  blk_mq_init_hctx block/blk-mq.c:3501 [inline]
  blk_mq_alloc_and_init_hctx+0x52d/0x1190 block/blk-mq.c:3962
  blk_mq_realloc_hw_ctxs+0x43d/0x590 block/blk-mq.c:3991
  blk_mq_init_allocated_queue+0x457/0x13d0 block/blk-mq.c:4053
  blk_mq_init_queue_data block/blk-mq.c:3906 [inline]
  __blk_mq_alloc_disk+0xd1/0x1c0 block/blk-mq.c:3926
  floppy_alloc_disk+0x3d/0x390 drivers/block/floppy.c:4495
  do_floppy_init drivers/block/floppy.c:4576 [inline]
  floppy_async_init+0x316/0x21ca drivers/block/floppy.c:4746
  async_run_entry_fn+0x9d/0x550 kernel/async.c:127
  process_one_work+0x996/0x1610 kernel/workqueue.c:2289
  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
  kthread+0x2e9/0x3a0 kernel/kthread.c:376
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
irq event stamp: 3588931
hardirqs last  enabled at (3588930): [<ffffffff81c44ea5>] kasan_quarantine_put+0xf5/0x210 mm/kasan/quarantine.c:231
hardirqs last disabled at (3588931): [<ffffffff8960c0fe>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (3588931): [<ffffffff8960c0fe>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (3588522): [<ffffffff81479a93>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last  enabled at (3588522): [<ffffffff81479a93>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
softirqs last disabled at (3588607): [<ffffffff81479a93>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (3588607): [<ffffffff81479a93>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&xa->xa_lock#8);
  <Interrupt>
    lock(&xa->xa_lock#8);

 *** DEADLOCK ***

1 lock held by swapper/1/0:
 #0: ffffffff8bd81e40 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2524 [inline]
 #0: ffffffff8bd81e40 (rcu_callback){....}-{0:0}, at: rcu_core+0x73d/0x1880 kernel/rcu/tree.c:2786

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.17.0-syzkaller-12882-g1930a6e739c4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3935 [inline]
 valid_state kernel/locking/lockdep.c:3947 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4150 [inline]
 mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4607
 mark_lock kernel/locking/lockdep.c:4571 [inline]
 mark_usage kernel/locking/lockdep.c:4502 [inline]
 __lock_acquire+0x11e7/0x56c0 kernel/locking/lockdep.c:4983
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 xa_destroy+0xb3/0x360 lib/xarray.c:2207
 blk_mq_release+0x2b1/0x3e0 block/blk-mq.c:3887
 blk_release_queue+0x15b/0x320 block/blk-sysfs.c:780
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
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:734
Code: ff ff ff 48 89 df e8 c4 8c 63 f8 e9 55 ff ff ff 4c 89 e7 e8 b7 8c 63 f8 eb 96 0f 1f 44 00 00 eb 07 0f 00 2d 57 d4 65 00 fb f4 <c3> cc cc cc cc 41 55 41 54 55 48 89 fd 53 e8 92 e4 17 f8 e8 7d 21
RSP: 0018:ffffc9000045fdf8 EFLAGS: 00000202
RAX: 000000000036c1fd RBX: ffff88801149d700 RCX: ffffffff895dcc51
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff88802cb3af93
R10: ffffed10059675f2 R11: 0000000000000000 R12: ffffed1002293ae0
R13: 0000000000000001 R14: ffffffff8db640d0 R15: 0000000000000000
 default_idle_call+0x87/0xd0 kernel/sched/idle.c:109
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x401/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x265/0x340 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>
ODEBUG: object ffffc90000528af0 is NOT on stack ffffc90000458000, but annotated.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at lib/debugobjects.c:548 debug_object_is_on_stack lib/debugobjects.c:545 [inline]
WARNING: CPU: 1 PID: 0 at lib/debugobjects.c:548 __debug_object_init.cold+0x252/0x2e5 lib/debugobjects.c:607
Modules linked in:

CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.17.0-syzkaller-12882-g1930a6e739c4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:548 [inline]
RIP: 0010:__debug_object_init.cold+0x252/0x2e5 lib/debugobjects.c:607
Code: 00 48 8d 7b 20 48 89 fa 48 c1 ea 03 80 3c 02 00 74 05 e8 b4 74 9b f8 48 8b 53 20 4c 89 e6 48 c7 c7 80 88 26 8a e8 a1 4c f1 ff <0f> 0b e9 d3 7f c7 fa 48 b8 00 01 00 00 00 00 ad de 48 89 ef 48 89
RSP: 0018:ffffc90000528920 EFLAGS: 00010286
RAX: 0000000000000050 RBX: ffff88801149d700 RCX: 0000000000000000
RDX: ffff88801149d700 RSI: ffffffff815fcd18 RDI: fffff520000a5116
RBP: ffff88801149d700 R08: 0000000000000050 R09: 0000000000000001
R10: ffffffff815f76ee R11: 0000000000000000 R12: ffffc90000528af0
R13: 1ffff920000a5133 R14: ffffffff90713c70 R15: ffffffff90713c68
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000056b66efc CR3: 000000006d58f000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __init_work+0x2d/0x50 kernel/workqueue.c:521
 synchronize_rcu_expedited+0x392/0x620 kernel/rcu/tree_exp.h:851
 synchronize_rcu+0x132/0x190 kernel/rcu/tree.c:3789
 blk_trace_cleanup kernel/trace/blktrace.c:350 [inline]
 __blk_trace_remove+0xcb/0x1c0 kernel/trace/blktrace.c:365
 blk_trace_shutdown+0x85/0x100 kernel/trace/blktrace.c:777
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
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:734
Code: ff ff ff 48 89 df e8 c4 8c 63 f8 e9 55 ff ff ff 4c 89 e7 e8 b7 8c 63 f8 eb 96 0f 1f 44 00 00 eb 07 0f 00 2d 57 d4 65 00 fb f4 <c3> cc cc cc cc 41 55 41 54 55 48 89 fd 53 e8 92 e4 17 f8 e8 7d 21
RSP: 0018:ffffc9000045fdf8 EFLAGS: 00000202
RAX: 000000000036c1fd RBX: ffff88801149d700 RCX: ffffffff895dcc51
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff88802cb3af93
R10: ffffed10059675f2 R11: 0000000000000000 R12: ffffed1002293ae0
R13: 0000000000000001 R14: ffffffff8db640d0 R15: 0000000000000000
 default_idle_call+0x87/0xd0 kernel/sched/idle.c:109
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x401/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x265/0x340 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 c4 8c 63 f8       	callq  0xf8638ccc
   8:	e9 55 ff ff ff       	jmpq   0xffffff62
   d:	4c 89 e7             	mov    %r12,%rdi
  10:	e8 b7 8c 63 f8       	callq  0xf8638ccc
  15:	eb 96                	jmp    0xffffffad
  17:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1c:	eb 07                	jmp    0x25
  1e:	0f 00 2d 57 d4 65 00 	verw   0x65d457(%rip)        # 0x65d47c
  25:	fb                   	sti
  26:	f4                   	hlt
* 27:	c3                   	retq <-- trapping instruction
  28:	cc                   	int3
  29:	cc                   	int3
  2a:	cc                   	int3
  2b:	cc                   	int3
  2c:	41 55                	push   %r13
  2e:	41 54                	push   %r12
  30:	55                   	push   %rbp
  31:	48 89 fd             	mov    %rdi,%rbp
  34:	53                   	push   %rbx
  35:	e8 92 e4 17 f8       	callq  0xf817e4cc
  3a:	e8                   	.byte 0xe8
  3b:	7d 21                	jge    0x5e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
