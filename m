Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125E04BDF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358666AbiBUNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358654AbiBUNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FB1EC6B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso11159953wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/873brHhZR6xm18sDiZdhD33uqz5ep38GtGCx69qMY=;
        b=WWR2i/oD1/ImYmqzvGm+tSJJ7MlYn6oWxndq5vCHMn2AFVVnhZ/RRBzCsMw6c831ag
         +5JoERRNMn0iyyrGiJxWZv6FFkwWZRl9yv32YVwUpqYgbh28p7CYJV7h+9P867hF010F
         r9gP6OdjsJuWvEZ6BIxpy84WwiSP8clBu/odr+AgHbHNqlRYq3YZ8pTwaJtxSqY3HmGy
         NG7tReTFSjSfIeBzXa7yaIxwjoZcEaaPtpo7mXeyubfh/lBjeNlLp5Z1qTozN0i9ub0R
         dq0L6M1nwXV5wBuMnUEb9/zMUQdVainoXaQ9FZp2P6Py7yg7TWFfqdRqZ0S0EVI5kF2W
         6IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/873brHhZR6xm18sDiZdhD33uqz5ep38GtGCx69qMY=;
        b=urSMzteMXd+kP9qH+Z7Y8+ojlO6A68JK2yFpuULkio+M2mdzL7j1bC+402bQU6A0o0
         bIrkF5dR1vKhCtq24AlyCeFBnpZnBCHuPNH5Y8TTWHhGl+r1BwpOqISSpF+sGVmKbG5F
         11J+eCzCKmCWN0hpqR6uJE1RYfXpa0C3jjd/fNXl1tPkQsZmmOoGbOPP/BkR5M5pyQI/
         S74HuxgDCsH5i/UqlghGjmE5fHjjTuLnFLG4UXvhBfLLBYFkGg7/0k7f2duQ9Rlen+XD
         StTSiUrDKQi8Us7jh9GLIXWat3qcyKSu7Lva1njY3wBG2i1+EtPBkzT2Vo3J1W4oyfSH
         O+Ew==
X-Gm-Message-State: AOAM532xsADHvSjpwIod6ESWQ2dz8FgKQ0pLgPGpmOd8hRC6Q4f9Funj
        3TKNzLRtf2QxGqy3ysBPvmZNQg==
X-Google-Smtp-Source: ABdhPJwsozEEOuF/0rPoouuPwDOTCYZ96rRUj9bR+ckw7xR4Yo/oO3Yc462V1ta/luwtz7dIWCoRHQ==
X-Received: by 2002:a05:600c:384a:b0:37b:e8ac:851f with SMTP id s10-20020a05600c384a00b0037be8ac851fmr9358623wmr.158.1645449045225;
        Mon, 21 Feb 2022 05:10:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/10] ASoC: codecs: tx-macro: add runtime pm support
Date:   Mon, 21 Feb 2022 13:10:31 +0000
Message-Id: <20220221131037.8809-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-tx-macro.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 7347d79a6329..1c0f0d27ed42 100644
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
@@ -1844,6 +1845,13 @@ static int tx_macro_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(tx_macro_dai));
 	if (ret)
 		goto err;
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return ret;
 err:
 	clk_bulk_disable_unprepare(TX_NUM_CLKS_MAX, tx->clks);
@@ -1862,6 +1870,38 @@ static int tx_macro_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused tx_macro_runtime_suspend(struct device *dev)
+{
+	struct tx_macro *tx = dev_get_drvdata(dev);
+
+	regcache_cache_only(tx->regmap, true);
+	regcache_mark_dirty(tx->regmap);
+
+	clk_disable_unprepare(tx->clks[2].clk);
+	clk_disable_unprepare(tx->clks[3].clk);
+	clk_disable_unprepare(tx->clks[4].clk);
+
+	return 0;
+}
+
+static int __maybe_unused tx_macro_runtime_resume(struct device *dev)
+{
+	struct tx_macro *tx = dev_get_drvdata(dev);
+
+	clk_prepare_enable(tx->clks[2].clk);
+	clk_prepare_enable(tx->clks[3].clk);
+	clk_prepare_enable(tx->clks[4].clk);
+	regcache_cache_only(tx->regmap, false);
+	regcache_sync(tx->regmap);
+	tx->reset_swr = true;
+
+	return 0;
+}
+
+static const struct dev_pm_ops tx_macro_pm_ops = {
+	SET_RUNTIME_PM_OPS(tx_macro_runtime_suspend, tx_macro_runtime_resume, NULL)
+};
+
 static const struct of_device_id tx_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
 	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
@@ -1873,6 +1913,7 @@ static struct platform_driver tx_macro_driver = {
 		.name = "tx_macro",
 		.of_match_table = tx_macro_dt_match,
 		.suppress_bind_attrs = true,
+		.pm = &tx_macro_pm_ops,
 	},
 	.probe = tx_macro_probe,
 	.remove = tx_macro_remove,
-- 
2.21.0

