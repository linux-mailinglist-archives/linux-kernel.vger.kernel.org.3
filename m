Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21B4474386
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhLNNcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:32:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:46620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhLNNcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:32:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218992257"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="218992257"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="752980367"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2021 05:32:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8995B15C; Tue, 14 Dec 2021 15:32:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 1/1] ARM: orion/gpio: Get rid of unused first parameter in orion_gpio_init()
Date:   Tue, 14 Dec 2021 15:32:43 +0200
Message-Id: <20211214133243.53199-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node pointer is always NULL, get rid of unused parameter in
orion_gpio_init(). As a side effect it will allow to switch GPIO
library to the fwnode API, as well as in case of resurrecting it here
it should be fwnode_handle anyways.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-dove/irq.c                      | 11 +++--------
 arch/arm/mach-mv78xx0/irq.c                   |  3 +--
 arch/arm/mach-orion5x/irq.c                   |  3 +--
 arch/arm/plat-orion/gpio.c                    |  8 ++------
 arch/arm/plat-orion/include/plat/orion-gpio.h |  3 +--
 5 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 31ccbcee2627..c7ad6e5c37b0 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -73,12 +73,7 @@ void __init dove_init_irq(void)
 	/*
 	 * Initialize gpiolib for GPIOs 0-71.
 	 */
-	orion_gpio_init(NULL, 0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
-			IRQ_DOVE_GPIO_START, gpio0_irqs);
-
-	orion_gpio_init(NULL, 32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
-			IRQ_DOVE_GPIO_START + 32, gpio1_irqs);
-
-	orion_gpio_init(NULL, 64, 8, DOVE_GPIO2_VIRT_BASE, 0,
-			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
+	orion_gpio_init(0, 32, DOVE_GPIO_LO_VIRT_BASE, 0, IRQ_DOVE_GPIO_START, gpio0_irqs);
+	orion_gpio_init(32, 32, DOVE_GPIO_HI_VIRT_BASE, 0, IRQ_DOVE_GPIO_START + 32, gpio1_irqs);
+	orion_gpio_init(64, 8, DOVE_GPIO2_VIRT_BASE, 0, IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
 }
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 788569e960e1..0b5f055ca1c3 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -67,7 +67,6 @@ void __init mv78xx0_init_irq(void)
 	 * registers for core #1 are at an offset of 0x18 from those of
 	 * core #0.)
 	 */
-	orion_gpio_init(NULL, 0, 32, GPIO_VIRT_BASE,
-			mv78xx0_core_index() ? 0x18 : 0,
+	orion_gpio_init(0, 32, GPIO_VIRT_BASE, mv78xx0_core_index() ? 0x18 : 0,
 			IRQ_MV78XX0_GPIO_START, gpio0_irqs);
 }
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index ac4af2283bef..62d0f4877b2a 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -49,6 +49,5 @@ void __init orion5x_init_irq(void)
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.
 	 */
-	orion_gpio_init(NULL, 0, 32, GPIO_VIRT_BASE, 0,
-			IRQ_ORION5X_GPIO_START, gpio0_irqs);
+	orion_gpio_init(0, 32, GPIO_VIRT_BASE, 0, IRQ_ORION5X_GPIO_START, gpio0_irqs);
 }
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 734f0be4f14a..3ef9ecdd6343 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -516,8 +516,7 @@ static void orion_gpio_mask_irq(struct irq_data *d)
 	irq_gc_unlock(gc);
 }
 
-void __init orion_gpio_init(struct device_node *np,
-			    int gpio_base, int ngpio,
+void __init orion_gpio_init(int gpio_base, int ngpio,
 			    void __iomem *base, int mask_offset,
 			    int secondary_irq_base,
 			    int irqs[4])
@@ -545,9 +544,6 @@ void __init orion_gpio_init(struct device_node *np,
 	ochip->chip.base = gpio_base;
 	ochip->chip.ngpio = ngpio;
 	ochip->chip.can_sleep = 0;
-#ifdef CONFIG_OF
-	ochip->chip.of_node = np;
-#endif
 	ochip->chip.dbg_show = orion_gpio_dbg_show;
 
 	spin_lock_init(&ochip->lock);
@@ -605,7 +601,7 @@ void __init orion_gpio_init(struct device_node *np,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
-	ochip->domain = irq_domain_add_legacy(np,
+	ochip->domain = irq_domain_add_legacy(NULL,
 					      ochip->chip.ngpio,
 					      ochip->secondary_irq_base,
 					      ochip->secondary_irq_base,
diff --git a/arch/arm/plat-orion/include/plat/orion-gpio.h b/arch/arm/plat-orion/include/plat/orion-gpio.h
index e856b073a9c8..25a2963e0e0f 100644
--- a/arch/arm/plat-orion/include/plat/orion-gpio.h
+++ b/arch/arm/plat-orion/include/plat/orion-gpio.h
@@ -30,8 +30,7 @@ int orion_gpio_led_blink_set(struct gpio_desc *desc, int state,
 void orion_gpio_set_valid(unsigned pin, int mode);
 
 /* Initialize gpiolib. */
-void __init orion_gpio_init(struct device_node *np,
-			    int gpio_base, int ngpio,
+void __init orion_gpio_init(int gpio_base, int ngpio,
 			    void __iomem *base, int mask_offset,
 			    int secondary_irq_base,
 			    int irq[4]);
-- 
2.33.0

