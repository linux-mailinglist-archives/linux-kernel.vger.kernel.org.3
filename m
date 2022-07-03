Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B765645D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiGCIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiGCIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:32:12 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7219588
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:32:10 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id x4-20020a6bd004000000b00675354ad495so4159843ioa.20
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 01:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XVaO9X0NKKbr9GQG5EuBkNmkmEXETTj1J29eHJcagS4=;
        b=p835c4u4jhmxQXIDmati/354v6CqiNoLbFeTCvAskGWxFoQAUA9nXqJbvv7imV5wiW
         jUnJKq/l/SbzNbYbTTE8z/IcVWdQxRemBfalcjDWHpIkBsa1TDxtFHm+5ra2/PAcoTwS
         4HnTMu/z0ncgGFx/VIofSklQoHQ7mqvGl1CR4aJe7NZMpU7R5O7fhrKylYRQfyHyvjV7
         LZD8iRQX8xn8pEW3mVevkZVjVn/QD61CvsyIPO7r5qitlXxcNzsGcZBIyEcQ9Kzdl7aa
         pD/pnfiO8vUvipdYYhhejuCArY9pORwnR3xWeyPsoYpxfzr5Hpxen0G1yh6PMBFRMyA+
         8iPA==
X-Gm-Message-State: AJIora+agcesTiVBZ5imv2Z7FgqRjMcz45mJi3O7oDeMkyX/7iyckSuT
        BkElIIJPlRnQuqCMnRRgb7b/rN7PJ3ZpQS8IKibqcvokMMV9
X-Google-Smtp-Source: AGRyM1sBaSSeA+NBqy3RR/PY9c7D5QIjmqx3KERBZFZxq6MoRmi/zFvqRtO6Z3gh9dEd3PUiS8L6muwJxsuwXvq37y0UjD5RO7Jy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f95:b0:314:58f9:5896 with SMTP id
 h21-20020a0566380f9500b0031458f95896mr14042141jal.228.1656837130041; Sun, 03
 Jul 2022 01:32:10 -0700 (PDT)
Date:   Sun, 03 Jul 2022 01:32:10 -0700
In-Reply-To: <20220703081120.1414-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000963efe05e2e2747a@google.com>
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

INFO: task kworker/1:4:3628 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:22768 pid: 3628 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 input_disconnect_device drivers/input/input.c:788 [inline]
 __input_unregister_device+0x24/0x470 drivers/input/input.c:2238
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2433
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
5 locks held by kworker/u4:3/51:
2 locks held by kworker/u4:5/1185:
 #0: ffff8880b9a39ed8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
 #1: ffff8880b9a277c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3e7/0x4e0 kernel/sched/psi.c:889
2 locks held by acpid/2962:
 #0: ffff88807d7e0158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_close_device drivers/input/joydev.c:220 [inline]
 #0: ffff88807d7e0158 (&joydev->mutex){+.+.}-{3:3}, at: joydev_release+0x187/0x290 drivers/input/joydev.c:252
 #1: ffff88802127a2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_close_device+0x42/0x200 drivers/input/input.c:728
2 locks held by getty/3287:
 #0: ffff88814aa77098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
6 locks held by kworker/1:4/3628:
 #0: ffff88801723f538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801723f538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801723f538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88801723f538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88801723f538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88801723f538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000308fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888147a84190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #2: ffff888147a84190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5691
 #3: ffff888021278190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff888021278190 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
 #4: ffff888021279118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #4: ffff888021279118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
 #4: ffff888021279118 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
 #5: ffff88802127a2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_disconnect_device drivers/input/input.c:788 [inline]
 #5: ffff88802127a2c0 (&dev->mutex#2){+.+.}-{3:3}, at: __input_unregister_device+0x24/0x470 drivers/input/input.c:2238
2 locks held by udevd/4068:
 #0: ffff88802127d110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open_device drivers/input/evdev.c:393 [inline]
 #0: ffff88802127d110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_open+0x2f3/0x6a0 drivers/input/evdev.c:487
 #1: ffff88802127a2c0 (&dev->mutex#2){+.+.}-{3:3}, at: input_open_device+0x4a/0x320 drivers/input/input.c:656

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
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc4-syzkaller-00125-ga175eca0f3d7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:__mod_timer+0x386/0xe30 kernel/time/timer.c:1072
Code: c0 74 09 3c 03 7f 05 e8 58 f7 5c 00 8b 5d 20 44 89 ff c1 eb 16 89 de e8 b8 2e 10 00 41 39 df 0f 85 fd 00 00 00 e9 1f 08 00 00 <e8> e5 32 10 00 48 89 ef 48 8d 74 24 60 e8 58 78 ff ff 48 c7 c2 00
RSP: 0018:ffffc90000007b98 EFLAGS: 00000002
RAX: 0000000000000000 RBX: 0000000000000004 RCX: ffffffff816a30fa
RDX: ffffffff8babc940 RSI: 0000000000000100 RDI: 0000000000000005
RBP: ffffffff91283ce0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000001 R12: 00000000ffffffff
R13: 1ffff92000000fa8 R14: 00000000002000f1 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3644ba0000 CR3: 0000000025674000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 dsp_cmx_send+0xbf3/0x1580 drivers/isdn/mISDN/dsp_cmx.c:1850
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x679/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:112 [inline]
RIP: 0010:acpi_idle_do_entry+0x1c9/0x240 drivers/acpi/processor_idle.c:554
Code: 89 de e8 8a 08 00 f8 84 db 75 98 e8 81 0c 00 f8 e8 ac 5a 06 f8 66 90 e8 75 0c 00 f8 0f 00 2d be b8 b9 00 e8 69 0c 00 f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 b4 08 00 f8 48 85 db
RSP: 0018:ffffffff8ba07d38 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8babc940 RSI: ffffffff897a5a47 RDI: 0000000000000000
RBP: ffff888017258864 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888017258800 R14: ffff888017258864 R15: ffff888145c9c804
 acpi_idle_enter+0x369/0x510 drivers/acpi/processor_idle.c:691
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 rest_init+0x169/0x270 init/main.c:726
 arch_call_rest_init+0xf/0x14 init/main.c:882
 start_kernel+0x46e/0x48f init/main.c:1137
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
----------------
Code disassembly (best guess):
   0:	c0 74 09 3c 03       	shlb   $0x3,0x3c(%rcx,%rcx,1)
   5:	7f 05                	jg     0xc
   7:	e8 58 f7 5c 00       	callq  0x5cf764
   c:	8b 5d 20             	mov    0x20(%rbp),%ebx
   f:	44 89 ff             	mov    %r15d,%edi
  12:	c1 eb 16             	shr    $0x16,%ebx
  15:	89 de                	mov    %ebx,%esi
  17:	e8 b8 2e 10 00       	callq  0x102ed4
  1c:	41 39 df             	cmp    %ebx,%r15d
  1f:	0f 85 fd 00 00 00    	jne    0x122
  25:	e9 1f 08 00 00       	jmpq   0x849
* 2a:	e8 e5 32 10 00       	callq  0x103314 <-- trapping instruction
  2f:	48 89 ef             	mov    %rbp,%rdi
  32:	48 8d 74 24 60       	lea    0x60(%rsp),%rsi
  37:	e8 58 78 ff ff       	callq  0xffff7894
  3c:	48                   	rex.W
  3d:	c7                   	.byte 0xc7
  3e:	c2                   	.byte 0xc2


Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135ba7fff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1272e084080000

