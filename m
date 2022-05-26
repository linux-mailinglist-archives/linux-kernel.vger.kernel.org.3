Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC4534E88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiEZLrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbiEZLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:45:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B449CA8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso1498543pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zj/X9v0Ajk3j0h5jIjtZCy0tKeDQQruHCgdom/4N+fE=;
        b=U/V4UcPcLkWJkdGIRwJy0tswczFFYYaIGT2CDAXbuN0JoVSeAZUKZXu4Ka2obvSiai
         L2KHfqeSxBTNCvLL1IK08FgZuPZve4kjb3KOilm1deUNTzZDqjfcEyRZDURlPXioAXek
         eFXFPvyrw46QHBTLtq3ZhkdaK6LbuneA18MG37t9UlAekE79jRB3cBsCmjzGK4GAgQ/Y
         eWXv/56iFVf7mc4kHG/UKLVAz51BYJi+Mwijkn42xXEGPsQ2nDjymSGZGvB3ZRPIcTzQ
         7kB3eig6NDeuU7IeIHVazkPuQ+0zEx7SYFoUQjcgRrfoTf/h0S6SdVf/BSXC3shdU5qr
         dZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zj/X9v0Ajk3j0h5jIjtZCy0tKeDQQruHCgdom/4N+fE=;
        b=X58G+/KzaZxSm4p3mxb7N4M1DeAA8uFiCK7Ejv6b9B5QZbMEDhe4IdzHboDIy8wBSf
         FksbtUuQNwxJRXcT02/kjp11cT8lIspWRRPmbZePkX0Chk8a2JXVizXRQe75XVGFH/N2
         LPzwZBh7JCrJCq240J3lp6pS5eev7dxup75YxBxvkf7sVoDJGvnTm0p1pGmv0lKpgYMW
         PSB34xRWO/ms6MxYy7Qu1fZQJi9LKERR+iNoxhyjasxtIEL32CkVrRaAev6/Ai+IaHgb
         p7G5LwTlJLFei5F2+QBKVV8/Z75xP9Y/mMG6S8N5ruI2cKS/O3XzloCZtGXAdlfqi7JT
         OUPA==
X-Gm-Message-State: AOAM532py5j4VDO/eb6ZHVHaX3t2ftLKnILMvcZFHzD6f/+rAzT484es
        +4JctPxGdJ2JM+HCYq6MdsM4MA==
X-Google-Smtp-Source: ABdhPJx3oV20cSATo8EtQIznnkfiy5wuf99iIOs0u2A3+24tbOHrxkqOWihSZ2kKVl34dIQ6MIAsmg==
X-Received: by 2002:a17:902:c2c7:b0:159:9f9:85f3 with SMTP id c7-20020a170902c2c700b0015909f985f3mr37050021pla.18.1653565494869;
        Thu, 26 May 2022 04:44:54 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709027c0100b0016194c1df58sm1315235pll.105.2022.05.26.04.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/31] OPP: Remove dev_pm_opp_register_set_opp_helper() and friends
Date:   Thu, 26 May 2022 17:12:27 +0530
Message-Id: <c585acc9d9f8434070d74e6209bef05ef8ad4729.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 89 ++++++++++--------------------------------
 include/linux/pm_opp.h | 17 --------
 2 files changed, 21 insertions(+), 85 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c2590c0c05a0..412af91d2039 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2200,7 +2200,7 @@ static void _opp_put_clkname(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
+ * _opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
  * @set_opp: Custom set OPP helper.
  *
@@ -2209,32 +2209,18 @@ static void _opp_put_clkname(struct opp_table *opp_table)
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
@@ -2247,60 +2233,26 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 
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
-{
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
+static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 {
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
@@ -2513,9 +2465,11 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	// Configure opp helper
 	if (config->set_opp) {
-		ret = dev_pm_opp_register_set_opp_helper(dev, config->set_opp);
-		if (IS_ERR(ret))
+		err = _opp_register_set_opp_helper(opp_table, dev, config->set_opp);
+		if (err) {
+			ret = ERR_PTR(err);
 			goto err;
+		}
 	}
 
 	// Configure supported hardware
@@ -2577,8 +2531,7 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
 
 	_opp_put_supported_hw(opp_table);
 
-	if (opp_table->set_opp)
-		dev_pm_opp_unregister_set_opp_helper(opp_table);
+	_opp_unregister_set_opp_helper(opp_table);
 
 	if (opp_table->prop_name)
 		dev_pm_opp_put_prop_name(opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 7afa8160590d..0ad60c7dca02 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -186,9 +186,6 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table);
 
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
-- 
2.31.1.272.g89b43f80a514

