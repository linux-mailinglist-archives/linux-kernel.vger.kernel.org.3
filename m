Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8A4DD1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiCRAM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiCRAM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:12:28 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B21E29CE;
        Thu, 17 Mar 2022 17:11:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 5B5F6E0063;
        Thu, 17 Mar 2022 17:11:07 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pzRlI9UiGHba; Thu, 17 Mar 2022 17:11:06 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] power: supply: max17042_battery: Add unit conversion macros
Date:   Fri, 18 Mar 2022 01:10:45 +0100
Message-Id: <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of sprinkling the code with magic numbers, put the unit
definitions used by the gauge into a set of macros. Macros are
used instead of simple defines in order to not require floating
point operations for divisions.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 40 +++++++++++++++----------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index ab031bbfbe78..c019d6c52363 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -51,6 +51,15 @@
 
 #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
 
+#define MAX17042_CURRENT_LSB		1562500ll /* µV */
+#define MAX17042_CURRENT_RSENSE(x)	(x * MAX17042_CURRENT_LSB) /* µV */
+#define MAX17042_CAPACITY_LSB		5000000ll /* µVh */
+#define MAX17042_CAPACITY_RSENSE(x)	(x * MAX17042_CAPACITY_LSB) /* µVh */
+#define MAX17042_TIME(x)		(x * 5625 / 1000) /* s */
+#define MAX17042_VOLTAGE(x)		(x * 625 / 8) /* µV */
+#define MAX17042_RESISTANCE(x)		(x / 4096) /* Ω */
+#define MAX17042_TEMPERATURE(x)		(x / 256) /* °C */
+
 struct max17042_chip {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -103,8 +112,7 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 
 	*temp = sign_extend32(data, 15);
 	/* The value is converted into deci-centigrade scale */
-	/* Units of LSB = 1 / 256 degree Celsius */
-	*temp = *temp * 10 / 256;
+	*temp = MAX17042_TEMPERATURE(*temp * 10);
 	return 0;
 }
 
@@ -161,7 +169,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 		return ret;
 
 	avg_current = sign_extend32(data, 15);
-	avg_current *= 1562500 / chip->pdata->r_sns;
+	avg_current *= MAX17042_CURRENT_LSB / chip->pdata->r_sns;
 
 	if (avg_current > 0)
 		*status = POWER_SUPPLY_STATUS_CHARGING;
@@ -181,7 +189,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto health_error;
 
 	/* bits [0-3] unused */
-	vavg = val * 625 / 8;
+	vavg = MAX17042_VOLTAGE(val);
 	/* Convert to millivolts */
 	vavg /= 1000;
 
@@ -190,7 +198,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto health_error;
 
 	/* bits [0-3] unused */
-	vbatt = val * 625 / 8;
+	vbatt = MAX17042_VOLTAGE(val);
 	/* Convert to millivolts */
 	vbatt /= 1000;
 
@@ -297,21 +305,21 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 625 / 8;
+		val->intval = MAX17042_VOLTAGE(data);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 625 / 8;
+		val->intval = MAX17042_VOLTAGE(data);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
 		ret = regmap_read(map, MAX17042_OCVInternal, &data);
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 625 / 8;
+		val->intval = MAX17042_VOLTAGE(data);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		if (chip->pdata->enable_current_sense)
@@ -328,7 +336,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 5000000ll;
+		data64 = MAX17042_CAPACITY_RSENSE(data);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -337,7 +345,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 5000000ll;
+		data64 = MAX17042_CAPACITY_RSENSE(data);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -346,7 +354,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 5000000ll;
+		data64 = MAX17042_CAPACITY_RSENSE(data);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -355,7 +363,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = sign_extend64(data, 15) * 5000000ll;
+		data64 = MAX17042_CAPACITY_RSENSE(sign_extend64(data, 15));
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
@@ -397,7 +405,7 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			data64 = sign_extend64(data, 15) * 1562500ll;
+			data64 = MAX17042_CURRENT_RSENSE(sign_extend64(data, 15));
 			val->intval = div_s64(data64, chip->pdata->r_sns);
 		} else {
 			return -EINVAL;
@@ -409,7 +417,7 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			data64 = sign_extend64(data, 15) * 1562500ll;
+			data64 = MAX17042_CURRENT_RSENSE(sign_extend64(data, 15));
 			val->intval = div_s64(data64, chip->pdata->r_sns);
 		} else {
 			return -EINVAL;
@@ -420,7 +428,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		data64 = data * 1562500ll;
+		data64 = MAX17042_CURRENT_RSENSE(data);
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
@@ -428,7 +436,7 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		val->intval = data * 5625 / 1000;
+		val->intval = MAX17042_TIME(data);
 		break;
 	default:
 		return -EINVAL;
-- 
2.35.1

