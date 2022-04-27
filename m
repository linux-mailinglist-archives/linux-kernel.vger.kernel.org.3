Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F77512468
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiD0VSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiD0VSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:18:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E005546AA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=TFrJcbLwX5GRyufhZzdlXa/G/r1hY3v4EV/ONC1zsQM=; b=s84EJCFbY6Q4BkBC74n0e/RbKv
        FMBh44tvk/MUv0vJx7qBuJqQCM/2vJ/3hYZlHCt5MCxdcK3uaSMzrHzmIcuOJo1vZZ6uEGwVyZeTy
        B3tFEcNbjigSHhPPTVqHEHNknhM4nNalqt+CP7B9ueH2AbI3HVWDgh64RWYElCe3H/fNN5meKAzDr
        1xm5iJUaoSOHMO4rrbYSPpgZGucSXeTVunyURMFNRI8tEhn6FPYRDPgM8q+xLsYkVCMUwsmsnCF4R
        dNW6PKYuvvzS2eTEOrK+/eApZPlMrSQ50TaaaA0tzM+vyyKhMeimXUvS/iQzkL2VqA6/xEDn+/M8M
        YJ2kpRrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njp0L-00AuQG-Fr; Wed, 27 Apr 2022 21:15:21 +0000
Date:   Wed, 27 Apr 2022 22:15:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, fangwei1@huawei.com
Subject: Re: Questions about folio allocation.
Message-ID: <YmmyabimiAo40XeS@casper.infradead.org>
References: <20220424113543.456342-1-guoxuenan@huawei.com>
 <YmU2izhF0HDlgbrW@casper.infradead.org>
 <77b76283-cec5-94a8-9bfe-34ea24c55b82@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77b76283-cec5-94a8-9bfe-34ea24c55b82@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:30:26PM +0800, Guo Xuenan wrote:
> Hmm.. sorry my expression is not rigorous enough, but i think you have got
> it partly.
> Read the whole file but not only 100k * 4, in most case page order is 2,
> which means
> that in this way of reading,the order of folio with readahead flag is 0 in
> most case.
> 
> [root@localhost ]# echo 4096 > /sys/block/vdb/queue/read_ahead_kb
> [root@localhost ]# echo 4096 > /sys/block/vdb/queue/max_sectors_kb
> [root@localhost ]# bpftrace bpf.bt  > 100K
> [root@localhost ]# cat 100K | awk '{print $11}' | sort | uniq -c
>     884 0
>    55945 2
>      1 3
>      14 4
>      2 5
>      5 6
> 
> According to the readahead code, the inital order is from current folio with
> readahead flag,
> may the inital order based on size of readadhead window is better?
> (eg: ra->size big enough and considering index alignment then set the
> order?)

Try this patch; it should fix the problem you're seeing.  At least, it
does in my tests.


From 89539907eb14b0723d457e77a18cc5af5e13db8f Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 27 Apr 2022 17:01:28 -0400
Subject: [PATCH] mm/readahead: Fix readahead with large folios

Reading 100KB chunks from a big file (eg dd bs=100K) leads to poor
readahead behaviour.  Studying the traces in detail, I noticed two
problems.

The first is that we were setting the readahead flag on the folio which
contains the last byte read from the block.  This is wrong because we
will trigger readahead at the end of the read without waiting to see
if a subsequent read is going to use the pages we just read.  Instead,
we need to set the readahead flag on the first folio _after_ the one
which contains the last byte that we're reading.

The second is that we were looking for the index of the folio with the
readahead flag set to exactly match the start + size - async_size.
If we've rounded this, either down (as previously) or up (as now),
we'll think we hit a folio marked as readahead by a different read,
and try to read the wrong pages.  So round the expected index to the
order of the folio we hit.

Reported-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8e3775829513..4a60cdb64262 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -474,7 +474,8 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 
 	if (!folio)
 		return -ENOMEM;
-	if (mark - index < (1UL << order))
+	mark = round_up(mark, 1UL << order);
+	if (index == mark)
 		folio_set_readahead(folio);
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
 	if (err)
@@ -555,8 +556,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
-	unsigned long index = readahead_index(ractl);
-	pgoff_t prev_index;
+	pgoff_t index = readahead_index(ractl);
+	pgoff_t expected, prev_index;
+	unsigned int order = folio ? folio_order(folio) : 0;
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -575,8 +577,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * It's the expected callback index, assume sequential access.
 	 * Ramp up sizes, and push forward the readahead window.
 	 */
-	if ((index == (ra->start + ra->size - ra->async_size) ||
-	     index == (ra->start + ra->size))) {
+	expected = round_up(ra->start + ra->size - ra->async_size,
+			1UL << order);
+	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
 		ra->size = get_next_ra_size(ra, max_pages);
 		ra->async_size = ra->size;
@@ -662,7 +665,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	ractl->_index = ra->start;
-	page_cache_ra_order(ractl, ra, folio ? folio_order(folio) : 0);
+	page_cache_ra_order(ractl, ra, order);
 }
 
 void page_cache_sync_ra(struct readahead_control *ractl,
-- 
2.34.1

