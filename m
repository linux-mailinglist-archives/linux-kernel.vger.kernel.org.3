Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626551FCC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiEIM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiEIM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:29:21 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B92685DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:25:27 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id r17-20020a0566022b9100b00654b99e71dbso9825058iov.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 05:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CIV+qHZifJLmkDnmY1o0LzgDSfbnM41nl8nf9mQx+7E=;
        b=A2P9iPID2nfEdTRECyHlzsrEOvKpIwB7y8TY4a9dxc4E7hR3DfA9qOrsxeS/yZTy85
         EXrES6oY/93mxApM8aSm4dwL1XzAzKvpUNhD3I838srkuuBEu+nGzLfXHiJtlBSq00c4
         5mYg9Ja1fMh8TRuJyCk0CnUj4+bXM9L6h8Ab0b/IyvwmRjBQKcXbaXORtwMv/XqzsBdj
         sCvR1qgXOuFnF5zvRP/wlCua/niEmmjRB5U2Ndx9KI65STqXVaXPHSXDENenEC8NYf1i
         D9fkVZsVtK5mglLF6EOQeDk29qs/idWKxFjmUrJvtezFUrbiR9L1b5bAc5kBoIrC8ZMC
         ssZg==
X-Gm-Message-State: AOAM531q1fgcQ+i82yLHBOVZtfPWsHsEK3DAOJTiMCvJqGHwIayF3JGk
        JdtS4ILpMWRhWKrrlfIMh7YvSFCRFMWVnXs5JmlKnIOeTX1P
X-Google-Smtp-Source: ABdhPJwZP8+4o0JYPEOiu5Z8VsM/F3FeC6Q8fpoSBa/JTN+Be7Dzm+hL7wurbhJGSsao3463LbMyMTzoaXfJd0PtqTsVwjsZOyiW
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2082:b0:657:ad1c:795e with SMTP id
 a2-20020a056602208200b00657ad1c795emr6397424ioa.187.1652099127044; Mon, 09
 May 2022 05:25:27 -0700 (PDT)
Date:   Mon, 09 May 2022 05:25:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099f10605de934df8@google.com>
Subject: [syzbot] linux-next boot error: KASAN: null-ptr-deref Read in task_nr_scan_windows
From:   syzbot <syzbot+755d763a1d9f7bdb1729@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mingo@kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    ab38272e9973 Add linux-next specific files for 20220509
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172b96faf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90245b9bee07a551
dashboard link: https://syzkaller.appspot.com/bug?extid=755d763a1d9f7bdb1729
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+755d763a1d9f7bdb1729@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
BUG: KASAN: null-ptr-deref in get_mm_counter include/linux/mm.h:1996 [inline]
BUG: KASAN: null-ptr-deref in get_mm_rss include/linux/mm.h:2049 [inline]
BUG: KASAN: null-ptr-deref in task_nr_scan_windows.isra.0+0x23/0x120 kernel/sched/fair.c:1123
Read of size 8 at addr 00000000000003f0 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc6-next-20220509-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_report mm/kasan/report.c:432 [inline]
 kasan_report.cold+0x61/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
 get_mm_counter include/linux/mm.h:1996 [inline]
 get_mm_rss include/linux/mm.h:2049 [inline]
 task_nr_scan_windows.isra.0+0x23/0x120 kernel/sched/fair.c:1123
 task_scan_min kernel/sched/fair.c:1144 [inline]
 task_scan_start+0x6c/0x400 kernel/sched/fair.c:1150
 task_tick_numa kernel/sched/fair.c:2944 [inline]
 task_tick_fair+0xaeb/0xef0 kernel/sched/fair.c:11186
 scheduler_tick+0x20a/0x5e0 kernel/sched/core.c:5380
 update_process_times+0x191/0x200 kernel/time/timer.c:1816
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:243
 tick_sched_timer+0xee/0x120 kernel/time/tick-sched.c:1481
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1112
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:in_gate_area_no_mm+0x0/0x70 arch/x86/entry/vsyscall/vsyscall_64.c:344
Code: 48 89 df e8 02 ee 79 00 48 39 eb 76 ce e8 88 ea 79 00 44 89 e0 5b 5d 41 5c c3 e8 eb 65 c6 00 e9 67 ff ff ff 66 0f 1f 44 00 00 <41> 54 55 53 48 89 fb e8 64 ea 79 00 8b 2d 36 1c 7e 0a bf 02 00 00
RSP: 0000:ffffc90000067810 EFLAGS: 00000202
RAX: dffffc0000000000 RBX: ffffffff8f04214d RCX: 0000000000000000
RDX: 1ffff9200000cf17 RSI: ffffc90000067d88 RDI: ffffffff8f04214d
RBP: ffffffff8f04214d R08: ffffffff8e3eaa6a R09: ffffc900000678a4
R10: fffff5200000cf19 R11: ffffc90000067db0 R12: ffffc90000067928
R13: 0000000000000000 R14: ffff888010e80000 R15: 0000000000000000
 is_kernel_text include/linux/kallsyms.h:31 [inline]
 core_kernel_text+0x20/0x90 kernel/extable.c:68
 kernel_text_address+0xd/0x80 kernel/extable.c:99
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
 kmem_cache_alloc_lru+0x255/0x720 mm/slub.c:3246
 alloc_inode_sb include/linux/fs.h:2950 [inline]
 alloc_inode+0x168/0x230 fs/inode.c:262
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x27/0x2f0 fs/inode.c:1047
 tracefs_get_inode+0x1a/0x130 fs/tracefs/inode.c:132
 tracefs_create_file+0xe8/0x600 fs/tracefs/inode.c:483
 event_subsystem_dir kernel/trace/trace_events.c:2333 [inline]
 event_create_dir+0xc17/0x1320 kernel/trace/trace_events.c:2410
 __trace_early_add_event_dirs+0x7e/0xf0 kernel/trace/trace_events.c:3478
 early_event_add_tracer kernel/trace/trace_events.c:3645 [inline]
 event_trace_init+0x9e/0x113 kernel/trace/trace_events.c:3805
 tracer_init_tracefs+0xf9/0x457 kernel/trace/trace.c:9722
 do_one_initcall+0x103/0x650 init/main.c:1301
 do_initcall_level init/main.c:1376 [inline]
 do_initcalls init/main.c:1392 [inline]
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1618
 kernel_init+0x1a/0x1d0 init/main.c:1507
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
==================================================================
----------------
Code disassembly (best guess):
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 02 ee 79 00       	callq  0x79ee0a
   8:	48 39 eb             	cmp    %rbp,%rbx
   b:	76 ce                	jbe    0xffffffdb
   d:	e8 88 ea 79 00       	callq  0x79ea9a
  12:	44 89 e0             	mov    %r12d,%eax
  15:	5b                   	pop    %rbx
  16:	5d                   	pop    %rbp
  17:	41 5c                	pop    %r12
  19:	c3                   	retq
  1a:	e8 eb 65 c6 00       	callq  0xc6660a
  1f:	e9 67 ff ff ff       	jmpq   0xffffff8b
  24:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
* 2a:	41 54                	push   %r12 <-- trapping instruction
  2c:	55                   	push   %rbp
  2d:	53                   	push   %rbx
  2e:	48 89 fb             	mov    %rdi,%rbx
  31:	e8 64 ea 79 00       	callq  0x79ea9a
  36:	8b 2d 36 1c 7e 0a    	mov    0xa7e1c36(%rip),%ebp        # 0xa7e1c72
  3c:	bf                   	.byte 0xbf
  3d:	02 00                	add    (%rax),%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
