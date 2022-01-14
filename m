Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1293848E390
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiANFYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:24:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:50718 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbiANFYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642137884; x=1673673884;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=92tRTD4fcrpeUbknFCBT9XDPsuuvbBnF0XT7Yjbsol8=;
  b=Ad+IG4pIqalRznqh2l/L1+AUwS9cGuknOzH+XBQsPal4+wUojDhSgf/z
   pzcmSeFdYdWkfa8Au1BnEX/sGmtzoq2SnxWj/GIoxzCMlg4+JIbEoESk5
   UF5y10LupjF5as4IFydVLsoMgyFb+aJzeFvGN1Gxo5L/jNCM+et03NkFZ
   IzfZWHZ/qRnbZeBqW2HQIip8ixF456dqpwu0/qq1kn/p/2Jo0VjOhjUTq
   p5pt3TWTHd7ixJ2nPREQx5rmisrklxtb1XdnwW9tSM55lLaA0KgtML3uL
   jv2N4l+3635I9+FUBfihW9IFEEcPVtfWV4/6vgaBrUjvOxiyLikOqLveV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="243982280"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="243982280"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 21:24:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="624217605"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 21:24:40 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Subject: Re: [PATCH -V10 RESEND 0/6] NUMA balancing: optimize memory
 placement for memory tiering system
References: <20211207022757.2523359-1-ying.huang@intel.com>
        <Yd79b6PptQMNzDRw@hirez.programming.kicks-ass.net>
        <87sftsumqd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yd/1r49RKgwCXCQL@hirez.programming.kicks-ass.net>
        <87o84fu9f3.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YeAid+EXvmH9WAbq@hirez.programming.kicks-ass.net>
        <871r1bu310.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Fri, 14 Jan 2022 13:24:38 +0800
In-Reply-To: <871r1bu310.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
        message of "Thu, 13 Jan 2022 22:24:43 +0800")
Message-ID: <87lezisxd5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Thu, Jan 13, 2022 at 08:06:40PM +0800, Huang, Ying wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>> > On Thu, Jan 13, 2022 at 03:19:06PM +0800, Huang, Ying wrote:
>>> >> Peter Zijlstra <peterz@infradead.org> writes:
>>> >> > On Tue, Dec 07, 2021 at 10:27:51AM +0800, Huang Ying wrote:
>>
>>> >> >> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
>>> >> >> for use like normal RAM"), the PMEM could be used as the
>>> >> >> cost-effective volatile memory in separate NUMA nodes.  In a typical
>>> >> >> memory tiering system, there are CPUs, DRAM and PMEM in each physical
>>> >> >> NUMA node.  The CPUs and the DRAM will be put in one logical node,
>>> >> >> while the PMEM will be put in another (faked) logical node.
>>> >> >
>>> >> > So what does a system like that actually look like, SLIT table wise, and
>>> >> > how does that affect init_numa_topology_type() ?
>>> >> 
>>> >> The SLIT table is as follows,
>>
>> <snip>
>>
>>> >> node distances:
>>> >> node   0   1   2   3 
>>> >>   0:  10  21  17  28 
>>> >>   1:  21  10  28  17 
>>> >>   2:  17  28  10  28 
>>> >>   3:  28  17  28  10 
>>> >> 
>>> >> init_numa_topology_type() set sched_numa_topology_type to NUMA_DIRECT.
>>> >> 
>>> >> The node 0 and node 1 are onlined during boot.  While the PMEM node,
>>> >> that is, node 2 and node 3 are onlined later.  As in the following dmesg
>>> >> snippet.
>>> >
>>> > But how? sched_init_numa() scans the *whole* SLIT table to determine
>>> > nr_levels / sched_domains_numa_levels, even offline nodes. Therefore it
>>> > should find 4 distinct distance values and end up not selecting
>>> > NUMA_DIRECT.
>>> >
>>> > Similarly for the other types it uses for_each_online_node(), which
>>> > would include the pmem nodes once they've been onlined, but I'm thinking
>>> > we explicitly want to skip CPU-less nodes in that iteration.
>>> 
>>> I used the debug patch as below, and get the log in dmesg as follows,
>>> 
>>> [    5.394577][    T1] sched_numa_topology_type: 0, levels: 4, max_distance: 28
>>> 
>>> I found that I forget another caller of init_numa_topology_type() run
>>> during hotplug.  I will add another printk() to show it.  Sorry about
>>> that.
>>
>> Can you try with this on?
>>
>> I'm suspecting there's a problem with init_numa_topology_type(); it will
>> never find the max distance due to the _online_ clause in the iteration,
>> since you said the pmem nodes are not online yet.
>>
>> ---
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index d201a7052a29..53ab9c63c185 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1756,6 +1756,8 @@ static void init_numa_topology_type(void)
>>  			return;
>>  		}
>>  	}
>> +
>> +	WARN(1, "no NUMA type determined");
>>  }
>
> Hi, Peter,
>
> I have run the test, the warning is triggered in the dmesg as follows.
> I will continue to debug hotplug tomorrow.

I did more experiments and found that init_numa_topology_type() will not
be called during PMEM nodes plugging in.  Because it will only be called
when a CPU of a never-onlined-before node is onlined.  There's no CPU on
the PMEM nodes (2/3).  So, when the PMEM node is onlined,
init_numa_topology_type() will not be called. And
sched_numa_topology_type will not be changed.

Best Regards,
Huang, Ying
