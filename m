Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32BE562E68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiGAIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiGAIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4071252
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:35:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g7so1969925pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/J/oGF74cDu8WRXcmEUoVqkWg7/dM3ieJV6SNHK5u2g=;
        b=wJ4YMZ6WLBdrditEkE5xr2++AgUlYr19Lh44vM2dqHRINpwTsz9a5gI65oTVGYkGb1
         8LvT2VXuTws67upE08yWCsQhkV6JOw2/2ssORzbt2Ct5kDeyZpG5U6uiJigpF/bOWCr/
         ZT9/u25NSfTCYll2z6hDsspxphpNLvoxBoUpZOhtfY9ZyspvXxfs3JZ2XEmxuHIRhdKp
         NjF4K1FG+mHrkTcRSZliV1Nwa6P8jSwp9ct9GP0rkV7b81VGaCGEcUOn0T231qrwPU45
         JT84zDwuiSytd8Y8T5Omnj07CFYYTQ4EMqryDTgWIeAGtjI2RwdMiOIqNc3rJUz5A+cd
         e7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/J/oGF74cDu8WRXcmEUoVqkWg7/dM3ieJV6SNHK5u2g=;
        b=GPQ3cMN8C/N+HhjoS5jQWer0420wKJJUEwCI0lzz/EafSxk2gYTlIy8CwzUNVXEfS1
         jmirhTDIdrWYwXSL1vwwerGhY89v5xDjAm7b9lrdI69b3ah5qchHyPCig/W3yjKrQtoR
         vnoXq0iUh9Eegwn4tcUC/alg5/p3rvAM+sFtz3RbNWdrSp0GMvSKi741Gbl/h2uu9tlf
         8c2lUsAGZHV4waO9GfCNpj5Kyp2JS4l0WAQyLPt/xFU4mL142ntUKv25gMrgGJ6JXEaV
         qOoDa+ax2Xr3ej9yI8V1BuQ/0xH/vwTHmAH/v8jvmclYX0O2sgvfwo5Ac8ljQUnpoBRg
         XP/Q==
X-Gm-Message-State: AJIora/lcAl/fmVxj0jODwImYYfblCsiUtSdVwsODpSHAMcVOgdY0V4X
        wDnEpCx6Ig06/D/iSgGoj4gp9w==
X-Google-Smtp-Source: AGRyM1txuauuk+cj9pXaDTeqhWJALiBbIWHadKxSv+B6yXyhdhDAYGmVhHoteZsZIJRf8Xo3VM5MHQ==
X-Received: by 2002:a17:902:6b8b:b0:14d:66c4:f704 with SMTP id p11-20020a1709026b8b00b0014d66c4f704mr20022449plk.53.1656664512730;
        Fri, 01 Jul 2022 01:35:12 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709027fc200b0016a581f9ac2sm14768963plb.234.2022.07.01.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:35:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] OPP: ti: Migrate to config_regulators()
Date:   Fri,  1 Jul 2022 14:04:54 +0530
Message-Id: <5ca08d546dd7e03e290256b4530ab4e6266da72e.1656664183.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656664183.git.viresh.kumar@linaro.org>
References: <cover.1656664183.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core now provides config_regulators() interface, which needs the
platforms to just set the OPP voltages instead of both clk and voltage.
The clock is set by the OPP core instead and hence reduces code
redundancy.

