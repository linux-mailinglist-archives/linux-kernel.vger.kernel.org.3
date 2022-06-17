Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD054FA69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbiFQPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiFQPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:36:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952AD46
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:36:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HBlIRM021568;
        Fri, 17 Jun 2022 10:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=qRtpFnwnINqdEI0cM/6TIAgTA8r6U9dSoQLRjJoptkw=;
 b=Y7JVKM5msmCoD9jA1SosE6mgf2hyZUWA/Sbmd4jneaOJNOp85CcNFM+Ld14irX8l0sJn
 k6wPvZ5993MDhYSYAx83WT7UzQwp6j5hLAKRGa25II4sKhzkSZtqPeVN+zoWbGOX2rTo
 bL+4lPzC0lHyX+tew+oGfZtP87FM1QIyuL89oithp9/Q/p9dNlWzCI3NRfYiFL3Fkmju
 DBmyUXEzKJRDg2YnA2maIisYE7oiT7X4OS0p4IWQYhFnB5jmnBroE0NNE/Ptn0G2vzkT
 PrXtJVr6ADm8z+vzIGUYKnabL/6UG2g3UastH1JphFED0iu1+M9ZWhS0Xp67/SfUx/tf Pw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq79b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 10:36:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 16:36:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 17 Jun 2022 16:36:19 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.121])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6F861468;
        Fri, 17 Jun 2022 15:36:18 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ASoC: ops: Fix integer detection for when max possible values > 1
Date:   Fri, 17 Jun 2022 16:36:06 +0100
Message-ID: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mqnC9nlbYucMZ7Ouujo0btYo4FKfBKEA
X-Proofpoint-GUID: mqnC9nlbYucMZ7Ouujo0btYo4FKfBKEA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard snd_soc_info_volsw() allows a two value control to be
defined as an integer control only if the control name ends in
"Volume". It achieves this by creating a substring if it contains
" Volume", and ensuring this exists at the end of the name. The
volume substring is then used to decide whether the type is a
SNDRV_CTL_ELEM_TYPE_INTEGER or SNDRV_CTL_ELEM_TYPE_BOOLEAN.
However this volume substring is only computed for a two value
control.
This means for controls where there are more than two possible
values, the substring is never created, so in this case the
substring remains NULL, and the condition yields
SNDRV_CTL_ELEM_TYPE_BOOLEAN, even though there are more than 2
possible values.
If there are more than 2 possible values for the control,
then it should always be an integer control.

Fixes: aa2a4b897132 ("ASoC: ops: Fix boolean/integer detection for simple controls")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 0267e39de2a8..1970bda074d8 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -183,17 +183,16 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	if (mc->platform_max && mc->platform_max < max)
 		max = mc->platform_max;
 
-	/* Even two value controls ending in Volume should always be integer */
 	if (max == 1) {
+		/* Even two value controls ending in Volume should always be integer */
 		vol_string = strstr(kcontrol->id.name, " Volume");
-		if (vol_string && strcmp(vol_string, " Volume"))
-			vol_string = NULL;
-	}
-
-	if (!vol_string)
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	else
+		if (vol_string && !strcmp(vol_string, " Volume"))
+			uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		else
+			uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	} else {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	}
 
 	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
-- 
2.25.1

