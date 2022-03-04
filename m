Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B014CD692
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiCDOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiCDOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:41:19 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F11BBF75
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:40:30 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2248TIlJ019088;
        Fri, 4 Mar 2022 08:40:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=bFhXLBMGqICJ9xa4zHe1IgD/QVmyIzhRYAhGIXcq0CU=;
 b=dxXP/m1O4qV6f6lgFmV2P9GFp126XRrB7ogHV29TDLnxAW703vhrcpSkq7bSlvjkd4Z3
 wV9FhLfji9kDnbyhPHkuyOGLVG/BlWr0W8m6gNi4Jplax4E/jKF39+CvkjKG9W/Uf+h+
 zX8Cag0MDQLxGWhKc6co1l7Stfe5NtelgR38k9pAdDwZehoGUdg8t4QlSE8yF/sdM6/G
 EX2a0rtTo8IFhkicBw3f717cUu5kwQkHp5uPebwbKp0bOZqq53NjgZWIXm4AQmdkUgxM
 XJL6ZxlOoiPejG/uH2gUxmZMNw8i7ahho/0Eljd3mMGjQF6lyPEUqxoTyXYY4nJmJtlp bA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h2td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 08:40:18 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 14:40:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 14:40:17 +0000
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.90.251.79])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 36C747C;
        Fri,  4 Mar 2022 14:40:17 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Add warnings about DETECT_MODE and PLL_START
Date:   Fri, 4 Mar 2022 14:40:15 +0000
Message-ID: <20220304144015.398656-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: alberyu2hsG-jYvJnT3dm0fL5Q1eubXO
X-Proofpoint-ORIG-GUID: alberyu2hsG-jYvJnT3dm0fL5Q1eubXO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DETECT_MODE and PLL_START must be zero while HP_PDN and ADC_PDN are
both 1. If this condition is broken it can discharge FILT+ and it
can then take up to 1 second for FILT+ to recharge.

There is no workaround required for this, simply avoiding settings
and sequences that would break the requirement. The driver already
meets the requirement.

But it is not obvious from reading the code that this requirement
exists, or what is ensuring it is met. So it would not currently be
obvious to someone changing the code that there is certain special
behaviour that must be maintained.

To avoid accidental breakage in the future:

- Add comments into the register definitions to warn about this so
  that anyone changing the code around DETECT_MODE and PLL_START is
  aware of this requirement.

- Add a comment where PLL_START is written to 1 to highlight the
  requirement and why it is satisfied.

- Add a comment in cs42l42_setup_hs_type_detect() when DETECT_MODE is
  initialized.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 13 ++++++++++++-
 sound/soc/codecs/cs42l42.h |  9 ++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index db6ef6cdce15..c8409d50e934 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1012,7 +1012,14 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 		}
 	} else {
 		if (!cs42l42->stream_use) {
-			/* SCLK must be running before codec unmute */
+			/* SCLK must be running before codec unmute.
+			 *
+			 * PLL must not be started with ADC and HP both off
+			 * otherwise the FILT+ supply will not charge properly.
+			 * DAPM widgets power-up before stream unmute so at least
+			 * one of the "DAC" or "ADC" widgets will already have
+			 * powered-up.
+			 */
 			if (pll_ratio_table[cs42l42->pll_config].mclk_src_sel) {
 				snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 							      CS42L42_PLL_START_MASK, 1);
@@ -1830,6 +1837,10 @@ static void cs42l42_setup_hs_type_detect(struct cs42l42_private *cs42l42)
 
 	cs42l42->hs_type = CS42L42_PLUG_INVALID;
 
+	/*
+	 * DETECT_MODE must always be 0 with ADC and HP both off otherwise the
+	 * FILT+ supply will not charge properly.
+	 */
 	regmap_update_bits(cs42l42->regmap, CS42L42_MISC_DET_CTL,
 			   CS42L42_DETECT_MODE_MASK, 0);
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 244b24d1f5e9..60d3bdf5d7c9 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -491,7 +491,10 @@
 #define CS42L42_TS_UNPLUG		0
 #define CS42L42_TS_TRANS		1
 
-/* Page 0x15 Fractional-N PLL Registers */
+/*
+ * NOTE: PLL_START must be 0 while both ADC_PDN=1 and HP_PDN=1.
+ * Otherwise it will prevent FILT+ from charging properly.
+ */
 #define CS42L42_PLL_CTL1		(CS42L42_PAGE_15 + 0x01)
 #define CS42L42_PLL_START_SHIFT		0
 #define CS42L42_PLL_START_MASK		(1 << CS42L42_PLL_START_SHIFT)
@@ -574,6 +577,10 @@
 #define CS42L42_TIP_SENSE_CTRL_MASK		(3 << \
 					CS42L42_TIP_SENSE_CTRL_SHIFT)
 
+/*
+ * NOTE: DETECT_MODE must be 0 while both ADC_PDN=1 and HP_PDN=1.
+ * Otherwise it will prevent FILT+ from charging properly.
+ */
 #define CS42L42_MISC_DET_CTL		(CS42L42_PAGE_1B + 0x74)
 #define CS42L42_PDN_MIC_LVL_DET_SHIFT	0
 #define CS42L42_PDN_MIC_LVL_DET_MASK	(1 << CS42L42_PDN_MIC_LVL_DET_SHIFT)
-- 
2.30.2

