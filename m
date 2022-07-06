Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ACF568546
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiGFKTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiGFKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:19:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70426AD0;
        Wed,  6 Jul 2022 03:18:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk26so6293362wrb.11;
        Wed, 06 Jul 2022 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bu6ftz0Gt9TtFBeI7TV10odeAq94fVVDqNabiJlB7ak=;
        b=bzgQ5Q+o/bqL/bB5ahPAL/7YK3du1XAO4RfHuhgDTHjyIUH9Ojb+2g1KJW/nOchLCl
         0VGGBievTaE3k4J/n1WUlkjbLD/9xM+/tUh6NQXGvwCI2woc+NQFn9F3MZZSeSQ9rUq7
         dFfX/y1AxRZJPvv47mWkvB8D2rYqo06KWfSWoYTXFZCmsB/ZAt3V7hY0rdfReU/NnHl1
         2Pc98HocugphC4tkKxzdk6VpnLzIHaUibgAnWBtJl+/G3ZdZIuwzC4KT35shnOn7dCuj
         IC0gdnsLen187Gvx55CCCfZIGDjUEsqQ8I786fa2jRi72UZaRco8OVt9cvIqxYx9qfW3
         hRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bu6ftz0Gt9TtFBeI7TV10odeAq94fVVDqNabiJlB7ak=;
        b=S1ERP6RbObZXVhJ0YTXJZyAlfzayQZZDE/OzYjbOsjVbmmTTxNHS1c8M1jQwzegdM/
         Q++b6mBJXWR2B6UR5rdrt/ckiwg6N0PFKm/1u92u4vmE5PLRX1HrrRkXJOVtRdPS5LhQ
         0GmyAZffjVbdVAb1xQ8Sm/7USSGxf+P0i6H0F0Hc8NX8trWXKhVpUL5ZC46xcoZLue7N
         lblvSZn/EHOeOgRoGiCob10BDyS8nUhW+XGk5YALVP6HeCVOzrL4MLEKo27iGJrcSAuE
         WcMk5lR6rX82YmiPO2DaADmFxV7rXADdCG2aqHnqt5fCHzcz1HimEun+B7By+spILCQi
         fu5w==
X-Gm-Message-State: AJIora8yW2SYLJk0By962z6kRJmWtaZnKjhgX8yu2z4okiXRZqO/r6Qz
        YWfrjWC51P9wIYBvznKXqXM=
X-Google-Smtp-Source: AGRyM1t6PdRKy5dGXyHX7RTGugNCavZGmAGNXggwZsDT2prSIW9gRHDUpcWnmCKi44YPe4xrMpWiGA==
X-Received: by 2002:a5d:6d84:0:b0:21b:9acb:c478 with SMTP id l4-20020a5d6d84000000b0021b9acbc478mr36423801wrs.491.1657102730163;
        Wed, 06 Jul 2022 03:18:50 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id c16-20020adfe750000000b002103a7c5c91sm35249435wrn.43.2022.07.06.03.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:49 -0700 (PDT)
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
Subject: [PATCH v5 12/13] power: axp20x_battery: Support battery status without fuel gauge
Date:   Wed,  6 Jul 2022 11:19:01 +0100
Message-Id: <20220706101902.4984-13-aidanmacdonald.0x0@gmail.com>
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

Add a "has_fg" flag to indicate that the chip has a fuel gauge.
Report battery full status on chips with no fuel gauge using the
battery voltage.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

