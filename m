Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600952D235
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiESMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiESMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:13:49 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C17A833
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:13:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 5B084FAD39
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:13:44 +0100 (IST)
Received: (qmail 28743 invoked from network); 19 May 2022 12:13:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 May 2022 12:13:44 -0000
Date:   Thu, 19 May 2022 13:13:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 4/6] mm/page_alloc: Remove unnecessary page == NULL check
 in rmqueue
Message-ID: <20220519121341.GV3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-5-mgorman@techsingularity.net>
 <5a0c9b7c-3620-3e0f-7510-d0fc3fa6ceda@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5a0c9b7c-3620-3e0f-7510-d0fc3fa6ceda@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 12:57:01PM +0200, Vlastimil Babka wrote:
> On 5/12/22 10:50, Mel Gorman wrote:
> > The VM_BUG_ON check for a valid page can be avoided with a simple
> > change in the flow. The ZONE_BOOSTED_WATERMARK is unlikely in general
> > and even more unlikely if the page allocation failed so mark the
> > branch unlikely.
> 
> Hm, so that makes a DEBUG_VM config avoid the check. On the other hand,
> it puts it on the path returning from rmqueue_pcplist() for all configs,
> and that should be the fast path. So unless things further change in the
> following patches, it doesn't seem that useful?
> 

You're right -- the fast path ends up with both a if
(page) and if (!page) checks. Andrew, can you drop the patch
mm-page_alloc-remove-unnecessary-page-==-null-check-in-rmqueue.patch from
your tree please?

Originally the flow was important when I was writing the patch and later
became unnecessary. However, it reminded me of another problem I thought
of when writing this and then forgotten to note it in the changelog. If
the page allocation fails then ZONE_BOOSTED_WATERMARK should still be
tested and cleared before waking kswapd. It could happen if an allocation
attempt tried to fallback to another migratetype and still fail to find
a suitable page. This is true whether going through the PCP lists or not.

So what do you think of me adding this patch to a follow-up series?

--8<--
mm/page_alloc: Remove mistaken page == NULL check in rmqueue

If a page allocation fails, the ZONE_BOOSTER_WATERMARK should be tested,
cleared and kswapd woken whether the allocation attempt was via the PCP
or directly via the buddy list.

Remove the page == NULL so the ZONE_BOOSTED_WATERMARK bit is checked
unconditionally. As it is unlikely that ZONE_BOOSTED_WATERMARK is set,
mark the branch accordingly.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1c4c54503a5d..61d5bc2efffe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3765,12 +3765,10 @@ struct page *rmqueue(struct zone *preferred_zone,
 
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
