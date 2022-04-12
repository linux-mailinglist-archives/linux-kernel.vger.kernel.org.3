Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A604FDC63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiDLKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380373AbiDLKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:20:29 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7212606
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:24:34 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FD681A227D;
        Tue, 12 Apr 2022 11:24:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE26E1A224E;
        Tue, 12 Apr 2022 11:24:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF84E184BDC5;
        Tue, 12 Apr 2022 17:24:31 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: [PATCH] ASoC: wm8524: remove rate constraint for FE-BE case
Date:   Tue, 12 Apr 2022 17:13:46 +0800
Message-Id: <1649754826-2651-1-git-send-email-shengjiu.wang@nxp.com>
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

The constraint is propagate to Front End Bitstream
for Front End and Back End share same snd_soc_pcm_runtime.

The constraint is not needed for Back End Bitstream
when there is be_hw_params_fixup() defined.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Tested-by: Fabio Estevam <festevam@denx.de>
---
 sound/soc/codecs/wm8524.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index 81f858f6bd67..442a59857875 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -61,6 +61,7 @@ static int wm8524_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8524_priv *wm8524 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	/* The set of sample rates that can be supported depends on the
 	 * MCLK supplied to the CODEC - enforce this.
@@ -71,9 +72,10 @@ static int wm8524_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_pcm_hw_constraint_list(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_RATE,
-				   &wm8524->rate_constraint);
+	if (!rtd->dai_link->be_hw_params_fixup)
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   &wm8524->rate_constraint);
 
 	gpiod_set_value_cansleep(wm8524->mute, 1);
 
-- 
2.17.1

