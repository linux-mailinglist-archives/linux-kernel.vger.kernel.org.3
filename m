Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506BD5220FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347267AbiEJQWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiEJQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:21:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE7291E7C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:17:52 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A5TVpg021012;
        Tue, 10 May 2022 11:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=nrGmf72PUMvWhBwg/KmhLmnE44YnGnwysukUNCGsDJ8=;
 b=QuFbHVYaIR3oebw39Hz2rxfsRHykhbyQBlCIkUj6BRhtHLyQXsFkhtAlzTj8UABIN5Tx
 KtYDDSPOpVoLifyLhKG3lOcOaIdzq5evAPSiYmWSO9m5H05LSkeM4CzubtYWFooiAHVG
 gLO1rPkdy/3wUMD43/3RQWcfAmBJn8zqcB5455BFJ2xI38HueEPD41zRe4jm1OLE7u9u
 4hFafamjgVGCcSfTzoz/CnT8G7Jdtvv0qlgo9yKBZdsev5jsHDgdHth8fZC0pIvafPZe
 PRdLoFdILRQgatb9E2avRSBoVbNuySj1RNuQPSTWzGkBE1XI7/PxQxXubYImsJXoM8Xi Tw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nvk88-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 May 2022 11:17:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 17:17:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 17:17:07 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.24])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C9491475;
        Tue, 10 May 2022 16:17:06 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/3] ALSA: hda/cs8409: Add Speaker Playback Switch for Cyborg
Date:   Tue, 10 May 2022 17:17:00 +0100
Message-ID: <20220510161701.851260-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510161701.851260-1-sbinding@opensource.cirrus.com>
References: <20220510161701.851260-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7s0dOMeRLauZMyKRs4YJNDSCKzZvKS-L
X-Proofpoint-GUID: 7s0dOMeRLauZMyKRs4YJNDSCKzZvKS-L
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a Speaker Playback Switch, which disables
the Amp connected to cs8409. The Switch is not added
automatically because cs8409 does not have an output amp
for the speaker NID.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 72 ++++++++++++++++++++++++++++++------
 sound/pci/hda/patch_cs8409.h |  3 ++
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index c4d21569cc7d..f682769667e3 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -419,6 +419,39 @@ static void cs8409_fix_caps(struct hda_codec *codec, unsigned int nid)
 	snd_hda_override_wcaps(codec, nid, (get_wcaps(codec, nid) | AC_WCAP_UNSOL_CAP));
 }
 
+static int cs8409_spk_sw_gpio_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs8409_spec *spec = codec->spec;
+
+	ucontrol->value.integer.value[0] = !!(spec->gpio_data & spec->speaker_pdn_gpio);
+	return 0;
+}
+
+static int cs8409_spk_sw_gpio_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs8409_spec *spec = codec->spec;
+	unsigned int gpio_data;
+
+	gpio_data = (spec->gpio_data & ~spec->speaker_pdn_gpio) |
+		(ucontrol->value.integer.value[0] ? spec->speaker_pdn_gpio : 0);
+	if (gpio_data == spec->gpio_data)
+		return 0;
+	spec->gpio_data = gpio_data;
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, spec->gpio_data);
+	return 1;
+}
+
+static const struct snd_kcontrol_new cs8409_spk_sw_ctrl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = snd_ctl_boolean_mono_info,
+	.get = cs8409_spk_sw_gpio_get,
+	.put = cs8409_spk_sw_gpio_put,
+};
+
 /******************************************************************************
  *                        CS42L42 Specific Functions
  ******************************************************************************/
@@ -836,7 +869,7 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 static void cs42l42_resume(struct sub_codec *cs42l42)
 {
 	struct hda_codec *codec = cs42l42->codec;
-	unsigned int gpio_data;
+	struct cs8409_spec *spec = codec->spec;
 	struct cs8409_i2c_param irq_regs[] = {
 		{ CS42L42_CODEC_STATUS, 0x00 },
 		{ CS42L42_DET_INT_STATUS1, 0x00 },
@@ -846,9 +879,9 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	int fsv_old, fsv_new;
 
 	/* Bring CS42L42 out of Reset */
-	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
-	gpio_data |= cs42l42->reset_gpio;
-	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, gpio_data);
+	spec->gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
+	spec->gpio_data |= cs42l42->reset_gpio;
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, spec->gpio_data);
 	usleep_range(10000, 15000);
 
 	cs42l42->suspended = 0;
