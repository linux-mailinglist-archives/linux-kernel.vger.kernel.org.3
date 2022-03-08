Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C24D1E65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348753AbiCHRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348744AbiCHRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:18:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36071BE8E;
        Tue,  8 Mar 2022 09:18:00 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228FxtbW015166;
        Tue, 8 Mar 2022 11:17:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=IsxmqqwZg/HZPXMqd6bzsxFBB97JAt5kfaKVBxnlXNw=;
 b=Xy4k8/U9wxbeYBYLAJIkLAynztbpaI750XIQhOTGBizAwdgXLUC5mVYgcszWVPI7nIuZ
 gIxV4776G6DkSgyB+JFpgbxEF4AYy0slkL/wzBTLVG5L3DBdd6ORMFCcZlgcIq4TTaAl
 YvuFPNFKguoALhsnKxrhlyKAhSYUXQLQ6KFR4wjYCAsxWL59LpRyNxnPt7Vm1nraKF/c
 /HDldbIzw2rZMSVhSGkbI2LNKfkWIfln4PQNGOXfRM6gPOQXfBYLGKSfdvj0jjp2qgZt
 liJh2alkLZ3vh+UCsOJ8I9PYHicHe8weXIyCDr41n8005ETXMQ3pcZi0eYAk+wscMRfm Mg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3em55svhnr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Mar 2022 11:17:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 17:17:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Mar 2022 17:17:35 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 858D9B1A;
        Tue,  8 Mar 2022 17:17:35 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 12/16] ALSA: hda: cs35l41: Reorganize log for playback actions
Date:   Tue, 8 Mar 2022 17:17:26 +0000
Message-ID: <20220308171730.454587-13-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eK-JxT82pWHC64CeSqEHd5DrSY38tz-8
X-Proofpoint-GUID: eK-JxT82pWHC64CeSqEHd5DrSY38tz-8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each case, only log the last regmap access, so it doesn't get
overwritten, and as all regmap access should show the same issues
logging the last one should be enough.
Change to dev_err to log this error.

Also, differentiate between a regmap access failure and invalid
playback action.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 08ce9b8005ec..fda4af323c32 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -144,10 +144,9 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
-		ret = regmap_multi_reg_write(reg, cs35l41_hda_config,
-					     ARRAY_SIZE(cs35l41_hda_config));
-		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
-				   CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
+		regmap_multi_reg_write(reg, cs35l41_hda_config, ARRAY_SIZE(cs35l41_hda_config));
+		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
+					 CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		ret = cs35l41_hda_global_enable(cs35l41, 1);
@@ -157,16 +156,16 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		ret = cs35l41_hda_global_enable(cs35l41, 0);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
-		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
-				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
+		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
+					 CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		break;
 	default:
-		ret = -EINVAL;
+		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
 		break;
 	}
 
 	if (ret)
-		dev_warn(cs35l41->dev, "Failed to apply multi reg write: %d\n", ret);
+		dev_err(cs35l41->dev, "Regmap access fail: %d\n", ret);
 }
 
 static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsigned int *tx_slot,
-- 
2.35.1

