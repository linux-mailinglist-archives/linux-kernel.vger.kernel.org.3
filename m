Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAC5AB852
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIBSfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIBSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA95110D8B;
        Fri,  2 Sep 2022 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143206; x=1693679206;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0rZByPU8jLloX7VT/25CU9V/snC5Hc8cjMfHRRhdw9s=;
  b=dnfJWUC6tXwRfPnkL0U39rA3BEP4z/TQ3u22UsNHK4kC5jFbQIsbke7W
   ktxcAjYV43RgJ8oBmKWeGdr+KRSDxm6aB+0pcSfmNNdUPjgIQtdKmqwC+
   MAxaMTOXCASMz6l7NHASVKrlPBjhrH5WMwZUfTC4jCefS/1jLmfEfpOE/
   jgshlh9sBTcQz1lkT3WCOjKBYdk/LsmRnNuno5FW4d3JIDhRVNid8u/up
   cjjLK1TlOHHwr/ZZjdVRzLVP9X16EoqVwlCehFqxCE6b/3IcLANioPcJ8
   Tf2M5l0OKSGpS0w+03slwgKwAkNRM+0VsJei5wtV3/eyeD2w3kcI6bCeh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296832712"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296832712"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="615791647"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2022 11:26:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D027745; Fri,  2 Sep 2022 21:26:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/17] pinctrl: cy8c95x0: make irq_chip immutable
Date:   Fri,  2 Sep 2022 21:26:34 +0300
Message-Id: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/pinctrl/pinctrl-cy8c95x0.c | 32 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index a29df0920f4f..8bb01f852c54 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -90,7 +90,6 @@ MODULE_DEVICE_TABLE(of, cy8c95x0_dt_ids);
  * @irq_trig_high:  I/O bits affected by a high voltage level
  * @push_pull:      I/O bits configured as push pull driver
  * @shiftmask:      Mask used to compensate for Gport2 width
- * @irq_chip:       IRQ chip configuration
  * @nport:          Number of Gports in this chip
  * @gpio_chip:      gpiolib chip
  * @driver_data:    private driver data
@@ -112,7 +111,6 @@ struct cy8c95x0_pinctrl {
 	DECLARE_BITMAP(irq_trig_high, MAX_LINE);
 	DECLARE_BITMAP(push_pull, MAX_LINE);
 	DECLARE_BITMAP(shiftmask, MAX_LINE);
-	struct irq_chip irq_chip;
 	int nport;
 	struct gpio_chip gpio_chip;
 	unsigned long driver_data;
@@ -844,16 +842,20 @@ static void cy8c95x0_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	set_bit(irqd_to_hwirq(d), chip->irq_mask);
+	set_bit(hwirq, chip->irq_mask);
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void cy8c95x0_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	clear_bit(irqd_to_hwirq(d), chip->irq_mask);
+	gpiochip_enable_irq(gc, hwirq);
+	clear_bit(hwirq, chip->irq_mask);
 }
 
 static void cy8c95x0_irq_bus_lock(struct irq_data *d)
@@ -931,6 +933,18 @@ static void cy8c95x0_irq_shutdown(struct irq_data *d)
 	clear_bit(hwirq, chip->irq_trig_high);
 }
 
+static const struct irq_chip cy8c95x0_irqchip = {
+	.name = "cy8c95x0-irq",
+	.irq_mask = cy8c95x0_irq_mask,
+	.irq_unmask = cy8c95x0_irq_unmask,
+	.irq_bus_lock = cy8c95x0_irq_bus_lock,
+	.irq_bus_sync_unlock = cy8c95x0_irq_bus_sync_unlock,
+	.irq_set_type = cy8c95x0_irq_set_type,
+	.irq_shutdown = cy8c95x0_irq_shutdown,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static bool cy8c95x0_irq_pending(struct cy8c95x0_pinctrl *chip, unsigned long *pending)
 {
 	DECLARE_BITMAP(ones, MAX_LINE);
@@ -1136,7 +1150,6 @@ static const struct pinconf_ops cy8c95x0_pinconf_ops = {
 
 static int cy8c95x0_irq_setup(struct cy8c95x0_pinctrl *chip, int irq)
 {
-	struct irq_chip *irq_chip = &chip->irq_chip;
 	struct gpio_irq_chip *girq = &chip->gpio_chip.irq;
 	DECLARE_BITMAP(pending_irqs, MAX_LINE);
 	int ret;
@@ -1155,15 +1168,8 @@ static int cy8c95x0_irq_setup(struct cy8c95x0_pinctrl *chip, int irq)
 	/* Mask all interrupts */
 	bitmap_fill(chip->irq_mask, MAX_LINE);
 
-	irq_chip->name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-irq", chip->name);
-	irq_chip->irq_mask = cy8c95x0_irq_mask;
-	irq_chip->irq_unmask = cy8c95x0_irq_unmask;
-	irq_chip->irq_bus_lock = cy8c95x0_irq_bus_lock;
-	irq_chip->irq_bus_sync_unlock = cy8c95x0_irq_bus_sync_unlock;
-	irq_chip->irq_set_type = cy8c95x0_irq_set_type;
-	irq_chip->irq_shutdown = cy8c95x0_irq_shutdown;
+	gpio_irq_chip_set_chip(girq, &cy8c95x0_irqchip);
 
-	girq->chip = irq_chip;
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.35.1

