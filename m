Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47C48A5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbiAKCco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:32:44 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:47893 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244421AbiAKCcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:32:42 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4JXvqY3HxkzTV;
        Tue, 11 Jan 2022 03:32:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1641868361; bh=twqKe1Mt8wJKNPpnOSYM2dsOVPjXF14PzRKIHZBWe/s=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=eY566POCWZz4ADTUgHMhYgpNNUKzEnjzd5dKrpTBRR0QMa57I+0zA4p5K/Id7aCjS
         iLbuxHJoPdnZZAMb1rUdLMkW+0uZPHlz2ssxqGNTRVeoqHlvhgSq20RZ4vVsDJ6cUg
         Ja7fdLlLl0PEAp9hfsYs0tYR/4ClAH8zFxk8AMvo19VsJkKXdCoSIiIxYhkb3QX0X6
         8O3PnpE2626k0Dr9FwFsFp10bWNodrvdYrWtOWVmijusJbIB5Ihd7crxiOGmJpJ47g
         vxkztzqdnoUkfBPodERcTzR5tdojP+erOB/KS+quudM9yWdlCfZV0zHl5OpCECeMrc
         SdeWeXhNX/IYA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.4 at mail
Date:   Tue, 11 Jan 2022 03:32:41 +0100
Message-Id: <3eede91c6484c6626f2a727bf1837ee93939155a.1641868274.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <680a4c737950f59e787f64887402e3ae247e89dd.1641868274.git.mirq-linux@rere.qmqm.pl>
References: <680a4c737950f59e787f64887402e3ae247e89dd.1641868274.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] power: supply: ltc2941: clean up error messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dev_err() with dev_err_probe() in probe() and extend register
access failure messages. dev_err()s in _reset() are removed as they
are redundant: register access wrappers already log the error.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 53 ++++++++------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index c0cbf4cd59ee..657305214d68 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -112,7 +112,8 @@ static int ltc294x_read_regs(struct i2c_client *client,
 
 	ret = i2c_transfer(client->adapter, &msgs[0], 2);
 	if (ret < 0) {
-		dev_err(&client->dev, "ltc2941 read_reg failed!\n");
+		dev_err(&client->dev, "ltc2941 read_reg(0x%x[%d]) failed: %pe\n",
+			reg, num_regs, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -130,7 +131,8 @@ static int ltc294x_write_regs(struct i2c_client *client,
 
 	ret = i2c_smbus_write_i2c_block_data(client, reg_start, num_regs, buf);
 	if (ret < 0) {
-		dev_err(&client->dev, "ltc2941 write_reg failed!\n");
+		dev_err(&client->dev, "ltc2941 write_reg(0x%x[%d]) failed: %pe\n",
+			reg, num_regs, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -148,11 +150,8 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 
 	/* Read status and control registers */
 	ret = ltc294x_read_regs(info->client, LTC294X_REG_CONTROL, &value, 1);
-	if (ret < 0) {
-		dev_err(&info->client->dev,
-			"Could not read registers from device\n");
-		goto error_exit;
-	}
+	if (ret < 0)
+		return ret;
 
 	control = LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
 				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
@@ -172,17 +171,11 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 	if (value != control) {
 		ret = ltc294x_write_regs(info->client,
 			LTC294X_REG_CONTROL, &control, 1);
-		if (ret < 0) {
-			dev_err(&info->client->dev,
-				"Could not write register\n");
-			goto error_exit;
-		}
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
-
-error_exit:
-	return ret;
 }
 
 static int ltc294x_read_charge_register(const struct ltc294x_info *info,
@@ -472,11 +465,9 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	/* r_sense can be negative, when sense+ is connected to the battery
 	 * instead of the sense-. This results in reversed measurements. */
 	ret = of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
-	if (ret < 0) {
-		dev_err(&client->dev,
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
 			"Could not find lltc,resistor-sense in devicetree\n");
-		return ret;
-	}
 	info->r_sense = r_sense;
 
 	ret = of_property_read_u32(np, "lltc,prescaler-exponent",
@@ -502,11 +493,9 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	/* Read status register to check for LTC2942 */
 	if (info->id == LTC2941_ID || info->id == LTC2942_ID) {
 		ret = ltc294x_read_regs(client, LTC294X_REG_STATUS, &status, 1);
-		if (ret < 0) {
-			dev_err(&client->dev,
+		if (ret < 0)
+			return dev_err_probe(&client->dev, ret,
 				"Could not read status register\n");
-			return ret;
-		}
 		if (status & LTC2941_REG_STATUS_CHIP_ID)
 			info->id = LTC2941_ID;
 		else
@@ -545,19 +534,17 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		return ret;
 
 	ret = ltc294x_reset(info, prescaler_exp);
-	if (ret < 0) {
-		dev_err(&client->dev, "Communication with chip failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+			"Communication with chip failed\n");
 
 	info->supply = devm_power_supply_register(&client->dev,
 						  &info->supply_desc, &psy_cfg);
-	if (IS_ERR(info->supply)) {
-		dev_err(&client->dev, "failed to register ltc2941\n");
-		return PTR_ERR(info->supply);
-	} else {
-		schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
-	}
+	if (IS_ERR(info->supply))
+		return dev_err_probe(&client->dev, PTR_ERR(info->supply),
+			"failed to register ltc2941\n");
+
+	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 
 	return 0;
 }
-- 
2.30.2

