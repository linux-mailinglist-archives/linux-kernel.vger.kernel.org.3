Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9344F5602F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiF2ObD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiF2OaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8C35DF2;
        Wed, 29 Jun 2022 07:30:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s1so22744601wra.9;
        Wed, 29 Jun 2022 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/6knLBCspYoJbBWZ+ks97ukajAgwVFBs4o2jAnU4CE=;
        b=F0whcHo7Zc3k+GEpoS8SmLr8tVyFTKmt1wCz/oaQlx6Ib7ZKEX063yRQrkxoZs0r67
         WuH740v9d1VXR0yfCyonHdTDr8SULH4ZkFuzdySuwlPcuOZ3LaJDMsxWd41SESYBfEIv
         H8ji5KUI/doCTfmHIKSZX+Np38hQVSim+qGxZGJwI8ju5NQQox6gytgsiS1hLzkxMhVe
         oRMky2ppDq/8k+h45DL81Ypj1rsrXdhjxJ/CW3xMCD+sE4+iUveaR5KbVMxWVdpWMNDA
         81k4aiE8tNaiW0ZsvzBSEG1sNt6/1tKZAl0RtIhF/GQjlSGVa8zdL/IIkkA54mS5jP5f
         nTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/6knLBCspYoJbBWZ+ks97ukajAgwVFBs4o2jAnU4CE=;
        b=QarWicW+fkgt/0GTNZH//6FRRqB2kd6Py7+WkTPz+arB9pbW8uR3bZa6daHDfiWzwD
         KXVq19sZtMoa7nHI9cKB9CGosUnhcHdID3Lr5qgEGlXeIm4JCT0G963S9whz8kyDdhSd
         9UC2KbOQgkDYjGO9CEY23Rb15WS2PbMjfZSS3/VIzpCDrpcGyV16TpNpNfZRleLH+Y+y
         AsN25oyJSH0hWev5hziUxidkEcfwaYx6w2yz5ffKRE40g4/NwRVle6j/wIQpOfEMQE8W
         h3F5SnPrq3XPkwfSTNogfZ//Ta7Ctvfj1wrb1oHl1EyOYS3RMcUdDfVu5puATWWD5/dX
         8nSA==
X-Gm-Message-State: AJIora8XkPWU9Px00XwtbiBCAt4Gf1yIcmBk0nD6LuB2NLi8uTRrN3iv
        MyngoEuwrJNpMNCIV9gYURc=
X-Google-Smtp-Source: AGRyM1ssJB+8a1pR4WAQ+kpPKxT8wl7jYM6SAD5uwinvRVog9qTcEzaMAvr1kw6gi5jmBcgoMiZX1g==
X-Received: by 2002:a5d:528e:0:b0:21b:b85b:5873 with SMTP id c14-20020a5d528e000000b0021bb85b5873mr3425379wrv.191.1656513015000;
        Wed, 29 Jun 2022 07:30:15 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm3402041wmq.1.2022.06.29.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:14 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 15/15] power: axp20x_battery: Add support for AXP192
Date:   Wed, 29 Jun 2022 15:30:46 +0100
Message-Id: <20220629143046.213584-16-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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

