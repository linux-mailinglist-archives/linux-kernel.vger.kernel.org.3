Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4B4F5B24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiDFJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583056AbiDFJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:35:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B0068FB8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649209314; x=1680745314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jS0mTy6ZTROUsnVE2643D/khG3eHsXQHKYgDfRMLldc=;
  b=QrW3DlQgqD6sdaIrPERmioWm2pcug3ymwKtzANBntvF5g4ls2qWDUnab
   Yrh48KJldQOnFeREjajCHtHQk3bW0835TnjFyFULIpVgS/i8qmCc1FotG
   7g2ilRa5+hshD8/w70bwvAXrl3Akunqa7uTAAGONDJDU4b3WNmHSU3ZEy
   mCN7AThH0D0QaS36BmXjD0DTZUBp2zou7SnsDx8nbRYgFDZhJAm9gem7s
   wRkRNzwc1FGEa9g45WANbrCG03gWHoqNV/LwHl4btgO/S53B6tzeL0RhD
   1Dc9ipKQrCLZweDJY9vF81MN3MthzP2jNG3TqhfFbKtFoH5cZtJS65VOV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324091443"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="324091443"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 18:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="570275381"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2022 18:41:48 -0700
Date:   Wed, 6 Apr 2022 09:41:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Subject: Re: [NUMA Balancing] e39bb6be9f: will-it-scale.per_thread_ops 64.4%
 improvement
Message-ID: <20220406014147.GA64277@shbuild999.sh.intel.com>
References: <20220401094214.GA8368@xsang-OptiPlex-9020>
 <CAHk-=wg+mJrTvun6qkdEnkZk9FSyj6vNYU2j7QY-iPn0g_y1nw@mail.gmail.com>
 <20220402085005.GC32311@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402085005.GC32311@shbuild999.sh.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 04:50:05PM +0800, Feng Tang wrote:
> Hi Linus,
> 
> On Fri, Apr 01, 2022 at 09:35:24AM -0700, Linus Torvalds wrote:
> > On Fri, Apr 1, 2022 at 2:42 AM kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > > FYI, we noticed a 64.4% improvement of will-it-scale.per_thread_ops due to commit:
> > > e39bb6be9f2b ("NUMA Balancing: add page promotion counter")
> > 
> > That looks odd and unlikely.
> > 
> > That commit only modifies some page counting statistics. Sure, it
> > could be another cache layout thing, and maybe it's due to the subtle
> > change in how NUMA_PAGE_MIGRATE gets counted, but it still looks a bit
> > odd.
> 
> We did a quick check about cache stuff by disabling HW cache prefetch
> completely (writing 0xf to MSR 0x1a4), and the performance change
> is almost gone:
> 
>   ee97347fe058d020     e39bb6be9f2b39a6dbaeff48436 
>   ----------------     --------------------------- 
>     134793            -1.4%     132867        will-it-scale.per_thread_ops
> 
> The test box is a Cascadelake machine with 4 nodes, and the similar trend
> is found on a 2 nodes machine, that the commit has 55% improvement with
> HW cache prefetch enabled, and has less than 1% change when disabled.
> 
> Though we still cannot pin-point the exact place affected.
 
We did more tests and debugs, and here are some updates:

* For the HW cache prefetcher, we narrowed down it to be related with
  'L2 cache prefetcher', and not the 'L2 adjacent cache line prefetcher'.
  We can't find any documents about the detail of the prefetcher, which
  make it hard to analyze how the performance is affected

* Debug shows the change is related with the struct 'mem_cgroup''s size
  change, that with commit ee97347fe058d020, its size is 4096, which turns
  to 4160 with commit e39bb6be9f2b3.
  - commit e39bb6be9f2b adds one counter 'PGPROMOTE_SUCCESS' and some
    code change, if we remove the code change and leave the counter,
    the 60% improvement remains.
  - revert e39bb6be9f2b, and only add 16 bytes padding inside 'mem_cgroup',
    the 60% change also remains. Debug patch is as below:

	diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
	index a68dce3873fcc..2bd56fb2e5b5f 100644
	--- a/include/linux/memcontrol.h
	+++ b/include/linux/memcontrol.h
	@@ -303,6 +303,8 @@ struct mem_cgroup {
		/* memory.stat */
		struct memcg_vmstats	vmstats;
	 
	+	unsigned long padding[2];
	+
		/* memory.events */
		atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];

Thanks,
Feng

> Also per our experience, the patch changing vm statistics can easily
> trigger strange performance bumps for micro-benchmarks like will-it-scale,
> stress-ng etc.
> 
> Thanks,
> Feng
> 
> 
> >                Linus
