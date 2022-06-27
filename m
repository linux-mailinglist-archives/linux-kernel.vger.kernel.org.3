Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E555C22A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiF0Jn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiF0Jny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:43:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726086363
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:43:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R6qLPI026382;
        Mon, 27 Jun 2022 04:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=yMU0jpROdhFuA14yjuioMus6L/3EfIebG5m6xYIHjn0=;
 b=fFsyzNmKqVuHg+36uywKRm1rw7/WN9EbtPtEEXYlnTpo3I4kV1cU4epi7vQGi0jpLF7x
 XmofCxq77j2+3JZkXRLsl1XkfmEgMroAM3HEhBfpJUTSI2XvyzCF+1idbFOD6pdhHkrM
 /6JQNIJA8LPaB3CNXbXoJpCdoTj4+/FdYZU4tyvBMAw9Pc78ZMMs2SVtGcuKFyrVchAY
 Y/FucMoJQWWMDBxve2Zy7PowJ7ewFshRvI+QOw7gXRuRXkfU0BlW5V/3/rgnd9OU6MeT
 yEAVD0JMLMh1LNW0wJ7siJ0IBgICaiEfwt4aXiWrhzCD/QmLhfby9MdMhWKiVKxBSPnM hg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gwxsq2ege-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Jun 2022 04:43:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 10:43:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 27 Jun 2022 10:43:35 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 47322458;
        Mon, 27 Jun 2022 09:43:35 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <s.nawrocki@samsung.com>,
        <jrdr.linux@gmail.com>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Date:   Mon, 27 Jun 2022 10:43:35 +0100
Message-ID: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nY3888gUAWbKeO48SGu51K1Gcyn5iKeZ
X-Proofpoint-ORIG-GUID: nY3888gUAWbKeO48SGu51K1Gcyn5iKeZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion of the set_fmt callback to direct clock specification
included a small typo, correct the affected code.

Fixes: 91c49199e6d6 ("ASoC: samsung: Update to use set_fmt_new callback")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/samsung/s3c24xx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 4082ad7cbcc11..c1a314b86b155 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -170,7 +170,7 @@ static int s3c24xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	pr_debug("hw_params r: IISMOD: %x \n", iismod);
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
-	case SND_SOC_DAIFMT_BC_CFC:
+	case SND_SOC_DAIFMT_BC_FC:
 		iismod |= S3C2410_IISMOD_SLAVE;
 		break;
 	case SND_SOC_DAIFMT_BP_FP:
-- 
2.30.2

