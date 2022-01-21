Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F734963D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380697AbiAURZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:25:23 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:8350 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380037AbiAURZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:25:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LHACZE027684;
        Fri, 21 Jan 2022 11:24:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/FscdIwUTX/T+KXtKcNQWJfwM3iEhr7GIwyOVP/4iic=;
 b=pbFVDhykG8JDd7oq+EtEg89whxuf62xD5hOJruy7qHoSvZk4K7bqGUzMHaY/GEzYIJhv
 nIZh+O1MoquGVZSPVLD/xFdFb5PpBPxXMp99gq5C5x33IZWmVoLPXOuEi2Agll6tHmFv
 bXdCM+1sQVPG/XooJTVUn0trHF6b5tz1cTIaDfeCxRexRtwzVvLvVigeN0r6/7EO9A6F
 TlDpaGhnj8Up77gzQV7SIdNekV/l6yr2pqTqPaCz+nkwjVnEtMrH7U5FycBpFuoNCzpC
 hN28imYl+eU7b6Z5xRD5/OnRleVYCTKXeRfxCJk2kF3mRyKSPKXK709g67AxVWWNB14u 4g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq14dq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:24:55 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 17:24:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 17:24:53 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CFBD3B0E;
        Fri, 21 Jan 2022 17:24:52 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 8/9] ALSA: hda/realtek: Add support for HP Laptops
Date:   Fri, 21 Jan 2022 17:24:30 +0000
Message-ID: <20220121172431.6876-9-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oBJsRaSVYgT4d31VUfCS_IKYVzEwd2t5
X-Proofpoint-ORIG-GUID: oBJsRaSVYgT4d31VUfCS_IKYVzEwd2t5
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Add support for two and four CS35L41 using the component
binding method

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 43 ++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 668274e52674..db0fce42887c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6611,6 +6611,16 @@ static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup
 	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 2);
 }
 
+static void cs35l41_fixup_spi_two(struct hda_codec *codec, const struct hda_fixup *fix, int action)
+{
+	cs35l41_generic_fixup(codec, action, "spi0", "CSC3551", 2);
+}
+
+static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fixup *fix, int action)
+{
+	cs35l41_generic_fixup(codec, action, "spi0", "CSC3551", 4);
+}
+
 static void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
 						struct snd_pcm_substream *sub, int action)
 {
@@ -6948,6 +6958,9 @@ enum {
 	ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
+	ALC245_FIXUP_CS35L41_SPI_2,
+	ALC245_FIXUP_CS35L41_SPI_4,
+	ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED,
 	ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
 };
 
@@ -8699,6 +8712,20 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
 	},
+	[ALC245_FIXUP_CS35L41_SPI_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_spi_two,
+	},
+	[ALC245_FIXUP_CS35L41_SPI_4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_spi_four,
+	},
+	[ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_gpio_led,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_CS35L41_SPI_4,
+	},
 	[ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -8926,7 +8953,21 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x89c3, "HP", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8971, "HP EliteBook 830 G9", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8972, "HP EliteBook 840 G9", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8973, "HP EliteBook 860 G9", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8974, "HP EliteBook 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8975, "HP EliteBook x360 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8981, "HP Elite Dragonfly G3", ALC245_FIXUP_CS35L41_SPI_4),
+	SND_PCI_QUIRK(0x103c, 0x898e, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x898f, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8991, "HP EliteBook 845 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8992, "HP EliteBook 845 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8994, "HP EliteBook 855 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8995, "HP EliteBook 855 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x89c3, "Zbook Studio G9", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
-- 
2.25.1

