Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6308E4FC15B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348187AbiDKPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348198AbiDKPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:46:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D7103E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bv19so8737173ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCfBJPHXx8k4ir3OUI2uyi8QPO52lWPfvV1p+DNSB0Q=;
        b=UIlxNrnv6VcwwbOIQefzk3mlWWdFKWUL3916hZfps/KAkUEKlIICiqKZkyB67+QMEb
         X9xqivPfoknTX+zYpe3kNDHqTedfXSX6Ebu6YAx6V2t1PFqhzDZqYJPt0kjPK1KkNzD3
         HgGI2ISWrMzdjzffZzucGGa4xLD2GO4TSkKo0Gq6NCajmjuTra/DvRfWKEBhn8dnuKoQ
         Nr+yyS8UkAxiz/CZKJGf69s4l0Pr+lckEQ3mj0b+dU+EvY64Yr0K3QKyRZ1thuT6A5Bt
         srx+3GYAQpNEfAsqChOkPAlynfnnmm43noHGTsq6aUJX9zcv2mPwgkSp7dmtdutYQQvQ
         Hoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCfBJPHXx8k4ir3OUI2uyi8QPO52lWPfvV1p+DNSB0Q=;
        b=Cgs6fzdXLhwUmFZNnTm3jlMexoZTP580wYQrTws4whvPFOGZfs16In6HBRdeZ6P/g+
         NClkFUEaUagbIVwprfAJk6SLwrx+sS0tlOJooL1nZnzKIcUqWTk5XRGj0JVhpIPWZKPX
         Ko/gtQ0tXjYCmLumrH/e8d9xTXPyVO8galAk7Jb7TZQXaidU9HPnwsEvY15cAdN04OBQ
         t6/aPvYYXeSHM2UlybPZYSlR5Zh4rAcQ3Mcc/aE6RV6k2F9Hv1QCcObvktfR+hjg3ajt
         2c4Z/08miGtshbXK+Q1H8Mo7wtMWV5GRhAPGXVKCEQvvH/vkLDNhdAFs2s+2wnf0Y1+B
         wDaw==
X-Gm-Message-State: AOAM533gyrPkVdeRhJAG1nZii6AuQ/mJyLePeCoxeLndwCTSXA6UPZts
        Z7aH4Sq4mPX7zx1aCdNkTfkWgQ==
X-Google-Smtp-Source: ABdhPJyYGhNKPINalNmL6ayvgX7kbAHjy2JB3wRp7G4GT9TaojwoktHJe/sfoJsMT67C5alhHgFdsA==
X-Received: by 2002:a17:907:968f:b0:6db:a3c5:ae3e with SMTP id hd15-20020a170907968f00b006dba3c5ae3emr30896744ejc.770.1649691850288;
        Mon, 11 Apr 2022 08:44:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm12173177ejj.74.2022.04.11.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:44:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v2 5/6] ufs: use PM OPP when scaling gears
Date:   Mon, 11 Apr 2022 17:43:46 +0200
Message-Id: <20220411154347.491396-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
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

Scaling gears requires not only scaling clocks, but also voltage levels,
e.g. via performance states.

Use the provided OPP table, to set proper OPP frequency which through
required-opps will trigger performance state change.  This deprecates
the old freq-table-hz Devicetree property and old clock scaling method
in favor of PM core code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c |  69 +++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c        | 115 +++++++++++++++++++++++--------
 drivers/scsi/ufs/ufshcd.h        |   4 ++
 3 files changed, 158 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index c1d8b6f46868..edba585db0c1 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -107,6 +107,69 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	return ret;
 }
 
