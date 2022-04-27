Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E76511F48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiD0PLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbiD0PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0B54F88
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:46 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qG022428;
        Wed, 27 Apr 2022 10:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=04jQOnFUHxsd9I2VAOnsbYi5jJf/4W+/qLf3RRELtVI=;
 b=nvL9aAp7kSi9WizhdQOGae+ZO7oY8yOF/SfDJAb8Ah1l2AHVKCYRU3cP+fDeVJRExqfT
 Ug7ntGkdAp/jasF++lHM96fGykhX1BitloerOZKTuovqKN3zc1JvNNfiLZaqBUtEMnnL
 JQVPr/cr/aR194uJnmVpqXmAWZBvAMUhe2l5+JFFO4RrZT8WTr0p0+ibB7qf7iIuXrP7
 qJL0IzjbFX1Zq6JYbjTOlCJiaAWFtHEro2S8ruVyMXVCscW0+5LFNRyoG7bESXKjTzfu
 kDKHv+VBUBW8M0Aht8QtRk4hxduZ99VaZcTPL2g8eDxh8TTFRyT7B42KVqB51PC7e5Id OQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:28 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C1FAE46C;
        Wed, 27 Apr 2022 15:07:27 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov <vitaly.rodionov@cirrus.com>
Subject: [PATCH 13/26] ALSA: hda: cs35l41: Add initial DSP support and firmware loading
Date:   Wed, 27 Apr 2022 16:07:07 +0100
Message-ID: <20220427150720.9194-14-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6CI_TyFFjz1_O9hCHtIQMHVhz2IEPfQP
X-Proofpoint-ORIG-GUID: 6CI_TyFFjz1_O9hCHtIQMHVhz2IEPfQP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Rodionov <vitaly.rodionov@cirrus.com>

This patch adds support for the CS35L41 DSP.
The DSP allows for extra features, such as running
speaker protection algorithms and hibernations.

To utilize these features, the driver must load
firmware into the DSP, as well as various tuning
files which allow for cusomtization for specific
models.

Signed-off-by: Vitaly Rodionov <vitaly.rodionov@cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h     |   4 +
 sound/pci/hda/Kconfig       |   4 +
 sound/pci/hda/cs35l41_hda.c | 238 +++++++++++++++++++++++++++++++++++-
 sound/pci/hda/cs35l41_hda.h |  12 ++
 4 files changed, 257 insertions(+), 1 deletion(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index dd70fb8dd860..85db31174adb 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -666,6 +666,10 @@
 #define CS35L41_BST_EN_DEFAULT		0x2
 #define CS35L41_AMP_EN_SHIFT		0
 #define CS35L41_AMP_EN_MASK		1
+#define CS35L41_VMON_EN_MASK		0x1000
+#define CS35L41_VMON_EN_SHIFT		12
+#define CS35L41_IMON_EN_MASK		0x2000
+#define CS35L41_IMON_EN_SHIFT		13
 
 #define CS35L41_PDN_DONE_MASK		0x00800000
 #define CS35L41_PDN_DONE_SHIFT		23
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index d1fd6cf82beb..1c378cca5dac 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -106,6 +106,8 @@ config SND_HDA_SCODEC_CS35L41_I2C
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
+	select SND_HDA_CS_DSP_CONTROLS
+	select CS_DSP
 	select REGMAP_IRQ
 	help
 	  Say Y or M here to include CS35L41 I2C HD-audio side codec support
@@ -122,6 +124,8 @@ config SND_HDA_SCODEC_CS35L41_SPI
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
+	select SND_HDA_CS_DSP_CONTROLS
+	select CS_DSP
 	select REGMAP_IRQ
 	help
 	  Say Y or M here to include CS35L41 SPI HD-audio side codec support
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index bbbaafac50c3..fe2ba03e602b 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -9,12 +9,22 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <sound/hda_codec.h>
+#include <sound/soc.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
 #include "hda_generic.h"
 #include "hda_component.h"
 #include "cs35l41_hda.h"
+#include "hda_cs_dsp_ctl.h"
+
+#define CS35L41_FIRMWARE_ROOT "cirrus/"
+#define CS35L41_PART "cs35l41"
+#define FW_NAME "CSPL"
+
+#define HALO_STATE_DSP_CTL_NAME		"HALO_STATE"
+#define HALO_STATE_DSP_CTL_TYPE		5
+#define HALO_STATE_DSP_CTL_ALG		262308
 
 static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
@@ -27,11 +37,167 @@ static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
 };
 
