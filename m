Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B071538E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbiEaKKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbiEaKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:10:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1A9A990
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:10:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s12so37909plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=841lChJS+wM9jNwwGNIhEP39YB5JqkFPrtXZuFk54ZE=;
        b=wsVUZDBwbwJUD2AB5HlQVmhzbHK1IExWV+c19cH6hRQ4ggbGuqoH+/SviPapk+UlP+
         GovfI79gVH10UBXFXfmTlzsthLjkOA1835nlQttp3GoFkWxIC4661qZxSOfIiheO8Jyw
         aJF9fFoEdU6QbLPEmfh0HxVzDsBEKdgLMoInHDuIZQ9QyYsYfdgF3Dpoaa7WeI4bOvdm
         pqaXYir/RYh5smiEISje8EncY1SXUyW4g40HmCOsALNm9ET1E9roOEzH3Y2qIIJuU3uC
         XESf+PGPGVZ454UhBrQzSmVQ84pdaWc8BChcLIAO5vQznh4ONZ1jsw3BIP5Wsn8Bpf1T
         o5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=841lChJS+wM9jNwwGNIhEP39YB5JqkFPrtXZuFk54ZE=;
        b=AFCeI6uRNQBBBTDW++stmaMNZ+gYYyEwtDzjg1BSId4O+sADSC3TciDGJxNAj8pxc6
         TQ+e7Zn76aPRRkwj7HuDAJTMfG3UqwDQcr5JJnONS5c+gWomIELpuQVLmgSUCBSrBjyG
         rY6xOhBnHgFaJvMv6ZuFKx+dNQBEVKbVKnJrQFk6rvlaY43h1s0AISsLNAPMg2j84/76
         wvDiSeY+4QkMdZizWPHM3xvtshratzw1RYe/YrggG69AYBk3Sm1hYTYEveTFhH1HipSI
         5lKP7meEdAsYGURZrkCSeVF35teozMC0flTcQsPxfSQKWDDxhKyCfwrIIqTP1kzovBsB
         YRBA==
X-Gm-Message-State: AOAM53054WvO63FqmiX9G6WO/f2cTVd8Cj50GkorPFIguEThfP3PNy3E
        /nKLKPkwNtdGMHtNsiDdrIV9+A==
X-Google-Smtp-Source: ABdhPJyykrDTXjJH194BNbajlW0qZVaKHHLjVigQyygVAMr38BqXMuyG1t704aSR+1M4CfeL+rYRSg==
X-Received: by 2002:a17:90b:33cd:b0:1e2:a03c:a4b1 with SMTP id lk13-20020a17090b33cd00b001e2a03ca4b1mr17806391pjb.49.1653991828146;
        Tue, 31 May 2022 03:10:28 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a150700b001e2f3831102sm1509234pja.17.2022.05.31.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:10:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] OPP: ti: Migrate to config_regulators()
Date:   Tue, 31 May 2022 15:40:03 +0530
Message-Id: <cc940c53d64bc78198ad6ea94f177846a7b452b0.1653991004.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653991004.git.viresh.kumar@linaro.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
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
index a30825dc30cf..2aeb084fc379 100644
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
+static int ti_opp_config_regulators(struct device *dev, struct dev_pm_opp *old_opp,
+				    struct dev_pm_opp *new_opp, struct regulator **regulators,
+				    unsigned int count)
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

