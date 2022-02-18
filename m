Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174AB4BAF79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiBRCQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:16:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiBRCQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:16:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCAB20A349
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645150552; x=1676686552;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=SuSapOJ8d+YrYjQ2tf2ikjJ10uJp/d39OepR1OXdY4g=;
  b=nfuII0yyPvMUjrxYWtI1ASD37zh8xDmbrBXWqPGGOWfwkRVyer3S2O8m
   SbDUimFixOQFAf3x38GNHXrY6UkZBxGxkqpFaozQ8jfLGO0SM8mwkrSgF
   iO3YtzlIzvt7G/jjkPRqsoIo0nCngT6kRpBd6izO/YZIMJjs2aNnUycKB
   JQ0lBTyuNOybhqw8g/KEABEytGLu+9HL0cSqUHZgvTa87kEk1ZPccL4tJ
   guvMNpxYsTSBG5WhD/08mjoz9quO2sRqpN+Ylskb9eiC4WSvYzaxwv/mD
   8lrjcT6GDZJwRYnloHzqZuzbCv1pA20Lwcqck7rF4SUh2kt/vfMl4c7rn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337475944"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="337475944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 18:15:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="503804866"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 18:15:48 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V11 2/3] NUMA balancing: optimize page placement for
 memory tiering system
References: <20220128082751.593478-1-ying.huang@intel.com>
        <20220128082751.593478-3-ying.huang@intel.com>
        <YgFbQFlZ+2rvS9Mm@cmpxchg.org>
        <87ee4cliia.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yg53HIx8/Knw6TZ7@cmpxchg.org>
Date:   Fri, 18 Feb 2022 10:15:46 +0800
In-Reply-To: <Yg53HIx8/Knw6TZ7@cmpxchg.org> (Johannes Weiner's message of
        "Thu, 17 Feb 2022 11:26:04 -0500")
Message-ID: <87h78w7wdp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> Hi Huang,
>
> Sorry, I didn't see this reply until you sent out the new version
> already :( Apologies.

Never mind!

> On Wed, Feb 09, 2022 at 01:24:29PM +0800, Huang, Ying wrote:
>> > On Fri, Jan 28, 2022 at 04:27:50PM +0800, Huang Ying wrote:
>> >> @@ -615,6 +622,10 @@ faults may be controlled by the `numa_balancing_scan_period_min_ms,
>> >>  numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
>> >>  numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
>> >>  
>> >> +Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
>> >> +different types of memory (represented as different NUMA nodes) to
>> >> +place the hot pages in the fast memory.  This is implemented based on
>> >> +unmapping and page fault too.
>> >
>> > NORMAL | TIERING appears to be a non-sensical combination.
>> >
>> > Would it be better to have a tristate (disabled, normal, tiering)
>> > rather than a mask?
>> 
>> NORMAL is for balancing cross-socket memory accessing among DRAM nodes.
>> TIERING is for optimizing page placement between DRAM and PMEM in one
>> socket.  We think it's possible to do both.
>> 
>> For example, with [3/3] of the patchset,
>> 
>> - TIERING: because DRAM pages aren't made PROT_NONE, it's disabled to
>>   balance among DRAM nodes.
>> 
>> - NORMAL | TIERING: both cross-socket balancing among DRAM nodes and
>>   page placement optimizing between DRAM and PMEM are enabled.
>
> Ok, I get it. So NORMAL would enable PROT_NONE sampling on all nodes,
> and TIERING would additionally raise the watermarks on DRAM nodes.
>
> Thanks!
>
>> >> @@ -2034,16 +2035,30 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>> >>  {
>> >>  	int page_lru;
>> >>  	int nr_pages = thp_nr_pages(page);
>> >> +	int order = compound_order(page);
>> >>  
>> >> -	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
>> >> +	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>> >>  
>> >>  	/* Do not migrate THP mapped by multiple processes */
>> >>  	if (PageTransHuge(page) && total_mapcount(page) > 1)
>> >>  		return 0;
>> >>  
>> >>  	/* Avoid migrating to a node that is nearly full */
>> >> -	if (!migrate_balanced_pgdat(pgdat, nr_pages))
>> >> +	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>> >> +		int z;
>> >> +
>> >> +		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
>> >> +		    !numa_demotion_enabled)
>> >> +			return 0;
>> >> +		if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
>> >> +			return 0;
>> >
>> > The encoded behavior doesn't seem very user-friendly: Unless the user
>> > enables numa demotion in a separate flag, enabling numa balancing in
>> > tiered mode will silently do nothing.
>> 
>> In theory, TIERING still does something even with numa_demotion_enabled
>> == false.  Where it works more like the original NUMA balancing.  If
>> there's some free space in DRAM node (for example, some programs exit),
>> some PMEM pages will be promoted to DRAM.  But as in the change log,
>> this isn't good enough for page placement optimizing.
>
> Right, so it's a behavior that likely isn't going to be useful.
>
>> > Would it make more sense to have a central flag for the operation of
>> > tiered memory systems that will enable both promotion and demotion?
>> 
>> IMHO, it may be possible for people to enable demotion alone.  For
>> example, if some people want to use a user space page placement
>> optimizing solution based on PMU counters, they may disable TIERING, but
>> still use demotion as a way to avoid swapping in some situation.  Do you
>> think this makes sense?
>
> Yes, it does.
>
>> > Alternatively, it could also ignore the state of demotion and promote
>> > anyway if asked to, resulting in regular reclaim to make room. It
>> > might not be the most popular combination, but would be in line with
>> > the zone_reclaim_mode policy of preferring reclaim over remote
>> > accesses.  It would make the knobs behave more as expected and it's
>> > less convoluted than having flags select other user-visible flags.
>> 
>> Sorry, I don't get your idea here.  Do you suggest to add another knob
>> like zone_relcaim_mode?  Then we can define some bit to control demotion
>> and promotion there?  If so, I still don't know how to fit this into the
>> existing NUMA balancing framework.
>
> No, I'm just suggesting to remove the !numa_demotion_disabled check
> from the promotion path on unbalanced nodes. Keep the switches
> independent from each other.
>
> Like you said, demotion without promotion can be a valid config with a
> userspace promoter.
>
> And I'm saying promotion without demotion can be a valid config in a
> zone_reclaim_mode type of setup.
>
> We also seem to agree degraded promotion when demotion enabled likely
> isn't very useful to anybody. So maybe it should be removed?
>
> It just comes down to user expectations. There is no masterswitch that
> says "do the right thing on tiered systems", so absent of that I think
> it would be best to keep the semantics of each of the two knobs simple
> and predictable, without tricky interdependencies - like quietly
> degrading promotion behavior when demotion is disabled.
>
> Does that make sense?

Yes.  It does.  I will do that in the next version!

Best Regards,
Huang, Ying
