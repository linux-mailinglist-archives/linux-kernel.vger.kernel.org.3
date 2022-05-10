Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4248E5215B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiEJMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbiEJMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:46:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680EA1209B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:42:00 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyHfQ2bs2zGpjS;
        Tue, 10 May 2022 20:39:10 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 20:41:57 +0800
CC:     Chen Yu <yu.chen.surf@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Yicong Yang <yangyicong@hisilicon.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Tim Chen <tim.c.chen@intel.com>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <962e16d1-dd73-418c-9635-009db110823d@huawei.com>
Date:   Tue, 10 May 2022 20:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220428182442.659294-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/29 2:24, Chen Yu wrote:
> [Problem Statement]
> select_idle_cpu() might spend too much time searching for an idle CPU,
> when the system is overloaded.
> 
> The following histogram is the time spent in select_idle_cpu(),
> when running 224 instances of netperf on a system with 112 CPUs
> per LLC domain:
> 
> @usecs:
> [0]                  533 |                                                    |
> [1]                 5495 |                                                    |
> [2, 4)             12008 |                                                    |
> [4, 8)            239252 |                                                    |
> [8, 16)          4041924 |@@@@@@@@@@@@@@                                      |
> [16, 32)        12357398 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         |
> [32, 64)        14820255 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [64, 128)       13047682 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
> [128, 256)       8235013 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
> [256, 512)       4507667 |@@@@@@@@@@@@@@@                                     |
> [512, 1K)        2600472 |@@@@@@@@@                                           |
> [1K, 2K)          927912 |@@@                                                 |
> [2K, 4K)          218720 |                                                    |
> [4K, 8K)           98161 |                                                    |
> [8K, 16K)          37722 |                                                    |
> [16K, 32K)          6715 |                                                    |
> [32K, 64K)           477 |                                                    |
> [64K, 128K)            7 |                                                    |
> 
> netperf latency usecs:
> =======
> case            	load    	    Lat_99th	    std%
> TCP_RR          	thread-224	      257.39	(  0.21)
> 
> The time spent in select_idle_cpu() is visible to netperf and might have a negative
> impact.
> 
> [Symptom analysis]
> The patch [1] from Mel Gorman has been applied to track the efficiency
> of select_idle_sibling. Copy the indicators here:
> 
> SIS Search Efficiency(se_eff%):
>         A ratio expressed as a percentage of runqueues scanned versus
>         idle CPUs found. A 100% efficiency indicates that the target,
>         prev or recent CPU of a task was idle at wakeup. The lower the
>         efficiency, the more runqueues were scanned before an idle CPU
>         was found.
> 
> SIS Domain Search Efficiency(dom_eff%):
>         Similar, except only for the slower SIS
> 	patch.
> 
> SIS Fast Success Rate(fast_rate%):
>         Percentage of SIS that used target, prev or
> 	recent CPUs.
> 
> SIS Success rate(success_rate%):
>         Percentage of scans that found an idle CPU.
> 
> The test is based on Aubrey's schedtests tool, netperf, hackbench,
> schbench and tbench were launched with 25% 50% 75% 100% 125% 150%
> 175% 200% of CPU number respectively. Each test lasts for 100 seconds
> and repeats 3 times. The system reboots into a fresh environment for
> each test.
> 
> Test on vanilla kernel:
> schedstat_parse.py -f netperf_vanilla.log
> case	        load	    se_eff%	    dom_eff%	  fast_rate%	success_rate%
> TCP_RR	   28 threads	     99.978	      18.535	      99.995	     100.000
> TCP_RR	   56 threads	     99.397	       5.671	      99.964	     100.000
> TCP_RR	   84 threads	     21.721	       6.818	      73.632	     100.000
> TCP_RR	  112 threads	     12.500	       5.533	      59.000	     100.000
> TCP_RR	  140 threads	      8.524	       4.535	      49.020	     100.000
> TCP_RR	  168 threads	      6.438	       3.945	      40.309	      99.999
> TCP_RR	  196 threads	      5.397	       3.718	      32.320	      99.982
> TCP_RR	  224 threads	      4.874	       3.661	      25.775	      99.767
> UDP_RR	   28 threads	     99.988	      17.704	      99.997	     100.000
> UDP_RR	   56 threads	     99.528	       5.977	      99.970	     100.000
> UDP_RR	   84 threads	     24.219	       6.992	      76.479	     100.000
> UDP_RR	  112 threads	     13.907	       5.706	      62.538	     100.000
> UDP_RR	  140 threads	      9.408	       4.699	      52.519	     100.000
> UDP_RR	  168 threads	      7.095	       4.077	      44.352	     100.000
> UDP_RR	  196 threads	      5.757	       3.775	      35.764	      99.991
> UDP_RR	  224 threads	      5.124	       3.704	      28.748	      99.860
> 
> schedstat_parse.py -f schbench_vanilla.log
> (each group has 28 tasks)
> case	        load	    se_eff%	    dom_eff%	  fast_rate%	success_rate%
> normal	   1   mthread	     99.152	       6.400	      99.941	     100.000
> normal	   2   mthreads	     97.844	       4.003	      99.908	     100.000
> normal	   3   mthreads	     96.395	       2.118	      99.917	      99.998
> normal	   4   mthreads	     55.288	       1.451	      98.615	      99.804
> normal	   5   mthreads	      7.004	       1.870	      45.597	      61.036
> normal	   6   mthreads	      3.354	       1.346	      20.777	      34.230
> normal	   7   mthreads	      2.183	       1.028	      11.257	      21.055
> normal	   8   mthreads	      1.653	       0.825	       7.849	      15.549
> 
> schedstat_parse.py -f hackbench_vanilla.log
> (each group has 28 tasks)
> case			load	        se_eff%	    dom_eff%	  fast_rate%	success_rate%
> process-pipe	     1 group	         99.991	       7.692	      99.999	     100.000
> process-pipe	    2 groups	         99.934	       4.615	      99.997	     100.000
> process-pipe	    3 groups	         99.597	       3.198	      99.987	     100.000
> process-pipe	    4 groups	         98.378	       2.464	      99.958	     100.000
> process-pipe	    5 groups	         27.474	       3.653	      89.811	      99.800
> process-pipe	    6 groups	         20.201	       4.098	      82.763	      99.570
> process-pipe	    7 groups	         16.423	       4.156	      77.398	      99.316
> process-pipe	    8 groups	         13.165	       3.920	      72.232	      98.828
> process-sockets	     1 group	         99.977	       5.882	      99.999	     100.000
> process-sockets	    2 groups	         99.927	       5.505	      99.996	     100.000
> process-sockets	    3 groups	         99.397	       3.250	      99.980	     100.000
> process-sockets	    4 groups	         79.680	       4.258	      98.864	      99.998
> process-sockets	    5 groups	          7.673	       2.503	      63.659	      92.115
> process-sockets	    6 groups	          4.642	       1.584	      58.946	      88.048
> process-sockets	    7 groups	          3.493	       1.379	      49.816	      81.164
> process-sockets	    8 groups	          3.015	       1.407	      40.845	      75.500
> threads-pipe	     1 group	         99.997	       0.000	     100.000	     100.000
> threads-pipe	    2 groups	         99.894	       2.932	      99.997	     100.000
> threads-pipe	    3 groups	         99.611	       4.117	      99.983	     100.000
> threads-pipe	    4 groups	         97.703	       2.624	      99.937	     100.000
> threads-pipe	    5 groups	         22.919	       3.623	      87.150	      99.764
> threads-pipe	    6 groups	         18.016	       4.038	      80.491	      99.557
> threads-pipe	    7 groups	         14.663	       3.991	      75.239	      99.247
> threads-pipe	    8 groups	         12.242	       3.808	      70.651	      98.644
> threads-sockets	     1 group	         99.990	       6.667	      99.999	     100.000
> threads-sockets	    2 groups	         99.940	       5.114	      99.997	     100.000
> threads-sockets	    3 groups	         99.469	       4.115	      99.977	     100.000
> threads-sockets	    4 groups	         87.528	       4.038	      99.400	     100.000
> threads-sockets	    5 groups	          6.942	       2.398	      59.244	      88.337
> threads-sockets	    6 groups	          4.359	       1.954	      49.448	      87.860
> threads-sockets	    7 groups	          2.845	       1.345	      41.198	      77.102
> threads-sockets	    8 groups	          2.871	       1.404	      38.512	      74.312
> 
> schedstat_parse.py -f tbench_vanilla.log
> case			load	      se_eff%	    dom_eff%	  fast_rate%	success_rate%
> loopback	  28 threads	       99.976	      18.369	      99.995	     100.000
> loopback	  56 threads	       99.222	       7.799	      99.934	     100.000
> loopback	  84 threads	       19.723	       6.819	      70.215	     100.000
> loopback	 112 threads	       11.283	       5.371	      55.371	      99.999
> loopback	 140 threads	        0.000	       0.000	       0.000	       0.000
> loopback	 168 threads	        0.000	       0.000	       0.000	       0.000
> loopback	 196 threads	        0.000	       0.000	       0.000	       0.000
> loopback	 224 threads	        0.000	       0.000	       0.000	       0.000
> 
> According to the test above, if the system becomes busy, the
> SIS Search Efficiency(se_eff%) drops significantly. Although some
> benchmarks would finally find an idle CPU(success_rate% = 100%), it is
> doubtful whether it is worth it to search the whole LLC domain.
> 
> [Proposal]
> It would be ideal to have a crystal ball to answer this question:
> How many CPUs must a wakeup path walk down, before it can find an idle
> CPU? Many potential metrics could be used to predict the number.
> One candidate is the sum of util_avg in this LLC domain. The benefit
> of choosing util_avg is that it is a metric of accumulated historic
> activity, which seems to be smoother than instantaneous metrics
> (such as rq->nr_running). Besides, choosing the sum of util_avg
> would help predict the load of the LLC domain more precisely, because
> SIS_PROP uses one CPU's idle time to estimate the total LLC domain idle
> time. As Peter suggested[2], the lower the util_avg is, the
> more select_idle_cpu() should scan for idle CPU, and vice versa.
> 
> Introduce the quadratic function:
> 
> y = a - bx^2
> 
> x is the sum_util ratio [0, 100] of this LLC domain, and y is the percentage
> of CPUs to be scanned in the LLC domain. The number of CPUs to search drops
> as sum_util increases. When sum_util hits 85% or above, the scan stops.
> Choosing 85% is because it is the threshold of an overloaded LLC sched group
> (imbalance_pct = 117). Choosing quadratic function is because:
> 
> [1] Compared to the linear function, it scans more aggressively when the
>     sum_util is low.
> [2] Compared to the exponential function, it is easier to calculate.
> [3] It seems that there is no accurate mapping between the sum of util_avg
>     and the number of CPUs to be scanned. Use heuristic scan for now.
> 
> The steps to calculate scan_nr are as followed:
> [1] scan_percent = 100 - (x/8.5)^2
>     when utilization reaches 85%, scan_percent becomes 0.
> [2] scan_nr = nr_llc * scan_percent / 100
> [3] scan_nr = max(scan_nr, 0)
> 
> For a platform with 112 CPUs per LLC, the number of CPUs to scan is:
> sum_util%   0    5   15   25  35  45  55   65   75   85 ...
> scan_ns   112  112  108  103  92  80  64   47   24    0 ...
> 
> Furthermore, to minimize the overhead of calculating the metrics in
> select_idle_cpu(), borrow the statistics from periodic load balance.
> As mentioned by Abel, on a platform with 112 CPUs per LLC, the
> sum_util calculated by periodic load balance after 112ms would decay
> to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%, thus bringing a delay in
> reflecting the latest utilization. But it is a trade-off.
> Checking the util_avg in newidle load balance would be more frequent,
> but it brings overhead - multiple CPUs write/read the per-LLC shared
> variable and introduces cache false sharing. And Tim also mentioned
> that, it is allowed to be non-optimal in terms of scheduling for the
> short term variations, but if there is a long term trend in the load
> behavior, the scheduler can adjust for that.
> 
> SIS_UTIL is disabled by default. When it is enabled, the select_idle_cpu()
> will use the nr_scan calculated by SIS_UTIL instead of the one from
> SIS_PROP. Later SIS_UTIL and SIS_PROP could be made mutually exclusive.
> 
> [Test result]
> 
> The following is the benchmark result comparison between
> baseline:vanilla and compare:patched kernel. Positive compare%
> indicates better performance.
> 
> netperf.throughput
> each thread: netperf -4 -H 127.0.0.1 -t TCP/UDP_RR -c -C -l 100
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	28 threads	 1.00 (  0.40)	 +1.14 (  0.37)
> TCP_RR          	56 threads	 1.00 (  0.49)	 +0.62 (  0.31)
> TCP_RR          	84 threads	 1.00 (  0.50)	 +0.26 (  0.55)
> TCP_RR          	112 threads	 1.00 (  0.27)	 +0.29 (  0.28)
> TCP_RR          	140 threads	 1.00 (  0.22)	 +0.14 (  0.23)
> TCP_RR          	168 threads	 1.00 (  0.21)	 +0.40 (  0.19)
> TCP_RR          	196 threads	 1.00 (  0.18)	+183.40 ( 16.43)
> TCP_RR          	224 threads	 1.00 (  0.16)	+188.44 (  9.29)
> UDP_RR          	28 threads	 1.00 (  0.47)	 +1.45 (  0.47)
> UDP_RR          	56 threads	 1.00 (  0.28)	 -0.22 (  0.30)
> UDP_RR          	84 threads	 1.00 (  0.38)	 +1.72 ( 27.10)
> UDP_RR          	112 threads	 1.00 (  0.16)	 +0.01 (  0.18)
> UDP_RR          	140 threads	 1.00 ( 14.10)	 +0.32 ( 11.15)
> UDP_RR          	168 threads	 1.00 ( 12.75)	 +0.91 ( 11.62)
> UDP_RR          	196 threads	 1.00 ( 14.41)	+191.97 ( 19.34)
> UDP_RR          	224 threads	 1.00 ( 15.34)	+194.88 ( 17.06)
> 
> Take the 224 threads as an example, the SIS search metrics changes are
> illustrated below:
> 
>     vanilla                    patched
>    4544492          +237.5%   15338634        sched_debug.cpu.sis_domain_search.avg
>      38539        +39686.8%   15333634        sched_debug.cpu.sis_failed.avg
>   128300000          -87.9%   15551326        sched_debug.cpu.sis_scanned.avg
>    5842896          +162.7%   15347978        sched_debug.cpu.sis_search.avg
> 
> There is -87.9% less CPU scans after patched, which indicates lower overhead.
> Besides, with this patch applied, there is -13% less rq lock contention
> in perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested
> .try_to_wake_up.default_wake_function.woken_wake_function.
> This could help explain the performance improvement - Because this patch allows
> the waking task to remain on the previous CPU, rather than grabbing other CPU's
> lock.
> 
> Other benchmarks:
> 
> hackbench.throughput
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1 group 	 1.00 (  0.09)	 -0.54 (  0.82)
> process-pipe    	2 groups 	 1.00 (  0.47)	 +0.89 (  0.61)
> process-pipe    	4 groups 	 1.00 (  0.83)	 +0.90 (  0.15)
> process-pipe    	8 groups 	 1.00 (  0.09)	 +0.31 (  0.07)
> process-sockets 	1 group 	 1.00 (  0.13)	 -0.58 (  0.49)
> process-sockets 	2 groups 	 1.00 (  0.41)	 -0.58 (  0.52)
> process-sockets 	4 groups 	 1.00 (  0.61)	 -0.37 (  0.50)
> process-sockets 	8 groups 	 1.00 (  0.22)	 +1.15 (  0.10)
> threads-pipe    	1 group 	 1.00 (  0.35)	 -0.28 (  0.78)
> threads-pipe    	2 groups 	 1.00 (  0.65)	 +0.03 (  0.96)
> threads-pipe    	4 groups 	 1.00 (  0.43)	 +0.81 (  0.38)
> threads-pipe    	8 groups 	 1.00 (  0.11)	 -1.56 (  0.07)
> threads-sockets 	1 group 	 1.00 (  0.30)	 -0.39 (  0.41)
> threads-sockets 	2 groups 	 1.00 (  0.21)	 -0.23 (  0.27)
> threads-sockets 	4 groups 	 1.00 (  0.23)	 +0.36 (  0.19)
> threads-sockets 	8 groups 	 1.00 (  0.13)	 +1.57 (  0.06)
> 
> tbench.throughput
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	28 threads	 1.00 (  0.15)	 +1.05 (  0.08)
> loopback        	56 threads	 1.00 (  0.09)	 +0.36 (  0.04)
> loopback        	84 threads	 1.00 (  0.12)	 +0.26 (  0.06)
> loopback        	112 threads	 1.00 (  0.12)	 +0.04 (  0.09)
> loopback        	140 threads	 1.00 (  0.04)	 +2.98 (  0.18)
> loopback        	168 threads	 1.00 (  0.10)	 +2.88 (  0.30)
> loopback        	196 threads	 1.00 (  0.06)	 +2.63 (  0.03)
> loopback        	224 threads	 1.00 (  0.08)	 +2.60 (  0.06)
> 
> schbench.latency_90%_us
> ========
> case            	load    	baseline	compare%
> normal          	1 mthread	 1.00 	        -1.7%
> normal          	2 mthreads	 1.00           +1.6%
> normal          	4 mthreads	 1.00           +1.4%
> normal          	8 mthreads	 1.00    	+21.0%
> 
> Limitations:
> [1]
> This patch is based on the util_avg, which is very sensitive to the CPU
> frequency invariance. The util_avg would decay quite fast when the
> CPU is idle, if the max frequency has been limited by the user.
> Patch [3] should be applied if turbo is disabled manually on Intel
> platforms.
> 
> [2]
> There may be unbalanced tasks among CPUs due to CPU affinity. For example,
> suppose the LLC domain is composed of 8 CPUs, and 7 tasks are bound to
> CPU0~CPU6, while CPU7 is idle:
> 
>           CPU0    CPU1    CPU2    CPU3    CPU4    CPU5    CPU6    CPU7
> util_avg  1024    1024    1024    1024    1024    1024    1024    0
> 
> Since the util_avg ratio is 87.5%( = 7/8 ), which is higher than 85%,
> select_idle_cpu() will not scan, thus CPU7 is undetected.
> 
> A possible workaround to mitigate this problem is that the nr_scan should
> be increased if idle CPUs are detected during periodic load balance. And the
> problem could be mitigated by idle load balance that, CPU7 might pull some
> tasks on it.
> 
> [3]
> Prateek mentioned that we should scan aggressively in an LLC domain
> with 16 CPUs. Because the cost to search for an idle one among 16 CPUs is
> negligible. The current patch aims to propose a generic solution and only
> considers the util_avg. A follow-up change could enhance the scan policy
> to adjust the scan_percent according to the CPU number in LLC.
> 
> v2->v3:
>  - Use 85% as the threshold again, because the CPU frequency invariance issue
>    has been fixed and the patch is queued for 5.19.
> 
>  - Stop the scan if 85% is reached, rather than scanning for at least 4 CPUs.
>    According to the feedback from Yicong, it might be better to stop scanning
>    entirely when the LLC is overloaded.
> 
>  - Replace linear scan with quadratic function scan, to let the SIS scan
>    aggressively when the LLC is not busy. Prateek mentioned there was slight
>    regression from ycsb-mongodb in v2, which might be due to fewer CPUs
>    scanned when the utilization is around 20%.
> 
>  - Add back the logic to stop the CPU scan even if has_idle_core is true.
>    It might be a waste of time to search for an idle Core if the LLC is
>    overloaded. Besides, according to the tbench result from Prateek, stop idle
>    Core scan would bring extra performance improvement.
> 
>  - Provide the SIS search statistics in the commit log, based on Mel Gorman's
>    patch, which is suggested by Adel.
> 
>  - Introduce SIS_UTIL sched feature rather than changing the logic of SIS_PROP
>    directly, which can be reviewed easier.
> 
> v2->v1:
>  - As suggested by Peter, introduce an idle CPU scan strategy that is based on
>    the util_avg metric. When util_avg is very low it scans more, while when
>    util_avg hits the threshold we naturally stop scanning entirely. The threshold
>    has been decreased from 85% to 50%, because this is the threshold when the
>    CPU is nearly 100% but with turbo disabled. At least scan for 4 CPUs even
>    when the LLC is overloaded, to keep it consistent with the current logic of
>    select_idle_cpu().
> 
> v1:
>  - Stop scanning the idle CPU in select_idle_cpu(), if the sum of util_avg in
>    the LLC domain has reached 85%.
> 
> [Resend to include the missing mailing list, sorry for any inconvenience.]
> 
> Link: https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net #1
> Link: https://lore.kernel.org/lkml/20220207135253.GF23216@worktop.programming.kicks-ass.net #2
> Link: https://lore.kernel.org/lkml/20220407234258.569681-1-yu.c.chen@intel.com #3
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 56 ++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h        |  1 +
>  3 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 56cffe42abbc..816df6cc444e 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -81,6 +81,7 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +	int		nr_idle_scan;
>  };
>  
>  struct sched_domain {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 23c7d0f617ee..50c9d5b2b338 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6327,6 +6327,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	struct sched_domain_shared *sd_share;
>  	struct rq *this_rq = this_rq();
>  	int this = smp_processor_id();
>  	struct sched_domain *this_sd;
> @@ -6366,6 +6367,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		time = cpu_clock(this);
>  	}
>  
> +	if (sched_feat(SIS_UTIL)) {
> +		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> +		if (sd_share) {
> +			/* because !--nr is the condition to stop scan */
> +			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> +			/* overloaded LLC is unlikely to have idle cpu/core */
> +			if (nr == 1)
> +				return -1;
> +		}
> +	}
> +
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -9267,6 +9279,46 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  	return idlest;
>  }
>  
> +static inline void update_idle_cpu_scan(struct lb_env *env,
> +					unsigned long sum_util)
> +{
> +	struct sched_domain_shared *sd_share;
> +	int nr_scan, nr_llc, llc_util_pct;
> +
> +	if (!sched_feat(SIS_UTIL))
> +		return;
> +	/*
> +	 * Update the number of CPUs to scan in LLC domain, which could
> +	 * be used as a hint in select_idle_cpu(). The update of this hint
> +	 * occurs during periodic load balancing, rather than frequent
> +	 * newidle balance.
> +	 */
> +	nr_llc = per_cpu(sd_llc_size, env->dst_cpu);
> +	if (env->idle == CPU_NEWLY_IDLE ||
> +	    env->sd->span_weight != nr_llc)
> +		return;
> +
> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
> +	if (!sd_share)
> +		return;
> +
> +	/*
> +	 * The number of CPUs to search drops as sum_util increases, when
> +	 * sum_util hits 85% or above, the scan stops.
> +	 * The reason to choose 85% as the threshold is because this is the
> +	 * imbalance_pct when a LLC sched group is overloaded.
> +	 * let y = 100 - (x/8.5)^2 = 100 - x^2/72
> +	 * y is the percentage of CPUs to be scanned in the LLC
> +	 * domain, x is the ratio of sum_util compared to the
> +	 * CPU capacity, which ranges in [0, 100], thus
> +	 * nr_scan = nr_llc * y / 100
> +	 */
> +	llc_util_pct = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
> +	nr_scan = (100 - (llc_util_pct * llc_util_pct / 72)) * nr_llc / 100;
> +	nr_scan = max(nr_scan, 0);
> +	WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> +}
> +
>  /**
>   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -9279,6 +9331,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	struct sched_group *sg = env->sd->groups;
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
> +	unsigned long sum_util = 0;
>  	int sg_status = 0;
>  
>  	do {
> @@ -9311,6 +9364,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		sds->total_load += sgs->group_load;
>  		sds->total_capacity += sgs->group_capacity;
>  
> +		sum_util += sgs->group_util;
>  		sg = sg->next;
>  	} while (sg != env->sd->groups);
>  
> @@ -9336,6 +9390,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
>  		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
>  	}
> +
> +	update_idle_cpu_scan(env, sum_util);
>  }
>  
>  #define NUMA_IMBALANCE_MIN 2
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 1cf435bbcd9c..69be099019f4 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>   */
>  SCHED_FEAT(SIS_PROP, true)
> +SCHED_FEAT(SIS_UTIL, false)
>  

