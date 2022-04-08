Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D64F8DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiDHENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiDHENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:13:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D24216F98
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:11:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so10819270pjn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgE3wbd8GWxUwcZlMMJCOiqXfWOa+RmugyiQ1vQxym8=;
        b=njZdvK92wEilmvL7t7vRRKjeqr4w30VWtXDcmFut7xqKzZP7odL3hIX6LOogb2vFTZ
         PjEmZxtW5mGRdfaa/yZSgeiCESp8Y2rE5pNu/aECUlFURPn9c7o6LIMretP+4Yzb+9cy
         ajcGb/aTqdKO7p14z3xLNYNmGyiIb4j3zgCAoRwmgKB5vT7m/RO0q9QtRJOiNz6CmuUo
         tjO4euOBllPgCFXLvlvUX6ZBIifiaKrGECmIBsoUWpz2ZJbwjKPCMf7ZJnmGW6xTzbSb
         EvMXAZNphQJZmubDVn/k4X5qGHOQ7t8iPiLK3XvZboUhQJKrav7xK/G5asrcOpXTUDi4
         O8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgE3wbd8GWxUwcZlMMJCOiqXfWOa+RmugyiQ1vQxym8=;
        b=2FLNUBD5H3/TUZzOocvNkmIsAI7N9tOJ67tW4qCV+sLBrEpROEjA4hhAiccCAblOZP
         fUdYiseWVeBynaylRcOou2aPgqRb/7kXcXnDiOWFPethxSpfBsV37e11O5llmk/K/RfH
         5dZz2Ahbl3dqW23S/2/PjffIEd1p4D8/IL+AsV8wSI/i+JYwSGl1NlIc6A0yR1XobKCc
         iMzAjEhzkaMbtVIGYjK8ID4EPXE5ptOzbgMiSwX76yQwNC1pMcP9E3qsPi9jMi81qR8k
         2mOqL8JA1HNvucgudUrjYcfpun2RwuVSQ6mT4D6t/i4UG01HRLJqT1JIEuVWLnYWigCs
         /6jw==
X-Gm-Message-State: AOAM531EJA6sTkGIo4YFxXRkyWtpzgzHloFTyMRtWeNb49gqXur8SzHz
        MJUZUPAK+NQZ+DiUbMr5H2Y=
X-Google-Smtp-Source: ABdhPJxSOtf5Ltl/mpS/RxxQnaUscbsMRh11+co0VPaGi3dvNuxJIvHcQH6NxN6lvsAoULPvLUm//Q==
X-Received: by 2002:a17:902:f64d:b0:151:3895:46bf with SMTP id m13-20020a170902f64d00b00151389546bfmr17409261plg.31.1649391093419;
        Thu, 07 Apr 2022 21:11:33 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090a3d4500b001c97528521asm10365636pjf.6.2022.04.07.21.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 21:11:32 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] ASoC: soc-card: Create jack kcontrol without pins
Date:   Fri,  8 Apr 2022 13:11:14 +0900
Message-Id: <20220408041114.6024-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_card_jack_new() allowed to create jack kcontrol without pins,
but did not create kcontrols. The jack would not have kcontrols if pins
were not going to be added.

This renames the old snd_soc_card_jack_new() to
snd_soc_card_jack_new_pins() for use when pins are provided or will be
added later. The new snd_soc_card_jack_new() appropriately creates a
jack for use without pins and adds a kcontrol.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 drivers/staging/greybus/audio_codec.c         | 12 ++--
 include/sound/soc-card.h                      |  7 ++-
 sound/soc/amd/acp-da7219-max98357a.c          |  4 +-
 sound/soc/amd/acp-rt5645.c                    |  2 +-
 sound/soc/amd/acp/acp-mach-common.c           |  4 +-
 sound/soc/amd/acp3x-rt5682-max9836.c          |  2 +-
 sound/soc/amd/vangogh/acp5x-mach.c            |  8 +--
 sound/soc/codecs/cs43130.c                    |  2 +-
 sound/soc/fsl/imx-es8328.c                    |  2 +-
 sound/soc/fsl/imx-hdmi.c                      |  5 +-
 sound/soc/generic/simple-card-utils.c         |  5 +-
 sound/soc/intel/boards/bdw-rt5650.c           |  6 +-
 sound/soc/intel/boards/bdw-rt5677.c           |  4 +-
 sound/soc/intel/boards/broadwell.c            |  2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c |  5 +-
 sound/soc/intel/boards/bxt_rt298.c            |  5 +-
 sound/soc/intel/boards/bytcht_cx2072x.c       | 10 ++--
 sound/soc/intel/boards/bytcht_es8316.c        |  8 +--
 sound/soc/intel/boards/bytcr_rt5640.c         | 24 ++++----
 sound/soc/intel/boards/bytcr_rt5651.c         |  7 ++-
 sound/soc/intel/boards/bytcr_wm5102.c         |  6 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c  | 10 ++--
 sound/soc/intel/boards/cht_bsw_nau8824.c      |  4 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c       |  6 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c       | 12 ++--
 sound/soc/intel/boards/cml_rt1011_rt5682.c    |  5 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c |  5 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c |  5 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  |  5 +-
 sound/soc/intel/boards/kbl_rt5660.c           | 15 +++--
 sound/soc/intel/boards/kbl_rt5663_max98927.c  |  7 +--
 .../intel/boards/kbl_rt5663_rt5514_max98927.c |  7 +--
 sound/soc/intel/boards/skl_hda_dsp_common.c   |  8 +--
 .../soc/intel/boards/skl_nau88l25_max98357a.c |  6 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |  6 +-
 sound/soc/intel/boards/skl_rt286.c            |  5 +-
 sound/soc/intel/boards/sof_cs42l42.c          |  5 +-
 sound/soc/intel/boards/sof_da7219_max98373.c  |  2 +-
 sound/soc/intel/boards/sof_es8336.c           |  8 +--
 sound/soc/intel/boards/sof_nau8825.c          |  2 +-
 sound/soc/intel/boards/sof_rt5682.c           |  5 +-
 sound/soc/intel/boards/sof_sdw_rt5682.c       | 14 ++---
 sound/soc/intel/boards/sof_sdw_rt700.c        | 14 ++---
 sound/soc/intel/boards/sof_sdw_rt711.c        | 14 ++---
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c   | 14 ++---
 sound/soc/intel/boards/sof_ssp_amp.c          |  3 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c   |  8 +--
 .../mediatek/mt8173/mt8173-rt5650-rt5514.c    |  2 +-
 .../mediatek/mt8173/mt8173-rt5650-rt5676.c    |  2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c     |  4 +-
 .../mediatek/mt8183/mt8183-da7219-max98357.c  |  5 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |  5 +-
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      |  4 +-
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      |  6 +-
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      |  6 +-
 sound/soc/pxa/hx4700.c                        |  6 +-
 sound/soc/pxa/palm27x.c                       |  7 ++-
 sound/soc/pxa/ttc-dkb.c                       | 14 +++--
 sound/soc/pxa/z2.c                            |  7 ++-
 sound/soc/qcom/apq8016_sbc.c                  |  2 +-
 sound/soc/qcom/sc7180.c                       |  4 +-
 sound/soc/qcom/sc7280.c                       |  4 +-
 sound/soc/qcom/sdm845.c                       |  2 +-
 sound/soc/qcom/sm8250.c                       |  2 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |  8 +--
 sound/soc/rockchip/rk3399_gru_sound.c         | 16 +++---
 sound/soc/rockchip/rockchip_max98090.c        | 16 +++---
 sound/soc/rockchip/rockchip_rt5645.c          |  2 +-
 sound/soc/samsung/aries_wm8994.c              |  4 +-
 sound/soc/samsung/h1940_uda1380.c             |  3 +-
 sound/soc/samsung/littlemill.c                |  2 +-
 sound/soc/samsung/lowland.c                   |  9 +--
 sound/soc/samsung/midas_wm1811.c              |  2 +-
 sound/soc/samsung/rx1950_uda1380.c            |  3 +-
 sound/soc/samsung/smartq_wm8987.c             |  8 +--
 sound/soc/samsung/speyside.c                  | 10 ++--
 sound/soc/samsung/tobermory.c                 |  8 +--
 sound/soc/soc-card.c                          | 56 ++++++++++++++-----
 sound/soc/soc-jack.c                          |  2 +-
 sound/soc/tegra/tegra_asoc_machine.c          | 30 +++++-----
 sound/soc/tegra/tegra_wm8903.c                | 10 ++--
 sound/soc/ti/ams-delta.c                      |  4 +-
 sound/soc/ti/omap-abe-twl6040.c               |  8 +--
 sound/soc/ti/omap-twl4030.c                   |  8 +--
 sound/soc/ti/rx51.c                           |  2 +-
 85 files changed, 319 insertions(+), 299 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6b1d03..db0b600ee5d1 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -702,8 +702,9 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 
 	headset->pin = module->jack_name;
 	headset->mask = module->jack_mask;
