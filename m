Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4B4BDEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbiBUIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:46:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbiBUIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:46:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2913DEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645433159; x=1676969159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psltTbQSqTHI37Tn5wwsvdJ9MbHsDu951d9NJsQVf2A=;
  b=Z2fDi7dxatJxTep6hobC5GzgOo5KJgbztuhfb7XXLIoDoB1ae2g8W0wt
   os2ZrIPVX+qKKBUYYphb0/QMS4iJGSunrI0S38ouBTrqBtjV4H2KaWICE
   VQYBIwxxBcI4ncGUfrcFhCoMRw+PvTcCRGSfO1ahvF85uzR44Lz16Mr9u
   2fDf1rcoERulZLiYaxzZ4j6WKA4/271Zx92m8toZOBTCCIsi9iaHnjBzA
   8DokxvzGpwmfC5ATW40q0av2PDomgsaIfso06NNfyCZnEKstDcxjYjA3/
   r4nxwDOu9Utf+n+8zXVNL88NPNu8smFX7Yu2HX8CKtRfXgooUaXjR/8P/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249045817"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="249045817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:45:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="531774883"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:45:55 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V13 3/3] memory tiering: skip to scan fast memory
Date:   Mon, 21 Feb 2022 16:45:29 +0800
Message-Id: <20220221084529.1052339-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221084529.1052339-1-ying.huang@intel.com>
References: <20220221084529.1052339-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the NUMA balancing isn't used to optimize the page placement among
sockets but only among memory types, the hot pages in the fast memory
node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
to scan the pages in the fast memory node via changing their PTE/PMD
mapping to be PROT_NONE.  So that the page faults could be avoided
too.

In the test, if only the memory tiering NUMA balancing mode is enabled, the
number of the NUMA balancing hint faults for the DRAM node is reduced to
almost 0 with the patch.  While the benchmark score doesn't change
visibly.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/huge_memory.c | 30 +++++++++++++++++++++---------
 mm/mprotect.c    | 13 ++++++++++++-
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..9ce126cb0cfd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -34,6 +34,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1766,17 +1767,28 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 #endif
 
-	/*
-	 * Avoid trapping faults against the zero page. The read-only
-	 * data is likely to be read-cached on the local CPU and
-	 * local/remote hits to the zero page are not interesting.
-	 */
-	if (prot_numa && is_huge_zero_pmd(*pmd))
-		goto unlock;
+	if (prot_numa) {
+		struct page *page;
+		/*
+		 * Avoid trapping faults against the zero page. The read-only
+		 * data is likely to be read-cached on the local CPU and
+		 * local/remote hits to the zero page are not interesting.
+		 */
+		if (is_huge_zero_pmd(*pmd))
+			goto unlock;
 
-	if (prot_numa && pmd_protnone(*pmd))
-		goto unlock;
+		if (pmd_protnone(*pmd))
+			goto unlock;
 
+		page = pmd_page(*pmd);
+		/*
+		 * Skip scanning top tier node if normal numa
+		 * balancing is disabled
+		 */
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+		    node_is_toptier(page_to_nid(page)))
+			goto unlock;
+	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
 	 * to not clear pmd intermittently to avoid race with MADV_DONTNEED
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0138dfcdb1d8..2fe03e695c81 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
+#include <linux/sched/sysctl.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -83,6 +84,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			 */
 			if (prot_numa) {
 				struct page *page;
+				int nid;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -109,7 +111,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */
-				if (target_node == page_to_nid(page))
+				nid = page_to_nid(page);
+				if (target_node == nid)
+					continue;
+
+				/*
+				 * Skip scanning top tier node if normal numa
+				 * balancing is disabled
+				 */
+				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+				    node_is_toptier(nid))
 					continue;
 			}
 
-- 
2.30.2