+static const struct reg_sequence cs35l41_hda_config_dsp[] = {
+	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
+	{ CS35L41_DSP_CLK_CTRL,		0x00000003 }, // DSP CLK EN
+	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, // GLOBAL_FS = 48 kHz
+	{ CS35L41_SP_ENABLES,		0x00010001 }, // ASP_RX1_EN = 1, ASP_TX1_EN = 1
+	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, // ASP_BCLK_FREQ = 3.072 MHz
+	{ CS35L41_SP_FORMAT,		0x20200200 }, // 32 bits RX/TX slots, I2S, clk consumer
+	{ CS35L41_SP_HIZ_CTRL,		0x00000003 }, // Hi-Z unused/disabled
+	{ CS35L41_SP_TX_WL,		0x00000018 }, // 24 cycles/slot
+	{ CS35L41_SP_RX_WL,		0x00000018 }, // 24 cycles/slot
+	{ CS35L41_DAC_PCM1_SRC,		0x00000032 }, // DACPCM1_SRC = ERR_VOL
+	{ CS35L41_ASP_TX1_SRC,		0x00000018 }, // ASPTX1 SRC = VMON
+	{ CS35L41_ASP_TX2_SRC,		0x00000019 }, // ASPTX2 SRC = IMON
+	{ CS35L41_ASP_TX3_SRC,		0x00000028 }, // ASPTX3 SRC = VPMON
+	{ CS35L41_ASP_TX4_SRC,		0x00000029 }, // ASPTX4 SRC = VBSTMON
+	{ CS35L41_DSP1_RX1_SRC,		0x00000008 }, // DSP1RX1 SRC = ASPRX1
+	{ CS35L41_DSP1_RX2_SRC,		0x00000008 }, // DSP1RX2 SRC = ASPRX1
+	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
+	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
+	{ CS35L41_DSP1_RX5_SRC,         0x00000029 }, // DSP1RX5 SRC = VBSTMON
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
+	{ CS35L41_AMP_GAIN_CTRL,	0x00000233 }, // AMP_GAIN_PCM = 17.5dB AMP_GAIN_PDM = 19.5dB
+};
+
 static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000000 }, // AMP_GAIN_PCM 0.5 dB
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 };
 
