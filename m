Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9A54031D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbiFGPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbiFGPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F923BE2;
        Tue,  7 Jun 2022 08:52:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me5so35547108ejb.2;
        Tue, 07 Jun 2022 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MU1NBdfsd3WejiAZZ/LhUKpjTNIf4Lxg/J1P2WWZO2w=;
        b=gYYUG5PgODwIWFhgsGyqZKPs0iX191m4/vg02X8sgcFvvprJZClaztw6qaOx62Ctyg
         2uxf+LHG4P3AwI5R6Kc9qJZZzUtHTNeWbGNMJpl4DjZNdsrWWLFtpUIghN5bHIGbNFZV
         p0hMkHJCKwEgj9Y28oaj4u0vL+hJ05r7+N9vNqGhi53wzfQ7d049DujrISmk0TnQtkPX
         43FLLK3GzhwcX9Esa1LvVMzz+0aLT8JSYG7WacH9ZKtgJG3dND7mAl8cJLKHG62eTKbo
         GkTEPZtHDyvfqKUhSvmWet4mngmcegEYgYaHUYsDIlh9++AzM22vBjertx9uJKRJ/T/A
         IE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MU1NBdfsd3WejiAZZ/LhUKpjTNIf4Lxg/J1P2WWZO2w=;
        b=fuuLZBC0slzM3gb4fzbXm5wpanqt3LjPOotuDlfuoZLr3wtK9x9YqKZPO6CzBZSKTL
         nzrt1K9t96CbMwlS7wDWg6pECEjH7E8cNPdgtnCrnhwLMC0x8MNd6+REHtC+BFBGYnh/
         4s3Ep1JJXQQHT4HUJeo6DuVegoVkZQLFe5gIR7k6T+VwTJb84iib6EDf80m3WyltDV79
         4jM6qk9HpgkhU7vKVsOrDpvXjIR8E0jJgMmdewmSCPM/NBfKM1VuO/BFI41OjJM31ws9
         91z6dYTpRHm4KgsSr42YecKenjbLpjHrVUBkhrGMIgpYiYJ+/GPTiZrtc8rtVIQR69Yi
         S4DQ==
X-Gm-Message-State: AOAM533HyQTCW5LxN2Ijc17uFpTy1LZ7b1DphXwijBUc88duSmSdqF42
        ROkPECG6N+F4LMNOcVfAKro=
X-Google-Smtp-Source: ABdhPJw4yX6tjYav2Nk+urAO1DKZ1hGVwd+C2hNqjZJ5Pk4wlrLTWV/GJ2Dc9V/JDgN/J8RhOP+06Q==
X-Received: by 2002:a17:907:72c1:b0:6ff:c5f:6b7d with SMTP id du1-20020a17090772c100b006ff0c5f6b7dmr27548288ejc.676.1654617170759;
        Tue, 07 Jun 2022 08:52:50 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id j1-20020a508a81000000b0042aca5edba7sm10687671edj.57.2022.06.07.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:50 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 15/17] power: axp20x_battery: Add constant charge current table
Date:   Tue,  7 Jun 2022 16:53:22 +0100
Message-Id: <20220607155324.118102-16-aidanmacdonald.0x0@gmail.com>
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

Add a table-based lookup method for constant charge current,
which is necessary when the setting cannot be represented as
a linear range.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 53 +++++++++++++++++++++------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 9106077c0dbb..87fb958f2224 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -61,6 +61,7 @@ struct axp20x_batt_ps;
 struct axp_data {
 	int	ccc_scale;
 	int	ccc_offset;
+	const int *ccc_table;
 	bool	has_fg_valid;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
@@ -176,7 +177,10 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 
 	*val &= AXP20X_CHRG_CTRL1_TGT_CURR;
 
-	*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
+	if (axp->data->ccc_table)
+		*val = axp->data->ccc_table[*val];
+	else
+		*val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
 
 	return 0;
 }
@@ -389,16 +393,36 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
@@ -410,14 +434,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
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
@@ -629,7 +653,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
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

