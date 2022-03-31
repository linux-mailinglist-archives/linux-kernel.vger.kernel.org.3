Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E665D4EE3C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbiCaWGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbiCaWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:06:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779981E1109
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:04:31 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id k5-20020a056e02134500b002c9af0334e2so648232ilr.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=demugtLfR12qlq+y0/dGkRsiord6YRRqHSkHOOP67fU=;
        b=YPsdox/xmZxDU92RZu9Vl4kPViyZTG0J42GpAFdn7s3sILcIRO7Rl3N2CpeAXoaWWt
         JxE5ssoljLdlp0Js6Cg73hGzck0zmu0vo/f2+GLSILeqCKctWRAseMLVTm7WsE4Ock1f
         nZYPBIvZIBoXh4uIHVAAwa3EaR2+10kFuG0awjurmjf7Pyh+3vsfDYGu9inoJylzUgic
         /QTREaRSUaibtxQ5Efo4bEq7pDQcfERykXwS3/vu3OYV7NHJD8tZE5hWkbC77Lpt5pD1
         UZ+h0Kpc/ToSWRtHITvqB0Z4fY55xLb4UBdLvEicF2d8FEdOHOTxjgb9k1dlo63t0Myp
         u8lw==
X-Gm-Message-State: AOAM533nGJS45S0YXjs35oWric8cQsKHp0Cmfva8sxAk+W46dLM9uw2q
        ui2EQVXQVh1HwSRG/nQ918sv5jI+Qd4ABcUZMirdzBDo7nPQ
X-Google-Smtp-Source: ABdhPJwN1XHCD54VdMC6h9kr6+zJtZghb6zkMSwL4lLfQa01qBJJmDkIhLZrE50NqIowY90Hy7pcXBIVxa9If+pY83IlX/xZkays
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10cd:b0:323:60e8:2803 with SMTP id
 q13-20020a05663810cd00b0032360e82803mr4131137jad.106.1648764270785; Thu, 31
 Mar 2022 15:04:30 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:04:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adb96505db8ad847@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in blk_mq_release
From:   syzbot <syzbot+d17750670998d5d4f5ec@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    787af64d05cd mm: page_alloc: validate buddy before check i..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109c0687700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3daed5742799b46b
dashboard link: https://syzkaller.appspot.com/bug?extid=d17750670998d5d4f5ec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d17750670998d5d4f5ec@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3123, name: udevd
preempt_count: 100, expected: 0
RCU nest depth: 2, expected: 0
4 locks held by udevd/3123:
 #0: ffffffff8c592858 (tomoyo_ss){....}-{0:0}, at: tomoyo_check_open_permission+0xe8/0x380 security/tomoyo/file.c:761
 #1: ffffffff8bd7f3e0 (rcu_read_lock){....}-{1:2}, at: prepend_path+0x0/0xea0 fs/d_path.c:368
 #2: ffffffff8bd7f3e0 (rcu_read_lock){....}-{1:2}, at: need_seqretry include/linux/seqlock.h:1158 [inline]
 #2: ffffffff8bd7f3e0 (rcu_read_lock){....}-{1:2}, at: prepend_path+0x25f/0xea0 fs/d_path.c:182
 #3: ffffffff8bd7f2c0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2524 [inline]
 #3: ffffffff8bd7f2c0 (rcu_callback){....}-{0:0}, at: rcu_core+0x73d/0x1880 kernel/rcu/tree.c:2786
 <IRQ>
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
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: 48 89 ef 5d e9 f1 90 4a 00 5d be 03 00 00 00 e9 36 66 74 02 66 0f 1f 44 00 00 48 8b be a8 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 <65> 8b 05 c9 a2 8a 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc900030ff5c8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888021002280 RSI: ffffffff81df460e RDI: 0000000000000003
RBP: ffffc900030ff6d8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81df4604 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801ab435d0 R14: dffffc0000000000 R15: dffffc0000000000
 __seqprop_spinlock_sequence include/linux/seqlock.h:277 [inline]
 read_seqbegin include/linux/seqlock.h:840 [inline]
 read_seqbegin_or_lock include/linux/seqlock.h:1144 [inline]
 prepend_path+0x3b4/0xea0 fs/d_path.c:170
 d_absolute_path+0xef/0x1a0 fs/d_path.c:233
 tomoyo_file_open security/tomoyo/tomoyo.c:311 [inline]
 tomoyo_file_open+0x9d/0xc0 security/tomoyo/tomoyo.c:306
 security_file_open+0x45/0xb0 security/security.c:1651
 do_dentry_open+0x349/0x11e0 fs/open.c:811
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
 do_sys_open fs/open.c:1229 [inline]
 __do_sys_openat fs/open.c:1245 [inline]
 __se_sys_openat fs/open.c:1240 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1240
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa17d125697
Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
RSP: 002b:00007ffeed1068f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000564cae660160 RCX: 00007fa17d125697
RDX: 0000000000080000 RSI: 00007ffeed106a28 RDI: 00000000ffffff9c
RBP: 00007ffeed106a28 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000564cae660160 R14: 0000000000000001 R15: 0000000000000000
 </TASK>

