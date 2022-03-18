Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7634DDD60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiCRP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiCRP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:57:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E7C97B8B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I4MHlc013781;
        Fri, 18 Mar 2022 10:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=yqr1wHW5rfR3nbhmYjfiUlx+jENyAjgkxhhw0beyGEE=;
 b=boMHOJuZr41DoB9SC03/L2hpLx7OQVdij6nPocECFHZqkB+eU1yQHon6HbYOxtI2lm3F
 lOzUHb+dMoxS6iWhNktdqH48BS/NmYDUK28nC2lKcE/Y21yD1PhpZR7hqIETjc8DhZXa
 tdbsWT52oti+o/62oWkbpptnS0FifFt0tKI0UWGphqvkRZJDkxSD8c9o2Q2IQugl2ee2
 apwdi20z5vZj6z0gMgEroRnEtnjCFhoa76B4um17Il8C4gFX8ySBkBIlIhvFPEYHb3sj
 fyrF9/Ik7upPl5sDHnSbKZTdEk/Qk/HRyXXI0xK/DSVjbuxODyi5Nx8KxP6slsnJKXfz ag== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp65wt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:55:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 15:55:54 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9A4B7B16;
        Fri, 18 Mar 2022 15:55:54 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 4/6] ALSA: hda/cs8409: Support new Warlock MLK Variants
Date:   Fri, 18 Mar 2022 15:55:50 +0000
Message-ID: <20220318155552.24751-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
References: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j7mr1XM0IX6QvJGyYmBgoo6WX7WpDY7C
X-Proofpoint-GUID: j7mr1XM0IX6QvJGyYmBgoo6WX7WpDY7C
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c | 29 +++++++++++++++++++++++++++++
 sound/pci/hda/patch_cs8409.c        | 17 ++++++++++++++---
 sound/pci/hda/patch_cs8409.h        |  2 ++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 9c1fa97100ef..8d20d7fb3d68 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -515,8 +515,23 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0AF0, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0AF4, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AF5, "Warlock", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0B92, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0B93, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0B94, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0B95, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0B96, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0B97, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0BB2, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0BB3, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0BB4, "Warlock MLK", CS8409_WARLOCK_MLK),
 	SND_PCI_QUIRK(0x1028, 0x0BB5, "Warlock N3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0BB6, "Warlock V3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0BB8, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0BB9, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0BBA, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0BBB, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0BBC, "Warlock MLK", CS8409_WARLOCK_MLK),
+	SND_PCI_QUIRK(0x1028, 0x0BBD, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
 	{} /* terminator */
 };
 
@@ -524,6 +539,8 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
 const struct hda_model_fixup cs8409_models[] = {
 	{ .id = CS8409_BULLSEYE, .name = "bullseye" },
 	{ .id = CS8409_WARLOCK, .name = "warlock" },
+	{ .id = CS8409_WARLOCK_MLK, .name = "warlock mlk" },
+	{ .id = CS8409_WARLOCK_MLK_DUAL_MIC, .name = "warlock mlk dual mic" },
 	{ .id = CS8409_CYBORG, .name = "cyborg" },
 	{ .id = CS8409_DOLPHIN, .name = "dolphin" },
 	{}
@@ -542,6 +559,18 @@ const struct hda_fixup cs8409_fixups[] = {
 		.chained = true,
 		.chain_id = CS8409_FIXUPS,
 	},
+	[CS8409_WARLOCK_MLK] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cs8409_cs42l42_pincfgs,
+		.chained = true,
+		.chain_id = CS8409_FIXUPS,
+	},
+	[CS8409_WARLOCK_MLK_DUAL_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cs8409_cs42l42_pincfgs,
+		.chained = true,
+		.chain_id = CS8409_FIXUPS,
+	},
 	[CS8409_CYBORG] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cs8409_cs42l42_pincfgs,
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 163ff3b3092a..85da4a5e84a8 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -912,9 +912,15 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 			cs8409_vendor_coef_set(codec, seq_bullseye->cir, seq_bullseye->coeff);
 	}
 
-	/* DMIC1_MO=00b, DMIC1/2_SR=1 */
-	if (codec->fixup_id == CS8409_CYBORG)
-		cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
+	switch (codec->fixup_id) {
+		case CS8409_CYBORG:
+		case CS8409_WARLOCK_MLK_DUAL_MIC:
+			/* DMIC1_MO=00b, DMIC1/2_SR=1 */
+			cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
+			break;
+		default:
+			break;
+	}
 
 	cs42l42_resume(cs42l42);
 
@@ -1008,6 +1014,11 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
 				CS42L42_FULL_SCALE_VOL_MINUS6DB;
 			break;
+		case CS8409_WARLOCK_MLK:
+		case CS8409_WARLOCK_MLK_DUAL_MIC:
+			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
+			spec->scodecs[CS8409_CODEC0]->full_scale_vol = CS42L42_FULL_SCALE_VOL_0DB;
+			break;
 		default:
 			spec->scodecs[CS8409_CODEC0]->hsbias_hiz = 0x0020;
 			spec->scodecs[CS8409_CODEC0]->full_scale_vol =
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 8e846f292cd0..7df46bd8d2da 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -267,6 +267,8 @@ enum cs8409_coefficient_index_registers {
 enum {
 	CS8409_BULLSEYE,
 	CS8409_WARLOCK,
+	CS8409_WARLOCK_MLK,
+	CS8409_WARLOCK_MLK_DUAL_MIC,
 	CS8409_CYBORG,
 	CS8409_FIXUPS,
 	CS8409_DOLPHIN,
-- 
2.25.1

