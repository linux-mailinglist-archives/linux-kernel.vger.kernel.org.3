Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE86534E56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347231AbiEZLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347165AbiEZLnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2C3EBA9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x12so1122326pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1aSxoXPeQBXlB3qL18aLGtP/jLnJcgk49cmVEjZDqY=;
        b=kXLq05FZBLbJAaTe80aq29sNfqJD7IT3RIS7chlu+dkCEmzO1U1sbIbbTSt+r7eiRK
         pHRIZV78aRurYDHxEDxC87/tyCowtiuh3J1q8BO0WuEGu8ddjIXMdRcikwRMb7I7O7og
         s10o19L/EiZalAkrXMbbgaB7gwtLAGOphCpO7gcXjV6rK9xV7moRearJ5j2DlpWNTqP4
         tlYCqMIUBFYvIURsAxHBrlTPTsdHD5jjuIe8Lg2BhfBt2M9FE6nbZFrpVIU66Bj1TmJQ
         He78mg87wqSE6yb8ml71Tra0HXEXB2NM4YlUIv9wNUm3JfbzQk2DMYq0lD8aC7BFbj0h
         t3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1aSxoXPeQBXlB3qL18aLGtP/jLnJcgk49cmVEjZDqY=;
        b=WVKC0dZGw8a0OqcbbfwFOri+iUJJb+PVDHKW0d1N9GAO6Qe/k94FqH+7lF07x1qEhN
         UmIgwE3vzPNRYbU73bYUq0uR7aYfahLz4ID4fDFvErPDbVgOm+ce+UeRIgQqo5+V8q3p
         zSA6QcKWrDO9AIfPI83UORHDz1H8o8itgx1NI9dEMhn+bYlarF6PT6yV4Ax4bxhd8WUa
         Qxjm1tS/AdeAbwxUpxbMpTSE3zSEL/nuH9mwlll2p+xwz2HK1RKWiM78oHZTsL1j4Kso
         oEDApUm+ZiUAUd0ZckH43Xq1L+OIGoaxro0G5rySlcettWxbIvG3fDklldrO4KtpJEKK
         Fo2A==
X-Gm-Message-State: AOAM531EK96dilzRGHf665DcTnrYzIF8hawrDOSTG/Magx4bNeNSyebw
        LVgh50xs/eyCDWKZm8A5jRo1gA==
X-Google-Smtp-Source: ABdhPJxWRgVUAVoXBqPYan+UY9BAEdKbGzQtd1Y+4MoI7hCORnXl47xbN0MT2uthDuMSymRjvtUyQw==
X-Received: by 2002:a62:1b06:0:b0:518:1649:bb6d with SMTP id b6-20020a621b06000000b005181649bb6dmr38679459pfb.25.1653565420831;
        Thu, 26 May 2022 04:43:40 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id o20-20020a170903301400b0015e8d4eb234sm1280322pla.126.2022.05.26.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/31] cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:04 +0530
Message-Id: <e48beb3df8eba830a6b8918ddfa003cefb2b0292.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 107 ++++++++-------------------
 1 file changed, 29 insertions(+), 78 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6dfa86971a75..4166b8d93b70 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -55,9 +55,7 @@ struct qcom_cpufreq_match_data {
 };
 
 struct qcom_cpufreq_drv {
-	struct opp_table **names_opp_tables;
-	struct opp_table **hw_opp_tables;
-	struct opp_table **genpd_opp_tables;
+	struct opp_table **opp_tables;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
 };
@@ -315,72 +313,44 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	}
 	of_node_put(np);
 
