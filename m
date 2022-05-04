Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBC51A511
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353150AbiEDQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353141AbiEDQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:17:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975427B39
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:13:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2444eM0Y022668;
        Wed, 4 May 2022 11:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=ZKCB6dSDdWjC7uNzTek+77/fO8XVZ1uO6IiRscjYf3U=;
 b=j7TknbmATv8vFwdGvxn+iWDnMd3HYxRoUcW1mfh9c94Eoaf9yJVUE1j1BY9+voAVow41
 mH/k1c4eHz1X50o/vRzmK8DW6XPs/DM4TZjwPVIY79rV1K1gGM8TMG+D4RQqtZfZTpbZ
 N8l7uG3Nyr9ne0TgWgEVHMdLUS3b0GJ6xvbWBnbUw6ROrkOWJ06yTWfZnw684uY9xCXX
 nMAZPZHAM+DsxF9qkcWPPseBefy0Lx7QEBofKNYV3ff1u41DBZNuKB1UxOPvQkpdDcgl
 4t7wf2LuiHk7qGKcv9OYRpSzD9QFd7sctQOKBSIjhEoWO5ti+MZkeUqlOM0OBk+UJ4Qq +Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fs1hpcvrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 May 2022 11:12:49 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 17:12:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 4 May 2022 17:12:47 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.73])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BD11459;
        Wed,  4 May 2022 16:12:47 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 3/3] ALSA: hda/cs8409: Support manual mode detection for CS42L42
Date:   Wed, 4 May 2022 17:12:36 +0100
Message-ID: <20220504161236.2490532-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504161236.2490532-1-sbinding@opensource.cirrus.com>
References: <20220504161236.2490532-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tlrDwmQre3IaKaL4Hvk0FhU5ZMIdF7jb
X-Proofpoint-GUID: tlrDwmQre3IaKaL4Hvk0FhU5ZMIdF7jb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Jack detection on CS42L42, detection is normally done using
"auto" mode, which automatically detects what type of jack is
connected to the device. However, some headsets are not
automatically detected, and as such and alternative detection
method "manual mode" can be used to detect these headsets.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c |   3 -
 sound/pci/hda/patch_cs8409.c        | 159 +++++++++++++++++++++++-----
 sound/pci/hda/patch_cs8409.h        |   1 -
 3 files changed, 132 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index a7ee489e6aec..0d11b24a1317 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -252,7 +252,6 @@ struct sub_codec cs8409_cs42l42_codec = {
 	.init_seq_num = ARRAY_SIZE(cs42l42_init_reg_seq),
 	.hp_jack_in = 0,
 	.mic_jack_in = 0,
-	.force_status_change = 1,
 	.paged = 1,
 	.suspended = 1,
 	.no_type_dect = 0,
@@ -444,7 +443,6 @@ struct sub_codec dolphin_cs42l42_0 = {
 	.init_seq_num = ARRAY_SIZE(dolphin_c0_init_reg_seq),
 	.hp_jack_in = 0,
 	.mic_jack_in = 0,
-	.force_status_change = 1,
 	.paged = 1,
 	.suspended = 1,
 	.no_type_dect = 0,
@@ -458,7 +456,6 @@ struct sub_codec dolphin_cs42l42_1 = {
 	.init_seq_num = ARRAY_SIZE(dolphin_c1_init_reg_seq),
 	.hp_jack_in = 0,
 	.mic_jack_in = 0,
-	.force_status_change = 1,
 	.paged = 1,
 	.suspended = 1,
 	.no_type_dect = 1,
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index d35d124bf3dc..c3a8b04c71d8 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -634,38 +634,128 @@ static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2, 0xc0);
 }
 
-static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
+static int cs42l42_manual_hs_det(struct sub_codec *cs42l42)
 {
-	int status_changed = cs42l42->force_status_change;
+	unsigned int hs_det_status;
+	unsigned int hs_det_comp1;
+	unsigned int hs_det_comp2;
+	unsigned int hs_det_sw;
+	unsigned int hs_type;
+
+	/* Set hs detect to manual, active mode */
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2,
+			 (1 << CS42L42_HSDET_CTRL_SHIFT) |
+			 (0 << CS42L42_HSDET_SET_SHIFT) |
+			 (0 << CS42L42_HSBIAS_REF_SHIFT) |
+			 (0 << CS42L42_HSDET_AUTO_TIME_SHIFT));
+
+	/* Configure HS DET comparator reference levels. */
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL1,
+			 (CS42L42_HSDET_COMP1_LVL_VAL << CS42L42_HSDET_COMP1_LVL_SHIFT) |
+			 (CS42L42_HSDET_COMP2_LVL_VAL << CS42L42_HSDET_COMP2_LVL_SHIFT));
+
+	/* Open the SW_HSB_HS3 switch and close SW_HSB_HS4 for a Type 1 headset. */
+	cs8409_i2c_write(cs42l42, CS42L42_HS_SWITCH_CTL, CS42L42_HSDET_SW_COMP1);
+
+	msleep(100);
+
+	hs_det_status = cs8409_i2c_read(cs42l42, CS42L42_HS_DET_STATUS);
+
+	hs_det_comp1 = (hs_det_status & CS42L42_HSDET_COMP1_OUT_MASK) >>
+			CS42L42_HSDET_COMP1_OUT_SHIFT;
+	hs_det_comp2 = (hs_det_status & CS42L42_HSDET_COMP2_OUT_MASK) >>
+			CS42L42_HSDET_COMP2_OUT_SHIFT;
+
+	/* Close the SW_HSB_HS3 switch for a Type 2 headset. */
+	cs8409_i2c_write(cs42l42, CS42L42_HS_SWITCH_CTL, CS42L42_HSDET_SW_COMP2);
 
