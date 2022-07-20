Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAE57BE71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiGTT2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiGTT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:28:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404EF491FD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w17so22297468ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEPz8nGMymbCfzl+yOiKGHx/SSkvUB4KvjWS7eUhSMU=;
        b=CKMuwBnWdW82jQlLWf+eiCVslJkPfvAH73iHT0IVs4T8b1tj8JZ0ro4DAPUHQkW7Rd
         Y2ocEVzC8vawBFDDdTkCHi6qGCiwRfxn4kdf9lmN1QkEQzSgUdJW9qLAsDt91OThAX+Q
         QqS6WEPzG3k6IT8pRUFYRg58VI5LaGmSSPQ0+3G9C83U9gC1YXYf1fkJurGxmuHeMkE+
         GMrI1NjsK8hlEboyUXXCDQDcU2zKrZJa/rcirqzU0+s+S3EZsQP9He9tAglqZ99OpR5u
         E2rxWrirmtEg0F69V3cQlWOSfKWUm3KOCeEgYS8XuSu7vAL4soMchGQufebbu1aG2gyD
         KDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEPz8nGMymbCfzl+yOiKGHx/SSkvUB4KvjWS7eUhSMU=;
        b=YqmAzqkWAWs25ueIgsFhsUKT99EygyCiNwDfJvBjspYb5hW6MS4/YMk7avFYvvX1Fn
         5i0Yj3Azq7Skr2fB4B6y/Q0UbCqTH4evmWbbAJQNii5lxp7YiEbrk/4NqChis2OT+PVU
         jIsdKQ826giMzy6i/66M9DGcLdHga5Q/1rHerDLliwvlYE86JODxJoJbJ0+KYZl0iQt/
         QiNDdVqyfuiuLWgs69KGIPu5BEVVbHWb2HoAnogqE0hMUcr43/7oWBTBAvox8j0Ylcid
         o6gFQUtw7RqHEchVts/C3E9tg6eChHsQbjnsk2JZOMNM/RU2EYLCvBRFpGIzBg26yWwy
         nODg==
X-Gm-Message-State: AJIora/pdHq2DbZv81PJQsFh7tc3YvzO3e2wu0JylEGmjQiLIKxd2vds
        JzBv3MPsovlGAs8bc/xN5GJynw==
X-Google-Smtp-Source: AGRyM1twPs/i4yBHNudsL3an3crul+NdmRjcyU3ZBKot5TGrNwKMGq2deoP8xkX/Rw74/RWBdgamFA==
X-Received: by 2002:a2e:8609:0:b0:25d:6af0:63b5 with SMTP id a9-20020a2e8609000000b0025d6af063b5mr18166121lji.360.1658345297461;
        Wed, 20 Jul 2022 12:28:17 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 04/10] soc: qcom: icc-bwmon: store reference to varian data in container
Date:   Wed, 20 Jul 2022 21:28:01 +0200
Message-Id: <20220720192807.130098-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index b76a59d9002c..93c3cec84721 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -118,11 +118,10 @@ struct icc_bwmon_data {
 
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
@@ -199,20 +198,20 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
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
 
@@ -267,7 +266,7 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 	 */
 	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
 	max *= BWMON_COUNT_UNIT_KB;
-	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->sample_ms);
+	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -329,14 +328,13 @@ static int bwmon_probe(struct platform_device *pdev)
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
@@ -364,8 +362,6 @@ static int bwmon_probe(struct platform_device *pdev)
 	if (IS_ERR(opp))
 		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
 
-	bwmon->sample_ms = data->sample_ms;
-	bwmon->default_lowbw_kbps = data->default_lowbw_kbps;
 	bwmon->dev = dev;
 
 	bwmon_disable(bwmon);
@@ -376,7 +372,7 @@ static int bwmon_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
 	platform_set_drvdata(pdev, bwmon);
-	bwmon_start(bwmon, data);
+	bwmon_start(bwmon);
 
 	return 0;
 }
-- 
2.34.1

