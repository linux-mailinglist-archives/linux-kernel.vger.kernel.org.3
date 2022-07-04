Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E907256547F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiGDMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiGDMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7BD12627
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4075998pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xhiD9amdZ6J7ogRI+kKZI/KO8vtgIY0dvS9gGM+qI8=;
        b=qkjX0dVwiicUWd3IVn3k5ZhFosaWDSgUjoZYwP2bSD2KQhZqxJcI4tHkkYFU/FeBRW
         BHoaUa6qQcjmlfxvRx93i9qKVFkWa8ZHXKl4NauFD9sS95i1C/vHdciswWtQsZjSYz1k
         VHrxnwB5FqQsLIjwhU+kwW+BnOpaE5u12g1ZBYSOnl40lDdUL3n0I4ar+aXYviR0xguv
         LAzfHBvayaiqioepZEy2kPswJRwxu/z+1l0D1oRrZQX+/zrg//yb1emo4734VbtzFRf1
         FIxxeAVtZu2zt6KaEVZQwofCGii19RO3v7X4LuOjZBkwUMfPjw0cHKP4WTovhBEeDrmI
         oQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xhiD9amdZ6J7ogRI+kKZI/KO8vtgIY0dvS9gGM+qI8=;
        b=wruSv8sboxtx0a5KDjrCd00emi8b0aL69YFBt0E/nTejNykb9f/nC7wBzIz8MIEkR2
         jxyds3BzkXzWiv/nD0ZAbjLdxe+luF+0TUc6qEcneHt/jOMf7misW5meEBf86ZJQ4sj4
         l0vCfQRo2GQrVaTc1ituxizlMDK+uxBIzvSD026wmXfQXTXP9j4cezw/VGGVFflCfkYO
         HFDA4bpc2Oqof1wj43qfbhhQ6hsXYVOqOgrufWZhZWsiJFGnRU9cTfjHxF/Te3t7BnxX
         A1DoGWa0DupgFGk3jXA9YShApWmEZP8BqkZzzcks+eB4N0jPJPY59MEg+1vlN6dYTaiP
         t4cg==
X-Gm-Message-State: AJIora/wpsobVkeYjhBHPKkb3IMCycF5bvJHj6WeHZ5mMyAJGTie4vyV
        X1Bj4hOd1LDX/bzA/G3vKuVHHQ==
X-Google-Smtp-Source: AGRyM1tBz/4s/3409KodSTMaww+Cy4Z/YO6/yZnOkRIVzLkC7L8iDGtr3uoenKxm+mtquKSoJW1PZA==
X-Received: by 2002:a17:90b:4a0c:b0:1ec:d90c:601d with SMTP id kk12-20020a17090b4a0c00b001ecd90c601dmr35151468pjb.154.1656936528249;
        Mon, 04 Jul 2022 05:08:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a00c800b001ef869aa755sm2459835pjd.15.2022.07.04.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 13/20] OPP: Migrate set-opp-helper API to use set-config helpers
Date:   Mon,  4 Jul 2022 17:37:51 +0530
Message-Id: <7274b73c609073e40461467a6d6cc211ef772bb0.1656935522.git.viresh.kumar@linaro.org>
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
migrate the set-opp-helper family of helpers to use the new
infrastructure.

The return type and parameter to the APIs change a bit due to this,
update the current users as well in the same commit in order to avoid
breaking builds.

Remove devm_pm_opp_register_set_opp_helper() as it has no users
currently.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c          | 89 +++++++++----------------------------
 drivers/opp/ti-opp-supply.c |  6 +--
 include/linux/pm_opp.h      | 33 +++++++-------
 3 files changed, 39 insertions(+), 89 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0a82ca7ae453..9da7dcf62cab 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2231,7 +2231,7 @@ static void _opp_put_clknames(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
+ * _opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
  * @set_opp: Custom set OPP helper.
  *
@@ -2240,32 +2240,18 @@ static void _opp_put_clknames(struct opp_table *opp_table)
  *
  * This must be called before any OPPs are initialized for the device.
  */
-struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
-			int (*set_opp)(struct dev_pm_set_opp_data *data))
+static int _opp_register_set_opp_helper(struct opp_table *opp_table,
+	struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
 	struct dev_pm_set_opp_data *data;
-	struct opp_table *opp_table;
-
-	if (!set_opp)
-		return ERR_PTR(-EINVAL);
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-EBUSY);
-	}
 
 	/* Another CPU that shares the OPP table has set the helper ? */
 	if (opp_table->set_opp)
