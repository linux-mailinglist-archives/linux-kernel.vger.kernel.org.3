Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2921651E9E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387151AbiEGUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiEGUdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD51BC95;
        Sat,  7 May 2022 13:29:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z2so18549515ejj.3;
        Sat, 07 May 2022 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tof11gWdZVMZxib9oySvQf9mu+NWMt2gs2nvPMKj0h4=;
        b=C3ZuLoKoR2iCe5UXuOCY/VW4LgEWX+8cpj5smDSCHQ4HIxFwlin1LDpr07fod8mdxn
         wzlv2MY2QGIDFPZJ66WpRVOQuqiq1QwIsCZxq612RI9rGUcF4XG2rTUxWlDiRvv1GNjz
         p6ZOK68mjBiVohcMZTFTwnYaTzod5W6CJCUzyNufehejYA2CeJ6Wwc8jDOWPTZ1ZChf9
         /ZkiskxHHwnXLTd6E///2f6IJqaKF0cDDUMpV7Tdcp2VhynpeIz3G68PEx6CZdRwWL6E
         RgAi4BtoNJz2Cc1b7glnp/0wU314fkJrknE9txUxrgjuxeCX/uebtm4bWMeT+LNKIMfC
         32tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tof11gWdZVMZxib9oySvQf9mu+NWMt2gs2nvPMKj0h4=;
        b=AMtU0J7cTBAb3gC+izXhw+S2nsLhhTqLT/4FjW1pHAK0Xix9oSEfrqATxV6m3Z3sZz
         NbgWAWlwq5bdSSHatu4Ez28NWJdzY0U9yQm2o8/88UxGKac37Ugs1i+ktnRFEyF7IB2M
         ukV1/JXm1Udjy7c7LZofrBxwMaqmnN9Xc4Q/lnz8O2xPeepFEtXXluMS7J6CucSztWrQ
         BQwjlPWmcAJ6zw94fqc64aw2e5dmKgD5mMTk6BeltM0l5lUPcZaKM6hGOoIgt9/gBAPJ
         Ly0zr52LNR5Xm854+m8cf2KhIbca/Um7pxjCQIaRJLI92VENVN4hwl/SUQK/0/pFxE9S
         CEAg==
X-Gm-Message-State: AOAM530Y8ZO7+/j7/BiHfmEqDWtq2495EZoZ8yrIkIls7BUlJfxbmz+4
        klGJbDPG4ZZEzvWAXCQQIqU=
X-Google-Smtp-Source: ABdhPJwBO0kpC+X39nkzexVVOGLumhjhW2iK1jvS8kyu1A/7LVkn+ROZIbfovMRTEgh0n3UkKCAOCg==
X-Received: by 2002:a17:906:27cd:b0:6f3:c015:e40d with SMTP id k13-20020a17090627cd00b006f3c015e40dmr8948239ejc.15.1651955391231;
        Sat, 07 May 2022 13:29:51 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:29:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 01/11] clk: qcom: ipq8074: fix NSS core PLL-s
Date:   Sat,  7 May 2022 22:29:38 +0200
Message-Id: <20220507202948.397271-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in IPQ6018 the NSS related Alpha PLL-s require initial configuration
to work.

So, obtain the regmap that is required for the Alpha PLL configuration
and thus utilize the qcom_cc_really_probe() as we already have the regmap.
Then utilize the Alpha PLL configs from the downstream QCA 5.4 based
kernel to configure them.

This fixes the UBI32 and NSS crypto PLL-s failing to get enabled by the
kernel.

Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 541016db3c4b..1a5141da7e23 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4371,6 +4371,33 @@ static struct clk_branch gcc_pcie0_axi_s_bridge_clk = {
 	},
 };
 
+static const struct alpha_pll_config ubi32_pll_config = {
+	.l = 0x4e,
+	.config_ctl_val = 0x200d4aa8,
+	.config_ctl_hi_val = 0x3c2,
+	.main_output_mask = BIT(0),
+	.aux_output_mask = BIT(1),
+	.pre_div_val = 0x0,
+	.pre_div_mask = BIT(12),
+	.post_div_val = 0x0,
+	.post_div_mask = GENMASK(9, 8),
+};
+
+static const struct alpha_pll_config nss_crypto_pll_config = {
+	.l = 0x3e,
+	.alpha = 0x0,
+	.alpha_hi = 0x80,
+	.config_ctl_val = 0x4001055b,
+	.main_output_mask = BIT(0),
+	.pre_div_val = 0x0,
+	.pre_div_mask = GENMASK(14, 12),
+	.post_div_val = 0x1 << 8,
+	.post_div_mask = GENMASK(11, 8),
+	.vco_mask = GENMASK(21, 20),
+	.vco_val = 0x0,
+	.alpha_en_mask = BIT(24),
+};
+
 static struct clk_hw *gcc_ipq8074_hws[] = {
 	&gpll0_out_main_div2.hw,
 	&gpll6_out_main_div2.hw,
@@ -4772,7 +4799,17 @@ static const struct qcom_cc_desc gcc_ipq8074_desc = {
 
 static int gcc_ipq8074_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gcc_ipq8074_desc);
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gcc_ipq8074_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
+	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
+				&nss_crypto_pll_config);
+
+	return qcom_cc_really_probe(pdev, &gcc_ipq8074_desc, regmap);
 }
 
 static struct platform_driver gcc_ipq8074_driver = {
-- 
2.35.1

