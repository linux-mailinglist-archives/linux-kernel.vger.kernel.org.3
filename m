Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963553CB31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbiFCN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbiFCN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:57:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A598B9B;
        Fri,  3 Jun 2022 06:56:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso4378143wmn.4;
        Fri, 03 Jun 2022 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGG9qpuiluHgCuaSHdjXJU7q47uAnSVrXsTe0fpRwjo=;
        b=TK5I4/rEbEjManXzyp0DZFUihYTt477+gPq2aCb2wJ3iIg9B9MD5zWeK6tRKaPZH7d
         RI60QIN5P/pltSuU0sdzEb60D8CNEXbtd5aHPbNAgKS39RoF3MxKvTGAl00YTxZKBlxz
         5MJ2C/hL/LLbyUdD4qjonxTtSJI64wKPFqlZkxH7+XDRqYvS+PvD2pWnrQkpt+lK0GZ3
         Hzzzli63UgBsoiAyVTlc2aIJYJpQyl3Jy4N2IwAfahnl7Yo8+uTZuR39dxNL1nuMxdUF
         zmhzFZTNhrVeeQnibMc41IglcmT4gJhTWpoKx8yjFaM0i4J+gU3ZJbrsUdxJCn+YYpvp
         h9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGG9qpuiluHgCuaSHdjXJU7q47uAnSVrXsTe0fpRwjo=;
        b=wgC7lStVHHRXG0kFEqkUf7Zb9bCxWQFJ5FmcHMXr/RRp2djtn10z5zI1TCcICrqMs8
         qrDwPDG8g9JuGLlXiFeXz+YsunFXHsjKfqzvxImwuHnOXOE1uI7sOs1OoNXrCT9hGyhr
         olKgr3+XkkZEJsXXq8vV6ynxFbCwLv5mdmwufumG2E9i8VNyIzi2HIj2K3k31k3G4GyW
         tWDdrbmMslGj9gTMVZFe/hNejuzH3GjHTvmf3+uA7meTF8eWrGqqXinAMxTuL+utalEM
         47+c3Mrjj4XJoFaZuL1oIULESdLl26UkWY3Nql92EnfHXVT97IIOIkTGQ9WHSNmrho+h
         Id7Q==
X-Gm-Message-State: AOAM530l2fiZ+R+G8fDKg/XiHNlCqDIi92eCcvZPiKpdpQYThY0laA6b
        NM3QffJbnNDu/YGYyfU1hxE=
X-Google-Smtp-Source: ABdhPJzJSYCvK7Sp5Ya3TON/rcRsQZKRuE8TUjMqiWQGaLc8tr7VeC1fwjPiAulBRUgyvXuOmTWRyQ==
X-Received: by 2002:a05:600c:a51:b0:397:8a4d:be15 with SMTP id c17-20020a05600c0a5100b003978a4dbe15mr8821671wmq.80.1654264612159;
        Fri, 03 Jun 2022 06:56:52 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c414700b0039787538c9csm3670131wmm.20.2022.06.03.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] power: supply: axp20x_usb_power: Add support for AXP192
Date:   Fri,  3 Jun 2022 14:57:13 +0100
Message-Id: <20220603135714.12007-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is mostly the same as the AXP202 but has a different
current limit.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 75 +++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1e6d1d44808..e1266b8265bc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -48,6 +48,9 @@
 #define AXP813_VBUS_CLIMIT_2000mA	2
 #define AXP813_VBUS_CLIMIT_2500mA	3
 
+#define AXP192_VBUS_CLIMIT_EN		BIT(1)
+#define AXP192_VBUS_CLIMIT_100mA	BIT(0)
+
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
@@ -121,6 +124,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
+static int axp192_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	if (!(v & AXP192_VBUS_CLIMIT_EN))
+		*val = -1;
+	else if (v & AXP192_VBUS_CLIMIT_100mA)
+		*val = 100000;
+	else
+		*val = 500000;
+
+	return 0;
+}
+
 static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
 {
 	unsigned int v;
@@ -179,7 +200,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
-	unsigned int input, v;
+	unsigned int input, v, reg;
 	int ret;
 
 	switch (psp) {
@@ -215,6 +236,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_get_current_max(power, &val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -256,15 +279,26 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 
-		if (power->axp20x_id == AXP202_ID) {
-			ret = regmap_read(power->regmap,
-					  AXP20X_USB_OTG_STATUS, &v);
+		switch (power->axp20x_id) {
+		case AXP192_ID:
+			/* Same layout as the AXP202, but different address */
+			reg = AXP192_USB_OTG_STATUS;
+			fallthrough;
+
+		case AXP202_ID:
+			if (power->axp20x_id == AXP202_ID)
+				reg = AXP20X_USB_OTG_STATUS;
+
+			ret = regmap_read(power->regmap, reg, &v);
 			if (ret)
 				return ret;
 
 			if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
 				val->intval =
 					POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+
+		default:
+			break;
 		}
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -316,6 +350,24 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp192_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val = AXP192_VBUS_CLIMIT_EN;
+	const int mask = AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
+
+	switch (intval) {
+	case 100000:
+		val |= AXP192_VBUS_CLIMIT_100mA;
+		fallthrough;
+	case 500000:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT, mask, val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -383,6 +435,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_usb_power_set_current_max(power,
 								val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -468,6 +523,13 @@ struct axp_data {
 	enum axp20x_variants		axp20x_id;
 };
 
+static const struct axp_data axp192_data = {
+	.power_desc	= &axp20x_usb_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
+	.axp20x_id	= AXP192_ID,
+};
+
 static const struct axp_data axp202_data = {
 	.power_desc	= &axp20x_usb_power_desc,
 	.irq_names	= axp20x_irq_names,
@@ -600,7 +662,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (power->axp20x_id == AXP202_ID) {
+	if (power->axp20x_id == AXP192_ID || power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
 		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
 					 AXP20X_VBUS_MON_VBUS_VALID,
@@ -659,6 +721,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_usb_power_match[] = {
 	{
+		.compatible = "x-powers,axp192-usb-power-supply",
+		.data = &axp192_data,
+	}, {
 		.compatible = "x-powers,axp202-usb-power-supply",
 		.data = &axp202_data,
 	}, {
-- 
2.35.1

