Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7D4889DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiAIOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiAIOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:24:40 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6141CC06173F;
        Sun,  9 Jan 2022 06:24:40 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id b7so13971419edj.9;
        Sun, 09 Jan 2022 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=K+p991uqT27+YFoDpAf480PlxCkVI4whlwNBI2qXQK4=;
        b=S/ZVCruSCfc9pNzLHG8FR7d+4outtx+88FF/OQKE9zdPwfd6M6Kr9kCFGaIEQNg2IG
         Y/O1fJxEM/3gbJwu3HDvIl0Yr9e3Z7yE6vc+0TELykP9usWVLbxgdvnRbMC4wg3HQkUx
         wL7nkP0XBCWTJtkdytGBQYTHLGsnIsIRaVokOo8rVkeHKdDjf7HUGZaG9zl/BbjR3xJ+
         IbpTI3iG7g2bJqUTtW4iHaOHQHV40G7oo07yGGR5Fl6b9KKiG1PnoFyBxWljUJtTnaxM
         y8pn5hFHadkMOp9bI3VMC7vV5fTj51xgIEUUoqMSniug/u0hFMNgTjsVXNVUXvykcRid
         nPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=K+p991uqT27+YFoDpAf480PlxCkVI4whlwNBI2qXQK4=;
        b=nYlw8udgBvLLUHdWEBjaHcf+iJH/iqFuRP38GUXoy+MGhtHK8T7CIp8whKZxqIqwbT
         QLKOoJxM/qvJCYghXHl8r0DiwKzOvx3X6nDtmxbHlWeYKrasoLVxwhWp4xI/0uwF9IBJ
         Eqry+u9P+unlCx0S2PdX+IcFsE116YwAreSJC/6x1oxhCIgw5KYP14CM/BH/GQ3aKAno
         GUPOcy7AmjvHYQuKYNnY2+bQsiUjaYJlcioxVpp+WQN2DQTljU0aiyJYtQoSXRDoqt+9
         BFAtFMB4oZ1iloUNVwM7phulEFGF29lNeulj8Ni224QecMT95FXgXhC1esnjyH3Pcdl+
         CVpg==
X-Gm-Message-State: AOAM530LOQwxazZK6kMhnTX10uYgMpRKyR4KkBpiFH4c1kOExDj9ExR6
        RrmoHm9V0y7fSQjbQD/Id/LPVbfCphpDWOE9BWU=
X-Google-Smtp-Source: ABdhPJwRMBmsz9Tkc7/0ZXSY2XqC6Lmt+CDRbDSdC6QaeZUImYjOaA2HaRMErAvWWwt+7zMbph3FXp06I8cZxp728uE=
X-Received: by 2002:a05:6402:120e:: with SMTP id c14mr15200292edw.40.1641738278591;
 Sun, 09 Jan 2022 06:24:38 -0800 (PST)
MIME-Version: 1.0
From:   "Sabri N. Ferreiro" <snferreiro1@gmail.com>
Date:   Sun, 9 Jan 2022 22:24:27 +0800
Message-ID: <CAKG+3NRn-epVKQ9H53178yBAE8y+63scJhYXc_ghvUfZaH_jqg@mail.gmail.com>
Subject: INFO: task hung in fd_watchdog
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When using Syzkaller to fuzz the Linux kernel, it triggers the following crash.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://pastebin.com/raw/ufQZJNFy
kernel config: https://docs.google.com/document/d/1w94kqQ4ZSIE6BW-5WIhqp4_Zh7XTPH57L5OF2Xb6O6o/view
C reproducer: https://pastebin.com/raw/ByeE6LJ3
Syzlang reproducer: https://pastebin.com/raw/gi8ZtsQC

If you fix this issue, please add the following tag to the commit:
Reported-by: Yuheng Shen mosesfonscqf75@gmail.com

INFO: task kworker/u16:3:9594 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u16:3   state:D stack:27224 pid: 9594 ppid:     2 flags:0x00004000
Workqueue: floppy floppy_work_workfn
Call Trace:
 <TASK>
 __schedule+0xcd9/0x2550
 schedule+0xd2/0x260
 schedule_timeout+0x5e5/0x890
 wait_for_completion+0x17b/0x280
 __flush_work+0x56c/0xb10
 __cancel_work_timer+0x370/0x4b0
 fd_watchdog.cold+0x3b/0x8f
 setup_rw_floppy+0x6f1/0x9f0
 floppy_ready+0x425/0x19b0
 recal_interrupt+0xd9/0x610
 process_one_work+0x9df/0x16a0
 worker_thread+0x90/0xe20
 kthread+0x405/0x4f0
 ret_from_fork+0x1f/0x30
 </TASK>
