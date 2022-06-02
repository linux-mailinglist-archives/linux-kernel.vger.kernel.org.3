Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6619553B7BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiFBL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFBL0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:26:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1F26D368;
        Thu,  2 Jun 2022 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654169169; x=1685705169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/wJRKIbC3EFh/krWyBfZNPgJelfCQhMivFD9CA8TVK8=;
  b=SjxWjmCj51Xvouzun2sMhgwOFB3BAry2QrnmDJYdOkVLc0Cztx8HEaa6
   HDXVdRCEilWku3W+/TRGMNBNAakPuq0oTZwktc+gL5qZrl7CUQPDjSGpO
   Zp6sDdNlNxVoF/d0hH4JCLUNr3gb7Ph8nalbPivrenHjuYYH1Pd2peot8
   m2l3lZ885ftSi1K4CHoeWqjnAh/4VIU6QbzpqTIOJSAMGRZlFpyKYe9e5
   Wgqxn0ZKtW/mRl2NK5Opqz5gBXSFm9I/OM+rWCOdyV1yfE6XTaCkqhbp6
   sQtdVK/F29gXjpO2giQnk+r3S666ruxTC37eWOGsfTYbEc3k31/BcyVC0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="255784724"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="255784724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="904944059"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2022 04:26:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B202F8; Thu,  2 Jun 2022 14:26:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/3] gpio: crystalcove: make irq_chip immutable
Date:   Thu,  2 Jun 2022 14:25:59 +0300
Message-Id: <20220602112601.12010-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
v2: called GPIO helpers only for real GPIOs in IRQ callbacks
 drivers/gpio/gpio-crystalcove.c | 40 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index b55c74a5e064..cf33041533aa 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/types.h>
 
 #define CRYSTALCOVE_GPIO_NUM	16
 #define CRYSTALCOVE_VGPIO_NUM	95
@@ -238,34 +239,43 @@ static void crystalcove_bus_sync_unlock(struct irq_data *data)
 
 static void crystalcove_irq_unmask(struct irq_data *data)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct crystalcove_gpio *cg = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
-	if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
-		cg->set_irq_mask = false;
-		cg->update |= UPDATE_IRQ_MASK;
-	}
+	if (hwirq >= CRYSTALCOVE_GPIO_NUM)
+		return;
+
+	gpiochip_enable_irq(gc, hwirq);
+
+	cg->set_irq_mask = false;
+	cg->update |= UPDATE_IRQ_MASK;
 }
 
 static void crystalcove_irq_mask(struct irq_data *data)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct crystalcove_gpio *cg = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
-	if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
-		cg->set_irq_mask = true;
-		cg->update |= UPDATE_IRQ_MASK;
-	}
+	if (hwirq >= CRYSTALCOVE_GPIO_NUM)
+		return;
+
+	cg->set_irq_mask = true;
+	cg->update |= UPDATE_IRQ_MASK;
+
+	gpiochip_disable_irq(gc, hwirq);
 }
 
-static struct irq_chip crystalcove_irqchip = {
+static const struct irq_chip crystalcove_irqchip = {
 	.name			= "Crystal Cove",
 	.irq_mask		= crystalcove_irq_mask,
 	.irq_unmask		= crystalcove_irq_unmask,
 	.irq_set_type		= crystalcove_irq_type,
 	.irq_bus_lock		= crystalcove_bus_lock,
 	.irq_bus_sync_unlock	= crystalcove_bus_sync_unlock,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t crystalcove_gpio_irq_handler(int irq, void *data)
@@ -353,7 +363,7 @@ static int crystalcove_gpio_probe(struct platform_device *pdev)
 	cg->regmap = pmic->regmap;
 
 	girq = &cg->chip.irq;
-	girq->chip = &crystalcove_irqchip;
+	gpio_irq_chip_set_chip(girq, &crystalcove_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.35.1

