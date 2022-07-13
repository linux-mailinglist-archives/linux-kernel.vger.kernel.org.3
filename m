Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04035572E84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGMGxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiGMGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:53:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF6E0272
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o18so9632280pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTHrG+AiEAASW62UUHSXPoZhBabigLGA1NFXrtvXNCU=;
        b=cbK4S3VM4IoP/3Ay5DwkS8JgSje4eih8NrDdAy/cn24jMNbHOjlfgY/1ZG0KLbXVzs
         aBx0odcR8ElrwiScQ1+FLKZCldKZUJS4diMGgM27SzlNwpGlhCGbldRC0kjfq0180Yxl
         pX13EfXDXpew3rRkfEYw36fuKOl9YvIx4pAje+rJ59L78X5l8aetlmObvqe6NEFGU/bH
         Vq1r2jAeZmhGHpYlyGC/Gf6YJPXDJIPKVfEVDI86hcp4Ek2La5pyTmIe+SbR+BDpp1kY
         6i6tC76qpgP2OnPa6gLm2SzPPSDhY8jrcuPMzVrqAu7MvLAKqVHXeJICAvhXRHUCRL+y
         5YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTHrG+AiEAASW62UUHSXPoZhBabigLGA1NFXrtvXNCU=;
        b=cfATQLWscRLi9CCkgKc5r+XVNT86ckmkTNDm8k+LVg5XqQs52lpzORigaZT98g8q8Q
         hfk6aylgpVv70cEGGGsqCnsCXKeUPs4pK5zR3oJSgftQ5EKiZerLAiZSKljNs8SkmM98
         VUxaLkh3zazlZj3uN0Dx8Oc/NK0ehplTsAQafvI5MBdZonANyWlQhME7eoN3tkjivrb1
         mDQ0LnUqmI93MMwKZzO3vAEFerB+tD3qQBFmrrxtdJRsEe+7gtacCgE1fZjteobi3V77
         6PFfDt8RK04fNySI6ytu8W4I22n4Fta87x1n5d92NmZ/Dm90ce719PcqjMgvGBBM/ln4
         +Mvw==
X-Gm-Message-State: AJIora/vf1AptH1X+y0CNY+z6mEGxhyil9FOM4LHzx1LC7JG5kW4CVpE
        WkbpbpoSDP0shrFqQ0QImLRjQQ==
X-Google-Smtp-Source: AGRyM1sNhiooVPvw3r752YmX5Lj9wifPPNQPO4wl2VaefmOOB+89HK7BlQ43chpADpN7qevdH348pA==
X-Received: by 2002:a05:6a00:181c:b0:52a:bc83:d767 with SMTP id y28-20020a056a00181c00b0052abc83d767mr1692107pfa.76.1657695199396;
        Tue, 12 Jul 2022 23:53:19 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 7-20020a621607000000b005283d34af49sm8215814pfw.176.2022.07.12.23.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:53:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] cpufreq: qcom-cpufreq-hw: Clocks are moved to CPU nodes
Date:   Wed, 13 Jul 2022 12:22:58 +0530
Message-Id: <eaa5e9b4a1df82d7cbf2dbd1f267544d69690c97.1657695140.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657695140.git.viresh.kumar@linaro.org>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
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

The clocks are not in the cpufreq-hw node anymore, and are moved to the
respective CPU nodes. Make changes accordingly here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++--------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0253731d6d25..05fce4a559ca 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -57,9 +57,10 @@ struct qcom_cpufreq_data {
 	struct cpufreq_policy *policy;
 
 	bool per_core_dcvs;
+	unsigned long cpu_hw_rate;
+	unsigned long xo_rate;
 };
 
-static unsigned long cpu_hw_rate, xo_rate;
 static bool icc_scaling_enabled;
 
 static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
@@ -209,9 +210,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 		volt = FIELD_GET(LUT_VOLT, data) * 1000;
 
 		if (src)
-			freq = xo_rate * lval / 1000;
+			freq = drv_data->xo_rate * lval / 1000;
 		else
-			freq = cpu_hw_rate / 1000;
+			freq = drv_data->cpu_hw_rate / 1000;
 
 		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
 			if (!qcom_cpufreq_update_opp(cpu_dev, freq, volt)) {
@@ -293,7 +294,7 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 	else
 		lval = readl_relaxed(data->base + data->soc_data->reg_domain_state) & 0xff;
 
-	return lval * xo_rate;
+	return lval * data->xo_rate;
 }
 
 static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
@@ -480,6 +481,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
 	struct resource *res;
+	struct clk *clk;
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	int ret, index;
@@ -527,6 +529,24 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto unmap_base;
 	}
 
+	clk = clk_get(cpu_dev, "xo");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto error;
+	}
+
+	data->xo_rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	clk = clk_get(cpu_dev, "alternate");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto error;
+	}
+
+	data->cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
+	clk_put(clk);
+
 	data->soc_data = of_device_get_match_data(&pdev->dev);
 	data->base = base;
 	data->res = res;
@@ -637,23 +657,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	struct device *cpu_dev;
-	struct clk *clk;
 	int ret;
 
-	clk = clk_get(&pdev->dev, "xo");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	xo_rate = clk_get_rate(clk);
-	clk_put(clk);
-
-	clk = clk_get(&pdev->dev, "alternate");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
-	clk_put(clk);
-
 	cpufreq_qcom_hw_driver.driver_data = pdev;
 
 	/* Check for optional interconnect paths on CPU0 */
-- 
2.31.1.272.g89b43f80a514