-	ret = snd_soc_card_jack_new(card, module->jack_name, module->jack_mask,
-				    &module->headset.jack, headset, 1);
+	ret = snd_soc_card_jack_new_pins(card, module->jack_name,
+					 module->jack_mask,
+					 &module->headset.jack, headset, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create new jack\n");
 		return ret;
@@ -725,9 +726,10 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 
 	button->pin = module->button_name;
 	button->mask = module->button_mask;
-	ret = snd_soc_card_jack_new(card, module->button_name,
-				    module->button_mask, &module->button.jack,
-				    button, 1);
+	ret = snd_soc_card_jack_new_pins(card, module->button_name,
+					 module->button_mask,
+					 &module->button.jack,
+					 button, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create button jack\n");
 		goto free_jacks;
diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index 4f2cc4fb56b7..df08573bd80c 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -16,8 +16,11 @@ enum snd_soc_card_subclass {
 struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 					       const char *name);
 int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
-			  struct snd_soc_jack *jack,
-			  struct snd_soc_jack_pin *pins, unsigned int num_pins);
+			  struct snd_soc_jack *jack);
+int snd_soc_card_jack_new_pins(struct snd_soc_card *card, const char *id,
+			       int type, struct snd_soc_jack *jack,
+			       struct snd_soc_jack_pin *pins,
+			       unsigned int num_pins);
 
 int snd_soc_card_suspend_pre(struct snd_soc_card *card);
 int snd_soc_card_suspend_post(struct snd_soc_card *card);
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3bf86c2424ae..ef1b4cefc273 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -71,7 +71,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&cz_jack, NULL, 0);
+				&cz_jack);
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
@@ -151,7 +151,7 @@ static int cz_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &cz_jack, NULL, 0);
+				    &cz_jack);
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index a79a46646d50..532aa98a2241 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -80,7 +80,7 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&cz_jack, NULL, 0);
+				&cz_jack);
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index caa202f7864e..51adb8f3f83e 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -145,7 +145,7 @@ static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &pco_jack, NULL, 0);
+				    &pco_jack);
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
@@ -266,7 +266,7 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &pco_jack, NULL, 0);
+				    &pco_jack);
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index dad70436d063..0543dda75b99 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -90,7 +90,7 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pco_jack, NULL, 0);
+				&pco_jack);
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 1551546c3050..d8b25622f911 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -61,10 +61,10 @@ static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
 	 */
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &vg_headset, acp5x_nau8821_jack_pins,
-				    ARRAY_SIZE(acp5x_nau8821_jack_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0,
+					 &vg_headset, acp5x_nau8821_jack_pins,
+					 ARRAY_SIZE(acp5x_nau8821_jack_pins));
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 44b20c1ef851..a771707145e0 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2303,7 +2303,7 @@ static int cs43130_probe(struct snd_soc_component *component)
 	}
 
 	ret = snd_soc_card_jack_new(card, "Headphone", CS43130_JACK_MASK,
-				    &cs43130->jack, NULL, 0);
+				    &cs43130->jack);
 	if (ret < 0) {
 		dev_err(component->dev, "Cannot create jack\n");
 		return ret;
diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 168973035e35..b80c57362fb8 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -48,7 +48,7 @@ static int imx_es8328_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (gpio_is_valid(data->jack_gpio)) {
 		ret = snd_soc_card_jack_new(rtd->card, "Headphone",
 					    SND_JACK_HEADPHONE | SND_JACK_BTN_0,
-					    &headset_jack, NULL, 0);
+					    &headset_jack);
 		if (ret)
 			return ret;
 
diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index 929f69b758af..e10136afa741 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -78,8 +78,9 @@ static int imx_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	data->hdmi_jack_pin.pin = "HDMI Jack";
 	data->hdmi_jack_pin.mask = SND_JACK_LINEOUT;
 	/* enable jack detection */
-	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &data->hdmi_jack, &data->hdmi_jack_pin, 1);
+	ret = snd_soc_card_jack_new_pins(card, "HDMI Jack", SND_JACK_LINEOUT,
+					 &data->hdmi_jack,
+					 &data->hdmi_jack_pin, 1);
 	if (ret) {
 		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
 		return ret;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 8e037835bc58..da44f6c0f742 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -719,9 +719,8 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
 		sjack->gpio.invert	= !!(flags & OF_GPIO_ACTIVE_LOW);
 		sjack->gpio.debounce_time = 150;
 
-		snd_soc_card_jack_new(card, pin_name, mask,
-				      &sjack->jack,
-				      &sjack->pin, 1);
+		snd_soc_card_jack_new_pins(card, pin_name, mask, &sjack->jack,
+					   &sjack->pin, 1);
 
 		snd_soc_jack_add_gpios(&sjack->jack, 1,
 				       &sjack->gpio);
diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index bc0eab1c304a..aae857fdcdb8 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -192,15 +192,15 @@ static int bdw_rt5650_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Create and initialize headphone jack */
-	if (snd_soc_card_jack_new(rtd->card, "Headphone Jack",
+	if (snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
 			SND_JACK_HEADPHONE, &headphone_jack,
 			&headphone_jack_pin, 1)) {
 		dev_err(component->dev, "Can't create headphone jack\n");
 	}
 
 	/* Create and initialize mic jack */
-	if (snd_soc_card_jack_new(rtd->card, "Mic Jack", SND_JACK_MICROPHONE,
-			&mic_jack, &mic_jack_pin, 1)) {
+	if (snd_soc_card_jack_new_pins(rtd->card, "Mic Jack",
+			SND_JACK_MICROPHONE, &mic_jack, &mic_jack_pin, 1)) {
 		dev_err(component->dev, "Can't create mic jack\n");
 	}
 
diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 071557fada29..d0ecbba2febe 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -256,7 +256,7 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Create and initialize headphone jack */
-	if (!snd_soc_card_jack_new(rtd->card, "Headphone Jack",
+	if (!snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
 			SND_JACK_HEADPHONE, &headphone_jack,
 			&headphone_jack_pin, 1)) {
 		headphone_jack_gpio.gpiod_dev = component->dev;
@@ -268,7 +268,7 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Create and initialize mic jack */
-	if (!snd_soc_card_jack_new(rtd->card, "Mic Jack",
+	if (!snd_soc_card_jack_new_pins(rtd->card, "Mic Jack",
 			SND_JACK_MICROPHONE, &mic_jack,
 			&mic_jack_pin, 1)) {
 		mic_jack_gpio.gpiod_dev = component->dev;
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index d37c74fd1a3c..c30a9dca6801 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -69,7 +69,7 @@ static int broadwell_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
-	ret = snd_soc_card_jack_new(rtd->card, "Headset",
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset",
 		SND_JACK_HEADSET | SND_JACK_BTN_0, &broadwell_headset,
 		broadwell_headset_pins, ARRAY_SIZE(broadwell_headset_pins));
 	if (ret)
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 9bc7b88e346b..d98376da425a 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -234,7 +234,7 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 			SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_LINEOUT,
-			&broxton_headset, NULL, 0);
+			&broxton_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -720,8 +720,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &broxton_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &broxton_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 05e833076499..75995d17597d 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -168,7 +168,7 @@ static int broxton_rt298_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset",
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset",
 		SND_JACK_HEADSET | SND_JACK_BTN_0,
 		&broxton_headset,
 		broxton_headset_pins, ARRAY_SIZE(broxton_headset_pins));
@@ -544,8 +544,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &broxton_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &broxton_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 96d3201efbbd..0eed68a11f7e 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -87,11 +87,11 @@ static int byt_cht_cx2072x_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(card, "Headset",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &byt_cht_cx2072x_headset,
-				    byt_cht_cx2072x_headset_pins,
-				    ARRAY_SIZE(byt_cht_cx2072x_headset_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0,
+					 &byt_cht_cx2072x_headset,
+					 byt_cht_cx2072x_headset_pins,
+					 ARRAY_SIZE(byt_cht_cx2072x_headset_pins));
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index e18371b5a771..a08507783e44 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -219,10 +219,10 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(card, "Headset",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &priv->jack, byt_cht_es8316_jack_pins,
-				    ARRAY_SIZE(byt_cht_es8316_jack_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0,
+					 &priv->jack, byt_cht_es8316_jack_pins,
+					 ARRAY_SIZE(byt_cht_es8316_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index d76a505052fb..702a4f116656 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1300,10 +1300,10 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	if (BYT_RT5640_JDSRC(byt_rt5640_quirk)) {
-		ret = snd_soc_card_jack_new(card, "Headset",
-					    SND_JACK_HEADSET | SND_JACK_BTN_0,
-					    &priv->jack, rt5640_pins,
-					    ARRAY_SIZE(rt5640_pins));
+		ret = snd_soc_card_jack_new_pins(card, "Headset",
+						 SND_JACK_HEADSET | SND_JACK_BTN_0,
+						 &priv->jack, rt5640_pins,
+						 ARRAY_SIZE(rt5640_pins));
 		if (ret) {
 			dev_err(card->dev, "Jack creation failed %d\n", ret);
 			return ret;
@@ -1321,17 +1321,17 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	if (byt_rt5640_quirk & BYT_RT5640_JD_HP_ELITEP_1000G2) {
-		ret = snd_soc_card_jack_new(card, "Headset",
-					    SND_JACK_HEADSET,
-					    &priv->jack, rt5640_pins,
-					    ARRAY_SIZE(rt5640_pins));
+		ret = snd_soc_card_jack_new_pins(card, "Headset",
+						 SND_JACK_HEADSET,
+						 &priv->jack, rt5640_pins,
+						 ARRAY_SIZE(rt5640_pins));
 		if (ret)
 			return ret;
 
-		ret = snd_soc_card_jack_new(card, "Headset 2",
-					    SND_JACK_HEADSET,
-					    &priv->jack2, rt5640_pins2,
-					    ARRAY_SIZE(rt5640_pins2));
+		ret = snd_soc_card_jack_new_pins(card, "Headset 2",
+						 SND_JACK_HEADSET,
+						 &priv->jack2, rt5640_pins2,
+						 ARRAY_SIZE(rt5640_pins2));
 		if (ret)
 			return ret;
 
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 39348d2b242f..d467fcaa48ea 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -652,9 +652,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		report = SND_JACK_HEADSET;
 
 	if (report) {
-		ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    report, &priv->jack, bytcr_jack_pins,
-				    ARRAY_SIZE(bytcr_jack_pins));
+		ret = snd_soc_card_jack_new_pins(runtime->card, "Headset",
+						 report, &priv->jack,
+						 bytcr_jack_pins,
+						 ARRAY_SIZE(bytcr_jack_pins));
 		if (ret) {
 			dev_err(runtime->dev, "jack creation failed %d\n", ret);
 			return ret;
diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index 8d8e96e3cd2d..00384c6fbcaa 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -226,9 +226,9 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 
 	jack_type = ARIZONA_JACK_MASK | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
-	ret = snd_soc_card_jack_new(card, "Headset", jack_type,
-				    &priv->jack, byt_wm5102_pins,
-				    ARRAY_SIZE(byt_wm5102_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headset", jack_type,
+					 &priv->jack, byt_wm5102_pins,
+					 ARRAY_SIZE(byt_wm5102_pins));
 	if (ret) {
 		dev_err(card->dev, "Error creating jack: %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index b3d7a0725ef2..5f6e6b86892c 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -201,9 +201,10 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 
 	jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
-				    jack_type, jack,
-				    hs_jack_pins, ARRAY_SIZE(hs_jack_pins));
+	ret = snd_soc_card_jack_new_pins(runtime->card, "Headset Jack",
+					 jack_type, jack,
+					 hs_jack_pins,
+					 ARRAY_SIZE(hs_jack_pins));
 	if (ret) {
 		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -306,8 +307,7 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
 		    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack", jack_type,
-				    jack, NULL, 0);
+	ret = snd_soc_card_jack_new(card, "Headset Jack", jack_type, jack);
 	if (ret) {
 		dev_err(card->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index da6c659de266..4c1d83b317c7 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -108,8 +108,8 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	 */
 	jack_type = SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 		SND_JACK_BTN_2 | SND_JACK_BTN_3;
-	ret = snd_soc_card_jack_new(runtime->card, "Headset", jack_type, jack,
-		cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
+	ret = snd_soc_card_jack_new_pins(runtime->card, "Headset", jack_type,
+		jack, cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
 	if (ret) {
 		dev_err(runtime->dev,
 			"Headset Jack creation failed %d\n", ret);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index c21561c6a464..45c301ea5e00 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -302,9 +302,9 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	else
 		jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    jack_type, &ctx->jack,
-				    cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
+	ret = snd_soc_card_jack_new_pins(runtime->card, "Headset", jack_type,
+					 &ctx->jack, cht_bsw_jack_pins,
+					 ARRAY_SIZE(cht_bsw_jack_pins));
 	if (ret) {
 		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 9882aeb24d33..c80324f34b1b 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -221,12 +221,12 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-        ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2,
-				    &ctx->headset,
-				    cht_bsw_headset_pins,
-				    ARRAY_SIZE(cht_bsw_headset_pins));
+	ret = snd_soc_card_jack_new_pins(runtime->card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2,
+					 &ctx->headset,
+					 cht_bsw_headset_pins,
+					 ARRAY_SIZE(cht_bsw_headset_pins));
         if (ret)
                 return ret;
 
diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index 27615acddacd..a99f74a15b5f 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -141,7 +141,7 @@ static int cml_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    &ctx->headset, NULL, 0);
+				    &ctx->headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -338,8 +338,7 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			 "HDMI/DP, pcm=%d Jack", pcm->device);
 		ret = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &hdmi_jack[i],
-					    NULL, 0);
+					    SND_JACK_AVOUT, &hdmi_jack[i]);
 		if (ret)
 			return ret;
 
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index e4bfb0fe5f12..170164baae7d 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -176,7 +176,7 @@ static int geminilake_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 			SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_LINEOUT,
-			&ctx->geminilake_headset, NULL, 0);
+			&ctx->geminilake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -571,8 +571,7 @@ static int glk_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &geminilake_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &geminilake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index a4bdf634e9b9..ceabed85e9da 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -182,7 +182,7 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	ret = snd_soc_card_jack_new(kabylake_audio_card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 			SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_LINEOUT,
-			&ctx->kabylake_headset, NULL, 0);
+			&ctx->kabylake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -587,8 +587,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &skylake_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &skylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 620a9fbcb08f..703ccff634b0 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -357,7 +357,7 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	ret = snd_soc_card_jack_new(kabylake_audio_card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 			SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_LINEOUT,
-			&ctx->kabylake_headset, NULL, 0);
+			&ctx->kabylake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -965,8 +965,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &kabylake_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &kabylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 1cb56ec363e8..2c7a547f63c9 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -173,9 +173,9 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Create and initialize headphone jack, this jack is not mandatory, don't return if fails */
-	ret = snd_soc_card_jack_new(rtd->card, "Lineout Jack",
-				    SND_JACK_LINEOUT, &lineout_jack,
-				    &lineout_jack_pin, 1);
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Lineout Jack",
+					 SND_JACK_LINEOUT, &lineout_jack,
+					 &lineout_jack_pin, 1);
 	if (ret)
 		dev_warn(component->dev, "Can't create Lineout jack\n");
 	else {
@@ -187,9 +187,9 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Create and initialize mic jack, this jack is not mandatory, don't return if fails */
-	ret = snd_soc_card_jack_new(rtd->card, "Mic Jack",
-				    SND_JACK_MICROPHONE, &mic_jack,
-				    &mic_jack_pin, 1);
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Mic Jack",
+					 SND_JACK_MICROPHONE, &mic_jack,
+					 &mic_jack_pin, 1);
 	if (ret)
 		dev_warn(component->dev, "Can't create mic jack\n");
 	else {
@@ -485,8 +485,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &skylake_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &skylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index f24e0ce5d49f..8d37b2676a81 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -273,8 +273,8 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 */
 	ret = snd_soc_card_jack_new(kabylake_audio_card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3, &ctx->kabylake_headset,
-			NULL, 0);
+			SND_JACK_BTN_2 | SND_JACK_BTN_3,
+			&ctx->kabylake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -919,8 +919,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &skylake_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &skylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 6874e981c8df..564c70a0fbc8 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -230,8 +230,8 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 */
 	ret = snd_soc_card_jack_new(&kabylake_audio_card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3, &ctx->kabylake_headset,
-			NULL, 0);
+			SND_JACK_BTN_2 | SND_JACK_BTN_3,
+			&ctx->kabylake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -743,8 +743,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP,pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
-				NULL, 0);
+				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 07bfb2e64b3b..e9cefa4ae56d 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -150,17 +150,11 @@ int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			 "HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &pcm->hdmi_jack,
-					    NULL, 0);
+					    SND_JACK_AVOUT, &pcm->hdmi_jack);
 
 		if (err)
 			return err;
 
-		err = snd_jack_add_new_kctl(pcm->hdmi_jack.jack,
-					    jack_name, SND_JACK_AVOUT);
-		if (err)
-			dev_warn(component->dev, "failed creating Jack kctl\n");
-
 		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
 					  &pcm->hdmi_jack);
 		if (err < 0)
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 7297eb05613c..8e2d03e36079 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -165,8 +165,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 */
 	ret = snd_soc_card_jack_new(&skylake_audio_card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset,
-			NULL, 0);
+			SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -610,8 +609,7 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 					SND_JACK_AVOUT,
-					&skylake_hdmi[i],
-					NULL, 0);
+					&skylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 68efde1633b3..501f0bbfc404 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -184,8 +184,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 */
 	ret = snd_soc_card_jack_new(&skylake_audio_card, "Headset Jack",
 		SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-		SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset,
-		NULL, 0);
+		SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
@@ -651,8 +650,7 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 					SND_JACK_AVOUT,
-					&skylake_hdmi[i],
-					NULL, 0);
+					&skylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index eca4a78668af..e9f9520dcea4 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -125,7 +125,7 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset",
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset",
 		SND_JACK_HEADSET | SND_JACK_BTN_0,
 		&skylake_headset,
 		skylake_headset_pins, ARRAY_SIZE(skylake_headset_pins));
@@ -491,8 +491,7 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					SND_JACK_AVOUT, &skylake_hdmi[i],
-					NULL, 0);
+					SND_JACK_AVOUT, &skylake_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index ce78c1879887..6a979c333bc5 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -102,7 +102,7 @@ static int sof_cs42l42_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    jack, NULL, 0);
+				    jack);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -186,8 +186,7 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			 "HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &pcm->hdmi_jack,
-					    NULL, 0);
+					    SND_JACK_AVOUT, &pcm->hdmi_jack);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index b7b3b0bf994a..a83f30b687cf 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -160,7 +160,7 @@ static int da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3 | SND_JACK_LINEOUT,
-				    &headset, NULL, 0);
+				    &headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 5e0529aa4f1d..2c3342a502ff 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -206,10 +206,10 @@ static int sof_es8316_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_card_jack_new(card, "Headset",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &priv->jack, sof_es8316_jack_pins,
-				    ARRAY_SIZE(sof_es8316_jack_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0,
+					 &priv->jack, sof_es8316_jack_pins,
+					 ARRAY_SIZE(sof_es8316_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "jack creation failed %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index 33de043b66c6..97dcd204a246 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -97,7 +97,7 @@ static int sof_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    &ctx->sof_headset, NULL, 0);
+				    &ctx->sof_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index ebec4d15edaa..e1716e2b6041 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -285,7 +285,7 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    &ctx->sof_headset, NULL, 0);
+				    &ctx->sof_headset);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -441,8 +441,7 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			 "HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &sof_hdmi[i],
-					    NULL, 0);
+					    SND_JACK_AVOUT, &sof_hdmi[i]);
 
 		if (err)
 			return err;
diff --git a/sound/soc/intel/boards/sof_sdw_rt5682.c b/sound/soc/intel/boards/sof_sdw_rt5682.c
index ea55479609a8..3a9be8211586 100644
--- a/sound/soc/intel/boards/sof_sdw_rt5682.c
+++ b/sound/soc/intel/boards/sof_sdw_rt5682.c
@@ -82,13 +82,13 @@ static int rt5682_rtd_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3,
-				    &ctx->sdw_headset,
-				    rt5682_jack_pins,
-				    ARRAY_SIZE(rt5682_jack_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 &ctx->sdw_headset,
+					 rt5682_jack_pins,
+					 ARRAY_SIZE(rt5682_jack_pins));
 	if (ret) {
 		dev_err(rtd->card->dev, "Headset Jack creation failed: %d\n",
 			ret);
diff --git a/sound/soc/intel/boards/sof_sdw_rt700.c b/sound/soc/intel/boards/sof_sdw_rt700.c
index bb9584c8f866..c93b1f5b9440 100644
--- a/sound/soc/intel/boards/sof_sdw_rt700.c
+++ b/sound/soc/intel/boards/sof_sdw_rt700.c
@@ -82,13 +82,13 @@ static int rt700_rtd_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3,
-				    &ctx->sdw_headset,
-				    rt700_jack_pins,
-				    ARRAY_SIZE(rt700_jack_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 &ctx->sdw_headset,
+					 rt700_jack_pins,
+					 ARRAY_SIZE(rt700_jack_pins));
 	if (ret) {
 		dev_err(rtd->card->dev, "Headset Jack creation failed: %d\n",
 			ret);
diff --git a/sound/soc/intel/boards/sof_sdw_rt711.c b/sound/soc/intel/boards/sof_sdw_rt711.c
index c38b70c9fac3..49ff0871e9e7 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711.c
@@ -106,13 +106,13 @@ static int rt711_rtd_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3,
-				    &ctx->sdw_headset,
-				    rt711_jack_pins,
-				    ARRAY_SIZE(rt711_jack_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 &ctx->sdw_headset,
+					 rt711_jack_pins,
+					 ARRAY_SIZE(rt711_jack_pins));
 	if (ret) {
 		dev_err(rtd->card->dev, "Headset Jack creation failed: %d\n",
 			ret);
diff --git a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
index 4215ddc36419..b3fc32bacfa8 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
@@ -107,13 +107,13 @@ static int rt711_sdca_rtd_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3,
-				    &ctx->sdw_headset,
-				    rt711_sdca_jack_pins,
-				    ARRAY_SIZE(rt711_sdca_jack_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 &ctx->sdw_headset,
+					 rt711_sdca_jack_pins,
+					 ARRAY_SIZE(rt711_sdca_jack_pins));
 	if (ret) {
 		dev_err(rtd->card->dev, "Headset Jack creation failed: %d\n",
 			ret);
diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
index 88530e9de543..02a27aaed92f 100644
--- a/sound/soc/intel/boards/sof_ssp_amp.c
+++ b/sound/soc/intel/boards/sof_ssp_amp.c
@@ -118,8 +118,7 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			 "HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &pcm->sof_hdmi,
-					    NULL, 0);
+					    SND_JACK_AVOUT, &pcm->sof_hdmi);
 
 		if (err)
 			return err;
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 4cb90da89262..5cb1eb86a22d 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -70,10 +70,10 @@ static int mt8173_max98090_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_component *component = asoc_rtd_to_codec(runtime, 0)->component;
 
 	/* enable jack detection */
-	ret = snd_soc_card_jack_new(card, "Headphone", SND_JACK_HEADPHONE,
-				    &mt8173_max98090_jack,
-				    mt8173_max98090_jack_pins,
-				    ARRAY_SIZE(mt8173_max98090_jack_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headphone", SND_JACK_HEADPHONE,
+					 &mt8173_max98090_jack,
+					 mt8173_max98090_jack_pins,
+					 ARRAY_SIZE(mt8173_max98090_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "Can't create a new Jack %d\n", ret);
 		return ret;
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index b55122b99f07..12f40c81b101 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -86,7 +86,7 @@ static int mt8173_rt5650_rt5514_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &mt8173_rt5650_rt5514_jack, NULL, 0);
+				    &mt8173_rt5650_rt5514_jack);
 	if (ret) {
 		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
 		return ret;
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 5716d9299066..70bf312e855f 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -99,7 +99,7 @@ static int mt8173_rt5650_rt5676_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &mt8173_rt5650_rt5676_jack, NULL, 0);
+				    &mt8173_rt5650_rt5676_jack);
 	if (ret) {
 		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
 		return ret;
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index fc164f4f95f8..d1c94acb4516 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -132,7 +132,7 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &mt8173_rt5650_jack, NULL, 0);
+				    &mt8173_rt5650_jack);
 	if (ret) {
 		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
 		return ret;
@@ -149,7 +149,7 @@ static int mt8173_rt5650_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &mt8173_rt5650_hdmi_jack, NULL, 0);
+				    &mt8173_rt5650_hdmi_jack);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index f090dee0c7a4..b33cc9a73ed1 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -364,7 +364,7 @@ static int mt8183_da7219_max98357_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
+				    &priv->hdmi_jack);
 	if (ret)
 		return ret;
 
