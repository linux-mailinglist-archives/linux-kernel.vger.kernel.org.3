Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B53540322
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiFGPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344554AbiFGPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0747252B2;
        Tue,  7 Jun 2022 08:52:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so23559426edf.5;
        Tue, 07 Jun 2022 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYTTL3AHy9mfMhWxVSDqva/rGQ2dCnVRfKuVQ0G6ydQ=;
        b=MjhicytwQA9VYzo7pv7zhVYArH4XZXMLs8sydsnQ3SsHkQBolU17Hw5rYIUeT8ccB9
         86A7TSBfx0F3ItmR65k93vXTT0DxEb2ypUOewavO/E6Cqf/M5HWn/aQrtOSfE3MZuiz2
         gRNwvz00YvYS7hOigiwqwLk8A5THDE7pYp5qzcq5xsEzWNnaAF/PKkO63UaEP6o/ZQNU
         Yv+THkWYb556mtcMBvTFb6QXqxtEs4cTfE8Ooe5AcMdzZRkBrCNSavicwBQ/qrdJ06gp
         c2uoGYnogvgJGyn9gww5sGHGbWZgTThCvg9KP8kQa1aMPD3Z1j6vK+XgfDmFHhCntIYr
         9H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYTTL3AHy9mfMhWxVSDqva/rGQ2dCnVRfKuVQ0G6ydQ=;
        b=Lpuxveo00L2DpwY+rOVzBvMzPDWW9twuul4hkwBkkpRbuFE0SoVCxBNdFvIA9SedBz
         2znzNq39ck5NPO18yOpzqdz0gfbI9aO7t1amHjbGH3fwKYRiKl7RDjN1uPynltDImpIC
         mwpmSO6aERrVb2+TcYdZk2b48gN6EpttGiGazFBctZoConIxuwlR3SGvP3AluXsuxE2l
         zVgUv85MWXLGNzX6r7Xq/lff9ZiBA6HwKvXdbU7kXHjIub9BXwaj48xlr8lJLnTuxhsq
         eqQnlkwJYf+zCnKGFK5VUqsPkomGrWug0nYRsIfElECfvtHrVNXgpXwUjfQs+6jEt1bO
         GgMQ==
X-Gm-Message-State: AOAM531yC7b3efUnNm9WMvkXAL4NPljXLn6ve5X6g+fLKd+5MybcKuvj
        yBlqZwBXdsxYwPCOqrKOMew=
X-Google-Smtp-Source: ABdhPJxbvKhLe3CpoyF1x95wM7oeWbtRT7lkPI1uv/whV/zbdYJKr5DxHc7YLLKjLI4FLg/t1X/vGQ==
X-Received: by 2002:a05:6402:f17:b0:42d:d3f3:244c with SMTP id i23-20020a0564020f1700b0042dd3f3244cmr34442715eda.52.1654617174271;
        Tue, 07 Jun 2022 08:52:54 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906254600b0070c1c494f73sm6481989ejb.90.2022.06.07.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:53 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 17/17] power: axp20x_battery: Add support for AXP192
Date:   Tue,  7 Jun 2022 16:53:24 +0100
Message-Id: <20220607155324.118102-18-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 49 +++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index e9547e2d7c48..3fa2faa6f0f8 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -538,6 +538,19 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
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
@@ -562,6 +575,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
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
@@ -572,6 +595,19 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
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
@@ -600,6 +636,9 @@ static const struct axp_data axp813_data = {
 
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
+		.compatible = "x-powers,axp192-battery-power-supply",
+		.data = (void *)&axp192_data,
+	}, {
 		.compatible = "x-powers,axp209-battery-power-supply",
 		.data = (void *)&axp209_data,
 	}, {
@@ -617,6 +656,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info *info;
+	const struct power_supply_desc *ps_desc;
 	struct device *dev = &pdev->dev;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -660,9 +700,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
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

