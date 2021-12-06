Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2B469982
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbhLFOz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344644AbhLFOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:55:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FFBC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5gtRshoZmV/yxPIlmlF7rITBcSsgOFW0o1b5I6QkwHU=; b=fgj02dzrTZYddTx/Mqgz4zGyiC
        23k9N7bJOk4OtOiNMOfjACQvBs3YxjGIy8DH0eP6NK5nl9lqgHh66CyqYfyMxf1Cyqpi0kUC0578J
        BGAOxycyuuqk5zT7N5qVsuiGDuw6fwLG5tGL5Wv67rUnGkKtoIPj9ny0QZ9F0mCi5Rw2c6Uk3ZtYx
        VtoPZtm6AmBpntDE3IH+EXEQcipguonN+sRKY5l811+J/mTMwAlHEBmB2mySDlvgeQDQ9tCD/xyTs
        sYgUFJz4XPXNKAj8Hm7sU4BDYbrsiYsddZr/LxnNPcTros1zhWdo3AJ2oV23Mw1Bm3PXC+U/x7iBL
        SIIM1EXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFLU-002a1N-Qp; Mon, 06 Dec 2021 14:52:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 744F23000E6;
        Mon,  6 Dec 2021 15:51:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CB30202420BC; Mon,  6 Dec 2021 15:51:58 +0100 (CET)
Date:   Mon, 6 Dec 2021 15:51:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sadagopan Srinivasan <Sadagopan.Srinivasan@amd.com>,
        Krupa Ramakrishnan <Krupa.Ramakrishnan@amd.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <Ya4jjgnejp3XP4yi@hirez.programming.kicks-ass.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
 <20211204104056.GR16608@worktop.programming.kicks-ass.net>
 <Ya3OVWUftTL5a2C6@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya3OVWUftTL5a2C6@BLR-5CG11610CF.amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 02:18:21PM +0530, Gautham R. Shenoy wrote:
> On Sat, Dec 04, 2021 at 11:40:56AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 01, 2021 at 03:18:44PM +0000, Mel Gorman wrote:
> > > +	/* Calculate allowed NUMA imbalance */
> > > +	for_each_cpu(i, cpu_map) {
> > > +		int imb_numa_nr = 0;
> > > +
> > > +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > > +			struct sched_domain *child = sd->child;
> > > +
> > > +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > > +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > > +				int nr_groups;
> > > +
> > > +				nr_groups = sd->span_weight / child->span_weight;
> > > +				imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> > > +						(nr_groups * num_online_nodes()));
> > > +			}
> > > +
> > > +			sd->imb_numa_nr = imb_numa_nr;
> > > +		}
> > 
> > OK, so let's see. All domains with SHARE_PKG_RESOURCES set will have
> > imb_numa_nr = 0, all domains above it will have the same value
> > calculated here.
> > 
> > So far so good I suppose :-)
> 
> Well, we will still have the same imb_numa_nr set for different NUMA
> domains which have different distances!

Fair enough; that would need making the computation depends on more
thing, but that shouldn't be too hard.

> > Then nr_groups is what it says on the tin; we could've equally well
> > iterated sd->groups and gotten the same number, but this is simpler.
> > 
> > Now, imb_numa_nr is where the magic happens, the way it's written
> > doesn't help, but it's something like:
> > 
> > 	(child->span_weight / 2) / (nr_groups * num_online_nodes())
> > 
> > With a minimum value of 1. So the larger the system is, or the smaller
> > the LLCs, the smaller this number gets, right?
> > 
> > So my ivb-ep that has 20 cpus in a LLC and 2 nodes, will get: (20 / 2)
> > / (1 * 2) = 10, while the ivb-ex will get: (20/2) / (1*4) = 5.
> > 
> > But a Zen box that has only like 4 CPUs per LLC will have 1, regardless
> > of how many nodes it has.
> 
> That's correct. On a Zen3 box with 2 sockets with 64 cores per
> sockets, we can configure it with either 1/2/4 Nodes Per Socket
> (NPS). The imb_numa_nr value for each of the NPS configurations is as
> follows:

Cute; that's similar to the whole Intel sub-numa-cluster stuff then;
perhaps update the comment that goes with x86_has_numa_in_package ?
Currently that only mentions AMD Magny-Cours which is a few generations
ago.


