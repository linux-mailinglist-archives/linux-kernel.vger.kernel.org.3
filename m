Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538E7490C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbiAQQJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:09:27 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46830 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235180AbiAQQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:23 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20HFFYHC025138;
        Mon, 17 Jan 2022 10:08:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=bl5u1NTQ5L1xVZfZHeopeNSvmI7iSBTqrV2EHIRtC04=;
 b=ABYlKoOylzmVdR60EJP8p8eXcFV4koeulRwpGDUtSRp3edJ3h5Nkv7TF9n7dsFmfaidQ
 3B/JYwppuhGlNN/71Le3Ov6yWNJxKtqPznrIq0TV3UDyBdFzLtZY5DMnCsJ15ka/nIVA
 acd0NW1nL2Y5sCtwP8AY+Yl3inVYu3uKwIZSwH2xF5147LCd2DL7UvbA3vjav1uNZSdE
 QLW4nhaRJU/k8m7Nn5LcGP4jy09l+kOlIRkFFa8BCsP0AsCC9skeEF26Zf3K+hZWqeTY
 EbOFgPKJBxKRiP+KXnlMctHCdvBYmJxONNcUYY7SDKL8rBMhkTBXolJalCudwWGwy7d6 2A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dnaxhr22c-2
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 30A6646C;
        Mon, 17 Jan 2022 16:08:32 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 2/6] ALSA: hda: cs35l41: Add calls to newly added test key function
Date:   Mon, 17 Jan 2022 16:08:26 +0000
Message-ID: <20220117160830.709403-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
References: <20220117160830.709403-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ppEl2H72LnyX2_9CGX-V0GQJPYmIQdqP
X-Proofpoint-ORIG-GUID: ppEl2H72LnyX2_9CGX-V0GQJPYmIQdqP
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

The test key now needs to be manually held when calling
cs35l41_register_errata_patch, after patch:

Add the missing function calls to this driver.

Fixes: f517ba4924ad ("ASoC: cs35l41: Add support for hibernate memory retention mode")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

V2: Add Fixes tag

---
 sound/pci/hda/cs35l41_hda.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index c47c5f0b4e59..509a380f9be7 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -463,6 +463,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		goto err;
 	}
 
+	ret = cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
+	if (ret)
+		goto err;
+
 	ret = cs35l41_register_errata_patch(cs35l41->dev, cs35l41->regmap, reg_revid);
 	if (ret)
 		goto err;
@@ -473,6 +477,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		goto err;
 	}
 
+	ret = cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
+	if (ret)
+		goto err;
+
 	ret = cs35l41_hda_apply_properties(cs35l41, acpi_hw_cfg);
 	if (ret)
 		goto err;
-- 
2.34.1

