Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587D4545ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbiFJIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347445AbiFJIYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:24:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272543F62CD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a10so23434681pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5m3c+9x2kGInvjdb6mc3X+Fw5QfrWswpjxX46Et57cA=;
        b=XRz/RmWb+fcBndD6KlXOk4NoYBP3hk2tGn6jai5qR7CbIdRje/Qcdx85hQv6MlaIVF
         3i2a11f6ubSXSz53UgHDMb6dXOETFJObkTSqINMxizdPb01NdOp1vTT0GwfTydwyakdZ
         7mOrXzB3vxq8DA8bG1AouUQWQsepuQMLlZvPBHg/1a8xFvUjJsWZUbSQebx2lQo5AC/O
         Z+ft4e2k/J1jR9l1aOllMC0wWozYrOjJuTbfjlRQtpe4zWt4Jpp0SLHzopCAzlwitIb0
         qMyRYUgmk9+6obHlODYZVMZWeur+qfXccgAsXfNjf9grJRutERT5208Zx209VE7Fv5la
         yscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5m3c+9x2kGInvjdb6mc3X+Fw5QfrWswpjxX46Et57cA=;
        b=yOouh0aokltjJQK0dzttNWCGMXBLm//GMGYhwC4NqLNm9NDCEjJ5MNAxn++TxAacJ1
         1QpE2glhUQe5ERQqP3imtL9J02T0YvqK7sb9UIfcYwO1j2EThZZW9LhV3jZQBYXG/wPj
         62CEZqjHFPIF2RxzAEjRcy2SkCD8jVj7D4HvHODaN6f7SlOeXTJbKqZuTbj1WMzNH3xl
         okG5hIjk6eLoMNVs2VrbOTZntF8HojJuuV4LynWbn+yeN3Tffba7DIkYS/apCAGTDCQp
         hYNhlfrPPxLv962QOe9zTcEsYmAMUOhjaVFStFeFIRv+qr0mDyppcJshDAfvR+SOUbdo
         zpVQ==
X-Gm-Message-State: AOAM53101LyWIGrxW8U8avxUu9gAzGYfzDRU8osGq/R/IycKtTPWlp9g
        JxvePrjBqZDIo6JtoHzt+KyhLA==
X-Google-Smtp-Source: ABdhPJxrhUjLXJt6TJhQLsz24mB0kkPdk58TvwaVNGd68v8yvpvaACY9Bsc8zZnuVJmmIaPLAwQHtA==
X-Received: by 2002:a17:90b:2246:b0:1e8:5531:5e61 with SMTP id hk6-20020a17090b224600b001e855315e61mr7540883pjb.86.1654849279166;
        Fri, 10 Jun 2022 01:21:19 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090302cc00b0015e8da1fb07sm18118293plk.127.2022.06.10.01.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] OPP: Allow multiple clocks for a device
Date:   Fri, 10 Jun 2022 13:50:49 +0530
Message-Id: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 165 ++++++++++++++++++++++++++++-------------
 drivers/opp/debugfs.c  |  27 ++++++-
 drivers/opp/of.c       |  67 +++++++++++++----
 drivers/opp/opp.h      |  16 ++--
 include/linux/pm_opp.h |   7 +-
 5 files changed, 208 insertions(+), 74 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6368ae2d7360..1e143bd8e589 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -177,7 +177,7 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 		return 0;
 	}
 
-	return opp->rate;
+	return opp->rates[0];
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
@@ -426,7 +426,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 /* Helpers to read keys */
 static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
 {
-	return opp->rate;
+	return opp->rates[0];
 }
 
 static unsigned long _read_level(struct dev_pm_opp *opp, int index)
@@ -766,8 +766,9 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
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
@@ -781,7 +782,7 @@ static inline int _generic_set_opp_clk_only(struct device *dev,
 	if (target) {
 		freq = *target;
 	} else if (opp) {
-		freq = opp->rate;
+		freq = opp->rates[0];
 	} else {
 		WARN_ON(1);
 		return -EINVAL;
@@ -1007,11 +1008,11 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
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
 
@@ -1041,7 +1042,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		}
 	}
 
