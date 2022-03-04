Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165E4CD0E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiCDJNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiCDJNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:13:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92AB38790
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:12:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 77377212C5;
        Fri,  4 Mar 2022 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646385154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqMdHxq3Tr9wFinwTE0WAXhnv9tEGYziFkIAVbbyOnQ=;
        b=AkRsaKEn6BkQPgOaWVvK+fXQY1+K/rVYo7Ck9TjWhm7pX6kkJptc+hon/dZMW/TzohL2lh
        nPfP6WzaHDN/4tGiPUz2vFwgkPKPKBrRSNrstsA/DXm6XV0eaZ4+a9fYQdPUGxC4CV+Wc6
        MSF6h2BaLxV6mE7tiW/OlzH/mp+82V8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62190A3B84;
        Fri,  4 Mar 2022 09:12:34 +0000 (UTC)
Date:   Fri, 4 Mar 2022 10:12:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Message-ID: <YiHYAbEq9Sl4Rbjo@dhcp22.suse.cz>
References: <20220303212956.229409-1-hannes@cmpxchg.org>
 <YiE3do4qCmJ6RsmP@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiE3do4qCmJ6RsmP@cmpxchg.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[please CC linux-api if you are going to repost with the fix suggested
 by Nadav]

On Thu 03-03-22 16:47:34, Johannes Weiner wrote:
> On Thu, Mar 03, 2022 at 04:29:56PM -0500, Johannes Weiner wrote:
> > MADV_DONTNEED historically rejects mlocked ranges, but with
> > MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> > there are valid use cases for depopulating locked ranges as well.
> > 
> > Users mlock memory to protect secrets. There are allocators for secure
> > buffers that want in-use memory generally mlocked, but cleared and
> > invalidated memory to give up the physical pages. This could be done
> > with explicit munlock -> mlock calls on free -> alloc of course, but
> > that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
> > splits and re-merges - only to get rid of the backing pages.
> > 
> > Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
> > okay with on-demand initial population. It seems valid to selectively
> > free some memory during the lifetime of such a process, without having
> > to mess with its overall policy.
> > 
> > Why add a separate flag? Isn't this a pretty niche usecase?
> > 
> > - MADV_DONTNEED has been bailing on locked vmas forever. It's at least
> >   conceivable that someone, somewhere is relying on mlock to protect
> >   data from perhaps broader invalidation calls. Changing this behavior
> >   now could lead to quiet data corruption.
> > 
> > - It also clarifies expectations around MADV_FREE and maybe
> >   MADV_REMOVE. It avoids the situation where one quietly behaves
> >   different than the others. MADV_FREE_LOCKED can be added later.
> > 
> > - The combination of mlock() and madvise() in the first place is
> >   probably niche. But where it happens, I'd say that dropping pages
> >   from a locked region once they don't contain secrets or won't page
> >   anymore is much saner than relying on mlock to protect memory from
> >   speculative or errant invalidation calls. It's just that we can't
> >   change the default behavior because of the two previous points.
> > 
> > Given that, an explicit new flag seems to make the most sense.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Just for context, I found this discussion back from 2018:
> 
> https://lkml.iu.edu/hypermail/linux/kernel/1806.1/00483.html
> 
> It seems to me that the usecase wasn't really in question, but people
> weren't sure about the API, and then Jason found a workaround before
> the discussion really concluded. I was asked internally about this
> feature, so I'm submitting another patch in this direction, but with
> more thoughts on why I chose to go with a new flag. Hopefully we can
> work it out this time around :-)

Thanks for the link. The topic sounded familiar but I couldn't really
remember any details anymore. Now I do remember that I wasn't happy
about special casing MLOCK_ONFAULT. A dedicated madvise operation
is definitely safer and I am OK with that. Presented usecases make sense
to me as well.

Btw. I have a recollection that Mike is working on MADV_DONTNEED support
for hugetlb pages. I do not know the current state of that work. Not
that it would make nay impact on your new flag but some minor changes
might be needed.

Anyway, after the madvise_need_mmap_write is addressed, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
