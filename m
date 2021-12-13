Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9414720B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhLMFq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:46:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:26984 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhLMFq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:46:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299449502"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="299449502"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:46:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="517608156"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:46:53 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: intel: improve suspend flows
Date:   Mon, 13 Dec 2021 13:46:30 +0800
Message-Id: <20211213054634.30088-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

This patch provides both a simplification of the suspend flows and a
better balanced operation during suspend/resume transition, as part of
the transition of Sound Open Firmware (SOF) to dynamic pipelines: the
DSP resources are only enabled when required instead of enabled on
startup.

The exiting code relies on a convoluted way of dealing with suspend
signals. Since there is no .suspend DAI callback, we used the
component .suspend and marked all the component DAI dmas as
'suspended'. The information was used in the .prepare stage to
differentiate resume operations from xrun handling, and only
reinitialize SHIM registers and DMA in the former case.

While this solution has been working reliably for about 2 years, there
is a much better solution consisting in trapping the TRIGGER_SUSPEND
in the .trigger DAI ops. The DMA is still marked in the same way for
the .prepare op to run, but in addition the callbacks sent to DSP
firmware are now balanced.

Normal operation:
hw_params -> intel_params_stream
hw_free   -> intel_free_stream

suspend    -> intel_free_stream
prepare    -> intel_params_stream

This balanced operation was not required with existing SOF firmware
relying on static pipelines instantiated at every boot. With the
on-going transition to dynamic pipelines, it's however a requirement
to keep the use count for the DAI widget balanced across all
transitions.

The component suspend is not removed but instead modified to deal with
a corner case: when a substream is PAUSED, the ALSA core does not
throw the TRIGGER_SUSPEND. This is problematic since the refcount for
all pipelines and widgets is not balanced, leading to issues on
resume. The trigger callback keeps track of the 'paused' state with a
new flag, which is tested during the component suspend called later to
release the remaining DSP resources. These resources will be
re-enabled in the .prepare step.

The IPC used in the TRIGGER_SUSPEND to release DSP resources is not a
problem since the BE dailink is already marked as non-atomic.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.h |   2 +
 drivers/soundwire/intel.c          | 110 +++++++++++++++++++++++------
 2 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index e587aede63bf..aa4b9b0eb2a8 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -86,6 +86,7 @@ struct sdw_cdns_stream_config {
  * @link_id: Master link id
  * @hw_params: hw_params to be applied in .prepare step
  * @suspended: status set when suspended, to be used in .prepare
+ * @paused: status set in .trigger, to be used in suspend
  */
 struct sdw_cdns_dma_data {
 	char *name;
@@ -96,6 +97,7 @@ struct sdw_cdns_dma_data {
 	int link_id;
 	struct snd_pcm_hw_params *hw_params;
 	bool suspended;
+	bool paused;
 };
 
 /**
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 25c5f5b9f058..3d29f02ad5a6 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -871,6 +871,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sdw_cdns_config_stream(cdns, ch, dir, pdi);
 
 	/* store pdi and hw_params, may be needed in prepare step */
+	dma->paused = false;
 	dma->suspended = false;
 	dma->pdi = pdi;
 	dma->hw_params = params;
@@ -1008,29 +1009,6 @@ static void intel_shutdown(struct snd_pcm_substream *substream,
 	pm_runtime_put_autosuspend(cdns->dev);
 }
 
-static int intel_component_dais_suspend(struct snd_soc_component *component)
-{
-	struct sdw_cdns_dma_data *dma;
-	struct snd_soc_dai *dai;
-
-	for_each_component_dais(component, dai) {
-		/*
-		 * we don't have a .suspend dai_ops, and we don't have access
-		 * to the substream, so let's mark both capture and playback
-		 * DMA contexts as suspended
-		 */
-		dma = dai->playback_dma_data;
-		if (dma)
-			dma->suspended = true;
-
-		dma = dai->capture_dma_data;
-		if (dma)
-			dma->suspended = true;
-	}
-
-	return 0;
-}
-
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
@@ -1059,11 +1037,97 @@ static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 	return dma->stream;
 }
 
+static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns_dma_data *dma;
+	int ret = 0;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma) {
+		dev_err(dai->dev, "failed to get dma data in %s\n",
+			__func__);
+		return -EIO;
+	}
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+
+		/*
+		 * The .prepare callback is used to deal with xruns and resume operations.
+		 * In the case of xruns, the DMAs and SHIM registers cannot be touched,
+		 * but for resume operations the DMAs and SHIM registers need to be initialized.
+		 * the .trigger callback is used to track the suspend case only.
+		 */
+
+		dma->suspended = true;
+
+		ret = intel_free_stream(sdw, substream->stream, dai, sdw->instance);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dma->paused = true;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dma->paused = false;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int intel_component_dais_suspend(struct snd_soc_component *component)
+{
+	struct snd_soc_dai *dai;
+
+	/*
+	 * In the corner case where a SUSPEND happens during a PAUSE, the ALSA core
+	 * does not throw the TRIGGER_SUSPEND. This leaves the DAIs in an unbalanced state.
+	 * Since the component suspend is called last, we can trap this corner case
+	 * and force the DAIs to release their resources.
+	 */
+	for_each_component_dais(component, dai) {
+		struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+		struct sdw_intel *sdw = cdns_to_intel(cdns);
+		struct sdw_cdns_dma_data *dma;
+		int stream;
+		int ret;
+
+		dma = dai->playback_dma_data;
+		stream = SNDRV_PCM_STREAM_PLAYBACK;
+		if (!dma) {
+			dma = dai->capture_dma_data;
+			stream = SNDRV_PCM_STREAM_CAPTURE;
+		}
+
+		if (!dma)
+			continue;
+
+		if (dma->suspended)
+			continue;
+
+		if (dma->paused) {
+			dma->suspended = true;
+
+			ret = intel_free_stream(sdw, stream, dai, sdw->instance);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
+	.trigger = intel_trigger,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
 	.get_sdw_stream = intel_get_sdw_stream,
-- 
2.17.1

