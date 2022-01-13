Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45B648D9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiAMOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:24:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:33180 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235638AbiAMOYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642083889; x=1673619889;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=2lwgn5Ak8FrAWeuWC+qm8/A59fs8zZe6onPZCttDNOQ=;
  b=RpBHXndfJxHylY3WJKztzC/Db88ST7wrhouNuIuXzkaTL5gBnTYMcNry
   EP2oJf7pwmNNujLmPn3DlmMvilAc13ul07vMyI6JtvhR+YfpZsVr6oxpw
   oCp9uzgxKNdQGtjqrT1rQFq8tFhaVBXte5pQVL7HbplJkxFxMZVz+FaMi
   AY8pGKjRNtC+6N/1aTAo2MUIOW3Y3InCeUhQX+MFLaq+f/+NVdf0jOidr
   46Sa0Jbjd/uA1kDilrj+5086PHKczTTSvJBZHcr8ChzuPwraL9e0JIddp
   vGbOKK6coGfXxJlwhy+7lBy2Jowh6pul9NLSsoHPM5P3xmyEJLky9wAXJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242832398"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="242832398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 06:24:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="529674005"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 06:24:45 -0800
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
Date:   Thu, 13 Jan 2022 22:24:43 +0800
In-Reply-To: <YeAid+EXvmH9WAbq@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 13 Jan 2022 14:00:39 +0100")
Message-ID: <871r1bu310.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jan 13, 2022 at 08:06:40PM +0800, Huang, Ying wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> > On Thu, Jan 13, 2022 at 03:19:06PM +0800, Huang, Ying wrote:
>> >> Peter Zijlstra <peterz@infradead.org> writes:
>> >> > On Tue, Dec 07, 2021 at 10:27:51AM +0800, Huang Ying wrote:
>
>> >> >> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
>> >> >> for use like normal RAM"), the PMEM could be used as the
>> >> >> cost-effective volatile memory in separate NUMA nodes.  In a typical
>> >> >> memory tiering system, there are CPUs, DRAM and PMEM in each physical
>> >> >> NUMA node.  The CPUs and the DRAM will be put in one logical node,
>> >> >> while the PMEM will be put in another (faked) logical node.
>> >> >
>> >> > So what does a system like that actually look like, SLIT table wise, and
>> >> > how does that affect init_numa_topology_type() ?
>> >> 
>> >> The SLIT table is as follows,
>
> <snip>
>
>> >> node distances:
>> >> node   0   1   2   3 
>> >>   0:  10  21  17  28 
>> >>   1:  21  10  28  17 
>> >>   2:  17  28  10  28 
>> >>   3:  28  17  28  10 
>> >> 
>> >> init_numa_topology_type() set sched_numa_topology_type to NUMA_DIRECT.
>> >> 
>> >> The node 0 and node 1 are onlined during boot.  While the PMEM node,
>> >> that is, node 2 and node 3 are onlined later.  As in the following dmesg
>> >> snippet.
>> >
>> > But how? sched_init_numa() scans the *whole* SLIT table to determine
>> > nr_levels / sched_domains_numa_levels, even offline nodes. Therefore it
>> > should find 4 distinct distance values and end up not selecting
>> > NUMA_DIRECT.
>> >
>> > Similarly for the other types it uses for_each_online_node(), which
>> > would include the pmem nodes once they've been onlined, but I'm thinking
>> > we explicitly want to skip CPU-less nodes in that iteration.
>> 
>> I used the debug patch as below, and get the log in dmesg as follows,
>> 
>> [    5.394577][    T1] sched_numa_topology_type: 0, levels: 4, max_distance: 28
>> 
>> I found that I forget another caller of init_numa_topology_type() run
>> during hotplug.  I will add another printk() to show it.  Sorry about
>> that.
>
> Can you try with this on?
>
> I'm suspecting there's a problem with init_numa_topology_type(); it will
> never find the max distance due to the _online_ clause in the iteration,
> since you said the pmem nodes are not online yet.
>
> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..53ab9c63c185 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1756,6 +1756,8 @@ static void init_numa_topology_type(void)
>  			return;
>  		}
>  	}
> +
> +	WARN(1, "no NUMA type determined");
>  }

Hi, Peter,

I have run the test, the warning is triggered in the dmesg as follows.
I will continue to debug hotplug tomorrow.

[    5.400923][    T1] ------------[ cut here ]------------
[    5.401917][    T1] no NUMA type determined
[    5.401921][    T1] WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:1760 init_numa_topology_type+0x199/0x1c0
[    5.403918][    T1] Modules linked in:
[    5.404917][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc8-00053-gbe30433a13c0 #1
[    5.405917][    T1] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
[    5.406917][    T1] RIP: 0010:init_numa_topology_type+0x199/0x1c0
[    5.407917][    T1] Code: de 82 41 89 dc e8 07 4f 4e 00 3d 00 04 00 00 44 0f 4e e0 3d ff 03 00 00 0f 8e ca fe ff ff 48 c7 c7 a7 88 55 82 e8 0c e5 b3 00 <0f> 0b e9 74 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f
[    5.408917][    T1] RSP: 0000:ffffc900000b7e00 EFLAGS: 00010286
[    5.409917][    T1] RAX: 0000000000000000 RBX: 0000000000000400 RCX: c0000000ffff7fff
[    5.410917][    T1] RDX: ffffc900000b7c28 RSI: 00000000ffff7fff RDI: 0000000000000000
[    5.411917][    T1] RBP: 000000000000001c R08: 0000000000000000 R09: ffffc900000b7c20
[    5.412917][    T1] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000400
[    5.413917][    T1] R13: 0000000000000400 R14: 0000000000000400 R15: 000000000000000c
[    5.414917][    T1] FS:  0000000000000000(0000) GS:ffff88903f600000(0000) knlGS:0000000000000000
[    5.415917][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.416917][    T1] CR2: ffff88df7fc01000 CR3: 0000005f7ec0a001 CR4: 00000000007706f0
[    5.417917][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.418917][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.419917][    T1] PKRU: 55555554
[    5.420917][    T1] Call Trace:
[    5.421919][    T1]  <TASK>
[    5.422919][    T1]  sched_init_numa+0x4a7/0x5c0
[    5.423918][    T1]  sched_init_smp+0x18/0x79
[    5.424918][    T1]  kernel_init_freeable+0x136/0x276
[    5.425918][    T1]  ? rest_init+0x100/0x100
[    5.426917][    T1]  kernel_init+0x16/0x140
[    5.427917][    T1]  ret_from_fork+0x1f/0x30
[    5.428918][    T1]  </TASK>
[    5.429919][    T1] ---[ end trace aa5563c4363f1ba3 ]---
[    5.430917][    T1] sched_numa_topology_type: 0, levels: 4, max_distance: 28

Best Regards,
Huang, Ying
