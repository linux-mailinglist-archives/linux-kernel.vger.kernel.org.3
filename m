Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4758571961
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiGLMDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGLMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:03:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755C71135
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:03:25 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h7-20020a05660224c700b0067898a33ceaso4136996ioe.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZrJsd0fFrox0/PvknIO9sEr2xyVAGiSOxFqniQzpXlg=;
        b=Vrl76suFjYo4H3BwW3Sc9BnW302mvjD3HYNKko28jNUe0npOJ45YyjQM2lfdWvmj4I
         9vrxeu6p4ozDTtMo/MDDv7/NpLT3L+xfS4Ei1QsMhF85G1Bm+aZeM/1Mchew7nrVQXKa
         SxpxjNymS2lW/mevFNDMrpSoEvP0T9LYXrelHZmTwjz9Hc/6CgTM67lBHaKIZFH2NbLL
         Kx0sK+00owLkwrIvbjuGK2vRi4j1UqO5Q6TyXE9Zcpa48J2kpLv1HuTcWYqAExHct/2M
         cbZlYhN4b6BQZWnensltMks7ETwrAu8OHAE6tRNySHWMczQFG4VUc+fbYwRlEcA6ojG4
         yV+Q==
X-Gm-Message-State: AJIora9MwFpUQ1GSXWUMVxCafbXT7kFpIccynBdCvObXBpAaGghTYpw9
        oJ9OQmXd9XSCvD+ISdv6BCZUFynNc8W6sk2ja5NJRwvuFR4Z
X-Google-Smtp-Source: AGRyM1t1JlgFOed/QAjUSKFqRd/ScG1x/mc7ejju184ImxWNzABm/gnAEXO7U26ybP0O6jkaQi9SwEOMlyt16pJYhU/JuB8MhWlj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2242:b0:33f:34d2:9506 with SMTP id
 m2-20020a056638224200b0033f34d29506mr11947208jas.234.1657627404816; Tue, 12
 Jul 2022 05:03:24 -0700 (PDT)
