Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17AD5663A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiGEHBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGEHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:01:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065801180D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:01:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d5so10204960plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdH5G4Th4X2DMlPi52KYT3YEURw2bBNX0NOy7kuLMhY=;
        b=BplPUaz2WEKeGGwt/6Z+X3PMdVT80ZtLj7KK/CmEKgshjOHlZXpmzz5l/xAvLB/GeA
         jW8PXw7eXfK/0hNvmWemwOj5hTyYsxJyi0IGxk4vt/Bih3femV2cAwdx8MYaZ1Cs2Lxu
         PrM8ojwX5nUpbTjw2oZ6LIzGS1bPhWwMY2GD2DmXCTZethyfwyXsfKbZFsHqxWaswsM1
         /n9Xjbu+X7PQsqoteDTQvAff/VxWKdPE9n2A1t2GczSJ6lcWKZe3SNG6byONmjMKsoLr
         1uof0B8QTtvTcFOdOJANAyJcMXwfRWMoBfhaIgV55yTMUyrMD8xsI1LyjH7CpygbipbS
         B7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdH5G4Th4X2DMlPi52KYT3YEURw2bBNX0NOy7kuLMhY=;
        b=iJUqxOQ4uaT9HdgVbvKnq7FrYrYiQtYSYio+XpFTiwykRdLbI0SBMWX+IUpomDUV7+
         HS5hG5IBSBpUZQTKq7+RHpZBYZqcnbtoMASi82WsFWOUj7yKafKzvfuyfKg0JpwVGL1z
         ScSsc8PkZNyuHg/9YwodsWUC41YKQsZXxaLbnGvXkp9QSjGZOY3F/Armkfbtsx/zu01Z
         9GtsQDEJQ+viiFTCXVV/6NOj9PDAKIy2s1IrYBqE6CzLe4azhZyPYrxMaz/RDcHuIZ8a
         xT157AFcWEI1S4diwXCdelhc9a8pKmmbNI1Gi8JzydrNfKnIpJOFUuW/sKpaGr27CoNZ
         ElwA==
X-Gm-Message-State: AJIora/b1M707bNZKfftujurFMTB4yN9EmKujTTt3ZRtvuCqHNGt2SyB
        11f/rU7HRpSSPAQAOzlIruQwUg==
X-Google-Smtp-Source: AGRyM1uANnFSFJWuoa9R9F/MRzwQAyXBS+zhGAv+0KR1ZYDjnYmpjdSC9nCLv6eJ0Zer7VCaSAXp+g==
X-Received: by 2002:a17:90b:314c:b0:1ed:442c:117e with SMTP id ip12-20020a17090b314c00b001ed442c117emr40647091pjb.160.1657004469470;
        Tue, 05 Jul 2022 00:01:09 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 70-20020a621849000000b0051bb79437f7sm22134187pfy.37.2022.07.05.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:01:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 13/13] OPP: Remove dev{m}_pm_opp_of_add_table_noclk()
Date:   Tue,  5 Jul 2022 12:30:16 +0530
Message-Id: <8e639af4cd22b6980cb3146d7656980b8697e647.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

Remove the now unused variants and the extra "getclk" parameter from few
routines, which is always "true" now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 19 +++++++----------
 drivers/opp/of.c       | 48 +++++++-----------------------------------
 drivers/opp/opp.h      |  2 +-
 include/linux/pm_opp.h | 12 -----------
 4 files changed, 17 insertions(+), 64 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 666e1ebf91d1..0205b83e1c02 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1360,8 +1360,7 @@ void _get_opp_table_kref(struct opp_table *opp_table)
 }
 
 static struct opp_table *_update_opp_table_clk(struct device *dev,
-					       struct opp_table *opp_table,
-					       bool getclk)
+					       struct opp_table *opp_table)
 {
 	int ret;
 
@@ -1369,8 +1368,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 	 * Return early if we don't need to get clk or we have already done it
 	 * earlier.
 	 */
-	if (!getclk || IS_ERR(opp_table) || !IS_ERR(opp_table->clk) ||
-	    opp_table->clks)
+	if (IS_ERR(opp_table) || !IS_ERR(opp_table->clk) || opp_table->clks)
 		return opp_table;
 
 	/* Find clk for the device */
@@ -1409,8 +1407,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
  * uses the opp_tables_busy flag to indicate if another creator is in the middle
  * of adding an OPP table and others should wait for it to finish.
  */
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
-					 bool getclk)
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 
@@ -1457,12 +1454,12 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
 unlock:
 	mutex_unlock(&opp_table_lock);
 
-	return _update_opp_table_clk(dev, opp_table, getclk);
+	return _update_opp_table_clk(dev, opp_table);
 }
 
