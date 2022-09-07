Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD65B00D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIGJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIGJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:47:36 -0400
Received: from outbound-smtp48.blacknight.com (outbound-smtp48.blacknight.com [46.22.136.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB09AFBA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:47:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 16F97FAF13
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:47:34 +0100 (IST)
Received: (qmail 25917 invoked from network); 7 Sep 2022 09:47:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2022 09:47:33 -0000
Date:   Wed, 7 Sep 2022 10:47:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <20220907094724.5lanecgcjg75vxv3@techsingularity.net>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZvItUOgTgD11etC@dhcp22.suse.cz>
 <163764199967.7248.2528204111227925210@noble.neil.brown.name>
 <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
 <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
 <Yxb4TQ0WDa85uurY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yxb4TQ0WDa85uurY@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:35:41AM +0200, Michal Hocko wrote:
> > From: "NeilBrown" <neilb@suse.de>
> > Subject: mm: discard __GFP_ATOMIC
> > 
> > __GFP_ATOMIC serves little purpose.  Its main effect is to set
> > ALLOC_HARDER which adds a few little boosts to increase the chance of an
> > allocation succeeding, one of which is to lower the water-mark at which it
> > will succeed.
> > 
> > It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> > adjusts this watermark.  It is probable that other users of __GFP_HIGH
> > should benefit from the other little bonuses that __GFP_ATOMIC gets.
> > 
> > __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM. 
> > There is little point to this.  We already get a might_sleep() warning if
> > __GFP_DIRECT_RECLAIM is set.
> > 
> > __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> > probable that testing ALLOC_HARDER is a better fit here.
> > 
> > __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> > sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> > 
> > This patch:
> >  - removes __GFP_ATOMIC
> >  - causes __GFP_HIGH to set ALLOC_HARDER unless __GFP_NOMEMALLOC is set
> >    (as well as ALLOC_HIGH).
> >  - makes other adjustments as suggested by the above.
> > 
> > The net result is not change to GFP_ATOMIC allocations.  Other
> > allocations that use __GFP_HIGH will benefit from a few different extra
> > privileges.  This affects:
> >   xen, dm, md, ntfs3
> >   the vermillion frame buffer
> >   hibernation
> >   ksm
> >   swap
> > all of which likely produce more benefit than cost if these selected
> > allocation are more likely to succeed quickly.
> 
> This is a good summary of the current usage and existing issues. It also
> shows that the naming is tricky and allows people to make wrong calls
> (tegra-smmu.c). I also thing that it is wrong to couple memory reserves
> access to the reclaim constrains/expectations of the caller.
> 

I think it's worth trying to get rid of __GFP_ATOMIC although this patch
needs to be rebased. Without rebasing it, I suspect there is a corner case
for reserving high order atomic blocks. A high-order atomic allocation
might get confused with a __GFP_HIGH high-order allocation that can sleep.
It would not be completely irrational to have such a caller if it was in a
path that can tolerate a stall but stalling might have visible consequences.
I'm also worried that the patch might allow __GFP_HIGH to ignore cpusets
which is probably not intended by direct users like ksm.

> > Link: https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Yes, I am all for dropping the gfp flag. One thing that is not really
> entirely clear to me, though, is whether we still need 3 levels of
> memory reserves access. Can we just drop ALLOC_HARDER? With this patch
> applied it serves RT tasks and conflates it with __GFP_HIGH users
> essentially. So why do we need that additional level of reserves?

I think this would fall under the "naming is hard". If __GFP_ATOMIC was
removed, the ALLOC_ flags might need renaming to detect differences in
high priority allocations (RT + GFP_ATOMIC), critical allocations (OOM)
and ones that can access special reserves (GFP_ATOMIC high-order).

-- 
Mel Gorman
SUSE Labs
