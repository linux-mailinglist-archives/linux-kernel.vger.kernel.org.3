Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2238B5A1369
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiHYOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbiHYOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:22:45 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C2B5156
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:22:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661437362; bh=5RGgH1AcjF5BtsgHx+ZoU5Me0+YKLfaL9/ywuzhYSio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SYyOmV2P5l7WMaWO/z5fBxhZuxZpcmFDcNLB/3Vj+yLexFc/x98roK9dYw4NbNWIk
         xxyWH6utfs7iE0IF6RTOGYSJiRlkcdXdhbRAibmKNDYsAPYZ+i+HNgBwvVGubkmCv7
         koH8M+uW3wkHWwmy55xkqXtbs/dHDBE6JV2hOPRM=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Stephen Kitt <steve@sk2.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: tas2562: Fix mute/unmute
Date:   Thu, 25 Aug 2022 16:22:26 +0200
Message-Id: <20220825142226.80929-3-povik+lin@cutebit.org>
In-Reply-To: <20220825142226.80929-1-povik+lin@cutebit.org>
References: <20220825142226.80929-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the PWR_CTRL field is modeled as the power state of the DAC
widget, and at the same time it is used to implement mute/unmute, we
need some additional book-keeping to have the right end result no matter
the sequence of calls. Without this fix, one permanently mutes an
ongoing stream by toggling the associated speaker pin control.

(This mirrors commit 1e5907bcb3a3 ("ASoC: tas2770: Fix handling of
mute/unmute") which was a fix to the tas2770 driver.)

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2562.c | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 2b0cdb6d1600..66149055aba9 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -54,6 +54,8 @@ struct tas2562_data {
 	int i_sense_slot;
 	int volume_lvl;
 	int model_id;
+	bool dac_powered;
+	bool unmuted;
 };
 
 enum tas256x_model {
@@ -351,30 +353,43 @@ static int tas2562_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int tas2562_update_pwr_ctrl(struct tas2562_data *tas2562)
+{
+	struct snd_soc_component *component = tas2562->component;
+	unsigned int val;
+	int ret;
+
+	if (tas2562->dac_powered)
+		val = tas2562->unmuted ?
+			TAS2562_ACTIVE : TAS2562_MUTE;
+	else
+		val = TAS2562_SHUTDOWN;
+
+	ret = snd_soc_component_update_bits(component, TAS2562_PWR_CTRL,
+					    TAS2562_MODE_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int tas2562_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
-	struct snd_soc_component *component = dai->component;
+	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(dai->component);
 
-	return snd_soc_component_update_bits(component, TAS2562_PWR_CTRL,
-					     TAS2562_MODE_MASK,
-					     mute ? TAS2562_MUTE : 0);
+	tas2562->unmuted = !mute;
+	return tas2562_update_pwr_ctrl(tas2562);
 }
 
 static int tas2562_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
-	int ret;
 
 	tas2562->component = component;
 
 	if (tas2562->sdz_gpio)
 		gpiod_set_value_cansleep(tas2562->sdz_gpio, 1);
 
-	ret = snd_soc_component_update_bits(component, TAS2562_PWR_CTRL,
-					    TAS2562_MODE_MASK, TAS2562_MUTE);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -428,30 +443,18 @@ static int tas2562_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		ret = snd_soc_component_update_bits(component,
-			TAS2562_PWR_CTRL,
-			TAS2562_MODE_MASK,
-			TAS2562_MUTE);
-		if (ret)
-			goto end;
+		tas2562->dac_powered = true;
+		ret = tas2562_update_pwr_ctrl(tas2562);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		ret = snd_soc_component_update_bits(component,
-			TAS2562_PWR_CTRL,
-			TAS2562_MODE_MASK,
-			TAS2562_SHUTDOWN);
-		if (ret)
-			goto end;
+		tas2562->dac_powered = false;
+		ret = tas2562_update_pwr_ctrl(tas2562);
 		break;
 	default:
 		dev_err(tas2562->dev, "Not supported evevt\n");
 		return -EINVAL;
 	}
 
-end:
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
2.33.0