-	drv->names_opp_tables = kcalloc(num_possible_cpus(),
-				  sizeof(*drv->names_opp_tables),
+	drv->opp_tables = kcalloc(num_possible_cpus(),
+				  sizeof(*drv->opp_tables),
 				  GFP_KERNEL);
-	if (!drv->names_opp_tables) {
+	if (!drv->opp_tables) {
 		ret = -ENOMEM;
 		goto free_drv;
 	}
-	drv->hw_opp_tables = kcalloc(num_possible_cpus(),
-				  sizeof(*drv->hw_opp_tables),
-				  GFP_KERNEL);
-	if (!drv->hw_opp_tables) {
-		ret = -ENOMEM;
-		goto free_opp_names;
-	}
-
-	drv->genpd_opp_tables = kcalloc(num_possible_cpus(),
-					sizeof(*drv->genpd_opp_tables),
-					GFP_KERNEL);
-	if (!drv->genpd_opp_tables) {
-		ret = -ENOMEM;
-		goto free_opp;
-	}
 
 	for_each_possible_cpu(cpu) {
+		struct dev_pm_opp_config config = {
+			.supported_hw = NULL,
+		};
+
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
 			ret = -ENODEV;
-			goto free_genpd_opp;
+			goto free_opp;
 		}
 
 		if (drv->data->get_version) {
+			config.supported_hw = &drv->versions;
+			config.supported_hw_count = 1;
 
-			if (pvs_name) {
-				drv->names_opp_tables[cpu] = dev_pm_opp_set_prop_name(
-								     cpu_dev,
-								     pvs_name);
-				if (IS_ERR(drv->names_opp_tables[cpu])) {
-					ret = PTR_ERR(drv->names_opp_tables[cpu]);
-					dev_err(cpu_dev, "Failed to add OPP name %s\n",
-						pvs_name);
-					goto free_opp;
-				}
-			}
-
-			drv->hw_opp_tables[cpu] = dev_pm_opp_set_supported_hw(
-									 cpu_dev, &drv->versions, 1);
-			if (IS_ERR(drv->hw_opp_tables[cpu])) {
-				ret = PTR_ERR(drv->hw_opp_tables[cpu]);
-				dev_err(cpu_dev,
-					"Failed to set supported hardware\n");
-				goto free_genpd_opp;
-			}
+			if (pvs_name)
+				config.prop_name = pvs_name;
 		}
 
 		if (drv->data->genpd_names) {
-			drv->genpd_opp_tables[cpu] =
-				dev_pm_opp_attach_genpd(cpu_dev,
-							drv->data->genpd_names,
-							NULL);
-			if (IS_ERR(drv->genpd_opp_tables[cpu])) {
-				ret = PTR_ERR(drv->genpd_opp_tables[cpu]);
-				if (ret != -EPROBE_DEFER)
-					dev_err(cpu_dev,
-						"Could not attach to pm_domain: %d\n",
-						ret);
-				goto free_genpd_opp;
+			config.genpd_names = drv->data->genpd_names;
+			config.virt_devs = NULL;
+		}
+
+		if (config.supported_hw || config.genpd_names) {
+			drv->opp_tables[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
+			if (IS_ERR(drv->opp_tables[cpu])) {
+				ret = PTR_ERR(drv->opp_tables[cpu]);
+				dev_err(cpu_dev, "Failed to set OPP config\n");
+				goto free_opp;
 			}
 		}
 	}
@@ -395,27 +365,13 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
-free_genpd_opp:
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->genpd_opp_tables[cpu]))
-			break;
-		dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
-	}
-	kfree(drv->genpd_opp_tables);
 free_opp:
 	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->names_opp_tables[cpu]))
+		if (IS_ERR(drv->opp_tables[cpu]))
 			break;
-		dev_pm_opp_put_prop_name(drv->names_opp_tables[cpu]);
+		dev_pm_opp_clear_config(drv->opp_tables[cpu]);
 	}
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->hw_opp_tables[cpu]))
-			break;
-		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
-	}
-	kfree(drv->hw_opp_tables);
-free_opp_names:
-	kfree(drv->names_opp_tables);
+	kfree(drv->opp_tables);
 free_drv:
 	kfree(drv);
 
@@ -429,15 +385,10 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
-		dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
-		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
-		dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
-	}
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_clear_config(drv->opp_tables[cpu]);
 
-	kfree(drv->names_opp_tables);
-	kfree(drv->hw_opp_tables);
-	kfree(drv->genpd_opp_tables);
+	kfree(drv->opp_tables);
 	kfree(drv);
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514

