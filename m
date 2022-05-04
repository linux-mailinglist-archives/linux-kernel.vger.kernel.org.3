Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03281519C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347919AbiEDKPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbiEDKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:15:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2311172
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:11:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c9so299412plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PBl8xW2PSVI88j/b+bhi+tuhcm4YohlmH+sr2K1/cw=;
        b=jjpgmjCDYPoVR7p5fJq+gv0fE5KfgYNqRIkHrfJI5dpd5/gReG1zqXsB86ajj3smDI
         Jgw4zMqtRukgZHGtsntByJIi65cd+b6TdKuIAWBci7tPqgnC7EnBdGQCGncbCNlehV5R
         6fRWAqij4LQYlOZX/cTyQwRZnye7FTyvwqHXq13DiGa/Rx49batyBAOtWufZVrpTouav
         qCUIFo+RGfiQI6ZEoUFfNrcYC9p7/pnsJdKe1nW0b89h+SqorqCiQIydrRQmN41IG3ZM
         PVfhtNMex8iKDO5IGl37wlUbMogoapWtzN4V9swZcF21zcNiOUNfcy3gaN2i3RHvZ5Mb
         rO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PBl8xW2PSVI88j/b+bhi+tuhcm4YohlmH+sr2K1/cw=;
        b=fE9MY8eGujCX0B2ouaPoxHRZPQr8xYvWlIipEK9rLb34N2UJ/D+fjJ/yc2NIS1pL/q
         f6P03l82PnoiGhFj6E/rflrEso1hCj/UXaBujP10oYdqR6WIFsY9L4YpLjqM/ZNBbqwO
         Q+kaUogHRpUSg4b8oFaCx9Bpe3+tvG+7kKZ3JLAFrpXA/bML3YhmGwFcIRtMEZMx5XQl
         8DkL7ZDJUeYYNocxAHPauZxbl6MGLn0vpmENva6BalsB36ccQ7BT+c/S/YbSW5HItzWr
         BcUC9zRlnJOPndo8PxNzedvhvA+n84NYvFPi/hVSRKOmzbqRHDazEu9Tzga+wHiP1QyK
         YrUg==
X-Gm-Message-State: AOAM531TGsfzh8IcNzRM2rRKTO2vvDFMlJ6ZzwEX8jQOXXr2HZsngAfa
        lDcTfZs1gxXkO/GB4IRJjRHlYA==
X-Google-Smtp-Source: ABdhPJwoydtOgEFBuhFb/unLnpikeNggmtykmu7XmJdAH08BreVz+Css31CxDKVEQqk6f3yyI/wdjQ==
X-Received: by 2002:a17:90b:4a05:b0:1dc:1a2c:8c69 with SMTP id kk5-20020a17090b4a0500b001dc1a2c8c69mr9313162pjb.9.1651659087375;
        Wed, 04 May 2022 03:11:27 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id gn4-20020a17090ac78400b001d25dfb9d39sm2882077pjb.14.2022.05.04.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:11:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Reorder definition of ceil/floor helpers
Date:   Wed,  4 May 2022 15:41:22 +0530
Message-Id: <22079af7df5a5dfef1c4d160abfd43035211759e.1651659079.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

Reorder the helpers to keep all freq specific ones, followed by level
and bw.

No functional change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 194 ++++++++++++++++++++---------------------
 include/linux/pm_opp.h |  22 ++---
 2 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 48606f52759d..84063eaebb91 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -456,103 +456,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
-/**
- * dev_pm_opp_find_level_exact() - search for an exact level
- * @dev:		device for which we do this operation
- * @level:		level to search for
- *
- * Return: Searches for exact match in the opp table and returns pointer to the
- * matching opp if found, else returns ERR_PTR in case of error and should
- * be handled using IS_ERR. Error return values can be:
- * EINVAL:	for bad pointer
- * ERANGE:	no match found for search
- * ENODEV:	if device not found in list of registered devices
- *
- * The callers are required to call dev_pm_opp_put() for the returned OPP after
- * use.
- */
-struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
-					       unsigned int level)
-{
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		int r = PTR_ERR(opp_table);
-
-		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		return ERR_PTR(r);
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->level == level) {
-			opp = temp_opp;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
-
-/**
- * dev_pm_opp_find_level_ceil() - search for an rounded up level
- * @dev:		device for which we do this operation
- * @level:		level to search for
- *
- * Return: Searches for rounded up match in the opp table and returns pointer
- * to the  matching opp if found, else returns ERR_PTR in case of error and
- * should be handled using IS_ERR. Error return values can be:
- * EINVAL:	for bad pointer
- * ERANGE:	no match found for search
- * ENODEV:	if device not found in list of registered devices
- *
- * The callers are required to call dev_pm_opp_put() for the returned OPP after
- * use.
- */
-struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
-					      unsigned int *level)
-{
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		int r = PTR_ERR(opp_table);
-
-		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		return ERR_PTR(r);
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->level >= *level) {
-			opp = temp_opp;
-			*level = opp->level;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
-
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
@@ -729,6 +632,103 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_by_volt);
 
+/**
+ * dev_pm_opp_find_level_exact() - search for an exact level
+ * @dev:		device for which we do this operation
+ * @level:		level to search for
+ *
+ * Return: Searches for exact match in the opp table and returns pointer to the
+ * matching opp if found, else returns ERR_PTR in case of error and should
+ * be handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					       unsigned int level)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int r = PTR_ERR(opp_table);
+
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
+		return ERR_PTR(r);
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->level == level) {
+			opp = temp_opp;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
+
+/**
+ * dev_pm_opp_find_level_ceil() - search for an rounded up level
+ * @dev:		device for which we do this operation
+ * @level:		level to search for
+ *
+ * Return: Searches for rounded up match in the opp table and returns pointer
+ * to the  matching opp if found, else returns ERR_PTR in case of error and
+ * should be handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					      unsigned int *level)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int r = PTR_ERR(opp_table);
+
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
+		return ERR_PTR(r);
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->level >= *level) {
+			opp = temp_opp;
+			*level = opp->level;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
+
 /**
  * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dcea178868c9..6708b4ec244d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -117,16 +117,16 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
-struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
-					       unsigned int level);
-struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
-					      unsigned int *level);
-
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 						     unsigned long u_volt);
 
+struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					       unsigned int level);
+struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					      unsigned int *level);
+
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
 
@@ -250,12 +250,6 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
-					unsigned long freq, bool available)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					unsigned int level)
 {
@@ -268,6 +262,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
+					unsigned long freq, bool available)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					unsigned long *freq)
 {
-- 
2.31.1.272.g89b43f80a514

