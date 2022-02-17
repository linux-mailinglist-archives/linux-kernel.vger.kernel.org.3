Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E74BA5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbiBQQ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:26:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiBQQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:26:22 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3C2782AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:26:06 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id x3so9230242qvd.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XI5wSofk79j/GRhgb9wMBt7y+qLqraOjCQlmddoi9Gs=;
        b=HOTiEPtCQSxBF8fYt2Lck0YZjgshd2WDxEaimka2RhcOq6SNGPUEyS0BQo6AIu3+3i
         CEiFZBStrS3Oz3ofHjiB+/5SMVnqmYuGBZxsWT5OchSc+htxxD6DBJpriNKQLbVFgQpi
         ijyRxs1iexJ6TabeysTFE0nZ3hmFNyBqQ+KqXllOzmVHuVSrtxa3FpfRfLwhTYDgE7B0
         GiVielCS1kmfwzUWPb3SqcPOwASnXYEPEG0dFbTCu+BoOxJgbyT5e9gTY741YXnLxBsg
         /LtA5+vgu9cfivKhSwtU0+WSMGk79vTFyOjvpHCbcvRljctG7hVVcou0pZ14irx77M9e
         E79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XI5wSofk79j/GRhgb9wMBt7y+qLqraOjCQlmddoi9Gs=;
        b=um6gUgmV+14RzDD5J8LD+XaKPqyK3tim59wr2p6PEXOC3qZ+O957ReNvSQS18k7T/p
         0j3yOsDl55Sx9la+upsnYDlEEMMx0hMyJYfg6/QBN0vvwQcmToYIdMJMCg5BPZVKNkZI
         inta2y8DG3fFh+7MTK52HuTXf7+EW5NuZX2dGyne2DtZwI+72rERdQSjPkTJOuhSJP3m
         ZrsECfh2vs60zJ3QPGZH/aTdAnGUeEkB8d20CtS7HyZ5NE5zp9nlJTa+zLGjKs8vjITw
         B7MCo42CWhrLWHl7178FUYxbGzOG4Y3mCKeLrP8LcAKN25U+ZguIoNJKOu8LkBE7fjqw
         gtvQ==
X-Gm-Message-State: AOAM531MWsANe6Zd5dAClLkYD561bUPq34UwYr5wjCLuNoe4CK7eo1Cn
        Dd4TnEIndNi+RtThZ+nFVOr7wA==
X-Google-Smtp-Source: ABdhPJwk4jF5c0aBznwQTLAu3usjR/ONiECpAXfX3JgQyxdPaQN1Tj4ltYGmKL5aijY/bzcsjecJDQ==
X-Received: by 2002:a05:622a:1183:b0:2dd:7c52:c0c2 with SMTP id m3-20020a05622a118300b002dd7c52c0c2mr1088371qtk.578.1645115165362;
        Thu, 17 Feb 2022 08:26:05 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id x83sm1281883qkb.68.2022.02.17.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:26:04 -0800 (PST)
Date:   Thu, 17 Feb 2022 11:26:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Message-ID: <Yg53HIx8/Knw6TZ7@cmpxchg.org>
References: <20220128082751.593478-1-ying.huang@intel.com>
 <20220128082751.593478-3-ying.huang@intel.com>
 <YgFbQFlZ+2rvS9Mm@cmpxchg.org>
 <87ee4cliia.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee4cliia.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