@@ -546,8 +546,7 @@ mt8183_da7219_max98357_headset_init(struct snd_soc_component *component)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 				    SND_JACK_LINEOUT,
-				    &priv->headset_jack,
-				    NULL, 0);
+				    &priv->headset_jack);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 889f9e4a96aa..ab157db78335 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -383,7 +383,7 @@ mt8183_mt6358_ts3a227_max98357_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
+				    &priv->hdmi_jack);
 	if (ret)
 		return ret;
 
@@ -613,8 +613,7 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 				    SND_JACK_HEADSET |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &priv->headset_jack,
-				    NULL, 0);
+				    &priv->headset_jack);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index ee91569c0911..730145ad9b19 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -316,7 +316,7 @@ static int mt8192_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    jack, NULL, 0);
+				    jack);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -338,7 +338,7 @@ static int mt8192_mt6359_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
+				    &priv->hdmi_jack);
 	if (ret) {
 		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
 		return ret;
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
index 5443a29da7b1..66950bce50d5 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
@@ -341,7 +341,7 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    jack, NULL, 0);
+				    jack);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -442,7 +442,7 @@ static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-				    &priv->dp_jack, NULL, 0);
+				    &priv->dp_jack);
 	if (ret)
 		return ret;
 
@@ -458,7 +458,7 @@ static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
+				    &priv->hdmi_jack);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index e3146311722f..04c0cb747d05 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -331,7 +331,7 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    jack, NULL, 0);
+				    jack);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
@@ -435,7 +435,7 @@ static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret = 0;
 
 	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-				    &priv->dp_jack, NULL, 0);
