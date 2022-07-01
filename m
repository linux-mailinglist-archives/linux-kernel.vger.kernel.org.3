Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EB562DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiGAIVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiGAIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:21:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C970E44
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:20:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h15-20020a17090a648f00b001ef3c529d77so4474895pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgbOoygWZaIIuor1RyiZGwebLyI7PYxrQBZVGVTI33I=;
        b=obCdm4rJzIAby9ExFqqvOXIVGWgQpZy95pRUIC38dC0eIr+MePjuGhl1A0Zzh7axhV
         oBTLRLs1niE+fF8sOtY4QAoyO5VqRj4FZiAT4ciUZy89txYOpFTijV/C8PXTfU3HfjBh
         l/A2STUX1L+mLvU2uMHF5BI4sqqxkKPFGsm6AtheWMfuRp1xCzdvxgUG9Q9xcntIlAa9
         3cLH720S30gUMnG57CrFy2k9ohBVVKyh7eHcCQ0amnV0ErJt5H3RfocVMUm0iG68H4qz
         oYjM28jiKUptzVA7+M27RYNIWBIAcLj3CtdfPEc5KNkLMZj6C6JBlREteUNoz2tdZWXI
         VI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgbOoygWZaIIuor1RyiZGwebLyI7PYxrQBZVGVTI33I=;
        b=ID8yTg899hoGr3sV3MMcSfX2lz3rUVBjG7S3mpDrFxmQrTAI37Uf0IhRfrkEMoszbY
         vgbuc/3qrKFt30haIbNie1g8SR6kvZf2AimUtRu5oMbm2tpa5vO9uAd8IZa43QBJt6Qg
         qzBollChTXtjPTA0FhmWjX/BIHxz10xc/iOwh5NTbuV0MSRDyMDfzLWELjNx8Vv/xiw1
         79rtr62OhL5nk6huPU0ga5ywp3rzD9KYs+wydgBcCO7mk9ZK7NeZJC7T0XjTgrKttkND
         YJCLdQEAWMNzqcnMk7EZrWfwNgYRr+M/ARPsW3ic0b47qwGRUOaxwfiac993i6dv87LF
         IZmA==
X-Gm-Message-State: AJIora/ZfgLQIdO/11NxQkkJWkrtc1EZOk3oNMPd9N4+Zh1g0aSKARA7
        txbIRQEtW190hzD3/syxvxyerg==
X-Google-Smtp-Source: AGRyM1tqcjCws6zg/SRdbpK7iJxqkiNnbiwu1OmSnN8KGWw1G6+vGEDusVUxK4VpgHd/fEzFYQ04bA==
X-Received: by 2002:a17:90b:4b48:b0:1ec:fc87:691c with SMTP id mi8-20020a17090b4b4800b001ecfc87691cmr17043869pjb.120.1656663655997;
        Fri, 01 Jul 2022 01:20:55 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016b8b35d725sm7861957pln.95.2022.07.01.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:20:55 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/30] cpufreq: imx: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:49:59 +0530
Message-Id: <d5a3279dac9503cb0457dd9b20c57de774ec1dfa.1656660185.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/imx-cpufreq-dt.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 3fe9125156b4..8104fed4ff7c 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -31,8 +31,8 @@
 
 /* cpufreq-dt device registered by imx-cpufreq-dt */
 static struct platform_device *cpufreq_dt_pdev;
-static struct opp_table *cpufreq_opp_table;
 static struct device *cpu_dev;
+static int cpufreq_opp_token;
 
 enum IMX7ULP_CPUFREQ_CLKS {
 	ARM,
@@ -86,6 +86,10 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	u32 cell_value, supported_hw[2];
 	int speed_grade, mkt_segment;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.supported_hw = supported_hw,
+		.supported_hw_count = ARRAY_SIZE(supported_hw),
+	};
 
 	cpu_dev = get_cpu_device(0);
 
@@ -153,17 +157,17 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "cpu speed grade %d mkt segment %d supported-hw %#x %#x\n",
 			speed_grade, mkt_segment, supported_hw[0], supported_hw[1]);
 
-	cpufreq_opp_table = dev_pm_opp_set_supported_hw(cpu_dev, supported_hw, 2);
-	if (IS_ERR(cpufreq_opp_table)) {
-		ret = PTR_ERR(cpufreq_opp_table);
-		dev_err(&pdev->dev, "Failed to set supported opp: %d\n", ret);
+	cpufreq_opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+	if (cpufreq_opp_token < 0) {
+		ret = cpufreq_opp_token;
+		dev_err(&pdev->dev, "Failed to set Opp config: %d\n", ret);
 		return ret;
 	}
 
 	cpufreq_dt_pdev = platform_device_register_data(
 			&pdev->dev, "cpufreq-dt", -1, NULL, 0);
 	if (IS_ERR(cpufreq_dt_pdev)) {
-		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		dev_pm_opp_clear_config(cpufreq_opp_token);
 		ret = PTR_ERR(cpufreq_dt_pdev);
 		dev_err(&pdev->dev, "Failed to register cpufreq-dt: %d\n", ret);
 		return ret;
@@ -176,7 +180,7 @@ static int imx_cpufreq_dt_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(cpufreq_dt_pdev);
 	if (!of_machine_is_compatible("fsl,imx7ulp"))
-		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		dev_pm_opp_clear_config(cpufreq_opp_token);
 	else
 		clk_bulk_put(ARRAY_SIZE(imx7ulp_clks), imx7ulp_clks);
 
-- 
2.31.1.272.g89b43f80a514

