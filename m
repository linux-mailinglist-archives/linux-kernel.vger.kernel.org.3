Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7754FB5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiDKITU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiDKITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:19:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8695133A05
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649665025; x=1681201025;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0SDytKNgnjB/MYuzpOQtWNCMJGuAnFbCKVUTPOrWFeY=;
  b=RO3sFwPVQVRIF8L48av81kqZXmHFcNfpeGJwzZgnj7dfWoEL506TAK0p
   mzbsBaX/cogfc7JRAMAKUVKeZfwm2aFti+Oa923T/wW0kUgquwswsOqq9
   E0JQNKgFoAwWJqTImycvOI0DaUQCTgos8wzbgoBYPeDiUqTihwgJF3Ukf
   3yrznX4aLnQtYSN2DBJ6MKNz6re0gR3qaPN9qKf4Sd2cHDEDTvUusNyp8
   vIiMdf7Z68R8jqF01+mT2NqSA5skZOFGI5wNmOQ219nb5ZzUmVQvsi2Zx
   dMtCo2nG5dRoyLf53CCDLh6hJBAzej5iUfadEb7D8PGD0zvXMse5S6vfQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="249345902"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="249345902"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:17:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572023054"
Received: from leichu-mobl1.ccr.corp.intel.com ([10.254.213.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:17:01 -0700
Message-ID: <1c87afeb5fec688ca1921f2f50e4b9fd92f6ce01.camel@intel.com>
Subject: Re: [PATCH 0/3] memory tiering: hot page selection
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 16:16:58 +0800
In-Reply-To: <20220408210709.ce4ede3a9c778700dda0a292@linux-foundation.org>
References: <20220408071222.219689-1-ying.huang@intel.com>
         <20220408210709.ce4ede3a9c778700dda0a292@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Thanks a lots for your comments!

On Fri, 2022-04-08 at 21:07 -0700, Andrew Morton wrote:
> On Fri,  8 Apr 2022 15:12:19 +0800 Huang Ying <ying.huang@intel.com>
> wrote:
> 
> > To optimize page placement in a memory tiering system with NUMA
> > balancing, the hot pages in the slow memory node need to be
> > identified.  Essentially, the original NUMA balancing
> > implementation
> > selects and promote the mostly recently accessed (MRU) pages.  But
> > the
> > recently accessed pages may be cold.
> 
> Wait.  What.  How on earth could the most recently accessed page be
> considered "cold"?
> 
> Changelog needs work, please.

Sorry for confusing.  What I really want to say is,

The pages with low accessing frequency should be kept in slow memory
node.  But these pages will still be accessed, so they may be selected
and migrated to the fast memory node by the original NUMA balancing
implementation upon accessing.

Are the new words better?

> > So in this patchset, we
> > implement a new hot page identification algorithm based on the
> > latency
> > between NUMA balancing page table scanning and hint page fault.
> 
> That sounds reasonable.
> 
> > And the hot page promotion can incur some overhead in the system. 
> > To
> > control the overhead a simple promotion rate limit mechanism is
> > implemented.
> 
> That sounds like a hack to fix a problem you just added?  Maybe a
> reasonable one..

Sorry again for confusing.  Try to reword it as follows,

If there are hot pages in slow memory node and cold pages in fast
memory node, we need to promote/demote hot/cold pages between the fast
and cold memory nodes.

One choice is to promote/demote as fast as possible.  But the CPU
cycles and memory bandwidth consumed by the fast promoting/demoting may
hurt the performance of the workload, e.g., the workload latency.

One way to resolve this issue is to restrict the max promoting/demoting
bandwidth.  It will take longer to finish the promoting/demoting.  But
the workload latency may be better.  This is implemented in this
patchset as the page promotion rate limit mechanism.

> > The hot threshold used to identify the hot pages is workload
> > dependent
> > usually.  So we also implemented a hot threshold automatic
> > adjustment
> > algorithm.  The basic idea is to increase/decrease the hot
> > threshold
> > to make the number of pages that pass the hot threshold (promote
> > candidate) near the rate limit.
> 
> hot threshold is tweakable via debugfs.  So it's an unstable
> interface,
> undocumented, may be withdrawn at any time, etc.
> 
> Please justify this.  Is it intended that this interface be removed? 
> If yes, please describe the plan for this in the changelog.  If no
> then
> this interface should be in sysfs, it should be fully documented in
> the
> kernel tree and it should be fully changelogged (preferably with
> usage
> examples) so that reviewers can best understand what is a permanent
> extension to the kernel API which we must maintain for all time.

Previously, I had added a hot threshold sysfs interface.  But later, I
thought that it's hard for the users to determine right hot threshold
value.  On the other hand, in patch [3/3], we implemented a hot
threshold automatic adjustment algorithm, which make it not so
important to set the hot threshold from the user space.  So I moved the
hot threshold setting interface to debugfs just for users to
experiment.  If it turns out that a formal interface is needed finally,
I will add one.

> Does this code build correctly if !LAST_CPUPID_NOT_IN_PAGE_FLAGS?
> 

I have relied on 0-Day kernel build service to capture the build bug of
more configurations and architectures.  But I just tried i386
architcture, and found that NUMA balancing isn't supported there, so I
cannot build test that for i386 too.  Should I try more?

> > TODO: Add ABI document for new sysctl knob.
> 
> um, yes.
> 

Sure.  Will do that in the next version.

> check_cpupid() is a poor function name.  Check for what?  Liver
> damage?
> A better identifier would be cpupid_valid(), perhaps.  And perhaps it
> should be implemented in mm.h.  And even documented.

Yes.  cpupid_valid() is much better.  I will add document for it in the
next version.

> Oddly, the proposed changes do a decent job of documenting
> intra-function changes but a poor job of documenting newly added
> functions.  Please review every new function and decide whether it is
> so simple and obvious that it can be added to Linux without any
> inline
> description at all.  
> 
> pgdat_free_space_enough() and  numa_hint_fault_latency().

Sure.  Will check all new functions and add document if necessary.

> numa_migration_check_rate_limit() particularly.  There's that "check"
> word again.  Check for what?
> 

The original idea is to check whether the migration is ratelimited. 
Will change this to numa_migration_rate_limit().  It will return true
if migration rate exceed the limit.

> 
> The numa_balancing_rate_limit_mbps sysctl.  I assume "b" means
> "bytes".
> That's better than "pages", but still.  Machines vary a lot in how
> many bytes they have and in the speed at which they process those
> bytes.  Is there some metric which we can use here which at least
> partially insulates us from this variability?  So that sysadmins
> don't
> need to set all their machines differently, based upon their size and
> speed?

Will change the sysctl to numb_balancing_promote_rate_limit_MBps to
avoid possible confusing.

The default rate limit is 64 GB/s, that is, no limitation.  As Mel
Gorman suggested.

To reduce the possible disturbing to the workload, A rule of thumb is
to set it to be 10% of the max slow memory bandwidth.  But we don't
know how to detect that automatically yet.

> numa_threshold_ts is apparently in units of jiffies.  This was not
> documented at the definition site, and it should be.  But jiffies can
> vary between machines and configs.  Why add this inter-machine and
> inter-config uncertainty/variability when we have
> include/linux/ktime.h?
> 

We need to call cmpxchg() on it, so ktime_t may be not the best choice
here.  But I got your idea.  I will use some more general time unit,
e.g. milli-second.

Best Regards,
Huang, Ying


