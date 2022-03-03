Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6908E4CC3DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiCCRcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbiCCRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A519E70E;
        Thu,  3 Mar 2022 09:31:20 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223509T5013880;
        Thu, 3 Mar 2022 11:31:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=KzILZ0DlQ3n1e7FkjfZR9BxxG7sCrZbKRkYcy7tdB58=;
 b=VOFpw9RObwwF48t7qeRIgtenz6r53AIW0gSIPVdFBm/Ag36Hu+D76ZZ4qaE5uei08S4V
 eDyero1MhaPzr76hkZMWlFQfnaIU1IxdVAD9wL9kQ4sPL+KVdQddCf+i0HTazxTvmEBp
 D41JRpbVcNbwlCPOxBMotWuZ6uU/tUmn2D4c89gMCcTWhohdC3il/H00Qn91toX1yQGK
 VkBX3xJ2eZOWRmtiC7MXNiE2RZOc+jJ5qXrhPaSkkfrbVlbvhzlY5t4FR3S8AHqZqVi4
 cHacJjG4SERdXTopAi2k5h9esxvzJCb8sDBkSIxa4i0qxUv5r6KOFi+xrhZWVBEE0P/e rQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:05 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8E590B1A;
        Thu,  3 Mar 2022 17:31:05 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 09/20] hda: cs35l41: Always configure the DAI
Date:   Thu, 3 Mar 2022 17:30:48 +0000
Message-ID: <20220303173059.269657-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 92PGN3-hMMbwWKCw-7QVB46h_q_tXTnl
X-Proofpoint-GUID: 92PGN3-hMMbwWKCw-7QVB46h_q_tXTnl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dai configuration is always the same and
should always configured during open.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index fe6f6a208d29..4c99dcac2dd7 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -111,8 +111,6 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
 	.probe		= cs35l41_reset_to_safe,
 	.num_probe	= ARRAY_SIZE(cs35l41_reset_to_safe),
-	.open		= cs35l41_hda_config,
-	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
 	.prepare	= cs35l41_safe_to_active,
 	.num_prepare	= ARRAY_SIZE(cs35l41_safe_to_active),
 	.cleanup	= cs35l41_active_to_safe,
@@ -120,8 +118,6 @@ static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
 };
 
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_ext_bst = {
-	.open		= cs35l41_hda_config,
-	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
 	.prepare	= cs35l41_start_ext_vspk,
 	.num_prepare	= ARRAY_SIZE(cs35l41_start_ext_vspk),
 	.cleanup	= cs35l41_stop_ext_vspk,
@@ -129,8 +125,6 @@ static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_ext_bst = {
 };
 
 static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_int_bst = {
-	.open		= cs35l41_hda_config,
-	.num_open	= ARRAY_SIZE(cs35l41_hda_config),
 	.prepare	= cs35l41_hda_start_bst,
 	.num_prepare	= ARRAY_SIZE(cs35l41_hda_start_bst),
 	.cleanup	= cs35l41_hda_stop_bst,
@@ -146,8 +140,8 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
-		if (reg_seq->open)
-			ret = regmap_multi_reg_write(reg, reg_seq->open, reg_seq->num_open);
+		ret = regmap_multi_reg_write(reg, cs35l41_hda_config,
+					     ARRAY_SIZE(cs35l41_hda_config));
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		if (reg_seq->prepare)
-- 
2.35.1

