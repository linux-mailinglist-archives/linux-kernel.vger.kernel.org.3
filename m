Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D898A468421
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384599AbhLDKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhLDKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:44:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40250C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t38DD/0QIy+XeaFgExFD8B7gq8HIERnGhxAuMeMk7rI=; b=XPeKdFczSC9fnYViyxHMOVkbs1
        ZJsr3tQ+ydmhQVtaHjApbKTCHHLjoV+QTQm/5GMldbavcBsXWdQbfc4KvgPpYDwRhOlB76dgkMGq9
        kldTeRCKxmQUwJXkvdd3Q++bGpNlSTT6cV+CqwO4jLdFS3WC9EWHzuyRDUhC3QinW2TgBH8to5FH/
        OJPaHom7lFj5f5mesNLTknVjbzTcmQML8aiRjp9RxB3tjZxOstAbVfodLK5FKcogmau5aZ6FXgD30
        Pu6DbYsIlLG32G012bZSuyuVevxVs6RAsyCL8joWkKSXNSeibbFtr6YyYhVYQ7kMTIbv1JYdS4/Ni
        c4NTGKhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtSTQ-00CfhD-Jw; Sat, 04 Dec 2021 10:40:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65C2798106D; Sat,  4 Dec 2021 11:40:56 +0100 (CET)
Date:   Sat, 4 Dec 2021 11:40:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211204104056.GR16608@worktop.programming.kicks-ass.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201151844.20488-3-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:18:44PM +0000, Mel Gorman wrote:
> +	/* Calculate allowed NUMA imbalance */
> +	for_each_cpu(i, cpu_map) {
> +		int imb_numa_nr = 0;
> +
> +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> +			struct sched_domain *child = sd->child;
> +
> +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> +				int nr_groups;
> +
> +				nr_groups = sd->span_weight / child->span_weight;
> +				imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> +						(nr_groups * num_online_nodes()));
> +			}
> +
> +			sd->imb_numa_nr = imb_numa_nr;
> +		}

OK, so let's see. All domains with SHARE_PKG_RESOURCES set will have
imb_numa_nr = 0, all domains above it will have the same value
calculated here.

So far so good I suppose :-)

Then nr_groups is what it says on the tin; we could've equally well
iterated sd->groups and gotten the same number, but this is simpler.

Now, imb_numa_nr is where the magic happens, the way it's written
doesn't help, but it's something like:

	(child->span_weight / 2) / (nr_groups * num_online_nodes())

With a minimum value of 1. So the larger the system is, or the smaller
the LLCs, the smaller this number gets, right?

So my ivb-ep that has 20 cpus in a LLC and 2 nodes, will get: (20 / 2)
/ (1 * 2) = 10, while the ivb-ex will get: (20/2) / (1*4) = 5.

But a Zen box that has only like 4 CPUs per LLC will have 1, regardless
of how many nodes it has.

Now, I'm thinking this assumes (fairly reasonable) that the level above
LLC is a node, but I don't think we need to assume this, while also not
assuming the balance domain spans the whole machine (yay paritions!).

	for (top = sd; top->parent; top = top->parent)
		;

	nr_llcs = top->span_weight / child->span_weight;
	imb_numa_nr = max(1, child->span_weight / nr_llcs);

which for my ivb-ep gets me:  20 / (40 / 20) = 10
and the Zen system will have:  4 / (huge number) = 1

Now, the exp: a / (b / a) is equivalent to a * (a / b) or a^2/b, so we
can also write the above as:

	(child->span_weight * child->span_weight) / top->span_weight;

Hmm?


> +	}
> +
>  	/* Calculate CPU capacity for physical packages and nodes */
>  	for (i = nr_cpumask_bits-1; i >= 0; i--) {
>  		if (!cpumask_test_cpu(i, cpu_map))
> -- 
> 2.31.1
> 
