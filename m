Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B841521532
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiEJM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbiEJM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:27:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279C1D8100
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:23:31 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i66-20020a6bb845000000b00657bac76fb4so11724791iof.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W8DHTnkIg5xv85W4z5i1vdRhAPL3p1evrQjuyNH3oC0=;
        b=NfTBlZ9t5oFr1HqW/mlOBuop1LRlab0ZaI8IesIjHC6X3TuORUZuy9oD/MZPcZhOBp
         TeZYccAuVME5CUpHYYsZEHlfTIBJOcril46B51PMOvmuuAtMWXq/Eh+ViooMxVatI2w2
         ewfXnCsx3Sdolbq3M23A3fhYHp8/unaQPwQp1xcCM+bADvlm0XTrKgGlqDQ4ljXop1Lu
         eYDLCpNRkU6VaLjDHN9uZgpC5Bfb4k7ZqTzWkg6FFwF2Zvd2KViJU5Ws6Bx2zx79583T
         pO3wiqOuLjAlGua+Mue70rHEE4WYvmHV7WFy/noVF4vFcT0pjZooV6GYxNCsJoGGmkgi
         gJOQ==
X-Gm-Message-State: AOAM530Qh4wwch+ijKogon3FRFMDn6rytQ8aLEa0hkuSihoscbZ17zKB
        CVjmosNgyZO7ueUcItVxw9ct3zau7dfsmzl+/u5caH2jVEh7
X-Google-Smtp-Source: ABdhPJwiJGhUw+XxELhWptiQvwaKdCyzbzh2zcG/dTEtWlgIsbnKTZDImqCgOZhli0EoJDNjvwQXCUdxg2hWuQX3c5/yY4sRw/mO
MIME-Version: 1.0
X-Received: by 2002:a5d:94cf:0:b0:657:24c1:bb7f with SMTP id
 y15-20020a5d94cf000000b0065724c1bb7fmr8622265ior.195.1652185411263; Tue, 10
 May 2022 05:23:31 -0700 (PDT)
Date:   Tue, 10 May 2022 05:23:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a9fbb05dea76400@google.com>
Subject: [syzbot] linux-next boot error: general protection fault in task_nr_scan_windows
From:   syzbot <syzbot+6cd5f4ca7f8b40a599d0@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mingo@kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ab38272e9973 Add linux-next specific files for 20220509
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129555fef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90245b9bee07a551
dashboard link: https://syzkaller.appspot.com/bug?extid=6cd5f4ca7f8b40a599d0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cd5f4ca7f8b40a599d0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000007e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000003f0-0x00000000000003f7]
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc6-next-20220509-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:arch_atomic64_read arch/x86/include/asm/atomic64_64.h:22 [inline]
RIP: 0010:arch_atomic_long_read include/linux/atomic/atomic-long.h:29 [inline]
RIP: 0010:atomic_long_read include/linux/atomic/atomic-instrumented.h:1266 [inline]
RIP: 0010:get_mm_counter include/linux/mm.h:1996 [inline]
RIP: 0010:get_mm_rss include/linux/mm.h:2049 [inline]
RIP: 0010:task_nr_scan_windows.isra.0+0x37/0x120 kernel/sched/fair.c:1123
Code: 03 00 00 55 48 89 fd 4c 89 e7 53 8b 1d b2 51 72 0a e8 ad 98 72 00 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 c1 e3 08 <80> 3c 02 00 0f 85 b9 00 00 00 48 8b 85 f0 03 00 00 41 bc 00 00 00
RSP: 0000:ffffc900001f0ca8 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000010000 RCX: ffffffff81544473
RDX: 000000000000007e RSI: 0000000000000008 RDI: 00000000000003f0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000003f8
R10: ffffffff816a7235 R11: 0000000000000000 R12: 00000000000003f0
R13: 00000000000003e8 R14: 000000003bfc8a1b R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ba8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
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
RIP: 0010:clear_page_erms+0x7/0x10 arch/x86/lib/clear_page_64.S:49
Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc cc cc 41 57 41 56 41 55 41 54 55 53 48 89 fb
RSP: 0000:ffffc900000676f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000a40
RDX: ffffea00005c1140 RSI: ffff888000000000 RDI: ffff8880170455c0
RBP: ffffea00005c1100 R08: 0000160000000000 R09: ffffea00005c1200
R10: fffff940000b8226 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000001
 clear_page arch/x86/include/asm/page_64.h:50 [inline]
 clear_highpage include/linux/highmem.h:217 [inline]
 kernel_init_free_pages mm/page_alloc.c:1283 [inline]
 post_alloc_hook+0x269/0x300 mm/page_alloc.c:2419
 prep_new_page mm/page_alloc.c:2431 [inline]
 get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4172
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5393
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2105
 alloc_pages+0x2b1/0x310 mm/mempolicy.c:2267
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc_lru+0x504/0x720 mm/slub.c:3246
 alloc_inode_sb include/linux/fs.h:2950 [inline]
 alloc_inode+0x168/0x230 fs/inode.c:262
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x27/0x2f0 fs/inode.c:1047
 tracefs_get_inode+0x1a/0x130 fs/tracefs/inode.c:132
 tracefs_create_file+0xe8/0x600 fs/tracefs/inode.c:483
 trace_create_file+0x2f/0x50 kernel/trace/trace.c:8824
 event_create_dir+0xaea/0x1320 kernel/trace/trace_events.c:2445
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
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic64_read arch/x86/include/asm/atomic64_64.h:22 [inline]
RIP: 0010:arch_atomic_long_read include/linux/atomic/atomic-long.h:29 [inline]
RIP: 0010:atomic_long_read include/linux/atomic/atomic-instrumented.h:1266 [inline]
RIP: 0010:get_mm_counter include/linux/mm.h:1996 [inline]
RIP: 0010:get_mm_rss include/linux/mm.h:2049 [inline]
RIP: 0010:task_nr_scan_windows.isra.0+0x37/0x120 kernel/sched/fair.c:1123
Code: 03 00 00 55 48 89 fd 4c 89 e7 53 8b 1d b2 51 72 0a e8 ad 98 72 00 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 c1 e3 08 <80> 3c 02 00 0f 85 b9 00 00 00 48 8b 85 f0 03 00 00 41 bc 00 00 00
RSP: 0000:ffffc900001f0ca8 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000010000 RCX: ffffffff81544473
RDX: 000000000000007e RSI: 0000000000000008 RDI: 00000000000003f0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000003f8
R10: ffffffff816a7235 R11: 0000000000000000 R12: 00000000000003f0
R13: 00000000000003e8 R14: 000000003bfc8a1b R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ba8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 00                	add    (%rax),%eax
   2:	00 55 48             	add    %dl,0x48(%rbp)
   5:	89 fd                	mov    %edi,%ebp
   7:	4c 89 e7             	mov    %r12,%rdi
   a:	53                   	push   %rbx
   b:	8b 1d b2 51 72 0a    	mov    0xa7251b2(%rip),%ebx        # 0xa7251c3
  11:	e8 ad 98 72 00       	callq  0x7298c3
  16:	4c 89 e2             	mov    %r12,%rdx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ea 03          	shr    $0x3,%rdx
  27:	c1 e3 08             	shl    $0x8,%ebx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 b9 00 00 00    	jne    0xed
  34:	48 8b 85 f0 03 00 00 	mov    0x3f0(%rbp),%rax
  3b:	41                   	rex.B
  3c:	bc                   	.byte 0xbc
  3d:	00 00                	add    %al,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
