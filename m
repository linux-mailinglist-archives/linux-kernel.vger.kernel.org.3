Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D975C47442C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhLNOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:00:41 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:17408 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232413AbhLNOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:00:31 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEAdVUN003487;
        Tue, 14 Dec 2021 08:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7XMGAbmDymTrSV2eBb46OndadsPp+ojG0fuidukm9ts=;
 b=p8v8JEHNrMYdWatTqNgYLf7h6joVzeLJKakcZE8dGeBKXQkggn8WAG6JzAOA/YogEuBk
 sgGSRP18NWoWBNq+uGvxc1gawFMg0syNslKNUCzEPtVW7svQC9Nfxwr/guhL1NiSBF0N
 G+h05RFutoQ/VBWAlIQ2ceEWIrvijneUOKHNkaAWO/nqTr8m+D2FEXM9mTVVNIrFqy6D
 dUI5xuEDqf9swg/c6ci6Xqir9Wf5iXlRIRgMOBrMDFJjtIh9NlaYtfs5AV9BEg2yl6Zy
 ikemdDxF1lAnpAN55QVlz22nEjSQbtWHDVxRdiO+31THxX9r1rTcC0TRJgEiznKWq32x 9A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cxe2f0uq1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 08:00:05 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 14:00:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Dec 2021 14:00:02 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B8A5545A;
        Tue, 14 Dec 2021 14:00:01 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v4 03/10] ASoC: cs35l41: Move power initializations to reg_sequence
Date:   Tue, 14 Dec 2021 13:59:52 +0000
Message-ID: <20211214135959.1317949-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
References: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -HC1HaRhuSPqmT22D440Vkb8drfHbnyP
X-Proofpoint-GUID: -HC1HaRhuSPqmT22D440Vkb8drfHbnyP
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA systems for all revisions of CS35L41 will benefit
from having this initialization, so add it to reg_sequence of
each revision

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c |  2 +-
 sound/soc/codecs/cs35l41.c     | 29 +++++++++--------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index dc5f502447a2..1387553afd3c 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -46,7 +46,7 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_CLASSH_CFG,			0x000B0405 },
 	{ CS35L41_WKFET_CFG,			0x00000111 },
 	{ CS35L41_NG_CFG,			0x00000033 },
-	{ CS35L41_AMP_GAIN_CTRL,		0x00000273 },
+	{ CS35L41_AMP_GAIN_CTRL,		0x00000000 },
 	{ CS35L41_GPIO1_CTRL1,			0xE1000001 },
 	{ CS35L41_GPIO2_CTRL1,			0xE1000001 },
 	{ CS35L41_MIXER_NGATE_CFG,		0x00000000 },
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index aa57c59b334d..4ed7490cab95 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1288,6 +1288,9 @@ static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
 	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
 	{ 0x00000040,			 0x0000CCCC },
 	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
 static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
@@ -1301,6 +1304,9 @@ static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
 	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
 	{ 0x00000040,			 0x0000CCCC },
 	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
 static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
@@ -1314,6 +1320,9 @@ static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
 	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
 	{ 0x00000040,			 0x0000CCCC },
 	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_DSP1_CCM_CORE_CTRL,	 0x00000000 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
 static const struct reg_sequence cs35l41_fs_errata_patch[] = {
@@ -1550,26 +1559,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
-	ret = regmap_write(cs35l41->regmap, CS35L41_DSP1_CCM_CORE_CTRL, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CCM_CORE_CTRL failed: %d\n", ret);
-		goto err;
-	}
-
-	ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				 CS35L41_AMP_EN_MASK, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CS35L41_PWR_CTRL2 failed: %d\n", ret);
-		goto err;
-	}
-
-	ret = regmap_update_bits(cs35l41->regmap, CS35L41_AMP_GAIN_CTRL,
-				 CS35L41_AMP_GAIN_PCM_MASK, 0);
-	if (ret < 0) {
-		dev_err(cs35l41->dev, "Write CS35L41_AMP_GAIN_CTRL failed: %d\n", ret);
-		goto err;
-	}
-
 	ret = cs35l41_set_pdata(cs35l41);
 	if (ret < 0) {
 		dev_err(cs35l41->dev, "Set pdata failed: %d\n", ret);
-- 
2.34.1

