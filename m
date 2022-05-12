Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68F3524857
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351805AbiELIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351726AbiELIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:51:45 -0400
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0DD5DA01
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:51:39 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id DFACABF1D5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:51:37 +0100 (IST)
Received: (qmail 16579 invoked from network); 12 May 2022 08:51:37 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 12 May 2022 08:51:37 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/6] mm/page_alloc: Remove unnecessary page == NULL check in rmqueue
Date:   Thu, 12 May 2022 09:50:41 +0100
Message-Id: <20220512085043.5234-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512085043.5234-1-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
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

The VM_BUG_ON check for a valid page can be avoided with a simple
change in the flow. The ZONE_BOOSTED_WATERMARK is unlikely in general
and even more unlikely if the page allocation failed so mark the
branch unlikely.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/page_alloc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1c4c54503a5d..b543333dce8f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3765,17 +3765,18 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
 							migratetype);
-	if (unlikely(!page))
-		return NULL;
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
-	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
+	if (unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
 	}
 
-	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
+	if (unlikely(!page))
+		return NULL;
+
+	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 	return page;
 }
 
-- 
2.34.1

