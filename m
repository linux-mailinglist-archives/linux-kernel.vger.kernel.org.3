Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A584523550
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiEKOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbiEKOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:23:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0219B64BC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:23:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CBDE1F8B4;
        Wed, 11 May 2022 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652278990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xD3/QEILxbkXd9LbTfoyaU7XN9dW0NYEfVuLDPsITXU=;
        b=XosQ4uH0cgBdXFuFHSBICXfZjVDKzSlp484V43bI+ZisGscnUp7KyMqB52HXqoullrmeOK
        gbdCM7fyNx1FnzqiL81GCsQupdkOu8kz9+OweJ2YNR685BOZotvhlCprTAavb/VUWyYzAn
        5grwiDqw9guq9qkj7pkNBMQ+G1x4lr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652278990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xD3/QEILxbkXd9LbTfoyaU7XN9dW0NYEfVuLDPsITXU=;
        b=vnw70Mkgdte5aGdvUwofLtyi/KyjgXev43LoBdPt5+SedcfaDIgtSdfNWJnz/CjPAtBZfv
        8IJLG5it69npjQAQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D14102C141;
        Wed, 11 May 2022 14:23:05 +0000 (UTC)
Date:   Wed, 11 May 2022 15:23:03 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: Fix tracepoint mm_page_alloc_zone_locked()
Message-ID: <20220511142303.GN20579@suse.de>
References: <20220511081207.132034-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220511081207.132034-1-vvghjk1234@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:12:07PM +0900, Wonhyuk Yang wrote:
> Currently, trace point mm_page_alloc_zone_locked() doesn't show
> correct information.
> 
> First, when alloc_flag has ALLOC_HARDER/ALLOC_CMA, page can
> be allocated from MIGRATE_HIGHATOMIC/MIGRATE_CMA. Nevertheless,
> tracepoint use requested migration type not MIGRATE_HIGHATOMIC and
> MIGRATE_CMA.
> 
> Second, after Commit 44042b4498728 ("mm/page_alloc: allow high-order
> pages to be stored on the per-cpu lists") percpu-list can store
> high order pages. But trace point determine whether it is a refiil
> of percpu-list by comparing requested order and 0.
> 
> To handle these problems, use cached migration type by
> get_pcppage_migratetype() instead of requested migration type.
> Then, make mm_page_alloc_zone_locked() be called only two contexts
> (rmqueue_bulk, rmqueue). With a new argument called percpu_refill,
> it can show whether it is a refill of percpu-list correctly.
> 

You're definitely right that the current tracepoint is broken.

I got momentarily confused because HIGHATOMIC and CMA are not stored on
PCP lists even though they are a pageblock migrate type. Superficially
calling get_pcppage_migratetype on a page that cannot be a PCP page
seems silly but in the context of this patch, it happens to work because
it was isolated with __rmqueue_smallest which sets the PCP type even if
the page is not going to a PCP list.

The original intent of that tracepoint was to trace when pages were
removed from the buddy list. That would suggest this untested patch on
top of yours as a simplication;

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0351808322ba..66a70b898130 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2476,6 +2476,8 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
 		set_pcppage_migratetype(page, migratetype);
+		trace_mm_page_alloc_zone_locked(page, order, migratetype,
+			pcp_allowed_order(order) && migratetype < MIGRATE_PCPTYPES);
 		return page;
 	}
 
@@ -3025,7 +3027,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			int migratetype, unsigned int alloc_flags)
 {
 	int i, allocated = 0;
-	int mt;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3053,9 +3054,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 */
 		list_add_tail(&page->lru, list);
 		allocated++;
-		mt = get_pcppage_migratetype(page);
-		trace_mm_page_alloc_zone_locked(page, order, mt, true);
-		if (is_migrate_cma(mt))
+		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
 	}
@@ -3704,7 +3703,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 {
 	unsigned long flags;
 	struct page *page;
-	int mt;
 
 	if (likely(pcp_allowed_order(order))) {
 		/*
@@ -3734,17 +3732,15 @@ struct page *rmqueue(struct zone *preferred_zone,
 		 * reserved for high-order atomic allocation, so order-0
 		 * request should skip it.
 		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER) {
+		if (order > 0 && alloc_flags & ALLOC_HARDER)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-		}
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 			if (!page)
 				goto failed;
 		}
-		mt = get_pcppage_migratetype(page);
-		trace_mm_page_alloc_zone_locked(page, order, mt, false);
-		__mod_zone_freepage_state(zone, -(1 << order), mt);
+		__mod_zone_freepage_state(zone, -(1 << order),
+					  get_pcppage_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