+				    &priv->dp_jack);
 	if (ret)
 		return ret;
 
@@ -451,7 +451,7 @@ static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret = 0;
 
 	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack, NULL, 0);
+				    &priv->hdmi_jack);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 7334fac758de..9a816156f012 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -122,9 +122,9 @@ static int hx4700_ak4641_init(struct snd_soc_pcm_runtime *rtd)
 	int err;
 
 	/* Jack detection API stuff */
-	err = snd_soc_card_jack_new(rtd->card, "Headphone Jack",
-				    SND_JACK_HEADPHONE, &hs_jack, hs_jack_pin,
-				    ARRAY_SIZE(hs_jack_pin));
+	err = snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
+					 SND_JACK_HEADPHONE, &hs_jack,
+					 hs_jack_pin, ARRAY_SIZE(hs_jack_pin));
 	if (err)
 		return err;
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index b92ea1a0453f..65257f7fe4c4 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -71,9 +71,10 @@ static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	int err;
 
 	/* Jack detection API stuff */
-	err = snd_soc_card_jack_new(rtd->card, "Headphone Jack",
-				    SND_JACK_HEADPHONE, &hs_jack, hs_jack_pins,
-				    ARRAY_SIZE(hs_jack_pins));
+	err = snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
+					 SND_JACK_HEADPHONE, &hs_jack,
+					 hs_jack_pins,
+					 ARRAY_SIZE(hs_jack_pins));
 	if (err)
 		return err;
 
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index d5f2961b1a3e..6cc970bb2aac 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -64,12 +64,14 @@ static int ttc_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
 
 	/* Headset jack detection */
