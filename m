Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D271757B522
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiGTLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGTLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:13:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF757E15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:13:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2CB70209BB;
        Wed, 20 Jul 2022 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658315607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVS1Ma60eQeIoz+rEvVQL37s9TZNdcW1qvb1bYiop7w=;
        b=qikOJz1OrtvsQzT3S3IVsO8DkmFUlUOrUn3irfxkGSwS7PfCfrkkQbLJjkDWnSgql/Y+C1
        efg7qFQ6/qRrUnLiU0MW+BvNpgOB0kfZU0uYYmka2+hQUcrplKGVB3EtOpHj43EkwCdfL4
        JQ8EDTuagJSf1+aUvOD0wzNG7nXYKYs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 775AB2C141;
        Wed, 20 Jul 2022 11:13:23 +0000 (UTC)
Date:   Wed, 20 Jul 2022 13:13:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YtfjT5gs/sa7uzrt@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
 <20220720082112.GA14437@hu-pkondeti-hyd.qualcomm.com>
 <YtfGeUUoi9cq3g0A@dhcp22.suse.cz>
 <f7e1efa4-43da-22e0-b748-d0855ecc7456@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e1efa4-43da-22e0-b748-d0855ecc7456@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-07-22 16:13:19, Charan Teja Kalla wrote:
> Thanks Michal & Pavan,
> 
> On 7/20/2022 2:40 PM, Michal Hocko wrote:
> >>>> Thanks! The most imporant part is how the exclusion is actual achieved
> >>>> because that is not really clear at first sight
> >>>>
> >>>> CPU1					CPU2
> >>>> lookup_page_ext(PageA)			offlining
> >>>> 					  offline_page_ext
> >>>> 					    __free_page_ext(addrA)
> >>>> 					      get_entry(addrA)
> >>>> 					      ms->page_ext = NULL
> >>>> 					      synchronize_rcu()
> >>>> 					      free_page_ext
> >>>> 					        free_pages_exact (now addrA is unusable)
> >>>> 					
> >>>>   rcu_read_lock()
> >>>>   entryA = get_entry(addrA)
> >>>>     base + page_ext_size * index # an address not invalidated by the freeing path
> >>>>   do_something(entryA)
> >>>>   rcu_read_unlock()
> >>>>
> >>>> CPU1 never checks ms->page_ext so it cannot bail out early when the
> >>>> thing is torn down. Or maybe I am missing something. I am not familiar
> >>>> with page_ext much.
> >>>
> >>> Thanks a lot for catching this Michal. You are correct that the proposed
> >>> code from me is still racy. I Will correct this along with the proper
> >>> commit message in the next version of this patch.
> >>>
> >> Trying to understand your discussion with Michal. What part is still racy? We
> >> do check for mem_section::page_ext and bail out early from lookup_page_ext(),
> >> no?
> >>
> >> Also to make this scheme explicit, we can annotate page_ext member with __rcu
> >> and use rcu_assign_pointer() on the writer side.
> 
> Annotating with __rcu requires all the read and writes to ms->page_ext
> to be under rcu_[access|assign]_pointer which is a big patch. I think
> READ_ONCE and WRITE_ONCE, mentioned by Michal, below should does the job.
> 
> >>
> >> struct page_ext *lookup_page_ext(const struct page *page)
> >> {
> >>         unsigned long pfn = page_to_pfn(page);
> >>         struct mem_section *section = __pfn_to_section(pfn);
> >>         /*
> >>          * The sanity checks the page allocator does upon freeing a
> >>          * page can reach here before the page_ext arrays are
> >>          * allocated when feeding a range of pages to the allocator
> >>          * for the first time during bootup or memory hotplug.
> >>          */
> >>         if (!section->page_ext)
> >>                 return NULL;
> >>         return get_entry(section->page_ext, pfn);
> >> }
> > You are right. I was looking at the wrong implementation and misread
> > ifdef vs. ifndef CONFIG_SPARSEMEM. My bad.
> > 
> 
> There is still a small race window b/n ms->page_ext setting NULL and its
> access even under CONFIG_SPARSEMEM. In the above mentioned example:
> 
>  CPU1					CPU2
>  rcu_read_lock()
>  lookup_page_ext(PageA):		offlining
>  					  offline_page_ext
>  					    __free_page_ext(addrA)
>  					      get_entry(addrA)
>     if (!section->page_ext)
>        turns to be false.
>  					      ms->page_ext = NULL
> 						
>    addrA = get_entry(base=section->page_ext):
>      base + page_ext_size * index;
>      **Since base is NULL here, caller
>      can still do the dereference on
>      the invalid pointer address.**

only if the value is re-fetched. Not likely but definitely better to
have it covered. That is why I was suggesting READ_ONCE/WRITE_ONCE for
this iperation.
> 						
>  					      synchronize_rcu()
>  					      free_page_ext
>  					        free_pages_exact (now )
> 
> 
> > Memory hotplug is not supported outside of CONFIG_SPARSEMEM so the
> > scheme should really work. I would use READ_ONCE for ms->page_ext and
> > WRITE_ONCE on the initialization side.
> 
> Yes, I should be using the READ_ONCE() and WRITE_ONCE() here.

yes.

-- 
Michal Hocko
SUSE Labs
