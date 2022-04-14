Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AAD501B87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbiDNTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244730AbiDNTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:05:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9756EA342;
        Thu, 14 Apr 2022 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649962967; x=1681498967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdE1RKZsiTimWQo56IAW2eBaZpgN2e/gySOlkjZQK7w=;
  b=JeH+T84CMrZSRteTS9dF2Z+Q6R/Lokr3wFVU8wOTZZwZWowcfmVoNNcf
   E3ro6/AH4kYIJrGFF1HcvFoUYak7Z8hvAZd62csLX2bIRzKX5R/w5kPxH
   rGWLEWbb5uth3zEbt/H7s63Pvfb4KJfQyGu9oUEkQi6xhZ0/PTGRX8pRv
   rsShOCKUeP6F4f01P+bp4uTKgaYZGJnMOYKi2OfQakuhHR0ryYTjO1jA1
   Is7splAXAJznQ4o3qdaDT4YYC+wuDnBTzgH2RWG9nkzG0fcP5HdAUWXbk
   rvl/bBzy3o5rwF4OWZvUdRfdBGIoFNKL1s/mNi1Dn+BitcMiBz0JKQxMP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250308376"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="250308376"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 12:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="645735755"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2022 12:02:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 755FF144; Thu, 14 Apr 2022 22:02:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 2/6] pinctrl: armada-37xx: Switch to use fwnode instead of of_node
Date:   Thu, 14 Apr 2022 22:02:38 +0300
Message-Id: <20220414190242.22178-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node,
so switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 08cad14042e2..110f70bce3fe 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/string_helpers.h>
@@ -787,18 +788,13 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
 					struct armada_37xx_pinctrl *info)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
+	struct fwnode_handle *fwnode;
 	struct gpio_chip *gc;
-	int ret = -ENODEV;
+	int ret;
 
-	for_each_child_of_node(dev->of_node, np) {
-		if (of_find_property(np, "gpio-controller", NULL)) {
-			ret = 0;
-			break;
-		}
-	}
-	if (ret)
-		return ret;
+	fwnode = gpiochip_node_get_first(dev);
+	if (!fwnode)
+		return -ENODEV;
 
 	info->gpio_chip = armada_37xx_gpiolib_chip;
 
@@ -806,7 +802,7 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
 	gc->ngpio = info->data->nr_pins;
 	gc->parent = dev;
 	gc->base = -1;
-	gc->of_node = np;
+	gc->fwnode = fwnode;
 	gc->label = info->data->name;
 
 	ret = armada_37xx_irqchip_register(pdev, info);
-- 
2.35.1

