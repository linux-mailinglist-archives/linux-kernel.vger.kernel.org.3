Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9255ACD01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiIEHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIEHkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:40:39 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2B193DE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:40:34 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662363632; bh=Gk6dEkmexN5Kop02Qn4R9tfpOM6x14dDFliZdEGF2zM=;
        h=From:To:Cc:Subject:Date;
        b=pkvEix9aoTFu/QcfBiqWiEmCJguW54koyoqICeEoFy9RBfHLveNVaFDSK6w/0sXQa
         lPMMALfz52ZYLxK04G51/Mw10pH0Hjx5EvCg/gq62+jbSVPNQvhj77KTaiiuQ/XwOo
         8i8nTwqlJ75L4yyDAN31HiYQz4MLSFIgY5x44WlI=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: apple: mca: Postpone requesting of DMA channels
Date:   Mon,  5 Sep 2022 09:40:30 +0200
Message-Id: <20220905074030.1293-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the requesting of DMA channels further down from 'probe' to
'pcm_new'. This is to spare the allocated DMA channel resources as we
typically only ever use one or two of the clusters for PCM streaming.
Before we would request DMA channels for all clusters.

(This is prompted by a change in the Audio DMA Controller driver, which
will now be allocating cache SRAM to channels.)

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 79 +++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index aa67d57c9a9b..69643524796e 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -885,6 +885,43 @@ static snd_pcm_uframes_t mca_pointer(struct snd_soc_component *component,
 	return snd_dmaengine_pcm_pointer(substream);
 }
 
+static struct dma_chan *mca_request_dma_channel(struct mca_cluster *cl, unsigned int stream)
+{
+	bool is_tx = (stream == SNDRV_PCM_STREAM_PLAYBACK);
+#ifndef USE_RXB_FOR_CAPTURE
+	char *name = devm_kasprintf(cl->host->dev, GFP_KERNEL,
+				    is_tx ? "tx%da" : "rx%da", cl->no);
+#else
+	char *name = devm_kasprintf(cl->host->dev, GFP_KERNEL,
+				    is_tx ? "tx%da" : "rx%db", cl->no);
+#endif
+	return of_dma_request_slave_channel(cl->host->dev->of_node, name);
+
+}
+
+static void mca_pcm_free(struct snd_soc_component *component,
+			 struct snd_pcm *pcm)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_chip(pcm);
+	struct mca_cluster *cl = mca_dai_to_cluster(asoc_rtd_to_cpu(rtd, 0));
+	unsigned int i;
+
+	if (rtd->dai_link->no_pcm)
+		return;
+
+	for_each_pcm_streams(i) {
+		struct snd_pcm_substream *substream =
+			rtd->pcm->streams[i].substream;
+
+		if (!substream || !cl->dma_chans[i])
+			continue;
+
+		dma_release_channel(cl->dma_chans[i]);
+		cl->dma_chans[i] = NULL;
+	}
+}
+
+
 static int mca_pcm_new(struct snd_soc_component *component,
 		       struct snd_soc_pcm_runtime *rtd)
 {
@@ -897,17 +934,21 @@ static int mca_pcm_new(struct snd_soc_component *component,
 	for_each_pcm_streams(i) {
 		struct snd_pcm_substream *substream =
 			rtd->pcm->streams[i].substream;
-		struct dma_chan *chan = cl->dma_chans[i];
+		struct dma_chan *chan;
 
 		if (!substream)
 			continue;
 
-		if (!chan) {
-			dev_err(component->dev, "missing DMA channel for stream %d on SERDES %d\n",
-				i, cl->no);
+		chan = mca_request_dma_channel(cl, i);
+
+		if (IS_ERR_OR_NULL(chan)) {
+			dev_err(component->dev, "unable to obtain DMA channel (stream %d cluster %d): %pe\n",
+				i, cl->no, chan);
+			mca_pcm_free(component, rtd->pcm);
 			return -EINVAL;
 		}
 
+		cl->dma_chans[i] = chan;
 		snd_pcm_set_managed_buffer(substream, SNDRV_DMA_TYPE_DEV_IRAM,
 					   chan->device->dev, 512 * 1024 * 6,
 					   SIZE_MAX);
@@ -924,6 +965,7 @@ static const struct snd_soc_component_driver mca_component = {
 	.trigger = mca_trigger,
 	.pointer = mca_pointer,
 	.pcm_construct = mca_pcm_new,
+	.pcm_destruct = mca_pcm_free,
 };
 
 static void apple_mca_release(struct mca_data *mca)
@@ -1019,7 +1061,6 @@ static int apple_mca_probe(struct platform_device *pdev)
 		struct snd_soc_dai_driver *fe =
 			&dai_drivers[mca->nclusters + i];
 		struct snd_soc_dai_driver *be = &dai_drivers[i];
-		int stream;
 
 		cl->host = mca;
 		cl->no = i;
@@ -1041,34 +1082,6 @@ static int apple_mca_probe(struct platform_device *pdev)
 			goto err_release;
 		}
 
-		for_each_pcm_streams(stream) {
-			struct dma_chan *chan;
-			bool is_tx = (stream == SNDRV_PCM_STREAM_PLAYBACK);
-#ifndef USE_RXB_FOR_CAPTURE
-			char *name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						    is_tx ? "tx%da" : "rx%da",
-						    i);
-#else
-			char *name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						    is_tx ? "tx%da" : "rx%db",
-						    i);
-#endif
-
-			chan = of_dma_request_slave_channel(pdev->dev.of_node,
-							    name);
-			if (IS_ERR(chan)) {
-				if (PTR_ERR(chan) != -EPROBE_DEFER)
-					dev_err(&pdev->dev,
-						"no %s DMA channel: %ld\n",
-						name, PTR_ERR(chan));
-
-				ret = PTR_ERR(chan);
-				goto err_release;
-			}
-
-			cl->dma_chans[stream] = chan;
-		}
-
 		fe->id = i;
 		fe->name =
 			devm_kasprintf(&pdev->dev, GFP_KERNEL, "mca-pcm-%d", i);
-- 
2.33.0

