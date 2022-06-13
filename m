Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80A549C86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbiFMTAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiFMS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:59:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6B43AE5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:16:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DBuxUi006945;
        Mon, 13 Jun 2022 11:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=4R4Ym4XA5bDdt/zDB7Y35xb6VBHh26DwvdrgZzMm1m4=;
 b=NFFik29o2NvZUx2AhujDPn+6BjLnktd3Bb8eKXXHUnu7rvyrxakwxjWipe1RFpIAn8UJ
 SrDUBCvzuuXVhrjqZNNhyRRAXV3pagYvMHitgSfIzZMkpX6cyt+UyfxmOhtJ70ZwrCns
 1n3nFFMXiy9W/vln0kIIwBEyVKjItaSvwe/fLuZzzM0aKZajzPNjkPOX7iC1RRB35sMz
 E/YOADb3ImA7phkeOaBqHYWO6/mR3ZJCOrXZvNmU43iD+0QKhhnwUkA+iX9fTvNvqQjj
 5/cG1DBMeVyFHbrSEZZ+CHPS6qFXLKpKs3xF5t2ESAvtRBMfofhVXNY0evryromRK/dm qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq24mu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jun 2022 11:15:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 17:15:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 13 Jun 2022 17:15:52 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C607546C;
        Mon, 13 Jun 2022 16:15:52 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <samuel@sholland.org>
CC:     <matthias.bgg@gmail.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: sun8i-codec: Partial revert to fix clock specifiers
Date:   Mon, 13 Jun 2022 17:15:51 +0100
Message-ID: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ufAMjQSTEEIdy2v7qIN3Z_ZuR-cxb2fr
X-Proofpoint-GUID: ufAMjQSTEEIdy2v7qIN3Z_ZuR-cxb2fr
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent updates accidentally updated the clock producer/consumer
specifiers on this device as part of refactoring the CPU side of the DAI
links. However, this device sits on the CODEC side and shouldn't have
been updated. Partially revert the changes keeping the switch to the new
clock terminology but going back to the CODEC defines.

Fixes: 7cc3965fde74 ("ASoC: sunxi: Update to use set_fmt_new callback")
Reported-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 90d74a2d53f38..f797c535f2983 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -287,10 +287,10 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
-	case SND_SOC_DAIFMT_BP_FP: /* Codec slave, DAI master */
+	case SND_SOC_DAIFMT_CBC_CFC: /* Codec slave, DAI master */
 		value = 0x1;
 		break;
-	case SND_SOC_DAIFMT_BC_FC: /* Codec Master, DAI slave */
+	case SND_SOC_DAIFMT_CBP_CFP: /* Codec Master, DAI slave */
 		value = 0x0;
 		break;
 	default:
-- 
2.30.2