Sorry, I didn't see this reply until you sent out the new version
already :( Apologies.

On Wed, Feb 09, 2022 at 01:24:29PM +0800, Huang, Ying wrote:
> > On Fri, Jan 28, 2022 at 04:27:50PM +0800, Huang Ying wrote:
> >> @@ -615,6 +622,10 @@ faults may be controlled by the `numa_balancing_scan_period_min_ms,
> >>  numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
> >>  numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
> >>  
> >> +Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
> >> +different types of memory (represented as different NUMA nodes) to
> >> +place the hot pages in the fast memory.  This is implemented based on
> >> +unmapping and page fault too.
> >
> > NORMAL | TIERING appears to be a non-sensical combination.
> >
> > Would it be better to have a tristate (disabled, normal, tiering)
> > rather than a mask?
> 
> NORMAL is for balancing cross-socket memory accessing among DRAM nodes.
> TIERING is for optimizing page placement between DRAM and PMEM in one
> socket.  We think it's possible to do both.
> 
> For example, with [3/3] of the patchset,
> 
> - TIERING: because DRAM pages aren't made PROT_NONE, it's disabled to
>   balance among DRAM nodes.
> 
> - NORMAL | TIERING: both cross-socket balancing among DRAM nodes and
>   page placement optimizing between DRAM and PMEM are enabled.

Ok, I get it. So NORMAL would enable PROT_NONE sampling on all nodes,
and TIERING would additionally raise the watermarks on DRAM nodes.

Thanks!

> >> @@ -2034,16 +2035,30 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> >>  {
> >>  	int page_lru;
> >>  	int nr_pages = thp_nr_pages(page);
> >> +	int order = compound_order(page);
> >>  
> >> -	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
> >> +	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
> >>  
> >>  	/* Do not migrate THP mapped by multiple processes */
> >>  	if (PageTransHuge(page) && total_mapcount(page) > 1)
> >>  		return 0;
> >>  
> >>  	/* Avoid migrating to a node that is nearly full */
> >> -	if (!migrate_balanced_pgdat(pgdat, nr_pages))
> >> +	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> >> +		int z;
> >> +
> >> +		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> >> +		    !numa_demotion_enabled)
> >> +			return 0;
> >> +		if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
> >> +			return 0;
> >
> > The encoded behavior doesn't seem very user-friendly: Unless the user
> > enables numa demotion in a separate flag, enabling numa balancing in
> > tiered mode will silently do nothing.
> 
> In theory, TIERING still does something even with numa_demotion_enabled
> == false.  Where it works more like the original NUMA balancing.  If
> there's some free space in DRAM node (for example, some programs exit),
> some PMEM pages will be promoted to DRAM.  But as in the change log,
> this isn't good enough for page placement optimizing.

Right, so it's a behavior that likely isn't going to be useful.

> > Would it make more sense to have a central flag for the operation of
> > tiered memory systems that will enable both promotion and demotion?
> 
> IMHO, it may be possible for people to enable demotion alone.  For
> example, if some people want to use a user space page placement
> optimizing solution based on PMU counters, they may disable TIERING, but
> still use demotion as a way to avoid swapping in some situation.  Do you
> think this makes sense?

Yes, it does.

> > Alternatively, it could also ignore the state of demotion and promote
> > anyway if asked to, resulting in regular reclaim to make room. It
> > might not be the most popular combination, but would be in line with
> > the zone_reclaim_mode policy of preferring reclaim over remote
> > accesses.  It would make the knobs behave more as expected and it's
> > less convoluted than having flags select other user-visible flags.
> 
> Sorry, I don't get your idea here.  Do you suggest to add another knob
> like zone_relcaim_mode?  Then we can define some bit to control demotion
> and promotion there?  If so, I still don't know how to fit this into the
> existing NUMA balancing framework.

No, I'm just suggesting to remove the !numa_demotion_disabled check
from the promotion path on unbalanced nodes. Keep the switches
independent from each other.

Like you said, demotion without promotion can be a valid config with a
userspace promoter.

And I'm saying promotion without demotion can be a valid config in a
zone_reclaim_mode type of setup.

We also seem to agree degraded promotion when demotion enabled likely
isn't very useful to anybody. So maybe it should be removed?

It just comes down to user expectations. There is no masterswitch that
says "do the right thing on tiered systems", so absent of that I think
it would be best to keep the semantics of each of the two knobs simple
and predictable, without tricky interdependencies - like quietly
degrading promotion behavior when demotion is disabled.

Does that make sense?

Thanks!
Johannes
