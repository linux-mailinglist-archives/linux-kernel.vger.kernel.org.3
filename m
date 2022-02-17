Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEF4B98E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiBQGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:09:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiBQGJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:09:40 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A13C7E61;
        Wed, 16 Feb 2022 22:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645078162; x=1676614162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YRvyw7IXTdrWUvaK5GEuMMmToJGD4PGqLknrnBwepRk=;
  b=QV0HF6JPmikhVoLe9N3hoC9GXtJN3Pot0qfMKMU7PhRa0qtq7RXFTKeg
   WIUqEWcmf6T5EZAEGVwUBwBwjACOXgwhV8YScJ8D1ohfENtzXlMCueF8p
   MNr7O5BY7gQM3AGkK/rvmL6zPk5rmsR4QfBHrA8m07nLrtyVR/VLQCLjR
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 22:09:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:09:22 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 22:09:21 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 22:09:15 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v14 07/10] ASoC: qcom: Add support for codec dma driver
Date:   Thu, 17 Feb 2022 11:37:43 +0530
Message-ID: <1645078066-9365-8-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645078066-9365-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645078066-9365-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upadate lpass cpu and platform driver to support audio over codec dma
in ADSP bypass use case.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/qcom/lpass-cpu.c      |  67 +++++-
 sound/soc/qcom/lpass-platform.c | 486 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 535 insertions(+), 18 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 4fb9669..3b97d78 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1042,6 +1042,8 @@ static void of_lpass_cpu_parse_dai_data(struct device *dev,
 		}
 		if (id == LPASS_DP_RX) {
 			data->hdmi_port_enable = 1;
+		} else if (is_cdc_dma_port(id)) {
+			data->codec_dma_enable = 1;
 		} else {
 			data->mi2s_playback_sd_mode[id] =
 				of_lpass_cpu_parse_sd_lines(dev, node,
@@ -1053,10 +1055,33 @@ static void of_lpass_cpu_parse_dai_data(struct device *dev,
 	}
 }
 
+static int of_lpass_cdc_dma_clks_parse(struct device *dev,
+					struct lpass_data *data)
+{
+	data->codec_mem0 = devm_clk_get(dev, "audio_cc_codec_mem0");
+	if (IS_ERR(data->codec_mem0))
+		return PTR_ERR(data->codec_mem0);
+
+	data->codec_mem1 = devm_clk_get(dev, "audio_cc_codec_mem1");
+	if (IS_ERR(data->codec_mem1))
+		return PTR_ERR(data->codec_mem1);
+
+	data->codec_mem2 = devm_clk_get(dev, "audio_cc_codec_mem2");
+	if (IS_ERR(data->codec_mem2))
+		return PTR_ERR(data->codec_mem2);
+
+	data->va_mem0 = devm_clk_get(dev, "aon_cc_va_mem0");
+	if (IS_ERR(data->va_mem0))
+		return PTR_ERR(data->va_mem0);
+
+	return 0;
+}
+
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata;
 	struct device_node *dsp_of_node;
+	struct resource *res;
 	struct lpass_variant *variant;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
@@ -1082,6 +1107,46 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	of_lpass_cpu_parse_dai_data(dev, drvdata);
 
+	if (drvdata->codec_dma_enable) {
+		drvdata->rxtx_lpaif =
+				devm_platform_ioremap_resource_byname(pdev, "lpass-rxtx-lpaif");
+		if (IS_ERR(drvdata->rxtx_lpaif))
+			return PTR_ERR(drvdata->rxtx_lpaif);
+
+		drvdata->va_lpaif = devm_platform_ioremap_resource_byname(pdev, "lpass-va-lpaif");
+		if (IS_ERR(drvdata->va_lpaif))
+			return PTR_ERR(drvdata->va_lpaif);
+
+		lpass_rxtx_regmap_config.max_register = LPAIF_CDC_RXTX_WRDMAPER_REG(variant,
+					variant->rxtx_wrdma_channels +
+					variant->rxtx_wrdma_channel_start, LPASS_CDC_DMA_TX3);
+
+		drvdata->rxtx_lpaif_map = devm_regmap_init_mmio(dev, drvdata->rxtx_lpaif,
+					&lpass_rxtx_regmap_config);
+		if (IS_ERR(drvdata->rxtx_lpaif_map))
+			return PTR_ERR(drvdata->rxtx_lpaif_map);
+
+		lpass_va_regmap_config.max_register = LPAIF_CDC_VA_WRDMAPER_REG(variant,
+					variant->va_wrdma_channels +
+					variant->va_wrdma_channel_start, LPASS_CDC_DMA_VA_TX0);
+
+		drvdata->va_lpaif_map = devm_regmap_init_mmio(dev, drvdata->va_lpaif,
+					&lpass_va_regmap_config);
+		if (IS_ERR(drvdata->va_lpaif_map))
+			return PTR_ERR(drvdata->va_lpaif_map);
+
+		ret = of_lpass_cdc_dma_clks_parse(dev, drvdata);
+		if (ret) {
+			dev_err(dev, "failed to get cdc dma clocks %d\n", ret);
+			return ret;
+		}
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-rxtx-cdc-dma-lpm");
+		drvdata->rxtx_cdc_dma_lpm_buf = res->start;
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-va-cdc-dma-lpm");
+		drvdata->va_cdc_dma_lpm_buf = res->start;
+	}
 	drvdata->lpaif = devm_platform_ioremap_resource_byname(pdev, "lpass-lpaif");
 	if (IS_ERR(drvdata->lpaif))
 		return PTR_ERR(drvdata->lpaif);
@@ -1124,7 +1189,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	for (i = 0; i < variant->num_dai; i++) {
 		dai_id = variant->dai_driver[i].id;
-		if (dai_id == LPASS_DP_RX)
+		if (dai_id == LPASS_DP_RX || is_cdc_dma_port(dai_id))
 			continue;
 
 		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get_optional(dev,
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 74ddc3f..1907d6c 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -20,6 +20,9 @@
 
 #define LPASS_PLATFORM_BUFFER_SIZE	(24 *  2 * 1024)
 #define LPASS_PLATFORM_PERIODS		2
+#define LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE (8 * 1024)
+#define LPASS_VA_CDC_DMA_LPM_BUFF_SIZE (12 * 1024)
+#define LPASS_CDC_DMA_REGISTER_FIELDS_MAX 15
 
 static const struct snd_pcm_hardware lpass_platform_pcm_hardware = {
 	.info			=	SNDRV_PCM_INFO_MMAP |
@@ -45,6 +48,99 @@ static const struct snd_pcm_hardware lpass_platform_pcm_hardware = {
 	.fifo_size		=	0,
 };
 
+static const struct snd_pcm_hardware lpass_platform_rxtx_hardware = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_RESUME,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	SNDRV_PCM_RATE_8000_192000,
+	.rate_min		=	8000,
+	.rate_max		=	192000,
+	.channels_min		=	1,
+	.channels_max		=	8,
+	.buffer_bytes_max	=	LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE,
+	.period_bytes_max	=	LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE /
+						LPASS_PLATFORM_PERIODS,
+	.period_bytes_min	=	LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE /
+						LPASS_PLATFORM_PERIODS,
+	.periods_min		=	LPASS_PLATFORM_PERIODS,
+	.periods_max		=	LPASS_PLATFORM_PERIODS,
+	.fifo_size		=	0,
+};
+
+static const struct snd_pcm_hardware lpass_platform_va_hardware = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_RESUME,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	SNDRV_PCM_RATE_8000_192000,
+	.rate_min		=	8000,
+	.rate_max		=	192000,
+	.channels_min		=	1,
+	.channels_max		=	8,
+	.buffer_bytes_max	=	LPASS_VA_CDC_DMA_LPM_BUFF_SIZE,
+	.period_bytes_max	=	LPASS_VA_CDC_DMA_LPM_BUFF_SIZE /
+						LPASS_PLATFORM_PERIODS,
+	.period_bytes_min	=	LPASS_VA_CDC_DMA_LPM_BUFF_SIZE /
+						LPASS_PLATFORM_PERIODS,
+	.periods_min		=	LPASS_PLATFORM_PERIODS,
+	.periods_max		=	LPASS_PLATFORM_PERIODS,
+	.fifo_size		=	0,
+};
+
+static int lpass_platform_alloc_rxtx_dmactl_fields(struct device *dev,
+					 struct regmap *map)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
+	struct lpaif_dmactl *rd_dmactl, *wr_dmactl;
+	int rval;
+
+	rd_dmactl = devm_kzalloc(dev, sizeof(*rd_dmactl), GFP_KERNEL);
+	if (!rd_dmactl)
+		return -ENOMEM;
+
+	wr_dmactl = devm_kzalloc(dev, sizeof(*wr_dmactl), GFP_KERNEL);
+	if (!wr_dmactl)
+		return -ENOMEM;
+
+	drvdata->rxtx_rd_dmactl = rd_dmactl;
+	drvdata->rxtx_wr_dmactl = wr_dmactl;
+
+	rval = devm_regmap_field_bulk_alloc(dev, map, &rd_dmactl->intf,
+					    &v->rxtx_rdma_intf, LPASS_CDC_DMA_REGISTER_FIELDS_MAX);
+	if (rval)
+		return rval;
+
+	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->intf,
+					    &v->rxtx_wrdma_intf, LPASS_CDC_DMA_REGISTER_FIELDS_MAX);
+}
+
+static int lpass_platform_alloc_va_dmactl_fields(struct device *dev,
+					 struct regmap *map)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
+	struct lpaif_dmactl *wr_dmactl;
+
+	wr_dmactl = devm_kzalloc(dev, sizeof(*wr_dmactl), GFP_KERNEL);
+	if (!wr_dmactl)
+		return -ENOMEM;
+
+	drvdata->va_wr_dmactl = wr_dmactl;
+	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->intf,
+					    &v->va_wrdma_intf, LPASS_CDC_DMA_REGISTER_FIELDS_MAX);
+}
+
+
 static int lpass_platform_alloc_dmactl_fields(struct device *dev,
 					 struct regmap *map)
 {
@@ -123,25 +219,55 @@ static int lpass_platform_pcmops_open(struct snd_soc_component *component,
 		return dma_ch;
 	}
 
-	if (cpu_dai->driver->id == LPASS_DP_RX) {
-		map = drvdata->hdmiif_map;
-		drvdata->hdmi_substream[dma_ch] = substream;
-	} else {
+	switch (dai_id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
 		map = drvdata->lpaif_map;
 		drvdata->substream[dma_ch] = substream;
+		break;
+	case LPASS_DP_RX:
+		map = drvdata->hdmiif_map;
+		drvdata->hdmi_substream[dma_ch] = substream;
+		break;
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+		map = drvdata->rxtx_lpaif_map;
+		drvdata->rxtx_substream[dma_ch] = substream;
+		break;
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+		map = drvdata->va_lpaif_map;
+		drvdata->va_substream[dma_ch] = substream;
+		break;
+	default:
+		break;
 	}
+
 	data->dma_ch = dma_ch;
-	ret = regmap_write(map,
-			LPAIF_DMACTL_REG(v, dma_ch, dir, data->i2s_port), 0);
-	if (ret) {
-		dev_err(soc_runtime->dev,
-			"error writing to rdmactl reg: %d\n", ret);
-		return ret;
+	switch (dai_id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
+	case LPASS_DP_RX:
+		ret = regmap_write(map, LPAIF_DMACTL_REG(v, dma_ch, dir, data->i2s_port), 0);
+		if (ret) {
+			kfree(data);
+			dev_err(soc_runtime->dev, "error writing to rdmactl reg: %d\n", ret);
+			return ret;
+		}
+		snd_soc_set_runtime_hwparams(substream, &lpass_platform_pcm_hardware);
+		runtime->dma_bytes = lpass_platform_pcm_hardware.buffer_bytes_max;
+		break;
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+		snd_soc_set_runtime_hwparams(substream, &lpass_platform_rxtx_hardware);
+		runtime->dma_bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
+		snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+		break;
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+		snd_soc_set_runtime_hwparams(substream, &lpass_platform_va_hardware);
+		runtime->dma_bytes = lpass_platform_va_hardware.buffer_bytes_max;
+		snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+		break;
+	default:
+		break;
 	}
-	snd_soc_set_runtime_hwparams(substream, &lpass_platform_pcm_hardware);
-
-	runtime->dma_bytes = lpass_platform_pcm_hardware.buffer_bytes_max;
-
 	ret = snd_pcm_hw_constraint_integer(runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
@@ -166,10 +292,25 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
 	unsigned int dai_id = cpu_dai->driver->id;
 
 	data = runtime->private_data;
-	if (dai_id == LPASS_DP_RX)
-		drvdata->hdmi_substream[data->dma_ch] = NULL;
-	else
+
+	switch (dai_id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
 		drvdata->substream[data->dma_ch] = NULL;
+		break;
+	case LPASS_DP_RX:
+		drvdata->hdmi_substream[data->dma_ch] = NULL;
+		break;
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+		drvdata->rxtx_substream[data->dma_ch] = NULL;
+		break;
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+		drvdata->va_substream[data->dma_ch] = NULL;
+		break;
+	default:
+		break;
+	}
+
 	if (v->free_dma_channel)
 		v->free_dma_channel(drvdata, data->dma_ch, dai_id);
 
@@ -208,7 +349,23 @@ static void __lpass_get_lpaif_handle(const struct snd_pcm_substream *substream,
 		l_dmactl = drvdata->hdmi_rd_dmactl;
 		l_map = drvdata->hdmiif_map;
 		break;
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+		l_id = pcm_data->dma_ch;
+		l_dmactl = drvdata->rxtx_rd_dmactl;
+		l_map = drvdata->rxtx_lpaif_map;
+		break;
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+		l_id = pcm_data->dma_ch - v->rxtx_wrdma_channel_start;
+		l_dmactl = drvdata->rxtx_wr_dmactl;
+		l_map = drvdata->rxtx_lpaif_map;
+		break;
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+		l_id = pcm_data->dma_ch - v->va_wrdma_channel_start;
+		l_dmactl = drvdata->va_wr_dmactl;
+		l_map = drvdata->va_lpaif_map;
+		break;
 	}
+
 	if (dmactl)
 		*dmactl = l_dmactl;
 	if (id)
@@ -296,6 +453,10 @@ static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
 		}
 
 		break;
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX0:
+		break;
 	default:
 		dev_err(soc_runtime->dev, "%s: invalid  interface: %d\n", __func__, dai_id);
 		break;
@@ -384,6 +545,9 @@ static int lpass_platform_pcmops_hw_free(struct snd_soc_component *component,
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
+	if (is_cdc_dma_port(dai_id))
+		return 0;
+
 	__lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
 	if (!map) {
 		dev_err(soc_runtime->dev, "%s: failed to get dmactl handle\n", __func__);
@@ -446,6 +610,14 @@ static int lpass_platform_pcmops_prepare(struct snd_soc_component *component,
 		return ret;
 	}
 
+	if (is_cdc_dma_port(dai_id)) {
+		ret = regmap_fields_write(dmactl->fifowm, id, LPAIF_DMACTL_FIFOWM_8);
+		if (ret) {
+			dev_err(soc_runtime->dev, "error writing fifowm field to dmactl reg: %d, id: %d\n",
+				ret, id);
+			return ret;
+		}
+	}
 	ret = regmap_fields_write(dmactl->enable, id, LPAIF_DMACTL_ENABLE_ON);
 	if (ret) {
 		dev_err(soc_runtime->dev, "error writing to rdmactl reg: %d\n",
@@ -529,6 +701,35 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
 			val_mask = LPAIF_IRQ_ALL(ch);
 			val_irqen = LPAIF_IRQ_ALL(ch);
 			break;
+		case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+		case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+			ret = regmap_fields_write(dmactl->dyncclk, id, LPAIF_DMACTL_DYNCLK_ON);
+			if (ret) {
+				dev_err(soc_runtime->dev,
+					"error writing to rdmactl reg field: %d\n", ret);
+				return ret;
+			}
+			reg_irqclr = LPAIF_RXTX_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_irqclr = LPAIF_IRQ_ALL(ch);
+
+			reg_irqen = LPAIF_RXTX_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_mask = LPAIF_IRQ_ALL(ch);
+			val_irqen = LPAIF_IRQ_ALL(ch);
+			break;
+		case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+			ret = regmap_fields_write(dmactl->dyncclk, id, LPAIF_DMACTL_DYNCLK_ON);
+			if (ret) {
+				dev_err(soc_runtime->dev,
+					"error writing to rdmactl reg field: %d\n", ret);
+				return ret;
+			}
+			reg_irqclr = LPAIF_VA_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_irqclr = LPAIF_IRQ_ALL(ch);
+
+			reg_irqen = LPAIF_VA_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_mask = LPAIF_IRQ_ALL(ch);
+			val_irqen = LPAIF_IRQ_ALL(ch);
+			break;
 		default:
 			dev_err(soc_runtime->dev, "%s: invalid %d interface\n", __func__, dai_id);
 			return -EINVAL;
@@ -580,6 +781,37 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
 			val_mask = LPAIF_IRQ_ALL(ch);
 			val_irqen = 0;
 			break;
+		case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+		case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+			ret = regmap_fields_write(dmactl->dyncclk, id, LPAIF_DMACTL_DYNCLK_OFF);
+			if (ret) {
+				dev_err(soc_runtime->dev,
+					"error writing to rdmactl reg field: %d\n", ret);
+				return ret;
+			}
+
+			reg_irqclr = LPAIF_RXTX_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_irqclr = LPAIF_IRQ_ALL(ch);
+
+			reg_irqen = LPAIF_RXTX_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_mask = LPAIF_IRQ_ALL(ch);
+			val_irqen = LPAIF_IRQ_ALL(ch);
+			break;
+		case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+			ret = regmap_fields_write(dmactl->dyncclk, id, LPAIF_DMACTL_DYNCLK_OFF);
+			if (ret) {
+				dev_err(soc_runtime->dev,
+					"error writing to rdmactl reg field: %d\n", ret);
+				return ret;
+			}
+
+			reg_irqclr = LPAIF_VA_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_irqclr = LPAIF_IRQ_ALL(ch);
+
+			reg_irqen = LPAIF_VA_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST);
+			val_mask = LPAIF_IRQ_ALL(ch);
+			val_irqen = LPAIF_IRQ_ALL(ch);
+			break;
 		default:
 			dev_err(soc_runtime->dev, "%s: invalid %d interface\n", __func__, dai_id);
 			return -EINVAL;
@@ -639,6 +871,35 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	return bytes_to_frames(substream->runtime, curr_addr - base_addr);
 }
 
+static int lpass_platform_cdc_dma_mmap(struct snd_pcm_substream *substream,
+				       struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long size, offset;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	size = vma->vm_end - vma->vm_start;
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+	return io_remap_pfn_range(vma, vma->vm_start,
+			(runtime->dma_addr + offset) >> PAGE_SHIFT,
+			size, vma->vm_page_prot);
+
+}
+
+static int lpass_platform_pcmops_mmap(struct snd_soc_component *component,
+				      struct snd_pcm_substream *substream,
+				      struct vm_area_struct *vma)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	unsigned int dai_id = cpu_dai->driver->id;
+
+	if (is_cdc_dma_port(dai_id))
+		return lpass_platform_cdc_dma_mmap(substream, vma);
+
+	return snd_pcm_lib_default_mmap(substream, vma);
+}
+
 static irqreturn_t lpass_dma_interrupt_handler(
 			struct snd_pcm_substream *substream,
 			struct lpass_data *drvdata,
@@ -671,6 +932,17 @@ static irqreturn_t lpass_dma_interrupt_handler(
 		reg = LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
 		val = 0;
 	break;
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+		map = drvdata->rxtx_lpaif_map;
+		reg = LPAIF_RXTX_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
+		val = 0;
+	break;
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+		map = drvdata->va_lpaif_map;
+		reg = LPAIF_VA_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
+		val = 0;
+	break;
 	default:
 	dev_err(soc_runtime->dev, "%s: invalid  %d interface\n", __func__, dai_id);
 	return -EINVAL;
@@ -778,16 +1050,115 @@ static irqreturn_t lpass_platform_hdmiif_irq(int irq, void *data)
 				return rv;
 		}
 	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t lpass_platform_rxtxif_irq(int irq, void *data)
+{
+	struct lpass_data *drvdata = data;
+	struct lpass_variant *v = drvdata->variant;
+	unsigned int irqs;
+	irqreturn_t rv;
+	int chan;
+
+	rv = regmap_read(drvdata->rxtx_lpaif_map,
+			LPAIF_RXTX_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
+
+	/* Handle per channel interrupts */
+	for (chan = 0; chan < LPASS_MAX_CDC_DMA_CHANNELS; chan++) {
+		if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->rxtx_substream[chan]) {
+			rv = lpass_dma_interrupt_handler(
+						drvdata->rxtx_substream[chan],
+						drvdata, chan, irqs);
+			if (rv != IRQ_HANDLED)
+				return rv;
+		}
+	}
 
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t lpass_platform_vaif_irq(int irq, void *data)
+{
+	struct lpass_data *drvdata = data;
+	struct lpass_variant *v = drvdata->variant;
+	unsigned int irqs;
+	irqreturn_t rv;
+	int chan;
+
+	rv = regmap_read(drvdata->va_lpaif_map,
+			LPAIF_VA_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
+
+	/* Handle per channel interrupts */
+	for (chan = 0; chan < LPASS_MAX_VA_CDC_DMA_CHANNELS; chan++) {
+		if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->va_substream[chan]) {
+			rv = lpass_dma_interrupt_handler(
+						drvdata->va_substream[chan],
+						drvdata, chan, irqs);
+			if (rv != IRQ_HANDLED)
+				return rv;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static int lpass_platform_prealloc_cdc_dma_buffer(struct snd_soc_component *component,
+						  struct snd_pcm *pcm, int dai_id)
+{
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
+		substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	else
+		substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+
+	buf = &substream->dma_buffer;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	/* Assign Codec DMA buffer pointers */
+	buf->dev.type = SNDRV_DMA_TYPE_CONTINUOUS;
+
+	switch (dai_id) {
+	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
+		buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
+		buf->addr = drvdata->rxtx_cdc_dma_lpm_buf;
+		break;
+	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
+		buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
+		buf->addr = drvdata->rxtx_cdc_dma_lpm_buf + LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE;
+		break;
+	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
+		buf->bytes = lpass_platform_va_hardware.buffer_bytes_max;
+		buf->addr = drvdata->va_cdc_dma_lpm_buf;
+		break;
+	default:
+		break;
+	}
+
+	buf->area = (unsigned char * __force)ioremap(buf->addr, buf->bytes);
+
+	return 0;
+}
+
 static int lpass_platform_pcm_new(struct snd_soc_component *component,
 				  struct snd_soc_pcm_runtime *soc_runtime)
 {
 	struct snd_pcm *pcm = soc_runtime->pcm;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	unsigned int dai_id = cpu_dai->driver->id;
+
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
+	/*
+	 * Lpass codec dma can access only lpass lpm hardware memory.
+	 * ioremap is for HLOS to access hardware memory.
+	 */
+	if (is_cdc_dma_port(dai_id))
+		return lpass_platform_prealloc_cdc_dma_buffer(component, pcm, dai_id);
+
 	return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
 					    component->dev, size);
 }
@@ -824,6 +1195,31 @@ static int lpass_platform_pcmops_resume(struct snd_soc_component *component)
 	return regcache_sync(map);
 }
 
+static int lpass_platform_copy(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream, int channel,
+			       unsigned long pos, void __user *buf, unsigned long bytes)
+{
+	struct snd_pcm_runtime *rt = substream->runtime;
+	unsigned int dai_id = component->id;
+	int ret = 0;
+
+	void __iomem *dma_buf = (void __iomem *) (rt->dma_area + pos +
+				channel * (rt->dma_bytes / rt->channels));
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (is_cdc_dma_port(dai_id))
+			ret = copy_from_user_toio(dma_buf, buf, bytes);
+		else
+			ret = copy_from_user((void __force *)dma_buf, buf, bytes);
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (is_cdc_dma_port(dai_id))
+			ret = copy_to_user_fromio(buf, dma_buf, bytes);
+		else
+			ret = copy_to_user(buf, (void __force *)dma_buf, bytes);
+	}
+
+	return ret;
+}
 
 static const struct snd_soc_component_driver lpass_component_driver = {
 	.name		= DRV_NAME,
@@ -834,9 +1230,11 @@ static const struct snd_soc_component_driver lpass_component_driver = {
 	.prepare	= lpass_platform_pcmops_prepare,
 	.trigger	= lpass_platform_pcmops_trigger,
 	.pointer	= lpass_platform_pcmops_pointer,
+	.mmap		= lpass_platform_pcmops_mmap,
 	.pcm_construct	= lpass_platform_pcm_new,
 	.suspend		= lpass_platform_pcmops_suspend,
 	.resume			= lpass_platform_pcmops_resume,
+	.copy_user		= lpass_platform_copy,
 
 };
 
@@ -874,6 +1272,60 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (drvdata->codec_dma_enable) {
+		ret = regmap_write(drvdata->rxtx_lpaif_map,
+			LPAIF_RXTX_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0x0);
+		if (ret) {
+			dev_err(&pdev->dev, "error writing to rxtx irqen reg: %d\n", ret);
+			return ret;
+		}
+		ret = regmap_write(drvdata->va_lpaif_map,
+			LPAIF_VA_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0x0);
+		if (ret) {
+			dev_err(&pdev->dev, "error writing to rxtx irqen reg: %d\n", ret);
+			return ret;
+		}
+		drvdata->rxtxif_irq = platform_get_irq_byname(pdev, "lpass-irq-rxtxif");
+		if (drvdata->rxtxif_irq < 0)
+			return -ENODEV;
+
+		ret = devm_request_irq(&pdev->dev, drvdata->rxtxif_irq,
+				lpass_platform_rxtxif_irq, IRQF_TRIGGER_RISING,
+				"lpass-irq-rxtxif", drvdata);
+		if (ret) {
+			dev_err(&pdev->dev, "rxtx irq request failed: %d\n", ret);
+			return ret;
+		}
+
+		ret = lpass_platform_alloc_rxtx_dmactl_fields(&pdev->dev,
+						 drvdata->rxtx_lpaif_map);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"error initializing rxtx dmactl fields: %d\n", ret);
+			return ret;
+		}
+
+		drvdata->vaif_irq = platform_get_irq_byname(pdev, "lpass-irq-vaif");
+		if (drvdata->vaif_irq < 0)
+			return -ENODEV;
+
+		ret = devm_request_irq(&pdev->dev, drvdata->vaif_irq,
+				lpass_platform_vaif_irq, IRQF_TRIGGER_RISING,
+				"lpass-irq-vaif", drvdata);
+		if (ret) {
+			dev_err(&pdev->dev, "va irq request failed: %d\n", ret);
+			return ret;
+		}
+
+		ret = lpass_platform_alloc_va_dmactl_fields(&pdev->dev,
+						 drvdata->va_lpaif_map);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"error initializing va dmactl fields: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (drvdata->hdmi_port_enable) {
 		drvdata->hdmiif_irq = platform_get_irq_byname(pdev, "lpass-irq-hdmi");
 		if (drvdata->hdmiif_irq < 0)
-- 
2.7.4

