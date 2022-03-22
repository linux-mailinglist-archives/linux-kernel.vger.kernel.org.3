Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB924E42C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiCVPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbiCVPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:20:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9085C364;
        Tue, 22 Mar 2022 08:18:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MAwx9B011964;
        Tue, 22 Mar 2022 10:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tHvVnOC+9G3Hu8w41fGXZGEdPqMVugcJ/G91GRLrkXY=;
 b=SvPRSWuYHQpP9npmFzheYnkctA02eq+3BCyx7QkskipsYHF8Kl20Dzrtc+HXDehXlaCy
 D1Zgv5llKXogj5FiFT8I6yUW9f4xHiUqZ2Vqny3o/wXW+LkaPTkd9JX4zeqkBlmacjsL
 S8zzR+SEGjINonkVeCDel9xL+4x1bay31cYTeRNGRaXHN/z7ODlIjhOCE0vJ4Qogxaq6
 7uVT55dabAy82CDScRkpfslhWKNKjmXd+QncOQuJSD1QvQ77DHmCgFKOTDL4Tktj3G7V
 lyTF4GEHKFz4zipe5EyI5hH3F1rNJ/GVcU7Fg8ZVGLOv0BunvejRdph68BN9gA77HViT cQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ewck1cb46-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Mar 2022 10:18:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Mar
 2022 15:18:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 22 Mar 2022 15:18:33 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2497D459;
        Tue, 22 Mar 2022 15:18:33 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v5 07/16] ALSA: hda: cs35l41: Put the device into safe mode for external boost
Date:   Tue, 22 Mar 2022 15:18:10 +0000
Message-ID: <20220322151819.4299-8-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
References: <20220322151819.4299-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zRUdwvcQUOnfIaqCzsYms0LSjt7eejmy
X-Proofpoint-GUID: zRUdwvcQUOnfIaqCzsYms0LSjt7eejmy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate the configuration of external boost devices, put all
devices, with or without VSPK switch, into safe mode from the start.
That allows the following parts of the driver to handle all external
boost devices in the same way.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 0dac622805c4..46e920ec3000 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -109,8 +109,6 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
 };
 
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
-	.probe		= cs35l41_reset_to_safe,
-	.num_probe	= ARRAY_SIZE(cs35l41_reset_to_safe),
 	.prepare	= cs35l41_safe_to_active,
 	.num_prepare	= ARRAY_SIZE(cs35l41_safe_to_active),
 	.cleanup	= cs35l41_active_to_safe,
@@ -224,10 +222,15 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 			return ret;
 		break;
 	case CS35L41_EXT_BOOST:
-		cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
-		break;
 	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
-		cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
+		if (hw_cfg->bst_type == CS35L41_EXT_BOOST)
+			cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
+		else
+			cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
+		ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_safe,
+					     ARRAY_SIZE(cs35l41_reset_to_safe));
+		if (ret)
+			return ret;
 		break;
 	default:
 		dev_err(cs35l41->dev, "Boost type %d not supported\n", hw_cfg->bst_type);
-- 
2.35.1