-	snd_soc_card_jack_new(rtd->card, "Headphone Jack", SND_JACK_HEADPHONE |
-			      SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
-			      &hs_jack, hs_jack_pins, ARRAY_SIZE(hs_jack_pins));
-	snd_soc_card_jack_new(rtd->card, "Microphone Jack", SND_JACK_MICROPHONE,
-			      &mic_jack, mic_jack_pins,
-			      ARRAY_SIZE(mic_jack_pins));
+	snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
+				   SND_JACK_HEADPHONE | SND_JACK_BTN_0 |
+				   SND_JACK_BTN_1 | SND_JACK_BTN_2,
+				   &hs_jack,
+				   hs_jack_pins, ARRAY_SIZE(hs_jack_pins));
+	snd_soc_card_jack_new_pins(rtd->card, "Microphone Jack",
+				   SND_JACK_MICROPHONE, &mic_jack,
+				   mic_jack_pins, ARRAY_SIZE(mic_jack_pins));
 
 	/* headphone, microphone detection & headset short detection */
 	pm860x_hs_jack_detect(component, &hs_jack, SND_JACK_HEADPHONE,
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index edf2b9eec5b8..f4a7cfe22115 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -132,9 +132,10 @@ static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 
 	/* Jack detection API stuff */
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack", SND_JACK_HEADSET,
-				    &hs_jack, hs_jack_pins,
-				    ARRAY_SIZE(hs_jack_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET, &hs_jack,
+					 hs_jack_pins,
+					 ARRAY_SIZE(hs_jack_pins));
 	if (ret)
 		goto err;
 
diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index f9d69375320e..b0a4f7ca2751 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -96,7 +96,7 @@ static int apq8016_dai_init(struct snd_soc_pcm_runtime *rtd, int mi2s)
 					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 					     SND_JACK_BTN_4,
-					     &pdata->jack, NULL, 0);
+					     &pdata->jack);
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index 37225ef2563a..efccb5c0b3e0 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -57,7 +57,7 @@ static int sc7180_headset_init(struct snd_soc_pcm_runtime *rtd)
 			SND_JACK_HEADPHONE |
 			SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 			SND_JACK_BTN_2 | SND_JACK_BTN_3,
