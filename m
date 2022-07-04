Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3156545A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiGDMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiGDMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5411456
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so2420694pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrOGtxkFmB6UH0d1rGpCly52Gseq2BReDDh7CSQ+HAQ=;
        b=qEcnTAIjcN2FhHiBHkMFY4f7YGO5q4FlBkrys/AbzPQC6gyy/PoQmTIQHzPNYy6smq
         upYJ9fz1S2hIU0zCWOvCx+NBN3GwOwVTxeDdILqAN+ZBJWgOL3aaVpHUyIEQf3W9y4GB
         oVL403zkb82N14XsG1SDHWSjz0ZiPEs46zuIfVSHfJrWNaUL7fXukYEFO95bvmNySRpt
         2WjI0oVb7xcGbbjmi36Z9R6Znz1wCfpQRyNdOkQif0fIJC1HhAztjQCT/hrCRztijbZF
         NnFiHfq9aQuFW+0mlewI5A6zzCCj0hQQ1NQOdt9t0Vq/akqTODbLRtc4dXQmEtKgQF2I
         4l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrOGtxkFmB6UH0d1rGpCly52Gseq2BReDDh7CSQ+HAQ=;
        b=3dohhNAhO/5Fg/bCruT/Fa93qTIt8TUk7Kp5f1grXQtKp4d4wQ4xrjsaJcWK6GTwX2
         jBZPwGTw2XvRvXnLZXJDV9dlqHBFsXZOJo/CJUZy5DM+tAkF6rpBm+4TaW8sT5jywTl+
         r452vHBLURzINCMDyOq/5T06F5Oypk4+G/GZNvCpByRmcLSEQpCYBjgUh05Feb/K3pdv
         5SXKco1nyRbeOCaMl03uK2X+G3Gcdb5ru2zMbKFejmfqzqlOeJjrCIfwb7KlRoZjmaDQ
         +1wjoZHlcX0h0oU70ZZ0b0H5hXMh8oqbSTZw9i71v9G3QCh2qAm8CSVaUA0cQtH10Wak
         lf4w==
X-Gm-Message-State: AJIora/zljAGHjovAMzbKTqsSxFCMI5LOnyXDFCDrOi+w3VZRnFlSUVK
        zAQ1X0GCrxZ53rekMnjj+qHkog==
X-Google-Smtp-Source: AGRyM1vYOAL9m3AYRPKBdHWJfJ6+0roTu5XHMn0UOmQO2dYfab5ob4tUcBZNNswchA1997RbCNrTzw==
X-Received: by 2002:a17:90b:1e06:b0:1ec:b513:4523 with SMTP id pg6-20020a17090b1e0600b001ecb5134523mr36905015pjb.58.1656936496430;
        Mon, 04 Jul 2022 05:08:16 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00098a00b0051bc721b838sm21068389pfg.188.2022.07.04.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH V3 02/20] OPP: Make dev_pm_opp_set_regulators() accept NULL terminated list
Date:   Mon,  4 Jul 2022 17:37:40 +0530
Message-Id: <9730e011004b7526e79c6f409f5147fb235b414a.1656935522.git.viresh.kumar@linaro.org>
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

Make dev_pm_opp_set_regulators() accept a NULL terminated list of names
instead of making the callers keep the two parameters in sync, which
creates an opportunity for bugs to get in.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c                |  9 ++++-----
 drivers/cpufreq/ti-cpufreq.c                |  7 +++----
 drivers/devfreq/exynos-bus.c                |  4 ++--
 drivers/gpu/drm/lima/lima_devfreq.c         |  3 ++-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c |  4 ++--
 drivers/opp/core.c                          | 18 ++++++++++++------
 drivers/soc/tegra/pmc.c                     |  4 ++--
 include/linux/pm_opp.h                      |  9 ++++-----
 8 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8fcaba541539..be0c19b3ffa5 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -193,7 +193,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	struct private_data *priv;
 	struct device *cpu_dev;
 	bool fallback = false;
-	const char *reg_name;
+	const char *reg_name[] = { NULL, NULL };
 	int ret;
 
 	/* Check if this CPU is already covered by some other policy */
@@ -218,10 +218,9 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	 * OPP layer will be taking care of regulators now, but it needs to know
 	 * the name of the regulator first.
 	 */
