Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D22565479
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiGDMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiGDMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB912603
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4075780pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/9TsfHubVBv9DY1BppOPOwd/HnEouHrujq83/2ruNg=;
        b=xmkenxa4Ac/ERNHJnlrShcfIHGlT6j3H0Agxofs36a8AA62Q5HdxwpAu+uPQDyweLN
         fXfG/3pO26jJbcbpI9UARobDLLQAhXzG9scFa6V10+JWHo3vnnnB8PbCDWRx3J4DhoUB
         i+LUJrFjicOca45jAvMueSVh/d5jydDxvGnPbmAF31GNQKQjIijfvRfiEeQl1OKpyYeL
         ixJgjc/fujsGZr9npzSQPLyNYM8ZecgEtkkrHuSRmgPTg7KSOqbLPKuKD1s5uPU6BAol
         aDee493mfYAPCPZGrdbjc/rm54KfmZ5ewxg3yFCU5DvhuO5o0+bYjM0hZAj3M7kXuxvS
         3+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/9TsfHubVBv9DY1BppOPOwd/HnEouHrujq83/2ruNg=;
        b=BlehLd/gmhuHydBV+5QcxA9ggPtHZsoZ310Bnj6pQW6efk3Ml+3jyMvyQMDqkHx46D
         wr2jXfM7w0yqYw2aRd/CA4ZHu3qJ1dEFpjfnzG4nB4XKac0i+/oBhApCyiYvZh2XzMpZ
         z/Bii+WFs3VMu2tlfLcoAe81NVDQDNM32R43iHkAW7WtzC+dpVuL8Ejsn13JFaWwZtRX
         20ZtvudrMCb94GcuAMsSLlRVKySOibN8VO9n/JdDqRoJZiQMhQqSvcNU7oNcZ42nKLtP
         idlM7gXlstMKDldfH5Q+KRqCocQ4xOX0Hbb9CtJCYqCmYAtKz2YwgLiOGuiwywgnJYPU
         41MQ==
X-Gm-Message-State: AJIora/vQMwEIcaXmP+TntIXIh8e6UIopf2gp5gBI8xfYXeP4elyR0U4
        Zj+ohwqVMisbLX/rlfmcCXi7VQ==
X-Google-Smtp-Source: AGRyM1tzoP2BrzAF0O9+mDmKNI6HEzcfmUZRSOi26/yUuVYzHS04jmRMOv3hDjlx8wp27beJnNXtPw==
X-Received: by 2002:a17:902:e844:b0:16a:32d9:722c with SMTP id t4-20020a170902e84400b0016a32d9722cmr35010927plg.40.1656936522271;
        Mon, 04 Jul 2022 05:08:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0016a38fa3f95sm20997613plk.118.2022.07.04.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH V3 11/20] OPP: Migrate set-supported-hw API to use set-config helpers
Date:   Mon,  4 Jul 2022 17:37:49 +0530
Message-Id: <a181aca1ac7ebcf526d717cbda1964cdc2898903.1656935522.git.viresh.kumar@linaro.org>
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
migrate the set-supported-hw family of helpers to use the new
infrastructure.

The return type and parameter to the APIs change a bit due to this,
update the current users as well in the same commit in order to avoid
breaking builds.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx-cpufreq-dt.c    | 12 ++--
 drivers/cpufreq/tegra20-cpufreq.c   | 12 ++--
 drivers/memory/tegra/tegra124-emc.c | 11 ++--
 drivers/opp/core.c                  | 87 +++++++----------------------
 include/linux/pm_opp.h              | 49 +++++++++-------
 5 files changed, 66 insertions(+), 105 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 3fe9125156b4..76e553af2071 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -31,8 +31,8 @@
 
 /* cpufreq-dt device registered by imx-cpufreq-dt */
 static struct platform_device *cpufreq_dt_pdev;
-static struct opp_table *cpufreq_opp_table;
 static struct device *cpu_dev;
+static int cpufreq_opp_token;
 
 enum IMX7ULP_CPUFREQ_CLKS {
 	ARM,
@@ -153,9 +153,9 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "cpu speed grade %d mkt segment %d supported-hw %#x %#x\n",
 			speed_grade, mkt_segment, supported_hw[0], supported_hw[1]);
 
