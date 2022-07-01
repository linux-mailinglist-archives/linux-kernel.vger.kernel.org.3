Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8159562DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiGAIVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiGAIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:21:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5170E77
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:21:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o18so580469pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLvm+NAa5BeE/i7Qo/3zGWdB4t6pSp8QC+y5KpzRMdM=;
        b=fwnyXMMkk7P3ih5uDwdTYK5Y0ERrPr6v0+GufM5RKzbD6qO14fEsskiV4ITy7/TT1K
         N8mZFTLF1vS0cVi2PzQHjDsWkiGzMO0mKp4wHVliBpaTHyrIJpcoeaz6IQWtp4ECIrym
         4uKpHNYn0heUaULAGTA/TKcBHIH9w4vBpKoBvdjNch4Q5uo9KYKKP7lwcWvyoBBlv67J
         Fd+GdHfKU2/nFaEebtnD5+BbZLfrHaYyVMeLQlAD7gTJivuaMjHEtp8oFjS0uXiFjRch
         JQ6i/+xV+EXSO+xkmjlCkexFR8ReX2o6r4NKCvpgSISIdFTXwsDKFqCSWM7K4zYd2vbU
         kt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLvm+NAa5BeE/i7Qo/3zGWdB4t6pSp8QC+y5KpzRMdM=;
        b=tFRFCvE9ETJwRMLdwOckSoM+VW0UCDhzxu4ZEgSzC87CfoC1bVYP5x1w9nXJWf4FYs
         xtPu1pHBYeNKioYAdxef8X7KTjHxCyhuXkBUxSjyy2B7LYb3Joh8rnTW14nVJ/Gt1Amv
         m2opfLKZc7W358n0E/QzLN7gnLizXOx6cNKQ8UckiQARZBTjH0AZF2EBmiSrI/ziLaqQ
         jzCh9FTGaASWt0K9ZDx7nPkn7wA3oMDPMgpcDSEakdVGdgagbg5bqjcpOBEWaUIuQfi7
         wXpZ+jfPPI5v3NVvy3gUU8JVpARDNHtJgTikSDMhAxE6B2XwfX8w+EqrVdOLivmMBv9N
         i9lA==
X-Gm-Message-State: AJIora9Gwin02waApx2837HIDYuzJLHHWHFt2r9PCvPxpT6aVZ0XK8+r
        DAkhaXVwn+pibCIWjFXkeIgdKg==
X-Google-Smtp-Source: AGRyM1s4oLyclufYs9wYwvrJNAdDcdUB4yykbH68vm/CdHwFSxjeFTYOUoGC4sTrKOYQvZyHzhfZlA==
X-Received: by 2002:a05:6a00:1312:b0:528:2ed8:7e35 with SMTP id j18-20020a056a00131200b005282ed87e35mr2521119pfu.13.1656663669507;
        Fri, 01 Jul 2022 01:21:09 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00161e50e2245sm14766175plk.178.2022.07.01.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/30] cpufreq: ti: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:04 +0530
Message-Id: <26dccec60b69c4a6b6902128de25a6b264bc57a4.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ti-cpufreq.c | 38 ++++++++++++++----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 8f9fdd864391..92a873e4d646 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -60,7 +60,6 @@ struct ti_cpufreq_data {
 	struct device_node *opp_node;
 	struct regmap *syscon;
 	const struct ti_cpufreq_soc_data *soc_data;
-	struct opp_table *opp_table;
 };
 
 static unsigned long amx3_efuse_xlate(struct ti_cpufreq_data *opp_data,
@@ -324,10 +323,13 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
 	const struct of_device_id *match;
-	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
 	const char * const default_reg_names[] = {"vdd", "vbb"};
 	int ret;
+	struct dev_pm_opp_config config = {
+		.supported_hw = version,
+		.supported_hw_count = ARRAY_SIZE(version),
+	};
 
 	match = dev_get_platdata(&pdev->dev);
 	if (!match)
@@ -370,33 +372,23 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_put_node;
 
-	ti_opp_table = dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
-						   version, VERSION_COUNT);
-	if (IS_ERR(ti_opp_table)) {
-		dev_err(opp_data->cpu_dev,
-			"Failed to set supported hardware\n");
-		ret = PTR_ERR(ti_opp_table);
-		goto fail_put_node;
-	}
-
-	opp_data->opp_table = ti_opp_table;
-
 	if (opp_data->soc_data->multi_regulator) {
-		const char * const *reg_names = default_reg_names;
+		config.regulator_count = ARRAY_SIZE(default_reg_names);
 
 		if (opp_data->soc_data->reg_names)
-			reg_names = opp_data->soc_data->reg_names;
-		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
-							 reg_names,
-							 ARRAY_SIZE(default_reg_names));
-		if (IS_ERR(ti_opp_table)) {
-			dev_pm_opp_put_supported_hw(opp_data->opp_table);
-			ret =  PTR_ERR(ti_opp_table);
-			goto fail_put_node;
-		}
+			config.regulator_names = opp_data->soc_data->reg_names;
+		else
+			config.regulator_names = default_reg_names;
+	}
+
+	ret = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
+	if (ret < 0) {
+		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
+		goto fail_put_node;
 	}
 
 	of_node_put(opp_data->opp_node);
+
 register_cpufreq_dt:
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 
-- 
2.31.1.272.g89b43f80a514

