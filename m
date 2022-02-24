Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5464C2AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiBXLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiBXLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:17:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46879144F5C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d17so2425466wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGwet8zq/q+oBO0cHbSkm6maZjXBTGE7Z1lKpvdPae8=;
        b=mWWsTocp+FaeXz7m6q2G2l6HK5IYTE8CBN/r+4zYwmSlwTs8jvDyI5kpnqO/55AZIj
         Mr3mWD0Mud3PA7EUu88qZ/uSSn0yLLYRJxgV5XqLEVjhTUTyMXM0kA5kq4B94T8M2JUf
         SQ24J0/n7Y+TjfEpntKWKgJeCAT3rfF0p1QXBfMEDY7nvr/NbFuaOQ6xf7aUTHaFWHs/
         ocRU7fNhUxLAgMeC7bySbxvSXtED6drR7kNSMrXQLR7ghStTK5y2QGA2xt9ZS1NUKjk+
         O9Gv5jQFdLp9Mx/378+VicOE0YufzQsokqZjAxm9/Yy1s37N+JITqE+WAXVeoMhQYf2p
         ZqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGwet8zq/q+oBO0cHbSkm6maZjXBTGE7Z1lKpvdPae8=;
        b=G9BMpIQE9TInUURrOu3v82TqID/+HEIlYIpr76Up7IuYoGdH81ICEIomwGbJN7NCbU
         ay76OIK5vEvDHjyRhOT4h5nZNjH65oHj7w6koAdvMSLGlpkMK8s9ZJgGVYpEKmsvUB5+
         0NllL2V8yugaYD8CDaEh2g6luTpVkyRKuviytS0c2B5OxFi/wJ9PuHsap+K2PGO9yu86
         1qV83j1oFPfXsiV3vpxk+GzGjz+1KdNl0f1if8c11iEwHA9hJMH6BYcVYCI5MC/W0od5
         pHzAz+KE5IDDioUVs2T8DfBQJlB8/x32cJpBd+E6A++PwohFofDotZXuo9fRx/kx0p/5
         IGnA==
X-Gm-Message-State: AOAM531G81t5e3FlI5DDWwwprYa0AOQu+ORydJLXqMNvL7iHJ614PTrq
        dRI8iMqvVFZU1liD0Xhm/vVmuQ==
X-Google-Smtp-Source: ABdhPJybg1t1xKJqLsGn0nQIlVpKXFYckwd6gkVxdYrY1KAog6yCEynqxw1UNdzl30rR089a6pB39Q==
X-Received: by 2002:a5d:64ce:0:b0:1e4:9b8d:4ccd with SMTP id f14-20020a5d64ce000000b001e49b8d4ccdmr1891746wri.37.1645701447824;
        Thu, 24 Feb 2022 03:17:27 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/16] ASoC: codecs: tx-macro: move to individual clks from bulk
