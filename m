Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B400247E74F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349583AbhLWR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhLWR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:58:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE67C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:58:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59750B81CB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 17:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA96C36AE5;
        Thu, 23 Dec 2021 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640282313;
        bh=EA2mSpp8MToPpanMC2fJhz1Qc0bXPtZhL0Gu1ndCjhw=;
        h=Date:From:To:Cc:Subject:From;
        b=GgoNejO4HfNfHdpuqTOnKQ7VJnZL7o/hQvqIErZvwiPD7lafOiAPlIZfCIMzft46D
         qn46nvD60MMLrgbs8w7hgcCQhOO76vpyRRx8dAxynTwjlwHJe9FqjjVSP10pilWKpG
         4YrawfgEY9Q6cal5QP8anCfOB2jGBrylSYbctyTlGLVnzVmCKKdaXRMSgfypzjf1WF
         4L4z3VbgyrhK22nxpIiw8FJFwP0iLrGl4gmGfFAzsvCpfjlZD4oufqZK5M6d+5Gq78
         CsM3xp9riXREu6Laq+cGYMZP9yYJ/W2T23ApbAWawgMFe4mr9h4tw+oiMvP7u+3b7p
         finjb4xqHg3jg==
Date:   Thu, 23 Dec 2021 10:58:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Issue with booting multi_v5_defconfig kernel with GCC 11
Message-ID: <YcS4xVWs6bQlQSPC@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My apologies if this has already been reported somewhere, I did a search
of lore.kernel.org and did not really come up with anything.

I was recently investigating a regression in booting a
multi_v5_defconfig kernel on -next [1] and I noticed that building the
kernel with GCC 11 causes it to no longer boot due to a panic in
da850_evm_config_emac().

$ qemu-system-arm \
    -initrd rootfs.cpio \
    -machine palmetto-bmc \
    -no-reboot \
    -dtb arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dtb \
    -display none \
    -kernel arch/arm/boot/zImage \
    -m 512m \
    -nodefaults \
    -serial mon:stdio
...
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000020
pgd = (ptrval)
[00000020] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0 #1
Hardware name: Generic DT based system
PC is at da850_evm_config_emac+0x1c/0x120
LR is at do_one_initcall+0x50/0x1e0
pc : [<c0b8f830>]    lr : [<c00098f4>]    psr: a0000153
sp : c106dee8  ip : c0b863e0  fp : c0b863e0
r10: c0dd3000  r9 : c0b4bea0  r8 : c0bc8830
r7 : 00000000  r6 : c0dd3288  r5 : ffffe000  r4 : c0b8f814
r3 : 00000000  r2 : 0000086d  r1 : ffffffff  r0 : 00000000
Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 40004000  DAC: 00000053
Register r0 information: NULL pointer
Register r1 information: non-paged memory
Register r2 information: non-paged memory
Register r3 information: NULL pointer
Register r4 information: non-slab/vmalloc memory
Register r5 information: non-paged memory
Register r6 information: non-slab/vmalloc memory
Register r7 information: NULL pointer
Register r8 information: non-slab/vmalloc memory
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: non-slab/vmalloc memory
Register r12 information: non-slab/vmalloc memory
Process swapper (pid: 1, stack limit = 0x(ptrval))
Stack: (0xc106dee8 to 0xc106e000)
dee0:                   c0b8f814 ffffe000 c0dd3000 00000000 c0bc8830 c00098f4
df00: c10ad600 c10ad608 c10ad5ff c003d8d8 00000000 c0ada9f0 000000f5 00000000
df20: 00000000 c0b863e0 00000006 00000006 00000011 c10ad615 00000000 6d86ee9a
df40: c1001100 00000006 000000f5 6d86ee9a c0bc884c c0bd9808 00000007 c10ad600
df60: c0bc8850 c0b87134 00000006 00000006 00000000 c0b863e0 00000000 000000f5
df80: c106c000 00000000 c08fa5e8 00000000 00000000 00000000 00000000 00000000
dfa0: 00000000 c08fa5f8 00000000 c0008548 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c0b8f830>] (da850_evm_config_emac) from [<c00098f4>] (do_one_initcall+0x50/0x1e0)
[<c00098f4>] (do_one_initcall) from [<c0b87134>] (kernel_init_freeable+0x17c/0x204)
[<c0b87134>] (kernel_init_freeable) from [<c08fa5f8>] (kernel_init+0x10/0x108)
[<c08fa5f8>] (kernel_init) from [<c0008548>] (ret_from_fork+0x14/0x2c)
Exception stack(0xc106dfb0 to 0xc106dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e59f20dc e5931000 e5963044 e1510002 (e5d37020)
Unpacking initramfs...
---[ end trace 4a15a77f3ebdc580 ]---

Initially, I thought this might be a GCC regression so I bisected and
landed on commit dae673abd37 ("tree-optimization/97307 - improve sinking
of loads"), which I really think just exposes something here.

If I add some rudimentary debug prints, I can see that
soc_info->emac_pdata is NULL, both with GCC 10 and GCC 11.

GCC 11:

da850_evm_config_emac: soc_info: c0dd3288
da850_evm_config_emac: emac_pdata: 00000000

GCC 10:

da850_evm_config_emac: soc_info: c0dd7288
da850_evm_config_emac: emac_pdata: 00000000

I don't really see how that is possible, as I can see this member
assigned in the davinci_soc_info_* variables but maybe there is some
race during initialization or problem because the QEMU machine is not
one of these machines?

I think that the GCC commit just makes it so that the rmii_en member is
read earlier, rather than at the point of use.

Regardless, something like this resolves this panic for me but I have no
idea if it is proper or not, hence just the report :)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 428012687a80..7f7f6bae21c2 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1101,11 +1101,13 @@ static int __init da850_evm_config_emac(void)
        int ret;
        u32 val;
        struct davinci_soc_info *soc_info = &davinci_soc_info;
-       u8 rmii_en = soc_info->emac_pdata->rmii_en;
+       u8 rmii_en;

        if (!machine_is_davinci_da850_evm())
                return 0;

+       rmii_en = soc_info->emac_pdata->rmii_en;
+
        cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);

        val = __raw_readl(cfg_chip3_base);

[1]: https://lore.kernel.org/r/YcNsG0Lp94V13whH@archlinux-ax161/

Cheers,
Nathan
