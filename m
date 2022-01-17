Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAB490C17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbiAQQIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:08:51 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:25470 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240728AbiAQQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:08:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HFFYHA025138;
        Mon, 17 Jan 2022 10:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=KUv7ngvVuTUvfvAzKJH6kDlqhmw0mCvg7E2LNqztcsg=;
 b=aH9gWWxrwrp06o1iVySEwmvNsSTgYwG3Ih6PrPl5mQK2OtTIVgSJFBtnMcZPvx00KLEn
 lRu8ZMc5ZG30X8sOOqm8/9U/SpXt5iqCalnGKyCWQPLtnQo4aqDOF/Zv34oBSfhjynjB
 nUfSTmghIHhMDnPaEJyI8mFgtQ4C0a2X07Mi1Ce7mo/Ed5eji2bJuDbRWPGdnh+1/mw3
 oT97g+6BEWL/ncFLmgaI4RmRAKspU393prnqPwJbN7MAJl1K6iKvA2OSJvkZ5Zmenx/y
 BvLKRy8mDHfj81LDZBm/Ew4d25Hg9VBjxWNsHMQfMTsJB52T1XMr0HjyT4CF1mysj8hl mQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhr22c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 10:08:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 16:08:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 16:08:32 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D679E459;
        Mon, 17 Jan 2022 16:08:31 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 1/6] ALSA: hda: cs35l41: Avoid overwriting register patch
Date:   Mon, 17 Jan 2022 16:08:25 +0000
Message-ID: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZQoJ3bLYtcWhv2KkilNAPdRESf1c6SdB
X-Proofpoint-ORIG-GUID: ZQoJ3bLYtcWhv2KkilNAPdRESf1c6SdB
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

regmap_register_patch can't be used to apply the probe sequence as a
patch is already registers with the regmap by
cs35l41_register_errata_patch and only a single patch can be attached to
a single regmap. The driver doesn't currently rely on a cache sync to
re-apply this probe sequence so simply switch it to a multi write.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

V2: Add Fixes tag

---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 30b40d865863..c47c5f0b4e59 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -480,7 +480,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	acpi_hw_cfg = NULL;
 
 	if (cs35l41->reg_seq->probe) {
-		ret = regmap_register_patch(cs35l41->regmap, cs35l41->reg_seq->probe,
+		ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41->reg_seq->probe,
 					    cs35l41->reg_seq->num_probe);
 		if (ret) {
 			dev_err(cs35l41->dev, "Fail to apply probe reg patch: %d\n", ret);
-- 
2.34.1

