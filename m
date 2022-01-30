Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE74A399D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356259AbiA3VCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiA3VCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16954C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso8040112wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgN4kboK6BDi4j8PdQgM4+rnAZo/EbE+mRU5+LkdX5I=;
        b=M/RIeWVvt1ILqz4YX0HR2Qt8Kvbj0WY/BF3eVcE1RalbZnfNLEy/jueZPykje3r2tw
         IZUwziPCwJFmd2Ch+F1gaPcrMbwfRSy7RSNjvFrkPYDFTkeZX+ZDpY/sn1LIWnYQcqJ5
         zdBCfTvQVLkoGpocGrgSJ2VCHftcLvvdgY8EMhn2Q1Jq5GHHZzZVgSaoqtA3ltsQUla5
         bleYRO+Qmr2irw117KzrVrBDbpy0TXNdjhADSBga3vZN0fw0KFPzb1AkBkp3YH48WlaK
         JXjo3mA0kTN0jx7Q8XKU+7y1WCcCdEJcEYAFuApb7GKYTLhFl5dJIgEg47LO+uEzBh1J
         Pm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgN4kboK6BDi4j8PdQgM4+rnAZo/EbE+mRU5+LkdX5I=;
        b=DWk0AIuvCT4r24i7kUHmoxC+z760yGj8nnG2L9BShl1KceHvp3aTicOG7ur1FLH3c1
         NCBSUwEGeTs5DEjbxtArTR5i7w6+pO4IkPy7g7O9zQdDS25g8mUPKiKdPS6Ashvxt4SS
         cWQ6u9elbzP0UQUSEyp2oeLikgn4fHWOjKqFQaIpFFxuKhOV5iNs96YtIyaKLPIq7MHM
         QEyROcxMi0VatIA+Uf2YgTC8qMJY3mIzgb+aXwkTqgYxHEPwtxfe3xvnm4BQ7fgKcTNB
         cyPT75hLg7D+Fqlg/24jqyLqZZ0exBzsYSbNA6q8ZnsId2LU+DqLZXQBHKFMNzP6OPUY
         bgpA==
X-Gm-Message-State: AOAM530HVcTE4b/DpW4EBzWNNENdBA8VjWZvWfXatwMIsqxLbtcD902U
        jtrH9skjXiCbB3N3b5c4vW8ryg==
X-Google-Smtp-Source: ABdhPJwnuWOR0GnzVxtJ/hx7eZAn0y6Hp7MDGqzH0Qs+meRUlepIIhnQDaIGi1drQWL04J8IJeHP2w==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr23962932wmi.118.1643576534603;
        Sun, 30 Jan 2022 13:02:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/7] powercap/dtpm: Change locking scheme
Date:   Sun, 30 Jan 2022 22:02:03 +0100
Message-Id: <20220130210210.549877-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The different functions are all called through the
dtpm_create_hierarchy() which handle the mutex. The different
functions are used in this context, consequently with the lock always
held.

Remove all locks taken in the function and add the lock in the
hierarchy creation function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 95 ++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 68 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 414826a1509b..0b0121c37a1b 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -51,9 +51,7 @@ static int get_max_power_range_uw(struct powercap_zone *pcz, u64 *max_power_uw)
 {
 	struct dtpm *dtpm = to_dtpm(pcz);
 
-	mutex_lock(&dtpm_lock);
 	*max_power_uw = dtpm->power_max - dtpm->power_min;
-	mutex_unlock(&dtpm_lock);
 
 	return 0;
 }
@@ -83,14 +81,7 @@ static int __get_power_uw(struct dtpm *dtpm, u64 *power_uw)
 
 static int get_power_uw(struct powercap_zone *pcz, u64 *power_uw)
 {
-	struct dtpm *dtpm = to_dtpm(pcz);
-	int ret;
-
-	mutex_lock(&dtpm_lock);
-	ret = __get_power_uw(dtpm, power_uw);
-	mutex_unlock(&dtpm_lock);
-
-	return ret;
+	return __get_power_uw(to_dtpm(pcz), power_uw);
 }
 
 static void __dtpm_rebalance_weight(struct dtpm *dtpm)
@@ -133,7 +124,16 @@ static void __dtpm_add_power(struct dtpm *dtpm)
 	}
 }
 
-static int __dtpm_update_power(struct dtpm *dtpm)
+/**
+ * dtpm_update_power - Update the power on the dtpm
+ * @dtpm: a pointer to a dtpm structure to update
+ *
+ * Function to update the power values of the dtpm node specified in
+ * parameter. These new values will be propagated to the tree.
+ *
+ * Return: zero on success, -EINVAL if the values are inconsistent
+ */
+int dtpm_update_power(struct dtpm *dtpm)
 {
 	int ret;
 
@@ -155,26 +155,6 @@ static int __dtpm_update_power(struct dtpm *dtpm)
 	return ret;
 }
 
