Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D470490C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiAQQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:09:22 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52932 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235180AbiAQQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:20 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HFFYHE025138;
        Mon, 17 Jan 2022 10:08:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NqFmW4aYe7NQ0YXxt5Fa5KfR4HPhf3lNiliwkux8kLk=;
 b=MIyIeJSIPljG+M2IbdnLf1NRVmvY+Fppn5obR5gFeVM4GqLenth/rBbMIY9plT4by2yh
 wuKi3mpNCw0/MwgEa99peYNjbpU5xaWq4PSgjjc+ubuAprgiQVcDngh4HLnBadNeZQQ9
 Y4cO+N0HIkC0akZHfypJqmHU6YgVRT5tgJ3+gh5yxZ6CifcigO79yBf3sTSLndPVHZis
 Ze2BX+XgzmxsXosD0lm7B+2OBc3njV5hgvcGfvK/hIUIGo6IetSYHGMOPT5kCO93RtF+
 U40YEIdWd11l8Aym1eX7E/Eu2N51L0thr1H1YfLSgKsoijFLloBnlSq9CjswfpMnSKFR qQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhr22c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 10:08:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 16:08:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 16:08:33 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CA24911D7;
        Mon, 17 Jan 2022 16:08:32 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 4/6] ALSA: hda: cs35l41: Add missing default cases
Date:   Mon, 17 Jan 2022 16:08:28 +0000
Message-ID: <20220117160830.709403-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
References: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nkTHCk8YUaqFAqyB5i0hANWIX6iRwZDA
X-Proofpoint-ORIG-GUID: nkTHCk8YUaqFAqyB5i0hANWIX6iRwZDA
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add switch default cases at gpio pins configs

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

V2: New patch with code split from Tidyup patch in this series

---
 sound/pci/hda/cs35l41_hda.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index c4f25e48dcc0..82f982f574a9 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -161,6 +161,9 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		if (reg_seq->close)
 			ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
 		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 	if (ret)
@@ -227,6 +230,8 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41,
 		internal_boost = true;
 
 	switch (hw_cfg->gpio1_func) {
+	case CS35L41_NOT_USED:
+		break;
 	case CS35l41_VSPK_SWITCH:
 		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
 				   CS35L41_GPIO1_CTRL_MASK, 1 << CS35L41_GPIO1_CTRL_SHIFT);
@@ -235,13 +240,21 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41,
 		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
 				   CS35L41_GPIO1_CTRL_MASK, 2 << CS35L41_GPIO1_CTRL_SHIFT);
 		break;
+	default:
+		dev_err(cs35l41->dev, "Invalid function %d for GPIO1\n", hw_cfg->gpio1_func);
+		return -EINVAL;
 	}
 
 	switch (hw_cfg->gpio2_func) {
+	case CS35L41_NOT_USED:
+		break;
 	case CS35L41_INTERRUPT:
 		regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
 				   CS35L41_GPIO2_CTRL_MASK, 2 << CS35L41_GPIO2_CTRL_SHIFT);
 		break;
+	default:
+		dev_err(cs35l41->dev, "Invalid function %d for GPIO2\n", hw_cfg->gpio2_func);
+		return -EINVAL;
 	}
 
 	if (internal_boost) {
-- 
2.34.1

