Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361094CC3F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiCCRdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiCCRcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928919E0A8;
        Thu,  3 Mar 2022 09:31:21 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AADx028599;
        Thu, 3 Mar 2022 11:31:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=EKex1J4UfS3p1wGhghJWpFbPklW0Awb7agShppedfn0=;
 b=AF60PGcioDtGScgyE/uT0lNiUloPzfK65dC7RAPAZx932aTq5kQQ4s9/KrlnKl3vdXpS
 SL+KjoJrbgFiRWmfzTeGQrLt7k18VGN1CICT2SG8PKE6GCva/wFK7amWfdL6N+3XQqDZ
 N+uSsHKL/GzIOekXGPAakHsWbO2w95WfuNgO9P6dWECyIR4+qs6+vtS3k4nYqD92V4nK
 tIZCpnoule3W6UYSiOOhHBVxlZrQoGLrNN+N1GXoSkj02S8/q/u930NKUEq6GTTtdMg0
 WUlrbOALVQljlLi9I0YWnKemR5/t/hziW6DsxerANGd9hCL9TmucVxEQGHgaJAQwvB/0 cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:09 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:07 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:07 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5841C7C;
        Thu,  3 Mar 2022 17:31:07 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 14/20] hda: cs35l41: Move boost config to initialization code
Date:   Thu, 3 Mar 2022 17:30:53 +0000
Message-ID: <20220303173059.269657-15-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZMMxzn5RVC8jfYPyNKpPZYLw5FVGTydq
X-Proofpoint-GUID: ZMMxzn5RVC8jfYPyNKpPZYLw5FVGTydq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boost configuration doesn't need to be written for
every new stream, so move it to the initialization code.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h     | 1 +
 sound/pci/hda/cs35l41_hda.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

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
index 75c5088cb224..90c833a25599 100644
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
@@ -234,6 +235,8 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 			cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
 		regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_safe,
 				       ARRAY_SIZE(cs35l41_reset_to_safe));
+		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
+				   CS35L41_BST_DIS_FET_OFF << CS35L41_BST_EN_SHIFT);
 		break;
 	default:
 		dev_err(cs35l41->dev, "Boost type %d not supported\n", hw_cfg->bst_type);
-- 
2.35.1

