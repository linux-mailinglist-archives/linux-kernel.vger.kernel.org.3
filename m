Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2386258B919
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 05:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiHGDmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 23:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 23:42:03 -0400
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211ECE1B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 20:42:01 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[61.152.201.158])
        by rmsmtp-lg-appmail-20-12023 (RichMail) with SMTP id 2ef762ef344d672-8c4c7;
        Sun, 07 Aug 2022 11:41:48 +0800 (CST)
X-RM-TRANSID: 2ef762ef344d672-8c4c7
From:   Kevin Lu <luminlong@139.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, Kevin Lu <luminlong@139.com>
Subject: [PATCH v1 1/1] drivers: Modify some parts
Date:   Sun,  7 Aug 2022 11:40:52 +0800
Message-Id: <20220807034052.2314-2-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220807034052.2314-1-luminlong@139.com>
References: <20220807034052.2314-1-luminlong@139.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new kcontrol for phase calib, remove unnecessary header file,
make code more comply with linux coding style

Signed-off-by: Kevin Lu <luminlong@139.com>
---
 tlv320adcx140.c | 114 ++++++++++++++++++++++++++++++++++++------------
 tlv320adcx140.h |   7 +--
 2 files changed, 90 insertions(+), 31 deletions(-)

diff --git a/tlv320adcx140.c b/tlv320adcx140.c
index 2844a9d..ed5db00 100644
--- a/tlv320adcx140.c
+++ b/tlv320adcx140.c
@@ -1,24 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 // TLV320ADCX140 Sound driver
-// Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
+// Copyright (C) 2020 - 2022 Texas Instruments Incorporated
+// - https://www.ti.com/
+/*
+ * Author: Kevin Lu <kevin-lu@ti.com>
+ *
+ *  Features:-
+ *
+ *   o Add a new kcontrol for phase calib
+ *   o Remove unnecessary header file
+ *   o Make code more comply with linux coding style
+ */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
-#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
-#include <linux/slab.h>
-#include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/initval.h>
 #include <sound/tlv.h>
 
 #include "tlv320adcx140.h"
@@ -34,6 +36,7 @@ struct adcx140_priv {
 
 	unsigned int dai_fmt;
 	unsigned int slot_width;
+	int phase_calib_on;
 };
 
 static const char * const gpo_config_names[] = {
@@ -592,6 +595,39 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"MIC4M Input Mux", "Digital", "MIC4M"},
 };
 
+static const char * const phase_calib_text[] = {
+	"Disable",
+	"Enable"
+};
+
+static const struct soc_enum phase_calib_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(phase_calib_text), phase_calib_text),
+};
+
+static int adcx140_phase_calib_get(struct snd_kcontrol *pKcontrol,
+	struct snd_ctl_elem_value *pValue)
+{
+	struct snd_soc_component *codec =
+		snd_soc_kcontrol_component(pKcontrol);
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(codec);
+
+	pValue->value.integer.value[0] = adcx140->phase_calib_on;
+
+	return 0;
+}
+
+static int adcx140_phase_calib_put(struct snd_kcontrol *pKcontrol,
+	struct snd_ctl_elem_value *pValue)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(pKcontrol);
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(codec);
+
+	adcx140->phase_calib_on = pValue->value.integer.value[0];
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	SOC_SINGLE_TLV("Analog CH1 Mic Gain Volume", ADCX140_CH1_CFG1, 2, 42, 0,
 			adc_tlv),
@@ -628,6 +664,8 @@ static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 			0, 0xff, 0, dig_vol_tlv),
 	SOC_SINGLE_TLV("Digital CH8 Out Volume", ADCX140_CH8_CFG2,
 			0, 0xff, 0, dig_vol_tlv),
+	SOC_ENUM_EXT("Phase calib", phase_calib_enum[0],
+		adcx140_phase_calib_get, adcx140_phase_calib_put),
 };
 
 static int adcx140_reset(struct adcx140_priv *adcx140)
