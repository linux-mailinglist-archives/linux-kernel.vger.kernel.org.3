Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209AC4C2AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiBXLSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiBXLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:17:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B0F68F8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r10so1440031wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5S4jXtQt9zJ/FIRoN63CnQsA0xt3UoiFNydOwJT7zD0=;
        b=z6JE71CNpxeyixCb5JaVsSk+O1A7pELVFqhrIgDySs+Jcfd0zkkOszUfV0rIukSnQP
         7adLbDNkyvEXin/k9GziX1kzVZns79F42T6OCz6xsFQ9BqZequUOkrCfl1lhvxra+iKm
         9qs9nDExoCTnc9/8FKhCYGm/tIevqh2zFyda3kE9JHnPmTrCivpYrHCcmv7uPaYtwVSU
         QOxVlpD4R8JGiZoC7FMMP+NDAIndxsBVRCsqQ3t1uBe5ibckSDmbDuqWSJS+ShTEHUsN
         aiByH/S+88QMkusp2rOo7BN0z3RPNnPIccwcGKG//jxbviWMCPIA+LpyVjUef/D+0KPV
         ZJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5S4jXtQt9zJ/FIRoN63CnQsA0xt3UoiFNydOwJT7zD0=;
        b=GPwVdxP2bSVD+9NY7JJbJ7vKSS2AHGDV7Z9KWMTV/jttttWpaluCGZdtzDOQqjr04G
         3rHRTJoH0ksvcfWtXj8UGI2xl1GkJRx/a4xuhS5bpvkhkuerD5fEq4WJ5QQ1R94BKRR3
         MZp/3A2iipi2gyk8z6/85I8CG6x/lkAp9zj1tO2lzqH2mf7eYeNMSo0eaom3yf/L/fIP
         T2jZY4bN+Vfo3eJ1+IOlL31H+LkBArdshcvO7d/C92rYWfoCQntXhjmE/r6nO494hbgA
         UGIlmicgdrTkQWNqw+Q50+j9Vu7LP5+7p1x/tixCfoDVJsr3erGAwDWFjZ8op+4ibKe1
         1NVg==
X-Gm-Message-State: AOAM530UVYEKKkuSomCTRrkTeVvVchdaZnUXdf5nG366InGb6zheRPsJ
        5jd7OS5o7BZjZmGkeezMRa+/Lw==
X-Google-Smtp-Source: ABdhPJyaqVEQef4+d4t/15H05ZMObVdYcIsikILB5quawSWQpvCzVILcxu0ingwfWR6rQGI2Xm7WUA==
X-Received: by 2002:a5d:44cf:0:b0:1ea:9cc3:504e with SMTP id z15-20020a5d44cf000000b001ea9cc3504emr1845612wrr.706.1645701446658;
        Thu, 24 Feb 2022 03:17:26 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/16] ASoC: codecs: rx-macro: move to individual clks from bulk
Date:   Thu, 24 Feb 2022 11:17:06 +0000
Message-Id: <20220224111718.6264-5-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-rx-macro.c | 85 +++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 6c61b4d35df9..83b570403c59 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -608,7 +608,11 @@ struct rx_macro {
 	int softclip_clk_users;
 
 	struct regmap *regmap;
-	struct clk_bulk_data clks[RX_NUM_CLKS_MAX];
+	struct clk *mclk;
+	struct clk *npl;
+	struct clk *macro;
+	struct clk *dcodec;
+	struct clk *fsgen;
 	struct clk_hw hw;
 };
 #define to_rx_macro(_hw) container_of(_hw, struct rx_macro, hw)
@@ -3488,7 +3492,7 @@ static int rx_macro_register_mclk_output(struct rx_macro *rx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(rx->clks[2].clk);
+	parent_clk_name = __clk_get_name(rx->mclk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
@@ -3526,17 +3530,25 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (!rx)
 		return -ENOMEM;
 
-	rx->clks[0].id = "macro";
-	rx->clks[1].id = "dcodec";
-	rx->clks[2].id = "mclk";
-	rx->clks[3].id = "npl";
-	rx->clks[4].id = "fsgen";
+	rx->macro = devm_clk_get_optional(dev, "macro");
+	if (IS_ERR(rx->macro))
+		return PTR_ERR(rx->macro);
 
-	ret = devm_clk_bulk_get_optional(dev, RX_NUM_CLKS_MAX, rx->clks);
-	if (ret) {
-		dev_err(dev, "Error getting RX Clocks (%d)\n", ret);
-		return ret;
-	}
+	rx->dcodec = devm_clk_get_optional(dev, "dcodec");
+	if (IS_ERR(rx->dcodec))
+		return PTR_ERR(rx->dcodec);
+
+	rx->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(rx->mclk))
+		return PTR_ERR(rx->mclk);
+
+	rx->npl = devm_clk_get(dev, "npl");
+	if (IS_ERR(rx->npl))
+		return PTR_ERR(rx->npl);
+
+	rx->fsgen = devm_clk_get(dev, "fsgen");
+	if (IS_ERR(rx->fsgen))
+		return PTR_ERR(rx->fsgen);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -3552,26 +3564,52 @@ static int rx_macro_probe(struct platform_device *pdev)
 	rx->dev = dev;
 
 	/* set MCLK and NPL rates */
-	clk_set_rate(rx->clks[2].clk, MCLK_FREQ);
-	clk_set_rate(rx->clks[3].clk, 2 * MCLK_FREQ);
+	clk_set_rate(rx->mclk, MCLK_FREQ);
+	clk_set_rate(rx->npl, 2 * MCLK_FREQ);
 
-	ret = clk_bulk_prepare_enable(RX_NUM_CLKS_MAX, rx->clks);
+	ret = clk_prepare_enable(rx->macro);
 	if (ret)
-		return ret;
+		goto err;
+
+	ret = clk_prepare_enable(rx->dcodec);
+	if (ret)
+		goto err_dcodec;
+
+	ret = clk_prepare_enable(rx->mclk);
+	if (ret)
+		goto err_mclk;
+
+	ret = clk_prepare_enable(rx->npl);
+	if (ret)
+		goto err_npl;
+
+	ret = clk_prepare_enable(rx->fsgen);
+	if (ret)
+		goto err_fsgen;
 
 	ret = rx_macro_register_mclk_output(rx);
 	if (ret)
-		goto err;
+		goto err_clkout;
 
 	ret = devm_snd_soc_register_component(dev, &rx_macro_component_drv,
 					      rx_macro_dai,
 					      ARRAY_SIZE(rx_macro_dai));
 	if (ret)
-		goto err;
+		goto err_clkout;
 
-	return ret;
+	return 0;
+
+err_clkout:
+	clk_disable_unprepare(rx->fsgen);
+err_fsgen:
+	clk_disable_unprepare(rx->npl);
+err_npl:
+	clk_disable_unprepare(rx->mclk);
+err_mclk:
+	clk_disable_unprepare(rx->dcodec);
+err_dcodec:
+	clk_disable_unprepare(rx->macro);
 err:
-	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
 	return ret;
 }
 
@@ -3579,7 +3617,12 @@ static int rx_macro_remove(struct platform_device *pdev)
 {
 	struct rx_macro *rx = dev_get_drvdata(&pdev->dev);
 
-	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
+	clk_disable_unprepare(rx->mclk);
+	clk_disable_unprepare(rx->npl);
+	clk_disable_unprepare(rx->fsgen);
+	clk_disable_unprepare(rx->macro);
+	clk_disable_unprepare(rx->dcodec);
+
 	return 0;
 }
 
-- 
2.21.0

