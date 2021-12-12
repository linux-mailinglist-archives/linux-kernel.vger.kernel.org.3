Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0D4719CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhLLLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:32:25 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54824 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhLLLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:32:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V-JXZHb_1639308733;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-JXZHb_1639308733)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Dec 2021 19:32:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] mm: Update the speculative pages' accessing time
Date:   Sun, 12 Dec 2021 19:32:00 +0800
Message-Id: <c7d23137cbf56c3b0c81e98e3ed4676ca3e44dea.1639306956.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems with different memory types, including fast memory (DRAM)
and slow memory (persistent memory), which will rely on the numa balancing
to promote slow and hot memory to fast memory to improve performance.
After supporting the speculative numa fault, we can update the next pages'
accessing time to help to promote it to fast memory node easily to
improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 91122beb6e53..e19b10299913 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4556,10 +4556,21 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * to record page access time.  So use default value.
 	 */
 	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(page_nid))
+	    !node_is_toptier(page_nid)) {
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
-	else
+		/*
+		 * According to the data locality for some workloads, the
+		 * probability of accessing some data soon after some nearby
+		 * data has been accessed. So for tiered memory systems, we
+		 * can update the sequential page's age located on slow memory
+		 * type, to try to promote it to fast memory in advance to
+		 * improve the performance.
+		 */
+		if (vmf->address != fault_address)
+			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
+	} else {
 		last_cpupid = page_cpupid_last(page);
+	}
 	target_nid = numa_migrate_prep(page, vma, fault_address, page_nid,
 			&flags);
 	if (target_nid == NUMA_NO_NODE) {
-- 
2.27.0

