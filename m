Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B84841C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiADMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiADMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:40:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E90C061792;
        Tue,  4 Jan 2022 04:40:15 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id w184so87860426ybg.5;
        Tue, 04 Jan 2022 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=75dtbV04goI2w8S91bVy1ZU22mEAo/mELu/LaDGPzJI=;
        b=Axe/lKGc/XjNeNFxXlUoMrP+Jg0urBX1EF8NESsH83xWLLF3bC6LlCEHE69EBX1gmv
         kXGHuHAR1NS1vvssLixd0+nIwqbDXN1gzI+gTZFjwzS76RhTD0PUChjx+X8qGfroLT5l
         WzMC1aqbzEz/WCm7pIJwf8wnbFsSg/IwoQFE6vIKRDm4W+yxVLJz/l3lP1oFetdQCAgE
         eYMJ4IHRU45X3wbh1i96z/0sG4AbKO6watqP32MlmeauCs8YQRx8HOZFdk3TPrwz58lC
         +VgtPIkfgPlJP2RbAkuTk1tM8NBTujBQmqo5sdtWPsNYvLFTi3MHcY01Pvwr6NeZ3VA/
         yn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=75dtbV04goI2w8S91bVy1ZU22mEAo/mELu/LaDGPzJI=;
        b=wunYbULWGfYvE/upyWJqFofGVa/kxtAqcznjYJPa0f69nsEWRQRo/pTMvJccdFCEfI
         +i997sH60f6hW4fU+VzhtmIWWE9t5Ngx/c9t/HY5W6cr3GUIMlEikdcwLm2e15Fp5N7G
         KVKFN3ryDcrG3QQ0JiIHOAZe0o+pifeqQ9XlK6Pn5AKP8aBpNw3ji9kPkgccIq/vOyZc
         GnuqTH0xD8i6+J8YiP7cpSxRWCbbChlNUyNnwSi1Vvp6CsHI370T23Kqh+JJdY4yjkTN
         epTRqgQXELBo22CE8Wo69tHudPpo7xfLk+gPoW1O2FPTwPeieK3tdy11absFohxhC0g7
         sR0w==
X-Gm-Message-State: AOAM5308eYA4wH9+KBItt6+M/LygKm8enxM7LR4HmpstUexbXvwBOxOO
        viWljmvaQRKoiCyq647rBQNgGiKOisrQzN68imo=
X-Google-Smtp-Source: ABdhPJz0pdbyCfvKkUH5x5BWR5taHg4ak2B5rSp2XnMR4cwL1TOcn+LilC8GwFzejsBzgRdMuvwRpl8BHEi7O1qLPPI=
X-Received: by 2002:a25:3006:: with SMTP id w6mr66216343ybw.691.1641300015002;
 Tue, 04 Jan 2022 04:40:15 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 20:40:04 +0800
Message-ID: <CAFkrUsjs-tTrqtqSDr+kCgLKQsR8CMDQVTGfsbckmXLg6TEUtw@mail.gmail.com>
Subject: INFO: task hung in hub_event
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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
console output: https://paste.ubuntu.com/p/rnV5TYkykk/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>


INFO: task kworker/2:12:10249 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/2:12    state:D stack:26368 pid:10249 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 hub_port_connect drivers/usb/core/hub.c:5250 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1b4c/0x4090 drivers/usb/core/hub.c:5725
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6757:
 #0: ffff88801812a670 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:1034
3 locks held by syz-executor.6/6796:
3 locks held by syz-executor.3/6797:
 #0: ffff888063f39a98 (&rq->__lock){-.-.}-{2:2}, at:
raw_spin_rq_lock_nested+0x1e/0x30 kernel/sched/core.c:478
 #1: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
perf_iterate_sb+0x0/0x9c0 kernel/events/core.c:7750
 #2: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
folio_memcg_lock+0x0/0x580 include/linux/cgroup.h:574
2 locks held by kworker/u8:5/11482:
5 locks held by kworker/1:67/21640:
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc90003fcfdc8 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff88801bccd220 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #2: ffff88801bccd220 (&dev->mutex){....}-{3:3}, at:
hub_event+0x1c1/0x4090 drivers/usb/core/hub.c:5671
 #3: ffff88801bd185c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
