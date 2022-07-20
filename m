Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E557B982
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiGTPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGTPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:23:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12355E329
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:23:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 99D5722D4A;
        Wed, 20 Jul 2022 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658330583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMuZ4eCnSI6oHdQmcEsbMFnhYCl7kv5zScxjJLVRWrw=;
        b=vZOWC9U/s5bq/xWLeJXyMWazRGZv6L2pDO9EkmnjUPOEcqj58kJFdrNa88MRUAWcoyWp8s
        JHOx4sw/wO7FHGKDM8FQHtWIUwLHb7bCK28bcI39UN/oX1d5AOP3Z5Wqn/pNS/luHCLdSo
        uLljwqVuTEPWxS4nRbksJpQEZKvsIUo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82E0A2C141;
        Wed, 20 Jul 2022 15:22:59 +0000 (UTC)
Date:   Wed, 20 Jul 2022 17:22:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <Ytgd0sVDXVZVO3OZ@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
 <YtbRF9Z1tVxgw+g0@dhcp22.suse.cz>
 <dd4e4b4c-65cd-93e5-3658-e73e754cad71@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4e4b4c-65cd-93e5-3658-e73e754cad71@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-07-22 20:38:58, Charan Teja Kalla wrote:
> Thanks Michal here!!
> 
> On 7/19/2022 9:13 PM, Michal Hocko wrote:
> >>>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
> >>>>>> index 3dc715d..5ccd3ee 100644
> >>>>>> --- a/mm/page_ext.c
> >>>>>> +++ b/mm/page_ext.c
> >>>>>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
> >>>>>>  	if (!ms || !ms->page_ext)
> >>>>>>  		return;
> >>>>>>  	base = get_entry(ms->page_ext, pfn);
> >>>>>> -	free_page_ext(base);
> >>>>>>  	ms->page_ext = NULL;
> >>>>>> +	synchronize_rcu();
> >>>>>> +	free_page_ext(base);
> >>>>>>  }
> >>>>> So you are imposing the RCU grace period for each page_ext! This can get
> >>>>> really expensive. Have you tried to measure the effect?
> >>> I was wrong here! This is for each memory section which is not as
> >>> terrible as every single page_ext. This can be still quite a lot memory
> >>> sections in a single memory block (e.g. on ppc memory sections are
> >>> ridiculously small).
> >>>
> >> On the ARM64, I see that the minimum a section size will go is 128MB. I
> >> think 16MB is the section size on ppc. Any inputs on how frequently
> >> offline/online operation is being done on this ppc arch?
> > I have seen several reports where 16MB sections were used on PPC LPARs
> > with a non trivial size. My usual answer to that is tha this is mostly a
> > self inflicted injury but I am told that for some reasons I cannot
> > udnerstand this is not easy to change. So reasonable or not this is not
> > all that uncommon in PPC land.
> > 
> > We definitely shouldn't optimize for those setups but we shouldn't make
> > them suffer even more as well. Besides that it seems that a single
> > rcu_synchronize per offline operation should be doable.
> 
> I too feel it is doable but the code might look to need to traverse the
> sections of a memory block twice.

yes, this is to be expected unless you really want to optimize that
further by some global flag which is probably not worth it. Traversing
the sequence of section is not really an expensive operation comparing
to do an expenensive operation to each of the iteration.
 
> 1) with synchronize_rcu() calling for each memory section of a memblock:
> ---------------------------------------------------------------------
> for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
>     __free_page_ext(pfn):
>          ms->page_ext = NULL
>          synchronize_rcu();// Called on every section.
> 	 free_page_ext();//free the page_ext.
> 
> 2) With a single synchronize_rcu() for each offlined block:
> -------------------------------------------------------
> for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> 	__free_page_ext(pfn):
> 	    ms->page_ext = NULL;

you want WRITE_ONCE here

> }
> synchronize_rcu(); // call synchronize_rcu for just once
> for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
> 	free_page_ext(); // Free the page_ext.

Yes this is what I really meant but the thing is that you need the
pointer to know what to free. One way to handle that would be to not
clear the pointer but make it visibly invalid for later checks. E.g. set
the lowest bit and check for it rather for NULL.
 
> Any better code you have in mind here please?
> 
> But since there are few sections the overhead of traversing them will be
> definitely less compared to synchronize_rcu() per memsection.
> 
> But I really doubt if there will be a real impact making sync_rcu per
> section because,(as david also mentioned and you also corrected it I
> think), the concern here is for ppc where the min memblock size is 256M
> with section size of 16M and there is a single offline operation on that
> block but can end up in calling 16 sync_rcu() calls. Should we really
> optimize this case here? If yes, I can go with the approach 2) mentioned
> above. Sorry if I am really undermining the problem here.

I would prefer a single rcu barrier solution. Unless this turns into
monster complicated stuff. Which I hope we can avoid completely by
simply not doing the separate lifetime as well...

Making any assumptions on the number of sections that are handled here
is just a ticket to get issues later. Let's not put land mines ahead of
us please.
-- 
Michal Hocko
SUSE Labs
