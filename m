Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49054E31F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353443AbiCUUjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348010AbiCUUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:39:00 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A2171ED7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:37:33 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h14-20020a05660208ce00b00645c339411bso11195981ioz.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qC4jTrpWSffD+WMp1CkNBmlim8+y8DbW2qT4Z4ZHbBE=;
        b=lLpQkIRRGL67lZW6XVFgofquldbwh0vexc7Ry9+URfPSDLb0/dowa0M8OwcHDmILpF
         FRWqkxCLv+E8heVKKjecHeGn0MA0AKPEAkysr/FQ5z+pZ10pyjmBSdLxjOlkGt5ASwxd
         hcCItUgldX6+1U19UvF1Tvo+0j6przQDKnwTlfWiS0wrnDM+gunYR71xhUGqV3eDNq+1
         6C6VlCY8Kokp3JoLICIsItCgr+57BnM3jsJOobeP8oNpPr8hHUHaDsfQ5URfI0Gw2L1V
         7mQiyU5Ef366Jzvf3nR2SmtbOGaEC8SOjtptAluQ7CWobzX+G+BIddpV312SxPqrE4mh
         GQ+w==
X-Gm-Message-State: AOAM531qS1qh65bq1v4MyM1ZJZV/nK3yR9a35q/wOyheIbYyoNM3yIW7
        oUPNt6PhdafxVtsnpmhpbZ2BJcxWfzIeMbmRtSAnXKmYBRyL
X-Google-Smtp-Source: ABdhPJwN+okyvL7A1BTR2v4aO66pypGE82XqbpF6AjUyB1f2q5ds/H1CSLcnMtv6wIZWvaOzxjmPNQ9jswaQN1EbxxOVwGw7cBuC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2491:b0:31a:5ba0:c0aa with SMTP id
 x17-20020a056638249100b0031a5ba0c0aamr11449532jat.92.1647895053013; Mon, 21
 Mar 2022 13:37:33 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:37:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043178605dac077da@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in blk_release_queue
From:   syzbot <syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    f9006d9269ea Add linux-next specific files for 20220321
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147292eb700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1619ffa2b0259a1
dashboard link: https://syzkaller.appspot.com/bug?extid=bbea00057d3d55c4889b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1034ac25700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1746535d700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.17.0-next-20220321-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9766
 blk_release_queue+0x1f/0x320 block/blk-sysfs.c:766
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 blkg_free.part.0+0x112/0x1f0 block/blk-cgroup.c:86
 blkg_free block/blk-cgroup.c:78 [inline]
 __blkg_release+0x105/0x160 block/blk-cgroup.c:102
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:116 [inline]
RIP: 0010:acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:556
Code: 89 de e8 4d bf 17 f8 84 db 75 ac e8 64 bb 17 f8 e8 cf 02 1e f8 eb 0c e8 58 bb 17 f8 0f 00 2d e1 3a d1 00 e8 4c bb 17 f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 c7 bd 17 f8 48 85 db
RSP: 0018:ffffc90000177d18 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888010fe9d40 RSI: ffffffff8960ede4 RDI: ffffffff8960edd1
RBP: ffff88814566f864 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff817ef0d8 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88814566f800 R14: ffff88814566f864 R15: ffff8880192fe804
 acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:692
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x265/0x340 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 4d bf 17 f8       	callq  0xf817bf54
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 64 bb 17 f8       	callq  0xf817bb74
  10:	e8 cf 02 1e f8       	callq  0xf81e02e4
  15:	eb 0c                	jmp    0x23
  17:	e8 58 bb 17 f8       	callq  0xf817bb74
  1c:	0f 00 2d e1 3a d1 00 	verw   0xd13ae1(%rip)        # 0xd13b04
  23:	e8 4c bb 17 f8       	callq  0xf817bb74
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 c7 bd 17 f8       	callq  0xf817be04
  3d:	48 85 db             	test   %rbx,%rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
