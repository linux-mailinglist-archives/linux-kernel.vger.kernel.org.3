Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC7533D82
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiEYNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiEYNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:16:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0CE00B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:16:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PCRmjI022096;
        Wed, 25 May 2022 08:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VovP2fjHmWUZWiLciMKSnLk1aUbcDY4P7rblNQN7RKM=;
 b=XfqjvFfnpEY8n8ORa4hJO4LxzKZ3gcSWFo8woA9SzWd4yMB6k42SvpnUvZDLWTcmX/mJ
 lRJfIAbaJAnBmzyzZLooJ7I5/G4S9nQcOj+vXguJ33MFs7JUTgxuNporxAbr6xSb8hkH
 FWwgKQkdEuNLRbRxLiFJkVzA/67erJBpUzh5FUx8YLOrO+OEs+hqvE2Y71BUA0kjyk9h
 OAqlbrgrfrH0cZiwmivZInD+Ja02iPL6UAiH3MnRLOel97NJ47p5AxdMSfbmvQ4IX8Cf
 yu8L7MxFtXPJMbmPG2pOwE7NX9+PYWBrcCqDZG00g5Npxgo3xfo8dPEuu2SwQo8C0IFG kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u20we6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 08:16:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 14:16:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 25 May 2022 14:16:43 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.233])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 620A846C;
        Wed, 25 May 2022 13:16:43 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 10/17] ASoC: cs35l41: Do not print error when waking from hibernation
Date:   Wed, 25 May 2022 14:16:31 +0100
Message-ID: <20220525131638.5512-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UpThctazHpv93Cr7d4kdTzKRFBHrtW7C
X-Proofpoint-GUID: UpThctazHpv93Cr7d4kdTzKRFBHrtW7C
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

When waking from hibernation, it is possible for the function
which sends the wake command to fail initially, but after a
retry it will succeed. There is no need to print an error if
the initial attempts fail.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes since v2:
 - No change
 
 sound/soc/codecs/cs35l41-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index cc5366c8bdd6..e726a38f1997 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1302,7 +1302,8 @@ int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			return 0;
 	}
 
-	dev_err(dev, "Failed to set mailbox cmd %u (status %u)\n", cmd, sts);
+	if (cmd != CSPL_MBOX_CMD_OUT_OF_HIBERNATE)
+		dev_err(dev, "Failed to set mailbox cmd %u (status %u)\n", cmd, sts);
 
 	return -ENOMSG;
 }
-- 
2.34.1

