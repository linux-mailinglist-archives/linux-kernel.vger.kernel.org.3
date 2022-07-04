Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5431E565478
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiGDMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiGDMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3790218A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c13so4659441pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gC67fAeym71rEkFE9k+oqzY1p3FNiw9zFdZR8va6dpY=;
        b=Pml5WBPxzc1XEVvLTl/1ecRTpGQ07MA7iG8JyddspRVnPUQwLWFmlJQftSxz63Yxza
         K/GZWSVVmo2hxQsLGAap3J5G/2M4hNoblfZzpKMNGBodMzTorddM7t170hRgv1w4lmtg
         S2jdLbuWRGg/F5wsQMSdJM24vBhopvX9UNO40jOdGxaYYPSDEJJ5U/myb/5tbHsidLX9
         e7+vnKrVOLwGubQi+FJLwBxPtvWwoEv2MMT0SRw3NRtnPitqQ5rFabe3y+qSVe/lCf/G
         lUjN5UKK5YebywPhB9hnEYQWwHqeuChDYfkYR0Yc56F3Yw3rGbqdjBhh0mGyzY+orwut
         HFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gC67fAeym71rEkFE9k+oqzY1p3FNiw9zFdZR8va6dpY=;
        b=endBQmxj0fFYMjCnsFKV1AWMMJTBrAZ41r0v26ntpq3b77JHh6CfSO27ncPcyfPFSz
         u+oQjHh+0I/SmvySHjMgu1+PakY45OsY4R2fDmSewYMqCO0ty0295RkqzlC50sgYQepy
         JKvlMyA8uVQogtg9p5GfMLiNtPQ2G/XC8i0p31gixEDxjxKiricEak86uzpdiftcl6tF
         1mE392Ae1dHenc5U3GpkVdPsgRYKuui9Y9qXY4sphjMHCvrrMXnCZzW//ZaKisrukJqX
         FAFUflUrgHnhCo5nxpvrBFqtJVeRDaZIcnmIarKfSL95oKDCUI6B9f+rz7y8JNkOmHwY
         8ylA==
X-Gm-Message-State: AJIora/Vo3B7Z6T2LerhEBigxfgFd3PnzfALeF8/OisMWYJ24B59kxbZ
        3BHfGMNM9YZObwve1+Bqequ4Qw==
X-Google-Smtp-Source: AGRyM1s+vQ3aYmJZ6251w1IjsHZYQ2vqP9sfRwH11QyT+Pb7osqxW45+tzLdW7RxYOIhMU62h93xoA==
X-Received: by 2002:a17:90b:17cb:b0:1ec:9d52:46f7 with SMTP id me11-20020a17090b17cb00b001ec9d5246f7mr34220040pjb.221.1656936519213;
        Mon, 04 Jul 2022 05:08:39 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902768b00b001637997d0d4sm20922989pll.206.2022.07.04.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V3 10/20] OPP: Migrate set-regulators API to use set-config helpers
Date:   Mon,  4 Jul 2022 17:37:48 +0530
Message-Id: <57b3f53e71550be92e28f4e2fa619f93bb5f3d78.1656935522.git.viresh.kumar@linaro.org>
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

Now that we have a central API to handle all OPP table configurations,
migrate the set-regulators family of helpers to use the new
infrastructure.

The return type and parameter to the APIs change a bit due to this,
update the current users as well in the same commit in order to avoid
breaking builds.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 12 ++---
 drivers/devfreq/exynos-bus.c | 19 +++-----
 drivers/opp/core.c           | 91 ++++++++----------------------------
 include/linux/pm_opp.h       | 44 ++++++++++-------
 4 files changed, 60 insertions(+), 106 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index be0c19b3ffa5..d69d13a26414 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -29,9 +29,9 @@ struct private_data {
 
 	cpumask_var_t cpus;
 	struct device *cpu_dev;
-	struct opp_table *opp_table;
 	struct cpufreq_frequency_table *freq_table;
 	bool have_static_opps;
+	int opp_token;
 };
 
 static LIST_HEAD(priv_list);
