Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B554B441D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiBNIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:30:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiBNIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:30:26 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77C25C69
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:30:18 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id y124-20020a6bc882000000b0060fbfe14d03so10099581iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=w/eG857dxxrFl69My9yhXVfKenfM7gm0O1wilECasmA=;
        b=u4X2vA152ReFDLuR6kzyCojAHE8HVKDY3qy4KOMpl6ju5MsPb5zxp6DVEy8sM8A6Na
         VBE62/J1sNL+Wt+TgPMiTnkzwYlkLrQSwotjvjV0SXtQ8MSvGo0cn/VYlvZz+PZFARPc
         OqbYmCGKQfYGDGVE5oSzj5nXpvmJAygQBuAcuwA1U0vwsbUGh/welY2fZNMx0rzSG/5H
         MelhtyvATyieSi+FHYcX/GOAgQijj+rDlFEJ5s5KUOzBQ8xX2ADqfuNvhRi2Zr+gcnLh
         0uNoVZEF+jv5qbaJOQpg9MDGDRnsuF1XTLAkIYxxSCFIqOVye6bKNBlTHWKMDGWn4E+7
         nhnw==
X-Gm-Message-State: AOAM533Q2bW0EohiNC1EKXkOle8MAedF4mUzgG4AYTEtBeZBf0jp3NFD
        YIsYm/tFb3e+CE+ixuKK7vAk9B1JLZFU2BdiNgCHSKUH59OG
X-Google-Smtp-Source: ABdhPJzf4GKJ3o9IpzDACkaj1LaTjSQMn9mqCNHxvOASkNVIqtOuSOqfHUtird12q0BD+X6dJmhqxk74Bb3SitgCkC8O9bKDG6w0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1305:: with SMTP id r5mr7316383jad.154.1644827417812;
 Mon, 14 Feb 2022 00:30:17 -0800 (PST)
Date:   Mon, 14 Feb 2022 00:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4a73905d7f63916@google.com>
Subject: [syzbot] inconsistent lock state in sync_timeline_debug_remove
From:   syzbot <syzbot+7dcd254b8987a29f6450@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        gustavo@padovan.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f4bc5bbb5fef Merge tag 'nfsd-5.17-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fc74c2700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c73c74700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1440451c700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a40d84700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a40d84700000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a40d84700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7dcd254b8987a29f6450@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
5.17.0-rc3-syzkaller-00043-gf4bc5bbb5fef #0 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
syz-executor198/3596 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffffffff8c7096d8 (sync_timeline_list_lock){?.+.}-{2:2}, at: sync_timeline_debug_remove+0x25/0x190 drivers/dma-buf/sync_debug.c:31
{HARDIRQ-ON-W} state was registered at:
  __trace_hardirqs_on_caller kernel/locking/lockdep.c:4224 [inline]
  lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4292 [inline]
  lockdep_hardirqs_on_prepare+0x135/0x400 kernel/locking/lockdep.c:4244
  trace_hardirqs_on+0x5b/0x1c0 kernel/trace/trace_preemptirq.c:49
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
  _raw_spin_unlock_irq+0x1f/0x40 kernel/locking/spinlock.c:202
  spin_unlock_irq include/linux/spinlock.h:399 [inline]
  sync_print_obj drivers/dma-buf/sync_debug.c:118 [inline]
  sync_info_debugfs_show+0xeb/0x200 drivers/dma-buf/sync_debug.c:153
  seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
  seq_read+0x3e8/0x5c0 fs/seq_file.c:162
  vfs_read+0x1b5/0x600 fs/read_write.c:479
  ksys_read+0x12d/0x250 fs/read_write.c:619
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
irq event stamp: 5708
hardirqs last  enabled at (5707): [<ffffffff894db1ef>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (5707): [<ffffffff894db1ef>] _raw_spin_unlock_irq+0x1f/0x40 kernel/locking/spinlock.c:202
hardirqs last disabled at (5708): [<ffffffff894a992b>] sysvec_irq_work+0xb/0xc0 arch/x86/kernel/irq_work.c:17
softirqs last  enabled at (5570): [<ffffffff84da6fd6>] spin_unlock_bh include/linux/spinlock.h:394 [inline]
softirqs last  enabled at (5570): [<ffffffff84da6fd6>] __tun_set_ebpf+0xf6/0x1c0 drivers/net/tun.c:2245
softirqs last disabled at (5568): [<ffffffff84da6f83>] spin_lock_bh include/linux/spinlock.h:354 [inline]
softirqs last disabled at (5568): [<ffffffff84da6f83>] __tun_set_ebpf+0xa3/0x1c0 drivers/net/tun.c:2241

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sync_timeline_list_lock);
  <Interrupt>
    lock(sync_timeline_list_lock);

 *** DEADLOCK ***

