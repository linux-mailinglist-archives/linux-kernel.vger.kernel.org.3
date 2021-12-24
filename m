Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F347EA80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350980AbhLXCLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:11:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:54155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350941AbhLXCLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640311879; x=1671847879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AVFqtyqEoBOXDU/7oBzMv8FnMPjM4PzRwUQqKLR7HM=;
  b=jl0dqNAxb60hVRNOa1kIyGaD97uEJOENsbWhzkJ2stJackFT9uv3/oh+
   lTbI3wnnx9MYvGyDMfaIkfUN3TL+DPwnU0RrYf9hLLMVrFpC2D2uqApG/
   KbaxhyIteu2oR5gdED61QIszqUmHqUow+7jtHJvnO+2h2GMTGPWiwRdGN
   Dm4XAk+KmftVM9yOGOeFL/AULKso+nIBwTadES7rSAy5wbVcmSdIPjd4L
   xdJ6lPHlPxxZ3VNOjT8Z8PmsySqzvFuTb9T3ra6MNYB92DAn3Isdf5BR0
   p4ZGmeGbRkYCRdoJlxlyt6OrlZTw5bYe0BYGjtQsxxjFF5kokDA0K98qk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="240715093"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="240715093"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="467156241"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:13 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 7/7] soundwire: intel: remove PDM support
Date:   Fri, 24 Dec 2021 10:10:34 +0800
Message-Id: <20211224021034.26635-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
References: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

While the hardware supports PDM streams, this capability has never
been tested or enabled on any product, so this is dead-code. Let's
remove all this.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/cadence_master.c |  36 +--------
 drivers/soundwire/cadence_master.h |  12 +--
 drivers/soundwire/intel.c          | 123 +++++++----------------------
 3 files changed, 31 insertions(+), 140 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4fcc3ba93004..558390af44b6 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1178,9 +1178,6 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	cdns->pcm.num_bd = config.pcm_bd;
 	cdns->pcm.num_in = config.pcm_in;
 	cdns->pcm.num_out = config.pcm_out;
-	cdns->pdm.num_bd = config.pdm_bd;
-	cdns->pdm.num_in = config.pdm_in;
-	cdns->pdm.num_out = config.pdm_out;
 
 	/* Allocate PDIs for PCMs */
 	stream = &cdns->pcm;
@@ -1211,32 +1208,6 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	stream->num_pdi = stream->num_bd + stream->num_in + stream->num_out;
 	cdns->num_ports = stream->num_pdi;
 
-	/* Allocate PDIs for PDMs */
-	stream = &cdns->pdm;
-	ret = cdns_allocate_pdi(cdns, &stream->bd,
-				stream->num_bd, offset);
-	if (ret)
-		return ret;
-
-	offset += stream->num_bd;
-
-	ret = cdns_allocate_pdi(cdns, &stream->in,
-				stream->num_in, offset);
-	if (ret)
-		return ret;
-
-	offset += stream->num_in;
-
-	ret = cdns_allocate_pdi(cdns, &stream->out,
-				stream->num_out, offset);
-
-	if (ret)
-		return ret;
-
-	/* Update total number of PDM PDIs */
-	stream->num_pdi = stream->num_bd + stream->num_in + stream->num_out;
-	cdns->num_ports += stream->num_pdi;
-
 	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_pdi_init);
@@ -1681,7 +1652,7 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 EXPORT_SYMBOL(sdw_cdns_probe);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
-			void *stream, bool pcm, int direction)
+			void *stream, int direction)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_cdns_dma_data *dma;
@@ -1705,10 +1676,7 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 		if (!dma)
 			return -ENOMEM;
 
-		if (pcm)
-			dma->stream_type = SDW_STREAM_PCM;
-		else
-			dma->stream_type = SDW_STREAM_PDM;
+		dma->stream_type = SDW_STREAM_PCM;
 
 		dma->bus = &cdns->bus;
 		dma->link_id = cdns->instance;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index aa4b9b0eb2a8..595d72c15d97 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -17,7 +17,7 @@
  * @h_ch_num: high channel for PDI
  * @ch_count: total channel count for PDI
  * @dir: data direction