@@ -880,7 +913,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 static void cs42l42_suspend(struct sub_codec *cs42l42)
 {
 	struct hda_codec *codec = cs42l42->codec;
-	unsigned int gpio_data;
+	struct cs8409_spec *spec = codec->spec;
 	int reg_cdc_status = 0;
 	const struct cs8409_i2c_param cs42l42_pwr_down_seq[] = {
 		{ CS42L42_DAC_CTL2, 0x02 },
@@ -911,9 +944,9 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 	cs42l42->mic_jack_in = 0;
 
 	/* Put CS42L42 into Reset */
-	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
-	gpio_data &= ~cs42l42->reset_gpio;
-	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, gpio_data);
+	spec->gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
+	spec->gpio_data &= ~cs42l42->reset_gpio;
+	snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA, spec->gpio_data);
 }
 #endif
 
@@ -1106,6 +1139,8 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		spec->gen.no_primary_hp = 1;
 		spec->gen.suppress_vmaster = 1;
 
+		spec->speaker_pdn_gpio = 0;
+
 		/* GPIO 5 out, 3,4 in */
 		spec->gpio_dir = spec->scodecs[CS8409_CODEC0]->reset_gpio;
 		spec->gpio_data = 0;
@@ -1117,21 +1152,33 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		cs8409_fix_caps(codec, CS8409_CS42L42_HP_PIN_NID);
 		cs8409_fix_caps(codec, CS8409_CS42L42_AMIC_PIN_NID);
 
-		/* Set HSBIAS_SENSE_EN and Full Scale volume for some variants. */
+		spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
+
 		switch (codec->fixup_id) {
+		case CS8409_CYBORG:
+			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
+				CS42L42_FULL_SCALE_VOL_MINUS6DB;
+			spec->speaker_pdn_gpio = CS8409_CYBORG_SPEAKER_PDN;
+			break;
 		case CS8409_ODIN:
+			spec->scodecs[CS8409_CODEC0]->full_scale_vol = CS42L42_FULL_SCALE_VOL_0DB;
+			spec->speaker_pdn_gpio = CS8409_CYBORG_SPEAKER_PDN;
+			break;
 		case CS8409_WARLOCK_MLK:
 		case CS8409_WARLOCK_MLK_DUAL_MIC:
-			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
 			spec->scodecs[CS8409_CODEC0]->full_scale_vol = CS42L42_FULL_SCALE_VOL_0DB;
 			break;
 		default:
-			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
 			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
 				CS42L42_FULL_SCALE_VOL_MINUS6DB;
 			break;
 		}
 
+		if (spec->speaker_pdn_gpio > 0) {
+			spec->gpio_dir |= spec->speaker_pdn_gpio;
+			spec->gpio_data |= spec->speaker_pdn_gpio;
+		}
+
 		break;
 	case HDA_FIXUP_ACT_PROBE:
 		/* Fix Sample Rate to 48kHz */
@@ -1148,6 +1195,9 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 				&cs42l42_dac_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, "Mic Capture Volume",
 				&cs42l42_adc_volume_mixer);
+		if (spec->speaker_pdn_gpio > 0)
+			snd_hda_gen_add_kctl(&spec->gen, "Speaker Playback Switch",
+					     &cs8409_spk_sw_ctrl);
 		/* Disable Unsolicited Response during boot */
 		cs8409_enable_ur(codec, 0);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 9852dc4234b4..630a7a2de51f 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -238,6 +238,7 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_I2C_ADDR			(0x48 << 1)
 #define CS8409_CS42L42_RESET			GENMASK(5, 5) /* CS8409_GPIO5 */
 #define CS8409_CS42L42_INT			GENMASK(4, 4) /* CS8409_GPIO4 */
+#define CS8409_CYBORG_SPEAKER_PDN		GENMASK(2, 2) /* CS8409_GPIO2 */
 #define CS8409_CS42L42_HP_PIN_NID		CS8409_PIN_ASP1_TRANSMITTER_A
 #define CS8409_CS42L42_SPK_PIN_NID		CS8409_PIN_ASP2_TRANSMITTER_A
 #define CS8409_CS42L42_AMIC_PIN_NID		CS8409_PIN_ASP1_RECEIVER_A
@@ -326,6 +327,8 @@ struct cs8409_spec {
 	unsigned int gpio_dir;
 	unsigned int gpio_data;
 
+	int speaker_pdn_gpio;
+
 	struct mutex i2c_mux;
 	unsigned int i2c_clck_enabled;
 	unsigned int dev_addr;
-- 
2.25.1

