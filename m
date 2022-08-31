Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6C5A7F88
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiHaOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiHaOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:04:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C4FD7588;
        Wed, 31 Aug 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661954668; x=1693490668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I4HAbKA0UyO2MIs7bemGVv7JTBttCA5lMY0VsZmgrVw=;
  b=VLiwHle4ZqMe1d2GhIZuA+j2SaPbDyLxY4MiXicEeWm7uwBNgwmHEY2w
   S7ahUC8LENL4RIX0Ex3pRSDYG/76LH+UBGJ7InYNvxHP088vxswYbYhSd
   OJ0abv9SNuPIsg0MxmNYoS68t+CYCwBZh8g+/86qvGQotVgSA1breu2KQ
   mFLEGoyOpbHEPqYKTOUnqs82SkA76WMODJ3mSMsvhb3vziBNfdrQrGkQU
   simDxf/K7nkep/P3uZrs0cm4yOigS8nL2pM6ZhwEx2iWPuJFFbXYv69+g
   382Kew+K/ebu5WYci6GJHQX0s9sz7mAmu3di3HW0XvtALTK+Eg2Xcc/Lc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="175003959"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 07:04:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 06:54:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 06:54:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] pinctrl: at91: move gpio suspend/resume calls to driver's context
Date:   Wed, 31 Aug 2022 16:56:35 +0300
Message-ID: <20220831135636.3176406-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
References: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move gpio suspend/resume execution local to driver and let it execute as
close as possible to the moment the machine specific PM code is executed
(by setting it to .noirq member of dev_pm_ops). With this the
at91_pinctrl_gpio_suspend()/at91_pinctrl_gpio_resume() calls were removed
from arch/arm/mach-at91/pm.c and also a header has been removed.
The patch has been checked on sama5d3_xplained, sam9x60ek,
sama5d2_xplained, sama7g5ek boards.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c        | 15 -------
 drivers/pinctrl/pinctrl-at91.c | 79 ++++++++++++++++------------------
 include/soc/at91/pm.h          | 16 -------
 3 files changed, 36 insertions(+), 74 deletions(-)
 delete mode 100644 include/soc/at91/pm.h

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f4501dea98b0..60dc56d8acfb 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -19,8 +19,6 @@
 #include <linux/clk/at91_pmc.h>
 #include <linux/platform_data/atmel.h>
 
-#include <soc/at91/pm.h>
-
 #include <asm/cacheflush.h>
 #include <asm/fncpy.h>
 #include <asm/system_misc.h>
@@ -656,16 +654,6 @@ static int at91_pm_enter(suspend_state_t state)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_PINCTRL_AT91
-	/*
-	 * FIXME: this is needed to communicate between the pinctrl driver and
-	 * the PM implementation in the machine. Possibly part of the PM
-	 * implementation should be moved down into the pinctrl driver and get
-	 * called as part of the generic suspend/resume path.
-	 */
-	at91_pinctrl_gpio_suspend();
-#endif
-
 	switch (state) {
 	case PM_SUSPEND_MEM:
 	case PM_SUSPEND_STANDBY:
@@ -690,9 +678,6 @@ static int at91_pm_enter(suspend_state_t state)
 	}
 
 error:
-#ifdef CONFIG_PINCTRL_AT91
-	at91_pinctrl_gpio_resume();
-#endif
 	at91_pm_config_quirks(false);
 	return 0;
 }
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 0b78fd48fd02..631a6289c2b6 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -22,8 +22,7 @@
 #include <linux/pinctrl/pinmux.h>
 /* Since we request GPIOs from ourself */
 #include <linux/pinctrl/consumer.h>
-
-#include <soc/at91/pm.h>
+#include <linux/pm.h>
 
 #include "pinctrl-at91.h"
 #include "core.h"
@@ -44,6 +43,9 @@ struct at91_pinctrl_mux_ops;
  * @regbase: PIO bank virtual address
  * @clock: associated clock
  * @ops: at91 pinctrl mux ops
+ * @wakeups: wakeup interrupts
+ * @backups: interrupts disabled in suspend
+ * @id: gpio chip identifier
  */
 struct at91_gpio_chip {
 	struct gpio_chip	chip;
@@ -55,6 +57,9 @@ struct at91_gpio_chip {
 	void __iomem		*regbase;
 	struct clk		*clock;
 	const struct at91_pinctrl_mux_ops *ops;
+	u32			wakeups;
+	u32			backups;
+	u32			id;
 };
 
 static struct at91_gpio_chip *gpio_chips[MAX_GPIO_BANKS];
@@ -1627,70 +1632,51 @@ static void gpio_irq_ack(struct irq_data *d)
 	/* the interrupt is already cleared before by reading ISR */
 }
 
