Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D634BE985
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358686AbiBUNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358658AbiBUNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812891EC6F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so1339306wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RewL+3EtNxhC0ou/pYILBVrh1qSfkoLM81IegMwgi94=;
        b=CnZFhCDbVNq8YUQgIUgkcn7+ZwM1cLOb2I1C7hnWQq/B7122caLSKIX1vYxPKwTVI9
         tAGaU4oDRPjyZ5ZfScYain86omjfyxk0tYYwx6JxRIt+CdACoJXVIXIPObS9i7LdM43t
         4GVsw7WZNQNwNYXzapJaFtgt+WwQalTTvOTIlhFjCnjRv41VHKLkHX1TPY9HEG45IV70
         mKYifBTkAZZ9sCLKrnFXOhxTWnpniQc24Y6feTJb+2AHWQGbP0ex/lQX34OYpwqD1WMH
         85SzasVkc/Vn44HV+j4UA83UZvQUXKkVXychSJEhW77gfKkWmlWhNOxUhvsYm/HZRcRL
         Du9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RewL+3EtNxhC0ou/pYILBVrh1qSfkoLM81IegMwgi94=;
        b=y4N+3VV8tI7c5R7wnc90moN1Z5FZGRCxGC3WXNshh2ZM0prXM6C2jwvyou/NPd2ewU
         UvlxzDt96600W70IyCNkcjWEvvgoKwuoNFTzks3grmHKLrUruejmKNIL4Iary9Bt3rnM
         8U6AvcOZKVMbgthbdk5xr0tsfYhDD3xYM7UxRo7CQvf7lM6s/URJRTEi9Vd9/Y9JvQei
         zf3yz4V3gGDx8eSTqOwHsoJ6SsJOh2+PyLK4a4w6S9ny4NtY/peuvSIMN4pj47EW8kbr
         AqQfZzE7G227XECLiGE9Sr+Xea7GcFEcNvhoRIOgHN6GVMDdpbYc14r69cgCREMIWT7/
         7ZsA==
X-Gm-Message-State: AOAM533ogPP7DkofErdKsaqx6Vj2lAebVoEJhbcAosx0hYZcM0EhC9NK
        CXRckTyDEwWjBE8QhcEO+RsKnQ==
X-Google-Smtp-Source: ABdhPJxGMd0Ms8x6dw0XsYi8KALi9pePtOLeIdPF5Bpu7BL8TvC7gxCHwewtjeASsZJ2rFGToWHbow==
X-Received: by 2002:a05:600c:410d:b0:37b:b8f2:a1b1 with SMTP id j13-20020a05600c410d00b0037bb8f2a1b1mr16948525wmi.123.1645449044140;
        Mon, 21 Feb 2022 05:10:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/10] ASoC: codecs: rx-macro: add runtime pm support
Date:   Mon, 21 Feb 2022 13:10:30 +0000
Message-Id: <20220221131037.8809-4-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-rx-macro.c | 45 ++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 0ed032b220a4..fb5d4bb8bd8b 100644
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
@@ -3568,8 +3569,17 @@ static int rx_macro_probe(struct platform_device *pdev)
 					      rx_macro_dai,
 					      ARRAY_SIZE(rx_macro_dai));
 	if (ret)
-		clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
+		goto err;
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
+	return ret;
+err:
+	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
 	return ret;
 }
 
@@ -3589,11 +3599,44 @@ static const struct of_device_id rx_macro_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
 
+static int __maybe_unused rx_macro_runtime_suspend(struct device *dev)
+{
+	struct rx_macro *rx = dev_get_drvdata(dev);
+
+	regcache_cache_only(rx->regmap, true);
+	regcache_mark_dirty(rx->regmap);
+
+	clk_disable_unprepare(rx->clks[2].clk);
+	clk_disable_unprepare(rx->clks[3].clk);
+	clk_disable_unprepare(rx->clks[4].clk);
+
+	return 0;
+}
+
+static int __maybe_unused rx_macro_runtime_resume(struct device *dev)
+{
+	struct rx_macro *rx = dev_get_drvdata(dev);
+
+	clk_prepare_enable(rx->clks[2].clk);
+	clk_prepare_enable(rx->clks[3].clk);
+	clk_prepare_enable(rx->clks[4].clk);
+	regcache_cache_only(rx->regmap, false);
+	regcache_sync(rx->regmap);
+	rx->reset_swr = true;
+
+	return 0;
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