usb_lock_port drivers/usb/core/hub.c:3086 [inline]
 #3: ffff88801bd185c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5249 [inline]
 #3: ffff88801bd185c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 #3: ffff88801bd185c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5643 [inline]
 #3: ffff88801bd185c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_event+0x1b23/0x4090 drivers/usb/core/hub.c:5725
 #4: ffff88801a7cce68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5250 [inline]
 #4: ffff88801a7cce68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 #4: ffff88801a7cce68 (hcd->address0_mutex){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5643 [inline]
 #4: ffff88801a7cce68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_event+0x1b4c/0x4090 drivers/usb/core/hub.c:5725
5 locks held by kworker/2:12/10249:
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc900141afdc8 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff88801be3f220 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #2: ffff88801be3f220 (&dev->mutex){....}-{3:3}, at:
hub_event+0x1c1/0x4090 drivers/usb/core/hub.c:5671
 #3: ffff8881088da5c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
usb_lock_port drivers/usb/core/hub.c:3086 [inline]
 #3: ffff8881088da5c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5249 [inline]
 #3: ffff8881088da5c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 #3: ffff8881088da5c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5643 [inline]
 #3: ffff8881088da5c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_event+0x1b23/0x4090 drivers/usb/core/hub.c:5725
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5250 [inline]
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5643 [inline]
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_event+0x1b4c/0x4090 drivers/usb/core/hub.c:5725
5 locks held by kworker/3:85/14401:
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888102b41d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000611fdc8 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff8881087e6220 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #2: ffff8881087e6220 (&dev->mutex){....}-{3:3}, at:
hub_event+0x1c1/0x4090 drivers/usb/core/hub.c:5671
 #3: ffff88801bdb15c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
usb_lock_port drivers/usb/core/hub.c:3086 [inline]
 #3: ffff88801bdb15c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5249 [inline]
 #3: ffff88801bdb15c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 #3: ffff88801bdb15c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5643 [inline]
 #3: ffff88801bdb15c0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_event+0x1b23/0x4090 drivers/usb/core/hub.c:5725
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5250 [inline]
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5643 [inline]
 #4: ffff888108882a68 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_event+0x1b4c/0x4090 drivers/usb/core/hub.c:5725
3 locks held by kworker/3:97/14413:
 #0: ffff8880116b1538 ((wq_completion)pm){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880116b1538 ((wq_completion)pm){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880116b1538 ((wq_completion)pm){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff8880116b1538 ((wq_completion)pm){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff8880116b1538 ((wq_completion)pm){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff8880116b1538 ((wq_completion)pm){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000621fdc8
