Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80548410A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiADLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiADLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:40:13 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FFEC061761;
        Tue,  4 Jan 2022 03:40:12 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 139so75695019ybd.3;
        Tue, 04 Jan 2022 03:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7C3FpU/yuL9QU2o/yrunzaCR75pcnIXMC+mxGFaMH9k=;
        b=o8iExUzolcdqu0q75Y9bgohWZwmhltmhssWqwRLRwTTyLPep3IUFF/oZoCjae6Ht0o
         yoNJLK0++o2DF27IHPydLn41RAJHZ9XCgt30Ydeeo5L83ytF6h1J6RIS7qDQ3BF5PPwp
         Bg4ni1gDRcMD5wZE/pfUj8eRvB5K19/cVk0wVfRbOSRDUKt07SMN4eoAXHZZAe1COKe1
         zc/i3yvASpuEc0CdX+qtdBXauvtZsFjrboOelFoPF/ccV5Dteae3HvITfIGOQOJlEbgK
         UggCRFDGV0mFYOUrOo5zdz+4uLajkyAhk6qT7Od9k2MRRImlkN9auJWm6BdHS7XcU9h0
         bevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7C3FpU/yuL9QU2o/yrunzaCR75pcnIXMC+mxGFaMH9k=;
        b=mRS792/8Q+/0x/772Lsbb7kviZW+gsAN72PPw2oI1RInaMRIIZa15w2uyg+m4b4BzV
         PVO3mglHZWgy8QaxmmgK9niCsYLKz2xu7dgWYWgEHnejGG4NJwGY9VQ1Rf4asg+RsvZ7
         i2FyXjdEhy8+q9xI/7fHklXoOqWRpYmGQDjAnQKbjT/22xwomKEbLhwSUVh1XsWsHelE
         rBdPHrFbiwdt2UGnE0UdYSGE8/zfZgmIHOsQwsNPX3jx9atoLWsdPmCE1KWkUH+zPXw2
         lgOmGUV+BdS4dVW0qe2vrIG9iI3YTOYCXxpb7kl7yM6RNgJIeuLs5UhCgVvfvkClcvN1
         NLYA==
X-Gm-Message-State: AOAM532Y2KP3DonkWsIOUMdrK7PJ6e1detikn6UCKPOnAt9DKUvnbfkh
        ZN1AOiQ9+PnJOZwiq1A0/kfupJcvqMGme5R3hy2u+IJW61NccA==
X-Google-Smtp-Source: ABdhPJxFWwabLwek5/CKneKT/E6/G7cN2Ee9cXqjfQkB3D0otnVKE4beORmfrYU4hMS9htg5XPjU8T7yYe3/TcfhBl8=
X-Received: by 2002:a25:b293:: with SMTP id k19mr55341624ybj.627.1641296412030;
 Tue, 04 Jan 2022 03:40:12 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 19:40:01 +0800
Message-ID: <CAFkrUsjwz_aJusruvm23_HmQOrxuMtOzokjGYqPZngW87v=Lbw@mail.gmail.com>
Subject: INFO: task hung in blk_trace_ioctl
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/c57Y7mpvMj/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>

INFO: task syz-executor.4:8184 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:29536 pid: 8184 ppid: 28604 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 blk_trace_ioctl+0xab/0x270 kernel/trace/blktrace.c:725
 blkdev_common_ioctl+0x66c/0x1930 block/ioctl.c:529
 blkdev_ioctl+0x2ca/0x800 block/ioctl.c:603
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc154d6689d
RSP: 002b:00007fc153695c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc154e86100 RCX: 00007fc154d6689d
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007fc154dd300d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd12e481ef R14: 00007fc154e86100 R15: 00007fc153695dc0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
3 locks held by jbd2/sda-8/3025:
2 locks held by systemd-journal/3047:
 #0: ffff888104518f88 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888104518f88 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by systemd-udevd/3063:
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by systemd-timesyn/3122:
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by sd-resolve/3125:
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by in:imklog/6788:
 #0: ffff888019825550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888019825550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by cron/6320:
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810451a378 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by agetty/6353:
 #0: ffff88810bb0b098 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc900026232e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x8db/0x1250 drivers/tty/n_tty.c:2113
