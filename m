Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF834C0B42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiBWEnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiBWEno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:43:44 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA066635
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:43:17 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so20712132oov.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNhRlACxy2aufThO0hLWVItxYuhke+gYQQ/WXwtufY8=;
        b=kKPKkb9UWRCXh5s8pqyecoVDUfpJBoEebNDqO5baIS3XHk23sQRMFVGe0Rw0VEOb/9
         S0hS1nDWtPJEOhX1bcvTF6h2mvbvl7VscbsY3yWY3NWTdlCsiGQ1xRGs4Nqa1wYACqDz
         ACGFHbXEhWAJ/YycNKOBnUSYUC9eTPrwDSRoJk4cBqONtxfuwS1ndinZfJ9FGctoCeTH
         weui4mCLY7okSfFEWsfsfc0Qs9ra/WtXIi1PDzlxQAHuF455RiMfzNI1BPA7xT6IhmC2
         HpfK4BUr6zaZbUZmxtpwZARoe1z09jyLQnfgBD0PttRDo6bfmNg3ncbrPMvUvwIaGBxw
         5UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNhRlACxy2aufThO0hLWVItxYuhke+gYQQ/WXwtufY8=;
        b=Wv+tgsLPA75NKuAuXPjK6Iik7MYFvS/nQ1J6ImCSg5MBV5p1Qx/TlzVy5gVPtd+/+q
         IX+YuO5BoToCC2L1XxTUOjiZ3AHYktbRgaRdjVO64uFFFGq1yv1HjVUorcd+CxXhHKyW
         ZCvDDVINzx5OVUc4MWLmDyJTJI0cco5dOiUrlDICUkb2ZwfYNQJeI7OveMCwoF66drAT
         ZCgeJ7a6+ns0KtKxuNKhSH7vuT81j9T4mBjW/VmW9LcXXedLILP70vA/OHptAGekSIcj
         PSB7CGXNRLPEXOCUjOPKvYgvtYrY82hf/UK0csqYSlFNQsHjBIuoMEg9ZksING8k4Og9
         I6pg==
X-Gm-Message-State: AOAM53213bq01PK4amkKC+mVV2kOTALUlU8lDBmVUJ9+WWvSuFGRODHS
        cBlpa+AqK8PIqsC84KJtpOabFw==
X-Google-Smtp-Source: ABdhPJxUmsS7LgM5xfLdKiun0arpDAiRqf3D/VggoI4K08YZqlQqsoAsNP+wfA5swiCyJKdXHewi4w==
X-Received: by 2002:a05:6870:60a0:b0:d3:a3f7:8b59 with SMTP id t32-20020a05687060a000b000d3a3f78b59mr3056772oae.94.1645591396944;
        Tue, 22 Feb 2022 20:43:16 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i20sm115251ota.71.2022.02.22.20.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 20:43:16 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: rpmhcc: add sc8280xp support to the RPMh clock controller
Date:   Tue, 22 Feb 2022 20:45:16 -0800
Message-Id: <20220223044516.3776637-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220223044516.3776637-1-bjorn.andersson@linaro.org>
References: <20220223044516.3776637-1-bjorn.andersson@linaro.org>
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

The Qualcomm SC8280XP platform exposes 5 clocks through the RPMh clock
controller. Add these, and the relates active-only variants, to the RPMh
clock controller driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 74e57c84f60a..aed907982344 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -512,6 +512,23 @@ static const struct clk_rpmh_desc clk_rpmh_sm8350 = {
 	.num_clks = ARRAY_SIZE(sm8350_rpmh_clocks),
 };
 
+DEFINE_CLK_RPMH_VRM(sc8280xp, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3", 2);
+
+static struct clk_hw *sc8280xp_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
+	[RPMH_LN_BB_CLK3]       = &sc8280xp_ln_bb_clk3.hw,
+	[RPMH_LN_BB_CLK3_A]     = &sc8280xp_ln_bb_clk3_ao.hw,
+	[RPMH_IPA_CLK]          = &sdm845_ipa.hw,
+	[RPMH_PKA_CLK]          = &sm8350_pka.hw,
+	[RPMH_HWKM_CLK]         = &sm8350_hwkm.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sc8280xp = {
+	.clks = sc8280xp_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sc8280xp_rpmh_clocks),
+};
+
 /* Resource name must match resource id present in cmd-db */
 DEFINE_CLK_RPMH_ARC(sc7280, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 4);
 
@@ -691,6 +708,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
 	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
+	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = &clk_rpmh_sc8280xp},
 	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
 	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
 	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
-- 
2.33.1

