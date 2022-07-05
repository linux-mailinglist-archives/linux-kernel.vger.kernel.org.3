Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3456638E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiGEHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGEHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1089DF5AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so6989443pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orAHTGD4Jsa6jh6pgoHDIf1kVufO1X0WbaBUQ/zQ1ZQ=;
        b=Hkes36yGoFLr0vcDQ8HBOddE0S9RPDMGQ2Th5zNp7upEqgIFBJgkpTk2v2w2uY1n/y
         wV6TZc4txtUfXwJzfJTHW/sOlyBvyocSmUuJ5URjFGoexnl0SLDiCSdV9Z48UWozHipS
         3+AdevpFL3PqdWSB+6EVy3uFf97rz0eNtqzPwnOQSWMnfKCWJ04PzB4W7LyiVf0y0oQL
         g8bU7ZHOGe9l75lQqiKIUpbEZfxp/R7dVB/dl4eOkw0S2B18gYZ3wd3o/z1qR6ELAoWB
         dmRkMVZmHo9kTFzT+nMxQCdZrMAITeG3ockpy4QWEMwltdlVQwimaqBU/uZ2XvGpMEoH
         +R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orAHTGD4Jsa6jh6pgoHDIf1kVufO1X0WbaBUQ/zQ1ZQ=;
        b=3D/aO2vniEwsII1f8fODpVXMJgCZ6dZs5XcdZbzBNMIE6un6qSm5pZOU82p1DzczgJ
         +XQsY2RI5my1pgEeycSUC2LHiRrbAZRT9Q079l2Yh35VfUtYMJTGMv8gGgZa5QDUnPFF
         jro41v8O3GpXXIhAcrx9haftOE03j8W3NRRdD8hC3M9dycMUwpF9aASHRn7v0Sy+hJnC
         mRZ6YioDD8awxleUO9anViu4/gSwHXz/La6eBcJ21L2IHJXdKTRjJkqK7484iyi4RFQA
         cnJekDFdw1K2fE3NHmloANVdMTWacKpD8ms/R6ce+2KLC4bWUrNhdTltL1RSIEIdE7LM
         8sGQ==
X-Gm-Message-State: AJIora9QTtIT7wMfr+iwmIEhII2uHvF5ldJ3AxvHqwIyzKYuAcwBMTCt
        G24lARJaP20C5FUOuuD7RPU+FQ==
X-Google-Smtp-Source: AGRyM1sijueN2OOpd1ZrAUwr8JG70NPmQ6onkoe4e2aAtRJim21Uusnh9goNi4F9CYM78bbIauSgqw==
X-Received: by 2002:a63:4d26:0:b0:411:83dd:2c3 with SMTP id a38-20020a634d26000000b0041183dd02c3mr26690851pgb.508.1657004437162;
        Tue, 05 Jul 2022 00:00:37 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id cj15-20020a056a00298f00b0052559bd12aasm22000550pfb.61.2022.07.05.00.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/13] OPP: Remove rate_not_available parameter to _opp_add()
Date:   Tue,  5 Jul 2022 12:30:05 +0530
Message-Id: <1cc2e6afabbf1a6bdeea1a589f921a58b4d4d056.1657003420.git.viresh.kumar@linaro.org>
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

commit 32715be4fe95 ("opp: Fix adding OPP entries in a wrong order if
rate is unavailable") removed the only user of this field, get rid of
rest of it now.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  4 ++--
 drivers/opp/of.c   | 10 ++++------
 drivers/opp/opp.h  |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e836d3043d22..ae5949656d77 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1713,7 +1713,7 @@ void _required_opps_available(struct dev_pm_opp *opp, int count)
  *  should be considered an error by the callers of _opp_add().
  */
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
-	     struct opp_table *opp_table, bool rate_not_available)
+	     struct opp_table *opp_table)
 {
 	struct list_head *head;
 	int ret;
@@ -1792,7 +1792,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
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
index 13abe991e811..e449828ffbf4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -247,7 +247,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
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

