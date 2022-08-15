Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035B592E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiHOL1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiHOL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:27:31 -0400
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9923BF0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:27:27 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[61.152.154.78])
        by rmsmtp-lg-appmail-21-12024 (RichMail) with SMTP id 2ef862fa2d9769e-ef021;
        Mon, 15 Aug 2022 19:27:23 +0800 (CST)
X-RM-TRANSID: 2ef862fa2d9769e-ef021
From:   Kevin Lu <luminlong@139.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, Kevin Lu <luminlong@139.com>
Subject: [PATCH v1 1/1] sound: Add a new kcontrol
Date:   Mon, 15 Aug 2022 19:27:15 +0800
Message-Id: <20220815112715.21617-1-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new kcontrol for phase calib

Signed-off-by: Kevin Lu <luminlong@139.com>
---
 sound/soc/codecs/tlv320adcx140.c | 59 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 0b72965..802c8e4 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -31,6 +31,7 @@ struct adcx140_priv {
 	struct device *dev;
 
 	bool micbias_vg;
+	bool phase_calib_on;
 
 	unsigned int dai_fmt;
 	unsigned int slot_width;
@@ -592,6 +593,52 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"MIC4M Input Mux", "Digital", "MIC4M"},
 };
 
+#define ADCX140_PHASE_CALIB_SWITCH(xname) {\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.info = adcx140_phase_calib_info, \
+	.get = adcx140_phase_calib_get, \
+	.put = adcx140_phase_calib_put}
+
+static int adcx140_phase_calib_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int adcx140_phase_calib_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *value)
+{
+	struct snd_soc_component *codec =
+		snd_soc_kcontrol_component(kcontrol);
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(codec);
+
+	value->value.integer.value[0] = adcx140->phase_calib_on ? 1 : 0;
+
+
+	return 0;
+}
+
+static int adcx140_phase_calib_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *value)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(codec);
+
+	bool v = value->value.integer.value[0] ? true : false;
+
+	if (adcx140->phase_calib_on != v) {
+		adcx140->phase_calib_on = v;
+		return 1;
+	}
+	return 0;
+}
+
 static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	SOC_SINGLE_TLV("Analog CH1 Mic Gain Volume", ADCX140_CH1_CFG1, 2, 42, 0,
 			adc_tlv),
@@ -628,6 +675,7 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 			0, 0xff, 0, dig_vol_tlv),
 	SOC_SINGLE_TLV("Digital CH8 Out Volume", ADCX140_CH8_CFG2,
 			0, 0xff, 0, dig_vol_tlv),
+	ADCX140_PHASE_CALIB_SWITCH("Adcx140 Phase Calib Switch"),
 };
 
 static int adcx140_reset(struct adcx140_priv *adcx140)
@@ -653,6 +701,8 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 {
 	int pwr_ctrl = 0;
+	int ret = 0;
+	struct snd_soc_component *component = adcx140->component;
 
 	if (power_state)
 		pwr_ctrl = ADCX140_PWR_CFG_ADC_PDZ | ADCX140_PWR_CFG_PLL_PDZ;
@@ -660,6 +710,14 @@ static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 	if (adcx140->micbias_vg && power_state)
 		pwr_ctrl |= ADCX140_PWR_CFG_BIAS_PDZ;
 
+	if (pwr_ctrl) {
+		ret = regmap_write(adcx140->regmap, ADCX140_PHASE_CALIB,
+			adcx140->phase_calib_on ? 0x00 : 0x40);
+		if (ret)
+			dev_err(component->dev, "%s: register write error %d\n",
+				__func__, ret);
+	}
+
 	regmap_update_bits(adcx140->regmap, ADCX140_PWR_CFG,
 			   ADCX140_PWR_CTRL_MSK, pwr_ctrl);
 }
@@ -1098,6 +1156,7 @@ static int adcx140_i2c_probe(struct i2c_client *i2c)
 	if (!adcx140)
 		return -ENOMEM;
 
+	adcx140->phase_calib_on = false;
 	adcx140->dev = &i2c->dev;
 
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index d7d4e3a..827f373 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -90,6 +90,7 @@
 #define ADCX140_PWR_CFG		0x75
 #define ADCX140_DEV_STS0	0x76
 #define ADCX140_DEV_STS1	0x77
+#define ADCX140_PHASE_CALIB		0X7b
 
 #define ADCX140_RESET	BIT(0)
 
-- 
2.17.1


