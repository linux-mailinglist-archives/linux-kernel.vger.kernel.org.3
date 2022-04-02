Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE64EFFC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352979AbiDBIwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiDBIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:52:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910306380
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648889412; x=1680425412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y7sSkd9UD22NCQ4FcQr0EgofGUC0OSFealjI83DxPQc=;
  b=SZVcy5yavA755IeqdjXXDGQU5t2XKmMwZt5L0p4XJ96tlQXHvnVfkigA
   RDAFdjFC6xPu3uEP4N6B7J3aoTdQW93xr5UxfuCKOQz2+X/zvPYmffj2R
   OjS/gzcA4xf9bslBBVNhda0Aq6wGYBuOeznnKVLS7ahA2VMztFrREnvcf
   ShxnoJg2iAOjHMLithTVgRydxQPkeErNV6d0L0PWWlvkK7knLkT7usddv
   +OatqCwnmBGSKGkSb3Hczgttm2XgQWwB+9kOOTpcnCJ/C2wZZfo15AOzB
   tDtTIlvGpq6rVeqzAQqLBndwrYyFl773MTUmyYHeg+OFIaqitkYxWQxQj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240876820"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="240876820"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 01:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="568141682"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2022 01:50:06 -0700
Date:   Sat, 2 Apr 2022 16:50:05 +0800
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
Message-ID: <20220402085005.GC32311@shbuild999.sh.intel.com>
References: <20220401094214.GA8368@xsang-OptiPlex-9020>
 <CAHk-=wg+mJrTvun6qkdEnkZk9FSyj6vNYU2j7QY-iPn0g_y1nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+mJrTvun6qkdEnkZk9FSyj6vNYU2j7QY-iPn0g_y1nw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Apr 01, 2022 at 09:35:24AM -0700, Linus Torvalds wrote:
> On Fri, Apr 1, 2022 at 2:42 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a 64.4% improvement of will-it-scale.per_thread_ops due to commit:
> > e39bb6be9f2b ("NUMA Balancing: add page promotion counter")
> 
> That looks odd and unlikely.
> 
> That commit only modifies some page counting statistics. Sure, it
> could be another cache layout thing, and maybe it's due to the subtle
> change in how NUMA_PAGE_MIGRATE gets counted, but it still looks a bit
> odd.

We did a quick check about cache stuff by disabling HW cache prefetch
completely (writing 0xf to MSR 0x1a4), and the performance change
is almost gone:

  ee97347fe058d020     e39bb6be9f2b39a6dbaeff48436 
  ----------------     --------------------------- 
    134793            -1.4%     132867        will-it-scale.per_thread_ops

The test box is a Cascadelake machine with 4 nodes, and the similar trend
is found on a 2 nodes machine, that the commit has 55% improvement with
HW cache prefetch enabled, and has less than 1% change when disabled.

Though we still cannot pin-point the exact place affected.

Also per our experience, the patch changing vm statistics can easily
trigger strange performance bumps for micro-benchmarks like will-it-scale,
stress-ng etc.

Thanks,
Feng


>                Linus
