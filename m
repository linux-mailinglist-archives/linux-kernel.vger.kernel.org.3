Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799F7475C10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbhLOPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244050AbhLOPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:44:23 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:44:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id s11so19717154ilv.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZY9NNgQz1Cb2zFAORN4jsgilpdlgj2d87pcnbidqzeM=;
        b=Cg0qWt/ceFcBSrFixDf7eQEmcQc+TvIFEyfWzowhbJ2AAwM06qW84wvEpqABbDzNPh
         BA118I+QYprnfIIqq62tuSOtbFoCbMTUbl4WBFGNH0iJcQD7oWQCT/wlK6FkRTQb6jnn
         vOE52AU9ZDcLhkSGHjwA8mp+Kmosdr0C/a0GBTJHCLHIDmYbVCzOl4Sw9OVeZeD4iyNT
         5psMVjmESSS867U/9XAaiCq7UTYTY54FpwgyIUEod/BWDPFYRY/ebwkmz7+CnGhHMYxo
         0IvbEAvK2zBGYEmfkoYCb0ZqocFlvJ4zRejmwQDT2x7gCt+hk5MRGifGbH5dBC0NrNbm
         6y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZY9NNgQz1Cb2zFAORN4jsgilpdlgj2d87pcnbidqzeM=;
        b=GSqFViQbDl6PwNzcc31Lzrc0JYOcs0F2ssvTb/t1J4iuez0qjsBeAGcndwHt5aN8O6
         h/PcxgApa13+H9nh5rcjseKSLe9puIh97CQp3HeIXbdvJkSElBti8+2dcwLXJWf5+iIT
         JWgW5k4R2axdt8fJIYyJeMU3CYRass8C5xARfgtis3anzxwp7/M6yyZle6M8Vi+oSSg+
         lS/6H+162TpG/U8nlUbGhI0vFhCPRIKMXel7yvQ6YorvadR1cEACdbgoWTwbRy4+bYvW
         ph0/O0yRgRvmETh22dPcHzSiRcixFkaH0IXQQMZnncnkqcVnolNhy+4WDes+/juW9Ygm
         JUBg==
X-Gm-Message-State: AOAM533Aexf4OOhFJYaUUJ2mnexCE28nhGeQjRq4RUMCBxtGJ1Q/PSNu
        ATCCGfvoHsaOzwDhD+3KWLV09ecw28g4VF/k2QFeQAIwiVFzhQ==
X-Google-Smtp-Source: ABdhPJwipDo0z7vcK9jh16urW4g2HTN/r6+PK/Ych4ywaK13/+8jgaIA7CyBrAC02cLMjU634y35cv+SFRrt7sqeLVY=
X-Received: by 2002:a05:6e02:1806:: with SMTP id a6mr6036269ilv.125.1639583062820;
 Wed, 15 Dec 2021 07:44:22 -0800 (PST)
MIME-Version: 1.0
From:   Florent Carli <fcarli@gmail.com>
Date:   Wed, 15 Dec 2021 16:44:12 +0100
Message-ID: <CAJuRqcAc19KZYik7T_dYFoqt_wX4QPHKBsh9A8BJwYE7uxs_1A@mail.gmail.com>
Subject: Bug in vhost-net with RT kernels with SMP
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

We encounter a bug in host-net with RT kernels running on SMP.

Our setup is:
- a multi cpu virtualized hypervisor that runs an RT kernel with SMP
(tested with 4.19 and 5.10) (originally I encountered the bug with a
physical host but we virtualized it to facilitate debugging)
- a guest running a standard kernel with a tap interface on
virtio/vhost-net (one vcpu)
- this tap is bridged with the host so that they can ping each other
- the guest is pinging the host as quickly as possible ("i=0; while [
$i -lt 100000 ]; do ping -c 1 10.10.10.2; i=$((i+1)); done")
- it may crash after some time, but to crash "quicker", we have found
that other network trafics at the same time do help, so we have the
host ping the guest the same way. Having to manage several network
flows at the same time seems to be key to triggering this bug.

After a few seconds, we get the following back trace:

