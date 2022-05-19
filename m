Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACB052CD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiESHyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiESHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:54:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396833E10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652946886; x=1684482886;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X5AZ2Cu9HPiYws+OpC3w+EEcJ2w0V8jecNLljKiFMsQ=;
  b=Uw16MFtwrYwti+ICc3M2rTqL2ZamLv3N8Y8En0FB83X6ehu7waGuk52v
   A+28+iaCqrxFC6msh8cwQcjPzoNBAa+f8KzfEd3TjmJO+VPHNwnIZMwYz
   Of+qhqZLvpAEpUDTWJSyN8bkb84xma7Hu+SicaSnDGdFHHua3G5DSlyXP
   PeWGuGP2zAsDzeFSMp8ZZE1lUITj09wLNRZja7lSHRWAC4TxFVZMYYD5J
   Kpe9KwhYhvwRRt/vh0GIWK+pOLXlu52scpybhvv/LGojd2AlDpc0OjJjz
   6/1RCYnVfW11Q/seFwnB+tgd9ILzx0afzvHLUk/FZ369ToBgC6F+UQp4t
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="252597816"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="252597816"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:54:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598413751"
Received: from xiaominc-mobl1.ccr.corp.intel.com ([10.254.213.242])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:54:42 -0700
Message-ID: <5941ce856343c314f829852d3a831cdd19f06573.camel@intel.com>
Subject: Re: [sched/numa]  bb2dee337b:  unixbench.score -11.2% regression
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>, yu.c.chen@intel.com
Date:   Thu, 19 May 2022 15:54:39 +0800
In-Reply-To: <20220518152258.GR3441@techsingularity.net>
References: <20220511143038.4620-4-mgorman@techsingularity.net>
         <20220518092414.GA15472@xsang-OptiPlex-9020>
         <20220518152258.GR3441@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

On Wed, 2022-05-18 at 16:22 +0100, Mel Gorman wrote:
> On Wed, May 18, 2022 at 05:24:14PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -11.2% regression of unixbench.score due to commit:
> > 
> > 
> > commit: bb2dee337bd7d314eb7c7627e1afd754f86566bc ("[PATCH 3/4] sched/numa: Apply imbalance limitations consistently")
> > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Mitigate-inconsistent-NUMA-imbalance-behaviour/20220511-223233
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git d70522fc541224b8351ac26f4765f2c6268f8d72
> > patch link: https://lore.kernel.org/lkml/20220511143038.4620-4-mgorman@techsingularity.net
> > 
> > in testcase: unixbench
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	nr_task: 1
> > 	test: shell8
> > 	cpufreq_governor: performance
> > 	ucode: 0xd000331
> > 
> > test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > test-url: https://github.com/kdlucas/byte-unixbench
> 
> I think what is happening for unixbench is that it prefers to run all
> instances on a local node if possible. shell8 is creating 8 scripts,
> each of which spawn more processes. The total number of tasks may exceed
> the allowed imbalance at fork time of 16 tasks. Some spill over to a
> remote node and as they are using files, some accesses are remote and it
> suffers. It's not memory bandwidth bound but is sensitive to locality.
> The stats somewhat support this idea
> 
> >      83590 ± 13%     -73.7%      21988 ± 32%  numa-meminfo.node0.AnonHugePages
> >     225657 ± 18%     -58.0%      94847 ± 18%  numa-meminfo.node0.AnonPages
> >     231652 ± 17%     -55.3%     103657 ± 16%  numa-meminfo.node0.AnonPages.max
> >     234525 ± 17%     -55.5%     104341 ± 18%  numa-meminfo.node0.Inactive
> >     234397 ± 17%     -55.5%     104267 ± 18%  numa-meminfo.node0.Inactive(anon)
> >      11724 ±  7%     +17.5%      13781 ±  5%  numa-meminfo.node0.KernelStack
> >       4472 ± 34%    +117.1%       9708 ± 31%  numa-meminfo.node0.PageTables
> >      15239 ± 75%    +401.2%      76387 ± 10%  numa-meminfo.node1.AnonHugePages
> >      67256 ± 63%    +206.3%     205994 ±  6%  numa-meminfo.node1.AnonPages
> >      73568 ± 58%    +193.1%     215644 ±  6%  numa-meminfo.node1.AnonPages.max
> >      75737 ± 53%    +183.9%     215053 ±  6%  numa-meminfo.node1.Inactive
> >      75709 ± 53%    +183.9%     214971 ±  6%  numa-meminfo.node1.Inactive(anon)
> >       3559 ± 42%    +187.1%      10216 ±  8%  numa-meminfo.node1.PageTables
> 
> There is less memory used on one node and more on the other so it's
> getting split.

This makes sense.  I will also check CPU utilization per node to verify
this directly.

> 
> > In addition to that, the commit also has significant impact on the following tests:
> > 
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | fsmark: fsmark.files_per_sec -21.5% regression                                      |
> > > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > > test parameters  | cpufreq_governor=performance                                                        |
> > >                  | disk=1SSD                                                                           |
> > >                  | filesize=8K                                                                         |
> > >                  | fs=f2fs                                                                             |
> > >                  | iterations=8                                                                        |
> > >                  | nr_directories=16d                                                                  |
> > >                  | nr_files_per_directory=256fpd                                                       |
> > >                  | nr_threads=4                                                                        |
> > >                  | sync_method=fsyncBeforeClose                                                        |
> > >                  | test_size=72G                                                                       |
> > >                  | ucode=0x500320a                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > 
> 
> It's less clearcut for this from the stats but it's likely getting split
> too and had preferred locality. It's curious that f2fs is affected but
> maybe other filesystems were too.
> 
> In both cases, the workloads are not memory bandwidth limited so prefer to
> stack on one node and previously, because they were cache hot, the load
> balancer would avoid splitting them apart if there were other candidates
> available.
> 
> This is a tradeoff between loads that want to stick on one node for
> locality because they are not bandwidth limited and workloads that are
> memory bandwidth limited and want to spread wide. We can't tell what
> type of workload it is at fork time.
> 
> Given there is no crystal ball and it's a tradeoff, I think it's better
> to be consistent and use similar logic at both fork time and runtime even
> if it doesn't have universal benefit.
> 

Thanks for detailed explanation.  So some other workloads may benefit
from this patch.  Can you give me some candidate so I can test them too?

Best Regards,
Huang, Ying


