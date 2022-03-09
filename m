Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC114D2F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiCIMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiCIMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:33:49 -0500
Received: from outbound-smtp21.blacknight.com (outbound-smtp21.blacknight.com [81.17.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD7623BCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:32:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 3617CCCB03
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:32:47 +0000 (GMT)
Received: (qmail 26046 invoked from network); 9 Mar 2022 12:32:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Mar 2022 12:32:46 -0000
Date:   Wed, 9 Mar 2022 12:32:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
Message-ID: <20220309123245.GI15701@techsingularity.net>
References: <20220304170215.1868106-1-eric.dumazet@gmail.com>
 <20220307091541.GD15701@techsingularity.net>
 <CANn89iLmwT4XQ6JPi4C7dO+Q2O_j7HK19-TAo4nA1NUf8ZSLBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CANn89iLmwT4XQ6JPi4C7dO+Q2O_j7HK19-TAo4nA1NUf8ZSLBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 03:49:48PM -0800, Eric Dumazet wrote:
> On Mon, Mar 7, 2022 at 1:15 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Mar 04, 2022 at 09:02:15AM -0800, Eric Dumazet wrote:
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > For high order pages not using pcp, rmqueue() is currently calling
> > > the costly check_new_pages() while zone spinlock is held,
> > > and hard irqs masked.
> > >
> > > This is not needed, we can release the spinlock sooner to reduce
> > > zone spinlock contention.
> > >
> > > Note that after this patch, we call __mod_zone_freepage_state()
> > > before deciding to leak the page because it is in bad state.
> > >
> > > v2: We need to keep interrupts disabled to call __mod_zone_freepage_state()
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: Wei Xu <weixugc@google.com>
> > > Cc: Greg Thelen <gthelen@google.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: David Rientjes <rientjes@google.com>
> >
> > Ok, this is only more expensive in the event pages on the free list have
> > been corrupted whch is already very unlikely so thanks!
> >
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> >
> 
> One remaining question is:
> 
> After your patch ("mm/page_alloc: allow high-order pages to be stored
> on the per-cpu lists"),
> do we want to change check_pcp_refill()/check_new_pcp() to check all pages,
> and not only the head ?
> 

We should because it was an oversight. Thanks for pointing that out.

> Or was it a conscious choice of yours ?
> (I presume part of the performance gains came from
> not having to bring ~7 cache lines per 32KB chunk on x86)
> 

There will be a performance penalty due to the check but it's a correctness
vs performance issue.

This? It's boot tested only.

--8<--
mm/page_alloc: check high-order pages for corruption during PCP operations

Eric Dumazet pointed out that commit 44042b449872 ("mm/page_alloc: allow
high-order pages to be stored on the per-cpu lists") only checks the head
page during PCP refill and allocation operations. This was an oversight
and all pages should be checked. This will incur a small performance
penalty but it's necessary for correctness.

Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..2920344fa887 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2342,23 +2342,36 @@ static inline int check_new_page(struct page *page)
 	return 1;
 }
 
+static bool check_new_pages(struct page *page, unsigned int order)
+{
+	int i;
+	for (i = 0; i < (1 << order); i++) {
+		struct page *p = page + i;
+
+		if (unlikely(check_new_page(p)))
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_DEBUG_VM
 /*
  * With DEBUG_VM enabled, order-0 pages are checked for expected state when
  * being allocated from pcp lists. With debug_pagealloc also enabled, they are
  * also checked when pcp lists are refilled from the free lists.
  */
-static inline bool check_pcp_refill(struct page *page)
+static inline bool check_pcp_refill(struct page *page, unsigned int order)
 {
 	if (debug_pagealloc_enabled_static())
-		return check_new_page(page);
+		return check_new_pages(page, order);
 	else
 		return false;
 }
 
-static inline bool check_new_pcp(struct page *page)
+static inline bool check_new_pcp(struct page *page, unsigned int order)
 {
-	return check_new_page(page);
+	return check_new_pages(page, order);
 }
 #else
 /*
@@ -2366,32 +2379,19 @@ static inline bool check_new_pcp(struct page *page)
  * when pcp lists are being refilled from the free lists. With debug_pagealloc
  * enabled, they are also checked when being allocated from the pcp lists.
  */
-static inline bool check_pcp_refill(struct page *page)
+static inline bool check_pcp_refill(struct page *page, unsigned int order)
 {
-	return check_new_page(page);
+	return check_new_pages(page, order);
 }
-static inline bool check_new_pcp(struct page *page)
+static inline bool check_new_pcp(struct page *page, unsigned int order)
 {
 	if (debug_pagealloc_enabled_static())
-		return check_new_page(page);
+		return check_new_pages(page, order);
 	else
 		return false;
 }
 #endif /* CONFIG_DEBUG_VM */
 
-static bool check_new_pages(struct page *page, unsigned int order)
-{
-	int i;
-	for (i = 0; i < (1 << order); i++) {
-		struct page *p = page + i;
-
-		if (unlikely(check_new_page(p)))
-			return true;
-	}
-
-	return false;
-}
-
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
@@ -3037,7 +3037,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (unlikely(page == NULL))
 			break;
 
-		if (unlikely(check_pcp_refill(page)))
+		if (unlikely(check_pcp_refill(page, order)))
 			continue;
 
 		/*
@@ -3641,7 +3641,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		page = list_first_entry(list, struct page, lru);
 		list_del(&page->lru);
 		pcp->count -= 1 << order;
-	} while (check_new_pcp(page));
+	} while (check_new_pcp(page, order));
 
 	return page;
 }
