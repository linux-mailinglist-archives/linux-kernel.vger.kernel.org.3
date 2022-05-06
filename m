Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A98351D38E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390220AbiEFIoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390216AbiEFIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:44:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9D5B3D7
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651826452; x=1683362452;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrGPP0wdU1m8YDsOqid/12IF8MjBkyBNkqejD+7ex4M=;
  b=JX20wX8SW4g/kiRdBvE6V/IRWD1LolkYnV552eKIyjORbvK/ThBT2I/U
   MKKCg2Y6EIvoaTpfnOLLpcnewS6NAehhTVNFQ96RNOxOSJyP606o9RfTN
   Ma6iu+TDWzNc7Vh/mHSxIbSQaSB+Yv5Kjbl/hDYLOBYPEVbP8JbesvsnH
   IUH9rr/PyxFHVe6NvCJ5H/mkOKkDY1z39igyUVCJyoKrH1elbaQLQ8f8D
   5NzpvCzsqkAZgQmjYa1EYVFXUJgkR080DLZOEr3Kgxw1gLtlHdu1uuiTu
   kdjO6QPoxHRxyNNve1ZElwosoCdeAt4XHZ0fwmQ7m9upqf5CR2eySbHIY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331384953"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331384953"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:40:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695068117"
Received: from fulaizha-mobl1.ccr.corp.intel.com ([10.254.213.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:40:47 -0700
Message-ID: <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
Subject: Re: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0%
 regression
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Date:   Fri, 06 May 2022 16:40:45 +0800
In-Reply-To: <YmvMDyx05UoPFtQy@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
         <YmvMDyx05UoPFtQy@ziqianlu-desk1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-29 at 19:29 +0800, Aaron Lu wrote:
> Hi Mel,
> 
> On Wed, Apr 20, 2022 at 09:35:26AM +0800, kernel test robot wrote:
> > 
> > (please be noted we reported
> > "[mm/page_alloc]  39907a939a:  netperf.Throughput_Mbps -18.1% regression"
> > on
> > https://lore.kernel.org/all/20220228155733.GF1643@xsang-OptiPlex-9020/
> > while the commit is on branch.
> > now we still observe similar regression when it's on mainline, and we also
> > observe a 13.2% improvement on another netperf subtest.
> > so report again for information)
> > 
> > Greeting,
> > 
> > FYI, we noticed a -18.0% regression of netperf.Throughput_Mbps due to commit:
> > 
> > 
> > commit: f26b3fa046116a7dedcaafe30083402113941451 ("mm/page_alloc: limit number of high-order pages on PCP during bulk free")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> 
> So what this commit did is: if a CPU is always doing free(pcp->free_factor > 0)

IMHO, this means the consumer and producer are running on different
CPUs.

> and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
> then do not use PCP but directly free the page directly to buddy.
> 
> The rationale as explained in the commit's changelog is:
> "
> Netperf running on localhost exhibits this pattern and while it does not
> matter for some machines, it does matter for others with smaller caches
> where cache misses cause problems due to reduced page reuse. Pages
> freed directly to the buddy list may be reused quickly while still cache
> hot where as storing on the PCP lists may be cold by the time
> free_pcppages_bulk() is called.
> "
> 
> This regression occurred on a machine that has large caches so this
> optimization brings no value to it but only overhead(skipped PCP), I
> guess this is the reason why there is a regression.

Per my understanding, not only the cache size is larger, but also the L2
cache (1MB) is per-core on this machine.  So if the consumer and
producer are running on different cores, the cache-hot page may cause
more core-to-core cache transfer.  This may hurt performance too.

> I have also tested this case on a small machine: a skylake desktop and
> this commit shows improvement:
> 8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
> f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%
>
> So this means those directly freed pages get reused by allocator side
> and that brings performance improvement for machines with smaller cache.

Per my understanding, the L2 cache on this desktop machine is shared
among cores.

> I wonder if we should still use PCP a little bit under the above said
> condition, for the purpose of:
> 1 reduced overhead in the free path for machines with large cache;
> 2 still keeps the benefit of reused pages for machines with smaller cache.
> 
> For this reason, I tested increasing nr_pcp_high() from returning 0 to
> either returning pcp->batch or (pcp->batch << 2):
> machine\nr_pcp_high() ret: pcp->high   0   pcp->batch (pcp->batch << 2)
> skylake desktop:             72288   90784   92219       91528
> icelake 2sockets:           120956   99177   98251      116108
> 
> note nr_pcp_high() returns pcp->high is the behaviour of this commit's
> parent, returns 0 is the behaviour of this commit.
> 
> The result shows, if we effectively use a PCP high as (pcp->batch << 2)
> for the described condition, then this workload's performance on
> small machine can remain while the regression on large machines can be
> greately reduced(from -18% to -4%).
> 

Can we use cache size and topology information directly?

> 
Best Regards,
Huang, Ying

[snip]


