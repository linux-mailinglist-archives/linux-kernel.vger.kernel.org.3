Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6795B2D36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIIED1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIIEDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:03:21 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713882F84
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:03:19 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B81A203AC1;
        Fri,  9 Sep 2022 06:03:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C51E4203AD3;
        Fri,  9 Sep 2022 06:03:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 17D9D1820F59;
        Fri,  9 Sep 2022 12:03:16 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: fsl_asrc: Add initialization finishing check in runtime resume
Date:   Fri,  9 Sep 2022 11:44:58 +0800
Message-Id: <1662695098-24602-1-git-send-email-shengjiu.wang@nxp.com>
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

If the initialization is not finished, then filling input data to
the FIFO may fail. So it is better to add initialization finishing
check in the runtime resume for suspend & resume case.

And consider the case of three instances working in parallel,
increase the retry times to 50 for more initialization time.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Nicolin Chen <nicolinc@gmail.com>
---
changes in v3:
- update warning message.

changes in v2:
- update comments.

 sound/soc/fsl/fsl_asrc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index aa5edf32d988..936aef5d2767 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -20,6 +20,7 @@
 
 #define IDEAL_RATIO_DECIMAL_DEPTH 26
 #define DIVIDER_NUM  64
+#define INIT_RETRY_NUM 50
 
 #define pair_err(fmt, ...) \
 	dev_err(&asrc->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
@@ -27,6 +28,9 @@
 #define pair_dbg(fmt, ...) \
 	dev_dbg(&asrc->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
 
+#define pair_warn(fmt, ...) \
+	dev_warn(&asrc->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
+
 /* Corresponding to process_option */
 static unsigned int supported_asrc_rate[] = {
 	5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
@@ -579,7 +583,7 @@ static void fsl_asrc_start_pair(struct fsl_asrc_pair *pair)
 {
 	struct fsl_asrc *asrc = pair->asrc;
 	enum asrc_pair_index index = pair->index;
-	int reg, retry = 10, i;
+	int reg, retry = INIT_RETRY_NUM, i;
 
 	/* Enable the current pair */
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
@@ -592,6 +596,10 @@ static void fsl_asrc_start_pair(struct fsl_asrc_pair *pair)
 		reg &= ASRCFG_INIRQi_MASK(index);
 	} while (!reg && --retry);
 
+	/* NOTE: Doesn't treat initialization timeout as an error */
+	if (!retry)
+		pair_warn("initialization isn't finished\n");
+
 	/* Make the input fifo to ASRC STALL level */
 	regmap_read(asrc->regmap, REG_ASRCNCR, &reg);
 	for (i = 0; i < pair->channels * 4; i++)
@@ -1257,6 +1265,7 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *asrc = dev_get_drvdata(dev);
 	struct fsl_asrc_priv *asrc_priv = asrc->private;
+	int reg, retry = INIT_RETRY_NUM;
 	int i, ret;
 	u32 asrctr;
 
@@ -1295,6 +1304,24 @@ static int fsl_asrc_runtime_resume(struct device *dev)
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
 
+	/* Wait for status of initialization for all enabled pairs */
+	do {
+		udelay(5);
+		regmap_read(asrc->regmap, REG_ASRCFG, &reg);
+		reg = (reg >> ASRCFG_INIRQi_SHIFT(0)) & 0x7;
+	} while ((reg != ((asrctr >> ASRCTR_ASRCEi_SHIFT(0)) & 0x7)) && --retry);
+
+	/*
+	 * NOTE: Doesn't treat initialization timeout as an error
+	 * Some of the pairs may success, then still can continue.
+	 */
+	if (!retry) {
+		for (i = ASRC_PAIR_A; i < ASRC_PAIR_MAX_NUM; i++) {
+			if ((asrctr & ASRCTR_ASRCEi_MASK(i)) && !(reg & (1 << i)))
+				dev_warn(dev, "Pair %c initialization isn't finished\n", 'A' + i);
+		}
+	}
+
 	return 0;
 
 disable_asrck_clk:
-- 
2.34.1

