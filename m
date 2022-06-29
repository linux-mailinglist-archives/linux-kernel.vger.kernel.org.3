Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175D75602E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiF2Oa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiF2OaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E823BE6;
        Wed, 29 Jun 2022 07:30:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 189so9016643wmz.2;
        Wed, 29 Jun 2022 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huOUgohMa6HSSO8lmmPUC18ErSlu3Lc7c1e9dFxmbGc=;
        b=Wm1mz8unakgPVLn6X0Lkp9MK22xHjcjuI1FOdjTI239U6fP3XpKKbtwTe46Qx2KG2l
         /nrfnn8kIeLclBq6DzJfuwaO6rwOyu7GoSNTT7yztMrryOWWGzKVweX3jO4gBT0bc+99
         WUmOF0UZBOU8B5pCyziRVXcEIWmHvcl4uC6EhPzS4KdFapK+A9wMWQWsdcdtN9AdmGON
         cLJABV+WFDGSguAktKJ7BbcH/CwInYBsdfnHEIVxKMZ6O0GUdKK/XtOs0Tjaq3QwSbeN
         IUl9hHfYLGdZvaNyQ74klnDZeTVqLnR2zRRALzaoYGA3XgFV/thpjwlEXAikjNavWEc6
         uyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huOUgohMa6HSSO8lmmPUC18ErSlu3Lc7c1e9dFxmbGc=;
        b=DSXwKeIGRcKv+XA+YFC5dkcpSYhYWFVR+guqOZ7whv2MWU/f1GBHLvmAEx8Ovcjl//
         L0Twm4ZzubH+XOL/Co9onA+tcjRZLGLb0SH3izehitX41ZLrT5wmf8v85i4z7cNi6G7H
         FsSayHmZeBfJJY7EbD+YyQOEZ6rL76nEoO/Th+DBKjyVRetZ4Pi/MF8HvmxfeEI8BPCk
         O8ak0aUG87PCRFZGER1wGD8Qi6ojlzgf49/4FmHqhUg6k348pyr8dsu9tmjmLlR1+Zxv
         RGSP81lH2jOwFHSyu064xLTrmuMQK3g55jPp7zOGgwlCAxAOHWl+ODyz/pfuzjrZYxzZ
         XUaQ==
X-Gm-Message-State: AJIora8y6bCJ71ufFsw8R31XSsBUefvTOKv5Qc4mTZMQowNwMfiAOiMR
        n83Gzi/uhpZM9JGiVBOlPhA=
X-Google-Smtp-Source: AGRyM1u4KTFPybHVMFdcYM6BYDjaMnpWE2ULHL13DQhzRQSavcVOPj6ateaC9yO9+eJP7agqWsC4WA==
X-Received: by 2002:a05:600c:1549:b0:3a1:6f35:c431 with SMTP id f9-20020a05600c154900b003a16f35c431mr2643546wmg.74.1656513011058;
        Wed, 29 Jun 2022 07:30:11 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b0020d02262664sm16810313wri.25.2022.06.29.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:10 -0700 (PDT)
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
Subject: [PATCH v4 13/15] power: axp20x_battery: Add constant charge current table
Date:   Wed, 29 Jun 2022 15:30:44 +0100
Message-Id: <20220629143046.213584-14-aidanmacdonald.0x0@gmail.com>
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

Add a table-based lookup method for constant charge current,
which is necessary when the setting cannot be represented as
a linear range.

This also replaces the hard-coded 300 mA default ccc setting
if the DT-specified value is unsupported; the minimum value
for the device is now set exactly instead of relying on the
value being rounded down to a supported value.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 59 +++++++++++++++++++++------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 9106077c0dbb..401779d84d2b 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -61,6 +61,14 @@ struct axp20x_batt_ps;
 struct axp_data {
 	int	ccc_scale;
 	int	ccc_offset;
+	/*
+	 * Lookup table for constant charge current, if provided this is used
+	 * instead of ccc_scale/ccc_offset.
+	 *
+	 * The table is indexed by the field AXP20X_CHRG_CTRL1_TGT_CURR so it
+	 * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
+	 */
+	const int *ccc_table;
 	bool	has_fg_valid;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
@@ -176,7 +184,10 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 
 	*val &= AXP20X_CHRG_CTRL1_TGT_CURR;
 
-	*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
+	if (axp->data->ccc_table)
+		*val = axp->data->ccc_table[*val];
+	else
+		*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
 
 	return 0;
 }
@@ -389,16 +400,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
 }
 
+static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps *axp_batt,
+						  int charge_current)
+{
+	int i;
+
+	if (axp_batt->data->ccc_table) {
+		for (i = AXP20X_CHRG_CTRL1_TGT_CURR; i >= 0; i--) {
+			if (axp_batt->data->ccc_table[i] <= charge_current)
+				return i;
+		}
+
+		return -EINVAL;
+	}
+
+	i = (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->ccc_scale;
+	if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
+		return -EINVAL;
+
+	return i;
+}
+
 static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 					      int charge_current)
 {
 	if (charge_current > axp_batt->max_ccc)
 		return -EINVAL;
 
-	charge_current = (charge_current - axp_batt->data->ccc_offset) /
-		axp_batt->data->ccc_scale;
-
-	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
+	charge_current = axp20x_get_constant_charge_current_sel(axp_batt, charge_current);
+	if (charge_current < 0)
 		return -EINVAL;
 
 	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
@@ -410,14 +440,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
 {
 	bool lower_max = false;
 
-	charge_current = (charge_current - axp->data->ccc_offset) /
-		axp->data->ccc_scale;
-
-	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
+	charge_current = axp20x_get_constant_charge_current_sel(axp, charge_current);
+	if (charge_current < 0)
 		return -EINVAL;
 
-	charge_current = charge_current * axp->data->ccc_scale +
-		axp->data->ccc_offset;
+	if (axp->data->ccc_table)
+		charge_current = axp->data->ccc_table[charge_current];
+	else
+		charge_current = charge_current * axp->data->ccc_scale + axp->data->ccc_offset;
 
 	if (charge_current > axp->max_ccc)
 		dev_warn(axp->dev,
@@ -629,7 +659,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 								   ccc)) {
 			dev_err(&pdev->dev,
 				"couldn't set constant charge current from DT: fallback to minimum value\n");
-			ccc = 300000;
+
+			if (axp20x_batt->data->ccc_table)
+				ccc = axp20x_batt->data->ccc_table[0];
+			else
+				ccc = axp20x_batt->data->ccc_offset;
+
 			axp20x_batt->max_ccc = ccc;
 			axp20x_set_constant_charge_current(axp20x_batt, ccc);
 		}
-- 
2.35.1

