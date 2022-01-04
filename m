Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD848407E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiADLKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:10:25 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59286 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbiADLKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:10:23 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 047551A2251;
        Tue,  4 Jan 2022 12:10:22 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1E4C1A223A;
        Tue,  4 Jan 2022 12:10:21 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2A0D4183AC4C;
        Tue,  4 Jan 2022 19:10:20 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: imx-card: Fix mclk calculation issue for akcodec
Date:   Tue,  4 Jan 2022 18:40:34 +0800
Message-Id: <1641292835-19085-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transfer the refined slots and slot_width to akcodec_get_mclk_rate()
for mclk calculation, otherwise the mclk frequency does not match
with the slots and slot_width for S16_LE format, because the default
slot_width is 32.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-card.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index e0f3aa6d9501..f9196fb7e833 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -247,13 +247,14 @@ static bool codec_is_akcodec(unsigned int type)
 }
 
 static unsigned long akcodec_get_mclk_rate(struct snd_pcm_substream *substream,
-					   struct snd_pcm_hw_params *params)
+					   struct snd_pcm_hw_params *params,
+					   int slots, int slot_width)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_card_data *data = snd_soc_card_get_drvdata(rtd->card);
 	const struct imx_card_plat_data *plat_data = data->plat_data;
 	struct dai_link_data *link_data = &data->link_data[rtd->num];
-	unsigned int width = link_data->slots * link_data->slot_width;
+	unsigned int width = slots * slot_width;
 	unsigned int rate = params_rate(params);
 	int i;
 
@@ -349,7 +350,7 @@ static int imx_aif_hw_params(struct snd_pcm_substream *substream,
 
 	/* Set MCLK freq */
 	if (codec_is_akcodec(plat_data->type))
-		mclk_freq = akcodec_get_mclk_rate(substream, params);
+		mclk_freq = akcodec_get_mclk_rate(substream, params, slots, slot_width);
 	else
 		mclk_freq = params_rate(params) * slots * slot_width;
 	/* Use the maximum freq from DSD512 (512*44100 = 22579200) */
-- 
2.17.1

