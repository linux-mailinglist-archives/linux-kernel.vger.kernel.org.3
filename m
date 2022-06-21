Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E60553DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356541AbiFUVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355488AbiFUVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:38:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00031260A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:38:29 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LBQrlO010673;
        Tue, 21 Jun 2022 16:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Pix/D3S9OebNgFhFGX/0xJqiIsFZ5HW8wcC6IbYMwgk=;
 b=Y6augWflPpW8eyp6+OUE3QQS3nJEcQTGTq09Oi4IJbQ3cvk2wrRpuLjmGOSV8yYDBrEi
 K6AgkEn4qk0X4ZMGLiiO60w6h/5hn+1+P/GfLGMWGQ/KLgabKp2tVCkjOT7NcnWutI5u
 7L4GuUo/YQUwmXwmLXcdYsbt+pNbLJAek5OfYsItwJ4QskjPT6+l6WZA1BjxKsmb07Fm
 zx5hm7PHcyc41bZ2yK4WV2j9LZK5SW9b2S1/UTuG2XE+YHhSRovfOPMr1LnMEYFdM29b
 NxtkhjDho6yt0AIHCNGgwHnOPJSUGvnySi5UWhxtudRCbpPyHpbATrdE2yuB3batoW6J 6A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41c7yj-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 16:38:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 22:38:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 22:38:06 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 48D5C11D1;
        Tue, 21 Jun 2022 21:38:06 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 13/14] ALSA: hda: cs35l41: Support Firmware switching and reloading
Date:   Tue, 21 Jun 2022 22:38:00 +0100
Message-ID: <20220621213801.2021097-14-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
References: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NveiNVgeqeftg2o4-LbCHmFxET_CdVEK
X-Proofpoint-ORIG-GUID: NveiNVgeqeftg2o4-LbCHmFxET_CdVEK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

This is required to support CS35L41 calibration.

By default, speaker protection firmware will be loaded, if
available. However, different firmware is required to run
the calibration sequence, so it is necessary to add support
to be able to unload, switch and reload firmware.

This patch adds 2 ALSA Controls for each amp:
"DSP1 Firmware Load"
"DSP1 Firmware Type"

"DSP1 Firmware Load" can be used to unload and
load the firmware.
"DSP1 Firmware Type"  can be used to switch the
target firmware to be loaded by "DSP1 Firmware Load"

Since loading firmware can add new ALSA controls, it is
necessary to ensure the firmware loading is run asynchronously
from the ALSA control itself to prevent deadlocks.

Note: When switching between firmwares, an ALSA control is
only added if it has not previously existed. If it had existed
previously, it will be re-enabled instead.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 201 ++++++++++++++++++++++++++++++++++--
 sound/pci/hda/cs35l41_hda.h |   6 ++
 2 files changed, 197 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index e51cdf42d3dc..3aa36c5ff972 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -21,7 +21,6 @@
 
 #define CS35L41_FIRMWARE_ROOT "cirrus/"
 #define CS35L41_PART "cs35l41"
-#define FW_NAME "CSPL"
 
 #define HALO_STATE_DSP_CTL_NAME		"HALO_STATE"
 #define HALO_STATE_DSP_CTL_TYPE		5
@@ -92,7 +91,7 @@ static int cs35l41_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
 	struct hda_cs_dsp_ctl_info info;
 
 	info.device_name = cs35l41->amp_name;
-	info.fw_type = HDA_CS_DSP_FW_SPK_PROT;
+	info.fw_type = cs35l41->firmware_type;
 	info.card = cs35l41->codec->card;
 
 	return hda_cs_dsp_control_add(cs_ctl, &info);
@@ -114,20 +113,24 @@ static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 
 	if (spkid > -1 && ssid && amp_name)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-spkid%d-%s.%s", dir, CS35L41_PART,
-				      dsp_name, "spk-prot", ssid, spkid, amp_name, filetype);
+				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
+				      ssid, spkid, amp_name, filetype);
 	else if (spkid > -1 && ssid)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-spkid%d.%s", dir, CS35L41_PART,
-				      dsp_name, "spk-prot", ssid, spkid, filetype);
+				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
+				      ssid, spkid, filetype);
 	else if (ssid && amp_name)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, CS35L41_PART,
-				      dsp_name, "spk-prot", ssid, amp_name,
-				      filetype);
+				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
+				      ssid, amp_name, filetype);
 	else if (ssid)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, CS35L41_PART,
