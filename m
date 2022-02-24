Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E64C2AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiBXLSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiBXLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731615A23A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so1062885wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cbjsxCnwDWXHhy887xSacuizUGg3UE/QEHYO2FNZug=;
        b=BgqwvFh2NPOZWo/43igYz9dplEN9ywPQIC+tP75/FD9MiDSMm2FPbL22A//EuT73hU
         7vhj8McsZuFw+RvtPOqiD+gxu/rxLUMd7oQYYOf+qe30OhlisjwrGmVDpMteh2mFst/b
         jILEiDTzLgsnCF5Kgm3Igoponk+Osh1zGm9jnm2oMv4RfCIKdfZ++7s1I4DlYgP/DsxH
         HHiI3sR4nCLsWr8AK5loL92+wKbZjHB+qG0P0dhOZ044KvP4CuODA0uJnHKQ4S3iRnbQ
         2T663q+al/5JFIGlwZnTFgYxS5f55AKQDlcPNWVdt4H+dC4Q8iMYymzUpJ5rp7IRdwAp
         X4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cbjsxCnwDWXHhy887xSacuizUGg3UE/QEHYO2FNZug=;
        b=GFRY7rzWQPXmMmq4BT5Spum37i1pdZPHFgBftBM7cUJPcuK2So0zdXdQl2Nn37RrhV
         MG/qCoV7gBU450h9AMN6eh+euyC8M1igCX375ZNat7RE98l5hnOg+jDftc96nc4YMYr1
         l67qXN2THdpHqUp2XsOheJdxr+G7wUTwoeM47DdNlDh6ZpYwPZM7tIXL89w1wJwHysh2
         qyKIdhZtnhfPguGK12ulQ6S2oxYk4XxB37r2TdrvXsa6uhZlgXSd+nNIv0dtOCaRqFkq
         UP/blDaIKuYtn/bhPsGUnd47b8ws0lcJEUlPdQXwBHbvGamAa7M2Ll3s07DAQforOqqH
         gIoA==
X-Gm-Message-State: AOAM532oabn6TahrZs0qex9PP5nIwbOge7HVPEASfgWoQGusw/e09Lwr
        vPwDHHXVY5fzLSu46GZdq66/XA==
X-Google-Smtp-Source: ABdhPJz5yjsGGYmbzbcKMglDTtROqnuOEqI3XWpxcYBLcKIQk4RLuVyxqapOo5JrHW4l9FhodTmeZg==
X-Received: by 2002:a05:600c:384c:b0:37b:c771:499c with SMTP id s12-20020a05600c384c00b0037bc771499cmr11105362wmr.141.1645701454723;
        Thu, 24 Feb 2022 03:17:34 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:34 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/16] ASoC: codecs: wsa-macro: add runtime pm support
Date:   Thu, 24 Feb 2022 11:17:13 +0000
Message-Id: <20220224111718.6264-12-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-wsa-macro.c | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 2586d6350f20..97ef788ab65d 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/pm_runtime.h>
 #include <linux/of_platform.h>
 #include <sound/tlv.h>
 #include "lpass-wsa-macro.h"
@@ -2468,6 +2469,12 @@ static int wsa_macro_probe(struct platform_device *pdev)
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
@@ -2498,6 +2505,59 @@ static int wsa_macro_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused wsa_macro_runtime_suspend(struct device *dev)
+{
+	struct wsa_macro *wsa = dev_get_drvdata(dev);
+
+	regcache_cache_only(wsa->regmap, true);
+	regcache_mark_dirty(wsa->regmap);
+
+	clk_disable_unprepare(wsa->mclk);
+	clk_disable_unprepare(wsa->npl);
+	clk_disable_unprepare(wsa->fsgen);
+
+	return 0;
+}
+
+static int __maybe_unused wsa_macro_runtime_resume(struct device *dev)
+{
+	struct wsa_macro *wsa = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(wsa->mclk);
+	if (ret) {
+		dev_err(dev, "unable to prepare mclk\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(wsa->npl);
+	if (ret) {
+		dev_err(dev, "unable to prepare mclkx2\n");
+		goto err_npl;
+	}
+
+	ret = clk_prepare_enable(wsa->fsgen);
+	if (ret) {
+		dev_err(dev, "unable to prepare fsgen\n");
+		goto err_fsgen;
+	}
+
+	regcache_cache_only(wsa->regmap, false);
+	regcache_sync(wsa->regmap);
+
+	return 0;
+err_fsgen:
+	clk_disable_unprepare(wsa->npl);
+err_npl:
+	clk_disable_unprepare(wsa->mclk);
+
+	return ret;
+}
+
+static const struct dev_pm_ops wsa_macro_pm_ops = {
+	SET_RUNTIME_PM_OPS(wsa_macro_runtime_suspend, wsa_macro_runtime_resume, NULL)
+};
+
 static const struct of_device_id wsa_macro_dt_match[] = {
 	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
 	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
@@ -2509,6 +2569,7 @@ static struct platform_driver wsa_macro_driver = {
 	.driver = {
 		.name = "wsa_macro",
 		.of_match_table = wsa_macro_dt_match,
+		.pm = &wsa_macro_pm_ops,
 	},
 	.probe = wsa_macro_probe,
 	.remove = wsa_macro_remove,
-- 
2.21.0

