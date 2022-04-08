Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136044F92C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiDHKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiDHKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:19:31 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E282F28E;
        Fri,  8 Apr 2022 03:17:28 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9478B8171;
        Fri,  8 Apr 2022 10:15:02 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/3] clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
Date:   Fri,  8 Apr 2022 13:17:14 +0300
Message-Id: <20220408101715.43697-3-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408101715.43697-1-tony@atomide.com>
References: <20220408101715.43697-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make timer-ti-dm selectable for ARCH_K3, and add a separate option
for OMAP_DM_SYSTIMER as there should be no need for it on ARCH_K3.

For older TI SoCs, we are already selecting OMAP_DM_TIMER in
arch/arm/mach-omap*/Kconfig. For mach-omap2, we need to now also select
OMAP_DM_SYSTIMER.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig  | 2 ++
 drivers/clocksource/Kconfig  | 8 +++++++-
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -105,6 +105,7 @@ config ARCH_OMAP2PLUS
 	select MACH_OMAP_GENERIC
 	select MEMORY
 	select MFD_SYSCON
+	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select OMAP_GPMC
 	select PINCTRL
@@ -160,6 +161,7 @@ config SOC_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP2
 	default y
+	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select SOC_HAS_OMAP2_SDRC
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -22,7 +22,7 @@ config CLKEVT_I8253
 config I8253_LOCK
 	bool
 
-config OMAP_DM_TIMER
+config OMAP_DM_SYSTIMER
 	bool
 	select TIMER_OF
 
@@ -56,6 +56,12 @@ config DIGICOLOR_TIMER
 	help
 	  Enables the support for the digicolor timer driver.
 
+config OMAP_DM_TIMER
+	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	select TIMER_OF
+	help
+	  Enables the support for the TI dual-mode timer driver.
+
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
-obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm-systimer.o
+obj-$(CONFIG_OMAP_DM_SYSTIMER)	+= timer-ti-dm-systimer.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
-- 
2.35.1
