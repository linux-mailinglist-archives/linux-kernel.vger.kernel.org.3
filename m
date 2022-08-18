Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE859901D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbiHRWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345265AbiHRWGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB37D25E9;
        Thu, 18 Aug 2022 15:06:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so3542310edc.1;
        Thu, 18 Aug 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FCwIidSpgWojKZHiatQEHHdaDA4BlPDLukpx2Wl2YA8=;
        b=OXZJRFfv/tDTLpZ7EcRPyoHaYOizwRF3OnsLDsIyoTjjM+el1vrWD+H7UIHTVMhb+T
         n46TP7/uhWgA+k2iTr8XNklJjiuhX0eECXG1wMrHrf2dhu89O92eu5M7s+SKfYachAYA
         bqmQuGjSajfZK1aUOAYg3ZZkXSx1jvjJVtjRwr+Y3DZMwTOzf4vEoQhhJ9zigafwsG8N
         gnrKHFOmYozFPZvs4v5p6XNhEQ7/JvEriKQa3jYhxPJOgECvxsgPoVUrjkJcU3fby7+d
         iRPswszNDx7uOpdwyHEHSxbSM0RvveIXH4NZDEiB+t1JMnbDR3Bq85VDr3oP0mmnKMgP
         9T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FCwIidSpgWojKZHiatQEHHdaDA4BlPDLukpx2Wl2YA8=;
        b=lmPiU7ZKnzIEHmdrBmzL+LQrxKKLpL3oC5VfYw/D76Y+f163Tpd7nPkiuA+BYGg5UP
         ksiuQnl82Rcgx3LTXoMQwwRzud/eruQfm8WBLBD/89234329Dt+UmTuZgVgq66YASyWY
         zDzwUC3boBZ8lNvajny+SeQEbqkCrWTQ1xEl7bs+vbSJyZ7dQ8sCneZciynQx+ZFoFpp
         bQe9eXizGtE5yffpP4VN7P9gJXZBB2ap1gt5SczkHT+L07bANr1HtvpFIoR2LWeKVNNr
         41SU06yUOPY2v5N05zIHfoMM3KJSVtLyT2sgifWtUnxZ4WY8pYlzLs25GnnENaIw7F6M
         SyhQ==
X-Gm-Message-State: ACgBeo2bpwQVljfEQIMYtM8hcxDU/zuMcUKzfK+aSDVnGFaLRPiPRRg2
        9skMXAA93KFZ8L4F/65e4rI=
X-Google-Smtp-Source: AA6agR49r2mKm0LVyTgxcULjsiTvK2W3/OBx8qOa30gQyB+N4Zw7F3ucffAyAehE+pZjQxTc6fx8zQ==
X-Received: by 2002:a05:6402:20b:b0:440:cb9f:c469 with SMTP id t11-20020a056402020b00b00440cb9fc469mr3807435edv.420.1660860395240;
        Thu, 18 Aug 2022 15:06:35 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:34 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 5/9] clk: qcom: apss-ipq-pll: use OF match data for Alpha PLL config
Date:   Fri, 19 Aug 2022 00:06:24 +0200
Message-Id: <20220818220628.339366-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
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
2.37.2

