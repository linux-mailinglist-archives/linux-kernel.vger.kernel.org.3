Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2C562DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiGAIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiGAIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:23:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F67126B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:22:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d14so1925455pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYSJNC/pxLs1fKmIBWBqgxu7Bni+gXbmGVB5WErQGn4=;
        b=fu/mglIbqflokGQBdnsQPAuKVDtpaa1SyiudbdrhcujrHyHZunBCK7fAa7bo9Dsg1Y
         aahfMTCfkJjiMwKWBNKBykWqWB0XZaXyaPaHyK1iwhriKeMRsgr8NEorrctfM4+FdSS9
         nG3BGsaYuJR/GNhhR64NgiFB7yJFZJI7Va0qwhdY2OkFmGNaKni9EIMGoqEXRz++t1bm
         xvzl8bPHHQ9JS8ty0pA73WI0JIuiakZuE1lfWycRCKMTsYGcjc6d1I5fDMm4/5KUMS0I
         aM/TKW3RbjI2TzUNTXqoACoq+J65JBIaHXkgwL1D2QKoe7UqVS5rkRqVPpv3tHV+tXMx
         r1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYSJNC/pxLs1fKmIBWBqgxu7Bni+gXbmGVB5WErQGn4=;
        b=3aApayUUS9cLa7ljV1/DeJDNK+L5TerDwde8sUo7E1D2b900w8hjzPWXXTn3YXVg+k
         MUY0qL7gzwi9rzu9BOYLvu4LbSLYgplyWvQTsex8okELKMd880oPfc2VZkKtWybgXQ9G
         sGxhXBFQxTrC1fkn/1LBqtcBTiIht6ZjpZkkYUeQIv/4r+t/96Z85CHbWqenvrhoqoAJ
         pG/MP3qYNNAqT2RFt3jHHn5xhi4n07sv21t+IlBi3FSwjnxRO9s1k99cMCGnB+5I9AvQ
         Cl6pEWfroMQTuyrk5BQnb5JiDfuzRWftal45ysOSj3QOl3dj2PsU/dvPm1pbOu02en4H
         2pUQ==
X-Gm-Message-State: AJIora+PXKtgUzJCWv6N9hl2nxN5MYG2cms+YE5vAe85Y4Yka9ShjEON
        yepO1qztLu8pTgZu8wzDhnIuZA==
X-Google-Smtp-Source: AGRyM1ukDUHC1+0Sbq/sEDCtUq0uU0SW9/OZkM9DwAOTrWDcL7ZMMh7Bq9enUEWUKNuFKpB5TqXqwg==
X-Received: by 2002:a17:903:1208:b0:16b:81f6:e992 with SMTP id l8-20020a170903120800b0016b81f6e992mr20105169plh.55.1656663720928;
        Fri, 01 Jul 2022 01:22:00 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id j2-20020a654282000000b003fe28130b12sm14651748pgp.62.2022.07.01.01.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:22:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 27/30] OPP: Remove dev_pm_opp_set_clkname() and friends
Date:   Fri,  1 Jul 2022 13:50:22 +0530
Message-Id: <66e6aa4cc95262e2e6909a5fec79ec63ee7c1c6b.1656660185.git.viresh.kumar@linaro.org>
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
public interface for dev_pm_opp_set_clkname() and friends.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 118 +++++++++++------------------------------
 include/linux/pm_opp.h |  15 ------
 2 files changed, 32 insertions(+), 101 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 66ffe501a7c8..9b4f67994993 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2156,104 +2156,57 @@ static void _opp_put_regulators(struct opp_table *opp_table)
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
+			     const char * const names[], unsigned int count)
 {
-	struct opp_table *opp_table;
-	int ret;
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
-		goto err;
-	}
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
@@ -2536,7 +2489,7 @@ static void _opp_clear_config(struct opp_config_data *data)
 	if (data->flags & OPP_CONFIG_PROP_NAME)
 		dev_pm_opp_put_prop_name(data->opp_table);
 	if (data->flags & OPP_CONFIG_CLK)
-		dev_pm_opp_put_clkname(data->opp_table);
+		_opp_put_clknames(data->opp_table);
 
 	dev_pm_opp_put_opp_table(data->opp_table);
 	kfree(data);
@@ -2587,17 +2540,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Configure clocks */
 	if (config->clk_names) {
-		/* We support only one clock name for now */
-		if (config->clk_count != 1) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		err = dev_pm_opp_set_clkname(dev, config->clk_names[0]);
-		if (IS_ERR(err)) {
-			ret = PTR_ERR(err);
+		ret = _opp_set_clknames(opp_table, dev, config->clk_names,
+					config->clk_count);
+		if (ret)
 			goto err;
-		}
 
 		data->flags |= OPP_CONFIG_CLK;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dfbb07b871a8..31062dc216f3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -189,9 +189,6 @@ void dev_pm_opp_clear_config(int token);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
-void dev_pm_opp_put_clkname(struct opp_table *opp_table);
-int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
@@ -390,18 +387,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
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
-- 
2.31.1.272.g89b43f80a514

