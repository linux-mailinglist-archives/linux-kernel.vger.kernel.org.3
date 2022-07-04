Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A063856547E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGDMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiGDMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E18612616
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso3022302pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IrdxzxTTKLEFqWex8kwhKDZi3CUweIZT4I4RMPAg9Q=;
        b=NBpMXihmPxXh0ldVsTqVnPHisV7QIaooloK5TLqgGR4Eq3tI/aoCpTiZCJfQzmwL34
         9UnrXXdwlLclxaXJNmZATFo9aOrlQICa7zZg7HtD1fUkXe9OipYlSrRc9unK4MI+Wi2z
         PKRXzpGxAP6WdgJVqCZVKZxeYw7R5/gJjBIr2NDQFRYggSkqNwouUgYq4DdXKHNHNn5K
         WWFkx14/em0EHU8Wwbidh+Vb4Po+82bT/L8L3cOiTZ8PnKwryRHRklvR1A9pvpluZj2B
         nqKs/l+WCLAoQAdm+8TQM5f5aTvI9zZvzBxt0Jap+o7thYEsPRFX2o8eWEh1P7GFa/Yz
         nuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IrdxzxTTKLEFqWex8kwhKDZi3CUweIZT4I4RMPAg9Q=;
        b=1Tzb75MzQKxsuwNPWzG/alksP9sGZ1FkKLb5Qms7uJ3UdCOuEM0Yn0+vNuBMxfg7Nk
         OjLh2YylB+NGLsWq57B0x6LugMP7PIQE0AWtgSo+ogZGLNcJqkjHlISVChxtlw+J7ghm
         sv5uRMZKW0gzywVXu4QHmMXG/1+zov7NERwdgvbs/tKTz2hv2JuhQN2EmC3MQGhB0fwy
         Se4UjGidcidEB5whhd3hT5CNOsmzTE6GSGUqtPuEitGSfpeeRnwJ6ZnIdVd4qk1AL2B2
         LLPM0xBIThecXpaaCxerbdEGypI7L1fZdkY8Qn35jY6ArdnwsIxu6vQ9LYhUvtxA0RDx
         FYIQ==
X-Gm-Message-State: AJIora/FuM2ueqFCTmr9f0qguJgFFPHwusUDyjpZ1ZzE0dUE6TpJ9qf7
        cG0VgDUYnAg3nb5bQTL6oBL3AQ==
X-Google-Smtp-Source: AGRyM1uRSy4NzHoOWjBM1hcipF+dubrs0xwkLuyFRx39LNV4lYZ/tb0MHIx/gIFSTMcG1V4pq7jRgA==
X-Received: by 2002:a17:90b:f86:b0:1ef:90f2:884c with SMTP id ft6-20020a17090b0f8600b001ef90f2884cmr1086310pjb.91.1656936525252;
        Mon, 04 Jul 2022 05:08:45 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090ac24300b001ef8ab65052sm1690189pjx.11.2022.07.04.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 12/20] OPP: Migrate set-clk-name API to use set-config helpers
Date:   Mon,  4 Jul 2022 17:37:50 +0530
Message-Id: <0ae7b982b4c87940a01d78200295f7bc66cb67f7.1656935522.git.viresh.kumar@linaro.org>
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

Now that we have a central API to handle all OPP table configurations,
migrate the set-clk-name family of helpers to use the new
infrastructure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 142 +++++++++++++----------------------------
 include/linux/pm_opp.h |  41 +++++++-----
 2 files changed, 69 insertions(+), 114 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8dbdfff38973..0a82ca7ae453 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2164,104 +2164,71 @@ static void _opp_put_regulators(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_set_clkname() - Set clk name for the device
- * @dev: Device for which clk name is being set.
- * @name: Clk name.
- *
- * In order to support OPP switching, OPP layer needs to get pointer to the
- * clock for the device. Simple cases work fine without using this routine (i.e.
- * by passing connection-id as NULL), but for a device with multiple clocks
- * available, the OPP core needs to know the exact name of the clk to use.
+ * _opp_set_clknames() - Set clk names for the device
+ * @dev: Device for which clk names is being set.
+ * @names: Clk names.
+ *
+ * In order to support OPP switching, OPP layer needs to get pointers to the
+ * clocks for the device. Simple cases work fine without using this routine
+ * (i.e. by passing connection-id as NULL), but for a device with multiple
+ * clocks available, the OPP core needs to know the exact names of the clks to
+ * use.
  *
  * This must be called before any OPPs are initialized for the device.
  */
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
+static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
+			     const char * const names[])
 {
-	struct opp_table *opp_table;
-	int ret;
+	const char * const *temp = names;
+	int count = 0;
 
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
+	/* Count number of clks */
+	while (*temp++)
+		count++;
 
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
-		goto err;
-	}
+	/*
+	 * This is a special case where we have a single clock, whose connection
+	 * id name is NULL, i.e. first two entries are NULL in the array.
+	 */
+	if (!count && !names[1])
+		count = 1;
+
+	/* We support only one clock name for now */
+	if (count != 1)
+		return -EINVAL;
 
 	/* Another CPU that shares the OPP table has set the clkname ? */
 	if (opp_table->clk_configured)
