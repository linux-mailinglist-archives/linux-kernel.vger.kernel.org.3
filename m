Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9F550728
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiFRVlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiFRVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0BEE04;
        Sat, 18 Jun 2022 14:40:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ej4so6388822edb.7;
        Sat, 18 Jun 2022 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdTUleMjvArbl3R35EacP+g4BGTjHl1V0Yx3cvZno8E=;
        b=Uz9gEVO7PIHJOUdcfDrahSGnUHOJ2dgbCNqAWreYRHanaiWUtpzQWLZgOdJmQ0AC1c
         YljRJhMiIiUNbztufQtKRbSbWv94XIP2jUZnY3OYcv5KKW6XLPXllP3HayGLr3LsHrN1
         YmgDGcRNaIg2kNc/USwg+Sjc/4LTcBev16dptu6X/BQ6plYKKYoomCj4Ahiz8VYwtxRG
         nK6nMGMRRdk8Sb3Z1BGJjw4R4AYXx9Wb0aOsg5cnVbQs8bwiEH1YDY9GipAizZ9PM/mU
         opx/ace+2P0tZjLjcR82m63AF9uDA9+fMchUpKpJNybNpAW3N2nreg6sb2bK+HD126O7
         rQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdTUleMjvArbl3R35EacP+g4BGTjHl1V0Yx3cvZno8E=;
        b=Thjk1bKjNIgW+i8/URfLXTHdS6SB9XLMtu7ny0dmIkSBR2yehDWGUegMY98vXWoW2r
         IRO2WtPnX7wIbXIcEULaeM/2ihbrDx9/unEHTD1qm0nboF5d/mm+9froL9s4qKI4wxPY
         iGYGns9WGcyjAkH8BYBXG6ont77dzW+Z/2VP8IG7qZT/gk8tU5WR7ErVnDZESdlzTlbb
         XMcb4Ta0bvCzEt6sR5hwYrEkSY6DyilsEQtoT4S9PpIRyjLaqi6trXiesAexbKxaIWNi
         Ik1mGpv8/Pdl1EatS112F+wFn9EWow8B0gXCJFPQ0Y7MxCltTSz2qJPG+i7CbXbRF7Nr
         S3EQ==
X-Gm-Message-State: AJIora9x4qBcQ656AKRI0YqR6lkYQN3rFRaE/V878COpkfhhmUxEkvf3
        fTGpDrKt84PfU1ENiC8+YJA=
X-Google-Smtp-Source: AGRyM1vHH6d2dcuUAmUfGkjtSJKYZe+J548J5Z9xXkC9KlYcHIdWWOWuPJhhzyhs+40n2fGz/rf1CA==
X-Received: by 2002:a05:6402:3322:b0:42d:f984:92fa with SMTP id e34-20020a056402332200b0042df98492famr20012125eda.106.1655588419708;
        Sat, 18 Jun 2022 14:40:19 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090631c200b007120e9573b4sm3847382ejf.169.2022.06.18.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:19 -0700 (PDT)
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
Subject: [PATCH v3 15/16] power: axp20x_battery: Support battery status without fuel gauge
Date:   Sat, 18 Jun 2022 22:40:08 +0100
Message-Id: <20220618214009.2178567-16-aidanmacdonald.0x0@gmail.com>
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

Add a "has_fg" flag to indicate that the chip has a fuel gauge.
Report battery full status on chips with no fuel gauge using the
battery voltage.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index ce22c0a92878..f2c57fd1329b 100644
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
@@ -553,6 +582,7 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
 };
@@ -560,6 +590,7 @@ static const struct axp_data axp209_data = {
 static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp22x_battery_get_max_voltage,
 	.set_max_voltage = axp22x_battery_set_max_voltage,
@@ -568,6 +599,7 @@ static const struct axp_data axp221_data = {
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp813_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
-- 
2.35.1

