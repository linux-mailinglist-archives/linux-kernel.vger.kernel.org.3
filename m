Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A795253DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357157AbiELRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357140AbiELRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:40:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029EA26C4C5;
        Thu, 12 May 2022 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377214; x=1683913214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfHOk3NbKnCzKqrFFON5C5D8NThthEjbjuQAmQX0Sco=;
  b=iNYtBVvUHVu/lm8x6WVos/NsUubUpvWOj80OmAzEyLs26iD56KOJq+rv
   4NNkpWIzMrzLSOIeKcUSSeMznfY7Y3hBH72ujY8tgbu3vZkbqg49GuxkV
   s3DswyUo9QpHJa1cTxxWt+s3ZiQejO3G6Kh3TNh4ySfFhv0qOti75rb3o
   QFyc/xkliO0IT9p5UA8qBZZvSf7n0rcxeuELxTSlzBXxGr4UlUTM/k725
   soj/hCgV+y/0mZ+B2POK5qraJgwSH+Vd7moCW/mvLOULGwM5+P+/pfUSW
   Iqa1tbm9B4COc7nWxok5DUuXlzuIi0P2WD1979hqY9RsLV2TjvjUOXvvG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257634327"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="257634327"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="542883705"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 May 2022 10:39:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6698C103; Thu, 12 May 2022 20:39:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 5/5] pinctrl: lynxpoint: make irq_chip immutable
Date:   Thu, 12 May 2022 20:39:21 +0300
Message-Id: <20220512173921.8210-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
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

While at it, switch hwirq variable to use the correct type for
the sake of consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 561fa322b0b4..4fb39eb30902 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -663,7 +663,7 @@ static void lp_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
-	u32 hwirq = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_INT_STAT);
 	unsigned long flags;
 
@@ -684,10 +684,12 @@ static void lp_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
-	u32 hwirq = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_INT_ENABLE);
 	unsigned long flags;
 
+	gpiochip_enable_irq(gc, hwirq);
+
 	raw_spin_lock_irqsave(&lg->lock, flags);
 	iowrite32(ioread32(reg) | BIT(hwirq % 32), reg);
 	raw_spin_unlock_irqrestore(&lg->lock, flags);
@@ -697,30 +699,33 @@ static void lp_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
-	u32 hwirq = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_INT_ENABLE);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&lg->lock, flags);
 	iowrite32(ioread32(reg) & ~BIT(hwirq % 32), reg);
 	raw_spin_unlock_irqrestore(&lg->lock, flags);
+
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static int lp_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
-	u32 hwirq = irqd_to_hwirq(d);
-	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_CONFIG1);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
+	void __iomem *reg;
 	u32 value;
 
-	if (hwirq >= lg->chip.ngpio)
+	reg = lp_gpio_reg(&lg->chip, hwirq, LP_CONFIG1);
+	if (!reg)
 		return -EINVAL;
 
 	/* Fail if BIOS reserved pin for ACPI use */
 	if (lp_gpio_acpi_use(lg, hwirq)) {
-		dev_err(lg->dev, "pin %u can't be used as IRQ\n", hwirq);
+		dev_err(lg->dev, "pin %lu can't be used as IRQ\n", hwirq);
 		return -EBUSY;
 	}
 
@@ -755,7 +760,7 @@ static int lp_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static struct irq_chip lp_irqchip = {
+static const struct irq_chip lp_irqchip = {
 	.name = "LP-GPIO",
 	.irq_ack = lp_irq_ack,
 	.irq_mask = lp_irq_mask,
@@ -763,7 +768,8 @@ static struct irq_chip lp_irqchip = {
 	.irq_enable = lp_irq_enable,
 	.irq_disable = lp_irq_disable,
 	.irq_set_type = lp_irq_set_type,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int lp_gpio_irq_init_hw(struct gpio_chip *chip)
@@ -884,7 +890,7 @@ static int lp_gpio_probe(struct platform_device *pdev)
 		struct gpio_irq_chip *girq;
 
 		girq = &gc->irq;
-		girq->chip = &lp_irqchip;
+		gpio_irq_chip_set_chip(girq, &lp_irqchip);
 		girq->init_hw = lp_gpio_irq_init_hw;
 		girq->parent_handler = lp_gpio_irq_handler;
 		girq->num_parents = 1;
-- 
2.35.1

