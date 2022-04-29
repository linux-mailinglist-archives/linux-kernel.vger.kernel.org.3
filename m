Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09614514AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357952AbiD2Nmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiD2Nmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:42:43 -0400
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E4CABA6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:39:23 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 7E96BFB0C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:39:22 +0100 (IST)
Received: (qmail 2312 invoked from network); 29 Apr 2022 13:39:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Apr 2022 13:39:22 -0000
Date:   Fri, 29 Apr 2022 14:39:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <20220429133918.GC3441@techsingularity.net>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YmvMDyx05UoPFtQy@ziqianlu-desk1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 07:29:19PM +0800, Aaron Lu wrote:
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
> and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
> then do not use PCP but directly free the page directly to buddy.
> 

Yes.

> This regression occurred on a machine that has large caches so this
> optimization brings no value to it but only overhead(skipped PCP), I
> guess this is the reason why there is a regression.
> 
> I have also tested this case on a small machine: a skylake desktop and
> this commit shows improvement:
> 8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
> f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%
> 
> So this means those directly freed pages get reused by allocator side
> and that brings performance improvement for machines with smaller cache.
> 
> I wonder if we should still use PCP a little bit under the above said
> condition, for the purpose of:
> 1 reduced overhead in the free path for machines with large cache;
> 2 still keeps the benefit of reused pages for machines with smaller cache.
> 

Ideally yes although the exact timing is going to depend on the cache
size so even if it's right for one machine, it's not necessarily right
for another.

Going through the buddy, pages get reused quickly and remains cache
hot. Going through PCP contends less on zone->lock but pages get reused
too late on microbenchmarks dealing with small amounts of data. As the
threshold couldn't be predicted, I went with "free to buddy" immediately.

> > in testcase: netperf
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> > with following parameters:
> > 
> > 	ip: ipv4
> > 	runtime: 300s
> > 	nr_threads: 1
> > 	cluster: cs-localhost
> > 	test: UDP_STREAM
> > 	cpufreq_governor: performance
> > 	ucode: 0xd000331
> > 
> > test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> > test-url: http://www.netperf.org/netperf/
> > 
> > In addition to that, the commit also has significant impact on the following tests:
> >
> 
> > +------------------+-------------------------------------------------------------------------------------+
> > | testcase: change | netperf: netperf.Throughput_Mbps 13.2% improvement                                  |
> > | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
> > | test parameters  | cluster=cs-localhost                                                                |
> > |                  | cpufreq_governor=performance                                                        |
> > |                  | ip=ipv4                                                                             |
> > |                  | nr_threads=25%                                                                      |
> > |                  | runtime=300s                                                                        |
> > |                  | send_size=10K                                                                       |
> > |                  | test=SCTP_STREAM_MANY                                                               |
> > |                  | ucode=0xd000331                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> >
> 
> And when nr_pcp_high() returns (pcp->batch << 2), the improvement will
> drop from 13.2% to 5.7%, not great but still an improvement...
> 
> The said change looks like this:
> (relevant comment will have to be adjusted)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 505d59f7d4fa..130a02af8321 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3332,18 +3332,19 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
>  		       bool free_high)
>  {
>  	int high = READ_ONCE(pcp->high);
> +	int batch = READ_ONCE(pcp->batch);
>  
> -	if (unlikely(!high || free_high))
> +	if (unlikely(!high))
>  		return 0;
>  
> -	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
> -		return high;
> -
>  	/*
>  	 * If reclaim is active, limit the number of pages that can be
>  	 * stored on pcp lists
>  	 */
> -	return min(READ_ONCE(pcp->batch) << 2, high);
> +	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags) || free_high)
> +		return min(batch << 2, high);
> +
> +	return high;
>  }
>  
>  static void free_unref_page_commit(struct page *page, int migratetype,
> 
> Does this look sane? If so, I can prepare a formal patch with proper
> comment and changelog, thanks.

I think it looks reasonable sane. The corner case is that if
((high - (batch >> 2)) > cachesize) that the pages will not get recycled
quickly enough. On the plus side always freeing to buddy may contend on the
zone lock again and freeing in batches reduces that risk.

Given that zone lock contention is reduced regardless of cache size, it
seems like a reasonable tradeoff.

-- 
Mel Gorman
SUSE Labs