- * @type: stream type, PDM or PCM
+ * @type: stream type, (only PCM supported)
  */
 struct sdw_cdns_pdi {
 	int num;
@@ -62,17 +62,11 @@ struct sdw_cdns_streams {
  * @pcm_bd: number of bidirectional PCM streams supported
  * @pcm_in: number of input PCM streams supported
  * @pcm_out: number of output PCM streams supported
- * @pdm_bd: number of bidirectional PDM streams supported
- * @pdm_in: number of input PDM streams supported
- * @pdm_out: number of output PDM streams supported
  */
 struct sdw_cdns_stream_config {
 	unsigned int pcm_bd;
 	unsigned int pcm_in;
 	unsigned int pcm_out;
-	unsigned int pdm_bd;
-	unsigned int pdm_in;
-	unsigned int pdm_out;
 };
 
 /**
@@ -111,7 +105,6 @@ struct sdw_cdns_dma_data {
  * @ports: Data ports
  * @num_ports: Total number of data ports
  * @pcm: PCM streams
- * @pdm: PDM streams
  * @registers: Cadence registers
  * @link_up: Link status
  * @msg_count: Messages sent on bus
@@ -129,7 +122,6 @@ struct sdw_cdns {
 	int num_ports;
 
 	struct sdw_cdns_streams pcm;
-	struct sdw_cdns_streams pdm;
 
 	int pdi_loopback_source;
 	int pdi_loopback_target;
@@ -188,7 +180,7 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
 int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
-			void *stream, bool pcm, int direction);
+			void *stream, int direction);
 
 void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string,
 				       bool initial_delay, int reset_iterations);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0d1c86e6ac2e..79ba0e3f6dac 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -564,7 +564,7 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
-	int pcm_cap, pdm_cap;
+	int pcm_cap;
 
 	/* PCM Stream Capability */
 	pcm_cap = intel_readw(shim, SDW_SHIM_PCMSCAP(link_id));
@@ -575,41 +575,25 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 
 	dev_dbg(sdw->cdns.dev, "PCM cap bd:%d in:%d out:%d\n",
 		config->pcm_bd, config->pcm_in, config->pcm_out);
-
-	/* PDM Stream Capability */
-	pdm_cap = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
-
-	config->pdm_bd = FIELD_GET(SDW_SHIM_PDMSCAP_BSS, pdm_cap);
-	config->pdm_in = FIELD_GET(SDW_SHIM_PDMSCAP_ISS, pdm_cap);
-	config->pdm_out = FIELD_GET(SDW_SHIM_PDMSCAP_OSS, pdm_cap);
-
-	dev_dbg(sdw->cdns.dev, "PDM cap bd:%d in:%d out:%d\n",
-		config->pdm_bd, config->pdm_in, config->pdm_out);
 }
 
 static int
-intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
+intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int count;
 
-	if (pcm) {
-		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
+	count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
 
-		/*
-		 * WORKAROUND: on all existing Intel controllers, pdi
-		 * number 2 reports channel count as 1 even though it
-		 * supports 8 channels. Performing hardcoding for pdi
-		 * number 2.
-		 */
-		if (pdi_num == 2)
-			count = 7;
-
-	} else {
-		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
-		count = FIELD_GET(SDW_SHIM_PDMSCAP_CPSS, count);
-	}
+	/*
+	 * WORKAROUND: on all existing Intel controllers, pdi
+	 * number 2 reports channel count as 1 even though it
+	 * supports 8 channels. Performing hardcoding for pdi
+	 * number 2.
+	 */
+	if (pdi_num == 2)
+		count = 7;
 
 	/* zero based values for channel count in register */
 	count++;
@@ -620,12 +604,12 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
 static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
 				   struct sdw_cdns_pdi *pdi,
 				   unsigned int num_pdi,
-				   unsigned int *num_ch, bool pcm)
+				   unsigned int *num_ch)
 {
 	int i, ch_count = 0;
 
 	for (i = 0; i < num_pdi; i++) {
-		pdi->ch_count = intel_pdi_get_ch_cap(sdw, pdi->num, pcm);
+		pdi->ch_count = intel_pdi_get_ch_cap(sdw, pdi->num);
 		ch_count += pdi->ch_count;
 		pdi++;
 	}
@@ -635,25 +619,23 @@ static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
 }
 
 static int intel_pdi_stream_ch_update(struct sdw_intel *sdw,
-				      struct sdw_cdns_streams *stream, bool pcm)
+				      struct sdw_cdns_streams *stream)
 {
 	intel_pdi_get_ch_update(sdw, stream->bd, stream->num_bd,
-				&stream->num_ch_bd, pcm);
+				&stream->num_ch_bd);
 
 	intel_pdi_get_ch_update(sdw, stream->in, stream->num_in,
-				&stream->num_ch_in, pcm);
+				&stream->num_ch_in);
 
 	intel_pdi_get_ch_update(sdw, stream->out, stream->num_out,
-				&stream->num_ch_out, pcm);
+				&stream->num_ch_out);
 
 	return 0;
 }
 
 static int intel_pdi_ch_update(struct sdw_intel *sdw)
 {
-	/* First update PCM streams followed by PDM streams */
-	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm, true);
-	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pdm, false);
+	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm);
 
 	return 0;
 }