-	cpufreq_opp_table = dev_pm_opp_set_supported_hw(cpu_dev, supported_hw, 2);
-	if (IS_ERR(cpufreq_opp_table)) {
-		ret = PTR_ERR(cpufreq_opp_table);
+	cpufreq_opp_token = dev_pm_opp_set_supported_hw(cpu_dev, supported_hw, 2);
+	if (cpufreq_opp_token < 0) {
+		ret = cpufreq_opp_token;
 		dev_err(&pdev->dev, "Failed to set supported opp: %d\n", ret);
 		return ret;
 	}
@@ -163,7 +163,7 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	cpufreq_dt_pdev = platform_device_register_data(
 			&pdev->dev, "cpufreq-dt", -1, NULL, 0);
 	if (IS_ERR(cpufreq_dt_pdev)) {
-		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		dev_pm_opp_put_supported_hw(cpufreq_opp_token);
 		ret = PTR_ERR(cpufreq_dt_pdev);
 		dev_err(&pdev->dev, "Failed to register cpufreq-dt: %d\n", ret);
 		return ret;
@@ -176,7 +176,7 @@ static int imx_cpufreq_dt_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(cpufreq_dt_pdev);
 	if (!of_machine_is_compatible("fsl,imx7ulp"))
-		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		dev_pm_opp_put_supported_hw(cpufreq_opp_token);
 	else
 		clk_bulk_put(ARRAY_SIZE(imx7ulp_clks), imx7ulp_clks);
 
diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index e8db3d75be25..ab7ac7df9e62 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -32,9 +32,9 @@ static bool cpu0_node_has_opp_v2_prop(void)
 	return ret;
 }
 
-static void tegra20_cpufreq_put_supported_hw(void *opp_table)
+static void tegra20_cpufreq_put_supported_hw(void *opp_token)
 {
-	dev_pm_opp_put_supported_hw(opp_table);
+	dev_pm_opp_put_supported_hw((unsigned long) opp_token);
 }
 
 static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
@@ -45,7 +45,6 @@ static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
 static int tegra20_cpufreq_probe(struct platform_device *pdev)
 {
 	struct platform_device *cpufreq_dt;
-	struct opp_table *opp_table;
 	struct device *cpu_dev;
 	u32 versions[2];
 	int err;
@@ -71,16 +70,15 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 	if (WARN_ON(!cpu_dev))
 		return -ENODEV;
 
-	opp_table = dev_pm_opp_set_supported_hw(cpu_dev, versions, 2);
-	err = PTR_ERR_OR_ZERO(opp_table);
-	if (err) {
+	err = dev_pm_opp_set_supported_hw(cpu_dev, versions, 2);
+	if (err < 0) {
 		dev_err(&pdev->dev, "failed to set supported hw: %d\n", err);
 		return err;
 	}
 
 	err = devm_add_action_or_reset(&pdev->dev,
 				       tegra20_cpufreq_put_supported_hw,
-				       opp_table);
+				       (void *)((unsigned long) err));
 	if (err)
 		return err;
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 908f8d5392b2..85bc936c02f9 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1395,15 +1395,14 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
-	struct opp_table *hw_opp_table;
-	int err;
+	int opp_token, err;
 
-	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
-	err = PTR_ERR_OR_ZERO(hw_opp_table);
-	if (err) {
+	err = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
+	if (err < 0) {
 		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
 		return err;
 	}
+	opp_token = err;
 
 	err = dev_pm_opp_of_add_table(emc->dev);
 	if (err) {
@@ -1430,7 +1429,7 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 remove_table:
 	dev_pm_opp_of_remove_table(emc->dev);
 put_hw_table:
-	dev_pm_opp_put_supported_hw(hw_opp_table);
+	dev_pm_opp_put_supported_hw(opp_token);
 
 	return err;
 }
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6ff9b5b69d07..8dbdfff38973 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1952,7 +1952,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 }
 
 /**
- * dev_pm_opp_set_supported_hw() - Set supported platforms
+ * _opp_set_supported_hw() - Set supported platforms
  * @dev: Device for which supported-hw has to be set.
  * @versions: Array of hierarchy of versions to match.
  * @count: Number of elements in the array.
@@ -1962,84 +1962,39 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
  * OPPs, which are available for those versions, based on its 'opp-supported-hw'
  * property.
  */
-struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
-			const u32 *versions, unsigned int count)
+static int _opp_set_supported_hw(struct opp_table *opp_table,
+				 const u32 *versions, unsigned int count)
 {
-	struct opp_table *opp_table;
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	/* Another CPU that shares the OPP table has set the property ? */
 	if (opp_table->supported_hw)
-		return opp_table;
+		return 0;
 
 	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
 					GFP_KERNEL);
-	if (!opp_table->supported_hw) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!opp_table->supported_hw)
+		return -ENOMEM;
 
 	opp_table->supported_hw_count = count;
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
 
 /**
- * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
- * @opp_table: OPP table returned by dev_pm_opp_set_supported_hw().
+ * _opp_put_supported_hw() - Releases resources blocked for supported hw
+ * @opp_table: OPP table returned by _opp_set_supported_hw().
  *
  * This is required only for the V2 bindings, and is called for a matching
- * dev_pm_opp_set_supported_hw(). Until this is called, the opp_table structure
+ * _opp_set_supported_hw(). Until this is called, the opp_table structure
  * will not be freed.
  */
