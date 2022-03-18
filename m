Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA84DD3AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiCRDpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiCRDpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:45:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8A193B4A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647575027; x=1679111027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9mHT8QQX4E3T1/DqYIJ3c6NI74lF2zRKrQ5p8f6lrkQ=;
  b=HO4fE0mKd2cl61SvFv5b0gPvacosERT1fqhXnKkYrI2EKUyqdpY14pIV
   JOQrBCPNFq7JseSgUSAY1IhSt4OM5YKMOKUWCeRgORrnXD0iYsdEAKi5B
   dBQWJLIFzDmQGN+LQKf1FtdjJRhfgR42dzINdRp7zeJYWB/fvnFbJEaLE
   +fRdF/cIhX6g/pOb1CxtuqjFEP/CkpJaNeQ0Bde3XPRwZLQnDqK47OQzl
   iEWYXof4uV+OvlXmQ5dFIB/uQVek65n1JXYIa+XtIQ9U3YStLESa68CjJ
   nciRbt5apstBWlBylsfGnVmf0jHX5c5pyOQ+zRc2l/UiZN5yiiQ8md4G8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254594951"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="254594951"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 20:43:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="541649640"
Received: from zihengcx-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.175.30])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 20:43:39 -0700
Date:   Fri, 18 Mar 2022 11:43:35 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyccccc@gmail.com>
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
        Aubrey Li <aubrey.li@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
Message-ID: <20220318034335.GA12577@chenyu5-mobl1>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <a1d9fa78-4d27-78c6-d462-d9b1f8cd39e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1d9fa78-4d27-78c6-d462-d9b1f8cd39e3@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,
On Fri, Mar 18, 2022 at 01:39:48AM +0800, Yicong Yang wrote:
> Hi Chen,
> 
> Thanks for the update. I'm still testing on this along with the sched cluster patches.
> I'll show some results when I get enough data. So some questions below.
> 
> 在 2022/3/10 8:52, Chen Yu 写道:
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
> 
> I might have a question here. In your V1 patch, we won't scan when the LLC
> util >85%. But in this patch we'll always scan 4 cpus no matter how much the
> LLC is overloaded. When the LLC is rather busy the scan is probably redundant
> so is it better if we found a threadhold for stopping the scan? The util_avg
> cannot indicate how much the cpu is overloaded so perhaps just stop scan when
> it is 100% utilized.
>
The reason we makes the scan number >=4 is that:
1. In the tbench test result based on v1 in your environment, there seems to be
   a -8.49% downgrading with 128 threads. It is possible that, when there is
   128 thread in your system, it is not fully busy, but we give up searching for
   an idle CPU, which causes downgrading. Tim suggested that we can still search
   for a minimal number of CPU even the system is very busy.
2. This is consistent with the current kernel's logic, 4 is the minal search number
   no matter how busy the system is.