2 locks held by syz-fuzzer/6713:
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6714:
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6715:
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by syz-fuzzer/6716:
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888026de2d70 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
2 locks held by kworker/u8:4/9919:
3 locks held by kworker/1:14/11580:
5 locks held by kworker/u9:7/28673:
2 locks held by syz-executor.1/4457:
 #0: ffff8880202da460 (sb_writers#5){.+.+}-{0:0}, at:
do_unlinkat+0x17f/0x660 fs/namei.c:4146
 #1: ffff88811b4c0de8 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88811b4c0de8 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at:
do_unlinkat+0x269/0x660 fs/namei.c:4150
1 lock held by syz-executor.5/5778:
 #0: ffffffff8c353758 (tomoyo_ss){....}-{0:0}, at:
tomoyo_check_open_permission+0xe8/0x370 security/tomoyo/file.c:761
3 locks held by syz-executor.4/8180:
 #0: ffff88810720bd20 (&q->debugfs_mutex){+.+.}-{3:3}, at:
blk_trace_ioctl+0xab/0x270 kernel/trace/blktrace.c:725
 #1: ffffffff8bbe0f08 (relay_channels_mutex){+.+.}-{3:3}, at:
relay_open kernel/relay.c:518 [inline]
 #1: ffffffff8bbe0f08 (relay_channels_mutex){+.+.}-{3:3}, at:
relay_open+0x389/0x9d0 kernel/relay.c:477
 #2: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #2: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #2: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-executor.4/8184:
 #0: ffff88810720bd20 (&q->debugfs_mutex){+.+.}-{3:3}, at:
blk_trace_ioctl+0xab/0x270 kernel/trace/blktrace.c:725

=============================================

