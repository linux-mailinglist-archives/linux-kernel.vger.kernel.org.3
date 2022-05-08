Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73051ECF8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiEHKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiEHKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:52:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C93B7DD;
        Sun,  8 May 2022 03:49:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so13252904edo.2;
        Sun, 08 May 2022 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMXZ0jNVuDFAyxvmr7RISt1a4MRB5GYj3th1Rkku/L0=;
        b=RyVBk2YxwmNnMRUtzmIszhLF82SiCeP8blFZ5ZDSFCMY2lsR0Gs2WBKvVgGwu+FGSH
         p04FwkZWt/ZsD3OOXSfjAbminLMznFM68IKSouwaFFz5WVPsdD7+rL/LBhO3H1i3kuBn
         RsDj9xlQely2y6R943TLCCEbDbpbMfqpfFOOSii2MZTaA9Po7Yx+sarL35EhrVaQV49Z
         AG5z1o7p8XHMmwIfXkGYdIeR6wV/V7VrirL/x1B0hG0pBtKYx9/jUeIVOmLp+leqea2X
         E0ZOTRSBx9C+DruWn/n39wzpozdFghZDIxeKOXLoFFDDcxpTlLBpSk++EpH3WEVz3gzG
         bVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMXZ0jNVuDFAyxvmr7RISt1a4MRB5GYj3th1Rkku/L0=;
        b=BlC74itov43paew/f6Xzj2uiIjRvsKTf39JciHCjjbYWWtCWgspjX/ijCrZc8FN8C3
         Jl+9tfKdwndVxwNypglgbQZ3vYKp4nPP1eRs6alhXXcW+FuFnndypbXBy8wlVDpXEg3N
         PR+W+NPE3gpwwRMY1khYc2ffmksoO/ldT8fbYuvSmVUAw0uhHxEiCIfUuZ3YezBYSOd4
         sPFhyZgiN/3IBEbrUqh3HuME1DKVLarqkewywmPAACLt84zs/HUu70NDObuDCIL06JLF
         ZDYaS7glK+XHv+zvUSbcEs6+bvKX1F3zbRNe0PJS+XbHzAtEOerXomwDjqFR7DylXypu
         zkzg==
X-Gm-Message-State: AOAM53239q+U0Ei8yi+DsTscWlXbyn2+/hGCyxCga+eb+kBvci7U3aXh
        dWiZp1bouC4Mw67EAejjlZKVELsgkLKcWQ==
X-Google-Smtp-Source: ABdhPJz49C0BobFcAxLZiUPUP1yxQm2zx6g4BGcl8jUbtsNNyocYYoiNIs6JHKKnsWPRR90FTRoKTQ==
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id z22-20020a50e696000000b00419998d5febmr12478391edm.122.1652006938695;
        Sun, 08 May 2022 03:48:58 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:48:58 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 01/11] clk: qcom: ipq8074: fix NSS core PLL-s
Date:   Sun,  8 May 2022 12:48:45 +0200
Message-Id: <20220508104855.78804-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
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
2.36.0

