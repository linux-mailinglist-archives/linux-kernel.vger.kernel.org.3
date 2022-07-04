Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFB565484
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiGDMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiGDMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB411A0C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r22so1883132pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kl68/Ge329JOBN8CDqlysFsOT5joX99Z+i70CGu+msw=;
        b=EAPUEFzYTGuwd7KwfeWIWHABSqOZA8SlZNOKkdvDAGNYKPrscnkHRezVxW6I5aU9ZE
         kb99aFv5etogNHOd2Zwp8kUS8EaI/8XrWsJnPKcUJaCFV5S6VXiI0nYSeM0+JEqnTasx
         CJlMwU/51ZCD8caQIU5SoFnuJgMDKcTiFuVBtxSTwVOzrCICJd51IzmZB5zTl3+mjtEX
         MNukj7W3NiuKs5eWUcPLg2I7DNtbmaINAg687PtwC+z8eKqUrkx/a9YSia7PuB3dT0NL
         CGTp17o5Chf/5/Z64eVeYSJWDpLT6l6RlctpUHzifEvD2IJhOcX20fTzcSuBbMiOoR/c
         bapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kl68/Ge329JOBN8CDqlysFsOT5joX99Z+i70CGu+msw=;
        b=2qFeYMeICeGuHp0Yd/0IsQR+HiPg8HI/cLqNrJVSYACNjbRb6o3PZ15AYJir0FdiJO
         Fpf/lJuNbhIeP2eLUufaO/dx74sTvWC5sZFqg2SCChU5Gv5sA709xBqmu24lnbGh4/R5
         D09utt70DXeC93fSyNB9cdmIw+QehctxdPyXTViuIP6jBjxl8lgm9CAwvXtyK9PwrGK4
         Y8J+Dq+fd2Iifiav6pZNEAHoJEK5BU6O0q4MgGj4NY3AYqjyAWJX0GZMMvvvOH92GGsB
         +Q3qAxbXjvk7agMjSf8BLK2E53Jt5fCKIt9xD7Lju+j+hj3cJecfNr05yq1kSJ+OEAey
         AI2A==
X-Gm-Message-State: AJIora9dXpBX2zj8B2qyPnvsNaqW/xuORz+/6r1dVJBmG+Dg6RyAmNFI
        IOntlEichBuL5+uMS5ERUbO9Sg==
X-Google-Smtp-Source: AGRyM1saClCpHqIjdDI+VytCcyi2ILPZ57ZBHaO9dBX+pNGS/RIp1zb8Fj/hebHIstDpQXjporCXxQ==
X-Received: by 2002:a63:de10:0:b0:411:9f90:b91f with SMTP id f16-20020a63de10000000b004119f90b91fmr21147329pgg.412.1656936534130;
        Mon, 04 Jul 2022 05:08:54 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b0015e8d4eb273sm4544753pla.189.2022.07.04.05.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 15/20] OPP: Migrate set-prop-name helper API to use set-config helpers
Date:   Mon,  4 Jul 2022 17:37:53 +0530
Message-Id: <bbd8f1e7508a9c66028ea1d80fd86924256fdb64.1656935522.git.viresh.kumar@linaro.org>
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
migrate the set-prop-name family of helpers to use the new
infrastructure.

The return type and parameter to the APIs change a bit due to this,
update the current users as well in the same commit in order to avoid
breaking builds.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 31 +++++++--------
 drivers/opp/core.c                     | 55 +++++++++-----------------
 include/linux/pm_opp.h                 | 23 ++++++-----
 3 files changed, 46 insertions(+), 63 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 75e1bf3a08f7..a4922580ce06 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -86,20 +86,20 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 {
-	struct opp_table **opp_tables;
+	int *opp_tokens;
 	char name[MAX_NAME_LEN];
 	unsigned int cpu;
 	u32 speed = 0;
 	int ret;
 
-	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
+	opp_tokens = kcalloc(num_possible_cpus(), sizeof(*opp_tokens),
 			     GFP_KERNEL);
-	if (!opp_tables)
+	if (!opp_tokens)
 		return -ENOMEM;
 
 	ret = sun50i_cpufreq_get_efuse(&speed);
 	if (ret) {
-		kfree(opp_tables);
+		kfree(opp_tokens);
 		return ret;
 	}
 
@@ -113,9 +113,9 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 			goto free_opp;
 		}
 
