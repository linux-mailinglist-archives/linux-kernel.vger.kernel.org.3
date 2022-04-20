Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9DF508583
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377514AbiDTKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiDTKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:11:36 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 03:08:51 PDT
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7E1D321
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:08:51 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 23FA7FAE49
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:59:50 +0100 (IST)
Received: (qmail 11477 invoked from network); 20 Apr 2022 09:59:49 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 Apr 2022 09:59:49 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/6] mm/page_alloc: Split out buddy removal code from rmqueue into separate helper
Date:   Wed, 20 Apr 2022 10:59:03 +0100
Message-Id: <20220420095906.27349-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420095906.27349-1-mgorman@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation page to allow the buddy removal code to be reused
in a later patch.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 87 ++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ed2deb93a758..4c1acf666056 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3622,6 +3622,46 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
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
+		if (order > 0 && alloc_flags & ALLOC_HARDER) {
+			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+			if (page)
+				trace_mm_page_alloc_zone_locked(page, order, migratetype);
+		}
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
@@ -3702,9 +3742,14 @@ struct page *rmqueue(struct zone *preferred_zone,
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
@@ -3718,38 +3763,10 @@ struct page *rmqueue(struct zone *preferred_zone,
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
-		if (order > 0 && alloc_flags & ALLOC_HARDER) {
-			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-			if (page)
-				trace_mm_page_alloc_zone_locked(page, order, migratetype);
-		}
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
@@ -3760,10 +3777,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
 	return page;
-
-failed:
-	spin_unlock_irqrestore(&zone->lock, flags);
-	return NULL;
 }
 
 #ifdef CONFIG_FAIL_PAGE_ALLOC
-- 
2.34.1