-	ret = _generic_set_opp_clk_only(dev, opp_table, opp, clk_data);
+	ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
 	if (ret)
 		return ret;
 
@@ -1115,8 +1116,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * equivalent to a clk_set_rate()
 		 */
 		if (!_get_opp_count(opp_table)) {
-			ret = _generic_set_opp_clk_only(dev, opp_table, NULL,
-							&target_freq);
+			ret = opp_table->config_clks(dev, opp_table, NULL,
+						     &target_freq, false);
 			goto put_opp_table;
 		}
 
@@ -1237,6 +1238,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	INIT_LIST_HEAD(&opp_table->dev_list);
 	INIT_LIST_HEAD(&opp_table->lazy);
 
+	opp_table->clk = ERR_PTR(-ENODEV);
+
 	/* Mark regulator count uninitialized */
 	opp_table->regulator_count = -1;
 
@@ -1283,18 +1286,22 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
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
@@ -1399,7 +1406,7 @@ static void _opp_table_kref_release(struct kref *kref)
 
 	_of_clear_opp_table(opp_table);
 
-	/* Release clk */
+	/* Release automatically acquired single clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
@@ -1487,7 +1494,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(iter, &opp_table->opp_list, node) {
-		if (iter->rate == freq) {
+		if (iter->rates[0] == freq) {
 			opp = iter;
 			break;
 		}
@@ -1594,24 +1601,28 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
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
 	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
-
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
@@ -1648,10 +1659,11 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
  * 1: opp1 > opp2
  * -1: opp1 < opp2
  */
-int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
+int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1,
+		     struct dev_pm_opp *opp2)
 {
-	if (opp1->rate != opp2->rate)
-		return opp1->rate < opp2->rate ? -1 : 1;
+	if (opp_table->clk_count == 1 && opp1->rates[0] != opp2->rates[0])
+		return opp1->rates[0] < opp2->rates[0] ? -1 : 1;
 	if (opp1->bandwidth && opp2->bandwidth &&
 	    opp1->bandwidth[0].peak != opp2->bandwidth[0].peak)
 		return opp1->bandwidth[0].peak < opp2->bandwidth[0].peak ? -1 : 1;
@@ -1676,7 +1688,7 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 	 * loop.
 	 */
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		opp_cmp = _opp_compare_key(new_opp, opp);
+		opp_cmp = _opp_compare_key(opp_table, new_opp, opp);
 		if (opp_cmp > 0) {
 			*head = &opp->node;
 			continue;
@@ -1687,8 +1699,8 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
 
 		/* Duplicate OPPs */
 		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
-			 __func__, opp->rate, opp->supplies[0].u_volt,
-			 opp->available, new_opp->rate,
+			 __func__, opp->rates[0], opp->supplies[0].u_volt,
+			 opp->available, new_opp->rates[0],
 			 new_opp->supplies[0].u_volt, new_opp->available);
 
 		/* Should we compare voltages for all regulators here ? */
@@ -1709,7 +1721,7 @@ void _required_opps_available(struct dev_pm_opp *opp, int count)
 
 		opp->available = false;
 		pr_warn("%s: OPP not supported by required OPP %pOF (%lu)\n",
-			 __func__, opp->required_opps[i]->np, opp->rate);
+			 __func__, opp->required_opps[i]->np, opp->rates[0]);
 		return;
 	}
 }
@@ -1750,7 +1762,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	if (!_opp_supported_by_regulators(new_opp, opp_table)) {
 		new_opp->available = false;
 		dev_warn(dev, "%s: OPP not supported by regulators (%lu)\n",
-			 __func__, new_opp->rate);
+			 __func__, new_opp->rates[0]);
 	}
 
 	/* required-opps not fully initialized yet */
@@ -1796,7 +1808,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 		return -ENOMEM;
 
 	/* populate the opp table */