Date:   Thu, 24 Feb 2022 11:17:07 +0000
Message-Id: <20220224111718.6264-6-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-tx-macro.c | 87 +++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 75a5513bff16..920b6e93fbaa 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -258,7 +259,11 @@ struct tx_macro {
 	unsigned long active_ch_cnt[TX_MACRO_MAX_DAIS];
 	unsigned long active_decimator[TX_MACRO_MAX_DAIS];
 	struct regmap *regmap;
-	struct clk_bulk_data clks[TX_NUM_CLKS_MAX];
+	struct clk *mclk;
+	struct clk *npl;
+	struct clk *macro;
+	struct clk *dcodec;
+	struct clk *fsgen;
 	struct clk_hw hw;
 	bool dec_active[NUM_DECIMATORS];
 	bool reset_swr;
@@ -1754,7 +1759,7 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(tx->clks[2].clk);
+	parent_clk_name = __clk_get_name(tx->mclk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
@@ -1793,17 +1798,25 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (!tx)
 		return -ENOMEM;
 
-	tx->clks[0].id = "macro";
-	tx->clks[1].id = "dcodec";
-	tx->clks[2].id = "mclk";
-	tx->clks[3].id = "npl";
-	tx->clks[4].id = "fsgen";
+	tx->macro = devm_clk_get_optional(dev, "macro");
+	if (IS_ERR(tx->macro))
+		return PTR_ERR(tx->macro);
 
-	ret = devm_clk_bulk_get_optional(dev, TX_NUM_CLKS_MAX, tx->clks);
-	if (ret) {
-		dev_err(dev, "Error getting RX Clocks (%d)\n", ret);
-		return ret;
-	}
+	tx->dcodec = devm_clk_get_optional(dev, "dcodec");
+	if (IS_ERR(tx->dcodec))
+		return PTR_ERR(tx->dcodec);
+
+	tx->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(tx->mclk))
+		return PTR_ERR(tx->mclk);
+
+	tx->npl = devm_clk_get(dev, "npl");
+	if (IS_ERR(tx->npl))
+		return PTR_ERR(tx->npl);
+
+	tx->fsgen = devm_clk_get(dev, "fsgen");
+	if (IS_ERR(tx->fsgen))
+		return PTR_ERR(tx->fsgen);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -1833,26 +1846,52 @@ static int tx_macro_probe(struct platform_device *pdev)
 	tx->dev = dev;
 
 	/* set MCLK and NPL rates */
-	clk_set_rate(tx->clks[2].clk, MCLK_FREQ);
-	clk_set_rate(tx->clks[3].clk, 2 * MCLK_FREQ);
+	clk_set_rate(tx->mclk, MCLK_FREQ);
+	clk_set_rate(tx->npl, 2 * MCLK_FREQ);
 
-	ret = clk_bulk_prepare_enable(TX_NUM_CLKS_MAX, tx->clks);
+	ret = clk_prepare_enable(tx->macro);
 	if (ret)
-		return ret;
+		goto err;
+
+	ret = clk_prepare_enable(tx->dcodec);
+	if (ret)
+		goto err_dcodec;
+
+	ret = clk_prepare_enable(tx->mclk);
+	if (ret)
+		goto err_mclk;
+
+	ret = clk_prepare_enable(tx->npl);
+	if (ret)
+		goto err_npl;
+
+	ret = clk_prepare_enable(tx->fsgen);
+	if (ret)
+		goto err_fsgen;
 
 	ret = tx_macro_register_mclk_output(tx);
 	if (ret)
-		goto err;
+		goto err_clkout;
 
 	ret = devm_snd_soc_register_component(dev, &tx_macro_component_drv,
 					      tx_macro_dai,
 					      ARRAY_SIZE(tx_macro_dai));
 	if (ret)
-		goto err;
-	return ret;
-err:
-	clk_bulk_disable_unprepare(TX_NUM_CLKS_MAX, tx->clks);
+		goto err_clkout;
 
+	return 0;
+
+err_clkout:
+	clk_disable_unprepare(tx->fsgen);
+err_fsgen:
+	clk_disable_unprepare(tx->npl);
+err_npl:
+	clk_disable_unprepare(tx->mclk);
+err_mclk:
+	clk_disable_unprepare(tx->dcodec);
+err_dcodec:
+	clk_disable_unprepare(tx->macro);
+err:
 	return ret;
 }
 
@@ -1860,7 +1899,11 @@ static int tx_macro_remove(struct platform_device *pdev)
 {
 	struct tx_macro *tx = dev_get_drvdata(&pdev->dev);
 
-	clk_bulk_disable_unprepare(TX_NUM_CLKS_MAX, tx->clks);
+	clk_disable_unprepare(tx->macro);
+	clk_disable_unprepare(tx->dcodec);
+	clk_disable_unprepare(tx->mclk);
+	clk_disable_unprepare(tx->npl);
+	clk_disable_unprepare(tx->fsgen);
 
 	return 0;
 }
-- 
2.21.0

