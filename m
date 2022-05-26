Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE666534E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbiEZLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347247AbiEZLpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:45:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3C49902
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o9-20020a17090a0a0900b001df3fc52ea7so4201305pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dbbt9rtTwG4gE+OVtAcGxXUAaT1xVEW1UYgDSsh/rzE=;
        b=RMJaCg2x3lZF/5iUJrvARxD8NpTd27etPnDG2pI//KDguG2KVnVYA1Vid3+zb9nxDE
         MOvOtQBNMsI63JABXt/RV3B4/GopT0foiw+o+MN4QCxlG5PMCrGYSrGRhxLVGI6r+qqV
         9ezfS0eKACWvFuf0W4F/eN7Bh8E/AwrcvV06Fh5hF1CHAe+57zvywS+cp+lXniH3Q9gC
         qiL5hu/OiqLhL3uxF3zrekpxdOi92f8hKjGLxCZO3pZpc/KFOoofSRtSg9aJUT//1iVt
         IoRWc0bRVFsPHfth/4Yq3sJn4AqaeO719xDxIKkex+yMII8GrG0i5+wPs0YQSVWNuYW9
         YuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dbbt9rtTwG4gE+OVtAcGxXUAaT1xVEW1UYgDSsh/rzE=;
        b=gJ5eIadcekc4flae3SS9TfVbhU4bkD7cOGTlxQbb4/FbuLP9w6TW353ZU7x7s/FahS
         xfod/1W2K9rKpTTuIzyuQrZ9vSAGXoIM1upW3KXX3vmudRusDGokcsdfn7MalDKCn1Pq
         LQ5PU1pOC1gCNjkGoG9IhkvFWkOjsSW3jmI0BTLiILdfdG+QanTfScLAjaJ59wN3/Vqw
         MXZbFicDd/4OvWS6+AhGt8yB1cuvpnqoaHMXaw0OI6GFfY7QZYIuEoJpNvouddw2L4Ht
         DHBff4/kUuH/gVu8GG7NLrvQRe5x+DuRWTlN8DlfmEpi532m6YDDrqy1eaPGHlCa8Zll
         jxrw==
X-Gm-Message-State: AOAM5307abIAuWoki361+H2ErVQCP45fF8wtFCc8si0HREtLZSTpguyb
        28drqNqoIeXoZzDtsvOtdXkZQw==
X-Google-Smtp-Source: ABdhPJwBKKcXOxuOxaT5d0+aqOVq9sUzLdc5/qKsmCx09mE4+x79vnxjnvxlpxxSEytNTlDzdzl3lA==
X-Received: by 2002:a17:90a:8d08:b0:1e0:a2dc:c71b with SMTP id c8-20020a17090a8d0800b001e0a2dcc71bmr2227511pjo.72.1653565498266;
        Thu, 26 May 2022 04:44:58 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090ade1700b001cd4989fee4sm3460273pjv.48.2022.05.26.04.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/31] OPP: Remove dev_pm_opp_attach_genpd() and friends
Date:   Thu, 26 May 2022 17:12:28 +0530
Message-Id: <4315c9a6a29631e1671c9822efddfa6e95ae4d2d.1653564321.git.viresh.kumar@linaro.org>
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
public interface for dev_pm_opp_attach_genpd() and friends.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 86 ++++++++++--------------------------------
 include/linux/pm_opp.h | 17 ---------
 2 files changed, 20 insertions(+), 83 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 412af91d2039..69c6cf6a0bcc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2254,7 +2254,7 @@ static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	}
 }
 
-static void _opp_detach_genpd(struct opp_table *opp_table)
+static void _detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
@@ -2274,7 +2274,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
+ * _opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
  * @dev: Consumer device for which the genpd is getting attached.
  * @names: Null terminated array of pointers containing names of genpd to attach.
  * @virt_devs: Pointer to return the array of virtual devices.
@@ -2295,30 +2295,23 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * The order of entries in the names array must match the order in which
  * "required-opps" are added in DT.
  */
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
-		const char * const *names, struct device ***virt_devs)
+static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
+			     const char * const *names, struct device ***virt_devs)
 {
-	struct opp_table *opp_table;
 	struct device *virt_dev;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
 	if (opp_table->genpd_virt_devs)
-		return opp_table;
+		return 0;
 
 	/*
 	 * If the genpd's OPP table isn't already initialized, parsing of the
 	 * required-opps fail for dev. We should retry this after genpd's OPP
 	 * table is added.
 	 */
-	if (!opp_table->required_opp_count) {
-		ret = -EPROBE_DEFER;
-		goto put_table;
-	}
+	if (!opp_table->required_opp_count)
+		return -EPROBE_DEFER;
 
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
@@ -2351,74 +2344,34 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 		*virt_devs = opp_table->genpd_virt_devs;
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
-	return opp_table;
+	return 0;
 
 err:
-	_opp_detach_genpd(opp_table);
+	_detach_genpd(opp_table);
 unlock:
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
+	return ret;
 
-put_table:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_attach_genpd);
 
 /**
- * dev_pm_opp_detach_genpd() - Detach genpd(s) from the device.
- * @opp_table: OPP table returned by dev_pm_opp_attach_genpd().
+ * _opp_detach_genpd() - Detach genpd(s) from the device.
+ * @opp_table: OPP table returned by _opp_attach_genpd().
  *
  * This detaches the genpd(s), resets the virtual device pointers, and puts the
  * OPP table.
  */
-void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
+static void _opp_detach_genpd(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
 	 * used in parallel.
 	 */
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
-	_opp_detach_genpd(opp_table);
+	_detach_genpd(opp_table);
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
-
-static void devm_pm_opp_detach_genpd(void *data)
-{
-	dev_pm_opp_detach_genpd(data);
 }
 
-/**
- * devm_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual
- *			      device pointer
- * @dev: Consumer device for which the genpd is getting attached.
- * @names: Null terminated array of pointers containing names of genpd to attach.
- * @virt_devs: Pointer to return the array of virtual devices.
- *
- * This is a resource-managed version of dev_pm_opp_attach_genpd().
- *
- * Return: 0 on success and errorno otherwise.
- */
-int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
-			     struct device ***virt_devs)
-{
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_attach_genpd(dev, names, virt_devs);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_detach_genpd,
-					opp_table);
-}
-EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
-
 /**
  * dev_pm_opp_set_config() - Set OPP configuration for the device.
  * @dev: Device for which configuration is being set.
@@ -2495,10 +2448,12 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	// Attach genpds
 	if (config->genpd_names) {
-		ret = dev_pm_opp_attach_genpd(dev, config->genpd_names,
-					      config->virt_devs);
-		if (IS_ERR(ret))
+		err = _opp_attach_genpd(opp_table, dev, config->genpd_names,
+					config->virt_devs);
+		if (err) {
+			ret = ERR_PTR(err);
 			goto err;
+		}
 	}
 
 	return opp_table;
@@ -2524,8 +2479,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
  */
 void dev_pm_opp_clear_config(struct opp_table *opp_table)
 {
-	if (opp_table->genpd_virt_devs)
-		dev_pm_opp_detach_genpd(opp_table);
+	_opp_detach_genpd(opp_table);
 
 	_opp_put_regulators(opp_table);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0ad60c7dca02..a310564ab698 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -186,9 +186,6 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
-void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
-int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -367,20 +364,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_attach_genpd(struct device *dev,
-					   const char * const *names,
-					   struct device ***virt_devs)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.31.1.272.g89b43f80a514