-			&pdata->hs_jack, NULL, 0);
+			&pdata->hs_jack);
 
 	if (rval < 0) {
 		dev_err(card->dev, "Unable to add Headset Jack\n");
@@ -89,7 +89,7 @@ static int sc7180_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	rval = snd_soc_card_jack_new(
 			card, "HDMI Jack",
 			SND_JACK_LINEOUT,
-			&pdata->hdmi_jack, NULL, 0);
+			&pdata->hdmi_jack);
 
 	if (rval < 0) {
 		dev_err(card->dev, "Unable to add HDMI Jack\n");
diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index bd0bf9c8cb28..a6893aded069 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -50,7 +50,7 @@ static int sc7280_headset_init(struct snd_soc_pcm_runtime *rtd)
 					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					     &pdata->hs_jack, NULL, 0);
+					     &pdata->hs_jack);
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headset Jack\n");
@@ -96,7 +96,7 @@ static int sc7280_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 	int rval;
 
 	rval = snd_soc_card_jack_new(card, "HDMI Jack",	SND_JACK_LINEOUT,
-				     &pdata->hdmi_jack, NULL, 0);
+				     &pdata->hdmi_jack);
 
 	if (rval < 0) {
 		dev_err(card->dev, "Unable to add HDMI Jack\n");
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 5c1d13eccbee..61fda790f375 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -247,7 +247,7 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 				SND_JACK_HEADPHONE |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pdata->jack, NULL, 0);
+				&pdata->jack);
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 114a29e01c0f..6e1184c8b672 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -41,7 +41,7 @@ static int sm8250_snd_init(struct snd_soc_pcm_runtime *rtd)
 					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					     &data->jack, NULL, 0);
