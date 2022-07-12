Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93607571E70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiGLPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiGLPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:09:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADDC8E8A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:02:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w17so8633531ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysY8+Szjqk/lrdwwPO/ndEqlhqBj7oxmsr4P9sxksRA=;
        b=EhCHtHuWeCN/Yu+oALFreHL4jL2A34MqhFjL5bAlqM2YAAkQucb7S9s9BYb50eX6Mo
         MnnQDw7jLeSXJDdS42W3R7yB1eLVGX47ev55LTPa5YL10rRex80V7S/A+ceQR96GN7zU
         xiw8+AYyiQHTDYyOEj7hIyQegtTmOty39sSG4MJPsrUghCX/1J+mzFhQMg4f5yOQ2qvE
         fiMBTr7BZENIs6xAhLMIM4SQ15jEFSu5G7rvCx6ijWXVqPz+qUFPca0AY2BwClkmkn4o
         erZ+vOVqKgdROsJnaYn5iIxv0WR/HlzCelmVxuKjpFqpw5+MfnzHtbXAdE+zXo0qfIIc
         DSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysY8+Szjqk/lrdwwPO/ndEqlhqBj7oxmsr4P9sxksRA=;
        b=QecgQPYkn6uPeEc4v3ChUg1WdZh7qGV89HJMUDF/0bB8xNZW/QMAdHGB8fpu2/yWxg
         ptcg3pU0AI8a9Q1IpyOOMYM2UcPaNA84ajYeHu0wE/+IwzqQu8G/eAK17kL1ULnH2orX
         MznSVmzDj1VGwZcJl4axMiTrUvUmdAa3QeMu3mxNO+k/cgyBv++9kbBe+P4Jxr1L2LsS
         5Cp8C9EO1G1PlbvCFlYPiuTND9VHeEBLvJs3oKnUKra3o8Xsx6pSikU4IVHq6bDaWEkE
         Ei0TmFSTQ8kJv8GM5E/KLKWn76FRbepa7Cwf7jR5N2uFHOU53kWHkudwSCSePjQ4oNNN
         3cDg==
X-Gm-Message-State: AJIora+IaHyhqpOP3p1F2imj7j1mN6Y+8BvHoLZ3CmN5Ex+t0eRJBJCR
        1QUh2H+y1lm03wgO27nnaQlxBg==
X-Google-Smtp-Source: AGRyM1uHIlbYFnwjXR/jabbsTH7ryUQs+sGBXXfD4IrrppWQi92rqSKeplNAt5NyiRVNwm6X6omS2w==
X-Received: by 2002:a05:651c:504:b0:25b:cb73:52af with SMTP id o4-20020a05651c050400b0025bcb7352afmr13848250ljp.391.1657638168200;
        Tue, 12 Jul 2022 08:02:48 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 4-20020ac25f44000000b0047f9614203esm2224649lfz.173.2022.07.12.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:02:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/3] mmc: sdhci-msm: drop redundant of_device_id entries
Date:   Tue, 12 Jul 2022 17:02:19 +0200
Message-Id: <20220712150219.20539-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org>
References: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org>
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

This reverts three commits:
1. Revert "mmc: sdhci-msm: Add compatible string check for sdx65"
   This reverts commit 953706844f0f2fd4dc6984cc010fe6cf51c041f2.

2. Revert "mmc: sdhci-msm: Add compatible string check for sm8150"
   This reverts commit 5acd6adb65802cc6f9986be3750179a820580d37.

3. Revert "mmc: sdhci-msm: Add SoC specific compatibles"
   This reverts commit 466614a9765c6fb67e1464d0a3f1261db903834b.

The oldest commit 466614a9765c ("mmc: sdhci-msm: Add SoC specific
compatibles") did not specify what benefits such multiple compatibles
bring, therefore assume there is none.  On the other hand such approach
brings a lot of churn to driver maintenance by expecting commit for
every new compatible, even though it is already covered by the fallback.

There is really no sense in duplicating of_device_id for each
variant, which is already covered by generic compatible fallback
qcom,sdhci-msm-v4 or qcom,sdhci-msm-v5.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/sdhci-msm.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e395411fb6fd..ff9f5b63c337 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2435,33 +2435,8 @@ static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
 };
 
 static const struct of_device_id sdhci_msm_dt_match[] = {
-	 /* Following two entries are deprecated (kept only for backward compatibility) */
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
-	/* Add entries for sdcc versions less than 5.0 here */
-	{.compatible = "qcom,apq8084-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8226-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8916-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8953-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8974-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
-	/*
-	 * Add entries for sdcc version 5.0 here. For SDCC version 5.0.0,
-	 * MCI registers are removed from SDCC interface and some registers
-	 * are moved to HC.
-	 */
-	{.compatible = "qcom,qcs404-sdhci", .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sdx55-sdhci",  .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sdx65-sdhci",  .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sm8150-sdhci", .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sm8250-sdhci", .data = &sdhci_msm_v5_var},
-	{.compatible = "qcom,sc7280-sdhci", .data = &sdhci_msm_v5_var},
-	/* Add entries where soc specific handling is required, here */
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
-- 
2.34.1

