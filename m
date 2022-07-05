Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F195663B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiGEHBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiGEHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44EDE0DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o18so9439505pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6+JJZXhhPuFkMBdsLtq/Gd28qJ1KvFHHo+xW7UL/pE=;
        b=fJWtP+Gb0KAwGZ8QJi3fBlrZdMsHtTb7U/NLDNMK8276nYtvNnspd4m/4ygjyv0AI5
         o/SBcilZ4WAVwhFKYW6n7wdOKHiTYcg3n+O2z86GdntXFo5rOEn+db+NHnv2hX8v6tNX
         GbU7nQqWetPskxKbzG+JCa4x5wEu0MLgBWGNinA8g0uqKu/UKRwgWZjUOX+2Tt/vkVnb
         v5Ee8jubU8pZTeqNPGt/SP7Z04+wMZ+BqNUmf/6mqbWVJOkZJPt7jw1kSJ1Xsgy9Agp2
         ugR4pm99xkNitu6vWQmez6GdBWfukfstDrzc62Nzijx2BNp+pP6g/GjIImVkHuGKrevo
         WgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6+JJZXhhPuFkMBdsLtq/Gd28qJ1KvFHHo+xW7UL/pE=;
        b=kZE3A2D5qZH5c5mb2Bp+syUQooj2ccLNR8vWlBQVBTQqELUCRO4t6GwT1IVAr66Kfl
         zpcdLfX6a9BJkJD/+84Ec2Hsec+QEmrAPRe06yRBTfJn/z2e1wSUkv9JMBy4g8EE0Iks
         zdy0fzYP2CUAGJez1PEYBitQNEbpwpp3sBdz3RH523qpe55I4G8wpw1ZdG4CtaprPRpS
         f8W08444NLMd9TnD/xF0nAA40ZhLcuRFGaMAUc+EY0YUoEewdi2uUxeGmL9RJgKsO8b8
         mYkjaEn9d/rQ/D+7OeowWfRFPcqFr75t+ZuR8RvUX3G4ZjFDryyH4F2YFF4ul+5wcB98
         piIQ==
X-Gm-Message-State: AJIora/2pAOGg87dDQBYUgaAcNtzqGt1g8GYSjCDsW13Y1WGxJFeA7G8
        yzi3ADEezQaDtSM+IbPm1LR91w==
X-Google-Smtp-Source: AGRyM1vmNyHgdPC1CpHsANhXfrNQHxiQlP08/kjyI7FuwiSjUC30Emh3+mTxWv3m8+K+7BjzI2VyKQ==
X-Received: by 2002:a63:7d58:0:b0:40c:995f:2b3d with SMTP id m24-20020a637d58000000b0040c995f2b3dmr27753939pgn.601.1657004449100;
        Tue, 05 Jul 2022 00:00:49 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 84-20020a621757000000b00524e8e48156sm22776472pfx.142.2022.07.05.00.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/13] OPP: Allow multiple clocks for a device
Date:   Tue,  5 Jul 2022 12:30:09 +0530
Message-Id: <f5ca8206c8f9359d052c3fb21fa1012c36ed13e3.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

This patch adds support to allow multiple clocks for a device.

The design is pretty much similar to how this is done for regulators,
and platforms can supply their own version of the config_clks() callback
if they have multiple clocks for their device. The core manages the
calls via opp_table->config_clks() eventually.

We have kept both "clk" and "clks" fields in the OPP table structure and
the reason is provided as a comment in _opp_set_clknames(). The same
isn't done for "rates" though and we use rates[0] at most of the places
now.

Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 199 +++++++++++++++++++++++++++++------------
 drivers/opp/debugfs.c  |  27 +++++-
 drivers/opp/of.c       |  69 +++++++++++---
 drivers/opp/opp.h      |  16 ++--
 include/linux/pm_opp.h |   7 +-
 5 files changed, 235 insertions(+), 83 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index daabc810a1f9..003cd48123d7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -181,7 +181,7 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 		return 0;
 	}
 
