Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A84E7E10
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiCYUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiCYUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:42:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AAD17F3F5;
        Fri, 25 Mar 2022 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648240856; x=1679776856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y0LAZAqsK93XWpNG5nw/oj1tHbeQR9usbzd6pJvOx4I=;
  b=KUiglmnAl9c7XS+0MpOoemSwrM2rg2dZS8V7XrqWcubgM/WZ/9UtCUXS
   YqH1kuh0/2V7XEMHM7Bum6zay3154BcHJyM6K2kYLBb+1T2IxCMqWjbJm
   c7OtLc3pLeLeBFmdSAy1R2Ow69b6X6g/WW9HGlvLLaaFSXFNS8qX1WzN/
   ApJPcdcMiy+k4sV3HKHMV0lVpuQiChOQEZ1yQVk2ZfFCq715hVZcOiyzk
   oYDWUE5NRxr9AOEb5A2dyXQ6LqIgmsTJAGsHsJktIT5cBmy4pvpDtsZjP
   3o4GBN9VEjKsrGU1uFbibZDuM/JoLGskBl6/SJ6JL0IwP44uVfLFSfoyx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="239311414"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="239311414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="617232702"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2022 13:14:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7E8F11E; Fri, 25 Mar 2022 22:14:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: armada-37xx: Switch to use fwnode instead of of_node
Date:   Fri, 25 Mar 2022 22:14:25 +0200
Message-Id: <20220325201425.54847-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index ba94125f6566..6c2b25418754 100644
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
@@ -783,18 +784,13 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
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
+	fwnode = device_get_named_child_node(dev, "gpio-controller");
+	if (!fwnode)
+		return -ENODEV;
 
 	info->gpio_chip = armada_37xx_gpiolib_chip;
 
@@ -802,7 +798,7 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
 	gc->ngpio = info->data->nr_pins;
 	gc->parent = dev;
 	gc->base = -1;
-	gc->of_node = np;
+	gc->fwnode = fwnode;
 	gc->label = info->data->name;
 
 	ret = armada_37xx_irqchip_register(pdev, info);
-- 
2.35.1