[  116.435285] WARNING: CPU: 2 PID: 365 at fs/eventfd.c:74
eventfd_signal+0x79/0x90
[  116.435303] Modules linked in:
[  116.435305] CPU: 2 PID: 365 Comm: vhost-361 Not tainted
5.10.83-rt58-mainline-rt #1
[  116.435307] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  116.435308] BUG: using smp_processor_id() in preemptible [00000000]
code: vhost-361/365
[  116.435310] caller is print_stop_info+0x16/0x30
[  116.435317] CPU: 2 PID: 365 Comm: vhost-361 Not tainted
5.10.83-rt58-mainline-rt #1
[  116.435319] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  116.435320] Call Trace:
[  116.435330]  dump_stack+0x57/0x6a
[  116.435362]  check_preemption_disabled+0xc8/0xd0
[  116.435377]  print_stop_info+0x16/0x30
[  116.435382]  show_regs+0x10/0x40
[  116.435399]  __warn+0x6d/0xa0
[  116.435410]  ? eventfd_signal+0x79/0x90
[  116.435413]  report_bug+0x95/0xb0
[  116.435434]  handle_bug+0x41/0x80
[  116.435437]  exc_invalid_op+0x14/0x60
[  116.435440]  asm_exc_invalid_op+0x12/0x20
[  116.435446] RIP: 0010:eventfd_signal+0x79/0x90
[  116.435449] Code: 01 00 00 00 be 03 00 00 00 4c 89 ef e8 30 ee e6
ff 65 ff 0d 69 bf 39 43 4c 89 ef e8 51 a7 77 00 4c 89 e0 5b 5d 41 5c
41 5d c3 <0f> 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 0f 1f 84 00 00
00 00
[  116.435451] RSP: 0018:ffffb0e480793d50 EFLAGS: 00010202
[  116.435452] RAX: 0000000000000001 RBX: ffff9ff7c5e94b10 RCX: 0000000000000000
[  116.435454] RDX: 0000000000008ac4 RSI: 0000000000000001 RDI: ffff9ff7c5e144b8
[  116.435455] RBP: 0000000000000100 R08: 0000000000000000 R09: 0000000000000000
[  116.435456] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ff7c53a3c40
[  116.435457] R13: ffffb0e480793e18 R14: ffff9ff7c5e90000 R15: ffff9ff7c5e94b10
[  116.435462]  vhost_tx_batch.constprop.0+0xa4/0x170
[  116.435474]  handle_tx_copy+0x156/0x570
[  116.435477]  ? __vhost_add_used_n+0x210/0x210
[  116.435479]  handle_tx+0xa0/0xe0
[  116.435481]  vhost_worker+0x8e/0xd0
[  116.435483]  kthread+0x17c/0x1a0
[  116.435491]  ? __kthread_parkme+0xa0/0xa0
[  116.435495]  ret_from_fork+0x22/0x30
[  116.435500] RIP: 0010:eventfd_signal+0x79/0x90
[  116.435503] Code: 01 00 00 00 be 03 00 00 00 4c 89 ef e8 30 ee e6
ff 65 ff 0d 69 bf 39 43 4c 89 ef e8 51 a7 77 00 4c 89 e0 5b 5d 41 5c
41 5d c3 <0f> 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 0f 1f 84 00 00
00 00
[  116.435504] RSP: 0018:ffffb0e480793d50 EFLAGS: 00010202
[  116.435505] RAX: 0000000000000001 RBX: ffff9ff7c5e94b10 RCX: 0000000000000000
[  116.435506] RDX: 0000000000008ac4 RSI: 0000000000000001 RDI: ffff9ff7c5e144b8
[  116.435507] RBP: 0000000000000100 R08: 0000000000000000 R09: 0000000000000000
[  116.435508] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ff7c53a3c40
[  116.435509] R13: ffffb0e480793e18 R14: ffff9ff7c5e90000 R15: ffff9ff7c5e94b10
[  116.435510] FS:  0000000000000000(0000) GS:ffff9ff7fbd00000(0000)
knlGS:0000000000000000
[  116.435513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  116.435515] CR2: 00007fff835d2080 CR3: 0000000107968002 CR4: 0000000000372ee0
[  116.435516] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  116.435517] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  116.435518] Call Trace:
[  116.435519]  vhost_tx_batch.constprop.0+0xa4/0x170
[  116.435521]  handle_tx_copy+0x156/0x570
[  116.435523]  ? __vhost_add_used_n+0x210/0x210
[  116.435525]  handle_tx+0xa0/0xe0
[  116.435527]  vhost_worker+0x8e/0xd0
[  116.435529]  kthread+0x17c/0x1a0
[  116.435531]  ? __kthread_parkme+0xa0/0xa0
[  116.435532]  ret_from_fork+0x22/0x30

The tap interface will still work but for about as long as it took to
crash, as if the situation needs to happen a second time for the
interface to stop working.
Anyway, the tap interface will fail shortly after: it will still be
there, but no trafic will flow between the guest and host (with no
kernel log or error message this time).

We can usually get the interface back up, by issuing "ip link set tap0
down", "ip link set tap0 up" from within the guest.
If we try the experiment once again, the tap will fail but we won't
get a new backtrace.
We get the backtrace only once, and we need to restart the host if we
want to see it again.
It's like the crash sets the kernel in an "unstable mode", in which
the vhost-net interfaces will easily fail (probably when the situation
will present itself for the "second" time).

A first analyzis was done on the #linux-rt irc channel:
"huh, looks like the underlying issue is hitting the WARN_ON_ONCE()
condition in eventfd_signal(), but in the bug handler (which
apparently is preemptible), we get into print_stop_info() and try to
use smp_processor_id() in that context, which is wrong because thigns
are preemptible.
I can't see the smp_processor_id() usage in mainlin (I don't have an
RT tree to hand), but someone with more RT knowledge might want to
look at that"

We were recommended to post to LKLM for further analysis.
Thanks.