-static u32 wakeups[MAX_GPIO_BANKS];
-static u32 backups[MAX_GPIO_BANKS];
-
 static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
 {
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
-	unsigned	bank = at91_gpio->pioc_idx;
 	unsigned mask = 1 << d->hwirq;
 
-	if (unlikely(bank >= MAX_GPIO_BANKS))
-		return -EINVAL;
-
 	if (state)
-		wakeups[bank] |= mask;
+		at91_gpio->wakeups |= mask;
 	else
-		wakeups[bank] &= ~mask;
+		at91_gpio->wakeups &= ~mask;
 
 	irq_set_irq_wake(at91_gpio->pioc_virq, state);
 
 	return 0;
 }
 
-void at91_pinctrl_gpio_suspend(void)
+static int at91_gpio_suspend(struct device *dev)
 {
-	int i;
+	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
+	void __iomem *pio = at91_chip->regbase;
 
-	for (i = 0; i < gpio_banks; i++) {
-		void __iomem  *pio;
+	at91_chip->backups = readl_relaxed(pio + PIO_IMR);
+	writel_relaxed(at91_chip->backups, pio + PIO_IDR);
+	writel_relaxed(at91_chip->wakeups, pio + PIO_IER);
 
-		if (!gpio_chips[i])
-			continue;
-
-		pio = gpio_chips[i]->regbase;
-
-		backups[i] = readl_relaxed(pio + PIO_IMR);
-		writel_relaxed(backups[i], pio + PIO_IDR);
-		writel_relaxed(wakeups[i], pio + PIO_IER);
+	if (!at91_chip->wakeups)
+		clk_disable_unprepare(at91_chip->clock);
+	else
+		printk(KERN_DEBUG "GPIO-%c may wake for %08x\n",
+		       'A' + at91_chip->id, at91_chip->wakeups);
 
-		if (!wakeups[i])
-			clk_disable_unprepare(gpio_chips[i]->clock);
-		else
-			printk(KERN_DEBUG "GPIO-%c may wake for %08x\n",
-			       'A'+i, wakeups[i]);
-	}
+	return 0;
 }
 
-void at91_pinctrl_gpio_resume(void)
+static int at91_gpio_resume(struct device *dev)
 {
-	int i;
+	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
+	void __iomem *pio = at91_chip->regbase;
 
-	for (i = 0; i < gpio_banks; i++) {
-		void __iomem  *pio;
-
-		if (!gpio_chips[i])
-			continue;
+	if (!at91_chip->wakeups)
+		clk_prepare_enable(at91_chip->clock);
 
-		pio = gpio_chips[i]->regbase;
+	writel_relaxed(at91_chip->wakeups, pio + PIO_IDR);
+	writel_relaxed(at91_chip->backups, pio + PIO_IER);
 
-		if (!wakeups[i])
-			clk_prepare_enable(gpio_chips[i]->clock);
-
-		writel_relaxed(wakeups[i], pio + PIO_IDR);
-		writel_relaxed(backups[i], pio + PIO_IER);
-	}
+	return 0;
 }
 
 static void gpio_irq_handler(struct irq_desc *desc)
@@ -1872,6 +1858,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	}
 
 	at91_chip->chip = at91_gpio_template;
+	at91_chip->id = alias_idx;
 
 	chip = &at91_chip->chip;
 	chip->label = dev_name(&pdev->dev);
@@ -1917,6 +1904,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 		goto gpiochip_add_err;
 
 	gpio_chips[alias_idx] = at91_chip;
+	platform_set_drvdata(pdev, at91_chip);
 	gpio_banks = max(gpio_banks, alias_idx + 1);
 
 	dev_info(&pdev->dev, "at address %p\n", at91_chip->regbase);
@@ -1932,10 +1920,15 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct dev_pm_ops at91_gpio_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(at91_gpio_suspend, at91_gpio_resume)
+};
+
 static struct platform_driver at91_gpio_driver = {
 	.driver = {
 		.name = "gpio-at91",
 		.of_match_table = at91_gpio_of_match,
+		.pm = pm_ptr(&at91_gpio_pm_ops),
 	},
 	.probe = at91_gpio_probe,
 };
diff --git a/include/soc/at91/pm.h b/include/soc/at91/pm.h
deleted file mode 100644
index 7a41e53a3ffa..000000000000
--- a/include/soc/at91/pm.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Atmel Power Management
- *
- * Copyright (C) 2020 Atmel
- *
- * Author: Lee Jones <lee.jones@linaro.org>
- */
-
-#ifndef __SOC_ATMEL_PM_H
-#define __SOC_ATMEL_PM_H
-
-void at91_pinctrl_gpio_suspend(void);
-void at91_pinctrl_gpio_resume(void);
-
-#endif /* __SOC_ATMEL_PM_H */
-- 
2.34.1

