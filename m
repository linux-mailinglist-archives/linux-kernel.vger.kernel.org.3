Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B061540323
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbiFGPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344543AbiFGPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600724F16;
        Tue,  7 Jun 2022 08:52:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me5so35547277ejb.2;
        Tue, 07 Jun 2022 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfO6Sx6ARHHT4F4vWizG3z7rq9SAuQ0dqpmQH5iYmfk=;
        b=ZXIucOCpLDog7eaVEeLBZZfs8ZRcpYc4UcUgMmAUC4I7b9IZK1KAU09g+e5xBQYmoV
         dX9bE/VVKG4eiyDTG+Yc/QdKfnxyc8rtIsc+SUJJA3Twq3IVT7MvEPL4icNsl1ekvyYw
         K0tJlBVdvmHc8Pv7naj6AVty0XV4TbIB6H2hvwG3Cdf62w8M8TPnnFFXi5qsqggavgWZ
         5aHbNVGVB6FbCLOY0RVafwPf3ARKy94pPLTqa8qNylvAJbPOSOeE/NcwOF8jvbO4LP1k
         D5KC94iKckJ4hlmEyoUkjWMSqMWm2ziH0fzg6JeMqJUZW/sT4NUouhnl9diAAM9V0QHi
         +51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfO6Sx6ARHHT4F4vWizG3z7rq9SAuQ0dqpmQH5iYmfk=;
        b=SkVh/DIBCGzyqgAqpUOjnYLJVP5kMh4m9Z6mNvmJoNVUxhA5bR7kRIdJHkktrHgMM8
         yRJXZKXj8fbE1114iXkyoRchHo9qQ0I8DOFqNGYyJIXdg3NyZe5nUr2w/zTz1Jq7k+5H
         2uSSq9nhQ+t/ncC0fC1MwKWflTBHGYkZOMXNk+MmUA5MM2zdm/Jd2XKhaH3kmjPVRaEi
         l6iXLMj+SIO79VQj71u7XvbxCMGFXRFtThwVjPoPgccClNjrMxk6UEmuC88JysDzklUU
         ScZut1AyBV341chKuLweKz1Z3zlqYcT5weBqqRlCkhmnA8smp7fVv1I09N/MxsymrNUx
         HuPQ==
X-Gm-Message-State: AOAM530AkVN7sJyh8hLF04s5M+ePNf5koXuaE6RcY/bPIthpaiDZqoQT
        VRQL/9ldHu+P3BEEXvghrSk=
X-Google-Smtp-Source: ABdhPJzS3Eqzx6iXBXaosSFh4oZhOQ7A6RRAlAhs7gjxfyp9TKEV2uv5wJAc76sVs4S+D5oq4dR3Xg==
X-Received: by 2002:a17:906:94c9:b0:711:e7c8:ba15 with SMTP id d9-20020a17090694c900b00711e7c8ba15mr2194615ejy.414.1654617172464;
        Tue, 07 Jun 2022 08:52:52 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm7820402ejc.197.2022.06.07.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 16/17] power: axp20x_battery: Support battery status without fuel gauge
Date:   Tue,  7 Jun 2022 16:53:23 +0100
Message-Id: <20220607155324.118102-17-aidanmacdonald.0x0@gmail.com>
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

Add a "has_fg" flag to indicate that the chip has a fuel gauge.
Report battery full status on chips with no fuel gauge using the
battery voltage.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 87fb958f2224..e9547e2d7c48 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -62,6 +62,7 @@ struct axp_data {
 	int	ccc_scale;
 	int	ccc_offset;
 	const int *ccc_table;
+	bool	has_fg;
 	bool	has_fg_valid;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
@@ -190,7 +191,7 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 				   union power_supply_propval *val)
 {
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
-	int ret = 0, reg, val1;
+	int ret = 0, reg, val1, val2;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -224,6 +225,34 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
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
@@ -546,6 +575,7 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
 };
@@ -553,6 +583,7 @@ static const struct axp_data axp209_data = {
 static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp22x_battery_get_max_voltage,
 	.set_max_voltage = axp22x_battery_set_max_voltage,
@@ -561,6 +592,7 @@ static const struct axp_data axp221_data = {
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp813_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
-- 
2.35.1

