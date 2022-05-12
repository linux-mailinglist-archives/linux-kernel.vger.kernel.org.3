Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0E5253DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357163AbiELRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357130AbiELRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:39:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1826709D;
        Thu, 12 May 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377177; x=1683913177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nybsqFuOSxsesOybfPjcLR1CetTbOyukDDpcrXaTOeU=;
  b=gmnZynLd0YDlCfnIL61UAoVwRdNeNpB062jaWi+xQnRWeY4bAwjMbiCO
   dkPo7n2/WWRucDzB+ULUX8bhuRGZiE7IItSzoXo4MqKKnd3wk+D1PtEE7
   9qvkBxkJNBFlaAwKO5GanLWNyx2jseqFV4PfrliXGvJnqid+Fey6eFdye
   5uEzUbvmmnJ+IUjyU37esyii0ze4L0zdxlYlAK6rx/FXxrbwfZe4bpb0G
   9GTMYpgwTQuDD6UKwpgQSMqAcXreJbF9G6JgwXd7dF/d1EMz5thqA12BI
   L81Et2jL7hnfNc3T8IW+EDloTOLzY29kUDh4NA/oDcfmGyIp1cHhrnvMG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333123609"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="333123609"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="698140588"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2022 10:39:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D60E109; Thu, 12 May 2022 20:39:33 +0300 (EEST)
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
Subject: [PATCH v1 4/5] pinctrl: cherryview: make irq_chip immutable
Date:   Thu, 12 May 2022 20:39:20 +0300
Message-Id: <20220512173921.8210-4-andriy.shevchenko@linux.intel.com>
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

While at it, switch to use hwirq variable instead of pin for
the sake of consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 65 +++++++++++++---------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 1d5818269076..b696f9392789 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1242,12 +1242,12 @@ static void chv_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	int pin = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 intr_line;
 
 	raw_spin_lock(&chv_lock);
 
-	intr_line = chv_readl(pctrl, pin, CHV_PADCTRL0);
+	intr_line = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 	intr_line &= CHV_PADCTRL0_INTSEL_MASK;
 	intr_line >>= CHV_PADCTRL0_INTSEL_SHIFT;
 	chv_pctrl_writel(pctrl, CHV_INTSTAT, BIT(intr_line));
@@ -1255,17 +1255,16 @@ static void chv_gpio_irq_ack(struct irq_data *d)
 	raw_spin_unlock(&chv_lock);
 }
 
-static void chv_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
+static void chv_gpio_irq_mask_unmask(struct irq_data *d, irq_hw_number_t hwirq, bool mask)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	int pin = irqd_to_hwirq(d);
 	u32 value, intr_line;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
-	intr_line = chv_readl(pctrl, pin, CHV_PADCTRL0);
+	intr_line = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 	intr_line &= CHV_PADCTRL0_INTSEL_MASK;
 	intr_line >>= CHV_PADCTRL0_INTSEL_SHIFT;
 
