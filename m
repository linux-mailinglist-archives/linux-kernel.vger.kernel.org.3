Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852A953AA6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiFAPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355870AbiFAPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:48:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB615A5026;
        Wed,  1 Jun 2022 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654098515; x=1685634515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+JUWCeXHDxrtBD2gmRVwSR4bH4BC9bWwvJ+0OSzAwRM=;
  b=XRjgxirVHayDw1LK2qc7/EdvzU+bU9fp7so7MxRmyH+4dEhNeQT4tpx0
   m0K/g8MXNFx6CLxuBxlbAs+dKEj5Hx4ki67nK3kBiz9GRQaCnVyMZ2i0l
   4rSZRkYB47G0VXdnC6k9NjJjZDvBzNKsjLpLAxO7c18uZoDZyXTq9YcKy
   S4u8vLUjqR6zgoVGpYtNf5THIGKFnecY4aZx+turTyBwLkhiOykFqWVd2
   0uHzmOV4PebC+X/YU9wXxnW+T0nJm5myUq0jM2s4AGmHiYbGXWNXmYHr1
   Hs65/CQtx2ApvfgG0RAAjveEbb4xSzvKTlWh6ptTz2UdH+/1RqAwhx9BL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263269175"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="263269175"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="756252603"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 08:48:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D611F8; Wed,  1 Jun 2022 18:48:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: wcove: make irq_chip immutable
Date:   Wed,  1 Jun 2022 18:48:33 +0300
Message-Id: <20220601154833.2173-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-wcove.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 16a0fae1e32e..c18b6b47384f 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -299,6 +299,8 @@ static void wcove_irq_unmask(struct irq_data *data)
 	if (gpio >= WCOVE_GPIO_NUM)
 		return;
 
+	gpiochip_enable_irq(chip, gpio);
+
 	wg->set_irq_mask = false;
 	wg->update |= UPDATE_IRQ_MASK;
 }
@@ -314,15 +316,19 @@ static void wcove_irq_mask(struct irq_data *data)
 
 	wg->set_irq_mask = true;
 	wg->update |= UPDATE_IRQ_MASK;
+
+	gpiochip_disable_irq(chip, gpio);
 }
 
-static struct irq_chip wcove_irqchip = {
+static const struct irq_chip wcove_irqchip = {
 	.name			= "Whiskey Cove",
 	.irq_mask		= wcove_irq_mask,
 	.irq_unmask		= wcove_irq_unmask,
 	.irq_set_type		= wcove_irq_type,
 	.irq_bus_lock		= wcove_bus_lock,
 	.irq_bus_sync_unlock	= wcove_bus_sync_unlock,
+	.flags			= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t wcove_gpio_irq_handler(int irq, void *data)
@@ -452,7 +458,7 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 	}
 
 	girq = &wg->chip.irq;
-	girq->chip = &wcove_irqchip;
+	gpio_irq_chip_set_chip(girq, &wcove_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.35.1

