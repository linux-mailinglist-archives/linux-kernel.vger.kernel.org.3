Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092656548C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiGDMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiGDMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E3120A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:09:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3179329pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY7WoCXtSxpDy49aZW3k9T/g6ZT/rb96KiKQJSdQeqs=;
        b=Qou5WpDZpxl7rh70fpR5vaceWx1f44DRsmgNblwCkLosOCUFC5rJdXyWRnD7mCEkqo
         rwQ+Xm469DOA0nENgIUYLdYJWpwtNXudatw4pVA6PmR7+zUDbrhZhEoFa1hms+9I2agy
         EuEspsyljgBkSm4DprgxS3QKY9il+4iupz/IqVu32cf83bQNd+Ewe1b+sNdMWIkPNTdg
         dCBpy0WCdAYDBGiMtuGvQ4DyHgIA33DHPg2HRtcp8VfT3wcc9z5QONG8b76CwGAkcrsG
         Ah4vnrVLcKP8J+xSZR3Ged1Kv+yZnX3DfaS+XaHJrKTsKhnHnYTsPgIswtj0VkQlczRc
         E3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY7WoCXtSxpDy49aZW3k9T/g6ZT/rb96KiKQJSdQeqs=;
        b=gmg4jcQ2Pl3FIo2Q5R+m72MM2Ij3dgN+yEzqRZ2otosJGEU5xiG63ortcTLPQvUIeI
         cbHH6wc25GDLvgWNaCgPrMLBJeeqqeVh125803sRIJnWyyfwge/YijKt4fCYSlsaKDFS
         IyzAOlfpZq4682c7yZvpcyEanKZ6PhgPKTyZjHFevjvQVH50dLJzAaR7qySQ1yB6vguu
         DXMFNpLw/K4XTqKuVdJts6yl7LEOkfATkMtpfC1RlkgKyJ1GSHPyMZ9ruO/oq3SWcbVh
         Wwz23AJzSoSUPAJTxVKQNLekg3doQRY4/d7yUU36Z3+7imNV44xkRHm5YK3cyASzWHxq
         0oJg==
X-Gm-Message-State: AJIora/vNfGnjonKU14BWwJXV1Rdnofzdb2N8M7XE7+RxRIIW4gTpoBT
        qto8EizUIiuVY4zNr38lbZWWfw==
X-Google-Smtp-Source: AGRyM1tbKd+RU3HYy4fxirhcWCGYNcGovRRk2UPexyrZl0y0paEeuQR1A7LgjSyBs66/c/0OjDGsCw==
X-Received: by 2002:a17:90a:e7c1:b0:1ed:3b8c:7ced with SMTP id kb1-20020a17090ae7c100b001ed3b8c7cedmr37572078pjb.77.1656936545444;
        Mon, 04 Jul 2022 05:09:05 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d17-20020a656b91000000b003c25dfd7372sm19941570pgw.26.2022.07.04.05.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:09:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 19/20] OPP: ti: Migrate to dev_pm_opp_set_config_regulators()
Date:   Mon,  4 Jul 2022 17:37:57 +0530
Message-Id: <9f7e72d6329095dcd2561a12e91b91b1851f5b7d.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core now provides dev_pm_opp_set_config_regulators() interface,
which needs the platforms to just set the OPP voltages instead of both
clk and voltage.  The clock is set by the OPP core instead and hence
reduces code redundancy.

Migrate the only user of the custom set_opp() to
dev_pm_opp_set_config_regulators().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/ti-opp-supply.c | 75 +++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 40ebc9ac82dd..8f3f13fbbb25 100644
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
@@ -405,8 +399,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = dev_pm_opp_register_set_opp_helper(cpu_dev,
-						 ti_opp_supply_set_opp);
+	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
 	if (ret < 0)
 		_free_optimized_voltages(dev, &opp_data);
 
-- 
2.31.1.272.g89b43f80a514

