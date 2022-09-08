Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2F5B14AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIHGfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHGe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:34:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274640E09
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:34:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay12so10179846wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Gcq/MNox46vkVaOFbJDKt3RUNde615bJ744Z+6gObTw=;
        b=TTPySrZhHQaWxIJnpAMRoxqM5yadpuBWk8tg2sXAMUe8IC08fXf45jBQY/CgY2cOvc
         arIRcB50pk2gfo8fUQayZy5RdswZ33OtmRBloeA7NpSfKcJ9rO4ZZBVfN0F3JuJxe+Ys
         SiW2R3Rk1ZkD067eP+SFJBY8T01lq6KZoh6fGaIafJA3deRqG96BZmrDUdAJ+Tq/uR22
         0ERl2mf1z9Uqog8zmRxpIrKgUEHHQR8XMU/DfUrh+18uI8Q8aVS+Aw9ANYjp+9+WTk/0
         CNdHIEOX/CXojqH5Vve0khwpgUdV+wqUFr3DjIhm1+JubAqAPI9BC/3MZC6RjC+QxjpS
         Y5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Gcq/MNox46vkVaOFbJDKt3RUNde615bJ744Z+6gObTw=;
        b=IjRR8aZh84DBdzWvOrfuG8xj/AeJ0hF7Lx6PNZWT6gj/0V3kCz9NpmRiq7N4yG3KZo
         s2kGHTDuZ3VxLzkubeCaO/aw/hFcaKHBgPJnDpix9SI4AQUxPFZAiDTJo2hzLWLxtYWa
         fvGkjdBuoJpYKFyCKXo+S8LCIrAcst5UDOBoRnA30YTT49In8sEq/0WKx9G11qgYreS7
         QkSiVhze2/fd5xKqG6uIKqx9H/oU9oGnY4keCerZ4Pz3EaaljewXbTXN6nzpc4wnYTiV
         9pkStpNHVvnILlM+shwQXCTTFkiPNF+xxIO1apiseT3RNdYaftwhhJ05XQHLfJxR+0QO
         i1ZQ==
X-Gm-Message-State: ACgBeo3p3lYF6BdHgE5W3bWBw0W7x18greb+V0OOk5Q9Zy6x9OnmYQcX
        CAo2Uz7THL0SKHK1EnzFrayMAg==
X-Google-Smtp-Source: AA6agR4SBoaoNC1cBNOfkprBs16dlcsy/HK8h5wYhvlGpi70UIHS5UMx5qdCLL3g1LvRnwtw1lhQuQ==
X-Received: by 2002:a05:600c:22cd:b0:3a6:7b62:3778 with SMTP id 13-20020a05600c22cd00b003a67b623778mr1103454wmg.45.1662618895743;
        Wed, 07 Sep 2022 23:34:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003a2e92edeccsm1549598wmq.46.2022.09.07.23.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:34:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/4] ASoC: qcom: add machine driver for sc8280xp
Date:   Thu,  8 Sep 2022 07:34:48 +0100
Message-Id: <20220908063448.27102-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908063448.27102-1-srinivas.kandagatla@linaro.org>
References: <20220908063448.27102-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add machine driver for sc8280xp SoC.

This intial supports only includes WSA883x Speakers and WCD938x based headset.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig    |  11 +++
 sound/soc/qcom/Makefile   |   2 +
 sound/soc/qcom/sc8280xp.c | 157 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 sound/soc/qcom/sc8280xp.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 750653404ba3..d0e59e07b1fc 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -173,6 +173,17 @@ config SND_SOC_SM8250
 	  SM8250 SoC-based systems.
 	  Say Y if you want to use audio device on this SoCs.
 
