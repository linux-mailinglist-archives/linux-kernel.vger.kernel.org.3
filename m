Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551F5663C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiGEHAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGEHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA35E0DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i17so1177450pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWn76D86a1mEcSjBQhlRWmVzJMrbS7iUkVOv/o7W4cI=;
        b=HD5eyLpgWrbnOGBRxm4GZac5zNe5J7E05Jtue7+jWWXouDjii9avtOLAG41RTfOMi6
         /v2so/GVD0HYNac/R414rhUY9VuQO4edOWSAr+3G4Sds19poXf022IdA7MpiNa04zULw
         Yheudj+5DhT7eokQgA1lpclOp9ikLjF5+yFxyX3zLsfpHEVV6yQd2cCjo49vu/B5T1qn
         SuAaNG4DJqhUtPQ1ODR9S8Hh8+unobNg8u5O1J7Hoj83NmTo8vsh0H/hTlI0oyYR78uN
         pQJMn24PqWyW9lWC1hv532xrirqH5CzZJ4Q5sCn/yN77vOvmnYp3UCJ4WhgOI89q4rvi
         1izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWn76D86a1mEcSjBQhlRWmVzJMrbS7iUkVOv/o7W4cI=;
        b=qgAp79fZc5tzniYi31n2JoA+EL9egbPUhsZPLDOqdj1faTw8ONl64wu0HE4EiNbzcj
         zON5ATfGyiDXIXgsvM5t7S6oTqHKyl/cESsBbIBuDDyieys+AatdFof2RPQndsCfSLoG
         DJyscQxHgX5NCOGbUUlGhEWbj8N2eKeZZDUDmaoToWkkT/DZRQr2YpmW7tK12wphHCcx
         KRmieGosOyDxeIMIZZGQD95tPNG8CF/dcA02/IdL61S2eV8wYopmfBwQzEykmUxzEVIa
         qkr7dP5nBuRVZsY1p6GL8QsqLtOtvTGuOGqbcNEw67aTgp/3N5cMW8kDW/j02NUnJKNs
         J5+g==
X-Gm-Message-State: AJIora9XtpjINOA+OGXG85z5kXMLiN1/v7kqxOff7yOn0DTdW8jHT6Zo
        6Uz/AGVavfsbOneCZi+DDNiyzQ==
X-Google-Smtp-Source: AGRyM1tsHivUtQGS4VcjxuhnswvvQB+zBPVYrt445EpyGuwJCb6Fxox73MWjKONTZx0o9Mi/spK97Q==
X-Received: by 2002:a63:82c3:0:b0:40c:c340:318d with SMTP id w186-20020a6382c3000000b0040cc340318dmr28886915pgd.191.1657004434244;
        Tue, 05 Jul 2022 00:00:34 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b0050dc76281f0sm22093419pfb.202.2022.07.05.00.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/13] OPP: Use consistent names for OPP table instances
Date:   Tue,  5 Jul 2022 12:30:04 +0530
Message-Id: <17bd927869b3a4d34c21aadad3536ccdcdf1078f.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

The OPP table is called "opp_table" at most of the places and "table" at
few. Make all of them follow the same naming convention, "opp_table".

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  7 ++++---
 drivers/opp/cpu.c  | 12 ++++++------
 drivers/opp/of.c   | 12 ++++++------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5ad43dbfd87f..e836d3043d22 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1585,15 +1585,16 @@ void dev_pm_opp_remove_all_dynamic(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
 
-struct dev_pm_opp *_opp_allocate(struct opp_table *table)
+struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
 	int supply_count, supply_size, icc_size;
 
 	/* Allocate space for at least one supply */
-	supply_count = table->regulator_count > 0 ? table->regulator_count : 1;
+	supply_count = opp_table->regulator_count > 0 ?
+			opp_table->regulator_count : 1;
 	supply_size = sizeof(*opp->supplies) * supply_count;
-	icc_size = sizeof(*opp->bandwidth) * table->path_count;
+	icc_size = sizeof(*opp->bandwidth) * opp_table->path_count;
 
 	/* allocate new OPP node and supplies structures */
 	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 5004335cf0de..3c3506021501 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -41,7 +41,7 @@
  * the table if any of the mentioned functions have been invoked in the interim.
  */
 int dev_pm_opp_init_cpufreq_table(struct device *dev,
-				  struct cpufreq_frequency_table **table)
+				  struct cpufreq_frequency_table **opp_table)
 {
 	struct dev_pm_opp *opp;
 	struct cpufreq_frequency_table *freq_table = NULL;
@@ -76,7 +76,7 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	freq_table[i].driver_data = i;
 	freq_table[i].frequency = CPUFREQ_TABLE_END;
 
-	*table = &freq_table[0];
+	*opp_table = &freq_table[0];
 
 out:
 	if (ret)
@@ -94,13 +94,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_init_cpufreq_table);
  * Free up the table allocated by dev_pm_opp_init_cpufreq_table
  */
 void dev_pm_opp_free_cpufreq_table(struct device *dev,
-				   struct cpufreq_frequency_table **table)
+				   struct cpufreq_frequency_table **opp_table)
 {
-	if (!table)
+	if (!opp_table)
 		return;
 
-	kfree(*table);
-	*table = NULL;
+	kfree(*opp_table);
+	*opp_table = NULL;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 30394929d700..e07fc31de416 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -767,7 +767,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *table,
+static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
 		    struct device_node *np, bool peak)
 {
 	const char *name = peak ? "opp-peak-kBps" : "opp-avg-kBps";
@@ -780,9 +780,9 @@ static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *table,
 		return -ENODEV;
 
 	count = prop->length / sizeof(u32);
-	if (table->path_count != count) {
+	if (opp_table->path_count != count) {
 		pr_err("%s: Mismatch between %s and paths (%d %d)\n",
-				__func__, name, count, table->path_count);
+				__func__, name, count, opp_table->path_count);
 		return -EINVAL;
 	}
 
@@ -808,7 +808,7 @@ static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *table,
 	return ret;
 }
 
-static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *table,
+static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
 			 struct device_node *np, bool *rate_not_available)
 {
 	bool found = false;
@@ -832,10 +832,10 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *table,
 	 * opp-peak-kBps = <path1_value path2_value>;
 	 * opp-avg-kBps = <path1_value path2_value>;
 	 */
-	ret = _read_bw(new_opp, table, np, true);
+	ret = _read_bw(new_opp, opp_table, np, true);
 	if (!ret) {
 		found = true;
-		ret = _read_bw(new_opp, table, np, false);
+		ret = _read_bw(new_opp, opp_table, np, false);
 	}
 
 	/* The properties were found but we failed to parse them */
-- 
2.31.1.272.g89b43f80a514

