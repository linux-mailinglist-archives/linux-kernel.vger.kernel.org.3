Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096D4CD723
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiCDPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbiCDPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:08:29 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71D40A33;
        Fri,  4 Mar 2022 07:07:40 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2hH013723;
        Fri, 4 Mar 2022 09:07:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=xtsITB9MtsbQbh9Pg7CKoJN9r/LR7G1l1Q0NK9S3HWk=;
 b=GXMmKAcEDKZz9m79azSLkQtB74mgqlRr7NZ7HERWK4cmmQXnDmREiJF9P3sbRvIyrPmr
 lmizC8wgKrgK9SQq9nLHRvyrpuiWS68PjIoM5jPxBSniGR4Hh2bWW+nP77mooB2uhEla
 63jRGBMxUt394hMb9tpSJ48oCV6wVZzwLutuC/csflrLX6o2wNez6E0RlSp8Ui2jg0QZ
 UGZmIa+PvOlGsEbMhHaIfdfOXctDywUUor1Dg45jErHDgH1ZV7BW7/nHOYLVusk7peEy
 UzbBktdBDaznF/8elbTwim/jN4cXL0JNY5CJCasM7Hd7F32yqd6/BhgTlyokK6wQNfnF oA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h414-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:28 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:24 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7A8727C;
        Fri,  4 Mar 2022 15:07:24 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 03/20] ASoC: cs35l41: Fix DSP mbox start command and global enable order
Date:   Fri, 4 Mar 2022 15:07:04 +0000
Message-ID: <20220304150721.3802-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: v53xgvSt1xnUz19cGb4h6JaH_adorjaA
X-Proofpoint-ORIG-GUID: v53xgvSt1xnUz19cGb4h6JaH_adorjaA
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
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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

