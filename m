Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B25B0664
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIGOWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIGOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:22:30 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C57A535;
        Wed,  7 Sep 2022 07:22:16 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E1F6920000A;
        Wed,  7 Sep 2022 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662560535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuLgzYpw92Z5skYvCzdhlOMlfP8qmscKLZEAb70AKTs=;
        b=DN8Rg/nbHNnTFIRz68juFamKfuaBvwQ0gkCeYBgkQODd8YW8yFYCkr4sc1Tjonht0NcunK
        RFEqWHlXeU4W87ocOy4oVphuNrkhq8Ok0EtxOSskU/EPKcdB3xjj7G0haxzppU5wD7fkmQ
        xAPu5AXICCS2sDKmVqVkzccGKNejd0iPrVvxz5ElqSIqpYNlSV5gDvScioW7+hYPGb+5RW
        CqaxecofWcPHPa4ChShtNtEtbzx23BwMHgxs8hy5RT80j1+8YmH91f8FEe4erMgsIM1Xgz
        xqprRuWoFj8siCzEmAjCmnBIl2kkSzzmTzbkYmLik6qJjWcZRlFw5OvdF4d6Dg==
From:   luca.ceresoli@bootlin.com
To:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 7/8] ASoC: codecs: Add RK3308 internal audio codec driver
Date:   Wed,  7 Sep 2022 16:21:23 +0200
Message-Id: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

Add driver for the internal audio codec of the Rockchip RK3308 SoC.

Initially based on the vendor kernel driver [0], with lots of cleanups,
fixes, improvements and removal of some features.

[0] https://github.com/rockchip-linux/kernel/blob/develop-4.19/sound/soc/codecs/rk3308_codec.c

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 MAINTAINERS                     |    2 +
 sound/soc/codecs/Kconfig        |   11 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/rk3308_codec.c | 2122 +++++++++++++++++++++++++++++++
 sound/soc/codecs/rk3308_codec.h |  648 ++++++++++
 5 files changed, 2785 insertions(+)
 create mode 100644 sound/soc/codecs/rk3308_codec.c
 create mode 100644 sound/soc/codecs/rk3308_codec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 079bdd95dc49..fb2a0a6e3c1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17593,6 +17593,8 @@ M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
 F:	include/dt-bindings/sound/rockchip,rk3308-codec.h
+F:	sound/soc/codecs/rk3308_codec.c
+F:	sound/soc/codecs/rk3308_codec.h
 
 ROCKCHIP RK3308 SOUND CARD DRIVER
 M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c7d83fe999e9..e05b084308f4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -164,6 +164,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_PCM5102A
 	imply SND_SOC_PCM512x_I2C
 	imply SND_SOC_PCM512x_SPI
+	imply SND_SOC_RK3308
 	imply SND_SOC_RK3328
 	imply SND_SOC_RK817
 	imply SND_SOC_RT274
@@ -1191,6 +1192,16 @@ config SND_SOC_PCM512x_SPI
 	select SND_SOC_PCM512x
 	select REGMAP_SPI
 
+config SND_SOC_RK3308
+	tristate "Rockchip RK3308 audio CODEC"
+	select REGMAP_MMIO
+	help
+	  This is a device driver for the audio codec embedded in the
+	  Rockchip RK3308 SoC.
+
+	  It has 8 24-bit ADCs and 2 24-bit DACs. The maximum supported
+	  sampling rate is 192 kHz.
+
 config SND_SOC_RK3328
 	tristate "Rockchip RK3328 audio CODEC"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 16a01635dd04..8f6a473c2467 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -181,6 +181,7 @@ snd-soc-pcm5102a-objs := pcm5102a.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
+snd-soc-rk3308-objs := rk3308_codec.o
 snd-soc-rk3328-objs := rk3328_codec.o
 snd-soc-rk817-objs := rk817_codec.o
 snd-soc-rl6231-objs := rl6231.o
@@ -534,6 +535,7 @@ obj-$(CONFIG_SND_SOC_PCM5102A)	+= snd-soc-pcm5102a.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
+obj-$(CONFIG_SND_SOC_RK3308)	+= snd-soc-rk3308.o
 obj-$(CONFIG_SND_SOC_RK3328)	+= snd-soc-rk3328.o
 obj-$(CONFIG_SND_SOC_RK817)	+= snd-soc-rk817.o
 obj-$(CONFIG_SND_SOC_RL6231)	+= snd-soc-rl6231.o
diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
new file mode 100644
index 000000000000..2c001689dce7
--- /dev/null
+++ b/sound/soc/codecs/rk3308_codec.c
@@ -0,0 +1,2122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Rockchip RK3308 internal audio codec driver
+ *
+ * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd All rights reserved.
+ * Copyright (c) 2022, Vivax-Metrotech Ltd
+ */
+
+#include <dt-bindings/sound/rockchip,rk3308-codec.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/util_macros.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "rk3308_codec.h"
+
+#define ADC_LR_GROUP_MAX		4
+#define RK3308_N_MICBIAS_MAX		2
+
+#define GRF_CHIP_ID			0x800
+
+#define ACODEC_VERSION_A		0xa
+#define ACODEC_VERSION_B		0xb
+
+enum {
+	ADC_GRP0_MICIN = 0,
+	ADC_GRP0_LINEIN
+};
+
+enum {
+	DAC_LINEOUT = 0,
+	DAC_HPOUT = 1,
+	DAC_LINEOUT_HPOUT = 11,
+};
+
+struct rk3308_codec_priv {
+	const struct device *dev;
+	struct regmap *regmap;
+	struct regmap *grf;
+	struct reset_control *reset;
+	struct clk *pclk;
+	struct clk *mclk_rx;
+	struct clk *mclk_tx;
+	struct snd_soc_component *component;
+	u32 codec_ver;
+
+	/*
+	 * To select ADCs for groups:
+	 *
+	 * grp 0 -- select ADC1 / ADC2
+	 * grp 1 -- select ADC3 / ADC4
+	 * grp 2 -- select ADC5 / ADC6
+	 * grp 3 -- select ADC7 / ADC8
+	 */
+	u32 used_adc_grps;
+	int adc_grp0_using_linein;
+	/* 0: line out, 1: hp out, 11: lineout and hpout */
+	int dac_output;
+
+	/* AGC L/R Off/on */
+	unsigned int agc_l[ADC_LR_GROUP_MAX];
+	unsigned int agc_r[ADC_LR_GROUP_MAX];
+
+	/* Only hpout do fade-in and fade-out */
+	unsigned int hpout_l_dgain;
+	unsigned int hpout_r_dgain;
+
+	bool micbias_enabled[RK3308_N_MICBIAS_MAX];
+	u32 micbias_avdd_mult;
+};
+
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_alc_agc_grp_gain_tlv,     -1800, 150, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_alc_agc_grp_max_gain_tlv, -1350, 600, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_alc_agc_grp_min_gain_tlv, -1800, 600, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_adc_alc_gain_tlv,	 -1800, 150, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_dac_hpout_gain_tlv,	 -3900, 150, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_dac_hpmix_gain_tlv,	  -600, 600, 0);
+
+static const DECLARE_TLV_DB_RANGE(rk3308_codec_dac_lineout_gain_tlv,
+	0, 0, TLV_DB_SCALE_ITEM(-600, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(-300, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(-150, 0, 0),
+	3, 3, TLV_DB_SCALE_ITEM(0,    0, 0),
+);
+
+static int rk3308_codec_hpout_l_get_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_hpout_l_put_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_hpout_r_get_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_hpout_r_put_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_agc_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_agc_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_micbias_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol);
+static int rk3308_codec_micbias_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol);
+
+static const char *offon_text[2] = {
+	[0] = "Off",
+	[1] = "On",
+};
+
+static const struct soc_enum rk3308_micbias_enum[] = {
+	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(1, 0, ARRAY_SIZE(offon_text), offon_text),
+};
+
+/* ALC AGC Switch */
+static const struct soc_enum rk3308_agc_enum_array[] = {
+	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(0, 1, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(1, 0, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(1, 1, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(2, 0, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(2, 1, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(3, 0, ARRAY_SIZE(offon_text), offon_text),
+	SOC_ENUM_SINGLE(3, 1, ARRAY_SIZE(offon_text), offon_text),
+};
+
+static const unsigned int agc_approx_rate[] = {
+	96000, 48000, 44100, 32000, 24000, 16000, 12000, 8000
+};
+
+static const struct snd_kcontrol_new rk3308_codec_controls[] = {
+	/* Despite the register names, these set the gain when AGC is OFF */
+	SOC_SINGLE_RANGE_TLV("MIC1 Capture Volume",
+			     RK3308_ADC_ANA_CON03(0),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC2 Capture Volume",
+			     RK3308_ADC_ANA_CON04(0),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC3 Capture Volume",
+			     RK3308_ADC_ANA_CON03(1),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC4 Capture Volume",
+			     RK3308_ADC_ANA_CON04(1),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC5 Capture Volume",
+			     RK3308_ADC_ANA_CON03(2),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC6 Capture Volume",
+			     RK3308_ADC_ANA_CON04(2),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC7 Capture Volume",
+			     RK3308_ADC_ANA_CON03(3),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC8 Capture Volume",
+			     RK3308_ADC_ANA_CON04(3),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE("MIC1 Capture Switch", RK3308_ADC_DIG_CON03(0), RK3308_ADC_L_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC2 Capture Switch", RK3308_ADC_DIG_CON03(0), RK3308_ADC_R_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC3 Capture Switch", RK3308_ADC_DIG_CON03(1), RK3308_ADC_L_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC4 Capture Switch", RK3308_ADC_DIG_CON03(1), RK3308_ADC_R_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC5 Capture Switch", RK3308_ADC_DIG_CON03(2), RK3308_ADC_L_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC6 Capture Switch", RK3308_ADC_DIG_CON03(2), RK3308_ADC_R_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC7 Capture Switch", RK3308_ADC_DIG_CON03(3), RK3308_ADC_L_CH_BIST_SFT, 1, 1),
+	SOC_SINGLE("MIC8 Capture Switch", RK3308_ADC_DIG_CON03(3), RK3308_ADC_R_CH_BIST_SFT, 1, 1),
+
+	SOC_ENUM_EXT("MIC1 AGC Capture Switch", rk3308_agc_enum_array[0],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC2 AGC Capture Switch", rk3308_agc_enum_array[1],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC3 AGC Capture Switch", rk3308_agc_enum_array[2],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC4 AGC Capture Switch", rk3308_agc_enum_array[3],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC5 AGC Capture Switch", rk3308_agc_enum_array[4],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC6 AGC Capture Switch", rk3308_agc_enum_array[5],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC7 AGC Capture Switch", rk3308_agc_enum_array[6],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+	SOC_ENUM_EXT("MIC8 AGC Capture Switch", rk3308_agc_enum_array[7],
+		     rk3308_codec_agc_get, rk3308_codec_agc_put),
+
+	SOC_SINGLE_RANGE_TLV("MIC1 AGC Max Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(0),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC2 AGC Max Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(0),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC3 AGC Max Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(1),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC4 AGC Max Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(1),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC5 AGC Max Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(2),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC6 AGC Max Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(2),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC7 AGC Max Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(3),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC8 AGC Max Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(3),
+			     RK3308_AGC_MAX_GAIN_PGA_SFT,
+			     RK3308_AGC_MAX_GAIN_PGA_MIN,
+			     RK3308_AGC_MAX_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_max_gain_tlv),
+
+	SOC_SINGLE_RANGE_TLV("MIC1 AGC Min Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(0),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC2 AGC Min Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(0),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC3 AGC Min Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(1),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC4 AGC Min Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(1),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC5 AGC Min Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(2),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC6 AGC Min Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(2),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC7 AGC Min Capture Volume",
+			     RK3308_ALC_L_DIG_CON09(3),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC8 AGC Min Capture Volume",
+			     RK3308_ALC_R_DIG_CON09(3),
+			     RK3308_AGC_MIN_GAIN_PGA_SFT,
+			     RK3308_AGC_MIN_GAIN_PGA_MIN,
+			     RK3308_AGC_MIN_GAIN_PGA_MAX,
+			     0, rk3308_codec_alc_agc_grp_min_gain_tlv),
+
+	SOC_SINGLE_RANGE_TLV("MIC1 PGA Gain Capture Volume",
+			     RK3308_ALC_L_DIG_CON03(0),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC2 PGA Gain Capture Volume",
+			     RK3308_ALC_R_DIG_CON03(0),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC3 PGA Gain Capture Volume",
+			     RK3308_ALC_L_DIG_CON03(1),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC4 PGA Gain Capture Volume",
+			     RK3308_ALC_R_DIG_CON03(1),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC5 PGA Gain Capture Volume",
+			     RK3308_ALC_L_DIG_CON03(2),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC6 PGA Gain Capture Volume",
+			     RK3308_ALC_R_DIG_CON03(2),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC7 PGA Gain Capture Volume",
+			     RK3308_ALC_L_DIG_CON03(3),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC8 PGA Gain Capture Volume",
+			     RK3308_ALC_R_DIG_CON03(3),
+			     RK3308_AGC_PGA_GAIN_SFT,
+			     RK3308_AGC_PGA_GAIN_MIN,
+			     RK3308_AGC_PGA_GAIN_MAX,
+			     0, rk3308_codec_alc_agc_grp_gain_tlv),
+
+	SOC_ENUM_EXT("MICBIAS1 Capture Switch", rk3308_micbias_enum[0],
+		     rk3308_codec_micbias_get, rk3308_codec_micbias_put),
+	SOC_ENUM_EXT("MICBIAS2 Capture Switch", rk3308_micbias_enum[1],
+		     rk3308_codec_micbias_get, rk3308_codec_micbias_put),
+
+	SOC_SINGLE_TLV("Line Out Left Playback Volume",
+		       RK3308_DAC_ANA_CON04,
+		       RK3308_DAC_L_LINEOUT_GAIN_SFT,
+		       RK3308_DAC_L_LINEOUT_GAIN_MAX,
+		       0, rk3308_codec_dac_lineout_gain_tlv),
+	SOC_SINGLE_TLV("Line Out Right Playback Volume",
+		       RK3308_DAC_ANA_CON04,
+		       RK3308_DAC_R_LINEOUT_GAIN_SFT,
+		       RK3308_DAC_R_LINEOUT_GAIN_MAX,
+		       0, rk3308_codec_dac_lineout_gain_tlv),
+
+	SOC_SINGLE_EXT_TLV("Headphone Left Playback Volume",
+			   RK3308_DAC_ANA_CON05,
+			   RK3308_DAC_L_HPOUT_GAIN_SFT,
+			   RK3308_DAC_L_HPOUT_GAIN_MAX,
+			   0,
+			   rk3308_codec_hpout_l_get_tlv,
+			   rk3308_codec_hpout_l_put_tlv,
+			   rk3308_codec_dac_hpout_gain_tlv),
+	SOC_SINGLE_EXT_TLV("Headphone Right Playback Volume",
+			   RK3308_DAC_ANA_CON06,
+			   RK3308_DAC_R_HPOUT_GAIN_SFT,
+			   RK3308_DAC_R_HPOUT_GAIN_MAX,
+			   0,
+			   rk3308_codec_hpout_r_get_tlv,
+			   rk3308_codec_hpout_r_put_tlv,
+			   rk3308_codec_dac_hpout_gain_tlv),
+
+	SOC_SINGLE_RANGE_TLV("Headphone Mix Left Playback Volume",
+			     RK3308_DAC_ANA_CON12,
+			     RK3308_DAC_L_HPMIX_GAIN_SFT,
+			     RK3308_DAC_L_HPMIX_GAIN_MIN,
+			     RK3308_DAC_L_HPMIX_GAIN_MAX,
+			     0, rk3308_codec_dac_hpmix_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("Headphone Mix Right Playback Volume",
+			     RK3308_DAC_ANA_CON12,
+			     RK3308_DAC_R_HPMIX_GAIN_SFT,
+			     RK3308_DAC_R_HPMIX_GAIN_MIN,
+			     RK3308_DAC_R_HPMIX_GAIN_MAX,
+			     0, rk3308_codec_dac_hpmix_gain_tlv),
+};
+
+static void rk3308_codec_update_zerocross(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int agc_on, value;
+	int grp;
+
+	/* 14: enable zero-cross detection if AGC enabled, else AGC won't work */
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		regmap_read(rk3308->regmap, RK3308_ALC_L_DIG_CON09(grp), &agc_on);
+		value = (agc_on & RK3308_AGC_FUNC_SEL_MSK) ? RK3308_ADC_CH1_ZEROCROSS_DET_EN : 0;
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				   RK3308_ADC_CH1_ZEROCROSS_DET_EN, value);
+
+		regmap_read(rk3308->regmap, RK3308_ALC_R_DIG_CON09(grp), &agc_on);
+		value = (agc_on & RK3308_AGC_FUNC_SEL_MSK) ? RK3308_ADC_CH2_ZEROCROSS_DET_EN : 0;
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				   RK3308_ADC_CH2_ZEROCROSS_DET_EN, value);
+	}
+}
+
+static int rk3308_codec_agc_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+
+	snd_BUG_ON(e->reg < 0 || e->reg > ADC_LR_GROUP_MAX - 1);
+
+	if (e->shift_l)
+		ucontrol->value.integer.value[0] = rk3308->agc_r[e->reg];
+	else
+		ucontrol->value.integer.value[0] = rk3308->agc_l[e->reg];
+
+	return 0;
+}
+
+static int rk3308_codec_agc_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int value = ucontrol->value.integer.value[0];
+	int grp = e->reg;
+
+	snd_BUG_ON(e->reg < 0 || e->reg > ADC_LR_GROUP_MAX - 1);
+
+	if (value) {
+		/* ALC AGC On */
+		if (e->shift_l) {
+			/* ALC AGC Right On */
+			regmap_set_bits(rk3308->regmap, RK3308_ALC_R_DIG_CON09(grp),
+					RK3308_AGC_FUNC_SEL_MSK);
+			regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON11(grp),
+					RK3308_ADC_ALCR_CON_GAIN_PGAR_EN);
+
+			rk3308->agc_r[e->reg] = 1;
+		} else {
+			/* ALC AGC Left On */
+			regmap_set_bits(rk3308->regmap, RK3308_ALC_L_DIG_CON09(grp),
+					RK3308_AGC_FUNC_SEL_MSK);
+			regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON11(grp),
+					RK3308_ADC_ALCL_CON_GAIN_PGAL_EN);
+
+			rk3308->agc_l[e->reg] = 1;
+		}
+	} else {
+		/* ALC AGC Off */
+		if (e->shift_l) {
+			/* ALC AGC Right Off */
+			regmap_clear_bits(rk3308->regmap, RK3308_ALC_R_DIG_CON09(grp),
+					  RK3308_AGC_FUNC_SEL_MSK);
+			regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON11(grp),
+					  RK3308_ADC_ALCR_CON_GAIN_PGAR_EN);
+
+			rk3308->agc_r[e->reg] = 0;
+		} else {
+			/* ALC AGC Left Off */
+			regmap_clear_bits(rk3308->regmap, RK3308_ALC_L_DIG_CON09(grp),
+					  RK3308_AGC_FUNC_SEL_MSK);
+			regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON11(grp),
+					  RK3308_ADC_ALCL_CON_GAIN_PGAL_EN);
+
+			rk3308->agc_l[e->reg] = 0;
+		}
+	}
+
+	rk3308_codec_update_zerocross(rk3308);
+
+	return 0;
+}
+
+/*
+ * Disable all BIAS circuits, but do not change the driver status (rk3308->micbias_*).
+ * Useful e.g. for suspend.
+ */
+static void rk3308_codec_micbias_disable(struct rk3308_codec_priv *rk3308)
+{
+	regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(1), RK3308_ADC_MIC_BIAS_BUF_EN);
+	regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(2), RK3308_ADC_MIC_BIAS_BUF_EN);
+	regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON08(0), RK3308_ADC_MICBIAS_CURRENT_EN);
+}
+
+/*
+ * Enable or disable MIC BIAS HW components based on the status (rk3308->micbias_*).
+ */
+static void rk3308_codec_micbias_apply(struct rk3308_codec_priv *rk3308)
+{
+	bool any_micbias_enabled = (rk3308->micbias_enabled[0] || rk3308->micbias_enabled[1]);
+	unsigned int i;
+
+	/*
+	 * MICBIAS programming sequence from TRM:
+	 *
+	 * - Enable MICBIAS:
+	 *   1. Configure ACODEC_ADC_ANA_CON7[2:0] (AVDD voltage multiplier)
+	 *   2. Wait until the VCMH stable
+	 *   3. Configure ACODEC_ADC_ANA_CON8[4] to 1 (enable current source)
+	 *   4. Configure the (ADC_ANA_CON7+{0x40|0x80})[3] (enable MICBIAS{1|2})
+	 *
+	 * - Disable MICBIAS:
+	 *   1. Clear (ADC_ANA_CON7+{0x40|0x80})[3] (disable MICBIAS{1|2})
+	 *   2. Clear ACODEC_ADC_ANA_CON8[4] (disenable current source)
+	 */
+
+	if (any_micbias_enabled) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(0),
+				   RK3308_ADC_LEVEL_RANGE_MICBIAS_MSK,
+				   rk3308->micbias_avdd_mult);
+
+		/* Wait until the VCMH keep stable */
+		msleep(20);	/* estimated value */
+
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON08(0),
+				RK3308_ADC_MICBIAS_CURRENT_EN);
+	}
+
+	for (i = 0; i < RK3308_N_MICBIAS_MAX; i++)
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(i + 1),
+				   RK3308_ADC_MIC_BIAS_BUF_EN,
+				   rk3308->micbias_enabled[i] ? RK3308_ADC_MIC_BIAS_BUF_EN : 0);
+
+	if (!any_micbias_enabled)
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON08(0),
+				  RK3308_ADC_MICBIAS_CURRENT_EN);
+}
+
+static int rk3308_codec_micbias_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *priv = (struct soc_enum *)kcontrol->private_value;
+
+	ucontrol->value.integer.value[0] = rk3308->micbias_enabled[priv->reg];
+
+	return 0;
+}
+
+static int rk3308_codec_micbias_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *priv = (struct soc_enum *)kcontrol->private_value;
+	unsigned int on = ucontrol->value.integer.value[0];
+
+	rk3308->micbias_enabled[priv->reg] = on;
+
+	rk3308_codec_micbias_apply(rk3308);
+
+	return 0;
+}
+
+static int rk3308_codec_hpout_l_get_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_soc_get_volsw_range(kcontrol, ucontrol);
+}
+
+static int rk3308_codec_hpout_l_put_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	unsigned int dgain = ucontrol->value.integer.value[0];
+
+	rk3308->hpout_l_dgain = dgain;
+
+	return snd_soc_put_volsw_range(kcontrol, ucontrol);
+}
+
+static int rk3308_codec_hpout_r_get_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_soc_get_volsw_range(kcontrol, ucontrol);
+}
+
+static int rk3308_codec_hpout_r_put_tlv(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	unsigned int dgain = ucontrol->value.integer.value[0];
+
+	rk3308->hpout_r_dgain = dgain;
+
+	return snd_soc_put_volsw_range(kcontrol, ucontrol);
+}
+
+static int rk3308_codec_reset(struct snd_soc_component *component)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	reset_control_assert(rk3308->reset);
+	usleep_range(10000, 11000);     /* estimated value */
+	reset_control_deassert(rk3308->reset);
+
+	regmap_write(rk3308->regmap, RK3308_GLB_CON, 0x00);
+	usleep_range(10000, 11000);     /* estimated value */
+	regmap_write(rk3308->regmap, RK3308_GLB_CON,
+		     RK3308_SYS_WORK |
+		     RK3308_DAC_DIG_WORK |
+		     RK3308_ADC_DIG_WORK);
+
+	return 0;
+}
+
+static int rk3308_codec_adc_dig_reset(struct rk3308_codec_priv *rk3308)
+{
+	regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
+	usleep_range(50, 100);
+	regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
+
+	return 0;
+}
+
+static int rk3308_codec_dac_dig_reset(struct rk3308_codec_priv *rk3308)
+{
+	regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_DAC_DIG_WORK);
+	usleep_range(10000, 11000);
+	regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_DAC_DIG_WORK);
+
+	return 0;
+}
+
+static int rk3308_set_bias_level(struct snd_soc_component *component,
+				 enum snd_soc_bias_level level)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		rk3308_codec_micbias_apply(rk3308);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		rk3308_codec_micbias_disable(rk3308);
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+
+	return 0;
+}
+
+static int rk3308_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	const unsigned int inv_bits = fmt & SND_SOC_DAIFMT_INV_MASK;
+	const bool inv_bitclk =
+		(inv_bits & SND_SOC_DAIFMT_IB_IF) ||
+		(inv_bits & SND_SOC_DAIFMT_IB_NF);
+	const bool inv_frmclk =
+		(inv_bits & SND_SOC_DAIFMT_IB_IF) ||
+		(inv_bits & SND_SOC_DAIFMT_NB_IF);
+
+	unsigned int adc_aif1 = 0, adc_aif2 = 0, dac_aif1 = 0, dac_aif2 = 0;
+	int grp, is_master;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	case SND_SOC_DAIFMT_CBP_CFP:
+		adc_aif2 |= RK3308_ADC_IO_MODE_MASTER;
+		adc_aif2 |= RK3308_ADC_MODE_MASTER;
+		dac_aif2 |= RK3308_DAC_IO_MODE_MASTER;
+		dac_aif2 |= RK3308_DAC_MODE_MASTER;
+		is_master = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_PCM;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_PCM;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_I2S;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_RJ;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_RJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_LJ;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_LJ;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (inv_bitclk) {
+		adc_aif2 |= RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL;
+		dac_aif2 |= RK3308_DAC_I2S_BIT_CLK_POL_REVERSAL;
+	}
+
+	if (inv_frmclk) {
+		adc_aif1 |= RK3308_ADC_I2S_LRC_POL_REVERSAL;
+		dac_aif1 |= RK3308_DAC_I2S_LRC_POL_REVERSAL;
+	}
+
+	/*
+	 * Hold ADC Digital registers start at master mode
+	 *
+	 * There are 8 ADCs and use the same SCLK and LRCK internal for master
+	 * mode, We need to make sure that they are in effect at the same time,
+	 * otherwise they will cause the abnormal clocks.
+	 */
+	if (is_master)
+		regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
+
+	for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON01(grp),
+				   RK3308_ADC_I2S_LRC_POL_REVERSAL |
+				   RK3308_ADC_I2S_MODE_MSK,
+				   adc_aif1);
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON02(grp),
+				   RK3308_ADC_IO_MODE_MASTER |
+				   RK3308_ADC_MODE_MASTER |
+				   RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL,
+				   adc_aif2);
+	}
+
+	/* Hold ADC Digital registers end at master mode */
+	if (is_master)
+		regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
+
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_DIG_CON01,
+			   RK3308_DAC_I2S_LRC_POL_REVERSAL |
+			   RK3308_DAC_I2S_MODE_MSK,
+			   dac_aif1);
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_DIG_CON02,
+			   RK3308_DAC_IO_MODE_MASTER |
+			   RK3308_DAC_MODE_MASTER |
+			   RK3308_DAC_I2S_BIT_CLK_POL_REVERSAL,
+			   dac_aif2);
+
+	return 0;
+}
+
+static int rk3308_codec_dac_dig_config(struct rk3308_codec_priv *rk3308,
+				       struct snd_pcm_hw_params *params)
+{
+	unsigned int dac_aif1 = 0;
+
+	/* Clear the status of DAC DIG Digital reigisters */
+	rk3308_codec_dac_dig_reset(rk3308);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_16BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_20BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_24BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_32BITS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_DIG_CON01,
+			   RK3308_DAC_I2S_VALID_LEN_MSK, dac_aif1);
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_DIG_CON02, RK3308_DAC_I2S_WORK);
+
+	return 0;
+}
+
+static int rk3308_codec_adc_dig_config(struct rk3308_codec_priv *rk3308,
+				       struct snd_pcm_hw_params *params)
+{
+	unsigned int adc_aif1 = 0;
+	int grp;
+
+	/* Clear the status of ADC DIG Digital reigisters */
+	rk3308_codec_adc_dig_reset(rk3308);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_16BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_20BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_24BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_32BITS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_channels(params)) {
+	case 1:
+		adc_aif1 |= RK3308_ADC_I2S_MONO;
+		break;
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON01(grp),
+				   RK3308_ADC_I2S_VALID_LEN_MSK | RK3308_ADC_I2S_MONO, adc_aif1);
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_DIG_CON02(grp), RK3308_ADC_I2S_WORK);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_agc_dig_config(struct rk3308_codec_priv *rk3308,
+				       struct snd_pcm_hw_params *params)
+{
+	int grp;
+
+	unsigned int value = find_closest_descending(params_rate(params),
+					  agc_approx_rate, ARRAY_SIZE(agc_approx_rate));
+
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		regmap_update_bits(rk3308->regmap, RK3308_ALC_L_DIG_CON04(grp),
+				   RK3308_AGC_APPROX_RATE_MSK, value);
+		regmap_update_bits(rk3308->regmap, RK3308_ALC_R_DIG_CON04(grp),
+				   RK3308_AGC_APPROX_RATE_MSK, value);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_update_adc_grps(struct rk3308_codec_priv *rk3308,
+					struct snd_pcm_hw_params *params)
+{
+	switch (params_channels(params)) {
+	case 1:
+		rk3308->used_adc_grps = 1;
+		break;
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		rk3308->used_adc_grps = params_channels(params) / 2;
+		break;
+	default:
+		dev_err(rk3308->dev, "Invalid channels: %d\n",
+			params_channels(params));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rk3308_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		int dgain;
+
+		if (mute) {
+			for (dgain = 0x2; dgain <= 0x7; dgain++) {
+				/*
+				 * Keep the max -> min digital CIC interpolation
+				 * filter gain step by step.
+				 *
+				 * loud: 0x2; whisper: 0x7
+				 */
+				regmap_update_bits(rk3308->regmap,
+						   RK3308_DAC_DIG_CON04,
+						   RK3308_DAC_CIC_IF_GAIN_MSK,
+						   dgain);
+				usleep_range(200, 300);  /* estimated value */
+			}
+		} else {
+			for (dgain = 0x7; dgain >= 0x2; dgain--) {
+				/*
+				 * Keep the min -> max digital CIC interpolation
+				 * filter gain step by step
+				 *
+				 * loud: 0x2; whisper: 0x7
+				 */
+				regmap_update_bits(rk3308->regmap,
+						   RK3308_DAC_DIG_CON04,
+						   RK3308_DAC_CIC_IF_GAIN_MSK,
+						   dgain);
+				usleep_range(200, 300);  /* estimated value */
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_digital_fadein(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int dgain, dgain_ref;
+
+	if (rk3308->hpout_l_dgain != rk3308->hpout_r_dgain) {
+		pr_warn("HPOUT l_dgain: 0x%x != r_dgain: 0x%x\n",
+			rk3308->hpout_l_dgain, rk3308->hpout_r_dgain);
+		dgain_ref = min(rk3308->hpout_l_dgain, rk3308->hpout_r_dgain);
+	} else {
+		dgain_ref = rk3308->hpout_l_dgain;
+	}
+
+	/*
+	 * We'd better change the gain of the left and right channels
+	 * at the same time to avoid different listening
+	 */
+	for (dgain = RK3308_DAC_L_HPOUT_GAIN_NDB_39;
+	     dgain <= dgain_ref; dgain++) {
+		/* Step 02 decrease dgains for de-pop */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON05,
+				   RK3308_DAC_L_HPOUT_GAIN_MSK,
+				   dgain);
+
+		/* Step 02 decrease dgains for de-pop */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON06,
+				   RK3308_DAC_R_HPOUT_GAIN_MSK,
+				   dgain);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_digital_fadeout(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int l_dgain, r_dgain;
+
+	/*
+	 * Note. In the step2, adjusting the register step by step to
+	 * the appropriate value and taking 20ms as time step
+	 */
+	regmap_read(rk3308->regmap, RK3308_DAC_ANA_CON05, &l_dgain);
+	l_dgain &= RK3308_DAC_L_HPOUT_GAIN_MSK;
+
+	regmap_read(rk3308->regmap, RK3308_DAC_ANA_CON06, &r_dgain);
+	r_dgain &= RK3308_DAC_R_HPOUT_GAIN_MSK;
+
+	if (l_dgain != r_dgain) {
+		pr_warn("HPOUT l_dgain: 0x%x != r_dgain: 0x%x\n",
+			l_dgain, r_dgain);
+		l_dgain = min(l_dgain, r_dgain);
+	}
+
+	/*
+	 * We'd better change the gain of the left and right channels
+	 * at the same time to avoid different listening
+	 */
+	while (l_dgain >= RK3308_DAC_L_HPOUT_GAIN_NDB_39) {
+		/* Step 02 decrease dgains for de-pop */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON05,
+				   RK3308_DAC_L_HPOUT_GAIN_MSK,
+				   l_dgain);
+
+		/* Step 02 decrease dgains for de-pop */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON06,
+				   RK3308_DAC_R_HPOUT_GAIN_MSK,
+				   l_dgain);
+
+		usleep_range(200, 300);  /* estimated value */
+
+		if (l_dgain == RK3308_DAC_L_HPOUT_GAIN_NDB_39)
+			break;
+
+		l_dgain--;
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_dac_enable(struct rk3308_codec_priv *rk3308)
+{
+	/*
+	 * Note1. If the ACODEC_DAC_ANA_CON12[6] or ACODEC_DAC_ANA_CON12[2]
+	 * is set to 0x1, ignoring the step9~12.
+	 */
+
+	/*
+	 * Note2. If the ACODEC_ DAC_ANA_CON12[7] or ACODEC_DAC_ANA_CON12[3]
+	 * is set to 0x1, the ADC0 or ADC1 should be enabled firstly, and
+	 * please refer to Enable ADC Configuration Standard Usage Flow(expect
+	 * step7~step9,step14).
+	 */
+
+	/*
+	 * Note3. If no opening the line out, ignoring the step6, step17 and
+	 * step19.
+	 */
+
+	/*
+	 * Note4. If no opening the headphone out, ignoring the step3,step7~8,
+	 * step16 and step18.
+	 */
+
+	/*
+	 * Note5. In the step18, adjust the register step by step to the
+	 * appropriate value and taking 10ms as one time step
+	 */
+
+	/*
+	 * 1. Set the ACODEC_DAC_ANA_CON0[0] to 0x1, to enable the current
+	 * source of DAC
+	 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON00,
+			RK3308_DAC_CURRENT_EN);
+
+	usleep_range(20, 40);
+
+	/*
+	 * 2. Set the ACODEC_DAC_ANA_CON1[6] and ACODEC_DAC_ANA_CON1[2] to 0x1,
+	 * to enable the reference voltage buffer
+	 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
+			RK3308_DAC_BUF_REF_L_EN |
+			RK3308_DAC_BUF_REF_R_EN);
+
+	/* Waiting the stable reference voltage */
+	mdelay(1);
+
+	/* Step 03 */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
+			   RK3308_DAC_HPOUT_POP_SOUND_L_MSK |
+			   RK3308_DAC_HPOUT_POP_SOUND_R_MSK,
+			   RK3308_DAC_HPOUT_POP_SOUND_L_WORK |
+			   RK3308_DAC_HPOUT_POP_SOUND_R_WORK);
+
+	usleep_range(20, 40);
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B &&
+	    (rk3308->dac_output == DAC_LINEOUT ||
+	     rk3308->dac_output == DAC_LINEOUT_HPOUT)) {
+		/* Step 04 */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON15,
+				   RK3308_DAC_LINEOUT_POP_SOUND_L_MSK |
+				   RK3308_DAC_LINEOUT_POP_SOUND_R_MSK,
+				   RK3308_DAC_L_SEL_DC_FROM_INTERNAL |
+				   RK3308_DAC_R_SEL_DC_FROM_INTERNAL);
+
+		usleep_range(20, 40);
+	}
+
+	/* Step 05 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			RK3308_DAC_L_HPMIX_EN |
+			RK3308_DAC_R_HPMIX_EN);
+
+	/* Waiting the stable HPMIX */
+	mdelay(1);
+
+	/* Step 06. Reset HPMIX and recover HPMIX gains */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			  RK3308_DAC_L_HPMIX_WORK |
+			  RK3308_DAC_R_HPMIX_WORK);
+	usleep_range(50, 100);
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			RK3308_DAC_L_HPMIX_WORK |
+			RK3308_DAC_R_HPMIX_WORK);
+
+	usleep_range(20, 40);
+
+	if (rk3308->dac_output == DAC_LINEOUT ||
+	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
+		/* Step 07 */
+		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
+				RK3308_DAC_L_LINEOUT_EN |
+				RK3308_DAC_R_LINEOUT_EN);
+
+		usleep_range(20, 40);
+	}
+
+	if (rk3308->dac_output == DAC_HPOUT ||
+	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
+		/* Step 08 */
+		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
+				RK3308_DAC_L_HPOUT_EN |
+				RK3308_DAC_R_HPOUT_EN);
+
+		usleep_range(20, 40);
+
+		/* Step 09 */
+		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
+				RK3308_DAC_L_HPOUT_WORK |
+				RK3308_DAC_R_HPOUT_WORK);
+
+		usleep_range(20, 40);
+	}
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/* Step 10 */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON15,
+				   RK3308_DAC_LINEOUT_POP_SOUND_L_MSK |
+				   RK3308_DAC_LINEOUT_POP_SOUND_R_MSK,
+				   RK3308_DAC_L_SEL_LINEOUT_FROM_INTERNAL |
+				   RK3308_DAC_R_SEL_LINEOUT_FROM_INTERNAL);
+
+		usleep_range(20, 40);
+	}
+
+	/* Step 11 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			RK3308_DAC_L_REF_EN | RK3308_DAC_R_REF_EN);
+
+	usleep_range(20, 40);
+
+	/* Step 12 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			RK3308_DAC_L_CLK_EN | RK3308_DAC_R_CLK_EN);
+
+	usleep_range(20, 40);
+
+	/* Step 13 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			RK3308_DAC_L_DAC_EN | RK3308_DAC_R_DAC_EN);
+
+	usleep_range(20, 40);
+
+	/* Step 14 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			RK3308_DAC_L_DAC_WORK | RK3308_DAC_R_DAC_WORK);
+
+	usleep_range(20, 40);
+
+	/* Step 15 */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON12,
+			   RK3308_DAC_L_HPMIX_SEL_MSK |
+			   RK3308_DAC_R_HPMIX_SEL_MSK,
+			   RK3308_DAC_L_HPMIX_I2S |
+			   RK3308_DAC_R_HPMIX_I2S);
+
+	usleep_range(20, 40);
+
+	/* Step 16 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			RK3308_DAC_L_HPMIX_UNMUTE | RK3308_DAC_R_HPMIX_UNMUTE);
+
+	usleep_range(20, 40);
+
+	/* Step 17: Put configuration HPMIX Gain */
+
+	if (rk3308->dac_output == DAC_HPOUT ||
+	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
+		/* Step 18 */
+		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
+				RK3308_DAC_L_HPOUT_UNMUTE | RK3308_DAC_R_HPOUT_UNMUTE);
+
+		usleep_range(20, 40);
+	}
+
+	if (rk3308->dac_output == DAC_LINEOUT ||
+	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
+		/* Step 19 */
+		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
+				RK3308_DAC_L_LINEOUT_UNMUTE | RK3308_DAC_R_LINEOUT_UNMUTE);
+		usleep_range(20, 40);
+	}
+
+	/* Step 20, put configuration HPOUT gain control */
+	/* Step 21, put configuration LINEOUT gain control */
+
+	if (rk3308->dac_output == DAC_HPOUT ||
+	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
+		/* Just for HPOUT */
+		rk3308_codec_digital_fadein(rk3308);
+	}
+
+	/* TODO: TRY TO TEST DRIVE STRENGTH */
+
+	return 0;
+}
+
+static int rk3308_codec_dac_disable(struct rk3308_codec_priv *rk3308)
+{
+	/*
+	 * Step 00 skipped. Keep the DAC channel work and input the mute signal.
+	 */
+
+	/* Step 01 skipped. May set the min gain for LINEOUT. */
+
+	/* Step 02 skipped. May set the min gain for HPOUT. */
+
+	if (rk3308->dac_output == DAC_HPOUT ||
+	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
+		/* Just for HPOUT */
+		rk3308_codec_digital_fadeout(rk3308);
+	}
+
+	/* Step 03 */
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			RK3308_DAC_L_HPMIX_UNMUTE | RK3308_DAC_R_HPMIX_UNMUTE);
+
+	/* Step 04 */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON12,
+			   RK3308_DAC_L_HPMIX_SEL_MSK |
+			   RK3308_DAC_R_HPMIX_SEL_MSK,
+			   RK3308_DAC_L_HPMIX_NONE |
+			   RK3308_DAC_R_HPMIX_NONE);
+	/* Step 05 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
+			  RK3308_DAC_L_HPOUT_UNMUTE |
+			  RK3308_DAC_R_HPOUT_UNMUTE);
+
+	/* Step 06 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			  RK3308_DAC_L_DAC_WORK |
+			  RK3308_DAC_R_DAC_WORK);
+
+	/* Step 07 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
+			  RK3308_DAC_L_HPOUT_EN |
+			  RK3308_DAC_R_HPOUT_EN);
+
+	/* Step 08 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
+			  RK3308_DAC_L_LINEOUT_UNMUTE |
+			  RK3308_DAC_R_LINEOUT_UNMUTE);
+
+	/* Step 09 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
+			  RK3308_DAC_L_LINEOUT_EN |
+			  RK3308_DAC_R_LINEOUT_EN);
+
+	/* Step 10 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			  RK3308_DAC_L_HPMIX_EN |
+			  RK3308_DAC_R_HPMIX_EN);
+
+	/* Step 11 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			  RK3308_DAC_L_DAC_EN |
+			  RK3308_DAC_R_DAC_EN);
+
+	/* Step 12 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			  RK3308_DAC_L_CLK_EN |
+			  RK3308_DAC_R_CLK_EN);
+
+	/* Step 13 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
+			  RK3308_DAC_L_REF_EN |
+			  RK3308_DAC_R_REF_EN);
+
+	/* Step 14 */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
+			   RK3308_DAC_HPOUT_POP_SOUND_L_MSK |
+			   RK3308_DAC_HPOUT_POP_SOUND_R_MSK,
+			   RK3308_DAC_HPOUT_POP_SOUND_L_INIT |
+			   RK3308_DAC_HPOUT_POP_SOUND_R_INIT);
+
+	/* Step 15 */
+	if (rk3308->codec_ver == ACODEC_VERSION_B &&
+	    (rk3308->dac_output == DAC_LINEOUT ||
+	     rk3308->dac_output == DAC_LINEOUT_HPOUT)) {
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON15,
+				   RK3308_DAC_LINEOUT_POP_SOUND_L_MSK |
+				   RK3308_DAC_LINEOUT_POP_SOUND_R_MSK,
+				   RK3308_DAC_L_SEL_DC_FROM_VCM |
+				   RK3308_DAC_R_SEL_DC_FROM_VCM);
+	}
+
+	/* Step 16 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
+			  RK3308_DAC_BUF_REF_L_EN |
+			  RK3308_DAC_BUF_REF_R_EN);
+
+	/* Step 17 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON00,
+			  RK3308_DAC_CURRENT_EN);
+
+	/* Step 18 */
+	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
+			  RK3308_DAC_L_HPOUT_WORK |
+			  RK3308_DAC_R_HPOUT_WORK);
+
+	/* Step 19 */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
+			   RK3308_DAC_L_HPMIX_WORK |
+			   RK3308_DAC_R_HPMIX_WORK,
+			   RK3308_DAC_L_HPMIX_WORK |
+			   RK3308_DAC_R_HPMIX_WORK);
+
+	/* Step 20 skipped, may set the min gain for HPOUT. */
+
+	/*
+	 * Note2. If the ACODEC_DAC_ANA_CON12[7] or ACODEC_DAC_ANA_CON12[3]
+	 * is set to 0x1, add the steps from the section Disable ADC
+	 * Configuration Standard Usage Flow after complete the step 19
+	 *
+	 * IF USING LINE-IN
+	 * rk3308_codec_adc_ana_disable(rk3308, type);
+	 */
+
+	return 0;
+}
+
+static int rk3308_codec_power_on(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int v;
+
+	/* TRM Section 8.6.3 Power Up */
+
+	/* 0. Supply the power of digital part and reset the Audio Codec */
+
+	/*
+	 * 1. Configure ACODEC_DAC_ANA_CON1[1:0] and ACODEC_DAC_ANA_CON1[5:4]
+	 *    to 0x1, to setup dc voltage of the DAC channel output.
+	 */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
+			   RK3308_DAC_HPOUT_POP_SOUND_L_MSK |
+			   RK3308_DAC_HPOUT_POP_SOUND_R_MSK,
+			   RK3308_DAC_HPOUT_POP_SOUND_L_INIT |
+			   RK3308_DAC_HPOUT_POP_SOUND_R_INIT);
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 2. Configure ACODEC_DAC_ANA_CON15[1:0] and
+		 *    ACODEC_DAC_ANA_CON15[5:4] to 0x1, to setup dc voltage of
+		 *    the DAC channel output.
+		 */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON15,
+				   RK3308_DAC_LINEOUT_POP_SOUND_L_MSK |
+				   RK3308_DAC_LINEOUT_POP_SOUND_R_MSK,
+				   RK3308_DAC_L_SEL_DC_FROM_VCM |
+				   RK3308_DAC_R_SEL_DC_FROM_VCM);
+	}
+
+	/*
+	 * 3. Configure the register ACODEC_ADC_ANA_CON10[6:0] to 7’b000_0001.
+	 */
+	regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+			   RK3308_ADC_CURRENT_CHARGE_MSK,
+			   RK3308_ADC_SEL_I(0x1));
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 4. Configure the register ACODEC_ADC_ANA_CON14[3:0] to
+		 *    4’b0001.
+		 */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON14,
+				   RK3308_DAC_CURRENT_CHARGE_MSK,
+				   RK3308_DAC_SEL_I(0x1));
+	}
+
+	/* 5. Supply the power of the analog part(AVDD,AVDDRV) */
+
+	/*
+	 * 6. Configure the register ACODEC_ADC_ANA_CON10[7] to 0x1 to setup
+	 *    reference voltage
+	 */
+	regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0), RK3308_ADC_REF_EN);
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 7. Configure the register ACODEC_ADC_ANA_CON14[4] to 0x1 to
+		 *    setup reference voltage
+		 */
+		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON14,
+				RK3308_DAC_VCM_LINEOUT_EN);
+	}
+
+	/*
+	 * 8. Change the register ACODEC_ADC_ANA_CON10[6:0] from the 0x1 to
+	 *    0x7f step by step or configure the ACODEC_ADC_ANA_CON10[6:0] to
+	 *    0x7f directly. Here the slot time of the step is 200us.
+	 */
+	for (v = 0x1; v <= 0x7f; v++) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+				   RK3308_ADC_CURRENT_CHARGE_MSK, v);
+		usleep_range(200, 400);
+	}
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 9. Change the register ACODEC_ADC_ANA_CON14[3:0] from the 0x1
+		 *    to 0xf step by step or configure the
+		 *    ACODEC_ADC_ANA_CON14[3:0] to 0xf directly. Here the slot
+		 *    time of the step is 200us.
+		 */
+		for (v = 0x1; v <= 0xf; v++) {
+			regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON14,
+					   RK3308_DAC_CURRENT_CHARGE_MSK, v);
+			usleep_range(200, 400);
+		}
+	}
+
+	/* 10. Wait until the voltage of VCM keeps stable at the AVDD/2 */
+	msleep(20);	/* estimated value */
+
+	/*
+	 * 11. Configure the register ACODEC_ADC_ANA_CON10[6:0] to the
+	 *     appropriate value (expect 0x0) for reducing power.
+	 */
+	regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+			   RK3308_ADC_CURRENT_CHARGE_MSK, 0x7c);
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 12. Configure the register ACODEC_DAC_ANA_CON14[6:0] to the
+		 *     appropriate value(expect 0x0) for reducing power.
+		 */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON14,
+				   RK3308_DAC_CURRENT_CHARGE_MSK, 0xf);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_power_off(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int v;
+
+	/*
+	 * 0. Keep the power on and disable the DAC and ADC path according to
+	 *    the section power on configuration standard usage flow.
+	 */
+
+	/*
+	 * 1. Configure the register ACODEC_ADC_ANA_CON10[6:0] to 7’b000_0001.
+	 */
+	regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+			   RK3308_ADC_CURRENT_CHARGE_MSK,
+			   RK3308_ADC_SEL_I(0x1));
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 2. Configure the register ACODEC_DAC_ANA_CON14[3:0] to
+		 *    4’b0001.
+		 */
+		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON14,
+				   RK3308_DAC_CURRENT_CHARGE_MSK,
+				   RK3308_DAC_SEL_I(0x1));
+	}
+
+	/* 3. Configure the register ACODEC_ADC_ANA_CON10[7] to 0x0 */
+	regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0), RK3308_ADC_REF_EN);
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/* 4. Configure the register ACODEC_DAC_ANA_CON14[7] to 0x0 */
+		regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON14,
+				  RK3308_DAC_VCM_LINEOUT_EN);
+	}
+
+	/*
+	 * 5. Change the register ACODEC_ADC_ANA_CON10[6:0] from the 0x1 to 0x7f
+	 *    step by step or configure the ACODEC_ADC_ANA_CON10[6:0] to 0x7f
+	 *    directly. Here the slot time of the step is 200us.
+	 */
+	for (v = 0x1; v <= 0x7f; v++) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+				   RK3308_ADC_CURRENT_CHARGE_MSK, v);
+		usleep_range(200, 400);
+	}
+
+	if (rk3308->codec_ver == ACODEC_VERSION_B) {
+		/*
+		 * 6. Change the register ACODEC_DAC_ANA_CON14[3:0] from the 0x1
+		 *    to 0xf step by step or configure the
+		 *    ACODEC_DAC_ANA_CON14[3:0] to 0xf directly. Here the slot
+		 *    time of the step is 200us.
+		 */
+		for (v = 0x1; v <= 0x7f; v++) {
+			regmap_update_bits(rk3308->regmap,
+					   RK3308_ADC_ANA_CON10(0),
+					   RK3308_ADC_CURRENT_CHARGE_MSK, v);
+			usleep_range(200, 400);
+		}
+	}
+
+	/* 7. Wait until the voltage of VCM keeps stable at the AGND */
+	msleep(20);	/* estimated value */
+
+	/* 8. Power off the analog power supply */
+	/* 9. Power off the digital power supply */
+
+	/* Do something via hardware */
+
+	return 0;
+}
+
+static int rk3308_codec_adc_reinit_mics(struct rk3308_codec_priv *rk3308)
+{
+	int grp;
+
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		/* vendor step 1 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				  RK3308_ADC_CH1_ADC_WORK |
+				  RK3308_ADC_CH2_ADC_WORK);
+
+		/* vendor step 2 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				  RK3308_ADC_CH1_ALC_WORK |
+				  RK3308_ADC_CH2_ALC_WORK);
+
+		/* vendor step 3 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				  RK3308_ADC_CH1_MIC_WORK |
+				  RK3308_ADC_CH2_MIC_WORK);
+	}
+
+	usleep_range(200, 250);	/* estimated value */
+
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		/* vendor step 1 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				RK3308_ADC_CH1_ADC_WORK |
+				RK3308_ADC_CH2_ADC_WORK);
+
+		/* vendor step 2 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				RK3308_ADC_CH1_ALC_WORK |
+				RK3308_ADC_CH2_ALC_WORK);
+
+		/* vendor step 3 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				RK3308_ADC_CH1_MIC_WORK |
+				RK3308_ADC_CH2_MIC_WORK);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_adc_ana_enable(struct rk3308_codec_priv *rk3308)
+{
+	int grp = 0;
+
+	/*
+	 * 1. Set the ACODEC_ADC_ANA_CON7[7:6] and ACODEC_ADC_ANA_CON7[5:4],
+	 * to select the line-in or microphone as input of ADC
+	 *
+	 * Note1. Please ignore the step1 for enabling ADC3, ADC4, ADC5,
+	 * ADC6, ADC7, and ADC8
+	 */
+	if (rk3308->adc_grp0_using_linein) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(0),
+				   RK3308_ADC_CH1_IN_SEL_MSK |
+				   RK3308_ADC_CH2_IN_SEL_MSK,
+				   RK3308_ADC_CH1_IN_LINEIN |
+				   RK3308_ADC_CH2_IN_LINEIN);
+		grp++;
+	}
+
+	for (; grp < rk3308->used_adc_grps; grp++) {
+		regmap_update_bits(rk3308->regmap,
+				   RK3308_ADC_ANA_CON07(grp),
+				   RK3308_ADC_CH1_IN_SEL_MSK |
+				   RK3308_ADC_CH2_IN_SEL_MSK,
+				   RK3308_ADC_CH1_IN_MIC |
+				   RK3308_ADC_CH2_IN_MIC);
+	}
+
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		/*
+		 * 2. Set ACODEC_ADC_ANA_CON0[7] and [3] to 0x1, to end the mute station
+		 * of ADC, to enable the MIC module, to enable the reference voltage
+		 * buffer, and to end the initialization of MIC
+		 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				RK3308_ADC_CH1_MIC_UNMUTE |
+				RK3308_ADC_CH2_MIC_UNMUTE);
+
+		/*
+		 * 3. Set ACODEC_ADC_ANA_CON6[0] to 0x1, to enable the current source
+		 * of audio
+		 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON06(grp),
+				RK3308_ADC_CURRENT_EN);
+	}
+
+	/*
+	 * This is mainly used for BIST mode that wait ADCs are stable.
+	 *
+	 * By tested results, the type delay is >40us, but we need to leave
+	 * enough delay margin.
+	 */
+	usleep_range(400, 500);
+
+	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+		/* vendor step 4 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				RK3308_ADC_CH1_BUF_REF_EN |
+				RK3308_ADC_CH2_BUF_REF_EN);
+
+		/* vendor step 5 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				RK3308_ADC_CH1_MIC_EN |
+				RK3308_ADC_CH2_MIC_EN);
+
+		/* vendor step 6 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				RK3308_ADC_CH1_ALC_EN |
+				RK3308_ADC_CH2_ALC_EN);
+
+		/* vendor step 7 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				RK3308_ADC_CH1_CLK_EN |
+				RK3308_ADC_CH2_CLK_EN);
+
+		/* vendor step 8 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				RK3308_ADC_CH1_ADC_EN |
+				RK3308_ADC_CH2_ADC_EN);
+
+		/* vendor step 9 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				RK3308_ADC_CH1_ADC_WORK |
+				RK3308_ADC_CH2_ADC_WORK);
+
+		/* vendor step 10 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				RK3308_ADC_CH1_ALC_WORK |
+				RK3308_ADC_CH2_ALC_WORK);
+
+		/* vendor step 11 */
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				RK3308_ADC_CH1_MIC_WORK |
+				RK3308_ADC_CH2_MIC_WORK);
+	}
+
+	rk3308_codec_update_zerocross(rk3308);
+
+	return 0;
+}
+
+static int rk3308_codec_adc_ana_disable(struct rk3308_codec_priv *rk3308,
+					unsigned int num_grps)
+{
+	int grp;
+
+	for (grp = 0; grp < num_grps; grp++) {
+		/* vendor step 1 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				  RK3308_ADC_CH1_ZEROCROSS_DET_EN |
+				  RK3308_ADC_CH2_ZEROCROSS_DET_EN);
+
+		/* vendor step 2 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				  RK3308_ADC_CH1_ADC_EN |
+				  RK3308_ADC_CH2_ADC_EN);
+
+		/* vendor step 3 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				  RK3308_ADC_CH1_CLK_EN |
+				  RK3308_ADC_CH2_CLK_EN);
+
+		/* vendor step 4 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				  RK3308_ADC_CH1_ALC_EN |
+				  RK3308_ADC_CH2_ALC_EN);
+
+		/* vendor step 5 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				  RK3308_ADC_CH1_MIC_EN |
+				  RK3308_ADC_CH2_MIC_EN);
+
+		/* vendor step 6 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				  RK3308_ADC_CH1_BUF_REF_EN |
+				  RK3308_ADC_CH2_BUF_REF_EN);
+
+		/* vendor step 7 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON06(grp),
+				  RK3308_ADC_CURRENT_EN);
+
+		/* vendor step 8 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON05(grp),
+				  RK3308_ADC_CH1_ADC_WORK |
+				  RK3308_ADC_CH2_ADC_WORK);
+
+		/* vendor step 9 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				  RK3308_ADC_CH1_ALC_WORK |
+				  RK3308_ADC_CH2_ALC_WORK);
+
+		/* vendor step 10 */
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON00(grp),
+				  RK3308_ADC_CH1_MIC_WORK |
+				  RK3308_ADC_CH2_MIC_WORK);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_open_capture(struct rk3308_codec_priv *rk3308)
+{
+	int grp = 0;
+
+	rk3308_codec_adc_ana_enable(rk3308);
+	rk3308_codec_adc_reinit_mics(rk3308);
+
+	if (rk3308->adc_grp0_using_linein) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON03(0),
+				   RK3308_ADC_L_CH_BIST_MSK,
+				   RK3308_ADC_L_CH_NORMAL_LEFT);
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON03(0),
+				   RK3308_ADC_R_CH_BIST_MSK,
+				   RK3308_ADC_R_CH_NORMAL_RIGHT);
+	} else {
+		for (grp = 0; grp < rk3308->used_adc_grps; grp++) {
+			regmap_update_bits(rk3308->regmap,
+					   RK3308_ADC_DIG_CON03(grp),
+					   RK3308_ADC_L_CH_BIST_MSK,
+					   RK3308_ADC_L_CH_NORMAL_LEFT);
+			regmap_update_bits(rk3308->regmap,
+					   RK3308_ADC_DIG_CON03(grp),
+					   RK3308_ADC_R_CH_BIST_MSK,
+					   RK3308_ADC_R_CH_NORMAL_RIGHT);
+		}
+	}
+
+	return 0;
+}
+
+static void rk3308_codec_adc_mclk_disable(struct rk3308_codec_priv *rk3308)
+{
+	regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_MCLK_GATING_MSK);
+}
+
+static void rk3308_codec_adc_mclk_enable(struct rk3308_codec_priv *rk3308)
+{
+	regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_MCLK_GATING_MSK);
+	usleep_range(20, 40);
+}
+
+static void rk3308_codec_dac_mclk_disable(struct rk3308_codec_priv *rk3308)
+{
+	regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_DAC_MCLK_GATING_MSK);
+}
+
+static void rk3308_codec_dac_mclk_enable(struct rk3308_codec_priv *rk3308)
+{
+	regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_DAC_MCLK_GATING_MSK);
+	usleep_range(20, 40);
+}
+
+static int rk3308_codec_llp_down(struct rk3308_codec_priv *rk3308)
+{
+	rk3308_codec_adc_mclk_disable(rk3308);
+	rk3308_codec_dac_mclk_disable(rk3308);
+
+	return 0;
+}
+
+static int rk3308_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* DAC only supports 2 channels */
+		rk3308_codec_dac_mclk_enable(rk3308);
+		rk3308_codec_dac_enable(rk3308);
+		rk3308_codec_dac_dig_config(rk3308, params);
+	} else {
+		rk3308_codec_micbias_apply(rk3308);
+		rk3308_codec_adc_mclk_enable(rk3308);
+		ret = rk3308_codec_update_adc_grps(rk3308, params);
+		if (ret < 0)
+			return ret;
+
+		rk3308_codec_open_capture(rk3308);
+		rk3308_codec_agc_dig_config(rk3308, params);
+		rk3308_codec_adc_dig_config(rk3308, params);
+	}
+
+	return 0;
+}
+
+static void rk3308_pcm_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		rk3308_codec_dac_disable(rk3308);
+		rk3308_codec_dac_mclk_disable(rk3308);
+	} else {
+		rk3308_codec_adc_ana_disable(rk3308, rk3308->used_adc_grps);
+		rk3308_codec_adc_mclk_disable(rk3308);
+		rk3308_codec_micbias_disable(rk3308);
+	}
+}
+
+static const struct snd_soc_dai_ops rk3308_dai_ops = {
+	.hw_params = rk3308_hw_params,
+	.set_fmt = rk3308_set_dai_fmt,
+	.mute_stream = rk3308_mute_stream,
+	.shutdown = rk3308_pcm_shutdown,
+};
+
+static struct snd_soc_dai_driver rk3308_dai[] = {
+	{
+		.name = "rk3308-hifi",
+		.id = RK3308_HIFI,
+		.playback = {
+			.stream_name = "HiFi Playback",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+				    SNDRV_PCM_FMTBIT_S20_3LE |
+				    SNDRV_PCM_FMTBIT_S24_LE |
+				    SNDRV_PCM_FMTBIT_S32_LE),
+		},
+		.capture = {
+			.stream_name = "HiFi Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+				    SNDRV_PCM_FMTBIT_S20_3LE |
+				    SNDRV_PCM_FMTBIT_S24_LE |
+				    SNDRV_PCM_FMTBIT_S32_LE),
+		},
+		.ops = &rk3308_dai_ops,
+	},
+};
+
+static int rk3308_codec_default_gains(struct rk3308_codec_priv *rk3308)
+{
+	int grp;
+
+	for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++) {
+		/* 12: set ADC gain to 20 dB (recommended by TRM when using MIC input) */
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON01(grp),
+				   RK3308_ADC_CH1_MIC_GAIN_MSK |
+				   RK3308_ADC_CH2_MIC_GAIN_MSK,
+				   RK3308_ADC_CH1_MIC_GAIN_20DB |
+				   RK3308_ADC_CH2_MIC_GAIN_20DB);
+
+	/* vendor step 13, set ALC default gains */
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON03(grp),
+				   RK3308_ADC_CH1_ALC_GAIN_MSK,
+				   RK3308_ADC_CH1_ALC_GAIN_0DB);
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON04(grp),
+				   RK3308_ADC_CH2_ALC_GAIN_MSK,
+				   RK3308_ADC_CH2_ALC_GAIN_0DB);
+	}
+
+	/* Prepare DAC gains */
+	/* Step 15, set HPMIX default gains */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON12,
+			   RK3308_DAC_L_HPMIX_GAIN_MSK |
+			   RK3308_DAC_R_HPMIX_GAIN_MSK,
+			   RK3308_DAC_L_HPMIX_GAIN_NDB_6 |
+			   RK3308_DAC_R_HPMIX_GAIN_NDB_6);
+
+	/* Step 18, set HPOUT default gains */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON05,
+			   RK3308_DAC_L_HPOUT_GAIN_MSK,
+			   RK3308_DAC_L_HPOUT_GAIN_NDB_39);
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON06,
+			   RK3308_DAC_R_HPOUT_GAIN_MSK,
+			   RK3308_DAC_R_HPOUT_GAIN_NDB_39);
+
+	/* Using the same gain to HPOUT LR channels */
+	rk3308->hpout_l_dgain = RK3308_DAC_L_HPOUT_GAIN_NDB_39;
+
+	/* Step 19, set LINEOUT default gains */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
+			   RK3308_DAC_L_LINEOUT_GAIN_MSK |
+			   RK3308_DAC_R_LINEOUT_GAIN_MSK,
+			   RK3308_DAC_L_LINEOUT_GAIN_NDB_6 |
+			   RK3308_DAC_R_LINEOUT_GAIN_NDB_6);
+
+	return 0;
+}
+
+static int rk3308_codec_controls_prepare(struct rk3308_codec_priv *rk3308)
+{
+	int grp;
+
+	for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++) {
+		rk3308->agc_l[grp] = 0;
+		rk3308->agc_r[grp] = 0;
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_prepare(struct rk3308_codec_priv *rk3308)
+{
+	/* Clear registers for ADC and DAC */
+	rk3308_codec_dac_disable(rk3308);
+	rk3308_codec_adc_ana_disable(rk3308, ADC_LR_GROUP_MAX);
+	rk3308_codec_default_gains(rk3308);
+	rk3308_codec_llp_down(rk3308);
+	rk3308_codec_controls_prepare(rk3308);
+
+	return 0;
+}
+
+static int rk3308_probe(struct snd_soc_component *component)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	rk3308->component = component;
+
+	rk3308_codec_reset(component);
+	rk3308_codec_power_on(rk3308);
+
+	rk3308_codec_micbias_disable(rk3308);
+
+	rk3308_codec_prepare(rk3308);
+
+	return 0;
+}
+
+static void rk3308_remove(struct snd_soc_component *component)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	rk3308_codec_micbias_disable(rk3308);
+	rk3308_codec_power_off(rk3308);
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_rk3308 = {
+	.probe = rk3308_probe,
+	.remove = rk3308_remove,
+	.set_bias_level = rk3308_set_bias_level,
+	.controls = rk3308_codec_controls,
+	.num_controls = ARRAY_SIZE(rk3308_codec_controls),
+};
+
+static const struct regmap_config rk3308_codec_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = RK3308_DAC_ANA_CON15,
+};
+
+static int rk3308_codec_get_version(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int chip_id;
+
+	regmap_read(rk3308->grf, GRF_CHIP_ID, &chip_id);
+	switch (chip_id) {
+	case 3306:
+		rk3308->codec_ver = ACODEC_VERSION_A;
+		break;
+	case 0x3308:
+		rk3308->codec_ver = ACODEC_VERSION_B;
+		break;
+	default:
+		return dev_err_probe(rk3308->dev, -EINVAL, "Unknown chip_id: 0x%x\n", chip_id);
+	}
+
+	dev_info(rk3308->dev, "Found codec version %X\n", rk3308->codec_ver);
+	return 0;
+}
+
+static int rk3308_codec_parse_dt(struct rk3308_codec_priv *rk3308)
+{
+	struct device_node *np = rk3308->dev->of_node;
+	int err;
+
+	/* Default value is 0 */
+	err = of_property_read_u32(np, "rockchip,micbias-avdd-multiplier",
+				   &rk3308->micbias_avdd_mult);
+	if (rk3308->micbias_avdd_mult >= RK3308_CODEC_MICBIAS_NUM)
+		return dev_err_probe(rk3308->dev, -EINVAL,
+				     "Invalid value for 'rockchip,micbias-avdd-multiplier'\n");
+
+	return 0;
+}
+
+static int rk3308_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct rk3308_codec_priv *rk3308;
+	struct resource *res;
+	void __iomem *base;
+	int err;
+
+	rk3308 = devm_kzalloc(&pdev->dev, sizeof(*rk3308), GFP_KERNEL);
+	if (!rk3308)
+		return -ENOMEM;
+
+	rk3308->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(rk3308->grf))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->grf),
+			"Missing 'rockchip,grf' property\n");
+
+	rk3308->dev = &pdev->dev;
+
+	err = rk3308_codec_parse_dt(rk3308);
+	if (err)
+		return err;
+
+	rk3308->reset = devm_reset_control_get(&pdev->dev, "acodec");
+	if (IS_ERR(rk3308->reset)) {
+		err = PTR_ERR(rk3308->reset);
+		if (err != -ENOENT)
+			return err;
+
+		dev_dbg(&pdev->dev, "No reset control found\n");
+		rk3308->reset = NULL;
+	}
+
+	rk3308->pclk = devm_clk_get(&pdev->dev, "hclk");
+	if (IS_ERR(rk3308->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->pclk), "Can't get hclk\n");
+
+	rk3308->mclk_rx = devm_clk_get(&pdev->dev, "mclk_rx");
+	if (IS_ERR(rk3308->mclk_rx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->mclk_rx), "Can't get mclk_rx\n");
+
+	rk3308->mclk_tx = devm_clk_get(&pdev->dev, "mclk_tx");
+	if (IS_ERR(rk3308->mclk_tx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->mclk_tx), "Can't get mclk_tx\n");
+
+	err = clk_prepare_enable(rk3308->pclk);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to enable acodec pclk\n");
+
+	err = clk_prepare_enable(rk3308->mclk_rx);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to enable i2s mclk_rx\n");
+
+	err = clk_prepare_enable(rk3308->mclk_tx);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to enable i2s mclk_tx\n");
+
+	err = rk3308_codec_get_version(rk3308);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to get acodec version\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base), "Failed to ioremap resource\n");
+
+	rk3308->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					       &rk3308_codec_regmap_config);
+	if (IS_ERR(rk3308->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->regmap),
+				     "Failed to init regmap\n");
+
+	rk3308->adc_grp0_using_linein = ADC_GRP0_MICIN;
+	rk3308->dac_output = DAC_LINEOUT;
+
+	platform_set_drvdata(pdev, rk3308);
+
+	err = devm_snd_soc_register_component(&pdev->dev, &soc_codec_dev_rk3308,
+					      rk3308_dai, ARRAY_SIZE(rk3308_dai));
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to register codec\n");
+
+	return 0;
+}
+
+static const struct of_device_id rk3308codec_of_match[] = {
+	{ .compatible = "rockchip,rk3308-codec", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rk3308codec_of_match);
+
+static struct platform_driver rk3308_codec_driver = {
+	.driver = {
+		.name = "rk3308-acodec",
+		.of_match_table = of_match_ptr(rk3308codec_of_match),
+	},
+	.probe = rk3308_platform_probe,
+};
+module_platform_driver(rk3308_codec_driver);
+
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
+MODULE_DESCRIPTION("ASoC RK3308 Codec Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/rk3308_codec.h b/sound/soc/codecs/rk3308_codec.h
new file mode 100644
index 000000000000..7ab08972141d
--- /dev/null
+++ b/sound/soc/codecs/rk3308_codec.h
@@ -0,0 +1,648 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Rockchip RK3308 internal audio codec driver -- register definitions
+ *
+ * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd All rights reserved.
+ * Copyright (c) 2022, Vivax-Metrotech Ltd
+ */
+
+#ifndef __RK3308_CODEC_H__
+#define __RK3308_CODEC_H__
+
+#define RK3308_GLB_CON				0x00
+
+/* ADC DIGITAL REGISTERS */
+
+/*
+ * The ADC group are 0 ~ 3, that control:
+ *
+ * CH0: left_0(ADC1) and right_0(ADC2)
+ * CH1: left_1(ADC3) and right_1(ADC4)
+ * CH2: left_2(ADC5) and right_2(ADC6)
+ * CH3: left_3(ADC7) and right_3(ADC8)
+ */
+#define RK3308_ADC_DIG_OFFSET(ch)		(((ch) & 0x3) * 0xc0 + 0x0)
+
+#define RK3308_ADC_DIG_CON01(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x04)
+#define RK3308_ADC_DIG_CON02(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x08)
+#define RK3308_ADC_DIG_CON03(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x0c)
+#define RK3308_ADC_DIG_CON04(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x10)
+#define RK3308_ADC_DIG_CON07(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x1c)
+
+#define RK3308_ALC_L_DIG_CON00(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x40)
+#define RK3308_ALC_L_DIG_CON01(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x44)
+#define RK3308_ALC_L_DIG_CON02(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x48)
+#define RK3308_ALC_L_DIG_CON03(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x4c)
+#define RK3308_ALC_L_DIG_CON04(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x50)
+#define RK3308_ALC_L_DIG_CON05(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x54)
+#define RK3308_ALC_L_DIG_CON06(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x58)
+#define RK3308_ALC_L_DIG_CON07(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x5c)
+#define RK3308_ALC_L_DIG_CON08(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x60)
+#define RK3308_ALC_L_DIG_CON09(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x64)
+#define RK3308_ALC_L_DIG_CON12(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x70)
+
+#define RK3308_ALC_R_DIG_CON00(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x80)
+#define RK3308_ALC_R_DIG_CON01(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x84)
+#define RK3308_ALC_R_DIG_CON02(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x88)
+#define RK3308_ALC_R_DIG_CON03(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x8c)
+#define RK3308_ALC_R_DIG_CON04(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x90)
+#define RK3308_ALC_R_DIG_CON05(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x94)
+#define RK3308_ALC_R_DIG_CON06(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x98)
+#define RK3308_ALC_R_DIG_CON07(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x9c)
+#define RK3308_ALC_R_DIG_CON08(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0xa0)
+#define RK3308_ALC_R_DIG_CON09(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0xa4)
+#define RK3308_ALC_R_DIG_CON12(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0xb0)
+
+/* DAC DIGITAL REGISTERS */
+#define RK3308_DAC_DIG_OFFSET			0x300
+#define RK3308_DAC_DIG_CON01			(RK3308_DAC_DIG_OFFSET + 0x04)
+#define RK3308_DAC_DIG_CON02			(RK3308_DAC_DIG_OFFSET + 0x08)
+#define RK3308_DAC_DIG_CON03			(RK3308_DAC_DIG_OFFSET + 0x0c)
+#define RK3308_DAC_DIG_CON04			(RK3308_DAC_DIG_OFFSET + 0x10)
+#define RK3308_DAC_DIG_CON05			(RK3308_DAC_DIG_OFFSET + 0x14)
+#define RK3308_DAC_DIG_CON10			(RK3308_DAC_DIG_OFFSET + 0x28)
+#define RK3308_DAC_DIG_CON11			(RK3308_DAC_DIG_OFFSET + 0x2c)
+#define RK3308_DAC_DIG_CON13			(RK3308_DAC_DIG_OFFSET + 0x34)
+#define RK3308_DAC_DIG_CON14			(RK3308_DAC_DIG_OFFSET + 0x38)
+
+/* ADC ANALOG REGISTERS */
+/*
+ * The ADC group are 0 ~ 3, that control:
+ *
+ * CH0: left_0(ADC1) and right_0(ADC2)
+ * CH1: left_1(ADC3) and right_1(ADC4)
+ * CH2: left_2(ADC5) and right_2(ADC6)
+ * CH3: left_3(ADC7) and right_3(ADC8)
+ */
+#define RK3308_ADC_ANA_OFFSET(ch)		(((ch) & 0x3) * 0x40 + 0x340)
+#define RK3308_ADC_ANA_CON00(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x00)
+#define RK3308_ADC_ANA_CON01(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x04)
+#define RK3308_ADC_ANA_CON02(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x08)
+#define RK3308_ADC_ANA_CON03(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x0c)
+#define RK3308_ADC_ANA_CON04(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x10)
+#define RK3308_ADC_ANA_CON05(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x14)
+#define RK3308_ADC_ANA_CON06(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x18)
+#define RK3308_ADC_ANA_CON07(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x1c)
+#define RK3308_ADC_ANA_CON08(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x20)
+#define RK3308_ADC_ANA_CON10(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x28)
+#define RK3308_ADC_ANA_CON11(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x2c)
+
+/* DAC ANALOG REGISTERS */
+#define RK3308_DAC_ANA_OFFSET			0x440
+#define RK3308_DAC_ANA_CON00			(RK3308_DAC_ANA_OFFSET + 0x00)
+#define RK3308_DAC_ANA_CON01			(RK3308_DAC_ANA_OFFSET + 0x04)
+#define RK3308_DAC_ANA_CON02			(RK3308_DAC_ANA_OFFSET + 0x08)
+#define RK3308_DAC_ANA_CON03			(RK3308_DAC_ANA_OFFSET + 0x0c)
+#define RK3308_DAC_ANA_CON04			(RK3308_DAC_ANA_OFFSET + 0x10)
+#define RK3308_DAC_ANA_CON05			(RK3308_DAC_ANA_OFFSET + 0x14)
+#define RK3308_DAC_ANA_CON06			(RK3308_DAC_ANA_OFFSET + 0x18)
+#define RK3308_DAC_ANA_CON07			(RK3308_DAC_ANA_OFFSET + 0x1c)
+#define RK3308_DAC_ANA_CON08			(RK3308_DAC_ANA_OFFSET + 0x20)
+#define RK3308_DAC_ANA_CON12			(RK3308_DAC_ANA_OFFSET + 0x30)
+#define RK3308_DAC_ANA_CON13			(RK3308_DAC_ANA_OFFSET + 0x34)
+#define RK3308_DAC_ANA_CON14			(RK3308_DAC_ANA_OFFSET + 0x38)
+#define RK3308_DAC_ANA_CON15			(RK3308_DAC_ANA_OFFSET + 0x3c)
+
+/*
+ * These are the bits for registers
+ */
+
+/* RK3308_GLB_CON - REG: 0x0000 */
+#define RK3308_ADC_BIST_WORK			BIT(7)
+#define RK3308_DAC_BIST_WORK			BIT(6)
+#define RK3308_ADC_MCLK_GATING_MSK		BIT(5)
+#define RK3308_DAC_MCLK_GATING_MSK		BIT(4)
+#define RK3308_CODEC_RST_MSK			(0x7 << 0)
+#define RK3308_ADC_DIG_WORK			BIT(2)
+#define RK3308_DAC_DIG_WORK			BIT(1)
+#define RK3308_SYS_WORK				BIT(0)
+
+/* RK3308_ADC_DIG_CON01 - REG: 0x0004 */
+#define RK3308_ADC_I2S_LRC_POL_REVERSAL		BIT(7)
+#define RK3308_ADC_I2S_VALID_LEN_SFT		5
+#define RK3308_ADC_I2S_VALID_LEN_MSK		(0x3 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_32BITS		(0x3 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_24BITS		(0x2 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_20BITS		(0x1 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_16BITS		(0x0 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_MODE_SFT			3
+#define RK3308_ADC_I2S_MODE_MSK			(0x3 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_PCM			(0x3 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_I2S			(0x2 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_LJ			(0x1 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_RJ			(0x0 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_LR_SWAP			BIT(1)
+#define RK3308_ADC_I2S_MONO			BIT(0)
+
+/* RK3308_ADC_DIG_CON02 - REG: 0x0008 */
+#define RK3308_ADC_IO_MODE_MASTER		BIT(5)
+#define RK3308_ADC_MODE_MASTER			BIT(4)
+#define RK3308_ADC_I2S_FRAME_LEN_SFT		2
+#define RK3308_ADC_I2S_FRAME_LEN_MSK		(0x3 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_32BITS		(0x3 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_24BITS		(0x2 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_20BITS		(0x1 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_16BITS		(0x0 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_WORK			BIT(1)
+#define RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL	BIT(0)
+
+/* RK3308_ADC_DIG_CON03 - REG: 0x000c */
+#define RK3308_ADC_L_CH_BIST_SFT		2
+#define RK3308_ADC_L_CH_BIST_MSK		(0x3 << RK3308_ADC_L_CH_BIST_SFT)
+#define RK3308_ADC_L_CH_NORMAL_RIGHT		(0x3 << RK3308_ADC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_ADC_L_CH_BIST_CUBE		(0x2 << RK3308_ADC_L_CH_BIST_SFT)
+#define RK3308_ADC_L_CH_BIST_SINE		(0x1 << RK3308_ADC_L_CH_BIST_SFT)
+#define RK3308_ADC_L_CH_NORMAL_LEFT		(0x0 << RK3308_ADC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_ADC_R_CH_BIST_SFT		0
+#define RK3308_ADC_R_CH_BIST_MSK		(0x3 << RK3308_ADC_R_CH_BIST_SFT)
+#define RK3308_ADC_R_CH_NORMAL_LEFT		(0x3 << RK3308_ADC_R_CH_BIST_SFT) /* normal mode */
+#define RK3308_ADC_R_CH_BIST_CUBE		(0x2 << RK3308_ADC_R_CH_BIST_SFT)
+#define RK3308_ADC_R_CH_BIST_SINE		(0x1 << RK3308_ADC_R_CH_BIST_SFT)
+#define RK3308_ADC_R_CH_NORMAL_RIGHT		(0x0 << RK3308_ADC_R_CH_BIST_SFT) /* normal mode */
+
+/* RK3308_ADC_DIG_CON04 - REG: 0x0010 */
+#define RK3308_ADC_HPF_PATH_DIS			BIT(2)
+#define RK3308_ADC_HPF_CUTOFF_SFT		0
+#define RK3308_ADC_HPF_CUTOFF_MSK		(0x3 << RK3308_ADC_HPF_CUTOFF_SFT)
+#define RK3308_ADC_HPF_CUTOFF_612HZ		(0x2 << RK3308_ADC_HPF_CUTOFF_SFT)
+#define RK3308_ADC_HPF_CUTOFF_245HZ		(0x1 << RK3308_ADC_HPF_CUTOFF_SFT)
+#define RK3308_ADC_HPF_CUTOFF_20HZ		(0x0 << RK3308_ADC_HPF_CUTOFF_SFT)
+
+/* RK3308_ADC_DIG_CON07 - REG: 0x001c */
+#define RK3308_ADCL_DATA_SFT			4
+#define RK3308_ADCR_DATA_SFT			2
+#define RK3308_ADCL_DATA_SEL_ADCL		BIT(1)
+#define RK3308_ADCR_DATA_SEL_ADCR		BIT(0)
+
+/*
+ * RK3308_ALC_L_DIG_CON00 - REG: 0x0040 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON00 - REG: 0x0080 + ch * 0xc0
+ */
+#define RK3308_GAIN_ATTACK_JACK			BIT(6)
+#define RK3308_CTRL_GEN_SFT			4
+#define RK3308_CTRL_GEN_MSK			(0x3 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_JACK3			(0x3 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_JACK2			(0x2 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_JACK1			(0x1 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_NORMAL			(0x0 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_AGC_HOLD_TIME_SFT		0
+#define RK3308_AGC_HOLD_TIME_MSK		(0xf << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_1S			(0xa << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_512MS		(0x9 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_256MS		(0x8 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_128MS		(0x7 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_64MS		(0x6 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_32MS		(0x5 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_16MS		(0x4 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_8MS		(0x3 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_4MS		(0x2 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_2MS		(0x1 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_0MS		(0x0 << RK3308_AGC_HOLD_TIME_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON01 - REG: 0x0044 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON01 - REG: 0x0084 + ch * 0xc0
+ */
+#define RK3308_AGC_DECAY_TIME_SFT		4
+#define RK3308_AGC_ATTACK_TIME_SFT		0
+
+/*
+ * RK3308_ALC_L_DIG_CON02 - REG: 0x0048 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON02 - REG: 0x0088 + ch * 0xc0
+ */
+#define RK3308_AGC_MODE_LIMITER			BIT(7)
+#define RK3308_AGC_ZERO_CRO_EN			BIT(6)
+#define RK3308_AGC_AMP_RECOVER_GAIN		BIT(5)
+#define RK3308_AGC_FAST_DEC_EN			BIT(4)
+#define RK3308_AGC_NOISE_GATE_EN		BIT(3)
+#define RK3308_AGC_NOISE_GATE_THRESH_SFT	0
+#define RK3308_AGC_NOISE_GATE_THRESH_MSK	(0x7 << RK3308_AGC_NOISE_GATE_THRESH_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON03 - REG: 0x004c + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON03 - REG: 0x008c + ch * 0xc0
+ */
+#define RK3308_AGC_PGA_ZERO_CRO_EN		BIT(5)
+#define RK3308_AGC_PGA_GAIN_MAX			0x1f
+#define RK3308_AGC_PGA_GAIN_MIN			0
+#define RK3308_AGC_PGA_GAIN_SFT			0
+
+/*
+ * RK3308_ALC_L_DIG_CON04 - REG: 0x0050 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON04 - REG: 0x0090 + ch * 0xc0
+ */
+#define RK3308_AGC_SLOW_CLK_EN			BIT(3)
+#define RK3308_AGC_APPROX_RATE_SFT		0
+#define RK3308_AGC_APPROX_RATE_MSK		(0x7 << RK3308_AGC_APPROX_RATE_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON05 - REG: 0x0054 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON05 - REG: 0x0094 + ch * 0xc0
+ */
+#define RK3308_AGC_LO_8BITS_AGC_MAX_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON06 - REG: 0x0058 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON06 - REG: 0x0098 + ch * 0xc0
+ */
+#define RK3308_AGC_HI_8BITS_AGC_MAX_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON07 - REG: 0x005c + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON07 - REG: 0x009c + ch * 0xc0
+ */
+#define RK3308_AGC_LO_8BITS_AGC_MIN_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON08 - REG: 0x0060 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON08 - REG: 0x00a0 + ch * 0xc0
+ */
+#define RK3308_AGC_HI_8BITS_AGC_MIN_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON09 - REG: 0x0064 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON09 - REG: 0x00a4 + ch * 0xc0
+ */
+#define RK3308_AGC_FUNC_SEL_MSK			BIT(6)
+#define RK3308_AGC_MAX_GAIN_PGA_MAX		0x7
+#define RK3308_AGC_MAX_GAIN_PGA_MIN		0
+#define RK3308_AGC_MAX_GAIN_PGA_SFT		3
+#define RK3308_AGC_MAX_GAIN_PGA_MSK		(0x7 << RK3308_AGC_MAX_GAIN_PGA_SFT)
+#define RK3308_AGC_MIN_GAIN_PGA_MAX		0x7
+#define RK3308_AGC_MIN_GAIN_PGA_MIN		0
+#define RK3308_AGC_MIN_GAIN_PGA_SFT		0
+#define RK3308_AGC_MIN_GAIN_PGA_MSK		(0x7 << RK3308_AGC_MIN_GAIN_PGA_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON12 - REG: 0x0068 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON12 - REG: 0x00a8 + ch * 0xc0
+ */
+#define RK3308_AGC_GAIN_MSK			0x1f
+
+/* RK3308_DAC_DIG_CON01 - REG: 0x0304 */
+#define RK3308_DAC_I2S_LRC_POL_REVERSAL		BIT(7)
+#define RK3308_DAC_I2S_VALID_LEN_SFT		5
+#define RK3308_DAC_I2S_VALID_LEN_MSK		(0x3 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_32BITS		(0x3 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_24BITS		(0x2 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_20BITS		(0x1 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_16BITS		(0x0 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_MODE_SFT			3
+#define RK3308_DAC_I2S_MODE_MSK			(0x3 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_PCM			(0x3 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_I2S			(0x2 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_LJ			(0x1 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_RJ			(0x0 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_LR_SWAP			BIT(2)
+
+/* RK3308_DAC_DIG_CON02 - REG: 0x0308 */
+#define RK3308_DAC_IO_MODE_MASTER		BIT(5)
+#define RK3308_DAC_MODE_MASTER			BIT(4)
+#define RK3308_DAC_I2S_FRAME_LEN_SFT		2
+#define RK3308_DAC_I2S_FRAME_LEN_MSK		(0x3 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_32BITS		(0x3 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_24BITS		(0x2 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_20BITS		(0x1 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_16BITS		(0x0 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_WORK			BIT(1)
+#define RK3308_DAC_I2S_BIT_CLK_POL_REVERSAL	BIT(0)
+
+/* RK3308_DAC_DIG_CON03 - REG: 0x030C */
+#define RK3308_DAC_L_CH_BIST_SFT		2
+#define RK3308_DAC_L_CH_BIST_MSK		(0x3 << RK3308_DAC_L_CH_BIST_SFT)
+#define RK3308_DAC_L_CH_BIST_LEFT		(0x3 << RK3308_DAC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_DAC_L_CH_BIST_CUBE		(0x2 << RK3308_DAC_L_CH_BIST_SFT)
+#define RK3308_DAC_L_CH_BIST_SINE		(0x1 << RK3308_DAC_L_CH_BIST_SFT)
+#define RK3308_DAC_L_CH_BIST_RIGHT		(0x0 << RK3308_DAC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_DAC_R_CH_BIST_SFT		0
+#define RK3308_DAC_R_CH_BIST_MSK		(0x3 << RK3308_DAC_R_CH_BIST_SFT)
+#define RK3308_DAC_R_CH_BIST_LEFT		(0x3 << RK3308_DAC_R_CH_BIST_SFT) /* normal mode */
+#define RK3308_DAC_R_CH_BIST_CUBE		(0x2 << RK3308_DAC_R_CH_BIST_SFT)
+#define RK3308_DAC_R_CH_BIST_SINE		(0x1 << RK3308_DAC_R_CH_BIST_SFT)
+#define RK3308_DAC_R_CH_BIST_RIGHT		(0x0 << RK3308_DAC_R_CH_BIST_SFT) /* normal mode */
+
+/* RK3308_DAC_DIG_CON04 - REG: 0x0310 */
+#define RK3308_DAC_MODULATOR_GAIN_SFT		4
+#define RK3308_DAC_MODULATOR_GAIN_MSK		(0x7 << RK3308_DAC_MODULATOR_GAIN_SFT)
+#define RK3308_DAC_CIC_IF_GAIN_SFT		0
+#define RK3308_DAC_CIC_IF_GAIN_MSK		(0x7 << RK3308_DAC_CIC_IF_GAIN_SFT)
+
+/* RK3308_DAC_DIG_CON05 - REG: 0x0314 */
+#define RK3308_DAC_L_REG_CTL_INDATA		BIT(2)
+#define RK3308_DAC_R_REG_CTL_INDATA		BIT(1)
+
+/* RK3308_DAC_DIG_CON10 - REG: 0x0328 */
+#define RK3308_DAC_DATA_HI4(x)			((x) & 0xf)
+
+/* RK3308_DAC_DIG_CON11 - REG: 0x032c */
+#define RK3308_DAC_DATA_LO8(x)			((x) & 0xff)
+
+/* RK3308_ADC_ANA_CON00 - REG: 0x0340 */
+#define RK3308_ADC_CH1_CH2_MIC_ALL_MSK		(0xff << 0)
+#define RK3308_ADC_CH1_CH2_MIC_ALL		0xff
+#define RK3308_ADC_CH2_MIC_UNMUTE		BIT(7)
+#define RK3308_ADC_CH2_MIC_WORK			BIT(6)
+#define RK3308_ADC_CH2_MIC_EN			BIT(5)
+#define RK3308_ADC_CH2_BUF_REF_EN		BIT(4)
+#define RK3308_ADC_CH1_MIC_UNMUTE		BIT(3)
+#define RK3308_ADC_CH1_MIC_WORK			BIT(2)
+#define RK3308_ADC_CH1_MIC_EN			BIT(1)
+#define RK3308_ADC_CH1_BUF_REF_EN		BIT(0)
+
+/* RK3308_ADC_ANA_CON01 - REG: 0x0344
+ *
+ * The PGA of MIC-INs:
+ * - HW version A:
+ *   0x0 - MIC1~MIC8  0 dB (recommended when ADC used as loopback)
+ *   0x3 - MIC1~MIC8 20 dB (recommended when ADC used as MIC input)
+ * - HW version B:
+ *   0x0 - MIC1~MIC8   0 dB
+ *   0x1 - MIC1~MIC8 6.6 dB
+ *   0x2 - MIC1~MIC8  13 dB
+ *   0x3 - MIC1~MIC8  20 dB
+ */
+#define RK3308_ADC_CH2_MIC_GAIN_MAX		0x3
+#define RK3308_ADC_CH2_MIC_GAIN_MIN		0
+#define RK3308_ADC_CH2_MIC_GAIN_SFT		4
+#define RK3308_ADC_CH2_MIC_GAIN_MSK		(0x3 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_20DB		(0x3 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_13DB		(0x2 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_6_6DB		(0x1 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_0DB		(0x0 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+
+#define RK3308_ADC_CH1_MIC_GAIN_MAX		0x3
+#define RK3308_ADC_CH1_MIC_GAIN_MIN		0
+#define RK3308_ADC_CH1_MIC_GAIN_SFT		0
+#define RK3308_ADC_CH1_MIC_GAIN_MSK		(0x3 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_20DB		(0x3 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_13DB		(0x2 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_6_6DB		(0x1 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_0DB		(0x0 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+
+/* RK3308_ADC_ANA_CON02 - REG: 0x0348 */
+#define RK3308_ADC_CH2_ZEROCROSS_DET_EN		BIT(6)
+#define RK3308_ADC_CH2_ALC_WORK			BIT(5)
+#define RK3308_ADC_CH2_ALC_EN			BIT(4)
+#define RK3308_ADC_CH1_ZEROCROSS_DET_EN		BIT(2)
+#define RK3308_ADC_CH1_ALC_WORK			BIT(1)
+#define RK3308_ADC_CH1_ALC_EN			BIT(0)
+
+/* RK3308_ADC_ANA_CON03 - REG: 0x034c */
+#define RK3308_ADC_CH1_ALC_GAIN_MAX		0x1f
+#define RK3308_ADC_CH1_ALC_GAIN_MIN		0
+#define RK3308_ADC_CH1_ALC_GAIN_SFT		0
+#define RK3308_ADC_CH1_ALC_GAIN_MSK		(0x1f << RK3308_ADC_CH1_ALC_GAIN_SFT)
+#define RK3308_ADC_CH1_ALC_GAIN_0DB		(0x0c << RK3308_ADC_CH1_ALC_GAIN_SFT)
+
+/* RK3308_ADC_ANA_CON04 - REG: 0x0350 */
+#define RK3308_ADC_CH2_ALC_GAIN_MAX		0x1f
+#define RK3308_ADC_CH2_ALC_GAIN_MIN		0
+#define RK3308_ADC_CH2_ALC_GAIN_SFT		0
+#define RK3308_ADC_CH2_ALC_GAIN_MSK		(0x1f << RK3308_ADC_CH2_ALC_GAIN_SFT)
+#define RK3308_ADC_CH2_ALC_GAIN_0DB		(0x0c << RK3308_ADC_CH2_ALC_GAIN_SFT)
+
+/* RK3308_ADC_ANA_CON05 - REG: 0x0354 */
+#define RK3308_ADC_CH2_ADC_WORK			BIT(6)
+#define RK3308_ADC_CH2_ADC_EN			BIT(5)
+#define RK3308_ADC_CH2_CLK_EN			BIT(4)
+#define RK3308_ADC_CH1_ADC_WORK			BIT(2)
+#define RK3308_ADC_CH1_ADC_EN			BIT(1)
+#define RK3308_ADC_CH1_CLK_EN			BIT(0)
+
+/* RK3308_ADC_ANA_CON06 - REG: 0x0358 */
+#define RK3308_ADC_CURRENT_EN			BIT(0)
+
+/* RK3308_ADC_ANA_CON07 - REG: 0x035c */
+/* Note: The register configuration is only valid for ADC2 */
+#define RK3308_ADC_CH2_IN_SEL_SFT		6
+#define RK3308_ADC_CH2_IN_SEL_MSK		(0x3 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_LINEIN_MIC		(0x3 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_LINEIN		(0x2 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_MIC			(0x1 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_NONE			(0x0 << RK3308_ADC_CH2_IN_SEL_SFT)
+/* Note: The register configuration is only valid for ADC1 */
+#define RK3308_ADC_CH1_IN_SEL_SFT		4
+#define RK3308_ADC_CH1_IN_SEL_MSK		(0x3 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_LINEIN_MIC		(0x3 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_LINEIN		(0x2 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_MIC			(0x1 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_NONE			(0x0 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_MIC_BIAS_BUF_EN		BIT(3)
+#define RK3308_ADC_LEVEL_RANGE_MICBIAS_SFT	0
+#define RK3308_ADC_LEVEL_RANGE_MICBIAS_MSK	(0x7 << RK3308_ADC_LEVEL_RANGE_MICBIAS_SFT)
+
+/* RK3308_ADC_ANA_CON08 - REG: 0x0360 */
+#define RK3308_ADC_MICBIAS_CURRENT_EN		BIT(4)
+
+/* RK3308_ADC_ANA_CON10 - REG: 0x0368 */
+#define RK3308_ADC_REF_EN			BIT(7)
+#define RK3308_ADC_CURRENT_CHARGE_SFT		0
+#define RK3308_ADC_CURRENT_CHARGE_MSK		(0x7f << RK3308_ADC_CURRENT_CHARGE_SFT)
+/*
+ * 1: Choose the current I
+ * 0: Don't choose the current I
+ */
+#define RK3308_ADC_SEL_I(x)			((x) & 0x7f)
+
+/* RK3308_ADC_ANA_CON11 - REG: 0x036c */
+#define RK3308_ADC_ALCR_CON_GAIN_PGAR_EN	BIT(1)
+#define RK3308_ADC_ALCL_CON_GAIN_PGAL_EN	BIT(0)
+
+/* RK3308_DAC_ANA_CON00 - REG: 0x0440 */
+#define RK3308_DAC_HEADPHONE_DET_EN		BIT(1)
+#define RK3308_DAC_CURRENT_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON01 - REG: 0x0444 */
+#define RK3308_DAC_BUF_REF_R_EN			BIT(6)
+#define RK3308_DAC_HPOUT_POP_SOUND_R_SFT	4
+#define RK3308_DAC_HPOUT_POP_SOUND_R_MSK	(0x3 << RK3308_DAC_HPOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_HPOUT_POP_SOUND_R_WORK	(0x2 << RK3308_DAC_HPOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_HPOUT_POP_SOUND_R_INIT	(0x1 << RK3308_DAC_HPOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_BUF_REF_L_EN			BIT(2)
+#define RK3308_DAC_HPOUT_POP_SOUND_L_SFT	0
+#define RK3308_DAC_HPOUT_POP_SOUND_L_MSK	(0x3 << RK3308_DAC_HPOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_HPOUT_POP_SOUND_L_WORK	(0x2 << RK3308_DAC_HPOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_HPOUT_POP_SOUND_L_INIT	(0x1 << RK3308_DAC_HPOUT_POP_SOUND_L_SFT)
+
+/* RK3308_DAC_ANA_CON02 - REG: 0x0448 */
+#define RK3308_DAC_R_DAC_WORK			BIT(7)
+#define RK3308_DAC_R_DAC_EN			BIT(6)
+#define RK3308_DAC_R_CLK_EN			BIT(5)
+#define RK3308_DAC_R_REF_EN			BIT(4)
+#define RK3308_DAC_L_DAC_WORK			BIT(3)
+#define RK3308_DAC_L_DAC_EN			BIT(2)
+#define RK3308_DAC_L_CLK_EN			BIT(1)
+#define RK3308_DAC_L_REF_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON03 - REG: 0x044c */
+#define RK3308_DAC_R_HPOUT_WORK			BIT(6)
+#define RK3308_DAC_R_HPOUT_EN			BIT(5)
+#define RK3308_DAC_R_HPOUT_UNMUTE		BIT(4)
+#define RK3308_DAC_L_HPOUT_WORK			BIT(2)
+#define RK3308_DAC_L_HPOUT_EN			BIT(1)
+#define RK3308_DAC_L_HPOUT_UNMUTE		BIT(0)
+
+/* RK3308_DAC_ANA_CON04 - REG: 0x0450 */
+#define RK3308_DAC_R_LINEOUT_GAIN_MAX		0x3
+#define RK3308_DAC_R_LINEOUT_GAIN_SFT		6
+#define RK3308_DAC_R_LINEOUT_GAIN_MSK		(0x3 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_0DB		(0x3 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_NDB_1_5	(0x2 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_NDB_3		(0x1 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_NDB_6		(0x0 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_UNMUTE		BIT(5)
+#define RK3308_DAC_R_LINEOUT_EN			BIT(4)
+#define RK3308_DAC_L_LINEOUT_GAIN_MAX		0x3
+#define RK3308_DAC_L_LINEOUT_GAIN_SFT		2
+#define RK3308_DAC_L_LINEOUT_GAIN_MSK		(0x3 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_0DB		(0x3 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_NDB_1_5	(0x2 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_NDB_3		(0x1 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_NDB_6		(0x0 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_UNMUTE		BIT(1)
+#define RK3308_DAC_L_LINEOUT_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON05 - REG: 0x0454, step is 1.5db */
+#define RK3308_DAC_L_HPOUT_GAIN_MAX		0x1e
+#define RK3308_DAC_L_HPOUT_GAIN_SFT		0
+#define RK3308_DAC_L_HPOUT_GAIN_MSK		(0x1f << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_PDB_6		(0x1e << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_PDB_4_5		(0x1d << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_PDB_3		(0x1c << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_PDB_1_5		(0x1b << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_0DB		(0x1a << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_1_5		(0x19 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_3		(0x18 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_4_5		(0x17 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_6		(0x16 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_7_5		(0x15 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_9		(0x14 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_10_5	(0x13 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_12		(0x12 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_13_5	(0x11 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_15		(0x10 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_16_5	(0x0f << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_18		(0x0e << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_19_5	(0x0d << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_21		(0x0c << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_22_5	(0x0b << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_24		(0x0a << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_25_5	(0x09 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_27		(0x08 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_28_5	(0x07 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_30		(0x06 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_31_5	(0x05 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_33		(0x04 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_34_5	(0x03 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_36		(0x02 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_37_5	(0x01 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+#define RK3308_DAC_L_HPOUT_GAIN_NDB_39		(0x00 << RK3308_DAC_L_HPOUT_GAIN_SFT)
+
+/* RK3308_DAC_ANA_CON06 - REG: 0x0458, step is 1.5db */
+#define RK3308_DAC_R_HPOUT_GAIN_MAX		0x1e
+#define RK3308_DAC_R_HPOUT_GAIN_SFT		0
+#define RK3308_DAC_R_HPOUT_GAIN_MSK		(0x1f << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_PDB_6		(0x1e << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_PDB_4_5		(0x1d << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_PDB_3		(0x1c << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_PDB_1_5		(0x1b << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_0DB		(0x1a << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_1_5		(0x19 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_3		(0x18 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_4_5		(0x17 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_6		(0x16 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_7_5		(0x15 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_9		(0x14 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_10_5	(0x13 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_12		(0x12 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_13_5	(0x11 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_15		(0x10 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_16_5	(0x0f << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_18		(0x0e << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_19_5	(0x0d << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_21		(0x0c << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_22_5	(0x0b << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_24		(0x0a << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_25_5	(0x09 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_27		(0x08 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_28_5	(0x07 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_30		(0x06 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_31_5	(0x05 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_33		(0x04 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_34_5	(0x03 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_36		(0x02 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_37_5	(0x01 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+#define RK3308_DAC_R_HPOUT_GAIN_NDB_39		(0x00 << RK3308_DAC_R_HPOUT_GAIN_SFT)
+
+/* RK3308_DAC_ANA_CON07 - REG: 0x045c */
+#define RK3308_DAC_R_HPOUT_DRV_SFT		4
+#define RK3308_DAC_R_HPOUT_DRV_MSK		(0xf << RK3308_DAC_R_HPOUT_DRV_SFT)
+#define RK3308_DAC_L_HPOUT_DRV_SFT		0
+#define RK3308_DAC_L_HPOUT_DRV_MSK		(0xf << RK3308_DAC_L_HPOUT_DRV_SFT)
+
+/* RK3308_DAC_ANA_CON08 - REG: 0x0460 */
+#define RK3308_DAC_R_LINEOUT_DRV_SFT		4
+#define RK3308_DAC_R_LINEOUT_DRV_MSK		(0xf << RK3308_DAC_R_LINEOUT_DRV_SFT)
+#define RK3308_DAC_L_LINEOUT_DRV_SFT		0
+#define RK3308_DAC_L_LINEOUT_DRV_MSK		(0xf << RK3308_DAC_L_LINEOUT_DRV_SFT)
+
+/* RK3308_DAC_ANA_CON12 - REG: 0x0470 */
+#define RK3308_DAC_R_HPMIX_SEL_SFT		6
+#define RK3308_DAC_R_HPMIX_SEL_MSK		(0x3 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_LINEIN_I2S		(0x3 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_LINEIN		(0x2 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_I2S			(0x1 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_NONE			(0x0 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_GAIN_MIN		0x1 /* 0xx0 and 0x3 are reserved */
+#define RK3308_DAC_R_HPMIX_GAIN_MAX		0x2
+#define RK3308_DAC_R_HPMIX_GAIN_SFT		4
+#define RK3308_DAC_R_HPMIX_GAIN_MSK		(0x3 << RK3308_DAC_R_HPMIX_GAIN_SFT)
+#define RK3308_DAC_R_HPMIX_GAIN_0DB		(0x2 << RK3308_DAC_R_HPMIX_GAIN_SFT)
+#define RK3308_DAC_R_HPMIX_GAIN_NDB_6		(0x1 << RK3308_DAC_R_HPMIX_GAIN_SFT)
+#define RK3308_DAC_L_HPMIX_SEL_SFT		2
+#define RK3308_DAC_L_HPMIX_SEL_MSK		(0x3 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_LINEIN_I2S		(0x3 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_LINEIN		(0x2 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_I2S			(0x1 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_NONE			(0x0 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_GAIN_MIN		0x1 /* 0xx0 and 0x3 are reserved */
+#define RK3308_DAC_L_HPMIX_GAIN_MAX		0x2
+#define RK3308_DAC_L_HPMIX_GAIN_SFT		0
+#define RK3308_DAC_L_HPMIX_GAIN_MSK		(0x3 << RK3308_DAC_L_HPMIX_GAIN_SFT)
+#define RK3308_DAC_L_HPMIX_GAIN_0DB		(0x2 << RK3308_DAC_L_HPMIX_GAIN_SFT)
+#define RK3308_DAC_L_HPMIX_GAIN_NDB_6		(0x1 << RK3308_DAC_L_HPMIX_GAIN_SFT)
+
+/* RK3308_DAC_ANA_CON13 - REG: 0x0474 */
+#define RK3308_DAC_R_HPMIX_UNMUTE		BIT(6)
+#define RK3308_DAC_R_HPMIX_WORK			BIT(5)
+#define RK3308_DAC_R_HPMIX_EN			BIT(4)
+#define RK3308_DAC_L_HPMIX_UNMUTE		BIT(2)
+#define RK3308_DAC_L_HPMIX_WORK			BIT(1)
+#define RK3308_DAC_L_HPMIX_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON14 - REG: 0x0478 */
+#define RK3308_DAC_VCM_LINEOUT_EN		(0x1 << 4)
+#define RK3308_DAC_CURRENT_CHARGE_SFT		0
+#define RK3308_DAC_CURRENT_CHARGE_MSK		(0xf << RK3308_DAC_CURRENT_CHARGE_SFT)
+
+/*
+ * 1: Choose the current I
+ * 0: Don't choose the current I
+ */
+#define RK3308_DAC_SEL_I(x)			((x) & 0xf)
+
+/* RK3308_DAC_ANA_CON15 - REG: 0x047C */
+#define RK3308_DAC_LINEOUT_POP_SOUND_R_SFT	4
+#define RK3308_DAC_LINEOUT_POP_SOUND_R_MSK	(0x3 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_R_SEL_DC_FROM_INTERNAL	(0x2 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_R_SEL_DC_FROM_VCM		(0x1 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_R_SEL_LINEOUT_FROM_INTERNAL	(0x0 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_LINEOUT_POP_SOUND_L_SFT	0
+#define RK3308_DAC_LINEOUT_POP_SOUND_L_MSK	(0x3 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_L_SEL_DC_FROM_INTERNAL	(0x2 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_L_SEL_DC_FROM_VCM		(0x1 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_L_SEL_LINEOUT_FROM_INTERNAL	(0x0 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+
+#define RK3308_HIFI				0x0
+
+#endif /* __RK3308_CODEC_H__ */
-- 
2.34.1

