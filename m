Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EC4BDC10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358641AbiBUNLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358602AbiBUNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB721EC61
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so26981744wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CALk/6ca7iO7/xBqMHHMOaqmUFWsovsA/Kq66L5KIA8=;
        b=LGamMUK0B2xkMZwpcmUL37yW6Z3TUIr5n5SrtxOkaisKG1588ss/Yu5E3C/KXo3TnI
         MmRzj1y+mJeBasHZ/W8PcwubZM9uleE2/V0Jsv19j/FLzbdkkwzA7pShMI6wHQky4r35
         2MZnwtat7HskNH3Z/KNyL/0sdhrH3mk9Xd2o75Ix5sbQISvXJ9oUFzb+0/J4dTtMVv3U
         OL2QixZibH0rWwZIwK4f1qMM4jCr0EKhxTpiN4AnSJQSIWeg5cYyDI/6kAS2abLHj/g8
         PETLpTzdddsbeEGTn9GMinPoa/TeuwetOWA+F78ksyS2KJLXdpuYz+tKNaZnQZbLWKRU
         O0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CALk/6ca7iO7/xBqMHHMOaqmUFWsovsA/Kq66L5KIA8=;
        b=yeF5OB3CWnibHBLTeISid+ddAL8RlMpFNoOoNaAuJjnvvYsSbxfanQajuUZQlVSuye
         ltH6WjX9pbJxPcLw78h990HrqAySJgCz08c8BouOQUJHpV79ys6jsto/kDZbI+w82Tq2
         0ZCaAc+Qiq68ooVZKicFYNzpU8lNi2j20PeXMWIE2cXJv5Mchem+aFP/ndhHJGZ7qAj2
         8zGgiSNCduphAOz8ICPUdm2Hnr2J0cKvKO3t47rlUeXMF+02IWdUb23eN83T5+xpoeDQ
         TiTRV78jps4NX3rhDCTrqSKE9LZrl9CY/pFe9XPrrQ3fj2tLQwZdSiFhrW6p6htBo2iR
         tPEA==
X-Gm-Message-State: AOAM533FzMRtVKVIdUiFTYzRxPcDgcQMQgadgfccdloyCStkPtcHSqlq
        oW7lBZO4kp2RPOfTyHb5pnSuHA==
X-Google-Smtp-Source: ABdhPJxqajVm7LxH5nEQV46AvjifUaSWOSb7GZHElKDVaAEoKDL3QMy5CpreSZ8ZutAb/8jHZlq6gQ==
X-Received: by 2002:adf:e883:0:b0:1e4:b617:bc9d with SMTP id d3-20020adfe883000000b001e4b617bc9dmr15806525wrm.132.1645449041832;
        Mon, 21 Feb 2022 05:10:41 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/10] ASoC: codecs: va-macro: add runtime pm support
Date:   Mon, 21 Feb 2022 13:10:28 +0000
Message-Id: <20220221131037.8809-2-srinivas.kandagatla@linaro.org>
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

Add pm runtime support to VA Macro.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index e14c277e6a8b..0fd0139e8229 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -9,6 +9,7 @@
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <sound/soc.h>
@@ -1454,6 +1455,12 @@ static int va_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return ret;
 
 err:
@@ -1471,6 +1478,34 @@ static int va_macro_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused va_macro_runtime_suspend(struct device *dev)
+{
+	struct va_macro *va = dev_get_drvdata(dev);
+
+	regcache_cache_only(va->regmap, true);
+	regcache_mark_dirty(va->regmap);
+
+	clk_disable_unprepare(va->clks[2].clk);
+
+	return 0;
+}
+
+static int __maybe_unused va_macro_runtime_resume(struct device *dev)
+{
+	struct va_macro *va = dev_get_drvdata(dev);
+
+	clk_prepare_enable(va->clks[2].clk);
+
+	regcache_cache_only(va->regmap, false);
+	regcache_sync(va->regmap);
+	return 0;
+}
+
+
+static const struct dev_pm_ops va_macro_pm_ops = {
+	SET_RUNTIME_PM_OPS(va_macro_runtime_suspend, va_macro_runtime_resume, NULL)
+};
+
 static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-va-macro" },
 	{ .compatible = "qcom,sm8250-lpass-va-macro" },
@@ -1483,6 +1518,7 @@ static struct platform_driver va_macro_driver = {
 		.name = "va_macro",
 		.of_match_table = va_macro_dt_match,
 		.suppress_bind_attrs = true,
+		.pm = &va_macro_pm_ops,
 	},
 	.probe = va_macro_probe,
 	.remove = va_macro_remove,
-- 
2.21.0

