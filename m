Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D697583D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiG1LiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiG1LiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:38:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6BA54CB9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:37:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p21so1635163ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVi3swbk6lGpU9EJQbU7r2ZRE/KO3o6omSpmuiZtsWw=;
        b=w1W/Ury8HO4KqOu7zRw6RW6avw1X0Mx7lp+AFM5+L8gNxOjYQrRGluYLjYinO4VTqr
         csFHyvPdXVlO7fTCGdJATOWpP6feg8Q2vO4EH8iKbG5MMGFH8x+3kWUNn8ZSur9Ty9bu
         ynZ6X51TqcsJq8MUM9lntwu6UBmSPUeWyIkNP/FHwfkcwtfn7gTY6qv5ayIEhcJJybGy
         QJLljsCOunRvpMwHvjwjeVhEFxViZ/j8LA3eKF2OKCdNMni5k71uuXxl9J0dhbSlGPGQ
         sLZjRC6fEAi6u8yV7lRviEE5x/gwau7etD1JTagzZ1GAN0wXTefghUIm26pnMAvXI6Oc
         6igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVi3swbk6lGpU9EJQbU7r2ZRE/KO3o6omSpmuiZtsWw=;
        b=qzHqQWh8OwWhI28/wYTgDyo2XDyDLbwzb29NpZnG2bZu44YgUwX8j7/nhl9myggfyx
         dgijP33yHk+5SvuD6qoBybQVoe31Xoag4ZwY1UQY99ybvOOX9pc1SMvx24hnJKJLiI/y
         JxW76GoV6/2BxnxTNdukpyA6m7q8rz4u8F9H/Uzqbcv//dLEYK0xp3cr3mm1ej7iHv0+
         wcK3LC3XYLJ09NnyvvIGe4AlZYSRvquDph18jhGlfeQk0CrtHhC6oGuV5SVcbQAU/7tg
         /neo0bLglKPqrefPk0MTrBERyO1NfKAyzRD5/M4MwJsxy6YLQKy9S2JtjIctfDjRUEfT
         udPg==
X-Gm-Message-State: AJIora/dnfmW6Q9hvem8BfBvBIfIg6ylQONRJKCg/sACBM36O0DQLASj
        IQR65Bicjscy2t8BPopqW/Wedw==
X-Google-Smtp-Source: AGRyM1uJZtN6+fLM32G+sSz15AwD0OD2dt1jSpLQqVnJGNSEabBzgYbVhtYm5OMYCfSTeTGs3364Mg==
X-Received: by 2002:a2e:98d6:0:b0:25e:c2e:a5dd with SMTP id s22-20020a2e98d6000000b0025e0c2ea5ddmr6067980ljj.455.1659008278139;
        Thu, 28 Jul 2022 04:37:58 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:37:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 04/11] soc: qcom: icc-bwmon: store reference to variant data in container
Date:   Thu, 28 Jul 2022 13:37:41 +0200
Message-Id: <20220728113748.170548-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of copying pieces of variant-specific data (struct
icc_bwmon_data) into the state container (struct icc_bwmon), just store
a pointer to it.

This simplifies a bit the code and allows later to grow easily the
variant-specific data for new BWMON v5.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/soc/qcom/icc-bwmon.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 9295ea04356a..a820855e85b4 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -117,11 +117,10 @@ struct icc_bwmon_data {
 
 struct icc_bwmon {
 	struct device *dev;
+	const struct icc_bwmon_data *data;
 	void __iomem *base;
 	int irq;
 
-	unsigned int default_lowbw_kbps;
-	unsigned int sample_ms;
 	unsigned int max_bw_kbps;
 	unsigned int min_bw_kbps;
 	unsigned int target_kbps;
@@ -198,20 +197,20 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
 {
 	unsigned int thres;
 
-	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->sample_ms,
+	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->data->sample_ms,
 			  MSEC_PER_SEC);
 	writel_relaxed(thres, bwmon->base + reg);
 }
 
-static void bwmon_start(struct icc_bwmon *bwmon,
-			const struct icc_bwmon_data *data)
+static void bwmon_start(struct icc_bwmon *bwmon)
 {
+	const struct icc_bwmon_data *data = bwmon->data;
 	unsigned int thres_count;
 	int window;
 
 	bwmon_clear_counters(bwmon);
 
-	window = mult_frac(bwmon->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
+	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
 	/* Maximum sampling window: 0xfffff */
 	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
 
@@ -266,7 +265,7 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 	 */
 	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
 	max *= BWMON_COUNT_UNIT_KB;
-	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->sample_ms);
+	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -328,14 +327,13 @@ static int bwmon_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dev_pm_opp *opp;
 	struct icc_bwmon *bwmon;
-	const struct icc_bwmon_data *data;
 	int ret;
 
 	bwmon = devm_kzalloc(dev, sizeof(*bwmon), GFP_KERNEL);
 	if (!bwmon)
 		return -ENOMEM;
 
-	data = of_device_get_match_data(dev);
+	bwmon->data = of_device_get_match_data(dev);
 
 	bwmon->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bwmon->base)) {
@@ -363,8 +361,6 @@ static int bwmon_probe(struct platform_device *pdev)
 	if (IS_ERR(opp))
 		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
 
-	bwmon->sample_ms = data->sample_ms;
-	bwmon->default_lowbw_kbps = data->default_lowbw_kbps;
 	bwmon->dev = dev;
 
 	bwmon_disable(bwmon);
@@ -375,7 +371,7 @@ static int bwmon_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
 	platform_set_drvdata(pdev, bwmon);
-	bwmon_start(bwmon, data);
+	bwmon_start(bwmon);
 
 	return 0;
 }
-- 
2.34.1