-	return opp->rate;
+	return opp->rates[0];
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
@@ -430,7 +430,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 /* Helpers to read keys */
 static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
 {
-	return opp->rate;
+	return opp->rates[0];
 }
 
 static unsigned long _read_level(struct dev_pm_opp *opp, int index)
@@ -784,22 +784,19 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
-static inline int _generic_set_opp_clk_only(struct device *dev,
-		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data)
+static int
+_opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
+		       struct dev_pm_opp *opp, void *data, bool scaling_down)
 {
 	unsigned long *target = data;
 	unsigned long freq;
 	int ret;
 
-	/* We may reach here for devices which don't change frequency */
-	if (IS_ERR(opp_table->clk))
-		return 0;
-
 	/* One of target and opp must be available */
 	if (target) {
 		freq = *target;
 	} else if (opp) {
-		freq = opp->rate;
+		freq = opp->rates[0];
 	} else {
 		WARN_ON(1);
 		return -EINVAL;
@@ -1025,11 +1022,11 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	dev_dbg(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",
-		__func__, old_opp->rate, opp->rate, old_opp->level, opp->level,
-		old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
+		__func__, old_opp->rates[0], opp->rates[0], old_opp->level,
+		opp->level, old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
 		opp->bandwidth ? opp->bandwidth[0].peak : 0);
 
-	scaling_down = _opp_compare_key(old_opp, opp);
+	scaling_down = _opp_compare_key(opp_table, old_opp, opp);
 	if (scaling_down == -1)
 		scaling_down = 0;
 
@@ -1059,9 +1056,11 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		}
 	}
 
-	ret = _generic_set_opp_clk_only(dev, opp_table, opp, clk_data);
-	if (ret)
-		return ret;
+	if (opp_table->config_clks) {
+		ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
+		if (ret)
+			return ret;
+	}
 
 	/* Scaling down? Configure required OPPs after frequency */
 	if (scaling_down) {
@@ -1133,8 +1132,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = _generic_set_opp_clk_only(dev, opp_table, NULL,
-							&target_freq);
+			ret = opp_table->config_clks(dev, opp_table, NULL,
+						     &target_freq, false);
 			goto put_opp_table;
 		}
 
@@ -1255,6 +1254,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	INIT_LIST_HEAD(&opp_table->dev_list);
 	INIT_LIST_HEAD(&opp_table->lazy);
 
+	opp_table->clk = ERR_PTR(-ENODEV);
+
 	/* Mark regulator count uninitialized */
 	opp_table->regulator_count = -1;
 
@@ -1301,18 +1302,22 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	int ret;
 
 	/*
-	 * Return early if we don't need to get clk or we have already tried it
+	 * Return early if we don't need to get clk or we have already done it
 	 * earlier.
 	 */
-	if (!getclk || IS_ERR(opp_table) || opp_table->clk)
+	if (!getclk || IS_ERR(opp_table) || !IS_ERR(opp_table->clk) ||
+	    opp_table->clks)
 		return opp_table;
 
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, NULL);
 
 	ret = PTR_ERR_OR_ZERO(opp_table->clk);
-	if (!ret)
+	if (!ret) {
+		opp_table->config_clks = _opp_config_clk_single;
+		opp_table->clk_count = 1;
 		return opp_table;
+	}
 
 	if (ret == -ENOENT) {
 		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
@@ -1417,7 +1422,7 @@ static void _opp_table_kref_release(struct kref *kref)
 
 	_of_clear_opp_table(opp_table);
 
-	/* Release clk */
+	/* Release automatically acquired single clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
@@ -1505,7 +1510,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(iter, &opp_table->opp_list, node) {
-		if (iter->rate == freq) {
+		if (iter->rates[0] == freq) {
 			opp = iter;
 			break;
 		}
@@ -1612,24 +1617,28 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
-	int supply_count, supply_size, icc_size;
+	int supply_count, supply_size, icc_size, clk_size;
 
 	/* Allocate space for at least one supply */
 	supply_count = opp_table->regulator_count > 0 ?
 			opp_table->regulator_count : 1;
 	supply_size = sizeof(*opp->supplies) * supply_count;
+	clk_size = sizeof(*opp->rates) * opp_table->clk_count;
 	icc_size = sizeof(*opp->bandwidth) * opp_table->path_count;
 
 	/* allocate new OPP node and supplies structures */
-	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
-
+	opp = kzalloc(sizeof(*opp) + supply_size + clk_size + icc_size, GFP_KERNEL);
 	if (!opp)
 		return NULL;
 
-	/* Put the supplies at the end of the OPP structure as an empty array */
+	/* Put the supplies, bw and clock at the end of the OPP structure */
 	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
+
+	opp->rates = (unsigned long *)(opp->supplies + supply_count);
+
 	if (icc_size)
-		opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
+		opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->rates + opp_table->clk_count);
+
 	INIT_LIST_HEAD(&opp->node);
 
 	return opp;
