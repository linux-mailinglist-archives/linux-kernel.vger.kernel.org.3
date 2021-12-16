Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778E24770E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhLPLoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:44:20 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13120 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233751AbhLPLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:44:07 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG6WwLl019726;
        Thu, 16 Dec 2021 05:43:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9o1JulQx1RfDJhAZY8/epNV4zyts01siPwgI5Q1HMi0=;
 b=ZpRaZ9juiLUO+2OX0IHGhrRb10ogBhLo0GskrUX421oAyL56kGDO8LD6uAMiV4xilEzX
 7t+rxariP4+vSxqnEQzQw4vPioQinUSSEFpmoc7M8Lsxs2eT7InIXKdT6p81Tj1GpNs3
 C8sCIxUfVxqJuZOJuW//3cjf7kgsyqRSPN7xaA1ACydBfMlx1y+6mnlGA+Wp0GVlqHW0
 xA3rxSNQ1j4aSZsF86zNY0t067+kSDIEXU9srDHOdEHF2v1xp2T//NpwQCPR6t1TIhVV
 OsWMxgqgkZdrKoGHuINoaXSGUwGrmU20WrpTaPLKJLg2LI06wpnxjFCNLhWvYg9s1tsl 6Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc110q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 05:43:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:43:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Dec 2021 11:43:36 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D80EB13;
        Thu, 16 Dec 2021 11:43:36 +0000 (UTC)
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
Subject: [PATCH v5 03/10] ASoC: cs35l41: Move power initializations to reg_sequence
Date:   Thu, 16 Dec 2021 11:43:25 +0000
Message-ID: <20211216114332.153409-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
References: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5foYoidIiMtVirxlkfDhzGBQrfE1ufwb
X-Proofpoint-ORIG-GUID: 5foYoidIiMtVirxlkfDhzGBQrfE1ufwb
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC and HDA systems for all revisions of CS35L41 will benefit
from having this initialization, so add it to reg_sequence of
each revision

By moving to reg_sequence all gains are set to zero. And boost,
monitoring parts, and class D amplifier are disabled.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c |  3 ++-
 sound/soc/codecs/cs35l41.c     | 20 ++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index dc5f502447a2..b3567e10adc4 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -17,6 +17,7 @@
 
 static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_PWR_CTRL1,			0x00000000 },
+	{ CS35L41_PWR_CTRL2,			0x00000000 },
 	{ CS35L41_PWR_CTRL3,			0x01000010 },
 	{ CS35L41_GPIO_PAD_CONTROL,		0x00000000 },
 	{ CS35L41_SP_ENABLES,			0x00000000 },
@@ -46,7 +47,7 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_CLASSH_CFG,			0x000B0405 },
 	{ CS35L41_WKFET_CFG,			0x00000111 },
 	{ CS35L41_NG_CFG,			0x00000033 },
-	{ CS35L41_AMP_GAIN_CTRL,		0x00000273 },
+	{ CS35L41_AMP_GAIN_CTRL,		0x00000000 },
 	{ CS35L41_GPIO1_CTRL1,			0xE1000001 },
 	{ CS35L41_GPIO2_CTRL1,			0xE1000001 },
 	{ CS35L41_MIXER_NGATE_CFG,		0x00000000 },
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index aa57c59b334d..7494710ae6e6 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1288,6 +1288,8 @@ static const struct reg_sequence cs35l41_reva0_errata_patch[] = {
 	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
 	{ 0x00000040,			 0x0000CCCC },
 	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
 static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
@@ -1301,6 +1303,8 @@ static const struct reg_sequence cs35l41_revb0_errata_patch[] = {
 	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
 	{ 0x00000040,			 0x0000CCCC },
 	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
 static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
@@ -1314,6 +1318,8 @@ static const struct reg_sequence cs35l41_revb2_errata_patch[] = {
 	{ CS35L41_DSP1_XM_ACCEL_PL0_PRI, 0x00000000 },
 	{ 0x00000040,			 0x0000CCCC },
 	{ 0x00000040,			 0x00003333 },
+	{ CS35L41_PWR_CTRL2,		 0x00000000 },
+	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
 };
 
 static const struct reg_sequence cs35l41_fs_errata_patch[] = {
@@ -1556,20 +1562,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 		goto err;
 	}
 
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

