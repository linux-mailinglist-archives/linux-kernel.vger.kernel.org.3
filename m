Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC4527A36
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiEOVBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiEOVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:00:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440C643A;
        Sun, 15 May 2022 14:00:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so16033827edo.2;
        Sun, 15 May 2022 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GurDE2uniGnUSdql0qTVquEExm5Vat6TsOsO+B9Kmfo=;
        b=UHYmV2zZ9MhZnHicX0Ek7+4zk9NZ4dthxv+ZBGxUpSLXO24RJK+EvytDQ7M1594aiS
         ADpdP2GsYr2wWgk+qCVyusNcPKkxY26fazEbCh55wdYmFhIYjltTgJnu2yVywQjDNyIb
         oA8XjryGt0OB8LtsOT5Ne8Jt0AImytWZGvLDIiwhfE3mIdDDNQKD1aOSRCmFmRoI1qL5
         CMb1ZSC6Dh8h/L/Msp3pnhr9wr5oeSh+os4cvsy+GyO08IbS7vF/gzuzINA2z3Qz8VNz
         dhCZFPWUFhlWdSvlzo9WxTOLUCsO+SUw0B8kUVQZi5ZMyI/iUKcmNblKlSHVWw71YrnF
         WF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GurDE2uniGnUSdql0qTVquEExm5Vat6TsOsO+B9Kmfo=;
        b=gGeFt5+wT+GWVrlkQB2IkNYhaFgQcoPOWECTvb9750/Gy12J+luI4CIOIeUaREXmlX
         VPhjsPomI5jVgOmlAtI/pqrVjktZ4y19hkcQxHSmI4FU0AMxF6R1v1X2yOkbV2fUQuXR
         VLxQtGrqIqXd1/IDbEhpzEY/FXW8KgE1zIC3tbKZ8P2tOrMS5MP4cyqke/tDQCG4LXzV
         V4bhMe75WP39/DydAuxr9F/bcHip9fYFipxLe8waiRBh4iZHaIew726zF2nyGwBkDaO8
         ddorDBfYL7l2YaygGKnSVlpGJOckm4xu1de+nKWQzV6DNCg9jaJPfJsYe9ROxJMBnjVb
         SdKw==
X-Gm-Message-State: AOAM530ojc3j1qZ5gyIut1qfbUrRU5P3xaWqAKI3QmYOtnX8SIupi9Xa
        iIW2qV6ocHNq6FiqbW55K6KQOEoZ+TPeqA==
X-Google-Smtp-Source: ABdhPJw2wNSbVeFUg3eFtVpTx51cCUNt8J2XyYDbbMfhgKup0CNK1rOzJsjuRcYDyDKWwlMNziz61A==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr9764099eda.362.1652648451103;
        Sun, 15 May 2022 14:00:51 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 01/11] clk: qcom: ipq8074: fix NSS core PLL-s
Date:   Sun, 15 May 2022 23:00:38 +0200
Message-Id: <20220515210048.483898-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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
2.36.1

