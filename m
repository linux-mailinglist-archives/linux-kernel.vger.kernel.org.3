Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9046CB80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhLHDUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:20:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:17506 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232839AbhLHDUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:20:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="217770062"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="217770062"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 19:16:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="502881240"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 19:16:30 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hasan Al Maruf <hasan3050@gmail.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        feng.tang@intel.com, hasanalmaruf@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mgorman@techsingularity.net, mhocko@suse.com, osalvador@suse.de,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        shy828301@gmail.com, weixugc@google.com, ziy@nvidia.com,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH -V10 RESEND 2/6] NUMA balancing: optimize page placement
 for memory tiering system
References: <20211207022757.2523359-3-ying.huang@intel.com>
        <20211207063639.83762-1-hasanalmaruf@fb.com>
Date:   Wed, 08 Dec 2021 11:16:28 +0800
In-Reply-To: <20211207063639.83762-1-hasanalmaruf@fb.com> (Hasan Al Maruf's
        message of "Tue, 7 Dec 2021 01:36:39 -0500")
Message-ID: <87wnkf3hwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasan Al Maruf <hasan3050@gmail.com> writes:

> Hi Huang,
>
>>+void set_numabalancing_state(bool enabled)
>>+{
>>+	if (enabled)
>>+		sysctl_numa_balancing_mode = NUMA_BALANCING_NORMAL;
>>+	else
>>+		sysctl_numa_balancing_mode = NUMA_BALANCING_DISABLED;
>>+	__set_numabalancing_state(enabled);
>>+}
>>+
>
> One of the properties of optimized NUMA Balancing for tiered memory is we
> are not going to scan top-tier nodes as promotion doesn't make sense there
> (implemented in the next patch [3/6]). However, if a system has only
> single memory node with CPU, does it make sense to run
> `NUMA_BALANCING_NORMAL` mode there? What do you think about downgrading to
> `NUMA_BALANCING_MEMORY_TIERING` mode if a user setup NUMA Balancing on
> the default mode of `NUMA_BALANCING_NORMAL` on a single toptier memory
> node?

Consider a system with only 1 NUMA node and no PMEM, should we refuse
NUMA balancing to be enabled at all?

Per my understanding, the philosophy behind is to keep thing as small as
possible instead of as smart as possible.  Do you agree?

>>diff --git a/mm/vmscan.c b/mm/vmscan.c
>>index c266e64d2f7e..5edb5dfa8900 100644
>>--- a/mm/vmscan.c
>>+++ b/mm/vmscan.c
>>@@ -56,6 +56,7 @@
>>
>> #include <linux/swapops.h>
>> #include <linux/balloon_compaction.h>
>>+#include <linux/sched/sysctl.h>
>>
>> #include "internal.h"
>>
>>@@ -3919,6 +3920,12 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
>> 	return false;
>> }
>>
>>+/*
>>+ * Keep the free pages on fast memory node a little more than the high
>>+ * watermark to accommodate the promoted pages.
>>+ */
>>+#define NUMA_BALANCING_PROMOTE_WATERMARK	(10UL * 1024 * 1024 >> PAGE_SHIFT)
>>+
>> /*
>>  * Returns true if there is an eligible zone balanced for the request order
>>  * and highest_zoneidx
>>@@ -3940,6 +3947,15 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>> 			continue;
>>
>> 		mark = high_wmark_pages(zone);
>>+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
>>+		    numa_demotion_enabled &&
>>+		    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE) {
>>+			unsigned long promote_mark;
>>+
>>+			promote_mark = min(NUMA_BALANCING_PROMOTE_WATERMARK,
>>+					   pgdat->node_present_pages >> 6);
>>+			mark += promote_mark;
>>+		}
>> 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
>> 			return true;
>> 	}
>
> This can be moved to a different patch. I think, this patch [2/6] can be
> splitted into two basic patches -- 1. NUMA Balancing interface for tiered
> memory and 2. maintaining a headroom for promotion.

Johannes has taught me that, if we introduce a new function, variable,
or interface, it's better to introduce its user together.  So that we
can determine whether it's necessary to do that, whether the definition
is suitable, etc.  I think that makes sense.  So I try to do that in
this patchset too.

As in [2/5] of your patchset below, another possibility is to make
1. NUMA balancing interface for tiered memory and 2. skip scanning top
tier memory in NUMA balancing in one patch.  One concern is that
although this is an optimization, there's almost no measurable
performance difference.  This makes it hard to justify to extend the
user space interface.  Do you have better data to support this?

> Instead of having a static value for `NUMA_BALANCING_PROMOTE_WATERMARK`
> what about decoupling the allocation and reclamation and add a user-space
> interface for controling them?

This means to add a new user space ABI.  Because we may need to support
the new ABI forever, we should have strong justification to add it.
I am not against to add an ABI to adjust promotion watermark in
general.  I think that the path could be,

- Have a simplest solution that works without introducing new ABI, like
  something in this patch, or revised.

- Then try to add a new ABI in a separate patch with enough
  justification, for example, with much improved performance data.

Do you agree?

> Do you think patch [2/5] and [3/5] of this series can be merged to your
> current patchset?
>
> https://lore.kernel.org/all/cover.1637778851.git.hasanalmaruf@fb.com/

Best Regards,
Huang, Ying
