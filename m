Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714954759AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbhLONa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:30:27 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:55010 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbhLONaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:30:25 -0500
Received: by mail-il1-f197.google.com with SMTP id g14-20020a92c7ce000000b002b1e78da1f9so2722171ilk.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gVQCM2ntOuDdKZF7tsePymOiEMWw9CHIovfNr6x4O9U=;
        b=cx2M70aNvpSKDTFIeYMLNcEO2uPNGjyDWxoQNriFg//H/CZmyb7Blyj6ObOq5PE4c/
         dDJaVRRC9gHwHAqSnwuULf30HEh8TbdAm/ErZxia9DbzsXGsCJ1rIiNCjtHWpPOdwT9m
         S4z30/n9YS/eLU5i1gi89+F0djjqNvYJ0u5gG2cgIOO0YILmqF8nlR8fVOVdN/n/PAaf
         N0ZmXAPrITVl/gVsRc0BbgCLfZvTxb/1yq9Wlc64Cr+jxtp155YXi5TM5qYgL6MOBa7F
         wbIwK5mv+apj3S2Rse/fsPwymmdCs/g/3IK4lFR1umU03ti0ktTk4FpXod3SQqcxZLE2
         wO/Q==
X-Gm-Message-State: AOAM532LwLab0Q+zI9UJmCiVdvItsmyh1qKcH6Hv7Dw3uAveOnu7O4Iz
        3FNb3s5V7zy1KkmO/DZCQ6Vh6/emMHBxKUdhb0OesnimUrgC
X-Google-Smtp-Source: ABdhPJwA474vx3zs0eRKjWQyfm5xzbNiauuWaSPduNn5M4fSPxkKQ5ma9WxNyZVAapLxsH5NDtLy1fJhIgHPpGqKyn4W5pb9yoZZ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1304:: with SMTP id r4mr5672523jad.332.1639575024767;
 Wed, 15 Dec 2021 05:30:24 -0800 (PST)
Date:   Wed, 15 Dec 2021 05:30:24 -0800
In-Reply-To: <00000000000042e11e05d2b0b39b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef198805d32f4ec7@google.com>
Subject: Re: [syzbot] INFO: task hung in r871xu_dev_remove
From:   syzbot <syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    5472f14a3742 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1767bc25b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174f3f51b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17568e83b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com

INFO: task kworker/1:1:25 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24888 pid:   25 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x174/0x270 kernel/sched/completion.c:138
 r871xu_dev_remove+0x6e/0x2c0 drivers/staging/rtl8712/usb_intf.c:597
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task kworker/1:2:137 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:25016 pid:  137 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 unregister_netdev+0xe/0x20 net/core/dev.c:11138
 r871xu_dev_remove+0x24f/0x2c0 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task kworker/0:3:1136 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:24888 pid: 1136 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x174/0x270 kernel/sched/completion.c:138
 r871xu_dev_remove+0x6e/0x2c0 drivers/staging/rtl8712/usb_intf.c:597
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task kworker/1:0:3714 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:24864 pid: 3714 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x174/0x270 kernel/sched/completion.c:138
 r871xu_dev_remove+0x6e/0x2c0 drivers/staging/rtl8712/usb_intf.c:597
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task kworker/1:3:3717 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:24488 pid: 3717 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x174/0x270 kernel/sched/completion.c:138
 r871xu_dev_remove+0x6e/0x2c0 drivers/staging/rtl8712/usb_intf.c:597
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task kworker/1:5:3722 blocked for more than 144 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:24888 pid: 3722 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 netdev_run_todo+0x6fa/0xa80 net/core/dev.c:10635
 r871xu_dev_remove+0x24f/0x2c0 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5643 [inline]
 hub_event+0x1c9c/0x4460 drivers/usb/core/hub.c:5725
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/1:1/25:
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90000dffdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88801cfca220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88801cfca220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff888075ba6220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888075ba6220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff88807b5081a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88807b5081a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff88807b5081a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff88807b5081a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
1 lock held by khungtaskd/27:
 #0: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
6 locks held by kworker/1:2/137:
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000209fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff888148291220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888148291220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff88807656e220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88807656e220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff88807d3fb1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88807d3fb1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff88807d3fb1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff88807d3fb1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
 #5: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: unregister_netdev+0xe/0x20 net/core/dev.c:11138
5 locks held by kworker/0:3/1136:
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90004e6fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff8881482e9220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff8881482e9220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff88807d1fa220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88807d1fa220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff88807d1f91a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88807d1f91a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff88807d1f91a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff88807d1f91a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
2 locks held by dhcpcd/3184:
 #0: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x1b3/0x1ca0 net/ipv4/devinet.c:1068
 #1: ffff88807f254e60 (&padapter->mutex_start){+.+.}-{3:3}, at: netdev_open+0x2e/0x6c0 drivers/staging/rtl8712/os_intfs.c:375
2 locks held by getty/3283:
 #0: ffff88802276f098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
