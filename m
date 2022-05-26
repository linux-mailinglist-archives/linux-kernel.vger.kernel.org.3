Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C1534E89
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbiEZLqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbiEZLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8AD6834
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so1228603plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBl1CC0647PH0W5NTycQQML4b7lHvkQNUHifdM1GDAY=;
        b=XU6kHOyVAe6IVpqMU7mG7mrqIele38tK/JE36YPUd6201Yvo2CZj62/LV3oLeN+lyO
         TodZyd/JTrQHXAUhZuHFofbvf9oXBuJQMQxS1BBCR3N9TEQL6FJ00w42/etUQfdvWIk1
         NcP6llHTwf0aceT5mdHaijXhyAIQq92uTXX6LlJRliMPc3BwFfdqXxqWBfXm10d45wsG
         lTEhCwCsMk2e6bCOndjaujvO9dZzzkevXZkke3SC5JIubIhlLpO/iyFPrf1NHverHb0a
         Qd0UyugsV2QfUrpqNVFJj1cfHiwZ0bl6ImlqwC4KWyVi1E9c+l92441XrvCsnDnaEhEO
         N/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBl1CC0647PH0W5NTycQQML4b7lHvkQNUHifdM1GDAY=;
        b=V5L3hbElbyE1EyhUW4NQlHWaplfRRlhJd46lUs/aYkHdGoov1siq2x6/bu2iLn5dX4
         4rDSGIYRszTtbirGYygyxnp02onBcZublGRkr30lM6e0Mu3Rh2l/DVUe0/U9iUB3ycHp
         Oo1It80a5M2in1vrfMfCLLxUKxhY2jPfPlp54V6FhXn9jYE2hqGgtYjGKLzHrPr4x6gI
         9r7dj+NE86Kg1/KPE04ClNR2RWQvMxqxLIXnJcBCwoS8dXr/xEjW9d/sv7rLu2QNB9z+
         +r24ZlAJibRcwKU5+v43AatYYxuXq+urkXWgv/XyYDJcMmsS140SdUFZERaRmxsbNj8/
         E5NQ==
X-Gm-Message-State: AOAM531h/zeB4HG+ptA5EPWglKBRrMyN5QOZZGnqMq6Mosh4vmvY/v2Y
        ugDAPHupzvAbtl4dazJ3H1eUKA==
X-Google-Smtp-Source: ABdhPJz3zYjTuxMYWiz3B6eAEhxfQdRcN7ZzzRRNKFLbGJu16yTRln18Pe6QDLjgBngfPyNCQLwP1g==
X-Received: by 2002:a17:902:9b94:b0:161:5a74:aa6c with SMTP id y20-20020a1709029b9400b001615a74aa6cmr36906593plp.108.1653565488042;
        Thu, 26 May 2022 04:44:48 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id br19-20020a17090b0f1300b001d954837197sm3420044pjb.22.2022.05.26.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/31] OPP: Remove dev_pm_opp_set_supported_hw() and friends
Date:   Thu, 26 May 2022 17:12:25 +0530
Message-Id: <c8dc74650009e96ef5f8741b77e3e49e50ba458c.1653564321.git.viresh.kumar@linaro.org>
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
public interface for dev_pm_opp_set_supported_hw() and friends.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 88 +++++++++++-------------------------------
 include/linux/pm_opp.h | 19 ---------
 2 files changed, 22 insertions(+), 85 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9297b5e944f7..07cb8ff33a6d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1948,7 +1948,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 }
 
 /**
- * dev_pm_opp_set_supported_hw() - Set supported platforms
+ * _opp_set_supported_hw() - Set supported platforms
  * @dev: Device for which supported-hw has to be set.
  * @versions: Array of hierarchy of versions to match.
  * @count: Number of elements in the array.
@@ -1958,84 +1958,39 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
  * OPPs, which are available for those versions, based on its 'opp-supported-hw'
  * property.
  */
-struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
-			const u32 *versions, unsigned int count)
+static int _opp_set_supported_hw(struct opp_table *opp_table,
+				 const u32 *versions, unsigned int count)
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
 	if (opp_table->supported_hw)
-		return opp_table;
+		return 0;
 
 	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
 					GFP_KERNEL);
-	if (!opp_table->supported_hw) {
-		dev_pm_opp_put_opp_table(opp_table);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!opp_table->supported_hw)
+		return -ENOMEM;
 
 	opp_table->supported_hw_count = count;
 
-	return opp_table;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
 
 /**
- * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
- * @opp_table: OPP table returned by dev_pm_opp_set_supported_hw().
+ * _opp_put_supported_hw() - Releases resources blocked for supported hw
+ * @opp_table: OPP table returned by _opp_set_supported_hw().
  *
  * This is required only for the V2 bindings, and is called for a matching
- * dev_pm_opp_set_supported_hw(). Until this is called, the opp_table structure
+ * _opp_set_supported_hw(). Until this is called, the opp_table structure
  * will not be freed.
  */
-void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
-{
-	if (unlikely(!opp_table))
-		return;
-
-	kfree(opp_table->supported_hw);
-	opp_table->supported_hw = NULL;
-	opp_table->supported_hw_count = 0;
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
-
-static void devm_pm_opp_supported_hw_release(void *data)
-{
-	dev_pm_opp_put_supported_hw(data);
-}
-
-/**
- * devm_pm_opp_set_supported_hw() - Set supported platforms
- * @dev: Device for which supported-hw has to be set.
- * @versions: Array of hierarchy of versions to match.
- * @count: Number of elements in the array.
- *
- * This is a resource-managed variant of dev_pm_opp_set_supported_hw().
- *
- * Return: 0 on success and errorno otherwise.
- */
-int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
-				 unsigned int count)
+static void _opp_put_supported_hw(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_supported_hw_release,
-					opp_table);
+	if (opp_table->supported_hw) {
+		kfree(opp_table->supported_hw);
+		opp_table->supported_hw = NULL;
+		opp_table->supported_hw_count = 0;
+	}
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_supported_hw);
 
 /**
  * dev_pm_opp_set_prop_name() - Set prop-extn name
@@ -2615,10 +2570,12 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	// Configure supported hardware
 	if (config->supported_hw) {
-		ret = dev_pm_opp_set_supported_hw(dev, config->supported_hw,
-						  config->supported_hw_count);
-		if (IS_ERR(ret))
+		err = _opp_set_supported_hw(opp_table, config->supported_hw,
+					    config->supported_hw_count);
+		if (err) {
+			ret = ERR_PTR(err);
 			goto err;
+		}
 	}
 
 	// Configure supplies
@@ -2668,8 +2625,7 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
 
 	_opp_put_regulators(opp_table);
 
-	if (opp_table->supported_hw)
-		dev_pm_opp_put_supported_hw(opp_table);
+	_opp_put_supported_hw(opp_table);
 
 	if (opp_table->set_opp)
 		dev_pm_opp_unregister_set_opp_helper(opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 11896ebe1fb1..b80982e5a067 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -184,9 +184,6 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_co
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(struct opp_table *opp_table);
 
-struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
-void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
-int devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -369,22 +366,6 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
-							    const u32 *versions,
-							    unsigned int count)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_supported_hw(struct device *dev,
-					       const u32 *versions,
-					       unsigned int count)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-- 
2.31.1.272.g89b43f80a514

