Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BFD4720AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhLMFq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:46:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:26980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhLMFqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:46:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299449498"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="299449498"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:46:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="517608148"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:46:50 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/7] ASoC/soundwire: intel: simplify callbacks for params/hw_free
Date:   Mon, 13 Dec 2021 13:46:29 +0800
Message-Id: <20211213054634.30088-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We don't really need to pass a substream to the callback, we only need
the direction. No functionality change, only simplification to enable
improve suspend with paused streams.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 14 +++++++-------
 include/linux/soundwire/sdw_intel.h |  4 ++--
 sound/soc/sof/intel/hda.c           |  6 ++----
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 78037ffdb09b..25c5f5b9f058 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -711,7 +711,7 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 }
 
 static int intel_params_stream(struct sdw_intel *sdw,
-			       struct snd_pcm_substream *substream,
+			       int stream,
 			       struct snd_soc_dai *dai,
 			       struct snd_pcm_hw_params *hw_params,
 			       int link_id, int alh_stream_id)
@@ -719,7 +719,7 @@ static int intel_params_stream(struct sdw_intel *sdw,
 	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_intel_stream_params_data params_data;
 
-	params_data.substream = substream;
+	params_data.stream = stream; /* direction */
 	params_data.dai = dai;
 	params_data.hw_params = hw_params;
 	params_data.link_id = link_id;
@@ -732,14 +732,14 @@ static int intel_params_stream(struct sdw_intel *sdw,
 }
 
 static int intel_free_stream(struct sdw_intel *sdw,
-			     struct snd_pcm_substream *substream,
+			     int stream,
 			     struct snd_soc_dai *dai,
 			     int link_id)
 {
 	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_intel_stream_free_data free_data;
 
-	free_data.substream = substream;
+	free_data.stream = stream; /* direction */
 	free_data.dai = dai;
 	free_data.link_id = link_id;
 
@@ -876,7 +876,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	dma->hw_params = params;
 
 	/* Inform DSP about PDI stream number */
-	ret = intel_params_stream(sdw, substream, dai, params,
+	ret = intel_params_stream(sdw, substream->stream, dai, params,
 				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
@@ -953,7 +953,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		sdw_cdns_config_stream(cdns, ch, dir, dma->pdi);
 
 		/* Inform DSP about PDI stream number */
-		ret = intel_params_stream(sdw, substream, dai,
+		ret = intel_params_stream(sdw, substream->stream, dai,
 					  dma->hw_params,
 					  sdw->instance,
 					  dma->pdi->intel_alh_id);
@@ -987,7 +987,7 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
+	ret = intel_free_stream(sdw, substream->stream, dai, sdw->instance);
 	if (ret < 0) {
 		dev_err(dai->dev, "intel_free_stream: failed %d\n", ret);
 		return ret;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 8a463b8fc12a..67e0d3e750b5 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -92,7 +92,7 @@
  * firmware.
  */
 struct sdw_intel_stream_params_data {
-	struct snd_pcm_substream *substream;
+	int stream;
 	struct snd_soc_dai *dai;
 	struct snd_pcm_hw_params *hw_params;
 	int link_id;
@@ -105,7 +105,7 @@ struct sdw_intel_stream_params_data {
  * firmware.
  */
 struct sdw_intel_stream_free_data {
-	struct snd_pcm_substream *substream;
+	int stream;
 	struct snd_soc_dai *dai;
 	int link_id;
 };
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 77b9cb551f4b..5f703ca884f9 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -185,12 +185,11 @@ static int sdw_dai_config_ipc(struct snd_sof_dev *sdev,
 static int sdw_params_stream(struct device *dev,
 			     struct sdw_intel_stream_params_data *params_data)
 {
-	struct snd_pcm_substream *substream = params_data->substream;
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	struct snd_soc_dai *d = params_data->dai;
 	struct snd_soc_dapm_widget *w;
 
-	w = snd_soc_dai_get_widget(d, substream->stream);
+	w = snd_soc_dai_get_widget(d, params_data->stream);
 
 	return sdw_dai_config_ipc(sdev, w, params_data->link_id, params_data->alh_stream_id,
 				  d->id, true);
@@ -199,12 +198,11 @@ static int sdw_params_stream(struct device *dev,
 static int sdw_free_stream(struct device *dev,
 			   struct sdw_intel_stream_free_data *free_data)
 {
-	struct snd_pcm_substream *substream = free_data->substream;
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	struct snd_soc_dai *d = free_data->dai;
 	struct snd_soc_dapm_widget *w;
 
-	w = snd_soc_dai_get_widget(d, substream->stream);
+	w = snd_soc_dai_get_widget(d, free_data->stream);
 
 	/* send invalid stream_id */
 	return sdw_dai_config_ipc(sdev, w, free_data->link_id, 0xFFFF, d->id, false);
-- 
2.17.1

