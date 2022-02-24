Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3168B4C2AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiBXLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiBXLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:17:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AFBFFF88
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b5so1474930wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceUQI8pUhjwWr7cwe8PfSIpA4DyG+G2Rz7beXile+P0=;
        b=himXMgwqxUWpRMrFbC97dlxMwb1qkLSvrgWmiX0R+wVTPDdmvC0ZMKzn5lLCPKOeXL
         fjcncNVLW9vUQpZy24Zu8rY2s0sc+Qt8JhEF9bMaMJV9rdVk9ha0qZOaL4v84ItkAg1m
         PBUjNz51VnrHBZpvsf0ZsT60sZeEyP/XG9woWpL9zXF+tARotwNUZKL+LcKUbTO0E6Hr
         vv/D0XM4U7yvkJ7+GkIvoYepaSPKvR5jFVZxDd8Fp4NhPn9mgOB/dLf6S6w2fpkMv0WZ
         2efScThgcgILM861QEvBNEFjGXUo37ZknHn/CbTHNs1KT1fyKGuFVrgoR5LHN58tFZbQ
         fq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceUQI8pUhjwWr7cwe8PfSIpA4DyG+G2Rz7beXile+P0=;
        b=8CMvlgMOeV8kYk1iOSnxQKbf4+BabdHB22ZsAYmlZv2nMrJU9Yk8WFXBbhdBda6E2X
         l9H+GkI/rypway8mQo3wtxH2IRliuolTbNL3QkSJ3WdsZeT/7qn9UMiAQo3CFY616XaE
         abVGjUPKJomrzkzc4e26y0uvSiZFPB9EUc9CQsJJQnSVjksQ9gJrinC5TghPaNr8BDTc
         WFVRNp00DZXx6W2s4d+MncS+/LWAWxPRqfrQcgC8cytKi90rc9MeSD8iXi6v6JM8hOjX
         F5jr26g18QPW0ut+KE44pq4VNcHCmnGtlxhAUFM2at9PMDwaTFQdv27KrOAhno8BkDDb
         VzHA==
X-Gm-Message-State: AOAM5335icE6tZZwfEIjDT8qpw9T6U8YSL+e3iSSXOdyXDuop5wA0IDH
        +EEwMGpKJ5d5Puv0qOBzxM2VaA==
X-Google-Smtp-Source: ABdhPJyF9hlhdYn3QgLA1hMGpxlSnPQtvk5TT0UYfuCo7gdjJ6fCLnBsBQreeycYv1PvBEnz4lzOTg==
X-Received: by 2002:a5d:6108:0:b0:1e3:3a73:d34a with SMTP id v8-20020a5d6108000000b001e33a73d34amr1819381wrt.290.1645701443219;
        Thu, 24 Feb 2022 03:17:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/16] ASoC: codecs: va-macro: move to individual clks from bulk
Date:   Thu, 24 Feb 2022 11:17:03 +0000
Message-Id: <20220224111718.6264-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
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

Using bulk clocks and referencing them individually using array index is
not great for readers.
So move them to individual clocks handling and also remove some unnecessary
error handling in the code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 65 ++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index e14c277e6a8b..ff8120886eca 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -193,7 +193,9 @@ struct va_macro {
 
 	int dec_mode[VA_MACRO_NUM_DECIMATORS];
 	struct regmap *regmap;
-	struct clk_bulk_data clks[VA_NUM_CLKS_MAX];
+	struct clk *mclk;
+	struct clk *macro;
+	struct clk *dcodec;
 	struct clk_hw hw;
 
 	s32 dmic_0_1_clk_cnt;
@@ -1321,7 +1323,7 @@ static const struct clk_ops fsgen_gate_ops = {
 
 static int va_macro_register_fsgen_output(struct va_macro *va)
 {
-	struct clk *parent = va->clks[2].clk;
+	struct clk *parent = va->mclk;
 	struct device *dev = va->dev;
 	struct device_node *np = dev->of_node;
 	const char *parent_clk_name;
@@ -1404,15 +1406,18 @@ static int va_macro_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	va->dev = dev;
-	va->clks[0].id = "macro";
-	va->clks[1].id = "dcodec";
-	va->clks[2].id = "mclk";
 
-	ret = devm_clk_bulk_get_optional(dev, VA_NUM_CLKS_MAX, va->clks);
-	if (ret) {
-		dev_err(dev, "Error getting VA Clocks (%d)\n", ret);
-		return ret;
-	}
+	va->macro = devm_clk_get_optional(dev, "macro");
+	if (IS_ERR(va->macro))
+		return PTR_ERR(va->macro);
+
+	va->dcodec = devm_clk_get_optional(dev, "dcodec");
+	if (IS_ERR(va->dcodec))
+		return PTR_ERR(va->dcodec);
+
+	va->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(va->mclk))
+		return PTR_ERR(va->mclk);
 
 	ret = of_property_read_u32(dev->of_node, "qcom,dmic-sample-rate",
 				   &sample_rate);
@@ -1425,12 +1430,6 @@ static int va_macro_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	/* mclk rate */
-	clk_set_rate(va->clks[1].clk, VA_MACRO_MCLK_FREQ);
-	ret = clk_bulk_prepare_enable(VA_NUM_CLKS_MAX, va->clks);
-	if (ret)
-		return ret;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
@@ -1444,21 +1443,41 @@ static int va_macro_probe(struct platform_device *pdev)
 	}
 
 	dev_set_drvdata(dev, va);
-	ret = va_macro_register_fsgen_output(va);
+
+	/* mclk rate */
+	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
+
+	ret = clk_prepare_enable(va->macro);
 	if (ret)
 		goto err;
 
+	ret = clk_prepare_enable(va->dcodec);
+	if (ret)
+		goto err_dcodec;
+
+	ret = clk_prepare_enable(va->mclk);
+	if (ret)
+		goto err_mclk;
+
+	ret = va_macro_register_fsgen_output(va);
+	if (ret)
+		goto err_clkout;
+
 	ret = devm_snd_soc_register_component(dev, &va_macro_component_drv,
 					      va_macro_dais,
 					      ARRAY_SIZE(va_macro_dais));
 	if (ret)
-		goto err;
+		goto err_clkout;
 
-	return ret;
+	return 0;
 
+err_clkout:
+	clk_disable_unprepare(va->mclk);
+err_mclk:
+	clk_disable_unprepare(va->dcodec);
+err_dcodec:
+	clk_disable_unprepare(va->macro);
 err:
-	clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
-
 	return ret;
 }
 
@@ -1466,7 +1485,9 @@ static int va_macro_remove(struct platform_device *pdev)
 {
 	struct va_macro *va = dev_get_drvdata(&pdev->dev);
 
-	clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
+	clk_disable_unprepare(va->mclk);
+	clk_disable_unprepare(va->dcodec);
+	clk_disable_unprepare(va->macro);
 
 	return 0;
 }
-- 
2.21.0

