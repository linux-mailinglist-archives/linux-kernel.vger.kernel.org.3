Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80825120A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiD0PL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiD0PK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77826338BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:47 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vq014103;
        Wed, 27 Apr 2022 10:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=yOn6Gfhz90jTeXp3FRLJmEXQSUdhxAWIPONKwS/IX68=;
 b=MXaYUqOJpKZY65WOQTSZdf0Oz2znRgeIVtuGjbXOjAbUtrWgcgTwyQf//qMFwuZZbujI
 2TorvVY+fIEBQhavcbNRGoMn7ClhrgTxChkyWgRm4+Xc4OtMqOZeS+w1sKgLq7vnh87u
 uUVhXS80ulEITG31RFg6TN8TzMTpkSz35+F9Iobcmwbb1wLCiq65dWL2v6rtc2k3gQkG
 T1ORBQQ7BQFiBMg8pI55b2la54BcdAipxvivZvmO1sxtc6wt+59uubORUC8v3a0jEiLM
 TJhtjNCbDWDxSlpOmbb5u6UKlQoqHfURQYEtbAbRtNt2mJWjjqSGB/dgUrn2bGZD6dMH WQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:31 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 884CD46C;
        Wed, 27 Apr 2022 15:07:31 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 21/26] ALSA: hda: cs35l41: Support Hibernation during Suspend
Date:   Wed, 27 Apr 2022 16:07:15 +0100
Message-ID: <20220427150720.9194-22-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zIPGW61UID-Gl2CgouIc0g_Qx1oM1Fp2
X-Proofpoint-ORIG-GUID: zIPGW61UID-Gl2CgouIc0g_Qx1oM1Fp2
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CS35L41 supports hibernation during suspend when using
DSP firmware.
When the driver suspends it will hibernate the part, if
firmware is running, and resume will wake from hibernation.
CS35L41 driver will suspend/resume when requested by
hda driver.
Note that suspend/resume and hibernation is only supported
when firmware is running.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c     | 109 +++++++++++++++++++++++++++++++-
 sound/pci/hda/cs35l41_hda.h     |   2 +
 sound/pci/hda/cs35l41_hda_i2c.c |   1 +
 sound/pci/hda/cs35l41_hda_spi.c |   1 +
 sound/pci/hda/hda_component.h   |   2 +
 sound/pci/hda/patch_realtek.c   |  25 +++++++-
 6 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 1d62a41fbc75..9c622104bf01 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
+#include <linux/pm_runtime.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
@@ -425,6 +426,75 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    rx_slot);
 }
 
+static int cs35l41_runtime_suspend(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l41->dev, "Suspend\n");
+
+	if (!cs35l41->firmware_running)
+		return 0;
+
+	if (cs35l41_enter_hibernate(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type) < 0)
+		return 0;
+
+	regcache_cache_only(cs35l41->regmap, true);
+	regcache_mark_dirty(cs35l41->regmap);
+
+	return 0;
+}
+
+static int cs35l41_runtime_resume(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(cs35l41->dev, "Resume.\n");
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
+		dev_dbg(cs35l41->dev, "System does not support Resume\n");
+		return 0;
+	}
+
+	if (!cs35l41->firmware_running)
+		return 0;
+
+	regcache_cache_only(cs35l41->regmap, false);
+
+	ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
+	if (ret) {
+		regcache_cache_only(cs35l41->regmap, true);
+		return ret;
+	}
+
+	/* Test key needs to be unlocked to allow the OTP settings to re-apply */
+	cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
+	ret = regcache_sync(cs35l41->regmap);
+	cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed to restore register cache: %d\n", ret);
+		return ret;
+	}
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+		cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, &cs35l41->hw_cfg);
+
+	return 0;
+}
+
+static int cs35l41_hda_suspend_hook(struct device *dev)
+{
+	dev_dbg(dev, "Request Suspend\n");
+	pm_runtime_mark_last_busy(dev);
+	return pm_runtime_put_autosuspend(dev);
+}
+
+static int cs35l41_hda_resume_hook(struct device *dev)
+{
+	dev_dbg(dev, "Request Resume\n");
+	return pm_runtime_get_sync(dev);
+}
+
 static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 {
 	int halo_sts;
@@ -482,17 +552,25 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	if (comps->dev)
 		return -EBUSY;
 
+	pm_runtime_get_sync(dev);
+
 	comps->dev = dev;
 	if (!cs35l41->acpi_subsystem_id)
 		cs35l41->acpi_subsystem_id = devm_kasprintf(dev, GFP_KERNEL,
 							    "%.8x", comps->subsystem_id);
 	cs35l41->codec = comps->codec;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
-	comps->playback_hook = cs35l41_hda_playback_hook;
 
 	if (cs35l41_smart_amp(cs35l41) < 0)
 		dev_warn(cs35l41->dev, "Cannot Run Firmware, reverting to dsp bypass...\n");
 
+	comps->playback_hook = cs35l41_hda_playback_hook;
+	comps->suspend_hook = cs35l41_hda_suspend_hook;
+	comps->resume_hook = cs35l41_hda_resume_hook;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 }
 
@@ -588,7 +666,7 @@ static const struct regmap_irq cs35l41_reg_irqs[] = {
 	CS35L41_REG_IRQ(IRQ1_STATUS1, AMP_SHORT_ERR),
 };
 