NMI backtrace for cpu 2
CPU: 2 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 2 to CPUs 0-1,3:
NMI backtrace for cpu 0
CPU: 0 PID: 28673 Comm: kworker/u9:7 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x3db/0xc20 kernel/smp.c:969
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89
f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 17 6f 0b 00 f3 90 <41> 0f
b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 06 00 00 8b 43 08 31
RSP: 0018:ffffc90002b47a10 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888063f3fca0 RCX: ffff888040a58000
RDX: 0000000000000000 RSI: ffff888040a58000 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff816bfe59 R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1fee128 R12: ffffed100c7e7f95
R13: 0000000000000002 R14: ffff888063f3fca8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043cfec CR3: 000000000b88e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1112 [inline]
 text_poke_bp_batch+0x355/0x560 arch/x86/kernel/alternative.c:1350
 text_poke_flush arch/x86/kernel/alternative.c:1451 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1458
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32d/0x440 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x156/0x1c0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:746 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:724
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 3
CPU: 3 PID: 9919 Comm: kworker/u8:4 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__sanitizer_cov_trace_pc+0x15/0x40 kernel/kcov.c:200
Code: 8b 80 58 15 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
65 48 8b 0c 25 40 70 02 00 bf 02 00 00 00 48 89 ce 4c 8b 04 24 <e8> 76
ff ff ff 84 c0 74 20 48 8b 91 48 15 00 00 8b 89 44 15 00 00
RSP: 0018:ffffc90018eefc28 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802dd50000
RDX: 0000000000000000 RSI: ffff88802dd50000 RDI: 0000000000000002
RBP: ffffffff88df98b1 R08: ffffffff817d7f4c R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1006758a98 R12: ffff888017e456d8
R13: ffff888017e44c80 R14: dffffc0000000000 R15: ffffffff88df99e0
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6177701270 CR3: 000000003157d000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 trace_hardirqs_off+0x2c/0x1b0 kernel/trace/trace_preemptirq.c:79
 __local_bh_enable_ip+0xc3/0x110 kernel/softirq.c:365
 spin_unlock_bh include/linux/spinlock.h:394 [inline]
 batadv_nc_purge_paths+0x2d1/0x400 net/batman-adv/network-coding.c:475
 batadv_nc_worker+0x287/0x770 net/batman-adv/network-coding.c:726
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 1
CPU: 1 PID: 3025 Comm: jbd2/sda-8 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x1c/0x40 kernel/kcov.c:200
Code: 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 65 48 8b 0c 25 40 70
02 00 bf 02 00 00 00 48 89 ce 4c 8b 04 24 e8 76 ff ff ff 84 c0 <74> 20
48 8b 91 48 15 00 00 8b 89 44 15 00 00 48 8b 02 48 83 c0 01
RSP: 0018:ffffc9000cba68b8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: fffffffffffffffe RCX: ffff88801ed9d640
RDX: 0000000000000000 RSI: ffff88801ed9d640 RDI: 0000000000000002
RBP: ffff888013f46788 R08: ffffffff81a24171 R09: fffffffffffffffe
R10: 0000000000000007 R11: fffffbfff1b20a2a R12: 0000000000000004
R13: 0000000000000000 R14: ffffc9000cba6930 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000477f80 CR3: 00000000218ee000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 list_empty include/linux/list.h:284 [inline]
 rwsem_is_contended include/linux/rwsem.h:121 [inline]
 shrink_slab mm/vmscan.c:942 [inline]
 shrink_slab+0x1a1/0x6f0 mm/vmscan.c:906
 shrink_node_memcgs mm/vmscan.c:3131 [inline]
 shrink_node+0x883/0x1df0 mm/vmscan.c:3252
 shrink_zones mm/vmscan.c:3485 [inline]
 do_try_to_free_pages+0x4f6/0x1440 mm/vmscan.c:3541
 try_to_free_pages+0x2a6/0x760 mm/vmscan.c:3776
 __perform_reclaim mm/page_alloc.c:4588 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 __alloc_pages_slowpath.constprop.0+0x807/0x21b0 mm/page_alloc.c:5007
 __alloc_pages+0x5ab/0x6e0 mm/page_alloc.c:5382
 alloc_pages+0x115/0x240 mm/mempolicy.c:2191
 __stack_depot_save+0x3db/0x520 lib/stackdepot.c:359
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x45/0x300 mm/page_owner.c:181
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2412 [inline]
 prep_new_page+0x1a6/0x240 mm/page_alloc.c:2418
 get_page_from_freelist+0x1eed/0x3b50 mm/page_alloc.c:4149
 __alloc_pages_cpuset_fallback mm/page_alloc.c:4231 [inline]
 __alloc_pages_may_oom mm/page_alloc.c:4322 [inline]
 __alloc_pages_slowpath.constprop.0+0x1d34/0x21b0 mm/page_alloc.c:5051
 __alloc_pages+0x5ab/0x6e0 mm/page_alloc.c:5382
 alloc_pages+0x115/0x240 mm/mempolicy.c:2191
 folio_alloc+0x1c/0x70 mm/mempolicy.c:2201
 filemap_alloc_folio+0x282/0x3d0 mm/filemap.c:1036
 __filemap_get_folio+0x3d7/0x1080 mm/filemap.c:1951
 pagecache_get_page+0x2c/0x1a0 mm/folio-compat.c:125
 find_or_create_page include/linux/pagemap.h:489 [inline]
 grow_dev_page fs/buffer.c:949 [inline]
 grow_buffers fs/buffer.c:1014 [inline]
 __getblk_slow fs/buffer.c:1041 [inline]
 __getblk_gfp+0x240/0xb80 fs/buffer.c:1334
 __getblk include/linux/buffer_head.h:382 [inline]
 jbd2_journal_get_descriptor_buffer+0x10a/0x410 fs/jbd2/journal.c:1014
 journal_submit_commit_record.part.0+0x89/0xa20 fs/jbd2/commit.c:131
 journal_submit_commit_record fs/jbd2/commit.c:128 [inline]
 jbd2_journal_commit_transaction+0x3ffd/0x6c90 fs/jbd2/commit.c:925
 kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0: 0b 00                or     (%rax),%eax
   2: 85 ed                test   %ebp,%ebp
   4: 74 4d                je     0x53
   6: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
   d: fc ff df
  10: 4d 89 f4              mov    %r14,%r12
  13: 4c 89 f5              mov    %r14,%rbp
  16: 49 c1 ec 03          shr    $0x3,%r12
  1a: 83 e5 07              and    $0x7,%ebp
  1d: 49 01 c4              add    %rax,%r12
  20: 83 c5 03              add    $0x3,%ebp
  23: e8 17 6f 0b 00        callq  0xb6f3f
  28: f3 90                pause
* 2a: 41 0f b6 04 24        movzbl (%r12),%eax <-- trapping instruction
  2f: 40 38 c5              cmp    %al,%bpl
  32: 7c 08                jl     0x3c
  34: 84 c0                test   %al,%al
  36: 0f 85 a2 06 00 00    jne    0x6de
  3c: 8b 43 08              mov    0x8(%rbx),%eax
  3f: 31                    .byte 0x31



Best Regards,
Yiru
