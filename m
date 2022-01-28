Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE91549F4BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiA1Hvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:51:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:43372 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbiA1Hvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643356300; x=1674892300;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=wpCS26UCB6v8HTFdM+6Od262eQP30k1OkMytg8Ea+84=;
  b=NxW4eB2M2KECMWSPd5NBoFybugyZdmGOBIRPQne8ZCtGr+LWsd1JIU9/
   XZH6vPguSYxSfqdmGaySe57n13E8hnFU6T6yyvZyLDBfEEm86miLGoeZc
   iH9FKQi3gWC7WiJM8SRiE54Rs/sxTRxG/64Yk91JOx+dIyNabDGgHHdLe
   djjL1UEheLWj7PmjbuDeWtefeMT+YxHpR9LBiBDesXFQynZKQ1vBrNdso
   KNd50fcbSOLnRqMkRw6hQLVhRYCp4RHXLFvKchnz0ZpvDH29ws7oTIqn+
   ep0wqrRiMdVujhWBzHEJ/XX0galgXaWqnJrh0yAZSpMof1juTLxQVarGX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227049954"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227049954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:51:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="536036371"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:51:38 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 2/2] NUMA balancing: avoid to migrate task to
 CPU-less node
References: <20220128023842.1946583-1-ying.huang@intel.com>
        <20220128023842.1946583-2-ying.huang@intel.com>
        <20220128053341.GB618915@linux.vnet.ibm.com>
Date:   Fri, 28 Jan 2022 15:51:36 +0800
In-Reply-To: <20220128053341.GB618915@linux.vnet.ibm.com> (Srikar Dronamraju's
        message of "Fri, 28 Jan 2022 11:03:41 +0530")
Message-ID: <877dakti0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> * Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:42]:
>
>> In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
>> nodes.  But if the number of the hint page faults on a PMEM node is
>> the max for a task, The current NUMA balancing policy may try to place
>> the task on the PMEM node instead of DRAM node.  This is unreasonable,
>> because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
>> nodes are ignored when searching the migration target node for a task
>> in this patch.
>> 
>> To test the patch, we run a workload that accesses more memory in PMEM
>> node than memory in DRAM node.  Without the patch, the PMEM node will
>> be chosen as preferred node in task_numa_placement().  While the DRAM
>> node will be chosen instead with the patch.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> ---
>>  kernel/sched/fair.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 54e1aad1c5d7..e462ac5c1e48 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2393,6 +2393,10 @@ static void task_numa_placement(struct task_struct *p)
>>  			}
>>  		}
>> 
>> +		/* Cannot migrate task to CPU-less node */
>> +		if (!node_state(nid, N_CPU))
>> +			continue;
>> +
>
> Lets take the example that you quoted 2 socket machine with 1 DRAM node and
> 1 PMEM node per socket.  Now lets say the task is placed on a CPU in node 1
> but most of its memory faults are coming from node 2, which is the PMEM node
> attached to node 0. Now without the hunk, there is a chance that the task
> got moved to node 0. However with the change, are we inhibiting such a move?

This sounds reasonable.  How about the following solution?  If a
CPU-less node is selected as migration target, we select a nearest node
with CPU instead?  That is, something like the below patch.

Best Regards,
Huang, Ying

------------------------------8<---------------------------------
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..52d926d8cbdb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2401,6 +2401,23 @@ static void task_numa_placement(struct task_struct *p)
 		}
 	}
 
+	/* Cannot migrate task to CPU-less node */
+	if (!node_state(max_nid, N_CPU)) {
+		int near_nid = max_nid;
+		int distance, near_distance = INT_MAX;
+
+		for_each_online_node(nid) {
+			if (!node_state(nid, N_CPU))
+				continue;
+			distance = node_distance(max_nid, nid);
+			if (distance < near_distance) {
+				near_nid = nid;
+				near_distance = distance;
+			}
+		}
+		max_nid = near_nid;
+	}
+
 	if (ng) {
 		numa_group_count_active_nodes(ng);
 		spin_unlock_irq(group_lock);
