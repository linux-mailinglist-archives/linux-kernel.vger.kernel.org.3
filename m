Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89951585DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiGaHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiGaHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 03:38:12 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3C10FE1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 00:38:10 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s5-20020a056e02216500b002dde8b02f62so4846106ilv.15
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=UBnqexlkXIWqjxQFSQ1lcewGNjzm5F2cQvt1xYSCndQ=;
        b=m275obd58y9GDjF7VHVXVeUWi6v5Td0pO3cB9+OhnvSgEEEcjoJ4Q3IYLz/xsYT0ds
         HZG3lnz3gpnDDrp1ek4tHsVoKqndcf9Pknvo8g9hxnV3yGCLHchfU5MWiX0/oSyN1vH6
         BHQ0PIZKuJCGl+U59hK7dMDU1ya9wuleivn8PZnyCiVyX7o3wSxLqEBXzZnd0wfiy5IB
         qbIqdS/Fq6waJxAUuAeOrkFwtGyKTaw8V5WRmpk0I8ghBdqbNQuOxlZetI7q1wDKzUd+
         e7gdbWmKnmGhPw4V67XBMjx3CXgz3aXs1B4xjIsqrhxnUeX9MwL9IND8omDs2R/QIgHS
         ieoA==
X-Gm-Message-State: AJIora8NmAbvC+tUbZZmTwcoqq4rsQ/jp89qxE+mvNl9lwvBgfazzJUw
        l398CKUS4DlC/4Zwui4i4+Wq8vJ+VkkIiVIPe6rUdASyjqOS
X-Google-Smtp-Source: AGRyM1v3qVl/UriwE0DiTUgi2yh2DsREWwTErki74Yz2Z29EqhoujbtoebeNbiXfRA1nWin3sDHm1trdDHVwLEgHZUXp+so0PXKw
MIME-Version: 1.0
X-Received: by 2002:a02:664a:0:b0:33f:5310:35e1 with SMTP id
 l10-20020a02664a000000b0033f531035e1mr4069908jaf.214.1659253090040; Sun, 31
 Jul 2022 00:38:10 -0700 (PDT)
Date:   Sun, 31 Jul 2022 00:38:10 -0700
In-Reply-To: <20220731072530.451-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000644b805e514f73c@google.com>
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
WARNING in __hrtimer_run_queues

------------[ cut here ]------------
On CPU1 hrtimer mac80211_hwsim_beacon took more than 4 ticks
WARNING: CPU: 1 PID: 6080 at kernel/time/hrtimer.c:1523 __run_hrtimer kernel/time/hrtimer.c:1523 [inline]
WARNING: CPU: 1 PID: 6080 at kernel/time/hrtimer.c:1523 __hrtimer_run_queues+0xe30/0xff0 kernel/time/hrtimer.c:1587
Modules linked in:
CPU: 1 PID: 6080 Comm: syz-executor.3 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1523 [inline]
RIP: 0010:__hrtimer_run_queues+0xe30/0xff0 kernel/time/hrtimer.c:1587
Code: fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e b7 01 00 00 41 8b 77 40 48 c7 c7 c0 97 4d 89 48 8b 54 24 08 e8 ca d0 56 07 <0f> 0b e9 6e f4 ff ff e8 d4 c1 52 00 e9 68 f6 ff ff 48 8b 7c 24 18
RSP: 0018:ffffc90000db0e50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801dcb0000 RSI: ffffffff815b73e5 RDI: fffff520001b61bc
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815b05be R11: 0000000000000000 R12: ffff8880263bd878
R13: 0000000000000004 R14: ffff8880b9f26c80 R15: ffff8880b9f26a00
FS:  00007f0886014700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000056c000 CR3: 0000000023e2c000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1604
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:lock_acquire+0x1d2/0x720 kernel/locking/lockdep.c:5410
Code: 48 c7 c7 a0 a9 4b 89 48 83 c4 20 e8 88 b9 a1 07 b8 ff ff ff ff 65 0f c1 05 ab 2a a9 7e 83 f8 01 0f 85 da 03 00 00 ff 34 24 9d <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
RSP: 0018:ffffc900020ffd28 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 1ffff9200041ffa7 RCX: 0000000000000001
RDX: 1ffff11003b96130 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8ee6683f
R10: fffffbfff1dccd07 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8880185411c8 R14: 0000000000000000 R15: 0000000000000000
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 setfl fs/fcntl.c:79 [inline]
 do_fcntl+0x696/0x1070 fs/fcntl.c:347
 __do_sys_fcntl fs/fcntl.c:463 [inline]
 __se_sys_fcntl fs/fcntl.c:448 [inline]
 __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465d99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0886014188 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465d99
RDX: 0000000000042000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000004bcf27 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffefcbe216f R14: 00007f0886014300 R15: 0000000000022000
----------------
Code disassembly (best guess):
   0:	48 c7 c7 a0 a9 4b 89 	mov    $0xffffffff894ba9a0,%rdi
   7:	48 83 c4 20          	add    $0x20,%rsp
   b:	e8 88 b9 a1 07       	callq  0x7a1b998
  10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  15:	65 0f c1 05 ab 2a a9 	xadd   %eax,%gs:0x7ea92aab(%rip)        # 0x7ea92ac8
  1c:	7e
  1d:	83 f8 01             	cmp    $0x1,%eax
  20:	0f 85 da 03 00 00    	jne    0x400
  26:	ff 34 24             	pushq  (%rsp)
  29:	9d                   	popfq
* 2a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax <-- trapping instruction
  31:	fc ff df
  34:	48 01 c3             	add    %rax,%rbx
  37:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7


Tested on:

commit:         f40ddce8 Linux 5.11
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1791dcfe080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3565439810a4d2e5
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157e1b36080000

