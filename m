Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFA5A1366
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiHYOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbiHYOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:22:45 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A11B4400
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:22:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661437361; bh=snL9pkaE4f5TuEA4/RFJEkEJWue+6V9/ZNAvLVwijxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HeX9EviMcDrqL8Cp3o0I0NsZip/wP6cx8O7XI+5Ljhjl/6Z/SFWupEWE9YXv94xr5
         by5BUoeZ5p1lkrA6B4QHDvACKQx66lA5uSt9vj0SzOH9Iv/f25WY6E8A60Jq468iC1
         2RS9jmNXinNuBKItlDGDRxdntaLPcgp9G1ydugIs=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Stephen Kitt <steve@sk2.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: tas2562: Drop conflicting set_bias_level power setting
Date:   Thu, 25 Aug 2022 16:22:25 +0200
Message-Id: <20220825142226.80929-2-povik+lin@cutebit.org>
In-Reply-To: <20220825142226.80929-1-povik+lin@cutebit.org>
References: <20220825142226.80929-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is setting the PWR_CTRL field in both the set_bias_level
callback and on DAPM events of the DAC widget (and also in the
mute_stream method). Drop the set_bias_level callback altogether as the
power setting it does is in conflict with the other code paths.

(This mirrors commit c8a6ae3fe1c8 ("ASoC: tas2770: Drop conflicting
set_bias_level power setting") which was a fix to the tas2770 driver.)

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2562.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index dc088a1c6721..2b0cdb6d1600 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -63,39 +63,6 @@ enum tas256x_model {
 	TAS2110,
 };
 
-static int tas2562_set_bias_level(struct snd_soc_component *component,
-				 enum snd_soc_bias_level level)
-{
-	struct tas2562_data *tas2562 =
-			snd_soc_component_get_drvdata(component);
-
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		snd_soc_component_update_bits(component,
-			TAS2562_PWR_CTRL,
-			TAS2562_MODE_MASK, TAS2562_ACTIVE);
-		break;
-	case SND_SOC_BIAS_STANDBY:
-	case SND_SOC_BIAS_PREPARE:
-		snd_soc_component_update_bits(component,
-			TAS2562_PWR_CTRL,
-			TAS2562_MODE_MASK, TAS2562_MUTE);
-		break;
-	case SND_SOC_BIAS_OFF:
-		snd_soc_component_update_bits(component,
-			TAS2562_PWR_CTRL,
-			TAS2562_MODE_MASK, TAS2562_SHUTDOWN);
-		break;
-
-	default:
-		dev_err(tas2562->dev,
-				"wrong power level setting %d\n", level);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int tas2562_set_samplerate(struct tas2562_data *tas2562, int samplerate)
 {
 	int samp_rate;
@@ -579,7 +546,6 @@ static const struct snd_soc_component_driver soc_component_dev_tas2110 = {
 	.probe			= tas2562_codec_probe,
 	.suspend		= tas2562_suspend,
 	.resume			= tas2562_resume,
-	.set_bias_level		= tas2562_set_bias_level,
 	.controls		= tas2562_snd_controls,
 	.num_controls		= ARRAY_SIZE(tas2562_snd_controls),
 	.dapm_widgets		= tas2110_dapm_widgets,
@@ -618,7 +584,6 @@ static const struct snd_soc_component_driver soc_component_dev_tas2562 = {
 	.probe			= tas2562_codec_probe,
 	.suspend		= tas2562_suspend,
 	.resume			= tas2562_resume,
-	.set_bias_level		= tas2562_set_bias_level,
 	.controls		= tas2562_snd_controls,
 	.num_controls		= ARRAY_SIZE(tas2562_snd_controls),
 	.dapm_widgets		= tas2562_dapm_widgets,
-- 
2.33.0

