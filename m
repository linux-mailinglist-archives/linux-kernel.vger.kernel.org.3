Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44CF565463
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiGDMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiGDMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFE10DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k14so8412995plh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xl1HN34mhSotDnvkt8tXbixjNJQAdLGe7tUjPgb4h/M=;
        b=hejDPxc4/RjWZjryn7VcZq2nFLoqh3D59bqolGEGxKaoAO4HZ9dhFD1ae9+7+eHVo3
         HdDau2hnwokSRTjXgR6W4AJgKGXuJLqrEcYvNRpbSjFgO/FOeUg4NWbl+EeaJLR/CXL2
         kVoWTBkwswESs/0Z/TC8GJWauLe1k4y78Hux8yuLm1yIaWN99UxzpFrofpE31qFi9sSM
         ia6hU9BjtJioEODs+PZ0sLGB8yqjfJrZEC/1+bYVGT39nfAXJmE/oGxJfckjTZX4i512
         JwzzQImON4dckvSgJi8X99FS90ojLTtXcsetHnqyRX56R3pWpUHfmoRjQxDxZbeWJJaI
         c3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl1HN34mhSotDnvkt8tXbixjNJQAdLGe7tUjPgb4h/M=;
        b=DfOQ6Zm26GoIllQ6Ph6z5DM8BWgq8+thTdALGbMNncpTgFGS4qLx4utKUls3p4rznt
         3B+N8F6ki0trCaWS6c491ZvdgmDN523I4mxeafcpf29sFB62m/jH+dWG6vbyLtN/atZ/
         byEKp6jKjKv1FdSI+DB5mSdTaoeka8v8iBWacHfd917CNlEXv+0d0ieRtppMsT9saw02
         5FfsfMu2Rp8/KyGYVxIRPLudY2d/1xp+oViFLfpRJNTh+mZbMxtgu9YBQal0TNZk2xQh
         qEM0BhnvHdhAFLAgnUvZbljnyOEtfzvRzqe3R22BSEteju4NmLu113n8zediAVNCH4ik
         ReoA==
X-Gm-Message-State: AJIora8BSKODrvF6Pcevasy1iImrsWWpAncRWdfWeMij/wm0FUiQiG5v
        3Uhji5/KnjWrSF+w1R56MhuqGw==
X-Google-Smtp-Source: AGRyM1vSrGUtt8sLadqWT6ivitaXEtkpIrx4RhuIhulQC2xIcP13GoJJAeiT2ojX22gwqUQrgqnIlA==
X-Received: by 2002:a17:90b:3d0f:b0:1ed:3dd0:900d with SMTP id pt15-20020a17090b3d0f00b001ed3dd0900dmr35349600pjb.191.1656936502167;
        Mon, 04 Jul 2022 05:08:22 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902a51700b001690d283f52sm20713693plq.158.2022.07.04.05.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 04/20] cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
Date:   Mon,  4 Jul 2022 17:37:42 +0530
Message-Id: <4623510dc596f65502c44f2879c9cc5dd650dbd3.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 109 +++++++--------------------
 1 file changed, 28 insertions(+), 81 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6dfa86971a75..863548f59c3e 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -55,9 +55,7 @@ struct qcom_cpufreq_match_data {
 };
 
 struct qcom_cpufreq_drv {
-	struct opp_table **names_opp_tables;
-	struct opp_table **hw_opp_tables;
-	struct opp_table **genpd_opp_tables;
+	int *opp_tokens;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
 };
@@ -315,72 +313,43 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	}
 	of_node_put(np);
 
-	drv->names_opp_tables = kcalloc(num_possible_cpus(),
-				  sizeof(*drv->names_opp_tables),
+	drv->opp_tokens = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tokens),
 				  GFP_KERNEL);
-	if (!drv->names_opp_tables) {
+	if (!drv->opp_tokens) {
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
+			drv->opp_tokens[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
+			if (drv->opp_tokens[cpu] < 0) {
+				ret = drv->opp_tokens[cpu];
+				dev_err(cpu_dev, "Failed to set OPP config\n");
+				goto free_opp;
 			}
 		}
 	}
@@ -395,27 +364,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->names_opp_tables[cpu]))
-			break;
-		dev_pm_opp_put_prop_name(drv->names_opp_tables[cpu]);
-	}
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->hw_opp_tables[cpu]))
-			break;
-		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
-	}
-	kfree(drv->hw_opp_tables);
-free_opp_names:
-	kfree(drv->names_opp_tables);
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
+	kfree(drv->opp_tokens);
 free_drv:
 	kfree(drv);
 
@@ -429,15 +381,10 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
-		dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
-		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
-		dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
-	}
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
 
-	kfree(drv->names_opp_tables);
-	kfree(drv->hw_opp_tables);
-	kfree(drv->genpd_opp_tables);
+	kfree(drv->opp_tokens);
 	kfree(drv);
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514

