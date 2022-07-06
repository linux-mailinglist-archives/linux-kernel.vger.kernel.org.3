Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892A3568550
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGFKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiGFKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:19:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874D2714F;
        Wed,  6 Jul 2022 03:18:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so21368765wra.5;
        Wed, 06 Jul 2022 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvGwVkTGyDn+vP4Fazz0kJpHMoviO3wS63dcj/8fxfo=;
        b=ZKCpGxJTFzF/rvSEejnIawseKoqfxUwKeVrwTB0K/cZ2nx8Ce/JEBlUNqYZ/6sMZaV
         y8aM1r7uUGzM8mxiw542IB7VjSGemOdAF34nToc96Ehd2pa3DtjtQLGevQqMRATa+ta9
         tN+gp4HKFfzBREN3ko+JQ7XhlC/UdW5a+NRch/vxEF5ZYPZaPXXG9MzskzDD7ixfRJJE
         G37xZgLxxFOVCatGXobMzXlXC+HA+CzMjBTGArCoTXKUxTVt8WFZuCrmTjMctnIWMtb2
         Z9XOF0V+a1BXKRfjjwMSYAX1h9LNIpf72HYEvgbGV5iB5Z40We8lfR2f3k3x0bhSOstR
         JMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvGwVkTGyDn+vP4Fazz0kJpHMoviO3wS63dcj/8fxfo=;
        b=FAk/Xnu5N5p67IVOpwEXdgm53Gheju73j5kEyUTBgwuHEIjtRqcXlMuPrttQ0prOOl
         jI7COOBMi2/EiUKqIKeXSFyTmnFM7J6AFUEpi9RYO3S6eA1b6396DVE/jX5prWCFZjBl
         BVeLkh9w8o2KolsFxlTz+iP2GtDdLguHeuCGhwlRDfSZreDEuvQWnNqjzd1TCsNPs6/l
         kzFkjiJH4yqpNWs/jCIsc7y9N1w2k3AgFmZxA41z9jgHj+FVt8A+/VmF7KKAuVZMgZQ6
         +IdoArdElIzaGXQHtJ5bPITEe7SECO8op/l7aaj3tIXP1CO2MrtZsI9aOyRi6zTRuFPG
         kyjQ==
X-Gm-Message-State: AJIora9fHv6HuqUzjHgMegXx0gNJqGKp4j7uOZa/m1QOn/6Zja++8EtL
        cR3S3g8b6WBqZUyocjNu7/M=
X-Google-Smtp-Source: AGRyM1vLCj4x+NqNP5HpX/hsCERhQNRayOjvlpg+w1jdkzDlNlP0qjd8PmOdvrbpuk0bd3MwfVqGOw==
X-Received: by 2002:adf:dc09:0:b0:21b:9ec1:f4ab with SMTP id t9-20020adfdc09000000b0021b9ec1f4abmr37147285wri.558.1657102732173;
        Wed, 06 Jul 2022 03:18:52 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id h15-20020a1ccc0f000000b0039749b01ea7sm33702763wmb.32.2022.07.06.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 13/13] power: axp20x_battery: Add support for AXP192
Date:   Wed,  6 Jul 2022 11:19:02 +0100
Message-Id: <20220706101902.4984-14-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 has a battery charger similar to other X-Powers PMICs,
but unlike the other supported devices, it does not have a fuel
gauge and can't report battery capacity directly.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 49 +++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 574c1d001556..1e84d26ce8e3 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -544,6 +544,19 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	}
 }
 
+static enum power_supply_property axp192_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+};
+
 static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -568,6 +581,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
+static const struct power_supply_desc axp192_batt_ps_desc = {
+	.name = "axp192-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = axp192_battery_props,
+	.num_properties = ARRAY_SIZE(axp192_battery_props),
+	.property_is_writeable = axp20x_battery_prop_writeable,
+	.get_property = axp20x_battery_get_prop,
+	.set_property = axp20x_battery_set_prop,
+};
+
 static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
@@ -578,6 +601,19 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+static const int axp192_ccc_table[AXP20X_CHRG_CTRL1_TGT_CURR+1] = {
+	100000,  190000,  280000,  360000,
+	450000,  550000,  630000,  700000,
+	780000,  880000,  960000,  1000000,
+	1080000, 1160000, 1240000, 1320000,
+};
+
+static const struct axp_data axp192_data = {
+	.ccc_table = axp192_ccc_table,
+	.get_max_voltage = axp20x_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
@@ -606,6 +642,9 @@ static const struct axp_data axp813_data = {
 
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
+		.compatible = "x-powers,axp192-battery-power-supply",
+		.data = (void *)&axp192_data,
+	}, {
 		.compatible = "x-powers,axp209-battery-power-supply",
 		.data = (void *)&axp209_data,
 	}, {
@@ -623,6 +662,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info *info;
+	const struct power_supply_desc *ps_desc;
 	struct device *dev = &pdev->dev;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -666,9 +706,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
 	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
 
-	axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
-						       &axp20x_batt_ps_desc,
-						       &psy_cfg);
+	if (!axp20x_batt->data->has_fg)
+		ps_desc = &axp192_batt_ps_desc;
+	else
+		ps_desc = &axp20x_batt_ps_desc;
+
+	axp20x_batt->batt = devm_power_supply_register(&pdev->dev, ps_desc, &psy_cfg);
 	if (IS_ERR(axp20x_batt->batt)) {
 		dev_err(&pdev->dev, "failed to register power supply: %ld\n",
 			PTR_ERR(axp20x_batt->batt));
-- 
2.35.1

