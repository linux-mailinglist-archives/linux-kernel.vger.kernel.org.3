Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D564596EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiHQMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiHQMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:55:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3E4A10F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:55:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HCp2QM001811;
        Wed, 17 Aug 2022 07:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=dI5c4NMBWb6kXd28M1dU1LPLwg2nYuaVxb2LGXb6HJA=;
 b=K3/Qowb95BotZb/Xz0jjg2SRsFUG97gCawzI5s2r3xzzetVFyu277PTTI3CLpzEjXqnM
 YxdiZsnNkLx4EJS1PdilaIleaJbue2gb2tFiuuEb4TpHCHsUAZcE0cON7VJgIVM372xO
 QC8GTlkSDiPRgwm9UelDgM5Zr7VEML9emHpTwvP1+FkEDgaiSdXLgzIFivWNE3736v9i
 CubNcOCch0is6JJ7CTYz5+ZExd+AA56VowX2TcCHM5ibTViEPKVbJR7UVQ1r44m3jSlG
 D+BwlNd7leclaZ3A4ABs0aYLG4bzohsI3OeYFcv8dD2abZUQLx/JktaVYy9iPvmn8eRa gg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcvey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:55:10 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:55:08 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:55:08 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6870D459;
        Wed, 17 Aug 2022 12:55:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: soc-utils-test: Add test for snd_soc_params_to_bclk()
Date:   Wed, 17 Aug 2022 13:55:08 +0100
Message-ID: <20220817125508.1406651-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GuE-QEIuDVO5lsT9Of62F59lRpBucotQ
X-Proofpoint-GUID: GuE-QEIuDVO5lsT9Of62F59lRpBucotQ
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

snd_soc_params_to_bclk() calculates the BCLK from only the information in
snd_pcm_hw_params. It is therefore a subset of the functionality of
snd_soc_tdm_params_to_bclk() so can use a subset of the test case table.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/soc-utils-test.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/soc-utils-test.c b/sound/soc/soc-utils-test.c
index 5ad8e23af49a..616d2c926dd1 100644
--- a/sound/soc/soc-utils-test.c
+++ b/sound/soc/soc-utils-test.c
@@ -170,8 +170,54 @@ static void test_tdm_params_to_bclk(struct kunit *test)
 	}
 }
 
+static void test_snd_soc_params_to_bclk_one(struct kunit *test,
+					    unsigned int rate, snd_pcm_format_t fmt,
+					    unsigned int channels,
+					    unsigned int expected_bclk)
+{
+	struct snd_pcm_hw_params params;
+	int got_bclk;
+
+	_snd_pcm_hw_params_any(&params);
+	snd_mask_none(hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT));
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->min = rate;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->max = rate;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->min = channels;
+	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->max = channels;
+	params_set_format(&params, fmt);
+
+	got_bclk = snd_soc_params_to_bclk(&params);
+	pr_debug("%s: r=%u sb=%u ch=%u expected=%u got=%d\n",
+		 __func__,
+		 rate, params_width(&params), channels, expected_bclk, got_bclk);
+	KUNIT_ASSERT_EQ(test, expected_bclk, (unsigned int)got_bclk);
+}
+
+static void test_snd_soc_params_to_bclk(struct kunit *test)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tdm_params_to_bclk_cases); ++i) {
+		/*
+		 * snd_soc_params_to_bclk() is all the test cases where
+		 * snd_pcm_hw_params values are not overridden.
+		 */
+		if (tdm_params_to_bclk_cases[i].tdm_width |
+		    tdm_params_to_bclk_cases[i].tdm_slots |
+		    tdm_params_to_bclk_cases[i].slot_multiple)
+			continue;
+
+		test_snd_soc_params_to_bclk_one(test,
+						tdm_params_to_bclk_cases[i].rate,
+						tdm_params_to_bclk_cases[i].fmt,
+						tdm_params_to_bclk_cases[i].channels,
+						tdm_params_to_bclk_cases[i].bclk);
+	}
+}
+
 static struct kunit_case soc_utils_test_cases[] = {
 	KUNIT_CASE(test_tdm_params_to_bclk),
+	KUNIT_CASE(test_snd_soc_params_to_bclk),
 	{}
 };
 
-- 
2.30.2