-void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
+static void _opp_put_supported_hw(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
-	kfree(opp_table->supported_hw);
-	opp_table->supported_hw = NULL;
-	opp_table->supported_hw_count = 0;
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
-
-static void devm_pm_opp_supported_hw_release(void *data)
-{
-	dev_pm_opp_put_supported_hw(data);
-}
-
-/**
- * devm_pm_opp_set_supported_hw() - Set supported platforms
- * @dev: Device for which supported-hw has to be set.
- * @versions: Array of hierarchy of versions to match.
- * @count: Number of elements in the array.
- *
- * This is a resource-managed variant of dev_pm_opp_set_supported_hw().
- *
- * Return: 0 on success and errorno otherwise.
- */
-int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
-				 unsigned int count)
-{
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_supported_hw_release,
-					opp_table);
+	if (opp_table->supported_hw) {
+		kfree(opp_table->supported_hw);
+		opp_table->supported_hw = NULL;
+		opp_table->supported_hw_count = 0;
+	}
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_supported_hw);
 
 /**
  * dev_pm_opp_set_prop_name() - Set prop-extn name
@@ -2583,7 +2538,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_REGULATOR)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
-		dev_pm_opp_put_supported_hw(data->opp_table);
+		_opp_put_supported_hw(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
 		dev_pm_opp_unregister_set_opp_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_PROP_NAME)
@@ -2694,12 +2649,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure supported hardware */
 	if (config->supported_hw) {
-		err = dev_pm_opp_set_supported_hw(dev, config->supported_hw,
-						  config->supported_hw_count);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_supported_hw(opp_table, config->supported_hw,
+					    config->supported_hw_count);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_SUPPORTED_HW;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f014bd172c99..94d0101c254c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -184,9 +184,6 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(int token);
 
-struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
-void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
-int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -369,22 +366,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
-							    const u32 *versions,
-							    unsigned int count)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_supported_hw(struct device *dev,
-					       const u32 *versions,
-					       unsigned int count)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
@@ -618,4 +599,34 @@ static inline int devm_pm_opp_set_regulators(struct device *dev,
 	return devm_pm_opp_set_config(dev, &config);
 }
 
+/* Supported-hw helpers */
+static inline int dev_pm_opp_set_supported_hw(struct device *dev,
+					      const u32 *versions,
+					      unsigned int count)
+{
+	struct dev_pm_opp_config config = {
+		.supported_hw = versions,
+		.supported_hw_count = count,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_put_supported_hw(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
+
+static inline int devm_pm_opp_set_supported_hw(struct device *dev,
+					       const u32 *versions,
+					       unsigned int count)
+{
+	struct dev_pm_opp_config config = {
+		.supported_hw = versions,
+		.supported_hw_count = count,
+	};
+
+	return devm_pm_opp_set_config(dev, &config);
+}
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

