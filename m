Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438AA4AD3CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351067AbiBHInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350872AbiBHImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:42:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69470C03FEC8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:42:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o2so6482669lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WW/JZAMcHGwsu/aVKbZpcWKcH0tV5XFvXiTi6TpD/iM=;
        b=s/dW6xKSwn0E1ynwQfrMtagbanfi8I/MD/YsKH4d1q/ZgoSq04BvtcEI8wkWcxb05v
         kkW1hhq7jtkkqJKM8XoBQUam6wxWwUXsC9GuqWwGorHmsRJaUVSQHqFR6yYc+dzOVM5o
         Gs1RNdnxm7CgqnNqX5dL3MWcktyVp1YVuYtbgIGOvPyVbjItwN/73aIFk9CymvENye7F
         zffWwXb/3TFSQrHmsTo97z/Q1R65+vRDVKMqxx/Ws5CLax/8MGSH7W7xEDElYnDuJ1xF
         ycHqVTCU/Pm3SWL7+OzymBJVQsYkWh7vb6LRoFusWYDfWYLrvpNCYEIDgzcZ+ZxF+LeR
         5SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WW/JZAMcHGwsu/aVKbZpcWKcH0tV5XFvXiTi6TpD/iM=;
        b=Lwy8mhxDgMD7WIsdNDlcCtjF2prAD7iJYWgHvDAL5RDvJ+uYIZbzSbXIVNH02Wn3yf
         UPPlLqazrY//+5xE/nqalq3ZjvlzeRBdlauV3z6qR2GfnIO4mUpPCitcczp59sVTE0cb
         9xv4/NRzZo7JOE/9rHDoFCdN92DMH8wR4exp3RXrXhXku7pudJ3NTcmykCvKMsKOA9Kt
         +84T2kLr+v7Z7MPK4UlyWCyoQ13Nzpm5hVHklk5tbows2YR/FZIFPFTSRYa5zl81cA2W
         rbihMLF4GZFl/O1xBJYYyfz0Q25tDJolfAk2YlG+ZHVAQ+eCnAsb0XDSqdHMgzih+Cc5
         L8og==
X-Gm-Message-State: AOAM533FyfyXo+YN3wac94ZkgF8MnlMl4pr7WeHYSv7YoHXj8zYw182+
        ZRPLTpsrZp4/hkDeEQE3J6CW5Q==
X-Google-Smtp-Source: ABdhPJxRogpGR1JTxiEnIH+idlt+2Csfb5uit/sYazWB9tshUteT6LOqweKxQThophAaMSV7PRVHJg==
X-Received: by 2002:a05:6512:3404:: with SMTP id i4mr2266933lfr.389.1644309763770;
        Tue, 08 Feb 2022 00:42:43 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id o12sm1830361lfu.96.2022.02.08.00.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:42:43 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 3/4] ASoC: pcm3168a: refactor format handling
Date:   Tue,  8 Feb 2022 11:42:19 +0300
Message-Id: <20220208084220.1289836-4-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
References: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- drop incomplete (not tdm-aware) calculation/setting of hardware
  fmt value from pcm3168a_set_dai_fmt(); instead, store original
  SND_SOC_DAIFMT* setting in io_params

