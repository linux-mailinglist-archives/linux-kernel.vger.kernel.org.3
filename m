Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E154DAF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiCPL4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCPL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:56:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061E31232
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647431689; x=1678967689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GdaaZKLTj7n24VPFwFWorJmb6xgdussBry3m/9TY2OY=;
  b=Lo7tqUOyqUFI/ZXhKN5wTLAodJlSeFLsMY1miyW7wH4u9/LfOXMthP/g
   TBCdf/ylNtLztuuKH8dPNF6AAjr8ljCADQ+5Y5vFkfIOQxtw0BSw4o0PU
   HW0XKgcrXxLXNSEXbHA4mZQgNMRNtzPN6e0k/O4vH4Ti3lpcOvp2L8kKu
   WN1PRA918OPnefH3p3997tkKwHOZgje4pE04VC2+BffLh6R+4jzK7OFUW
   brPuX1TD22zxCs6ndHPeIvqp/gdpnXxr6P7pn3MDkrrxc7V3GmhXEUNRb
   GNfc1imztiDfCSoAbzllEYS7XIuHO6l9DQ8J8tRfH4rGsodlATTcFKh4E
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255388883"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="255388883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:54:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557402719"
Received: from xkong-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.174.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:54:23 -0700
Date:   Wed, 16 Mar 2022 19:54:18 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
Message-ID: <20220316115418.GA20589@chenyu5-mobl1>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <50315795-c2cf-fc1a-6698-752b0c26cb96@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50315795-c2cf-fc1a-6698-752b0c26cb96@amd.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek, 
On Tue, Mar 15, 2022 at 05:07:35PM +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 3/10/2022 6:22 AM, Chen Yu wrote:
> > [Problem Statement]
> > Currently select_idle_cpu() uses the percpu average idle time to
> > estimate the total LLC domain idle time, and calculate the number
> > of CPUs to be scanned. This might be inconsistent because idle time
> > of a CPU does not necessarily correlate with idle time of a domain.
> > As a result, the load could be underestimated and causes over searching
> > when the system is very busy.
> >
> > The following histogram is the time spent in select_idle_cpu(),
> > when running 224 instance of netperf on a system with 112 CPUs
> > per LLC domain:
> >
> > @usecs:
> > [0]                  533 |                                                    |
> > [1]                 5495 |                                                    |
> > [2, 4)             12008 |                                                    |
> > [4, 8)            239252 |                                                    |
> > [8, 16)          4041924 |@@@@@@@@@@@@@@                                      |
> > [16, 32)        12357398 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         |
> > [32, 64)        14820255 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [64, 128)       13047682 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
> > [128, 256)       8235013 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
> > [256, 512)       4507667 |@@@@@@@@@@@@@@@                                     |
> > [512, 1K)        2600472 |@@@@@@@@@                                           |
> > [1K, 2K)          927912 |@@@                                                 |
> > [2K, 4K)          218720 |                                                    |
> > [4K, 8K)           98161 |                                                    |
> > [8K, 16K)          37722 |                                                    |
> > [16K, 32K)          6715 |                                                    |
> > [32K, 64K)           477 |                                                    |
> > [64K, 128K)            7 |                                                    |
> >
> > netperf latency:
> > =======
> > case            	load    	    Lat_99th	    std%
> > TCP_RR          	thread-224	      257.39	(  0.21)
> > UDP_RR          	thread-224	      242.83	(  6.29)
> >
> > The netperf 99th latency(usec) above is comparable with the time spent in
> > select_idle_cpu(). That is to say, when the system is overloaded, searching
> > for idle CPU could be a bottleneck.
> >
> > [Proposal]
> > The main idea is to replace percpu average idle time with the domain
> > based metric. Choose average CPU utilization(util_avg) as the candidate.
> > In general, the number of CPUs to be scanned should be inversely
> > proportional to the sum of util_avg in this domain. That is, the lower
> > the util_avg is, the more select_idle_cpu() should scan for idle CPU,
> > and vice versa. The benefit of choosing util_avg is that, it is a metric
> > of accumulated historic activity, which seems to be more accurate than
> > instantaneous metrics(such as rq->nr_running).
> >
> > Furthermore, borrow the util_avg from periodic load balance,
> > which could offload the overhead of select_idle_cpu().
> >
> > According to last discussion[1], introduced the linear function
> > for experimental purpose:
> >
> > f(x) = a - bx
> >
> >      llc_size
> > x = \Sum      util_avg[cpu] / llc_cpu_capacity
> >      1
> > f(x) is the number of CPUs to be scanned, x is the sum util_avg.
> > To decide a and b, the following condition should be met:
> >
> > [1] f(0) = llc_size
> > [2] f(x) = 4,  x >= 50%
> >
> > That is to say, when the util_avg is 0, we should search for
> > the whole LLC domain. And if util_avg ratio reaches 50% or higher,
> > it should search at most 4 CPUs.
> >
> > Yes, there would be questions like:
> > Why using this linear function to calculate the number of CPUs to
> > be scanned? Why choosing 50% as the threshold? These questions will
> > be discussed in the [Limitations] section.
> >
> > [Benchmark]
> > netperf, hackbench, schbench, tbench
> > were tested with 25% 50% 75% 100% 125% 150% 175% 200% instance
> > of CPU number (these ratios are not CPU utilization). Each test lasts
> > for 100 seconds, and repeats 3 times. The system would reboot into a
> > fresh environment for each benchmark.
> >
> > The following is the benchmark result comparison between
> > baseline:vanilla and compare:patched kernel. Positive compare%
> > indicates better performance.
> >
> > netperf
> > =======
> > case            	load    	baseline(std%)	compare%( std%)
> > TCP_RR          	28 threads	 1.00 (  0.30)	 -1.26 (  0.32)
> > TCP_RR          	56 threads	 1.00 (  0.35)	 -1.26 (  0.41)
> > TCP_RR          	84 threads	 1.00 (  0.46)	 -0.15 (  0.60)
> > TCP_RR          	112 threads	 1.00 (  0.36)	 +0.44 (  0.41)
> > TCP_RR          	140 threads	 1.00 (  0.23)	 +0.95 (  0.21)
> > TCP_RR          	168 threads	 1.00 (  0.20)	+177.77 (  3.78)
> > TCP_RR          	196 threads	 1.00 (  0.18)	+185.43 ( 10.08)
> > TCP_RR          	224 threads	 1.00 (  0.16)	+187.86 (  7.32)
> > UDP_RR          	28 threads	 1.00 (  0.43)	 -0.93 (  0.27)
> > UDP_RR          	56 threads	 1.00 (  0.17)	 -0.39 ( 10.91)
> > UDP_RR          	84 threads	 1.00 (  6.36)	 +1.03 (  0.92)
> > UDP_RR          	112 threads	 1.00 (  5.55)	 +1.47 ( 17.67)
> > UDP_RR          	140 threads	 1.00 ( 18.17)	 +0.31 ( 15.48)
> > UDP_RR          	168 threads	 1.00 ( 15.00)	+153.87 ( 13.20)
> > UDP_RR          	196 threads	 1.00 ( 16.26)	+169.19 ( 13.78)
> > UDP_RR          	224 threads	 1.00 ( 51.81)	+76.72 ( 10.95)
> >
> > hackbench
> > =========
> > (each group has 1/4 * 112 tasks)
> > case            	load    	baseline(std%)	compare%( std%)
> > process-pipe    	1 group 	 1.00 (  0.47)	 -0.46 (  0.16)
> > process-pipe    	2 groups 	 1.00 (  0.42)	 -0.61 (  0.74)
> > process-pipe    	3 groups 	 1.00 (  0.42)	 +0.38 (  0.20)
> > process-pipe    	4 groups 	 1.00 (  0.15)	 -0.36 (  0.56)
> > process-pipe    	5 groups 	 1.00 (  0.20)	 -5.08 (  0.01)
> > process-pipe    	6 groups 	 1.00 (  0.28)	 -2.98 (  0.29)
> > process-pipe    	7 groups 	 1.00 (  0.08)	 -1.18 (  0.28)
> > process-pipe    	8 groups 	 1.00 (  0.11)	 -0.40 (  0.07)
> > process-sockets 	1 group 	 1.00 (  0.43)	 -1.93 (  0.58)
> > process-sockets 	2 groups 	 1.00 (  0.23)	 -1.10 (  0.49)
> > process-sockets 	3 groups 	 1.00 (  1.10)	 -0.96 (  1.12)
> > process-sockets 	4 groups 	 1.00 (  0.59)	 -0.08 (  0.88)
> > process-sockets 	5 groups 	 1.00 (  0.45)	 +0.31 (  0.34)
> > process-sockets 	6 groups 	 1.00 (  0.23)	 +0.06 (  0.66)
> > process-sockets 	7 groups 	 1.00 (  0.12)	 +1.72 (  0.20)
> > process-sockets 	8 groups 	 1.00 (  0.11)	 +1.98 (  0.02)
> > threads-pipe    	1 group 	 1.00 (  1.07)	 +0.03 (  0.40)
> > threads-pipe    	2 groups 	 1.00 (  1.05)	 +0.19 (  1.27)
> > threads-pipe    	3 groups 	 1.00 (  0.32)	 -0.42 (  0.48)
> > threads-pipe    	4 groups 	 1.00 (  0.42)	 -0.76 (  0.79)
> > threads-pipe    	5 groups 	 1.00 (  0.19)	 -4.97 (  0.07)
> > threads-pipe    	6 groups 	 1.00 (  0.05)	 -4.11 (  0.04)
> > threads-pipe    	7 groups 	 1.00 (  0.10)	 -1.13 (  0.16)
> > threads-pipe    	8 groups 	 1.00 (  0.03)	 -0.08 (  0.05)
> > threads-sockets 	1 group 	 1.00 (  0.33)	 -1.93 (  0.69)
> > threads-sockets 	2 groups 	 1.00 (  0.20)	 -1.55 (  0.30)
> > threads-sockets 	3 groups 	 1.00 (  0.37)	 -1.29 (  0.59)
> > threads-sockets 	4 groups 	 1.00 (  1.83)	 +0.31 (  1.17)
> > threads-sockets 	5 groups 	 1.00 (  0.28)	+15.73 (  0.24)
> > threads-sockets 	6 groups 	 1.00 (  0.15)	 +5.02 (  0.34)
> > threads-sockets 	7 groups 	 1.00 (  0.10)	 +2.29 (  0.14)
> > threads-sockets 	8 groups 	 1.00 (  0.17)	 +2.22 (  0.12)
> >
> > tbench
> > ======
> > case            	load    	baseline(std%)	compare%( std%)
> > loopback        	28 threads	 1.00 (  0.05)	 -1.39 (  0.04)
> > loopback        	56 threads	 1.00 (  0.08)	 -0.37 (  0.04)
> > loopback        	84 threads	 1.00 (  0.03)	 +0.20 (  0.13)
> > loopback        	112 threads	 1.00 (  0.04)	 +0.69 (  0.04)
> > loopback        	140 threads	 1.00 (  0.13)	 +1.15 (  0.21)
> > loopback        	168 threads	 1.00 (  0.03)	 +1.62 (  0.08)
> > loopback        	196 threads	 1.00 (  0.08)	 +1.50 (  0.30)
> > loopback        	224 threads	 1.00 (  0.05)	 +1.62 (  0.05)
> >
> > schbench
> > ========
> > (each mthread group has 1/4 * 112 tasks)
> > case            	load    	baseline(std%)	compare%( std%)
> > normal          	1 mthread group	 1.00 ( 17.92)	+19.23 ( 23.67)
> > normal          	2 mthread groups 1.00 ( 21.10)	 +8.32 ( 16.92)
> > normal          	3 mthread groups 1.00 ( 10.80)	+10.03 (  9.21)
> > normal          	4 mthread groups 1.00 (  2.67)	 +0.11 (  3.00)
> > normal          	5 mthread groups 1.00 (  0.08)	 +0.00 (  0.13)
> > normal          	6 mthread groups 1.00 (  2.99)	 -2.66 (  3.87)
> > normal          	7 mthread groups 1.00 (  2.16)	 -0.83 (  2.24)
> > normal          	8 mthread groups 1.00 (  1.75)	 +0.18 (  3.18)
> Following are the results on benchmarks from Zen3 system (2 x 64C/128T)
> on different NPS modes.
> 
Thanks for the testing.
> NPS Configurations:
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> Benchmark Results:
> 
> Kernel versions:
> - sched-tip:      5.17-rc5 tip sched/core
> - v2_sis_prop:    5.17-rc5 tip sched/core + this patch
> 
Just wonder what the kernel version was when you tested v1?
https://lore.kernel.org/lkml/4ca9ba48-20f0-84d5-6a38-11f9d4c7a028@amd.com/
It seems that there is slight performance difference between the old baseline
and current 5.17-rc5 tip sched/core.
> ~~~~~~~~~
> hackbench
> ~~~~~~~~~
> 
> NPS1
> 
> Test:                   sched-tip              v2_sis_prop
>  1-groups:         5.05 (0.00 pct)         5.00 (0.99 pct)
>  2-groups:         5.72 (0.00 pct)         5.63 (1.57 pct)
>  4-groups:         6.34 (0.00 pct)         6.21 (2.05 pct)
>  8-groups:         7.89 (0.00 pct)         7.80 (1.14 pct)
> 16-groups:        11.80 (0.00 pct)        11.62 (1.52 pct)
> 
> NPS2
> 
> Test:                   sched-tip              v2_sis_prop
>  1-groups:         4.94 (0.00 pct)         4.93 (0.20 pct)
>  2-groups:         5.64 (0.00 pct)         5.55 (1.59 pct)
>  4-groups:         6.23 (0.00 pct)         6.07 (2.56 pct)
>  8-groups:         7.70 (0.00 pct)         7.46 (3.11 pct)
> 16-groups:        10.49 (0.00 pct)        10.12 (3.52 pct)
> 
> NPS4
> 
> Test:                   sched-tip              v2_sis_prop
>  1-groups:         4.89 (0.00 pct)         4.97 (-1.63 pct)
>  2-groups:         5.43 (0.00 pct)         5.48 (-0.92 pct)
>  4-groups:         6.15 (0.00 pct)         6.21 (-0.97 pct)
>  8-groups:         7.54 (0.00 pct)         8.07 (-7.02 pct)
> 16-groups:        10.20 (0.00 pct)        10.13 ( 0.68 pct)
> 
> ~~~~~~~~
> schbench
> ~~~~~~~~
> 
> NPS 1
> 
> #workers:        sched-tip               v2_sis_prop
>   1:      13.00 (0.00 pct)        14.50 (-11.53 pct)
>   2:      31.50 (0.00 pct)        35.00 (-11.11 pct)
It seems that in the old result:
NPS Mode - NPS1
#workers:       sched-tip                util-avg
  1:      13.00 (0.00 pct)        14.50 (-11.53 pct)
  2:      31.50 (0.00 pct)        34.00 (-7.93 pct)