((work_completion)(&hcd->wakeup_work)){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffff8881085b8220 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #2: ffff8881085b8220 (&dev->mutex){....}-{3:3}, at:
usb_remote_wakeup+0x1f/0xe0 drivers/usb/core/hub.c:3720
2 locks held by syz-executor.0/5478:
3 locks held by syz-executor.2/5490:
5 locks held by syz-executor.6/5499:

=============================================

NMI backtrace for cpu 3
CPU: 3 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc6 #9
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
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 1
CPU: 1 PID: 5478 Comm: syz-executor.0 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:hlock_class kernel/locking/lockdep.c:194 [inline]
RIP: 0010:mark_lock.part.0+0xc4/0x27c0 kernel/locking/lockdep.c:4583
Code: 00 41 bd 01 00 00 00 44 89 f1 41 d3 e5 4d 63 ed 4d 8d 7c 24 20
48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 0f b6 04 02 <84> c0
74 08 3c 03 0f 8e 8c 09 00 00 41 0f b7 54 24 20 66 81 e2 ff
RSP: 0018:ffffc900007e05c0 EFLAGS: 00000016
RAX: 0000000000000000 RBX: 1ffff920000fc0c0 RCX: ffffffff815c1d52
RDX: 1ffff11025cd7c24 RSI: ffff88812e6be100 RDI: ffff88812e6be122
RBP: ffffc900007e0730 R08: 1ffff11025cd7c1f R09: fffffbfff1fee129
R10: ffffffff8ff70947 R11: fffffbfff1fee128 R12: ffff88812e6be100
R13: 0000000000000200 R14: 0000000000000009 R15: ffff88812e6be120
FS:  00007fc709689700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056396e881f17 CR3: 000000011b375000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 mark_lock kernel/locking/lockdep.c:4569 [inline]
 mark_usage kernel/locking/lockdep.c:4526 [inline]
 __lock_acquire+0x8e1/0x57e0 kernel/locking/lockdep.c:4981
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 __perf_output_begin kernel/events/ring_buffer.c:163 [inline]
 perf_output_begin_forward+0xb0/0xa30 kernel/events/ring_buffer.c:268
 __perf_event_output kernel/events/core.c:7489 [inline]
 perf_event_output_forward+0xf2/0x280 kernel/events/core.c:7507
 __perf_event_overflow+0x13c/0x3d0 kernel/events/core.c:9207
 perf_swevent_hrtimer+0x37c/0x3f0 kernel/events/core.c:10600
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x5f0/0xdf0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:preempt_schedule_irq+0x49/0x90 kernel/sched/core.c:6668
Code: 55 53 65 48 8b 1c 25 40 70 02 00 48 89 dd 48 c1 ed 03 48 01 c5
bf 01 00 00 00 e8 62 44 0c f8 e8 6d 6c 39 f8 fb bf 01 00 00 00 <e8> 22
cf ff ff 9c 58 fa f6 c4 02 75 27 bf 01 00 00 00 e8 00 2a 0c
RSP: 0018:ffffc900062ef2a8 EFLAGS: 00000206
RAX: 0000000000000dbb RBX: ffff88812e6bd640 RCX: 1ffffffff1ff599e
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffed1025cd7ac8 R08: 0000000000000001 R09: fffffbfff1fee13c
R10: 0000000000000001 R11: fffffbfff1fee13b R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 irqentry_exit+0x31/0x80 kernel/entry/common.c:425
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:rcu_preempt_read_exit kernel/rcu/tree_plugin.h:380 [inline]
RIP: 0010:__rcu_read_unlock+0x11/0x570 kernel/rcu/tree_plugin.h:419
Code: e8 b4 34 5a 00 e9 a6 f9 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 40 00 41 56 41 55 41 54 55 65 48 8b 2c 25 40 70 02 00 53 <48> 8d
bd fc 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc900062ef370 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88812e6bd640
RDX: 0000000000000000 RSI: ffff88812e6bd640 RDI: 0000000000000002
RBP: ffff88812e6bd640 R08: ffffffff818411dc R09: 0000000000000000
R10: 0000000000000001 R11: fffffbfff1fee128 R12: ffffc900062ef400
R13: 0000000000000000 R14: ffff88812e6bd640 R15: ffff88804c446280
 rcu_read_unlock include/linux/rcupdate.h:720 [inline]
 is_bpf_text_address+0x81/0x170 kernel/bpf/core.c:717
 kernel_text_address kernel/extable.c:124 [inline]
 kernel_text_address+0x39/0x80 kernel/extable.c:93
 __kernel_text_address+0x9/0x30 kernel/extable.c:78
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:318 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:313
 arch_stack_walk+0x93/0xe0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0x100/0x140 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1723 [inline]
 slab_free_freelist_hook mm/slub.c:1749 [inline]
 slab_free mm/slub.c:3513 [inline]
 kfree+0x107/0x4c0 mm/slub.c:4561
 tomoyo_check_open_permission+0x169/0x370 security/tomoyo/file.c:786
 tomoyo_file_open security/tomoyo/tomoyo.c:311 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:306
 security_file_open+0x52/0x650 security/security.c:1635
 do_dentry_open+0x353/0x1250 fs/open.c:809
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1c3c/0x26c0 fs/namei.c:3559
 do_filp_open+0x1c1/0x290 fs/namei.c:3586
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
 do_sys_open+0xc3/0x140 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc70ad1789d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc709688c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fc70ae36f60 RCX: 00007fc70ad1789d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
RBP: 00007fc70ad8400d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe9fe1f68f R14: 00007fc70ae36f60 R15: 00007fc709688dc0
 </TASK>
NMI backtrace for cpu 0
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x1a/0x40 kernel/kcov.c:200
Code: 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 65 48 8b 0c 25
40 70 02 00 bf 02 00 00 00 48 89 ce 4c 8b 04 24 e8 76 ff ff ff <84> c0
74 20 48 8b 91 48 15 00 00 8b 89 44 15 00 00 48 8b 02 48 83
RSP: 0018:ffffc900007279f8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88801161b980
RDX: 0000000000000000 RSI: ffff88801161b980 RDI: 0000000000000002
RBP: ffffc90000727b80 R08: ffffffff8727162b R09: 0000000000000000
R10: 0000000000000001 R11: fffffbfff1b20a2a R12: ffff888044bb06c2
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888044bb0640
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6256488000 CR3: 000000010755d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __netif_receive_skb_core+0x11bb/0x3a60 net/core/dev.c:5375
 __netif_receive_skb_one_core+0xae/0x180 net/core/dev.c:5463
 __netif_receive_skb+0x24/0x1c0 net/core/dev.c:5579
 process_backlog+0x223/0x770 net/core/dev.c:6455
 __napi_poll+0xb3/0x630 net/core/dev.c:7023
 napi_poll net/core/dev.c:7090 [inline]
 net_rx_action+0x823/0xbc0 net/core/dev.c:7177
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 2
CPU: 2 PID: 5461 Comm: systemd-udevd Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:hlock_class kernel/locking/lockdep.c:194 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4701 [inline]
RIP: 0010:__lock_acquire+0x43b/0x57e0 kernel/locking/lockdep.c:4977
Code: fa 48 c1 ea 03 0f b6 04 02 84 c0 74 06 0f 8e f0 11 00 00 48 b8
00 00 00 00 00 fc ff df 48 8b 4c 24 30 45 0f b6 a7 b8 00 00 00 <48> c1
e9 03 0f b6 04 01 84 c0 74 08 3c 03 0f 8e b6 11 00 00 44 0f
RSP: 0018:ffffc900036df450 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: ffff88812cf02728
RDX: 1ffffffff1fee26b RSI: 0000000000000008 RDI: ffffffff8ff71358
RBP: ffff88812cf02708 R08: 1ffff110259e04e0 R09: fffffbfff1fee129
R10: ffffffff8ff70947 R11: fffffbfff1fee128 R12: 0000000000000002
R13: ffff88812cf01cc0 R14: ffffffff8bb80e20 R15: ffffffff8ff712a0
FS:  00007f62c61298c0(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcb6541ff8 CR3: 000000011c0da000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 is_bpf_text_address+0x36/0x170 kernel/bpf/core.c:715
 kernel_text_address kernel/extable.c:124 [inline]
 kernel_text_address+0x39/0x80 kernel/extable.c:93
 __kernel_text_address+0x9/0x30 kernel/extable.c:78
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:318 [inline]
 unwind_get_return_address+0x5a/0xa0 arch/x86/kernel/unwind_orc.c:313
 arch_stack_walk+0x93/0xe0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:269 [inline]
 __kmalloc+0x1d2/0x3d0 mm/slub.c:4423
 kmalloc include/linux/slab.h:595 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x219/0x420 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1334
 vfs_getattr+0x22/0x60 fs/stat.c:157
 vfs_fstat+0x49/0x90 fs/stat.c:182
 __do_sys_newfstat+0x81/0x100 fs/stat.c:422
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f62c4f9c2e2
Code: 48 8b 05 b9 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f
1f 40 00 83 ff 01 77 33 48 63 fe b8 05 00 00 00 48 89 d6 0f 05 <48> 3d
00 f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 8b 15 81 db 2b 00 f7
RSP: 002b:00007ffc339204b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 00007f62c5257440 RCX: 00007f62c4f9c2e2
RDX: 00007ffc339204c0 RSI: 00007ffc339204c0 RDI: 000000000000000f
RBP: 000056396e682d30 R08: 0000000000000b40 R09: 000056396e67ee40
R10: 000056396e682d30 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000003e R14: 000056396e67ee40 R15: 00007ffc33920760
 </TASK>
----------------
Code disassembly (best guess):
   0: 00 41 bd              add    %al,-0x43(%rcx)
   3: 01 00                add    %eax,(%rax)
   5: 00 00                add    %al,(%rax)
   7: 44 89 f1              mov    %r14d,%ecx
   a: 41 d3 e5              shl    %cl,%r13d
   d: 4d 63 ed              movslq %r13d,%r13
  10: 4d 8d 7c 24 20        lea    0x20(%r12),%r15
  15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1c: fc ff df
  1f: 4c 89 fa              mov    %r15,%rdx
  22: 48 c1 ea 03          shr    $0x3,%rdx
  26: 0f b6 04 02          movzbl (%rdx,%rax,1),%eax
* 2a: 84 c0                test   %al,%al <-- trapping instruction
  2c: 74 08                je     0x36
  2e: 3c 03                cmp    $0x3,%al
  30: 0f 8e 8c 09 00 00    jle    0x9c2
  36: 41 0f b7 54 24 20    movzwl 0x20(%r12),%edx
  3c: 66                    data16
  3d: 81                    .byte 0x81
  3e: e2 ff                loop   0x3f




Best Regards,
Yiru
