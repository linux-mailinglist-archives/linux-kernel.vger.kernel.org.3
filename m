Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E346782C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357632AbhLCNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:30:46 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:52059 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242067AbhLCNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:30:46 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 5BB791C3F86
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:27:21 +0000 (GMT)
Received: (qmail 24445 invoked from network); 3 Dec 2021 13:27:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2021 13:27:21 -0000
Date:   Fri, 3 Dec 2021 13:27:19 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211203132719.GD3366@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
 <CAGsJ_4xuYH8d18r9f5vUGYjNxtZ31FZrNZepEh8QCZbLW+3a6Q@mail.gmail.com>
 <20211203105055.GB3366@techsingularity.net>
 <CAGsJ_4zigz0rs9ubPjJKn0s9FsHp6A1Gpoh+cyc=cQnnMEMgYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zigz0rs9ubPjJKn0s9FsHp6A1Gpoh+cyc=cQnnMEMgYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 12:14:33AM +1300, Barry Song wrote:
> > > Hi Mel, you used to have 25% * numa_weight if node has only one LLC.
> > > for a system with 4 numa,  In case sd has 2 nodes, child is 1 numa node,
> > > then  nr_groups=2, num_online_nodes()=4,  imb_numa_nr will be
> > > child->span_weight/2/2/4?
> > >
> > > Does this patch change the behaviour for machines whose numa equals LLC?
> > >
> >
> > Yes, it changes behaviour. Instead of a flat 25%, it takes into account
> > the number of LLCs per node and the number of nodes overall.
> 
> Considering  the number of nodes overall seems to be quite weird to me.
> for example, for the below machines
> 
> 1P * 2DIE = 2NUMA:    node1 - node0
> 2P * 2DIE = 4NUMA:    node1 - node0  ------ node2 - node3
> 4P * 2DIE = 8NUMA:    node1 - node0  ------ node2 - node3
>                                       node5 - node4  ------ node6 - node7
> 
> if one service pins node1 and node0 in all above configurations, it seems in all
> different machines, the app will result in different behavior.
> 

The intent is to balance between LLCs across the whole machine, hence
accounting for the number of online nodes.

> the other example is:
> in a 2P machine, if one app pins the first two NUMAs, the other app pins
> the last two NUMAs, why would the  num_online_nodes() matter to them?
> there is no balance requirement between the two P.
> 

The previous 25% imbalance also did not take pinning into account and
the choice was somewhat arbitrary.

-- 
Mel Gorman
SUSE Labs
