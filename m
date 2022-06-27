Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D355E355
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiF0NPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiF0NPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:15:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550A13D2F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:12:21 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RBmurk015955;
        Mon, 27 Jun 2022 08:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0Khu6/fuJfMLzW9aQk1bRq1eHO8RZ0Hw8Fa6zQNMHwg=;
 b=Vdtnw+e2/Z5f0r9TaRj6P+z8CFdM5/uMRDNNaz7dDa6LkDEuGG0er5QbUg/Rr44z8C84
 xRyhkm8yjKTJr3D10fAeJT6UpZx2vZfDOQ05n0lGsORJwgdEp+XdjCOp+ZV3yUUSc2mL
 WGLiX7A1ZtuAceJScHAUn20aoA5ibMpIMBaNk07298AmzEIB+qnMxPahk/krCYFsv5VG
 KiD595tv8HBKMZmRqin/c62DIaFDQZCJfc6x/LsYeyfL6SRYAJuVBOBzS3BsXg7yO8E9
 AkahUruv7Z5wG6mhFWjdDbrV6BlFZsVGDYNjKFsqN8i76w0fp5pSXwHGX5xRInFAxlX8 rQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2jthu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Jun 2022 08:12:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 14:12:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 27 Jun 2022 14:12:02 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 52443458;
        Mon, 27 Jun 2022 13:12:02 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <s.nawrocki@samsung.com>,
        <jrdr.linux@gmail.com>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Date:   Mon, 27 Jun 2022 14:12:02 +0100
Message-ID: <20220627131202.3148329-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5HNY2iefiqGyrAbo5CP_Ne9bRYCsGn9B
X-Proofpoint-GUID: 5HNY2iefiqGyrAbo5CP_Ne9bRYCsGn9B
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

Fixes: 0b491c7c1b25 ("ASoC: samsung: Update to use set_fmt_new callback")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Correct fixes tag.

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

