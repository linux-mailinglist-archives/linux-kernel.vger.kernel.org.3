Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D457FB92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiGYImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiGYImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:42:15 -0400
Received: from outbound-smtp63.blacknight.com (outbound-smtp63.blacknight.com [46.22.136.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C914036
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:42:13 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 0FE8BFAC5F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:42:12 +0100 (IST)
Received: (qmail 26044 invoked from network); 25 Jul 2022 08:42:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Jul 2022 08:42:11 -0000
Date:   Mon, 25 Jul 2022 09:42:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gh21.hong@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com
Subject: Re: [PATCH] page_alloc: fix invalid watemark check on a negative
 value
Message-ID: <20220725084204.52kdi6jyjhytzudm@techsingularity.net>
References: <CGME20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67@epcas1p4.samsung.com>
 <20220725012843.17115-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220725012843.17115-1-jaewon31.kim@samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:28:43AM +0900, Jaewon Kim wrote:
> There was a report that a task is waiting at the
> throttle_direct_reclaim. The pgscan_direct_throttle in vmstat was
> increasing.
> 
> This is a bug where zone_watermark_fast returns true even when the free
> is very low. The commit f27ce0e14088 ("page_alloc: consider highatomic
> reserve in watermark fast") changed the watermark fast to consider
> highatomic reserve. But it did not handle a negative value case which
> can be happened when reserved_highatomic pageblock is bigger than the
> actual free.
> 
> If watermark is considered as ok for the negative value, allocating
> contexts for order-0 will consume all free pages without direct reclaim,
> and finally free page may become depleted except highatomic free.
> 
> Then allocating contexts may fall into throttle_direct_reclaim. This
> symptom may easily happen in a system where wmark min is low and other
> reclaimers like kswapd does not make free pages quickly.
> 
> To handle the negative value, get the value as long type like
> __zone_watermark_ok does.
> 
> Reported-by: GyeongHwan Hong <gh21.hong@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>

Add

Fixes: f27ce0e14088 ("page_alloc: consider highatomic reserve in watermark fast")

The fix is fine as-is but it's not immediately obvious why this
can wrap negative as it depends on an implementation detail of
__zone_watermark_unusable_free.  The variable copy just to change the sign
could get accidentally "fixed" later as a micro-optimisation (same if the
type of mark was changed) so maybe leave a comment like

                /* unusable may over-estimate high-atomic reserves */

Otherwise

Acked-by: Mel Gorman <mgorman@techsingularity.net>

The problem could also be made explicit with something like below. I know
you are copying the logic of __zone_watermark_ok but I don't think min
can go negative there.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 934d1b5a5449..f8f50a2aa43e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4048,11 +4048,15 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	 * need to be calculated.
 	 */
 	if (!order) {
-		long fast_free;
+		long usable_free;
+		long reserved;
 
-		fast_free = free_pages;
-		fast_free -= __zone_watermark_unusable_free(z, 0, alloc_flags);
-		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
+		usable_free = free_pages;
+		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
+
+		/* reserved may over estimate high-atomic reserves. */
+		usable_free -= min(usable_free, reserved);
+		if (usable_free > mark + z->lowmem_reserve[highest_zoneidx])
 			return true;
 	}
 
-- 
Mel Gorman
SUSE Labs