-				      dsp_name, "spk-prot", ssid, filetype);
+				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
+				      ssid, filetype);
 	else
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, CS35L41_PART,
-				      dsp_name, "spk-prot", filetype);
+				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
+				      filetype);
 
 	if (*filename == NULL)
 		return -ENOMEM;
@@ -422,7 +425,7 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 		dev_warn(cs35l41->dev, "No Coefficient File available.\n");
 
 	ret = cs_dsp_power_up(dsp, wmfw_firmware, wmfw_filename, coeff_firmware, coeff_filename,
-			      FW_NAME);
+			      hda_cs_dsp_fw_ids[cs35l41->firmware_type]);
 	if (ret)
 		goto err_release;
 
@@ -451,6 +454,7 @@ static void cs35l41_remove_dsp(struct cs35l41_hda *cs35l41)
 {
 	struct cs_dsp *dsp = &cs35l41->cs_dsp;
 
+	cancel_work_sync(&cs35l41->fw_load_work);
 	cs35l41_shutdown_dsp(cs35l41);
 	cs_dsp_remove(dsp);
 	cs35l41->halo_initialized = false;
@@ -481,6 +485,7 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
+		cs35l41->playback_started = true;
 		if (cs35l41->firmware_running) {
 			regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
 					       ARRAY_SIZE(cs35l41_hda_config_dsp));
@@ -518,6 +523,7 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 					   0 << CS35L41_VMON_EN_SHIFT | 0 << CS35L41_IMON_EN_SHIFT);
 		}
 		cs35l41_irq_release(cs35l41);
+		cs35l41->playback_started = false;
 		break;
 	default:
 		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
@@ -664,10 +670,179 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 	return ret;
 }
 
