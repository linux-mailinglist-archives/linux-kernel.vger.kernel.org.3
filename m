Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16185AB855
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIBSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiIBSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFF110DA9;
        Fri,  2 Sep 2022 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143210; x=1693679210;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LnuYAt94YWSAPrjoHbzV8WP/hTfRRBDfaaIMJkQKpyg=;
  b=nJARMmgLEGmdtKRJILrRTx82k8ID2zj+Q6zWaz8QY4ocwE0wlgOIZaxm
   qX2K2py7JYChbU9227G2qdzSzEXIvoSVnW2k9j8u6x9glP1xT+M+SrP5Q
   wGgqq3u7L6EvGTwaj2nd91dHgdvSymxg99b+J1FNPSuDy/HohPJ0Apauv
   4r99YmPf4MG2iMY7RjPfTO4WbifNUIEnAZh1vfiv8nrWjBlAd0q72s+OL
   ekahOGjXAk8DxxqKTKKejJ+T9aJWCiE3d4I2MVH6nCjBSKlgaps+Ggs4C
   yRCFJJRv47F2aHSqUfctiRljmgacV1OLuQMO67wkHQbn/I1QyPwaSz5ws
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="283034558"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="283034558"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="681373079"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 512D0713; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/17] pinctrl: cy8c95x0: Make use of device properties
Date:   Fri,  2 Sep 2022 21:26:46 +0300
Message-Id: <20220902182650.83098-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
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

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/Kconfig            |  2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index fc0e529e633f..c09562fbb1b7 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -137,7 +137,7 @@ config PINCTRL_BM1880
 
 config PINCTRL_CY8C95X0
 	tristate "Cypress CY8C95X0 I2C pinctrl and GPIO driver"
-	depends on I2C && OF
+	depends on I2C
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
 	select PINMUX
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index ea81b5ae27a6..699da63d9c39 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -13,15 +13,16 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 
 /* Fast access registers */
 #define CY8C95X0_INPUT		0x00
@@ -1040,8 +1041,10 @@ static const struct pinctrl_ops cy8c95x0_pinctrl_ops = {
 	.get_groups_count = cy8c95x0_pinctrl_get_groups_count,
 	.get_group_name = cy8c95x0_pinctrl_get_group_name,
 	.get_group_pins = cy8c95x0_pinctrl_get_group_pins,
+#ifdef CONFIG_OF
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
 	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
 	.pin_dbg_show = cy8c95x0_pin_dbg_show,
 };
 
@@ -1245,9 +1248,8 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	chip->dev = &client->dev;
 
 	/* Set the device type */
-	if (client->dev.of_node)
-		chip->driver_data = (unsigned long)of_device_get_match_data(&client->dev);
-	else
+	chip->driver_data = (unsigned long)device_get_match_data(&client->dev);
+	if (!chip->driver_data)
 		chip->driver_data = i2c_match_id(cy8c95x0_id, client)->driver_data;
 
 	if (!chip->driver_data)
-- 
2.35.1

