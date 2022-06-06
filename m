Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781B653ECEC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiFFRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFFRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:18:44 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBF4B1C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:17:35 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso12023473ilo.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 10:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3cT+cYc6eIdA/PYlt6YsLnsMLiBQB8PPWS9hMkrBX+4=;
        b=GpDz0TXVkvsitEKWKjhMOv1InG7tmsFa/imWM0CdPlkRhXngAgz4kniEAGi9IpnfEm
         ypkiakYb09ZHOjNyOk00QXfYhB5fwzTiUHQjMwsEUjqjKMbxIJ4hUFrdzxbyFrAx1wxS
         +FtPq8CInDSCct9aFuVKIn0nTOhzUbqww39J0AzJyguzfldEB/nx4FMiATL5IUuKNmjQ
         3AUoaio/M80y9qX6Vb8T7OHg6kxGByMKSL4Ie/XqLYRz6OJiegPHaW3GcX9pzQC5BsHR
         PKhT0MmulBrXzAohTePKsbjHZcJ11AFVQH1U9tPW5C64BHekZiuxn5MRGoOyjTzVqcb2
         ii+w==
X-Gm-Message-State: AOAM531QkOcou+JiReYoCoPg+OQkU52uEbU+7b4mzYKSXCW85TEPPLQJ
        JMQqynRZuEQfRvIN6kcW+4Z1GaoCV1YrB2owr2ZtlklpTV5R
X-Google-Smtp-Source: ABdhPJzwmykMTCGRv5Ck+oRbXcMGqoy3Uh/aRbeP9qssJhCJ5SeD25LNTxxUtxPdXxR6M6ctnDwwE0uI4BghzSW20VwvDBAVw4Dq
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d1:b0:669:734a:4c8a with SMTP id
 g17-20020a05660226d100b00669734a4c8amr256730ioo.209.1654535854427; Mon, 06
 Jun 2022 10:17:34 -0700 (PDT)
Date:   Mon, 06 Jun 2022 10:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df245205e0caa518@google.com>
Subject: [syzbot] inconsistent lock state in find_vm_area
From:   syzbot <syzbot+5e0952b70fe7b7876ee7@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    44688ffd111a Merge tag 'objtool-urgent-2022-06-05' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b46a4ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531d663674a4b5d1
dashboard link: https://syzkaller.appspot.com/bug?extid=5e0952b70fe7b7876ee7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e0952b70fe7b7876ee7@syzkaller.appspotmail.com

 ksys_read+0x127/0x250 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d258fe
