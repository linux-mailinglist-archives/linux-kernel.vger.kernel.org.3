Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A06564109
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiGBPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiGBPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:32:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3595B0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 08:32:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h5-20020a056e021d8500b002daba64574dso2491568ila.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 08:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TxsPujnBUvWGDCSXZ9i3Bo1zvr621VewqPaT7DWdiSQ=;
        b=Ahn7fhzwJ0MzFwESJk8HuTzLqF6j64IDoh5Q3/xbvuJpi9trWY3PcVwftrhUmZlw0U
         4dFN09UPsdd43X3Az5NS31ePkmyj1YRdKRhs5ThlSwghOpp7oiCe1zvt3w5M+zJOAB2p
         v6oPsTzNw1kx6LiHlClpbSJCQD3j+i8x8BMceLzPNq1F9sIKzDDu9K/lVjBX/HYdOrZ2
         ehF197wSsRVO1b8yOUb3dMZACkn2j8CxN8VLvw38IN0uqy7b5T8RQpuUdPcVnOnIP8xw
         pjm9a+FWS5j6z53sMoVWtm3+xBDc+edH8eq1p1VQF/RPnnUT5ct1F6jFHMldlM/SCxuK
         14kg==
X-Gm-Message-State: AJIora+14vY3pzq5CSE8b3CQdAXP9pjJwPVR3UyfDXvXWQP2e/6DFe4X
        qx6p4GnWuuR2JLBxfM3Idhbw9G9MJ8d+zxCnKZlpM6a/PPnk
X-Google-Smtp-Source: AGRyM1uStEjZnXyh6Q21+HA2BgAY0lYSFPjAOM0QaQV3F3duoSq/gIuQgwaoYssu0m009oxUtOgVWFmN1TcsBWUZloDjggj/adw4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:b0:2da:9539:3093 with SMTP id
 j13-20020a056e02154d00b002da95393093mr12277493ilu.131.1656775942641; Sat, 02
 Jul 2022 08:32:22 -0700 (PDT)
Date:   Sat, 02 Jul 2022 08:32:22 -0700
In-Reply-To: <000000000000ed47a705e2cbd347@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088a03905e2d435c2@google.com>
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
From:   syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    90557fa89d3e dt-bindings: usb: atmel: Add Microchip LAN966..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16892484080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33f1eaa5b20a699
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155cc25c080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f64834080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com

INFO: task kworker/0:2:71 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00099-g90557fa89d3e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23752 pid:   71 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 input_disconnect_device drivers/input/input.c:784 [inline]
 __input_unregister_device+0x24/0x470 drivers/input/input.c:2234
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2429
 iforce_usb_disconnect+0x5e/0xf0 drivers/input/joystick/iforce/iforce-usb.c:261
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:545 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:537
 __device_release_driver drivers/base/dd.c:1222 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1248
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3604
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x278/0x6ec drivers/usb/core/hub.c:2228
 hub_port_connect drivers/usb/core/hub.c:5190 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5490 [inline]
 port_event drivers/usb/core/hub.c:5646 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5728
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff87a94700 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
6 locks held by kworker/0:2/71:
 #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90001057da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88810f267190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff88810f267190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5674
 #3: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff88811d2cb118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff88811d2cb118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff88811d2cb118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffff88811d2cc2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_disconnect_device drivers/input/input.c:784 [inline]
 #5: ffff88811d2cc2c0 (&dev->mutex#2){+.+.}-{3:3}, at: __input_unregister_device+0x24/0x470 drivers/input/input.c:2234
2 locks held by acpid/1166:
 #0: ffff88811d2cf110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_close_device drivers/input/evdev.c:411 [inline]
 #0: ffff88811d2cf110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_release+0x299/0x410 drivers/input/evdev.c:456
 #1: ffff88811d2cc2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:726
2 locks held by getty/1240:
 #0: ffff8881109fc098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900000432e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by udevd/1293:
 #0: ffff8881106e6488 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:197 [inline]
 #0: ffff8881106e6488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x189/0x6e0 fs/kernfs/file.c:236
 #1: ffff888108bf0a00 (kn->active#40){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:198 [inline]
 #1: ffff888108bf0a00 (kn->active#40){++++}-{0:0}, at: kernfs_fop_read_iter+0x1ac/0x6e0 fs/kernfs/file.c:236
 #2: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:840 [inline]
 #2: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 26 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00099-g90557fa89d3e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c9/0x240 drivers/acpi/processor_idle.c:554

