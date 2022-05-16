Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0F528D87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbiEPS43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiEPS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:56:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A365F1;
        Mon, 16 May 2022 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652727383; x=1684263383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N6vZipY1C/o523cREZKcuT3/Tn8BOnL68ODAi7fpyvc=;
  b=Yr5L4F507PWGa82OQqDUwCVgoXHZ9RujeYj6hrVdf8hiakQHMVOA93Mk
   HyMjRwZtCpoXOm4VCZBw0rHMb9B4kGIm5nN+P/CSp8ibtdfOf/bKWIsIc
   oj2oSE2a9cZioYG3CF+pSEFc3n9x/PsYVwg2Y+pPL5PddZx/RNfi48L1b
   IZYlPSvjgAkME0T0uCnkRLEdoPESYQbpBJQfyCAp9yugU82YnUcUMYWIw
   N/aUnf6IHT38ZMALRTnOKL+zFyDu6Lyety8TvCs4JzF0tbCkBOgBLo/gK
   NXyMKXHPbXuGmN9FE5Elr2B+r+Knz609ae034vClFOTVW3sfQyh8v1ArJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270874764"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270874764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="596669158"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 May 2022 11:56:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F356A8; Mon, 16 May 2022 21:56:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] pinctrl: intel: make irq_chip immutable
Date:   Mon, 16 May 2022 21:56:17 +0300
Message-Id: <20220516185618.32448-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, the kernel is nagging about mutable irq_chips:

   "not an immutable chip, please consider fixing it!"

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

While at it, align IRQ chip callback names with member names for
the sake of consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 44 ++++++++++++++++-----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 826d494f3cc6..0d9161a3edf3 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1039,15 +1039,14 @@ static void intel_gpio_irq_ack(struct irq_data *d)
 	}
 }
 
-static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
+static void intel_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwirq, bool mask)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct intel_community *community;
 	const struct intel_padgroup *padgrp;
 	int pin;
 
-	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
+	pin = intel_gpio_to_pin(pctrl, hwirq, &community, &padgrp);
 	if (pin >= 0) {
 		unsigned int gpp, gpp_offset;
 		unsigned long flags;
@@ -1077,15 +1076,23 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 
 static void intel_gpio_irq_mask(struct irq_data *d)
 {
-	intel_gpio_irq_mask_unmask(d, true);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	intel_gpio_irq_mask_unmask(gc, hwirq, true);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void intel_gpio_irq_unmask(struct irq_data *d)
 {
-	intel_gpio_irq_mask_unmask(d, false);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(gc, hwirq);
+	intel_gpio_irq_mask_unmask(gc, hwirq, false);
 }
 
-static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
+static int intel_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
@@ -1142,7 +1149,7 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static int intel_gpio_irq_wake(struct irq_data *d, unsigned int on)
+static int intel_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
@@ -1157,6 +1164,17 @@ static int intel_gpio_irq_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static const struct irq_chip intel_gpio_irq_chip = {
+	.name		= "intel-gpio",
+	.irq_ack	= intel_gpio_irq_ack,
+	.irq_mask	= intel_gpio_irq_mask,
+	.irq_unmask	= intel_gpio_irq_unmask,
+	.irq_set_type	= intel_gpio_irq_set_type,
+	.irq_set_wake	= intel_gpio_irq_set_wake,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int intel_gpio_community_irq_handler(struct intel_pinctrl *pctrl,
 					    const struct intel_community *community)
 {
@@ -1319,15 +1337,6 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 	pctrl->chip.add_pin_ranges = intel_gpio_add_pin_ranges;
 	pctrl->irq = irq;
 
-	/* Setup IRQ chip */
-	pctrl->irqchip.name = dev_name(pctrl->dev);
-	pctrl->irqchip.irq_ack = intel_gpio_irq_ack;
-	pctrl->irqchip.irq_mask = intel_gpio_irq_mask;
-	pctrl->irqchip.irq_unmask = intel_gpio_irq_unmask;
-	pctrl->irqchip.irq_set_type = intel_gpio_irq_type;
-	pctrl->irqchip.irq_set_wake = intel_gpio_irq_wake;
-	pctrl->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND;
-
 	/*
 	 * On some platforms several GPIO controllers share the same interrupt
 	 * line.
@@ -1340,8 +1349,9 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 		return ret;
 	}
 
+	/* Setup IRQ chip */
 	girq = &pctrl->chip.irq;
-	girq->chip = &pctrl->irqchip;
+	gpio_irq_chip_set_chip(girq, &intel_gpio_irq_chip);
 	/* This will let us handle the IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.35.1

