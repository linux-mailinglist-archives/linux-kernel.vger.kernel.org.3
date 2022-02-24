Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE264C2AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiBXLSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiBXLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D816C4F6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n14so2075132wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnhpDOk4CUU3lYsv0PpUfinJqZMQJnvxRMmJ0Ek2uv8=;
        b=iHgn2n0Xbc0eS5i5rmuVlIhBnrk1T9JqOx4lAmr9MjuuLqLPefIrWkjeUB03q3UJdk
         JcYDwzltbGzolGWroQQt8Gc6b1IoXLn8Agdj9/jJkDhkrcX5btQlkOFD8kmicnTI8mfw
         kQC15wMyxH7qrfe74fHBcLB6eSioWOWbGVFFev0Xmd6HZz5zyQZGi/3fE9VvSQuNwVje
         wugyuVvpNoeRhvzMmdW71VcyBtTpu8JnZgJOrRp9q9GkEf+8J2UhRtNGJ08Rn1bFqwW+
         GLErTgSwojHatENPHxxIP7hCsR3UF1UFlXyJzy7Xd/wSy+F7YK8LNI/+8fYhBHVvqRxM
         6xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnhpDOk4CUU3lYsv0PpUfinJqZMQJnvxRMmJ0Ek2uv8=;
        b=j4mK48uuXXsKWp/DdMCMQErPW9XJ5rSxPi+uz9Mr8oAUhYvBBKr8uA+vQ/WygqUPCn
         0TqkgR4VRTQ0mPAp5xd/gbPx0wfti3j+F7Xiu7b40dDJkAkOciJbhPDPqYKPFTuOExkT
         jaOtGiUlKrC9Ynf9h+PopHxQ3JwiVyZqy6gRfXmyCZjOrPtlWY4BLAa7RCchpS1KW2+2
         QU6IpfQP0htByCoQge0SonE+co7mh9DfnAvGZOLdvSzS6xA1Lu50U5s+3qDQ7hjd4DBO
         Z727XfgqxaoZt9wLJRmghLEKtMfZIUxk0gNN28EBn9UU6BXgk6naeEZ0Dy5muL5SgKVE
         a5aA==
X-Gm-Message-State: AOAM531oHr+6MCsrNvCnTkC3EeisBiJhkxxwgRtttdN7/zFWAqPqbD+4
        Le2sCVAJPFxUh/d26N+6W2BSvA==
X-Google-Smtp-Source: ABdhPJxGJ8YMd6U1ZvlIMkNGjumB115CP6WBkh2oFxGcgtmx9Xosrnqs/8pck2bBAImBOr/InU6k5A==
X-Received: by 2002:a05:6000:178a:b0:1ea:7db1:3159 with SMTP id e10-20020a056000178a00b001ea7db13159mr1819995wrg.9.1645701453670;
        Thu, 24 Feb 2022 03:17:33 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/16] ASoC: codecs: va-macro: add runtime pm support
Date:   Thu, 24 Feb 2022 11:17:12 +0000
Message-Id: <20220224111718.6264-11-srinivas.kandagatla@linaro.org>
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

Add pm runtime support to VA Macro.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index ff8120886eca..34aeee50332a 100644
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
@@ -1469,6 +1470,12 @@ static int va_macro_probe(struct platform_device *pdev)
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
@@ -1492,6 +1499,39 @@ static int va_macro_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused va_macro_runtime_suspend(struct device *dev)
+{
+	struct va_macro *va = dev_get_drvdata(dev);
+
+	regcache_cache_only(va->regmap, true);
+	regcache_mark_dirty(va->regmap);
+
+	clk_disable_unprepare(va->mclk);
+
+	return 0;
+}
+
+static int __maybe_unused va_macro_runtime_resume(struct device *dev)
+{
+	struct va_macro *va = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(va->mclk);
+	if (ret) {
+		dev_err(va->dev, "unable to prepare mclk\n");
+		return ret;
+	}
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
@@ -1504,6 +1544,7 @@ static struct platform_driver va_macro_driver = {
 		.name = "va_macro",
 		.of_match_table = va_macro_dt_match,
 		.suppress_bind_attrs = true,
+		.pm = &va_macro_pm_ops,
 	},
 	.probe = va_macro_probe,
 	.remove = va_macro_remove,
-- 
2.21.0

