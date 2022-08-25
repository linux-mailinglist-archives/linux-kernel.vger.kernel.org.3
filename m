Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307125A12ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiHYODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiHYOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:02:59 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E6A8327
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:02:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661436172; bh=PsCam++xDona5BVDShW7mfj5kX/puOVnGoX+XMGkuc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r31WAVO2XWASiv4N/KJcm/d/M9XAJsD7XFnrJl5o758Se1fe0WQIwxSkjIsVOH5ON
         e8LgKJb+uuhADj085h44Fm4WYlFXHOwzPYJ2e2IAOiehHONsugUmqaPGVO5q9VzE8v
         pGpVTLB8SLg0x9dZdNsml/t7IVBivF031WRMC044=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 3/5] ASoC: tas2764: Fix mute/unmute
Date:   Thu, 25 Aug 2022 16:02:39 +0200
Message-Id: <20220825140241.53963-4-povik+lin@cutebit.org>
In-Reply-To: <20220825140241.53963-1-povik+lin@cutebit.org>
References: <20220825140241.53963-1-povik+lin@cutebit.org>
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

Because the PWR_CTRL field is modeled as the power state of the DAC
widget, and at the same time it is used to implement mute/unmute, we
need some additional book-keeping to have the right end result no matter
the sequence of calls. Without this fix, one permanently mutes an
ongoing stream by toggling the associated speaker pin control.

(This mirrors commit 1e5907bcb3a3 ("ASoC: tas2770: Fix handling of
mute/unmute") which was a fix to the tas2770 driver.)

Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2764.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index f4ac6edefdc0..39902f77a2e0 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -34,6 +34,9 @@ struct tas2764_priv {
 	
 	int v_sense_slot;
 	int i_sense_slot;
+
+	bool dac_powered;
+	bool unmuted;
 };
 
 static void tas2764_reset(struct tas2764_priv *tas2764)
@@ -50,6 +53,26 @@ static void tas2764_reset(struct tas2764_priv *tas2764)
 	usleep_range(1000, 2000);
 }
 
+static int tas2764_update_pwr_ctrl(struct tas2764_priv *tas2764)
+{
+	struct snd_soc_component *component = tas2764->component;
+	unsigned int val;
+	int ret;
+
+	if (tas2764->dac_powered)
+		val = tas2764->unmuted ?
+			TAS2764_PWR_CTRL_ACTIVE : TAS2764_PWR_CTRL_MUTE;
+	else
+		val = TAS2764_PWR_CTRL_SHUTDOWN;
+
+	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
+					    TAS2764_PWR_CTRL_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int tas2764_codec_suspend(struct snd_soc_component *component)
 {
@@ -82,9 +105,7 @@ static int tas2764_codec_resume(struct snd_soc_component *component)
 		usleep_range(1000, 2000);
 	}
 
-	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-					    TAS2764_PWR_CTRL_MASK,
-					    TAS2764_PWR_CTRL_ACTIVE);
+	ret = tas2764_update_pwr_ctrl(tas2764);
 
 	if (ret < 0)
 		return ret;
@@ -118,14 +139,12 @@ static int tas2764_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-						    TAS2764_PWR_CTRL_MASK,
-						    TAS2764_PWR_CTRL_MUTE);
+		tas2764->dac_powered = true;
+		ret = tas2764_update_pwr_ctrl(tas2764);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-						    TAS2764_PWR_CTRL_MASK,
-						    TAS2764_PWR_CTRL_SHUTDOWN);
+		tas2764->dac_powered = false;
+		ret = tas2764_update_pwr_ctrl(tas2764);
 		break;
 	default:
 		dev_err(tas2764->dev, "Unsupported event\n");
@@ -170,17 +189,11 @@ static const struct snd_soc_dapm_route tas2764_audio_map[] = {
 
 static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
-	struct snd_soc_component *component = dai->component;
-	int ret;
-
-	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-					    TAS2764_PWR_CTRL_MASK,
-					    mute ? TAS2764_PWR_CTRL_MUTE : 0);
+	struct tas2764_priv *tas2764 =
+			snd_soc_component_get_drvdata(dai->component);
 
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	tas2764->unmuted = !mute;
+	return tas2764_update_pwr_ctrl(tas2764);
 }
 
 static int tas2764_set_bitwidth(struct tas2764_priv *tas2764, int bitwidth)
@@ -494,12 +507,6 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-					    TAS2764_PWR_CTRL_MASK,
-					    TAS2764_PWR_CTRL_MUTE);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
2.33.0

