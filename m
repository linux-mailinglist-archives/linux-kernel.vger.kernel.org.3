Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6A478A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhLQL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:58:12 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:64884 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235793AbhLQL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:57:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH7xa1m006045;
        Fri, 17 Dec 2021 05:57:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FbtxLzmWT/i2wweFnmuXlFKi4928In2fNWyJEawIQXY=;
 b=mUIWIZ74DvSiLEaJ+V8ovAgtVZAhkAQfeYLJugEtvm9a/6hiPz/v3S+J3JdHmv/ls5Rd
 AqoWdAl5ZQFem2DpEV/z+YOU/IdDF02o1kitu5asmJ/+1fNZ3mKCc3Z6CVfcW2UPl2O9
 PytlKZ9lj2vJz8ElFAES8E5K92+FzhFyr+DtlUcaxAA0TTx7MA3raooPW/5SGWsrT8P6
 fFYx32zEe2WD1cuyGY/xxWExuNmEdLbiHDhka92mPNY1jYXe1fAmgwdPve6VgXxF7+S1
 efIOK6BFnD5DC7e61QoJmALlB+vyeqesgyRqLYgcW2hoytQJxnoz6wkiOGmsTcy5FM0Z JQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc2f3n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 05:57:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 11:57:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 11:57:24 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0B5E2478;
        Fri, 17 Dec 2021 11:57:24 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v6 09/10] ALSA: hda/realtek: Add support for Legion 7 16ACHg6 laptop
Date:   Fri, 17 Dec 2021 11:57:07 +0000
Message-ID: <20211217115708.882525-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6RJXrF87jfKPcHIAAzhCJ5yE63KIsvbs
X-Proofpoint-ORIG-GUID: 6RJXrF87jfKPcHIAAzhCJ5yE63KIsvbs
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for CS35L41 using the component binding
method

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 107 ++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e59ff75eea75..af2897ca7b01 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -25,6 +25,7 @@
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
 #include "hda_generic.h"
+#include "hda_component.h"
 
 /* keep halting ALC5505 DSP, for power saving */
 #define HALT_REALTEK_ALC5505
@@ -126,6 +127,10 @@ struct alc_spec {
 	unsigned int coef0;
 	struct input_dev *kb_dev;
 	u8 alc_mute_keycode_map[1];
+
+	/* component binding */
+	struct component_match *match;
+	struct hda_component comps[HDA_MAX_COMPONENTS];
 };
 
 /*
@@ -6497,6 +6502,102 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
+static int comp_match_dev_name(struct device *dev, void *data)
+{
+	return strcmp(dev_name(dev), data) == 0;
+}
+
+static int find_comp_by_dev_name(struct alc_spec *spec, const char *name)
+{
+	int i;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (strcmp(spec->comps[i].name, name) == 0)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int comp_bind(struct device *dev)
+{
+	struct hda_codec *cdc = dev_to_hda_codec(dev);
+	struct alc_spec *spec = cdc->spec;
+
+	return component_bind_all(dev, spec->comps);
+}
+
+static void comp_unbind(struct device *dev)
+{
+	struct hda_codec *cdc = dev_to_hda_codec(dev);
+	struct alc_spec *spec = cdc->spec;
+
+	component_unbind_all(dev, spec->comps);
+}
+
+static const struct component_master_ops comp_master_ops = {
+	.bind = comp_bind,
+	.unbind = comp_unbind,
+};
+
+static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
+				       struct snd_pcm_substream *sub, int action)
+{
+	struct alc_spec *spec = cdc->spec;
+	int i;
+
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (spec->comps[i].dev)
+			spec->comps[i].playback_hook(spec->comps[i].dev, action);
+	}
+}
+
+static void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
+						struct snd_pcm_substream *sub, int action)
+{
+	struct alc_spec *spec = cdc->spec;
+	unsigned int rx_slot;
+	int i;
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_PREPARE:
+		rx_slot = 0;
+		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.0");
+		if (i >= 0)
+			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
+
+		rx_slot = 1;
+		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.1");
+		if (i >= 0)
+			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
+		break;
+	}
+
+	comp_generic_playback_hook(hinfo, cdc, sub, action);
+}
+
+static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
+						 int action)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct alc_spec *spec = cdc->spec;
+	int ret;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		component_match_add(dev, &spec->match, comp_match_dev_name,
+				    "i2c-CLSA0100:00-cs35l41-hda.0");
+		component_match_add(dev, &spec->match, comp_match_dev_name,
+				    "i2c-CLSA0100:00-cs35l41-hda.1");
+		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
+		if (ret)
+			codec_err(cdc, "Fail to register component aggregator %d\n", ret);
+		else
+			spec->gen.pcm_playback_hook = alc287_legion_16achg6_playback_hook;
+		break;
+	}
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -6766,6 +6867,7 @@ enum {
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
+	ALC287_FIXUP_LEGION_16ACHG6,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8490,6 +8592,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_no_audio_jack,
 	},
+	[ALC287_FIXUP_LEGION_16ACHG6] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_16achg6_speakers,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8901,6 +9007,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Yoga 9i", ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.34.1

