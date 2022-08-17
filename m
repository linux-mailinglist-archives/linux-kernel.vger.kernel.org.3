Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278A7596F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiHQNO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiHQNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:14:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502014CA1C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:14:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx38so13501150ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NUd8YryzxRUKn1lcURqTFfrnvxH9vHeWn1VsvKW9iig=;
        b=j8crz0TGC0TwfsN5OrJTRjy9ExfL2boMNIiIoZ1GY8DY2Wi8+8b5X5/lv2gqmY7V6o
         aG0tfYcAOL6OX55fn2TtvZjNbo4cbB98QqLI6hmhHXa0sJFp+4Pd3hGETSYGKooGCm69
         i+J0aZOHrU0Gm+Avl9S6OpiDSVZGKzhpbo2W8t4jSJjmP6wfesLIgEK84+vqfZ6B559+
         X0gwLCno8PNjo0efY5DtGg0dRn0mtlx988H4zpYMPU3XV3OB7Z1rpjE0ToYiWrO8C3EF
         6h4nSwl1PdoWkcuKcYIzDm8rBZdZhVBCMF1EautAoqjbAWO147MRzL1Mp8x0z6ZxSZik
         H8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NUd8YryzxRUKn1lcURqTFfrnvxH9vHeWn1VsvKW9iig=;
        b=f313td/dOrpIDdvunEUWFWBUs+e60zxQwMYWXx6iYTvQyfG6WRLrTmzjpvpimGmlsO
         Tq1wrqBhoaL9xRbD2LllxW60UhzYdWuAvJclGvfRStOd/bfQy+EkLs0BMWI9xHaBYStM
         FH2Wc5joUnvKR4xTIXMVsMl1E7wb5URr7EMF7xSApWxrNTFKVlCw/LX26ZXfN3VQcKvR
         r4grecddpW66MrYpmMoMvPTE7j6JrnV7gE5+DgnoiUQOXgNObDTHwDlvGxaUvgtm1mTG
         Ti5lGvLCc6tZT6NlTsddBDC4EbARwrWWysdb3ZUG9kd3R/tfQ/dc94DqeNmnqk7vvkSy
         UTHQ==
X-Gm-Message-State: ACgBeo2/Cjto/F5VCMFAn4m0CzT2pXLbAYdKlZg1eg0D2gwUfxh423jC
        gD9hRJqOFVXb6SmJVeYUbROy9g==
X-Google-Smtp-Source: AA6agR4ODr7SKicA1GAKwnAKK/adpoZpki8+XPbXTk8r1Ll36pXGE75J4H1rXOx4tDjMzSsB4QzPbA==
X-Received: by 2002:a05:651c:154a:b0:25e:7b43:133f with SMTP id y10-20020a05651c154a00b0025e7b43133fmr8631623ljp.137.1660742068771;
        Wed, 17 Aug 2022 06:14:28 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea261000000b0026182f31aa0sm1411307ljm.1.2022.08.17.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:14:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 05/12] hwspinlock: qcom: add support for MMIO on older SoCs
Date:   Wed, 17 Aug 2022 16:14:08 +0300
Message-Id: <20220817131415.714340-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817131415.714340-1-krzysztof.kozlowski@linaro.org>
References: <20220817131415.714340-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Qualcomm SoCs have TCSR mutex registers with 0x80 stride, instead
of 0x1000.  Add dedicated compatibles and regmap for such case.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 42 +++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 9734e149d981..9cf186362ae2 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -22,6 +22,7 @@
 struct qcom_hwspinlock_of_data {
 	u32 offset;
 	u32 stride;
+	const struct regmap_config *regmap_config;
 };
 
 static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
@@ -73,15 +74,42 @@ static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
 	.stride = 0x4,
 };
 
-/* All modern platform has offset 0 and stride of 4k */
+static const struct regmap_config tcsr_msm8226_mutex_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x1000,
+	.fast_io		= true,
+};
+
+static const struct qcom_hwspinlock_of_data of_msm8226_tcsr_mutex = {
+	.offset = 0,
+	.stride = 0x80,
+	.regmap_config = &tcsr_msm8226_mutex_config,
+};
+
+static const struct regmap_config tcsr_mutex_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x20000,
+	.fast_io		= true,
+};
+
 static const struct qcom_hwspinlock_of_data of_tcsr_mutex = {
 	.offset = 0,
 	.stride = 0x1000,
+	.regmap_config = &tcsr_mutex_config,
 };
 
 static const struct of_device_id qcom_hwspinlock_of_match[] = {
 	{ .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
 	{ .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
+	{ .compatible = "qcom,apq8084-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
+	{ .compatible = "qcom,ipq6018-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
+	{ .compatible = "qcom,msm8226-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
+	{ .compatible = "qcom,msm8974-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
+	{ .compatible = "qcom,msm8994-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
@@ -117,14 +145,6 @@ static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
 	return regmap;
 }
 
-static const struct regmap_config tcsr_mutex_config = {
-	.reg_bits		= 32,
-	.reg_stride		= 4,
-	.val_bits		= 32,
-	.max_register		= 0x20000,
-	.fast_io		= true,
-};
-
 static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
 						 u32 *offset, u32 *stride)
 {
@@ -133,6 +153,8 @@ static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
 	void __iomem *base;
 
 	data = of_device_get_match_data(dev);
+	if (!data->regmap_config)
+		return ERR_PTR(-EINVAL);
 
 	*offset = data->offset;
 	*stride = data->stride;
@@ -141,7 +163,7 @@ static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
-	return devm_regmap_init_mmio(dev, base, &tcsr_mutex_config);
+	return devm_regmap_init_mmio(dev, base, data->regmap_config);
 }
 
 static int qcom_hwspinlock_probe(struct platform_device *pdev)
-- 
2.34.1