@@ -1281,12 +1280,20 @@ static void chv_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 
 static void chv_gpio_irq_mask(struct irq_data *d)
 {
-	chv_gpio_irq_mask_unmask(d, true);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	chv_gpio_irq_mask_unmask(d, hwirq, true);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void chv_gpio_irq_unmask(struct irq_data *d)
 {
-	chv_gpio_irq_mask_unmask(d, false);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(gc, hwirq);
+	chv_gpio_irq_mask_unmask(d, hwirq, false);
 }
 
 static unsigned chv_gpio_irq_startup(struct irq_data *d)
@@ -1306,17 +1313,17 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 		struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 		struct device *dev = pctrl->dev;
 		struct intel_community_context *cctx = &pctrl->context.communities[0];
-		unsigned int pin = irqd_to_hwirq(d);
+		irq_hw_number_t hwirq = irqd_to_hwirq(d);
 		irq_flow_handler_t handler;
 		unsigned long flags;
 		u32 intsel, value;
 
 		raw_spin_lock_irqsave(&chv_lock, flags);
-		intsel = chv_readl(pctrl, pin, CHV_PADCTRL0);
+		intsel = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 		intsel &= CHV_PADCTRL0_INTSEL_MASK;
 		intsel >>= CHV_PADCTRL0_INTSEL_SHIFT;
 
-		value = chv_readl(pctrl, pin, CHV_PADCTRL1);
+		value = chv_readl(pctrl, hwirq, CHV_PADCTRL1);
 		if (value & CHV_PADCTRL1_INTWAKECFG_LEVEL)
 			handler = handle_level_irq;
 		else
@@ -1324,9 +1331,9 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 
 		if (cctx->intr_lines[intsel] == CHV_INVALID_HWIRQ) {
 			irq_set_handler_locked(d, handler);
-			dev_dbg(dev, "using interrupt line %u for IRQ_TYPE_NONE on pin %u\n",
-				intsel, pin);
-			cctx->intr_lines[intsel] = pin;
+			dev_dbg(dev, "using interrupt line %u for IRQ_TYPE_NONE on pin %lu\n",
+				intsel, hwirq);
+			cctx->intr_lines[intsel] = hwirq;
 		}
 		raw_spin_unlock_irqrestore(&chv_lock, flags);
 	}
@@ -1392,14 +1399,14 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	unsigned int pin = irqd_to_hwirq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 value;
 	int ret;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
-	ret = chv_gpio_set_intr_line(pctrl, pin);
+	ret = chv_gpio_set_intr_line(pctrl, hwirq);
 	if (ret)
 		goto out_unlock;
 
@@ -1416,8 +1423,8 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 	 * 2. If the pin cfg is not locked in BIOS:
 	 *	Driver programs the IntWakeCfg bits and save the mapping.
 	 */
-	if (!chv_pad_locked(pctrl, pin)) {
-		value = chv_readl(pctrl, pin, CHV_PADCTRL1);
+	if (!chv_pad_locked(pctrl, hwirq)) {
+		value = chv_readl(pctrl, hwirq, CHV_PADCTRL1);
 		value &= ~CHV_PADCTRL1_INTWAKECFG_MASK;
 		value &= ~CHV_PADCTRL1_INVRXTX_MASK;
 
@@ -1434,7 +1441,7 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 				value |= CHV_PADCTRL1_INVRXTX_RXDATA;
 		}
 
-		chv_writel(pctrl, pin, CHV_PADCTRL1, value);
+		chv_writel(pctrl, hwirq, CHV_PADCTRL1, value);
 	}
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -1448,6 +1455,17 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 	return ret;
 }
 
+static const struct irq_chip chv_gpio_irq_chip = {
+	.name		= "chv-gpio",
+	.irq_startup	= chv_gpio_irq_startup,
+	.irq_ack	= chv_gpio_irq_ack,
+	.irq_mask	= chv_gpio_irq_mask,
+	.irq_unmask	= chv_gpio_irq_unmask,
+	.irq_set_type	= chv_gpio_irq_type,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void chv_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
@@ -1611,15 +1629,8 @@ static int chv_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 	chip->base = -1;
 
 	pctrl->irq = irq;
-	pctrl->irqchip.name = "chv-gpio";
-	pctrl->irqchip.irq_startup = chv_gpio_irq_startup;
-	pctrl->irqchip.irq_ack = chv_gpio_irq_ack;
-	pctrl->irqchip.irq_mask = chv_gpio_irq_mask;
-	pctrl->irqchip.irq_unmask = chv_gpio_irq_unmask;
-	pctrl->irqchip.irq_set_type = chv_gpio_irq_type;
-	pctrl->irqchip.flags = IRQCHIP_SKIP_SET_WAKE;
-
-	chip->irq.chip = &pctrl->irqchip;
+
+	gpio_irq_chip_set_chip(&chip->irq, &chv_gpio_irq_chip);
 	chip->irq.init_hw = chv_gpio_irq_init_hw;
 	chip->irq.parent_handler = chv_gpio_irq_handler;
 	chip->irq.num_parents = 1;
-- 
2.35.1

