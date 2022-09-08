Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD75B15FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiIHHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiIHHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:50:06 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE50E5465E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:50:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 94F331A0EDB;
        Thu,  8 Sep 2022 09:50:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 686241A0ED8;
        Thu,  8 Sep 2022 09:50:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 465B0180031F;
        Thu,  8 Sep 2022 15:50:00 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak4458: Remove component probe() and remove()
Date:   Thu,  8 Sep 2022 15:31:56 +0800
Message-Id: <1662622316-23426-1-git-send-email-shengjiu.wang@nxp.com>
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

Most function in ak4458_probe() and ak4458_remove() are
duplicate with dai ops, so remove them and move dsd_path
setting to dai ops.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 53 ++++++---------------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index ea33cc83c86c..b534212096ee 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -447,6 +447,13 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, AK4458_0B_CONTROL7,
 				      AK4458_DCHAIN_MASK, dchn);
 
+	if (ak4458->drvdata->type == AK4497) {
+		ret = snd_soc_component_update_bits(component, AK4458_09_DSD2,
+						    0x4, (ak4458->dsd_path << 2));
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = ak4458_rstn_control(component, 0);
 	if (ret)
 		return ret;
@@ -629,48 +636,6 @@ static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
 	}
 }
 
-static int ak4458_init(struct snd_soc_component *component)
-{
-	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	/* External Mute ON */
-	if (ak4458->mute_gpiod)
-		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
-
-	ak4458_reset(ak4458, false);
-
-	ret = snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
-			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
-	if (ret < 0)
-		return ret;
-
-	if (ak4458->drvdata->type == AK4497) {
-		ret = snd_soc_component_update_bits(component, AK4458_09_DSD2,
-						    0x4, (ak4458->dsd_path << 2));
-		if (ret < 0)
-			return ret;
-	}
-
-	return ak4458_rstn_control(component, 1);
-}
-
-static int ak4458_probe(struct snd_soc_component *component)
-{
-	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-
-	ak4458->fs = 48000;
-
-	return ak4458_init(component);
-}
-
-static void ak4458_remove(struct snd_soc_component *component)
-{
-	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-
-	ak4458_reset(ak4458, true);
-}
-
 #ifdef CONFIG_PM
 static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
 {
@@ -714,8 +679,6 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
-	.probe			= ak4458_probe,
-	.remove			= ak4458_remove,
 	.controls		= ak4458_snd_controls,
 	.num_controls		= ARRAY_SIZE(ak4458_snd_controls),
 	.dapm_widgets		= ak4458_dapm_widgets,
@@ -728,8 +691,6 @@ static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
 };
 
 static const struct snd_soc_component_driver soc_codec_dev_ak4497 = {
-	.probe			= ak4458_probe,
-	.remove			= ak4458_remove,
 	.controls		= ak4497_snd_controls,
 	.num_controls		= ARRAY_SIZE(ak4497_snd_controls),
 	.dapm_widgets		= ak4497_dapm_widgets,
-- 
2.34.1

