Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C082585E02
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiGaIDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGaIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:03:16 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED8D66
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:03:15 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id 15-20020a056e0220cf00b002dd711a2677so4913794ilq.21
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=cbiNkBF3G9ZKuuMPj1xgFi/8YuWw+YtX9U5zqHgbnAE=;
        b=tdBimd4CFIqVUULjMk9iA4iXESwpaJPi0q6DjCPNyo6ZOI+hGrd8dessdZ44VqyWUW
         o8ceBkIrNAk0wsDrJYXWlqdRCG6b7HvepK3Ln+p1lmlOSld2V3mXJ6WQj6kjwHMu+NfO
         KlAy7AfJlz1buVxw0cOLVQ7OvtLlMLuTyFjSskUFiKrUAWnhXOVGdCq6XpCrNDqZO8eC
         bHzYrwfiNWoTFOKqgLMbGuKxHm7XmdgaVjmeP4SehKPOwzNzSmIpOGgI98ke6BU5g9f1
         daPaHhkJSDhlMbC+vxum9i19zkm8p1XMjwckqtt+A0Qwws1sLu4J6qdlL4c+hFzH5aIQ
         L03A==
X-Gm-Message-State: AJIora+7X3iivEXGHxX5AH1J87esau1QKOvAGS6eQXMj14p3kfBNnUdg
        rLO0RgiuZ5KvVbuXnfzS/zRFoKLQD7/9PxDZsaonv0K2Zojl
X-Google-Smtp-Source: AGRyM1s+GaS3mVkMB16NLh3PqrJ4uhM4LFY4vbe59M70RgingVnimlkfjHQ5UjyiHaGszyTFIXP9alpIsCCaObJNqqwfg3ZIBxFe
MIME-Version: 1.0
X-Received: by 2002:a6b:c301:0:b0:67c:5d64:ba13 with SMTP id
 t1-20020a6bc301000000b0067c5d64ba13mr3517289iof.126.1659254594712; Sun, 31
 Jul 2022 01:03:14 -0700 (PDT)
Date:   Sun, 31 Jul 2022 01:03:14 -0700
In-Reply-To: <20220731074633.519-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5ba6b05e515502e@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __hrtimer_run_queues

------------[ cut here ]------------
On CPU1 hrtimer tick_sched_timer took more than 4 ticks
WARNING: CPU: 1 PID: 0 at kernel/time/hrtimer.c:1689 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
WARNING: CPU: 1 PID: 0 at kernel/time/hrtimer.c:1689 __hrtimer_run_queues+0xe3c/0x1000 kernel/time/hrtimer.c:1754
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0-rc6-next-20220303-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1689 [inline]
RIP: 0010:__hrtimer_run_queues+0xe3c/0x1000 kernel/time/hrtimer.c:1754
Code: fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e b7 01 00 00 41 8b 77 40 48 c7 c7 a0 68 ce 89 48 8b 54 24 08 e8 50 82 b0 07 <0f> 0b e9 62 f4 ff ff e8 c8 42 5c 00 e9 5c f6 ff ff 48 8b 7c 24 18
RSP: 0018:ffffc900001e0e30 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888011a21d40 RSI: ffffffff81602878 RDI: fffff5200003c1b8
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815fd23e R11: 0000000000000000 R12: ffff8880b9d2afa0
R13: 0000000000000000 R14: ffff8880b9d2a680 R15: ffff8880b9d2a600
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba30aa0097 CR3: 000000002354c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1816
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:116 [inline]
RIP: 0010:acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:556
Code: 89 de e8 4d e6 18 f8 84 db 75 ac e8 64 e2 18 f8 e8 1f 2b 1f f8 eb 0c e8 58 e2 18 f8 0f 00 2d 91 ed d1 00 e8 4c e2 18 f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 c7 e4 18 f8 48 85 db
RSP: 0018:ffffc90000177d18 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888011a21d40 RSI: ffffffff896045f4 RDI: 0000000000000000
RBP: ffff888016545864 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f7138 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888016545800 R14: ffff888016545864 R15: ffff8880199b0004
 acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:692
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:158 [inline]
 cpuidle_idle_call kernel/sched/idle.c:239 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_secondary+0x265/0x340 arch/x86/kernel/smpboot.c:272
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 4d e6 18 f8       	callq  0xf818e654
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 64 e2 18 f8       	callq  0xf818e274
  10:	e8 1f 2b 1f f8       	callq  0xf81f2b34
  15:	eb 0c                	jmp    0x23
  17:	e8 58 e2 18 f8       	callq  0xf818e274
  1c:	0f 00 2d 91 ed d1 00 	verw   0xd1ed91(%rip)        # 0xd1edb4
  23:	e8 4c e2 18 f8       	callq  0xf818e274
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 c7 e4 18 f8       	callq  0xf818e504
  3d:	48 85 db             	test   %rbx,%rbx


Tested on:

commit:         91265a6d Add linux-next specific files for 20220303
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11658846080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161e281e080000

