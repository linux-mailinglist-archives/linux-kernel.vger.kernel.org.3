Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B56592C33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiHOJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiHOJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:43:41 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5941EC7B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:43:40 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 059F11A1915;
        Mon, 15 Aug 2022 11:43:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 99B4D1A191B;
        Mon, 15 Aug 2022 11:43:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2ACE4180031A;
        Mon, 15 Aug 2022 17:43:37 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Add support multi fifo sdma script
Date:   Mon, 15 Aug 2022 17:25:46 +0800
Message-Id: <1660555546-24223-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With disabling combine mode, the multiple successive
FIFO registers or non successive FIFO registers of SAI module
can work with the sdma multi fifo script.

This patch is to configure the necessary information to
the SDMA engine driver for support multi fifo script.

'words_per_fifo' is the channels for each dataline
'n_fifos_src' and 'n_fifos_dst' are the fifo number
'stride_fifos_src' and 'stride_fifos_dst' are the stride
between enable FIFOs
'maxburst' is the multiply of datalines

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 37 ++++++++++++++++++++++++++++++++++++-
 sound/soc/fsl/fsl_sai.h |  3 +++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index acf76ea21138..a2b375e2b56c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -533,6 +533,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	u32 slot_width = word_width;
 	int adir = tx ? RX : TX;
 	u32 pins, bclk;
+	u32 watermark;
 	int ret, i;
 
 	if (sai->slot_width)
@@ -627,7 +628,15 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				   FSL_SAI_CR5_FBT_MASK, val_cr5);
 	}
 
-	if (hweight8(dl_cfg[dl_cfg_idx].mask[tx]) <= 1)
+	/*
+	 * Combine mode has limation:
+	 * - Can't used for singel dataline/FIFO case except the FIFO0
+	 * - Can't used for multi dataline/FIFO case except the enabled FIFOs
+	 *   are successive and start from FIFO0
+	 *
+	 * So for common usage, all multi fifo case disable the combine mode.
+	 */
+	if (hweight8(dl_cfg[dl_cfg_idx].mask[tx]) <= 1 || sai->is_multi_fifo_dma)
 		regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 				   FSL_SAI_CR4_FCOMB_MASK, 0);
 	else
@@ -638,6 +647,26 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	dma_params->addr = sai->res->start + FSL_SAI_xDR0(tx) +
 			   dl_cfg[dl_cfg_idx].start_off[tx] * 0x4;
 
+	if (sai->is_multi_fifo_dma) {
+		sai->audio_config[tx].words_per_fifo = min(slots, channels);
+		if (tx) {
+			sai->audio_config[tx].n_fifos_dst = pins;
+			sai->audio_config[tx].stride_fifos_dst = dl_cfg[dl_cfg_idx].next_off[tx];
+		} else {
+			sai->audio_config[tx].n_fifos_src = pins;
+			sai->audio_config[tx].stride_fifos_src = dl_cfg[dl_cfg_idx].next_off[tx];
+		}
+		dma_params->maxburst = sai->audio_config[tx].words_per_fifo * pins;
+		dma_params->peripheral_config = &sai->audio_config[tx];
+		dma_params->peripheral_size = sizeof(sai->audio_config[tx]);
+
+		watermark = tx ? (sai->soc_data->fifo_depth - dma_params->maxburst) :
+				 (dma_params->maxburst - 1);
+		regmap_update_bits(sai->regmap, FSL_SAI_xCR1(tx, ofs),
+				   FSL_SAI_CR1_RFW_MASK(sai->soc_data->fifo_depth),
+				   watermark);
+	}
+
 	/* Find a proper tcre setting */
 	for (i = 0; i < sai->soc_data->pins; i++) {
 		trce_mask = (1 << (i + 1)) - 1;
@@ -1265,6 +1294,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	char tmp[8];
 	int irq, ret, i;
 	int index;
+	u32 dmas[4];
 
 	sai = devm_kzalloc(dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
@@ -1321,6 +1351,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	fsl_asoc_get_pll_clocks(&pdev->dev, &sai->pll8k_clk,
 				&sai->pll11k_clk);
 
+	/* Use Multi FIFO mode depending on the support from SDMA script */
+	ret = of_property_read_u32_array(np, "dmas", dmas, 4);
+	if (!sai->soc_data->use_edma && !ret && dmas[2] == IMX_DMATYPE_MULTI_SAI)
+		sai->is_multi_fifo_dma = true;
+
 	/* read dataline mask for rx and tx*/
 	ret = fsl_sai_read_dlcfg(sai);
 	if (ret < 0) {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 17956b5731dc..697f6690068c 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -6,6 +6,7 @@
 #ifndef __FSL_SAI_H
 #define __FSL_SAI_H
 
+#include <linux/dma/imx-dma.h>
 #include <sound/dmaengine_pcm.h>
 
 #define FSL_SAI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
@@ -281,6 +282,7 @@ struct fsl_sai {
 	bool is_lsb_first;
 	bool is_dsp_mode;
 	bool is_pdm_mode;
+	bool is_multi_fifo_dma;
 	bool synchronous[2];
 	struct fsl_sai_dl_cfg *dl_cfg;
 	unsigned int dl_cfg_cnt;
@@ -300,6 +302,7 @@ struct fsl_sai {
 	struct pm_qos_request pm_qos_req;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_state;
+	struct sdma_peripheral_config audio_config[2];
 };
 
 #define TX 1
-- 
2.17.1

