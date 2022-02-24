Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C534C2AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiBXLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiBXLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511116E7CD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so2447940wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBRWbGG3hXrowhqp61BdFvJmp09eFX4PXrA2EU5LRPo=;
        b=RFQzpDwgQRIX0yGLn4YfC6ANknqYHJ6rJ/TY2pD6gHlbityGXrfOMxGVYg340Ddr9k
         a6QwKq0nHHECWIAW5QTRZNZNpJYFjK7o8opbLHX656DjtzraCU0ZGg5aq1gzPliOQvou
         WhuVlsmrYWkUhqO4Ggd/ruelD0oB6U9elXIBgIhQeO839VxzGkAsuKe87pfbXmKp/u4i
         VRr9oNXWkSroGZfbeeR+XOEHHDbqzVGA9IF8kdVrUxWl20+s5o3cn9ZBHWkAh55WH0q+
         npod77c4D1IRi5B1UU0lRF04uM51uVVPFdEO+VaLC4gH1URjWIZonJQksJ/epWwcHjcU
         0+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBRWbGG3hXrowhqp61BdFvJmp09eFX4PXrA2EU5LRPo=;
        b=PYr6p2Ujl98JIAbHfyabyPcAd0NB7vyxTbk1vp47ZuwE1CLjtzD9CkX+hvnCK0F4YK
         GFw8S0tcWVJM0QVaCoAPNCkXSIBsaNpalKXqe96IKJvQRGpQ4zlLqf/dRYenW+BQ1LHA
         HY6qFFwLeLxoat9YtfuXyUiQwnUmHnxsXgSkKFxS8kbKU9Kp+NskIno8Tp/No06it+Sk
         PELqeM7IHl8gHZRrZvivbeamFv0v4QH7dBH+p8nGblk6WEQhoF/fhaIjiUlcEcEe4YOg
         lFSVMCvHz9NOrmgt5HP8cbJ4OxR9w6vCRcWZauiv8Cc5n3FU6S/d5bKetWM9TwTrgjo4
         2IqA==
X-Gm-Message-State: AOAM533YR1HS0O+xgK8+2CXO42+XFiNz4qgqLNrdMUe1CZE0iAYxAsro
        pz3yptpmvHzwl6pnCBQAHWwO8Q==
X-Google-Smtp-Source: ABdhPJx4PbfZIRdTPPLjfaKJk9COSJSQw2JAq202emZ0PODnzYAXfVQ3C/JVsLYSfYFLHFZjHMI+jA==
X-Received: by 2002:a5d:64ce:0:b0:1e4:9b8d:4ccd with SMTP id f14-20020a5d64ce000000b001e49b8d4ccdmr1892266wri.37.1645701456920;
        Thu, 24 Feb 2022 03:17:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 13/16] ASoC: codecs: tx-macro: add runtime pm support
Date:   Thu, 24 Feb 2022 11:17:15 +0000
Message-Id: <20220224111718.6264-14-srinivas.kandagatla@linaro.org>
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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index b32235a9e1e5..2b2b93ddb4d6 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1887,6 +1887,12 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clkout;
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 
 err_clkout:
@@ -1916,6 +1922,60 @@ static int tx_macro_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused tx_macro_runtime_suspend(struct device *dev)
+{
+	struct tx_macro *tx = dev_get_drvdata(dev);
+
+	regcache_cache_only(tx->regmap, true);
+	regcache_mark_dirty(tx->regmap);
+
+	clk_disable_unprepare(tx->mclk);
+	clk_disable_unprepare(tx->npl);
+	clk_disable_unprepare(tx->fsgen);
+
+	return 0;
+}
+
+static int __maybe_unused tx_macro_runtime_resume(struct device *dev)
+{
+	struct tx_macro *tx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tx->mclk);
+	if (ret) {
+		dev_err(dev, "unable to prepare mclk\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(tx->npl);
+	if (ret) {
+		dev_err(dev, "unable to prepare npl\n");
+		goto err_npl;
+	}
+
+	ret = clk_prepare_enable(tx->fsgen);
+	if (ret) {
+		dev_err(dev, "unable to prepare fsgen\n");
+		goto err_fsgen;
+	}
+
+	regcache_cache_only(tx->regmap, false);
+	regcache_sync(tx->regmap);
+	tx->reset_swr = true;
+
+	return 0;
+err_fsgen:
+	clk_disable_unprepare(tx->npl);
+err_npl:
+	clk_disable_unprepare(tx->mclk);
+
+	return ret;
+}
+
+static const struct dev_pm_ops tx_macro_pm_ops = {
+	SET_RUNTIME_PM_OPS(tx_macro_runtime_suspend, tx_macro_runtime_resume, NULL)
+};
+
 static const struct of_device_id tx_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
 	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
@@ -1927,6 +1987,7 @@ static struct platform_driver tx_macro_driver = {
 		.name = "tx_macro",
 		.of_match_table = tx_macro_dt_match,
 		.suppress_bind_attrs = true,
+		.pm = &tx_macro_pm_ops,
 	},
 	.probe = tx_macro_probe,
 	.remove = tx_macro_remove,
-- 
2.21.0

