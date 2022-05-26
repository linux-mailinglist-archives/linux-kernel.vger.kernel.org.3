Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B998534E85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiEZLqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347373AbiEZLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379AD6816
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c14so1506434pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GyYsGJSyLdpY6YjxA3xivfl9Pu65955UdoiLRgF0nI=;
        b=l8dxC5jwAwaKkGfZE/RaVevT1zFOqmGKUMqy3FpkiXne/z70OeEIECPflRPW7Q/Q6q
         vgL+4EYhQJmQF9x94iJehCaU/NO+bdf/s8cH1LIasc4Xe/UHp8D7R+CkOqwCysrgsEs6
         SosYZXHGvcrTLUC5xRKSzyFLrx/ZgOb/assJ9CVCbwUUPHhJjJOWajmiCtw8ttFdK59B
         f5pj57HHznA7bMim/Ujtfx5+wc+xPHAnLU6+MxhaLfY3C4O7jaHTXqHa/RyxtXnuBm1O
         9YSEew7XrNZmAzjRnDJQEXvOLIg7lfUOmldw2KGs0B96bU1m8KtJncLXbof6HB+IrwaO
         61GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GyYsGJSyLdpY6YjxA3xivfl9Pu65955UdoiLRgF0nI=;
        b=kQ2/j5Burw8nibHK2s1e90CNqz32fvChBkgJBq2nlFGvdaITyTfqx37+KXKgF8p4mr
         rz3x8l0SSFoJ0kCNbG0rlTFLL1x0ijKJDFCKavXdn65rmP8c6nXTEblaGb1SqGTFpPLY
         MnrtR+/+fP/i9DdW7istJIjJdDF44Q9C2CObyeqKioUi26m6fifOlKy4NdxhuYV0bnEx
         um1bS1FP+SpK9zNUO4yPM9SxHEvgNX332z2QSWsosgKGOYQLYixjZRgMFw79iuY2iy/n
         FVIq1rcpKOOUoZKt/npkq9m92JbKQ4noyxZAw/Y8zuFyTXqV1hFg4cv0hsFKak/D7a+T
         OEvQ==
X-Gm-Message-State: AOAM531Z399eySu3fuT8ojFwHQK6UG+sXaMda06sDhsRzTP0pJ/2XrWp
        oBj1vxblPFJ4n3hDthn00sJbQQ==
X-Google-Smtp-Source: ABdhPJy3YcgtcoDGxztR99tPx35mpt5XTIrynFTggmeVtJAPk0xKZu9fo/mKxviLaJs+DkLe26O7Rg==
X-Received: by 2002:a63:e449:0:b0:3fb:10d9:ec18 with SMTP id i9-20020a63e449000000b003fb10d9ec18mr2812166pgk.43.1653565484562;
        Thu, 26 May 2022 04:44:44 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79050000000b00518c6887217sm1277301pfo.58.2022.05.26.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/31] OPP: Remove dev_pm_opp_set_regulators() and friends
Date:   Thu, 26 May 2022 17:12:24 +0530
Message-Id: <799420aa820061490aadedc0e88e456ae6435401.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 95 ++++++++++--------------------------------
 include/linux/pm_opp.h | 17 --------
 2 files changed, 22 insertions(+), 90 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 30dbef0f4d17..9297b5e944f7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -987,8 +987,8 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	int size;
 
 	/*
-	 * We support this only if dev_pm_opp_set_regulators() was called
-	 * earlier.
+	 * We support this only if dev_pm_opp_set_config() was called
+	 * earlier to set regulators.
 	 */
 	if (opp_table->sod_supplies) {
 		size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
@@ -2093,7 +2093,7 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
 /**
- * dev_pm_opp_set_regulators() - Set regulator names for the device
+ * _opp_set_regulators() - Set regulator names for the device
  * @dev: Device for which regulator name is being set.
  * @names: Array of pointers to the names of the regulator.
  * @count: Number of regulators.
@@ -2104,36 +2104,22 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
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
@@ -2163,7 +2149,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	}
 	mutex_unlock(&opp_table->lock);
 
-	return opp_table;
+	return 0;
 
 free_regulators:
 	while (i != 0)
@@ -2172,26 +2158,20 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
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
@@ -2214,41 +2194,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
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
@@ -2634,6 +2580,7 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 					struct dev_pm_opp_config *config)
 {
 	struct opp_table *opp_table, *ret;
+	int err;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2676,10 +2623,13 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	// Configure supplies
 	if (config->regulator_names) {
-		ret = dev_pm_opp_set_regulators(dev, config->regulator_names,
-						config->regulator_count);
-		if (IS_ERR(ret))
+		err = _opp_set_regulators(opp_table, dev,
+					  config->regulator_names,
+					  config->regulator_count);
+		if (err) {
+			ret = ERR_PTR(err);
 			goto err;
+		}
 	}
 
 	// Attach genpds
@@ -2716,8 +2666,7 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
 	if (opp_table->genpd_virt_devs)
 		dev_pm_opp_detach_genpd(opp_table);
 
-	if (opp_table->regulators)
-		dev_pm_opp_put_regulators(opp_table);
+	_opp_put_regulators(opp_table);
 
 	if (opp_table->supported_hw)
 		dev_pm_opp_put_supported_hw(opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0d5d07dd164a..11896ebe1fb1 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -189,9 +189,6 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
-void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-int devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -409,20 +406,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
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

