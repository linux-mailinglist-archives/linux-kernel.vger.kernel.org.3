Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A941C598697
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiHRO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbiHRO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1342BD0BC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391CC60C95
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D519C43470;
        Thu, 18 Aug 2022 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834609;
        bh=RlvIHjnFmvmSJ2Sj9XCES+dsJBYvTPzMIPgDbH08k5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICT3toaNk/oHDQKBfW01iuipifxP+CV77V0ELUgSduNyT+8gvtSCw90om68kyv4V9
         FCyNVZiTMCH8uB9CmGBFkXGEvvoBh5R+Z6rqltTPEuDbvnExjLuLyXZlViM9pas96d
         okW6ameFgTn3ynwtOTKLUkZQtcwjFDwG88Us9fNGXj2Peu6/7b3pvR7IsYJx1PO0sj
         VIi5l9bCVrtHLzVDU71E+q6SadVoKAspRKy1aFsH0CZKpejrFv4B4CqFUs3C43A4EJ
         i+BoTAznr94FEShmCTEUv+VyM1anlTJZp7UxpDyld1v502sD7pVkcM1VTuis+SQvfV
         56W9AKtOe53LA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 4/5] ARM: fix CPU_V6 dependencies
Date:   Thu, 18 Aug 2022 16:56:15 +0200
Message-Id: <20220818145616.3156379-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818145616.3156379-1-arnd@kernel.org>
References: <20220818145616.3156379-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_XIP_KERNEL must not be combined with CONFIG_SMP_ON_UP
because the patching of read-only data does not work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig       | 1 +
 arch/arm/mach-omap2/Kconfig     | 1 +
 arch/arm/mach-versatile/Kconfig | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ab767f059929..9308e9894be5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -41,6 +41,7 @@ comment "ARM1136 platforms"
 
 config SOC_IMX31
 	bool "i.MX31 support"
+	depends on !SMP || !XIP_KERNEL # for SMP_ON_UP
 	select CPU_V6
 	select MXC_AVIC
 	help
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3b53dda9ec79..f2ce262958c4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -8,6 +8,7 @@ config OMAP_HWMOD
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_MULTI_V6
+	depends on !SMP || !XIP_KERNEL # for SMP_ON_UP
 	select ARCH_OMAP2PLUS
 	select CPU_V6
 	select OMAP_HWMOD
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index 2ef226194c3a..25723b0c63dd 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -21,6 +21,7 @@ menuconfig ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
 	depends on CPU_LITTLE_ENDIAN || ARCH_MULTI_V6
+	depends on !SMP || !XIP_KERNEL # for SMP_ON_UP
 	select ARM_AMBA
 	select CMA
 	select DMA_CMA
@@ -146,6 +147,7 @@ endif
 menuconfig ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V6 || ARCH_MULTI_V7
+	depends on !SMP || !XIP_KERNEL # for SMP_ON_UP
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
-- 
2.29.2

