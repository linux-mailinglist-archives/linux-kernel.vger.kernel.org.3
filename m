Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57875566388
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiGEHBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiGEHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3297101C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so1399054pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTnSd1R3c2h/MITa9c+P658EkVFvGV+MYxMCfkJEHnA=;
        b=NYf8GTmlfn19nNUsHKtjZ+dPbmWcd1QNJHok5icKPNNqrMl53t0rWdVRobyER1sfIY
         gjXVj7Hv9kTL9tr0llnm+3p3a0vc9SAJshBZ60vot93+dApC7kcluFPnu6kmssMYYVrO
         X2KW/EjOJEeZ72Wh42nbchY+J2YJqvA3zI5KoBuLQeS7yPFABcYlKpITZWlrdBbznRB6
         T4Y8ctu7OSO2XzAb08NqJmP2WFgSCXA4Yix05+y+V0Lf3VbNMimP+pQ+8Z3xTroq9l7z
         +IN4xwb+NnVJAqDLTE0hXtKWt+Qqffx1h8DZWu7Ow17eRySDJz+NCcuz7gOADgGJ6IGh
         MwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTnSd1R3c2h/MITa9c+P658EkVFvGV+MYxMCfkJEHnA=;
        b=6B1BJGO4kyQj3uarILYNOIOLwpDfsSBFiOQeEHZXi/ksoyoTwM5OY5Zob99LaBZlu5
         zZNvQwckzuEw6K5xWG8+VpsJ5gb3w7rpxieoVP9eFsXq4hmV5RJQLrYIldBkvC5h2JE3
         qfjhb2eD7xUoAPdey4rcwKZkU4q2EohnrXWprMPb8Cn8VqE41AqU12hFKxa4rAvVAaW/
         qwlMxQXvO1YZVmdPMFLxOkH/1OYX5pngEimXMykNxadPZxKvyk2DKoRVA0964FnCtjqh
         i6KuzMcpTT2Q6wH59E7WCipzWfqYihI+mSMmzCzt0UgGInFcxRLK4cuKjXyqGRBHwQjs
         0oig==
X-Gm-Message-State: AJIora+OFJtXs932BXGtBZlzEqcfaPJlpqKjrJQf4LSb2Me99v9JeDPl
        MvaV/6BD8pLn5Eot/AYdLxzX+w==
X-Google-Smtp-Source: AGRyM1s9x5apNo/JV/bi7399PxHr880FTjl5pyveN2IyqLdLo+GXLyH5ayAyZXd+FV5nyOW6iRZu3w==
X-Received: by 2002:a17:902:cccf:b0:168:c4c3:e8ca with SMTP id z15-20020a170902cccf00b00168c4c3e8camr41917841ple.40.1657004457506;
        Tue, 05 Jul 2022 00:00:57 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id md4-20020a17090b23c400b001ecb5602944sm11499949pjb.28.2022.07.05.00.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/13] OPP: Assert clk_count == 1 for single clk helpers
Date:   Tue,  5 Jul 2022 12:30:12 +0530
Message-Id: <f039572f213ee49125d3d1ea4e64a94b79778426.1657003420.git.viresh.kumar@linaro.org>
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

Many helpers can be safely called only for devices that have a single
clk associated with them. Assert the same for those routines.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e1696cf63409..5b3542557f72 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -97,6 +97,18 @@ struct opp_table *_find_opp_table(struct device *dev)
 	return opp_table;
 }
 
+/*
+ * Returns true if multiple clocks aren't there, else returns false with WARN.
+ *
+ * We don't force clk_count == 1 here as there are users who don't have a clock
+ * representation in the OPP table and manage the clock configuration themselves
+ * in an platform specific way.
+ */
+static bool assert_single_clk(struct opp_table *opp_table)
+{
+	return !WARN_ON(opp_table->clk_count > 1);
+}
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
@@ -181,6 +193,9 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 		return 0;
 	}
 
+	if (!assert_single_clk(opp->opp_table))
+		return 0;
+
 	return opp->rates[0];
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
@@ -601,7 +616,8 @@ static struct dev_pm_opp *_find_key_floor(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		unsigned long freq, bool available)
 {
-	return _find_key_exact(dev, freq, 0, available, _read_freq, NULL);
+	return _find_key_exact(dev, freq, 0, available, _read_freq,
+			       assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
@@ -609,7 +625,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
 	return _opp_table_find_key_ceil(opp_table, freq, 0, true, _read_freq,
-					NULL);
+					assert_single_clk);
 }
 
 /**
@@ -633,7 +649,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
-	return _find_key_ceil(dev, freq, 0, true, _read_freq, NULL);
+	return _find_key_ceil(dev, freq, 0, true, _read_freq, assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -658,7 +674,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
 {
-	return _find_key_floor(dev, freq, 0, true, _read_freq, NULL);
+	return _find_key_floor(dev, freq, 0, true, _read_freq, assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
@@ -1521,6 +1537,9 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		return;
 
+	if (!assert_single_clk(opp_table))
+		goto put_table;
+
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(iter, &opp_table->opp_list, node) {
@@ -1542,6 +1561,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 			 __func__, freq);
 	}
 
+put_table:
 	/* Drop the reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
 }
@@ -1868,6 +1888,9 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol;
 	int ret;
 
+	if (!assert_single_clk(opp_table))
+		return -EINVAL;
+
 	new_opp = _opp_allocate(opp_table);
 	if (!new_opp)
 		return -ENOMEM;
@@ -2721,6 +2744,11 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		return r;
 	}
 
+	if (!assert_single_clk(opp_table)) {
+		r = -EINVAL;
+		goto put_table;
+	}
+
 	mutex_lock(&opp_table->lock);
 
 	/* Do we have the frequency? */
@@ -2792,6 +2820,11 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
+	if (!assert_single_clk(opp_table)) {
+		r = -EINVAL;
+		goto put_table;
+	}
+
 	mutex_lock(&opp_table->lock);
 
 	/* Do we have the frequency? */
@@ -2823,11 +2856,11 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 				     opp);
 
 	dev_pm_opp_put(opp);
-	goto adjust_put_table;
+	goto put_table;
 
 adjust_unlock:
 	mutex_unlock(&opp_table->lock);
-adjust_put_table:
+put_table:
 	dev_pm_opp_put_opp_table(opp_table);
 	return r;
 }
-- 
2.31.1.272.g89b43f80a514

