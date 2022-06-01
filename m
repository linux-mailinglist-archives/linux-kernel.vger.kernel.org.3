Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2A53AA50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355739AbiFAPhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351279AbiFAPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:37:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184A3587F;
        Wed,  1 Jun 2022 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654097849; x=1685633849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IMV7FgsT0NHUVmOYXh7cvaQQcC4fnWUbm7XEhHmvcxM=;
  b=hxusySzkXlsb/o9g7TY+O+JsSvLGWyl6wl6ge7PeKQWI2WvbF4nShoXL
   x93OwmbMDhq0/weTky9/h7OQ0xAWjKuqN073uyzTd+wFUc+oHtXOPxBLv
   I+HjneHaCacofmrYbBNn01kgOCZCHeOLtolb0qvZZO5aYuqptW1kc+mfL
   72uNzOPOs0QUAy6u580QnxK8uW7tTUw0JSLsAjEFByA4yFTmWOhQC/c85
   yhWE76SkGkvImvhyU3LWorqInEUjQQIwZisjtUw4H8LTI+QzK9Mpr4t2u
   Co3ffVqQ1w5EeNbWrSOu34aID4+OwJAmIMNgKoA/bDXTFY3u/KxRYUqi3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="255500923"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="255500923"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="530113964"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 08:37:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83806F8; Wed,  1 Jun 2022 18:37:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: sch: make irq_chip immutable
Date:   Wed,  1 Jun 2022 18:36:56 +0300
Message-Id: <20220601153656.76454-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-sch.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index acda4c5052d3..8a83f7bf4382 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -38,7 +38,6 @@
 
 struct sch_gpio {
 	struct gpio_chip chip;
-	struct irq_chip irqchip;
 	spinlock_t lock;
 	unsigned short iobase;
 	unsigned short resume_base;
@@ -218,11 +217,9 @@ static void sch_irq_ack(struct irq_data *d)
 	spin_unlock_irqrestore(&sch->lock, flags);
 }
 
-static void sch_irq_mask_unmask(struct irq_data *d, int val)
+static void sch_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t gpio_num, int val)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct sch_gpio *sch = gpiochip_get_data(gc);
-	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&sch->lock, flags);
@@ -232,14 +229,32 @@ static void sch_irq_mask_unmask(struct irq_data *d, int val)
 
 static void sch_irq_mask(struct irq_data *d)
 {
-	sch_irq_mask_unmask(d, 0);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
+
+	sch_irq_mask_unmask(gc, gpio_num, 0);
+	gpiochip_disable_irq(gc, gpio_num);
 }
 
 static void sch_irq_unmask(struct irq_data *d)
 {
-	sch_irq_mask_unmask(d, 1);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(gc, gpio_num);
+	sch_irq_mask_unmask(gc, gpio_num, 1);
 }
 
+static const struct irq_chip sch_irqchip = {
+	.name = "sch_gpio",
+	.irq_ack = sch_irq_ack,
+	.irq_mask = sch_irq_mask,
+	.irq_unmask = sch_irq_unmask,
+	.irq_set_type = sch_irq_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static u32 sch_gpio_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 {
 	struct sch_gpio *sch = context;
@@ -367,14 +382,8 @@ static int sch_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sch);
 
-	sch->irqchip.name = "sch_gpio";
-	sch->irqchip.irq_ack = sch_irq_ack;
-	sch->irqchip.irq_mask = sch_irq_mask;
-	sch->irqchip.irq_unmask = sch_irq_unmask;
-	sch->irqchip.irq_set_type = sch_irq_type;
-
 	girq = &sch->chip.irq;
-	girq->chip = &sch->irqchip;
+	gpio_irq_chip_set_chip(girq, &sch_irqchip);
 	girq->num_parents = 0;
 	girq->parents = NULL;
 	girq->parent_handler = NULL;
-- 
2.35.1

