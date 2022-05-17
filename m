Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC752A840
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351043AbiEQQia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiEQQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:38:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4E33E17;
        Tue, 17 May 2022 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652805505; x=1684341505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zl8YweXi0s0RV+9G0WFQmftqGmOUyvjXqU37od8/iVs=;
  b=YpyeGdEpLF5wSnr69rYF0Idi+fJsjcGzsURJQEGtXOGlpWSDo+kKlElK
   sC4NwRa7bMnwslG4WbsWj+DNSOz63AIlcqVGY8bT7inWs66BXdt3N8rYJ
   xcyNChADQdZioXXoftQke90OC0tYHCODLqUR3Xa/DGmoklI4LANUsRaQo
   oxFcDPw5k49gAEzu36om6QQPnaEJ20lw60hHVgpWxHyG1L7CyrKCwNUFu
   KfMVASH1y1r6QokAzPP3q1G8qmmToOTHtJSlb/QLnqUsyiolDYS3STFfK
   VEkmCRIyR+wCcZeYlyCxRSkG3T76KxfPLaDv97VvToXa97l6PD0KphvMT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251755452"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251755452"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="605441639"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2022 09:38:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A1C4109; Tue, 17 May 2022 19:38:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] pinctrl: intel: make irq_chip immutable
Date:   Tue, 17 May 2022 19:38:19 +0300
Message-Id: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped renaming part (Mika)
 drivers/pinctrl/intel/pinctrl-intel.c | 40 +++++++++++++++++----------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 826d494f3cc6..4845d0b74df9 100644
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
@@ -1077,12 +1076,20 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 
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
 
 static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
@@ -1157,6 +1164,17 @@ static int intel_gpio_irq_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static const struct irq_chip intel_gpio_irq_chip = {
+	.name		= "intel-gpio",
+	.irq_ack	= intel_gpio_irq_ack,
+	.irq_mask	= intel_gpio_irq_mask,
+	.irq_unmask	= intel_gpio_irq_unmask,
+	.irq_set_type	= intel_gpio_irq_type,
+	.irq_set_wake	= intel_gpio_irq_wake,
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

