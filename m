Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2829596E63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiHQMYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiHQMYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094642B262
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H4vLJd010755;
        Wed, 17 Aug 2022 07:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fo2EGunu8bsAB6527X+mSVSKQLth99Br3x4ca9Xnrow=;
 b=ZsG/wqn2+bIrzzJP+t/OZPsPnDjqMJZEvcfh5PZdvKYjLfCGHzTeNQQbhd3yCjFJkB98
 kYpzqSPDZrQUVqkWj1QCRqCpOjIFNgwG9AFpJ8ijEPq+MnVbjIQINEQGU/XuFvCOY9mR
 iTbPLaqx25BkbW4Kbf75fZhVsEwIJqm/SPmMkdajZ11ZLl6rVMttEU8hbrOLwyxPJrQI
 rXRCqNaNai/rWlLQx0+vHdOAarqrDijumXq8cOudmblUJv4Uypl5XAWoWW88DiPjikvj
 EYINjpUeUselpDIq5JYVTI7MtfE8CDXfOlmc1DGDH63IFOMJf3rzcjf35jNlJoJnCWlG XQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcuec-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:23:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:23:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:23:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E8290459;
        Wed, 17 Aug 2022 12:23:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: cs42l42: Use snd_soc_tdm_params_to_bclk()
Date:   Wed, 17 Aug 2022 13:23:47 +0100
Message-ID: <20220817122347.1356773-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817122347.1356773-1-rf@opensource.cirrus.com>
References: <20220817122347.1356773-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i55BiZiuETI5FMbZ4F4wNDydevJOqvag
X-Proofpoint-GUID: i55BiZiuETI5FMbZ4F4wNDydevJOqvag
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new snd_soc_tdm_params_to_bclk() helper function to
calculate the bclk. This function handles most of the previous
manipulation and makes the code tidier.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a84d873e29df..42cdb051e0fb 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -893,22 +893,21 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int channels = params_channels(params);
 	unsigned int width = (params_width(params) / 8) - 1;
+	unsigned int slot_width = 0;
 	unsigned int val = 0;
 	int ret;
 
 	cs42l42->srate = params_rate(params);
-	cs42l42->bclk = snd_soc_params_to_bclk(params);
-
-	/* I2S frame always has 2 channels even for mono audio */
-	if (channels == 1)
-		cs42l42->bclk *= 2;
 
 	/*
 	 * Assume 24-bit samples are in 32-bit slots, to prevent SCLK being
 	 * more than assumed (which would result in overclocking).
 	 */
 	if (params_width(params) == 24)
-		cs42l42->bclk = (cs42l42->bclk / 3) * 4;
+		slot_width = 32;
+
+	/* I2S frame always has multiple of 2 channels */
+	cs42l42->bclk = snd_soc_tdm_params_to_bclk(params, slot_width, 0, 2);
 
 	switch (substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
-- 
2.30.2

