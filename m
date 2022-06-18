Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD45506E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiFRVkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiFRVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0476F586;
        Sat, 18 Jun 2022 14:40:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eq6so3006102edb.6;
        Sat, 18 Jun 2022 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuT29ehbyN/ATcCnZiRuVu0ODVzbMYGZM8OoTh+ph94=;
        b=TC63OzcCQY3vjDErZ0IN8bOx/RTPgwxX+i0pPhd8y0NXjpGxPhEOPQzRuXVlEQD3G0
         HCHmrcWnIWifViBjmj/VHI5+FRJ2y3udUkZszTrcrgUyZe7DooOKDQz7nbqY5DWGwQuF
         CUBdJxxJdnRBUAylIFpAs4+vdogY8VMvhbyupyaU/zithSZWBAJn2qBdR705vy3FWgKv
         VHGjkpvqR4mr4+Pq1D4e6BktWXej2rTAxrQbZ7iBPHU9pnXkRrsP529HJlUoujBVuxOA
         2v2muBo1ffsayRL7PrXNE6foBK1y9Z5tO4rMbePv6zpMAnp2bSLXDVc4keBNaZgWGY/p
         jjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuT29ehbyN/ATcCnZiRuVu0ODVzbMYGZM8OoTh+ph94=;
        b=EBd1ckSoo5GEmgtz4xlXpLEcfuLzN+DaOVFhmzKf1WQ1g22BGU7h75hdoEGVTNS6EG
         FVlTtjXOpc2l7O70zZLHkwBARLtabwdBNbKPuux/cduRjHXMoPDml8tkUu97P3uW43YY
         jpI5Zl+fx2h+em0aXAXHiY3m9mrnHcdljcdMtH0jyeIzO5XlnP2pAM9EYO9TIiFlBLJu
         vSDaIOBjJHh9H3u/2LjJeC+WQvEDQtN12DCISACsZuaTrDbLPvsw1fsDbeyQDVqLQUZZ
         mZWCIuNFKObMYSqt8zCScdoA6aQej0hcSq9RW5a94GdJwkZPzG71A62NmoF3Gv6Xr8TX
         Dh8Q==
X-Gm-Message-State: AJIora8ToQ3rP8vsqE8DZ0pEdMQeNib1ehzJj0hBlMbnW98C68aNpoB+
        +v+O8LVQ/cmB0IEFWZIa6aa9v6AM1J8=
X-Google-Smtp-Source: AGRyM1v2VunXky1vK+cV7MtTgRSFTyFU/5ufjTsqWt0YIO5NiQPjz46exDF5qHzY+63Z1oYD6zifPQ==
X-Received: by 2002:a05:6402:1d97:b0:42d:ccd1:2fa4 with SMTP id dk23-20020a0564021d9700b0042dccd12fa4mr20230419edb.325.1655588414917;
        Sat, 18 Jun 2022 14:40:14 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id ot21-20020a170906ccd500b006f3ef214e0esm3776351ejb.116.2022.06.18.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:14 -0700 (PDT)
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
Subject: [PATCH v3 12/16] power: supply: axp20x_usb_power: Add support for AXP192
Date:   Sat, 18 Jun 2022 22:40:05 +0100
Message-Id: <20220618214009.2178567-13-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is mostly the same as the AXP202 but has a different
current limit.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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

