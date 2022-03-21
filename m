Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252E4E2D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350633AbiCUQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349034AbiCUQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:07:50 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C26565177
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:06:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z15-20020a92d6cf000000b002c811796c23so2145907ilp.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fDjRP2JQcEzLDeioLLRFp9lQSMrewPMiB1BiU2Impu0=;
        b=vDfH8y50GVpbPJRbdcSjrjvhrbUD9Xp5r9RpD+UudzIzGhRLPNNseIW++et85eGaKX
         1e5tlpQU8DH9NPt3JZZDF3JV+Tenz6sH9YYULWEMv6iK3DDkq/ZCfV1hn8Qs0uzF4nyb
         RqY3xIHpUJW80K/BeSk0VEPH5fUx5v/uehsPBNHRGNIYKV31Choy/9UKiMGSOnKLYgiz
         WptAE6eckhDtfylgTq0rK2UJRn46eQl0N4sFf2pUnkVPo2cnQRtsRXqJxkjbzfD7Vst1
         t4w2GITp3gISkR9FXS0qPbWRjy2drgl4ujqjINSsyD7XKFYYQ8eKhf+dtSuAZChZPPMS
         kWIg==
X-Gm-Message-State: AOAM532vt0ecpooS7ZSWB2XGDKicU2ztIohGNI3j67R7gTDirs40xII1
        SupWZaO9iLKkn/ysZ7BjOnpPqAV12KM+h52W9UZucxN4UTrp
X-Google-Smtp-Source: ABdhPJy/U9Q84+ldbJJAWRqTcdkejSYo9is9zrjm0+4QQd5ALc1reFuRQn8+8mEiuyQxVDG1bMIvg+sAV8RQpMW1MwKhOFbv2A9H
MIME-Version: 1.0
X-Received: by 2002:a5e:c012:0:b0:649:ab74:a3c6 with SMTP id
 u18-20020a5ec012000000b00649ab74a3c6mr2345688iol.182.1647878783824; Mon, 21
 Mar 2022 09:06:23 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008af91005dabcad4f@google.com>
Subject: [syzbot] INFO: task hung in nbd_add_socket (2)
From:   syzbot <syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com>
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

HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b09f89700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b3f519700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com

INFO: task syz-executor.3:3748 blocked for more than 143 seconds.
      Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28456 pid: 3748 ppid:  3641 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4995 [inline]
 __schedule+0xa94/0x4910 kernel/sched/core.c:6304
 schedule+0xd2/0x260 kernel/sched/core.c:6377
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 nbd_add_socket+0x166/0x810 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6ce3d6b049
RSP: 002b:00007f6ce34e0168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6ce3e7df60 RCX: 00007f6ce3d6b049
RDX: 0000000000000004 RSI: 000000000000ab00 RDI: 0000000000000003
RBP: 00007f6ce3dc508d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff39c20b5f R14: 00007f6ce34e0300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.0:3762 blocked for more than 143 seconds.
      Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28456 pid: 3762 ppid:  3643 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4995 [inline]
 __schedule+0xa94/0x4910 kernel/sched/core.c:6304
 schedule+0xd2/0x260 kernel/sched/core.c:6377
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 nbd_add_socket+0x166/0x810 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f76c6cb0049
RSP: 002b:00007f76c6425168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f76c6dc2f60 RCX: 00007f76c6cb0049
RDX: 0000000000000004 RSI: 000000000000ab00 RDI: 0000000000000003
RBP: 00007f76c6d0a08d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc1647f5cf R14: 00007f76c6425300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.1:3786 blocked for more than 143 seconds.
      Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:28456 pid: 3786 ppid:  3644 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4995 [inline]
 __schedule+0xa94/0x4910 kernel/sched/core.c:6304
 schedule+0xd2/0x260 kernel/sched/core.c:6377
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 nbd_add_socket+0x166/0x810 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f771e10a049
RSP: 002b:00007f771d87f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f771e21cf60 RCX: 00007f771e10a049
RDX: 0000000000000004 RSI: 000000000000ab00 RDI: 0000000000000003
RBP: 00007f771e16408d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd29c3466f R14: 00007f771d87f300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:3796 blocked for more than 144 seconds.
      Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28456 pid: 3796 ppid:  3646 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4995 [inline]
 __schedule+0xa94/0x4910 kernel/sched/core.c:6304
 schedule+0xd2/0x260 kernel/sched/core.c:6377
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 nbd_add_socket+0x166/0x810 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5cb8d4e049
RSP: 002b:00007f5cb84c3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5cb8e60f60 RCX: 00007f5cb8d4e049
RDX: 0000000000000004 RSI: 000000000000ab00 RDI: 0000000000000003
RBP: 00007f5cb8da808d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc915ce70f R14: 00007f5cb84c3300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb84ca0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6460
2 locks held by getty/3274:
 #0: ffff88814ac35098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002b632e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2075
