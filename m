Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C7564CB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiGDEjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGDEjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:39:08 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8922BF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:39:07 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l2-20020a056e0212e200b002d9258029c4so3701792iln.22
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sPHe5YWP+BoqNOb2jdiFWllMFtXP31hqto/iV2CYgAY=;
        b=vjq2CjDQ4+GhUOmk85bzajnwkpFHVXQGi7lzhHkkAT+um0ClFuNh3pxE20M91ArPeY
         TsLq6g7rCjLvJbzZ7qO0Fg8q6dlrksL5NyT3R5DhiM026ZZPeIud9SDuKf6C1mAB9stA
         LlD1t8XeZbwuxlZt98qn+khcXUrTjQXn6T0v3VV6+p19+gDwG8WmHKvbZaMfVZSiBXls
         WCU3hdUlUGN3tVooVJEiGjuFtdYxFb41rT3256WNOxie3GRWOqYAIRVRgPZ9Wwhw2Cg1
         S5qWE3YX7DkukJckcNtGnDoDRFUOOITYHSMEVIFqAZbqQQm+NlshLpSQ4O540lBebEFQ
         iGNQ==
X-Gm-Message-State: AJIora8x23AKPGiuX7HO84nzqNDMrjts1PsxuUmsHefbqIUZwSXppj3c
        JRZTzKsHiLxOVc8ehifk0EwNBicoQERyJcICkL+o6hTOH/Vz
X-Google-Smtp-Source: AGRyM1uw2BegVpoo4yawAUR7Tw9NdDzsuwhUUYKAAXAZRh7/wkH39LA83b2DZMPTMfiZ6KOFAsZQumsT8+Jq09nhD82Jgg3gwtpD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f92:b0:2da:6799:789 with SMTP id
 v18-20020a056e020f9200b002da67990789mr15657538ilo.3.1656909546458; Sun, 03
 Jul 2022 21:39:06 -0700 (PDT)
Date:   Sun, 03 Jul 2022 21:39:06 -0700
In-Reply-To: <20220704042001.1830-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1138c05e2f35061@google.com>
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
INFO: task hung in input_unregister_handle

INFO: task kworker/1:2:143 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:23672 pid:  143 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 input_unregister_handle+0x128/0x290 drivers/input/input.c:2592
 joydev_disconnect+0xfb/0x150 drivers/input/joydev.c:1023
 __input_unregister_device+0x1f1/0x460 drivers/input/input.c:2238
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2428
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
1 lock held by khungtaskd/28:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
3 locks held by kworker/u4:2/41:
7 locks held by kworker/1:2/143:
 #0: ffff888011a65938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011a65938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011a65938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011a65938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011a65938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011a65938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90002b9fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff88802011d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff88802011d190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff88807b888190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff88807b888190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff88807a420118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff88807a420118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff88807a420118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffffffff8ceafca8 (input_mutex){+.+.}-{3:3}, at: __input_unregister_device+0x158/0x460 drivers/input/input.c:2235
 #6: ffff88807a4212c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_unregister_handle+0x128/0x290 drivers/input/input.c:2592
2 locks held by acpid/2962:
 #0: ffff88807a120158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff88807a120158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff88807a4212c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:726
2 locks held by getty/3288:
 #0: ffff88814b342098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
2 locks held by udevd/4098:
 #0: ffff88807a424110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open_device drivers/input/evdev.c:393 [inline]
 #0: ffff88807a424110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open+0x2f3/0x6a0 drivers/input/evdev.c:487
 #1: ffff88807a4212c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_open_device+0x4a/0x320 drivers/input/input.c:656

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
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:mark_held_locks+0xc1/0xe0 kernel/locking/lockdep.c:4239
Code: 4c 89 e7 e8 51 e6 ff ff 85 c0 74 12 83 c3 01 41 39 9c 24 58 0a 00 00 7f a9 b8 01 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e <c3> e8 c9 3f 69 00 e9 6d ff ff ff 48 89 34 24 e8 9b 3f 69 00 48 8b
RSP: 0018:ffffc90000b27998 EFLAGS: 00000092
RAX: 0000000000000001 RBX: ffff888011b19d80 RCX: 1ffffffff20d0d76
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffffff90686bb0
RBP: ffff888011b19d80 R08: 0000000000000000 R09: ffffffff9067f917
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff812c131f
R13: 0000000000000004 R14: 0000000000000aa8 R15: ffffffff8bec6480
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f22bcc110 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4252 [inline]
 lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4319 [inline]
 lockdep_hardirqs_on_prepare+0x135/0x400 kernel/locking/lockdep.c:4271
 trace_hardirqs_on+0x2d/0x120 kernel/trace/trace_preemptirq.c:49
 __text_poke+0x6df/0x8e0 arch/x86/kernel/alternative.c:1112
 text_poke arch/x86/kernel/alternative.c:1137 [inline]
 text_poke_bp_batch+0x382/0x6c0 arch/x86/kernel/alternative.c:1432
 text_poke_flush arch/x86/kernel/alternative.c:1589 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1586 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1596
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x152/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:825 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:803
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	4c 89 e7             	mov    %r12,%rdi
   3:	e8 51 e6 ff ff       	callq  0xffffe659
   8:	85 c0                	test   %eax,%eax
   a:	74 12                	je     0x1e
   c:	83 c3 01             	add    $0x1,%ebx
   f:	41 39 9c 24 58 0a 00 	cmp    %ebx,0xa58(%r12)
  16:	00
  17:	7f a9                	jg     0xffffffc2
  19:	b8 01 00 00 00       	mov    $0x1,%eax
  1e:	48 83 c4 08          	add    $0x8,%rsp
  22:	5b                   	pop    %rbx
  23:	5d                   	pop    %rbp
  24:	41 5c                	pop    %r12
  26:	41 5d                	pop    %r13
  28:	41 5e                	pop    %r14
* 2a:	c3                   	retq <-- trapping instruction
  2b:	e8 c9 3f 69 00       	callq  0x693ff9
  30:	e9 6d ff ff ff       	jmpq   0xffffffa2
  35:	48 89 34 24          	mov    %rsi,(%rsp)
  39:	e8 9b 3f 69 00       	callq  0x693fd9
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1422b968080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130ec148080000

