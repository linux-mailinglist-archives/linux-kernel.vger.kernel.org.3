Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081615785E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiGROzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiGROzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:55:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B28222A2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:54:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DD65E1F86C;
        Mon, 18 Jul 2022 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658156097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GYqqskOUH/7Rs8C9Uf77Hro67UXC5uPhE9Py/w8lGFI=;
        b=TPEaSqJEeqXFATLlnkEi6eI/xEGEBvo4pkt0vmg/kjJ9eUnVtrZUV+y24U+0bMd7OrXSfM
        Xl+QhPqw+3JvvOD4hlXRy64U54Ym2NSwt9EThaVksk+zwc6VO3+Ep+OiE0hWCKsPgfQHbc
        SKTIGGpOTiiMhw7V/icDZYqT7cpq15M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D04DF2C141;
        Mon, 18 Jul 2022 14:54:56 +0000 (UTC)
Date:   Mon, 18 Jul 2022 16:54:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-07-22 19:28:13, Charan Teja Kalla wrote:
> Thanks Michal for the comments!!
> 
> On 7/18/2022 5:20 PM, Michal Hocko wrote:
> >> The above mentioned race is just one example __but the problem persists
> >> in the other paths too involving page_ext->flags access(eg:
> >> page_is_idle())__. Since offline waits till the last reference on the
> >> page goes down i.e. any path that took the refcount on the page can make
> >> the memory offline operation to wait. Eg: In the migrate_pages()
> >> operation, we do take the extra refcount on the pages that are under
> >> migration and then we do copy page_owner by accessing page_ext. For
> >>
> >> Fix those paths where offline races with page_ext access by maintaining
> >> synchronization with rcu lock.
> > Please be much more specific about the synchronization. How does RCU
> > actually synchronize the offlining and access? Higher level description
> > of all the actors would be very helpful not only for the review but also
> > for future readers.
> 
> I will improve the commit message about this synchronization change
> using RCU's.

Thanks! The most imporant part is how the exclusion is actual achieved
because that is not really clear at first sight

CPU1					CPU2
lookup_page_ext(PageA)			offlining
					  offline_page_ext
					    __free_page_ext(addrA)
					      get_entry(addrA)
					      ms->page_ext = NULL
					      synchronize_rcu()
					      free_page_ext
					        free_pages_exact (now addrA is unusable)
					
  rcu_read_lock()
  entryA = get_entry(addrA)
    base + page_ext_size * index # an address not invalidated by the freeing path
  do_something(entryA)
  rcu_read_unlock()

CPU1 never checks ms->page_ext so it cannot bail out early when the
thing is torn down. Or maybe I am missing something. I am not familiar
with page_ext much.

> > Also, more specifically
> > [...]
> >> diff --git a/mm/page_ext.c b/mm/page_ext.c
> >> index 3dc715d..5ccd3ee 100644
> >> --- a/mm/page_ext.c
> >> +++ b/mm/page_ext.c
> >> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
> >>  	if (!ms || !ms->page_ext)
> >>  		return;
> >>  	base = get_entry(ms->page_ext, pfn);
> >> -	free_page_ext(base);
> >>  	ms->page_ext = NULL;
> >> +	synchronize_rcu();
> >> +	free_page_ext(base);
> >>  }
> > So you are imposing the RCU grace period for each page_ext! This can get
> > really expensive. Have you tried to measure the effect?

I was wrong here! This is for each memory section which is not as
terrible as every single page_ext. This can be still quite a lot memory
sections in a single memory block (e.g. on ppc memory sections are
ridiculously small).

> I didn't really measure the effect. Let me measure it and post these in V2.

I think it would be much more optimal to split the operation into 2
phases. Invalidate all the page_ext metadata then synchronize_rcu and
only then free them all. I am not very familiar with page_ext so I am
not sure this is easy to be done. Maybe page_ext = NULL can be done in
the first stage.

> > Is there any reason why page_ext is freed during offlining rather when
> > it is hotremoved?
> 
> This is something I am struggling to get the answer. IMO, this is even
> wrong design where I don't have page_ext but page. Moving the freeing of
> page_ext to hotremove path actually solves the problem but somehow this
> idea didn't liked[1].  copying the excerpt here:

yes, it certainly adds subtlety to the page_ext thingy. I do agree that
even situation around struct page is not all that great wrt
synchronization. We have pfn_to_online_page which even when racy doesn't
give you a garbage because hotremove happens very rarely or so long
after offlining that the race window is essentially impractically too
long for any potential damage. We would have to change a lot to make it
work "properly". I am not optimistic this is actually feasible.

> > 3) Change the design where the page_ext is valid as long as the struct
> > page is alive.
> 
> :/ Doesn't spark joy."

I would be wondering why. It should only take to move the callback to
happen at hotremove. So it shouldn't be very involved of a change. I can
imagine somebody would be relying on releasing resources when offlining
memory but is that really the case?

-- 
Michal Hocko
SUSE Labs
