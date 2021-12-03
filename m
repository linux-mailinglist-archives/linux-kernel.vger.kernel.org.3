Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7ED467ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382001AbhLCQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:11:46 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:11939 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381998AbhLCQLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:11:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638547700; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Z8suxlhJNIMEoLMglFVJ80ldjqWZzPZV59v/2TjXn+Q=; b=wL8TaFZagDbBkI0V8CLk8B1S+jG7a3cm4dXkOPogylPQfNZnmRcHKxOxYWG6GxW/mUpk43B4
 +f1XI1qEXrdxd8ukMHZwUUbvvyL1mZJ8mXD2xYr8eH4ptO1KtGeRnEVjVOVsx2JQ6fcrETbb
 v4PIq3jNx1vjxeDhTYdJO5756f4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61aa40f4903341b2e44d6bbd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 16:08:20
 GMT
Sender: srivasam=codeaurora.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10A83C4363B; Fri,  3 Dec 2021 16:08:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 575EFC43638;
        Fri,  3 Dec 2021 16:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 575EFC43638
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.com
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: [PATCH v8 04/10] ASoC: qcom: Add helper function to get dma control and lpaif handle
Date:   Fri,  3 Dec 2021 21:37:32 +0530
Message-Id: <1638547658-22032-5-git-send-email-srivasam@codeaurora.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
References: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

Add support function to get dma control and lpaif handle to avoid
repeated code in platform driver

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 113 +++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 47 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a44162c..5d77240 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -177,6 +177,49 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
 	return 0;
 }
 
+static void __lpass_get_lpaif_handle(struct snd_pcm_substream *substream,
+				     struct snd_soc_component *component,
+				     struct lpaif_dmactl **dmactl, int *id, struct regmap **map)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
+	struct lpass_variant *v = drvdata->variant;
+	int dir = substream->stream;
+	unsigned int dai_id = cpu_dai->driver->id;
+	struct lpaif_dmactl *l_dmactl = NULL;
+	struct regmap *l_map = NULL;
+	int l_id = 0;
+
+	switch (dai_id) {
+	case MI2S_PRIMARY ... MI2S_QUINARY:
+		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+			l_id = pcm_data->dma_ch;
+			l_dmactl = drvdata->rd_dmactl;
+		} else {
+			l_dmactl = drvdata->wr_dmactl;
+			l_id = pcm_data->dma_ch - v->wrdma_channel_start;
+		}
+		l_map = drvdata->lpaif_map;
+		break;
+	case LPASS_DP_RX:
+		l_id = pcm_data->dma_ch;
+		l_dmactl = drvdata->hdmi_rd_dmactl;
+		l_map = drvdata->hdmiif_map;
+		break;
+	default:
+		break;
+	}
+	if (dmactl)
+		*dmactl = l_dmactl;
+	if (id)
+		*id = l_id;
+	if (map)
+		*map = l_map;
+}
+
 static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
 					   struct snd_pcm_substream *substream,
 					   struct snd_pcm_hw_params *params)
@@ -191,21 +234,15 @@ static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
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
+	__lpass_get_lpaif_handle(substream, component, &dmactl, &id, NULL);
+	if (!dmactl) {
+		dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
+		return -EINVAL;
 	}
 
 	bitwidth = snd_pcm_format_width(format);
@@ -350,10 +387,11 @@ static int lpass_platform_pcmops_hw_free(struct snd_soc_component *component,
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-	if (dai_id == LPASS_DP_RX)
-		map = drvdata->hdmiif_map;
-	else
-		map = drvdata->lpaif_map;
+	__lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
+	if (!map) {
+		dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
+		return -EINVAL;
+	}
 
 	reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream, dai_id);
 	ret = regmap_write(map, reg, 0);
@@ -379,22 +417,12 @@ static int lpass_platform_pcmops_prepare(struct snd_soc_component *component,
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
+	__lpass_get_lpaif_handle(substream, component, &dmactl, &id, &map);
+	if (!dmactl) {
+		dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
+		return -EINVAL;
 	}
 
 	ret = regmap_write(map, LPAIF_DMABASE_REG(v, ch, dir, dai_id),
@@ -444,25 +472,15 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
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
+	__lpass_get_lpaif_handle(substream, component, &dmactl, &id, &map);
+	if (!dmactl) {
+		dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
+		return -EINVAL;
 	}
 
 	switch (cmd) {
@@ -597,10 +615,11 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	struct regmap *map;
 	unsigned int dai_id = cpu_dai->driver->id;
 
-	if (dai_id == LPASS_DP_RX)
-		map = drvdata->hdmiif_map;
-	else
-		map = drvdata->lpaif_map;
+	__lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
+	if (!map) {
+		dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
+		return -EINVAL;
+	}
 
 	ch = pcm_data->dma_ch;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

