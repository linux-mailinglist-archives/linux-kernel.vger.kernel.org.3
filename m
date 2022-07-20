Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9837457B384
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiGTJK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiGTJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:10:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783762FE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:10:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C73A37585;
        Wed, 20 Jul 2022 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658308221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAdq3+Dl59dOrtqGUadXbH90BiOSvY1QRdbnjHxitEY=;
        b=koq0O3YT0a8AFx9ViFLP55NVJSwPRrVN9orjcew1VcG7KtPIbpJQaHt331bBg7aQuI76bU
        cfezxUbxmK01wnYRU+2iJefDIrsaAMCCQoCtkhlPxPnz98nWB8RMki78YicWB9pg+DDG9w
        D9i8k5rGU7iX0TWgEj5v+2tYuYfUsSY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B92EB2C141;
        Wed, 20 Jul 2022 09:10:17 +0000 (UTC)
Date:   Wed, 20 Jul 2022 11:10:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YtfGeUUoi9cq3g0A@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
 <20220720082112.GA14437@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720082112.GA14437@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-07-22 13:51:12, Pavan Kondeti wrote:
> Hi Charan,
> 
> On Tue, Jul 19, 2022 at 08:42:42PM +0530, Charan Teja Kalla wrote:
> > Thanks Michal!!
> > 
> > On 7/18/2022 8:24 PM, Michal Hocko wrote:
> > >>>> The above mentioned race is just one example __but the problem persists
> > >>>> in the other paths too involving page_ext->flags access(eg:
> > >>>> page_is_idle())__. Since offline waits till the last reference on the
> > >>>> page goes down i.e. any path that took the refcount on the page can make
> > >>>> the memory offline operation to wait. Eg: In the migrate_pages()
> > >>>> operation, we do take the extra refcount on the pages that are under
> > >>>> migration and then we do copy page_owner by accessing page_ext. For
> > >>>>
> > >>>> Fix those paths where offline races with page_ext access by maintaining
> > >>>> synchronization with rcu lock.
> > >>> Please be much more specific about the synchronization. How does RCU
> > >>> actually synchronize the offlining and access? Higher level description
> > >>> of all the actors would be very helpful not only for the review but also
> > >>> for future readers.
> > >> I will improve the commit message about this synchronization change
> > >> using RCU's.
> > > Thanks! The most imporant part is how the exclusion is actual achieved
> > > because that is not really clear at first sight
> > > 
> > > CPU1					CPU2
> > > lookup_page_ext(PageA)			offlining
> > > 					  offline_page_ext
> > > 					    __free_page_ext(addrA)
> > > 					      get_entry(addrA)
> > > 					      ms->page_ext = NULL
> > > 					      synchronize_rcu()
> > > 					      free_page_ext
> > > 					        free_pages_exact (now addrA is unusable)
> > > 					
> > >   rcu_read_lock()
> > >   entryA = get_entry(addrA)
> > >     base + page_ext_size * index # an address not invalidated by the freeing path
> > >   do_something(entryA)
> > >   rcu_read_unlock()
> > > 
> > > CPU1 never checks ms->page_ext so it cannot bail out early when the
> > > thing is torn down. Or maybe I am missing something. I am not familiar
> > > with page_ext much.
> > 
> > 
> > Thanks a lot for catching this Michal. You are correct that the proposed
> > code from me is still racy. I Will correct this along with the proper
> > commit message in the next version of this patch.
> > 
> 
> Trying to understand your discussion with Michal. What part is still racy? We
> do check for mem_section::page_ext and bail out early from lookup_page_ext(),
> no?
> 
> Also to make this scheme explicit, we can annotate page_ext member with __rcu
> and use rcu_assign_pointer() on the writer side.
> 
> struct page_ext *lookup_page_ext(const struct page *page)
> {
>         unsigned long pfn = page_to_pfn(page);
>         struct mem_section *section = __pfn_to_section(pfn);
>         /*
>          * The sanity checks the page allocator does upon freeing a
>          * page can reach here before the page_ext arrays are
>          * allocated when feeding a range of pages to the allocator
>          * for the first time during bootup or memory hotplug.
>          */
>         if (!section->page_ext)
>                 return NULL;
>         return get_entry(section->page_ext, pfn);
> }

You are right. I was looking at the wrong implementation and misread
ifdef vs. ifndef CONFIG_SPARSEMEM. My bad.

Memory hotplug is not supported outside of CONFIG_SPARSEMEM so the
scheme should really work. I would use READ_ONCE for ms->page_ext and
WRITE_ONCE on the initialization side.
-- 
Michal Hocko
SUSE Labs
