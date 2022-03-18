Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030DA4DD1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiCRAMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiCRAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:12:38 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A183139CED;
        Thu, 17 Mar 2022 17:11:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 757F8E0063;
        Thu, 17 Mar 2022 17:11:20 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iedwKpeVX3pq; Thu, 17 Mar 2022 17:11:19 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] power: supply: max17042_battery: read battery properties from device tree
Date:   Fri, 18 Mar 2022 01:10:48 +0100
Message-Id: <20220318001048.20922-5-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far configuring the gauge was only possible using platform data,
with no way to provide the configuration on device tree-based platforms.

Change that by looking up the configuration values from monitored-battery
property. This is especially useful on models implementing ModelGauge m5 EZ
algorithm, such as MAX17055, as all the required configuration can be
derived from a "simple-battery" DT node there.

In order to be able to access power supply framework in get_of_pdata,
move devm_power_supply_register earlier in max17042_probe.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 50 +++++++++++++++++++------
 include/linux/power/max17042_battery.h  |  1 +
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index c39250349a1d..4c33565802d5 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -937,7 +937,9 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 	struct device *dev = &chip->client->dev;
 	struct device_node *np = dev->of_node;
 	u32 prop;
+	u64 data64;
 	struct max17042_platform_data *pdata;
+	struct power_supply_battery_info *info;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -961,6 +963,32 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
 		pdata->vmax = INT_MAX;
 
+	if (pdata->enable_current_sense &&
+	    power_supply_get_battery_info(chip->battery, &info) == 0) {
+		pdata->config_data = devm_kzalloc(dev, sizeof(*pdata->config_data), GFP_KERNEL);
+		if (!pdata->config_data)
+			return NULL;
+
+		if (info->charge_full_design_uah != -EINVAL) {
+			data64 = (u64)info->charge_full_design_uah * pdata->r_sns;
+			do_div(data64, MAX17042_CAPACITY_LSB);
+			pdata->config_data->design_cap = (u16)data64;
+			pdata->enable_por_init = true;
+		}
+		if (info->charge_term_current_ua != -EINVAL) {
+			data64 = (u64)info->charge_term_current_ua * pdata->r_sns;
+			do_div(data64, MAX17042_CURRENT_LSB);
+			pdata->config_data->ichgt_term = (u16)data64;
+			pdata->enable_por_init = true;
+		}
+		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+			if (info->voltage_max_design_uv > 4250000) {
+				pdata->config_data->model_cfg = MAX17055_MODELCFG_VCHG_BIT;
+				pdata->enable_por_init = true;
+			}
+		}
+	}
+
 	return pdata;
 }
 #endif
@@ -1092,16 +1120,23 @@ static int max17042_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	i2c_set_clientdata(client, chip);
+	psy_cfg.drv_data = chip;
+	psy_cfg.of_node = dev->of_node;
+
+	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
+						   &psy_cfg);
+	if (IS_ERR(chip->battery)) {
+		dev_err(&client->dev, "failed: power supply register\n");
+		return PTR_ERR(chip->battery);
+	}
+
 	chip->pdata = max17042_get_pdata(chip);
 	if (!chip->pdata) {
 		dev_err(&client->dev, "no platform data provided\n");
 		return -EINVAL;
 	}
 
-	i2c_set_clientdata(client, chip);
-	psy_cfg.drv_data = chip;
-	psy_cfg.of_node = dev->of_node;
-
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
 	if (!chip->pdata->enable_current_sense)
@@ -1122,13 +1157,6 @@ static int max17042_probe(struct i2c_client *client,
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
-						   &psy_cfg);
-	if (IS_ERR(chip->battery)) {
-		dev_err(&client->dev, "failed: power supply register\n");
-		return PTR_ERR(chip->battery);
-	}
-
 	if (client->irq) {
 		unsigned int flags = IRQF_ONESHOT;
 
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 6943921cab5e..367620800e7e 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -23,6 +23,7 @@
 
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
+#define MAX17055_MODELCFG_VCHG_BIT	BIT(10)
 #define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
 
 enum max17042_register {
-- 
2.35.1

