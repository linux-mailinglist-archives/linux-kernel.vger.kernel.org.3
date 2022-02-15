Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6664B707C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiBOOxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:53:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbiBOOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:52:07 -0500
Received: from outbound-smtp47.blacknight.com (outbound-smtp47.blacknight.com [46.22.136.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB4A939CA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:51:34 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 34214FA89D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:51:33 +0000 (GMT)
Received: (qmail 14272 invoked from network); 15 Feb 2022 14:51:32 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 15 Feb 2022 14:51:32 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/5] mm/page_alloc: Fetch the correct pcp buddy during bulk free
Date:   Tue, 15 Feb 2022 14:51:07 +0000
Message-Id: <20220215145111.27082-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215145111.27082-1-mgorman@techsingularity.net>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
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

free_pcppages_bulk() prefetches buddies about to be freed but the
order must also be passed in as PCP lists store multiple orders.

Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..08de32cfd9bb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1432,10 +1432,10 @@ static bool bulkfree_pcp_prepare(struct page *page)
 }
 #endif /* CONFIG_DEBUG_VM */
 
-static inline void prefetch_buddy(struct page *page)
+static inline void prefetch_buddy(struct page *page, unsigned int order)
 {
 	unsigned long pfn = page_to_pfn(page);
-	unsigned long buddy_pfn = __find_buddy_pfn(pfn, 0);
+	unsigned long buddy_pfn = __find_buddy_pfn(pfn, order);
 	struct page *buddy = page + (buddy_pfn - pfn);
 
 	prefetch(buddy);
@@ -1512,7 +1512,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			 * prefetch buddy for the first pcp->batch nr of pages.
 			 */
 			if (prefetch_nr) {
-				prefetch_buddy(page);
+				prefetch_buddy(page, order);
 				prefetch_nr--;
 			}
 		} while (count > 0 && --batch_free && !list_empty(list));
-- 
2.31.1

