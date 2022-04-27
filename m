Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1B511F41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiD0PK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiD0PK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610133E07
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vo014103;
        Wed, 27 Apr 2022 10:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=rC1I/YxoZvpUioOZX42tJOCa5yR61WbSa3yvtsC5Zdw=;
 b=d1N/G6AjNnIRThXsbxyZL1lav5XGbbiOn9e3b4AqECLkWKRhPY6HWgR3NnzhLhuZqFCl
 rUmm+pK8CJTTucPvkp5qDboBfmeKqTaRsSuNiyEcsVhay8mxl4PI4PX3/S/J2sshGy+Y
 Dg3NZv5Waq06RYSB8tgeX6sS8ssEw09WgWPxCBPR73PGFfi64A0wuyrdpH7NMdurVBsD
 bgcTMeZc1MBtCAnfhKhEPWswq0achlpTsnAAXQt1sNxEE9OjdXMty9/RDxCyFQ3pcsHf
 2VPCDXea4udQxNehTp8esRkrcpM43q6Wew8lheSIh8qvhfECgD9RAnZbYe23yUR1wzWs UQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:30 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6565446C;
        Wed, 27 Apr 2022 15:07:30 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 19/26] ALSA: cs35l41: Do not print error when waking from hibernation
Date:   Wed, 27 Apr 2022 16:07:13 +0100
Message-ID: <20220427150720.9194-20-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: spaYy79zCg5QNdFGXUjmWboqJAd8xoK3
X-Proofpoint-ORIG-GUID: spaYy79zCg5QNdFGXUjmWboqJAd8xoK3
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

When waking from hibernation, it is possible for the function
which sends the wake command to fail initially, but after a
retry it will succeed. There is no need to print an error if
the initial attempts fail.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index dc4654f43157..8a796dbe0718 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1300,7 +1300,8 @@ int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			return 0;
 	}
 
-	dev_err(dev, "Failed to set mailbox cmd %u (status %u)\n", cmd, sts);
+	if (cmd != CSPL_MBOX_CMD_OUT_OF_HIBERNATE)
+		dev_err(dev, "Failed to set mailbox cmd %u (status %u)\n", cmd, sts);
 
 	return -ENOMSG;
 }
-- 
2.32.0

