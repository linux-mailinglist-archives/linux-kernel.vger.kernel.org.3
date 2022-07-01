Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E43562DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiGAIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiGAIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:24:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C473904
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:22:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g7so1940724pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7SNzEv2Y0yMoLr0YW1Rr4xpG010Vhadeq8nxGyUQ7g=;
        b=AuEQTOaWqe6eTjPtJvstSxgy2AATbxAiNYqJCbiYyAruGoKmeax/KPtEzFE8BZBJz3
         oUJCxJM00l3FliWHHMVx+C0vwCxSL3G7n4I23Flwy07sszZiEamRbMbBgrcqQD332OaZ
         xZTBHv8XLmpiM2Zi4JAGOWsZFduMuM53NSHjVMYYzJoLNdeZkX1M0bAYPDeRPBXgCtJx
         AEJmetHGYtoKEKviGJ3y1QgRm4TzV0yqSFfbg4UfePNRkwYRnthFiLRgXRN1C/gcZMb7
         K7iN+pu5eTUo2DccCPImrvoqwM+8Yx8woObRknJvjFZqKBMJtRXoCEoGng4XGfNQ0J1j
         giGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7SNzEv2Y0yMoLr0YW1Rr4xpG010Vhadeq8nxGyUQ7g=;
        b=rpzC3raSVJk+wyQzhGfVDNK7PdE5NdL2HqZvbpSSwGbZcKQFxLuzqJxrq1IaVsxB/z
         RJnRS5f9nMU+7TxG9OOew7LTG7JxjTMzTDl+uzwwsCQm6GzUNn6qOATFw9714n5IsfUv
         V2jVW1pG2/lWO1O1Z0L+6lhCVkJ7pGq8kS2/n4flLrxLawoHGmVH1D6/GmBIjxFMOTYT
         0/ZImbFl4jVSqwMGcvFgxzLUmXX7PWdMj50VbEjhJxVrxZuNlCz3z4DHr7T61qDLOI8+
         vKfjvyUVovHv2zkDk6ELa5Ai1kfwu5utyXEvO5YrPAwSge02dA0VpY21nlvm4nbVXUlw
         0kGA==
X-Gm-Message-State: AJIora+72wTlQRl83EqGO9wTC7D7Q6VpaG2x/gMOcgvXvL7SlKX2NuOT
        lkDame7Xsi29ZriCfjc2kv1Uqg==
X-Google-Smtp-Source: AGRyM1umn8qHkGZedvpCETfMBY/tg0uf0IicbyM848kvybseXS0QBaHz8B9yPUnGvGAzb16e6fVmtg==
X-Received: by 2002:a17:902:e983:b0:16a:2221:fc99 with SMTP id f3-20020a170902e98300b0016a2221fc99mr18533979plb.19.1656663730172;
        Fri, 01 Jul 2022 01:22:10 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id s26-20020a65645a000000b0040c755b7651sm14813778pgv.41.2022.07.01.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:22:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 30/30] OPP: Remove dev_pm_opp_set_prop_name() and friends
Date:   Fri,  1 Jul 2022 13:50:25 +0530
Message-Id: <100facac98a8f481fdb4f3cedd6a760c627d0239.1656660185.git.viresh.kumar@linaro.org>
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
public interface for dev_pm_opp_set_prop_name() and friends.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 55 ++++++++++++++----------------------------
 include/linux/pm_opp.h |  9 -------
 2 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 17e9d272026f..75bb570d30e4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1997,7 +1997,7 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_set_prop_name() - Set prop-extn name
+ * _opp_set_prop_name() - Set prop-extn name
  * @dev: Device for which the prop-name has to be set.
  * @name: name to postfix to properties.
  *
@@ -2006,50 +2006,33 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
  * which the extension will apply are opp-microvolt and opp-microamp. OPP core
  * should postfix the property name with -<name> while looking for them.
  */
-struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
+static int _opp_set_prop_name(struct opp_table *opp_table, const char *name)
 {
-	struct opp_table *opp_table;
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	/* Another CPU that shares the OPP table has set the property ? */
-	if (opp_table->prop_name)
-		return opp_table;
-
-	opp_table->prop_name = kstrdup(name, GFP_KERNEL);
 	if (!opp_table->prop_name) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-ENOMEM);
+		opp_table->prop_name = kstrdup(name, GFP_KERNEL);
+		if (!opp_table->prop_name)
+			return -ENOMEM;
 	}
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
 
 /**
- * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-name
- * @opp_table: OPP table returned by dev_pm_opp_set_prop_name().
+ * _opp_put_prop_name() - Releases resources blocked for prop-name
+ * @opp_table: OPP table returned by _opp_set_prop_name().
  *
  * This is required only for the V2 bindings, and is called for a matching
- * dev_pm_opp_set_prop_name(). Until this is called, the opp_table structure
+ * _opp_set_prop_name(). Until this is called, the opp_table structure
  * will not be freed.
  */
-void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
+static void _opp_put_prop_name(struct opp_table *opp_table)
 {
-	if (unlikely(!opp_table))
-		return;
-
-	kfree(opp_table->prop_name);
-	opp_table->prop_name = NULL;
-
-	dev_pm_opp_put_opp_table(opp_table);
+	if (opp_table->prop_name) {
+		kfree(opp_table->prop_name);
+		opp_table->prop_name = NULL;
+	}
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
 /**
  * _opp_set_regulators() - Set regulator names for the device
@@ -2392,7 +2375,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_REGULATOR_HELPER)
 		_opp_unregister_set_opp_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_PROP_NAME)
-		dev_pm_opp_put_prop_name(data->opp_table);
+		_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
 		_opp_put_clknames(data->opp_table);
 
@@ -2419,7 +2402,7 @@ static void _opp_clear_config(struct opp_config_data *data)
  */
 int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
-	struct opp_table *opp_table, *err;
+	struct opp_table *opp_table;
 	struct opp_config_data *data;
 	unsigned int id;
 	int ret;
@@ -2455,11 +2438,9 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure property names */
 	if (config->prop_name) {
-		err = dev_pm_opp_set_prop_name(dev, config->prop_name);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_prop_name(opp_table, config->prop_name);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_PROP_NAME;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 63ad7870ae11..26653be21dc0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -187,8 +187,6 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(int token);
 
-struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
-void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -360,13 +358,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
-
 static inline int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 {
 	return -EOPNOTSUPP;
-- 
2.31.1.272.g89b43f80a514

