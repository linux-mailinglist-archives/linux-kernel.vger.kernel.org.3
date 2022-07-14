Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3319E5747EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiGNJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiGNJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:10:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57D2408E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:10:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c15so1469856ljr.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZPLNxoOrlBXnnELoaUQZiTp1bpHPpDagke/CdxO/sA=;
        b=w40AoTU9ec62G6Pl7RJx0BX5Ba8XLiFWwt17SYbTMi6qtaF4sjXjMnIxmV4DKjLlLj
         nBCnYUUvpJRI/dVKSdA/nQw1+AnLNx2cqk/j/plX8ZpGctfz+BdBPmFov/dM2Av7KvdX
         xbToaDKOk1/WcU/JRqQbGQS0EY/TJ15+F/9N7pFpbmS18Yh6mlYjd/0x72E+mKSseBUT
         tjkd3Y4bUKRgJyL0ROSfBdxyPCif1GdeXNq+hkioC0FCayl+QgAf5ghvpSyFoL5qTI3m
         hHD/A5LGcWJm0nnf3z3BBJVZqhoH1ziR/CBuId+ReckCsAgGKu4040WmwRhvq1SWwRcu
         L+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZPLNxoOrlBXnnELoaUQZiTp1bpHPpDagke/CdxO/sA=;
        b=hfWXZCiJBUeyOwR9QAA6VMmMcXP4a7hKzwp+oD8I4MCf8Dbia3t7vaA0WuT6wvK5Ht
         mulXnJ+kw4yZpFq6u49AN4iQnRpqbbjHgbKnMaRfZ3S0xyYGr4wuYAOgwpankhfRNmpc
         1FSDC9G/O7lg8PAh+bAGl//tLc5H72JeJpXOUp6JeDTIdjRe0+x1NVG0IFcpSO4vGnNo
         nNdOoOL0JZ4tQg1c8HFqeOSTWckZQ2FV/X3tJOH/U6oIKjBOepNQ5FyvaVjqigVndIYh
         ybnw+OcNxU6SgN/jz7cIeyfiWlGkFb1lTei1FY0lVTNa64WzuFgFIWTxPbmy/sa8XLy5
         ETMg==
X-Gm-Message-State: AJIora+we9oHsWAEqLsg/yRM4BmtxhiRXbw01R02B/YcS/U3qNByGWv1
        J7z3K0XmzBZqPtVqm1Y3M9NwPg==
X-Google-Smtp-Source: AGRyM1txAJKSbvRFtUvOJa0mWbsnIAkKGgiWNta1hCJHavlH87N+jCrX8rb96Wx9KKeggeag63bq9A==
X-Received: by 2002:a2e:8093:0:b0:25d:63ce:4d56 with SMTP id i19-20020a2e8093000000b0025d63ce4d56mr3790440ljg.105.1657789855541;
        Thu, 14 Jul 2022 02:10:55 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004790ef191e3sm250006lfs.216.2022.07.14.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:10:55 -0700 (PDT)
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
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 3/3] mmc: sdhci-msm: drop redundant of_device_id entries
Date:   Thu, 14 Jul 2022 11:10:42 +0200
Message-Id: <20220714091042.22287-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
References: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/sdhci-msm.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e395411fb6fd..dc2991422a87 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2435,33 +2435,12 @@ static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
 };
 
 static const struct of_device_id sdhci_msm_dt_match[] = {
-	 /* Following two entries are deprecated (kept only for backward compatibility) */
-	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
-	/* Add entries for sdcc versions less than 5.0 here */
-	{.compatible = "qcom,apq8084-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8226-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8916-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8953-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8974-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
-	{.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
 	/*
-	 * Add entries for sdcc version 5.0 here. For SDCC version 5.0.0,
-	 * MCI registers are removed from SDCC interface and some registers
-	 * are moved to HC.
+	 * Do not add new variants to the driver which are compatible with
+	 * generic ones, unless they need customization.
 	 */
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
+	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
-- 
2.34.1

