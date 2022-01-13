Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9F48D52C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiAMJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiAMJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:50:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD6C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y37C9xvvw/+7WYQ3rc48UmYY6uDeLG7OzcDKXO2aqx8=; b=FQO6F2qWxXEJz8BMcWRuli8cMy
        8Ym7pvpLbxxPiSTyrIlxpr51JWAIMB0e7atvLKsX1XRWccANpc+6TuUOffaLwmD6XI5zUBAHw5pd+
        TrxNxT/esx6y3izT6ZguUPXNbOoGcNfDsk1AglqaPHCegIRlK5cQgwr5sd+5LAMhvcIaRA58oTMH/
        4ZZhlOKHuOgc0C99s0wTaz5CisUMbxgvopMbJUmp9i/mghHAGsNI25veMPrk/+7enJ4ofwHG4gQi9
        vArxbx4HmCaDBhZoPSQpYI7DgwwFeowvaekwohV2nmKbN1+1+7PjvewxBTDe+R5QAq4Ge5sRFPlHj
        FTiBzahA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7wji-000x4a-Ok; Thu, 13 Jan 2022 09:49:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC92D3000E6;
        Thu, 13 Jan 2022 10:49:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B562A264EE43D; Thu, 13 Jan 2022 10:49:35 +0100 (CET)
Date:   Thu, 13 Jan 2022 10:49:35 +0100
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
Message-ID: <Yd/1r49RKgwCXCQL@hirez.programming.kicks-ass.net>
References: <20211207022757.2523359-1-ying.huang@intel.com>
 <Yd79b6PptQMNzDRw@hirez.programming.kicks-ass.net>
 <87sftsumqd.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sftsumqd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:19:06PM +0800, Huang, Ying wrote:
> Hi, Peter,
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Dec 07, 2021 at 10:27:51AM +0800, Huang Ying wrote:
> >> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
> >> for use like normal RAM"), the PMEM could be used as the
> >> cost-effective volatile memory in separate NUMA nodes.  In a typical
> >> memory tiering system, there are CPUs, DRAM and PMEM in each physical
> >> NUMA node.  The CPUs and the DRAM will be put in one logical node,
> >> while the PMEM will be put in another (faked) logical node.
> >
> > So what does a system like that actually look like, SLIT table wise, and
> > how does that affect init_numa_topology_type() ?
> 
> The SLIT table is as follows,
> 
> [000h 0000   4]                    Signature : "SLIT"    [System Locality Information Table]
> [004h 0004   4]                 Table Length : 0000042C
> [008h 0008   1]                     Revision : 01
> [009h 0009   1]                     Checksum : 59
> [00Ah 0010   6]                       Oem ID : "INTEL "
> [010h 0016   8]                 Oem Table ID : "S2600WF "
> [018h 0024   4]                 Oem Revision : 00000001
> [01Ch 0028   4]              Asl Compiler ID : "INTL"
> [020h 0032   4]        Asl Compiler Revision : 20091013
> 
> [024h 0036   8]                   Localities : 0000000000000004
> [02Ch 0044   4]                 Locality   0 : 0A 15 11 1C
> [030h 0048   4]                 Locality   1 : 15 0A 1C 11
> [034h 0052   4]                 Locality   2 : 11 1C 0A 1C
> [038h 0056   4]                 Locality   3 : 1C 11 1C 0A
> 
> The `numactl -H` output is as follows,
> 
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
> node 0 size: 64136 MB
> node 0 free: 5981 MB
> node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> node 1 size: 64466 MB
> node 1 free: 10415 MB
> node 2 cpus:
> node 2 size: 253952 MB
> node 2 free: 253920 MB
> node 3 cpus:
> node 3 size: 253952 MB
> node 3 free: 253951 MB
> node distances:
> node   0   1   2   3 
>   0:  10  21  17  28 
>   1:  21  10  28  17 
>   2:  17  28  10  28 
>   3:  28  17  28  10 
> 
> init_numa_topology_type() set sched_numa_topology_type to NUMA_DIRECT.
> 
> The node 0 and node 1 are onlined during boot.  While the PMEM node,
> that is, node 2 and node 3 are onlined later.  As in the following dmesg
> snippet.

But how? sched_init_numa() scans the *whole* SLIT table to determine
nr_levels / sched_domains_numa_levels, even offline nodes. Therefore it
should find 4 distinct distance values and end up not selecting
NUMA_DIRECT.

Similarly for the other types it uses for_each_online_node(), which
would include the pmem nodes once they've been onlined, but I'm thinking
we explicitly want to skip CPU-less nodes in that iteration.
