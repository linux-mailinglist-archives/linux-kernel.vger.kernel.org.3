Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83D45220E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbiEJQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiEJQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:21:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86528C9FA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:17:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A5TVpf021012;
        Tue, 10 May 2022 11:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uBSWCqZV6AZfkui42gbQt3shr/UiB+T/uu6E3fJbL44=;
 b=SJXq3ic0OwruUk522Cmtuy3a6gC4Do/YZFUNAu3BqE8GKjoLvQ8z9/osAbzhZ1oecdAo
 gWzjWu+Awj3TZ/nX0r95vIB1YjaWBvqUT8+azym//Bui/LFEklKwYY7TCIZ+HbVZB1Zz
 NDpS2UJYnwvTqt7KAqW/oUj1SvP8O+/s42a/9Zfj1qDVkSz4PavsSaOba7KjMFcbIVIG
 DYTkbapmbYIA2YeyYcqrnTtBhdkx8/0K+mnfLiOkL8vBc7tY7+jntXaZR5dNhrqenNYv
 T8d9kfBHqlj+cMNJHWiIQdRttF3+Z+Ebc/F75mUCvRNsfLjbiXHdObI6YdG59H3tSqcN 0w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nvk8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 May 2022 11:17:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 17:17:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 17:17:06 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.24])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 80BCE11D1;
        Tue, 10 May 2022 16:17:06 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/3] ALSA: hda/cs8409: Support new Odin Variants
Date:   Tue, 10 May 2022 17:16:59 +0100
Message-ID: <20220510161701.851260-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510161701.851260-1-sbinding@opensource.cirrus.com>
References: <20220510161701.851260-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F-RndI_SK0Tyh-I5lr4TdqenhbWolmm2
X-Proofpoint-GUID: F-RndI_SK0Tyh-I5lr4TdqenhbWolmm2
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

Odin Variants have the internal mic connected
directly to the CPU rather than codec.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c | 19 +++++++++++++++++++
 sound/pci/hda/patch_cs8409.c        | 11 ++++++++---
 sound/pci/hda/patch_cs8409.h        |  1 +
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 0d11b24a1317..4f4cc8215917 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -76,6 +76,13 @@ const struct hda_pintbl cs8409_cs42l42_pincfgs[] = {
 	{} /* terminator */
 };
 
+const struct hda_pintbl cs8409_cs42l42_pincfgs_no_dmic[] = {
+	{ CS8409_PIN_ASP1_TRANSMITTER_A, 0x042120f0 },	/* ASP-1-TX */
+	{ CS8409_PIN_ASP1_RECEIVER_A, 0x04a12050 },	/* ASP-1-RX */
+	{ CS8409_PIN_ASP2_TRANSMITTER_A, 0x901000f0 },	/* ASP-2-TX */
+	{} /* terminator */
+};
+
 /* Vendor specific HW configuration for CS42L42 */
 static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ CS42L42_I2C_TIMEOUT, 0xB0 },
@@ -518,6 +525,11 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0B95, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0B96, "Warlock MLK", CS8409_WARLOCK_MLK),
 	SND_PCI_QUIRK(0x1028, 0x0B97, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0BA5, "Odin", CS8409_ODIN),
+	SND_PCI_QUIRK(0x1028, 0x0BA6, "Odin", CS8409_ODIN),
+	SND_PCI_QUIRK(0x1028, 0x0BA8, "Odin", CS8409_ODIN),
+	SND_PCI_QUIRK(0x1028, 0x0BAA, "Odin", CS8409_ODIN),
+	SND_PCI_QUIRK(0x1028, 0x0BAE, "Odin", CS8409_ODIN),
 	SND_PCI_QUIRK(0x1028, 0x0BB2, "Warlock MLK", CS8409_WARLOCK_MLK),
 	SND_PCI_QUIRK(0x1028, 0x0BB3, "Warlock MLK", CS8409_WARLOCK_MLK),
 	SND_PCI_QUIRK(0x1028, 0x0BB4, "Warlock MLK", CS8409_WARLOCK_MLK),
@@ -545,6 +557,7 @@ const struct hda_model_fixup cs8409_models[] = {
 	{ .id = CS8409_WARLOCK_MLK_DUAL_MIC, .name = "warlock mlk dual mic" },
 	{ .id = CS8409_CYBORG, .name = "cyborg" },
 	{ .id = CS8409_DOLPHIN, .name = "dolphin" },
+	{ .id = CS8409_ODIN, .name = "odin" },
 	{}
 };
 
@@ -593,4 +606,10 @@ const struct hda_fixup cs8409_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = dolphin_fixups,
 	},
+	[CS8409_ODIN] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cs8409_cs42l42_pincfgs_no_dmic,
+		.chained = true,
+		.chain_id = CS8409_FIXUPS,
+	},
 };
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index c3a8b04c71d8..c4d21569cc7d 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1027,6 +1027,9 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 		/* DMIC1_MO=00b, DMIC1/2_SR=1 */
 		cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
 		break;
+	case CS8409_ODIN:
+		/* ASP1/2_xxx_EN=1, ASP1/2_MCLK_EN=0, DMIC1_SCL_EN=0 */
+		cs8409_vendor_coef_set(codec, CS8409_PAD_CFG_SLW_RATE_CTRL, 0xfc00);
 	default:
 		break;
 	}
@@ -1116,6 +1119,7 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 
 		/* Set HSBIAS_SENSE_EN and Full Scale volume for some variants. */
 		switch (codec->fixup_id) {
+		case CS8409_ODIN:
 		case CS8409_WARLOCK_MLK:
 		case CS8409_WARLOCK_MLK_DUAL_MIC:
 			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
@@ -1136,9 +1140,10 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 		/* add hooks */
 		spec->gen.pcm_playback_hook = cs42l42_playback_pcm_hook;
 		spec->gen.pcm_capture_hook = cs42l42_capture_pcm_hook;
-		/* Set initial DMIC volume to -26 dB */
-		snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
-					      HDA_INPUT, 0, 0xff, 0x19);
+		if (codec->fixup_id != CS8409_ODIN)
+			/* Set initial DMIC volume to -26 dB */
+			snd_hda_codec_amp_init_stereo(codec, CS8409_CS42L42_DMIC_ADC_PIN_NID,
+						      HDA_INPUT, 0, 0xff, 0x19);
 		snd_hda_gen_add_kctl(&spec->gen, "Headphone Playback Volume",
 				&cs42l42_dac_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, "Mic Capture Volume",
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index ebf473a3f109..9852dc4234b4 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -267,6 +267,7 @@ enum {
 	CS8409_FIXUPS,
 	CS8409_DOLPHIN,
 	CS8409_DOLPHIN_FIXUPS,
+	CS8409_ODIN,
 };
 
 enum {
-- 
2.25.1

