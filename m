Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2E524850
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351754AbiELIvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351744AbiELIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:51:21 -0400
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294AE5713D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:51:18 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id B9F0F3133
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:51:16 +0100 (IST)
Received: (qmail 15363 invoked from network); 12 May 2022 08:51:16 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 12 May 2022 08:51:16 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/6] mm/page_alloc: Use only one PCP list for THP-sized allocations
Date:   Thu, 12 May 2022 09:50:39 +0100
Message-Id: <20220512085043.5234-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512085043.5234-1-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per_cpu_pages is cache-aligned on a standard x86-64 distribution
configuration but a later patch will add a new field which would push
the structure into the next cache line. Use only one list to store
THP-sized pages on the per-cpu list. This assumes that the vast majority
of THP-sized allocations are GFP_MOVABLE but even if it was another type,
it would not contribute to serious fragmentation that potentially causes
a later THP allocation failure. Align per_cpu_pages on the cacheline
boundary to ensure there is no false cache sharing.

After this patch, the structure sizing is;

struct per_cpu_pages {
        int                        count;                /*     0     4 */
        int                        high;                 /*     4     4 */
        int                        batch;                /*     8     4 */
        short int                  free_factor;          /*    12     2 */
        short int                  expire;               /*    14     2 */
        struct list_head           lists[13];            /*    16   208 */

        /* size: 256, cachelines: 4, members: 6 */
        /* padding: 32 */
} __attribute__((__aligned__(64)));

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/mmzone.h | 11 +++++++----
 mm/page_alloc.c        |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 962b14d403e8..abe530748de6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -358,15 +358,18 @@ enum zone_watermarks {
 };
 
 /*
- * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER plus one additional
- * for pageblock size for THP if configured.
+ * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
+ * for THP which will usually be GFP_MOVABLE. Even if it is another type,
+ * it should not contribute to serious fragmentation causing THP allocation
+ * failures.
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define NR_PCP_THP 1
 #else
 #define NR_PCP_THP 0
 #endif
-#define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
+#define NR_LOWORDER_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1))
+#define NR_PCP_LISTS (NR_LOWORDER_PCP_LISTS + NR_PCP_THP)
 
 /*
  * Shift to encode migratetype and order in the same integer, with order
@@ -392,7 +395,7 @@ struct per_cpu_pages {
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
 	struct list_head lists[NR_PCP_LISTS];
-};
+} ____cacheline_aligned_in_smp;
 
 struct per_cpu_zonestat {
 #ifdef CONFIG_SMP
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f58f85fdb05f..5851ee88a89c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -648,7 +648,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != pageblock_order);
-		base = PAGE_ALLOC_COSTLY_ORDER + 1;
+		return NR_LOWORDER_PCP_LISTS;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
@@ -662,7 +662,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (order > PAGE_ALLOC_COSTLY_ORDER)
+	if (pindex == NR_LOWORDER_PCP_LISTS)
 		order = pageblock_order;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.34.1

