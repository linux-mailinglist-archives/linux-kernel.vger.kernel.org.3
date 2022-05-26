Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ACD534E68
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347227AbiEZLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345972AbiEZLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF163DDEA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z11so1520298pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rm1D/w2QvTu4or6R4hVEWZEG7Ji+GbsLOWNM+13EdT0=;
        b=Fd6PbFwGgpst1ab5pqOOW4QTQNxMqsotRztlxhyBXRB9vSU8cR6l8K41Jbn967c9An
         MFLcQSGLMm7Mf/rirshMD4Sv+3ABPCSjnyZ4krYlhRhdAd5Dl1q4SJGjZ5qNaqRWihRA
         J9+lJtvhvQ0tBVhuUY6uoz/0PBzfEC2kioPqVDuMoYW2Z6WEawIjGAjeZJ6Y4UMAX7xj
         CRP/wK7D/TBdX68CnrinT62c0JI4dD8dZOHu33+1NBXljRLPA3AVTGkfToUUYDAN+Cg8
         7HJrhThNKB0IqEON+9/H65bREo6Gg0wtQKOGiUfo/5mZbA0Uzsc54ww9Dcu8PborF3qP
         7oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rm1D/w2QvTu4or6R4hVEWZEG7Ji+GbsLOWNM+13EdT0=;
        b=00vV+rj3+OpWv2vbKy0rZ65ZvqWJwP+ST1nkDdaXE+hpi6ryvksL+0Zz+i+elmlUUT
         +mwwrIF9loOXKknOp7soN7RAgEGKn97uJan2/xLUoEYBi5wofvw3Qz75Mf6TWDuAt0la
         bRB67eYJZBfcIorD2rotzfbR7nw+bnjSLqvfeXHqf6FvzI10k/a5VzjG1Y+QX4LG4fSG
         8RoIBh06flHz0hCZH5NtmLSRZ5H3NgmSRzhaxSkv4I7C8oUCk/0sMItUzZY9I4l8uqb0
         pL1qTzRwoEWs5w9pf1V+zQ9r1T7lXUzi01kUJFzpX9hYkPBPfQeSfL4MgoNxv+I8vCgP
         k1bA==
X-Gm-Message-State: AOAM531H+A+FqqCwcm7a2LP7Bq4GbzSWGup9GkZGAAmWn5FZFxHvgxKU
        uLLkq8XBfZ3cmJkaelWsZ6IoBQ==
X-Google-Smtp-Source: ABdhPJwL2+vUZJljvm15zkMsICuHtMSjWDz1W5QvpfO7supCE+5odduI8PvAbAnWZVnkOOf/YRXaHQ==
X-Received: by 2002:a17:90a:8916:b0:1e0:9f07:6d39 with SMTP id u22-20020a17090a891600b001e09f076d39mr2200543pjn.163.1653565417763;
        Thu, 26 May 2022 04:43:37 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id o20-20020a63fb14000000b003ed6b3dc52esm1331741pgh.55.2022.05.26.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:37 -0700 (PDT)
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
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/31] cpufreq: imx: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:03 +0530
Message-Id: <2d9e2996d9ca9da1561f50f58520c7f2ced53e0a.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/imx-cpufreq-dt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 3fe9125156b4..57917b0670f2 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
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
+	cpufreq_opp_table = dev_pm_opp_set_config(cpu_dev, &config);
 	if (IS_ERR(cpufreq_opp_table)) {
 		ret = PTR_ERR(cpufreq_opp_table);
-		dev_err(&pdev->dev, "Failed to set supported opp: %d\n", ret);
+		dev_err(&pdev->dev, "Failed to set Opp config: %d\n", ret);
 		return ret;
 	}
 
 	cpufreq_dt_pdev = platform_device_register_data(
 			&pdev->dev, "cpufreq-dt", -1, NULL, 0);
 	if (IS_ERR(cpufreq_dt_pdev)) {
-		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		dev_pm_opp_clear_config(cpufreq_opp_table);
 		ret = PTR_ERR(cpufreq_dt_pdev);
 		dev_err(&pdev->dev, "Failed to register cpufreq-dt: %d\n", ret);
 		return ret;
@@ -176,7 +180,7 @@ static int imx_cpufreq_dt_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(cpufreq_dt_pdev);
 	if (!of_machine_is_compatible("fsl,imx7ulp"))
-		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		dev_pm_opp_clear_config(cpufreq_opp_table);
 	else
 		clk_bulk_put(ARRAY_SIZE(imx7ulp_clks), imx7ulp_clks);
 
-- 
2.31.1.272.g89b43f80a514

