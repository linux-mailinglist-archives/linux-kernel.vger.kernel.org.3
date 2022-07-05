Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA40B56633B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiGEGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGEGhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:37:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98D610FEE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:37:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n10so10245059plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcbMmvHbvVMpZvOTILkaolJLorfaQM+g9wQsZMC+FTE=;
        b=g0bprKe6UgQxC7q+zKqSxMLjOwv+3yRMZlfrMw1EgUwyP8SDkEwAeCs/bJYayUtvnW
         19u4tZ/iyydAJ7QjsxfvYAuT/VlpL5oAGF6DSuwz5Q0Bv1IF7qHYiARtoM9knRoMY+v7
         iKPX/Mcx1bjA38/7ewO4vcQWQ+jV6XuYnAvz+XyJ1gs5laJZwx5cXsMPP2tCiLYTsrAO
         05DaCYfWpkua89iCVEWUAxW/acA0XQgmWpgjF8Rtk1PyHsdgpXd5M6B/XTHvkBD46e+J
         FDywfa1vAHUhY1Pu/agPHghVESqhmKu7I+J68IYl4S7xF4gZWVbAtccx8yB4Oo0xVOLi
         Kgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcbMmvHbvVMpZvOTILkaolJLorfaQM+g9wQsZMC+FTE=;
        b=jV/MIZ0LhRIcc2oxOnfXXnxgQpMX+qSZNvZl5Ng0QJ10/Olbh+wUS58C5N2Z4V5jbs
         u9Fo6KBdKrInUWVxBI+jwGlHRUCj6e969bA5T06LO77ZVNC2eX4MSKYyvMyi7FWv+fXX
         1pTc7m3Inqklg06AnshranFe+kGKq+LCzNWQTLbavQztGRaOVBHJjksRs2DxvhZIvznB
         Wt8p3iehZ/8lN7L5sDnN/AggAuAajhsY9qbqaRL/39AIWP6sbCIWRSqh8QA+E+FIT5dQ
         qiY0Kmca1W+pOXNidHHXDN0g8wDmwcOHpf3nOgCOHz5+MWPya9G0+GV2WfSylrJKzJNd
         BE+g==
X-Gm-Message-State: AJIora+AoVxXexCGrp4mRPT+ATgt4wpa+IHvnN79SuL2ojdoK+uN4Eb1
        /lKDh/rpiepmxYPa6lqajAovXg==
X-Google-Smtp-Source: AGRyM1uz18gDPJhA64KqvLCW7ypIfE0r8nA3ehySpmm8TrHVMpZGnoqNWf719nS7QCronhFKOxNFKw==
X-Received: by 2002:a17:90b:278e:b0:1ee:f086:9c9d with SMTP id pw14-20020a17090b278e00b001eef0869c9dmr40729090pjb.182.1657003069210;
        Mon, 04 Jul 2022 23:37:49 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00168b4b550f2sm22535425plm.54.2022.07.04.23.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:37:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
Date:   Tue,  5 Jul 2022 12:07:37 +0530
Message-Id: <63de4a326ceb5b8836c46c6ee347d443e4068eb4.1657002904.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657002904.git.viresh.kumar@linaro.org>
References: <cover.1657002904.git.viresh.kumar@linaro.org>
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

This was added few years back, but the code that was supposed to use it
never got merged. Remove the unused helper.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 54 ------------------------------------------
 include/linux/pm_opp.h |  8 -------
 2 files changed, 62 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e74bdc134c5a..fc0232f695c6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -607,60 +607,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
-/**
- * dev_pm_opp_find_freq_ceil_by_volt() - Find OPP with highest frequency for
- *					 target voltage.
- * @dev:	Device for which we do this operation.
- * @u_volt:	Target voltage.
- *
- * Search for OPP with highest (ceil) frequency and has voltage <= u_volt.
- *
- * Return: matching *opp, else returns ERR_PTR in case of error which should be
- * handled using IS_ERR.
- *
- * Error return values can be:
- * EINVAL:	bad parameters
- *
- * The callers are required to call dev_pm_opp_put() for the returned OPP after
- * use.
- */
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
-						     unsigned long u_volt)
-{
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !u_volt) {
-		dev_err(dev, "%s: Invalid argument volt=%lu\n", __func__,
-			u_volt);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available) {
-			if (temp_opp->supplies[0].u_volt > u_volt)
-				break;
-			opp = temp_opp;
-		}
-	}
-
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp))
-		dev_pm_opp_get(opp);
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_by_volt);
-
 /**
  * dev_pm_opp_find_level_exact() - search for an exact level
  * @dev:		device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 9d59aedc2be3..50cbc75bef71 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -118,8 +118,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      bool available);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
-						     unsigned long u_volt);
 
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
@@ -265,12 +263,6 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
-					unsigned long u_volt)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
-- 
2.31.1.272.g89b43f80a514

