Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001253A99E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352646AbiFAPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354972AbiFAPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:05:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970F64BE8;
        Wed,  1 Jun 2022 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654095897; x=1685631897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LqAg3ztRUMfLy5sWtIGmiUixains/oIwQqd9RH1G25E=;
  b=d35+59d9AEcFmVbb5XKGnmLpCLt88Ip/w5FMm1lTvtGddm1gxZqhKfHg
   HQms7Hx0VecSQ6YKGdKNlPqRlBuWCvFiYhUXroz9kFxxf9YQWWyGlD2iS
   8OrwKhaFtMnhqX9s6dUECN5O1x7afy55HDp17CWg43El4UlofXJeQ0ZzR
   OZdkfvpTvzBHdZiEGMSUG8K0H5cNwnHy8hZpSBTQ3Qf3h+fUDbclgGTPW
   SBcSMD15iEHsi+P2vB2JOlu+nXis3/Tsu7p3ju/VVvOM8L1M7+osq5Z9n
   QU4PkFWtgJnDqDOOzsnm/77hri1xiFg9Qn7u+rAaIa2t8XAwk7OID5pwj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257687421"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257687421"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="720820049"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2022 08:04:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E25CFF8; Wed,  1 Jun 2022 18:04:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/3] gpio: crystalcove: make irq_chip immutable
Date:   Wed,  1 Jun 2022 18:04:44 +0300
Message-Id: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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
 drivers/gpio/gpio-crystalcove.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index b55c74a5e064..f40d3b133527 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/types.h>
 
 #define CRYSTALCOVE_GPIO_NUM	16
 #define CRYSTALCOVE_VGPIO_NUM	95
@@ -238,10 +239,13 @@ static void crystalcove_bus_sync_unlock(struct irq_data *data)
 
 static void crystalcove_irq_unmask(struct irq_data *data)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct crystalcove_gpio *cg = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	gpiochip_enable_irq(gc, hwirq);
 
-	if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
+	if (hwirq < CRYSTALCOVE_GPIO_NUM) {
 		cg->set_irq_mask = false;
 		cg->update |= UPDATE_IRQ_MASK;
 	}
@@ -249,23 +253,27 @@ static void crystalcove_irq_unmask(struct irq_data *data)
 
 static void crystalcove_irq_mask(struct irq_data *data)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct crystalcove_gpio *cg = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
-	if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
+	if (hwirq < CRYSTALCOVE_GPIO_NUM) {
 		cg->set_irq_mask = true;
 		cg->update |= UPDATE_IRQ_MASK;
 	}
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
@@ -353,7 +361,7 @@ static int crystalcove_gpio_probe(struct platform_device *pdev)
 	cg->regmap = pmic->regmap;
 
 	girq = &cg->chip.irq;
-	girq->chip = &crystalcove_irqchip;
+	gpio_irq_chip_set_chip(girq, &crystalcove_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.35.1