INFO: task syz-executor.0:21342 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27920 pid:21342 ppid:  6935 flags:0x00000004
Call Trace:
 <TASK>
 __schedule+0xcd9/0x2550
 schedule+0xd2/0x260
 schedule_preempt_disabled+0xf/0x20
 __mutex_lock+0xc48/0x1610
 floppy_release+0x43/0x1c0
 blkdev_put_whole+0xd2/0x110
 blkdev_put+0x296/0x710
 blkdev_close+0x6a/0x80
 __fput+0x286/0x9f0
 task_work_run+0xe0/0x1a0
 exit_to_user_mode_prepare+0x28d/0x2a0
 syscall_exit_to_user_mode+0x19/0x60
 do_syscall_64+0x42/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f196095b14b
RSP: 002b:00007ffd4516c600 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f196095b14b
RDX: 00007f1960acf5f8 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 00007f1960acc96c R08: 0000000000000000 R09: 00007f1960acf600
R10: 00007ffd4516c730 R11: 0000000000000293 R12: 000000000005c797
R13: 00007ffd4516c740 R14: 00007f1960acaf6c R15: 000000000005c7c9
 </TASK>
INFO: task syz-executor.7:21344 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:27920 pid:21344 ppid:  6934 flags:0x00000004
Call Trace:
 <TASK>
 __schedule+0xcd9/0x2550
 schedule+0xd2/0x260
 schedule_preempt_disabled+0xf/0x20
 __mutex_lock+0xc48/0x1610
 blkdev_put+0xa6/0x710
 blkdev_close+0x6a/0x80
 __fput+0x286/0x9f0
 task_work_run+0xe0/0x1a0
 exit_to_user_mode_prepare+0x28d/0x2a0
 syscall_exit_to_user_mode+0x19/0x60
 do_syscall_64+0x42/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f740523814b
RSP: 002b:00007ffcaa72e410 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f740523814b
RDX: 0000001b2c820000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f74053a9960 R08: 0000000000000000 R09: 00007ffcaa780090
R10: 000000000000edfc R11: 0000000000000293 R12: 000000000005ca89
R13: 00007ffcaa72e550 R14: 00007f74053a810c R15: 000000000005c7d7
 </TASK>
INFO: task syz-executor.7:21347 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.7  state:D stack:28384 pid:21347 ppid:  6934 flags:0x00004004
Call Trace:
 <TASK>
 __schedule+0xcd9/0x2550
 schedule+0xd2/0x260
 __cancel_work_timer+0x44a/0x4b0
 wait_til_done+0x340/0x370
 fd_locked_ioctl+0x19ec/0x23d0
 fd_ioctl+0x35/0x50
 blkdev_ioctl+0x37a/0x800
 __x64_sys_ioctl+0x193/0x200
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f740528889d
RSP: 002b:00007f7403bf9c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f74053a7f60 RCX: 00007f740528889d
RDX: 0000000020000100 RSI: 0000000000000258 RDI: 0000000000000005
RBP: 00007f74052f500d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcaa72e3af R14: 00007f74053a7f60 R15: 00007f7403bf9dc0
 </TASK>
INFO: task syz-executor.2:21480 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27920 pid:21480 ppid:  6932 flags:0x00000004
Call Trace:
 <TASK>
 __schedule+0xcd9/0x2550
 schedule+0xd2/0x260
 schedule_preempt_disabled+0xf/0x20
 __mutex_lock+0xc48/0x1610
 blkdev_get_by_dev+0x23b/0xa80
 blkdev_open+0x154/0x2e0
 do_dentry_open+0x4b9/0x1240
 path_openat+0x1c3c/0x26c0
 do_filp_open+0x1c1/0x290
 do_sys_openat2+0x61b/0x9a0
 do_sys_open+0xc3/0x140
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3dcea8f434
RSP: 002b:00007f3dcd42f750 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f3dcea8f434
RDX: 0000000000000c00 RSI: 00007f3dcd42f7f0 RDI: 00000000ffffff9c
RBP: 00007f3dcd42f7f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000c00
R13: 00007ffe9ca1c26f R14: 00007f3dcebff030 R15: 00007f3dcd42fdc0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/59:
 #0: ffffffff8bb80ee0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260
