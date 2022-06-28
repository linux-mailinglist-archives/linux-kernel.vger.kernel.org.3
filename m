Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE055DDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbiF1Iye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241584AbiF1Iyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:54:32 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B42DA80
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:54:31 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F98D2027B3;
        Tue, 28 Jun 2022 10:54:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 66FCA2027C9;
        Tue, 28 Jun 2022 10:54:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A9FD1802204;
        Tue, 28 Jun 2022 16:54:29 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_micfil: change micfil default settings
Date:   Tue, 28 Jun 2022 16:39:49 +0800
Message-Id: <1656405589-29850-1-git-send-email-shengjiu.wang@nxp.com>
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

Previous default settings resulted in loose dynamic
range and low sound level.
New default configuration changes:
- outgain = 2
- quality mode = VLOW0
- dc remover = bypass

Signed-off-by: Irina Patru <ioana-irina.patru@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 22 ++++++++++++++++++----
 sound/soc/fsl/fsl_micfil.h |  9 +++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 25c647ae080a..18ab80b68752 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -48,6 +48,7 @@ struct fsl_micfil {
 	char name[32];
 	int irq[MICFIL_IRQ_LINES];
 	enum quality quality;
+	int dc_remover;
 };
 
 struct fsl_micfil_soc_data {
@@ -336,12 +337,25 @@ static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
-	int ret;
+	struct device *dev = cpu_dai->dev;
+	unsigned int val = 0;
+	int ret, i;
+
+	micfil->quality = QUALITY_VLOW0;
 
-	micfil->quality = QUALITY_MEDIUM;
+	/* set default gain to 2 */
+	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL, 0x22222222);
 
-	/* set default gain to max_gain */
-	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL, 0x77777777);
+	/* set DC Remover in bypass mode*/
+	for (i = 0; i < MICFIL_OUTPUT_CHANNELS; i++)
+		val |= MICFIL_DC_BYPASS << MICFIL_DC_CHX_SHIFT(i);
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_DC_CTRL,
+				 MICFIL_DC_CTRL_CONFIG, val);
+	if (ret) {
+		dev_err(dev, "failed to set DC Remover mode bits\n");
+		return ret;
+	}
+	micfil->dc_remover = MICFIL_DC_BYPASS;
 
 	snd_soc_dai_init_dma_data(cpu_dai, NULL,
 				  &micfil->dma_params_rx);
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index 053caba3caf3..d60285dd07bc 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -73,6 +73,15 @@
 #define MICFIL_FIFO_STAT_FIFOX_OVER(ch)	BIT(ch)
 #define MICFIL_FIFO_STAT_FIFOX_UNDER(ch)	BIT((ch) + 8)
 
+/* MICFIL DC Remover Control Register -- REG_MICFIL_DC_CTRL */
+#define MICFIL_DC_CTRL_CONFIG          GENMASK(15, 0)
+#define MICFIL_DC_CHX_SHIFT(ch)        ((ch) << 1)
+#define MICFIL_DC_CHX(ch)              GENMASK((((ch) << 1) + 1), ((ch) << 1))
+#define MICFIL_DC_CUTOFF_21HZ          0
+#define MICFIL_DC_CUTOFF_83HZ          1
+#define MICFIL_DC_CUTOFF_152Hz         2
+#define MICFIL_DC_BYPASS               3
+
 /* MICFIL HWVAD0 Control 1 Register -- REG_MICFIL_VAD0_CTRL1*/
 #define MICFIL_VAD0_CTRL1_CHSEL		GENMASK(26, 24)
 #define MICFIL_VAD0_CTRL1_CICOSR	GENMASK(19, 16)
-- 
2.17.1

