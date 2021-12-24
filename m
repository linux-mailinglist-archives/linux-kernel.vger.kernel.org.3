Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAF47EA7E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351002AbhLXCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:11:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:54155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350942AbhLXCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640311877; x=1671847877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WoY6tgpHDngkFOSzrHpZDUtxXnt3fGuJlAcVU+z1ZbE=;
  b=X14i+825f2J1OnzrRzvOEJyUscdpIcEq4Vmi+y6RQKqWYROcwjDWLX/w
   b+VYORILwXU0DeEMiOWbTwGYouqagrmbUzP0DCv76e3f7B0PnAeSLIF03
   p5FR4C/brX36ob8l1fRHcdKHB+1xUELVqpzNhOTOx3bfH8PBVX2rMeoDK
   /wA9R2w/79+XMVEOGYVlVATpGTHOy1IO2WJZJ2SZWTEnLaR5DGQ01yx9e
   grXCdPsmI8fLHE/JFHwwdd63hbu69JWUZXsKgOE87pgA3dPkKk/Omh5pv
   UEtXVgWRjFYpmLpxo+Z1E+/B9WXB9RP3KhIJ9bS9eGcgZnQkm7VammTHj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="240715088"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="240715088"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="467156231"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:04 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 4/7] ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire
Date:   Fri, 24 Dec 2021 10:10:31 +0800
Message-Id: <20211224021034.26635-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
References: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The HDAudio ASoC support relies on the set_tdm_slots() helper to store
the HDaudio stream tag in the tx_mask. This only works because of the
pre-existing order in soc-pcm.c, where the hw_params() is handled for
codec_dais *before* cpu_dais. When the order is reversed, the
stream_tag is used as a mask in the codec fixup functions:

	/* fixup params based on TDM slot masks */
	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
	    codec_dai->tx_mask)
		soc_pcm_codec_params_fixup(&codec_params,
					   codec_dai->tx_mask);

As a result of this confusion, the codec_params_fixup() ends-up
generating bad channel masks, depending on what stream_tag was
allocated.

We could add a flag to state that the tx_mask is really not a mask,
but it would be quite ugly to persist in overloading concepts.

Instead, this patch suggests a more generic get/set 'stream' API based
on the existing model for SoundWire. We can expand the concept to
store 'stream' opaque information that is specific to different DAI
types. In the case of HDAudio DAIs, we only need to store a stream tag
as an unsigned char pointer. The TDM rx_ and tx_masks should really
only be used to store masks.

Rename get_sdw_stream/set_sdw_stream callbacks and helpers as
get_stream/set_stream. No functionality change beyond the rename.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel.c        |  8 ++++----
 drivers/soundwire/qcom.c         |  8 ++++----
 drivers/soundwire/stream.c       |  4 ++--
 include/sound/soc-dai.h          | 32 ++++++++++++++++----------------
 sound/soc/codecs/max98373-sdw.c  |  2 +-
 sound/soc/codecs/rt1308-sdw.c    |  2 +-
 sound/soc/codecs/rt1316-sdw.c    |  2 +-
 sound/soc/codecs/rt5682-sdw.c    |  2 +-
 sound/soc/codecs/rt700.c         |  2 +-
 sound/soc/codecs/rt711-sdca.c    |  2 +-
 sound/soc/codecs/rt711.c         |  2 +-
 sound/soc/codecs/rt715-sdca.c    |  2 +-
 sound/soc/codecs/rt715.c         |  2 +-
 sound/soc/codecs/sdw-mockup.c    |  2 +-
 sound/soc/codecs/wcd938x.c       |  2 +-
 sound/soc/codecs/wsa881x.c       |  2 +-
 sound/soc/intel/boards/sof_sdw.c |  6 +++---
 sound/soc/qcom/sdm845.c          |  4 ++--
 sound/soc/qcom/sm8250.c          |  4 ++--
 19 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3d29f02ad5a6..70d164372a2b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1129,8 +1129,8 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_free = intel_hw_free,
 	.trigger = intel_trigger,
 	.shutdown = intel_shutdown,