https://lore.kernel.org/lkml/2627025ab96a315af0e76e5983c803578623c826.camel@linux.intel.com/

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
> >
> > According to the results above, when the workloads is heavy, the throughput
> > of netperf improves a lot. It might be interesting to look into the reason
> > why this patch benefits netperf significantly. Further investigation has
> > shown that, this might be a 'side effect' of this patch. It is found that,
> > the CPU utilization is around 90% on vanilla kernel, while it is nearly
> > 100% on patched kernel. According to the perf profile, with the patch
> > applied, the scheduler would likely to choose previous running CPU for the
> > waking task, thus reduces runqueue lock contention, so the CPU utilization
> > is higher and get better performance.
> >
> > [Limitations]
> > Q:Why using 50% as the util_avg/capacity threshold to search at most 4 CPUs?
> >
> > A: 50% is chosen as that corresponds to almost full CPU utilization, when
> >    the CPU is fixed to run at its base frequency, with turbo enabled.
> >    4 is the minimal number of CPUs to be scanned in current select_idle_cpu().
> >
> >    A synthetic workload was used to simulate different level of
> >    load. This workload takes every 10ms as the sample period, and in
> >    each sample period:
> >
> >    while (!timeout_10ms) {
> >         loop(busy_pct_ms);
> >    	sleep(10ms-busy_pct_ms)
> >    }
> >
> >    to simulate busy_pct% of CPU utilization. When the workload is
> >    running, the percpu runqueue util_avg was monitored. The
> >    following is the result from turbostat's Busy% on CPU2 and
> >    cfs_rq[2].util_avg from /sys/kernel/debug/sched/debug:
> >
> >    Busy%    util_avg   util_avg/cpu_capacity%
> >    10.06    35         3.42
> >    19.97    99         9.67
> >    29.93    154        15.04
> >    39.86    213        20.80
> >    49.79    256        25.00
> >    59.73    325        31.74
> >    69.77    437        42.68
> >    79.69    458        44.73
> >    89.62    519        50.68
> >    99.54    598        58.39
> >
> >    The reason why util_avg ratio is not consistent with Busy% might be due
> >    to CPU frequency invariance. The CPU is running at fixed lower frequency
> >    than the turbo frequency, then the util_avg scales lower than
> >    SCHED_CAPACITY_SCALE. In our test platform, the base frequency is 1.9GHz,
> >    and the max turbo frequency is 3.7GHz, so 1.9/3.7 is around 50%.
> >    In the future maybe we could use arch_scale_freq_capacity()
> >    instead of sds->total_capacity, so as to remove the impact from frequency.
> >    Then the 50% could be adjusted higher. For now, 50% is an aggressive
> >    threshold to restric the idle CPU searching and shows benchmark
> >    improvement.
> >
> > Q: Why using nr_scan = a - b * sum_util_avg to do linear search?
> >
> > A: Ideally the nr_scan could be:
> >
> >    nr_scan = sum_util_avg / pelt_avg_scan_cost
> >
> >    However consider the overhead of calculating pelt on avg_scan_cost
> >    in each wake up, choosing heuristic search for evaluation seems to
> >    be an acceptable trade-off.
> >
> >    The f(sum_util_avg) could be of any form, as long as it is a monotonically
> >    decreasing function. At first f(x) = a - 2^(bx) was chosen. Because when the
> >    sum_util_avg is low, the system should try very hard to find an idle CPU. And
> >    if sum_util_avg goes higher, the system dramatically lose its interest to search
> >    for the idle CPU. But exponential function does have its drawback:
> >
> >    Consider a system with 112 CPUs, let f(x) =  112 when x = 0,
> >    f(x) = 4 when x = 50, x belongs to [0, 100], then we have:
> >
> >    f1(x) = 113 - 2^(x / 7.35)
> >    and
> >    f2(x) = 112 - 2.16 * x
> >
> >    Since kernel does not support floating point, above functions are converted into:
> >    nr_scan1(x) = 113 - 2^(x / 7)
> >    and
> >    nr_scan2(x) = 112 - 2 * x
> >
> >    util_avg%      0     1     2  ...   8     9   ... 47   48   49
> >    nr_scan1     112   112   112      111   111       49   49    4
> >    nr_scan2     112   110   108       96    94       18   16   14
> >
> >    According to above result, the granularity of exponential function
> >    is coarse-grained, while the linear function is fine-grained.
> >
> >    So finally choose linear function. After all, it has shown benchmark
> >    benefit without noticeable regression so far.
> >
> > Q: How to deal with the following corner case:
> >
> >    It is possible that there is unbalanced tasks among CPUs due to CPU affinity.
> >    For example, suppose the LLC domain is composed of 6 CPUs, and 5 tasks are bound
> >    to CPU0~CPU4, while CPU5 is idle:
> >
> > 		CPU0	CPU1	CPU2	CPU3	CPU4	CPU5
> >    util_avg	1024	1024	1024	1024	1024	0
> >
> >    Since the util_avg ratio is 83%( = 5/6 ), which is higher than 50%, select_idle_cpu()
> >    only searches 4 CPUs starting from CPU0, thus leaves idle CPU5 undetected.
> >
> >    A possible workaround to mitigate this problem is that, the nr_scan should
> >    be increased by the number of idle CPUs found during periodic load balance
> >    in update_sd_lb_stats(). In above example, the nr_scan will be adjusted to
> >    4 + 1 = 5. Currently I don't have better solution in mind to deal with it
> >    gracefully.
> 
> Without CPU affinity, is it possible that we also meet this case?
Yes, it is true.
> Considering we always scan from the target cpu and the further cpus have less
> chance to be checked, the scan possibility of each CPUs is not equal. When the
> util_avg ratio >50%, after several wakeups from CPU0 the CPU 1~4 will be non-idle
> andthe following scans may fail without checking CPU5.
In this case, we relies on the load balance path to migrate some tasks among
CPUs and 'saturate'this LLC domain equally.
 
> >
> > -		 * If we're busy, the assumption that the last idle period
> > -		 * predicts the future is flawed; age away the remaining
> > -		 * predicted idle time.
> > -		 */
> > -		if (unlikely(this_rq->wake_stamp < now)) {
> > -			while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
> > -				this_rq->wake_stamp++;
> > -				this_rq->wake_avg_idle >>= 1;
> > -			}
> > -		}
> > -
> > -		avg_idle = this_rq->wake_avg_idle;
> > -		avg_cost = this_sd->avg_scan_cost + 1;
> > -
> 
> With this patch, sd->avg_scan_cost, rq->{wake_stamp, wake_avg_idle} may have no users.
> 
If we 'rebase' the SIS_PRO to use sum_util_avg, it seems that avg_scan_cost and
rq->{wake_stamp, wake_avg_idle} are not needed IMO.
For rq->{wake_stamp, wake_avg_idle}, it is used to reduce the search number when waking
up a task on a busy rq. However this metric still uses one CPU's statistic to predict
the whole system's status, which is trying to be avoid in this patch.

