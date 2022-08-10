Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161C58EC59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiHJMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiHJMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:53:56 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF9E6B152;
        Wed, 10 Aug 2022 05:53:55 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v128so14993942vsb.10;
        Wed, 10 Aug 2022 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=YukoUXFkDlluQpg3az6GBPcKt1mtICotQCEBaoJRE2c=;
        b=U2Pm1Urb3arYSp0dzR5ROo7jUtx1ZV5dkjqI29XhNdXFk8W3Vl8s3cQYJsObrd5QhG
         cbunBqpOgD8uDXqZgOROJrVoP3Ktp27qcpMkvWcA3hwWMfIRmLtXXYMco+Ni7glHtvL8
         eEjgPNdtXDBtcHxPnFkLifi1SWjucIUG6YX/3bwOWh+POq1C7u800+SZ5uEt8SLjoyb3
         a4zG1Tt1X4SntspVh2v/lvkdntow2JnbALfa7IWOVFwd0z2ryBKCL+9h33Y9LT4JRFAd
         JzljyIE1fav54cBtrTbelPG6JdUZmC2AFYnPx/i6z6IUbPBUaHuOSPf193L5pYBDwMZS
         TixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=YukoUXFkDlluQpg3az6GBPcKt1mtICotQCEBaoJRE2c=;
        b=bd437R7xoiKBig2IZ9XwXV8mYGLE3LnzK0adNE8byLLQRdDtTiFK5wvpwyFPvalD9H
         QKvaeVujMQLzv+JLfSSFmrRhZn2ld6Uo7aNN4jx5wBb8oASBeipUWTuv69Uix4A3PRyj
         ITvtWObAYI9UGkEBlkScxSfbTOMTGk9XdXp1PIeMDRrDp13xiGe+GChGJjEe3fGI37pk
         G9J+yHRF2m6WaLYvK1wdpUhERuYRi/Ez3V9xzdE+6z9U38wvzJORSPoUd/ppUTmxh1S5
         CNFJdVtsW5p5HdfhwRrj+nEW/WbscYhMLHpAnsl89d3OffQuXPQnnYwEHFmJxmriygTS
         ii3A==
X-Gm-Message-State: ACgBeo0qiHADNt38Xncuc/rgERFvkoKxgOD19EKWE+MzpqTsr3jhg3CR
        BCi9++CAShqe+mOggUxtIW7SgiXaOGseNf1ymZY72eI+KrWvkaeCGH8=
X-Google-Smtp-Source: AA6agR73XeQ5Yx3hfznTpNV3SPhJot2TflnLIE2fXsc/DFL/GYqyZN2pUxO1diWcUhum7/2MPOw6g/Gxpz5BZb9oOIk=
X-Received: by 2002:a67:f607:0:b0:388:ac13:af19 with SMTP id
 k7-20020a67f607000000b00388ac13af19mr6376749vso.19.1660136034183; Wed, 10 Aug
 2022 05:53:54 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 10 Aug 2022 20:53:43 +0800
Message-ID: <CAB7eexJcUuLm10m-Yd9PVnHt1VvaPQzCBkoiFv1uKTR=0O=KsQ@mail.gmail.com>
Subject: linux version v5.18 warn in alloc_ep_req
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
git tree: upstream

kernel config: https://pastebin.com/KecL2gaG
C reproducer: https://pastebin.com/sh8uUVpV
console output: https://pastebin.com/yV0hwZSi

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0x13d3, product
id:0x3333, with function: midi).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

It seems that when calling a pre-allocate write usb requests to use on
f_midi_transmit, kernel will eventually call alloc_ep_req function,
and a failed kmalloc allocation on the buffer filed within use_request
struct will cause this error happen.

The crash report is as follow:

