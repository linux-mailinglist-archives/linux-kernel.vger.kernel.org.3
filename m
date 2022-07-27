Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338A5823A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiG0KAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiG0KAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:00:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C862F6;
        Wed, 27 Jul 2022 03:00:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4SNEf032560;
        Wed, 27 Jul 2022 04:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=UHvBpm5zfl//HU6kw3atKgmqc2hKJIkAZW2cDtQKQ5k=;
 b=IlRbU5NQhqkHHA1JhBgR+IECQY58O2ue3NFZLgrKUv+8IhzaYe6kO80S0KG5L4cp2GTf
 pl148xTAFYmFbCh6lXUb40Exa4WgI+jpKfmEvdGnUiKSXZ5TyT3M7Tq2ZzdMVak00zuR
 y33G9n2j+JMcZi22O2qu3iA8Z8r7ydryvYFv+i89HXsDZytG/RkBm2rPXM41WLNITCYU
 CE6/sN7zKj/vCJBE4KSwZQXaCBlolFi2lJq3k+SH2m2EFgiEPIC7BBs4CHmwC36J+bfg
 KtQkg/vyuebbsP8c14HfqFhFi76uRQgHybqhXrcnyhvv8PiBSPNFMTkkmCf25DD05vXo MA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hged1vtk6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:59:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 04:59:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Wed, 27 Jul 2022 04:59:28 -0500
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 86C4CB0E;
        Wed, 27 Jul 2022 09:59:28 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Cameron Berkenpas <cam@neo-zeon.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 2/4] ALSA: hda: cs35l41: Support CLSA0101
Date:   Wed, 27 Jul 2022 10:59:22 +0100
Message-ID: <20220727095924.80884-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
References: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lShaz5kvN2W-QsD4ao7Q4JOh0--Mn88P
X-Proofpoint-ORIG-GUID: lShaz5kvN2W-QsD4ao7Q4JOh0--Mn88P
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Intel version of Legion 7 laptop.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c     | 66 ++++++++++++++++++++-------------
 sound/pci/hda/cs35l41_hda_i2c.c |  3 ++
 sound/pci/hda/patch_realtek.c   | 12 ++++++
 3 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 48d94c683b75..6edf95553745 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1133,6 +1133,45 @@ static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
 	return speaker_id;
 }
 
+/*
+ * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
+ * And devices created by serial-multi-instantiate don't have their device struct
+ * pointing to the correct fwnode, so acpi_dev must be used here.
+ * And devm functions expect that the device requesting the resource has the correct
+ * fwnode.
+ */
+static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			       const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+
+	/* check I2C address to assign the index */
+	cs35l41->index = id == 0x40 ? 0 : 1;
+	cs35l41->channel_index = 0;
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
+	hw_cfg->spk_pos = cs35l41->index;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->valid = true;
+	put_device(physdev);
+
+	if (strncmp(hid, "CLSA0100", 8) == 0) {
+		hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
+	} else if (strncmp(hid, "CLSA0101", 8) == 0) {
+		hw_cfg->bst_type = CS35L41_EXT_BOOST;
+		hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
+		hw_cfg->gpio1.valid = true;
+	} else {
+		hw_cfg->valid = false;
+		hw_cfg->gpio1.valid = false;
+		hw_cfg->gpio2.valid = false;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, int id)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
@@ -1161,7 +1200,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	property = "cirrus,dev-index";
 	ret = device_property_count_u32(physdev, property);
 	if (ret <= 0)
-		goto no_acpi_dsd;
+		return cs35l41_no_acpi_dsd(cs35l41, physdev, id, hid);
 
 	if (ret > ARRAY_SIZE(values)) {
 		ret = -EINVAL;
@@ -1255,31 +1294,6 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	dev_err(cs35l41->dev, "Failed property %s: %d\n", property, ret);
 
 	return ret;
-
-no_acpi_dsd:
-	/*
-	 * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
-	 * And devices created by serial-multi-instantiate don't have their device struct
-	 * pointing to the correct fwnode, so acpi_dev must be used here.
-	 * And devm functions expect that the device requesting the resource has the correct
-	 * fwnode.
-	 */
-	if (strncmp(hid, "CLSA0100", 8) != 0)
-		return -EINVAL;
-
-	/* check I2C address to assign the index */
-	cs35l41->index = id == 0x40 ? 0 : 1;
-	cs35l41->hw_cfg.spk_pos = cs35l41->index;
-	cs35l41->channel_index = 0;
-	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
-	cs35l41->hw_cfg.bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
-	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
-	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
-	hw_cfg->gpio2.valid = true;
-	cs35l41->hw_cfg.valid = true;
-	put_device(physdev);
-
-	return 0;
 }
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index 9c08fa08c421..5baacfde4f16 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -22,6 +22,8 @@ static int cs35l41_hda_i2c_probe(struct i2c_client *clt, const struct i2c_device
 	 */
 	if (strstr(dev_name(&clt->dev), "CLSA0100"))
 		device_name = "CLSA0100";
+	else if (strstr(dev_name(&clt->dev), "CLSA0101"))
+		device_name = "CLSA0101";
 	else if (strstr(dev_name(&clt->dev), "CSC3551"))
 		device_name = "CSC3551";
 	else
@@ -45,6 +47,7 @@ static const struct i2c_device_id cs35l41_hda_i2c_id[] = {
 
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{"CLSA0100", 0 },
+	{"CLSA0101", 0 },
 	{"CSC3551", 0 },
 	{}
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0e340c0934db..65fd3e599a83 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6710,6 +6710,12 @@ static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const st
 	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0100", 2);
 }
 
+static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
+						 int action)
+{
+	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0101", 2);
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -7047,6 +7053,7 @@ enum {
 	ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED,
 	ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
 	ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE,
+	ALC287_FIXUP_LEGION_16ITHG6,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -8889,6 +8896,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC287_FIXUP_LEGION_16ITHG6] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_16ithg6_speakers,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9353,6 +9364,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x384a, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.37.1