For sd->avg_scan_cost, unless we use sum_util_avg / pelt(sd->avg_scan_cost), it
could be leveraged to predict the number of CPUs to scan. I'm not sure how much
the overhead is when calculating pelt on sd->avg_scan_cost each time during wakeup,
but I can have a try to get some data.

thanks,
Chenyu
> Thanks,
> Yicong
> 
> > -		span_avg = sd->span_weight * avg_idle;
> > -		if (span_avg > 4*avg_cost)
> > -			nr = div_u64(span_avg, avg_cost);
> > -		else
> > -			nr = 4;
> > -
> > -		time = cpu_clock(this);
> > +		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> > +		if (sd_share)
> > +			nr = READ_ONCE(sd_share->nr_idle_scan);
> >  	}
> >  
> >  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> > @@ -6328,18 +6299,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  	if (has_idle_core)
> >  		set_idle_cores(target, false);
> >  
> > -	if (sched_feat(SIS_PROP) && !has_idle_core) {
> > -		time = cpu_clock(this) - time;
> > -
> > -		/*
> > -		 * Account for the scan cost of wakeups against the average
> > -		 * idle time.
> > -		 */
> > -		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> > -
> > -		update_avg(&this_sd->avg_scan_cost, time);
> > -	}
> > -
> >  	return idle_cpu;
> >  }
> >  
> > @@ -9199,6 +9158,60 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >  	return idlest;
> >  }
> >  
> > +static inline void update_nr_idle_scan(struct lb_env *env, struct sd_lb_stats *sds,
> > +				       unsigned long sum_util)
> > +{
> > +	struct sched_domain_shared *sd_share;
> > +	int llc_size = per_cpu(sd_llc_size, env->dst_cpu);
> > +	int nr_scan;
> > +
> > +	/*
> > +	 * Update the number of CPUs to scan in LLC domain, which could
> > +	 * be used as a hint in select_idle_cpu(). The update of this hint
> > +	 * occurs during periodic load balancing, rather than frequent
> > +	 * newidle balance.
> > +	 */
> > +	if (env->idle == CPU_NEWLY_IDLE || env->sd->span_weight != llc_size)
> > +		return;
> > +
> > +	sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
> > +	if (!sd_share)
> > +		return;
> > +
> > +	/*
> > +	 * In general, the number of cpus to be scanned should be
> > +	 * inversely proportional to the sum_util. That is, the lower
> > +	 * the sum_util is, the harder select_idle_cpu() should scan
> > +	 * for idle CPU, and vice versa. Let x be the sum_util ratio
> > +	 * [0-100] of the LLC domain, f(x) be the number of CPUs scanned:
> > +	 *
> > +	 * f(x) = a - bx                                              [1]
> > +	 *
> > +	 * Consider that f(x) = nr_llc when x = 0, and f(x) = 4 when
> > +	 * x >= threshold('h' below) then:
> > +	 *
> > +	 * a = llc_size;
> > +	 * b = (nr_llc - 4) / h                                       [2]
> > +	 *
> > +	 * then [2] becomes:
> > +	 *
> > +	 * f(x) = llc_size - (llc_size -4)x/h                         [3]
> > +	 *
> > +	 * Choose 50 (50%) for h as the threshold from experiment result.
> > +	 * And since x = 100 * sum_util / total_cap, [3] becomes:
> > +	 *
> > +	 * f(sum_util)
> > +	 *  = llc_size - (llc_size - 4) * 100 * sum_util / total_cap * 50
> > +	 *  = llc_size - (llc_size - 4) * 2 * sum_util / total_cap
> > +	 *
> > +	 */
> > +	nr_scan = llc_size - (llc_size - 4) * 2 * sum_util / sds->total_capacity;
> > +	if (nr_scan < 4)
> > +		nr_scan = 4;
> > +
> > +	WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> > +}
> > +
> >  /**
> >   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
> >   * @env: The load balancing environment.
> > @@ -9212,6 +9225,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  	struct sg_lb_stats *local = &sds->local_stat;
> >  	struct sg_lb_stats tmp_sgs;
> >  	int sg_status = 0;
> > +	unsigned long sum_util = 0;
> >  
> >  	do {
> >  		struct sg_lb_stats *sgs = &tmp_sgs;
> > @@ -9242,6 +9256,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  		/* Now, start updating sd_lb_stats */
> >  		sds->total_load += sgs->group_load;
> >  		sds->total_capacity += sgs->group_capacity;
> > +		sum_util += sgs->group_util;
> >  
> >  		sg = sg->next;
> >  	} while (sg != env->sd->groups);
> > @@ -9268,6 +9283,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> >  		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> >  	}
> > +
> > +	update_nr_idle_scan(env, sds, sum_util);
> >  }
> >  
> >  #define NUMA_IMBALANCE_MIN 2
