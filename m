Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C956455E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 08:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiGCGJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 02:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCGJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 02:09:12 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DF2603
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 23:09:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id p123-20020a6bbf81000000b00674f66cf13aso3971470iof.23
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 23:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=epXbEtSZFlUSjCkmmS+S9FmTG4RJKlgrEeWf7Rkk7Es=;
        b=lUKnD3gMou1Q1iboFl2CBFXAFSQEuCQ1XY1EuX9tG40P6o4LiEX6G3mfZrJ+JUAGR8
         s0ZNBykrYQHTact6lCpPZkvVfq/o1EVsbDMI+wlurOfbvBEw4ZKwL44m7RL5Ev/O0VfE
         r53+fHIDRE//jOBaTZRP8U8LGrzY/IfwUxX6Bsh+94UyqSIt5x8WOHVPLcCCwy+MsGUq
         R9lKmOZMD5oMCETd2fU3SU34h9qWOySA9OF+PmRZg3JXU/G69uoMAd9QFQi2/AyFqCNc
         SOUbNvVJeYnNsPV9vBwpuNRZF/MMKc3etaB5PkvLB/v6vg7bFpZMZF3XvUZ/8aZmtuAw
         5dnw==
X-Gm-Message-State: AJIora/Nm/+xXez7iXtLqoH22ONloQ8Y8m59odkqmML3yvfBTR19n5AH
        fVYlb+eEhVLGS4Zbpy/2G+sayGozYT55HpPI2O0KyXqHiqtO
X-Google-Smtp-Source: AGRyM1sLn8ktFeFEL79VV5x0lYqQIVc6E2OvPjE37nDW53iLAtnNXKgtQBZc9WqhNN8crh+NmsEFSkY5SHkV3ze/tbL/H35mScxC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:928:b0:2dc:759:7817 with SMTP id
 o8-20020a056e02092800b002dc07597817mr1516309ilt.84.1656828547767; Sat, 02 Jul
 2022 23:09:07 -0700 (PDT)
Date:   Sat, 02 Jul 2022 23:09:07 -0700
In-Reply-To: <20220702234214.903-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b250605e2e0757a@google.com>
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
From:   syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __input_unregister_device

INFO: task kworker/1:1:26 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:23328 pid:   26 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
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
 hub_port_connect drivers/usb/core/hub.c:5207 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5663 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5745
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/1:1/26:
 #0: ffff888011ad3138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011ad3138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011ad3138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011ad3138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011ad3138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011ad3138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000a1fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888147a97190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888147a97190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff88807b9db190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff88807b9db190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff88807b9de118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff88807b9de118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff88807b9de118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffff88807ed272c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_disconnect_device drivers/input/input.c:784 [inline]
 #5: ffff88807ed272c0 (&dev->mutex#2){+.+.}-{3:3}, at: __input_unregister_device+0x24/0x470 drivers/input/input.c:2234
1 lock held by khungtaskd/28:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by acpid/2961:
 #0: ffff88807c658158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff88807c658158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff88807ed272c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:726
2 locks held by getty/3285:
 #0: ffff8881477a2098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by udevd/4064:
 #0: ffff888147515c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:197 [inline]
 #0: ffff888147515c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x189/0x6e0 fs/kernfs/file.c:236
 #1: ffff88802410dda0 (kn->active#86){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:198 [inline]
 #1: ffff88802410dda0 (kn->active#86){++++}-{0:0}, at: kernfs_fop_read_iter+0x1ac/0x6e0 fs/kernfs/file.c:236
 #2: ffff88807b9db190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:840 [inline]
 #2: ffff88807b9db190 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
2 locks held by udevd/4067:
 #0: ffff88807a669110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open_device drivers/input/evdev.c:393 [inline]
 #0: ffff88807a669110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open+0x2f3/0x6a0 drivers/input/evdev.c:487
 #1: ffff88807ed272c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_open_device+0x4a/0x320 drivers/input/input.c:656

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
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
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4068 Comm: syz-executor.0 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:native_apic_mem_write+0x8/0x10 arch/x86/include/asm/apic.h:110
Code: 00 00 be 01 00 00 00 e9 06 74 2e 00 66 0f 1f 44 00 00 b8 01 00 00 00 c3 cc cc cc cc cc cc cc cc cc cc 89 ff 89 b7 00 c0 5f ff <c3> 0f 1f 80 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 53 89 fb 48
RSP: 0018:ffffc9000305fb38 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffffffff8b7fbae0 RCX: 0000000000000020
RDX: 1ffffffff16ff75e RSI: 000000000000ffa2 RDI: 0000000000000380
RBP: ffff8880b9a27200 R08: 0000000000000005 R09: 000000000000003f
R10: 0000000000000020 R11: 0000000000000001 R12: 000000000000ffa2
R13: 0000000000000020 R14: ffff8880b9a2a500 R15: 0000000000000000
FS:  0000555556d10400(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3cead8f110 CR3: 000000007226e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 apic_write arch/x86/include/asm/apic.h:396 [inline]
 lapic_next_event+0x4d/0x80 arch/x86/kernel/apic/apic.c:478
 clockevents_program_event+0x254/0x370 kernel/time/clockevents.c:334
 tick_program_event+0xac/0x140 kernel/time/tick-oneshot.c:44
 __hrtimer_reprogram kernel/time/hrtimer.c:681 [inline]
 hrtimer_reprogram+0x38c/0x440 kernel/time/hrtimer.c:866
 hrtimer_start_range_ns+0x7af/0xa80 kernel/time/hrtimer.c:1299
 hrtimer_start_expires include/linux/hrtimer.h:432 [inline]
 hrtimer_sleeper_start_expires kernel/time/hrtimer.c:1965 [inline]
 do_nanosleep+0x1e8/0x690 kernel/time/hrtimer.c:2041
 hrtimer_nanosleep+0x1f9/0x4a0 kernel/time/hrtimer.c:2097
 common_nsleep+0xa2/0xc0 kernel/time/posix-timers.c:1227
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x2f4/0x430 kernel/time/posix-timers.c:1245
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f3ce9cade31
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007ffddf9f8200 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 000000000000006d RCX: 00007f3ce9cade31
RDX: 00007ffddf9f8240 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffddf9f82cc R08: 0000000000000000 R09: 00007ffddf9fa080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000003898b R14: 0000000000000000 R15: 00007ffddf9f8330
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	be 01 00 00 00       	mov    $0x1,%esi
   7:	e9 06 74 2e 00       	jmpq   0x2e7412
   c:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  12:	b8 01 00 00 00       	mov    $0x1,%eax
  17:	c3                   	retq
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	cc                   	int3
  1e:	cc                   	int3
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	cc                   	int3
  22:	89 ff                	mov    %edi,%edi
  24:	89 b7 00 c0 5f ff    	mov    %esi,-0xa04000(%rdi)
* 2a:	c3                   	retq <-- trapping instruction
  2b:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  32:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  39:	fc ff df
  3c:	53                   	push   %rbx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	48                   	rex.W


Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16a9e6f0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1491b034080000