we still saw some downgradings. Although in the v1 patch,
there is no logic change when the utilization is below 85%.
I'm thinking of this might be deviation when the load is low.
For example in v2 test of schbench, 3 cycles of testings were
launched:
case                load            baseline(std%)  compare%( std%)
normal              1 mthread group  1.00 ( 17.92)  +19.23 ( 23.67)
The standard deviation ratio is 23%, which seams to be relatively
large. But consider that v2 patch has changed the logic of how aggressive
we searching for a idle CPU, even in low utilization, this result
needs to be evaluated.
>   4:      43.00 (0.00 pct)        44.50 (-3.48 pct)
>   8:      52.50 (0.00 pct)        52.00 (0.95 pct)
>  16:      69.00 (0.00 pct)        68.00 (1.44 pct)
>  32:     108.50 (0.00 pct)       108.50 (0.00 pct)
>  64:     195.00 (0.00 pct)       192.50 (1.28 pct)
> 128:     395.50 (0.00 pct)       399.00 (-0.88 pct)
> 256:     950.00 (0.00 pct)       944.00 (0.63 pct)
> 512:     60352.00 (0.00 pct)     60608.00 (-0.42 pct)
> 
> NPS2
> 
> #workers:        sched-tip             v2_sis_prop
>   1:      10.00 (0.00 pct)        10.00 (0.00 pct)
>   2:      25.00 (0.00 pct)        28.00 (-12.00 pct)
>   4:      37.00 (0.00 pct)        37.50 (-1.35 pct)
>   8:      50.50 (0.00 pct)        52.50 (-3.96 pct)
>  16:      65.50 (0.00 pct)        67.50 (-3.05 pct)
>  32:     104.00 (0.00 pct)       104.50 (-0.48 pct)
>  64:     190.00 (0.00 pct)       186.50 (1.84 pct)
> 128:     394.50 (0.00 pct)       398.50 (-1.01 pct)
> 256:     959.00 (0.00 pct)       979.00 (-2.08 pct)
> 512:     60352.00 (0.00 pct)     60480.00 (-0.21 pct)
> 
> NPS4
> 
> #workers:        sched-tip              v2_sis_prop
>   1:       9.50 (0.00 pct)        10.00 (-5.26 pct)
>   2:      28.00 (0.00 pct)        30.00 (-7.14 pct)
>   4:      32.00 (0.00 pct)        36.50 (-14.06 pct)
>   8:      42.00 (0.00 pct)        43.00 (-2.38 pct)
>  16:      68.00 (0.00 pct)        75.50 (-11.02 pct)

