Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D54C2FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiBXPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiBXPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:34:55 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E71C60D7;
        Thu, 24 Feb 2022 07:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645716864; x=1677252864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dUEPjmxzsrMxtRZWNBWhoUxQyq9/D11CrdSJdyCDlbk=;
  b=aaKAWB33ua8Sdl3PCEiftPXr3Kz5YX5qhM/PbiIf1b9XgOEcMMBlfIIz
   rEJezl/2DHQIVZE7aLA85c6089Tmwfj2c+t8CkRV8RYF7bdR4QIrEOfJN
   5ngVWqp52us2xansOT2aXYfMbXHtL/z3uoEkNl5jb3cwtQ/Fmzkuj0fcd
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Feb 2022 07:34:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:34:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 07:34:23 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 07:34:17 -0800
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
Subject: [PATCH v16 3/9] ASoC: qcom: Add helper function to get dma control and lpaif handle
Date:   Thu, 24 Feb 2022 21:03:42 +0530
Message-ID: <1645716828-15305-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645716828-15305-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645716828-15305-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support function to get dma control and lpaif handle to avoid
repeated code in platform driver

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 131 ++++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 51 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a44162c..198f27c 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -177,6 +177,75 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
 	return 0;
 }
 
+static struct lpaif_dmactl *__lpass_get_dmactl_handle(const struct snd_pcm_substream *substream,
+				     struct snd_soc_component *component)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
+	struct lpaif_dmactl *dmactl = NULL;
+
+	switch (cpu_dai->driver->id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			dmactl = drvdata->rd_dmactl;
+		else
+			dmactl = drvdata->wr_dmactl;
+		break;
+	case LPASS_DP_RX:
+		dmactl = drvdata->hdmi_rd_dmactl;
+		break;
+	}
+
+	return dmactl;
+}
+
+static int __lpass_get_id(const struct snd_pcm_substream *substream,
+				     struct snd_soc_component *component)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
+	struct lpass_variant *v = drvdata->variant;
+	int id;
+
+	switch (cpu_dai->driver->id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			id = pcm_data->dma_ch;
+		else
+			id = pcm_data->dma_ch - v->wrdma_channel_start;
+		break;
+	case LPASS_DP_RX:
+		id = pcm_data->dma_ch;
+		break;
+	}
+
+	return id;
+}
+
+static struct regmap *__lpass_get_regmap_handle(const struct snd_pcm_substream *substream,
+				     struct snd_soc_component *component)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
+	struct regmap *map = NULL;
+
+	switch (cpu_dai->driver->id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
+		map = drvdata->lpaif_map;
+		break;
+	case LPASS_DP_RX:
+		map = drvdata->hdmiif_map;
+		break;
+	}
+
+	return map;
+}
+
 static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
 					   struct snd_pcm_substream *substream,
 					   struct snd_pcm_hw_params *params)
@@ -191,22 +260,13 @@ static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
 	struct lpaif_dmactl *dmactl;
-	int id, dir = substream->stream;
+	int id;
 	int bitwidth;
 	int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
-		id = pcm_data->dma_ch;
-		if (dai_id == LPASS_DP_RX)
-			dmactl = drvdata->hdmi_rd_dmactl;
-		else
-			dmactl = drvdata->rd_dmactl;
-
-	} else {
-		dmactl = drvdata->wr_dmactl;
-		id = pcm_data->dma_ch - v->wrdma_channel_start;
-	}
+	dmactl = __lpass_get_dmactl_handle(substream, component);
+	id = __lpass_get_id(substream, component);
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -350,10 +410,7 @@ static int lpass_platform_pcmops_hw_free(struct snd_soc_component *component,
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-	if (dai_id == LPASS_DP_RX)
-		map = drvdata->hdmiif_map;
-	else
-		map = drvdata->lpaif_map;
+	map = __lpass_get_regmap_handle(substream, component);
 
 	reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream, dai_id);
 	ret = regmap_write(map, reg, 0);
@@ -379,23 +436,11 @@ static int lpass_platform_pcmops_prepare(struct snd_soc_component *component,
 	int ret, id, ch, dir = substream->stream;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-
 	ch = pcm_data->dma_ch;
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dai_id == LPASS_DP_RX) {
-			dmactl = drvdata->hdmi_rd_dmactl;
-			map = drvdata->hdmiif_map;
-		} else {
-			dmactl = drvdata->rd_dmactl;
-			map = drvdata->lpaif_map;
-		}
 
-		id = pcm_data->dma_ch;
-	} else {
-		dmactl = drvdata->wr_dmactl;
-		id = pcm_data->dma_ch - v->wrdma_channel_start;
-		map = drvdata->lpaif_map;
-	}
+	dmactl = __lpass_get_dmactl_handle(substream, component);
+	id = __lpass_get_id(substream, component);
+	map = __lpass_get_regmap_handle(substream, component);
 
 	ret = regmap_write(map, LPAIF_DMABASE_REG(v, ch, dir, dai_id),
 				runtime->dma_addr);
@@ -444,26 +489,14 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
 	struct lpaif_dmactl *dmactl;
 	struct regmap *map;
 	int ret, ch, id;
-	int dir = substream->stream;
 	unsigned int reg_irqclr = 0, val_irqclr = 0;
 	unsigned int  reg_irqen = 0, val_irqen = 0, val_mask = 0;
 	unsigned int dai_id = cpu_dai->driver->id;
 
 	ch = pcm_data->dma_ch;
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
-		id = pcm_data->dma_ch;
-		if (dai_id == LPASS_DP_RX) {
-			dmactl = drvdata->hdmi_rd_dmactl;
-			map = drvdata->hdmiif_map;
-		} else {
-			dmactl = drvdata->rd_dmactl;
-			map = drvdata->lpaif_map;
-		}
-	} else {
-		dmactl = drvdata->wr_dmactl;
-		id = pcm_data->dma_ch - v->wrdma_channel_start;
-		map = drvdata->lpaif_map;
-	}
+	dmactl = __lpass_get_dmactl_handle(substream, component);
+	id = __lpass_get_id(substream, component);
+	map = __lpass_get_regmap_handle(substream, component);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -597,11 +630,7 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-	if (dai_id == LPASS_DP_RX)
-		map = drvdata->hdmiif_map;
-	else
-		map = drvdata->lpaif_map;
-
+	map = __lpass_get_regmap_handle(substream, component);
 	ch = pcm_data->dma_ch;
 
 	ret = regmap_read(map,
-- 
2.7.4

