Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461DB47EA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350968AbhLXCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:11:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:54157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350943AbhLXCLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640311876; x=1671847876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4wlCe70BRZKAkZaO8SjK9u4Vz9V4vUqESsniSLvQ5zI=;
  b=Q6LNoMyI/Uqj8c0EftQuDMGChrEMz/pCFWUwUFXdF7aNUqCDuvWaoiX0
   NwljZlVTe5F4q0IMq0c/+cWqAKpPy2TH2CHjraN0aYhAgBL2SGAt8pprD
   8PiYaYjTnHHPdcCRhsfgak1WFdxY6LnS1b3Il16qk/Do7ndqcLLdWaE8E
   jS6HHOww+duhqBkAX6dbuUfXHa7pWe8RqO/yPI20PXPm7oS9F7zJ78R9w
   MGOmDLH0vr+8+WuvVZWSgu7Nm2yByrdVQC3A5f0C+x+1jrJvgHnUV6qDi
   zbC2QTKNRA363AJ8bw8B+rzw+bI8+uGTv+EcIsAi0IOwSNAns8034APx6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="240715091"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="240715091"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="467156234"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:07 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 5/7] ASoC: Intel/SOF: use set_stream() instead of set_tdm_slots() for HDAudio
Date:   Fri, 24 Dec 2021 10:10:32 +0800
Message-Id: <20211224021034.26635-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
References: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Overloading the tx_mask with a linear value is asking for trouble and
only works because the codec_dai hw_params() is called before the
cpu_dai hw_params().

Move to the more generic set_stream() API to pass the hdac_stream
information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c       | 22 +++++++++++-----------
 sound/soc/intel/skylake/skl-pcm.c |  7 ++-----
 sound/soc/sof/intel/hda-dai.c     |  7 ++-----
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 390dd6c7f6a5..de5955db0a5f 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -46,9 +46,8 @@ static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai);
 static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai);
-static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
-				     unsigned int tx_mask, unsigned int rx_mask,
-				     int slots, int slot_width);
+static int hdac_hda_dai_set_stream(struct snd_soc_dai *dai, void *stream,
+				   int direction);
 static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 						 struct snd_soc_dai *dai);
 
@@ -58,7 +57,7 @@ static const struct snd_soc_dai_ops hdac_hda_dai_ops = {
 	.prepare = hdac_hda_dai_prepare,
 	.hw_params = hdac_hda_dai_hw_params,
 	.hw_free = hdac_hda_dai_hw_free,
-	.set_tdm_slot = hdac_hda_dai_set_tdm_slot,
+	.set_stream = hdac_hda_dai_set_stream,
 };
 
 static struct snd_soc_dai_driver hdac_hda_dais[] = {
@@ -180,21 +179,22 @@ static struct snd_soc_dai_driver hdac_hda_dais[] = {
 
 };
 
-static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
-				     unsigned int tx_mask, unsigned int rx_mask,
-				     int slots, int slot_width)
+static int hdac_hda_dai_set_stream(struct snd_soc_dai *dai,
+				   void *stream, int direction)
 {
 	struct snd_soc_component *component = dai->component;
 	struct hdac_hda_priv *hda_pvt;
 	struct hdac_hda_pcm *pcm;
+	struct hdac_stream *hstream;
+
+	if (!stream)
+		return -EINVAL;
 
 	hda_pvt = snd_soc_component_get_drvdata(component);
 	pcm = &hda_pvt->pcm[dai->id];
+	hstream = (struct hdac_stream *)stream;
 
-	if (tx_mask)
-		pcm->stream_tag[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
-	else
-		pcm->stream_tag[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+	pcm->stream_tag[direction] = hstream->stream_tag;
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 9ecaf6a1e847..8378c187959f 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -562,11 +562,8 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 
 	stream_tag = hdac_stream(link_dev)->stream_tag;
 
-	/* set the stream tag in the codec dai dma params  */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_dai_set_tdm_slot(codec_dai, stream_tag, 0, 0, 0);
-	else
-		snd_soc_dai_set_tdm_slot(codec_dai, 0, stream_tag, 0, 0);
+	/* set the hdac_stream in the codec dai */
+	snd_soc_dai_set_stream(codec_dai, hdac_stream(link_dev), substream->stream);
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 6381f2b227f0..cd12589355ef 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -243,11 +243,8 @@ static int hda_link_hw_params(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
-	/* set the stream tag in the codec dai dma params */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_dai_set_tdm_slot(codec_dai, stream_tag, 0, 0, 0);
-	else
-		snd_soc_dai_set_tdm_slot(codec_dai, 0, stream_tag, 0, 0);
+	/* set the hdac_stream in the codec dai */
+	snd_soc_dai_set_stream(codec_dai, hdac_stream(link_dev), substream->stream);
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
-- 
2.17.1