1 lock held by in:imklog/6782:
 #0: ffff88801c992670 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100
2 locks held by kworker/u16:3/9594:
 #0: ffff88810505b138 ((wq_completion)floppy){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16a0
 #1: ffffc900180b7dc8 (floppy_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16a0
2 locks held by syz-executor.0/21342:
 #0: ffff88801a762918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xa6/0x710
 #1: ffffffff8c6a4c88 (floppy_mutex){+.+.}-{3:3}, at: floppy_release+0x43/0x1c0
1 lock held by syz-executor.7/21344:
 #0: ffff88801a762918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xa6/0x710
1 lock held by syz-executor.7/21347:
 #0: ffffffff8c6a4c88 (floppy_mutex){+.+.}-{3:3}, at: fd_ioctl+0x25/0x50
1 lock held by syz-executor.2/21480:
 #0: ffff88801a762918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x23b/0xa80

=============================================

NMI backtrace for cpu 4
CPU: 4 PID: 59 Comm: khungtaskd Not tainted 5.16.0-rc8+ #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 nmi_cpu_backtrace.cold+0x47/0x144
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0
 watchdog+0xcc8/0x1010
 kthread+0x405/0x4f0
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 4 to CPUs 0-3,5-7:
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
NMI backtrace for cpu 5 skipped: idling at default_idle+0xb/0x10
NMI backtrace for cpu 3
CPU: 3 PID: 7496 Comm: kworker/u16:2 Not tainted 5.16.0-rc8+ #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__this_cpu_preempt_check+0xd/0x20
Code: 00 00 48 c7 c6 e0 1f 05 8a 48 c7 c7 20 20 05 8a e9 78 fe ff ff
0f 1f 84 00 00 00 00 00 55 48 89 fd 0f 1f 44 00 00 48 89 ee 5d <48> c7
c7 60 20 05 8a e9 57 fe ff ff cc cc cc cc cc cc cc 0f 1f 44
RSP: 0018:ffffc900095efbe8 EFLAGS: 00000086
RAX: 0000000000000001 RBX: 1ffff920012bdf80 RCX: 0000000000000001
RDX: 1ffff11020dab873 RSI: ffffffff89ac11c0 RDI: ffffffff89ac11c0
RBP: 0000000000000000 R08: 1ffff11020dab87d R09: fffffbfff1fee329
R10: ffffffff8ff71947 R11: fffffbfff1fee328 R12: 0000000000000002
R13: ffffffff8bb80ee0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888135c80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000235090 CR3: 0000000019740000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 lock_acquire+0x1bb/0x520
 batadv_nc_worker+0x114/0x770
 process_one_work+0x9df/0x16a0
 worker_thread+0x90/0xe20
 kthread+0x405/0x4f0
 ret_from_fork+0x1f/0x30
 </TASK>
NMI backtrace for cpu 7 skipped: idling at default_idle+0xb/0x10
NMI backtrace for cpu 1 skipped: idling at default_idle+0xb/0x10
NMI backtrace for cpu 6 skipped: idling at default_idle+0xb/0x10
----------------
Code disassembly (best guess):
   0: 00 00                add    %al,(%rax)
   2: 48 c7 c6 e0 1f 05 8a mov    $0xffffffff8a051fe0,%rsi
   9: 48 c7 c7 20 20 05 8a mov    $0xffffffff8a052020,%rdi
  10: e9 78 fe ff ff        jmpq   0xfffffe8d
  15: 0f 1f 84 00 00 00 00 nopl   0x0(%rax,%rax,1)
  1c: 00
  1d: 55                    push   %rbp
  1e: 48 89 fd              mov    %rdi,%rbp
  21: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  26: 48 89 ee              mov    %rbp,%rsi
  29: 5d                    pop    %rbp
* 2a: 48 c7 c7 60 20 05 8a mov    $0xffffffff8a052060,%rdi <--
trapping instruction
  31: e9 57 fe ff ff        jmpq   0xfffffe8d
  36: cc                    int3
  37: cc                    int3
  38: cc                    int3
  39: cc                    int3
  3a: cc                    int3
  3b: cc                    int3
  3c: cc                    int3
  3d: 0f                    .byte 0xf
  3e: 1f                    (bad)
  3f: 44                    rex.R
