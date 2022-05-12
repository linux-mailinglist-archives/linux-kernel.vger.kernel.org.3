Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE35253DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357152AbiELRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357128AbiELRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:39:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D92670B6;
        Thu, 12 May 2022 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377178; x=1683913178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTBb/hf/ahHMp/pRIP5/Gah+ftq46V7U9XMtKm5dPRY=;
  b=RFGUnHJjjlpy/sRe4nCJBDowF/INx366npFbNJ6b+OnDpL57Ppex4UR0
   SPQdYIhtrmRUGNrkaR95Bgi/VMcOYdKvxmt1WXJx0Qrlu6ULi6KXks1x4
   i371SgJWPdP+zH77dMhHhkH7yIsQqtaqEmF/orJL+uqE9k6HyTecwgghY
   d/hVUM8a9BYDRUTS69Bu6hQ0zJbAFz+m8cMdLE5BtU25bkYypRqsDa+AR
   lY3jpMUp/XiSqN96GY6sOqFdsWNwWg7Ke3oEOSAsjlIyySDasa0QADJyU
   oQt8qo5UGws7E/1KgMMQ+zOSYUIe3WLaR0fQgDEteVwHPmxeW2xMApuYB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330691123"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="330691123"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="594787761"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2022 10:39:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F3ACD2; Thu, 12 May 2022 20:39:33 +0300 (EEST)
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
Subject: [PATCH v1 3/5] pinctrl: baytrail: make irq_chip immutable
Date:   Thu, 12 May 2022 20:39:19 +0300
Message-Id: <20220512173921.8210-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

While at it, switch to use hwirq variable instead of offset for
the sake of consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 42 ++++++++++++++----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index f89c9fcd4e1b..31f8f271628c 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1350,15 +1350,15 @@ static void byt_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *vg = gpiochip_get_data(gc);
-	unsigned int offset = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg;
 
-	reg = byt_gpio_reg(vg, offset, BYT_INT_STAT_REG);
+	reg = byt_gpio_reg(vg, hwirq, BYT_INT_STAT_REG);
 	if (!reg)
 		return;
 
 	raw_spin_lock(&byt_lock);
-	writel(BIT(offset % 32), reg);
+	writel(BIT(hwirq % 32), reg);
 	raw_spin_unlock(&byt_lock);
 }
 
@@ -1366,20 +1366,24 @@ static void byt_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *vg = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	byt_gpio_clear_triggering(vg, irqd_to_hwirq(d));
+	byt_gpio_clear_triggering(vg, hwirq);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void byt_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *vg = gpiochip_get_data(gc);
-	unsigned int offset = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	void __iomem *reg;
 	u32 value;
 
-	reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
+	gpiochip_enable_irq(gc, hwirq);
+
+	reg = byt_gpio_reg(vg, hwirq, BYT_CONF0_REG);
 	if (!reg)
 		return;
 
@@ -1412,12 +1416,13 @@ static void byt_irq_unmask(struct irq_data *d)
 static int byt_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(irq_data_get_irq_chip_data(d));
-	u32 offset = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 value;
 	unsigned long flags;
-	void __iomem *reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
+	void __iomem *reg;
 
-	if (!reg || offset >= vg->chip.ngpio)
+	reg = byt_gpio_reg(vg, hwirq, BYT_CONF0_REG);
+	if (!reg)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&byt_lock, flags);
@@ -1447,6 +1452,16 @@ static int byt_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static const struct irq_chip byt_gpio_irq_chip = {
+	.name		= "BYT-GPIO",
+	.irq_ack	= byt_irq_ack,
+	.irq_mask	= byt_irq_mask,
+	.irq_unmask	= byt_irq_unmask,
+	.irq_set_type	= byt_irq_type,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void byt_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
@@ -1633,15 +1648,8 @@ static int byt_gpio_probe(struct intel_pinctrl *vg)
 	if (irq > 0) {
 		struct gpio_irq_chip *girq;
 
-		vg->irqchip.name = "BYT-GPIO",
-		vg->irqchip.irq_ack = byt_irq_ack,
-		vg->irqchip.irq_mask = byt_irq_mask,
-		vg->irqchip.irq_unmask = byt_irq_unmask,
-		vg->irqchip.irq_set_type = byt_irq_type,
-		vg->irqchip.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED,
-
 		girq = &gc->irq;
-		girq->chip = &vg->irqchip;
+		gpio_irq_chip_set_chip(girq, &byt_gpio_irq_chip);
 		girq->init_hw = byt_gpio_irq_init_hw;
 		girq->init_valid_mask = byt_init_irq_valid_mask;
 		girq->parent_handler = byt_gpio_irq_handler;
-- 
2.35.1