>  32:     104.50 (0.00 pct)       106.50 (-1.91 pct)
>  64:     186.00 (0.00 pct)       191.50 (-2.95 pct)
> 128:     382.50 (0.00 pct)       392.50 (-2.61 pct)
> 256:     966.00 (0.00 pct)       963.00 (0.31 pct)
> 512:     60480.00 (0.00 pct)     60416.00 (0.10 pct)
> 
> ~~~~~~
> tbench
> ~~~~~~
> 
> NPS 1
> 
> Clients:          sched-tip              v2_sis_prop
>     1    477.85 (0.00 pct)       470.68 (-1.50 pct)
>     2    924.07 (0.00 pct)       910.82 (-1.43 pct)
>     4    1778.95 (0.00 pct)      1743.64 (-1.98 pct)
>     8    3244.81 (0.00 pct)      3200.35 (-1.37 pct)
>    16    5837.06 (0.00 pct)      5808.36 (-0.49 pct)
>    32    9339.33 (0.00 pct)      8648.03 (-7.40 pct)
>    64    14761.19 (0.00 pct)     15803.13 (7.05 pct)
>   128    27806.11 (0.00 pct)     27510.69 (-1.06 pct)
>   256    35262.03 (0.00 pct)     34135.78 (-3.19 pct)
The result from v1 patch:
NPS Mode - NPS1
Clients:        sched-tip               util-avg
256    26726.29 (0.00 pct)     52502.83 (96.44 pct)
>   512    52459.78 (0.00 pct)     51630.53 (-1.58 pct)
>  1024    52480.67 (0.00 pct)     52439.37 (-0.07 pct)
> 
> NPS 2
> 
> Clients:          sched-tip              v2_sis_prop
>     1    478.98 (0.00 pct)       472.98 (-1.25 pct)
>     2    930.52 (0.00 pct)       914.48 (-1.72 pct)
>     4    1743.26 (0.00 pct)      1711.16 (-1.84 pct)
>     8    3297.07 (0.00 pct)      3161.12 (-4.12 pct)
>    16    5779.10 (0.00 pct)      5738.38 (-0.70 pct)
>    32    10708.42 (0.00 pct)     10748.26 (0.37 pct)
>    64    16965.21 (0.00 pct)     16894.42 (-0.41 pct)
>   128    29152.49 (0.00 pct)     28287.31 (-2.96 pct)
>   256    27408.75 (0.00 pct)     33680.59 (22.88 pct)
The result from v1 patch:
256    27654.49 (0.00 pct)     47126.18 (70.41 pct)
>   512    51453.64 (0.00 pct)     47546.87 (-7.59 pct)
>  1024    52156.85 (0.00 pct)     51233.28 (-1.77 pct)
> 
> NPS 4
> 
> Clients:          sched-tip              v2_sis_prop
>     1    480.29 (0.00 pct)       473.75 (-1.36 pct)
>     2    940.23 (0.00 pct)       915.60 (-2.61 pct)
>     4    1760.21 (0.00 pct)      1687.99 (-4.10 pct)
>     8    3269.75 (0.00 pct)      3154.02 (-3.53 pct)
>    16    5503.71 (0.00 pct)      5485.01 (-0.33 pct)
>    32    10633.93 (0.00 pct)     10276.21 (-3.36 pct)
>    64    16304.44 (0.00 pct)     15351.17 (-5.84 pct)
>   128    26893.95 (0.00 pct)     25337.08 (-5.78 pct)
>   256    24469.94 (0.00 pct)     32178.33 (31.50 pct)
The result from v1 patch:
256    25997.38 (0.00 pct)     47735.83 (83.61 pct)

