Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E779E512128
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiD0PLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiD0PK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6354BE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:46 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vn014103;
        Wed, 27 Apr 2022 10:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ArcewcoP0tuLPjnpGDtq73r4Bynp3YQrvgJpLfisDOQ=;
 b=DE59EqXX8dHw3G/B+M5Wq4jKJpiT6d4qBPbsOaBfTQojm7Yp16ZhwsumW7KVf54iU3dB
 0ghXgg6AaiX0FP1RnRypTE8sJkVBVcajshSTHArYbHwnjRSj5EJlelSuuj5aaa1rgF1W
 RlBL6q5x95bMiOWEv6bawMLFvwBK9wHFDH0kPpnGozLCySLcKI2VctCs5kWZbpCzk7dg
 brTZFGdRGfvsG2iucAAhBHnqPhoELLH68Fb3/O30UOdmoikoEmtyHZvMmN1EmjpQPEbW
 Z2s8CgpxLcZ3QwkBK7FfjbyhRE4QF4Zl+trb11C3/nCt+yBnELaM/63JJFV6LJ3ZFtax FQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:30 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 04676B1A;
        Wed, 27 Apr 2022 15:07:29 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 18/26] ASoC: cs35l41: Move cs35l41 exit hibernate function into shared code
Date:   Wed, 27 Apr 2022 16:07:12 +0100
Message-ID: <20220427150720.9194-19-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mfluf5woC9VU3-7USLj7_SXnRwm33w2w
X-Proofpoint-ORIG-GUID: mfluf5woC9VU3-7USLj7_SXnRwm33w2w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

CS35L41 HDA Driver will support hibernation using DSP firmware,
move the exit hibernate function into shared code so this can
be reused.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  1 +
 sound/soc/codecs/cs35l41-lib.c | 60 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 61 +---------------------------------
 3 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 85db31174adb..938f5846e4d4 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -886,6 +886,7 @@ void cs35l41_configure_cs_dsp(struct device *dev, struct regmap *reg, struct cs_
 int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			      enum cs35l41_cspl_mbox_cmd cmd);
 int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap);
+int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 37ae8ddccac9..dc4654f43157 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1319,6 +1319,66 @@ int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs35l41_write_fs_errata);
 
+static void cs35l41_wait_for_pwrmgt_sts(struct device *dev, struct regmap *regmap)
+{
+	const int pwrmgt_retries = 10;
+	unsigned int sts;
+	int i, ret;
+
+	for (i = 0; i < pwrmgt_retries; i++) {
+		ret = regmap_read(regmap, CS35L41_PWRMGT_STS, &sts);
+		if (ret)
+			dev_err(dev, "Failed to read PWRMGT_STS: %d\n", ret);
+		else if (!(sts & CS35L41_WR_PEND_STS_MASK))
+			return;
+
+		udelay(20);
+	}
+
+	dev_err(dev, "Timed out reading PWRMGT_STS\n");
+}
+
+int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap)
+{
+	const int wake_retries = 20;
+	const int sleep_retries = 5;
+	int ret, i, j;
+
+	for (i = 0; i < sleep_retries; i++) {
+		dev_dbg(dev, "Exit hibernate\n");
+
+		for (j = 0; j < wake_retries; j++) {
+			ret = cs35l41_set_cspl_mbox_cmd(dev, regmap,
+							CSPL_MBOX_CMD_OUT_OF_HIBERNATE);
+			if (!ret)
+				break;
+
+			usleep_range(100, 200);
+		}
+
+		if (j < wake_retries) {
+			dev_dbg(dev, "Wake success at cycle: %d\n", j);
+			return 0;
+		}
+
+		dev_err(dev, "Wake failed, re-enter hibernate: %d\n", ret);
+
+		cs35l41_wait_for_pwrmgt_sts(dev, regmap);
+		regmap_write(regmap, CS35L41_WAKESRC_CTL, 0x0088);
+
+		cs35l41_wait_for_pwrmgt_sts(dev, regmap);
+		regmap_write(regmap, CS35L41_WAKESRC_CTL, 0x0188);
+
+		cs35l41_wait_for_pwrmgt_sts(dev, regmap);
+		regmap_write(regmap, CS35L41_PWRMGT_CTL, 0x3);
+	}
+
+	dev_err(dev, "Timed out waking device\n");
+
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(cs35l41_exit_hibernate);
+
 MODULE_DESCRIPTION("CS35L41 library");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 5f0eca229dd3..0400c6e091d5 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1349,65 +1349,6 @@ static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static void cs35l41_wait_for_pwrmgt_sts(struct cs35l41_private *cs35l41)
-{
-	const int pwrmgt_retries = 10;
-	unsigned int sts;
-	int i, ret;
-
-	for (i = 0; i < pwrmgt_retries; i++) {
-		ret = regmap_read(cs35l41->regmap, CS35L41_PWRMGT_STS, &sts);
-		if (ret)
-			dev_err(cs35l41->dev, "Failed to read PWRMGT_STS: %d\n", ret);
-		else if (!(sts & CS35L41_WR_PEND_STS_MASK))
-			return;
-
-		udelay(20);
-	}
-
-	dev_err(cs35l41->dev, "Timed out reading PWRMGT_STS\n");
-}
-
-static int cs35l41_exit_hibernate(struct cs35l41_private *cs35l41)
-{
-	const int wake_retries = 20;
-	const int sleep_retries = 5;
-	int ret, i, j;
-
-	for (i = 0; i < sleep_retries; i++) {
-		dev_dbg(cs35l41->dev, "Exit hibernate\n");
-
-		for (j = 0; j < wake_retries; j++) {
-			ret = cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
-							CSPL_MBOX_CMD_OUT_OF_HIBERNATE);
-			if (!ret)
-				break;
-
-			usleep_range(100, 200);
-		}
-
-		if (j < wake_retries) {
-			dev_dbg(cs35l41->dev, "Wake success at cycle: %d\n", j);
-			return 0;
-		}
-
-		dev_err(cs35l41->dev, "Wake failed, re-enter hibernate: %d\n", ret);
-
-		cs35l41_wait_for_pwrmgt_sts(cs35l41);
-		regmap_write(cs35l41->regmap, CS35L41_WAKESRC_CTL, 0x0088);
-
-		cs35l41_wait_for_pwrmgt_sts(cs35l41);
-		regmap_write(cs35l41->regmap, CS35L41_WAKESRC_CTL, 0x0188);
-
-		cs35l41_wait_for_pwrmgt_sts(cs35l41);
-		regmap_write(cs35l41->regmap, CS35L41_PWRMGT_CTL, 0x3);
-	}
-
-	dev_err(cs35l41->dev, "Timed out waking device\n");
-
-	return -ETIMEDOUT;
-}
-
 static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
@@ -1420,7 +1361,7 @@ static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
 
 	regcache_cache_only(cs35l41->regmap, false);
 
-	ret = cs35l41_exit_hibernate(cs35l41);
+	ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
 	if (ret)
 		return ret;
 
-- 
2.32.0