+					     &data->jack);
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index b052642ea620..bcdeddeba80c 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -124,10 +124,10 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 
 	/* Enable Headset Jack detection */
 	if (gpio_is_valid(machine->gpio_hp_det)) {
-		snd_soc_card_jack_new(runtime->card, "Headphone Jack",
-				      SND_JACK_HEADPHONE, &headphone_jack,
-				      headphone_jack_pins,
-				      ARRAY_SIZE(headphone_jack_pins));
+		snd_soc_card_jack_new_pins(runtime->card, "Headphone Jack",
+					   SND_JACK_HEADPHONE, &headphone_jack,
+					   headphone_jack_pins,
+					   ARRAY_SIZE(headphone_jack_pins));
 		rk_hp_jack_gpio.gpio = machine->gpio_hp_det;
 		snd_soc_jack_add_gpios(&headphone_jack, 1, &rk_hp_jack_gpio);
 	}
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index eeef3ed70037..2540b9ba37c8 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -174,7 +174,7 @@ static int rockchip_sound_cdndp_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* Enable jack detection. */
 	ret = snd_soc_card_jack_new(card, "DP Jack", SND_JACK_LINEOUT,
-				    &cdn_dp_card_jack, NULL, 0);
+				    &cdn_dp_card_jack);
 	if (ret) {
 		dev_err(card->dev, "Can't create DP Jack %d\n", ret);
 		return ret;
@@ -204,13 +204,13 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Enable Headset and 4 Buttons Jack detection */
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &rockchip_sound_jack,
-				    rockchip_sound_jack_pins,
-				    ARRAY_SIZE(rockchip_sound_jack_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &rockchip_sound_jack,
+					 rockchip_sound_jack_pins,
+					 ARRAY_SIZE(rockchip_sound_jack_pins));
 
 	if (ret) {
 		dev_err(rtd->card->dev, "New Headset Jack failed! (%d)\n", ret);
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index c8f1a28a92b7..150ac524a590 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -231,7 +231,7 @@ static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
 
 	/* enable jack detection */
 	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &rk_hdmi_jack, NULL, 0);
+				    &rk_hdmi_jack);
 	if (ret) {
 		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
 		return ret;
@@ -345,13 +345,13 @@ static int rk_98090_headset_init(struct snd_soc_component *component)
 	int ret;
 
 	/* Enable Headset and 4 Buttons Jack detection */
-	ret = snd_soc_card_jack_new(component->card, "Headset Jack",
-				    SND_JACK_HEADSET |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &headset_jack,
-				    headset_jack_pins,
-				    ARRAY_SIZE(headset_jack_pins));
+	ret = snd_soc_card_jack_new_pins(component->card, "Headset Jack",
+					 SND_JACK_HEADSET |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &headset_jack,
+					 headset_jack_pins,
+					 ARRAY_SIZE(headset_jack_pins));
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 16ca2ad92426..d07cc5c813f2 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -107,7 +107,7 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &headset_jack, NULL, 0);
+				    &headset_jack);
 	if (ret) {
 		dev_err(card->dev, "New Headset Jack failed! (%d)\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 5265e546b124..5b5fc66885e1 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -343,7 +343,7 @@ static int aries_late_probe(struct snd_soc_card *card)
 	struct aries_wm8994_data *priv = snd_soc_card_get_drvdata(card);
 	int ret, irq;
 
-	ret = snd_soc_card_jack_new(card, "Dock", SND_JACK_LINEOUT,
+	ret = snd_soc_card_jack_new_pins(card, "Dock", SND_JACK_LINEOUT,
 			&aries_dock, dock_pins, ARRAY_SIZE(dock_pins));
 	if (ret)
 		return ret;
@@ -361,7 +361,7 @@ static int aries_late_probe(struct snd_soc_card *card)
 	else
 		snd_soc_jack_report(&aries_dock, 0, SND_JACK_LINEOUT);
 
-	ret = snd_soc_card_jack_new(card, "Headset",
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
 			SND_JACK_HEADSET | SND_JACK_BTN_0,
 			&aries_headset,
 			jack_pins, ARRAY_SIZE(jack_pins));
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index c994e67d1eaf..907266aee839 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -151,7 +151,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
-	snd_soc_card_jack_new(rtd->card, "Headphone Jack", SND_JACK_HEADPHONE,
+	snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
+		SND_JACK_HEADPHONE,
 		&hp_jack, hp_jack_pins, ARRAY_SIZE(hp_jack_pins));
 
 	snd_soc_jack_add_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 34067cc314ff..f3dfe3558b77 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -285,7 +285,7 @@ static int littlemill_late_probe(struct snd_soc_card *card)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 				    SND_JACK_BTN_4 | SND_JACK_BTN_5,
-				    &littlemill_headset, NULL, 0);
+				    &littlemill_headset);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 7b12ccd2a9b2..b1ac8e89faf4 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -51,10 +51,11 @@ static int lowland_wm5100_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset", SND_JACK_LINEOUT |
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &lowland_headset, lowland_headset_pins,
-				    ARRAY_SIZE(lowland_headset_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset",
+					 SND_JACK_LINEOUT | SND_JACK_HEADSET |
+					 SND_JACK_BTN_0,
+					 &lowland_headset, lowland_headset_pins,
+					 ARRAY_SIZE(lowland_headset_pins));
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 5e9dc18687cc..6931b9a45b3e 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -309,7 +309,7 @@ static int midas_late_probe(struct snd_soc_card *card)
 			SND_JACK_HEADSET | SND_JACK_MECHANICAL |
 			SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 			SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5,
-			&priv->headset_jack, NULL, 0);
+			&priv->headset_jack);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 6ea1c8cc9167..ff3acc94a454 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -201,7 +201,8 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
-	snd_soc_card_jack_new(rtd->card, "Headphone Jack", SND_JACK_HEADPHONE,
+	snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
+		SND_JACK_HEADPHONE,
 		&hp_jack, hp_jack_pins, ARRAY_SIZE(hp_jack_pins));
 
 	snd_soc_jack_add_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index cee39ad16667..29bf917242fe 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -139,10 +139,10 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "ROUT1");
 
 	/* Headphone jack detection */
-	err = snd_soc_card_jack_new(rtd->card, "Headphone Jack",
-				    SND_JACK_HEADPHONE, &smartq_jack,
-				    smartq_jack_pins,
-				    ARRAY_SIZE(smartq_jack_pins));
+	err = snd_soc_card_jack_new_pins(rtd->card, "Headphone Jack",
+					 SND_JACK_HEADPHONE, &smartq_jack,
+					 smartq_jack_pins,
+					 ARRAY_SIZE(smartq_jack_pins));
 	if (err)
 		return err;
 
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 37b1f4f60b21..221b54045d0b 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -156,10 +156,12 @@ static int speyside_wm8996_init(struct snd_soc_pcm_runtime *rtd)
 		pr_err("Failed to request HP_SEL GPIO: %d\n", ret);
 	gpio_direction_output(WM8996_HPSEL_GPIO, speyside_jack_polarity);
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset", SND_JACK_LINEOUT |
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &speyside_headset, speyside_headset_pins,
-				    ARRAY_SIZE(speyside_headset_pins));
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset",
+					 SND_JACK_LINEOUT | SND_JACK_HEADSET |
+					 SND_JACK_BTN_0,
+					 &speyside_headset,
+					 speyside_headset_pins,
+					 ARRAY_SIZE(speyside_headset_pins));
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 8d3149a47a4c..ff8e6463e283 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -189,10 +189,10 @@ static int tobermory_late_probe(struct snd_soc_card *card)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_card_jack_new(card, "Headset", SND_JACK_HEADSET |
-				    SND_JACK_BTN_0, &tobermory_headset,
-				    tobermory_headset_pins,
-				    ARRAY_SIZE(tobermory_headset_pins));
+	ret = snd_soc_card_jack_new_pins(card, "Headset", SND_JACK_HEADSET |
+					 SND_JACK_BTN_0, &tobermory_headset,
+					 tobermory_headset_pins,
+					 ARRAY_SIZE(tobermory_headset_pins));
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/soc-card.c b/sound/soc/soc-card.c
index 41c586b86dc3..4158f5aacfd3 100644
--- a/sound/soc/soc-card.c
+++ b/sound/soc/soc-card.c
@@ -42,8 +42,42 @@ struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
 
+static int jack_new(struct snd_soc_card *card, const char *id, int type,
+		    struct snd_soc_jack *jack, bool initial_kctl)
+{
+	mutex_init(&jack->mutex);
+	jack->card = card;
+	INIT_LIST_HEAD(&jack->pins);
+	INIT_LIST_HEAD(&jack->jack_zones);
+	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
+
+	return snd_jack_new(card->snd_card, id, type, &jack->jack, initial_kctl, false);
+}
+
 /**
- * snd_soc_card_jack_new - Create a new jack
+ * snd_soc_card_jack_new - Create a new jack without pins
+ * @card:  ASoC card
+ * @id:    an identifying string for this jack
+ * @type:  a bitmask of enum snd_jack_type values that can be detected by
+ *         this jack
+ * @jack:  structure to use for the jack
+ *
+ * Creates a new jack object without pins. If adding pins later,
+ * snd_soc_card_jack_new_pins() should be used instead with 0 as num_pins
+ * argument.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ * On success jack will be initialised.
+ */
+int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
+			  struct snd_soc_jack *jack)
+{
+	return soc_card_ret(card, jack_new(card, id, type, jack, true));
+}
+EXPORT_SYMBOL_GPL(snd_soc_card_jack_new);
+
+/**
+ * snd_soc_card_jack_new_pins - Create a new jack with pins
  * @card:  ASoC card
  * @id:    an identifying string for this jack
  * @type:  a bitmask of enum snd_jack_type values that can be detected by
@@ -52,24 +86,20 @@ EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
  * @pins:  Array of jack pins to be added to the jack or NULL
  * @num_pins: Number of elements in the @pins array
  *
- * Creates a new jack object.
+ * Creates a new jack object with pins. If not adding pins,
+ * snd_soc_card_jack_new() should be used instead.
  *
  * Returns zero if successful, or a negative error code on failure.
  * On success jack will be initialised.
  */