@@ -840,7 +822,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_port_config *pconfig;
 	int ch, dir;
 	int ret;
-	bool pcm = true;
 
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma)
@@ -852,13 +833,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = SDW_DATA_DIR_TX;
 
-	if (dma->stream_type == SDW_STREAM_PDM)
-		pcm = false;
-
-	if (pcm)
-		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
-	else
-		pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pdm, ch, dir, dai->id);
+	pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
 
 	if (!pdi) {
 		ret = -EINVAL;
@@ -888,12 +863,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sconfig.frame_rate = params_rate(params);
 	sconfig.type = dma->stream_type;
 
-	if (dma->stream_type == SDW_STREAM_PDM) {
-		sconfig.frame_rate *= 50;
-		sconfig.bps = 1;
-	} else {
-		sconfig.bps = snd_pcm_format_width(params_format(params));
-	}
+	sconfig.bps = snd_pcm_format_width(params_format(params));
 
 	/* Port configuration */
 	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
@@ -1012,13 +982,7 @@ static void intel_shutdown(struct snd_pcm_substream *substream,
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
-	return cdns_set_sdw_stream(dai, stream, true, direction);
-}
-
-static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
-				    void *stream, int direction)
-{
-	return cdns_set_sdw_stream(dai, stream, false, direction);
+	return cdns_set_sdw_stream(dai, stream, direction);
 }
 
 static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
@@ -1133,16 +1097,6 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.get_stream = intel_get_sdw_stream,
 };
 
-static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
-	.startup = intel_startup,
-	.hw_params = intel_hw_params,
-	.prepare = intel_prepare,
-	.hw_free = intel_hw_free,
-	.shutdown = intel_shutdown,
-	.set_stream = intel_pdm_set_sdw_stream,
-	.get_stream = intel_get_sdw_stream,
-};
-
 static const struct snd_soc_component_driver dai_component = {
 	.name           = "soundwire",
 	.suspend	= intel_component_dais_suspend
@@ -1151,7 +1105,7 @@ static const struct snd_soc_component_driver dai_component = {
 static int intel_create_dai(struct sdw_cdns *cdns,
 			    struct snd_soc_dai_driver *dais,
 			    enum intel_pdi_type type,
-			    u32 num, u32 off, u32 max_ch, bool pcm)
+			    u32 num, u32 off, u32 max_ch)
 {
 	int i;
 
@@ -1180,10 +1134,7 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
 
-		if (pcm)
-			dais[i].ops = &intel_pcm_dai_ops;
-		else
-			dais[i].ops = &intel_pdm_dai_ops;
+		dais[i].ops = &intel_pcm_dai_ops;
 	}
 
 	return 0;
@@ -1197,7 +1148,7 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	int num_dai, ret, off = 0;
 
 	/* DAIs are created based on total number of PDIs supported */
-	num_dai = cdns->pcm.num_pdi + cdns->pdm.num_pdi;
+	num_dai = cdns->pcm.num_pdi;
 
 	dais = devm_kcalloc(cdns->dev, num_dai, sizeof(*dais), GFP_KERNEL);
 	if (!dais)
@@ -1207,39 +1158,19 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	stream = &cdns->pcm;
 
 	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pcm.num_in,
-			       off, stream->num_ch_in, true);
+			       off, stream->num_ch_in);
 	if (ret)
 		return ret;
 
 	off += cdns->pcm.num_in;
 	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns->pcm.num_out,
-			       off, stream->num_ch_out, true);
+			       off, stream->num_ch_out);
 	if (ret)
 		return ret;
 
 	off += cdns->pcm.num_out;
 	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pcm.num_bd,
-			       off, stream->num_ch_bd, true);
-	if (ret)
-		return ret;
-
-	/* Create PDM DAIs */
-	stream = &cdns->pdm;
-	off += cdns->pcm.num_bd;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pdm.num_in,
-			       off, stream->num_ch_in, false);
-	if (ret)
-		return ret;
-
-	off += cdns->pdm.num_in;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns->pdm.num_out,
-			       off, stream->num_ch_out, false);
-	if (ret)
-		return ret;
-
-	off += cdns->pdm.num_out;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pdm.num_bd,
-			       off, stream->num_ch_bd, false);
+			       off, stream->num_ch_bd);
 	if (ret)
 		return ret;
 
-- 
2.17.1

