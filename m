Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8968156639E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiGEHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiGEHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:01:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B811143
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:01:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so5182045pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnPaxH1mDSIZ2e0GPjWftFKnYfExNBe634PCeF5701I=;
        b=u0/ja3+gzAShKN6od06YgRN0+EGIwLFWHCcHMqrhK1OuLT/q7/z0A7GTO8fHEsmENa
         RPhjD9ICXz65xj+j2vi03p3qYBuXe8mK09mrt3WOedwsDu+5PHtNznf/cK3FXR4wuhjz
         Vo3Gnibs1I8n6zHJi0MNeET2Qq95OKZxHrTMblvQ0FOHlh+uFp3tg9aFEFFGcrK9K8A7
         K5Euw9lBjy+qM5MpKyT0VDZWOqpumVqX4oshKpighn4dnJ2X+sSJHGbJUTf5lNB8DIZe
         wU5s9kqAgKJSlwHMgSvw5CGCANGz1g7pf2pWNy42iHSifmHGMuHPLVGwt8ajeDGMcbQf
         ZgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnPaxH1mDSIZ2e0GPjWftFKnYfExNBe634PCeF5701I=;
        b=tAp5bvp3B+dPQXp/tAqRYmGPHClZaJYff7CQwNg7ohbS5Qc+MchdCKcwUWhGSJ+2iJ
         5Lp4h+NcWioZBnha160wp3WuvIqtqY8jqRKMXamaZZ5jI1t9VUw6Z00Xb3ErIX1d72xT
         ZbbkVSvybg6xrKFycX0c0QNQ+tH6He83yNYhwudThLzeRvArNTqTdVJPPGY6hDmSGTuN
         0cXJ4grEkID8X7OsuVZ84zlTjrUHAMxD4aaLUUD5O0c33cP5QkPSBzEw/DJ57RoljSS6
         BS2qhaxK8zEkb7mviU/MIA+IW7VGDXSTdLp4wMxnizVmr+M0m2e1dBGjmy3f0fLMqG0H
         KYxw==
X-Gm-Message-State: AJIora+qpmv32LTfJRWfm7W0x0AiO5psSMOdr6hqjzfVth/VxBUOEwzJ
        1xThbjEOtYgLm8GJZVe4lSCTOw==
X-Google-Smtp-Source: AGRyM1tjcbGETqs70V1A+ZZhLgbBZCVq5Tv/ZsONxxt2m7iSUGbCm4TgP9CVwz8uwJRRcRfg8CCLVg==
X-Received: by 2002:a17:90a:408f:b0:1d1:d1ba:2abb with SMTP id l15-20020a17090a408f00b001d1d1ba2abbmr43123411pjg.152.1657004466394;
        Tue, 05 Jul 2022 00:01:06 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w194-20020a627bcb000000b005286308ee62sm3641624pfc.121.2022.07.05.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:01:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/13] PM / devfreq: tegra30: Register config_clks helper
Date:   Tue,  5 Jul 2022 12:30:15 +0530
Message-Id: <17e26d352a8de3e003d2f6b578d1d037737682a2.1657003420.git.viresh.kumar@linaro.org>
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

There is a corner case with Tegra30, where we want to skip clk
configuration that happens via dev_pm_opp_set_opp(), but still want the
OPP core to read the "opp-hz" property so we can find the right OPP via
freq finding helpers.

The OPP core provides support for the platforms to provide config_clks
helpers now, lets use that instead of devm_pm_opp_of_add_table_noclk()
to achieve the same result, as the OPP core won't parse the DT's
"opp-hz" property anymore if the clock isn't provided.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/tegra30-devfreq.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 65ecf17a36f4..0e0a4058f45c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -821,6 +821,15 @@ static int devm_tegra_devfreq_init_hw(struct device *dev,
 	return err;
 }
 
+static int tegra_devfreq_config_clks_nop(struct device *dev,
+					 struct opp_table *opp_table,
+					 struct dev_pm_opp *opp, void *data,
+					 bool scaling_down)
+{
+	/* We want to skip clk configuration via dev_pm_opp_set_opp() */
+	return 0;
+}
+
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
@@ -830,6 +839,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	unsigned int i;
 	long rate;
 	int err;
+	const char *clk_names[] = { "actmon", NULL };
+	struct dev_pm_opp_config config = {
+		.supported_hw = &hw_version,
+		.supported_hw_count = 1,
+		.clk_names = clk_names,
+		.config_clks = tegra_devfreq_config_clks_nop,
+	};
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
@@ -874,13 +890,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_pm_opp_set_supported_hw(&pdev->dev, &hw_version, 1);
+	err = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
+		dev_err(&pdev->dev, "Failed to set OPP config: %d\n", err);
 		return err;
 	}
 
-	err = devm_pm_opp_of_add_table_noclk(&pdev->dev, 0);
+	err = devm_pm_opp_of_add_table_indexed(&pdev->dev, 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
 		return err;
-- 
2.31.1.272.g89b43f80a514

