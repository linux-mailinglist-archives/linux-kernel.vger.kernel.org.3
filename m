Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB94F71E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiDGCSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiDGCSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:18:51 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8CE5E14;
        Wed,  6 Apr 2022 19:16:51 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 7 Apr 2022
 10:16:50 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 7 Apr
 2022 10:16:49 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] s390: Simplify the calculation of variables
Date:   Thu, 7 Apr 2022 10:16:47 +0800
Message-ID: <1649297808-5048-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
References: <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
./arch/s390/include/asm/scsw.h:695:47-49: WARNING
 !A || A && B is equivalent to !A || B

I apply a readable version just to get rid of a warning.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: apply a readable and simple version as suggestion.
V2->V3: scsw->tm instead of scsw->cmd; fix logic flow as suggestion.

 arch/s390/include/asm/scsw.h | 79 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index a7c3ccf681da..5cb893706d66 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -508,9 +508,21 @@ static inline int scsw_cmd_is_valid_zcc(union scsw *scsw)
  */
 static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
 {
-	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       !(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
-	       (scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS);
+	/* Must be status pending. */
+	if (!(scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+
+	/* Must have alert status. */
+	if (!(scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS))
+		return 0;
+
+	/* Must be alone or together with primary, secondary or both,
+	 * => no intermediate status.
+	 */
+	if (scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS)
+		return 0;
+
+	return 1;
 }
 
 /**
@@ -522,10 +533,25 @@ static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
  */
 static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
 {
-	return (scsw->cmd.fctl != 0) &&
-	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
-		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
+	/* Must indicate at least one I/O function. */
+	if (!scsw->cmd.fctl)
+		return 0;
+
+	/* Must be status pending. */
+	if (!(scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+
+	/* Can be status pending alone, or with any combination of primary,
+	 * secondary and alert => no intermediate status.
+	 */
+	if (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS))
+		return 1;
+
+	/* If intermediate, must be suspended. */
+	if (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)
+		return 1;
+
+	return 0;
 }
 
 /**
@@ -675,9 +700,21 @@ static inline int scsw_tm_is_valid_q(union scsw *scsw)
  */
 static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
 {
-	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       !(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-	       (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS);
+	/* Must be status pending. */
+	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+
+	/* Must have alert status. */
+	if (!(scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS))
+		return 0;
+
+	/* Must be alone or together with primary, secondary or both,
+	 * => no intermediate status.
+	 */
+	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
+		return 0;
+
+	return 1;
 }
 
 /**
@@ -689,11 +725,25 @@ static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
  */
 static inline int scsw_tm_is_valid_pno(union scsw *scsw)
 {
-	return (scsw->tm.fctl != 0) &&
-	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
+	/* Must indicate at least one I/O function. */
+	if (!scsw->tm.fctl)
+		return 0;
+
+	/* Must be status pending. */
+	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+
+	/* Can be status pending alone, or with any combination of primary,
+	 * secondary and alert => no intermediate status.
+	 */
+	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
+		return 1;
+
+	/* If intermediate, must be suspended. */
+	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
+		return 1;
+
+	return 0;
 }
 
 /**
-- 
2.7.4

