Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9F562DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiGAIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiGAIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:20:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4070AF7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:20:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so5727739pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rd2Uisd5Y4W/VJAGdhobqO4GQLVcYGgmZc11srtGLLA=;
        b=WkpdupNLmmTJbNdi75+tw8qqz16nkcR7kXI60KBWPn45KSRjpCbo+EstSlYMyePbJC
         ZwK73GCR5WxIhjrHsulCMclv5IUWnMR1/esv5YEq8U8vSS3B+Yho6OhZZydHoEqqDXzq
         8fIoGc2smB/PRHLugv8g9P/vBm63HXswfopg7ZULXlVRjwdXMNSvUMi/1d7YYVjHcU3k
         pzhzYZxnYzNNbQ1u2G6PFtJrH9uM6l0hZuoyszwa/VaQ7RphpMapjZcXMX+P8rm6SGe3
         LY2yhxFOoy3tNidO1Ojh3x5a02mTQwmx1ig1UApWe60yKvfmGm22H44WyM1NnwcXh5uD
         cbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rd2Uisd5Y4W/VJAGdhobqO4GQLVcYGgmZc11srtGLLA=;
        b=vn9QG9Xs9oM9i2FRi2v2IGgEygO0WnLf/GGUtd0Wk7F0HniWcyEZxLhf30XABSYDDw
         AynDuQBbVEdreuq93ISx+sWbndzoAPRyRjr7wVb62d+UZoD5kpol4O61bTb4j5EVSWeE
         dDrVV0VdjKu6NTuuEOAmW1jz6Qpymn6kiwKyGeM7h2BY8YjgdABSmVnvTbqPSpYeJHgr
         fS5ULFDW7rs08kRrMOQzptAYM0ljCCCTSJd8RUxUzCLLDA4gV5R5W5A+JfWqsq53TPAG
         EZqe2QL1FfeOEUElxg5COZoA2/HQCGPckjIlCLJR0HY8HZ9y01/y5o729V5y3q5VVWvx
         54tQ==
X-Gm-Message-State: AJIora99UsJl6YCj01idFigfKzXYUaSykmNtvxRWa37/DkDJoakTsP5L
        azDhd0CwLnZn0eIdZlIHVK+yHg==
X-Google-Smtp-Source: AGRyM1uPQeSi/N29UBRniR+zsVejTf6T7LB6AVWdO2jFxrIu8vQA6gQ2aLgxKWsu4uYIdoGIIWwu0Q==
X-Received: by 2002:a17:902:ec85:b0:16a:1d00:4ef6 with SMTP id x5-20020a170902ec8500b0016a1d004ef6mr19294082plg.62.1656663650372;
        Fri, 01 Jul 2022 01:20:50 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001634d581adfsm14765758plp.157.2022.07.01.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:20:50 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/30] OPP: Add dev_pm_opp_set_config() and friends
Date:   Fri,  1 Jul 2022 13:49:57 +0530
Message-Id: <1ac36a9ad618ed182d7584bb04d1e834720a3fea.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

The OPP core already have few configuration specific APIs and it is
getting complex or messy for both the OPP core and its users.

Lets introduce a new set of API which will be used for all kind of
different configurations, and shall eventually replace all the existing
ones.

The new API, returns a unique token instead of a pointer to the OPP
table, which allows the OPP core to drop the resources selectively later
on.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 214 ++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h      |  21 ++++
 include/linux/pm_opp.h |  45 +++++++++
 3 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e166bfe5fc90..c77ea05ee2cd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -13,11 +13,12 @@
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
 
 #include "opp.h"
 
@@ -36,6 +37,9 @@ DEFINE_MUTEX(opp_table_lock);
 /* Flag indicating that opp_tables list is being updated at the moment */
 static bool opp_tables_busy;
 
