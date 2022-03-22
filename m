Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19574E42AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiCVPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiCVPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:20:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA385AEF0;
        Tue, 22 Mar 2022 08:18:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MCnUfD013136;
        Tue, 22 Mar 2022 10:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=iIsMAubiZN9gs6M2Z3vJ8JRx40Az9eiqwNpvIPkWq/o=;
 b=NPmrdtqqD9QZ3cGqm4Pfyqo8aEPYluUZRMaWgAgTTPwTk9NIhdH48P8/0qndVETSXWVb
 mdu95ZtAPlRqRnO7RUwQwGpEdNNPn/jODAHFayNMu56pFLJakgsOWrwGDowpXaevppph
 FVJAItSXZ90frYuxyOT19Gs8x7TeQN6cL5Zbbe9cpnP7zSlNcRaVc26FyNMOZStVkxhv
 msbjntI09nTVfJzX8SlVj+zAv/BtfHQtKBb6hLBiXu52gg2efNYFWv+Hs+Z3FI8L1VwT
 MCERneZH1u1G6UgX6hPLAdW87PJ4+ymC44gUJvCYJ+2BnsQCtpv/OUmdRWWWHomSkonl 7w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ewbknc0jc-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Mar 2022 10:18:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Mar
 2022 15:18:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 22 Mar 2022 15:18:34 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D302477;
        Tue, 22 Mar 2022 15:18:34 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v5 10/16] ALSA: hda: cs35l41: Move boost config to initialization code
Date:   Tue, 22 Mar 2022 15:18:13 +0000
Message-ID: <20220322151819.4299-11-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
References: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dwDiMfXx9AKkRz5W8Ku1_r_Botrfev_v
X-Proofpoint-GUID: dwDiMfXx9AKkRz5W8Ku1_r_Botrfev_v
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
index 64d98cbd5c0e..7d892c97b1e8 100644
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
index 0709d09f4e13..6e82ab9517f0 100644
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