-	new_opp->rate = freq;
+	new_opp->rates[0] = freq;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
@@ -1991,6 +2003,17 @@ static void _opp_put_regulators(struct opp_table *opp_table)
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
@@ -2005,30 +2028,66 @@ static void _opp_put_regulators(struct opp_table *opp_table)
  * This must be called before any OPPs are initialized for the device.
  */
 static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
-			     const char * const names[], unsigned int count)
+			     const char * const names[], unsigned int count,
+			     config_clks_t config_clks)
 {
-	/* We support only one clock name for now */
-	if (count != 1)
+	struct clk *clk;
+	int ret, i;
+
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
@@ -2037,11 +2096,13 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
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
@@ -2225,9 +2286,13 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 	/* Configure clocks */
 	if (config->clk_names) {
 		ret = _opp_set_clknames(opp_table, dev, config->clk_names,
-					config->clk_count);
+					config->clk_count, config->config_clks);
 		if (ret)
 			goto err;
+	} else if (config->config_clks) {
+		/* Don't allow config callback without clocks */
+		ret = -EINVAL;
+		goto err;
 	}
 
 	/* Configure property names */
@@ -2523,7 +2588,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 
 	/* Do we have the frequency? */
 	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
-		if (tmp_opp->rate == freq) {
+		if (tmp_opp->rates[0] == freq) {
 			opp = tmp_opp;
 			break;
 		}
@@ -2594,7 +2659,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 
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
index 843923ab9d66..ea8fc9e1f7e3 100644
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
+		return 0;
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
+	if (ret)
+		return ret;
+	else if (opp_table->clk_count == 1)
 		found = true;
-	}
 
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
 
@@ -945,7 +986,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		opp_table->clock_latency_ns_max = new_opp->clock_latency_ns;
 
 	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu level:%u\n",
-		 __func__, new_opp->turbo, new_opp->rate,
+		 __func__, new_opp->turbo, new_opp->rates[0],
 		 new_opp->supplies[0].u_volt, new_opp->supplies[0].u_volt_min,
 		 new_opp->supplies[0].u_volt_max, new_opp->clock_latency_ns,
 		 new_opp->level);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 131fc7c05db8..d5e8e2bd5e9a 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -58,7 +58,7 @@ extern struct list_head opp_tables, lazy_opp_tables;
  * @suspend:	true if suspend OPP
  * @removed:	flag indicating that OPP's reference is dropped by OPP core.
  * @pstate: Device's power domain's performance state.
- * @rate:	Frequency in hertz
+ * @rates:	Frequencies in hertz
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @bandwidth:	Interconnect bandwidth values
@@ -81,7 +81,7 @@ struct dev_pm_opp {
 	bool suspend;
 	bool removed;
 	unsigned int pstate;
-	unsigned long rate;
+	unsigned long *rates;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
@@ -149,8 +149,10 @@ enum opp_table_access {
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
@@ -199,8 +201,10 @@ struct opp_table {
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
@@ -225,7 +229,7 @@ struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
-int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
+int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 3a81885e976a..74fbb7515128 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -61,10 +61,14 @@ typedef int (*config_regulators_t)(struct device *dev,
 			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
 			struct regulator **regulators, unsigned int count);
 
+typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
+			struct dev_pm_opp *opp, void *data, bool scaling_down);
+
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_names: Clk name.
- * @clk_count: Number of clocks, max 1 for now.
+ * @clk_count: Number of clocks.
+ * @config_clks: Custom set clk helper.
  * @prop_name: Name to postfix to properties.
  * @config_regulators: Custom set regulator helper.
  * @supported_hw: Array of hierarchy of versions to match.
@@ -80,6 +84,7 @@ typedef int (*config_regulators_t)(struct device *dev,
 struct dev_pm_opp_config {
 	const char * const *clk_names;
 	unsigned int clk_count;
+	config_clks_t config_clks;
 	const char *prop_name;
 	config_regulators_t config_regulators;
 	unsigned int *supported_hw;
-- 
2.31.1.272.g89b43f80a514