-	cs42l42->force_status_change = 0;
+	msleep(100);
+
+	hs_det_status = cs8409_i2c_read(cs42l42, CS42L42_HS_DET_STATUS);
+
+	hs_det_comp1 |= ((hs_det_status & CS42L42_HSDET_COMP1_OUT_MASK) >>
+			CS42L42_HSDET_COMP1_OUT_SHIFT) << 1;
+	hs_det_comp2 |= ((hs_det_status & CS42L42_HSDET_COMP2_OUT_MASK) >>
+			CS42L42_HSDET_COMP2_OUT_SHIFT) << 1;
+
+	/* Use Comparator 1 with 1.25V Threshold. */
+	switch (hs_det_comp1) {
+	case CS42L42_HSDET_COMP_TYPE1:
+		hs_type = CS42L42_PLUG_CTIA;
+		hs_det_sw = CS42L42_HSDET_SW_TYPE1;
+		break;
+	case CS42L42_HSDET_COMP_TYPE2:
+		hs_type = CS42L42_PLUG_OMTP;
+		hs_det_sw = CS42L42_HSDET_SW_TYPE2;
+		break;
+	default:
+		/* Fallback to Comparator 2 with 1.75V Threshold. */
+		switch (hs_det_comp2) {
+		case CS42L42_HSDET_COMP_TYPE1:
+			hs_type = CS42L42_PLUG_CTIA;
+			hs_det_sw = CS42L42_HSDET_SW_TYPE1;
+			break;
+		case CS42L42_HSDET_COMP_TYPE2:
+			hs_type = CS42L42_PLUG_OMTP;
+			hs_det_sw = CS42L42_HSDET_SW_TYPE2;
+			break;
+		case CS42L42_HSDET_COMP_TYPE3:
+			hs_type = CS42L42_PLUG_HEADPHONE;
+			hs_det_sw = CS42L42_HSDET_SW_TYPE3;
+			break;
+		default:
+			hs_type = CS42L42_PLUG_INVALID;
+			hs_det_sw = CS42L42_HSDET_SW_TYPE4;
+			break;
+		}
+	}
+
+	/* Set Switches */
+	cs8409_i2c_write(cs42l42, CS42L42_HS_SWITCH_CTL, hs_det_sw);
+
+	/* Set HSDET mode to Manual—Disabled */
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2,
+			 (0 << CS42L42_HSDET_CTRL_SHIFT) |
+			 (0 << CS42L42_HSDET_SET_SHIFT) |
+			 (0 << CS42L42_HSBIAS_REF_SHIFT) |
+			 (0 << CS42L42_HSDET_AUTO_TIME_SHIFT));
+
+	/* Configure HS DET comparator reference levels. */
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL1,
+			 (CS42L42_HSDET_COMP1_LVL_DEFAULT << CS42L42_HSDET_COMP1_LVL_SHIFT) |
+			 (CS42L42_HSDET_COMP2_LVL_DEFAULT << CS42L42_HSDET_COMP2_LVL_SHIFT));
+
+	return hs_type;
+}
+
+static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
+{
+	int status_changed = 0;
 
 	/* TIP_SENSE INSERT/REMOVE */
 	switch (reg_ts_status) {
 	case CS42L42_TS_PLUG:
-		if (!cs42l42->hp_jack_in) {
-			if (cs42l42->no_type_dect) {
-				status_changed = 1;
-				cs42l42->hp_jack_in = 1;
-				cs42l42->mic_jack_in = 0;
-			} else {
-				cs42l42_run_jack_detect(cs42l42);
-			}
+		if (cs42l42->no_type_dect) {
+			status_changed = 1;
+			cs42l42->hp_jack_in = 1;
+			cs42l42->mic_jack_in = 0;
+		} else {
+			cs42l42_run_jack_detect(cs42l42);
 		}
 		break;
 
 	case CS42L42_TS_UNPLUG:
-		if (cs42l42->hp_jack_in || cs42l42->mic_jack_in) {
-			status_changed = 1;
-			cs42l42->hp_jack_in = 0;
-			cs42l42->mic_jack_in = 0;
-		}
+		status_changed = 1;
+		cs42l42->hp_jack_in = 0;
+		cs42l42->mic_jack_in = 0;
 		break;
 	default:
 		/* jack in transition */
 		break;
 	}
 
+	codec_dbg(cs42l42->codec, "Tip Sense Detection: (%d)\n", reg_ts_status);
+
 	return status_changed;
 }
 
@@ -698,24 +788,40 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 
 		type = (reg_hs_status & CS42L42_HSDET_TYPE_MASK) >> CS42L42_HSDET_TYPE_SHIFT;
 
+		/* Configure the HSDET mode. */
+		cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2, 0x80);
+
 		if (cs42l42->no_type_dect) {
 			status_changed = cs42l42_handle_tip_sense(cs42l42, current_plug_status);
-		} else if (type == CS42L42_PLUG_INVALID) {
-			/* Type CS42L42_PLUG_INVALID not supported	*/
-			status_changed = cs42l42_handle_tip_sense(cs42l42, CS42L42_TS_UNPLUG);
 		} else {
-			if (!cs42l42->hp_jack_in) {
-				status_changed = 1;
-				cs42l42->hp_jack_in = 1;
+			if (type == CS42L42_PLUG_INVALID || type == CS42L42_PLUG_HEADPHONE) {
+				codec_dbg(cs42l42->codec,
+					  "Auto detect value not valid (%d), running manual det\n",
+					  type);
+				type = cs42l42_manual_hs_det(cs42l42);
 			}
-			/* type = CS42L42_PLUG_HEADPHONE has no mic */
-			if ((!cs42l42->mic_jack_in) && (type != CS42L42_PLUG_HEADPHONE)) {
+
+			switch (type) {
+			case CS42L42_PLUG_CTIA:
+			case CS42L42_PLUG_OMTP:
 				status_changed = 1;
+				cs42l42->hp_jack_in = 1;
 				cs42l42->mic_jack_in = 1;
+				break;
+			case CS42L42_PLUG_HEADPHONE:
+				status_changed = 1;
+				cs42l42->hp_jack_in = 1;
+				cs42l42->mic_jack_in = 0;
+				break;
+			default:
+				status_changed = 1;
+				cs42l42->hp_jack_in = 0;
+				cs42l42->mic_jack_in = 0;
+				break;
 			}
+			codec_dbg(cs42l42->codec, "Detection done (%d)\n", type);
 		}
-		/* Configure the HSDET mode. */
-		cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2, 0x80);
+
 		/* Enable the HPOUT ground clamp and configure the HP pull-down */
 		cs8409_i2c_write(cs42l42, CS42L42_DAC_CTL2, 0x02);
 		/* Re-Enable Tip Sense Interrupt */
@@ -803,7 +909,6 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 	cs42l42->last_page = 0;
 	cs42l42->hp_jack_in = 0;
 	cs42l42->mic_jack_in = 0;
-	cs42l42->force_status_change = 1;
 
 	/* Put CS42L42 into Reset */
 	gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 988259f8a940..ebf473a3f109 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -304,7 +304,6 @@ struct sub_codec {
 
 	unsigned int hp_jack_in:1;
 	unsigned int mic_jack_in:1;
-	unsigned int force_status_change:1;
 	unsigned int suspended:1;
 	unsigned int paged:1;
 	unsigned int last_page;
-- 
2.25.1

