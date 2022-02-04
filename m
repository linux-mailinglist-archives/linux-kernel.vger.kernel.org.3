Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF584A9AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359160AbiBDOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:09:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiBDOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:09:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 81369210FE;
        Fri,  4 Feb 2022 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643983770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9tm/++mvEPPU+2Bq7Fq7e1IXc/zDLCyCxZNu3z31Ao=;
        b=Ba9B8OHpdB4cI+8xVeKTcEQ1JEoXVEeavHS8wKs+6s/C2mjasfH/7/KRRwgw05Pj18/CpU
        hYLROMa+gahZfxtiVK5QvQ0u96p+mjNBrMuPAh3oCrbvrFAPsl0sxKrMn5yqVLYUF4j+DM
        L3Bk5YR81ojf8uEnxr8iWr5lQl6CO0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643983770;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9tm/++mvEPPU+2Bq7Fq7e1IXc/zDLCyCxZNu3z31Ao=;
        b=yBviWfeE+/7CZnnxhBJer0836PWwUrMpqrY71LvKbIRw3mLa+F5hK2RTeEn/GC9ZFcsHXu
        xbCqePp8bJFhFLDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9645A3B87;
        Fri,  4 Feb 2022 14:09:29 +0000 (UTC)
Date:   Fri, 4 Feb 2022 14:09:22 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH v0 1/3] sched/numa: Process based autonuma scan
 period framework
Message-ID: <20220204140922.GF3301@suse.de>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-2-bharata@amd.com>
 <20220131121714.GX3301@suse.de>
 <9f95a85f-5396-b8bd-50cf-c4eeeac2a013@amd.com>
 <20220201141520.GB3301@suse.de>
 <0384ed3b-498c-365a-6c12-3c297a5a8a0d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0384ed3b-498c-365a-6c12-3c297a5a8a0d@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:33:57PM +0530, Bharata B Rao wrote:
> > However, the major concern I have is that address-space wide decisions
> > on scan rates has no sensible means of adapting to thread-specific
> > requirements. I completely agree that it will result in more stable scan
> > rates, particularly the adjustments. It also side-steps a problem where
> > new threads may start with a scan rate that is completely inappropriate.
> > 
> > However, I worry that it would be limited overall because each thread
> > potentially has unique behaviour which is not obvious in a workload like
> > NAS where threads are all executing similar instructions on different
> > data. For other applications, threads may operate on thread-local areas
> > only (low scan rate), others could operate on shared only regresions (high
> > scan rate until back off and interleave), threads can has phase behaviour
> > (manager thread collecting data from worker threads) and threads can have
> > different lifetimes and phase behaviour. Each thread would have a different
> > optimal scan rate to decide if memory needs to be migrated to a local node
> > or not. I don't see how address-space wide statistics could every be mapped
> > back to threads to adapt scan rates based on thread-specific behaviour.
> 
> So if all the threads have similar behavior, wouldn't they all arrive at similar
> scan period independently and shouldn't that stabilize the overall scan period
> variation? But we do see variation in per-thread scan periods and overall benefit
> in numbers from per-mm scan period approach for benchmarks like NAS.
> 

NAS is close to being an ideal case. Threads have individual behaviour
but it's mostly SIMD with variations between the different computations.

> And, for a thread that has completely different behaviour in the group, currently
> there is no determinism AFAICS on when that would get its chance to update
> the scan period and also whether the eventual scanning happens in the areas
> of interest for that thread. In that case, isn't changing the scan period in
> isolation to cater to that unique thread an overhead on process address space
> scanning?
> 

It would protect against worst-case behaviour and non-determinism of
the thread updating its scan period but it's masking the problem by
averaging worst-case behaviour instead of solving it. Address-space wide
scanning does not necessarily scan areas of interest to a specific thread
because only the thread can determine that. Similarly, address-space
wide identification of hot spots would identify hot spots but not what
threads are creating the hot regions so threads still end up scanning
regions that are not relevant to the thread's access pattern.

> Since process level stats are essentially aggregation of thread level stats,
> process level stats will capture thread level behaviour in general. However,
> if there are certain threads whose behavior is much very different from other
> threads, they should eventually impact the process level behaviour is our
> current thinking.
> 

It does capture thread level in general but mostly by averaging all
behaviour. It masks any outlier behaviour such as worker threads in a pool
being allocated, activated and deactivated versus long-lived threads that
are almost continually active.

> For example, in a micro-benchmark where half the threads have local-only
> access and the other half start with remote-all accesses, the initial
> behaviour of the two sets are completely different, but we do see that
> per-mm scan period approach performing more or less similar to the existing
> approach.

Yes, as an average of the two where as the threads with local-only
accesses should scan at the lowest possible rate and the remote-all
should scan quickly to either meet the threshold allowing the pages to
be migrated or backed off if it's shared accesses that are a mix of
local and remote faults.

> However if we use further optimization related to tuning the scan
> period in response to the detected node imbalance(this optimization patch
> wasn't included as part of this initial series), things improve further.
> 
> Having said that, there could be corner cases where per-mm approach may not
> be able to capture the per-thread behaviour effectively as you note. We would
> surely want to explore such cases with per-mm approach to understand the
> behaviour better. We can write micro -benchmarks for this but if there already
> existing well known benchmarks that exhibit such behaviors at per-thread level,
> we are willing to give them a try.
> 

And a major concern is that the corner cases where pre-mm approach does
not work well means we need to get thread-specific information back.
There is value in knowing how the overall address space is being used
e.g. setting the scan rate of new threads or limiting the minimum scan
period to avoid excessive scanning. However, most of the major problems
such as threads only scanning areas of interest cannot be easily
adddressed by per-mm only information as the hot spots could belong to
any thread.

> > Thread scanning on the other hand can be improved in multiple ways. If
> > nothing else, they can do redundant scanning of regions that are
> > not relveant to a task which gets increasingly problematic when VSZ
> > increases. The obvious problems are
> > 
> > 1. Scan based on page table updates, not address ranges to mitigate
> >    problems with THP vs base page updates
> > 
> > 2. Move scan delay to be a per-vma structure that is kmalloced if
> >    necessary instead of being address space wide.
> > 
> > 3. Track what threads access a VMA. The suggestion was to use a unsigned
> >    long pid_mask and use the lower bits to tag approximately what
> >    threads access a VMA. Skip VMAs that did not trap a fault. This would
> >    be approximate because of PID collisions but would reduce scanning
> >    of areas the thread is not interested in
> > 
> > 4. Track active regions within VMAs. Very coarse tracking, use unsigned
> >    long to trap what ranges are active
> > 
> > In different ways, this would reduce the amount of scanning work threads
> > do and focuses them on regions of relevance to reduce overhead overall
> > without losing thread-specific details.
> 
> Thanks for these pointers, these are worth exploring. And any approach
> for reducing the redundant scanning should complement the current effort
> to optimize the scan period calculation.
> 

I think per-mm stats may be used to bound the scan rates of individual
threads but the biggest help would be if threads could track what VMAs
they are faulting within (problem 3 above) and identifying potential
hotspots (problem 4). There would still be some redundant scanning and
on occasion some thread has to rescan the entire address space but it
would reduce the overhead.

-- 
Mel Gorman
SUSE Labs
