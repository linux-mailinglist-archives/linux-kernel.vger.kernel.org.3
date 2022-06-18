Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32963550727
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiFRVlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiFRVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B73FD16;
        Sat, 18 Jun 2022 14:40:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so6388790edb.7;
        Sat, 18 Jun 2022 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/zYTjgk5pB69GoemyuVBNs3k+vyg9d4nZ7pYovafwk=;
        b=KUy3M5rNLOREFfUhIdpU3cPrpyLNKhgcX75BXGfNCHMHOxWRSBVY3ZlirdBi9ATKDl
         Tl9ySYb+WdRXO4PPCAgEpfi5BGYDDfbTiIT3PdDIeFvxaJVrj2OYZXMB4k1/ZfUke0XS
         ehaZia8+NXSyitUsJC5Nt6qC1RKWby4eTJFqiPwclL6bVltWKebvRE0GICWP7HQSEpiJ
         XZj1g9WaJX3YDqhuoxeLfjqN+A8kfd4mlYkiusBl5M7Sfd9GUOHWpTOO3b88is1NHvcL
         w2APmO/RqhmssXuv20pRBQLmwbmJbsm/ePq+9MA5PZs5zZytrdI4z4SfdPtZ7NDoewcL
         e9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/zYTjgk5pB69GoemyuVBNs3k+vyg9d4nZ7pYovafwk=;
        b=LL0QvFHAkAW8rIM6uI261iDz4oyTUJ+cWMeSOlHfwu7+S4EJAC+P/lYjvGtJ3YDEHj
         D6ouq7NN5BJAGw0dOL2mOODNoWA532VPXVYy1vklybSNt1t6L7jd+aUY34RkfrqMsddh
         oeTeCQjG5Wip5J4LpOvAqxunfobc5QVkBemUXcyo5j2f/k1eotbVjm5bWxOsKBtfOgRp
         M6UBYvarMIqijtppLFc2kHHwoSrDSGLN+/PXojxM5rL3bck+l+TQ/v4ldT33374Bdq+e
         QE0/re/VLhdsYveLFxjRZIYXmvgTdQTrBaquWiKB6LrjqqAu9u9zEFauOQo5Ypz8KiCv
         pE/Q==
X-Gm-Message-State: AJIora8x/t2W0l6BvvIjwn60LHVOeTT5qihkdaQMriMnhuPk9O7nHpPo
        SdSk4mlAfnb9gKAjvXbD6AM=
X-Google-Smtp-Source: AGRyM1sFi2GKoViGB/DWyMRS6izqYKmtTmwdB/LAL+QURoADCpa1/iXI2o5/fzr8w+zK2/5Upg/R/w==
X-Received: by 2002:a05:6402:27cc:b0:42d:de37:7e42 with SMTP id c12-20020a05640227cc00b0042dde377e42mr20415952ede.200.1655588418252;
        Sat, 18 Jun 2022 14:40:18 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b0070b7875aa6asm1104715ejh.166.2022.06.18.14.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:17 -0700 (PDT)
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
Subject: [PATCH v3 14/16] power: axp20x_battery: Add constant charge current table
Date:   Sat, 18 Jun 2022 22:40:07 +0100
Message-Id: <20220618214009.2178567-15-aidanmacdonald.0x0@gmail.com>
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

Add a table-based lookup method for constant charge current,
which is necessary when the setting cannot be represented as
a linear range.

This also replaces the hard-coded 300 mA default ccc setting
if the DT-specified value is unsupported; the minimum value
for the device is now set exactly instead of relying on the
value being rounded down to a supported value.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 60 +++++++++++++++++++++------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 9106077c0dbb..ce22c0a92878 100644
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
@@ -389,16 +400,36 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
 }
 
+static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps *axp_batt,
+						  int charge_current)
+{
+	int i;
+
+	if (axp_batt->data->ccc_table) {
+		for (i = AXP20X_CHRG_CTRL1_TGT_CURR; i >= 0; --i) {
+			if (axp_batt->data->ccc_table[i] <= charge_current)
+				return i;
+		}
+
+		return -EINVAL;
+	}
+
+	i = (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->ccc_scale;
+
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
@@ -410,14 +441,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
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
@@ -629,7 +660,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
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

