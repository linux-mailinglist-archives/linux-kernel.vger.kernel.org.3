Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1010C482F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiACJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:11:22 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:40957 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiACJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:11:21 -0500
Received: by mail-il1-f199.google.com with SMTP id n3-20020a056e021ba300b002b53500c8feso13627860ili.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 01:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0Q7MEdqGlkJQSqThkcMjIxnhyiVISB0/YW9EG3pgrlc=;
        b=7i4jNurbPNbbXWoj7P5R05dPYlTu34OBkxYbJnZsFDFtC1e0ww8aaK3JEFe9Z6hI2S
         g4kplkqoA+jUa5npJrMWWDJEfdPUhqX0cCI42k3qfDDho74XpuEbaK1b7xdpMACyR7wE
         JrPKyGHVPA3jPeqVSLyo1hTJ8CY9HlSfyrmO3iIepYrIjfoZAEQJxACRd7Y9YqPcPbvh
         rxkfsF7rmA3BcjYTMciQghxNQQtgdj/MLZN9oHLeNzaqnUh0eSDA3bsFNdLYaiQcBA4u
         9KMklYw9Zp1AUAzY/7ly/eklpvs8Rx0rxukZDgtdymzugcHD2SMFTnE6B9Y9t06ZGw1u
         ocaw==
X-Gm-Message-State: AOAM530dyAkQEku2sEh9t8Qq9QSz4+SWrmgezxkas8O16UW+GKeuZHSm
        tdhouCAtQ+c1xULEd2YBbF6oZjDgVdv5yaVW4udPcA3vjpeh
X-Google-Smtp-Source: ABdhPJwjYb3MYB1kbkmi/hfXfFmb4QqOeQf15j/V+2bPB4aQkZ9kVYWxkPyQSk9rhlU9Mp6JJoS89qistrYpNGmrLGsMktGDzgk/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:: with SMTP id i8mr6894728ilm.146.1641201081187;
 Mon, 03 Jan 2022 01:11:21 -0800 (PST)
Date:   Mon, 03 Jan 2022 01:11:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007305e805d4a9e7f9@google.com>
Subject: [syzbot] INFO: task hung in blkdev_fallocate
From:   syzbot <syzbot+39b75c02b8be0a061bfc@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eec4df26e24e Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147d1c73b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13531cc7b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17da8659b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39b75c02b8be0a061bfc@syzkaller.appspotmail.com

INFO: task syz-executor243:3652 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor243 state:D stack:28144 pid: 3652 ppid:  3649 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4900 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x634/0x1110 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blkdev_fallocate+0x1e2/0x420 block/fops.c:625
 vfs_fallocate+0x48d/0xe10 fs/open.c:307
 ksys_fallocate fs/open.c:330 [inline]
 __do_sys_fallocate fs/open.c:338 [inline]
 __se_sys_fallocate fs/open.c:336 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:336
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f74a1108e39
RSP: 002b:00007fff04673d58 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f74a1108e39
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 7fffffffffffffff R11: 0000000000000246 R12: 00007f74a10cc610
R13: 0000000000000000 R14: 00007fff04673d80 R15: 00007fff04673d70
 </TASK>
INFO: task syz-executor243:3653 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor243 state:D stack:28144 pid: 3653 ppid:  3650 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4900 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x634/0x1110 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blkdev_fallocate+0x1e2/0x420 block/fops.c:625
 vfs_fallocate+0x48d/0xe10 fs/open.c:307
 ksys_fallocate fs/open.c:330 [inline]
 __do_sys_fallocate fs/open.c:338 [inline]
 __se_sys_fallocate fs/open.c:336 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:336
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f74a1108e39
RSP: 002b:00007fff04673d58 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f74a1108e39
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 7fffffffffffffff R11: 0000000000000246 R12: 00007f74a10cc610
R13: 0000000000000000 R14: 00007fff04673d80 R15: 00007fff04673d70
 </TASK>
