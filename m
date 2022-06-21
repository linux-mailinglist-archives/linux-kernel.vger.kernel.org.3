Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7309B552F95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbiFUKU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFUKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:20:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129B28719
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:20:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L7wQ92011194;
        Tue, 21 Jun 2022 05:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=krV/LBDSpEQgXSWb5U5qWoeNdA7OvdAhzrLM454UqaI=;
 b=iFlq/AERe7qTIJt9Ni8y7948JqcQfUHa/mvEMTZtumDv16UIwSYUVsAYyMpqiymRxrLr
 i8oYZpekqVQSKrCUqDNVicRzLFbu4RrnXeZNXZS/dj08u2KuskvHCwisPL5k2IBvuUtB
 FcFdjzAt3pNSwAxk7wgPIwD9IkoBpulujIrSbKaxJyr/47cmDvV/jf9EmzyEiaOZUcER
 dBW3lXtk1gB8Ml9tuRXkmtw8ekjn9p/vDfnATTXzKB8JNk7oxsyFje1K4bQmTbPuuax1
 CkY2rFFCwNk8O82gv698fcOcVSR2fr+rU/X8IXrRc2yT+9oDVDgyDLR4SATkw5ZmdYR7 BA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41bcxp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 05:20:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 11:20:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 11:20:42 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C36611D1;
        Tue, 21 Jun 2022 10:20:42 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: wm5110: Fix DRE control
Date:   Tue, 21 Jun 2022 11:20:39 +0100
Message-ID: <20220621102041.1713504-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
References: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: es6T71c9ntu5vukUdpQkfGwE4H7Yh0TN
X-Proofpoint-ORIG-GUID: es6T71c9ntu5vukUdpQkfGwE4H7Yh0TN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRE controls on wm5110 should return a value of 1 if the DRE state
is actually changed, update to fix this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm5110.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 4973ba1ed7791..4ab7a672f8de8 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -413,6 +413,7 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 	unsigned int rnew = (!!ucontrol->value.integer.value[1]) << mc->rshift;
 	unsigned int lold, rold;
 	unsigned int lena, rena;
+	bool change = false;
 	int ret;
 
 	snd_soc_dapm_mutex_lock(dapm);
@@ -440,8 +441,8 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 		goto err;
 	}
 
-	ret = regmap_update_bits(arizona->regmap, ARIZONA_DRE_ENABLE,
-				 mask, lnew | rnew);
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_DRE_ENABLE,
+				       mask, lnew | rnew, &change);
 	if (ret) {
 		dev_err(arizona->dev, "Failed to set DRE: %d\n", ret);
 		goto err;
@@ -454,6 +455,9 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 	if (!rnew && rold)
 		wm5110_clear_pga_volume(arizona, mc->rshift);
 
+	if (change)
+		ret = 1;
+
 err:
 	snd_soc_dapm_mutex_unlock(dapm);
 
-- 
2.30.2

