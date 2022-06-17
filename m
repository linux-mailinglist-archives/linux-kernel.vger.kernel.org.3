Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62954F258
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380754AbiFQH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380702AbiFQH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:59:21 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DB5A2D8;
        Fri, 17 Jun 2022 00:59:20 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D230E201FAC;
        Fri, 17 Jun 2022 09:59:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 87E63201FA1;
        Fri, 17 Jun 2022 09:59:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 293381820F45;
        Fri, 17 Jun 2022 15:59:17 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] ASoC: fsl_sai: Add support for more sample rates
Date:   Fri, 17 Jun 2022 15:44:33 +0800
Message-Id: <1655451877-16382-4-git-send-email-shengjiu.wang@nxp.com>
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

