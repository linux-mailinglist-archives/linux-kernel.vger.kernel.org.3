Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85855599F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFXMzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFXMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:55:09 -0400
Received: from outbound-smtp59.blacknight.com (outbound-smtp59.blacknight.com [46.22.136.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BD64F9F9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:55:08 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp59.blacknight.com (Postfix) with ESMTPS id B50CBFAC5D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:55:06 +0100 (IST)
Received: (qmail 7825 invoked from network); 24 Jun 2022 12:55:06 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 24 Jun 2022 12:55:06 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/7] mm/page_alloc: Split out buddy removal code from rmqueue into separate helper
Date:   Fri, 24 Jun 2022 13:54:19 +0100
Message-Id: <20220624125423.6126-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220624125423.6126-1-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation page to allow the buddy removal code to be reused in
a later patch.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 81 ++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index febd97f4a2fc..44d198af4b35 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3637,6 +3637,43 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 #endif
 }
 
+static __always_inline
+struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
+			   unsigned int order, unsigned int alloc_flags,
+			   int migratetype)
+{
+	struct page *page;
+	unsigned long flags;
+
+	do {
+		page = NULL;
+		spin_lock_irqsave(&zone->lock, flags);
+		/*
+		 * order-0 request can reach here when the pcplist is skipped
+		 * due to non-CMA allocation context. HIGHATOMIC area is
+		 * reserved for high-order atomic allocation, so order-0
+		 * request should skip it.
+		 */
+		if (order > 0 && alloc_flags & ALLOC_HARDER)
+			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+		if (!page) {
+			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			if (!page) {
+				spin_unlock_irqrestore(&zone->lock, flags);
+				return NULL;
+			}
+		}
+		__mod_zone_freepage_state(zone, -(1 << order),
+					  get_pcppage_migratetype(page));
+		spin_unlock_irqrestore(&zone->lock, flags);
+	} while (check_new_pages(page, order));
+
+	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
+	zone_statistics(preferred_zone, zone, 1);
+
+	return page;
+}
+
 /* Remove page from the per-cpu list, caller must protect the list */
 static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
@@ -3717,9 +3754,14 @@ struct page *rmqueue(struct zone *preferred_zone,
 			gfp_t gfp_flags, unsigned int alloc_flags,
 			int migratetype)
 {
-	unsigned long flags;
 	struct page *page;
 
+	/*
+	 * We most definitely don't want callers attempting to
+	 * allocate greater than order-1 page units with __GFP_NOFAIL.
+	 */
+	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
+
 	if (likely(pcp_allowed_order(order))) {
 		/*
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
@@ -3733,35 +3775,10 @@ struct page *rmqueue(struct zone *preferred_zone,
 		}
 	}
 
-	/*
-	 * We most definitely don't want callers attempting to
-	 * allocate greater than order-1 page units with __GFP_NOFAIL.
-	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-
-	do {
-		page = NULL;
-		spin_lock_irqsave(&zone->lock, flags);
-		/*
-		 * order-0 request can reach here when the pcplist is skipped
-		 * due to non-CMA allocation context. HIGHATOMIC area is
-		 * reserved for high-order atomic allocation, so order-0
-		 * request should skip it.
-		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER)
-			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
-			if (!page)
-				goto failed;
-		}
-		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
-		spin_unlock_irqrestore(&zone->lock, flags);
-	} while (check_new_pages(page, order));
-
-	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
-	zone_statistics(preferred_zone, zone, 1);
+	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
+							migratetype);
+	if (unlikely(!page))
+		return NULL;
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3772,10 +3789,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
 	return page;
-
-failed:
-	spin_unlock_irqrestore(&zone->lock, flags);
-	return NULL;
 }
 
 #ifdef CONFIG_FAIL_PAGE_ALLOC
-- 
2.35.3