+static int ufshcd_parse_operating_points(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	struct ufs_clk_info *clki;
+	const char *names[16];
+	bool clocks_done;
+	int cnt, i, ret;
+
+	if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
+		return 0;
+
+	cnt = of_property_count_strings(np, "clock-names");
+	if (cnt <= 0) {
+		dev_warn(dev, "%s: Missing clock-names\n",
+			 __func__);
+		return -EINVAL;
+	}
+
+	if (cnt > ARRAY_SIZE(names)) {
+		dev_info(dev, "%s: Too many clock-names\n",  __func__);
+		return -EINVAL;
+	}
+
+	/* clocks parsed by ufshcd_parse_clock_info() */
+	clocks_done = !!of_find_property(np, "freq-table-hz", NULL);
+
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_string_index(np, "clock-names", i,
+						    &names[i]);
+		if (ret)
+			return ret;
+
+		if (clocks_done)
+			continue;
+
+		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
+		if (!clki)
+			return -ENOMEM;
+
+		clki->name = devm_kstrdup(dev, names[i], GFP_KERNEL);
+		if (!clki->name)
+			return -ENOMEM;
+
+		if (!strcmp(names[i], "ref_clk"))
+			clki->keep_link_active = true;
+
+		list_add_tail(&clki->list, &hba->clk_list_head);
+	}
+
+	ret = devm_pm_opp_set_clknames(dev, names, i);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret)
+		return ret;
+
+	hba->use_pm_opp = true;
+
+	return 0;
+}
+
 #define MAX_PROP_SIZE 32
 static int ufshcd_populate_vreg(struct device *dev, const char *name,
 		struct ufs_vreg **out_vreg)
@@ -360,6 +423,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
+	err = ufshcd_parse_operating_points(hba);
+	if (err) {
+		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
+		goto dealloc_host;
+	}
+
 	ufshcd_init_lanes_per_dir(hba);
 
 	err = ufshcd_init(hba, mmio_base, irq);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5bfa62fa288a..aec7da18a550 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1022,6 +1022,9 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 	int ret = 0;
 	ktime_t start = ktime_get();
 
+	if (hba->use_pm_opp)
+		return 0;
+
 	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, PRE_CHANGE);
 	if (ret)
 		goto out;
@@ -1044,11 +1047,13 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 /**
  * ufshcd_is_devfreq_scaling_required - check if scaling is required or not
  * @hba: per adapter instance
+ * @freq: Target frequency
  * @scale_up: True if scaling up and false if scaling down
  *
  * Returns true if scaling is required, false otherwise.
  */
 static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
+					       unsigned long freq,
 					       bool scale_up)
 {
 	struct ufs_clk_info *clki;
@@ -1057,6 +1062,9 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
 	if (list_empty(head))
 		return false;
 
+	if (hba->use_pm_opp)
+		return freq != hba->clk_scaling.target_freq;
+
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
 			if (scale_up && clki->max_freq) {
@@ -1155,13 +1163,15 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 /**
  * ufshcd_scale_gear - scale up/down UFS gear
  * @hba: per adapter instance
+ * @freq: Target frequency
  * @scale_up: True for scaling up gear and false for scaling down
  *
  * Returns 0 for success,
  * Returns -EBUSY if scaling can't happen at this time
  * Returns non-zero for any other errors
  */
-static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
+static int ufshcd_scale_gear(struct ufs_hba *hba, unsigned long freq,
+			     bool scale_up)
 {
 	int ret = 0;
 	struct ufs_pa_layer_attr new_pwr_info;
@@ -1186,6 +1196,12 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
 		}
 	}
 
+	if (hba->use_pm_opp && scale_up) {
+		ret = dev_pm_opp_set_rate(hba->dev, freq);
+		if (ret)
+			return ret;
+	}
+
 	/* check if the power mode needs to be changed or not? */
 	ret = ufshcd_config_pwr_mode(hba, &new_pwr_info);
 	if (ret)
@@ -1194,6 +1210,11 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
 			hba->pwr_info.gear_tx, hba->pwr_info.gear_rx,
 			new_pwr_info.gear_tx, new_pwr_info.gear_rx);
 
