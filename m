Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BBD568472
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiGFJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiGFJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:57:56 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EFA1ED
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:57:54 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C48A20079B;
        Wed,  6 Jul 2022 11:57:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04D402007DE;
        Wed,  6 Jul 2022 11:57:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 50153180327D;
        Wed,  6 Jul 2022 17:57:51 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-card: Fix DSD/PDM mclk frequency
Date:   Wed,  6 Jul 2022 17:42:55 +0800
Message-Id: <1657100575-8261-1-git-send-email-shengjiu.wang@nxp.com>
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

The DSD/PDM rate not only DSD64/128/256/512, which are the
multiple rate of 44.1kHz,  but also support the multiple
rate of 8kHz, so can't force all mclk frequency to be
22579200Hz, need to assign the frequency according to
rate.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-card.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 1797d777b1b8..ccc4194dc5e7 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -17,6 +17,9 @@
 
 #include "fsl_sai.h"
 
+#define IMX_CARD_MCLK_22P5792MHZ  22579200
+#define IMX_CARD_MCLK_24P576MHZ   24576000
+
 enum codec_type {
 	CODEC_DUMMY = 0,
 	CODEC_AK5558 = 1,
@@ -353,9 +356,14 @@ static int imx_aif_hw_params(struct snd_pcm_substream *substream,
 		mclk_freq = akcodec_get_mclk_rate(substream, params, slots, slot_width);
 	else
 		mclk_freq = params_rate(params) * slots * slot_width;
-	/* Use the maximum freq from DSD512 (512*44100 = 22579200) */
-	if (format_is_dsd(params))
-		mclk_freq = 22579200;
+
+	if (format_is_dsd(params)) {
+		/* Use the maximum freq from DSD512 (512*44100 = 22579200) */
+		if (!(params_rate(params) % 11025))
+			mclk_freq = IMX_CARD_MCLK_22P5792MHZ;
+		else
+			mclk_freq = IMX_CARD_MCLK_24P576MHZ;
+	}
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, link_data->cpu_sysclk_id, mclk_freq,
 				     SND_SOC_CLOCK_OUT);
-- 
2.17.1