I see you mentioned they're mutually exclusive in the commit, worth a comment here?

One minor question: nr is updated in load balance so there maybe a delay because of
interval of load balancing. Furthermore, the LLC domain may not be balanced everytime
if the lowest domain is not LLC, like CLS->LLC. So maybe a bit more delay included.

The test results is fine and as expected. The improvement of netperf at a heavy load
condition, compared to your v2 version.

Thanks,
Yicong

TCP_RR node 0-1
threads
16	57559.56667	57930.03333 (+0.64%)
32	56373		57754.53333 (+2.45%)
64	18831.4		46234.76667 (+145.52%)
128	15658.9		19620.26667 (+25.30%)
256	7959.896667	8869.013333 (+11.42%)

TCP_RR node 0
threads
16	58389.43333	59026.03333 (+1.09%)
32	23779.6		51563.33333 (+116.84%)
64	20514.56667	23485.63333 (+14.48%)
128	8202.49		9205.483333 (+12.23%)
256	3843.163333	4304.8      (+12.01%)

tbench4 node 0-1
                           5.18-rc1                patched
Hmean     1        299.02 (   0.00%)      307.73 *   2.91%*
Hmean     2        597.88 (   0.00%)      619.10 *   3.55%*
Hmean     4       1207.11 (   0.00%)     1239.57 *   2.69%*
Hmean     8       2406.67 (   0.00%)     2463.63 *   2.37%*
Hmean     16      4755.52 (   0.00%)     4979.46 *   4.71%*
Hmean     32      9449.01 (   0.00%)     9709.59 *   2.76%*
Hmean     64     10538.89 (   0.00%)    10727.86 *   1.79%*
Hmean     128    13333.84 (   0.00%)    14580.63 *   9.35%*
Hmean     256    11735.24 (   0.00%)    11737.16 (   0.02%)

tbench4 node 0
                           5.18-rc1                patched
Hmean     1        302.26 (   0.00%)      313.43 *   3.70%*
Hmean     2        603.87 (   0.00%)      618.56 *   2.43%*
Hmean     4       1213.91 (   0.00%)     1249.63 *   2.94%*
Hmean     8       2469.72 (   0.00%)     2527.48 *   2.34%*
Hmean     16      4980.70 (   0.00%)     5099.62 *   2.39%*
Hmean     32      9001.88 (   0.00%)     9730.27 *   8.09%*
Hmean     64      7032.07 (   0.00%)     7691.56 *   9.38%*
Hmean     128     6037.76 (   0.00%)     6712.86 *  11.18%*
Hmean     256     8513.83 (   0.00%)     9117.79 *   7.09%*

>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
> 
