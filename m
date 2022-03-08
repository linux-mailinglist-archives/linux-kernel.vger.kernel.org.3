Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4704D1E76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbiCHRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348907AbiCHRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F5454190;
        Tue,  8 Mar 2022 09:18:49 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228FxhGZ010224;
        Tue, 8 Mar 2022 11:17:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=A0hkLIWNLLqXGjOzH0Bif6CIq15QUspFH3l5KIu/XHc=;
 b=mXnDFOqcZICB5Scmgtka5ZSPL5DNGXre9PRY9S9hxM6YSii7Rl1JsdMhBFY2gUo60mDp
 xmwaG3SFx8zl1cxDCxkVZkjW4BlRJo4qYRE7+hP2Kd32vObqL7Tq7BWFIe4wCmuhWiXt
 7Bh3AQDtd/FmS08LRFeFMlMQwji49UqeGEh2joztM0LAFfZDTvsMN7Qy4vAiRBhkl3U7
 U1Dhk0q70orBGFYszwUZSVypNiaM/gRAoQURJJCRdqrJ5m+6uoBNeeGu94knYX6kVSUc
 +hhhMM12RJFL3ZfWNMOmNE89Cwxkz/Mx3eepTSrMbcplUZ6vdppQj0jtR1ttngKDL5bp 5w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656mh5v-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Mar 2022 11:17:46 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 17:17:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Mar 2022 17:17:35 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D2F70B1A;
        Tue,  8 Mar 2022 17:17:34 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 10/16] ALSA: hda: cs35l41: Move boost config to initialization code
Date:   Tue, 8 Mar 2022 17:17:24 +0000
Message-ID: <20220308171730.454587-11-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MEFgZOISOp05WzZQ2JeSIAu4g_uQ7Bca
X-Proofpoint-GUID: MEFgZOISOp05WzZQ2JeSIAu4g_uQ7Bca
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having CS35L41_PWR_CTRL2 on cs35l41_hda_config overwrites the boost
configuration for internal boost.
So move it to the initialization part and use regmap_update_bits to
only change the correct bits.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h     |  1 +
 sound/pci/hda/cs35l41_hda.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index fbf38f32e36d..a8537bccedcf 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -661,6 +661,7 @@
 #define CS35L41_GLOBAL_EN_SHIFT		0
 #define CS35L41_BST_EN_MASK		0x0030
 #define CS35L41_BST_EN_SHIFT		4
+#define CS35L41_BST_DIS_FET_OFF		0x00
 #define CS35L41_BST_EN_DEFAULT		0x2
 #define CS35L41_AMP_EN_SHIFT		0
 #define CS35L41_AMP_EN_MASK		1
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index b3cc7db3fc42..3b8167d1ccc1 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -25,7 +25,6 @@ static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, // DACPCM1_SRC = ASPRX1
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
-	{ CS35L41_PWR_CTRL2,		0x00000001 }, // AMP_EN = 1
 };
 
 static const struct reg_sequence cs35l41_hda_mute[] = {
@@ -34,7 +33,6 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 };
 
 static const struct reg_sequence cs35l41_hda_start_bst[] = {
-	{ CS35L41_PWR_CTRL2,		0x00000021 }, // BST_EN = 10, AMP_EN = 1
 	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
 };
 
@@ -94,7 +92,6 @@ static const struct reg_sequence cs35l41_active_to_safe[] = {
 	{ 0x00000040,			0x00000055 },
 	{ 0x00000040,			0x000000AA },
 	{ 0x00007438,			0x00585941 },
-	{ CS35L41_PWR_CTRL2,		0x00000000 }, // AMP_EN = 0
 	{ CS35L41_PWR_CTRL1,		0x00000000 },
 	{ 0x0000742C,			0x00000009, 2000 },
 	{ 0x00007438,			0x00580941 },
@@ -144,6 +141,8 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 	case HDA_GEN_PCM_ACT_OPEN:
 		ret = regmap_multi_reg_write(reg, cs35l41_hda_config,
 					     ARRAY_SIZE(cs35l41_hda_config));
+		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
+				   CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		if (reg_seq->prepare)
@@ -155,6 +154,8 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 			ret = regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
+		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
+				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (reg_seq->close)
 			ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
 		break;
@@ -232,8 +233,10 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 			cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
 		else
 			cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
-		ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_safe,
-					     ARRAY_SIZE(cs35l41_reset_to_safe));
+		regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_safe,
+				       ARRAY_SIZE(cs35l41_reset_to_safe));
+		ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
+					  CS35L41_BST_DIS_FET_OFF << CS35L41_BST_EN_SHIFT);
 		if (ret)
 			return ret;
 		break;
-- 
2.35.1