@@ -220,9 +220,9 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	 */
 	reg_name[0] = find_supply_name(cpu_dev);
 	if (reg_name[0]) {
-		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, reg_name);
-		if (IS_ERR(priv->opp_table)) {
-			ret = PTR_ERR(priv->opp_table);
+		priv->opp_token = dev_pm_opp_set_regulators(cpu_dev, reg_name);
+		if (priv->opp_token < 0) {
+			ret = priv->opp_token;
 			if (ret != -EPROBE_DEFER)
 				dev_err(cpu_dev, "failed to set regulators: %d\n",
 					ret);
@@ -294,7 +294,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 out:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-	dev_pm_opp_put_regulators(priv->opp_table);
+	dev_pm_opp_put_regulators(priv->opp_token);
 free_cpumask:
 	free_cpumask_var(priv->cpus);
 	return ret;
@@ -308,7 +308,7 @@ static void dt_cpufreq_release(void)
 		dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
 		if (priv->have_static_opps)
 			dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-		dev_pm_opp_put_regulators(priv->opp_table);
+		dev_pm_opp_put_regulators(priv->opp_token);
 		free_cpumask_var(priv->cpus);
 		list_del(&priv->node);
 	}
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 541baff93ee8..d1235242367f 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -33,7 +33,7 @@ struct exynos_bus {
 
 	unsigned long curr_freq;
 
-	struct opp_table *opp_table;
+	int opp_token;
 	struct clk *clk;
 	unsigned int ratio;
 };
@@ -161,8 +161,7 @@ static void exynos_bus_exit(struct device *dev)
 
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
-	dev_pm_opp_put_regulators(bus->opp_table);
-	bus->opp_table = NULL;
+	dev_pm_opp_put_regulators(bus->opp_token);
 }
 
 static void exynos_bus_passive_exit(struct device *dev)
@@ -179,18 +178,16 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 					struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
-	struct opp_table *opp_table;
 	const char *supplies[] = { "vdd", NULL };
 	int i, ret, count, size;
 
-	opp_table = dev_pm_opp_set_regulators(dev, supplies);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
+	ret = dev_pm_opp_set_regulators(dev, supplies);
+	if (ret < 0) {
 		dev_err(dev, "failed to set regulators %d\n", ret);
 		return ret;
 	}
 
-	bus->opp_table = opp_table;
+	bus->opp_token = ret;
 
 	/*
 	 * Get the devfreq-event devices to get the current utilization of
@@ -236,8 +233,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	return 0;
 
 err_regulator:
-	dev_pm_opp_put_regulators(bus->opp_table);
-	bus->opp_table = NULL;
+	dev_pm_opp_put_regulators(bus->opp_token);
 
 	return ret;
 }
@@ -459,8 +455,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
 err_reg:
-	dev_pm_opp_put_regulators(bus->opp_table);
-	bus->opp_table = NULL;
+	dev_pm_opp_put_regulators(bus->opp_token);
 
 	return ret;
 }
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7ab20c3b91ed..6ff9b5b69d07 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -991,8 +991,8 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	int size;
 
 	/*
-	 * We support this only if dev_pm_opp_set_regulators() was called
-	 * earlier.
+	 * We support this only if dev_pm_opp_set_config() was called
+	 * earlier to set regulators.
 	 */
 	if (opp_table->sod_supplies) {
 		size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
@@ -2097,7 +2097,7 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
 /**
- * dev_pm_opp_set_regulators() - Set regulator names for the device
+ * _opp_set_regulators() - Set regulator names for the device
  * @dev: Device for which regulator name is being set.
  * @names: Array of pointers to the names of the regulator.
  * @count: Number of regulators.
@@ -2108,12 +2108,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  *
  * This must be called before any OPPs are initialized for the device.
  */
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
-					    const char * const names[])
+static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
+			       const char * const names[])
 {
 	struct dev_pm_opp_supply *supplies;
 	const char * const *temp = names;
-	struct opp_table *opp_table;
 	struct regulator *reg;
 	int count = 0, ret, i;
 
@@ -2122,29 +2121,17 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 		count++;
 
 	if (!count)
-		return ERR_PTR(-EINVAL);
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
-		goto err;
-	}
+		return -EINVAL;
 
 	/* Another CPU that shares the OPP table has set the regulators ? */
 	if (opp_table->regulators)
