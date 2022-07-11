Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D6E570CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiGKVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGKVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:35:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090E2714D;
        Mon, 11 Jul 2022 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575327; x=1689111327;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H6ArmHTQ6yeMw2auxyxhCIrckwMnvtSOg5e2BDHKOUU=;
  b=dnZHvjG9owpQbE6SWn536KKa9xpY9lcEd8ky0KiGTu4iUeLVyzZ6w1mJ
   4gHa0JoxKSf8Cas4uhReC+YrVDwYR8fYGaQQc4cYqwtsJPf0e8Cy5YUOo
   RcFBeVFxCa0NrLhYwZ5y44dzcC/Ny1KmyII0A1x0wKWHB4irImkzPfmuP
   GceJj/A0PH4RsJ1B2Y6czug3K7I9nFwRlpxBNvbEupt5SpQNeVjmhktk9
   9TpfK5aedUFpRzJ6CdIvhRU9wwQexi7veTb4xsFQxbUe85hpQVjbiW74T
   3nTAAx8ZWpMq3u2gnxBU2sPbUWgC3p1Bn6owzovCSprHvq7WVhYuJRoJb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310383929"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="310383929"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="599165379"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2022 14:35:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6C4271A0; Tue, 12 Jul 2022 00:35:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] leds: is31fl319x: Make use of device properties
Date:   Tue, 12 Jul 2022 00:35:20 +0300
Message-Id: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/Kconfig           |  2 +-
 drivers/leds/leds-is31fl319x.c | 44 ++++++++++++++++------------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a49979f41eee..9a896be26dc7 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -697,7 +697,7 @@ config LEDS_MENF21BMC
 
 config LEDS_IS31FL319X
 	tristate "LED Support for ISSI IS31FL319x I2C LED controller family"
-	depends on LEDS_CLASS && I2C && OF
+	depends on LEDS_CLASS && I2C
 	select REGMAP_I2C
 	help
 	  This option enables support for LEDs connected to ISSI IS31FL319x
diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 056cf3bcffdc..b1a0ca340e24 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -11,9 +11,9 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -362,25 +362,23 @@ static const struct of_device_id of_is31fl319x_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_is31fl319x_match);
 
-static int is31fl319x_parse_child_dt(const struct device *dev,
-				     const struct device_node *child,
+static int is31fl319x_parse_child_fw(const struct device *dev,
+				     const struct fwnode_handle *child,
 				     struct is31fl319x_led *led,
 				     struct is31fl319x_chip *is31)
 {
 	struct led_classdev *cdev = &led->cdev;
 	int ret;
 
-	if (of_property_read_string(child, "label", &cdev->name))
-		cdev->name = child->name;
+	if (fwnode_property_read_string(child, "label", &cdev->name))
+		cdev->name = fwnode_get_name(child);
 
-	ret = of_property_read_string(child, "linux,default-trigger",
-				      &cdev->default_trigger);
+	ret = fwnode_property_read_string(child, "linux,default-trigger", &cdev->default_trigger);
 	if (ret < 0 && ret != -EINVAL) /* is optional */
 		return ret;
 
 	led->max_microamp = is31->cdef->current_default;
-	ret = of_property_read_u32(child, "led-max-microamp",
-				   &led->max_microamp);
+	ret = fwnode_property_read_u32(child, "led-max-microamp", &led->max_microamp);
 	if (!ret) {
 		if (led->max_microamp < is31->cdef->current_min)
 			return -EINVAL;	/* not supported */
@@ -391,16 +389,12 @@ static int is31fl319x_parse_child_dt(const struct device *dev,
 	return 0;
 }
 
-static int is31fl319x_parse_dt(struct device *dev,
-			       struct is31fl319x_chip *is31)
+static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 {
-	struct device_node *np = dev_of_node(dev), *child;
+	struct fwnode_handle *fwnode = dev_fwnode(dev), *child;
 	int count;
 	int ret;
 
-	if (!np)
-		return -ENODEV;
-
 	is31->shutdown_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(is31->shutdown_gpio)) {
 		ret = PTR_ERR(is31->shutdown_gpio);
@@ -410,7 +404,9 @@ static int is31fl319x_parse_dt(struct device *dev,
 
 	is31->cdef = device_get_match_data(dev);
 
-	count = of_get_available_child_count(np);
+	count = 0;
+	fwnode_for_each_available_child_node(fwnode, child)
+		count++;
 
 	dev_dbg(dev, "probing with %d leds defined in DT\n", count);
 
@@ -420,11 +416,11 @@ static int is31fl319x_parse_dt(struct device *dev,
 		return -ENODEV;
 	}
 
-	for_each_available_child_of_node(np, child) {
+	fwnode_for_each_available_child_node(fwnode, child) {
 		struct is31fl319x_led *led;
 		u32 reg;
 
-		ret = of_property_read_u32(child, "reg", &reg);
+		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret) {
 			dev_err(dev, "Failed to read led 'reg' property\n");
 			goto put_child_node;
@@ -444,7 +440,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 			goto put_child_node;
 		}
 
-		ret = is31fl319x_parse_child_dt(dev, child, led, is31);
+		ret = is31fl319x_parse_child_fw(dev, child, led, is31);
 		if (ret) {
 			dev_err(dev, "led %u DT parsing failed\n", reg);
 			goto put_child_node;
@@ -455,7 +451,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 
 	is31->audio_gain_db = 0;
 	if (is31->cdef->is_3196or3199) {
-		ret = of_property_read_u32(np, "audio-gain-db", &is31->audio_gain_db);
+		ret = fwnode_property_read_u32(fwnode, "audio-gain-db", &is31->audio_gain_db);
 		if (!ret)
 			is31->audio_gain_db = min(is31->audio_gain_db,
 						  IS31FL3196_AUDIO_GAIN_DB_MAX);
@@ -464,7 +460,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 	return 0;
 
 put_child_node:
-	of_node_put(child);
+	fwnode_handle_put(child);
 	return ret;
 }
 
@@ -521,7 +517,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 
 	mutex_init(&is31->lock);
 
-	err = is31fl319x_parse_dt(&client->dev, is31);
+	err = is31fl319x_parse_fw(&client->dev, is31);
 	if (err)
 		goto free_mutex;
 
@@ -619,7 +615,7 @@ MODULE_DEVICE_TABLE(i2c, is31fl319x_id);
 static struct i2c_driver is31fl319x_driver = {
 	.driver   = {
 		.name           = "leds-is31fl319x",
-		.of_match_table = of_match_ptr(of_is31fl319x_match),
+		.of_match_table = of_is31fl319x_match,
 	},
 	.probe    = is31fl319x_probe,
 	.remove   = is31fl319x_remove,
-- 
2.35.1

