Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9417753A9D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355200AbiFAPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352340AbiFAPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:17:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF74996A4;
        Wed,  1 Jun 2022 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654096628; x=1685632628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZxuQEmdkKs/HEZX6cDHYykMxogzdF5y087a9G86axjU=;
  b=EOgXfalKaZvsW1C/iZG99z2hSZFv4dILN1WUzsZFli44KiFlomXWQlbD
   bUj5UvAWI6nII5wA7YkJ84Gn/C3P0UqEfZo8UXpHT3OMmx5+6hXhBvZi8
   Sm5VC/0CYG0n32jQUVW5JSCrhyhcJQJClDmGf1DW7xrfgvuVIhUxyAAoc
   esFkNkT18E5DjVImnvtib0FFZdnQGzr2XN89rNpM9rQp1kTjQnmoGzOQn
   o258CsZy5rZHFOLyM2Pqj1IENjPy7K8b6eVzjlIgXUv26VyV8aIZo9Myj
   k2+s/Yc2dAYFdRE59udLn59U66NnEw0ObvHr5xnKo3/F/nhTNPLBVQ+eU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263259923"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="263259923"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="720826784"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2022 08:17:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF962F8; Wed,  1 Jun 2022 18:17:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: merrifield: make irq_chip immutable
Date:   Wed,  1 Jun 2022 18:17:07 +0300
Message-Id: <20220601151707.46493-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-merrifield.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index f3d1baeacbe9..72ac09a59702 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -220,10 +220,8 @@ static void mrfld_irq_ack(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static void mrfld_irq_unmask_mask(struct irq_data *d, bool unmask)
+static void mrfld_irq_unmask_mask(struct mrfld_gpio *priv, u32 gpio, bool unmask)
 {
-	struct mrfld_gpio *priv = irq_data_get_irq_chip_data(d);
-	u32 gpio = irqd_to_hwirq(d);
 	void __iomem *gimr = gpio_reg(&priv->chip, gpio, GIMR);
 	unsigned long flags;
 	u32 value;
@@ -241,12 +239,20 @@ static void mrfld_irq_unmask_mask(struct irq_data *d, bool unmask)
 
 static void mrfld_irq_mask(struct irq_data *d)
 {
-	mrfld_irq_unmask_mask(d, false);
+	struct mrfld_gpio *priv = irq_data_get_irq_chip_data(d);
+	u32 gpio = irqd_to_hwirq(d);
+
+	mrfld_irq_unmask_mask(priv, gpio, false);
+	gpiochip_disable_irq(&priv->chip, gpio);
 }
 
 static void mrfld_irq_unmask(struct irq_data *d)
 {
-	mrfld_irq_unmask_mask(d, true);
+	struct mrfld_gpio *priv = irq_data_get_irq_chip_data(d);
+	u32 gpio = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(&priv->chip, gpio);
+	mrfld_irq_unmask_mask(priv, gpio, true);
 }
 
 static int mrfld_irq_set_type(struct irq_data *d, unsigned int type)
@@ -329,13 +335,15 @@ static int mrfld_irq_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
-static struct irq_chip mrfld_irqchip = {
+static const struct irq_chip mrfld_irqchip = {
 	.name		= "gpio-merrifield",
 	.irq_ack	= mrfld_irq_ack,
 	.irq_mask	= mrfld_irq_mask,
 	.irq_unmask	= mrfld_irq_unmask,
 	.irq_set_type	= mrfld_irq_set_type,
 	.irq_set_wake	= mrfld_irq_set_wake,
+	.flags		= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void mrfld_irq_handler(struct irq_desc *desc)
@@ -482,7 +490,7 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		return retval;
 
 	girq = &priv->chip.irq;
-	girq->chip = &mrfld_irqchip;
+	gpio_irq_chip_set_chip(girq, &mrfld_irqchip);
 	girq->init_hw = mrfld_irq_init_hw;
 	girq->parent_handler = mrfld_irq_handler;
 	girq->num_parents = 1;
-- 
2.35.1

