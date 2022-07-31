Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C25585E95
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiGaLNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiGaLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:13:10 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF3BF56
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:13:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id a17-20020a056e0208b100b002dc52b51d98so5071242ilt.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lQ9+iJKOltog490HmPKeyNREtCkgKWR15MTHkv5Of9c=;
        b=V6qTknx5PyKuigGZHodWRUsBmEc0H2ke9/IKOu8dkoFTYfGVxoNOgWFd7zUhTK8E8Y
         uhNcNKz0yz4tDjTgkt8FdesBxoe2J78Yjgi/QOIL5PR5oILEv1AcvBNc3ZZDRQMW7u26
         QtYlm1PgI+u3GPgHNb1afs/mAU5/rdtmsQRYTYpfE0DLL7zjHaWUFfGoJGbCvHVI/488
         5KmH1gmm3A6QR4iQQ6tRdaMQQ7Oqpc6kreo43RIJxaomKXQRyjhtDaNCAdwfLko9JWg6
         HZfPCDtG/24C9IcpGqxSog2xv0VKF6bg2Ste6JYy63GTyVbQ9j8fcKujkFLYta9CUNTN
         PeOQ==
X-Gm-Message-State: AJIora+OMEjw5WZ5RBN0M2raGzGqMxOuF+gETDVrObeOD5Kv4+RiIG0O
        K23yxlZGAcAumjyGqxetFBecr2OIW+RJJcY2Qu5WUKRugmrQ
X-Google-Smtp-Source: AGRyM1sl8/DrgXTjDMtrOTHNTT93vStGHrd6U4N/kwzUna1JFeG7x/bHi7q2rCQBYeYlF5a2KOqLS0ho5Gcv9/TfMPmT+Zkqclj3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:2dc:2950:3385 with SMTP id
 z7-20020a056e0217c700b002dc29503385mr4261746ilu.88.1659265988475; Sun, 31 Jul
 2022 04:13:08 -0700 (PDT)
Date:   Sun, 31 Jul 2022 04:13:08 -0700
In-Reply-To: <20220731110143.913-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4c35805e517f706@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
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
WARNING in __do_softirq

------------[ cut here ]------------
On CPU0 softirq took more than 20 ticks
WARNING: CPU: 0 PID: 6054 at kernel/softirq.c:351 __do_softirq+0x3b8/0xba6 kernel/softirq.c:351
Modules linked in:
CPU: 0 PID: 6054 Comm: syz-executor.0 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__do_softirq+0x3b8/0xba6 kernel/softirq.c:351
Code: 0f 89 71 fe ff ff 80 3d 56 69 cf 03 00 0f 85 64 fe ff ff 8b 74 24 40 48 c7 c7 00 54 4a 89 c6 05 3e 69 cf 03 01 e8 52 a8 99 ff <0f> 0b e9 46 fe ff ff 65 8b 15 9a 91 e1 76 83 fa 07 0f 87 ed 04 00
RSP: 0018:ffffc90000007f78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8b00a0c8 RCX: 0000000000000000
RDX: ffff888022969bc0 RSI: ffffffff815b73e5 RDI: fffff52000000fe1
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815b05be R11: 0000000000000000 R12: 0000000000000102
R13: 00000000ffffab06 R14: 0000000000000001 R15: 0000000000000082
FS:  00007f8534135700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005680c0 CR3: 000000003141e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:433 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:445
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:lock_is_held_type+0x10/0x120 kernel/locking/lockdep.c:5470
Code: c7 c7 a0 a9 4b 89 89 44 24 04 e8 e5 29 bf ff 0f 0b 8b 44 24 04 e9 08 ff ff ff 41 57 41 56 41 55 41 bd 01 00 00 00 41 54 55 53 <48> 83 ec 08 8b 0d d2 3b 09 04 85 c9 0f 84 c6 00 00 00 65 8b 05 e7
RSP: 0018:ffffc900020afd08 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff8158ce61
RDX: 1ffffffff166f836 RSI: 00000000ffffffff RDI: ffffffff8b373de0
RBP: 1ffff92000415fac R08: 0000000000000000 R09: ffffffff8d038c4f
R10: fffffbfff1a07189 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888029f29980
 lock_is_held include/linux/lockdep.h:271 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:123
 trace_lock_release include/trace/events/lock.h:58 [inline]
 lock_release+0x5b7/0x710 kernel/locking/lockdep.c:5453
 __raw_spin_unlock include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:183
 spin_unlock include/linux/spinlock.h:394 [inline]
 setfl fs/fcntl.c:81 [inline]
 do_fcntl+0x6da/0x1070 fs/fcntl.c:347
 __do_sys_fcntl fs/fcntl.c:463 [inline]
 __se_sys_fcntl fs/fcntl.c:448 [inline]
 __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465d99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8534135188 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465d99
RDX: 0000000000042000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000004bcf27 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffee7bd08df R14: 00007f8534135300 R15: 0000000000022000
----------------
Code disassembly (best guess):
   0:	c7 c7 a0 a9 4b 89    	mov    $0x894ba9a0,%edi
   6:	89 44 24 04          	mov    %eax,0x4(%rsp)
   a:	e8 e5 29 bf ff       	callq  0xffbf29f4
   f:	0f 0b                	ud2
  11:	8b 44 24 04          	mov    0x4(%rsp),%eax
  15:	e9 08 ff ff ff       	jmpq   0xffffff22
  1a:	41 57                	push   %r15
  1c:	41 56                	push   %r14
  1e:	41 55                	push   %r13
  20:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  26:	41 54                	push   %r12
  28:	55                   	push   %rbp
  29:	53                   	push   %rbx
* 2a:	48 83 ec 08          	sub    $0x8,%rsp <-- trapping instruction
  2e:	8b 0d d2 3b 09 04    	mov    0x4093bd2(%rip),%ecx        # 0x4093c06
  34:	85 c9                	test   %ecx,%ecx
  36:	0f 84 c6 00 00 00    	je     0x102
  3c:	65                   	gs
  3d:	8b                   	.byte 0x8b
  3e:	05                   	.byte 0x5
  3f:	e7                   	.byte 0xe7


Tested on:

commit:         f40ddce8 Linux 5.11
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c8846a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3565439810a4d2e5
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16efe82e080000

