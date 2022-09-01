Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4535A9DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiIARHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIARHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:07:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9117C1FA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:06:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d5so9369665wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/iEsgNZ3zxpxlJkR6d7YtrGS/CQaCI0EY2hUj7o3h64=;
        b=Ee1QFrzr+w2lzMP6it3D6ebBLJYAn8hfKgdayDo+Sy1oBSGhRUfB1CEhU3uDNBqvWA
         6yQJQMFM4yqlmaiBxDV8qdZ/KlGBB3GFTSB6UVNVMP1IVyLyt4Eyo2AiP/SuN+01xmin
         EkHEvAyPzl9PSqFFUdEr6SBTDxhaGcnZzFUb83z183+Ag5QUOSeha/epVAIP6QC7n3oL
         Fy1AM9VaWpQqW2CkvS8tQ4/7CaxBknZNZDJF6DtxHb17qeiSB0RQM3WGe6t/evK636iO
         RnagpUfJzkewxJSzqbKjYradEQRU5Q60jHu3YV0f/HswBaPELPbZ6vXK7EvCXw9Ed4LH
         MMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/iEsgNZ3zxpxlJkR6d7YtrGS/CQaCI0EY2hUj7o3h64=;
        b=Y6+X000ldnuCQq61CsVL1I86XibM52EbV34yR56IzY+ZnMb5iahJwsB/oJdua6TuDD
         uyhsMH5bYjN8rPaow4UCHI49deAtmMVzAQfyF08tAQsxsc5ZYLM8xejbjhWbB83V6iGh
         dXk0Ir/rCDtdKapTZTuVMDNzfvWOSKtN0EKBIEH2rurZluJN+ndJo7vVtby9TPlL789F
         w5sgHKl3MsBWyV03jzrn/wx7VqkPFf3szkSxIUC+A4/xKDZvDAZirCMDqxSL1UjfFi1p
         cux48/dtJqzXjK1KqOTV67KIGN54Za2Y1GksGp3ZdX4V+1Y2EVtFs5OxQ9hzbtn27dP9
         A/Mg==
X-Gm-Message-State: ACgBeo3Wk40WL/h5+b5PTr9rpWx1Lol875yJpl79eXBMvglNp01wIcNy
        ua0lVCx4jIvF6LjmzapZDgsL0g==
X-Google-Smtp-Source: AA6agR6wVP7z9OTfACJ4zx4paCVV9QaiSFq4ViwDVIHPQ5I5xMVuz3DXsOWA1l9/+3/tBPqlf7Nwdw==
X-Received: by 2002:a05:600c:3d93:b0:3a6:1ac3:adf8 with SMTP id bi19-20020a05600c3d9300b003a61ac3adf8mr60773wmb.125.1662052015407;
        Thu, 01 Sep 2022 10:06:55 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id v12-20020adfebcc000000b00224f5bfa890sm15075807wrn.97.2022.09.01.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 10:06:55 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Subject: [PATCH] riscv: fix early reserved memory setup
Date:   Thu,  1 Sep 2022 18:06:28 +0100
Message-Id: <20220901170627.2329578-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Currently, RISC-V sets up reserved memory using the "early" copy of the
device tree. As a result, when trying to get a reserved memory region
in a remoteproc driver using of_reserved_mem_lookup(), the pointer to
a reserved memory region's name is using an early, pre-virtual-memory
address which causes a kernel panic.

For example, a node like so:
  reserved-memory {
  	ranges;
  	#size-cells = <2>;
  	#address-cells = <2>;

  	fabricbuf0: fabricbuf@0 {
  		compatible = "shared-dma-pool";
  		reg = <0x0 0xae000000 0x0 0x2000000>;
  		label = "fabricbuf0-ddr-c";
  	};
  };

Would lead to the following (albeit triggered here by some debug code):

  OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
  Machine model: Microchip PolarFire-SoC Icicle Kit
  earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '115200n8')
  printk: bootconsole [ns16550a0] enabled
  printk: debug: skip boot console de-registration.
  efi: UEFI not found.

<initial read of the name after of_reserved_mem_lookup()>

  OF: reserved mem: debug name is fabricbuf@ae000000

<a tlb flush happens here>

<accessing the name post flush>
  Unable to handle kernel paging request at virtual address 00000000401c31ac
  Oops [#1]
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00001-g0d9d6953d834 #1
  Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
  epc : string+0x4a/0xea
   ra : vsnprintf+0x1e4/0x336
  epc : ffffffff80335ea0 ra : ffffffff80338936 sp : ffffffff81203be0
   gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 0000000000000000
   t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : ffffffff81203c20
   s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 0000000000000000
   a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : ffffffffffffffff
   a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : ffffffffffffffff
   s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 0000000000000008
   s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 00000000ffffff00
   s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 0000000000000002
   s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : ffffffff812f3617
   t5 : ffffffff812f3618 t6 : ffffffff81203d08
  status: 0000000200000100 badaddr: 00000000401c31ac cause: 000000000000000d
  [<ffffffff80338936>] vsnprintf+0x1e4/0x336
  [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
  [<ffffffff80055d86>] vprintk_emit+0x56/0x192
  [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
  [<ffffffff800563d2>] vprintk+0x72/0x80
  [<ffffffff806813b2>] _printk+0x36/0x50
  [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
  [<ffffffff808057ec>] paging_init+0x528/0x5bc
  [<ffffffff808031ae>] setup_arch+0xd0/0x592
  [<ffffffff8080070e>] start_kernel+0x82/0x73c
  ---[ end trace 0000000000000000 ]---

Move early_init_fdt_scan_reserved_mem() further along the boot sequence
so that the names are using the correct virtual memory addresses.

Reported-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Fixes: 922b0375fc93 ("riscv: Fix memblock reservation for device tree blob")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I mentioned this patch in [0]. We need the reserved mem lookup
function so that we can implement remoteproc on PolarFire SoC, so since
I hava heard nothing really on [0] I figured I would send this patch to
at least unblock that work. The debug code to trigger the issue is
there too.

There's a very good chance that this is not the correct fix, but it is
the most brainless fix for the problem. The probability of it being
wrong is only increased by the other issue pointed out in [0].

0 - https://lore.kernel.org/linux-riscv/7a86cf8e-f40f-29ae-bc7c-8a20cc5b9850@microchip.com/
---
 arch/riscv/kernel/setup.c | 1 +
 arch/riscv/mm/init.c      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 95ef6e2bf45c..62ece4fbc92a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -283,6 +283,7 @@ void __init setup_arch(char **cmdline_p)
 	else
 		pr_err("No DTB found in kernel mappings\n");
 #endif
+	early_init_fdt_scan_reserved_mem();
 	misc_mem_init();
 
 	init_resources();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b56a0a75533f..50a1b6edd491 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -262,7 +262,6 @@ static void __init setup_bootmem(void)
 			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 	}
 
-	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-- 
2.37.1

