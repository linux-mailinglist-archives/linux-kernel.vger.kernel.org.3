Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06AA54031E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbiFGPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbiFGPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE71581C;
        Tue,  7 Jun 2022 08:52:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so36076812ejq.6;
        Tue, 07 Jun 2022 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZqJwwQCJ01pELy38FJeEc30ceI9lCwpIjpzGgddVds=;
        b=PR0+roS4upmG5WN8qbwXgI2Mpr6VZc/OLs/N3ev2DvXhqNNLmgRgkPLE6s6HsC1DSf
         uzDtOMQLFQtSE1flaTaJFbqlRUtUMaWNhSapwkrtpnBDkKsezuuJxJ0s0lHM1JYt2eiu
         zRFN+vgASrR6sz2L/foMiaLYpmUB5xjbXTTwiVJWNvuUhQH2fT8FDf1ein7aQHcf/vl/
         deHaGdjmJtYDSyoCuGDd4H0nJhqnPMOYJ7sLfofG381tpOt96B+c/8LhYWF5UHhba3m3
         entwCVNaVaT2FT9ioIpWuzsFs4XYI0hIhG0AgCv65O7ItpS6l0JOdf49veFkRqZ72X5o
         qPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZqJwwQCJ01pELy38FJeEc30ceI9lCwpIjpzGgddVds=;
        b=y/hYJjBSF/SLdWX3TZrwSYZYvBnkirwm34C19Ds6OCFpw30/1fKDYbzh3uFwUQUO6g
         sPA5ZSuSTe9eEk+HFqzmZwlW8r9f/dAW0aabgttjoqzn59eyg8E0ppWyrbXA9r4CRpX5
         PSX+Bd4/Kgba/9wKOi3VH539Wo3+W+k5FgRbCfi4S3O3xRz7bdl0uwSgYtf19ouQU7Gn
         2J1J05RSYWLVyJwMil21XV94lAURrrWOqfU5eQJiZ2WZByvTM40JdW3G3aXjImNrPIvp
         3PMi4RZWZ8E39evcuk8mMnVwEGL+8m5ngBySLVUUsFQaY+c+YLTZCX4PW9Gg3HSup3ER
         ApIw==
X-Gm-Message-State: AOAM5308mO15xSI1O+yJboc7yMEiklx41MA4f4hw2RIF74bJg0UwY08z
        U/ViBKvxRUA8FAzo7bsw+nM=
X-Google-Smtp-Source: ABdhPJywtFQwM6e3Otj27xiK8EwkejIk56Zg8sFR5g5NkZpqU3FhYFzCFILRQMFBoXu6e4rX8+zW9w==
X-Received: by 2002:a17:907:86ac:b0:708:9c4a:c6e9 with SMTP id qa44-20020a17090786ac00b007089c4ac6e9mr27668532ejc.297.1654617167167;
        Tue, 07 Jun 2022 08:52:47 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090669cb00b006fec1a73e48sm7872752ejs.64.2022.06.07.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:46 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 13/17] power: supply: axp20x_usb_power: Add support for AXP192
Date:   Tue,  7 Jun 2022 16:53:20 +0100
Message-Id: <20220607155324.118102-14-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is mostly the same as the AXP202 but has a different
current limit.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 80 +++++++++++++++++++++----
 1 file changed, 69 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1e6d1d44808..03145374ae72 100644
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
@@ -256,16 +279,20 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 
-		if (power->axp20x_id == AXP202_ID) {
-			ret = regmap_read(power->regmap,
-					  AXP20X_USB_OTG_STATUS, &v);
-			if (ret)
-				return ret;
+		if (power->axp20x_id == AXP192_ID)
+			reg = AXP192_USB_OTG_STATUS;
+		else if (power->axp20x_id == AXP202_ID)
+			reg = AXP20X_USB_OTG_STATUS;
+		else
+			/* Other chips do not have an OTG status register */
+			break;
 
-			if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
-				val->intval =
-					POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
-		}
+		ret = regmap_read(power->regmap, reg, &v);
+		if (ret)
+			return ret;
+
+		if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
@@ -316,6 +343,24 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
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
@@ -383,6 +428,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_usb_power_set_current_max(power,
 								val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -468,6 +516,13 @@ struct axp_data {
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
@@ -600,7 +655,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (power->axp20x_id == AXP202_ID) {
+	if (power->axp20x_id == AXP192_ID || power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
 		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
 					 AXP20X_VBUS_MON_VBUS_VALID,
@@ -659,6 +714,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
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