1 lock held by syz-executor.3/3748:
 #0: ffff88801ab4b198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504
1 lock held by syz-executor.0/3762:
 #0: ffff88801aa43998 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504
1 lock held by syz-executor.1/3786:
 #0: ffff88801ab90198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504
1 lock held by syz-executor.2/3796:
 #0: ffff88801ab97998 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3678 Comm: kworker/u4:2 Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy10 ieee80211_iface_work
RIP: 0010:stackdepot_memcmp lib/stackdepot.c:217 [inline]
RIP: 0010:find_stack lib/stackdepot.c:233 [inline]
RIP: 0010:__stack_depot_save+0x145/0x500 lib/stackdepot.c:373
Code: 29 48 85 ed 75 12 e9 92 00 00 00 48 8b 6d 00 48 85 ed 0f 84 85 00 00 00 39 5d 08 75 ee 44 3b 7d 0c 75 e8 31 c0 48 8b 74 c5 18 <49> 39 34 c6 75 db 48 83 c0 01 48 39 c2 75 ec 48 8b 7c 24 28 48 85
RSP: 0018:ffffc90002adf418 EFLAGS: 00000202
RAX: 0000000000000007 RBX: 00000000fcc93932 RCX: ffff88823b89c990
RDX: 000000000000000b RSI: ffffffff814cca4c RDI: 00000000231130b5
RBP: ffff88806d495930 R08: 00000000faa8e072 R09: 0000000000000001
R10: fffff5200055be77 R11: 0000000000088078 R12: 0000000000000001
R13: 0000000000000b20 R14: ffffc90002adf488 R15: 000000000000000b
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd0058e108 CR3: 000000007f38a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 kasan_save_stack+0x2e/0x40 mm/kasan/common.c:39
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 cfg80211_inform_single_bss_frame_data+0x34b/0xf40 net/wireless/scan.c:2436
 cfg80211_inform_bss_frame_data+0xa7/0xb50 net/wireless/scan.c:2497
 ieee80211_bss_info_update+0x35b/0xb00 net/mac80211/scan.c:190
 ieee80211_rx_bss_info net/mac80211/ibss.c:1119 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1610 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x19cf/0x3150 net/mac80211/ibss.c:1639
 ieee80211_iface_process_skb net/mac80211/iface.c:1527 [inline]
 ieee80211_iface_work+0xa69/0xd00 net/mac80211/iface.c:1581
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	29 48 85             	sub    %ecx,-0x7b(%rax)
   3:	ed                   	in     (%dx),%eax
   4:	75 12                	jne    0x18
   6:	e9 92 00 00 00       	jmpq   0x9d
   b:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
   f:	48 85 ed             	test   %rbp,%rbp
  12:	0f 84 85 00 00 00    	je     0x9d
  18:	39 5d 08             	cmp    %ebx,0x8(%rbp)
  1b:	75 ee                	jne    0xb
  1d:	44 3b 7d 0c          	cmp    0xc(%rbp),%r15d
  21:	75 e8                	jne    0xb
  23:	31 c0                	xor    %eax,%eax
  25:	48 8b 74 c5 18       	mov    0x18(%rbp,%rax,8),%rsi
* 2a:	49 39 34 c6          	cmp    %rsi,(%r14,%rax,8) <-- trapping instruction
  2e:	75 db                	jne    0xb
  30:	48 83 c0 01          	add    $0x1,%rax
  34:	48 39 c2             	cmp    %rax,%rdx
  37:	75 ec                	jne    0x25
  39:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
  3e:	48                   	rex.W
  3f:	85                   	.byte 0x85


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
