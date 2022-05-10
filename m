Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7346520DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiEJG2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiEJG15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:27:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D82B5CE0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652163818; x=1683699818;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmcOn+vAeSefIMXH0HwiPs/zqiGy3MSOs5uQ9EEbAc8=;
  b=IzdPARdSY7xAqna4eUhisPOux3Ht6Xnvg1Lv5g/XBPrVils/dI7/4/4p
   AOCRKAFWPBUqLNSzptU7uvf6Wt7kwmh8QHY/ZOKVvSIMYPIkMtki/pQt0
   2Qjv/cbLaP5nBx9Djb/gQDH4EVvENwSEKLuzjc4FcfYm7k/JMTyvtDkmm
   KJEvvAKxXdVWDFV72HjgpNueyTF8feIMqP98YBAOcxfhMNx294Ca0vi3e
   R4QiKem+EMv5FacrNGwCNt5gFMfICz6nvGuVNrhv7GZAFPZ09dH/X3A0E
   fa92a6K2+XTco95ade8mOoI5J5jDmTEsQKu2RLh/HeLwPeUKrDWAuRVD3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355703689"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="355703689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:23:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="519600498"
Received: from sijieyux-mobl3.ccr.corp.intel.com ([10.254.212.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:23:31 -0700
Message-ID: <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Date:   Tue, 10 May 2022 14:23:28 +0800
In-Reply-To: <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
         <YmvMDyx05UoPFtQy@ziqianlu-desk1>
         <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
         <YnURx04+hE0sQ3v3@ziqianlu-desk1>
         <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
         <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
         <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
         <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
         <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
         <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 11:43 +0800, Aaron Lu wrote:
> On 5/7/2022 3:44 PM, ying.huang@intel.com wrote:
> > On Sat, 2022-05-07 at 15:31 +0800, Aaron Lu wrote:
> 
> ... ...
> 
> > > 
> > > I thought the overhead of changing the cache line from "shared" to
> > > "own"/"modify" is pretty cheap.
> > 
> > This is the read/write pattern of cache ping-pong.  Although it should
> > be cheaper than the write/write pattern of cache ping-pong in theory, we
> > have gotten sevious regression for that before.
> > 
> 
> Can you point me to the regression report? I would like to take a look,
> thanks.

Sure.

https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/

> > > Also, this is the same case as the Skylake desktop machine, why it is a
> > > gain there but a loss here? 
> > 
> > I guess the reason is the private cache size.  The size of the private
> > L2 cache of SKL server is much larger than that of SKL client (1MB vs.
> > 256KB).  So there's much more core-2-core traffic on SKL server.
> > 
> 
> It could be. The 256KiB L2 in Skylake desktop can only store 8 order-3
> pages and that means the allocator side may have a higher chance of
> reusing a page that is evicted from the free cpu's L2 cache than the
> server machine, whose L2 can store 40 order-3 pages.
> 
> I can do more tests using different high for the two machines:
> 1) high=0, this is the case when page reuse is the extreme. core-2-core
> transfer should be the most. This is the behavior of this bisected commit.
> 2) high=L2_size, this is the case when page reuse is fewer compared to
> the above case, core-2-core should still be the majority.
> 3) high=2 times of L2_size and smaller than llc size, this is the case
> when cache reuse is further reduced, and when the page is indeed reused,
> it shouldn't cause core-2-core transfer but can benefit from llc.
> 4) high>llc_size, this is the case when page reuse is the least and when
> page is indeed reused, it is likely not in the entire cache hierarchy.
> This is the behavior of this bisected commit's parent commit for the
> Skylake desktop machine.
> 
> I expect case 3) should give us the best performance and 1) or 4) is the
> worst for this testcase.
> 
> case 4) is difficult to test on the server machine due to the cap of
> pcp->high which is affected by the low watermark of the zone. The server
> machine has 128 cpus but only 128G memory, which makes the pcp->high
> capped at 421, while llc size is 40MiB and that translates to a page
> number of 12288.
> > 

Sounds good to me.

Best Regards,
Huang, Ying

> > > Is it that this "overhead" is much greater
> > > in server machine to the extent that it is even better to use a totally
> > > cold page than a hot one?
> > 
> > Yes.  And I think the private cache size matters here.  And after being
> > evicted from the private cache (L1/L2), the cache lines of the reused
> > pages will go to shared cache (L3), that will help performance.
> > 
> 
> Sounds reasonable.
> 
> > > If so, it seems to suggest we should avoid
> > > cache reuse in server machine unless the two CPUs happens to be two
> > > hyperthreads of the same core.
> > 
> > Yes.  I think so.


