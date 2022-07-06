Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59E7568528
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGFKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGFKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:19:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B226544;
        Wed,  6 Jul 2022 03:18:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so21386535wrc.2;
        Wed, 06 Jul 2022 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFRacK/lHYWgN+1u5LK1kYYmS445KX95i0Rb5jk9kRw=;
        b=fZadVM0Ryt5U5omkXPSw8O5dTH3N1OegY/Q8QVL/mRQkaDgQUnBzqOPmNNc/zi9aCv
         qG1JSshsMnEGLErV40hu/g+/YlB4ca52cIpH4XX2fDvTuC/qGFiQnvJyO98oyIoBV/wd
         mOj6A60gQ10FtvrSZSFuQlLUnhQ1PIwPPZcAR0bH2n1imyyPGlTP3+pPmhCS4xhLlY9a
         N/pLBpVAFR+PF1x2N43JgPNBP45qs1PUJoXYofdQxXBzq3KINlxwwCssMkb4nedTUgnY
         tUTDPZgUfdgTmuanWCKvssU89AmWIwNys9hxc89UWRqUcAcE3k7NDN0Hp4mE+1KzCdiJ
         RxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFRacK/lHYWgN+1u5LK1kYYmS445KX95i0Rb5jk9kRw=;
        b=2JhFLiF3diIMx8E+sctX3V+8gHQeDfQGJ61PTAZdo+2SFZyr2B9Vl33unNX9jVT0tY
         HmBl1GwIiLuYoEUPl4PuDwzwY2NGsSIq+p3qcxPD6qbOEV+nCN9dd8cIeuHNWf0yJNJ6
         sa5cjMsJAbsoiOvwNnxNXS/RxY55/M7CmtsFqyw1JJZuvVKuz+ZpFI7MXV9ZrokDaoGD
         97ubCMutVjijovCjZcDjzxdzGzPEDl58i8WoEWSgwudQMLUlaGAkqiVvUg8PERznX72u
         KcxahAG4bxY8UyQ1jaBu3vBsTHvq72KkxaVaEpI00W3Dk+Seu/PBaC3hi4vfoZqPp9cH
         VGEQ==
X-Gm-Message-State: AJIora8HJUYktXv9Ka0j04xETN9GxKAGrpBIFyTIwDLFEsl3k4zC/Hpb
        o7+KiThC8///+8+lVnx30wA=
X-Google-Smtp-Source: AGRyM1sp4ohzZ04YxV24XO0ixUzdGprhwiraUKlLrY7U2hilZkHGbRzGKwxWgYBJy8f2cY7xucxUXg==
X-Received: by 2002:a5d:6e85:0:b0:21d:65ec:22d with SMTP id k5-20020a5d6e85000000b0021d65ec022dmr17847950wrz.435.1657102728349;
        Wed, 06 Jul 2022 03:18:48 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c2cc200b003a18e7a5af2sm18975814wmc.34.2022.07.06.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:47 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 11/13] power: axp20x_battery: Add constant charge current table
Date:   Wed,  6 Jul 2022 11:19:00 +0100
Message-Id: <20220706101902.4984-12-aidanmacdonald.0x0@gmail.com>
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

Add a table-based lookup method for constant charge current,
which is necessary when the setting cannot be represented as
a linear range.

This also replaces the hard-coded 300 mA default ccc setting
if the DT-specified value is unsupported; the minimum value
for the device is now set exactly instead of relying on the
value being rounded down to a supported value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