no locks held by syz-executor198/3596.

stack backtrace:
CPU: 0 PID: 3596 Comm: syz-executor198 Not tainted 5.17.0-rc3-syzkaller-00043-gf4bc5bbb5fef #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:203 [inline]
 valid_state kernel/locking/lockdep.c:3945 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4148 [inline]
 mark_lock.cold+0x61/0x8e kernel/locking/lockdep.c:4605
 mark_usage kernel/locking/lockdep.c:4497 [inline]
 __lock_acquire+0x1499/0x5470 kernel/locking/lockdep.c:4981
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 sync_timeline_debug_remove+0x25/0x190 drivers/dma-buf/sync_debug.c:31
 sync_timeline_free drivers/dma-buf/sw_sync.c:104 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sync_timeline_put drivers/dma-buf/sw_sync.c:116 [inline]
 timeline_fence_release+0x263/0x340 drivers/dma-buf/sw_sync.c:144
 dma_fence_release+0x2ee/0x590 drivers/dma-buf/dma-fence.c:549
 kref_put include/linux/kref.h:65 [inline]
 dma_fence_put include/linux/dma-fence.h:276 [inline]
 dma_fence_array_release+0x1e4/0x2b0 drivers/dma-buf/dma-fence-array.c:120
 dma_fence_release+0x2ee/0x590 drivers/dma-buf/dma-fence.c:549
 kref_put include/linux/kref.h:65 [inline]
 dma_fence_put include/linux/dma-fence.h:276 [inline]
 irq_dma_fence_array_work+0xa5/0xd0 drivers/dma-buf/dma-fence-array.c:52
 irq_work_single+0x120/0x270 kernel/irq_work.c:211
 irq_work_run_list+0x91/0xc0 kernel/irq_work.c:242
 irq_work_run+0x54/0xd0 kernel/irq_work.c:251
 __sysvec_irq_work+0x95/0x3d0 arch/x86/kernel/irq_work.c:22
 sysvec_irq_work+0x8e/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x12/0x20 arch/x86/include/asm/idtentry.h:664
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
Code: 0f 1f 44 00 00 55 48 8b 74 24 08 48 89 fd 48 83 c7 18 e8 4e a1 0f f8 48 89 ef e8 06 17 10 f8 e8 b1 0b 31 f8 fb bf 01 00 00 00 <e8> 46 ca 02 f8 65 8b 05 bf bd b4 76 85 c0 74 02 5d c3 e8 2b 93 b2
RSP: 0018:ffffc90001f5fe18 EFLAGS: 00000206
RAX: 000000000000164b RBX: 00000000ffffffff RCX: 1ffffffff1b27381
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff8880153ff050 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817ebdd8 R11: 0000000000000000 R12: ffff8880153ff000
R13: dffffc0000000000 R14: ffff8880153ff000 R15: ffff8880153ff050
 spin_unlock_irq include/linux/spinlock.h:399 [inline]
 sw_sync_debugfs_release+0x160/0x240 drivers/dma-buf/sw_sync.c:321
 __fput+0x286/0x9f0 fs/file_table.c:313
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbe1817b7e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbe17901208 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fbe181fd4f8 RCX: 00007fbe1817b7e9
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000003
RBP: 00007fbe181fd4f0 R08: 00007fbe17901700 R09: 0000000000000000
R10: 00007fbe17901700 R11: 0000000000000246 R12: 00007fbe181fd4fc
R1
----------------
Code disassembly (best guess):
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	55                   	push   %rbp
   6:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
   b:	48 89 fd             	mov    %rdi,%rbp
   e:	48 83 c7 18          	add    $0x18,%rdi
  12:	e8 4e a1 0f f8       	callq  0xf80fa165
  17:	48 89 ef             	mov    %rbp,%rdi
  1a:	e8 06 17 10 f8       	callq  0xf8101725
  1f:	e8 b1 0b 31 f8       	callq  0xf8310bd5
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 46 ca 02 f8       	callq  0xf802ca75 <-- trapping instruction
  2f:	65 8b 05 bf bd b4 76 	mov    %gs:0x76b4bdbf(%rip),%eax        # 0x76b4bdf5
  36:	85 c0                	test   %eax,%eax
  38:	74 02                	je     0x3c
  3a:	5d                   	pop    %rbp
  3b:	c3                   	retq
  3c:	e8                   	.byte 0xe8
  3d:	2b                   	.byte 0x2b
  3e:	93                   	xchg   %eax,%ebx
  3f:	b2                   	.byte 0xb2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
