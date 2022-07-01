Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56D562DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiGAIXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiGAIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:22:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5473599
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:21:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d14so1925270pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crygxFK87eEaJSYA5aOZhpi4Df1w8ys65sC4v5ffens=;
        b=kXecoXn8caaRsH99aYcVNrxI+LEFLvRi8Ie0t4paFBsjOalZPXlhCtB7JuiOtw72rw
         Gd0jvkF+/iXhZUo7/Ks6Ak9ylG/HCPCbB5bEIWn7hiedJ25UeCge4I0cMHJMwD6Z9rbx
         qLSBnAukCipBFg0iYDag8vIEcevYgP89jc9PCL0kNrayy0M5PLz3bEe/JNcl9wwbrcon
         1Lsm4DALGAqKvwbWfHjp5ybDXaNuz7xomV700LtNOKJO5PvaGb/6T9erNJIjdA+fB0dE
         t7W6EXpCOt0IGN25ESQ8p2eJl7CUEwMi7RgINyJjl0MnL7gCsjt5itNoiqwPp+4Jsjrw
         fqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crygxFK87eEaJSYA5aOZhpi4Df1w8ys65sC4v5ffens=;
        b=ysGTqJSiWCGc+jlggJ9znso0pkjOx4VKnR65crzqrHYoiLGVXZS46JRmDi5dcVucpb
         0YVkMPedkF7BpBbP8WhXkI35zk55HpdQkHxA7bIWkq6fPZW7dxnr1kEe9mV5PdCC1HGS
         OD0NRWzoCiy4TnnUSdG05L47wdnxKTppqYErRZhA9A7njih25Mnmf8FZM83jI7U0ttue
         wEEGiuKmY4L3YHiU9I6DRzZ5uvJ/9hY3RI6zlQeaqD6g8WrFJBdtZbaceSDGloe9pMNf
         Dwo2yIUdTdQngIIyFmlANmKh6I8zo2zkzwcq6jIONyzk/k9hgtWJBhx3CDiQX64zjjQ4
         BQoQ==
X-Gm-Message-State: AJIora8J5jxZgwUKDhn/hIkSSUlJsXWIZ1pdrupN7pWcNBIZnfKjXcL5
        atOu0WdCbGKCYXXjWIWpv0WjxQ==
X-Google-Smtp-Source: AGRyM1vEoNgBJMaMW7uCv2ZUckPLmdNP1SmWYvXp6o7N8Ccdms8gxqRDN4kS+TiqjGx/9pqo3LA0DQ==
X-Received: by 2002:a17:90b:4b41:b0:1ec:cb06:2fa3 with SMTP id mi1-20020a17090b4b4100b001eccb062fa3mr14795607pjb.55.1656663715023;
        Fri, 01 Jul 2022 01:21:55 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b00161a9df4de8sm15046287plf.145.2022.07.01.01.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 25/30] OPP: Remove dev_pm_opp_set_regulators() and friends
Date:   Fri,  1 Jul 2022 13:50:20 +0530
Message-Id: <0929adcdec2aad013235f36c8c5c2910b6f64a66.1656660185.git.viresh.kumar@linaro.org>
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

Now that everyone has migrated to dev_pm_opp_set_config(), remove the
public interface for dev_pm_opp_set_regulators() and friends.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 93 +++++++++---------------------------------
 include/linux/pm_opp.h | 17 --------
 2 files changed, 19 insertions(+), 91 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c77ea05ee2cd..fc3cd87ee7df 100644
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
@@ -2108,36 +2108,22 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
  *
  * This must be called before any OPPs are initialized for the device.
  */
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
-					    const char * const names[],
-					    unsigned int count)
+static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
+			       const char * const names[], unsigned int count)
 {
 	struct dev_pm_opp_supply *supplies;
-	struct opp_table *opp_table;
 	struct regulator *reg;
 	int ret, i;
 
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
-		goto err;
-	}
-
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
@@ -2167,7 +2153,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	}
 	mutex_unlock(&opp_table->lock);
 
-	return opp_table;
+	return 0;
 
 free_regulators:
 	while (i != 0)
@@ -2176,26 +2162,20 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
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
@@ -2218,41 +2198,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
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
-			       const char * const names[],
-			       unsigned int count)
-{
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_regulators(dev, names, count);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_regulators_release,
-					opp_table);
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_regulators);
 
 /**
  * dev_pm_opp_set_clkname() - Set clk name for the device
@@ -2627,7 +2573,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_GENPD)
 		dev_pm_opp_detach_genpd(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR)
-		dev_pm_opp_put_regulators(data->opp_table);
+		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		dev_pm_opp_put_supported_hw(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
@@ -2737,12 +2683,11 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure supplies */
 	if (config->regulator_names) {
-		err = dev_pm_opp_set_regulators(dev, config->regulator_names,
-						config->regulator_count);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_regulators(opp_table, dev,
+					  config->regulator_names,
+					  config->regulator_count);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_REGULATOR;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 467bed35130e..0dc45d4403ce 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -192,9 +192,6 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
-void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-int devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -412,20 +409,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_regulators(struct device *dev,
-					     const char * const names[],
-					     unsigned int count)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.31.1.272.g89b43f80a514