-/**
- * dtpm_update_power - Update the power on the dtpm
- * @dtpm: a pointer to a dtpm structure to update
- *
- * Function to update the power values of the dtpm node specified in
- * parameter. These new values will be propagated to the tree.
- *
- * Return: zero on success, -EINVAL if the values are inconsistent
- */
-int dtpm_update_power(struct dtpm *dtpm)
-{
-	int ret;
-
-	mutex_lock(&dtpm_lock);
-	ret = __dtpm_update_power(dtpm);
-	mutex_unlock(&dtpm_lock);
-
-	return ret;
-}
-
 /**
  * dtpm_release_zone - Cleanup when the node is released
  * @pcz: a pointer to a powercap_zone structure
@@ -191,20 +171,14 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	struct dtpm *dtpm = to_dtpm(pcz);
 	struct dtpm *parent = dtpm->parent;
 
-	mutex_lock(&dtpm_lock);
-
-	if (!list_empty(&dtpm->children)) {
-		mutex_unlock(&dtpm_lock);
+	if (!list_empty(&dtpm->children))
 		return -EBUSY;
-	}
 
 	if (parent)
 		list_del(&dtpm->sibling);
 
 	__dtpm_sub_power(dtpm);
 
-	mutex_unlock(&dtpm_lock);
-
 	if (dtpm->ops)
 		dtpm->ops->release(dtpm);
 
@@ -216,23 +190,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	return 0;
 }
 
-static int __get_power_limit_uw(struct dtpm *dtpm, int cid, u64 *power_limit)
-{
-	*power_limit = dtpm->power_limit;
-	return 0;
-}
-
 static int get_power_limit_uw(struct powercap_zone *pcz,
 			      int cid, u64 *power_limit)
 {
-	struct dtpm *dtpm = to_dtpm(pcz);
-	int ret;
-
-	mutex_lock(&dtpm_lock);
-	ret = __get_power_limit_uw(dtpm, cid, power_limit);
-	mutex_unlock(&dtpm_lock);
-
-	return ret;
+	*power_limit = to_dtpm(pcz)->power_limit;
+	
+	return 0;
 }
 
 /*
@@ -292,7 +255,7 @@ static int __set_power_limit_uw(struct dtpm *dtpm, int cid, u64 power_limit)
 
 			ret = __set_power_limit_uw(child, cid, power);
 			if (!ret)
-				ret = __get_power_limit_uw(child, cid, &power);
+				ret = get_power_limit_uw(&child->zone, cid, &power);
 
 			if (ret)
 				break;
@@ -310,8 +273,6 @@ static int set_power_limit_uw(struct powercap_zone *pcz,
 	struct dtpm *dtpm = to_dtpm(pcz);
 	int ret;
 
-	mutex_lock(&dtpm_lock);
-
 	/*
 	 * Don't allow values outside of the power range previously
 	 * set when initializing the power numbers.
@@ -323,8 +284,6 @@ static int set_power_limit_uw(struct powercap_zone *pcz,
 	pr_debug("%s: power limit: %llu uW, power max: %llu uW\n",
 		 dtpm->zone.name, dtpm->power_limit, dtpm->power_max);
 
-	mutex_unlock(&dtpm_lock);
-
 	return ret;
 }
 
@@ -335,11 +294,7 @@ static const char *get_constraint_name(struct powercap_zone *pcz, int cid)
 
 static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *max_power)
 {
-	struct dtpm *dtpm = to_dtpm(pcz);
-
-	mutex_lock(&dtpm_lock);
-	*max_power = dtpm->power_max;
-	mutex_unlock(&dtpm_lock);
+	*max_power = to_dtpm(pcz)->power_max;
 
 	return 0;
 }
@@ -442,8 +397,6 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	if (IS_ERR(pcz))
 		return PTR_ERR(pcz);
 
-	mutex_lock(&dtpm_lock);
-
 	if (parent) {
 		list_add_tail(&dtpm->sibling, &parent->children);
 		dtpm->parent = parent;
@@ -459,8 +412,6 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	pr_debug("Registered dtpm node '%s' / %llu-%llu uW, \n",
 		 dtpm->zone.name, dtpm->power_min, dtpm->power_max);
 
-	mutex_unlock(&dtpm_lock);
-
 	return 0;
 }
 
@@ -605,8 +556,12 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 	struct device_node *np;
 	int i, ret;
 
-	if (pct)
-		return -EBUSY;
+	mutex_lock(&dtpm_lock);
+
+	if (pct) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
@@ -648,12 +603,16 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 				dtpm_subsys[i]->name, ret);
 	}
 
+	mutex_unlock(&dtpm_lock);
+
 	return 0;
 
 out_err:
 	powercap_unregister_control_type(pct);
 out_pct:
 	pct = NULL;
+out_unlock:
+	mutex_unlock(&dtpm_lock);
 	
 	return ret;
 }
-- 
2.25.1

