Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B89549A29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbiFMRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiFMReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:34:44 -0400
Received: from outbound-smtp01.blacknight.com (outbound-smtp01.blacknight.com [81.17.249.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7416541A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:57:16 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 9DE02C4A2C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:57:14 +0100 (IST)
Received: (qmail 29193 invoked from network); 13 Jun 2022 12:57:14 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 13 Jun 2022 12:57:14 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/7] mm/page_alloc: Remove mistaken page == NULL check in rmqueue
Date:   Mon, 13 Jun 2022 13:56:19 +0100
Message-Id: <20220613125622.18628-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613125622.18628-1-mgorman@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
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

If a page allocation fails, the ZONE_BOOSTER_WATERMARK should be tested,
cleared and kswapd woken whether the allocation attempt was via the PCP
or directly via the buddy list.

Remove the page == NULL so the ZONE_BOOSTED_WATERMARK bit is checked
unconditionally. As it is unlikely that ZONE_BOOSTED_WATERMARK is set,
mark the branch accordingly.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 44d198af4b35..7fb262eeec2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3777,12 +3777,10 @@ struct page *rmqueue(struct zone *preferred_zone,
 
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
-- 
2.35.3

