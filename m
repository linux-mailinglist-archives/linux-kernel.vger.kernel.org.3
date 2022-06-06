Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5964B53EB71
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiFFPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiFFPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:45:12 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACD1F231E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:45:09 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F062D83C61;
        Mon,  6 Jun 2022 17:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1654530307;
        bh=7pWtef+oRH7wX2wP+LnlDhlscbgmm4pckw9tnmWgA/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztmcKReTk1GHbhPwGROPTnYONvPzyAVj7shSwSG9nizeal+BC8hsEWnrxxQHCST7h
         btBJzK06PSfYqpta+LNbFKSEpuMpBFmg90OdTjh7kMw6tXa3yuqOxab/HO8tu+6Rom
         LlHUy9iK7AjlXBD4sRKJuy55AeIhkywDomdIo7zeKufYeQC1WnkNr/UEsT++fGUZoC
         1srU9FNACafHtiH9afs6YEZf0rA/jYpRFc4Ai+bnP9b4MzaOcWBNbmIwSF6fbcNSSp
         lKQNCUOhnvasZHi+RQMFxK8YgwMZwMU4vTm0S6kglp0cYFxokmSyo8wezsUBdqYq9V
         IHJqIcuRHAVFg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/3] ASoC: wm8940: Rewrite code to set proper clocks
Date:   Mon,  6 Jun 2022 17:44:40 +0200
Message-Id: <20220606154441.20848-2-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220606154441.20848-1-lukma@denx.de>
References: <20220606154441.20848-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change, the wm8940 driver is not working when
set_sysclk callback (wm8940_set_dai_sysclk) is called with
freqency not listed in the switch clause.

This change adjusts this driver to allow non-standard frequency
set (just after the boot) being adjusted afterwards by the sound
system core code.

Moreover, support for internal wm8940's PLL is provided, so it
can generate clocks when HOST system is not able to do it.

Code in this commit is based on previous change done for wm8974
(SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/codecs/wm8940.c | 103 ++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 7cea54720436..6fb1c3780439 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -37,7 +37,9 @@
 #include "wm8940.h"
 
 struct wm8940_priv {
-	unsigned int sysclk;
+	unsigned int mclk;
+	unsigned int fs;
+
 	struct regmap *regmap;
 };
 
@@ -387,17 +389,24 @@ static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8940_update_clocks(struct snd_soc_dai *dai);
 static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct wm8940_priv *wm8940 = snd_soc_component_get_drvdata(component);
 	u16 iface = snd_soc_component_read(component, WM8940_IFACE) & 0xFD9F;
 	u16 addcntrl = snd_soc_component_read(component, WM8940_ADDCNTRL) & 0xFFF1;
 	u16 companding =  snd_soc_component_read(component,
 						WM8940_COMPANDINGCTL) & 0xFFDF;
 	int ret;
 
+	wm8940->fs = params_rate(params);
+	ret = wm8940_update_clocks(dai);
+	if (ret)
+		return ret;
+
 	/* LoutR control */
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE
 	    && params_channels(params) == 2)
@@ -496,7 +505,6 @@ static int wm8940_set_bias_level(struct snd_soc_component *component,
 				return ret;
 			}
 		}
-
 		/* ensure bufioen and biasen */
 		pwr_reg |= (1 << 2) | (1 << 3);
 		/* set vmid to 300k for standby */
@@ -611,24 +619,6 @@ static int wm8940_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	return 0;
 }
 
-static int wm8940_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-				 int clk_id, unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = codec_dai->component;
-	struct wm8940_priv *wm8940 = snd_soc_component_get_drvdata(component);
-
-	switch (freq) {
-	case 11289600:
-	case 12000000:
-	case 12288000:
-	case 16934400:
-	case 18432000:
-		wm8940->sysclk = freq;
-		return 0;
-	}
-	return -EINVAL;
-}
-
 static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 				 int div_id, int div)
 {
@@ -653,6 +643,79 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	return ret;
 }
 
+static unsigned int wm8940_get_mclkdiv(unsigned int f_in, unsigned int f_out,
+				       int *mclkdiv)
+{
+	unsigned int ratio = 2 * f_in / f_out;
+
+	if (ratio <= 2) {
+		*mclkdiv = WM8940_MCLKDIV_1;
+		ratio = 2;
+	} else if (ratio == 3) {
+		*mclkdiv = WM8940_MCLKDIV_1_5;
+	} else if (ratio == 4) {
+		*mclkdiv = WM8940_MCLKDIV_2;
+	} else if (ratio <= 6) {
+		*mclkdiv = WM8940_MCLKDIV_3;
+		ratio = 6;
+	} else if (ratio <= 8) {
+		*mclkdiv = WM8940_MCLKDIV_4;
+		ratio = 8;
+	} else if (ratio <= 12) {
+		*mclkdiv = WM8940_MCLKDIV_6;
+		ratio = 12;
+	} else if (ratio <= 16) {
+		*mclkdiv = WM8940_MCLKDIV_8;
+		ratio = 16;
+	} else {
+		*mclkdiv = WM8940_MCLKDIV_12;
+		ratio = 24;
+	}
+
+	return f_out * ratio / 2;
+}
+
+static int wm8940_update_clocks(struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct wm8940_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned int fs256;
+	unsigned int fpll = 0;
+	unsigned int f;
+	int mclkdiv;
+
+	if (!priv->mclk || !priv->fs)
+		return 0;
+
+	fs256 = 256 * priv->fs;
+
+	f = wm8940_get_mclkdiv(priv->mclk, fs256, &mclkdiv);
+	if (f != priv->mclk) {
+		/* The PLL performs best around 90MHz */
+		fpll = wm8940_get_mclkdiv(22500000, fs256, &mclkdiv);
+	}
+
+	wm8940_set_dai_pll(dai, 0, 0, priv->mclk, fpll);
+	wm8940_set_dai_clkdiv(dai, WM8940_MCLKDIV, mclkdiv);
+
+	return 0;
+}
+
+static int wm8940_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct wm8940_priv *priv = snd_soc_component_get_drvdata(component);
+
+	if (dir != SND_SOC_CLOCK_IN)
+		return -EINVAL;
+
+	priv->mclk = freq;
+
+	return wm8940_update_clocks(dai);
+}
+
+
 #define WM8940_RATES SNDRV_PCM_RATE_8000_48000
 
 #define WM8940_FORMATS (SNDRV_PCM_FMTBIT_S8 |				\
-- 
2.20.1

