Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE34F405F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350839AbiDEOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiDEJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F929E;
        Tue,  5 Apr 2022 02:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E196B80DA1;
        Tue,  5 Apr 2022 09:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E981C385A2;
        Tue,  5 Apr 2022 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150351;
        bh=DeQtVM10KaxSTi7JtqRVyZcnxrwnHXMAjUTF+jS4kR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifw51FaMc8qRGtx8hI5Ek3EFTkoPpLJADkxkwhSZHQVts8pt5F1u44eCudiVRu/Ds
         xsqqFWczHvUOpfFrf6GV6ypFNVy7yfY2SOMHp8l44QI3fyiGszJmFQy0UObBXS8bzb
         A+w+bDU8N+08m6gejQHCT4hbP2YVFFLlQV/cibi4U8GfiEVHIkC5AEfFwvvoRP1tcB
         eXYcH+5dtw/1I2uD4fe1cYqUpFe9TkjsauKM5hbXcnRW8EsY/ZoZtX1M8Y2fpuW4gX
         rVWTTfuqMjBDO12V9x4xphk2ydsUCZldjhfDyqRDC56ltN8/uCmEL9AI85uRMMLseV
         Dx7nO3/uIArBw==
From:   Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 12/12] ARM: ixp4xx: enable multiplatform support
Date:   Tue,  5 Apr 2022 11:17:50 +0200
Message-Id: <20220405091750.3076973-13-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220405091750.3076973-1-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After all the work that Linus Walleij did on this platform, it can be
part of a generic kernel build as well.

Note that there are known bugs in little-endian mode on ixp4xx, and
no other ARMv5 platform at this point supports big-endian mode, or is
likely to in the future, so there is limited practical value in this,
but it helps with build testing and ixp4xx little-endian support may
get fixed in the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                              | 16 ------
 arch/arm/mach-ixp4xx/Kconfig                  | 22 +++++---
 arch/arm/mach-ixp4xx/Makefile.boot            |  4 --
 .../arm/mach-ixp4xx/include/mach/uncompress.h | 54 -------------------
 4 files changed, 15 insertions(+), 81 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/Makefile.boot
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4d98de155e20..db9b9ed5d7c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -357,22 +357,6 @@ config ARCH_FOOTBRIDGE
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
-config ARCH_IXP4XX
-	bool "IXP4xx-based"
-	depends on CPU_BIG_ENDIAN
-	select ARM_PATCH_PHYS_VIRT
-	select CPU_XSCALE
-	select GPIO_IXP4XX
-	select GPIOLIB
-	select HAVE_PCI
-	select IXP4XX_IRQ
-	select IXP4XX_TIMER
-	select SPARSE_IRQ
-	select USB_EHCI_BIG_ENDIAN_DESC
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	help
-	  Support for Intel's IXP4XX (XScale) family of processors.
-
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on CPU_LITTLE_ENDIAN
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index f41ba3f42fc8..dc6ea3c2e3ed 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -1,9 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if ARCH_IXP4XX
-
-menu "Intel IXP4xx Implementation Options"
+menuconfig ARCH_IXP4XX
+	bool "IXP4xx-based platforms"
+	depends on ARCH_MULTI_V5
+	depends on CPU_BIG_ENDIAN
+	select CPU_XSCALE
+	select GPIO_IXP4XX
+	select GPIOLIB
+	select FORCE_PCI
+	select IXP4XX_IRQ
+	select IXP4XX_TIMER
+	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	help
+	  Support for Intel's IXP4XX (XScale) family of processors.
 
-comment "IXP4xx Platforms"
+if ARCH_IXP4XX
 
 config MACH_IXP4XX_OF
 	bool
@@ -12,11 +23,8 @@ config MACH_IXP4XX_OF
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select I2C
 	select I2C_IOP3XX
-	select PCI
 	select USE_OF
 	help
 	  Say 'Y' here to support Device Tree-based IXP4xx platforms.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-ixp4xx/Makefile.boot b/arch/arm/mach-ixp4xx/Makefile.boot
deleted file mode 100644
index 9b015bd1ef27..000000000000
--- a/arch/arm/mach-ixp4xx/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
deleted file mode 100644
index 09e7663e6a55..000000000000
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * arch/arm/mach-ixp4xx/include/mach/uncompress.h 
- *
- * Copyright (C) 2002 Intel Corporation.
- * Copyright (C) 2003-2004 MontaVista Software, Inc.
- */
-
-#ifndef _ARCH_UNCOMPRESS_H_
-#define _ARCH_UNCOMPRESS_H_
-
-#include <asm/mach-types.h>
-#include <linux/serial_reg.h>
-
-#define IXP4XX_UART1_BASE_PHYS 0xc8000000
-#define IXP4XX_UART2_BASE_PHYS 0xc8001000
-
-#define TX_DONE (UART_LSR_TEMT|UART_LSR_THRE)
-
-volatile u32* uart_base;
-
-static inline void putc(int c)
-{
-	/* Check THRE and TEMT bits before we transmit the character.
-	 */
-	while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
-		barrier();
-
-	*uart_base = c;
-}
-
-static void flush(void)
-{
-}
-
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
-{
-	/*
-	 * Some boards are using UART2 as console
-	 */
-	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
-	    machine_is_gateway7001() || machine_is_wg302v2() ||
-	    machine_is_devixp() || machine_is_miccpt() || machine_is_mic256())
-		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
-	else
-		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
-}
-
-/*
- * arch_id is a variable in decompress_kernel()
- */
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
-#endif
-- 
2.29.2