-		opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
-		if (IS_ERR(opp_tables[cpu])) {
-			ret = PTR_ERR(opp_tables[cpu]);
+		opp_tokens[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
+		if (opp_tokens[cpu] < 0) {
+			ret = opp_tokens[cpu];
 			pr_err("Failed to set prop name\n");
 			goto free_opp;
 		}
@@ -124,7 +124,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
 	if (!IS_ERR(cpufreq_dt_pdev)) {
-		platform_set_drvdata(pdev, opp_tables);
+		platform_set_drvdata(pdev, opp_tokens);
 		return 0;
 	}
 
@@ -132,27 +132,24 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	pr_err("Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR_OR_NULL(opp_tables[cpu]))
-			break;
-		dev_pm_opp_put_prop_name(opp_tables[cpu]);
-	}
-	kfree(opp_tables);
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_prop_name(opp_tokens[cpu]);
+	kfree(opp_tokens);
 
 	return ret;
 }
 
 static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 {
-	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	int *opp_tokens = platform_get_drvdata(pdev);
 	unsigned int cpu;
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_put_prop_name(opp_tables[cpu]);
+		dev_pm_opp_put_prop_name(opp_tokens[cpu]);
 
-	kfree(opp_tables);
+	kfree(opp_tokens);
 
 	return 0;
 }
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 458584994c2b..1745e25c1eaf 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1997,7 +1997,7 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_set_prop_name() - Set prop-extn name
+ * _opp_set_prop_name() - Set prop-extn name
  * @dev: Device for which the prop-name has to be set.
  * @name: name to postfix to properties.
  *
@@ -2006,50 +2006,33 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
  * which the extension will apply are opp-microvolt and opp-microamp. OPP core
  * should postfix the property name with -<name> while looking for them.
  */
-struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+static int _opp_set_prop_name(struct opp_table *opp_table, const char *name)
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
-	if (opp_table->prop_name)
-		return opp_table;
-
-	opp_table->prop_name = kstrdup(name, GFP_KERNEL);
 	if (!opp_table->prop_name) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-ENOMEM);
+		opp_table->prop_name = kstrdup(name, GFP_KERNEL);
+		if (!opp_table->prop_name)
+			return -ENOMEM;
 	}
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
 
 /**
- * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
- * @opp_table: OPP table returned by dev_pm_opp_set_prop_name().
+ * _opp_put_prop_name() - Releases resources blocked for prop-name
+ * @opp_table: OPP table returned by _opp_set_prop_name().
  *
  * This is required only for the V2 bindings, and is called for a matching
- * dev_pm_opp_set_prop_name(). Until this is called, the opp_table structure
+ * _opp_set_prop_name(). Until this is called, the opp_table structure
  * will not be freed.
  */
-void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
+static void _opp_put_prop_name(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
-	kfree(opp_table->prop_name);
-	opp_table->prop_name = NULL;
-
-	dev_pm_opp_put_opp_table(opp_table);
+	if (opp_table->prop_name) {
+		kfree(opp_table->prop_name);
+		opp_table->prop_name = NULL;
+	}
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
 /**
  * _opp_set_regulators() - Set regulator names for the device
@@ -2414,7 +2397,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
 		_opp_unregister_set_opp_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_PROP_NAME)
-		dev_pm_opp_put_prop_name(data->opp_table);
+		_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
 		_opp_put_clknames(data->opp_table);
 
@@ -2441,7 +2424,7 @@ static void _opp_clear_config(struct opp_config_data *data)
  */
 int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
-	struct opp_table *opp_table, *err;
+	struct opp_table *opp_table;
 	struct opp_config_data *data;
 	unsigned int id;
 	int ret;
@@ -2476,11 +2459,9 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure property names */
 	if (config->prop_name) {
-		err = dev_pm_opp_set_prop_name(dev, config->prop_name);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_prop_name(opp_table, config->prop_name);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_PROP_NAME;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 20e1e5060a8a..f995ca1406e8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -184,8 +184,6 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(int token);
 
-struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
-void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -357,13 +355,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
-
 static inline int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
 	return -EOPNOTSUPP;
@@ -652,5 +643,19 @@ static inline int devm_pm_opp_attach_genpd(struct device *dev,
 	return devm_pm_opp_set_config(dev, &config);
 }
 
+/* prop-name helpers */
+static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+{
+	struct dev_pm_opp_config config = {
+		.prop_name = name,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_put_prop_name(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

