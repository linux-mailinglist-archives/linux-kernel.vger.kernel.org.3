Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543E156545F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiGDMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiGDMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB6B64
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b2so8784059pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR9S24AVhdiyO3FjKQelsAHWRldKQJFRITpPgI47fvs=;
        b=t/ORs6pHsddG83J8MiSSWlq8NntooA+4f9BfjedD+VNOrTo4Otsbh9ILrb/jygXlxw
         ZSrkLuIdG+0OuZqV3t0wEJ1mr4p+i0s3wNi90qcGe1g/819ozfKOEDUidTIMO8MXn12L
         VwRp8XZBEAjbbBbSsX7roq0p8RJx8tyhazLGAyA/oe261Apknf+N3II4+Wr4yNPLQaNV
         W+XVnYoQX7COmQN/ykxMu7jvMjjh/vJ+9IebEdw743xuJXrNEn1fgtxAaWWSqxPCjVhx
         xvSbXsG2Jll8a3gNyKH1ZY6s4tJMtKLzBZ+fJeEaZwIFF7UPrch7p5kmt8CkKeMGT8H3
         ZX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR9S24AVhdiyO3FjKQelsAHWRldKQJFRITpPgI47fvs=;
        b=CKuL1u7QQtfKSGdRacQGJ+I04GqVCiO8uyEk663ze3f1WZBppJbTR6gKE++WcsXbt1
         uHkVa2brCYg7SZlKFlg8OMTHU11NutrphoSamen1wAMuFajkNaeVY0JLfxrw8TRBl7CV
         6nRPr1x4/i7R5jd/m3xwOEPjK2QYuWjR8IkYx5Z6WsPIk3QagwkHEmQ3NtPX4aRjOwZv
         3I87BPjLvcew0Dn2nrP760EBXFm5SlB0YdQzhfhWIZTqayIH5NqeCKgbLKbmQRU23nvj
         4m1gTje8LpgWM7LhyRhkM12h98HUOxv4om8wXEAMqiEGfCmMRHljH8TaixIn90ELyhQ8
         Ki/g==
X-Gm-Message-State: AJIora+QE5U9X0wfpTaWR/bx6Uqy6WziqUPBnG3SUY6/C8CSPrzBjPOM
        uUdvB6KnfS59gUOHZRAj9HwZRw==
X-Google-Smtp-Source: AGRyM1uIQyxW408bOWtO51tAuKYwlZSV8iuEau8+/wE43ynjPeBq5axSKY7Vu1B87/joAioI/ajspQ==
X-Received: by 2002:a05:6a00:32c5:b0:525:933e:252f with SMTP id cl5-20020a056a0032c500b00525933e252fmr34642402pfb.26.1656936499455;
        Mon, 04 Jul 2022 05:08:19 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b0016be0417409sm2620209plh.254.2022.07.04.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 03/20] OPP: Add dev_pm_opp_set_config() and friends
Date:   Mon,  4 Jul 2022 17:37:41 +0530
Message-Id: <e8782ca6693ec5c80ece890cef99a36221cc28bd.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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
different configurations, and shall eventually be used by all the
existing ones.

The new API, returns a unique token instead of a pointer to the OPP
table, which allows the OPP core to drop the resources selectively later
on.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 229 ++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h      |  21 ++++
 include/linux/pm_opp.h |  42 ++++++++
 3 files changed, 291 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4e4593957ec5..7ab20c3b91ed 100644
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
@@ -2624,6 +2628,229 @@ int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
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
+		const char * const *temp = config->clk_names;
+		int count = 0;
+
+		/* Count number of clks */
+		while (*temp++)
+			count++;
+
+		/*
+		 * This is a special case where we have a single clock, whose
+		 * connection id name is NULL, i.e. first two entries are NULL
+		 * in the array.
+		 */
+		if (!count && !config->clk_names[1])
+			count = 1;
+
+		/* We support only one clock name for now */
+		if (count != 1) {
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
+		err = dev_pm_opp_set_regulators(dev, config->regulator_names);
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
+
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
index 4c490865d574..a08f9481efb3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -90,6 +90,32 @@ struct dev_pm_set_opp_data {
 	struct device *dev;
 };
 
+/**
+ * struct dev_pm_opp_config - Device OPP configuration values
+ * @clk_names: Clk names, NULL terminated array, max 1 clock for now.
+ * @prop_name: Name to postfix to properties.
+ * @set_opp: Custom set OPP helper.
+ * @supported_hw: Array of hierarchy of versions to match.
+ * @supported_hw_count: Number of elements in the array.
+ * @regulator_names: Array of pointers to the names of the regulator, NULL terminated.
+ * @genpd_names: Null terminated array of pointers containing names of genpd to
+ *		 attach.
+ * @virt_devs: Pointer to return the array of virtual devices.
+ *
+ * This structure contains platform specific OPP configurations for the device.
+ */
+struct dev_pm_opp_config {
+	/* NULL terminated */
+	const char * const *clk_names;
+	const char *prop_name;
+	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	const unsigned int *supported_hw;
+	unsigned int supported_hw_count;
+	const char * const *regulator_names;
+	const char * const *genpd_names;
+	struct device ***virt_devs;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -154,6 +180,10 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
+int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
+int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
+void dev_pm_opp_clear_config(int token);
+
 struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
@@ -418,6 +448,18 @@ static inline int devm_pm_opp_attach_genpd(struct device *dev,
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

