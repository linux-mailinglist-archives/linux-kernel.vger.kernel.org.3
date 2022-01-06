Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8483B4861DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiAFJMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:12:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiAFJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:12:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 52FBB1F37C;
        Thu,  6 Jan 2022 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641460354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2brGx705QYkY0AujJCUiwrOpHDiV9D8MTqlymar57Js=;
        b=i6GwA8wbAWNjXByGHUOSM2/wXA6tOzUxYF3qrqfb62FbOJCCpLe6CXIsB7MUwAksqLdYY/
        92I9jpQ/TXk3WIwgyrN5cytxbxp/BL0+mpKFMceicdgmXNAgiHkNqOI461OMeNAgNsx4sD
        ERlzTpLLxi+CRhXd9P/2k3qFN4c1zlI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D052AA3B84;
        Thu,  6 Jan 2022 09:12:33 +0000 (UTC)
Date:   Thu, 6 Jan 2022 10:12:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Sabri N. Ferreiro" <snferreiro1@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        mosesfonscqf75@gmail.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: INFO: rcu detected stall in devkmsg_read
Message-ID: <YdayfngxLCBB/Ful@alley>
References: <CAKG+3NT_v6fVOOn-qftVTLTHg5kSgsfnwb_-+zAQ-3drJm5+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKG+3NT_v6fVOOn-qftVTLTHg5kSgsfnwb_-+zAQ-3drJm5+=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-05 23:54:16, Sabri N. Ferreiro wrote:
> Hi,
> 
> When using Syzkaller to fuzz the Linux kernel, it triggers the following crash.
> 
> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: https://paste.ubuntu.com/p/mdfS9m5C74/
> kernel config: https://docs.google.com/document/d/1w94kqQ4ZSIE6BW-5WIhqp4_Zh7XTPH57L5OF2Xb6O6o/view
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by:  Yuheng Shen <mosesfonscqf75@gmail.com>
> 
> Sorry for my lack of this crash reproducer, I hope the symbolic report
> will help you.
> 
> R13: 00007ffd0a4a0e08 R14: 000055d71ee2c958 R15: 0005d4cd3d2ed07c
>  </TASK>
> Call Trace:
>  <IRQ>
>  x86_pmu_stop+0x11b/0x320 root/fuzz/kernel/5.16/arch/x86/events/core.c:1597
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>  x86_pmu_del+0x1a5/0x5b0 root/fuzz/kernel/5.16/arch/x86/events/core.c:1636
> rcu: 1-....: (108 ticks this GP) idle=459/1/0x4000000000000000
> softirq=39414/39414 fqs=4592
> (detected by 3, t=21002 jiffies, g=40973, q=19739)
>  event_sched_out.part.0+0x1ea/0x820
> root/fuzz/kernel/5.16/kernel/events/core.c:2285
> Sending NMI from CPU 3 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 121 Comm: systemd-journal Not tainted 5.16.0-rc6 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:preempt_count_add+0x7/0x140
> root/fuzz/kernel/5.16/kernel/sched/core.c:5422
> Code: df 03 00 48 89 ef e8 68 81 04 00 48 8b 3d b1 ca b8 03 48 89 ee
> 5d e9 a8 2b 44 00 0f 1f 84 00 00 00 00 00 48 c7 c0 c0 ef 6d 92 <55> 48
> ba 00 00 00 00 00 fc ff df 48 89 c1 53 83 e0 07 89 fb 48 c1
> RSP: 0018:ffff8881f7289868 EFLAGS: 00000046
> RAX: ffffffff926defc0 RBX: 1ffff1103ee5130e RCX: ffffffff8e253c25
> RDX: ffff8881082bd3c0 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: ffffffff9269e980 R08: 0000000000000001 R09: ffffffff9269e30e
> R10: fffffbfff24d3c61 R11: 0000000000000001 R12: ffff8881f7289940
> R13: 0000000000014f2e R14: 0000000000014f2e R15: ffff8881f7289ad0
> FS:  00007f3f4e83c8c0(0000) GS:ffff8881f7280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3f4a04b000 CR3: 0000000108138000 CR4: 0000000000350ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>

The backtrace is from IRQ context.

>  __raw_spin_lock
> root/fuzz/kernel/5.16/./include/linux/spinlock_api_smp.h:132 [inline]
>  _raw_spin_lock+0x5e/0xd0 root/fuzz/kernel/5.16/kernel/locking/spinlock.c:154
>  console_lock_spinning_enable
> root/fuzz/kernel/5.16/kernel/printk/printk.c:1776 [inline]
>  console_unlock+0x28e/0x8e0 root/fuzz/kernel/5.16/kernel/printk/printk.c:2708

console_unlock() was called from IRQ context.

