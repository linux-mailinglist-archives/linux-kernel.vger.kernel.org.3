Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173F9534E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiEZLpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347255AbiEZLoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C6BD02B0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q4so1208571plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPsuNO4IJ7T2z2weCPNLXji/1rrU6SbwmIuvAfLuJdM=;
        b=gXnGQSuj+c45yeKB+8j1h5YrFgbmZ/F+ScjvzuqHVRExHvwyEIyIm5m2DGsq4eRivF
         P+M98Z8RwNJBIogL2m0HYIZ/Fwa/lLhneVU4VJ4Mj/sOV0eRgziQBZkii377HVD6QyY1
         2bI/Muk5RxlNiPNzwLamtJMg9nie/mRGw9lFbmQU1dDJfGWsoTyOloH1ViyUb9qy2iog
         R08xQMgbo7j+fugthPtNqBSIqZ60i0bcEzLumfuUcIQbXxbNMflFxtoh2dfLplEfco3s
         Mk6gkTfQyPxNUeu4yHFaMQt3tnDVqPzUxf2Z/qjS5HuGEXrcPAUGpj/kBGYO/P3ecI86
         SX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPsuNO4IJ7T2z2weCPNLXji/1rrU6SbwmIuvAfLuJdM=;
        b=th9GXuIcVGNQlfmwQP1VZ5fA7uedmgwHN71B8oPKq0NVHG1oAUvOcRP+f6S/+4Wa0a
         11aNTa/ZzX5KiDdi851YYCgs/ZfKwNbxYRO9elcyVprZ1gUiSZDe3ufgm24BS+jF9YRE
         /R1hpM7lzmZJdtEDwj8UqeUg/Yaf0YnxDrm1rbr3hfk/BZJ/Z6dH8gvJkplOao43nmNX
         7kjZ011UbDCmYDIwUoRKlSF0N0ot2+3mWtANlrSyEIVNNW5pqPX/Y51/ah5KGXb1SA+h
         9W2NaC//dg/+44UBYnfl1iN4u8uhX4/aVHFIul+jz97nt8D/ma56hwGy02m4zIVtz+h6
         pyGA==
X-Gm-Message-State: AOAM530gvvFbUyC0glRmB19n0HQctJXHlOv+xf/wMQwY8nPLzS8WaB6K
        ouMQXvSE5puV/dG5CHEduiJxMA==
X-Google-Smtp-Source: ABdhPJxHkvspcXsVc/hjxvjqkI2gYKKMuKYXQeyh/YgUZZoPbuby4lZj7ryI8rRuulEhYMTROUIvnQ==
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id m2-20020a17090ade0200b001df3f94811cmr2197205pjv.112.1653565459142;
        Thu, 26 May 2022 04:44:19 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u30-20020a63235e000000b003c14af505fcsm1319907pgm.20.2022.05.26.04.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/31] media: venus: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:16 +0530
Message-Id: <1f243f35b02d53fde5bf730a7da1a789186f62b1.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/media/platform/qcom/venus/pm_helpers.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index cb48c5ff3dee..16f8849896a9 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -294,12 +294,15 @@ static int load_scale_v1(struct venus_inst *inst)
 static int core_get_v1(struct venus_core *core)
 {
 	int ret;
+	struct dev_pm_opp_config config = {
+		.clk_name = "core",
+	};
 
 	ret = core_clks_get(core);
 	if (ret)
 		return ret;
 
-	ret = devm_pm_opp_set_clkname(core->dev, "core");
+	ret = devm_pm_opp_set_config(core->dev, &config);
 	if (ret)
 		return ret;
 
@@ -862,6 +865,10 @@ static int vcodec_domains_get(struct venus_core *core)
 	const struct venus_resources *res = core->res;
 	struct device *pd;
 	unsigned int i;
+	struct dev_pm_opp_config config = {
+		.genpd_names = res->opp_pmdomain,
+		.virt_devs = &opp_virt_dev,
+	};
 
 	if (!res->vcodec_pmdomains_num)
 		goto skip_pmdomains;
@@ -879,7 +886,7 @@ static int vcodec_domains_get(struct venus_core *core)
 		return 0;
 
 	/* Attach the power domain for setting performance state */
-	ret = devm_pm_opp_attach_genpd(dev, res->opp_pmdomain, &opp_virt_dev);
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret)
 		goto opp_attach_err;
 
@@ -978,6 +985,9 @@ static int core_get_v4(struct venus_core *core)
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.clk_name = "core",
+	};
 
 	ret = core_clks_get(core);
 	if (ret)
@@ -1003,7 +1013,7 @@ static int core_get_v4(struct venus_core *core)
 	if (legacy_binding)
 		return 0;
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret)
 		return ret;
 
-- 
2.31.1.272.g89b43f80a514

