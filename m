Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25B565481
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiGDMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiGDMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD912613
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y141so8787534pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVwwsLgblRII0czn7jaGcIQ0lMjiB5lW3Rzfz9bgHNA=;
        b=rpR3CZu8opaXuJUwHDy4f7GFgdLnkIR+SOHvjjmy4HU7iprbXBo0ORpawDhL4k5o+y
         EYLC4i7Ql6GJkkZePrPYrXwaxSumynWMJqjpPI0Ubtq6ZH1mmFJu64y6r4gYvLHSRn4c
         fHfxoulWAtF1uyW8V+8nvmlH3a0XeueJ7eMJOdQ0TMi0a9+ri41DlHcHDFsKR3DI6F6k
         Yk7iS7LBp3QdlmWTc1qqYvef7TUlfyV/bCqX5ktwiv54WAHemMgL0hGCbaoLuM3hY4iv
         pA1c+XWMOVGal61DAF77CvWvdfhsV34zGthHbenJ3UppKgEeQgbqJqqTPirvMPkvLT6P
         9W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVwwsLgblRII0czn7jaGcIQ0lMjiB5lW3Rzfz9bgHNA=;
        b=twRmCWjdg886U61ParppQ7vHhkrpe5MuzhlSfl9jq435TNTg4GV6qJ9Z+em3Bg0iuv
         ldyGGPoc8dqx1d8+6SrHHUEG5qDTw65GzLB1dGsuTb77uTaOjWgUBcrcqttAylhaU6WG
         2m4AhN9QRW/X+bXgnnbwP+GMygJzhuCMPxruvc2Z8DOU1CcJhYiVQJjJ9z9zBGuy4vhi
         Lh+EV4rtI9AK0Y3TXtDKd8u0aP2mOXwb+NekzyA1spD7m9u5y71MzuNnGCrjAtkzo8qQ
         9OM0fQyIG4f8o960HC4zxYgzdZicNXUExtbyq67Wz5XCHvR7rRdD0nqgI1PX+KrdNTSw
         2MMg==
X-Gm-Message-State: AJIora8zhhBWjmEGa6FTaoHQkwjdBeGGew+jYRRileaiQ7ouVN79YI0z
        SOf3cFU002qKaEqLSl8yAJP7Pg==
X-Google-Smtp-Source: AGRyM1tEGWdGdhPMOgJAEhZ+sfknlv72HahQgSA+crudG5Z82VdZWqpx/T5Q1fDVW+U5oi9RP3unRA==
X-Received: by 2002:a05:6a00:2292:b0:525:6c57:8dd5 with SMTP id f18-20020a056a00229200b005256c578dd5mr35612660pfe.17.1656936531161;
        Mon, 04 Jul 2022 05:08:51 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm20465980pll.103.2022.07.04.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:50 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 14/20] OPP: Migrate attach-genpd API to use set-config helpers
Date:   Mon,  4 Jul 2022 17:37:52 +0530
Message-Id: <e83f3c8bb94b822fddbf331c2a6938765b7b43f5.1656935522.git.viresh.kumar@linaro.org>
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
migrate the attach-genpd family of helpers to use the new
infrastructure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 85 +++++++++---------------------------------
 include/linux/pm_opp.h | 48 +++++++++++++++---------
 2 files changed, 49 insertions(+), 84 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9da7dcf62cab..458584994c2b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2285,7 +2285,7 @@ static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	}
 }
 
-static void _opp_detach_genpd(struct opp_table *opp_table)
+static void _detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
@@ -2305,7 +2305,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
+ * _opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
  * @dev: Consumer device for which the genpd is getting attached.
  * @names: Null terminated array of pointers containing names of genpd to attach.
  * @virt_devs: Pointer to return the array of virtual devices.
@@ -2326,30 +2326,23 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * The order of entries in the names array must match the order in which
  * "required-opps" are added in DT.
  */
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
-		const char * const *names, struct device ***virt_devs)
+static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
+			const char * const *names, struct device ***virt_devs)
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
 
@@ -2382,78 +2375,38 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
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
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
-
-static void devm_pm_opp_detach_genpd(void *data)
-{
-	dev_pm_opp_detach_genpd(data);
-}
-
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
 
 static void _opp_clear_config(struct opp_config_data *data)
 {
 	if (data->flags & OPP_CONFIG_GENPD)
-		dev_pm_opp_detach_genpd(data->opp_table);
+		_opp_detach_genpd(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
@@ -2564,12 +2517,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Attach genpds */
 	if (config->genpd_names) {
-		err = dev_pm_opp_attach_genpd(dev, config->genpd_names,
-					      config->virt_devs);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
+					config->virt_devs);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_GENPD;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 85a4b7353979..20e1e5060a8a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -186,9 +186,6 @@ void dev_pm_opp_clear_config(int token);
 
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
 static inline int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
 	return -EOPNOTSUPP;
@@ -639,4 +622,35 @@ static inline void dev_pm_opp_unregister_set_opp_helper(int token)
 	dev_pm_opp_clear_config(token);
 }
 
+/* genpd helpers */
+static inline int dev_pm_opp_attach_genpd(struct device *dev,
+					  const char * const *names,
+					  struct device ***virt_devs)
+{
+	struct dev_pm_opp_config config = {
+		.genpd_names = names,
+		.virt_devs = virt_devs,
+	};
+
+	return dev_pm_opp_set_config(dev, &config);
+}
+
+static inline void dev_pm_opp_detach_genpd(int token)
+{
+	dev_pm_opp_clear_config(token);
+}
+
+static inline int devm_pm_opp_attach_genpd(struct device *dev,
+					   const char * const *names,
+					   struct device ***virt_devs)
+{
+	struct dev_pm_opp_config config = {
+		.genpd_names = names,
+		.virt_devs = virt_devs,
+	};
+
+	return devm_pm_opp_set_config(dev, &config);
+}
+
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