Migrate the only user of the custom set_opp() interface to
config_regulators().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/ti-opp-supply.c | 74 +++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 26e929377ebd..f1f881140fa2 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -36,11 +36,15 @@ struct ti_opp_supply_optimum_voltage_table {
  * @vdd_table:	Optimized voltage mapping table
  * @num_vdd_table: number of entries in vdd_table
  * @vdd_absolute_max_voltage_uv: absolute maximum voltage in UV for the supply
+ * @old_supplies: Placeholder for supplies information for old OPP.
+ * @new_supplies: Placeholder for supplies information for new OPP.
  */
 struct ti_opp_supply_data {
 	struct ti_opp_supply_optimum_voltage_table *vdd_table;
 	u32 num_vdd_table;
 	u32 vdd_absolute_max_voltage_uv;
+	struct dev_pm_opp_supply old_supplies[2];
+	struct dev_pm_opp_supply new_supplies[2];
 };
 
 static struct ti_opp_supply_data opp_data;
@@ -266,27 +270,32 @@ static int _opp_set_voltage(struct device *dev,
 	return 0;
 }
 
-/**
- * ti_opp_supply_set_opp() - do the opp supply transition
- * @data:	information on regulators and new and old opps provided by
- *		opp core to use in transition
- *
- * Return: If successful, 0, else appropriate error value.
- */
-static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
+/* Do the opp supply transition */
+static int ti_opp_config_regulators(struct device *dev,
+			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
+			struct regulator **regulators, unsigned int count)
 {
-	struct dev_pm_opp_supply *old_supply_vdd = &data->old_opp.supplies[0];
-	struct dev_pm_opp_supply *old_supply_vbb = &data->old_opp.supplies[1];
-	struct dev_pm_opp_supply *new_supply_vdd = &data->new_opp.supplies[0];
-	struct dev_pm_opp_supply *new_supply_vbb = &data->new_opp.supplies[1];
-	struct device *dev = data->dev;
-	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
-	struct clk *clk = data->clk;
-	struct regulator *vdd_reg = data->regulators[0];
-	struct regulator *vbb_reg = data->regulators[1];
+	struct dev_pm_opp_supply *old_supply_vdd = &opp_data.old_supplies[0];
+	struct dev_pm_opp_supply *old_supply_vbb = &opp_data.old_supplies[1];
+	struct dev_pm_opp_supply *new_supply_vdd = &opp_data.new_supplies[0];
+	struct dev_pm_opp_supply *new_supply_vbb = &opp_data.new_supplies[1];
+	struct regulator *vdd_reg = regulators[0];
+	struct regulator *vbb_reg = regulators[1];
+	unsigned long old_freq, freq;
 	int vdd_uv;
 	int ret;
 
+	/* We must have two regulators here */
+	WARN_ON(count != 2);
+
+	/* Fetch supplies and freq information from OPP core */
+	ret = dev_pm_opp_get_supplies(new_opp, opp_data.new_supplies);
+	WARN_ON(ret);
+
+	old_freq = dev_pm_opp_get_freq(old_opp);
+	freq = dev_pm_opp_get_freq(new_opp);
+	WARN_ON(!old_freq || !freq);
+
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
 					  new_supply_vdd->u_volt);
 
@@ -303,39 +312,24 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 		ret = _opp_set_voltage(dev, new_supply_vbb, 0, vbb_reg, "vbb");
 		if (ret)
 			goto restore_voltage;
-	}
-
-	/* Change frequency */
-	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n",
-		__func__, old_freq, freq);
-
-	ret = clk_set_rate(clk, freq);
-	if (ret) {
-		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
-			ret);
-		goto restore_voltage;
-	}
-
-	/* Scaling down? Scale voltage after frequency */
-	if (freq < old_freq) {
+	} else {
 		ret = _opp_set_voltage(dev, new_supply_vbb, 0, vbb_reg, "vbb");
 		if (ret)
-			goto restore_freq;
+			goto restore_voltage;
 
 		ret = _opp_set_voltage(dev, new_supply_vdd, vdd_uv, vdd_reg,
 				       "vdd");
 		if (ret)
-			goto restore_freq;
+			goto restore_voltage;
 	}
 
 	return 0;
 
-restore_freq:
-	ret = clk_set_rate(clk, old_freq);
-	if (ret)
-		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_freq);
 restore_voltage:
+	/* Fetch old supplies information only if required */
+	ret = dev_pm_opp_get_supplies(old_opp, opp_data.old_supplies);
+	WARN_ON(ret);
+
 	/* This shouldn't harm even if the voltages weren't updated earlier */
 	if (old_supply_vdd->u_volt) {
 		ret = _opp_set_voltage(dev, old_supply_vbb, 0, vbb_reg, "vbb");
@@ -383,7 +377,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 	const struct ti_opp_supply_of_data *of_data;
 	int ret = 0;
 	struct dev_pm_opp_config config = {
-		.set_opp = ti_opp_supply_set_opp,
+		.config_regulators = ti_opp_config_regulators,
 	};
 
 	match = of_match_device(ti_opp_supply_of_match, dev);
-- 
2.31.1.272.g89b43f80a514