```
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at mm/page_alloc.c:5402
__alloc_pages+0x3e9/0x6e0 mm/page_alloc.c:5402
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc4-00208-g69cb6c6556ad #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__alloc_pages+0x3e9/0x6e0 mm/page_alloc.c:5402
Code: 0f 84 06 02 00 00 41 be 41 00 00 00 e9 df fd ff ff 83 fe 0a 0f
86 e1 fc ff ff 80 3d 62 05 c5 07 00 75 09 c6 05 59 05 c5 07 01 <0f> 0b
45 31 f6 e9 69 ff ff ff 65 8b 2d 16 07 90 7e 83 fd 07 0f 87
RSP: 0018:ffffc90000198730 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff920000330ea RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000000000
RBP: 0000000000040a20 R08: ffffffff8177d993 R09: 0000000000000005
R10: 0000000000000003 R11: fffffbfff128458a R12: 0000000000000013
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffff1102201463e
FS: 0000000000000000(0000) GS:ffff88811a880000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559410745860 CR3: 0000000114927000 CR4: 0000000000350ee0
Call Trace:
<IRQ>
alloc_pages+0x119/0x250 mm/mempolicy.c:2272
kmalloc_order+0x34/0xf0 mm/slab_common.c:945
kmalloc_order_trace+0x14/0x120 mm/slab_common.c:961
kmalloc_large include/linux/slab.h:529 [inline]
__kmalloc+0x395/0x4b0 mm/slub.c:4435
kmalloc include/linux/slab.h:605 [inline]
alloc_ep_req+0x146/0x1e0 drivers/usb/gadget/u_f.c:22
midi_alloc_ep_req drivers/usb/gadget/function/f_midi.c:230 [inline]
f_midi_set_alt drivers/usb/gadget/function/f_midi.c:384 [inline]
f_midi_set_alt+0x22f/0x630 drivers/usb/gadget/function/f_midi.c:363
set_config drivers/usb/gadget/composite.c:933 [inline]
composite_setup+0x3b5c/0x76a0 drivers/usb/gadget/composite.c:1829
configfs_composite_setup+0x101/0x140 drivers/usb/gadget/configfs.c:1467
dummy_timer+0x1699/0x33f0 drivers/usb/gadget/udc/dummy_hcd.c:1920
call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers kernel/time/timer.c:1790 [inline]
__run_timers kernel/time/timer.c:1763 [inline]
run_timer_softirq+0x1084/0x16d0 kernel/time/timer.c:1803
__do_softirq+0x1c0/0x8ee kernel/softirq.c:571
invoke_softirq kernel/softirq.c:445 [inline]
__irq_exit_rcu kernel/softirq.c:650 [inline]
irq_exit_rcu+0xe2/0x120 kernel/softirq.c:662
sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1106
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:731
Code: 75 fe ff 4c 89 e2 48 89 ef 5d 41 5c 31 f6 e9 7c f8 5e fc cc cc
cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 77 9a 4d 00 fb f4 <c3> 0f
1f 40 00 41 54 be 08 00 00 00 53 65 48 8b 1c 25 c0 6e 02 00
RSP: 0018:ffffc9000010fde8 EFLAGS: 00000202
RAX: 00000000001580e9 RBX: 0000000000000001 RCX: ffffffff85f2eeb0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed1023517153
R10: ffff88811a8b8a93 R11: ffffed1023517152 R12: 0000000000000001
R13: 0000000000000001 R14: ffffffff89422c50 R15: 0000000000000000
default_idle_call+0xbd/0x420 kernel/sched/idle.c:109
cpuidle_idle_call kernel/sched/idle.c:191 [inline]
do_idle+0x3f9/0x570 kernel/sched/idle.c:303
cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:266
secondary_startup_64_no_verify+0xce/0xdb
</TASK>
----------------
Code disassembly (best guess):
0: 75 fe jne 0x0
2: ff 4c 89 e2 decl -0x1e(%rcx,%rcx,4)
6: 48 89 ef mov %rbp,%rdi
9: 5d pop %rbp
a: 41 5c pop %r12
c: 31 f6 xor %esi,%esi
e: e9 7c f8 5e fc jmpq 0xfc5ef88f
13: cc int3
14: cc int3
15: cc int3
16: cc int3
17: cc int3
18: cc int3
19: cc int3
1a: cc int3
1b: cc int3
1c: cc int3
1d: cc int3
1e: cc int3
1f: eb 07 jmp 0x28
21: 0f 00 2d 77 9a 4d 00 verw 0x4d9a77(%rip) # 0x4d9a9f
28: fb sti
29: f4 hlt
* 2a: c3 retq <-- trapping instruction
2b: 0f 1f 40 00 nopl 0x0(%rax)
2f: 41 54 push %r12
31: be 08 00 00 00 mov $0x8,%esi
36: 53 push %rbx
37: 65 48 8b 1c 25 c0 6e mov %gs:0x26ec0,%rbx
3e: 02 00

```