================================
WARNING: inconsistent lock state
5.18.0-syzkaller-13918-g44688ffd111a #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
udevd/3649 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffffffff8beb88d8 (vmap_area_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffffffff8beb88d8 (vmap_area_lock){+.?.}-{2:2}, at: find_vmap_area mm/vmalloc.c:1805 [inline]
ffffffff8beb88d8 (vmap_area_lock){+.?.}-{2:2}, at: find_vm_area+0x1c/0x190 mm/vmalloc.c:2525
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
irq event stamp: 1207211
hardirqs last  enabled at (1207210): [<ffffffff897a10ef>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (1207210): [<ffffffff897a10ef>] _raw_spin_unlock_irq+0x1f/0x40 kernel/locking/spinlock.c:202
hardirqs last disabled at (1207211): [<ffffffff897a0f1e>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1207211): [<ffffffff897a0f1e>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (1202390): [<ffffffff81484a93>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (1202390): [<ffffffff81484a93>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (1207195): [<ffffffff81484a93>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (1207195): [<ffffffff81484a93>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(vmap_area_lock);
  <Interrupt>
    lock(vmap_area_lock);

 *** DEADLOCK ***

7 locks held by udevd/3649:
 #0: ffff88801c7a6c30 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xdf/0x1280 fs/seq_file.c:182
 #1: ffff888022e2a488 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x47/0x440 fs/kernfs/file.c:111
 #2: ffffc900001f0d70 ((&dum_hcd->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #2: ffffc900001f0d70 ((&dum_hcd->timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
 #3: ffff8880173f5230 (&dev->event_lock#2){-.-.}-{2:2}, at: input_event drivers/input/input.c:456 [inline]
 #3: ffff8880173f5230 (&dev->event_lock#2){-.-.}-{2:2}, at: input_event+0x7b/0xb0 drivers/input/input.c:449
 #4: ffffffff8bd86be0 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x710 drivers/input/input.c:884
 #5: ffffffff8c802f78 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #5: ffffffff8c802f78 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x86/0x1780 drivers/tty/vt/keyboard.c:1537
 #6: ffffffff8bd86be0 (rcu_read_lock){....}-{1:2}, at: show_state_filter+0x0/0x300 kernel/sched/core.c:8733

stack backtrace:
CPU: 1 PID: 3649 Comm: udevd Not tainted 5.18.0-syzkaller-13918-g44688ffd111a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
 find_vmap_area mm/vmalloc.c:1805 [inline]
 find_vm_area+0x1c/0x190 mm/vmalloc.c:2525
 check_heap_object mm/usercopy.c:176 [inline]
 __check_object_size mm/usercopy.c:252 [inline]
 __check_object_size+0x1fb/0x7a0 mm/usercopy.c:214
 check_object_size include/linux/thread_info.h:199 [inline]
 __copy_from_user_inatomic include/linux/uaccess.h:62 [inline]
 copy_from_user_nmi arch/x86/lib/usercopy.c:47 [inline]
 copy_from_user_nmi+0xcb/0x130 arch/x86/lib/usercopy.c:31
 copy_code arch/x86/kernel/dumpstack.c:91 [inline]
 show_opcodes+0x59/0xb0 arch/x86/kernel/dumpstack.c:121
 show_iret_regs+0xd/0x33 arch/x86/kernel/dumpstack.c:149
 __show_regs+0x1e/0x60 arch/x86/kernel/process_64.c:74
 show_trace_log_lvl+0x25b/0x2ba arch/x86/kernel/dumpstack.c:292
 sched_show_task kernel/sched/core.c:8771 [inline]
 sched_show_task+0x44c/0x5c0 kernel/sched/core.c:8745
 show_state_filter+0x13e/0x300 kernel/sched/core.c:8816
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
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:check_preemption_disabled+0x2/0x170 lib/smp_processor_id.c:13
Code: 1f 44 00 00 e8 5f 83 29 f8 65 48 8b 3c 25 80 6f 02 00 e8 41 48 e3 f7 eb 99 0f 1f 44 00 00 0f 0b e9 23 ff ff ff cc cc cc 41 56 <41> 55 49 89 f5 41 54 55 48 89 fd 53 0f 1f 44 00 00 65 44 8b 25 d5
RSP: 0018:ffffc900030ffa20 EFLAGS: 00000282
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff815e5601
RDX: 0000000000000001 RSI: ffffffff8a284e80 RDI: ffffffff8a284ec0
RBP: 1ffff9200061ff4d R08: 0000000000000000 R09: ffffffff8dbb7957
R10: fffffbfff1b76f2a R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff89df6100 R14: ffff888022e2a420 R15: ffffffff89df6100
 rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1185 [inline]
 rcu_lockdep_current_cpu_online+0x2d/0x140 kernel/rcu/tree.c:1177
 rcu_read_lock_held_common kernel/rcu/update.c:112 [inline]
 rcu_read_lock_held_common kernel/rcu/update.c:102 [inline]
 rcu_read_lock_sched_held+0x25/0x70 kernel/rcu/update.c:123
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x560/0x780 kernel/locking/lockdep.c:5676
 __mutex_unlock_slowpath+0x99/0x5e0 kernel/locking/mutex.c:907
 seq_read_iter+0xd19/0x1280 fs/seq_file.c:280
 kernfs_fop_read_iter+0x506/0x6e0 fs/kernfs/file.c:235
 call_read_iter include/linux/fs.h:2052 [inline]
 new_sync_read+0x384/0x5f0 fs/read_write.c:401
 vfs_read+0x492/0x5d0 fs/read_write.c:482
 ksys_read+0x127/0x250 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d258fe
Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe4d58fa18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056132fef0190 RCX: 00007f9366d258fe
RDX: 0000000000001000 RSI: 00007ffe4d58feb8 RDI: 0000000000000008
RBP: 000056132fcd4e73 R08: 000056132fcd4e73 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 000056132fef0280 R14: 00007ffe4d58feb8 R15: 000056132fedebe0
 </TASK>
Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffe4d58fa18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056132fef0190 RCX: 00007f9366d258fe
RDX: 0000000000001000 RSI: 00007ffe4d58feb8 RDI: 0000000000000008
RBP: 000056132fcd4e73 R08: 000056132fcd4e73 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 000056132fef0280 R14: 00007ffe4d58feb8 R15: 000056132fedebe0
 </TASK>
task:udevd           state:R  running task     stack:26304 pid: 3650 ppid:  2978 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:6736
 irqentry_exit+0x31/0x80 kernel/entry/common.c:428
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x1ef/0x570 kernel/locking/lockdep.c:5633
Code: 1a a4 7e 83 f8 01 0f 85 e8 02 00 00 9c 58 f6 c4 02 0f 85 fb 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc9000315f548 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200062beab RCX: e9dea97a144a6d3b
RDX: 1ffff110030b7c5b RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff9067b8c7
R10: fffffbfff20cf718 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8bd86be0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:269 [inline]
 rcu_read_lock include/linux/rcupdate.h:695 [inline]
 is_bpf_text_address+0x36/0x170 kernel/bpf/core.c:714
 kernel_text_address kernel/extable.c:125 [inline]
 kernel_text_address+0x39/0x80 kernel/extable.c:94
 __kernel_text_address+0x9/0x30 kernel/extable.c:79
 unwind_get_return_address arch/x86/kernel/unwind_orc.c:318 [inline]
 unwind_get_return_address+0x51/0x90 arch/x86/kernel/unwind_orc.c:313
 arch_stack_walk+0x93/0xe0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 lsm_file_alloc security/security.c:573 [inline]
 security_file_alloc+0x34/0x170 security/security.c:1526
 __alloc_file+0xd9/0x270 fs/file_table.c:143
 alloc_empty_file+0x6d/0x170 fs/file_table.c:187
 path_openat+0xe4/0x2910 fs/namei.c:3639
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d25697
RSP: 002b:00007ffe4d591120 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000056132fed18f0 RCX: 00007f9366d25697
RDX: 0000000000080000 RSI: 000056132fee18d0 RDI: 00000000ffffff9c
RBP: 000056132fee18d0 R08: 000056132fee18d0 R09: 00007f9366df5a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000000000000700 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:kworker/u5:4    state:I stack:26408 pid: 3651 ppid:     2 flags:0x00004000
Workqueue:  0x0 (hci5)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u5:5    state:I stack:28600 pid: 3652 ppid:     2 flags:0x00004000
Workqueue:  0x0 (hci0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u5:6    state:I stack:29200 pid: 3653 ppid:     2 flags:0x00004000
Workqueue:  0x0 (hci3)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:udevd           state:R  running task     stack:26112 pid: 3656 ppid:  2978 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 ep_poll fs/eventpoll.c:1856 [inline]
 do_epoll_wait+0x1290/0x1930 fs/eventpoll.c:2234
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d33e46
RSP: 002b:00007ffe4d596998 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9366d33e46
RDX: 0000000000000004 RSI: 00007ffe4d5969d8 RDI: 0000000000000004
RBP: 000056132fef0190 R08: 0000000000000007 R09: 000056132feee280
R10: 00000000ffffffff R11: 0000000000000246 R12: 000056132feebb50
R13: 00007ffe4d5969d8 R14: 0000000000000008 R15: 000056132feca910
 </TASK>
task:bond0           state:I stack:30536 pid: 3657 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond0           state:I stack:30536 pid: 3658 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond0           state:I stack:30528 pid: 3659 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg0    state:I stack:30528 pid: 3660 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg1    state:I stack:30528 pid: 3661 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg2    state:I stack:30536 pid: 3662 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond0           state:I stack:30008 pid: 3663 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond0           state:I stack:30528 pid: 3664 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg0    state:I stack:28240 pid: 3665 ppid:     2 flags:0x00004000
Workqueue:  0x0 (wg-crypt-wg0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg1    state:I stack:30528 pid: 3666 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg0    state:I stack:30528 pid: 3667 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg1    state:I stack:30528 pid: 3668 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg2    state:I stack:30528 pid: 3669 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg2    state:I stack:30528 pid: 3670 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond0           state:I stack:30056 pid: 3671 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg0    state:I stack:28240 pid: 3672 ppid:     2 flags:0x00004000
Workqueue:  0x0 (wg-crypt-wg0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg1    state:I stack:29040 pid: 3673 ppid:     2 flags:0x00004000
Workqueue:  0x0 (wg-crypt-wg1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg2    state:I stack:29776 pid: 3674 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg0    state:I stack:29776 pid: 3675 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg0    state:I stack:29776 pid: 3676 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg1    state:I stack:30528 pid: 3677 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg1    state:I stack:29776 pid: 3678 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg2    state:I stack:29776 pid: 3679 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:3     state:I stack:25888 pid: 3680 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:wg-crypt-wg2    state:I stack:29776 pid: 3681 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:4     state:I stack:25832 pid: 3682 ppid:     2 flags:0x00004000
Workqueue:  0x0 (wg-crypt-wg1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:5     state:I stack:26416 pid: 3683 ppid:     2 flags:0x00004000
Workqueue:  0x0 (rcu_gp)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:6     state:I stack:26720 pid: 3684 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:7     state:I stack:25728 pid: 3685 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/0:8     state:I stack:26504 pid: 3686 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:4     state:I stack:26552 pid: 3687 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:5     state:I stack:25128 pid: 3689 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:6     state:I stack:25672 pid: 3696 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:7    state:R  running task     stack:27016 pid: 3712 ppid:     2 flags:0x00004000
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:6736
 irqentry_exit+0x31/0x80 kernel/entry/common.c:428
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x1ef/0x570 kernel/locking/lockdep.c:5633
Code: 1a a4 7e 83 f8 01 0f 85 e8 02 00 00 9c 58 f6 c4 02 0f 85 fb 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc9000479fb98 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920008f3f75 RCX: 5f85d40c8ce276f1
RDX: 1ffff11003e0214b RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff9067b8c7
R10: fffffbfff20cf718 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8bd86be0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:269 [inline]
 rcu_read_lock include/linux/rcupdate.h:695 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x12d/0xfa0 net/batman-adv/network-coding.c:719
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:8    state:I stack:25904 pid: 3723 ppid:     2 flags:0x00004000
Workqueue:  0x0 (phy4)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:udevd           state:S stack:27160 pid: 3905 ppid:  2978 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 schedule_hrtimeout_range_clock+0x343/0x390 kernel/time/hrtimer.c:2296
 ep_poll fs/eventpoll.c:1856 [inline]
 do_epoll_wait+0x1290/0x1930 fs/eventpoll.c:2234
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d33e46
RSP: 002b:00007ffe4d596998 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9366d33e46
RDX: 0000000000000004 RSI: 00007ffe4d5969d8 RDI: 0000000000000004
RBP: 000056132fef0190 R08: 0000000000000007 R09: 000056132feee280
R10: 00000000ffffffff R11: 0000000000000246 R12: 000056132ff06d80
R13: 00007ffe4d5969d8 R14: 00000000ffffffff R15: 000056132feca910
 </TASK>
task:kworker/1:7     state:I stack:27176 pid: 3906 ppid:     2 flags:0x00004000
Workqueue:  0x0 (rcu_gp)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:8     state:I stack:24264 pid: 3907 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/1:9     state:I stack:25912 pid: 3908 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:9    state:I stack:26728 pid: 4150 ppid:     2 flags:0x00004000
Workqueue:  0x0 (phy6)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:10   state:I stack:26928 pid: 4152 ppid:     2 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:11   state:I stack:27256 pid: 4154 ppid:     2 flags:0x00004000
Workqueue:  0x0 (phy8)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:12   state:I stack:27016 pid: 4284 ppid:     2 flags:0x00004000
Workqueue:  0x0 (phy14)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:kworker/u4:13   state:I stack:25504 pid: 4287 ppid:     2 flags:0x00004000
Workqueue:  0x0 (phy9)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:udevd           state:R  running task     stack:26224 pid: 4324 ppid:  2978 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:6736
 irqentry_exit+0x31/0x80 kernel/entry/common.c:428
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:refill_stock+0x208/0x3d0 mm/memcontrol.c:2260
Code: 00 48 c7 c6 87 a9 cd 81 48 89 ef e8 c2 ab 90 ff 48 85 db 75 2a 9c 58 f6 c4 02 0f 85 f8 00 00 00 48 85 db 74 01 fb 48 83 c4 08 <5b> 5d 41 5c 41 5d 41 5e 41 5f c3 e8 e8 17 b3 ff e9 06 fe ff ff e8
RSP: 0018:ffffc9000afefb98 EFLAGS: 00000282
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1b76951
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880b9a35de0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880b9a35e08
R13: 0000000000000000 R14: ffff888079430000 R15: 0000000000000001
 obj_cgroup_uncharge_pages mm/memcontrol.c:2978 [inline]
 refill_obj_stock+0x419/0x700 mm/memcontrol.c:3249
 memcg_slab_free_hook mm/slab.h:587 [inline]
 memcg_slab_free_hook mm/slab.h:550 [inline]
 do_slab_free mm/slub.c:3440 [inline]
 ___cache_free+0x265/0x400 mm/slub.c:3514
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags include/linux/audit.h:323 [inline]
 getname+0x8e/0xd0 fs/namei.c:218
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1272
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d25697
RSP: 002b:00007ffe4d5913e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000056132fed18f0 RCX: 00007f9366d25697
RDX: 0000000000080000 RSI: 000056132fed9af0 RDI: 00000000ffffff9c
RBP: 000056132fed9af0 R08: 000056132fed9af0 R09: 00007f9366df5a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000000000000701 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:R  running task     stack:26464 pid: 4325 ppid:  2978 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rwsem_down_write_slowpath+0x68a/0x11a0 kernel/locking/rwsem.c:1172
 __down_write_common kernel/locking/rwsem.c:1287 [inline]
 __down_write_common kernel/locking/rwsem.c:1284 [inline]
 __down_write kernel/locking/rwsem.c:1296 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1543
 inode_lock include/linux/fs.h:741 [inline]
 open_last_lookups fs/namei.c:3441 [inline]
 path_openat+0x93c/0x2910 fs/namei.c:3650
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9366d25697
RSP: 002b:00007ffe4d596010 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000056132fef2e40 RCX: 00007f9366d25697
RDX: 0000000000080241 RSI: 00007ffe4d596558 RDI: 00000000ffffff9c
RBP: 00007ffe4d596558 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
R13: 000056132fef2e40 R14: 0000000000000001 R15: 000056132feca910
 </TASK>
task:kworker/u4:14   state:I stack:26336 pid: 4428 ppid:     2 flags:0x00004000
Workqueue:  0x0 (phy4)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 worker_thread+0x15c/0x1080 kernel/workqueue.c:2457
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:syz-executor.4  state:T stack:29480 pid: 4917 ppid:  3638 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_signal_stop+0x591/0x890 kernel/signal.c:2476
 get_signal+0x843/0x2600 kernel/signal.c:2809
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:295
RIP: 0033:0x7fc4e7289109
RSP: 002b:00007fc4e83f3118 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00007fc4e739bf60 RCX: 00007fc4e7289109
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fc4e72e308d R08: 0000000020000300 R09: 0000000020000300
R10: 00000000200002c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc0b9db95f R14: 00007fc4e83f3300 R15: 0000000000022000
 </TASK>
task:syz-executor.4  state:T stack:29456 pid: 4962 ppid:  3638 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_signal_stop+0x591/0x890 kernel/signal.c:2476
 get_signal+0x843/0x2600 kernel/signal.c:2809
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc4e72ade31
RSP: 002b:00007fc4e83f30b0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00007fc4e739bf60 RCX: 00007fc4e72ade31
RDX: 00007fc4e83f30f0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fc4e72e308d R08: 0000000000000000 R09: 0000000020000300
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffc0b9db95f R14: 00007fc4e83f3300 R15: 0000000000022000
 </TASK>
task:syz-executor.4  state:T stack:29480 pid: 4997 ppid:  3638 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_signal_stop+0x591/0x890 kernel/signal.c:2476
 get_signal+0x843/0x2600 kernel/signal.c:2809
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:295
RIP: 0033:0x7fc4e7289109
RSP: 002b:00007fc4e83b1118 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00007fc4e739c100 RCX: 00007fc4e7289109
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fc4e72e308d R08: 0000000020000300 R09: 0000000020000300
R10: 00000000200002c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc0b9db95f R14: 00007fc4e83b1300 R15: 0000000000022000
 </TASK>
task:bond1           state:I stack:30360 pid: 5449 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond2           state:I stack:30536 pid: 5462 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond3           state:I stack:30536 pid: 5464 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond1           state:I stack:30536 pid: 5479 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond4           state:I stack:30536 pid: 5481 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond5           state:I stack:30536 pid: 5484 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond6           state:I stack:30536 pid: 5485 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond7           state:I stack:30536 pid: 5492 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond8           state:I stack:30536 pid: 5495 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond9           state:I stack:30536 pid: 5504 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond10          state:I stack:30536 pid: 5505 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond11          state:I stack:30536 pid: 5510 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond12          state:I stack:30536 pid: 5511 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond13          state:I stack:30056 pid: 5513 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond14          state:I stack:29968 pid: 5514 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond15          state:I stack:30536 pid: 5515 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond16          state:I stack:29688 pid: 5516 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond17          state:I stack:30536 pid: 5517 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond18          state:I stack:30536 pid: 5518 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond19          state:I stack:29688 pid: 5519 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond20          state:I stack:29968 pid: 5520 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond21          state:I stack:30536 pid: 5521 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond22          state:I stack:30536 pid: 5522 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond23          state:I stack:30008 pid: 5523 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond24          state:I stack:30528 pid: 5524 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond25          state:I stack:30528 pid: 5525 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond26          state:I stack:30536 pid: 5526 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rescuer_thread+0x780/0xcf0 kernel/workqueue.c:2599
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
task:bond27          state:I stack:30528 pid: 5527 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	44 00 00             	add    %r8b,(%rax)
   3:	e8 5f 83 29 f8       	callq  0xf8298367
   8:	65 48 8b 3c 25 80 6f 	mov    %gs:0x26f80,%rdi
   f:	02 00
  11:	e8 41 48 e3 f7       	callq  0xf7e34857
  16:	eb 99                	jmp    0xffffffb1
  18:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1d:	0f 0b                	ud2
  1f:	e9 23 ff ff ff       	jmpq   0xffffff47
  24:	cc                   	int3
  25:	cc                   	int3
  26:	cc                   	int3
  27:	41 56                	push   %r14
* 29:	41 55                	push   %r13 <-- trapping instruction
  2b:	49 89 f5             	mov    %rsi,%r13
  2e:	41 54                	push   %r12
  30:	55                   	push   %rbp
  31:	48 89 fd             	mov    %rdi,%rbp
  34:	53                   	push   %rbx
  35:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3a:	65                   	gs
  3b:	44                   	rex.R
  3c:	8b                   	.byte 0x8b
  3d:	25                   	.byte 0x25
  3e:	d5                   	(bad)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
