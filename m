Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E8483E75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiADIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiADIuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:50:07 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44712C061761;
        Tue,  4 Jan 2022 00:50:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d201so82127958ybc.7;
        Tue, 04 Jan 2022 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+gNtiVxoPcFMmHAi0IVREklEDEbSigV3EqXCOXXkxjM=;
        b=Yzwkva2sQu6wuNDQyd6TaY043pQYr3U16bA1Qik7vfu67Wf/TDhj7W5uQRNSkFvUTC
         meJPgXmenC1yAS7PHawaKhjPvlx2mvG59eAicRmTTAc7MI/6NwL710dtU+GO9p6C7wpH
         rGdNXqwCYnkTJwfU8i3YhViEZSbP2z0BSfPx5iEt5qMtLO3yWzYHWwB/haCvI7mhjUJv
         gMZvhyAmaB6S+Riqn+QJAhxZw8k9lYj0omaZxq0OrPO5bkG6pDMMMe8BmlTEugSgRYQr
         ++REQmvXsXacXVxGVLAmhNSBP86oJj3nWhJKOWtlQZ8HNOsh8Hml5VIcsJ1VkSpp6LyY
         4HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+gNtiVxoPcFMmHAi0IVREklEDEbSigV3EqXCOXXkxjM=;
        b=m0qEOggw72ArwxNmhOuj1kbhUNkC3x0pxVXfX8SHldINdPdWmoncJGYwR4vaTBMCy7
         0ENTOZPhlfq7lcF8CU2AQ5el23mIZPvQG78imEHW2tKwXavLOD9NTac5DrMVvUsATODL
         d2MP2eE1T+4CF5/i1QJJ5Qip0uXINjHvwspIyV9+NCVnB8wFyWMp2SVXJDwAeXHljr8y
         hwWpM1oK/S1kyFVx5+veXXYtg72MLnHuS1ksh2UBbuSARyUZQXqSZ3CDCpRIgfud6KNO
         SvoQ2Om4TbGrzjy0mqt+amqv3adDkFXhcGUXXrthANx1Skiux1R+PEmuPpbfSfEUickG
         4weA==
X-Gm-Message-State: AOAM530UHbcryOuMAUL1bryd8DlMzmiKBN/CQ6LTR1tPUD5vlDCCCVHL
        tHKRWh7JDgDOZjRrc+qpV8C94EyxC3VLD7PYHkHlUDh+dwYMKh/u
X-Google-Smtp-Source: ABdhPJykcPuuEPvSYYg5wR/ziR5FoYoJSfIm+ZLkAau9PmvSUGGAWUGVTh9p0UbSyTF0OJPvx2MpP92zdqgvaC4d2fg=
X-Received: by 2002:a25:da0e:: with SMTP id n14mr50755123ybf.35.1641286206529;
 Tue, 04 Jan 2022 00:50:06 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 16:49:55 +0800
Message-ID: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
Subject: INFO: trying to register non-static key in hci_uart_tx_wakeup
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
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
console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>


INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 2 PID: 18524 Comm: syz-executor.5 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:951 [inline]
 register_lock_class+0x148d/0x1950 kernel/locking/lockdep.c:1263
 __lock_acquire+0x106/0x57e0 kernel/locking/lockdep.c:4906
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
 percpu_down_read_trylock include/linux/percpu-rwsem.h:92 [inline]
 hci_uart_tx_wakeup+0x12e/0x490 drivers/bluetooth/hci_ldisc.c:124
 h5_timed_event+0x32f/0x6a0 drivers/bluetooth/hci_h5.c:188
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x6b0/0xa90 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xf2/0x130 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:get_current arch/x86/include/asm/current.h:15 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x40 kernel/kcov.c:199
Code: 02 8b 7e 81 e2 00 01 ff 00 75 10 65 48 8b 04 25 40 70 02 00 48
8b 80 58 15 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 <65> 48
8b 0c 25 40 70 02 00 bf 02 00 00 00 48 89 ce 4c 8b 04 24 e8
RSP: 0018:ffffc90006f5f300 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000200 RCX: ffff888051915640
RDX: 0000000000000000 RSI: ffff888051915640 RDI: 0000000000000002
RBP: 0000000000000008 R08: ffffffff814c726d R09: 0000000000000000
R10: 0000000000000007 R11: fffffbfff1b20a2a R12: 0000000000000000
R13: 0000000000000001 R14: ffff888010c64c00 R15: ffffea0001826f00
 queue_work_on+0xb3/0x110 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:502 [inline]
 schedule_work include/linux/workqueue.h:563 [inline]
 __vfree_deferred mm/vmalloc.c:2654 [inline]
 vfree_atomic+0xac/0xe0 mm/vmalloc.c:2672
 free_thread_stack kernel/fork.c:291 [inline]
 release_task_stack kernel/fork.c:431 [inline]
 put_task_stack+0x2a7/0x480 kernel/fork.c:442
 finish_task_switch+0x591/0x820 kernel/sched/core.c:4884
 context_switch kernel/sched/core.c:4975 [inline]
 __schedule+0xce1/0x2530 kernel/sched/core.c:6253
 preempt_schedule_common+0x4a/0xc0 kernel/sched/core.c:6419
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
 vprintk_emit+0x315/0x4a0 kernel/printk/printk.c:2246
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
 _printk+0xba/0xed kernel/printk/printk.c:2266
 show_free_areas+0x762/0xff0 mm/page_alloc.c:5892
 show_mem+0x3e/0x1ab lib/show_mem.c:17
 warn_alloc_show_mem mm/page_alloc.c:4198 [inline]
 warn_alloc.cold+0x10e/0x17a mm/page_alloc.c:4221
 __vmalloc_area_node mm/vmalloc.c:2964 [inline]
 __vmalloc_node_range+0x84e/0xa30 mm/vmalloc.c:3065
 alloc_thread_stack_node kernel/fork.c:244 [inline]
 dup_task_struct kernel/fork.c:886 [inline]
 copy_process+0x911/0x73e0 kernel/fork.c:2023
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2699
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fd4e55d41c5
Code: 48 85 ff 74 3d 48 85 f6 74 38 48 83 ee 10 48 89 4e 08 48 89 3e
48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85
c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00 00 00
RSP: 002b:00007fff2aaa5b78 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fd4e3e3b700 RCX: 00007fd4e55d41c5
RDX: 00007fd4e3e3b9d0 RSI: 00007fd4e3e3adb0 RDI: 00000000003d0f00
RBP: 00007fff2aaa5dd0 R08: 00007fd4e3e3b700 R09: 00007fd4e3e3b700
R10: 00007fd4e3e3b9d0 R11: 0000000000000202 R12: 00007fff2aaa5c2e
R13: 00007fff2aaa5c2f R14: 00007fff2aaa5dd0 R15: 00007fd4e3e3adc0
 </TASK>
----------------
Code disassembly (best guess):
   0: 02 8b 7e 81 e2 00     add    0xe2817e(%rbx),%cl
   6: 01 ff                 add    %edi,%edi
   8: 00 75 10             add    %dh,0x10(%rbp)
   b: 65 48 8b 04 25 40 70 mov    %gs:0x27040,%rax
  12: 02 00
  14: 48 8b 80 58 15 00 00 mov    0x1558(%rax),%rax
  1b: c3                   retq
  1c: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
  23: 00 00 00 00
  27: 0f 1f 00             nopl   (%rax)
* 2a: 65 48 8b 0c 25 40 70 mov    %gs:0x27040,%rcx <-- trapping instruction
  31: 02 00
  33: bf 02 00 00 00       mov    $0x2,%edi
  38: 48 89 ce             mov    %rcx,%rsi
  3b: 4c 8b 04 24           mov    (%rsp),%r8
  3f: e8                   .byte 0xe8


Best Regards,
Yiru
