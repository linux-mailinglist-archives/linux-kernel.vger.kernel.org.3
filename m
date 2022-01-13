Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A292148DCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiAMRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:07:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45760 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233652AbiAMRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:07:48 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DGAV40020998;
        Thu, 13 Jan 2022 11:07:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=HI6bEErhvsZPIb7ephN7Y9393a6abI1s2gAyNDkJZXY=;
 b=AAVok25Aem42bor/3GPosb7Owzp05/4x22OYdTpKbVqaekymMPC8ll7a1A6cixEwXajk
 qv4UgpFBP9DFZf7As1F3IWVuW/o5aHTun4o65BEoExgZE6KJ+EzbjHRqYJ7jGG4FRdf2
 tThu54E6vm6fow7jR9DGB6WkfDodYjl1vxfl16RV/hlfsHZa1tyKQVb+cXOhM44hydKY
 0VtgMgwrB8jLHv8MdJaOZ33HKnUDViKK/KgmzkF6LCDWaE0Yg7Z65L6IBjvEq7GCdpoe
 e00jgNgK6vVtA8EZSRAD1+ghvWmpfdvej6+kP/wiwmZemhJ4fXmPr1nCDYddu+6GOiLf Bg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3djqcb026y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Jan 2022 11:07:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 13 Jan
 2022 17:07:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 13 Jan 2022 17:07:31 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.50])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C7E87B0E;
        Thu, 13 Jan 2022 17:07:30 +0000 (UTC)
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
Subject: [PATCH 2/5] ALSA: hda: cs35l41: Add calls to newly added test key function
Date:   Thu, 13 Jan 2022 17:07:25 +0000
Message-ID: <20220113170728.1953559-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pmEixx5NJrqnbqps-fMLCBxpSSPyDnrM
X-Proofpoint-ORIG-GUID: pmEixx5NJrqnbqps-fMLCBxpSSPyDnrM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

The test key now needs to be manually held when calling
cs35l41_register_errata_patch, after patch:

'commit f517ba4924ad ("ASoC: cs35l41: Add support for
hibernate memory retention mode")'

Add the missing function calls to this driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
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

