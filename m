Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFE4CD72E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiCDPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiCDPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:08:30 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D041635;
        Fri,  4 Mar 2022 07:07:41 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2hJ013723;
        Fri, 4 Mar 2022 09:07:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=jPt/cfXYkcSIdY91R4XLOOF/Ab/YvNIlCw06bl45M0w=;
 b=S54ucqtkvSio2PNR/zfTL0kI9hMtK/XRJHdFEGfG2jnZTO18CCToOE+aqHfeXV0KtCiZ
 1T4udIZorNqV1Y7ZrHTUFzj3aOsjGsavOTdSc6LNTnVVABzM5yxWDLp0VmqvVzJX076Z
 Dst+Pzc6e/NaMrYZdVYtynz/sbo+zM5q5UMFkWaX3mADqHZ+aGvk9A3RycysY7kBlOBG
 Sp8FHkQxoWt4DykVM+U1Lz/UXtHlgLOyZIncF9G3rk4DhUp+iySvVnTaNAM9tUhBDXpM
 vnps+R4Ap0FEibj+ADOgbZldot2EHg5cWAAiPqsse6+PWx9uYD7mcr1IYwMbE03RSOnp cQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h414-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:30 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:27 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 79C6A11D1;
        Fri,  4 Mar 2022 15:07:27 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 11/20] hda: cs35l41: Put the device into safe mode for external boost
Date:   Fri, 4 Mar 2022 15:07:12 +0000
Message-ID: <20220304150721.3802-12-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: z4yCgEpUNYltcpj7-f0JCEPAVdJh3LFw
X-Proofpoint-ORIG-GUID: z4yCgEpUNYltcpj7-f0JCEPAVdJh3LFw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All external boost setups should be put into safe mode.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 17660ce71f93..3b9515ed871d 100644
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

