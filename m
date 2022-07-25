Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2D57FBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiGYIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiGYIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:53:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C902140EC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:53:16 -0700 (PDT)
Date:   Mon, 25 Jul 2022 08:53:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658739194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h07meF+OpyOGWFqSjatb90Ng9PCZSeyT/td6Yf8xpu4=;
        b=LhjIsMtP8ti/X3KNzzyVHB68ebEkzGA133oBXDRDqIwerJUbybuyPNDzze8b4XB/51Gnjm
        EUbQqtkmU8RIWzMr+UIb81ItDINOI1AdqKAkXkVizCwNot1hSZVR7Yd4gmTCy6VNc6fLJa
        6iO0KEwNSWkKiBXVqQqPPW+1kt9utrThj3zBT60yF1LUjUVL8hf4ORzUKe3Llj4FP/+NZJ
        NfXX/lZOq5DoieTyxtU+STkgrIEWqyJs9ptix0wwiLhIEW0VGGdGf1jzGkHKSnn1D9ZWsX
        JPHoKvIQ47/gnStXcO8u9VdPk8WO3oo4rtOuyVTPQVq8NqomviBSNM29rT6Tnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658739194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h07meF+OpyOGWFqSjatb90Ng9PCZSeyT/td6Yf8xpu4=;
        b=6srZl7bD8xAWxb9HR3yLAIewreVjWLeMK2Qxt9gZSMw8Dsw3tcs45H919AJebxL1ubclQ5
        sqPSKqBm/wwRLwAA==
From:   "irqchip-bot for Ben Dooks" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mmp: Declare init functions in
 common header file
Cc:     Ben Dooks <ben-linux@fluff.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220724222152.551850-1-ben-linux@fluff.org>
References: <20220724222152.551850-1-ben-linux@fluff.org>
MIME-Version: 1.0
Message-ID: <165873919320.15455.15230987291054613592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9d9b010f12cc4e254bbba32d79c965b564a8957f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9d9b010f12cc4e254bbba32d79c965b564a8957f
Author:        Ben Dooks <ben-linux@fluff.org>
AuthorDate:    Sun, 24 Jul 2022 23:21:52 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 25 Jul 2022 09:42:24 +01:00

irqchip/mmp: Declare init functions in common header file

The functions icu_init_irq and mmp2_init_icu are exported
from this code, so declare them in the header file to avoid
the following sparse warnings:

drivers/irqchip/irq-mmp.c:248:13: warning: symbol 'icu_init_irq' was not declared. Should it be static?
drivers/irqchip/irq-mmp.c:271:13: warning: symbol 'mmp2_init_icu' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[maz: fixup commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220724222152.551850-1-ben-linux@fluff.org
---
 arch/arm/mach-mmp/mmp2.h    | 2 +-
 arch/arm/mach-mmp/pxa168.h  | 2 +-
 arch/arm/mach-mmp/pxa910.h  | 2 +-
 include/linux/irqchip/mmp.h | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index 3ebc1bb..7f80b90 100644
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
index 34f907c..c1547e0 100644
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
index 6ace5a8..7d22921 100644
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
index cb8455c..aa18137 100644
--- a/include/linux/irqchip/mmp.h
+++ b/include/linux/irqchip/mmp.h
@@ -4,4 +4,7 @@
 
 extern struct irq_chip icu_irq_chip;
 
+extern void icu_init_irq(void);
+extern void mmp2_init_icu(void);
+
 #endif	/* __IRQCHIP_MMP_H */
