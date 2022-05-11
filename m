Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED0522D70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiEKHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbiEKHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:32:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BA9D040
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652254343; x=1683790343;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDhdCpyLbxPHKHgsMe8I/CSGQvUsFpQZ0U6Xht0vSRI=;
  b=YqxrbrNswIKpoeQwm1I12woFV03aGJlqOVv/D0jZPNjzgqG+S9IXuC5w
   MILrKdGD20GouPEvUWEmKmSn9O05gsH9WYGGsehPuwDpd1pBc85zH8nWR
   JXYd7Jej31TWg85edKV/i0gRJVqIddMyUO8s/jZp4CYjp2q+52wdw0lRh
   n1GZKRYZQG/qisQHkhfdgUKs3bKsSfS3sZyWZClK6V+GpCRjbpPogpYMR
   gutXcNNzTaF19K4TVMWRKCPFf8EJKfCZ/B3Wxw/l5gkefxz1dvmesBnj2
   q99f+zYndWpdJbfoDESwD8QzXoQHmA28RFZ1K6MmsZsz7pdFIsOph5B9l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267205805"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="267205805"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:32:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="593982182"
Received: from rliu1-mobl1.ccr.corp.intel.com ([10.254.213.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:32:18 -0700
Message-ID: <4e9d67b4d2ed8b4851a93b2a79a04e860d1f36b9.camel@intel.com>
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
Date:   Wed, 11 May 2022 15:32:15 +0800
In-Reply-To: <YnswSZQAfRAWr+z0@ziqianlu-desk1>
References: <YmvMDyx05UoPFtQy@ziqianlu-desk1>
         <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
         <YnURx04+hE0sQ3v3@ziqianlu-desk1>
         <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
         <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
         <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
         <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
         <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
         <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
         <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
         <YnswSZQAfRAWr+z0@ziqianlu-desk1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 11:40 +0800, Aaron Lu wrote:
> On Tue, May 10, 2022 at 02:23:28PM +0800, ying.huang@intel.com wrote:
> > On Tue, 2022-05-10 at 11:43 +0800, Aaron Lu wrote:
> > > On 5/7/2022 3:44 PM, ying.huang@intel.com wrote:
> > > > On Sat, 2022-05-07 at 15:31 +0800, Aaron Lu wrote:
> > > 
> > > ... ...
> > > 
> > > > > 
> > > > > I thought the overhead of changing the cache line from "shared" to
> > > > > "own"/"modify" is pretty cheap.
> > > > 
> > > > This is the read/write pattern of cache ping-pong.  Although it should
> > > > be cheaper than the write/write pattern of cache ping-pong in theory, we
> > > > have gotten sevious regression for that before.
> > > > 
> > > 
> > > Can you point me to the regression report? I would like to take a look,
> > > thanks.
> > 
> > Sure.
> > 
> > https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> > 
> > > > > Also, this is the same case as the Skylake desktop machine, why it is a
> > > > > gain there but a loss here? 
> > > > 
> > > > I guess the reason is the private cache size.  The size of the private
> > > > L2 cache of SKL server is much larger than that of SKL client (1MB vs.
> > > > 256KB).  So there's much more core-2-core traffic on SKL server.
> > > > 
> > > 
> > > It could be. The 256KiB L2 in Skylake desktop can only store 8 order-3
> > > pages and that means the allocator side may have a higher chance of
> > > reusing a page that is evicted from the free cpu's L2 cache than the
> > > server machine, whose L2 can store 40 order-3 pages.
> > > 
> > > I can do more tests using different high for the two machines:
> > > 1) high=0, this is the case when page reuse is the extreme. core-2-core
> > > transfer should be the most. This is the behavior of this bisected commit.
> > > 2) high=L2_size, this is the case when page reuse is fewer compared to
> > > the above case, core-2-core should still be the majority.
> > > 3) high=2 times of L2_size and smaller than llc size, this is the case
> > > when cache reuse is further reduced, and when the page is indeed reused,
> > > it shouldn't cause core-2-core transfer but can benefit from llc.
> > > 4) high>llc_size, this is the case when page reuse is the least and when
> > > page is indeed reused, it is likely not in the entire cache hierarchy.
> > > This is the behavior of this bisected commit's parent commit for the
> > > Skylake desktop machine.
> > > 
> > > I expect case 3) should give us the best performance and 1) or 4) is the
> > > worst for this testcase.
> > > 
> > > case 4) is difficult to test on the server machine due to the cap of
> > > pcp->high which is affected by the low watermark of the zone. The server
> > > machine has 128 cpus but only 128G memory, which makes the pcp->high
> > > capped at 421, while llc size is 40MiB and that translates to a page
> > > number of 12288.
> > > > 
> > 
> > Sounds good to me.
> 
> I've run the tests on a 2 sockets Icelake server and a Skylake desktop.
> 
> On this 2 sockets Icelake server(1.25MiB L2 = 320 pages, 48MiB LLC =
> 12288 pages):
> 
> pcp->high      score
>     0          100662 (bypass PCP, most page resue, most core-2-core transfer)
>   320(L2)      117252
>   640          133149
>  6144(1/2 llc) 134674
> 12416(>llc)    103193 (least page reuse)
> 
> Setting pcp->high to 640(2 times L2 size) gives very good result, only
> slightly lower than 6144(1/2 llc size). Bypassing PCP to get the most
> cache reuse didn't deliver good performance, so I think Ying is right:
> core-2-core really hurts.
> 
> On this 4core/8cpu Skylake desktop(256KiB L2 = 64 pages, 8MiB LLC = 2048
> pages):
> 
>    0           86780 (bypass PCP, most page reuse, most core-2-core transfer)
>   64(L2)       85813
>  128           85521
> 1024(1/2 llc)  85557
> 2176(> llc)    74458 (least page reuse)
> 
> Things are different on this small machine. Bypassing PCP gives the best
> performance. I find it hard to explain this. Maybe the 256KiB is too
> small that even bypassing PCP, the page still ends up being evicted from
> L2 when allocator side reuses it? Or maybe core-2-core transfer is
> fast on this small machine?

86780 / 85813 = 1.011

So, there's almost no measurable difference among the configurations
except the last one.  I would rather say the test isn't sensitive to L2
size, but sensitive to LLC size on this machine.

Best Regards,
Huang, Ying

> P.S. I've blindly setting pcp->high to the above value, ignoring zone's
> low watermark cap for testing purpose.


