Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE9534E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiEZLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347188AbiEZLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D745AF8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n10so1513810pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6FKGuWTYeL9CyJXF/nui49yX2g2b8cAfQUyL7WS+yM=;
        b=H3PWYr6fgVdEpbNbAbKBUEcwfB5VncU0s52oMLsps2/EtOooxFx/vAzuIunub4nQIL
         bUREhE1yrLHPFBXLeuqAeehyM/+oP8dTM7Z9y+FgL7MjBtuMGm1gyYEvAQXf3kzIC4iK
         ovmdTFDrKNF+RsdaTOThoaul/xyMb5UDuKCtrIJAseOtW2k2uCsEETZWvFr8rpAP47tY
         F8es6ydbBX/oQWmIydzYPb464BkSllrspADZPLf7grD2dJI7PXk9YarEUyU/JLQYankt
         ptpi/g+6Gs9tpYmNsHyyPYO7qkeVDcy3fdkFnm5L4ugdVizMFdg9L30cYcph3vWSsS1j
         n03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6FKGuWTYeL9CyJXF/nui49yX2g2b8cAfQUyL7WS+yM=;
        b=74HxnLns7fEmo+I0XcC+UA1HKpxAB0Si+mzXD0yFH/2mw9uRbIhGeNuNw0sB61diSl
         46L6yu09VVh/xZf0EejaIBCLUYV8DeohDZvGYpA5EP3Mj4clUd/gR/7Q++FctqeVpc+b
         N5zqveBOuzQXjqQdXfwf/ZzUz06qhsmjJcdMTiRmHr217Ng18eGnoEmR8FEcu7oxc891
         5l3ymz1jymkgi8f/b2fVZentcB3K2BF6VokGlk+o9fXKwB+xBAFee8LE6GH/bm23+I+e
         CLlncXC8XiBygypCFrKrjxYub77qj9zNCJuEhQ/SYXL4V+1r9Hfpcr9TqqxGq3gZZbD8
         Gp/g==
X-Gm-Message-State: AOAM531LlbiEi1WacIczYnmQVfNJTHMmpzC9szh8Obna67/5SYGXVr2d
        t//A0eqjfmn8rwX4AiJmlUy07w==
X-Google-Smtp-Source: ABdhPJylJuyVRIVUb54hEn87GYfGffdmIDUn3OCcqUeKNw1PX/9AHVDbO9nW+pEOObcVYIfVJpAAvQ==
X-Received: by 2002:a17:90a:5515:b0:1dc:c1f1:59bd with SMTP id b21-20020a17090a551500b001dcc1f159bdmr2205074pji.81.1653565436253;
        Thu, 26 May 2022 04:43:56 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id ce17-20020a17090aff1100b001e09a4afd69sm1284556pjb.7.2022.05.26.04.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:55 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/31] devfreq: exynos: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:09 +0530
Message-Id: <052c4937ce408a01de5cd7d7e359d333f9b11e57.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/exynos-bus.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index e689101abc93..780e525eb92a 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -161,7 +161,7 @@ static void exynos_bus_exit(struct device *dev)
 
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
-	dev_pm_opp_put_regulators(bus->opp_table);
+	dev_pm_opp_clear_config(bus->opp_table);
 	bus->opp_table = NULL;
 }
 
@@ -182,11 +182,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	struct opp_table *opp_table;
 	const char *vdd = "vdd";
 	int i, ret, count, size;
+	struct dev_pm_opp_config config = {
+		.regulator_names = &vdd,
+		.regulator_count = 1,
+	};
 
-	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
+	opp_table = dev_pm_opp_set_config(dev, &config);
 	if (IS_ERR(opp_table)) {
 		ret = PTR_ERR(opp_table);
-		dev_err(dev, "failed to set regulators %d\n", ret);
+		dev_err(dev, "failed to set OPP config %d\n", ret);
 		return ret;
 	}
 
@@ -236,7 +240,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	return 0;
 
 err_regulator:
-	dev_pm_opp_put_regulators(bus->opp_table);
+	dev_pm_opp_clear_config(bus->opp_table);
 	bus->opp_table = NULL;
 
 	return ret;
@@ -459,7 +463,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	dev_pm_opp_of_remove_table(dev);
 	clk_disable_unprepare(bus->clk);
 err_reg:
-	dev_pm_opp_put_regulators(bus->opp_table);
+	dev_pm_opp_clear_config(bus->opp_table);
 	bus->opp_table = NULL;
 
 	return ret;
-- 
2.31.1.272.g89b43f80a514