@@ -650,9 +688,11 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 	return ret;
 }
 
-static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
+static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140,
+	bool power_state)
 {
-	int pwr_ctrl = 0;
+	int pwr_ctrl = 0, ret = 0;
+	struct snd_soc_component *component = adcx140->component;
 
 	if (power_state)
 		pwr_ctrl = ADCX140_PWR_CFG_ADC_PDZ | ADCX140_PWR_CFG_PLL_PDZ;
@@ -660,8 +700,17 @@ static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
 	if (adcx140->micbias_vg && power_state)
 		pwr_ctrl |= ADCX140_PWR_CFG_BIAS_PDZ;
 
-	regmap_update_bits(adcx140->regmap, ADCX140_PWR_CFG,
-			   ADCX140_PWR_CTRL_MSK, pwr_ctrl);
+	ret = regmap_write(adcx140->regmap, ADCX140_PHASE_CALIB,
+		adcx140->phase_calib_on ? 0x00 : 0x40);
+	if (ret)
+		dev_err(component->dev, "%s: register write error %d\n",
+			__func__, ret);
+
+	ret = regmap_update_bits(adcx140->regmap, ADCX140_PWR_CFG,
+		ADCX140_PWR_CTRL_MSK, pwr_ctrl);
+	if (ret)
+		dev_err(component->dev, "%s: register bits update error %d\n",
+			__func__, ret);
 }
 
 static int adcx140_hw_params(struct snd_pcm_substream *substream,
@@ -795,7 +844,8 @@ static int adcx140_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
 	 * only supports adjacent slots beginning at the first slot.
 	 */
 	if (tx_mask != GENMASK(__fls(tx_mask), 0)) {
-		dev_err(component->dev, "Only lower adjacent slots are supported\n");
+		dev_err(component->dev,
+			"Only lower adjacent slots are supported\n");
 		return -EINVAL;
 	}
 
@@ -806,7 +856,8 @@ static int adcx140_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
 	case 32:
 		break;
 	default:
-		dev_err(component->dev, "Unsupported slot width %d\n", slot_width);
+		dev_err(component->dev, "Unsupported slot width %d\n",
+			slot_width);
 		return -EINVAL;
 	}
 
@@ -837,12 +888,14 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
 			continue;
 
 		if (gpo_outputs[0] > ADCX140_GPO_CFG_MAX) {
-			dev_err(adcx140->dev, "GPO%d config out of range\n", i + 1);
+			dev_err(adcx140->dev, "GPO%d config out of range\n",
+				i + 1);
 			return -EINVAL;
 		}
 
 		if (gpo_outputs[1] > ADCX140_GPO_DRV_MAX) {
-			dev_err(adcx140->dev, "GPO%d drive out of range\n", i + 1);
+			dev_err(adcx140->dev, "GPO%d drive out of range\n",
+				i + 1);
 			return -EINVAL;
 		}
 
@@ -891,7 +944,8 @@ static int adcx140_configure_gpio(struct adcx140_priv *adcx140)
 	gpio_output_val = gpio_outputs[0] << ADCX140_GPIO_SHIFT
 		| gpio_outputs[1];
 
-	return regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0, gpio_output_val);
+	return regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0,
+		gpio_output_val);
 }
 
 static int adcx140_codec_probe(struct snd_soc_component *component)
@@ -958,7 +1012,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 			return ret;
 
 		for (i = 0; i < pdm_count; i++)
-			pdm_edge_val |= pdm_edges[i] << (ADCX140_PDM_EDGE_SHIFT - i);
+			pdm_edge_val |=
+			pdm_edges[i] << (ADCX140_PDM_EDGE_SHIFT - i);
 
 		ret = regmap_write(adcx140->regmap, ADCX140_PDM_CFG,
 				   pdm_edge_val);
@@ -974,16 +1029,16 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 		if (ret)
 			return ret;
 
