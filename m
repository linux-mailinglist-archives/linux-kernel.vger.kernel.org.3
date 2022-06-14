Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9E54A80F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351321AbiFNE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349712AbiFNEZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:25:35 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B02AC52;
        Mon, 13 Jun 2022 21:25:34 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A215C2026FE;
        Tue, 14 Jun 2022 06:25:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 57D96202717;
        Tue, 14 Jun 2022 06:25:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 720D8180219B;
        Tue, 14 Jun 2022 12:25:30 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] ASoC: fsl_sai: Add support for more sample rates
Date:   Tue, 14 Jun 2022 12:11:20 +0800
Message-Id: <1655179884-12278-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for more sample rates, because PDM format
bitstream has higher sample rates. for example DSD512
format, the bit clock is 22.5792MHz, if the word width
is U8_LE, then the max sample rate is 2822400.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d11ee3b6f163..9d2828b55c07 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -30,7 +30,8 @@
 static const unsigned int fsl_sai_rates[] = {
 	8000, 11025, 12000, 16000, 22050,
 	24000, 32000, 44100, 48000, 64000,
-	88200, 96000, 176400, 192000
+	88200, 96000, 176400, 192000, 352800,
+	384000, 705600, 768000, 1411200, 2822400,
 };
 
 static const struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
@@ -763,7 +764,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template = {
 		.channels_min = 1,
 		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 192000,
+		.rate_max = 2822400,
 		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = FSL_SAI_FORMATS,
 	},
@@ -772,7 +773,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template = {
 		.channels_min = 1,
 		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 192000,
+		.rate_max = 2822400,
 		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = FSL_SAI_FORMATS,
 	},
-- 
2.17.1

