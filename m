Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5E560317
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiF2ObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiF2OaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0331DD5;
        Wed, 29 Jun 2022 07:30:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k22so22764975wrd.6;
        Wed, 29 Jun 2022 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odvKRTSR5PQa6I1lgNQzJlwkwMoYjjJl0f88++Q1+JE=;
        b=K8KCY0T0J9PPdnMIewUFEB6A61pwqHd/8akYO/gilOGoOgcZMAJVwsN2l8wPwaH03B
         Nk2rB3SGMiFtsWa0VOhq6LPPdWswfAzVyuSjh9b9jQwrn6xtj4apnq1xEK27Q/MfoKfI
         jZ18JJtXZ8cCtT7LSQ6tONrBKJ3IG2lHhFQ457g4/HjpbFv8kDyWCsrzY/gLP/YZll5v
         10iZJ8YzWJal0cWlSwLxLRSmaR+1+7EJIPQnn3iCDxvVQpalWHcXlsDnyjM70XcZz0xs
         bmUJi91sEiGOkDREM0ksf/wVaA7tolHXFYRc4aEqEnL+wYDtXtPiRX7cet59JUlOPOLI
         7xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odvKRTSR5PQa6I1lgNQzJlwkwMoYjjJl0f88++Q1+JE=;
        b=FYtfKMvAgJlPlRNBKsRq3BZ5Ht0qjSq3k2+bw7rXAeRJ7P+DDziboyEm/0lBoqGY+e
         cd0Vx/lepGiAoO9pg345EvahE10ZNvxvfdjosjyV1V2fyiPEw6lYsGQogexzHbLDY4/l
         Ym//Mi1ksm0+Ay/k5lLvIsrOSpxivJufJr90WaWWlb4NS+6P8daNThDUX32Hyb/R42xr
         w/4W4TnsHKRaF1Cf3ITSh4dZE1qUKl9NlAe4+UmSr+l1IPxRsU4aQ2/h/ThQLdmUHm1Q
         Ff5EVQaWyiwYBczyATtT91pcxNTAUuc3M7m0tOjvtSXDbg+RNuuaTRisx33DOYfHNXlD
         YfLA==
X-Gm-Message-State: AJIora991ror/WR58pGJHjbTgutTPuhUkkRrewyaEolQZvHvZ42MQB6Y
        etIW+SLASHHWkYU55SYvrgg=
X-Google-Smtp-Source: AGRyM1vVdkvIEYoZMBdZbdfj/0hf9JThtjbJSYvs0nxAFNS+SZdkZ3wU8Gtmp+CWN8coP8b1zwdakA==
X-Received: by 2002:a5d:6d86:0:b0:21b:ce00:4163 with SMTP id l6-20020a5d6d86000000b0021bce004163mr3594235wrs.511.1656513013254;
        Wed, 29 Jun 2022 07:30:13 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id k23-20020a7bc317000000b003976fbfbf00sm3538855wmj.30.2022.06.29.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:12 -0700 (PDT)
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
Subject: [PATCH v4 14/15] power: axp20x_battery: Support battery status without fuel gauge
Date:   Wed, 29 Jun 2022 15:30:45 +0100
Message-Id: <20220629143046.213584-15-aidanmacdonald.0x0@gmail.com>
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

Add a "has_fg" flag to indicate that the chip has a fuel gauge.
Report battery full status on chips with no fuel gauge using the
battery voltage.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 401779d84d2b..574c1d001556 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -69,6 +69,7 @@ struct axp_data {
 	 * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
 	 */
 	const int *ccc_table;
+	bool	has_fg;
 	bool	has_fg_valid;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
@@ -197,7 +198,7 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 				   union power_supply_propval *val)
 {
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
-	int ret = 0, reg, val1;
+	int ret = 0, reg, val1, val2;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -231,6 +232,34 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 			return 0;
 		}
 
+		/*
+		 * If the chip does not have a fuel gauge, we check battery full status
+		 * using voltage instead.
+		 */
+		if (!axp20x_batt->data->has_fg) {
+			ret = axp20x_batt->data->get_max_voltage(axp20x_batt, &val1);
+			if (ret)
+				return ret;
+
+			ret = iio_read_channel_processed(axp20x_batt->batt_v, &val2);
+			if (ret)
+				return ret;
+
+			/* IIO subsystem reports voltage in mV but we need uV */
+			val2 *= 1000;
+
+			/*
+			 * According to the AXP192 datasheet, charging will restart if
+			 * the battery voltage drops below V_rch = V_tgt - 0.1 V, so we
+			 * report the battery is full if its voltage is at least V_rch.
+			 */
+			if (val2 >= val1 - 100000)
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		}
+
 		ret = regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &val1);
 		if (ret)
 			return ret;
@@ -552,6 +581,7 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
 };
@@ -559,6 +589,7 @@ static const struct axp_data axp209_data = {
 static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp22x_battery_get_max_voltage,
 	.set_max_voltage = axp22x_battery_set_max_voltage,
@@ -567,6 +598,7 @@ static const struct axp_data axp221_data = {
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp813_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
-- 
2.35.1

