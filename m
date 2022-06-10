Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D80545ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbiFJIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347598AbiFJIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:24:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F573EB9CA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i15so5466126plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vcF/QNpvPLcA4RHww4ViDk70wdKPxBVofdBW3sgq5c=;
        b=p7V4YUibibj9AvSgBH2AE999cHg+ec4xuwtZHf4oCKGnASuR7Jk0TqhUUEF8XaOR+r
         wxrU+j3QghaV8hAB+Mvm7zWzgiR8PrkF6FJiBDH3G6YzWYJr5ALY7k090vQONfMRnqGz
         vZyYQPntTUBRfaqBoadikhkcg9ew+Deswu/DB5qzND4R/Re+hF6ZHZO7pRBGchYvuh31
         0o8C8nuOLY+O9O1rY1t04DJ55Z74U3IQGI0+lPuUcillbKNVNihZ4TITwbccLshYVfHW
         5RjBUvwS6JJEh/6dMcUm+pwOMB1QW/paW/1WuwqRkMabzSMgl2Nbdv3U1GxaUuZ7gb2I
         hbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vcF/QNpvPLcA4RHww4ViDk70wdKPxBVofdBW3sgq5c=;
        b=BxiPuhZED8yA4Fho3BbXhWC7pSJK758QOnmAy0WoeR43ZjzXZUvzlbyB/r0id25WNw
         XC74c/9z3ZXJjQjHoL5tSN7YLPAz7Jf2dfj/PUgw8neqUT2/ql3sY+13gI5tDf7vfaJo
         xwsC9IHzmlax5DVGr4cBGfGFlpyUrGCz2evTqsSp1a2ahHlVc/vuiBfAUux0QbMTLo55
         6tGa+DuZjTKu5teH+ZC14tuKMmZX0LssKzc1UmDye093c11MeVPhUJBvtyc6Wb8SpYss
         MzPk0pWBCr5LFB/PRaFz0rvUAO1xApo99OadPvTYBk7jHhBP9Wxvf7/t/uW+0YjQz9qf
         RZyQ==
X-Gm-Message-State: AOAM533+NOmS99KYgy0mCWXhlgqKkWiMEELVNG1f62hUCkAIoz2RJRdX
        YiqHqAv0UsYoSXrBb8SNANbZMA==
X-Google-Smtp-Source: ABdhPJw7e/wORoEphD60Ma+eCczcirA3YOZoOwIoYuv97QFY+ER1reFifPnoU6cQu5aFzCmqGq8K8w==
X-Received: by 2002:a17:90b:368b:b0:1e6:67a0:1c17 with SMTP id mj11-20020a17090b368b00b001e667a01c17mr7494284pjb.203.1654849269662;
        Fri, 10 Jun 2022 01:21:09 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090aaf8400b001e0abbc3a74sm1092638pjq.5.2022.06.10.01.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] OPP: Remove rate_not_available parameter to _opp_add()
Date:   Fri, 10 Jun 2022 13:50:46 +0530
Message-Id: <d141dc4605199de55c33e5ae06cc9aad8fe441b1.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 32715be4fe95 ("opp: Fix adding OPP entries in a wrong order if
rate is unavailable") removed the only user of this field, get rid of
rest of it now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  4 ++--
 drivers/opp/of.c   | 10 ++++------
 drivers/opp/opp.h  |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 404f43759066..fe447f41c99e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1695,7 +1695,7 @@ void _required_opps_available(struct dev_pm_opp *opp, int count)
  *  should be considered an error by the callers of _opp_add().
  */
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
-	     struct opp_table *opp_table, bool rate_not_available)
+	     struct opp_table *opp_table)
 {
 	struct list_head *head;
 	int ret;
@@ -1774,7 +1774,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
-	ret = _opp_add(dev, new_opp, opp_table, false);
+	ret = _opp_add(dev, new_opp, opp_table);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
 		if (ret == -EBUSY)
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e07fc31de416..bec9644a7260 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -808,8 +808,8 @@ static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
 	return ret;
 }
 
-static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
-			 struct device_node *np, bool *rate_not_available)
+static int _read_opp_key(struct dev_pm_opp *new_opp,
+			 struct opp_table *opp_table, struct device_node *np)
 {
 	bool found = false;
 	u64 rate;
@@ -825,7 +825,6 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *opp_table
 		new_opp->rate = (unsigned long)rate;
 		found = true;
 	}
-	*rate_not_available = !!ret;
 
 	/*
 	 * Bandwidth consists of peak and average (optional) values:
@@ -881,13 +880,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	struct dev_pm_opp *new_opp;
 	u32 val;
 	int ret;
-	bool rate_not_available = false;
 
 	new_opp = _opp_allocate(opp_table);
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
+	ret = _read_opp_key(new_opp, opp_table, np);
 	if (ret < 0) {
 		dev_err(dev, "%s: opp key field not found\n", __func__);
 		goto free_opp;
@@ -920,7 +918,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (opp_table->is_genpd)
 		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
 
-	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
+	ret = _opp_add(dev, new_opp, opp_table);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
 		if (ret == -EBUSY)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 407eee9f10ab..4d8894ef2975 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -226,7 +226,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
-int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
+int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
-- 
2.31.1.272.g89b43f80a514