-	reg_name = find_supply_name(cpu_dev);
-	if (reg_name) {
-		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, &reg_name,
-							    1);
+	reg_name[0] = find_supply_name(cpu_dev);
+	if (reg_name[0]) {
+		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, reg_name);
 		if (IS_ERR(priv->opp_table)) {
 			ret = PTR_ERR(priv->opp_table);
 			if (ret != -EPROBE_DEFER)
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 8f9fdd864391..560d67a6bef1 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -173,7 +173,7 @@ static struct ti_cpufreq_soc_data omap34xx_soc_data = {
  *    seems to always read as 0).
  */
 
-static const char * const omap3_reg_names[] = {"cpu0", "vbb"};
+static const char * const omap3_reg_names[] = {"cpu0", "vbb", NULL};
 
 static struct ti_cpufreq_soc_data omap36xx_soc_data = {
 	.reg_names = omap3_reg_names,
@@ -326,7 +326,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
-	const char * const default_reg_names[] = {"vdd", "vbb"};
+	const char * const default_reg_names[] = {"vdd", "vbb", NULL};
 	int ret;
 
 	match = dev_get_platdata(&pdev->dev);
@@ -387,8 +387,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 		if (opp_data->soc_data->reg_names)
 			reg_names = opp_data->soc_data->reg_names;
 		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
-							 reg_names,
-							 ARRAY_SIZE(default_reg_names));
+							 reg_names);
 		if (IS_ERR(ti_opp_table)) {
 			dev_pm_opp_put_supported_hw(opp_data->opp_table);
 			ret =  PTR_ERR(ti_opp_table);
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index e689101abc93..541baff93ee8 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -180,10 +180,10 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 {
 	struct device *dev = bus->dev;
 	struct opp_table *opp_table;
-	const char *vdd = "vdd";
+	const char *supplies[] = { "vdd", NULL };
 	int i, ret, count, size;
 
-	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
+	opp_table = dev_pm_opp_set_regulators(dev, supplies);
 	if (IS_ERR(opp_table)) {
 		ret = PTR_ERR(opp_table);
 		dev_err(dev, "failed to set regulators %d\n", ret);
diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 8989e215dfc9..dc83c5421125 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -111,6 +111,7 @@ int lima_devfreq_init(struct lima_device *ldev)
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
 	int ret;
+	const char *regulator_names[] = { "mali", NULL };
 
 	if (!device_property_present(dev, "operating-points-v2"))
 		/* Optional, continue without devfreq */
@@ -122,7 +123,7 @@ int lima_devfreq_init(struct lima_device *ldev)
 	if (ret)
 		return ret;
 
-	ret = devm_pm_opp_set_regulators(dev, (const char *[]){ "mali" }, 1);
+	ret = devm_pm_opp_set_regulators(dev, regulator_names);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 194af7f607a6..12784f349550 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -91,6 +91,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+	const char *supplies[] = { pfdev->comp->supply_names[0], NULL };
 
 	if (pfdev->comp->num_supplies > 1) {
 		/*
@@ -101,8 +102,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		return 0;
 	}
 
-	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
-					 pfdev->comp->num_supplies);
+	ret = devm_pm_opp_set_regulators(dev, supplies);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV) {
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e166bfe5fc90..4e4593957ec5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2105,13 +2105,20 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  * This must be called before any OPPs are initialized for the device.
  */
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
-					    const char * const names[],
-					    unsigned int count)
+					    const char * const names[])
 {
 	struct dev_pm_opp_supply *supplies;
+	const char * const *temp = names;
 	struct opp_table *opp_table;
 	struct regulator *reg;
-	int ret, i;
+	int count = 0, ret, i;
+
+	/* Count number of regulators */
+	while (*temp++)
+		count++;
+
+	if (!count)
+		return ERR_PTR(-EINVAL);
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2236,12 +2243,11 @@ static void devm_pm_opp_regulators_release(void *data)
  * Return: 0 on success and errorno otherwise.
  */
 int devm_pm_opp_set_regulators(struct device *dev,
-			       const char * const names[],
-			       unsigned int count)
+			       const char * const names[])
 {
 	struct opp_table *opp_table;
 
-	opp_table = dev_pm_opp_set_regulators(dev, names, count);
+	opp_table = dev_pm_opp_set_regulators(dev, names);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5611d14d3ba2..6a4b8f7e7948 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1384,7 +1384,7 @@ tegra_pmc_core_pd_opp_to_performance_state(struct generic_pm_domain *genpd,
 static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
-	const char *rname = "core";
+	const char *rname[] = { "core", NULL};
 	int err;
 
 	genpd = devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL);
@@ -1395,7 +1395,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-	err = devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
+	err = devm_pm_opp_set_regulators(pmc->dev, rname);
 	if (err)
 		return dev_err_probe(pmc->dev, err,
 				     "failed to set core OPP regulator\n");
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6708b4ec244d..4c490865d574 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -159,9 +159,9 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[]);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-int devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+int devm_pm_opp_set_regulators(struct device *dev, const char * const names[]);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -379,7 +379,7 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
+static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[])
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -387,8 +387,7 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
 static inline int devm_pm_opp_set_regulators(struct device *dev,
-					     const char * const names[],
-					     unsigned int count)
+					     const char * const names[])
 {
 	return -EOPNOTSUPP;
 }
-- 
2.31.1.272.g89b43f80a514

