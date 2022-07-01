Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB989562E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiGAIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiGAIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:23:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECBE735A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:22:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n10so1759784plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=occJkHHu6x23QwNkK+mJiCbcRgGi/dU2FHiFOrlSYbY=;
        b=DfpOjzJqDmPgNlzLJG3E0dPhRhARULlPZWnEvfN4mlod27WHw/HwD4Ex/MzoFQt1lq
         ifaj5yfIE6DUaoG5Bt1xQzabIKqyNR6Q8zkPi3nHG8wYin+qUA65PczAZvfLhvzrl49v
         B/XMtibfwIDlAHCsII0r2WlMX7JCcVnq4WPQv/6RlKMJe7V4AwcBdUGILNGqlZF80IYB
         QqlCJQUhhzZ/8EBF6XHG6ZzpS0vfmOgQtZu1KGHr77B71D6PiWItGdTq5CJtpeym+DLx
         D8iMcM2dppFv/MbFWz1rCqIZ9EybSx18pDpie1y7iI+befL7X0w+1ht/ZG44Sd1eWdHa
         nCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=occJkHHu6x23QwNkK+mJiCbcRgGi/dU2FHiFOrlSYbY=;
        b=17hhEnewnpY+oN6emjKPKO1Ly/9UpMHO12SnAdWxbDaZRvW3pbIVi5a8ahvrl/4db4
         fzelTFHDe97rzuCvWzB53H/Zy1rL6ktCQs8A1LZwk3H2IbgEKrfo92l7MARWBdC7RUYt
         a5QFqHKV9Pjprh2vFlP2OMRGfeg+M1CZDaeQexwJfUAH/bt9p4c0uVLMeOPdqkku99iA
         xtYrhnKEKf1Qn56us67IQqOuLORsypb6p45mV+A/9S0lifVXCdRHjCWi7HhhxqyK0feO
         wB9mN9WExb9+/En4EyrGi49REBzJf857969vd8WMWNdfodgv+aoDz028PU8vNX4jqStZ
         DpHg==
X-Gm-Message-State: AJIora/cfcajfc02+6ZAVULssR0fQn9E97S/osVX7hE2P7DafYA9IYTV
        u3jToFYpt47NuS9XvOe1TgsFcg==
X-Google-Smtp-Source: AGRyM1tRf7aYIs8kaHYiDj0HDOku3J/sNXhwvKbJc66rflsZjIYdVXvYfQ3uUMgzTYIS8F1RbLX8mA==
X-Received: by 2002:a17:90b:194:b0:1ec:96dd:fef2 with SMTP id t20-20020a17090b019400b001ec96ddfef2mr14832285pjs.195.1656663723813;
        Fri, 01 Jul 2022 01:22:03 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027e4500b0016784c93f23sm14762687pln.197.2022.07.01.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:22:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 28/30] OPP: Remove dev_pm_opp_register_set_opp_helper() and friends
Date:   Fri,  1 Jul 2022 13:50:23 +0530
Message-Id: <188bd4f0cdaa5aa79e5d112d2dd623c0603ef25c.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

Now that everyone has migrated to dev_pm_opp_set_config(), remove the
public interface for dev_pm_opp_register_set_opp_helper() and friends.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 89 ++++++++++--------------------------------
 include/linux/pm_opp.h | 17 --------
 2 files changed, 20 insertions(+), 86 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9b4f67994993..3040e735fe1c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2209,7 +2209,7 @@ static void _opp_put_clknames(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
+ * _opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
  * @set_opp: Custom set OPP helper.
  *
@@ -2218,32 +2218,18 @@ static void _opp_put_clknames(struct opp_table *opp_table)
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
@@ -2256,60 +2242,26 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 
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
@@ -2485,7 +2437,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
 		_opp_put_supported_hw(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
-		dev_pm_opp_unregister_set_opp_helper(data->opp_table);
+		_opp_unregister_set_opp_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		dev_pm_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
@@ -2561,11 +2513,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
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
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 31062dc216f3..75edb6a14a76 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -189,9 +189,6 @@ void dev_pm_opp_clear_config(int token);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
@@ -366,20 +363,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
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
-- 
2.31.1.272.g89b43f80a514

