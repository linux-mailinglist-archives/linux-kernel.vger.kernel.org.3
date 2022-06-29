Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192745602CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiF2Oai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiF2OaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5C3054B;
        Wed, 29 Jun 2022 07:30:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so17605796wra.0;
        Wed, 29 Jun 2022 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7o4tF/gtDrRCcpZ88soilLOFMUthquvodxNmmBfEYs=;
        b=GdLvPrDFzcEEWAA4JpRInaagGdJj503Zr2xjAZkn5Mdp6Ay9sZ2Fan2xAAqNSpwwBT
         T/z4fsxLNJL+C1fVIrR33rBq0SSh1zMtdF0ZPdnfl9r4fE9u4pmfRq7/vHTF3IZ3hK29
         8+vBNdQ9EpIwOjKDHvHXpdFLQiSZc7DA31K1OpPcybMHgQnWx8jNwVGjn28RSLKcC4qm
         CpqFtmHOB9at1Z5GbapOvJNpxwxiGiUMkWAyxVyXFxsLTch+gZNRNbbhiZlYg/sd6qVj
         Fv8Nzwztp8hrf2uN7RbtNofZJR9qtvrkVoD1uP+2Zl6PbDPzgeu26oWUKbXwwtcdFKAp
         JyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7o4tF/gtDrRCcpZ88soilLOFMUthquvodxNmmBfEYs=;
        b=N32tNLZ48FI7c2xH4Ls8LeORUdMr0okvfbyenKiXDTMdMdWpS4apzng3+vCkzQBPHu
         RK9ycmVcfVKvGeUGAbf/zRBJdRU63a9Nk5M5ZY2nK+ViiMtlFLta3ZKgcGUdAAajDzDk
         S+HRjaf85QmhO+czsgHDWqon22w21eMgXwGQzDDbCPPCe4gEEKamEXuzEumC+XrLJyx1
         axLo0WYjaC70RimPvJ3f+ZN+EWpOPr+dCrwowCn95y8PLsfK99EIPL6uRz2Tq/x7Imz6
         y1oQ4JmuE2Wo/FgNgswG0ll1RPqp51DFSymlKRCELy9XTtBCVCNzhyTDangT1mUaYB2e
         l6GA==
X-Gm-Message-State: AJIora/caL4eRjJ5rF4dWV0tLwWR/ZxTqE82zwQJNquJ9rjBtK/gkBdn
        XVK/r/p4zOR1pr5rLFhtHqg=
X-Google-Smtp-Source: AGRyM1sBUIO2E1geRpNeoOmUqDC6LyvA/BNgIlIKnqzZYPvNX/9lAPOpQ68bdPP3BnKgNCD2rktVyQ==
X-Received: by 2002:adf:fe83:0:b0:21b:9cc6:4c91 with SMTP id l3-20020adffe83000000b0021b9cc64c91mr3604289wrr.414.1656513006441;
        Wed, 29 Jun 2022 07:30:06 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021b98d73a4esm16997309wrr.114.2022.06.29.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:06 -0700 (PDT)
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
Subject: [PATCH v4 11/15] power: supply: axp20x_usb_power: Add support for AXP192
Date:   Wed, 29 Jun 2022 15:30:42 +0100
Message-Id: <20220629143046.213584-12-aidanmacdonald.0x0@gmail.com>
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

The AXP192's USB power supply is similar to the AXP202 but it has
different USB current limits and a different offset for the VBUS
status register.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 84 +++++++++++++++++++++----
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1e6d1d44808..f83e2ed6d507 100644
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
 
@@ -121,6 +124,25 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
+static int axp192_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
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
@@ -179,7 +201,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
-	unsigned int input, v;
+	unsigned int input, v, reg;
 	int ret;
 
 	switch (psp) {
@@ -215,6 +237,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_get_current_max(power, &val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -256,16 +280,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
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
+			break; /* Other chips lack the OTG status register */
 
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
@@ -316,6 +343,28 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp192_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	const unsigned int mask = AXP192_VBUS_CLIMIT_EN |
+				  AXP192_VBUS_CLIMIT_100mA;
+	unsigned int val;
+
+	switch (intval) {
+	case 100000:
+		val = AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
+		break;
+	case 500000:
+		val = AXP192_VBUS_CLIMIT_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(power->regmap,
+				  AXP20X_VBUS_IPSOUT_MGMT, mask, val);
+}
+
 static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -383,6 +432,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_usb_power_set_current_max(power,
 								val->intval);
+		else if (power->axp20x_id == AXP192_ID)
+			return axp192_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -468,6 +520,13 @@ struct axp_data {
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
@@ -600,7 +659,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (power->axp20x_id == AXP202_ID) {
+	if (power->axp20x_id == AXP192_ID || power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
 		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
 					 AXP20X_VBUS_MON_VBUS_VALID,
@@ -659,6 +718,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
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