+config SND_SOC_SC8280XP
+	tristate "SoC Machine driver for SC8280XP boards"
+	depends on QCOM_APR && SOUNDWIRE
+	depends on COMMON_CLK
+	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
+	help
+	  To add support for audio on Qualcomm Technologies Inc.
+	  SC8280XP SoC-based systems.
+	  Say Y if you want to use audio device on this SoCs.
+
 config SND_SOC_SC7180
 	tristate "SoC Machine driver for SC7180 boards"
 	depends on I2C && GPIOLIB
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 8b7b876899a8..8b97172cf990 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -26,6 +26,7 @@ snd-soc-sc7180-objs := sc7180.o
 snd-soc-sc7280-objs := sc7280.o
 snd-soc-sdm845-objs := sdm845.o
 snd-soc-sm8250-objs := sm8250.o
+snd-soc-sc8280xp-objs := sc8280xp.o
 snd-soc-qcom-common-objs := common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
@@ -33,6 +34,7 @@ obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
 obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
+obj-$(CONFIG_SND_SOC_SC8280XP) += snd-soc-sc8280xp.o
 obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
 obj-$(CONFIG_SND_SOC_SM8250) += snd-soc-sm8250.o
 obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
new file mode 100644
index 000000000000..ade44ad7c585
--- /dev/null
+++ b/sound/soc/qcom/sc8280xp.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2022, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <linux/soundwire/sdw.h>
+#include <sound/jack.h>
+#include <linux/input-event-codes.h>
+#include "qdsp6/q6afe.h"
+#include "common.h"
+
+#define DRIVER_NAME		"sc8280xp"
+
+struct sc8280xp_snd_data {
+	bool stream_prepared[AFE_PORT_MAX];
+	struct snd_soc_card *card;
+	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
+	struct snd_soc_jack jack;
+	bool jack_setup;
+};
+
+static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+
+	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
+}
+
+static int sc8280xp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = 2;
+	channels->max = 2;
+	switch (cpu_dai->id) {
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		channels->min = 1;
+		break;
+	default:
+		break;
+	}
+
+
+	return 0;
+}
+
+static int sc8280xp_snd_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
+
+	return qcom_snd_sdw_hw_params(substream, params, &pdata->sruntime[cpu_dai->id]);
+}
+
+static int sc8280xp_snd_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	return qcom_snd_sdw_prepare(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
+}
+
+static int sc8280xp_snd_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	return qcom_snd_sdw_hw_free(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
+}
+
+static const struct snd_soc_ops sc8280xp_be_ops = {
+	.hw_params = sc8280xp_snd_hw_params,
+	.hw_free = sc8280xp_snd_hw_free,
+	.prepare = sc8280xp_snd_prepare,
+};
+
+static void sc8280xp_add_be_ops(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link;
+	int i;
+
+	for_each_card_prelinks(card, i, link) {
+		if (link->no_pcm == 1) {
+			link->init = sc8280xp_snd_init;
+			link->be_hw_params_fixup = sc8280xp_be_hw_params_fixup;
+			link->ops = &sc8280xp_be_ops;
+		}
+	}
+}
+
+static int sc8280xp_platform_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card;
+	struct sc8280xp_snd_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+	card->owner = THIS_MODULE;
+	/* Allocate the private data */
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	card->dev = dev;
+	dev_set_drvdata(dev, card);
+	snd_soc_card_set_drvdata(card, data);
+	ret = qcom_snd_parse_of(card);
+	if (ret)
+		return ret;
+
+	card->driver_name = DRIVER_NAME;
+	sc8280xp_add_be_ops(card);
+	return devm_snd_soc_register_card(dev, card);
+}
+
+static const struct of_device_id snd_sc8280xp_dt_match[] = {
+	{.compatible = "qcom,sc8280xp-sndcard",},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, snd_sc8280xp_dt_match);
+
+static struct platform_driver snd_sc8280xp_driver = {
+	.probe  = sc8280xp_platform_probe,
+	.driver = {
+		.name = "snd-sc8280xp",
+		.of_match_table = snd_sc8280xp_dt_match,
+	},
+};
+module_platform_driver(snd_sc8280xp_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("SC8280XP ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