It is a known printk() design problem that console_unlock() called
from IRQ context can cause softlockups, rcu stalls, ... when it has
to flush too many messages to the consoles. Especially when there
are messages added from other CPUs.

And the console output at https://paste.ubuntu.com/p/mdfS9m5C74/ suggests
that there were many printk messages flushed.

John Ogness is working on solving this design problem by offloading
the console handling to kthreads. So, we hopefully get rid of it
one day.


At the moment, the only solution is to reduce the number of messages
printed to the console.

And I am a bit confused here. I do not understand who is producing all
the other messages. They look like "regular" snapshots but I do not
understand who triggered them.

We should make sure that there is no infinite loop caused by kasan
reports and printk code. But I do not fully understand if this is
the case here. Adding Kasan people into CC.

Best Regards,
Petr


>  vprintk_emit+0xf8/0x230 root/fuzz/kernel/5.16/kernel/printk/printk.c:2245
>  vprintk+0x69/0x80 root/fuzz/kernel/5.16/kernel/printk/printk_safe.c:50
>  _printk+0xba/0xed root/fuzz/kernel/5.16/kernel/printk/printk.c:2266
>  printk_stack_address
> root/fuzz/kernel/5.16/arch/x86/kernel/dumpstack.c:72 [inline]
>  show_trace_log_lvl+0x263/0x2ca
> root/fuzz/kernel/5.16/arch/x86/kernel/dumpstack.c:282
>  ex_handler_wrmsr_unsafe root/fuzz/kernel/5.16/arch/x86/mm/extable.c:87 [inline]
>  fixup_exception+0x3bb/0x690 root/fuzz/kernel/5.16/arch/x86/mm/extable.c:150
>  __exc_general_protection
> root/fuzz/kernel/5.16/arch/x86/kernel/traps.c:601 [inline]
>  exc_general_protection+0xed/0x2e0
> root/fuzz/kernel/5.16/arch/x86/kernel/traps.c:562
>  asm_exc_general_protection+0x1e/0x30
> root/fuzz/kernel/5.16/./arch/x86/include/asm/idtentry.h:562
> RIP: 0010:__wrmsr
> root/fuzz/kernel/5.16/./arch/x86/include/asm/msr.h:103 [inline]
> RIP: 0010:native_write_msr
> root/fuzz/kernel/5.16/./arch/x86/include/asm/msr.h:160 [inline]
> RIP: 0010:wrmsrl root/fuzz/kernel/5.16/./arch/x86/include/asm/msr.h:281 [inline]
> RIP: 0010:x86_pmu_disable_event
> root/fuzz/kernel/5.16/arch/x86/events/amd/../perf_event.h:1138
> [inline]
> RIP: 0010:amd_pmu_disable_event+0x83/0x280
> root/fuzz/kernel/5.16/arch/x86/events/amd/core.c:639
> Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e0 01
> 00 00 48 8b ab 78 01 00 00 4c 89 e2 44 89 e0 48 c1 ea 20 89 e9 <0f> 30
> 66 90 e8 34 4a 38 00 e8 2f 4a 38 00 48 8d bb 94 01 00 00 48
> RSP: 0018:ffff8881f7289df8 EFLAGS: 00010016
> RAX: 0000000000110076 RBX: ffff88810e915c88 RCX: 00000000c0010200
> RDX: 0000000000000100 RSI: ffffffff90e07480 RDI: ffff88810e915e00
> RBP: 00000000c0010200 R08: 0000000000000000 R09: ffff8881f72a19e7
> R10: ffffed103ee5433c R11: 0000000000000001 R12: 0000010000110076
> R13: 0000000000000000 R14: ffff8881f72a17e0 R15: ffff88810e915e14
>  x86_pmu_stop+0x11b/0x320 root/fuzz/kernel/5.16/arch/x86/events/core.c:1597
>  x86_pmu_del+0x1a5/0x5b0 root/fuzz/kernel/5.16/arch/x86/events/core.c:1636
>  event_sched_out.part.0+0x1ea/0x820
> root/fuzz/kernel/5.16/kernel/events/core.c:2285
>  event_sched_out root/fuzz/kernel/5.16/kernel/events/core.c:2354 [inline]
>  __perf_remove_from_context+0x5c6/0x750
> root/fuzz/kernel/5.16/kernel/events/core.c:2352
>  event_function+0x216/0x310 root/fuzz/kernel/5.16/kernel/events/core.c:253
>  remote_function root/fuzz/kernel/5.16/kernel/events/core.c:91 [inline]
>  remote_function+0x110/0x190 root/fuzz/kernel/5.16/kernel/events/core.c:71
>  flush_smp_call_function_queue+0x162/0x4f0
> root/fuzz/kernel/5.16/kernel/smp.c:628
>  __sysvec_call_function_single+0x62/0x200
> root/fuzz/kernel/5.16/arch/x86/kernel/smp.c:248
>  sysvec_call_function_single+0x89/0xc0
> root/fuzz/kernel/5.16/arch/x86/kernel/smp.c:243
>  </IRQ>
>  <TASK>
>  asm_sysvec_call_function_single+0x12/0x20
> root/fuzz/kernel/5.16/./arch/x86/include/asm/idtentry.h:646
> RIP: 0010:bytes_is_nonzero root/fuzz/kernel/5.16/mm/kasan/generic.c:85 [inline]
> RIP: 0010:memory_is_nonzero
> root/fuzz/kernel/5.16/mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n
> root/fuzz/kernel/5.16/mm/kasan/generic.c:128 [inline]
> RIP: 0010:memory_is_poisoned
> root/fuzz/kernel/5.16/mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline
> root/fuzz/kernel/5.16/mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0x18e/0x1e0
> root/fuzz/kernel/5.16/mm/kasan/generic.c:189
> Code: 07 48 39 d0 7d 87 41 bb 01 00 00 00 5b 5d 44 89 d8 41 5c c3 48
> 85 d2 74 ed 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 df 80 38 00 <74> f2
> e9 32 ff ff ff 41 bb 01 00 00 00 44 89 d8 c3 48 29 c3 48 89
> RSP: 0018:ffff888108c07b68 EFLAGS: 00000246
> RAX: fffffbfff22dc768 RBX: fffffbfff22dc769 RCX: ffffffff8e254b5c
> RDX: fffffbfff22dc769 RSI: 0000000000000008 RDI: ffffffff916e3b40
> RBP: fffffbfff22dc768 R08: 0000000000000000 R09: ffffffff916e3b47
> R10: fffffbfff22dc768 R11: 0000000000000001 R12: ffffffff916e3b40
> R13: ffff888108c07c30 R14: ffff888108c07c50 R15: ffffffff916e3b20
>  instrument_atomic_read
> root/fuzz/kernel/5.16/./include/linux/instrumented.h:71 [inline]
>  atomic_long_read
> root/fuzz/kernel/5.16/./include/linux/atomic/atomic-instrumented.h:1183
> [inline]
>  prb_first_seq root/fuzz/kernel/5.16/kernel/printk/printk_ringbuffer.c:1833
> [inline]
>  _prb_read_valid+0x48c/0x660
> root/fuzz/kernel/5.16/kernel/printk/printk_ringbuffer.c:1881
>  prb_read_valid+0x75/0xa0
> root/fuzz/kernel/5.16/kernel/printk/printk_ringbuffer.c:1929
>  devkmsg_read+0x158/0x680 root/fuzz/kernel/5.16/kernel/printk/printk.c:730
>  vfs_read+0x13c/0x4c0 root/fuzz/kernel/5.16/fs/read_write.c:479
>  ksys_read+0x100/0x210 root/fuzz/kernel/5.16/fs/read_write.c:619
>  do_syscall_x64 root/fuzz/kernel/5.16/arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 root/fuzz/kernel/5.16/arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f3f4ddcd210
> Code: 73 01 c3 48 8b 0d 98 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> 0f 1f 44 00 00 83 3d b9 c1 20 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fc ff ff 48 89 04 24
> RSP: 002b:00007ffd0a49e438 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007ffd0a4a0eb0 RCX: 00007f3f4ddcd210
> RDX: 0000000000002000 RSI: 00007ffd0a49ecb0 RDI: 0000000000000009
> RBP: 0000000000000000 R08: 000000000000e000 R09: 0000000000000007
> R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffd0a49ecb0
> R13: 00007ffd0a4a0e08 R14: 000055d71ee2c958 R15: 0005d4cd3d2ed07c
>  </TASK>
>  event_sched_out root/fuzz/kernel/5.16/kernel/events/core.c:2354 [inline]
>  __perf_remove_from_context+0x5c6/0x750
> root/fuzz/kernel/5.16/kernel/events/core.c:2352
>  event_function+0x216/0x310 root/fuzz/kernel/5.16/kernel/events/core.c:253
>  remote_function root/fuzz/kernel/5.16/kernel/events/core.c:91 [inline]
>  remote_function+0x110/0x190 root/fuzz/kernel/5.16/kernel/events/core.c:71
>  flush_smp_call_function_queue+0x162/0x4f0
> root/fuzz/kernel/5.16/kernel/smp.c:628
>  __sysvec_call_function_single+0x62/0x200
> root/fuzz/kernel/5.16/arch/x86/kernel/smp.c:248
>  sysvec_call_function_single+0x89/0xc0
> root/fuzz/kernel/5.16/arch/x86/kernel/smp.c:243
>  </IRQ>
