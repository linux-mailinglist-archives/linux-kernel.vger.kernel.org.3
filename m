Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62284F44FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiDEOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiDEJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D0922528;
        Tue,  5 Apr 2022 02:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5558A61577;
        Tue,  5 Apr 2022 09:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17DEC385A7;
        Tue,  5 Apr 2022 09:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150296;
        bh=Wo392uEawl61tpBst45l5+t1WaSNVll46ELOkHU90ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwT5G0+JvjM2OoUCGaf7dYjAeelIXoF2JQyLEDTgg7eL7brW0igNcD8hgCb2+AW/J
         4tB/4rEj+j3WEKLmckBuSbMUCBHVOx9o+7W0p60kim0EtQLwBJiZSYfvpqvKQJEmc3
         9tLXDeU2SuIb587y/0UMTLL17i0Sc44upoLNM3s7HAgf1q4h/4tejh5e9aE4UI0SeF
         C6QSoTcFXYsc/DVQcO0/D7hCJNWWPi6Iv4sUe/g3trQRnePL1vh8UizJTelrDYLrKA
         VStP18jigA5M4KUgLuDYG9G75F/IELARplzLiX5uAY14Yi8cmfH8rrZNtcq0pdJg0A
         ZI0Dbpvsr0s+g==
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
Subject: [PATCH 02/12] ARM: ep93xx: renumber interrupts
Date:   Tue,  5 Apr 2022 11:17:40 +0200
Message-Id: <20220405091750.3076973-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220405091750.3076973-1-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With the move to irq domains, no irqchip must start at number 0,
so shift all the hardwired IRQ numbers by one.

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ep93xx/core.c              |   4 +-
 arch/arm/mach-ep93xx/include/mach/irqs.h | 122 ++++++++++++-----------
 2 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index a3b4e843456a..e4569a5acc3f 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -75,8 +75,8 @@ void __init ep93xx_map_io(void)
  *************************************************************************/
 void __init ep93xx_init_irq(void)
 {
-	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
-	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
+	vic_init(EP93XX_VIC1_BASE, IRQ_EP93XX_VIC0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
+	vic_init(EP93XX_VIC2_BASE, IRQ_EP93XX_VIC1, EP93XX_VIC2_VALID_IRQ_MASK, 0);
 }
 
 
diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h b/arch/arm/mach-ep93xx/include/mach/irqs.h
index 244daf83ce6d..60c69c4ed7e1 100644
--- a/arch/arm/mach-ep93xx/include/mach/irqs.h
+++ b/arch/arm/mach-ep93xx/include/mach/irqs.h
@@ -6,69 +6,73 @@
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
-#define IRQ_EP93XX_COMMRX		2
-#define IRQ_EP93XX_COMMTX		3
-#define IRQ_EP93XX_TIMER1		4
-#define IRQ_EP93XX_TIMER2		5
-#define IRQ_EP93XX_AACINTR		6
-#define IRQ_EP93XX_DMAM2P0		7
-#define IRQ_EP93XX_DMAM2P1		8
-#define IRQ_EP93XX_DMAM2P2		9
-#define IRQ_EP93XX_DMAM2P3		10
-#define IRQ_EP93XX_DMAM2P4		11
-#define IRQ_EP93XX_DMAM2P5		12
-#define IRQ_EP93XX_DMAM2P6		13
-#define IRQ_EP93XX_DMAM2P7		14
-#define IRQ_EP93XX_DMAM2P8		15
-#define IRQ_EP93XX_DMAM2P9		16
-#define IRQ_EP93XX_DMAM2M0		17
-#define IRQ_EP93XX_DMAM2M1		18
-#define IRQ_EP93XX_GPIO0MUX		19
-#define IRQ_EP93XX_GPIO1MUX		20
-#define IRQ_EP93XX_GPIO2MUX		21
-#define IRQ_EP93XX_GPIO3MUX		22
-#define IRQ_EP93XX_UART1RX		23
-#define IRQ_EP93XX_UART1TX		24
-#define IRQ_EP93XX_UART2RX		25
-#define IRQ_EP93XX_UART2TX		26
-#define IRQ_EP93XX_UART3RX		27
-#define IRQ_EP93XX_UART3TX		28
-#define IRQ_EP93XX_KEY			29
-#define IRQ_EP93XX_TOUCH		30
+#define IRQ_EP93XX_VIC0			1
+
+#define IRQ_EP93XX_COMMRX		(IRQ_EP93XX_VIC0 + 2)
+#define IRQ_EP93XX_COMMTX		(IRQ_EP93XX_VIC0 + 3)
+#define IRQ_EP93XX_TIMER1		(IRQ_EP93XX_VIC0 + 4)
+#define IRQ_EP93XX_TIMER2		(IRQ_EP93XX_VIC0 + 5)
+#define IRQ_EP93XX_AACINTR		(IRQ_EP93XX_VIC0 + 6)
+#define IRQ_EP93XX_DMAM2P0		(IRQ_EP93XX_VIC0 + 7)
+#define IRQ_EP93XX_DMAM2P1		(IRQ_EP93XX_VIC0 + 8)
+#define IRQ_EP93XX_DMAM2P2		(IRQ_EP93XX_VIC0 + 9)
+#define IRQ_EP93XX_DMAM2P3		(IRQ_EP93XX_VIC0 + 10)
+#define IRQ_EP93XX_DMAM2P4		(IRQ_EP93XX_VIC0 + 11)
+#define IRQ_EP93XX_DMAM2P5		(IRQ_EP93XX_VIC0 + 12)
+#define IRQ_EP93XX_DMAM2P6		(IRQ_EP93XX_VIC0 + 13)
+#define IRQ_EP93XX_DMAM2P7		(IRQ_EP93XX_VIC0 + 14)
+#define IRQ_EP93XX_DMAM2P8		(IRQ_EP93XX_VIC0 + 15)
+#define IRQ_EP93XX_DMAM2P9		(IRQ_EP93XX_VIC0 + 16)
+#define IRQ_EP93XX_DMAM2M0		(IRQ_EP93XX_VIC0 + 17)
+#define IRQ_EP93XX_DMAM2M1		(IRQ_EP93XX_VIC0 + 18)
+#define IRQ_EP93XX_GPIO0MUX		(IRQ_EP93XX_VIC0 + 19)
+#define IRQ_EP93XX_GPIO1MUX		(IRQ_EP93XX_VIC0 + 20)
+#define IRQ_EP93XX_GPIO2MUX		(IRQ_EP93XX_VIC0 + 21)
+#define IRQ_EP93XX_GPIO3MUX		(IRQ_EP93XX_VIC0 + 22)
+#define IRQ_EP93XX_UART1RX		(IRQ_EP93XX_VIC0 + 23)
+#define IRQ_EP93XX_UART1TX		(IRQ_EP93XX_VIC0 + 24)
+#define IRQ_EP93XX_UART2RX		(IRQ_EP93XX_VIC0 + 25)
+#define IRQ_EP93XX_UART2TX		(IRQ_EP93XX_VIC0 + 26)
+#define IRQ_EP93XX_UART3RX		(IRQ_EP93XX_VIC0 + 27)
+#define IRQ_EP93XX_UART3TX		(IRQ_EP93XX_VIC0 + 28)
+#define IRQ_EP93XX_KEY			(IRQ_EP93XX_VIC0 + 29)
+#define IRQ_EP93XX_TOUCH		(IRQ_EP93XX_VIC0 + 30)
 #define EP93XX_VIC1_VALID_IRQ_MASK	0x7ffffffc
 
-#define IRQ_EP93XX_EXT0			32
-#define IRQ_EP93XX_EXT1			33
-#define IRQ_EP93XX_EXT2			34
-#define IRQ_EP93XX_64HZ			35
-#define IRQ_EP93XX_WATCHDOG		36
-#define IRQ_EP93XX_RTC			37
-#define IRQ_EP93XX_IRDA			38
-#define IRQ_EP93XX_ETHERNET		39
-#define IRQ_EP93XX_EXT3			40
-#define IRQ_EP93XX_PROG			41
-#define IRQ_EP93XX_1HZ			42
-#define IRQ_EP93XX_VSYNC		43
-#define IRQ_EP93XX_VIDEO_FIFO		44
-#define IRQ_EP93XX_SSP1RX		45
-#define IRQ_EP93XX_SSP1TX		46
-#define IRQ_EP93XX_GPIO4MUX		47
-#define IRQ_EP93XX_GPIO5MUX		48
-#define IRQ_EP93XX_GPIO6MUX		49
-#define IRQ_EP93XX_GPIO7MUX		50
-#define IRQ_EP93XX_TIMER3		51
-#define IRQ_EP93XX_UART1		52
-#define IRQ_EP93XX_SSP			53
-#define IRQ_EP93XX_UART2		54
-#define IRQ_EP93XX_UART3		55
-#define IRQ_EP93XX_USB			56
-#define IRQ_EP93XX_ETHERNET_PME		57
-#define IRQ_EP93XX_DSP			58
-#define IRQ_EP93XX_GPIO_AB		59
-#define IRQ_EP93XX_SAI			60
+#define IRQ_EP93XX_VIC1			(IRQ_EP93XX_VIC0 + 32)
+
+#define IRQ_EP93XX_EXT0			(IRQ_EP93XX_VIC1 + 0)
+#define IRQ_EP93XX_EXT1			(IRQ_EP93XX_VIC1 + 1)
+#define IRQ_EP93XX_EXT2			(IRQ_EP93XX_VIC1 + 2)
+#define IRQ_EP93XX_64HZ			(IRQ_EP93XX_VIC1 + 3)
+#define IRQ_EP93XX_WATCHDOG		(IRQ_EP93XX_VIC1 + 4)
+#define IRQ_EP93XX_RTC			(IRQ_EP93XX_VIC1 + 5)
+#define IRQ_EP93XX_IRDA			(IRQ_EP93XX_VIC1 + 6)
+#define IRQ_EP93XX_ETHERNET		(IRQ_EP93XX_VIC1 + 7)
+#define IRQ_EP93XX_EXT3			(IRQ_EP93XX_VIC1 + 8)
+#define IRQ_EP93XX_PROG			(IRQ_EP93XX_VIC1 + 9)
+#define IRQ_EP93XX_1HZ			(IRQ_EP93XX_VIC1 + 10)
+#define IRQ_EP93XX_VSYNC		(IRQ_EP93XX_VIC1 + 11)
+#define IRQ_EP93XX_VIDEO_FIFO		(IRQ_EP93XX_VIC1 + 12)
+#define IRQ_EP93XX_SSP1RX		(IRQ_EP93XX_VIC1 + 13)
+#define IRQ_EP93XX_SSP1TX		(IRQ_EP93XX_VIC1 + 14)
+#define IRQ_EP93XX_GPIO4MUX		(IRQ_EP93XX_VIC1 + 15)
+#define IRQ_EP93XX_GPIO5MUX		(IRQ_EP93XX_VIC1 + 16)
+#define IRQ_EP93XX_GPIO6MUX		(IRQ_EP93XX_VIC1 + 17)
+#define IRQ_EP93XX_GPIO7MUX		(IRQ_EP93XX_VIC1 + 18)
+#define IRQ_EP93XX_TIMER3		(IRQ_EP93XX_VIC1 + 19)
+#define IRQ_EP93XX_UART1		(IRQ_EP93XX_VIC1 + 20)
+#define IRQ_EP93XX_SSP			(IRQ_EP93XX_VIC1 + 21)
+#define IRQ_EP93XX_UART2		(IRQ_EP93XX_VIC1 + 22)
+#define IRQ_EP93XX_UART3		(IRQ_EP93XX_VIC1 + 23)
+#define IRQ_EP93XX_USB			(IRQ_EP93XX_VIC1 + 24)
+#define IRQ_EP93XX_ETHERNET_PME		(IRQ_EP93XX_VIC1 + 25)
+#define IRQ_EP93XX_DSP			(IRQ_EP93XX_VIC1 + 26)
+#define IRQ_EP93XX_GPIO_AB		(IRQ_EP93XX_VIC1 + 27)
+#define IRQ_EP93XX_SAI			(IRQ_EP93XX_VIC1 + 28)
 #define EP93XX_VIC2_VALID_IRQ_MASK	0x1fffffff
 
-#define NR_EP93XX_IRQS			(64 + 24)
+#define NR_EP93XX_IRQS			(IRQ_EP93XX_VIC1 + 32 + 24)
 
 #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
 #define EP93XX_BOARD_IRQS		32
-- 
2.29.2

