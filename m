Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A459157F750
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiGXWV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:21:57 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5CBF583
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:21:55 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oFjyz-002JZ1-0g;
        Sun, 24 Jul 2022 23:21:53 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, tglx@linutronix.de, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH V2] irqchip/mmp: fix missing extern init code
Date:   Sun, 24 Jul 2022 23:21:52 +0100
Message-Id: <20220724222152.551850-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions icu_init_irq and mmp2_init_icu are exported
from this code, so declare them in the header file to avoid
the following sparse warnings:

drivers/irqchip/irq-mmp.c:248:13: warning: symbol 'icu_init_irq' was not declared. Should it be static?
drivers/irqchip/irq-mmp.c:271:13: warning: symbol 'mmp2_init_icu' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
--
- v2: added pxa machine includes into this patch
---
 arch/arm/mach-mmp/mmp2.h    | 2 +-
 arch/arm/mach-mmp/pxa168.h  | 2 +-
 arch/arm/mach-mmp/pxa910.h  | 2 +-
 include/linux/irqchip/mmp.h | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index 3ebc1bb13f71..7f80b90248fb 100644
--- a/arch/arm/mach-mmp/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -5,13 +5,13 @@
 #include <linux/platform_data/pxa_sdhci.h>
 
 extern void mmp2_timer_init(void);
-extern void __init mmp2_init_icu(void);
 extern void __init mmp2_init_irq(void);
 extern void mmp2_clear_pmic_int(void);
 
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
+#include <linux/irqchip/mmp.h>
 
 #include "devices.h"
 
diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
index 34f907cd165a..c1547e098f09 100644
--- a/arch/arm/mach-mmp/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -5,7 +5,6 @@
 #include <linux/reboot.h>
 
 extern void pxa168_timer_init(void);
-extern void __init icu_init_irq(void);
 extern void __init pxa168_init_irq(void);
 extern void pxa168_restart(enum reboot_mode, const char *);
 extern void pxa168_clear_keypad_wakeup(void);
@@ -18,6 +17,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <linux/pxa168_eth.h>
 #include <linux/platform_data/mv_usb.h>
 #include <linux/soc/mmp/cputype.h>
+#include <linux/irqchip/mmp.h>
 
 #include "devices.h"
 
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index 6ace5a8aa15b..7d229214065a 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -3,13 +3,13 @@
 #define __ASM_MACH_PXA910_H
 
 extern void pxa910_timer_init(void);
-extern void __init icu_init_irq(void);
 extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/mmp_disp.h>
+#include <linux/irqchip/mmp.h>
 
 #include "devices.h"
 
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
index cb8455c87c8a..aa1813749a4f 100644
--- a/include/linux/irqchip/mmp.h
+++ b/include/linux/irqchip/mmp.h
@@ -4,4 +4,7 @@
 
 extern struct irq_chip icu_irq_chip;
 
+extern void icu_init_irq(void);
+extern void mmp2_init_icu(void);
+
 #endif	/* __IRQCHIP_MMP_H */
-- 
2.35.1