================================
WARNING: inconsistent lock state
5.17.0-syzkaller-13430-g787af64d05cd #0 Tainted: G        W        
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
udevd/3123 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff8880140d2160 (&xa->xa_lock#8){+.?.}-{2:2}, at: xa_destroy+0xb3/0x360 lib/xarray.c:2207
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
softirqs last  enabled at (20583496): [<ffffffff8146ca53>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last  enabled at (20583496): [<ffffffff8146ca53>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
softirqs last disabled at (20587107): [<ffffffff8146ca53>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (20587107): [<ffffffff8146ca53>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&xa->xa_lock#8);
  <Interrupt>

 *** DEADLOCK ***

 #0: ffffffff8c592858 (tomoyo_ss){....}-{0:0}, at: tomoyo_check_open_permission+0xe8/0x380 security/tomoyo/file.c:761
 #2: ffffffff8bd7f3e0 (rcu_read_lock){....}-{1:2}, at: need_seqretry include/linux/seqlock.h:1158 [inline]
 #2: ffffffff8bd7f3e0 (rcu_read_lock){....}-{1:2}, at: prepend_path+0x25f/0xea0 fs/d_path.c:182

stack backtrace:
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
 blk_mq_release+0x2b1/0x3e0 block/blk-mq.c:3887
 blk_release_queue+0x15b/0x320 block/blk-sysfs.c:780
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
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: 48 89 ef 5d e9 f1 90 4a 00 5d be 03 00 00 00 e9 36 66 74 02 66 0f 1f 44 00 00 48 8b be a8 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 <65> 8b 05 c9 a2 8a 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc900030ff5c8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888021002280 RSI: ffffffff81df460e RDI: 0000000000000003
RBP: ffffc900030ff6d8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81df4604 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801ab435d0 R14: dffffc0000000000 R15: dffffc0000000000
 __seqprop_spinlock_sequence include/linux/seqlock.h:277 [inline]
 read_seqbegin include/linux/seqlock.h:840 [inline]
 read_seqbegin_or_lock include/linux/seqlock.h:1144 [inline]
 prepend_path+0x3b4/0xea0 fs/d_path.c:170
 d_absolute_path+0xef/0x1a0 fs/d_path.c:233
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:311 [inline]
 tomoyo_file_open+0x9d/0xc0 security/tomoyo/tomoyo.c:306
 do_dentry_open+0x349/0x11e0 fs/open.c:811
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
RIP: 0033:0x7fa17d125697
RSP: 002b:00007ffeed1068f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:577
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff89a000e1>] softirq_handle_begin kernel/softirq.c:396 [inline]
[<ffffffff89a000e1>] __do_softirq+0xe1/0x9c2 kernel/softirq.c:534
CPU: 0 PID: 3123 Comm: udevd Tainted: G        W         5.17.0-syzkaller-13430-g787af64d05cd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9733
 blk_trace_shutdown+0x1d/0x100 kernel/trace/blktrace.c:773
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
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: 48 89 ef 5d e9 f1 90 4a 00 5d be 03 00 00 00 e9 36 66 74 02 66 0f 1f 44 00 00 48 8b be a8 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 <65> 8b 05 c9 a2 8a 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc900030ff5c8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888021002280 RSI: ffffffff81df460e RDI: 0000000000000003
RBP: ffffc900030ff6d8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81df4604 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801ab435d0 R14: dffffc0000000000 R15: dffffc0000000000
 __seqprop_spinlock_sequence include/linux/seqlock.h:277 [inline]
 read_seqbegin include/linux/seqlock.h:840 [inline]
 read_seqbegin_or_lock include/linux/seqlock.h:1144 [inline]
 prepend_path+0x3b4/0xea0 fs/d_path.c:170
 d_absolute_path+0xef/0x1a0 fs/d_path.c:233
 tomoyo_get_absolute_path security/tomoyo/realpath.c:101 [inline]
 tomoyo_realpath_from_path+0x288/0x620 security/tomoyo/realpath.c:276
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:311 [inline]
 tomoyo_file_open+0x9d/0xc0 security/tomoyo/tomoyo.c:306
 security_file_open+0x45/0xb0 security/security.c:1651
 do_dentry_open+0x349/0x11e0 fs/open.c:811
 do_open fs/namei.c:3476 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3609
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
 do_sys_open fs/open.c:1229 [inline]
 __do_sys_openat fs/open.c:1245 [inline]
 __se_sys_openat fs/open.c:1240 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1240
RIP: 0033:0x7fa17d125697
RAX: ffffffffffffffda RBX: 0000564cae660160 RCX: 00007fa17d125697
R13: 0000564cae660160 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff895f3be9>] schedule_preempt_disabled+0x19/0x20 kernel/sched/core.c:6514
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.17.0-syzkaller-13430-g787af64d05cd #0
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
Code: ff ff ff 48 89 df e8 d4 78 62 f8 e9 55 ff ff ff 4c 89 e7 e8 c7 78 62 f8 eb 96 0f 1f 44 00 00 eb 07 0f 00 2d d7 24 66 00 fb f4 <c3> cc cc cc cc 41 55 41 54 55 48 89 fd 53 e8 12 68 17 f8 e8 6d 1d
RSP: 0018:ffffffff8ba07e40 EFLAGS: 00000246
RAX: 00000000000ff8da RBX: ffffffff8babc700 RCX: ffffffff895d77c1
RDX: ffffed1005947603 RSI: 0000000000000001 RDI: ffffffff8960688f
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88802ca3b013
R10: ffffed1005947602 R11: 0000000000000000 R12: fffffbfff17578e0
R13: 0000000000000000 R14: ffffffff8db63990 R15: 0000000000000000
 default_idle_call+0x87/0xd0 kernel/sched/idle.c:109
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x401/0x590 kernel/sched/idle.c:303
 secondary_startup_64_no_verify+0xc3/0xcb
----------------
Code disassembly (best guess):
   0:	48 89 ef             	mov    %rbp,%rdi
   3:	5d                   	pop    %rbp
   4:	e9 f1 90 4a 00       	jmpq   0x4a90fa
   9:	5d                   	pop    %rbp
   a:	be 03 00 00 00       	mov    $0x3,%esi
   f:	e9 36 66 74 02       	jmpq   0x274664a
  14:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1a:	48 8b be a8 01 00 00 	mov    0x1a8(%rsi),%rdi
  21:	e8 b4 ff ff ff       	callq  0xffffffda
  26:	31 c0                	xor    %eax,%eax
  28:	c3                   	retq
  29:	90                   	nop
* 2a:	65 8b 05 c9 a2 8a 7e 	mov    %gs:0x7e8aa2c9(%rip),%eax        # 0x7e8aa2fa <-- trapping instruction
  31:	89 c1                	mov    %eax,%ecx
  33:	48 8b 34 24          	mov    (%rsp),%rsi
  37:	81 e1 00 01 00 00    	and    $0x100,%ecx
  3d:	65                   	gs
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
