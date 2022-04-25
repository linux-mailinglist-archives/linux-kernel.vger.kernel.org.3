Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837150E808
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiDYS0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiDYSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:25:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC08930A;
        Mon, 25 Apr 2022 11:22:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so31291419ejd.5;
        Mon, 25 Apr 2022 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzYBm1Mg5ELnZ9VCZbiqSgNhv5b4M2fdTVMavRogM9Y=;
        b=dKbii47PzYUtTzXl3x34dyKNQhk2j/2D511n/Jbfg7hyiROT1AuEBZRi4jpwz4PR4g
         MVXSElIxfONshrRoSxxd5DjXj9glhaelxc17GEqqNwMNLKQerD9XoqBky+Mh5SsRy9Xz
         w+k2037LBcZGFrM5rYjiHf/CV6tlnYzcDIlMAaIwgYGYM6HJQTZVC0AMPWO+A4tPn64E
         oNPAsXIcAzoknRgdGnZXLgpGpkQ4Y0z3tBZ2CvXDtrbHkmvvM1kSGrsxKUDQ/EfmR2Nm
         h/EyRMJvrx8hG2vToTAING6dY5rTi+Qj/bz5ewm7qyLiUfTxI/3FwbwX7ikKoI38VzLX
         ggNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzYBm1Mg5ELnZ9VCZbiqSgNhv5b4M2fdTVMavRogM9Y=;
        b=oi4xwJD09qehLw9CweMh6GrW8NnzY54pu48P+RR01HhHYN3NDIqREwYp42By05ac/O
         oWSUTrf3qAxxhklZ+50/fWz9y6iZPoI67aEPfHasw9p4PMMc3Nh8JUkcaFaZHI73L1Kk
         /xnIAdxMjMnRr9tXgxsoXzVbNLJB4swaHyy3tR3RVdDykWdm6M0g3wIQjAMxhgO97eCd
         b24Bxnc1MtxVwuRhrARtUHkHjHzIQSIiGNpFa+GM2lFxRliquqzj/YWT2hSa8/XPTNod
         RYxr3vWdC6EzcwOLdvkJn4pCuckA/AaC7nWL/SvXZuwk0mzh2i231TPUeaZ3fX8OqeHx
         bpNg==
X-Gm-Message-State: AOAM5332EdaC7ffk7puLQGFmfwxuElNCdgvdb13Ant+AB09A5ycaNQQ4
        OPFE9vWO2t1rBEKgTrQnbw4=
X-Google-Smtp-Source: ABdhPJzqf8TDkVAWYyl2awXpsYE0dqc0V5iR3CO442aW5Dsip2FxjVztqZ4xH+J9d4V4TIWlWmi1eg==
X-Received: by 2002:a17:906:8685:b0:6f3:9575:e352 with SMTP id g5-20020a170906868500b006f39575e352mr6059784ejx.622.1650910973455;
        Mon, 25 Apr 2022 11:22:53 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-91.zg.cable.xnet.hr. [94.253.165.91])
        by smtp.googlemail.com with ESMTPSA id h13-20020a170906590d00b006f39021e683sm1677210ejq.12.2022.04.25.11.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:22:52 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/7] clk: qcom: ipq8074: fix NSS core PLL-s
Date:   Mon, 25 Apr 2022 20:22:43 +0200
Message-Id: <20220425182249.2753690-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index e79c3329febd..2ebd1462db78 100644
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
@@ -4773,7 +4800,17 @@ static const struct qcom_cc_desc gcc_ipq8074_desc = {
 
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

