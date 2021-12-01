Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7B4654A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhLASEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:04:37 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39392 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhLASEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:04:22 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B150FOq020440;
        Wed, 1 Dec 2021 12:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=zvuDB81jMVYurNmZDyITgoCw52lNavBJMeVaz+gA898=;
 b=Ejv2gTYdRmu5lhj5yJisIj2rkHWMpnFqoIdTE4lSQc6vwPALdJc0/6md1cqZifAIOQet
 c1q9bJz6k7jBnlUde/oHrgv3HpoiZ+AmtaX9byDO6JtlpA35kG1OTz0M+s2tZNkHhVlf
 l6GDXSIxZoTvo82HGHdctZWfBn6HzPI5RN+r3lVEk7v9jAVZRO/FM/FzlgTmxcTYFyjn
 upcVenYm/Sig69HqF/Q4Fr8XWT0rdQqYvMRXfFNjumnbTdwV77C/ks5J0b0uSC8/ZBof
 wLvTleyPm7cePy6/6BRPweMK68Te22sB3SuEfuD8npV5nbiRAlxv6S8C3ssGE6weRYS+ iw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cp1x10txm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Dec 2021 12:00:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 18:00:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 1 Dec 2021 18:00:06 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.238])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2831A2A9;
        Wed,  1 Dec 2021 18:00:06 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] ASoC: amd: Fix dependency for SPI master
Date:   Wed, 1 Dec 2021 18:00:03 +0000
Message-ID: <20211201180004.1402156-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OpJqvcrtiV-HFQpB1iRBmDess_psbXKa
X-Proofpoint-ORIG-GUID: OpJqvcrtiV-HFQpB1iRBmDess_psbXKa
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set SPI_MASTER as dependency as is using CS35L41 SPI driver

Fixes: 96792fdd77cd1 ("ASoC: amd: enable vangogh platform machine driver build")

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v2 -> Fix patch description

 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 092966ff5ea7..8961b8fd23eb 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -68,7 +68,7 @@ config SND_SOC_AMD_VANGOGH_MACH
 	tristate "AMD Vangogh support for NAU8821 CS35L41"
 	select SND_SOC_NAU8821
 	select SND_SOC_CS35L41_SPI
-	depends on SND_SOC_AMD_ACP5x && I2C
+	depends on SND_SOC_AMD_ACP5x && I2C && SPI_MASTER
 	help
 	  This option enables machine driver for Vangogh platform
 	  using NAU8821 and CS35L41 codecs.
-- 
2.34.1

