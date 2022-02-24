Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B04C2ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiBXLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiBXLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AB16E7C1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d17so2426377wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyVwZE5kS8xGdR91o+WjovvMprsI53ZLyaYZnmErV2U=;
        b=FhYFTNt+x3zszGAAc6gGVhzw88T2nJfziV8IMyz+t5pRZHT/uQUpG/qBROnyUaOInX
         t6ydRexMU9xeDqLPuLmfDwCcCcley4x4U48EGfc4N6WukdVvYf8DZlawzrDNKd8C7FFV
         piEKh1CH2rdUJ1/FKZ0wmHE4/5BGxIbZHJG5Ki926kOMial7fMtmRNM3mz5ZKagcqQjk
         tL4T4laIIAgpVqkFPZUZZNUePbs6aG+cQbu0t7oetR3A6Br0XbUtDfDTA3TY2Orv2o9P
         yyD0rt+BDpSTqiVwmhzn7HbDPMIxaJxxqu9Fsoa9qSLz8xyqDGQHvgI9lumtnZ6NGpm4
         c+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyVwZE5kS8xGdR91o+WjovvMprsI53ZLyaYZnmErV2U=;
        b=mA/8HabuZqmrTzKncZSVMLxpgtaphQ0KC3d7UtmWNdcjM0gOSPW0PZPkCU9wY77bN7
         3dzWZdUjCswWprPVj0xuiJVyQ+qwp1XpGh3/FdgfaNH1E1KGL+9YYM+bik1PkRLajj54
         pZaZmXOns1IZQxrJymik8t/u4T+s7YM0Sxt5/GhlqyMogosyCHHuefR7jBePc3Kg3XJ1
         fsLj+kRtoYaAykQ+3mjrDSLHtN4r9QrB6GbLwJo//6VNmdwyf2vGT38pzsN0AO/C0Yw6
         TEiDDkSRXSfVaDxK+XR90pNDNA73+IVJQ/Ddp5Hmtrl3jwkjJwOWMHqHXpRE1tjcSl7F
         PzTw==
X-Gm-Message-State: AOAM531qltpb7tzXfoajVIzfCPcZV8NQqdeUyUQeCyIbXopqf00b1QND
        fdVal3rKWjwfvEO7AP8sgHZvEg==
X-Google-Smtp-Source: ABdhPJyAAhwj8cEam23zueLna4wetFnGKEXHXXgZhuqBgsSnzAi5Elri6zJEPYc0C7b8nXQqOuN60A==
X-Received: by 2002:a05:6000:2ad:b0:1ea:793a:3284 with SMTP id l13-20020a05600002ad00b001ea793a3284mr1835943wry.63.1645701460101;
        Thu, 24 Feb 2022 03:17:40 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 16/16] ASoC: codecs: wcd-mbhc: add runtime pm support
Date:   Thu, 24 Feb 2022 11:17:18 +0000
Message-Id: <20220224111718.6264-17-srinivas.kandagatla@linaro.org>
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

under low power state a SoundWire Wake IRQ could trigger MBHC interrupts
so make sure that codec is not in suspended state when this happens.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 7488a150a138..c53c2ef33e1a 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
@@ -711,6 +712,16 @@ static irqreturn_t wcd_mbhc_hphr_ocp_irq(int irq, void *data)
 static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 {
 	struct snd_soc_component *component = mbhc->component;
+	int ret;
+
+	ret = pm_runtime_get_sync(component->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(component->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(component->dev);
+		return ret;
+	}
 
 	mutex_lock(&mbhc->lock);
 
@@ -751,6 +762,9 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 
 	mutex_unlock(&mbhc->lock);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -1078,10 +1092,19 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	int output_mv, cross_conn, hs_threshold, try = 0, micbias_mv;
 	bool is_spl_hs = false;
 	bool is_pa_on;
+	int ret;
 
 	mbhc = container_of(work, struct wcd_mbhc, correct_plug_swch);
 	component = mbhc->component;
 
+	ret = pm_runtime_get_sync(component->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(component->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(component->dev);
+		return;
+	}
 	micbias_mv = wcd_mbhc_get_micbias(mbhc);
 	hs_threshold = wcd_mbhc_adc_get_hs_thres(mbhc);
 
@@ -1232,6 +1255,9 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 
 	if (mbhc->mbhc_cb->hph_pull_down_ctrl)
 		mbhc->mbhc_cb->hph_pull_down_ctrl(component, true);
+
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
 }
 
 static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
-- 
2.21.0

