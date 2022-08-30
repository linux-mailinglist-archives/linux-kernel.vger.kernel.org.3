Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8690B5A6C21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH3S2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiH3S2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:28:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470A62AA7;
        Tue, 30 Aug 2022 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661884116; x=1693420116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YfXWSBWHSc7nzFXc3C8U0RLqVjkKnSLqKhiNl+qs3I0=;
  b=d9puZdKAwMkyNhqQt8BOi1HjCS7KSry/rAJFVnoN6+B1yYfvb4+cWe6a
   0+ZP7YCZJ44tI8LnbTDhwWEPQfTtdxKTFxLZd/d0PCHDT0eL//sXfTj7o
   5PnjyqGQCDNVTQlckrOFwuBFfUr0ZMhjM43ekrpY2kpqQ9q6a7REkdXLI
   7kva3R3mtUe8KquWDSvr92S3DP8kza4Kedv91gZKAdhkBPrId1BECkfap
   H3ICv1yfW5Ta3pV2Dp97mMxCBvCFLCnWWvy7qoOf47/iLVpR6EyXh74LS
   WsGw9R2sPL1A/cRqgVBtz61sFN4xpyH7FOGmpJqWdxWUKdsCCSNesP1ro
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="292846189"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="292846189"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562763453"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 11:28:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6672174; Tue, 30 Aug 2022 21:28:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v1 1/1] Input: clps711x-keypad - get rid of OF_GPIO dependency
Date:   Tue, 30 Aug 2022 21:28:39 +0300
Message-Id: <20220830182839.47965-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no such dependency in the driver, but it's implicitly
used to have OF property APIs available. Replace that by device
property API and get rid of OF_GPIO dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/keyboard/Kconfig           |  2 +-
 drivers/input/keyboard/clps711x-keypad.c | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a20ee693b22b..2c6cef222f9c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -186,7 +186,7 @@ config KEYBOARD_QT2160
 
 config KEYBOARD_CLPS711X
 	tristate "CLPS711X Keypad support"
-	depends on OF_GPIO && (ARCH_CLPS711X || COMPILE_TEST)
+	depends on ARCH_CLPS711X || COMPILE_TEST
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here to enable the matrix keypad on the Cirrus Logic
diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
index 939c88655fc0..4c1a3e611edd 100644
--- a/drivers/input/keyboard/clps711x-keypad.c
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -6,9 +6,11 @@
  */
 
 #include <linux/input.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
 #include <linux/input/matrix_keypad.h>
@@ -86,7 +88,6 @@ static int clps711x_keypad_probe(struct platform_device *pdev)
 {
 	struct clps711x_keypad_data *priv;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct input_dev *input;
 	u32 poll_interval;
 	int i, err;
@@ -95,11 +96,11 @@ static int clps711x_keypad_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
+	priv->syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
 	if (IS_ERR(priv->syscon))
 		return PTR_ERR(priv->syscon);
 
-	priv->row_count = of_gpio_named_count(np, "row-gpios");
+	priv->row_count = gpiod_count(dev, "row");
 	if (priv->row_count < 1)
 		return -EINVAL;
 
@@ -119,7 +120,7 @@ static int clps711x_keypad_probe(struct platform_device *pdev)
 			return PTR_ERR(data->desc);
 	}
 
-	err = of_property_read_u32(np, "poll-interval", &poll_interval);
+	err = device_property_read_u32(dev, "poll-interval", &poll_interval);
 	if (err)
 		return err;
 
@@ -143,7 +144,7 @@ static int clps711x_keypad_probe(struct platform_device *pdev)
 		return err;
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
-	if (of_property_read_bool(np, "autorepeat"))
+	if (device_property_read_bool(dev, "autorepeat"))
 		__set_bit(EV_REP, input->evbit);
 
 	/* Set all columns to low */
-- 
2.35.1