-		gpi_input_val = gpi_inputs[ADCX140_GPI1_INDEX] << ADCX140_GPI_SHIFT |
-				gpi_inputs[ADCX140_GPI2_INDEX];
+		gpi_input_val = gpi_inputs[ADCX140_GPI1_INDEX]
+			<< ADCX140_GPI_SHIFT | gpi_inputs[ADCX140_GPI2_INDEX];
 
 		ret = regmap_write(adcx140->regmap, ADCX140_GPI_CFG0,
 				   gpi_input_val);
 		if (ret)
 			return ret;
 
-		gpi_input_val = gpi_inputs[ADCX140_GPI3_INDEX] << ADCX140_GPI_SHIFT |
-				gpi_inputs[ADCX140_GPI4_INDEX];
+		gpi_input_val = gpi_inputs[ADCX140_GPI3_INDEX]
+			<< ADCX140_GPI_SHIFT | gpi_inputs[ADCX140_GPI4_INDEX];
 
 		ret = regmap_write(adcx140->regmap, ADCX140_GPI_CFG1,
 				   gpi_input_val);
@@ -1010,7 +1065,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 		ret = regmap_update_bits(adcx140->regmap, ADCX140_ASI_CFG0,
 				 ADCX140_TX_FILL, ADCX140_TX_FILL);
 		if (ret) {
-			dev_err(adcx140->dev, "Setting Tx drive failed %d\n", ret);
+			dev_err(adcx140->dev,
+				"Setting Tx drive failed %d\n", ret);
 			goto out;
 		}
 	}
@@ -1020,8 +1076,9 @@ out:
 	return ret;
 }
 
-static int adcx140_set_bias_level(struct snd_soc_component *component,
-				  enum snd_soc_bias_level level)
+static int adcx140_set_bias_level(
+	struct snd_soc_component *component,
+	enum snd_soc_bias_level level)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 
@@ -1116,7 +1173,8 @@ static int adcx140_i2c_probe(struct i2c_client *i2c)
 			return ret;
 		}
 
-		ret = devm_add_action_or_reset(&i2c->dev, adcx140_disable_regulator, adcx140);
+		ret = devm_add_action_or_reset(&i2c->dev,
+			adcx140_disable_regulator, adcx140);
 		if (ret)
 			return ret;
 	}
@@ -1156,4 +1214,4 @@ module_i2c_driver(adcx140_i2c_driver);
 
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_DESCRIPTION("ASoC TLV320ADCX140 CODEC Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/tlv320adcx140.h b/tlv320adcx140.h
index d7d4e3a..ca05a94 100644
--- a/tlv320adcx140.h
+++ b/tlv320adcx140.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // TLV320ADCX104 Sound driver
 // Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
 
@@ -16,7 +16,7 @@
 
 #define ADCX140_PAGE_SELECT	0x00
 #define ADCX140_SW_RESET	0x01
-#define ADCX140_SLEEP_CFG 	0x02
+#define ADCX140_SLEEP_CFG	0x02
 #define ADCX140_SHDN_CFG	0x05
 #define ADCX140_ASI_CFG0	0x07
 #define ADCX140_ASI_CFG1	0x08
@@ -63,7 +63,7 @@
 #define ADCX140_CH3_CFG1	0x47
 #define ADCX140_CH3_CFG2	0x48
 #define ADCX140_CH3_CFG3	0x49
-#define ADCX140_CH3_CFG4 	0x4a
+#define ADCX140_CH3_CFG4	0x4a
 #define ADCX140_CH4_CFG0	0x4b
 #define ADCX140_CH4_CFG1	0x4c
 #define ADCX140_CH4_CFG2	0x4d
@@ -90,6 +90,7 @@
 #define ADCX140_PWR_CFG		0x75
 #define ADCX140_DEV_STS0	0x76
 #define ADCX140_DEV_STS1	0x77
+#define ADCX140_PHASE_CALIB	0x7b
 
 #define ADCX140_RESET	BIT(0)
 
-- 
2.17.1


