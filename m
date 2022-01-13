Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83248D720
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiAMMHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:07:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:29254 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234383AbiAMMGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642075611; x=1673611611;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4fWpAMCkMJpXx/DYwwFItfouhoPnra/h+mOm6olLclQ=;
  b=G9c+jNIzfDpIVqKokYhAX9q/6r37xAOokbjdUxVaYF4JGHHpNJzBUhz+
   sRYx4wURnbOpbNDRM9NCMjkNJJXMJZG6nLlPkKE/7t89DwHei7eOCXnAm
   uyw1Jh8URn3FskhP0UBpsDwjq3oAnwspx9h3JGVmfDhj/MEF4KTcRxsio
   DIIeqqjnF9k6Kq50f4FohyCmNimHEYJLimfuXXGbPlyonPMG0jYEMQSrT
   wd4Bt9YsmxpJc6ZSmlc7JdXzWSAXbJJVeMaG1lI8MfKpRNah9UK0x75Qp
   8DrVbekRMlIN7BI/6Oy5egP1FpInpe2zSW60gSxIXhEeXPB8EaN9cIsQ6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307339456"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307339456"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 04:06:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="475290041"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 04:06:42 -0800
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
Date:   Thu, 13 Jan 2022 20:06:40 +0800
In-Reply-To: <Yd/1r49RKgwCXCQL@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 13 Jan 2022 10:49:35 +0100")
Message-ID: <87o84fu9f3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jan 13, 2022 at 03:19:06PM +0800, Huang, Ying wrote:
>> Hi, Peter,
>> 
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>> > On Tue, Dec 07, 2021 at 10:27:51AM +0800, Huang Ying wrote:
>> >> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
>> >> for use like normal RAM"), the PMEM could be used as the
>> >> cost-effective volatile memory in separate NUMA nodes.  In a typical
>> >> memory tiering system, there are CPUs, DRAM and PMEM in each physical
>> >> NUMA node.  The CPUs and the DRAM will be put in one logical node,
>> >> while the PMEM will be put in another (faked) logical node.
>> >
>> > So what does a system like that actually look like, SLIT table wise, and
>> > how does that affect init_numa_topology_type() ?
>> 
>> The SLIT table is as follows,
>> 
>> [000h 0000   4]                    Signature : "SLIT"    [System Locality Information Table]
>> [004h 0004   4]                 Table Length : 0000042C
>> [008h 0008   1]                     Revision : 01
>> [009h 0009   1]                     Checksum : 59
>> [00Ah 0010   6]                       Oem ID : "INTEL "
>> [010h 0016   8]                 Oem Table ID : "S2600WF "
>> [018h 0024   4]                 Oem Revision : 00000001
>> [01Ch 0028   4]              Asl Compiler ID : "INTL"
>> [020h 0032   4]        Asl Compiler Revision : 20091013
>> 
>> [024h 0036   8]                   Localities : 0000000000000004
>> [02Ch 0044   4]                 Locality   0 : 0A 15 11 1C
>> [030h 0048   4]                 Locality   1 : 15 0A 1C 11
>> [034h 0052   4]                 Locality   2 : 11 1C 0A 1C
>> [038h 0056   4]                 Locality   3 : 1C 11 1C 0A
>> 
>> The `numactl -H` output is as follows,
>> 
>> available: 4 nodes (0-3)
>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
>> node 0 size: 64136 MB
>> node 0 free: 5981 MB
>> node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
>> node 1 size: 64466 MB
>> node 1 free: 10415 MB
>> node 2 cpus:
>> node 2 size: 253952 MB
>> node 2 free: 253920 MB
>> node 3 cpus:
>> node 3 size: 253952 MB
>> node 3 free: 253951 MB
>> node distances:
>> node   0   1   2   3 
>>   0:  10  21  17  28 
>>   1:  21  10  28  17 
>>   2:  17  28  10  28 
>>   3:  28  17  28  10 
>> 
>> init_numa_topology_type() set sched_numa_topology_type to NUMA_DIRECT.
>> 
>> The node 0 and node 1 are onlined during boot.  While the PMEM node,
>> that is, node 2 and node 3 are onlined later.  As in the following dmesg
>> snippet.
>
> But how? sched_init_numa() scans the *whole* SLIT table to determine
> nr_levels / sched_domains_numa_levels, even offline nodes. Therefore it
> should find 4 distinct distance values and end up not selecting
> NUMA_DIRECT.
>
> Similarly for the other types it uses for_each_online_node(), which
> would include the pmem nodes once they've been onlined, but I'm thinking
> we explicitly want to skip CPU-less nodes in that iteration.

I used the debug patch as below, and get the log in dmesg as follows,

[    5.394577][    T1] sched_numa_topology_type: 0, levels: 4, max_distance: 28

I found that I forget another caller of init_numa_topology_type() run
during hotplug.  I will add another printk() to show it.  Sorry about
that.

Best Regards,
Huang, Ying

-------------------------------8<------------------------------------
From 11cea4be2db6220333d84f5b168174f534ac0933 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Thu, 13 Jan 2022 09:53:15 +0800
Subject: [PATCH] dbg: show sched_numa_topology_type

---
 kernel/sched/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..9d92191fd62d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1914,6 +1914,10 @@ void sched_init_numa(void)
 
 	init_numa_topology_type();
 
+	pr_info("sched_numa_topology_type: %d, levels: %d, max_distance: %d\n",
+		sched_numa_topology_type, sched_domains_numa_levels,
+		sched_max_numa_distance);
+
 	sched_numa_onlined_nodes = bitmap_alloc(nr_node_ids, GFP_KERNEL);
 	if (!sched_numa_onlined_nodes)
 		return;
-- 
2.30.2

