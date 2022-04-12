Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B804FE601
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357735AbiDLQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiDLQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:41:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A814706E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:39:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23BNTBcJ022664;
        Tue, 12 Apr 2022 11:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=OruPJRSEpxz+SS2SuZh1l9IfGObv7YDQ/pALU12P51I=;
 b=pFNSQhTSS0a88LvD+zsAZgniqVR4Cu6PagZ9fUQjYK9eSomORE3gcHul+5mI320yDsdr
 JLQ0vNP4UNGn/Ii6nOygZpOtORnDVFyng1nUAzHF0lLpbiLNayIrzz3lOT6hhp73QRUC
 kkOAv0WBAyY6dH3gpaTx1+71cVsYVPD7IN9xzdqspJdiI0ScTwt9DDwEq3D0SVuCFNrH
 0221fBIuckVkR2HR6SuWkR3A5bTV0fBREohZ8jEbsqM7HqfK0JSvZBZB9gTfvaEv8BEq
 hTQtDiV6Zb5491Q48hG0mXtR5jA7FzmUCHPMmYvKDhA47su4fhb/iqGfZ+Ol8aSxmnTx vQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fb7hym18n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Apr 2022 11:39:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 17:39:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 12 Apr 2022 17:39:30 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 04470458;
        Tue, 12 Apr 2022 16:39:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Fix overrun of unterminated control name string
Date:   Tue, 12 Apr 2022 17:39:27 +0100
Message-ID: <20220412163927.1303470-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TpmPQ69TQXk_a1C_3XAa3qKwEZ0TFgTA
X-Proofpoint-ORIG-GUID: TpmPQ69TQXk_a1C_3XAa3qKwEZ0TFgTA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For wmfw format v2 and later the coefficient name strings have a length
field and are NOT null-terminated. Use kasprintf() to convert the
unterminated string into a null-terminated string in an allocated buffer.

The previous code handled this duplication incorrectly using kmemdup()
and getting the length from a strlen() of the (unterminated) source string.
This resulted in creating a string that continued up to the next byte in
the firmware file that just happened to be 0x00.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
---
 drivers/firmware/cirrus/cs_dsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index e48108e694f8..7dad6f57d970 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -955,8 +955,7 @@ static int cs_dsp_create_control(struct cs_dsp *dsp,
 	ctl->alg_region = *alg_region;
 	if (subname && dsp->fw_ver >= 2) {
 		ctl->subname_len = subname_len;
-		ctl->subname = kmemdup(subname,
-				       strlen(subname) + 1, GFP_KERNEL);
+		ctl->subname = kasprintf(GFP_KERNEL, "%.*s", subname_len, subname);
 		if (!ctl->subname) {
 			ret = -ENOMEM;
 			goto err_ctl;
-- 
2.30.2