INFO: task syz-executor243:3658 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor243 state:D stack:27120 pid: 3658 ppid:  3644 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4900 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x634/0x1110 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 filemap_invalidate_lock include/linux/fs.h:828 [inline]
 blkdev_fallocate+0x1e2/0x420 block/fops.c:625
 vfs_fallocate+0x48d/0xe10 fs/open.c:307
 ksys_fallocate fs/open.c:330 [inline]
 __do_sys_fallocate fs/open.c:338 [inline]
 __se_sys_fallocate fs/open.c:336 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:336
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f74a1108e39
RSP: 002b:00007fff04673d58 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f74a1108e39
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 7fffffffffffffff R11: 0000000000000246 R12: 0000000000074dbc
R13: 00007fff04673d6c R14: 00007fff04673d80 R15: 00007fff04673d70
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb83da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
2 locks held by getty/3296:
 #0: ffff8880221a5098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
1 lock held by syz-executor243/3652:
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1e2/0x420 block/fops.c:625
1 lock held by syz-executor243/3653:
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1e2/0x420 block/fops.c:625
1 lock held by syz-executor243/3655:
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1e2/0x420 block/fops.c:625
1 lock held by syz-executor243/3658:
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1e2/0x420 block/fops.c:625
1 lock held by syz-executor243/3665:
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1e2/0x420 block/fops.c:625
1 lock held by syz-executor243/3667:
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:828 [inline]
 #0: ffff888017262108 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_fallocate+0x1e2/0x420 block/fops.c:625

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 26 Comm: khungtaskd Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2961 Comm: klogd Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xe3d/0x5470 kernel/locking/lockdep.c:5054
Code: 44 8b 3d 9e 32 35 0c 45 85 ff 0f 84 09 76 a4 07 45 31 ff 48 b8 00 00 00 00 00 fc ff df 48 8b 5c 24 30 48 c7 04 03 00 00 00 00 <48> 8b 84 24 e8 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 ca 2d 00
RSP: 0018:ffffc9000ba27470 EFLAGS: 00000097
RAX: dffffc0000000000 RBX: 1ffff92001744ea0 RCX: 000000000000aabe
RDX: 1ffff1100fb684eb RSI: 0000000000000001 RDI: ffffffff8f317558
RBP: d045cae75a1e1578 R08: 0000000000000000 R09: ffffffff8ff76a07
R10: fffffbfff1feed40 R11: 0000000000000001 R12: ffff88807db42788
R13: ffff88807db41d00 R14: ffffffff8d918b48 R15: 0000000000000001
FS:  00007faa0c677800(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f74a114c01d CR3: 000000002333e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 __debug_check_no_obj_freed lib/debugobjects.c:980 [inline]
 debug_check_no_obj_freed+0xc7/0x420 lib/debugobjects.c:1023
 free_pages_prepare mm/page_alloc.c:1343 [inline]
 free_pcp_prepare+0x2ae/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 __unfreeze_partials+0x343/0x360 mm/slub.c:2527
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3234 [inline]
 __kmalloc_node_track_caller+0x238/0x360 mm/slub.c:4956
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1127 [inline]
 alloc_skb_with_frags+0x93/0x620 net/core/skbuff.c:6078
 sock_alloc_send_pskb+0x783/0x910 net/core/sock.c:2575
 unix_dgram_sendmsg+0x3ec/0x1950 net/unix/af_unix.c:1811
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 __sys_sendto+0x21c/0x320 net/socket.c:2036
 __do_sys_sendto net/socket.c:2048 [inline]
 __se_sys_sendto net/socket.c:2044 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2044
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7faa0c8130ac
Code: 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
RSP: 002b:00007ffde81df788 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faa0c8130ac
RDX: 000000000000003a RSI: 0000561c075a8bf0 RDI: 0000000000000003
RBP: 0000561c075a4910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000014
R13: 0000000000000001 R14: 00007faa0c98e77d R15: 00007ffde81df898
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.854 msecs
----------------
Code disassembly (best guess):
   0:	44 8b 3d 9e 32 35 0c 	mov    0xc35329e(%rip),%r15d        # 0xc3532a5
   7:	45 85 ff             	test   %r15d,%r15d
   a:	0f 84 09 76 a4 07    	je     0x7a47619
  10:	45 31 ff             	xor    %r15d,%r15d
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
  22:	48 c7 04 03 00 00 00 	movq   $0x0,(%rbx,%rax,1)
  29:	00
* 2a:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax <-- trapping instruction
  31:	00
  32:	65 48 2b 04 25 28 00 	sub    %gs:0x28,%rax
  39:	00 00
  3b:	0f                   	.byte 0xf
  3c:	85 ca                	test   %ecx,%edx
  3e:	2d                   	.byte 0x2d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