3 locks held by udevd/3682:
 #0: ffff888022339c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
 #0: ffff888022339c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
 #1: ffff88801af0a748 (kn->active#50){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
 #1: ffff88801af0a748 (kn->active#50){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
 #2: ffff888075ba0220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:765 [inline]
 #2: ffff888075ba0220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
5 locks held by kworker/1:0/3714:
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90001fbfdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff888148301220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888148301220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff88807f12e220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88807f12e220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff8880155e61a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff8880155e61a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff8880155e61a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff8880155e61a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
5 locks held by kworker/1:3/3717:
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000291fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff888148289220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888148289220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff888075ba0220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888075ba0220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff88807e0fd1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88807e0fd1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff88807e0fd1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff88807e0fd1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
3 locks held by kworker/1:4/3720:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000294fdb0 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
3 locks held by kworker/0:0/3721:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000295fdb0 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
6 locks held by kworker/1:5/3722:
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801578f938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000296fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff888148311220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888148311220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4460 drivers/usb/core/hub.c:5671
 #3: ffff88807e543220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88807e543220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff88807d3fe1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88807d3fe1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff88807d3fe1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff88807d3fe1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
 #5: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: netdev_run_todo+0x6fa/0xa80 net/core/dev.c:10635
3 locks held by kworker/0:2/3729:
 #0: ffff88814b0d8938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88814b0d8938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88814b0d8938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88814b0d8938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88814b0d8938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88814b0d8938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900029d7db0 ((addr_chk_work).work){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0xa/0x20 net/ipv6/addrconf.c:4595
3 locks held by kworker/1:8/3734:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900029ffdb0 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458
3 locks held by udevd/3737:
 #0: ffff88807d251c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:203 [inline]
 #0: ffff88807d251c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x185/0x5f0 fs/kernfs/file.c:242
 #1: ffff88801b95d490 (kn->active#50){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:204 [inline]
 #1: ffff88801b95d490 (kn->active#50){++++}-{0:0}, at: kernfs_fop_read_iter+0x1a8/0x5f0 fs/kernfs/file.c:242
 #2: ffff88807e543220 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:765 [inline]
 #2: ffff88807e543220 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
3 locks held by kworker/1:10/3926:
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90002b2fdb0 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8d30d3a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x11/0x50 net/core/dev.c:10458

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc5-syzkaller #0
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
CPU: 1 PID: 3709 Comm: syz-executor834 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:util_est_update kernel/sched/fair.c:4001 [inline]
RIP: 0010:dequeue_task_fair+0x4bf/0xea0 kernel/sched/fair.c:5742
Code: 42 0f b6 04 30 84 c0 74 08 3c 03 0f 8e 6e 08 00 00 41 8b bf c0 01 00 00 85 ff 0f 84 0c fe ff ff 44 0f b6 74 24 08 41 83 e6 01 <45> 84 f6 0f 84 19 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 54
RSP: 0018:ffffc900020bfac0 EFLAGS: 00000093
RAX: ffff8880b9d39a80 RBX: 0000000000000005 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff8880b9d39b5c RDI: ffff88801f9a9df0
RBP: ffff88801f9a9d00 R08: 0000000000000000 R09: ffff8880b9d39bc8
R10: 00000000000002ab R11: 0000000000000001 R12: 0000000000000009
R13: 0000000000000000 R14: 0000000000000001 R15: ffff8880b9d39b40
FS:  0000555555f6c400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6cecc8bd40 CR3: 00000000780a3000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 deactivate_task kernel/sched/core.c:2033 [inline]
 __schedule+0xbe1/0x4940 kernel/sched/core.c:6207
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x24e/0x690 kernel/time/hrtimer.c:2044
 hrtimer_nanosleep+0x1f9/0x4a0 kernel/time/hrtimer.c:2097
 common_nsleep+0xa2/0xc0 kernel/time/posix-timers.c:1227
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x2f4/0x430 kernel/time/posix-timers.c:1245
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6cecb20251
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 ba dc ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 f3 dc ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007f6cecc8cd40 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00000000001b25ad RCX: 00007f6cecb20251
RDX: 00007f6cecc8cd80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000003f R08: 0000000000000000 R09: 00007ffed43bc080
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f6cecc8cdcc
R13: 00007f6cecc8ce00 R14: 00007f6cecc8cde0 R15: 000000000000003d
 </TASK>
----------------
Code disassembly (best guess):
   0:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
   5:	84 c0                	test   %al,%al
   7:	74 08                	je     0x11
   9:	3c 03                	cmp    $0x3,%al
   b:	0f 8e 6e 08 00 00    	jle    0x87f
  11:	41 8b bf c0 01 00 00 	mov    0x1c0(%r15),%edi
  18:	85 ff                	test   %edi,%edi
  1a:	0f 84 0c fe ff ff    	je     0xfffffe2c
  20:	44 0f b6 74 24 08    	movzbl 0x8(%rsp),%r14d
  26:	41 83 e6 01          	and    $0x1,%r14d
* 2a:	45 84 f6             	test   %r14b,%r14b <-- trapping instruction
  2d:	0f 84 19 02 00 00    	je     0x24c
  33:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3a:	fc ff df
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	54                   	push   %rsp