+static int cs35l41_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
+{
+	struct cs35l41_hda *cs35l41 = container_of(cs_ctl->dsp, struct cs35l41_hda, cs_dsp);
+	struct hda_cs_dsp_ctl_info info;
+
+	info.amp_name = cs35l41->amp_name;
+	info.fw_type = HDA_CS_DSP_FW_SPK_PROT;
+	info.card = cs35l41->codec->card;
+
+	return hda_cs_dsp_control_add(cs_ctl, &info);
+}
+
+static const struct cs_dsp_client_ops client_ops = {
+	.control_add = cs35l41_control_add,
+	.control_remove = hda_cs_dsp_control_remove,
+};
+
+static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
+					 const struct firmware **firmware, char **filename,
+					 const char *dir, const char *filetype)
+{
+	const char * const dsp_name = cs35l41->cs_dsp.name;
+	char *s, c;
+	int ret = 0;
+
+	*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, CS35L41_PART, dsp_name, "spk-prot",
+			      filetype);
+
+	if (*filename == NULL)
+		return -ENOMEM;
+
+	/*
+	 * Make sure that filename is lower-case and any non alpha-numeric
+	 * characters except full stop and '/' are replaced with hyphens.
+	 */
+	s = *filename;
+	while (*s) {
+		c = *s;
+		if (isalnum(c))
+			*s = tolower(c);
+		else if (c != '.' && c != '/')
+			*s = '-';
+		s++;
+	}
+
+	ret = firmware_request_nowarn(firmware, *filename, cs35l41->dev);
+	if (ret != 0) {
+		dev_dbg(cs35l41->dev, "Failed to request '%s'\n", *filename);
+		kfree(*filename);
+		*filename = NULL;
+	}
+
+	return ret;
+}
+
+static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
+					  const struct firmware **wmfw_firmware,
+					  char **wmfw_filename,
+					  const struct firmware **coeff_firmware,
+					  char **coeff_filename)
+{
+	int ret;
+
+	/* cirrus/part-dspN-fwtype.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, "wmfw");
+	if (!ret) {
+		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					      CS35L41_FIRMWARE_ROOT, "bin");
+		return 0;
+	}
+
+	dev_warn(cs35l41->dev, "Failed to request firmware\n");
+
+	return ret;
+}
+
+
+static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
+{
+	const struct firmware *coeff_firmware = NULL;
+	const struct firmware *wmfw_firmware = NULL;
+	struct cs_dsp *dsp = &cs35l41->cs_dsp;
+	char *coeff_filename = NULL;
+	char *wmfw_filename = NULL;
+	int ret;
+
+	cs35l41_configure_cs_dsp(cs35l41->dev, cs35l41->regmap, dsp);
+	dsp->client_ops = &client_ops;
+
+	if (!cs35l41->halo_initialized) {
+		ret = cs_dsp_halo_init(&cs35l41->cs_dsp);
+		if (ret)
+			return ret;
+		cs35l41->halo_initialized = true;
+	}
+
+	ret = cs35l41_request_firmware_files(cs35l41, &wmfw_firmware, &wmfw_filename,
+					     &coeff_firmware, &coeff_filename);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(cs35l41->dev, "Loaded WMFW Firmware: %s\n", wmfw_filename);
+	if (coeff_filename)
+		dev_dbg(cs35l41->dev, "Loaded Coefficient File: %s\n", coeff_filename);
+	else
+		dev_warn(cs35l41->dev, "No Coefficient File available.\n");
+
+	ret = cs_dsp_power_up(dsp, wmfw_firmware, wmfw_filename, coeff_firmware, coeff_filename,
+			      FW_NAME);
+
+	if (wmfw_firmware)
+		release_firmware(wmfw_firmware);
+	if (coeff_firmware)
+		release_firmware(coeff_firmware);
+	kfree(wmfw_filename);
+	kfree(coeff_filename);
+
+	return ret;
+}
+
+static void cs35l41_remove_dsp(struct cs35l41_hda *cs35l41)
+{
+	struct cs_dsp *dsp = &cs35l41->cs_dsp;
+
+	cs_dsp_stop(dsp);
+	cs_dsp_power_down(dsp);
+	cs_dsp_remove(dsp);
+	cs35l41->firmware_running = false;
+	dev_dbg(cs35l41->dev, "Unloaded Firmware\n");
+}
+
 /* Protection release cycle to get the speaker out of Safe-Mode */
 static void cs35l41_error_release(struct device *dev, struct regmap *regmap, unsigned int mask)
 {
@@ -55,7 +221,18 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
-		regmap_multi_reg_write(reg, cs35l41_hda_config, ARRAY_SIZE(cs35l41_hda_config));
+		if (cs35l41->firmware_running) {
+			regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
+					       ARRAY_SIZE(cs35l41_hda_config_dsp));
+			regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
+					   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
+					   1 << CS35L41_VMON_EN_SHIFT | 1 << CS35L41_IMON_EN_SHIFT);
+			cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
+						  CSPL_MBOX_CMD_RESUME);
+		} else {
+			regmap_multi_reg_write(reg, cs35l41_hda_config,
+					       ARRAY_SIZE(cs35l41_hda_config));
+		}
 		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 					 CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
