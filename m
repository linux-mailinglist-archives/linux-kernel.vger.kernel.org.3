Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5F51354D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbiD1NjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347389AbiD1NjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D442A33;
        Thu, 28 Apr 2022 06:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8A260DED;
        Thu, 28 Apr 2022 13:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12470C385A9;
        Thu, 28 Apr 2022 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152961;
        bh=yIaVBevNnUct48c1FDbDUtaqNwTUvvToj1PXt1VbxdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMnGMBkdRsKJEoGLQgofnWhOiCqvLTEuwVgsYTALGgohsq0jhEv6labHfq30uHEau
         5yAEwuCYfJ2ZLWRoHeWsEj8NRgA4h57+1ptZ/G8M+U1rgHNsludJNc6MesziV7DG8K
         dqW8bC5h4//uNSr2VWbQDF07r3t7GoajTJEU62fnrIpholeg4f3ZjJ+uRNnVwPZ+cb
         BOW2am2YKYPfPZ++7zHgEOQ2+BPoa2hFZCH3SuAloTEbKDxoUGD0mtxvGm9OJ/CPJU
         ZruEifKXb3QIYMm90nxkuzGoQoGFL4qZYtBNyW2Rgi4uocmMmUTvP+Bu1lReh2B7mU
         YfEkd2r5CNrPQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 6/6] ARM: omap1: add back omap_set_dma_priority() stub
Date:   Thu, 28 Apr 2022 15:31:58 +0200
Message-Id: <20220428133210.990808-7-arnd@kernel.org>
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

One of my multiplatform patches went a little too far and removed
a declaration that is needed for compile-testing the omapfb
driver on non-OMAP1 platforms:

  arm-linux-gnueabi-ld: drivers/video/fbdev/omap/omapfb_main.o: in function `omapfb_do_probe':
  omapfb_main.c:(.text+0x41ec): undefined reference to `omap_set_dma_priority'

Add back the inline stub, and in turn hide the definition when
omapfb is disabled, like we do for the usb specific bits.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 52ef8efcb75e ("dma: omap: hide legacy interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/omap-dma.c | 18 ++----------------
 include/linux/omap-dma.h       |  7 +++++++
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/omap-dma.c b/arch/arm/mach-omap1/omap-dma.c
index e504f65cdc1b..f7e62de427f3 100644
--- a/arch/arm/mach-omap1/omap-dma.c
+++ b/arch/arm/mach-omap1/omap-dma.c
@@ -99,7 +99,7 @@ static inline void set_gdma_dev(int req, int dev)
 	omap_writel(l, reg);
 }
 
-#ifdef CONFIG_ARCH_OMAP1
+#if IS_ENABLED(CONFIG_FB_OMAP)
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
@@ -129,22 +129,8 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 		omap_writel(l, reg);
 	}
 }
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-void omap_set_dma_priority(int lch, int dst_port, int priority)
-{
-	u32 ccr;
-
-	ccr = p->dma_read(CCR, lch);
-	if (priority)
-		ccr |= (1 << 6);
-	else
-		ccr &= ~(1 << 6);
-	p->dma_write(ccr, CCR, lch);
-}
-#endif
 EXPORT_SYMBOL(omap_set_dma_priority);
+#endif
 
 #if IS_ENABLED(CONFIG_USB_OMAP)
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 254b4e10511b..6f6c31e3fb93 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -294,7 +294,14 @@ struct omap_system_dma_plat_info {
 
 extern struct omap_system_dma_plat_info *omap_get_plat_info(void);
 
+#if defined(CONFIG_ARCH_OMAP1)
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
+#else
+static inline void omap_set_dma_priority(int lch, int dst_port, int priority)
+{
+}
+#endif
+
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
 			void *data, int *dma_ch);
-- 
2.29.2