-		return opp_table;
+		return 0;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	mutex_lock(&opp_table->lock);
 	opp_table->set_opp_data = data;
@@ -2278,60 +2264,26 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 
 	opp_table->set_opp = set_opp;
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_opp_helper);
 
 /**
- * dev_pm_opp_unregister_set_opp_helper() - Releases resources blocked for
- *					   set_opp helper
- * @opp_table: OPP table returned from dev_pm_opp_register_set_opp_helper().
+ * _opp_unregister_set_opp_helper() - Releases resources blocked for set_opp helper
+ * @opp_table: OPP table returned from _opp_register_set_opp_helper().
  *
  * Release resources blocked for platform specific set_opp helper.
  */
-void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
+static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
-	opp_table->set_opp = NULL;
-
-	mutex_lock(&opp_table->lock);
-	kfree(opp_table->set_opp_data);
-	opp_table->set_opp_data = NULL;
-	mutex_unlock(&opp_table->lock);
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
-
-static void devm_pm_opp_unregister_set_opp_helper(void *data)
-{
-	dev_pm_opp_unregister_set_opp_helper(data);
-}
-
-/**
- * devm_pm_opp_register_set_opp_helper() - Register custom set OPP helper
- * @dev: Device for which the helper is getting registered.
- * @set_opp: Custom set OPP helper.
- *
- * This is a resource-managed version of dev_pm_opp_register_set_opp_helper().
- *
- * Return: 0 on success and errorno otherwise.
- */
-int devm_pm_opp_register_set_opp_helper(struct device *dev,
-					int (*set_opp)(struct dev_pm_set_opp_data *data))
-{
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_register_set_opp_helper(dev, set_opp);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
+	if (opp_table->set_opp) {
+		opp_table->set_opp = NULL;
 
-	return devm_add_action_or_reset(dev, devm_pm_opp_unregister_set_opp_helper,
-					opp_table);
+		mutex_lock(&opp_table->lock);
+		kfree(opp_table->set_opp_data);
+		opp_table->set_opp_data = NULL;
+		mutex_unlock(&opp_table->lock);
+	}
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_register_set_opp_helper);
 
 static void _opp_detach_genpd(struct opp_table *opp_table)
 {
@@ -2507,7 +2459,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		_opp_put_supported_hw(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
-		dev_pm_opp_unregister_set_opp_helper(data->opp_table);
+		_opp_unregister_set_opp_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		dev_pm_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
@@ -2582,11 +2534,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure opp helper */
 	if (config->set_opp) {
-		err = dev_pm_opp_register_set_opp_helper(dev, config->set_opp);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_register_set_opp_helper(opp_table, dev,
+						   config->set_opp);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_REGULATOR_HELPER;
 	}
diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index bd4771f388ab..40ebc9ac82dd 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -405,9 +405,9 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = PTR_ERR_OR_ZERO(dev_pm_opp_register_set_opp_helper(cpu_dev,
-								 ti_opp_supply_set_opp));
-	if (ret)
+	ret = dev_pm_opp_register_set_opp_helper(cpu_dev,
+						 ti_opp_supply_set_opp);
+	if (ret < 0)
 		_free_optimized_voltages(dev, &opp_data);
 
 	return ret;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ed1906bbe8bb..85a4b7353979 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -186,9 +186,6 @@ void dev_pm_opp_clear_config(int token);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
@@ -363,20 +360,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
-			int (*set_opp)(struct dev_pm_set_opp_data *data))
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_register_set_opp_helper(struct device *dev,
-				    int (*set_opp)(struct dev_pm_set_opp_data *data))
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
@@ -640,4 +623,20 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
 	return devm_pm_opp_set_config(dev, &config);
 }
 
+/* set-opp helpers */
+static inline int dev_pm_opp_register_set_opp_helper(struct device *dev,
+			int (*set_opp)(struct dev_pm_set_opp_data *data))
+{
+	struct dev_pm_opp_config config = {
+		.set_opp = set_opp,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_unregister_set_opp_helper(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

