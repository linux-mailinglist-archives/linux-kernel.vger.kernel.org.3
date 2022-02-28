Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9464C6FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiB1Ond (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiB1On3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:43:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1E2716E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:42:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d28so15844362wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeiJd2ZgJiYLQDAoicuBe5LbDBJMIUmRRu8Fz2FFrrY=;
        b=AWcnUSmR1nyOrs2af4OP9NZKhiPk9OK4hwjMbjIt+eWRCmyQ8LFIHpf+qFIcrnUUgb
         BCqlu/ThO7XS664ZJQqdOdiWx6EaTa8eGO6YHM8Cqqjk/dskiZ+AlQVfQiudj9bXnlif
         czcfbv9E1xGuT3vFGipmbSGOCttiqC+u6Xdnl9wPHTz7uSbyqDpFcmmrGPrVRi6WX+qN
         4d8CGrhAzQQjE94pzgtFObmlx3wE3OkuyKFacs8oFzMBCjrvB6jafvnes1oOpiDXAzRh
         1+si/nRLnsttkoXCmb1j4fntKSYHq4pcHs4l2C2lPy7E5uxQgYUEkBOMx/gWrnOGYPok
         homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeiJd2ZgJiYLQDAoicuBe5LbDBJMIUmRRu8Fz2FFrrY=;
        b=QOhOSZWrgNpwaYiOHaeHBwy2kUvGZHm3gCeJm7q/EQeWKdypxNIrIuFosxwZBN0oDV
         eD4XOVR7AF750y0sK3MTvHYjzGiBxaqSKxXkOwT1DvC32Gqtdm8dCvO7Z5VIUAVOTwFv
         pl/uUsonvlmb7XKGj9D0387O5TalnaDDeGoSiKPCJyBcMfLG0/GWY368lTaX13AvHqip
         TZITd0ehTOJ2LAe8s5YK3zk49cDB/lPaIgHmX9rFLif4FTBx6KONGQ/AKxA0+10wC2Dc
         ADBvL67VK0oQ2kYwL+ljV1vGyAtTWRl+IRXCsPCm5c6F81BMEl2LjXIvrir2LqQJy76j
         zMZg==
X-Gm-Message-State: AOAM531q15b8h7roPt5XeQ5vET8biU7q8K9VgpurQtWm2ZhBUvDf0hb3
        Zwne5jFDtVu3n0XBdXwI45JOkA==
X-Google-Smtp-Source: ABdhPJwiNyvayuILk4HidnUJ6aXnqMYeqhE/TX7K/qv04vfoCVYAD3RUQk2OEsWQ6V2SrGv27K2iOg==
X-Received: by 2002:adf:eb81:0:b0:1e3:2bf5:132 with SMTP id t1-20020adfeb81000000b001e32bf50132mr16412204wrn.246.1646059367227;
        Mon, 28 Feb 2022 06:42:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm14643724wmq.35.2022.02.28.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:42:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4] ASoC: codecs: wsa881x: add runtime pm support
Date:   Mon, 28 Feb 2022 14:42:35 +0000
Message-Id: <20220228144235.24208-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

WSA SoundWire Controller does not support Clock stop and performs a soft reset
on suspend  resume path. Its recommended that WSA881x codecs connected to this
are also reset using a hard reset during suspend resume.

So this codec driver performs a hard reset during suspend resume cycle.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v3:
	- added missing sign off.
	- no code changes


 sound/soc/codecs/wsa881x.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 0222370ff95d..616b26c70c3b 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -11,6 +11,7 @@
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw_type.h>
@@ -198,6 +199,7 @@
 #define WSA881X_OCP_CTL_TIMER_SEC 2
 #define WSA881X_OCP_CTL_TEMP_CELSIUS 25
 #define WSA881X_OCP_CTL_POLL_TIMER_SEC 60
+#define WSA881X_PROBE_TIMEOUT 1000
 
 #define WSA881X_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -747,6 +749,12 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 	unsigned int mask = (1 << fls(max)) - 1;
 	int val, ret, min_gain, max_gain;
 
+	ret = pm_runtime_get_sync(comp->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(comp->dev);
+		return ret;
+	}
+
 	max_gain = (max - ucontrol->value.integer.value[0]) & mask;
 	/*
 	 * Gain has to set incrementally in 4 steps
@@ -773,6 +781,9 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 		usleep_range(1000, 1010);
 	}
 
+	pm_runtime_mark_last_busy(comp->dev);
+	pm_runtime_put_autosuspend(comp->dev);
+
 	return 1;
 }
 
@@ -1101,6 +1112,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
 	struct wsa881x_priv *wsa881x;
+	struct device *dev = &pdev->dev;
 
 	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
 	if (!wsa881x)
@@ -1132,12 +1144,52 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 		return PTR_ERR(wsa881x->regmap);
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 					       &wsa881x_component_drv,
 					       wsa881x_dais,
 					       ARRAY_SIZE(wsa881x_dais));
 }
 
+static int __maybe_unused wsa881x_runtime_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
+
+	gpiod_direction_output(wsa881x->sd_n, 0);
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	return 0;
+}
+
+static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
+
+	gpiod_direction_output(wsa881x->sd_n, 1);
+
+	wait_for_completion_timeout(&slave->initialization_complete,
+				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
+
+	regcache_cache_only(regmap, false);
+	regcache_sync(regmap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops wsa881x_pm_ops = {
+	SET_RUNTIME_PM_OPS(wsa881x_runtime_suspend, wsa881x_runtime_resume, NULL)
+};
+
 static const struct sdw_device_id wsa881x_slave_id[] = {
 	SDW_SLAVE_ENTRY(0x0217, 0x2010, 0),
 	SDW_SLAVE_ENTRY(0x0217, 0x2110, 0),
@@ -1151,6 +1203,7 @@ static struct sdw_driver wsa881x_codec_driver = {
 	.id_table = wsa881x_slave_id,
 	.driver = {
 		.name	= "wsa881x-codec",
+		.pm = &wsa881x_pm_ops,
 	}
 };
 module_sdw_driver(wsa881x_codec_driver);
-- 
2.21.0

