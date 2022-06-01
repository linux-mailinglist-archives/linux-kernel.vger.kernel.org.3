Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760FC53A98D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353515AbiFAPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354168AbiFAPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:04:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A23E67D02;
        Wed,  1 Jun 2022 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654095880; x=1685631880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4K0ylCm3UtXK+4vAfaLYD+TBP2NmHn26LIgf5PcV+ac=;
  b=DCP2uUddylYr8DmeW7eTsk/++ekf+WSCos6ay+5b97L3Ar24N3R9OXIl
   N63HGEX1cRL/H+mZr4PmImZUoopQ5MCexqkvsQe9gjIPFcbLGTT4BYGH3
   oBNbfZTJgtuPcAaj8Bn1YllE65n6u9R0ZABXeuVL73eo0EsVRgAegQM3g
   pz7acwKzl0PK3ve+Swn52NKsmaj6bDNyVDY27Tv+WHMQQU0F0YP4pR6Y9
   lrefad1o43Kg7/IKAafWrhiCiRk9t0wufqKG+tUcmzr2k8cHbD59/jFrC
   8dwXblfaLte1c+WET6PewFpebbbrBum+chS9ldZJ5hYee4vF4J0PN9XLL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275341616"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275341616"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="606311758"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 01 Jun 2022 08:04:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9EDFEF8; Wed,  1 Jun 2022 18:04:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: dln2: make irq_chip immutable
Date:   Wed,  1 Jun 2022 18:04:36 +0300
Message-Id: <20220601150436.25830-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, the kernel is nagging about mutable irq_chips:

   "not an immutable chip, please consider fixing it!"

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-dln2.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index 08b9e2cf4f2d..71fa437b491f 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -46,7 +46,6 @@
 struct dln2_gpio {
 	struct platform_device *pdev;
 	struct gpio_chip gpio;
-	struct irq_chip irqchip;
 
 	/*
 	 * Cache pin direction to save us one transfer, since the hardware has
@@ -306,6 +305,7 @@ static void dln2_irq_unmask(struct irq_data *irqd)
 	struct dln2_gpio *dln2 = gpiochip_get_data(gc);
 	int pin = irqd_to_hwirq(irqd);
 
+	gpiochip_enable_irq(gc, pin);
 	set_bit(pin, dln2->unmasked_irqs);
 }
 
@@ -316,6 +316,7 @@ static void dln2_irq_mask(struct irq_data *irqd)
 	int pin = irqd_to_hwirq(irqd);
 
 	clear_bit(pin, dln2->unmasked_irqs);
+	gpiochip_disable_irq(gc, pin);
 }
 
 static int dln2_irq_set_type(struct irq_data *irqd, unsigned type)
@@ -384,6 +385,17 @@ static void dln2_irq_bus_unlock(struct irq_data *irqd)
 	mutex_unlock(&dln2->irq_lock);
 }
 
+static const struct irq_chip dln2_irqchip = {
+	.name = "dln2-irq",
+	.irq_mask = dln2_irq_mask,
+	.irq_unmask = dln2_irq_unmask,
+	.irq_set_type = dln2_irq_set_type,
+	.irq_bus_lock = dln2_irq_bus_lock,
+	.irq_bus_sync_unlock = dln2_irq_bus_unlock,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void dln2_gpio_event(struct platform_device *pdev, u16 echo,
 			    const void *data, int len)
 {
@@ -465,15 +477,8 @@ static int dln2_gpio_probe(struct platform_device *pdev)
 	dln2->gpio.direction_output = dln2_gpio_direction_output;
 	dln2->gpio.set_config = dln2_gpio_set_config;
 
-	dln2->irqchip.name = "dln2-irq",
-	dln2->irqchip.irq_mask = dln2_irq_mask,
-	dln2->irqchip.irq_unmask = dln2_irq_unmask,
-	dln2->irqchip.irq_set_type = dln2_irq_set_type,
-	dln2->irqchip.irq_bus_lock = dln2_irq_bus_lock,
-	dln2->irqchip.irq_bus_sync_unlock = dln2_irq_bus_unlock,
-
 	girq = &dln2->gpio.irq;
-	girq->chip = &dln2->irqchip;
+	gpio_irq_chip_set_chip(girq, &dln2_irqchip);
 	/* The event comes from the outside so no parent handler */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.35.1