-		return opp_table;
+		return 0;
 
 	opp_table->regulators = kmalloc_array(count,
 					      sizeof(*opp_table->regulators),
 					      GFP_KERNEL);
-	if (!opp_table->regulators) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!opp_table->regulators)
+		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
 		reg = regulator_get_optional(dev, names[i]);
@@ -2174,7 +2161,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	}
 	mutex_unlock(&opp_table->lock);
 
-	return opp_table;
+	return 0;
 
 free_regulators:
 	while (i != 0)
@@ -2183,26 +2170,20 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
-err:
-	dev_pm_opp_put_opp_table(opp_table);
 
-	return ERR_PTR(ret);
+	return ret;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulators);
 
 /**
- * dev_pm_opp_put_regulators() - Releases resources blocked for regulator
- * @opp_table: OPP table returned from dev_pm_opp_set_regulators().
+ * _opp_put_regulators() - Releases resources blocked for regulator
+ * @opp_table: OPP table returned from _opp_set_regulators().
  */
-void dev_pm_opp_put_regulators(struct opp_table *opp_table)
+static void _opp_put_regulators(struct opp_table *opp_table)
 {
 	int i;
 
-	if (unlikely(!opp_table))
-		return;
-
 	if (!opp_table->regulators)
-		goto put_opp_table;
+		return;
 
 	if (opp_table->enabled) {
 		for (i = opp_table->regulator_count - 1; i >= 0; i--)
@@ -2225,40 +2206,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
-
-put_opp_table:
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
-
-static void devm_pm_opp_regulators_release(void *data)
-{
-	dev_pm_opp_put_regulators(data);
-}
-
-/**
- * devm_pm_opp_set_regulators() - Set regulator names for the device
- * @dev: Device for which regulator name is being set.
- * @names: Array of pointers to the names of the regulator.
- * @count: Number of regulators.
- *
- * This is a resource-managed variant of dev_pm_opp_set_regulators().
- *
- * Return: 0 on success and errorno otherwise.
- */
-int devm_pm_opp_set_regulators(struct device *dev,
-			       const char * const names[])
-{
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_regulators(dev, names);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_regulators_release,
-					opp_table);
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_regulators);
 
 /**
  * dev_pm_opp_set_clkname() - Set clk name for the device
@@ -2633,7 +2581,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_GENPD)
 		dev_pm_opp_detach_genpd(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR)
-		dev_pm_opp_put_regulators(data->opp_table);
+		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		dev_pm_opp_put_supported_hw(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
@@ -2758,11 +2706,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure supplies */
 	if (config->regulator_names) {
-		err = dev_pm_opp_set_regulators(dev, config->regulator_names);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_regulators(opp_table, dev,
+					  config->regulator_names);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_REGULATOR;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a08f9481efb3..f014bd172c99 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -189,9 +189,6 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[]);
-void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-int devm_pm_opp_set_regulators(struct device *dev, const char * const names[]);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -409,19 +406,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[])
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_regulators(struct device *dev,
-					     const char * const names[])
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
@@ -606,4 +590,32 @@ static inline int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_ta
 }
 #endif
 
+/* OPP Configuration helpers */
+
+/* Regulators helpers */
+static inline int dev_pm_opp_set_regulators(struct device *dev,
+					    const char * const names[])
+{
+	struct dev_pm_opp_config config = {
+		.regulator_names = names,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_put_regulators(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
+
+static inline int devm_pm_opp_set_regulators(struct device *dev,
+					     const char * const names[])
+{
+	struct dev_pm_opp_config config = {
+		.regulator_names = names,
+	};
+
+	return devm_pm_opp_set_config(dev, &config);
+}
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