@@ -1660,21 +1669,43 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+static int _opp_compare_rate(struct opp_table *opp_table,
+			     struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
+{
+	int i;
+
+	for (i = 0; i < opp_table->clk_count; i++) {
+		if (opp1->rates[i] != opp2->rates[i])
+			return opp1->rates[i] < opp2->rates[i] ? -1 : 1;
+	}
+
+	/* Same rates for both OPPs */
+	return 0;
+}
+
 /*
  * Returns
  * 0: opp1 == opp2
  * 1: opp1 > opp2
  * -1: opp1 < opp2
  */
-int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
+int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1,
+		     struct dev_pm_opp *opp2)
 {
-	if (opp1->rate != opp2->rate)
-		return opp1->rate < opp2->rate ? -1 : 1;
+	int ret;
+
+	ret = _opp_compare_rate(opp_table, opp1, opp2);
+	if (ret)
+		return ret;
+
 	if (opp1->bandwidth && opp2->bandwidth &&
 	    opp1->bandwidth[0].peak != opp2->bandwidth[0].peak)
 		return opp1->bandwidth[0].peak < opp2->bandwidth[0].peak ? -1 : 1;
+
 	if (opp1->level != opp2->level)
 		return opp1->level < opp2->level ? -1 : 1;
+
+	/* Duplicate OPPs */
 	return 0;
 }
 
@@ -1694,7 +1725,7 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop.
 	 */
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		opp_cmp = _opp_compare_key(new_opp, opp);
+		opp_cmp = _opp_compare_key(opp_table, new_opp, opp);
 		if (opp_cmp > 0) {
 			*head = &opp->node;
 			continue;
@@ -1705,8 +1736,8 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 
 		/* Duplicate OPPs */
 		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
-			 __func__, opp->rate, opp->supplies[0].u_volt,
-			 opp->available, new_opp->rate,
+			 __func__, opp->rates[0], opp->supplies[0].u_volt,
+			 opp->available, new_opp->rates[0],
 			 new_opp->supplies[0].u_volt, new_opp->available);
 
 		/* Should we compare voltages for all regulators here ? */
@@ -1727,7 +1758,7 @@ void _required_opps_available(struct dev_pm_opp *opp, int count)
 
 		opp->available = false;
 		pr_warn("%s: OPP not supported by required OPP %pOF (%lu)\n",
-			 __func__, opp->required_opps[i]->np, opp->rate);
+			 __func__, opp->required_opps[i]->np, opp->rates[0]);
 		return;
 	}
 }
@@ -1768,7 +1799,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	if (!_opp_supported_by_regulators(new_opp, opp_table)) {
 		new_opp->available = false;
 		dev_warn(dev, "%s: OPP not supported by regulators (%lu)\n",
-			 __func__, new_opp->rate);
+			 __func__, new_opp->rates[0]);
 	}
 
 	/* required-opps not fully initialized yet */
@@ -1814,7 +1845,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 		return -ENOMEM;
 
 	/* populate the opp table */
-	new_opp->rate = freq;
+	new_opp->rates[0] = freq;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
@@ -2017,6 +2048,17 @@ static void _opp_put_regulators(struct opp_table *opp_table)
 	opp_table->regulator_count = -1;
 }
 