Date:   Tue, 12 Jul 2022 05:03:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a256df05e39a74e7@google.com>
Subject: [syzbot] inconsistent lock state in find_vmap_area
From:   syzbot <syzbot+8d19062486784d15dda9@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8affe37c525d usb: dwc3: gadget: fix high speed multiplier ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12742d1a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebec88088cc2071
dashboard link: https://syzkaller.appspot.com/bug?extid=8d19062486784d15dda9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10357da2080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150e832a080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d19062486784d15dda9@syzkaller.appspotmail.com

 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x2f4/0x430 kernel/time/posix-timers.c:1245
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fa84b6b7f7a
================================
WARNING: inconsistent lock state
5.19.0-rc4-syzkaller-00118-g8affe37c525d #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
syz-executor629/1291 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffffffff87b82078 (vmap_area_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffffffff87b82078 (vmap_area_lock){+.?.}-{2:2}, at: find_vmap_area+0x1c/0x130 mm/vmalloc.c:1805
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5665 [inline]
  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:349 [inline]
  alloc_vmap_area+0xa49/0x1f00 mm/vmalloc.c:1586
  __get_vm_area_node+0x142/0x3f0 mm/vmalloc.c:2453
  get_vm_area_caller+0x43/0x50 mm/vmalloc.c:2506
  __ioremap_caller.constprop.0+0x292/0x600 arch/x86/mm/ioremap.c:280
  acpi_os_ioremap include/acpi/acpi_io.h:13 [inline]
  acpi_map drivers/acpi/osl.c:296 [inline]
  acpi_os_map_iomem+0x463/0x550 drivers/acpi/osl.c:355
  acpi_tb_acquire_table+0xd8/0x209 drivers/acpi/acpica/tbdata.c:142
  acpi_tb_validate_table drivers/acpi/acpica/tbdata.c:317 [inline]
  acpi_tb_validate_table+0x50/0x8c drivers/acpi/acpica/tbdata.c:308
  acpi_tb_verify_temp_table+0x84/0x674 drivers/acpi/acpica/tbdata.c:504
  acpi_reallocate_root_table+0x374/0x3e0 drivers/acpi/acpica/tbxface.c:180
  acpi_early_init+0x13a/0x438 drivers/acpi/bus.c:1200
  start_kernel+0x3cf/0x48f init/main.c:1098
  secondary_startup_64_no_verify+0xce/0xdb
irq event stamp: 283923
hardirqs last  enabled at (283922): [<ffffffff85eff66f>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (283922): [<ffffffff85eff66f>] _raw_spin_unlock_irq+0x1f/0x40 kernel/locking/spinlock.c:202
hardirqs last disabled at (283923): [<ffffffff85eff49e>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (283923): [<ffffffff85eff49e>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (268742): [<ffffffff811657c3>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (268742): [<ffffffff811657c3>] __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650
softirqs last disabled at (283919): [<ffffffff811657c3>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (283919): [<ffffffff811657c3>] __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(vmap_area_lock);
  <Interrupt>
    lock(vmap_area_lock);

 *** DEADLOCK ***

5 locks held by syz-executor629/1291:
 #0: ffffc90000178d70 ((&dum_hcd->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #0: ffffc90000178d70 ((&dum_hcd->timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
 #1: ffff88810fa80230 (&dev->event_lock){-.-.}-{2:2}, at: input_event drivers/input/input.c:456 [inline]
 #1: ffff88810fa80230 (&dev->event_lock){-.-.}-{2:2}, at: input_event+0x7b/0xb0 drivers/input/input.c:449
 #2: ffffffff87a94700 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x710 drivers/input/input.c:884
 #3: ffffffff87eb1e38 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #3: ffffffff87eb1e38 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x86/0x1780 drivers/tty/vt/keyboard.c:1537
 #4: ffffffff87a94700 (rcu_read_lock){....}-{1:2}, at: show_state_filter+0x0/0x300 kernel/sched/core.c:8763

stack backtrace:
CPU: 1 PID: 1291 Comm: syz-executor629 Not tainted 5.19.0-rc4-syzkaller-00118-g8affe37c525d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3961 [inline]
 valid_state kernel/locking/lockdep.c:3973 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
 mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
 mark_lock kernel/locking/lockdep.c:4596 [inline]
 mark_usage kernel/locking/lockdep.c:4527 [inline]
 __lock_acquire+0x11e7/0x5660 kernel/locking/lockdep.c:5007
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 find_vmap_area+0x1c/0x130 mm/vmalloc.c:1805
 check_heap_object mm/usercopy.c:176 [inline]
 __check_object_size mm/usercopy.c:250 [inline]
 __check_object_size+0x1f8/0x700 mm/usercopy.c:212
 check_object_size include/linux/thread_info.h:199 [inline]
 __copy_from_user_inatomic include/linux/uaccess.h:62 [inline]
 copy_from_user_nmi arch/x86/lib/usercopy.c:47 [inline]
 copy_from_user_nmi+0xcb/0x130 arch/x86/lib/usercopy.c:31
 copy_code arch/x86/kernel/dumpstack.c:91 [inline]
 show_opcodes+0x59/0xb0 arch/x86/kernel/dumpstack.c:121
 show_iret_regs+0xd/0x33 arch/x86/kernel/dumpstack.c:149
 __show_regs+0x1e/0x60 arch/x86/kernel/process_64.c:74
 show_trace_log_lvl+0x25b/0x2ba arch/x86/kernel/dumpstack.c:292
 sched_show_task kernel/sched/core.c:8801 [inline]
 sched_show_task+0x44c/0x5c0 kernel/sched/core.c:8775
 show_state_filter+0x13e/0x300 kernel/sched/core.c:8846
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xe1/0x130 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcdd/0x1780 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x3b9/0x4c0 drivers/input/input.c:129
 input_pass_values.part.0+0x230/0x710 drivers/input/input.c:156
 input_pass_values drivers/input/input.c:426 [inline]
 input_handle_event+0x67e/0x1440 drivers/input/input.c:426
 input_event drivers/input/input.c:457 [inline]
 input_event+0x8e/0xb0 drivers/input/input.c:449
 hidinput_hid_event+0x79d/0x2010 drivers/hid/hid-input.c:1631
 hid_process_event+0x491/0x570 drivers/hid/hid-core.c:1527
 hid_input_array_field+0x4d7/0x660 drivers/hid/hid-core.c:1639
 hid_process_report drivers/hid/hid-core.c:1681 [inline]
 hid_report_raw_event+0xa8a/0x1280 drivers/hid/hid-core.c:1998
 hid_input_report+0x360/0x4c0 drivers/hid/hid-core.c:2065
 hid_irq_in+0x50e/0x690 drivers/hid/usbhid/hid-core.c:284
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1670
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1747
 dummy_timer+0x11f9/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x679/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x288/0x9a5 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:finish_task_switch.isra.0+0x24d/0xa10 kernel/sched/core.c:5026
Code: 8b 3a 4c 89 e7 48 c7 02 00 00 00 00 ff d1 4d 85 ff 75 bf 4c 89 e7 e8 62 0d d0 04 e8 9d 6e 2b 00 fb 65 48 8b 1c 25 c0 6e 02 00 <48> 8d bb 98 14 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90000597b30 EFLAGS: 00000202
RAX: 000000000004550d RBX: ffff888110e5d580 RCX: 1ffffffff11b9ef1
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000597b78 R08: 0000000000000001 R09: 0000000000000001
R10: ffffed103ed26f68 R11: 0000000000000001 R12: ffff8881f6937b40
R13: ffff8881002cd580 R14: ffff88810029a300 R15: 0000000000000002
 context_switch kernel/sched/core.c:5149 [inline]
 __schedule+0x947/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x24e/0x690 kernel/time/hrtimer.c:2044
 hrtimer_nanosleep+0x1f9/0x4a0 kernel/time/hrtimer.c:2097
 common_nsleep+0xa2/0xc0 kernel/time/posix-timers.c:1227
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x2f4/0x430 kernel/time/posix-timers.c:1245
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fa84b6b7f7a
Code: 83 ff 03 74 3b 48 83 ec 28 b8 fa ff ff ff 83 ff 02 49 89 ca 0f 44 f8 64 8b 04 25 18 00 00 00 85 c0 75 2d b8 e6 00 00 00 0f 05 <89> c2 f7 da 3d 00 f0 ff ff b8 00 00 00 00 0f 47 c2 48 83 c4 28 c3
RSP: 002b:00007ffe8fb1bdb0 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000053a09 RCX: 00007fa84b6b7f7a
RDX: 00007ffe8fb1bdf0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000000000158 R09: 00007ffe8fba4080
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe8fb1be38
R13: 00007ffe8fb1be50 R14: 00007ffe8fb1be90 R15: 0000000000000003
 </TASK>
Code: 83 ff 03 74 3b 48 83 ec 28 b8 fa ff ff ff 83 ff 02 49 89 ca 0f 44 f8 64 8b 04 25 18 00 00 00 85 c0 75 2d b8 e6 00 00 00 0f 05 <89> c2 f7 da 3d 00 f0 ff ff b8 00 00 00 00 0f 47 c2 48 83 c4 28 c3
RSP: 002b:00007ffe8fb1bdb0 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000053a09 RCX: 00007fa84b6b7f7a
RDX: 00007ffe8fb1bdf0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000000000158 R09: 00007ffe8fba4080
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe8fb1be38
R13: 00007ffe8fb1be50 R14: 00007ffe8fb1be90 R15: 0000000000000003
 </TASK>
task:kworker/1:2     state:I stack:29984 pid: 1743 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_power_efficient)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:0     state:I stack:29672 pid: 1746 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:3     state:I stack:29800 pid: 1748 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:udevd           state:S stack:28160 pid: 1754 ppid:  1182 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 ep_poll fs/eventpoll.c:1856 [inline]
 do_epoll_wait+0x1290/0x1930 fs/eventpoll.c:2234
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6d14bdee46
RSP: 002b:00007ffe547bfe18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6d14bdee46
RDX: 0000000000000004 RSI: 00007ffe547bfe58 RDI: 0000000000000004
RBP: 00005558e52cc540 R08: 0000000000000007 R09: 00005558e52af720
R10: 00000000ffffffff R11: 0000000000000246 R12: 00005558e52b95f0
R13: 00007ffe547bfe58 R14: 00000000ffffffff R15: 00005558e5295910
 </TASK>
task:syz-executor629 state:S stack:28168 pid: 1755 ppid:  1291 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x378/0x530 kernel/sched/completion.c:106
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion_interruptible+0x1b/0x30 kernel/sched/completion.c:206
 raw_process_ep_io+0x5ec/0xb20 drivers/usb/gadget/legacy/raw_gadget.c:1071
 raw_ioctl_ep_write drivers/usb/gadget/legacy/raw_gadget.c:1099 [inline]
 raw_ioctl+0x955/0x2780 drivers/usb/gadget/legacy/raw_gadget.c:1271
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fa84b685d37
RSP: 002b:00007ffe8fb1adc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa84b685d37
RDX: 00007ffe8fb1ade0 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 00007fa84b6fb1e0 R11: 0000000000000246 R12: 00007ffe8fb1be38
R13: 00007ffe8fb1be50 R14: 00007ffe8fb1be90 R15: 0000000000000003
 </TASK>
task:udevd           state:S stack:27992 pid: 1756 ppid:  1182 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 ep_poll fs/eventpoll.c:1856 [inline]
 do_epoll_wait+0x1290/0x1930 fs/eventpoll.c:2234
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6d14bdee46
RSP: 002b:00007ffe547bfe18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6d14bdee46
RDX: 0000000000000004 RSI: 00007ffe547bfe58 RDI: 0000000000000004
RBP: 00005558e52c6770 R08: 0000000000000007 R09: 00005558e52b9280
R10: 00000000ffffffff R11: 0000000000000246 R12: 00005558e52d52a0
R13: 00007ffe547bfe58 R14: 00000000ffffffff R15: 00005558e5295910
 </TASK>
task:udevd           state:S stack:28440 pid: 1757 ppid:  1182 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 ep_poll fs/eventpoll.c:1856 [inline]
 do_epoll_wait+0x1290/0x1930 fs/eventpoll.c:2234
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6d14bdee46
RSP: 002b:00007ffe547bfe18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6d14bdee46
RDX: 0000000000000004 RSI: 00007ffe547bfe58 RDI: 0000000000000004
RBP: 00005558e52ab290 R08: 0000000000000007 R09: 00005558e52af720
R10: 00000000ffffffff R11: 0000000000000246 R12: 00005558e52be430
R13: 00007ffe547bfe58 R14: 00000000ffffffff R15: 00005558e5295910
 </TASK>
task:udevd           state:S stack:28328 pid: 1758 ppid:  1182 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 ep_poll fs/eventpoll.c:1856 [inline]
 do_epoll_wait+0x1290/0x1930 fs/eventpoll.c:2234
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6d14bdee46
RSP: 002b:00007ffe547bfe18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6d14bdee46
RDX: 0000000000000004 RSI: 00007ffe547bfe58 RDI: 0000000000000004
RBP: 00005558e52c8e80 R08: 0000000000000007 R09: 00005558e52af720
R10: 00000000ffffffff R11: 0000000000000246 R12: 00005558e52c0e40
R13: 00007ffe547bfe58 R14: 00000000ffffffff R15: 00005558e5295910
 </TASK>
INFO: lockdep is turned off.
task:init            state:S stack:22824 pid:    1 ppid:     0 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 freezable_schedule_hrtimeout_range include/linux/freezer.h:250 [inline]
 do_sigtimedwait+0x48d/0x7b0 kernel/signal.c:3604
 __do_sys_rt_sigtimedwait kernel/signal.c:3648 [inline]
 __se_sys_rt_sigtimedwait kernel/signal.c:3626 [inline]
 __x64_sys_rt_sigtimedwait+0x1a2/0x2c0 kernel/signal.c:3626
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f2ea7f62ac4
RSP: 002b:00007ffcb0447100 EFLAGS: 00000246 ORIG_RAX: 0000000000000080
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2ea7f62ac4
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f2ea81ab498
RBP: 00007f2ea81ab490 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffcb0447168
R13: 00007ffcb044715c R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:kthreadd        state:S stack:28152 pid:    2 ppid:     0 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 kthreadd+0x592/0x750 kernel/kthread.c:733
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:rcu_gp          state:I stack:29904 pid:    3 ppid:     2 flags:0x00004000
Workqueue:  0x0 (rcu_gp)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:rcu_par_gp      state:I stack:30920 pid:    4 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:netns           state:I stack:30920 pid:    5 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:0H    state:I stack:29672 pid:    7 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:1H    state:I stack:27816 pid:    9 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:mm_percpu_wq    state:I stack:30920 pid:   10 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:rcu_tasks_kthre state:I stack:28992 pid:   11 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rcu_tasks_kthread+0x462/0xb40 kernel/rcu/tasks.h:520
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:1     state:I stack:29408 pid:   12 ppid:     2 flags:0x00004000
Workqueue:  0x0 (rcu_gp)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:ksoftirqd/0     state:S stack:25200 pid:   13 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:rcu_preempt     state:I stack:29528 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rcu_gp_kthread+0x1d4/0x250 kernel/rcu/tree.c:2171
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:migration/0     state:S stack:30376 pid:   15 ppid:     2 flags:0x00004000
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:cpuhp/0         state:S stack:27920 pid:   16 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:cpuhp/1         state:S stack:27936 pid:   17 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:migration/1     state:S stack:30536 pid:   18 ppid:     2 flags:0x00004000
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:ksoftirqd/1     state:S stack:25488 pid:   19 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:0     state:I stack:29592 pid:   20 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:0H    state:I stack:28952 pid:   21 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kdevtmpfs       state:S stack:27808 pid:   22 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 devtmpfs_work_loop drivers/base/devtmpfs.c:415 [inline]
 devtmpfsd+0x286/0x2a3 drivers/base/devtmpfs.c:448
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:inet_frag_wq    state:I stack:30328 pid:   23 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:1     state:R  running task     stack:20672 pid:   24 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kauditd         state:S stack:30008 pid:   25 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 freezable_schedule include/linux/freezer.h:172 [inline]
 kauditd_thread+0x5f8/0xba0 kernel/audit.c:903
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:khungtaskd      state:S stack:30576 pid:   26 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1935
 watchdog+0xf9/0xf50 kernel/hung_task.c:373
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:oom_reaper      state:S stack:30320 pid:   27 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 freezable_schedule include/linux/freezer.h:172 [inline]
 oom_reaper+0xa66/0xd90 mm/oom_kill.c:646
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:1    state:I stack:25632 pid:   28 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:writeback       state:I stack:30112 pid:   29 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kcompactd0      state:S stack:29864 pid:   30 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1935
 freezable_schedule_timeout include/linux/freezer.h:192 [inline]
 kcompactd+0xa10/0xeb0 mm/compaction.c:2950
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kblockd         state:I stack:30112 pid:   31 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:blkcg_punt_bio  state:I stack:30920 pid:   32 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:tpm_dev_wq      state:I stack:30632 pid:   33 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:ata_sff         state:I stack:30328 pid:   34 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:md              state:I stack:30272 pid:   35 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:edac-poller     state:I stack:30632 pid:   36 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:1H    state:I stack:28368 pid:   37 ppid:     2 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:rpciod          state:I stack:30112 pid:   38 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:xprtiod         state:I stack:30920 pid:   39 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:cfg80211        state:I stack:30920 pid:   40 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kswapd0         state:S stack:30336 pid:   65 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 kswapd_try_to_sleep mm/vmscan.c:4382 [inline]
 kswapd+0xd39/0xf80 mm/vmscan.c:4444
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:nfsiod          state:I stack:30328 pid:   67 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:2     state:I stack:22480 pid:   71 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:acpi_thermal_pm state:I stack:30328 pid:  102 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:hwrng           state:S stack:30048 pid:  149 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1935
 add_hwgenerator_randomness+0x81/0xe0 drivers/char/random.c:856
 hwrng_fillfn+0x278/0x370 drivers/char/hw_random/core.c:529
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:scsi_eh_0       state:S stack:30352 pid:  193 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 scsi_error_handler+0x523/0xe30 drivers/scsi/scsi_error.c:2251
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:scsi_tmf_0      state:I stack:30632 pid:  194 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:target_completi state:I stack:30328 pid:  219 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:target_submissi state:I stack:30632 pid:  220 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:xcopy_wq        state:I stack:30328 pid:  221 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:libertastf      state:I stack:30632 pid:  289 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:zd1211rw        state:I stack:30328 pid:  308 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:u132            state:I stack:30392 pid:  372 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:uas             state:I stack:30328 pid:  384 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:usbip_event     state:I stack:30328 pid:  677 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:pvrusb2-context state:S stack:30584 pid:  886 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 pvr2_context_thread_func+0x5de/0x850 drivers/media/usb/pvrusb2/pvrusb2-context.c:160
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:3    state:I stack:23408 pid:  898 ppid:     2 flags:0x00004000
Workqueue:  0x0 (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kvub300c        state:I stack:30328 pid:  930 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kvub300p        state:I stack:30328 pid:  931 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kvub300d        state:I stack:30632 pid:  932 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kmemstick       state:I stack:30112 pid:  936 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:elousb          state:I stack:30920 pid:  945 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:4    state:I stack:25144 pid: 1030 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:mld             state:I stack:30632 pid: 1097 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:ipv6_addrconf   state:I stack:30912 pid: 1098 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:jbd2/sda1-8     state:D stack:27344 pid: 1146 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 io_schedule+0xba/0x130 kernel/sched/core.c:8645
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x60/0x190 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xd5/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer+0x7a/0x90 fs/buffer.c:122
 wait_on_buffer include/linux/buffer_head.h:355 [inline]
 jbd2_journal_commit_transaction+0x38e5/0x6aa0 fs/jbd2/commit.c:849
 kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:ext4-rsv-conver state:I stack:30632 pid: 1147 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:syslogd         state:S stack:26424 pid: 1164 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 __skb_wait_for_more_packets+0x35b/0x5e0 net/core/datagram.c:120
 __unix_dgram_recvmsg+0x202/0xb90 net/unix/af_unix.c:2403
 sock_recvmsg_nosec net/socket.c:995 [inline]
 sock_recvmsg net/socket.c:1013 [inline]
 sock_recvmsg net/socket.c:1009 [inline]
 sock_read_iter+0x337/0x470 net/socket.c:1086
 call_read_iter include/linux/fs.h:2052 [inline]
 new_sync_read+0x4f9/0x5f0 fs/read_write.c:401
 vfs_read+0x492/0x5d0 fs/read_write.c:482
 ksys_read+0x1e8/0x250 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f51280c08fe
RSP: 002b:00007fff6ace0658 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f51280c08fe
RDX: 00000000000000ff RSI: 0000563be7f15950 RDI: 0000000000000000
RBP: 0000563be7f15910 R08: 00007f5128150040 R09: 00007f51281500c0
R10: 00007f512814ffc0 R11: 0000000000000246 R12: 0000563be7f159f2
R13: 0000563be7f15950 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:acpid           state:S stack:24392 pid: 1167 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x93f/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 poll_schedule_timeout.constprop.0+0xb9/0x190 fs/select.c:244
 do_select+0x11a1/0x16a0 fs/select.c:607
----------------
Code disassembly (best guess):
   0:	8b 3a                	mov    (%rdx),%edi
   2:	4c 89 e7             	mov    %r12,%rdi
   5:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
   c:	ff d1                	callq  *%rcx
   e:	4d 85 ff             	test   %r15,%r15
  11:	75 bf                	jne    0xffffffd2
  13:	4c 89 e7             	mov    %r12,%rdi
  16:	e8 62 0d d0 04       	callq  0x4d00d7d
  1b:	e8 9d 6e 2b 00       	callq  0x2b6ebd
  20:	fb                   	sti
  21:	65 48 8b 1c 25 c0 6e 	mov    %gs:0x26ec0,%rbx
  28:	02 00
* 2a:	48 8d bb 98 14 00 00 	lea    0x1498(%rbx),%rdi <-- trapping instruction
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df
  3b:	48 89 fa             	mov    %rdi,%rdx
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