> NPS 4:
> ~~~~~~~
> SMT [span_wt=2]
>    --> MC [span_wt=16, LLC]
>        --> NODE [span_wt=32]
>            --> NUMA [span_wt=128, SD_NUMA]
> 	       --> NUMA [span_wt=256, SD_NUMA]

OK, so at max nodes you still have at least 2 LLCs per node.

> While the imb_numa_nr = 1 is good for the NUMA domain within a socket
> (the lower NUMA domains in in NPS2 and NPS4 modes), it appears to be a
> little bit aggressive for the NUMA domain spanning the two sockets. If
> we have only a pair of communicating tasks in a socket, we will end up
> spreading them across the two sockets with this patch.
> 
> > 
> > Now, I'm thinking this assumes (fairly reasonable) that the level above
> > LLC is a node, but I don't think we need to assume this, while also not
> > assuming the balance domain spans the whole machine (yay paritions!).
> > 
> > 	for (top = sd; top->parent; top = top->parent)
> > 		;
> > 
> > 	nr_llcs = top->span_weight / child->span_weight;
> > 	imb_numa_nr = max(1, child->span_weight / nr_llcs);
> > 
> > which for my ivb-ep gets me:  20 / (40 / 20) = 10
> > and the Zen system will have:  4 / (huge number) = 1
> > 
> > Now, the exp: a / (b / a) is equivalent to a * (a / b) or a^2/b, so we
> > can also write the above as:
> > 
> > 	(child->span_weight * child->span_weight) / top->span_weight;
> 
> 
> Assuming that "child" here refers to the LLC domain, on Zen3 we would have
> (a) child->span_weight = 16. (b) top->span_weight = 256.
> 
> So we get a^2/b = 1.

Yes, it would be in the same place as the current imb_numa_nr
calculation, so child would be the largest domain having
SHARE_PKG_RESOURCES, aka. LLC.

> Last week, I tried a modification on top of Mel's current patch where
> we spread tasks between the LLCs of the groups within each NUMA domain
> and compute the value of imb_numa_nr per NUMA domain. The idea is to set
> 
>     sd->imb_numa_nr = min(1U,
>     		         (Number of LLCs in each sd group / Number of sd groups))

s/min/max/

Which is basically something like:

for_each (sd in NUMA):
  llc_per_group = child->span / llc->span;
  nr_group = sd->span / child->span;
  imb = max(1, llc_per_group / nr_group);


> This won't work for processors which have a single LLC in a socket,
> since the sd->imb_numa_nr will be 1 which is probably too low. 

Right.

> FWIW,
> with this heuristic, the imb_numa_nr across the different NPS
> configurations of a Zen3 server is as follows
> 
> NPS1:
>     NUMA domain: nr_llcs_per_group = 8. nr_groups = 2. imb_numa_nr = 4
> 
> NPS2:
>     1st NUMA domain: nr_llcs_per_group = 4. nr_groups = 2. imb_numa_nr = 2.
>     2nd NUMA domain: nr_llcs_per_group = 8. nr_groups = 2. imb_numa_nr = 4.
> 
> NPS4:
>     1st NUMA domain: nr_llcs_per_group = 2. nr_groups = 4. imb_numa_nr = min(1, 2/4) = 1.
>     2nd NUMA domain: nr_llcs_per_group = 8. nr_groups = 2. imb_numa_nr = 4.
> 
> Thus, at the highest NUMA level (socket), we don't spread across the
> two sockets until there are 4 tasks within the socket. If there is
> only a pair of communicating tasks in the socket, they will be left
> alone within that socket. 

Something that might work:

imb = 0;
imb_span = 1;

for_each_sd(sd) {
	child = sd->child;

	if (!(sd->flags & SD_SPR) && child && (child->flags & SD_SPR)) {

		imb = /* initial magic */
		imb_span = sd->span;
		sd->imb = imb;

	} else if (imb) {
		sd->imb = imb * (sd->span / imb_span);
	}
}

Where we calculate the initial imbalance for the LLC boundary, and then
increase that for subsequent domains based on how often that boundary sd
fits in it. That gives the same progression you have, but also works for
NODE==LLC I think.