+	if (ret && hba->use_pm_opp && scale_up)
+		dev_pm_opp_set_rate(hba->dev, hba->devfreq->previous_freq);
+	else if (hba->use_pm_opp && !scale_up)
+		ret = dev_pm_opp_set_rate(hba->dev, freq);
+
 	return ret;
 }
 
@@ -1236,13 +1257,15 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
 /**
  * ufshcd_devfreq_scale - scale up/down UFS clocks and gear
  * @hba: per adapter instance
+ * @freq: Target frequency
  * @scale_up: True for scaling up and false for scalin down
  *
  * Returns 0 for success,
  * Returns -EBUSY if scaling can't happen at this time
  * Returns non-zero for any other errors
  */
-static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
+static int ufshcd_devfreq_scale(struct ufs_hba *hba, unsigned long freq,
+				bool scale_up)
 {
 	int ret = 0;
 	bool is_writelock = true;
@@ -1253,7 +1276,7 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 
 	/* scale down the gear before scaling down clocks */
 	if (!scale_up) {
-		ret = ufshcd_scale_gear(hba, false);
+		ret = ufshcd_scale_gear(hba, freq, false);
 		if (ret)
 			goto out_unprepare;
 	}
@@ -1261,13 +1284,14 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 	ret = ufshcd_scale_clks(hba, scale_up);
 	if (ret) {
 		if (!scale_up)
-			ufshcd_scale_gear(hba, true);
+			ufshcd_scale_gear(hba, hba->clk_scaling.target_freq,
+					  true);
 		goto out_unprepare;
 	}
 
 	/* scale up the gear after scaling up clocks */
 	if (scale_up) {
-		ret = ufshcd_scale_gear(hba, true);
+		ret = ufshcd_scale_gear(hba, freq, true);
 		if (ret) {
 			ufshcd_scale_clks(hba, false);
 			goto out_unprepare;
@@ -1332,9 +1356,20 @@ static int ufshcd_devfreq_target(struct device *dev,
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
 
-	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
 	/* Override with the closest supported frequency */
-	*freq = (unsigned long) clk_round_rate(clki->clk, *freq);
+	if (hba->use_pm_opp) {
+		struct dev_pm_opp *opp;
+
+		opp = devfreq_recommended_opp(dev, freq, flags);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+		dev_pm_opp_put(opp);
+	} else {
+		clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info,
+					list);
+		*freq =	(unsigned long) clk_round_rate(clki->clk, *freq);
+	}
+
 	spin_lock_irqsave(hba->host->host_lock, irq_flags);
 	if (ufshcd_eh_in_progress(hba)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
@@ -1350,11 +1385,11 @@ static int ufshcd_devfreq_target(struct device *dev,
 	}
 
 	/* Decide based on the rounded-off frequency and update */
-	scale_up = (*freq == clki->max_freq) ? true : false;
-	if (!scale_up)
+	scale_up = (*freq > hba->clk_scaling.target_freq) ? true : false;
+	if (!hba->use_pm_opp && !scale_up)
 		*freq = clki->min_freq;
 	/* Update the frequency */
-	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
+	if (!ufshcd_is_devfreq_scaling_required(hba, *freq, scale_up)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 		ret = 0;
 		goto out; /* no state change required */
@@ -1362,7 +1397,9 @@ static int ufshcd_devfreq_target(struct device *dev,
 	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
 	start = ktime_get();
-	ret = ufshcd_devfreq_scale(hba, scale_up);
+	ret = ufshcd_devfreq_scale(hba, *freq, scale_up);
+	if (!ret)
+		hba->clk_scaling.target_freq = *freq;
 
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 		(scale_up ? "up" : "down"),
@@ -1382,8 +1419,6 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
 	unsigned long flags;
-	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
 	ktime_t curr_t;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
@@ -1396,13 +1431,20 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	if (!scaling->window_start_t)
 		goto start_window;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	/*
-	 * If current frequency is 0, then the ondemand governor considers
-	 * there's no initial frequency set. And it always requests to set
-	 * to max. frequency.
-	 */
-	stat->current_frequency = clki->curr_freq;
+	if (hba->use_pm_opp) {
+		stat->current_frequency = hba->clk_scaling.target_freq;
+	} else {
+		struct list_head *clk_list = &hba->clk_list_head;
+		struct ufs_clk_info *clki;
+
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		/*
+		 * If current frequency is 0, then the ondemand governor considers
+		 * there's no initial frequency set. And it always requests to set
+		 * to max. frequency.
+		 */
+		stat->current_frequency = clki->curr_freq;
+	}
 	if (scaling->is_busy_started)
 		scaling->tot_busy_t += ktime_us_delta(curr_t,
 				scaling->busy_start_t);
@@ -1435,9 +1477,11 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 	if (list_empty(clk_list))
 		return 0;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
-	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	if (!hba->use_pm_opp) {
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		dev_pm_opp_add(hba->dev, clki->min_freq, 0);
+		dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	}
 
 	ufshcd_vops_config_scaling_param(hba, &hba->vps->devfreq_profile,
 					 &hba->vps->ondemand_data);
@@ -1449,8 +1493,10 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 		ret = PTR_ERR(devfreq);
 		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
 
-		dev_pm_opp_remove(hba->dev, clki->min_freq);
-		dev_pm_opp_remove(hba->dev, clki->max_freq);
+		if (!hba->use_pm_opp) {
+			dev_pm_opp_remove(hba->dev, clki->min_freq);
+			dev_pm_opp_remove(hba->dev, clki->max_freq);
+		}
 		return ret;
 	}
 
@@ -1462,7 +1508,6 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 {
 	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
 
 	if (!hba->devfreq)
 		return;
@@ -1470,9 +1515,13 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 	devfreq_remove_device(hba->devfreq);
 	hba->devfreq = NULL;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_remove(hba->dev, clki->min_freq);
-	dev_pm_opp_remove(hba->dev, clki->max_freq);
+	if (!hba->use_pm_opp) {
+		struct ufs_clk_info *clki;
+
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		dev_pm_opp_remove(hba->dev, clki->min_freq);
+		dev_pm_opp_remove(hba->dev, clki->max_freq);
+	}
 }
 
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
@@ -1556,8 +1605,14 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 	if (value) {
 		ufshcd_resume_clkscaling(hba);
 	} else {
+		struct dev_pm_opp *opp;
+		unsigned long freq = ULONG_MAX;
+
+		opp = dev_pm_opp_find_freq_floor(dev, &freq);
+		dev_pm_opp_put(opp);
+
 		ufshcd_suspend_clkscaling(hba);
-		err = ufshcd_devfreq_scale(hba, true);
+		err = ufshcd_devfreq_scale(hba, freq, true);
 		if (err)
 			dev_err(hba->dev, "%s: failed to scale clocks up %d\n",
 					__func__, err);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1a8f7b8977e6..c224a55fd9ee 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -443,6 +443,7 @@ struct ufs_clk_scaling {
 	bool is_initialized;
 	bool is_busy_started;
 	bool is_suspended;
+	unsigned long target_freq;
 };
 
 #define UFS_EVENT_HIST_LENGTH 8
@@ -776,6 +777,8 @@ struct ufs_hba_monitor {
  * @auto_bkops_enabled: to track whether bkops is enabled in device
  * @vreg_info: UFS device voltage regulator information
  * @clk_list_head: UFS host controller clocks list node head
+ * @use_pm_opp: whether OPP table is provided and scaling gears should trigger
+ *              setting OPP
  * @pwr_info: holds current power mode
  * @max_pwr_info: keeps the device max valid pwm
  * @clk_scaling_lock: used to serialize device commands and clock scaling
@@ -892,6 +895,7 @@ struct ufs_hba {
 	bool auto_bkops_enabled;
 	struct ufs_vreg_info vreg_info;
 	struct list_head clk_list_head;
+	bool use_pm_opp;
 
 	/* Number of requests aborts */
 	int req_abort_count;
-- 
2.32.0

