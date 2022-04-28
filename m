Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B4513548
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347345AbiD1NjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347441AbiD1NjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:39:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F2369EB;
        Thu, 28 Apr 2022 06:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4A82CE2A9E;
        Thu, 28 Apr 2022 13:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0573C385AA;
        Thu, 28 Apr 2022 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152946;
        bh=Yem0bnNbFNUn8TX2xhzhUAMAwGC5I1kgSwaYdUe5wy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SikuTTS8Ib+DRjwDF3ntqojf93NLALINtVefz2S6XvMKLTqK5OcTF4/FKaozYfVOl
         LKnjO2M5r1toFFSRozzHAX6hO0bafXWbGhpsnqMaF2tNFkBsbt8mjtAQitb5vyNcBQ
         N0s0Ht5cpl7CE37rIktOftWqqRK+Y6c471sWVF/ysElfijwmn317b2HkhDhJMSCeHJ
         +5kduGOi84j3U+A93i83z6sqr+SpZZSLOEkz5VmIO8DsnkDFwfpYTnPhDzwNrsaFeC
         OgFjDb+rq92hvyTAyB9vuaFOMCQ7NroHNBPoDYO0nL6qvVcwH+42Z/hBJycNuLxsmI
         8Jo+0f8KB8qQg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 5/6] ARM: omap2: fix missing declaration warnings
Date:   Thu, 28 Apr 2022 15:31:57 +0200
Message-Id: <20220428133210.990808-6-arnd@kernel.org>
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

Moving the plat-omap files triggered a sparse warning for omap1 and
omap2 that is now in a different file from before. Found some more sparse
warnings here that I address by making sure the declaration is visible
to both the caller and the callee, or they are static

mach-omap1/fb.c:33:17: warning: symbol 'omap_fb_resources' was not declared. Should it be static?
mach-omap1/timer32k.c:215:12: warning: symbol 'omap_init_clocksource_32k' was not declared. Should it be static?
mach-omap1/i2c.c:36:12: warning: symbol 'omap_i2c_add_bus' was not declared. Should it be static?
mach-omap1/i2c.c:115:12: warning: symbol 'omap_register_i2c_bus_cmdline' was not declared. Should it be static?
mach-omap1/i2c.c:140:12: warning: symbol 'omap_register_i2c_bus' was not declared. Should it be static?
mach-omap2/dma.c:180:34: warning: symbol 'dma_plat_info' was not declared. Should it be static?
mach-omap2/omap4-common.c:116:6: warning: symbol 'omap_interconnect_sync' was not declared. Should it be static?
mach-omap2/omap-iommu.c:113:5: warning: symbol 'omap_iommu_set_pwrdm_constraint' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/fb.c           |  2 +-
 arch/arm/mach-omap1/i2c.c          |  1 +
 arch/arm/mach-omap1/timer32k.c     |  2 +-
 arch/arm/mach-omap2/common.h       | 13 ++++++++++++-
 arch/arm/mach-omap2/dma.c          |  1 +
 arch/arm/mach-omap2/omap-iommu.c   |  1 +
 arch/arm/mach-omap2/pdata-quirks.c | 11 -----------
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/fb.c b/arch/arm/mach-omap1/fb.c
index a4538c231f66..b6e952b03838 100644
--- a/arch/arm/mach-omap1/fb.c
+++ b/arch/arm/mach-omap1/fb.c
@@ -30,7 +30,7 @@ static struct omapfb_platform_data omapfb_config;
 
 static u64 omap_fb_dma_mask = ~(u32)0;
 
-struct resource omap_fb_resources[] = {
+static struct resource omap_fb_resources[] = {
 	{
 		.name  = "irq",
 		.start = INT_LCD_CTRL,
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index f574eb0bcc0b..22f945360599 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -10,6 +10,7 @@
 
 #include "mux.h"
 #include "soc.h"
+#include "i2c.h"
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 560cd16568a7..410d17d1d443 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -212,7 +212,7 @@ static void omap_read_persistent_clock64(struct timespec64 *ts)
  * Returns 0 upon success or negative error code upon failure.
  *
  */
-int __init omap_init_clocksource_32k(void __iomem *vbase)
+static int __init omap_init_clocksource_32k(void __iomem *vbase)
 {
 	int ret;
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 32f58f58515e..bd5981945239 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -266,7 +266,7 @@ extern void omap4_sar_ram_init(void);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap4_mpuss_early_init(void);
 extern void omap_do_wfi(void);
-
+extern void omap_interconnect_sync(void);
 
 #ifdef CONFIG_SMP
 /* Needed for secondary core boot */
@@ -360,5 +360,16 @@ extern int omap_dss_reset(struct omap_hwmod *);
 /* SoC specific clock initializer */
 int omap_clk_init(void);
 
+#if IS_ENABLED(CONFIG_OMAP_IOMMU)
+int omap_iommu_set_pwrdm_constraint(struct platform_device *pdev, bool request,
+				    u8 *pwrst);
+#else
+static inline int omap_iommu_set_pwrdm_constraint(struct platform_device *pdev,
+						  bool request, u8 *pwrst)
+{
+	return 0;
+}
+#endif
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index dfc9b21ff19b..830cd4e7eb44 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -30,6 +30,7 @@
 #include <linux/omap-dma.h>
 
 #include "soc.h"
+#include "common.h"
 
 static const struct omap_dma_reg reg_map[] = {
 	[REVISION]	= { 0x0000, 0x00, OMAP_DMA_REG_32BIT },
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 93c20bbd7b7e..9c8a85198e16 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -13,6 +13,7 @@
 
 #include "clockdomain.h"
 #include "powerdomain.h"
+#include "common.h"
 
 struct pwrdm_link {
 	struct device *dev;
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index e7fd29a502a0..13f1b89f74b8 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -43,17 +43,6 @@ struct pdata_init {
 static struct of_dev_auxdata omap_auxdata_lookup[];
 static struct twl4030_gpio_platform_data twl_gpio_auxdata;
 
-#if IS_ENABLED(CONFIG_OMAP_IOMMU)
-int omap_iommu_set_pwrdm_constraint(struct platform_device *pdev, bool request,
-				    u8 *pwrst);
-#else
-static inline int omap_iommu_set_pwrdm_constraint(struct platform_device *pdev,
-						  bool request, u8 *pwrst)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_MACH_NOKIA_N8X0
 static void __init omap2420_n8x0_legacy_init(void)
 {
-- 
2.29.2

