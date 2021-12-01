Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36231465430
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhLARra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:47:30 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52516 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229896AbhLARr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:47:29 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B150FNa020440;
        Wed, 1 Dec 2021 11:43:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=USMKAjKlWX5RdcWThd0ZXcUwm5XRCCvMpVHsaxh7ssQ=;
 b=NMf5LqMGucq/FjxHCuWIOanVnUOKcpu5n3xdArJc0udbt2SI7sMKNeMfOzh2ULozqibU
 3zS9CFDAmQ8FoSX1krX2xsBk7GTTN5NaXS6szvJV8pW/0/6KdWhF8jCsmBm1lYza0FBy
 uRSps8PbeVx1vKwXw0C2vmyg8czztqOGAasb8etFKa9+bF2IhI3eu1atp3OWFlNlPcA6
 YaZNWgoYSkOVMhJlHi+dhd0FR57SPzHZNErgnlrVRaGtqflgLLZEyT+zMQrp9f3X0xgf
 NaFhoZMYkyb4SlcTVRySHO7OzxQQoECoSoR4KW5W3VnKKLFSb4PtcQ6IW9a5gvAdztWT 4w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cp1x10t7j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Dec 2021 11:43:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 17:43:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 1 Dec 2021 17:43:42 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.238])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 59762B10;
        Wed,  1 Dec 2021 17:43:42 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] ASoC: cs35l41: Fix undefined reference to core functions
Date:   Wed, 1 Dec 2021 17:43:07 +0000
Message-ID: <20211201174307.1399625-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201174307.1399625-1-tanureal@opensource.cirrus.com>
References: <20211201174307.1399625-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: W90QqdUWtiqt8Z5EZgfKL8REfzr9MjmL
X-Proofpoint-ORIG-GUID: W90QqdUWtiqt8Z5EZgfKL8REfzr9MjmL
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto select core driver if i2c or spi bus drivers are
selected

Fixes: a5e0091d62ab ("ASoC: cs35l41: Fix link problem")

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/codecs/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b4f70e27342c..c033ee7d82e4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -614,17 +614,19 @@ config SND_SOC_CS35L36
 
 config SND_SOC_CS35L41
 	tristate
+	default y if SND_SOC_CS35L41_SPI=y
+	default y if SND_SOC_CS35L41_I2C=y
+	default m if SND_SOC_CS35L41_SPI=m
+	default m if SND_SOC_CS35L41_I2C=m
 
 config SND_SOC_CS35L41_SPI
 	tristate "Cirrus Logic CS35L41 CODEC (SPI)"
 	depends on SPI_MASTER
-	select SND_SOC_CS35L41
 	select REGMAP_SPI
 
 config SND_SOC_CS35L41_I2C
 	tristate "Cirrus Logic CS35L41 CODEC (I2C)"
 	depends on I2C
-	select SND_SOC_CS35L41
 	select REGMAP_I2C
 
 config SND_SOC_CS42L42
-- 
2.34.1

