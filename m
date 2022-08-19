Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B25599C70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbiHSMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348843AbiHSMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:52:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D07D86FD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:41 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JBix0P020060;
        Fri, 19 Aug 2022 07:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fRxAdbE57d0qiTBUvDtalLSnCO5ib5KMTH5zZplYHSE=;
 b=WRMPe6IsGN6KjPBo/mSLOJD1f7lSd/FBuQ/iTtxmLeOVy6AS+Xp/lR5M5Fz5C0QACVea
 KxbezR8Bb+YY6rhU4bUx0zh1THNvisXfW+4v54NpA8KcsmrAfKD/vdsOzE0oZxwj0fEh
 W7xzszTWUOK6TefZvb8ma1iyCQ3WqpMFnmXkgvosXy+FpCWwOeSUimnjbUG8lMcoYIE0
 695a7sMW+omoGswvosSZloaVhyWz7lwzehMg6UXYNpJ/STq4rXQwwdqKTbYZ5byaRjJz
 ybuLBLcGPSly0OnV+3ChzZ9Nb/LVVP0YN3WjKMtxrLx5o679/Z/DjiZKsgSpExV/746+ SQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpfuvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:36 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:34 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 40B07B16;
        Fri, 19 Aug 2022 12:52:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 01/12] ASoC: cs42l42: Add SOFT_RESET_REBOOT register
Date:   Fri, 19 Aug 2022 13:52:19 +0100
Message-ID: <20220819125230.42731-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819125230.42731-1-rf@opensource.cirrus.com>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xs4AYtngnCc7SOo6tZI9rnjN33jkVlp4
X-Proofpoint-GUID: xs4AYtngnCc7SOo6tZI9rnjN33jkVlp4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SOFT_RESET_REBOOT register is needed to recover CS42L42 state after
a Soundwire bus reset.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs42l42.h    | 5 +++++
 sound/soc/codecs/cs42l42.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/cs42l42.h b/include/sound/cs42l42.h
index a55d522f1772..9cf4baabea52 100644
--- a/include/sound/cs42l42.h
+++ b/include/sound/cs42l42.h
@@ -34,6 +34,7 @@
 #define CS42L42_PAGE_24		0x2400
 #define CS42L42_PAGE_25		0x2500
 #define CS42L42_PAGE_26		0x2600
+#define CS42L42_PAGE_27		0x2700
 #define CS42L42_PAGE_28		0x2800
 #define CS42L42_PAGE_29		0x2900
 #define CS42L42_PAGE_2A		0x2A00
@@ -719,6 +720,10 @@
 
 #define CS42L42_SRC_SDOUT_FS		(CS42L42_PAGE_26 + 0x09)
 
+/* Page 0x27 DMA */
+#define CS42L42_SOFT_RESET_REBOOT	(CS42L42_PAGE_27 + 0x01)
+#define CS42L42_SFT_RST_REBOOT_MASK	BIT(1)
+
 /* Page 0x28 S/PDIF Registers */
 #define CS42L42_SPDIF_CTL1		(CS42L42_PAGE_28 + 0x01)
 #define CS42L42_SPDIF_CTL2		(CS42L42_PAGE_28 + 0x02)
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 42cdb051e0fb..440d414efe0a 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -294,6 +294,7 @@ static bool cs42l42_readable_register(struct device *dev, unsigned int reg)
 	case CS42L42_SPDIF_SW_CTL1:
 	case CS42L42_SRC_SDIN_FS:
 	case CS42L42_SRC_SDOUT_FS:
+	case CS42L42_SOFT_RESET_REBOOT:
 	case CS42L42_SPDIF_CTL1:
 	case CS42L42_SPDIF_CTL2:
 	case CS42L42_SPDIF_CTL3:
@@ -358,6 +359,7 @@ static bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L42_LOAD_DET_DONE:
 	case CS42L42_DET_STATUS1:
 	case CS42L42_DET_STATUS2:
+	case CS42L42_SOFT_RESET_REBOOT:
 		return true;
 	default:
 		return false;
-- 
2.30.2