+static void _put_clks(struct opp_table *opp_table, int count)
+{
+	int i;
+
+	for (i = count - 1; i >= 0; i--)
+		clk_put(opp_table->clks[i]);
+
+	kfree(opp_table->clks);
+	opp_table->clks = NULL;
+}
+
 /**
  * _opp_set_clknames() - Set clk names for the device
  * @dev: Device for which clk names is being set.
@@ -2031,10 +2073,12 @@ static void _opp_put_regulators(struct opp_table *opp_table)
  * This must be called before any OPPs are initialized for the device.
  */
 static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
-			     const char * const names[])
+			     const char * const names[],
+			     config_clks_t config_clks)
 {
 	const char * const *temp = names;
-	int count = 0;
+	int count = 0, ret, i;
+	struct clk *clk;
 
 	/* Count number of clks */
 	while (*temp++)
@@ -2047,28 +2091,60 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 	if (!count && !names[1])
 		count = 1;
 
-	/* We support only one clock name for now */
-	if (count != 1)
+	/* Fail early for invalid configurations */
+	if (!count || (config_clks && count == 1) || (!config_clks && count > 1))
 		return -EINVAL;
 
 	/* Another CPU that shares the OPP table has set the clkname ? */
-	if (opp_table->clk_configured)
+	if (opp_table->clks)
 		return 0;
 
-	/* clk shouldn't be initialized at this point */
-	if (WARN_ON(opp_table->clk))
-		return -EBUSY;
+	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
+					GFP_KERNEL);
+	if (!opp_table->clks)
+		return -ENOMEM;
 
-	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, names[0]);
-	if (IS_ERR(opp_table->clk)) {
-		return dev_err_probe(dev, PTR_ERR(opp_table->clk),
-				    "%s: Couldn't find clock\n", __func__);
+	/* Find clks for the device */
+	for (i = 0; i < count; i++) {
+		clk = clk_get(dev, names[i]);
+		if (IS_ERR(clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(clk),
+					    "%s: Couldn't find clock with name: %s\n",
+					    __func__, names[i]);
+			goto free_clks;
+		}
+
+		opp_table->clks[i] = clk;
 	}
 
-	opp_table->clk_configured = true;
+	opp_table->clk_count = count;
+
+	/* Set generic single clk set here */
+	if (count == 1) {
+		opp_table->config_clks = _opp_config_clk_single;
+
+		/*
+		 * We could have just dropped the "clk" field and used "clks"
+		 * everywhere. Instead we kept the "clk" field around for
+		 * following reasons:
+		 *
+		 * - avoiding clks[0] everywhere else.
+		 * - not running single clk helpers for multiple clk usecase by
+		 *   mistake.
+		 *
+		 * Since this is single-clk case, just update the clk pointer
+		 * too.
+		 */
+		opp_table->clk = opp_table->clks[0];
+	} else {
+		opp_table->config_clks = config_clks;
+	}
 
 	return 0;
+
+free_clks:
+	_put_clks(opp_table, i);
+	return ret;
 }
 
 /**
@@ -2077,11 +2153,13 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
  */
 static void _opp_put_clknames(struct opp_table *opp_table)
 {
-	if (opp_table->clk_configured) {
-		clk_put(opp_table->clk);
-		opp_table->clk = ERR_PTR(-EINVAL);
-		opp_table->clk_configured = false;
-	}
+	if (!opp_table->clks)
+		return;
+
+	opp_table->config_clks = NULL;
+	opp_table->clk = ERR_PTR(-ENODEV);
+
+	_put_clks(opp_table, opp_table->clk_count);
 }
 
 /**
@@ -2298,11 +2376,16 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure clocks */
 	if (config->clk_names) {
-		ret = _opp_set_clknames(opp_table, dev, config->clk_names);
+		ret = _opp_set_clknames(opp_table, dev, config->clk_names,
+					config->config_clks);
 		if (ret)
 			goto err;
 
 		data->flags |= OPP_CONFIG_CLK;
+	} else if (config->config_clks) {
+		/* Don't allow config callback without clocks */
+		ret = -EINVAL;
+		goto err;
 	}
 
 	/* Configure property names */
