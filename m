Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643EF58B673
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiHFPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHFPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:25:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837979FEA;
        Sat,  6 Aug 2022 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659799522; x=1691335522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yeMrOGaLj7UiZ3aSAIAl9Iu73Rv0eEWT/0hnU9WSJMI=;
  b=eoW+a3M8jCwTF/zon9zMNufyDi1pzg5HyZMKPLXwYYC7iEfpv8feFeUx
   pe6WkQT9xcpF3Cwvww1tx5FZmcsLu6rszGQj+WB3GKocV/oXXhkjFsHlD
   5AJ/aFvhHjFhbv51qJWkASK5WZdrZRAR7NYM0sUHszcKGVKgh/QC2Lofs
   lwfsjQLizLdQ65lcu+JpjYuppQ7dLd5OxA02qnM4OkGOPnRKOTVurQ4JD
   CvgTOvASoRgQB17FPu3aGaZo6pQZTrBMI9ATgr9iVnUcNPIBmZNu0j1vD
   s4CFHm3P/Nv9IoasOdgIj7pAVlDVeI8juT37q4TmaEM2i+sABHQFWOeaw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352098533"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352098533"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 08:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="600652376"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2022 08:25:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F31617D5; Sat,  6 Aug 2022 18:25:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
Date:   Sat,  6 Aug 2022 18:25:15 +0300
Message-Id: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/hwmon/Kconfig   |  2 +-
 drivers/hwmon/pwm-fan.c | 50 +++++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e70d9614bec2..58912a5c5de8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1613,7 +1613,7 @@ source "drivers/hwmon/pmbus/Kconfig"
 
 config SENSORS_PWM_FAN
 	tristate "PWM fan"
-	depends on (PWM && OF) || COMPILE_TEST
+	depends on PWM || COMPILE_TEST
 	depends on THERMAL || THERMAL=n
 	help
 	  If you say yes here you get support for fans connected to PWM lines.
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 6c08551d8d14..9ce9f2543861 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -9,10 +9,11 @@
 
 #include <linux/hwmon.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
@@ -25,7 +26,6 @@ struct pwm_fan_tach {
 	int irq;
 	atomic_t pulses;
 	unsigned int rpm;
-	u8 pulses_per_revolution;
 };
 
 struct pwm_fan_ctx {
@@ -36,6 +36,7 @@ struct pwm_fan_ctx {
 
 	int tach_count;
 	struct pwm_fan_tach *tachs;
+	u32 *pulses_per_revolution;
 	ktime_t sample_start;
 	struct timer_list rpm_timer;
 
@@ -73,7 +74,7 @@ static void sample_timer(struct timer_list *t)
 			pulses = atomic_read(&tach->pulses);
 			atomic_sub(pulses, &tach->pulses);
 			tach->rpm = (unsigned int)(pulses * 1000 * 60) /
-				(tach->pulses_per_revolution * delta);
+				(ctx->pulses_per_revolution[i] * delta);
 		}
 
 		ctx->sample_start = ktime_get();
@@ -229,16 +230,14 @@ static const struct thermal_cooling_device_ops pwm_fan_cooling_ops = {
 	.set_cur_state = pwm_fan_set_cur_state,
 };
 
-static int pwm_fan_of_get_cooling_data(struct device *dev,
-				       struct pwm_fan_ctx *ctx)
+static int pwm_fan_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
 {
-	struct device_node *np = dev->of_node;
 	int num, i, ret;
 
-	if (!of_find_property(np, "cooling-levels", NULL))
+	if (!device_property_present(dev, "cooling-levels"))
 		return 0;
 
-	ret = of_property_count_u32_elems(np, "cooling-levels");
+	ret = device_property_count_u32(dev, "cooling-levels");
 	if (ret <= 0) {
 		dev_err(dev, "Wrong data!\n");
 		return ret ? : -EINVAL;
@@ -250,8 +249,8 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	if (!ctx->pwm_fan_cooling_levels)
 		return -ENOMEM;
 
-	ret = of_property_read_u32_array(np, "cooling-levels",
-					 ctx->pwm_fan_cooling_levels, num);
+	ret = device_property_read_u32_array(dev, "cooling-levels",
+					     ctx->pwm_fan_cooling_levels, num);
 	if (ret) {
 		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
 		return ret;
@@ -302,7 +301,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	mutex_init(&ctx->lock);
 
-	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
+	ctx->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(ctx->pwm))
 		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
 
@@ -370,6 +369,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		if (!fan_channel_config)
 			return -ENOMEM;
 		ctx->fan_channel.config = fan_channel_config;
+
+		ctx->pulses_per_revolution = devm_kmalloc_array(dev,
+								ctx->tach_count,
+								sizeof(*ctx->pulses_per_revolution),
+								GFP_KERNEL);
+		if (!ctx->pulses_per_revolution)
+			return -ENOMEM;
+
+		/* Setup default pulses per revolution */
+		memset32(ctx->pulses_per_revolution, 2, ctx->tach_count);
+
+		device_property_read_u32_array(dev, "pulses-per-revolution",
+					       ctx->pulses_per_revolution,
+					       ctx->tach_count);
 	}
 
 	channels = devm_kcalloc(dev, channel_count + 1,
@@ -381,7 +394,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ctx->tach_count; i++) {
 		struct pwm_fan_tach *tach = &ctx->tachs[i];
-		u32 ppr = 2;
 
 		tach->irq = platform_get_irq(pdev, i);
 		if (tach->irq == -EPROBE_DEFER)
@@ -397,20 +409,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			}
 		}
 
-		of_property_read_u32_index(dev->of_node,
-					   "pulses-per-revolution",
-					   i,
-					   &ppr);
-		tach->pulses_per_revolution = ppr;
-		if (!tach->pulses_per_revolution) {
-			dev_err(dev, "pulses-per-revolution can't be zero.\n");
-			return -EINVAL;
-		}
-
 		fan_channel_config[i] = HWMON_F_INPUT;
 
 		dev_dbg(dev, "tach%d: irq=%d, pulses_per_revolution=%d\n",
-			i, tach->irq, tach->pulses_per_revolution);
+			i, tach->irq, ctx->pulses_per_revolution[i]);
 	}
 
 	if (ctx->tach_count > 0) {
@@ -430,7 +432,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		return PTR_ERR(hwmon);
 	}
 
-	ret = pwm_fan_of_get_cooling_data(dev, ctx);
+	ret = pwm_fan_get_cooling_data(dev, ctx);
 	if (ret)
 		return ret;
 
-- 
2.35.1