+/* OPP ID allocator */
+static DEFINE_XARRAY_ALLOC1(opp_configs);
+
 static bool _find_opp_dev(const struct device *dev, struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
@@ -2618,6 +2622,214 @@ int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
 
+static void _opp_clear_config(struct opp_config_data *data)
+{
+	if (data->flags & OPP_CONFIG_GENPD)
+		dev_pm_opp_detach_genpd(data->opp_table);
+	if (data->flags & OPP_CONFIG_REGULATOR)
+		dev_pm_opp_put_regulators(data->opp_table);
+	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
+		dev_pm_opp_put_supported_hw(data->opp_table);
+	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
+		dev_pm_opp_unregister_set_opp_helper(data->opp_table);
+	if (data->flags & OPP_CONFIG_PROP_NAME)
+		dev_pm_opp_put_prop_name(data->opp_table);
+	if (data->flags & OPP_CONFIG_CLK)
+		dev_pm_opp_put_clkname(data->opp_table);
+
+	dev_pm_opp_put_opp_table(data->opp_table);
+	kfree(data);
+}
+
+/**
+ * dev_pm_opp_set_config() - Set OPP configuration for the device.
+ * @dev: Device for which configuration is being set.
+ * @config: OPP configuration.
+ *
+ * This allows all device OPP configurations to be performed at once.
+ *
+ * This must be called before any OPPs are initialized for the device. This may
+ * be called multiple times for the same OPP table, for example once for each
+ * CPU that share the same table. This must be balanced by the same number of
+ * calls to dev_pm_opp_clear_config() in order to free the OPP table properly.
+ *
+ * This returns a token to the caller, which must be passed to
+ * dev_pm_opp_clear_config() to free the resources later. The value of the
+ * returned token will be >= 1 for success and negative for errors. The minimum
+ * value of 1 is chosen here to make it easy for callers to manage the resource.
+ */
+int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	struct opp_table *opp_table, *err;
+	struct opp_config_data *data;
+	unsigned int id;
+	int ret;
+
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	opp_table = _add_opp_table(dev, false);
+	if (IS_ERR(opp_table)) {
+		kfree(data);
+		return PTR_ERR(opp_table);
+	}
+
+	data->opp_table = opp_table;
+	data->flags = 0;
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Configure clocks */
+	if (config->clk_names) {
+		/* We support only one clock name for now */
+		if (config->clk_count != 1) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		err = dev_pm_opp_set_clkname(dev, config->clk_names[0]);
+		if (IS_ERR(err)) {
+			ret = PTR_ERR(err);
+			goto err;
+		}
+
+		data->flags |= OPP_CONFIG_CLK;
+	}
+
+	/* Configure property names */
+	if (config->prop_name) {
+		err = dev_pm_opp_set_prop_name(dev, config->prop_name);
+		if (IS_ERR(err)) {
+			ret = PTR_ERR(err);
+			goto err;
+		}
+
+		data->flags |= OPP_CONFIG_PROP_NAME;
+	}
+
+	/* Configure opp helper */
+	if (config->set_opp) {
+		err = dev_pm_opp_register_set_opp_helper(dev, config->set_opp);
+		if (IS_ERR(err)) {
+			ret = PTR_ERR(err);
+			goto err;
+		}
+
+		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
+	}
+
+	/* Configure supported hardware */
+	if (config->supported_hw) {
+		err = dev_pm_opp_set_supported_hw(dev, config->supported_hw,
+						  config->supported_hw_count);
+		if (IS_ERR(err)) {
+			ret = PTR_ERR(err);
+			goto err;
+		}
+
+		data->flags |= OPP_CONFIG_SUPPORTED_HW;
+	}
+
+	/* Configure supplies */
+	if (config->regulator_names) {
+		err = dev_pm_opp_set_regulators(dev, config->regulator_names,
+						config->regulator_count);
+		if (IS_ERR(err)) {
+			ret = PTR_ERR(err);
+			goto err;
+		}
+
+		data->flags |= OPP_CONFIG_REGULATOR;
+	}
+
+	/* Attach genpds */
+	if (config->genpd_names) {
+		err = dev_pm_opp_attach_genpd(dev, config->genpd_names,
+					      config->virt_devs);
+		if (IS_ERR(err)) {
+			ret = PTR_ERR(err);
+			goto err;
+		}
+
+		data->flags |= OPP_CONFIG_GENPD;
+	}
+
+	ret = xa_alloc(&opp_configs, &id, data, XA_LIMIT(1, INT_MAX),
+		       GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	return id;
+
+err:
+	_opp_clear_config(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
+
+/**
+ * dev_pm_opp_clear_config() - Releases resources blocked for OPP configuration.
+ * @opp_table: OPP table returned from dev_pm_opp_set_config().
+ *
+ * This allows all device OPP configurations to be cleared at once. This must be
+ * called once for each call made to dev_pm_opp_set_config(), in order to free
+ * the OPPs properly.
+ *
+ * Currently the first call itself ends up freeing all the OPP configurations,
+ * while the later ones only drop the OPP table reference. This works well for
+ * now as we would never want to use an half initialized OPP table and want to
+ * remove the configurations together.
+ */
+void dev_pm_opp_clear_config(int token)
+{
+	struct opp_config_data *data;
+
+	/*
+	 * This lets the callers call this unconditionally and keep their code
+	 * simple.
+	 */
+	if (unlikely(token <= 0))
+		return;
+
+	data = xa_erase(&opp_configs, token);
+	if (WARN_ON(!data))
+		return;
+
+	_opp_clear_config(data);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_clear_config);
+
+static void devm_pm_opp_config_release(void *token)
+{
+	dev_pm_opp_clear_config((unsigned long)token);
+}
+
+/**
+ * devm_pm_opp_set_config() - Set OPP configuration for the device.
+ * @dev: Device for which configuration is being set.
+ * @config: OPP configuration.
+ *
+ * This allows all device OPP configurations to be performed at once.
+ * This is a resource-managed variant of dev_pm_opp_set_config().
+ *
+ * Return: 0 on success and errorno otherwise.
+ */
+int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	int token = dev_pm_opp_set_config(dev, config);
+	if (token < 0)
+		return token;
+
+	return devm_add_action_or_reset(dev, devm_pm_opp_config_release,
+					(void *) ((unsigned long) token));
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_config);
+
 /**
  * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
  * @src_table: OPP table which has @dst_table as one of its required OPP table.
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9e1cfcb0ea98..d652f0cc84f1 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -28,6 +28,27 @@ extern struct mutex opp_table_lock;
 
 extern struct list_head opp_tables, lazy_opp_tables;
 
+/* OPP Config flags */
+#define OPP_CONFIG_CLK			BIT(0)
+#define OPP_CONFIG_REGULATOR		BIT(1)
+#define OPP_CONFIG_REGULATOR_HELPER	BIT(2)
+#define OPP_CONFIG_PROP_NAME		BIT(3)
+#define OPP_CONFIG_SUPPORTED_HW		BIT(4)
+#define OPP_CONFIG_GENPD		BIT(5)
+
+/**
+ * struct opp_config_data - data for set config operations
+ * @opp_table: OPP table
+ * @flags: OPP config flags
+ *
+ * This structure stores the OPP config information for each OPP table
+ * configuration by the callers.
+ */
+struct opp_config_data {
+	struct opp_table *opp_table;
+	unsigned int flags;
+};
+
 /*
  * Internal data structure organization with the OPP layer library is as
  * follows:
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6708b4ec244d..467bed35130e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,6 +90,35 @@ struct dev_pm_set_opp_data {
 	struct device *dev;
 };
 
+/**
+ * struct dev_pm_opp_config - Device OPP configuration values
+ * @clk_names: Clk name.
+ * @clk_count: Number of clocks, max 1 for now.
+ * @prop_name: Name to postfix to properties.
+ * @set_opp: Custom set OPP helper.
+ * @supported_hw: Array of hierarchy of versions to match.
+ * @supported_hw_count: Number of elements in the array.
+ * @regulator_names: Array of pointers to the names of the regulator.
+ * @regulator_count: Number of regulators.
+ * @genpd_names: Null terminated array of pointers containing names of genpd to
+ *		 attach.
+ * @virt_devs: Pointer to return the array of virtual devices.
+ *
+ * This structure contains platform specific OPP configurations for the device.
+ */
+struct dev_pm_opp_config {
+	const char * const *clk_names;
+	unsigned int clk_count;
+	const char *prop_name;
+	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	unsigned int *supported_hw;
+	unsigned int supported_hw_count;
+	const char * const *regulator_names;
+	unsigned int regulator_count;
+	const char * const *genpd_names;
+	struct device ***virt_devs;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -154,6 +183,10 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
+int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
+int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
+void dev_pm_opp_clear_config(int token);
+
 struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
@@ -419,6 +452,18 @@ static inline int devm_pm_opp_attach_genpd(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dev_pm_opp_clear_config(int token) {}
+
 static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 				struct opp_table *dst_table, struct dev_pm_opp *src_opp)
 {
-- 
2.31.1.272.g89b43f80a514

