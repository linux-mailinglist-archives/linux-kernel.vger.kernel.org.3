Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F152DBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbiESRtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbiESRsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:48:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F5B2273
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:48:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J5MiMu023727;
        Thu, 19 May 2022 12:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VovP2fjHmWUZWiLciMKSnLk1aUbcDY4P7rblNQN7RKM=;
 b=TyvMBhwnQ4ujZvnEsZzlsn2sH6TrMsgKhNScMqX2Gt/hNUpdMjgEvQnnDqpAFvOjnHb7
 ycBOt/zrpjNN5xhqtp/iNkCLQx2upaKCUrdhpwMH38kntA0A7l4WXGopkLMon2HPVAPg
 9I5Fw0ZMFKRnZF5Q7ERFfXzw7C6eABOEXWnDzOqJ4MhcwrZmVNG3oLcT2xoWWhZjIJVb
 OWRFSiMP1pQ09iNgArn6PrNrfS/2yL7qD4BcnWuqGdwna9n8Or5ottS7WPkI6YFjyErI
 IHhMNYY1XaVbgvHd9Z/zo44xxcrpKdQPCoWtK3HYt/7vwrjRq0oDwwzAKzE0Sac4Uhed Qw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g29u37tee-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 May 2022 12:47:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 18:47:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 19 May 2022 18:47:54 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.59])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 96B48458;
        Thu, 19 May 2022 17:47:53 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 10/17] ASoC: cs35l41: Do not print error when waking from hibernation
Date:   Thu, 19 May 2022 18:47:42 +0100
Message-ID: <20220519174749.15459-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
References: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Elr-t-csaGHAJBXkfsBBS1uKWN4PXakE
X-Proofpoint-ORIG-GUID: Elr-t-csaGHAJBXkfsBBS1uKWN4PXakE
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

