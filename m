Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024A45647FE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGCOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGCOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:11:12 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D52AEA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:11:11 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id n4-20020a5d8244000000b0067566682c09so4379415ioo.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 07:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SuVBGWRSkYQf0A9xjxf+XtDa6RZ3OntIa4jm2xkymS8=;
        b=pkyR875WEXN0Mjou+UDvIofanHgbU0ARCCZx74q81Ueg3AXUv1HPby1bTMzqVdOJs+
         ZV9GnIRVBYPrK6J+3PP3XUWn2OiYRL+Z4ZWgOSL6+tzf8ZvoI73Sd4mNYF5tUSM8Vl/h
         kyVRNEOBx66uHaUz1nt/oyi+5PoKSl340BwStRu+BiFTXU8AEp2kqo4SVCtDYThveoOH
         e748dkgWs9btSkhYM87zvUwsLcdaj+IDCtOTTcD4HKulDnwDuPRRdc0FXKGEeNYqqgx6
         YLWvwCKZ1fviVdziaCqbx3ju7qXmhO8SK1hsbdaLptkoXCy29kDx7JEyEadWQAqidfPc
         YfkQ==
X-Gm-Message-State: AJIora+djb3JtKTBtVbbQFSlZ1PSrF0Rusk4bbZxu3ZpwMbYz3SeiRKO
        J2/bkxoE7qB1va27r6OMvBtkwtsRuakYC4wAY8XPCfnfKHVZ
X-Google-Smtp-Source: AGRyM1ukfL1ZIxCpsKLmlRajaXCTeL5EINE9d3TNVQy3Y591VW994omTRJ2qIIBwQwx44Q8gmup/VSGrV7SgtsOcIECibcN731H7
MIME-Version: 1.0
X-Received: by 2002:a5d:9817:0:b0:65a:f20b:db2c with SMTP id
 a23-20020a5d9817000000b0065af20bdb2cmr13482398iol.118.1656857470795; Sun, 03
 Jul 2022 07:11:10 -0700 (PDT)
Date:   Sun, 03 Jul 2022 07:11:10 -0700
In-Reply-To: <20220703091039.1538-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd862105e2e730e9@google.com>
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

INFO: task kworker/0:1:14 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:24296 pid:   14 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 input_disconnect_device drivers/input/input.c:793 [inline]
 __input_unregister_device+0x24/0x470 drivers/input/input.c:2243
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2438
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
6 locks held by kworker/0:1/14:
 #0: ffff8881458a0538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881458a0538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881458a0538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8881458a0538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8881458a0538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8881458a0538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000137da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888020a04190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888020a04190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff888146de5190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff888146de5190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff888146de3118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff888146de3118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff888146de3118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffff88807df402c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_disconnect_device drivers/input/input.c:793 [inline]
 #5: ffff88807df402c0 (&dev->mutex#2){+.+.}-{3:3}, at: __input_unregister_device+0x24/0x470 drivers/input/input.c:2243
1 lock held by khungtaskd/27:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by acpid/2960:
 #0: ffff88807dcec158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff88807dcec158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff88807df402c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x44/0x220 drivers/input/input.c:733
2 locks held by getty/3285:
 #0: ffff88814b110098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
3 locks held by udevd/4093:
 #0: ffff88807e905488 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter fs/kernfs/file.c:197 [inline]
 #0: ffff88807e905488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x189/0x6e0 fs/kernfs/file.c:236
 #1: ffff88806f5b50f0 (kn->active#86){++++}-{0:0}, at: kernfs_file_read_iter fs/kernfs/file.c:198 [inline]
 #1: ffff88806f5b50f0 (kn->active#86){++++}-{0:0}, at: kernfs_fop_read_iter+0x1ac/0x6e0 fs/kernfs/file.c:236
 #2: ffff888146de5190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:840 [inline]
 #2: ffff888146de5190 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4070 Comm: syz-executor.0 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:__pvclock_read_cycles arch/x86/include/asm/pvclock.h:86 [inline]
RIP: 0010:pvclock_clocksource_read+0x91/0x530 arch/x86/kernel/pvclock.c:76
Code: 43 08 8b 0b 48 bd 00 00 00 00 00 fc ff df 48 8d 7b 1c 48 89 44 24 10 48 c1 e8 03 48 8d 53 1b 49 89 c5 48 89 f8 48 89 7c 24 18 <4c> 8d 4b 0f 48 c1 e8 03 48 89 14 24 49 01 ed 4c 8d 43 18 48 01 e8
RSP: 0018:ffffc90002fafe20 EFLAGS: 00000806
RAX: ffffffff8f2ad05c RBX: ffffffff8f2ad040 RCX: 0000000000000004
RDX: ffffffff8f2ad05b RSI: 0000000000000000 RDI: ffffffff8f2ad05c
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffffff90680917
R10: fffffbfff20d0122 R11: 0000000000000001 R12: ffffffff8f2ad043
R13: 1ffffffff1e55a09 R14: 0000000000000000 R15: ffff88801d2824a8
FS:  0000555555f7a400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555f7a708 CR3: 000000007435c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_clock_read arch/x86/kernel/kvmclock.c:79 [inline]
 kvm_sched_clock_read+0x14/0x40 arch/x86/kernel/kvmclock.c:91
 vtime_delta kernel/sched/cputime.c:637 [inline]
 get_vtime_delta kernel/sched/cputime.c:646 [inline]
 vtime_user_exit+0xbc/0x6c0 kernel/sched/cputime.c:720
 __context_tracking_exit+0xb8/0xe0 kernel/context_tracking.c:160
 user_exit_irqoff include/linux/context_tracking.h:47 [inline]
 __enter_from_user_mode kernel/entry/common.c:24 [inline]
 syscall_enter_from_user_mode+0x4c/0x70 kernel/entry/common.c:106
 do_syscall_64+0x16/0xb0 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fbe204ade31
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007fff04d571e0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000085 RCX: 00007fbe204ade31
RDX: 00007fff04d57220 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fff04d572ac R08: 0000000000000000 R09: 00007fff04dbc080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000003dbc7 R14: 0000000000000000 R15: 00007fff04d57310
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	8b 0b                	mov    (%rbx),%ecx
   2:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
   9:	fc ff df
   c:	48 8d 7b 1c          	lea    0x1c(%rbx),%rdi
  10:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  15:	48 c1 e8 03          	shr    $0x3,%rax
  19:	48 8d 53 1b          	lea    0x1b(%rbx),%rdx
  1d:	49 89 c5             	mov    %rax,%r13
  20:	48 89 f8             	mov    %rdi,%rax
  23:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
* 28:	4c 8d 4b 0f          	lea    0xf(%rbx),%r9 <-- trapping instruction
  2c:	48 c1 e8 03          	shr    $0x3,%rax
  30:	48 89 14 24          	mov    %rdx,(%rsp)
  34:	49 01 ed             	add    %rbp,%r13
  37:	4c 8d 43 18          	lea    0x18(%rbx),%r8
  3b:	48 01 e8             	add    %rbp,%rax


Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15812020080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a4c000080000

