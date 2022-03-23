Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED54E552B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245160AbiCWP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiCWP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:26:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E643C706
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648049089; x=1679585089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PDhBafgZj3+zXDMLpR9U5QffixWseTxyOTJmwjftEEw=;
  b=K9acs0uGIIl/Wyd8currlai2EplH71NwNQNfFlBVIIVfHq5F1a9WoZob
   wq20y4owFU7J3QmvfXH4bkKPrft4Hk73w2DqMCr5dsILsMeF+ntHZmMLm
   R9/r9CMHRgHXjSppUk0ssXCgVMA+IA4RoBsOppqctiCexgaM8sxY5hHur
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Mar 2022 08:24:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:24:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 08:24:48 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 08:24:44 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <minchan@kernel.org>, <surenb@google.com>, <vbabka@suse.cz>,
        <rientjes@google.com>, <nadav.amit@gmail.com>,
        <edgararriaga@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH 1/2] Revert "mm: madvise: skip unmapped vma holes passed to process_madvise"
Date:   Wed, 23 Mar 2022 20:54:09 +0530
Message-ID: <e73da1304a88b6a8a11907045117cccf4c2b8374.1648046642.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1648046642.git.quic_charante@quicinc.com>
References: <cover.1648046642.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

This reverts commit 08095d6310a7 ("mm: madvise: skip unmapped vma holes
passed to process_madvise") as process_madvise() fails to return exact
processed bytes at other cases too. As an example: if the
process_madvise() hits mlocked pages after processing some initial bytes
passed in [start, end), it just returns EINVAL though some bytes are
processed. Thus making an exception only for ENOMEM is partially fixing
the problem of returning the proper advised bytes.

Thus revert this patch and return proper bytes advised, if there any,
for all the error types in the following patch.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/madvise.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 39b712f..0d8fd17 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1433,16 +1433,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	while (iov_iter_count(&iter)) {
 		iovec = iov_iter_iovec(&iter);
-		/*
-		 * do_madvise returns ENOMEM if unmapped holes are present
-		 * in the passed VMA. process_madvise() is expected to skip
-		 * unmapped holes passed to it in the 'struct iovec' list
-		 * and not fail because of them. Thus treat -ENOMEM return
-		 * from do_madvise as valid and continue processing.
-		 */
 		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
 					iovec.iov_len, behavior);
-		if (ret < 0 && ret != -ENOMEM)
+		if (ret < 0)
 			break;
 		iov_iter_advance(&iter, iovec.iov_len);
 	}
-- 
2.7.4