-		return opp_table;
+		return 0;
 
 	/* clk shouldn't be initialized at this point */
-	if (WARN_ON(opp_table->clk)) {
-		ret = -EBUSY;
-		goto err;
-	}
+	if (WARN_ON(opp_table->clk))
+		return -EBUSY;
 
 	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, name);
+	opp_table->clk = clk_get(dev, names[0]);
 	if (IS_ERR(opp_table->clk)) {
-		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
+		return dev_err_probe(dev, PTR_ERR(opp_table->clk),
 				    "%s: Couldn't find clock\n", __func__);
-		goto err;
 	}
 
 	opp_table->clk_configured = true;
 
-	return opp_table;
-
-err:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ERR_PTR(ret);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
-
-/**
- * dev_pm_opp_put_clkname() - Releases resources blocked for clk.
- * @opp_table: OPP table returned from dev_pm_opp_set_clkname().
- */
-void dev_pm_opp_put_clkname(struct opp_table *opp_table)
-{
-	if (unlikely(!opp_table))
-		return;
-
-	clk_put(opp_table->clk);
-	opp_table->clk = ERR_PTR(-EINVAL);
-	opp_table->clk_configured = false;
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
-
-static void devm_pm_opp_clkname_release(void *data)
-{
-	dev_pm_opp_put_clkname(data);
+	return 0;
 }
 
 /**
- * devm_pm_opp_set_clkname() - Set clk name for the device
- * @dev: Device for which clk name is being set.
- * @name: Clk name.
- *
- * This is a resource-managed variant of dev_pm_opp_set_clkname().
- *
- * Return: 0 on success and errorno otherwise.
+ * _opp_put_clknames() - Releases resources blocked for clks.
+ * @opp_table: OPP table returned from _opp_set_clknames().
  */
-int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+static void _opp_put_clknames(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_clkname(dev, name);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_clkname_release,
-					opp_table);
+	if (opp_table->clk_configured) {
+		clk_put(opp_table->clk);
+		opp_table->clk = ERR_PTR(-EINVAL);
+		opp_table->clk_configured = false;
+	}
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_clkname);
 
 /**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
@@ -2544,7 +2511,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		dev_pm_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
-		dev_pm_opp_put_clkname(data->opp_table);
+		_opp_put_clknames(data->opp_table);
 
 	dev_pm_opp_put_opp_table(data->opp_table);
 	kfree(data);
@@ -2595,32 +2562,9 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure clocks */
 	if (config->clk_names) {
-		const char * const *temp = config->clk_names;
-		int count = 0;
-
-		/* Count number of clks */
-		while (*temp++)
-			count++;
-
-		/*
-		 * This is a special case where we have a single clock, whose
-		 * connection id name is NULL, i.e. first two entries are NULL
-		 * in the array.
-		 */
-		if (!count && !config->clk_names[1])
-			count = 1;
-
-		/* We support only one clock name for now */
-		if (count != 1) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		err = dev_pm_opp_set_clkname(dev, config->clk_names[0]);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_clknames(opp_table, dev, config->clk_names);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_CLK;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 94d0101c254c..ed1906bbe8bb 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -186,9 +186,6 @@ void dev_pm_opp_clear_config(int token);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
-void dev_pm_opp_put_clkname(struct opp_table *opp_table);
-int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
@@ -387,18 +384,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
@@ -629,4 +614,30 @@ static inline int devm_pm_opp_set_supported_hw(struct device *dev,
 	return devm_pm_opp_set_config(dev, &config);
 }
 
+/* clkname helpers */
+static inline int dev_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	const char *names[] = { name, NULL };
+	struct dev_pm_opp_config config = {
+		.clk_names = names,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_put_clkname(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
+
+static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	const char *names[] = { name, NULL };
+	struct dev_pm_opp_config config = {
+		.clk_names = names,
+	};
+
+	return devm_pm_opp_set_config(dev, &config);
+}
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

