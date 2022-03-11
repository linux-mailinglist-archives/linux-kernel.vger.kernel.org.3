Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246DB4D6000
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiCKKqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbiCKKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:46:09 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44E14F298
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646995507; x=1678531507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qyQGJ2He+N8AB6+cRhEVM5D86zlY5Me+dRbYbcq+MQQ=;
  b=zjFs+mB8Z/VI7FKR3lnS9zrjxWYgJPgwPVChWXnfa60w6ZPA0WJv/Pia
   gPJPAocJaaVo8bmeXxYaJJHQLfD/2eIluUN8yVUe7FAsa7Cgr2MBU3G2V
   OMFOCpjoB48nD+2UYv3cyqXgBv0KphxkTRoI0Ul6N07TmUtyo6spCkLxZ
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Mar 2022 02:45:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:45:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Mar 2022 02:45:05 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Mar 2022 02:45:00 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <markhemm@googlemail.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <mhocko@suse.com>, <surenb@google.com>, <shakeelb@google.com>,
        <willy@infradead.org>, <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH V5,1/2] mm: fadvise: move 'endbyte' calculations to helper function
Date:   Fri, 11 Mar 2022 16:13:51 +0530
Message-ID: <3dbba7655209709198b4e58ea677160732f3fb3f.1646987674.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1646987674.git.quic_charante@quicinc.com>
References: <cover.1646987674.git.quic_charante@quicinc.com>
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
index d6baa4f..086e929 100644
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
index d8030039..91bb17d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -506,6 +506,27 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
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

