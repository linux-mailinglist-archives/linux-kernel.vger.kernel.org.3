Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5552978E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiEQC5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiEQC5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:57:14 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9930B5F6D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:57:13 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k2-20020a0566022d8200b0065ad142f8c1so11584825iow.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BRwbj52xouzRSOLJgZSDw5oH7zURnJJCPmuzJDKbukM=;
        b=UYODjK+sCNknuYq4x+TdNMGAEeVtu2EMJzialw7JIfsBRzi7mwFXQlLrMkKGIh/V26
         PPiUyrZG+zQmih3oHaMEqpgrXs4fNrA1ON9QDTshlOJsFesJS+gjVJ2YNnNbl4E3y7+g
         jTpTK4fpCLOtsBWyHpSmEWlQa/ei2RPMyFJ0olGsQQAcEbgfHrp/VNKBE5nTlvwtRIpD
         jw5L9unbedvX/JnxsRb7zFIuoCGG7pDSvxiQt6Hw1pganqUUyR2MzTPUxnD0w6aXx5mi
         SkRYfrkvCxPWK1yKTjo0mZn3Vkmfg7g941mSUOiY3per5KaddS0vumiWist5FIE4dy63
         bFpQ==
X-Gm-Message-State: AOAM5304t41+ZPYlwzkCWZ489TZyGQX4bsxzI+9wykp4bI14ML8bQ69v
        CuZjYqhav96iQLMmmKRDp7r0Jv9Vme/MzRsMwPNKmqAtUQea
X-Google-Smtp-Source: ABdhPJzauUES8+GS3QgTnJ13swTQ/amjnNeI2oW0LUlwyF5iombQpxrByUinBex2G36cRaQnWVyRz04EMN47jlmC9nt1UP7HII0D
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f06:b0:65a:cfe5:1778 with SMTP id
 q6-20020a0566022f0600b0065acfe51778mr9082967iow.192.1652756233008; Mon, 16
 May 2022 19:57:13 -0700 (PDT)
Date:   Mon, 16 May 2022 19:57:13 -0700
In-Reply-To: <20220516233918.2046-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b39b905df2c4c30@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in percpu_ref_switch_to_atomic_rcu

------------[ cut here ]------------
percpu ref (css_release) <= 0 (-4294967295) after switching to atomic
WARNING: CPU: 1 PID: 0 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x46c/0x560 lib/percpu-refcount.c:196
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x46c/0x560 lib/percpu-refcount.c:196
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 c0 00 00 00 49 8b 77 e8 4c 89 e2 48 c7 c7 60 e3 26 8a e8 bc a7 31 05 <0f> 0b e9 34 ff ff ff 48 89 c6 48 c7 c7 80 39 69 8c 48 89 44 24 08
RSP: 0018:ffffc900001e0e20 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888010e71d80 RSI: ffffffff81601ae8 RDI: fffff5200003c1b6
RBP: ffff88801c8e2380 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815fc4be R11: 0000000000000000 R12: ffffffff00000001
R13: dffffc0000000000 R14: 0000607f4607c018 R15: ffff88801c8e23a0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556503848 CR3: 0000000023275000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
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
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
RIP: 0010:acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:551
Code: 89 de e8 1d 00 09 f8 84 db 75 ac e8 34 fc 08 f8 e8 9f 44 0f f8 eb 0c e8 28 fc 08 f8 0f 00 2d c1 93 c2 00 e8 1c fc 08 f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 97 fe 08 f8 48 85 db
RSP: 0018:ffffc90000177d20 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888010e71d80 RSI: ffffffff897044c4 RDI: 0000000000000000
RBP: ffff88801640a864 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f8988 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801640a800 R14: ffff88801640a864 R15: ffff888147cb0004
 acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:686
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x224/0x2c0 arch/x86/kernel/smpboot.c:266
 secondary_startup_64_no_verify+0xc3/0xcb
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 1d 00 09 f8       	callq  0xf8090024
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 34 fc 08 f8       	callq  0xf808fc44
  10:	e8 9f 44 0f f8       	callq  0xf80f44b4
  15:	eb 0c                	jmp    0x23
  17:	e8 28 fc 08 f8       	callq  0xf808fc44
  1c:	0f 00 2d c1 93 c2 00 	verw   0xc293c1(%rip)        # 0xc293e4
  23:	e8 1c fc 08 f8       	callq  0xf808fc44
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 97 fe 08 f8       	callq  0xf808fed4
  3d:	48 85 db             	test   %rbx,%rbx


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=110e4759f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1545e62df00000

