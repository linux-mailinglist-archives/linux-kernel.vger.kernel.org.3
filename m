Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDC4D2862
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiCIF3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCIF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:29:42 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1F3D1E0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646803725; x=1678339725;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=97CBgfKzG/hf6ld2R9U1iapWBregjuYMrjFowuf2y98=;
  b=bBIoHKI8wQExxUnJoW2lFgxsDn2BjXC9lqQXcLv1SEW5Yj7YwbsHnxd2
   baeu1dCmhuHTkTT0RmO4c3DLOXhzCviQSCU4gQY13oNv9ZU1Vc9ljqN4A
   QaSn0WDnfHRgVrmhtVd3pzkQt/GCSqYlHzuIEJ8CKWLPNmL6AignQAPXn
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 21:28:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:28:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 21:28:42 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 21:28:38 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <yuehaibing@huawei.com>,
        <minchan@kernel.org>, <sfr@canb.auug.org.au>,
        <rientjes@google.com>, <edgararriaga@google.com>, <mhocko@suse.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm: madvise: return correct bytes advised with process_madvise
Date:   Wed, 9 Mar 2022 10:57:59 +0530
Message-ID: <1646803679-11433-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The process_madvise() system call returns error even after processing
some VMA's passed in the 'struct iovec' vector list which leaves the
user confused to know where to restart the advise next. It is also
against this syscall man page[1] documentation where it mentions that
"return value may be less than the total number of requested bytes, if
an error occurred after some iovec elements were already processed.".

Consider a user passed 10 VMA's in the 'struct iovec' vector list of
which 9 are processed but one. Then it just returns the error caused on
that failed VMA despite the first 9 VMA's processed, leaving the user
confused about on which VMA it is failed. Returning the number of bytes
processed here can help the user to know which VMA it is failed on and
thus can retry/skip the advise on that VMA.

[1]https://man7.org/linux/man-pages/man2/process_madvise.2.html.

Fixes: ecb8ac8b1f14("mm/madvise: introduce process_madvise() syscall: an external memory hinting API"
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/madvise.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 38d0f51..d3b49b3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1426,15 +1426,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	while (iov_iter_count(&iter)) {
 		iovec = iov_iter_iovec(&iter);
+		/*
+		 * Even when [start, end) passed to do_madvise covers
+		 * some unmapped addresses, it continues processing with
+		 * returning ENOMEM at the end. Thus consider the range
+		 * as processed when do_madvise() returns ENOMEM.
+		 * This makes process_madvise() never returns ENOMEM.
+		 */
 		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
 					iovec.iov_len, behavior);
-		if (ret < 0)
+		if (ret < 0 && ret != -ENOMEM)
 			break;
 		iov_iter_advance(&iter, iovec.iov_len);
 	}
 
-	if (ret == 0)
-		ret = total_len - iov_iter_count(&iter);
+	ret = (total_len - iov_iter_count(&iter)) ? : ret;
 
 release_mm:
 	mmput(mm);
-- 
2.7.4

