Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1768562E00
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiGAIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiGAIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:23:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37971240
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:22:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 65so1761870pfw.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XANjbhTBub5XHoBRNLuZd7Pb6PVjD97S/pZFiEt1YbY=;
        b=W7Cx0Lg4EyDga4Yut++xv8T+KBTxqHhtic0ssx/v94LPGfHUtZDXUx3qcvBM75BvBa
         wCjH7I2TvWbnLfBaJ37xv3n/uFYuc+yC4IZ9hoy2/8Oz0wV2563WaPtGlcStCdOysvmC
         zF5evz+GvUQYhPIavMYMJTGuUIhEptEuligjkj3BOtjVFOuBoe7vbnxBJvhCiqE80l1S
         F6VUnRerktHX/u8e/y7Ab4wozE7v+31JC3aYKGbrQ/rOdiWcLY7awhDC2+5OPkfwnvT0
         tu7gUMHg7PpRZy3KIEx0wL71KoQf7dZwr5Zrg4vV8y1byAyhRXEICArmNhmtgVMsCgBR
         OTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XANjbhTBub5XHoBRNLuZd7Pb6PVjD97S/pZFiEt1YbY=;
        b=WooYAYQ0MvcleijfblbEMwG3WxU8DCbOI7wEkHJ0QU1RSDOIUBNeTQzD0akHhNzA/L
         cRYHVxRChXdwgncm9Ymwc03IxFzvMKb3+Xk/LFtp4agfBl1TiJX8/+7ENhKFh+c1u5Si
         RDccoSbtUHxerCg6bkrSb+XMb8LlEyb6J9hu28oTgUch8LFoB5lu0GcD0bK9RYgQQhj4
         D8TMNtTizt2hRFwBDW8hVLHygk00rfhYyXR1FaQOTAf1ZOoQLtPw+YhfDmzXqkhQF01j
         h+LvI7+rABzZ4d7VMWUh7X64JBPQfh91hta4JGXlDB2ro8b7Cq3U71A4v5gAWH2RRLPL
         K2og==
X-Gm-Message-State: AJIora8bVk/zTWsVpEG4FHavJqFUKq5km8N6xVUzmP1m/SRFhdSsSLRz
        i1rwJyccz8pNE83i98XL8SCEeNfBXTsQBA==
X-Google-Smtp-Source: AGRyM1t84AdrZW1AhlOsY0MmPKB6SaWGJmuBXLJYddD+X/DPin5PVzUGLJ1t4zWBJeGX8IaPMcVrKQ==
X-Received: by 2002:a63:234f:0:b0:405:3981:be7 with SMTP id u15-20020a63234f000000b0040539810be7mr11390828pgm.15.1656663727059;
        Fri, 01 Jul 2022 01:22:07 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b00163fbb1eec5sm14766729plk.229.2022.07.01.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:22:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 29/30] OPP: Remove dev_pm_opp_attach_genpd() and friends
Date:   Fri,  1 Jul 2022 13:50:24 +0530
Message-Id: <dcb615e5aedd159a4e8816ef3da6e8c8c6017a12.1656660185.git.viresh.kumar@linaro.org>
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
public interface for dev_pm_opp_attach_genpd() and friends.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 85 +++++++++---------------------------------
 include/linux/pm_opp.h | 17 ---------
 2 files changed, 18 insertions(+), 84 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3040e735fe1c..17e9d272026f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2263,7 +2263,7 @@ static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	}
 }
 
-static void _opp_detach_genpd(struct opp_table *opp_table)
+static void _detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
@@ -2283,7 +2283,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
+ * _opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
  * @dev: Consumer device for which the genpd is getting attached.
  * @names: Null terminated array of pointers containing names of genpd to attach.
  * @virt_devs: Pointer to return the array of virtual devices.
@@ -2304,30 +2304,23 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
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
 
@@ -2360,78 +2353,38 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
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
@@ -2544,12 +2497,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
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
index 75edb6a14a76..63ad7870ae11 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -189,9 +189,6 @@ void dev_pm_opp_clear_config(int token);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
-void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
-int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -370,20 +367,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
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
-- 
2.31.1.272.g89b43f80a514

