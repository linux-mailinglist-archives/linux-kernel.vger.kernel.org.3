Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DE51E513
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445976AbiEGHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiEGHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:15:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5D186C4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651907507; x=1683443507;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4JxHFmsYcymXr8Ke2ayjVAeIIlldY+X3WwkZJ8AkNQ=;
  b=XvhA78SWRaw4Tyv/GWWif0EfwQso+hKzQvDCWgz7nZsUl22wXC/Y1MtT
   heCYZXcPqBlUSzYntYx+PFf9y5iNc64DsMVtC6yz94Xi11a0DbUzfgwus
   Wv5YV/SZI8rcrLOfwamol+Z9h1W2Ps2b9TIq4EEaEsBdrPLXaeQvy6dop
   b+puvxS0JYrJl0D9y1sSYCszo4ZjEioO3gI/ZUO90wS1H19yTnC7Vq/vJ
   0mFtc71CBZULjH5854GiK7Y38enH/qAuj4HLMeLB6ieyh7Egp9dAJzQVG
   ptu4DjxTYgPKiVnpgMbsFoAvb9jjMD/UckOehBwySmCt1/ysebDTvTUCN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="256158079"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="256158079"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:11:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="538237424"
Received: from sjin6-mobl1.ccr.corp.intel.com ([10.254.214.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:11:43 -0700
Message-ID: <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
Subject: Re: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0%
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
Date:   Sat, 07 May 2022 15:11:41 +0800
In-Reply-To: <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
         <YmvMDyx05UoPFtQy@ziqianlu-desk1>
         <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
         <YnURx04+hE0sQ3v3@ziqianlu-desk1>
         <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
         <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-07 at 11:27 +0800, Aaron Lu wrote:
> On Sat, May 07, 2022 at 08:54:35AM +0800, ying.huang@intel.com wrote:
> > On Fri, 2022-05-06 at 20:17 +0800, Aaron Lu wrote:
> > > On Fri, May 06, 2022 at 04:40:45PM +0800, ying.huang@intel.com wrote:
> > > > On Fri, 2022-04-29 at 19:29 +0800, Aaron Lu wrote:
> > > > > Hi Mel,
> > > > > 
> > > > > On Wed, Apr 20, 2022 at 09:35:26AM +0800, kernel test robot wrote:
> > > > > > 
> > > > > > (please be noted we reported
> > > > > > "[mm/page_alloc]  39907a939a:  netperf.Throughput_Mbps -18.1% regression"
> > > > > > on
> > > > > > https://lore.kernel.org/all/20220228155733.GF1643@xsang-OptiPlex-9020/
> > > > > > while the commit is on branch.
> > > > > > now we still observe similar regression when it's on mainline, and we also
> > > > > > observe a 13.2% improvement on another netperf subtest.
> > > > > > so report again for information)
> > > > > > 
> > > > > > Greeting,
> > > > > > 
> > > > > > FYI, we noticed a -18.0% regression of netperf.Throughput_Mbps due to commit:
> > > > > > 
> > > > > > 
> > > > > > commit: f26b3fa046116a7dedcaafe30083402113941451 ("mm/page_alloc: limit number of high-order pages on PCP during bulk free")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > > 
> > > > > 
> > > > > So what this commit did is: if a CPU is always doing free(pcp->free_factor > 0)
> > > > 
> > > > IMHO, this means the consumer and producer are running on different
> > > > CPUs.
> > > > 
> > > 
> > > Right.
> > > 
> > > > > and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
> > > > > then do not use PCP but directly free the page directly to buddy.
> > > > > 
> > > > > The rationale as explained in the commit's changelog is:
> > > > > "
> > > > > Netperf running on localhost exhibits this pattern and while it does not
> > > > > matter for some machines, it does matter for others with smaller caches
> > > > > where cache misses cause problems due to reduced page reuse. Pages
> > > > > freed directly to the buddy list may be reused quickly while still cache
> > > > > hot where as storing on the PCP lists may be cold by the time
> > > > > free_pcppages_bulk() is called.
> > > > > "
> > > > > 
> > > > > This regression occurred on a machine that has large caches so this
> > > > > optimization brings no value to it but only overhead(skipped PCP), I
> > > > > guess this is the reason why there is a regression.
> > > > 
> > > > Per my understanding, not only the cache size is larger, but also the L2
> > > > cache (1MB) is per-core on this machine.  So if the consumer and
> > > > producer are running on different cores, the cache-hot page may cause
> > > > more core-to-core cache transfer.  This may hurt performance too.
> > > > 
> > > 
> > > Client side allocates skb(page) and server side recvfrom() it.
> > > recvfrom() copies the page data to server's own buffer and then releases
> > > the page associated with the skb. Client does all the allocation and
> > > server does all the free, page reuse happens at client side.
> > > So I think core-2-core cache transfer due to page reuse can occur when
> > > client task migrates.
> > 
> > The core-to-core cache transfering can be cross-socket or cross-L2 in
> > one socket.  I mean the later one.
> > 
> > > I have modified the job to have the client and server bound to a
> > > specific CPU of different cores on the same node, and testing it on the
> > > same Icelake 2 sockets server, the result is
> > > 
> > >   kernel      throughput
> > > 8b10b465d0e1     125168
> > > f26b3fa04611     102039 -18%
> > > 
> > > It's also a 18% drop. I think this means c2c is not a factor?
> > 
> > Can you test with client and server bound to 2 hardware threads
> > (hyperthread) of one core?  The two hardware threads of one core will
> > share the L2 cache.
> > 
> 
> 8b10b465d0e1: 89702
> f26b3fa04611: 95823 +6.8%
> 
> When binding client and server on the 2 threads of the same core, the
> bisected commit is an improvement now on this 2 sockets Icelake server.

Good.  I guess cache-hot works now.

> > > > > I have also tested this case on a small machine: a skylake desktop and
> > > > > this commit shows improvement:
> > > > > 8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
> > > > > f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%
> > > > > 
> > > > > So this means those directly freed pages get reused by allocator side
> > > > > and that brings performance improvement for machines with smaller cache.
> > > > 
> > > > Per my understanding, the L2 cache on this desktop machine is shared
> > > > among cores.
> > > > 
> > > 
> > > The said CPU is i7-6700 and according to this wikipedia page,
> > > L2 is per core:
> > > https://en.wikipedia.org/wiki/Skylake_(microarchitecture)#Mainstream_desktop_processors
> > 
> > Sorry, my memory was wrong.  The skylake and later server has much
> > larger private L2 cache (1MB vs 256KB of client), this may increase the
> > possibility of core-2-core transfering.
> > 
> 
> I'm trying to understand where is the core-2-core cache transfer.
> 
> When server needs to do the copy in recvfrom(), there is core-2-core
> cache transfer from client cpu to server cpu. But this is the same no
> matter page gets reused or not, i.e. the bisected commit and its parent
> doesn't have any difference in this step. 

Yes.

> Then when page gets reused in
> the client side, there is no core-2-core cache transfer as the server
> side didn't do write to the page's data.

The "reused" pages were read by the server side, so their cache lines
are in "shared" state, some inter-core traffic is needed to shoot down
these cache lines before the client side writes them.  This will incur
some overhead.

Best Regards,
Huang, Ying

> So page reuse or not, it
> shouldn't cause any difference regarding core-2-core cache transfer.
> Is this correct?
> 
> > > > > I wonder if we should still use PCP a little bit under the above said
> > > > > condition, for the purpose of:
> > > > > 1 reduced overhead in the free path for machines with large cache;
> > > > > 2 still keeps the benefit of reused pages for machines with smaller cache.
> > > > > 
> > > > > For this reason, I tested increasing nr_pcp_high() from returning 0 to
> > > > > either returning pcp->batch or (pcp->batch << 2):
> > > > > machine\nr_pcp_high() ret: pcp->high   0   pcp->batch (pcp->batch << 2)
> > > > > skylake desktop:             72288   90784   92219       91528
> > > > > icelake 2sockets:           120956   99177   98251      116108
> > > > > 
> > > > > note nr_pcp_high() returns pcp->high is the behaviour of this commit's
> > > > > parent, returns 0 is the behaviour of this commit.
> > > > > 
> > > > > The result shows, if we effectively use a PCP high as (pcp->batch << 2)
> > > > > for the described condition, then this workload's performance on
> > > > > small machine can remain while the regression on large machines can be
> > > > > greately reduced(from -18% to -4%).
> > > > > 
> > > > 
> > > > Can we use cache size and topology information directly?
> > > 
> > > It can be complicated by the fact that the system can have multiple
> > > producers(cpus that are doing free) running at the same time and getting
> > > the perfect number can be a difficult job.
> > 
> > We can discuss this after verifying whether it's core-2-core transfering
> > related.
> > 
> > Best Regards,
> > Huang, Ying
> > 
> > 


