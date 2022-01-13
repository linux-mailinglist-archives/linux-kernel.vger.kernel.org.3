Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6B48DC99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiAMRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:07:48 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39700 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbiAMRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:07:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DGAZTT021018;
        Thu, 13 Jan 2022 11:07:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=GAtWy8saaDNASzmwjnxbbHFXnbph2X6H4i7d21Nd0To=;
 b=Yl7eXDWTsM0tyE6HEu9Qtjq5aeCWNDRFwCbvxfV7csilDIwxbVGnYeDxEU7AIANVh6wH
 O3gGEvSI7YM41WQg9jjZUL6BKBordycLCvk1ZH/DabTKVe3mCDcHYW5pG0q0xoDzo1hi
 fC0sMaJR9fwGwRDIM1r/oLRQ4OUMlp3qP24vI2zKmauCZAmQ53RtKvrul0GA9Mnwsuly
 xZYhgywYd/3vDFQer+umv26oL+gW9NikHTjLbR1XNk/jvV7oBjmGjrK6TWnPKz3K9Mo4
 Ml5m2pfdDEtMoP31NXM7nhH6iTKp6//BdbtsUWyNWV81o6iablExnIM+zSSlisojQbHI PQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3djqcb026x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Jan 2022 11:07:32 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 13 Jan
 2022 17:07:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 13 Jan 2022 17:07:30 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.50])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C59EBB13;
        Thu, 13 Jan 2022 17:07:29 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 1/5] ALSA: hda: cs35l41: Avoid overwriting register patch
Date:   Thu, 13 Jan 2022 17:07:24 +0000
Message-ID: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dvxRVehPXollWW0CaTnrYuaYFoaHuRMI
X-Proofpoint-ORIG-GUID: dvxRVehPXollWW0CaTnrYuaYFoaHuRMI
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

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
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

