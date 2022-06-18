Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45B9550729
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiFRVlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiFRVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E141010552;
        Sat, 18 Jun 2022 14:40:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s12so14608908ejx.3;
        Sat, 18 Jun 2022 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzcMBw6VtrHkejeDZkdOMrPvcqX9TFhUl4shxSwhjw8=;
        b=WMG6OdTO8Qo9Lb8I+MuMAXdl4SkuzQpw8CRkeqgQCHHOWD1/DNAU9xGLZTC461JoIZ
         tO8mc8kJlKbpao+gKQfNUqJlYa8g5PsaEbe/m1dvAtUC8Wg8QmLgwH/Myg8NIiwC4Xip
         aQLe8yVm84nIB0DvNgX9ZfIDFTrBfJnXyteAQNQeKKxB2YniJzyKtHJglYpu56MPH3mW
         CvVPs2Ybew3b2Q/cWA7obuUSs/rgKTkLXYSd9TeS+6XLqAX+p/O6Yt5Q4vooIWkcNnpy
         Jgnwp7WDpsRp8N7RS20Kd1vN7jZypoMFaVCL2MP7hiAVlLQenJhXDW3rvEq9JTY9934g
         uqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzcMBw6VtrHkejeDZkdOMrPvcqX9TFhUl4shxSwhjw8=;
        b=lg3fVshjWEjMkNqpJFSZFZBjKB2x2ttXqKWFwo6txa97WgyOWif2jdJID7mjNpUQiF
         Y9iHUZDAUxe6bHGGBlIHrqItkbYJVc2ycarY+e1cYKl9WU7+4OIZC8OPbBnI4cGnkbe6
         k/2Iz8KObsna2zi06hlch9Tec1EUsfIPP+TZwxIqoRHqcMhQnJksMPKbNia0H5I6VRTO
         lY5NApukaowByMmWepfwGZ+hnKTEpacnXHa9GybrzciKqN9zG/RXSSXw0fM5ylM5tQXe
         8tju+nNrsRyJaZ2UomSFcDkdgl0TosCfV9GnGh7OHvhNm8c7+fvbrQ7PLpTQfCwqT8iV
         Bvmg==
X-Gm-Message-State: AJIora+SGUuuv5CW9cQcTuQ+E1kM27fLmYSXcFSubQWN0txmXvYnCfqY
        iovrnbZAj8Z1BUWeEUT+pN4=
X-Google-Smtp-Source: AGRyM1vLb+bmuKJo+BXhThn4ZGNtiL477tIyd+yaHRDWEzFTLhkXL0TGK9pCuyBtfSUVtoUbt2wYJQ==
X-Received: by 2002:a17:907:7256:b0:711:dd35:61eb with SMTP id ds22-20020a170907725600b00711dd3561ebmr14502535ejc.445.1655588421291;
        Sat, 18 Jun 2022 14:40:21 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id k9-20020a056402048900b00435720b7a1csm1494713edv.20.2022.06.18.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:20 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 16/16] power: axp20x_battery: Add support for AXP192
Date:   Sat, 18 Jun 2022 22:40:09 +0100
Message-Id: <20220618214009.2178567-17-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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
index f2c57fd1329b..cd5d6905b2d2 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -545,6 +545,19 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
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
@@ -569,6 +582,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
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
@@ -579,6 +602,19 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
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
@@ -607,6 +643,9 @@ static const struct axp_data axp813_data = {
 
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
+		.compatible = "x-powers,axp192-battery-power-supply",
+		.data = (void *)&axp192_data,
+	}, {
 		.compatible = "x-powers,axp209-battery-power-supply",
 		.data = (void *)&axp209_data,
 	}, {
@@ -624,6 +663,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info *info;
+	const struct power_supply_desc *ps_desc;
 	struct device *dev = &pdev->dev;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -667,9 +707,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
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

