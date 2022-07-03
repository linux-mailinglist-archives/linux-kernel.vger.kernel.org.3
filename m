Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A935645AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiGCH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGCH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:57:10 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E864DE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:57:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id t2-20020a6b0902000000b006753087a104so4085924ioi.18
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 00:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XNk7KaAgGZNZjQSlUNOXiBJGfKZ2ePbtkbOfWuUvOm8=;
        b=pBNkgHcGEZDaB4fHuCOZ2isCH/DMIb4QjOD1jj/YorbbmZb9m70A18XC0dj/PsYSv3
         ve/RrWD+hrbvqp+ttWfrSorBYSFaaIwY2eluICdJIQLQMOffxdgBEmAyIKuqE6yB66sw
         qTmHCJbDopv0S7K5xy3ONf7+/m6sdPHaiWLp4AVbMiAC1M4iPCTPwMjJSILRDlj4FHTC
         iQDnXjMFnalt4REPSejN6Bn4BsP/t3wvxhezIHDujXMcCMaXGr7mgYr6bdo8QEr3entN
         OqtYZswECOwbO5WoviTOVxT0iF031J2O0namDeAEmBhRGzRlIYQMekasy6XICdPt3ssU
         AQag==
X-Gm-Message-State: AJIora9D54kEk7TdCDqoCKnrwovzYG6MVJ+uZPztKdEoqihzGXOFYvit
        KA/dlKgSikUS8OQInFcVLs85TM3BKnsL79siKs/b/LOCO2LB
X-Google-Smtp-Source: AGRyM1uDjwmbwySNeMGT8AAW0uyk+sGGu5ZAyMXzMryVE/mzryP9+5KtHM22S9zdFJnYypoCu1nkTS0ZF6gV5FKQTBx0+lYL0cvh
MIME-Version: 1.0
X-Received: by 2002:a92:cdaf:0:b0:2da:a7ed:69e with SMTP id
 g15-20020a92cdaf000000b002daa7ed069emr13565784ild.56.1656835029083; Sun, 03
 Jul 2022 00:57:09 -0700 (PDT)
Date:   Sun, 03 Jul 2022 00:57:09 -0700
In-Reply-To: <20220703073138.1297-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c2ba205e2e1f7d0@google.com>
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

INFO: task kworker/0:2:142 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:24456 pid:  142 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 input_disconnect_device drivers/input/input.c:785 [inline]
 __input_unregister_device+0x24/0x470 drivers/input/input.c:2235
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2430
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
6 locks held by kworker/0:2/142:
 #0: ffff88801741b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801741b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801741b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88801741b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88801741b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88801741b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc900029bfda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888147aaf190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888147aaf190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff88814713f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff88814713f190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff888147139118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff888147139118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff888147139118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffff8881471382c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_disconnect_device drivers/input/input.c:785 [inline]
 #5: ffff8881471382c0 (&dev->mutex#2){+.+.}-{3:3}, at: __input_unregister_device+0x24/0x470 drivers/input/input.c:2235
2 locks held by syslogd/2958:
 #0: ffff8880b9b39ed8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
 #1: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: inode_lock include/linux/fs.h:741 [inline]
 #1: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: generic_file_write_iter+0x8a/0x220 mm/filemap.c:3936
2 locks held by acpid/2961:
 #0: ffff888076e50158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff888076e50158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff8881471382c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x1f0 drivers/input/input.c:727
2 locks held by getty/3289:
 #0: ffff88807ee70098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
2 locks held by udevd/4091:
 #0: ffff88814ae63110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open_device drivers/input/evdev.c:393 [inline]
 #0: ffff88814ae63110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open+0x2f3/0x6a0 drivers/input/evdev.c:487
 #1: ffff8881471382c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_open_device+0x4a/0x320 drivers/input/input.c:656

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
CPU: 0 PID: 8 Comm: kworker/u4:0 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: bat_events batadv_purge_orig
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:__local_bh_enable_ip+0x5d/0x120 kernel/softirq.c:378
Code: 03 83 c0 03 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 c5 00 00 00 8b 05 ff 76 73 0c 85 c0 74 0b 65 8b 05 f0 2a ba 7e 85 c0 74 53 9c <58> fa f6 c4 02 75 5a 65 8b 05 15 21 ba 7e 25 00 ff 00 00 3d 00 02
RSP: 0018:ffffc900000d7bd0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000201 RCX: 1ffffffff1b778a1
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff891218b7
RBP: ffffffff891218b7 R08: 0000000000000000 R09: ffff8880703e0783
R10: ffffed100e07c0f0 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc900000d7da8 R14: ffff8880119b7900 R15: 000000000000001e
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc54d501110 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:394 [inline]
 batadv_purge_orig_ref+0xeb7/0x1550 net/batman-adv/originator.c:1259
 batadv_purge_orig+0x17/0x60 net/batman-adv/originator.c:1272
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 83 c0 03 0f b6    	add    -0x49f0fc40(%rbx),%eax
   6:	14 11                	adc    $0x11,%al
   8:	38 d0                	cmp    %dl,%al
   a:	7c 08                	jl     0x14
   c:	84 d2                	test   %dl,%dl
   e:	0f 85 c5 00 00 00    	jne    0xd9
  14:	8b 05 ff 76 73 0c    	mov    0xc7376ff(%rip),%eax        # 0xc737719
  1a:	85 c0                	test   %eax,%eax
  1c:	74 0b                	je     0x29
  1e:	65 8b 05 f0 2a ba 7e 	mov    %gs:0x7eba2af0(%rip),%eax        # 0x7eba2b15
  25:	85 c0                	test   %eax,%eax
  27:	74 53                	je     0x7c
  29:	9c                   	pushfq
* 2a:	58                   	pop    %rax <-- trapping instruction
  2b:	fa                   	cli
  2c:	f6 c4 02             	test   $0x2,%ah
  2f:	75 5a                	jne    0x8b
  31:	65 8b 05 15 21 ba 7e 	mov    %gs:0x7eba2115(%rip),%eax        # 0x7eba214d
  38:	25 00 ff 00 00       	and    $0xff00,%eax
  3d:	3d                   	.byte 0x3d
  3e:	00 02                	add    %al,(%rdx)


Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c88434080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ed9168080000