- in pcm3168a_hw_params(), do all checks in terms of SND_SOC_DAIFMT*,
  and convert that to register bitfield values only to write to
  hardware

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/pcm3168a.c | 84 ++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 526e4562ccb5..1d3821f2c5f1 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -50,7 +50,7 @@ static const char *const pcm3168a_supply_names[PCM3168A_NUM_SUPPLIES] = {
 /* ADC/DAC side parameters */
 struct pcm3168a_io_params {
 	bool master_mode;
-	unsigned int fmt;
+	unsigned int format;
 	int tdm_slots;
 	u32 tdm_mask;
 	int slot_width;
@@ -328,10 +328,11 @@ static void pcm3168a_update_fixup_pcm_stream(struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
+	struct pcm3168a_io_params *io_params = &pcm3168a->io_params[dai->id];
 	u64 formats = SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE;
 	unsigned int channel_max = dai->id == PCM3168A_DAI_DAC ? 8 : 6;
 
-	if (pcm3168a->io_params[dai->id].fmt == PCM3168A_FMT_RIGHT_J) {
+	if (io_params->format == SND_SOC_DAIFMT_RIGHT_J) {
 		/* S16_LE is only supported in RIGHT_J mode */
 		formats |= SNDRV_PCM_FMTBIT_S16_LE;
 
@@ -339,7 +340,7 @@ static void pcm3168a_update_fixup_pcm_stream(struct snd_soc_dai *dai)
 		 * If multi DIN/DOUT is not selected, RIGHT_J can only support
 		 * two channels (no TDM support)
 		 */
-		if (pcm3168a->io_params[dai->id].tdm_slots != 2)
+		if (io_params->tdm_slots != 2)
 			channel_max = 2;
 	}
 
@@ -356,24 +357,15 @@ static int pcm3168a_set_dai_fmt(struct snd_soc_dai *dai, unsigned int format)
 {
 	struct snd_soc_component *component = dai->component;
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
-	u32 fmt, reg, mask, shift;
+	struct pcm3168a_io_params *io_params = &pcm3168a->io_params[dai->id];
 	bool master_mode;
 
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_LEFT_J:
-		fmt = PCM3168A_FMT_LEFT_J;
-		break;
 	case SND_SOC_DAIFMT_I2S:
-		fmt = PCM3168A_FMT_I2S;
-		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		fmt = PCM3168A_FMT_RIGHT_J;
-		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		fmt = PCM3168A_FMT_DSP_A;
-		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		fmt = PCM3168A_FMT_DSP_B;
 		break;
 	default:
 		dev_err(component->dev, "unsupported dai format\n");
@@ -399,20 +391,8 @@ static int pcm3168a_set_dai_fmt(struct snd_soc_dai *dai, unsigned int format)
 		return -EINVAL;
 	}
 
-	if (dai->id == PCM3168A_DAI_DAC) {
-		reg = PCM3168A_DAC_PWR_MST_FMT;
-		mask = PCM3168A_DAC_FMT_MASK;
-		shift = PCM3168A_DAC_FMT_SHIFT;
-	} else {
-		reg = PCM3168A_ADC_MST_FMT;
-		mask = PCM3168A_ADC_FMTAD_MASK;
-		shift = PCM3168A_ADC_FMTAD_SHIFT;
-	}
-
-	pcm3168a->io_params[dai->id].master_mode = master_mode;
-	pcm3168a->io_params[dai->id].fmt = fmt;
-
-	regmap_update_bits(pcm3168a->regmap, reg, mask, fmt << shift);
+	io_params->master_mode = master_mode;
+	io_params->format = format & SND_SOC_DAIFMT_FORMAT_MASK;
 
 	pcm3168a_update_fixup_pcm_stream(dai);
 
@@ -461,7 +441,8 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
 	struct pcm3168a_io_params *io_params = &pcm3168a->io_params[dai->id];
-	bool master_mode;
+	bool master_mode, tdm_mode;
+	unsigned int format;
 	unsigned int reg, mask, ms, ms_shift, fmt, fmt_shift, ratio, tdm_slots;
 	int i, num_scki_ratios, slot_width;
 
@@ -499,7 +480,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		ms = 0;
 	}
 
-	fmt = io_params->fmt;
+	format = io_params->format;
 
 	if (io_params->slot_width)
 		slot_width = io_params->slot_width;
@@ -508,15 +489,14 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 
 	switch (slot_width) {
 	case 16:
-		if (master_mode || (fmt != PCM3168A_FMT_RIGHT_J)) {
+		if (master_mode || (format != SND_SOC_DAIFMT_RIGHT_J)) {
 			dev_err(component->dev, "16-bit slots are supported only for slave mode using right justified\n");
 			return -EINVAL;
 		}
-		fmt = PCM3168A_FMT_RIGHT_J_16;
 		break;
 	case 24:
-		if (master_mode || (fmt == PCM3168A_FMT_DSP_A) ||
-				   (fmt == PCM3168A_FMT_DSP_B)) {
+		if (master_mode || (format == SND_SOC_DAIFMT_DSP_A) ||
+				   (format == SND_SOC_DAIFMT_DSP_B)) {
 			dev_err(component->dev, "24-bit slots not supported in master mode, or slave mode using DSP\n");
 			return -EINVAL;
 		}
@@ -541,15 +521,14 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	 * If pcm3168a->tdm_slots is set to 2 then DIN1/2/3/4 and DOUT1/2/3 is
 	 * used in normal mode, no need to switch to TDM modes.
 	 */
-	if (tdm_slots > 2) {
-		switch (fmt) {
-		case PCM3168A_FMT_I2S:
-		case PCM3168A_FMT_DSP_A:
-			fmt = PCM3168A_FMT_I2S_TDM;
-			break;
-		case PCM3168A_FMT_LEFT_J:
-		case PCM3168A_FMT_DSP_B:
-			fmt = PCM3168A_FMT_LEFT_J_TDM;
+	tdm_mode = (tdm_slots > 2);
+
+	if (tdm_mode) {
+		switch (format) {
+		case SND_SOC_DAIFMT_I2S:
+		case SND_SOC_DAIFMT_DSP_A:
+		case SND_SOC_DAIFMT_LEFT_J:
+		case SND_SOC_DAIFMT_DSP_B:
 			break;
 		default:
 			dev_err(component->dev,
@@ -558,6 +537,27 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	switch (format) {
+	case SND_SOC_DAIFMT_I2S:
+		fmt = tdm_mode ? PCM3168A_FMT_I2S_TDM : PCM3168A_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		fmt = tdm_mode ? PCM3168A_FMT_LEFT_J_TDM : PCM3168A_FMT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		fmt = (slot_width == 16) ? PCM3168A_FMT_RIGHT_J_16 :
+					   PCM3168A_FMT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		fmt = tdm_mode ? PCM3168A_FMT_I2S_TDM : PCM3168A_FMT_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		fmt = tdm_mode ? PCM3168A_FMT_LEFT_J_TDM : PCM3168A_FMT_DSP_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	regmap_update_bits(pcm3168a->regmap, reg, mask,
 			(ms << ms_shift) | (fmt << fmt_shift));
 
-- 
2.30.2

