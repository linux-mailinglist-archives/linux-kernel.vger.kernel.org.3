Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFE545EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiFJIYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347445AbiFJIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:24:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EE3E866F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cx11so23453980pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqmtsnnn/rBbgkYjsLkZHJ0d80G5x0xgJus9h30FBZI=;
        b=RWzCHuEdf3vWCLjvt9cbjQmgL5DJ8D41Dw0K9q7oQ2Z17dJVX/Ex8GYjo4MxpIMyIx
         n1jHM8GfK7Rjl8yTKYpta3YOhk7wz+q/3mebsqtJDiDlbo03fegZXHY6nW0czkAajCrI
         NKoHem/WfBBDFKBvkOTszVml4Vw/Bak1nDSP6p/4mw041gKK4f6gt8cRnU918RztLxor
         xx3bJG0/ZeLhNkaQKrorpXipGhF5IWQogb+mCuP8JieCIVsYUt3LAuWb/fzDxgMA0WUD
         OUy/iDZ67NpeGVRqO3pSxWH/WabsZSP84xmnl/3eIVdEu5h6553DgmmiHX6H3ZPXjGby
         glyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqmtsnnn/rBbgkYjsLkZHJ0d80G5x0xgJus9h30FBZI=;
        b=4MEu+VDQVhJLu3D6AspHjF3z+te9KxjZfbSZFCYiOSeLcCNMQr9FCd6nlFtaskSArX
         gcrSt08mGw5l9IjV6Oi3VN72BVdB2R5XqZGEv9g3vcCqLN7E1zMW69B0rToUbD5rIXTb
         s3dEjqpcKZk+vdSc1YG+HZcH3CbYA5RsMkIqnHKgqpo/qnQIZnC/D4+/f9fqjy/phjJN
         Jt2fIU+uJTq9Jzb//0jjGXzzw061ktI70YzmdM8YsbOS1qZ33fPj6hAAFNwyYSBQfm4G
         dUPJvb+S65MIgoE7M3FK+X5OvdI2bMiOdQJi7NP3SPWfyc6ap3/JB/ZuH9xFTxkn8eNO
         3U4g==
X-Gm-Message-State: AOAM532+5lGxmRcvUIAt4Mh3ivxVkLMWH/AIeH6ACjndWyqmXrqFb+53
        K9yF6Z3TwCdOjkcHf2lfTL9zUA==
X-Google-Smtp-Source: ABdhPJzyphAF7MDKdO4LsySNr5NaWrcjnl2906vaS5KqAf4pmbtKPZggcXN/K3cTSGASmWxsAIJbvw==
X-Received: by 2002:a17:90b:350b:b0:1e8:5177:fe7d with SMTP id ls11-20020a17090b350b00b001e85177fe7dmr7789962pjb.142.1654849266751;
        Fri, 10 Jun 2022 01:21:06 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id n10-20020a056a0007ca00b0051bd9981ccbsm15298810pfu.39.2022.06.10.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] OPP: Use consistent names for OPP table instances
Date:   Fri, 10 Jun 2022 13:50:45 +0530
Message-Id: <03780196cbd07ffff8ea4a1b2b4627a19a22e262.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP table is called "opp_table" at most of the places and "table" at
few. Make all of them follow the same naming convention, "opp_table".

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  7 ++++---
 drivers/opp/cpu.c  | 12 ++++++------
 drivers/opp/of.c   | 12 ++++++------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6e6c1ca92641..404f43759066 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1567,15 +1567,16 @@ void dev_pm_opp_remove_all_dynamic(struct device *dev)
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

