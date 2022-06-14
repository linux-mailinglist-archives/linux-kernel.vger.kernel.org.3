Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2154A80C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351450AbiFNE0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350441AbiFNEZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:25:36 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F6A2A73C;
        Mon, 13 Jun 2022 21:25:35 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 16D731A2684;
        Tue, 14 Jun 2022 06:25:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 845B71A2674;
        Tue, 14 Jun 2022 06:25:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F004180222A;
        Tue, 14 Jun 2022 12:25:31 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ASoc: fsl_sai: Add pinctrl operation for PDM and DSD
Date:   Tue, 14 Jun 2022 12:11:21 +0800
Message-Id: <1655179884-12278-5-git-send-email-shengjiu.wang@nxp.com>
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

With DSD format, the pinctrl is different compare with
I2S format, because one dataline only has one channel
data, and the codec always mux the LRCLK pin to DSD
data line, and on i.MX8MQ the BCLK pin can route to
codec on DSD case for the MCLK is too high.

Add pinctrl operation that the pinctrl can be switched
on runtime according to the I2S format or DSD format

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 70 +++++++++++++++++++++++++++++++++++------
 sound/soc/fsl/fsl_sai.h |  2 ++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9d2828b55c07..ddfe28cb7df0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -57,6 +58,31 @@ static inline bool fsl_sai_dir_is_synced(struct fsl_sai *sai, int dir)
 	return !sai->synchronous[dir] && sai->synchronous[adir];
 }
 
+static struct pinctrl_state *fsl_sai_get_pins_state(struct fsl_sai *sai, u32 bclk)
+{
+	struct pinctrl_state *state = 0;
+
+	if (sai->is_pdm_mode) {
+		/* DSD512@44.1kHz, DSD512@48kHz */
+		if (bclk >= 22579200)
+			state = pinctrl_lookup_state(sai->pinctrl, "dsd512");
+
+		/* Get default DSD state */
+		if (IS_ERR_OR_NULL(state))
+			state = pinctrl_lookup_state(sai->pinctrl, "dsd");
+	} else {
+		/* 706k32b2c, 768k32b2c, etc */
+		if (bclk >= 45158400)
+			state = pinctrl_lookup_state(sai->pinctrl, "pcm_b2m");
+	}
+
+	/* Get default state */
+	if (IS_ERR_OR_NULL(state))
+		state = pinctrl_lookup_state(sai->pinctrl, "default");
+
+	return state;
+}
+
 static irqreturn_t fsl_sai_isr(int irq, void *devid)
 {
 	struct fsl_sai *sai = (struct fsl_sai *)devid;
@@ -466,7 +492,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	u32 slots = (channels == 1) ? 2 : channels;
 	u32 slot_width = word_width;
 	int adir = tx ? RX : TX;
-	u32 pins;
+	u32 pins, bclk;
 	int ret;
 
 	if (sai->slots)
@@ -484,15 +510,21 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	if (sai->is_pdm_mode)
 		pins = channels;
 
+	bclk = params_rate(params) * (sai->bclk_ratio ? sai->bclk_ratio : slots * slot_width);
+
+	if (!IS_ERR_OR_NULL(sai->pinctrl)) {
+		sai->pins_state = fsl_sai_get_pins_state(sai, bclk);
+		if (!IS_ERR_OR_NULL(sai->pins_state)) {
+			ret = pinctrl_select_state(sai->pinctrl, sai->pins_state);
+			if (ret) {
+				dev_err(cpu_dai->dev, "failed to set proper pins state: %d\n", ret);
+				return ret;
+			}
+		}
+	}
+
 	if (!sai->is_consumer_mode) {
-		if (sai->bclk_ratio)
-			ret = fsl_sai_set_bclk(cpu_dai, tx,
-					       sai->bclk_ratio *
-					       params_rate(params));
-		else
-			ret = fsl_sai_set_bclk(cpu_dai, tx,
-					       slots * slot_width *
-					       params_rate(params));
+		ret = fsl_sai_set_bclk(cpu_dai, tx, bclk);
 		if (ret)
 			return ret;
 
@@ -757,6 +789,23 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
+static int fsl_sai_dai_resume(struct snd_soc_component *component)
+{
+	struct fsl_sai *sai = snd_soc_component_get_drvdata(component);
+	struct device *dev = &sai->pdev->dev;
+	int ret;
+
+	if (!IS_ERR_OR_NULL(sai->pinctrl) && !IS_ERR_OR_NULL(sai->pins_state)) {
+		ret = pinctrl_select_state(sai->pinctrl, sai->pins_state);
+		if (ret) {
+			dev_err(dev, "failed to set proper pins state: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver fsl_sai_dai_template = {
 	.probe = fsl_sai_dai_probe,
 	.playback = {
@@ -782,6 +831,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template = {
 
 static const struct snd_soc_component_driver fsl_component = {
 	.name           = "fsl-sai",
+	.resume         = fsl_sai_dai_resume,
 };
 
 static struct reg_default fsl_sai_reg_defaults_ofs0[] = {
@@ -1147,6 +1197,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
 	sai->dma_params_tx.maxburst = FSL_SAI_MAXBURST_TX;
 
+	sai->pinctrl = devm_pinctrl_get(&pdev->dev);
+
 	platform_set_drvdata(pdev, sai);
 	pm_runtime_enable(dev);
 	if (!pm_runtime_enabled(dev)) {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index e28a49ce12ef..c0b6bc42fc3c 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -278,6 +278,8 @@ struct fsl_sai {
 	struct fsl_sai_verid verid;
 	struct fsl_sai_param param;
 	struct pm_qos_request pm_qos_req;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_state;
 };
 
 #define TX 1
-- 
2.17.1

