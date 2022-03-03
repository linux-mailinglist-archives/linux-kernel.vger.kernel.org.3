Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183AC4CC3EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiCCRdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiCCRcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1109D19E72C;
        Thu,  3 Mar 2022 09:31:21 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AADt028599;
        Thu, 3 Mar 2022 11:31:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7OagKgdEVfE1W5ke5mHVLC61Cbl1a7WdHXMCUL9/MWk=;
 b=nHLyAwYT2/7JAZ/Svl7g2y6nQiY6PH+p54kLyeJwUUrx0AMo1nnVXP/Vgp+mvVSkDVxn
 AznMn0Ooz0Tv2RysvdOT2O3CWCMecLjCMvxFrzoO3ceMjTkIDdmkLDpqMNo7xYxEiPMJ
 bRJuJa7VIrmYPwgQdHa00CZ+cioMkBKefxQKne1eA9121OcC24TEcEjkZcBmOcWTBrYQ
 74JWZpkGDFfJi06v+BoojdS5dBN1rB/mL9KX7n48oLc3hGxzOqKXrcJnlP3WDflaVfjp
 eP9Bof+4ab4Gfc8idiV91x92Eikbew2jZl2AdGaIRuY718kRPPFwnTjTn7bT3mMEu/ce jg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:03 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5F26D11D1;
        Thu,  3 Mar 2022 17:31:03 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 03/20] ASoC: cs35l41: Fix DSP mbox start command and global enable order
Date:   Thu, 3 Mar 2022 17:30:42 +0000
Message-ID: <20220303173059.269657-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UPtZl0vb1q5uuNiLxv-MDp1EGMa6Q5tk
X-Proofpoint-GUID: UPtZl0vb1q5uuNiLxv-MDp1EGMa6Q5tk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global enable must happen before CSPL_MBOX_CMD_RESUME command
is sent. Move it to PRE_PMU as both events use
SND_SOC_DAPM_OUT_DRV_E macro.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index f3787d77f892..05de94fd2e55 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -573,7 +573,7 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 	int ret = 0;
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+	case SND_SOC_DAPM_PRE_PMU:
 		regmap_multi_reg_write_bypassed(cs35l41->regmap,
 						cs35l41_pup_patch,
 						ARRAY_SIZE(cs35l41_pup_patch));
@@ -649,7 +649,7 @@ static const struct snd_soc_dapm_widget cs35l41_dapm_widgets[] = {
 
 	SND_SOC_DAPM_OUT_DRV_E("Main AMP", CS35L41_PWR_CTRL2, 0, 0, NULL, 0,
 			       cs35l41_main_amp_event,
-			       SND_SOC_DAPM_POST_PMD |	SND_SOC_DAPM_POST_PMU),
+			       SND_SOC_DAPM_POST_PMD |	SND_SOC_DAPM_PRE_PMU),
 
 	SND_SOC_DAPM_MUX("ASP TX1 Source", SND_SOC_NOPM, 0, 0, &asp_tx1_mux),
 	SND_SOC_DAPM_MUX("ASP TX2 Source", SND_SOC_NOPM, 0, 0, &asp_tx2_mux),
-- 
2.35.1

