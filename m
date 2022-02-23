Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0664C1A72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiBWSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbiBWSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:00:41 -0500
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF54133D;
        Wed, 23 Feb 2022 10:00:11 -0800 (PST)
Received: from [77.244.183.192] (port=62116 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nMvvt-00039p-Ku; Wed, 23 Feb 2022 19:00:09 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 6/8] watchdog: max77620: add support for the max77714 variant
Date:   Wed, 23 Feb 2022 18:59:06 +0100
Message-Id: <20220223175908.191618-7-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223175908.191618-1-luca@lucaceresoli.net>
References: <20220223175908.191618-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX77714 is a MFD chip whose watchdog has the same programming
procedures as the MAX77620 watchdog, but most register offsets and bit
masks are different, as well as some features.

Support the MAX77714 watchdog by adding a variant description table holding
the differences.

All the features implemented by this driver are available on the MAX77714
except for the lack of a WDTOFFC bit. Instead of using a "HAS_*" flag we
handle this by holding in the cnfg_glbl2_cfg_bits struct field the bits
(i.e. the features) to enable in the CNFG_GLBL2 register. These bits differ
among the two models. This implementation allows to avoid any conditional
code, keeping the execution flow unchanged.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---

Changes in v6:
 - Update copyright year

Changes in v5:
 - keep a unique watchdog_info for both models (Guenter Roeck)

This patch is new in v4. It replaces v3 patch 7 ("watchdog: max77714: add
driver for the watchdog in the MAX77714 PMIC") by adding MAX77714 wdog
support to the existing MAX77620 wdog driver instead of adding a new
driver. Suggested by Guenter Roeck and Krzysztof Kozlowski.
---
 drivers/watchdog/Kconfig        |  2 +-
 drivers/watchdog/max77620_wdt.c | 80 ++++++++++++++++++++++++++-------
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c8fa79da23b3..5373ecdec58e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -678,7 +678,7 @@ config MAX63XX_WATCHDOG
 
 config MAX77620_WATCHDOG
 	tristate "Maxim Max77620 Watchdog Timer"
-	depends on MFD_MAX77620 || COMPILE_TEST
+	depends on MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the Max77620 watchdog timer.
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index be6a53c30002..cd321c7e0d59 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -3,8 +3,10 @@
  * Maxim MAX77620 Watchdog Driver
  *
  * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
+ * Copyright (C) 2022 Luca Ceresoli
  *
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
+ * Author: Luca Ceresoli <luca@lucaceresoli.net>
  */
 
 #include <linux/err.h>
@@ -13,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mfd/max77620.h>
+#include <linux/mfd/max77714.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -20,17 +23,57 @@
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
+/**
+ * struct max77620_variant - Data specific to a chip variant
+ * @wdt_info:            watchdog descriptor
+ * @reg_onoff_cnfg2:     ONOFF_CNFG2 register offset
+ * @reg_cnfg_glbl2:      CNFG_GLBL2 register offset
+ * @reg_cnfg_glbl3:      CNFG_GLBL3 register offset
+ * @wdtc_mask:           WDTC bit mask in CNFG_GLBL3 (=bits to update to ping the watchdog)
+ * @bit_wd_rst_wk:       WD_RST_WK bit offset within ONOFF_CNFG2
+ * @cnfg_glbl2_cfg_bits: configuration bits to enable in CNFG_GLBL2 register
+ */
+struct max77620_variant {
+	u8 reg_onoff_cnfg2;
+	u8 reg_cnfg_glbl2;
+	u8 reg_cnfg_glbl3;
+	u8 wdtc_mask;
+	u8 bit_wd_rst_wk;
+	u8 cnfg_glbl2_cfg_bits;
+};
+
 struct max77620_wdt {
 	struct device			*dev;
 	struct regmap			*rmap;
+	const struct max77620_variant	*drv_data;
 	struct watchdog_device		wdt_dev;
 };
 
+static const struct max77620_variant max77620_wdt_data = {
+	.reg_onoff_cnfg2     = MAX77620_REG_ONOFFCNFG2,
+	.reg_cnfg_glbl2      = MAX77620_REG_CNFGGLBL2,
+	.reg_cnfg_glbl3      = MAX77620_REG_CNFGGLBL3,
+	.wdtc_mask           = MAX77620_WDTC_MASK,
+	.bit_wd_rst_wk       = MAX77620_ONOFFCNFG2_WD_RST_WK,
+	/* Set WDT clear in OFF and sleep mode */
+	.cnfg_glbl2_cfg_bits = MAX77620_WDTSLPC | MAX77620_WDTOFFC,
+};
+
+static const struct max77620_variant max77714_wdt_data = {
+	.reg_onoff_cnfg2     = MAX77714_CNFG2_ONOFF,
+	.reg_cnfg_glbl2      = MAX77714_CNFG_GLBL2,
+	.reg_cnfg_glbl3      = MAX77714_CNFG_GLBL3,
+	.wdtc_mask           = MAX77714_WDTC,
+	.bit_wd_rst_wk       = MAX77714_WD_RST_WK,
+	/* Set WDT clear in sleep mode (there is no WDTOFFC on MAX77714) */
+	.cnfg_glbl2_cfg_bits = MAX77714_WDTSLPC,
+};
+
 static int max77620_wdt_start(struct watchdog_device *wdt_dev)
 {
 	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
 
-	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+	return regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
 				  MAX77620_WDTEN, MAX77620_WDTEN);
 }
 
