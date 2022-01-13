Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6948D86B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiAMNBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiAMNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:01:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E92C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y6HJF6oLf+uuPOOcPyE3SINVVAUQoRNIhsQLAe8u8cY=; b=aqL2i/Liplp4+SKIt8U3RtDmb0
        BpRErl4guZy52b+mc9K/VUgNWHCNJBj/dNT/cWbJpawWzxzDxgeXWI0n32vFj0NBg+roXHH3DVwUk
        z2ZA+5l2IRanVLPI+oaxM+2EBrtvqifjNC+O1CEF6edMHXXhut7btEDpQQtPAK0BtliqlRnEmKhMY
        CyBQQSiSUsdpuGoKA0B4q/mc7jilQdJfEVJQlEzpRK3mc/7vbbm63GR3Sqta1OOSHSUklm1SW59tW
        m5LV8lYgAxuxItHFkl/hMBkJCYAovKCYDiWnErGTSWVYPpQ+QcoMom9f647H/UzwopwZ1lNd+AMge
        lTOc093A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7zic-000y5l-9n; Thu, 13 Jan 2022 13:00:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98DE93001E1;
        Thu, 13 Jan 2022 14:00:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 462CC20DECE22; Thu, 13 Jan 2022 14:00:39 +0100 (CET)
Date:   Thu, 13 Jan 2022 14:00:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Message-ID: <YeAid+EXvmH9WAbq@hirez.programming.kicks-ass.net>
References: <20211207022757.2523359-1-ying.huang@intel.com>
 <Yd79b6PptQMNzDRw@hirez.programming.kicks-ass.net>
 <87sftsumqd.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yd/1r49RKgwCXCQL@hirez.programming.kicks-ass.net>
 <87o84fu9f3.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o84fu9f3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:06:40PM +0800, Huang, Ying wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Thu, Jan 13, 2022 at 03:19:06PM +0800, Huang, Ying wrote:
> >> Peter Zijlstra <peterz@infradead.org> writes:
> >> > On Tue, Dec 07, 2021 at 10:27:51AM +0800, Huang Ying wrote:

> >> >> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
> >> >> for use like normal RAM"), the PMEM could be used as the
> >> >> cost-effective volatile memory in separate NUMA nodes.  In a typical
> >> >> memory tiering system, there are CPUs, DRAM and PMEM in each physical
> >> >> NUMA node.  The CPUs and the DRAM will be put in one logical node,
> >> >> while the PMEM will be put in another (faked) logical node.
> >> >
> >> > So what does a system like that actually look like, SLIT table wise, and
> >> > how does that affect init_numa_topology_type() ?
> >> 
> >> The SLIT table is as follows,

<snip>

> >> node distances:
> >> node   0   1   2   3 
> >>   0:  10  21  17  28 
> >>   1:  21  10  28  17 
> >>   2:  17  28  10  28 
> >>   3:  28  17  28  10 
> >> 
> >> init_numa_topology_type() set sched_numa_topology_type to NUMA_DIRECT.
> >> 
> >> The node 0 and node 1 are onlined during boot.  While the PMEM node,
> >> that is, node 2 and node 3 are onlined later.  As in the following dmesg
> >> snippet.
> >
> > But how? sched_init_numa() scans the *whole* SLIT table to determine
> > nr_levels / sched_domains_numa_levels, even offline nodes. Therefore it
> > should find 4 distinct distance values and end up not selecting
> > NUMA_DIRECT.
> >
> > Similarly for the other types it uses for_each_online_node(), which
> > would include the pmem nodes once they've been onlined, but I'm thinking
> > we explicitly want to skip CPU-less nodes in that iteration.
> 
> I used the debug patch as below, and get the log in dmesg as follows,
> 
> [    5.394577][    T1] sched_numa_topology_type: 0, levels: 4, max_distance: 28
> 
> I found that I forget another caller of init_numa_topology_type() run
> during hotplug.  I will add another printk() to show it.  Sorry about
> that.

Can you try with this on?

I'm suspecting there's a problem with init_numa_topology_type(); it will
never find the max distance due to the _online_ clause in the iteration,
since you said the pmem nodes are not online yet.

---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..53ab9c63c185 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1756,6 +1756,8 @@ static void init_numa_topology_type(void)
 			return;
 		}
 	}
+
+	WARN(1, "no NUMA type determined");
 }