+static void cs35l41_load_firmware(struct cs35l41_hda *cs35l41, bool load)
+{
+	pm_runtime_get_sync(cs35l41->dev);
+
+	if (cs35l41->firmware_running && !load) {
+		dev_dbg(cs35l41->dev, "Unloading Firmware\n");
+		cs35l41_shutdown_dsp(cs35l41);
+	} else if (!cs35l41->firmware_running && load) {
+		dev_dbg(cs35l41->dev, "Loading Firmware\n");
+		cs35l41_smart_amp(cs35l41);
+	} else {
+		dev_dbg(cs35l41->dev, "Unable to Load firmware.\n");
+	}
+
+	pm_runtime_mark_last_busy(cs35l41->dev);
+	pm_runtime_put_autosuspend(cs35l41->dev);
+}
+
+static int cs35l41_fw_load_ctl_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = cs35l41->request_fw_load;
+	return 0;
+}
+
+static void cs35l41_fw_load_work(struct work_struct *work)
+{
+	struct cs35l41_hda *cs35l41 = container_of(work, struct cs35l41_hda, fw_load_work);
+
+	mutex_lock(&cs35l41->fw_mutex);
+
+	/* Recheck if playback is ongoing, mutex will block playback during firmware loading */
+	if (cs35l41->playback_started)
+		dev_err(cs35l41->dev, "Cannot Load/Unload firmware during Playback\n");
+	else
+		cs35l41_load_firmware(cs35l41, cs35l41->request_fw_load);
+
+	cs35l41->fw_request_ongoing = false;
+	mutex_unlock(&cs35l41->fw_mutex);
+}
+
+static int cs35l41_fw_load_ctl_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
+	unsigned int ret = 0;
+
+	mutex_lock(&cs35l41->fw_mutex);
+
+	if (cs35l41->request_fw_load == ucontrol->value.integer.value[0])
+		goto err;
+
+	if (cs35l41->fw_request_ongoing) {
+		dev_dbg(cs35l41->dev, "Existing request not complete\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Check if playback is ongoing when initial request is made */
+	if (cs35l41->playback_started) {
+		dev_err(cs35l41->dev, "Cannot Load/Unload firmware during Playback\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	cs35l41->fw_request_ongoing = true;
+	cs35l41->request_fw_load = ucontrol->value.integer.value[0];
+	schedule_work(&cs35l41->fw_load_work);
+
+err:
+	mutex_unlock(&cs35l41->fw_mutex);
+
+	return ret;
+}
+
+static int cs35l41_fw_type_ctl_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = cs35l41->firmware_type;
+
+	return 0;
+}
+
+static int cs35l41_fw_type_ctl_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.enumerated.item[0] < HDA_CS_DSP_NUM_FW) {
+		cs35l41->firmware_type = ucontrol->value.enumerated.item[0];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int cs35l41_fw_type_ctl_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(hda_cs_dsp_fw_ids), hda_cs_dsp_fw_ids);
+}
+
+static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
+{
+	struct snd_kcontrol_new fw_type_ctl = {
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.info = cs35l41_fw_type_ctl_info,
+		.get = cs35l41_fw_type_ctl_get,
+		.put = cs35l41_fw_type_ctl_put,
+	};
+	struct snd_kcontrol_new fw_load_ctl = {
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.info = snd_ctl_boolean_mono_info,
+		.get = cs35l41_fw_load_ctl_get,
+		.put = cs35l41_fw_load_ctl_put,
+	};
+	struct snd_kcontrol *kctl1, *kctl2;
+	int ret = 0;
+
+	fw_load_ctl.name = kasprintf(GFP_KERNEL, "%s DSP1 Firmware Load", cs35l41->amp_name);
+	if (!fw_load_ctl.name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	fw_type_ctl.name = kasprintf(GFP_KERNEL, "%s DSP1 Firmware Type", cs35l41->amp_name);
+	if (!fw_type_ctl.name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	kctl1 = snd_ctl_new1(&fw_type_ctl, cs35l41);
+	if (!kctl1) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	if (snd_ctl_add(cs35l41->codec->card, kctl1)) {
+		ret = -ENODEV;
+		dev_err(cs35l41->dev, "Failed to add KControl: %s\n", fw_type_ctl.name);
+		goto err;
+	}
+
+	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_type_ctl.name);
+
+	kctl2 = snd_ctl_new1(&fw_load_ctl, cs35l41);
+	if (!kctl2) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	if (snd_ctl_add(cs35l41->codec->card, kctl2)) {
+		ret = -ENODEV;
+		dev_err(cs35l41->dev, "Failed to add KControl: %s, removing all controls\n",
+			fw_load_ctl.name);
+		goto err;
+	}
+
+	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
+
+err:
+	kfree(fw_load_ctl.name);
+	kfree(fw_type_ctl.name);
+
+	return ret;
+}
+
 static int cs35l41_hda_bind(struct device *dev, struct device *master, void *master_data)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
+	int ret = 0;
 
 	if (!comps || cs35l41->index < 0 || cs35l41->index >= HDA_MAX_COMPONENTS)
 		return -EINVAL;
@@ -685,11 +860,16 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	cs35l41->codec = comps->codec;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 
+	cs35l41->firmware_type = HDA_CS_DSP_FW_SPK_PROT;
+
+	cs35l41->request_fw_load = true;
 	mutex_lock(&cs35l41->fw_mutex);
 	if (cs35l41_smart_amp(cs35l41) < 0)
 		dev_warn(cs35l41->dev, "Cannot Run Firmware, reverting to dsp bypass...\n");
 	mutex_unlock(&cs35l41->fw_mutex);
 
+	ret = cs35l41_create_controls(cs35l41);
+
 	comps->playback_hook = cs35l41_hda_playback_hook;
 	comps->suspend_hook = cs35l41_hda_suspend_hook;
 	comps->resume_hook = cs35l41_hda_resume_hook;
@@ -697,7 +877,7 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	return 0;
+	return ret;
 }
 
 static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *master_data)
@@ -1208,6 +1388,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (ret)
 		goto err;
 
+	INIT_WORK(&cs35l41->fw_load_work, cs35l41_fw_load_work);
 	mutex_init(&cs35l41->fw_mutex);
 
 	pm_runtime_set_autosuspend_delay(cs35l41->dev, 3000);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 59a9461d0444..bdb35f3be68a 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -58,11 +58,17 @@ struct cs35l41_hda {
 	unsigned volatile long irq_errors;
 	const char *amp_name;
 	const char *acpi_subsystem_id;
+	int firmware_type;
 	int speaker_id;
 	struct mutex fw_mutex;
+	struct work_struct fw_load_work;
+
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;
+	bool request_fw_load;
+	bool fw_request_ongoing;
 	bool halo_initialized;
+	bool playback_started;
 	struct cs_dsp cs_dsp;
 };
 
-- 
2.34.1

