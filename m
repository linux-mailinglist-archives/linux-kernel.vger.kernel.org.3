Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3E51354C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347317AbiD1Nin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347313AbiD1Nii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC1286E4;
        Thu, 28 Apr 2022 06:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A415660DED;
        Thu, 28 Apr 2022 13:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED2AC385AA;
        Thu, 28 Apr 2022 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152921;
        bh=eRESxdZdW2NvpGzb01TfQEFR4FhwuOlS8/l4GHlSOFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rt+QKL1BqYM26+KugcnmLw09URlLnzAmM8qXYt40z3sBMONaZ84qe3yfcXJ8Y53k6
         Azs2fEwA1c0s99IA1V1p7SfpHy8Ia2XwpXdle2qwKFBXoiUZXXVNUlGP8J2Ak2UuZX
         LQkUlCDG4qacLuEeudTBwOj6ONrTr0MJB2j6gqAsRTLfkTFD9xkoJzYlNIbUrlWOAb
         6Y8cn3DHJ0cXh2YGSsYc3iyjQpk6iZ2LT6sWBBubVOs52UfEswyQdR7aAgSNsganrR
         0z4v9BJ1zfVx1HSoTaSmWavz4v7JWCawIv/BLJl+UMuwk7QP7NDBbZa6XnZwZF4bkC
         Kcshuoeja6llQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 4/6] ARM: omap: fix address space warnings from sparse
Date:   Thu, 28 Apr 2022 15:31:56 +0200
Message-Id: <20220428133210.990808-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220428133210.990808-1-arnd@kernel.org>
References: <20220428133210.990808-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Moving sram code from plat-omap got the attention of the kernel test robot.

I found a few more places with related warnings because the sram
references are a mix of kernel pointers and __iomem pointers:

mach-omap1/sram-init.c:56:17: warning: cast removes address space '__iomem' of expression
mach-omap1/board-ams-delta.c:667:9: warning: incorrect type in argument 1 (different base types)
mach-omap2/sram.c:78:17: warning: cast removes address space '__iomem' of expression
mach-omap2/omap4-common.c:142:27: warning: incorrect type in assignment (different address spaces)
mach-omap2/omap4-common.c:142:27:    expected void [noderef] __iomem *static [toplevel] sram_sync
mach-omap2/omap4-common.c:142:27:    got void *
mach-omap2/pm34xx.c:113:45: warning: incorrect type in argument 1 (different address spaces)
mach-omap2/pm34xx.c:113:45:    expected void [noderef] __iomem *save_regs
mach-omap2/pm34xx.c:113:45:    got void *extern [addressable] [toplevel] omap3_secure_ram_storage

There is no good solution here, as sram is a bit special in this
regard. Change the annotations to at least shut up the warnings.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-ams-delta.c | 2 +-
 arch/arm/mach-omap1/sram-init.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index cd97df48686e..651c28d81132 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -664,7 +664,7 @@ static void __init ams_delta_latch2_init(void)
 {
 	u16 latch2 = 1 << LATCH2_PIN_MODEM_NRESET | 1 << LATCH2_PIN_MODEM_CODEC;
 
-	__raw_writew(latch2, LATCH2_VIRT);
+	__raw_writew(latch2, IOMEM(LATCH2_VIRT));
 }
 
 static void __init ams_delta_init(void)
diff --git a/arch/arm/mach-omap1/sram-init.c b/arch/arm/mach-omap1/sram-init.c
index 0e3ec32a008e..27c42e2a21cc 100644
--- a/arch/arm/mach-omap1/sram-init.c
+++ b/arch/arm/mach-omap1/sram-init.c
@@ -53,7 +53,7 @@ static void *omap_sram_push_address(unsigned long size)
 	new_ceil = ROUND_DOWN(new_ceil, FNCPY_ALIGN);
 	omap_sram_ceil = IOMEM(new_ceil);
 
-	return (void *)omap_sram_ceil;
+	return (void __force *)omap_sram_ceil;
 }
 
 void *omap_sram_push(void *funcp, unsigned long size)
-- 
2.29.2