@@ -73,6 +250,13 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 					 CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
+		if (cs35l41->firmware_running) {
+			cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
+						  CSPL_MBOX_CMD_PAUSE);
+			regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
+					   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
+					   0 << CS35L41_VMON_EN_SHIFT | 0 << CS35L41_IMON_EN_SHIFT);
+		}
 		cs35l41_irq_release(cs35l41);
 		break;
 	default:
@@ -104,6 +288,51 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    rx_slot);
 }
 
+static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
+{
+	int halo_sts;
+	int ret;
+
+	ret = cs35l41_init_dsp(cs35l41);
+	if (ret) {
+		dev_warn(cs35l41->dev, "Cannot Initialize Firmware. Error: %d\n", ret);
+		goto clean_dsp;
+	}
+
+	ret = cs35l41_write_fs_errata(cs35l41->dev, cs35l41->regmap);
+	if (ret) {
+		dev_err(cs35l41->dev, "Cannot Write FS Errata: %d\n", ret);
+		goto clean_dsp;
+	}
+
+	ret = cs_dsp_run(&cs35l41->cs_dsp);
+	if (ret) {
+		dev_err(cs35l41->dev, "Fail to start dsp: %d\n", ret);
+		goto clean_dsp;
+	}
+
+	ret = read_poll_timeout(hda_cs_dsp_read_ctl, ret,
+				be32_to_cpu(halo_sts) == HALO_STATE_CODE_RUN,
+				1000, 15000, false, &cs35l41->cs_dsp, HALO_STATE_DSP_CTL_NAME,
+				HALO_STATE_DSP_CTL_TYPE, HALO_STATE_DSP_CTL_ALG,
+				&halo_sts, sizeof(halo_sts));
+
+	if (ret) {
+		dev_err(cs35l41->dev, "Timeout waiting for HALO Core to start. State: %d\n",
+			 halo_sts);
+		goto clean_dsp;
+	}
+
+	cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap, CSPL_MBOX_CMD_PAUSE);
+	cs35l41->firmware_running = true;
+
+	return 0;
+
+clean_dsp:
+	cs35l41_remove_dsp(cs35l41);
+	return ret;
+}
+
 static int cs35l41_hda_bind(struct device *dev, struct device *master, void *master_data)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -121,6 +350,9 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 	comps->playback_hook = cs35l41_hda_playback_hook;
 
+	if (cs35l41_smart_amp(cs35l41) < 0)
+		dev_warn(cs35l41->dev, "Cannot Run Firmware, reverting to dsp bypass...\n");
+
 	return 0;
 }
 
@@ -564,6 +796,9 @@ void cs35l41_hda_remove(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
+	if (cs35l41->firmware_running)
+		cs35l41_remove_dsp(cs35l41);
+
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
 
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
@@ -573,5 +808,6 @@ void cs35l41_hda_remove(struct device *dev)
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
 MODULE_DESCRIPTION("CS35L41 HDA Driver");
+MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index aaf9e16684c2..03c5f14631dd 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -15,6 +15,9 @@
 #include <linux/device.h>
 #include <sound/cs35l41.h>
 
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/firmware/cirrus/wmfw.h>
+
 enum cs35l41_hda_spk_pos {
 	CS35l41_LEFT,
 	CS35l41_RIGHT,
@@ -40,6 +43,15 @@ struct cs35l41_hda {
 	unsigned volatile long irq_errors;
 	const char *amp_name;
 	struct regmap_irq_chip_data *irq_data;
+	bool firmware_running;
+	bool halo_initialized;
+	struct cs_dsp cs_dsp;
+};
+
+enum halo_state {
+	HALO_STATE_CODE_INIT_DOWNLOAD = 0,
+	HALO_STATE_CODE_START,
+	HALO_STATE_CODE_RUN
 };
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
-- 
2.32.0

