Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E104ED403
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiCaGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiCaGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:40:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B51ED070
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648708736; x=1680244736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mHeEyGBnZF6p3AO3x4ap5fHK4uid7cBRJDPfLGdSF3o=;
  b=hTp8qJw1kB2wjREC8liu2tOtSRNR6tQUaHUPp1VC8UEBI+5yZwgdt7C3
   mQR4nvxuQHY7XDWDeODu0Tw956u/m6QeUF0gg7sQcBtVnWC+b8H8cvxuI
   JdvdlYkgQeXSG9FiZPj1bQ2JPbD7pXKjfno9CEDrtWyNPYgoAtrfHJ6QA
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Mar 2022 23:38:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:38:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 23:38:55 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 23:38:51 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <hughd@google.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH RESEND V5,1/2] mm: fadvise: move 'endbyte' calculations to helper function
Date:   Thu, 31 Mar 2022 12:08:20 +0530
Message-ID: <ff8e0629a5f6ad8cd1efd860d3218e0972edb9cb.1648706231.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1648706231.git.quic_charante@quicinc.com>
References: <cover.1648706231.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charan Teja Reddy <quic_charante@quicinc.com>

Move the 'endbyte' calculations that determines last byte that fadvise
can to a helper function. This is a preparatory change made for
shmem_fadvise() functionality in the next patch. No functional changes
in this patch.

Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
---
Changes in V5:
 -- Moved the 'endbyte' calculation to a helper function.
 -- This patch is newly raised in V5 thus no change exists from v1 to v4.

 mm/fadvise.c  | 11 +----------
 mm/internal.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index 338f160..0c82be2 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -65,16 +65,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		return 0;
 	}
 
-	/*
-	 * Careful about overflows. Len == 0 means "as much as possible".  Use
-	 * unsigned math because signed overflows are undefined and UBSan
-	 * complains.
-	 */
-	endbyte = (u64)offset + (u64)len;
-	if (!len || endbyte < len)
-		endbyte = -1;
-	else
-		endbyte--;		/* inclusive */
+	endbyte = fadvise_calc_endbyte(offset, len);
 
 	switch (advice) {
 	case POSIX_FADV_NORMAL:
diff --git a/mm/internal.h b/mm/internal.h
index 58dc6ad..b02f07e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -546,6 +546,27 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 #endif /* !CONFIG_MMU */
 
 /*
+ * Helper function to get the endbyte of a file that fadvise can operate on.
+ */
+static inline loff_t fadvise_calc_endbyte(loff_t offset, loff_t len)
+{
+	loff_t endbyte;
+
+	/*
+	 * Careful about overflows. Len == 0 means "as much as possible".  Use
+	 * unsigned math because signed overflows are undefined and UBSan
+	 * complains.
+	 */
+	endbyte = (u64)offset + (u64)len;
+	if (!len || endbyte < len)
+		endbyte = -1;
+	else
+		endbyte--;		/* inclusive */
+
+	return endbyte;
+}
+
+/*
  * Return the mem_map entry representing the 'offset' subpage within
  * the maximally aligned gigantic page 'base'.  Handle any discontiguity
  * in the mem_map at MAX_ORDER_NR_PAGES boundaries.
-- 
2.7.4

