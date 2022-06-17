Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8563154F254
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380721AbiFQH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380702AbiFQH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:59:19 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9745AA6A;
        Fri, 17 Jun 2022 00:59:18 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E82A01A29AC;
        Fri, 17 Jun 2022 09:59:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E2701A286D;
        Fri, 17 Jun 2022 09:59:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B737F1820F56;
        Fri, 17 Jun 2022 15:59:14 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] ASoC: fsl_sai: Add PDM daifmt support
Date:   Fri, 17 Jun 2022 15:44:31 +0800
Message-Id: <1655451877-16382-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDM format is used for 1-bit stream, so clear the FBT and SYWD,
and the each dataline only has one channel data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 17 +++++++++++++++--
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4f5bd9597c74..d11ee3b6f163 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -224,6 +224,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	if (!sai->is_lsb_first)
 		val_cr4 |= FSL_SAI_CR4_MF;
 
+	sai->is_pdm_mode = false;
 	/* DAI mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -262,6 +263,11 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		val_cr2 |= FSL_SAI_CR2_BCP;
 		sai->is_dsp_mode = true;
 		break;
+	case SND_SOC_DAIFMT_PDM:
+		val_cr2 |= FSL_SAI_CR2_BCP;
+		val_cr4 &= ~FSL_SAI_CR4_MF;
+		sai->is_pdm_mode = true;
+		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		/* To be done */
 	default:
@@ -470,6 +476,13 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	pins = DIV_ROUND_UP(channels, slots);
 
+	/*
+	 * PDM mode, channels are independent
+	 * each channels are on one dataline/FIFO.
+	 */
+	if (sai->is_pdm_mode)
+		pins = channels;
+
 	if (!sai->is_consumer_mode) {
 		if (sai->bclk_ratio)
 			ret = fsl_sai_set_bclk(cpu_dai, tx,
@@ -492,13 +505,13 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (!sai->is_dsp_mode)
+	if (!sai->is_dsp_mode && !sai->is_pdm_mode)
 		val_cr4 |= FSL_SAI_CR4_SYWD(slot_width);
 
 	val_cr5 |= FSL_SAI_CR5_WNW(slot_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(slot_width);
 
-	if (sai->is_lsb_first)
+	if (sai->is_lsb_first || sai->is_pdm_mode)
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
 	else
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 1c8f5ca07f9d..bc2a86a413e1 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -259,6 +259,7 @@ struct fsl_sai {
 	bool is_consumer_mode;
 	bool is_lsb_first;
 	bool is_dsp_mode;
+	bool is_pdm_mode;
 	bool synchronous[2];
 
 	unsigned int mclk_id[2];
-- 
2.17.1