@@ -2614,7 +2697,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
-		if (tmp_opp->rate == freq) {
+		if (tmp_opp->rates[0] == freq) {
 			opp = tmp_opp;
 			break;
 		}
@@ -2685,7 +2768,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
-		if (tmp_opp->rate == freq) {
+		if (tmp_opp->rates[0] == freq) {
 			opp = tmp_opp;
 			break;
 		}
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 1b6e5c55c3ed..402c507edac7 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -74,6 +74,24 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
 	}
 }
 
+static void opp_debug_create_clks(struct dev_pm_opp *opp,
+				  struct opp_table *opp_table,
+				  struct dentry *pdentry)
+{
+	char name[12];
+	int i;
+
+	if (opp_table->clk_count == 1) {
+		debugfs_create_ulong("rate_hz", S_IRUGO, pdentry, &opp->rates[0]);
+		return;
+	}
+
+	for (i = 0; i < opp_table->clk_count; i++) {
+		snprintf(name, sizeof(name), "rate_hz_%d", i);
+		debugfs_create_ulong(name, S_IRUGO, pdentry, &opp->rates[i]);
+	}
+}
+
 static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct opp_table *opp_table,
 				      struct dentry *pdentry)
@@ -117,10 +135,11 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	 * Get directory name for OPP.
 	 *
 	 * - Normally rate is unique to each OPP, use it to get unique opp-name.
-	 * - For some devices rate isn't available, use index instead.
+	 * - For some devices rate isn't available or there are multiple, use
+	 *   index instead for them.
 	 */
-	if (likely(opp->rate))
-		id = opp->rate;
+	if (likely(opp_table->clk_count == 1))
+		id = opp->rates[0];
 	else
 		id = _get_opp_count(opp_table);
 
@@ -134,7 +153,6 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo);
 	debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
 	debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
-	debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
 	debugfs_create_u32("level", S_IRUGO, d, &opp->level);
 	debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
 			     &opp->clock_latency_ns);
@@ -142,6 +160,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	opp->of_name = of_node_full_name(opp->np);
 	debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
 
