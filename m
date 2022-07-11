Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81B4570045
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiGKLW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiGKLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA96C63;
        Mon, 11 Jul 2022 03:47:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so4766550wma.1;
        Mon, 11 Jul 2022 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9Xxii6Uq6u9N4X9oYLMMJTBOBPZ/anZfpBCj5Ubmss=;
        b=LTujsVZix7h6BZ9Fu6GkqRc7KU/djhhG8DEQFwsjI8G0et0Su0qzUI4NqppjrL7mbR
         +xQCdUcK+OVS4g6k/Xy2OKnbFEIsWppVfcxpe/Ych5OrE1QIP7Zjm6Z5zN4G35mh0c3L
         aI7FImD7Q4BkCX4FiXUXiMwlAgs9sqi6kVStPj1bA+oTKsMQqLpK0/AtEBTYHn+1fpjG
         TF9ioYH/k7jM9EQGX2Xnwh5j9fwBHgwgDCHtADDoANb+eyBTu7mIeubNxRjtNMSoUht0
         f4x1Z5LDmSm9NPcboilp8YIlhHl64Di1pnGjuV+Q4+86nAJvLiIUFl6RHGyV47urNpH+
         6TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9Xxii6Uq6u9N4X9oYLMMJTBOBPZ/anZfpBCj5Ubmss=;
        b=jJhw7OGslzRHvh7hcpz3WaGK3tterWWOTuWNjlVhpkgpk+uzCU6BbyY4EldF3NCPdG
         InyUQcwo31uXjsNKHSvYx3mqmQiO265R4OwgIrSStXZQRj/KVTvSozV5lad1/Tb6vHuA
         APMCFomQRSKycYMTmTWC5bSOX/9qWcCRxEzjkMaOmBX9/j51tP8ACzSnQ6BgAFpWiXLq
         ZVD/XerdYR84nlNl4e29Il53Xaaj5r1BA2QrioHHhWHVObvZSy9LtVVL9pjzen1xR9aj
         tlCB4IMTwliC277pNet+Kf8YQs6kKdkIGaKTPCKuFl29M3GaJ/iKjS5MND7Q3coTpoIW
         QXCA==
X-Gm-Message-State: AJIora9I1/kYx4JHc9/rLZNWZghQqoyurjc2TeivT4r4IGV2OBMjTBLp
        jp1kaq8b9IDwCFmvkZzKm04=
X-Google-Smtp-Source: AGRyM1ubXzhdRxrqkXB7Mv+HHP19cm7y/4ukC8Ipx3ZqQ2G/C9rnnt24ptNZa1snJ2I+jVys8wY2AA==
X-Received: by 2002:a05:600c:19cd:b0:3a1:77b6:cf1d with SMTP id u13-20020a05600c19cd00b003a177b6cf1dmr14765791wmq.141.1657536450823;
        Mon, 11 Jul 2022 03:47:30 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6338716wmi.29.2022.07.11.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:47:30 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 6/6] clk: qcom: apss-ipq-pll: add support for IPQ8074
Date:   Mon, 11 Jul 2022 12:47:19 +0200
Message-Id: <20220711104719.40939-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711104719.40939-1-robimarko@gmail.com>
References: <20220711104719.40939-1-robimarko@gmail.com>
MIME-Version: 1.0
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

Add support for IPQ8074 since it uses the same PLL setup, however it does
not require the Alpha PLL to be reconfigured.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index bef7899ad0d6..acfb3ec4f142 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -55,6 +55,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
 static int apss_ipq_pll_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
@@ -67,7 +68,8 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	clk_alpha_pll_configure(&ipq_pll, regmap, &ipq_pll_config);
+	if (of_device_is_compatible(node, "qcom,ipq6018-a53pll"))
+		clk_alpha_pll_configure(&ipq_pll, regmap, &ipq_pll_config);
 
 	ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
 	if (ret)
@@ -79,6 +81,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
 	{ .compatible = "qcom,ipq6018-a53pll" },
+	{ .compatible = "qcom,ipq8074-a53pll" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
-- 
2.36.1

