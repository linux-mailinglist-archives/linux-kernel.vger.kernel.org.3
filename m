Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6B4C2AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiBXLSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiBXLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A94215A23A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d3so2469437wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNHsk/5D9xGPuJd373nmHea73ZrQBMQ8kphOXj5avdc=;
        b=CAztRwtvkUV4S/jm0VRCSY3/l6SYaa3FYziJw4jCHUV/3ExCknj5i6ayCefxIAqzSC
         kG9WgCMWy8FVch3L0V0n8ICxsoWJKfSN/f6Tu7foDLn5FXExsAJl50LfxsAvcTSXXbul
         x+1GXhyHoGAq7sYB/kMdZmjIS7n3QxTO3VmTPhn3M/ZR2+ViLKT3DIKeR9IeQDRzA10B
         3ND4iaYG0x3kBKKCdzYTBtJHrKyEVHZ+atcNHEJFUxltIeS7pC+k49o1yxkbloVz/hyC
         qUIaYKNy337fHJ6H8rFOotqmXV6nweemfI6jbDAX2GbNvq57z3sxydYi+FOHY8u073zd
         C6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNHsk/5D9xGPuJd373nmHea73ZrQBMQ8kphOXj5avdc=;
        b=nU/dCqKfAdOAL8iIiZCRDAipHBNwKQ1xrsITjSgvxx/LCVjeNqg8mQh7lkivlAuNF5
         VXQWK8v5jskLUtYbf9h3Yn16lBQLK2XoT3f5Y3ay8FFqtCkF3KAPYCwcAVsuOGA1YIay
         49P0fpkVAB7Yh7Sps2gcr9hEHBlzYdX0lpfBOVaZysd8ao1DpN6q9GfZWpKiJcKbG1SZ
         gnvZV4DKrw7D2iPge0RpBYUai/V6xEDwo+HwHq8gs8CluGg1WI/yjm0UJ75em5MWXc2O
         r0ggQTvfENH1YFjU+bPkNfR5lBzD785vC7JflHzNF8AghAlcfjvg1X1tHqPtMQ71tZXZ
         iV7A==
X-Gm-Message-State: AOAM530CZ5Daj7ZgUqFHjrHhY8PiyvmmZTlKo8/s718cN4iIuzeTDFuJ
        qayOYCRk3q3KlFIT+qA65zkyXw==
X-Google-Smtp-Source: ABdhPJxFwqIv17XbkPAGUFEk1/FooN+/RsYed3Q2KhAOJZC9eVgY/J8T/Cw/4GeSyGQvbfdPGN9fbA==
X-Received: by 2002:a5d:6c68:0:b0:1e8:9827:b978 with SMTP id r8-20020a5d6c68000000b001e89827b978mr1716361wrz.633.1645701455898;
        Thu, 24 Feb 2022 03:17:35 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 12/16] ASoC: codecs: rx-macro: add runtime pm support
Date:   Thu, 24 Feb 2022 11:17:14 +0000
Message-Id: <20220224111718.6264-13-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-rx-macro.c | 62 +++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a2f49a21678b..67bec5befc02 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
@@ -3605,6 +3606,13 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clkout;
 
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 
 err_clkout:
@@ -3641,11 +3649,65 @@ static const struct of_device_id rx_macro_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
 
+static int __maybe_unused rx_macro_runtime_suspend(struct device *dev)
+{
+	struct rx_macro *rx = dev_get_drvdata(dev);
+
+	regcache_cache_only(rx->regmap, true);
+	regcache_mark_dirty(rx->regmap);
+
+	clk_disable_unprepare(rx->mclk);
+	clk_disable_unprepare(rx->npl);
+	clk_disable_unprepare(rx->fsgen);
+
+	return 0;
+}
+
+static int __maybe_unused rx_macro_runtime_resume(struct device *dev)
+{
+	struct rx_macro *rx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(rx->mclk);
+	if (ret) {
+		dev_err(dev, "unable to prepare mclk\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(rx->npl);
+	if (ret) {
+		dev_err(dev, "unable to prepare mclkx2\n");
+		goto err_npl;
+	}
+
+	ret = clk_prepare_enable(rx->fsgen);
+	if (ret) {
+		dev_err(dev, "unable to prepare fsgen\n");
+		goto err_fsgen;
+	}
+	regcache_cache_only(rx->regmap, false);
+	regcache_sync(rx->regmap);
+	rx->reset_swr = true;
+
+	return 0;
+err_fsgen:
+	clk_disable_unprepare(rx->npl);
+err_npl:
+	clk_disable_unprepare(rx->mclk);
+
+	return ret;
+}
+
+static const struct dev_pm_ops rx_macro_pm_ops = {
+	SET_RUNTIME_PM_OPS(rx_macro_runtime_suspend, rx_macro_runtime_resume, NULL)
+};
+
 static struct platform_driver rx_macro_driver = {
 	.driver = {
 		.name = "rx_macro",
 		.of_match_table = rx_macro_dt_match,
 		.suppress_bind_attrs = true,
+		.pm = &rx_macro_pm_ops,
 	},
 	.probe = rx_macro_probe,
 	.remove = rx_macro_remove,
-- 
2.21.0