-int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
-			  struct snd_soc_jack *jack,
-			  struct snd_soc_jack_pin *pins, unsigned int num_pins)
+int snd_soc_card_jack_new_pins(struct snd_soc_card *card, const char *id,
+			       int type, struct snd_soc_jack *jack,
+			       struct snd_soc_jack_pin *pins,
+			       unsigned int num_pins)
 {
 	int ret;
 
-	mutex_init(&jack->mutex);
-	jack->card = card;
-	INIT_LIST_HEAD(&jack->pins);
-	INIT_LIST_HEAD(&jack->jack_zones);
-	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
-
-	ret = snd_jack_new(card->snd_card, id, type, &jack->jack, false, false);
+	ret = jack_new(card, id, type, jack, false);
 	if (ret)
 		goto end;
 
@@ -78,7 +108,7 @@ int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
 end:
 	return soc_card_ret(card, ret);
 }
-EXPORT_SYMBOL_GPL(snd_soc_card_jack_new);
+EXPORT_SYMBOL_GPL(snd_soc_card_jack_new_pins);
 
 int snd_soc_card_suspend_pre(struct snd_soc_card *card)
 {
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index d798765d168c..fcece5ca38c6 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_get_type);
 /**
  * snd_soc_jack_add_pins - Associate DAPM pins with an ASoC jack
  *
- * @jack:  ASoC jack
+ * @jack:  ASoC jack created with snd_soc_card_jack_new_pins()
  * @count: Number of pins
  * @pins:  Array of pins
  *
diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index a73404879aa1..78faa8bcae27 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -133,11 +133,11 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 		else
 			jack_name = "Headphones Jack";
 
-		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_HEADPHONE,
-					    &tegra_machine_hp_jack,
-					    tegra_machine_hp_jack_pins,
-					    ARRAY_SIZE(tegra_machine_hp_jack_pins));
+		err = snd_soc_card_jack_new_pins(card, jack_name,
+						 SND_JACK_HEADPHONE,
+						 &tegra_machine_hp_jack,
+						 tegra_machine_hp_jack_pins,
+						 ARRAY_SIZE(tegra_machine_hp_jack_pins));
 		if (err) {
 			dev_err(rtd->dev,
 				"Headphones Jack creation failed: %d\n", err);
@@ -153,11 +153,11 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	if (machine->gpiod_hp_det && machine->asoc->add_headset_jack) {
-		err = snd_soc_card_jack_new(card, "Headset Jack",
-					    SND_JACK_HEADSET,
-					    &tegra_machine_headset_jack,
-					    tegra_machine_headset_jack_pins,
-					    ARRAY_SIZE(tegra_machine_headset_jack_pins));
+		err = snd_soc_card_jack_new_pins(card, "Headset Jack",
+						 SND_JACK_HEADSET,
+						 &tegra_machine_headset_jack,
+						 tegra_machine_headset_jack_pins,
+						 ARRAY_SIZE(tegra_machine_headset_jack_pins));
 		if (err) {
 			dev_err(rtd->dev,
 				"Headset Jack creation failed: %d\n", err);
@@ -173,11 +173,11 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	if (machine->gpiod_mic_det && machine->asoc->add_mic_jack) {
-		err = snd_soc_card_jack_new(rtd->card, "Mic Jack",
-					    SND_JACK_MICROPHONE,
-					    &tegra_machine_mic_jack,
-					    tegra_machine_mic_jack_pins,
-					    ARRAY_SIZE(tegra_machine_mic_jack_pins));
+		err = snd_soc_card_jack_new_pins(rtd->card, "Mic Jack",
+						 SND_JACK_MICROPHONE,
+						 &tegra_machine_mic_jack,
+						 tegra_machine_mic_jack_pins,
+						 ARRAY_SIZE(tegra_machine_mic_jack_pins));
 		if (err) {
 			dev_err(rtd->dev, "Mic Jack creation failed: %d\n", err);
 			return err;
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 5751fb398c1a..b3cd0a34da63 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -79,11 +79,11 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 		struct snd_soc_component *component = codec_dai->component;
 		int shrt = 0;
 
-		err = snd_soc_card_jack_new(rtd->card, "Mic Jack",
-					    SND_JACK_MICROPHONE,
-					    machine->mic_jack,
-					    tegra_wm8903_mic_jack_pins,
-					    ARRAY_SIZE(tegra_wm8903_mic_jack_pins));
+		err = snd_soc_card_jack_new_pins(rtd->card, "Mic Jack",
+						 SND_JACK_MICROPHONE,
+						 machine->mic_jack,
+						 tegra_wm8903_mic_jack_pins,
+						 ARRAY_SIZE(tegra_wm8903_mic_jack_pins));
 		if (err) {
 			dev_err(rtd->dev, "Mic Jack creation failed: %d\n", err);
 			return err;
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index b1a32545babd..438e2fa843a0 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -471,8 +471,8 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* Add hook switch - can be used to control the codec from userspace
 	 * even if line discipline fails */
-	ret = snd_soc_card_jack_new(card, "hook_switch", SND_JACK_HEADSET,
-				    &ams_delta_hook_switch, NULL, 0);
+	ret = snd_soc_card_jack_new_pins(card, "hook_switch", SND_JACK_HEADSET,
+					 &ams_delta_hook_switch, NULL, 0);
 	if (ret)
 		dev_warn(card->dev,
 				"Failed to allocate resources for hook switch, "
diff --git a/sound/soc/ti/omap-abe-twl6040.c b/sound/soc/ti/omap-abe-twl6040.c
index da809c7f25a4..805ffbf89014 100644
--- a/sound/soc/ti/omap-abe-twl6040.c
+++ b/sound/soc/ti/omap-abe-twl6040.c
@@ -182,10 +182,10 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* Headset jack detection only if it is supported */
 	if (priv->jack_detection) {
-		ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-					    SND_JACK_HEADSET, &hs_jack,
-					    hs_jack_pins,
-					    ARRAY_SIZE(hs_jack_pins));
+		ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+						 SND_JACK_HEADSET, &hs_jack,
+						 hs_jack_pins,
+						 ARRAY_SIZE(hs_jack_pins));
 		if (ret)
 			return ret;
 
diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 1da05a6cdc9f..950eec44503b 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -155,10 +155,10 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 	if (priv->jack_detect > 0) {
 		hs_jack_gpios[0].gpio = priv->jack_detect;
 
-		ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
-					    SND_JACK_HEADSET, &priv->hs_jack,
-					    hs_jack_pins,
-					    ARRAY_SIZE(hs_jack_pins));
+		ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+						 SND_JACK_HEADSET,
+						 &priv->hs_jack, hs_jack_pins,
+						 ARRAY_SIZE(hs_jack_pins));
 		if (ret)
 			return ret;
 
diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index a2629ccc1dc8..322c398d209b 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -277,7 +277,7 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	/* AV jack detection */
 	err = snd_soc_card_jack_new(rtd->card, "AV Jack",
 				    SND_JACK_HEADSET | SND_JACK_VIDEOOUT,
-				    &rx51_av_jack, NULL, 0);
+				    &rx51_av_jack);
 	if (err) {
 		dev_err(card->dev, "Failed to add AV Jack\n");
 		return err;
-- 
2.35.1