@@ -38,7 +81,7 @@ static int max77620_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
 
-	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+	return regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
 				  MAX77620_WDTEN, 0);
 }
 
@@ -46,8 +89,8 @@ static int max77620_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
 
-	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
-				  MAX77620_WDTC_MASK, 0x1);
+	return regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl3,
+				  wdt->drv_data->wdtc_mask, 0x1);
 }
 
 static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
@@ -80,12 +123,12 @@ static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
 		break;
 	}
 
-	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
-				 MAX77620_WDTC_MASK, 0x1);
+	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl3,
+				 wdt->drv_data->wdtc_mask, 0x1);
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
+	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
 				 MAX77620_TWD_MASK, regval);
 	if (ret < 0)
 		return ret;
@@ -109,6 +152,7 @@ static const struct watchdog_ops max77620_wdt_ops = {
 
 static int max77620_wdt_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct device *dev = &pdev->dev;
 	struct max77620_wdt *wdt;
 	struct watchdog_device *wdt_dev;
@@ -120,6 +164,8 @@ static int max77620_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wdt->dev = dev;
+	wdt->drv_data = (const struct max77620_variant *) id->driver_data;
+
 	wdt->rmap = dev_get_regmap(dev->parent, NULL);
 	if (!wdt->rmap) {
 		dev_err(wdt->dev, "Failed to get parent regmap\n");
@@ -136,25 +182,25 @@ static int max77620_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 
 	/* Enable WD_RST_WK - WDT expire results in a restart */
-	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_ONOFFCNFG2,
-				 MAX77620_ONOFFCNFG2_WD_RST_WK,
-				 MAX77620_ONOFFCNFG2_WD_RST_WK);
+	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_onoff_cnfg2,
+				 wdt->drv_data->bit_wd_rst_wk,
+				 wdt->drv_data->bit_wd_rst_wk);
 	if (ret < 0) {
 		dev_err(wdt->dev, "Failed to set WD_RST_WK: %d\n", ret);
 		return ret;
 	}
 
-	/* Set WDT clear in OFF and sleep mode */
-	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
-				 MAX77620_WDTOFFC | MAX77620_WDTSLPC,
-				 MAX77620_WDTOFFC | MAX77620_WDTSLPC);
+	/* Set the "auto WDT clear" bits available on the chip */
+	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
+				 wdt->drv_data->cnfg_glbl2_cfg_bits,
+				 wdt->drv_data->cnfg_glbl2_cfg_bits);
 	if (ret < 0) {
 		dev_err(wdt->dev, "Failed to set WDT OFF mode: %d\n", ret);
 		return ret;
 	}
 
 	/* Check if WDT running and if yes then set flags properly */
-	ret = regmap_read(wdt->rmap, MAX77620_REG_CNFGGLBL2, &regval);
+	ret = regmap_read(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2, &regval);
 	if (ret < 0) {
 		dev_err(wdt->dev, "Failed to read WDT CFG register: %d\n", ret);
 		return ret;
@@ -186,7 +232,8 @@ static int max77620_wdt_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max77620_wdt_devtype[] = {
-	{ .name = "max77620-watchdog", },
+	{ "max77620-watchdog", (kernel_ulong_t)&max77620_wdt_data },
+	{ "max77714-watchdog", (kernel_ulong_t)&max77714_wdt_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, max77620_wdt_devtype);
@@ -208,4 +255,5 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