-static const struct regmap_irq_chip cs35l41_regmap_irq_chip = {
+static struct regmap_irq_chip cs35l41_regmap_irq_chip = {
 	.name = "cs35l41 IRQ1 Controller",
 	.status_base = CS35L41_IRQ1_STATUS1,
 	.mask_base = CS35L41_IRQ1_MASK1,
@@ -596,6 +674,7 @@ static const struct regmap_irq_chip cs35l41_regmap_irq_chip = {
 	.num_regs = 4,
 	.irqs = cs35l41_reg_irqs,
 	.num_irqs = ARRAY_SIZE(cs35l41_reg_irqs),
+	.runtime_pm = true,
 };
 
 static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
@@ -1003,13 +1082,23 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (ret)
 		goto err;
 
+	pm_runtime_set_autosuspend_delay(cs35l41->dev, 3000);
+	pm_runtime_use_autosuspend(cs35l41->dev);
+	pm_runtime_mark_last_busy(cs35l41->dev);
+	pm_runtime_set_active(cs35l41->dev);
+	pm_runtime_get_noresume(cs35l41->dev);
+	pm_runtime_enable(cs35l41->dev);
+
 	ret = cs35l41_hda_apply_properties(cs35l41);
 	if (ret)
-		goto err;
+		goto err_pm;
+
+	pm_runtime_put_autosuspend(cs35l41->dev);
 
 	ret = component_add(cs35l41->dev, &cs35l41_hda_comp_ops);
 	if (ret) {
 		dev_err(cs35l41->dev, "Register component failed: %d\n", ret);
+		pm_runtime_disable(cs35l41->dev);
 		goto err;
 	}
 
@@ -1017,6 +1106,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	return 0;
 
+err_pm:
+	pm_runtime_disable(cs35l41->dev);
+	pm_runtime_put_noidle(cs35l41->dev);
+
 err:
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
@@ -1030,17 +1123,27 @@ void cs35l41_hda_remove(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
+	pm_runtime_get_sync(cs35l41->dev);
+	pm_runtime_disable(cs35l41->dev);
+
 	if (cs35l41->firmware_running)
 		cs35l41_remove_dsp(cs35l41);
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
 
+	pm_runtime_put_noidle(cs35l41->dev);
+
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 }
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
+const struct dev_pm_ops cs35l41_hda_pm_ops = {
+	SET_RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
+
 MODULE_DESCRIPTION("CS35L41 HDA Driver");
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 717b30a2e33b..54521a013e78 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -56,6 +56,8 @@ enum halo_state {
 	HALO_STATE_CODE_RUN
 };
 
+extern const struct dev_pm_ops cs35l41_hda_pm_ops;
+
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
 		      struct regmap *regmap);
 void cs35l41_hda_remove(struct device *dev);
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index e810b278fb91..a669090a18e8 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -55,6 +55,7 @@ static struct i2c_driver cs35l41_i2c_driver = {
 	.driver = {
 		.name		= "cs35l41-hda",
 		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
+		.pm		= &cs35l41_hda_pm_ops,
 	},
 	.id_table	= cs35l41_hda_i2c_id,
 	.probe		= cs35l41_hda_i2c_probe,
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 22e088f28438..d7f15e2abe66 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -50,6 +50,7 @@ static struct spi_driver cs35l41_spi_driver = {
 	.driver = {
 		.name		= "cs35l41-hda",
 		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
+		.pm		= &cs35l41_hda_pm_ops,
 	},
 	.id_table	= cs35l41_hda_spi_id,
 	.probe		= cs35l41_hda_spi_probe,
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index fa6df52e7855..72ec0d865a28 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -17,4 +17,6 @@ struct hda_component {
 	int subsystem_id;
 	struct hda_codec *codec;
 	void (*playback_hook)(struct device *dev, int action);
+	int (*suspend_hook)(struct device *dev);
+	int (*resume_hook)(struct device *dev);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2d01c53282fd..6ee11235437c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4005,15 +4005,22 @@ static void alc5505_dsp_init(struct hda_codec *codec)
 static int alc269_suspend(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	int i;
 
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_suspend(codec);
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++)
+		if (spec->comps[i].suspend_hook)
+			spec->comps[i].suspend_hook(spec->comps[i].dev);
+
 	return alc_suspend(codec);
 }
 
 static int alc269_resume(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	int i;
 
 	if (spec->codec_variant == ALC269_TYPE_ALC269VB)
 		alc269vb_toggle_power_output(codec, 0);
@@ -4044,6 +4051,10 @@ static int alc269_resume(struct hda_codec *codec)
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_resume(codec);
 
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++)
+		if (spec->comps[i].resume_hook)
+			spec->comps[i].resume_hook(spec->comps[i].dev);
+
 	return 0;
 }
 #endif /* CONFIG_PM */
@@ -6586,8 +6597,20 @@ static int comp_bind(struct device *dev)
 {
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
 	struct alc_spec *spec = cdc->spec;
+	int ret, i;
+
+	ret = component_bind_all(dev, spec->comps);
+	if (ret)
+		return ret;
 
-	return component_bind_all(dev, spec->comps);
+	if (snd_hdac_is_power_on(&cdc->core)) {
+		codec_dbg(cdc, "Resuming after bind.\n");
+		for (i = 0; i < HDA_MAX_COMPONENTS; i++)
+			if (spec->comps[i].resume_hook)
+				spec->comps[i].resume_hook(spec->comps[i].dev);
+	}
+
+	return 0;
 }
 
 static void comp_unbind(struct device *dev)
-- 
2.32.0