+	opp_debug_create_clks(opp, opp_table, d);
 	opp_debug_create_supplies(opp, opp_table, d);
 	opp_debug_create_bw(opp, opp_table, d);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index bb49057cb1fc..080481a05223 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -767,6 +767,53 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_rate(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
+		      struct device_node *np)
+{
+	struct property *prop;
+	int i, count, ret;
+	u64 *rates;
+
+	if (!opp_table->clk_count)
+		return -ENODEV;
+
+	prop = of_find_property(np, "opp-hz", NULL);
+	if (!prop)
+		return -ENODEV;
+
+	count = prop->length / sizeof(u64);
+	if (opp_table->clk_count != count) {
+		pr_err("%s: Count mismatch between opp-hz and clk_count (%d %d)\n",
+		       __func__, count, opp_table->clk_count);
+		return -EINVAL;
+	}
+
+	rates = kmalloc_array(count, sizeof(*rates), GFP_KERNEL);
+	if (!rates)
+		return -ENOMEM;
+
+	ret = of_property_read_u64_array(np, "opp-hz", rates, count);
+	if (ret) {
+		pr_err("%s: Error parsing opp-hz: %d\n", __func__, ret);
+	} else {
+		/*
+		 * Rate is defined as an unsigned long in clk API, and so
+		 * casting explicitly to its type. Must be fixed once rate is 64
+		 * bit guaranteed in clk API.
+		 */
+		for (i = 0; i < count; i++) {
+			new_opp->rates[i] = (unsigned long)rates[i];
+
+			/* This will happen for frequencies > 4.29 GHz */
+			WARN_ON(new_opp->rates[i] != rates[i]);
+		}
+	}
+
+	kfree(rates);
+
+	return ret;
+}
+
 static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
 		    struct device_node *np, bool peak)
 {
@@ -812,19 +859,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp,
 			 struct opp_table *opp_table, struct device_node *np)
 {
 	bool found = false;
-	u64 rate;
 	int ret;
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
-	if (!ret) {
-		/*
-		 * Rate is defined as an unsigned long in clk API, and so
-		 * casting explicitly to its type. Must be fixed once rate is 64
-		 * bit guaranteed in clk API.
-		 */
-		new_opp->rate = (unsigned long)rate;
+	ret = _read_rate(new_opp, opp_table, np);
+	if (!ret)
 		found = true;
-	}
+	else if (ret != -ENODEV)
+		return ret;
 
 	/*
 	 * Bandwidth consists of peak and average (optional) values:
@@ -893,8 +934,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
-		dev_dbg(dev, "OPP not supported by hardware: %lu\n",
-			new_opp->rate);
+		dev_dbg(dev, "OPP not supported by hardware: %s\n",
+			of_node_full_name(np));
 		goto free_opp;
 	}
 
@@ -930,7 +971,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (opp_table->suspend_opp) {
 			/* Pick the OPP with higher rate/bw/level as suspend OPP */
-			if (_opp_compare_key(new_opp, opp_table->suspend_opp) == 1) {
+			if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
 				opp_table->suspend_opp->suspend = false;
 				new_opp->suspend = true;
 				opp_table->suspend_opp = new_opp;
@@ -945,7 +986,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		opp_table->clock_latency_ns_max = new_opp->clock_latency_ns;
 
 	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu level:%u\n",
-		 __func__, new_opp->turbo, new_opp->rate,
+		 __func__, new_opp->turbo, new_opp->rates[0],
 		 new_opp->supplies[0].u_volt, new_opp->supplies[0].u_volt_min,
 		 new_opp->supplies[0].u_volt_max, new_opp->clock_latency_ns,
 		 new_opp->level);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e481bdb59499..816009eaafee 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -79,7 +79,7 @@ struct opp_config_data {
  * @suspend:	true if suspend OPP
  * @removed:	flag indicating that OPP's reference is dropped by OPP core.
  * @pstate: Device's power domain's performance state.
- * @rate:	Frequency in hertz
+ * @rates:	Frequencies in hertz
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @bandwidth:	Interconnect bandwidth values
@@ -102,7 +102,7 @@ struct dev_pm_opp {
 	bool suspend;
 	bool removed;
 	unsigned int pstate;
-	unsigned long rate;
+	unsigned long *rates;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
@@ -170,8 +170,10 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
- * @clk_configured: Clock name is configured by the platform.
- * @clk: Device's clock handle
+ * @config_clks: Platform specific config_clks() callback.
+ * @clks: Device's clock handles, for multiple clocks.
+ * @clk: Device's clock handle, for single clock.
+ * @clk_count: Number of clocks.
  * @config_regulators: Platform specific config_regulators() callback.
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
@@ -220,8 +222,10 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
-	bool clk_configured;
+	config_clks_t config_clks;
+	struct clk **clks;
 	struct clk *clk;
+	int clk_count;
 	config_regulators_t config_regulators;
 	struct regulator **regulators;
 	int regulator_count;
@@ -246,7 +250,7 @@ struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
-int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
+int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 50cbc75bef71..104151dfe46c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -61,9 +61,13 @@ typedef int (*config_regulators_t)(struct device *dev,
 			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
 			struct regulator **regulators, unsigned int count);
 
+typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
+			struct dev_pm_opp *opp, void *data, bool scaling_down);
+
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
- * @clk_names: Clk names, NULL terminated array, max 1 clock for now.
+ * @clk_names: Clk names, NULL terminated array.
+ * @config_clks: Custom set clk helper.
  * @prop_name: Name to postfix to properties.
  * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
@@ -78,6 +82,7 @@ typedef int (*config_regulators_t)(struct device *dev,
 struct dev_pm_opp_config {
 	/* NULL terminated */
 	const char * const *clk_names;
+	config_clks_t config_clks;
 	const char *prop_name;
 	config_regulators_t config_regulators;
 	const unsigned int *supported_hw;
-- 
2.31.1.272.g89b43f80a514

