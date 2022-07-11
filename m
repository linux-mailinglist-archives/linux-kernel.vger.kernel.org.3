Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C555570C69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiGKVG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiGKVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7273586;
        Mon, 11 Jul 2022 14:06:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k30so7761251edk.8;
        Mon, 11 Jul 2022 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0J6xbmqkN6QXcHlYwZcevB8vSh02K48PUp/GkwVo1E=;
        b=hGFiDLyM8/CvuTVFC+GFGIysQgqwIE7WvsnLvFTM0usr2VoSa57Tka8YoGPwVU11Zr
         jvcXRCSL8pJ5H4a8jcGT6yZvb7GEd8BTJAWUuSOBMhFFddFRn4EYNRH9vH0i/ySO6x0/
         e1MPZcKXRQNUhE3rN4ggtUr2pjXimPOlPJKRqDctZPKvuOkqsdLx88RmuTnp7mFnhe2h
         MvxrrIerOEpLF4yG+arC3BE9Vo4bxFuZOyCQ76KatQwwV+2Y33WxNkPElRsbGSGTIAGc
         T67dpV8sGWXnkOjKng1nRn1Pu5JwIwjnLxxcfQDkeFuJlfWzLuU6XGtyBsTnx1q05YRX
         ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0J6xbmqkN6QXcHlYwZcevB8vSh02K48PUp/GkwVo1E=;
        b=lJQjk7ih1SDtKA1n5KzT0eMhERs2l7vUuqsOer1dRIYA89t2XCQShSw1HM9o+rjJnS
         /2f94axBwmeC4XKwcrjmEPIY0TOPuO+EEFXWHN6/vy6L2IX+EDM6Uh4X847Zy8BWKPMu
         sWUq418+3ZRDF0RR00ucYpHqiJmpeXSSD4OXiRjiuH0B4oTkO9GtqiAfoRSCzpdv+uv4
         8OaBsKPvwYWaJI7BKBJj8a98L2O1/uS8ZLYBVEbTZpDLH2QCuk9FuvdD9Bkc1r5mvyni
         uh72Bw/Zsk++MQL2CsHsmsH+uHF48uVGvXkco/UOivwPDgbrkm4gdwD+mhHFyhDUUHSG
         zTaA==
X-Gm-Message-State: AJIora9iQXFdWgBeZvmXwgdP2SC3R0UpUlen7j06tIcLC9hpiImlRFpa
        7MAy4OO3b5yPEgX2xwFBg70=
X-Google-Smtp-Source: AGRyM1sn+7LpW1RgyEQSqBPBHXcSfT87CJCovy3xQnyLfa8KlqnHXiHRK+vn6MrkZzfMDX/K1araBw==
X-Received: by 2002:a05:6402:1691:b0:43a:db2:a213 with SMTP id a17-20020a056402169100b0043a0db2a213mr27664448edv.100.1657573601737;
        Mon, 11 Jul 2022 14:06:41 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:41 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 5/7] clk: qcom: apss-ipq-pll: use OF match data for Alpha PLL config
Date:   Mon, 11 Jul 2022 23:06:32 +0200
Message-Id: <20220711210634.3042092-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711210634.3042092-1-robimarko@gmail.com>
References: <20220711210634.3042092-1-robimarko@gmail.com>
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

Convert the driver to use OF match data for providing the Alpha PLL config
per compatible.
This is required for IPQ8074 support since it uses a different Alpha PLL
config.

While we are here rename "ipq_pll_config" to "ipq6018_pll_config" to make
it clear that it is for IPQ6018 only.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index bef7899ad0d6..ba77749b16c4 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 #include <linux/clk-provider.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -36,7 +37,7 @@ static struct clk_alpha_pll ipq_pll = {
 	},
 };
 
-static const struct alpha_pll_config ipq_pll_config = {
+static const struct alpha_pll_config ipq6018_pll_config = {
 	.l = 0x37,
 	.config_ctl_val = 0x04141200,
 	.config_ctl_hi_val = 0x0,
@@ -54,6 +55,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
 
 static int apss_ipq_pll_probe(struct platform_device *pdev)
 {
+	const struct alpha_pll_config *ipq_pll_config;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	void __iomem *base;
@@ -67,7 +69,11 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	clk_alpha_pll_configure(&ipq_pll, regmap, &ipq_pll_config);
+	ipq_pll_config = of_device_get_match_data(&pdev->dev);
+	if (!ipq_pll_config)
+		return -ENODEV;
+
+	clk_alpha_pll_configure(&ipq_pll, regmap, ipq_pll_config);
 
 	ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
 	if (ret)
@@ -78,7 +84,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
-	{ .compatible = "qcom,ipq6018-a53pll" },
+	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
-- 
2.36.1