-	.set_sdw_stream = intel_pcm_set_sdw_stream,
-	.get_sdw_stream = intel_get_sdw_stream,
+	.set_stream = intel_pcm_set_sdw_stream,
+	.get_stream = intel_get_sdw_stream,
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
@@ -1139,8 +1139,8 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
-	.set_sdw_stream = intel_pdm_set_sdw_stream,
-	.get_sdw_stream = intel_get_sdw_stream,
+	.set_stream = intel_pdm_set_sdw_stream,
+	.get_stream = intel_get_sdw_stream,
 };
 
 static const struct snd_soc_component_driver dai_component = {
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index a317bea2d42d..9d42891ac3d6 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1024,8 +1024,8 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	ctrl->sruntime[dai->id] = sruntime;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		ret = snd_soc_dai_set_sdw_stream(codec_dai, sruntime,
-						 substream->stream);
+		ret = snd_soc_dai_set_stream(codec_dai, sruntime,
+					     substream->stream);
 		if (ret < 0 && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "Failed to set sdw stream on %s\n",
 				codec_dai->name);
@@ -1051,8 +1051,8 @@ static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
 	.hw_free = qcom_swrm_hw_free,
 	.startup = qcom_swrm_startup,
 	.shutdown = qcom_swrm_shutdown,
-	.set_sdw_stream = qcom_swrm_set_sdw_stream,
-	.get_sdw_stream = qcom_swrm_get_sdw_stream,
+	.set_stream = qcom_swrm_set_sdw_stream,
+	.get_stream = qcom_swrm_get_sdw_stream,
 };
 
 static const struct snd_soc_component_driver qcom_swrm_dai_component = {
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 5d4f6b308ef7..980f26d49b66 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1863,7 +1863,7 @@ static int set_stream(struct snd_pcm_substream *substream,
 
 	/* Set stream pointer on all DAIs */
 	for_each_rtd_dais(rtd, i, dai) {
-		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
+		ret = snd_soc_dai_set_stream(dai, sdw_stream, substream->stream);
 		if (ret < 0) {
 			dev_err(rtd->dev, "failed to set stream pointer on dai %s\n", dai->name);
 			break;
@@ -1934,7 +1934,7 @@ void sdw_shutdown_stream(void *sdw_substream)
 	/* Find stream from first CPU DAI */
 	dai = asoc_rtd_to_cpu(rtd, 0);
 
-	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+	sdw_stream = snd_soc_dai_get_stream(dai, substream->stream);
 
 	if (IS_ERR(sdw_stream)) {
 		dev_err(rtd->dev, "no stream found for DAI %s\n", dai->name);
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 5d4dd7c5450b..bbd821d2df9c 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -295,9 +295,9 @@ struct snd_soc_dai_ops {
 			unsigned int *rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
-	int (*set_sdw_stream)(struct snd_soc_dai *dai,
-			void *stream, int direction);
-	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
+	int (*set_stream)(struct snd_soc_dai *dai,
+			  void *stream, int direction);
+	void *(*get_stream)(struct snd_soc_dai *dai, int direction);
 
 	/*
 	 * DAI digital mute - optional.
@@ -515,42 +515,42 @@ static inline void *snd_soc_dai_get_drvdata(struct snd_soc_dai *dai)
 }
 
 /**
- * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
+ * snd_soc_dai_set_stream() - Configures a DAI for stream operation
  * @dai: DAI
- * @stream: STREAM
+ * @stream: STREAM (opaque structure depending on DAI type)
  * @direction: Stream direction(Playback/Capture)
- * SoundWire subsystem doesn't have a notion of direction and we reuse
+ * Some subsystems, such as SoundWire, don't have a notion of direction and we reuse
  * the ASoC stream direction to configure sink/source ports.
  * Playback maps to source ports and Capture for sink ports.
  *
  * This should be invoked with NULL to clear the stream set previously.
  * Returns 0 on success, a negative error code otherwise.
  */
-static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
-				void *stream, int direction)
+static inline int snd_soc_dai_set_stream(struct snd_soc_dai *dai,
+					 void *stream, int direction)
 {
-	if (dai->driver->ops->set_sdw_stream)
-		return dai->driver->ops->set_sdw_stream(dai, stream, direction);
+	if (dai->driver->ops->set_stream)
+		return dai->driver->ops->set_stream(dai, stream, direction);
 	else
 		return -ENOTSUPP;
 }
 
 /**
- * snd_soc_dai_get_sdw_stream() - Retrieves SDW stream from DAI
+ * snd_soc_dai_get_stream() - Retrieves stream from DAI
  * @dai: DAI
  * @direction: Stream direction(Playback/Capture)
  *
  * This routine only retrieves that was previously configured
- * with snd_soc_dai_get_sdw_stream()
+ * with snd_soc_dai_get_stream()
  *
  * Returns pointer to stream or an ERR_PTR value, e.g.
  * ERR_PTR(-ENOTSUPP) if callback is not supported;
  */
-static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
-					       int direction)
+static inline void *snd_soc_dai_get_stream(struct snd_soc_dai *dai,
+					   int direction)
 {
-	if (dai->driver->ops->get_sdw_stream)
-		return dai->driver->ops->get_sdw_stream(dai, direction);
+	if (dai->driver->ops->get_stream)
+		return dai->driver->ops->get_stream(dai, direction);
 	else
 		return ERR_PTR(-ENOTSUPP);
 }
diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index dc520effc61c..f47e956d4f55 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -741,7 +741,7 @@ static int max98373_sdw_set_tdm_slot(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops max98373_dai_sdw_ops = {
 	.hw_params = max98373_sdw_dai_hw_params,
 	.hw_free = max98373_pcm_hw_free,
-	.set_sdw_stream = max98373_set_sdw_stream,
+	.set_stream = max98373_set_sdw_stream,
 	.shutdown = max98373_shutdown,
 	.set_tdm_slot = max98373_sdw_set_tdm_slot,
 };
diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index f716668de640..149a76075c76 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -613,7 +613,7 @@ static const struct snd_soc_component_driver soc_component_sdw_rt1308 = {
 static const struct snd_soc_dai_ops rt1308_aif_dai_ops = {
 	.hw_params = rt1308_sdw_hw_params,
 	.hw_free	= rt1308_sdw_pcm_hw_free,
-	.set_sdw_stream	= rt1308_set_sdw_stream,
+	.set_stream	= rt1308_set_sdw_stream,
 	.shutdown	= rt1308_sdw_shutdown,
 	.set_tdm_slot	= rt1308_sdw_set_tdm_slot,
 };
diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index 09b4914bba1b..c66d7b20cb4d 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -602,7 +602,7 @@ static const struct snd_soc_component_driver soc_component_sdw_rt1316 = {
 static const struct snd_soc_dai_ops rt1316_aif_dai_ops = {
 	.hw_params = rt1316_sdw_hw_params,
 	.hw_free	= rt1316_sdw_pcm_hw_free,
-	.set_sdw_stream	= rt1316_set_sdw_stream,
+	.set_stream	= rt1316_set_sdw_stream,
 	.shutdown	= rt1316_sdw_shutdown,
 };
 
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 31a4f286043e..248257a2e4e0 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -272,7 +272,7 @@ static int rt5682_sdw_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops rt5682_sdw_ops = {
 	.hw_params	= rt5682_sdw_hw_params,
 	.hw_free	= rt5682_sdw_hw_free,
-	.set_sdw_stream	= rt5682_set_sdw_stream,
+	.set_stream	= rt5682_set_sdw_stream,
 	.shutdown	= rt5682_sdw_shutdown,
 };
 
diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index 921382724f9c..e61a8257bf64 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -1005,7 +1005,7 @@ static int rt700_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops rt700_ops = {
 	.hw_params	= rt700_pcm_hw_params,
 	.hw_free	= rt700_pcm_hw_free,
-	.set_sdw_stream	= rt700_set_sdw_stream,
+	.set_stream	= rt700_set_sdw_stream,
 	.shutdown	= rt700_shutdown,
 };
 
diff --git a/sound/soc/codecs/rt711-sdca.c b/sound/soc/codecs/rt711-sdca.c
index 2e992589f1e4..bdb1375f0338 100644
--- a/sound/soc/codecs/rt711-sdca.c
+++ b/sound/soc/codecs/rt711-sdca.c
@@ -1358,7 +1358,7 @@ static int rt711_sdca_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops rt711_sdca_ops = {
 	.hw_params	= rt711_sdca_pcm_hw_params,
 	.hw_free	= rt711_sdca_pcm_hw_free,
-	.set_sdw_stream	= rt711_sdca_set_sdw_stream,
+	.set_stream	= rt711_sdca_set_sdw_stream,
 	.shutdown	= rt711_sdca_shutdown,
 };
 
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index a7c5608a0ef8..6770825d037a 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -1089,7 +1089,7 @@ static int rt711_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops rt711_ops = {
 	.hw_params	= rt711_pcm_hw_params,
 	.hw_free	= rt711_pcm_hw_free,
-	.set_sdw_stream	= rt711_set_sdw_stream,
+	.set_stream	= rt711_set_sdw_stream,
 	.shutdown	= rt711_shutdown,
 };
 
diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 66e166568c50..bfa536bd7196 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -938,7 +938,7 @@ static int rt715_sdca_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops rt715_sdca_ops = {
 	.hw_params	= rt715_sdca_pcm_hw_params,
 	.hw_free	= rt715_sdca_pcm_hw_free,
-	.set_sdw_stream	= rt715_sdca_set_sdw_stream,
+	.set_stream	= rt715_sdca_set_sdw_stream,
 	.shutdown	= rt715_sdca_shutdown,
 };
 
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 1352869cc086..a64d11a74751 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -909,7 +909,7 @@ static int rt715_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops rt715_ops = {
 	.hw_params	= rt715_pcm_hw_params,
 	.hw_free	= rt715_pcm_hw_free,
-	.set_sdw_stream	= rt715_set_sdw_stream,
+	.set_stream	= rt715_set_sdw_stream,
 	.shutdown	= rt715_shutdown,
 };
 
diff --git a/sound/soc/codecs/sdw-mockup.c b/sound/soc/codecs/sdw-mockup.c
index 8ea13cfa9f8e..7c612aaf31c7 100644
--- a/sound/soc/codecs/sdw-mockup.c
+++ b/sound/soc/codecs/sdw-mockup.c
@@ -138,7 +138,7 @@ static int sdw_mockup_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops sdw_mockup_ops = {
 	.hw_params	= sdw_mockup_pcm_hw_params,
 	.hw_free	= sdw_mockup_pcm_hw_free,
-	.set_sdw_stream	= sdw_mockup_set_sdw_stream,
+	.set_stream	= sdw_mockup_set_sdw_stream,
 	.shutdown	= sdw_mockup_shutdown,
 };
 
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 67151c7770c6..0b5266c56a3f 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4287,7 +4287,7 @@ static int wcd938x_codec_set_sdw_stream(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops wcd938x_sdw_dai_ops = {
 	.hw_params = wcd938x_codec_hw_params,
 	.hw_free = wcd938x_codec_free,
-	.set_sdw_stream = wcd938x_codec_set_sdw_stream,
+	.set_stream = wcd938x_codec_set_sdw_stream,
 };
 
 static struct snd_soc_dai_driver wcd938x_dais[] = {
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 2da4a5fa7a18..ffc025e01bce 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1018,7 +1018,7 @@ static const struct snd_soc_dai_ops wsa881x_dai_ops = {
 	.hw_params = wsa881x_hw_params,
 	.hw_free = wsa881x_hw_free,
 	.mute_stream = wsa881x_digital_mute,
-	.set_sdw_stream = wsa881x_set_sdw_stream,
+	.set_stream = wsa881x_set_sdw_stream,
 };
 
 static struct snd_soc_dai_driver wsa881x_dais[] = {
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index de303a980879..da515eb1ddbe 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -347,7 +347,7 @@ int sdw_prepare(struct snd_pcm_substream *substream)
 	/* Find stream from first CPU DAI */
 	dai = asoc_rtd_to_cpu(rtd, 0);
 
-	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+	sdw_stream = snd_soc_dai_get_stream(dai, substream->stream);
 
 	if (IS_ERR(sdw_stream)) {
 		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
@@ -367,7 +367,7 @@ int sdw_trigger(struct snd_pcm_substream *substream, int cmd)
 	/* Find stream from first CPU DAI */
 	dai = asoc_rtd_to_cpu(rtd, 0);
 
-	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+	sdw_stream = snd_soc_dai_get_stream(dai, substream->stream);
 
 	if (IS_ERR(sdw_stream)) {
 		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
@@ -406,7 +406,7 @@ int sdw_hw_free(struct snd_pcm_substream *substream)
 	/* Find stream from first CPU DAI */
 	dai = asoc_rtd_to_cpu(rtd, 0);
 
-	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+	sdw_stream = snd_soc_dai_get_stream(dai, substream->stream);
 
 	if (IS_ERR(sdw_stream)) {
 		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 10d724bd1d67..5c1d13eccbee 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -57,8 +57,8 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0, i;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
-						      substream->stream);
+		sruntime = snd_soc_dai_get_stream(codec_dai,
+						  substream->stream);
 		if (sruntime != ERR_PTR(-ENOTSUPP))
 			pdata->sruntime[cpu_dai->id] = sruntime;
 
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index b2ca2579810b..114a29e01c0f 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -136,8 +136,8 @@ static int sm8250_snd_hw_params(struct snd_pcm_substream *substream,
 	case TX_CODEC_DMA_TX_2:
 	case TX_CODEC_DMA_TX_3:
 		for_each_rtd_codec_dais(rtd, i, codec_dai) {
-			sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
-						      substream->stream);
+			sruntime = snd_soc_dai_get_stream(codec_dai,
+							  substream->stream);
 			if (sruntime != ERR_PTR(-ENOTSUPP))
 				pdata->sruntime[cpu_dai->id] = sruntime;
 		}
-- 
2.17.1

