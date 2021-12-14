Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5341147442D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhLNOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:00:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:25386 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234671AbhLNOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:00:31 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE4Ko3p006814;
        Tue, 14 Dec 2021 08:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=d/1h1dcmjbxeO1WOxkRmaotN/td2jqwcrUgCM/MTXvU=;
 b=feMF4N6IOcbAkT6787HfxGICUYk7d+xb9NbxLs6OeEGk7KkAhDL2pDHeDbVWMfJ1eqfC
 OekM44D+J7eIZE4gGXHCTx66Jz4YF/0PVBKQ2NTc4SNCns0chwb9AMWFpSuBrY30IZ/n
 Nsa24PSMGQOUSR2kpkU8L14v0CWUVD5c3ksJ18bWGJ7vh/z3nluQ91hyHul20avpzV2E
 CwonOvwZsw8F3hTyiDZDsv7pIYcLPuGvKdGntw52mSVnTgTSCnrGcpfOuV4dHv6xnlyg
 Nx217B1sJjkRaGxiC+FlRkrjoz1lD4be+H5VAi23G5SCmhKVZecPcrsSSeVj4OwjVngt cA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cxh14grht-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 08:00:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 14:00:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Dec 2021 14:00:05 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 21C56B12;
        Tue, 14 Dec 2021 14:00:05 +0000 (UTC)
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
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v4 10/10] ALSA: hda/realtek: Add CS35L41 support for Thinkpad laptops
Date:   Tue, 14 Dec 2021 13:59:59 +0000
Message-ID: <20211214135959.1317949-11-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
References: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 49LNN7KSG5k83oJX55pFMpVTm8EV8yd8
X-Proofpoint-ORIG-GUID: 49LNN7KSG5k83oJX55pFMpVTm8EV8yd8
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Add support for two CS35L41 using I2C bus and the component
binding method

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c7afabfae574..56c2ce3121fd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6555,6 +6555,35 @@ void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *
 	}
 }
 
+static void cs35l41_generic_fixup(struct hda_codec *codec, int action, const char *bus,
+				  const char *hid, int count)
+{
+	struct device *dev = hda_codec_dev(codec);
+	struct alc_spec *spec = codec->spec;
+	char *name;
+	int ret, i;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		for (i = 0; i < count; i++) {
+			name = devm_kasprintf(dev, GFP_KERNEL,
+					      "%s-%s:00-cs35l41-hda.%d", bus, hid, i);
+			component_match_add(dev, &spec->match, comp_match_dev_name, name);
+		}
+		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
+		if (ret)
+			codec_err(codec, "Fail to register component aggregator %d\n", ret);
+		else
+			spec->gen.pcm_playback_hook = comp_generic_playback_hook;
+		break;
+	}
+}
+
+static void cs35l41_fixup_i2c_two(struct hda_codec *codec, const struct hda_fixup *fix, int action)
+{
+	cs35l41_generic_fixup(codec, action, "i2c", "CSC3551", 2);
+}
+
 void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *codec,
 					 struct snd_pcm_substream *sub, int action)
 {
@@ -6871,6 +6900,7 @@ enum {
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
 	ALC287_FIXUP_LEGION_16ACHG6,
+	ALC287_FIXUP_CS35L41_I2C_2,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8599,6 +8629,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_legion_16achg6_speakers,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9009,6 +9043,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Yoga 9i", ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
+	SND_PCI_QUIRK(0x17aa, 0x22F1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x22F2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x22F3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.34.1