-static struct opp_table *_add_opp_table(struct device *dev, bool getclk)
+static struct opp_table *_add_opp_table(struct device *dev)
 {
-	return _add_opp_table_indexed(dev, 0, getclk);
+	return _add_opp_table_indexed(dev, 0);
 }
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
@@ -2444,7 +2441,7 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 	if (!data)
 		return -ENOMEM;
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		kfree(data);
 		return PTR_ERR(opp_table);
@@ -2735,7 +2732,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = _add_opp_table(dev, true);
+	opp_table = _add_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 080481a05223..6b19764a3897 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1123,7 +1123,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	return ret;
 }
 
-static int _of_add_table_indexed(struct device *dev, int index, bool getclk)
+static int _of_add_table_indexed(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 	int ret, count;
@@ -1139,7 +1139,7 @@ static int _of_add_table_indexed(struct device *dev, int index, bool getclk)
 			index = 0;
 	}
 
-	opp_table = _add_opp_table_indexed(dev, index, getclk);
+	opp_table = _add_opp_table_indexed(dev, index);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -1163,11 +1163,11 @@ static void devm_pm_opp_of_table_release(void *data)
 	dev_pm_opp_of_remove_table(data);
 }
 
-static int _devm_of_add_table_indexed(struct device *dev, int index, bool getclk)
+static int _devm_of_add_table_indexed(struct device *dev, int index)
 {
 	int ret;
 
-	ret = _of_add_table_indexed(dev, index, getclk);
+	ret = _of_add_table_indexed(dev, index);
 	if (ret)
 		return ret;
 
@@ -1195,7 +1195,7 @@ static int _devm_of_add_table_indexed(struct device *dev, int index, bool getclk
  */
 int devm_pm_opp_of_add_table(struct device *dev)
 {
-	return _devm_of_add_table_indexed(dev, 0, true);
+	return _devm_of_add_table_indexed(dev, 0);
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table);
 
@@ -1218,7 +1218,7 @@ EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table);
  */
 int dev_pm_opp_of_add_table(struct device *dev)
 {
-	return _of_add_table_indexed(dev, 0, true);
+	return _of_add_table_indexed(dev, 0);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
@@ -1234,7 +1234,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  */
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	return _of_add_table_indexed(dev, index, true);
+	return _of_add_table_indexed(dev, index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
 
@@ -1247,42 +1247,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
  */
 int devm_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	return _devm_of_add_table_indexed(dev, index, true);
+	return _devm_of_add_table_indexed(dev, index);
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table_indexed);
 
-/**
- * dev_pm_opp_of_add_table_noclk() - Initialize indexed opp table from device
- *		tree without getting clk for device.
- * @dev:	device pointer used to lookup OPP table.
- * @index:	Index number.
- *
- * Register the initial OPP table with the OPP library for given device only
- * using the "operating-points-v2" property. Do not try to get the clk for the
- * device.
- *
- * Return: Refer to dev_pm_opp_of_add_table() for return values.
- */
-int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
-{
-	return _of_add_table_indexed(dev, index, false);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_noclk);
-
-/**
- * devm_pm_opp_of_add_table_noclk() - Initialize indexed opp table from device
- *		tree without getting clk for device.
- * @dev:	device pointer used to lookup OPP table.
- * @index:	Index number.
- *
- * This is a resource-managed variant of dev_pm_opp_of_add_table_noclk().
- */
-int devm_pm_opp_of_add_table_noclk(struct device *dev, int index)
-{
-	return _devm_of_add_table_indexed(dev, index, false);
-}
-EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table_noclk);
-
 /* CPU device specific helpers */
 
 /**
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 816009eaafee..5e089651c91f 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -254,7 +254,7 @@ int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1, struc
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index);
 void _put_opp_list_kref(struct opp_table *opp_table);
 void _required_opps_available(struct dev_pm_opp *opp, int count);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 683e6baf9618..dc1fb5890792 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -402,8 +402,6 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
 int devm_pm_opp_of_add_table_indexed(struct device *dev, int index);
-int dev_pm_opp_of_add_table_noclk(struct device *dev, int index);
-int devm_pm_opp_of_add_table_noclk(struct device *dev, int index);
 void dev_pm_opp_of_remove_table(struct device *dev);
 int devm_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
@@ -434,16 +432,6 @@ static inline int devm_pm_opp_of_add_table_indexed(struct device *dev, int index
 	return -EOPNOTSUPP;
 }
 
-static inline int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int devm_pm_opp_of_add_table_noclk(struct device *dev, int index)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
-- 
2.31.1.272.g89b43f80a514

