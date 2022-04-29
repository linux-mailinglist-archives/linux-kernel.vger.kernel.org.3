Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE52514510
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiD2JIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiD2JIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:08:39 -0400
Received: from outbound-smtp20.blacknight.com (outbound-smtp20.blacknight.com [46.22.139.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E137BDC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:05:19 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 734271C4674
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:05:16 +0100 (IST)
Received: (qmail 24973 invoked from network); 29 Apr 2022 09:05:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Apr 2022 09:05:16 -0000
Date:   Fri, 29 Apr 2022 10:05:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
Message-ID: <20220429090511.GA3441@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <20220420095906.27349-6-mgorman@techsingularity.net>
 <YmhHCHaUy+zARWxi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YmhHCHaUy+zARWxi@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:24:56PM -0700, Minchan Kim wrote:
> > @@ -3450,10 +3496,19 @@ void free_unref_page(struct page *page, unsigned int order)
> >  void free_unref_page_list(struct list_head *list)
> >  {
> >  	struct page *page, *next;
> > +	struct per_cpu_pages *pcp;
> > +	struct zone *locked_zone;
> >  	unsigned long flags;
> >  	int batch_count = 0;
> >  	int migratetype;
> >  
> > +	/*
> > +	 * An empty list is possible. Check early so that the later
> > +	 * lru_to_page() does not potentially read garbage.
> > +	 */
> > +	if (list_empty(list))
> > +		return;
> > +
> >  	/* Prepare pages for freeing */
> >  	list_for_each_entry_safe(page, next, list, lru) {
> >  		unsigned long pfn = page_to_pfn(page);
> > @@ -3474,8 +3529,26 @@ void free_unref_page_list(struct list_head *list)
> >  		}
> >  	}
> >  
> > +	VM_BUG_ON(in_hardirq());
> 
> You need to check the list_empty here again and bail out if it is.
> 

You're right, every page could have failed to prepare or was isolated.

-- 
Mel Gorman
SUSE Labs