In above three cases, v2 has smaller improvement compared to
v1. In both v1 and v2, the improvement mainly comes from choosing
previous running CPU as the target, when the system is busy. But
v2 is more likely to choose a previous CPU than v1, because its
threshold 50% is lower than 85% from v2. Then why v2 has less improvement
than v1? It seems that v2 patch only changes the logic of SIS_PRO for
single idle CPU searching, but not touches the idle Core searching.
Meanwhile v1 limits both idle CPU and idle Core searching, and this
might explain the extra benefit from v1 patch IMO.
>   512    46343.65 (0.00 pct)     49607.28 (7.04 pct)
>  1024    51496.80 (0.00 pct)     51791.27 (0.57 pct)
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Stream with 16 threads.
> built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> NPS1
> 
> Test:               sched-tip             v2_sis_prop
>  Copy:   204020.95 (0.00 pct)    211802.20 (3.81 pct)
> Scale:   208261.03 (0.00 pct)    210809.40 (1.22 pct)
>   Add:   243944.45 (0.00 pct)    249801.81 (2.40 pct)
> Triad:   237033.90 (0.00 pct)    242273.45 (2.21 pct)
> 
> NPS2
> 
> Test:               sched-tip              v2_sis_prop
>  Copy:   171679.21 (0.00 pct)    153853.24 (-10.38 pct)
> Scale:   191362.43 (0.00 pct)    188219.32 (-1.64 pct)
>   Add:   218986.47 (0.00 pct)    204766.66 (-6.49 pct)
> Triad:   215118.01 (0.00 pct)    202370.69 (-5.92 pct)
> 
> NPS4
> 
> Test:               sched-tip              v2_sis_prop
>  Copy:   133829.00 (0.00 pct)    125722.97 (-6.05 pct)
> Scale:   192074.89 (0.00 pct)    187164.95 (-2.55 pct)
>   Add:   186288.73 (0.00 pct)    175316.23 (-5.89 pct)
> Triad:   185469.53 (0.00 pct)    175985.74 (-5.11 pct)
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Stream with 16 threads.
> built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=100
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> NPS1
> 
> Test:               sched-tip             v2_sis_prop
>  Copy:   217592.30 (0.00 pct)    231684.51 (6.47 pct)
> Scale:   217269.78 (0.00 pct)    218632.93 (0.62 pct)
>   Add:   265842.95 (0.00 pct)    266692.50 (0.31 pct)
> Triad:   252647.10 (0.00 pct)    253462.69 (0.32 pct)
> 
> NPS2
> 
> Test:               sched-tip             v2_sis_prop
>  Copy:   226948.55 (0.00 pct)    242576.78 (6.88 pct)
> Scale:   217968.87 (0.00 pct)    220613.96 (1.21 pct)
>   Add:   274839.22 (0.00 pct)    277389.36 (0.92 pct)
> Triad:   261920.73 (0.00 pct)    263849.95 (0.73 pct)
> 
> NPS4
> 
> Test:               sched-tip              v2_sis_prop
>  Copy:   256162.84 (0.00 pct)    238881.35 (-6.74 pct)
> Scale:   228251.12 (0.00 pct)    228669.16 (0.18 pct)
>   Add:   292794.77 (0.00 pct)    293700.42 (0.30 pct)
> Triad:   274152.69 (0.00 pct)    274900.77 (0.27 pct)
> 
> ~~~~~~~~~~~~
> ycsb-mongodb
> ~~~~~~~~~~~~
> 
> NPS1
> 
> sched-tip:      304934.67 (var: 0.88)
> v2_sis_prop:    301560.0  (var: 2.0)    (-1.1%)
> 
> NPS2
> 
> sched-tip:      303757.0 (var: 1.0)
> v2_sis_prop:    302283.0 (var: 0.58)    (-0.48%)
> 
> NPS4
> 
> sched-tip:      308106.67 (var: 2.88)
> v2_sis_prop:    302302.67 (var: 1.12)   (-1.88%)
>
May I know the average CPU utilization of this benchmark?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> schbench, tbench - System 50% loaded to fully loaded
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ~~~~~~~~
> schbench
> ~~~~~~~~
> 
> NPS1
> 
> #workers:        sched-tip              v2_sis_prop
> 128:     395.50 (0.00 pct)       399.00 (-0.88 pct)
> 144:     441.50 (0.00 pct)       450.00 (-1.92 pct)
> 160:     488.00 (0.00 pct)       513.00 (-5.12 pct)
> 176:     549.00 (0.00 pct)       547.00 (0.36 pct)
> 192:     601.00 (0.00 pct)       589.00 (1.99 pct)
> 208:     653.00 (0.00 pct)       736.00 (-12.71 pct)
> 224:     740.00 (0.00 pct)       757.00 (-2.29 pct)
> 240:     835.00 (0.00 pct)       808.00 (3.23 pct)
> 256:     950.00 (0.00 pct)       944.00 (0.63 pct)
> 
> NPS2:
> #workers:        sched-tip              v2_sis_prop
> 128:     394.50 (0.00 pct)       398.50 (-1.01 pct)
> 144:     454.50 (0.00 pct)       443.50 (2.42 pct)
> 160:     500.00 (0.00 pct)       494.00 (1.20 pct)
> 176:     547.00 (0.00 pct)       530.00 (3.10 pct)
> 192:     595.00 (0.00 pct)       609.00 (-2.35 pct)
> 208:     739.00 (0.00 pct)       738.00 (0.13 pct)
> 224:     781.00 (0.00 pct)       794.00 (-1.66 pct)
> 240:     894.00 (0.00 pct)       890.00 (0.44 pct)
> 256:     959.00 (0.00 pct)       979.00 (-2.08 pct)
> 
> NPS4
> 
> #workers:        sched-tip              v2_sis_prop
> 128:     382.50 (0.00 pct)       392.50 (-2.61 pct)
> 144:     451.50 (0.00 pct)       459.00 (-1.66 pct)
> 160:     491.00 (0.00 pct)       497.00 (-1.22 pct)
> 176:     578.00 (0.00 pct)       564.00 (2.42 pct)
> 192:     593.00 (0.00 pct)       612.00 (-3.20 pct)
> 208:     737.00 (0.00 pct)       720.00 (2.30 pct)
> 224:     786.00 (0.00 pct)       796.00 (-1.27 pct)
> 240:     893.00 (0.00 pct)       890.00 (0.33 pct)
> 256:     966.00 (0.00 pct)       963.00 (0.31 pct)
> 
> ~~~~~~
> tbench
> ~~~~~~
> 
> NPS1
> 
> Clients:         sched-tip              v2_sis_prop
> 128    28369.07 (0.00 pct)     25649.26 (-9.58 pct)
> 144    25794.95 (0.00 pct)     25464.33 (-1.28 pct)
> 160    23905.48 (0.00 pct)     23507.18 (-1.66 pct)
> 176    24219.13 (0.00 pct)     22664.99 (-6.41 pct)
> 192    23978.71 (0.00 pct)     22506.50 (-6.13 pct)
> 208    24045.91 (0.00 pct)     22592.62 (-6.04 pct)
> 224    21961.21 (0.00 pct)     22154.28 (0.87 pct)
> 240    22001.05 (0.00 pct)     26245.06 (19.29 pct)
> 256    26866.60 (0.00 pct)     33064.10 (23.06 pct)
> 
> NPS2
> 
> Clients:         sched-tip              v2_sis_prop
> 128    25229.75 (0.00 pct)     26396.32 (4.62 pct)
> 144    27488.16 (0.00 pct)     24596.76 (-10.51 pct)
> 160    23765.03 (0.00 pct)     23945.55 (0.75 pct)
> 176    22230.05 (0.00 pct)     22207.84 (-0.09 pct)
> 192    21383.39 (0.00 pct)     22385.72 (4.68 pct)
> 208    23920.96 (0.00 pct)     22323.24 (-6.67 pct)
> 224    22212.38 (0.00 pct)     24108.90 (8.53 pct)
> 240    22143.36 (0.00 pct)     25655.54 (15.86 pct)
> 256    29923.16 (0.00 pct)     32570.60 (8.84 pct)
> 
> NPS4
> 
> Clients:         sched-tip              v2_sis_prop
> 128    26336.35 (0.00 pct)     24604.90 (-6.57 pct)
> 144    24469.64 (0.00 pct)     24685.57 (0.88 pct)
> 160    23742.98 (0.00 pct)     23381.86 (-1.52 pct)
> 176    22512.46 (0.00 pct)     22602.49 (0.39 pct)
> 192    21141.71 (0.00 pct)     22752.25 (7.61 pct)
> 208    21803.07 (0.00 pct)     22280.24 (2.18 pct)
> 224    21174.10 (0.00 pct)     23582.49 (11.37 pct)
> 240    21510.36 (0.00 pct)     26295.92 (22.24 pct)
> 256    25170.50 (0.00 pct)     34215.08 (35.93 pct)
> 
> Hackbench shows improvements in NPS1 and NPS2 modes. tbench sees good
> improvement when system is close to fully loaded. Stream values are very
> close to the baseline. YCSB MongoDB shows slight regression and schbench
> is a mixed bag.
> 
> This strategy would probably work better on systems with large number of
> CPUs per LLC but from our observations, I believe it is worthwhile to
> search for an idle CPUs in the entire LLC on Zen3 systems as we have
> 16 CPUs per LLC.
> Only when the system is close to fully loaded, we see a good uplift by not
> searching the entire LLC in tbench which is what we saw with the v1 too.
I see. But we might have to make this per-LLC search generic, both for smaller
size and bigger size. Current using exponential descent function could increase the
number of CPUs to be searched when the system is not busy. I'll think about it
and do some investigation.

thanks,
Chenyu
> --
> Thanks and Regards,
> Prateek
