Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2C4AB422
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiBGFuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiBGDlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:41:24 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:41:23 PST
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A862C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644205283; x=1675741283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DxzfBPyoiTsLf0QdgfHO2igbzYxMtnjk2Zp6ZwRl9LU=;
  b=M8X9LgBwsrkZbJzpnjNqymG6HbLRyAidliSiQDO5sv9T3HHTZVdsMoZt
   jNDcEtL2J90gjchgUAfAxks7eiyrS8GIzTCRyjdn7bNOIvQwLd61Q/vNa
   DfEQeFGzikeqKqJKE94sQ03EtFXHgmxkQIjD1sFjuVXb+sYhoq5/H93eB
   vpVYuglfmkEPRpfdiDKE6qHGFgWtRjHD5nZ6Xv9Ty03SqosUsuMi88bxx
   cv3w4tvCLJdLzWK0fd4cV7wbq1EEDGZkkeDv9ei+Xx4/duGPuPwQxCGcq
   mkqiJF9v6YVR3goCvZ5pFOwUt2p3ONSPNb1mL3rsY2bc8yxGEagqXlLO4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="246223698"
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="246223698"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 19:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="700320489"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2022 19:40:15 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] sched: Stop searching for idle cpu if the LLC domain is overloaded
Date:   Mon,  7 Feb 2022 11:40:13 +0800
Message-Id: <20220207034013.599214-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Problem Statement]
Searching for an idle cpu/core in a LLC domain is time consuming
when the LLC domain is relatively busy. Even worse, it is possible
that after iterating the whole LLC domain, it might still
fail to find an idle cpu/core.

The following histogram is the time(usec) spent in select_idle_cpu(),
when running 224 instance of netperf:

@usec: 
[1]                    2 |                                                    |
[2, 4)                 1 |                                                    |
[4, 8)                 4 |                                                    |
[8, 16)              948 |                                                    |
[16, 32)           18420 |@@@@@@@@@@@@@@@@@@                                  |
[32, 64)           40391 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             |
[64, 128)          49345 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    |
[128, 256)         52539 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[256, 512)         45178 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
[512, 1K)          28838 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
[1K, 2K)           10825 |@@@@@@@@@@                                          |
[2K, 4K)            1352 |@                                                   |
[4K, 8K)              24 |    

The time spent in select_idle_cpu() is visible to some workloads and might
bring negative impact. 

[Symptom analysis]
The patch [1] from Mel Gorman has been applied to track the efficiency
of select_idle_sibling. Copy the indicators here:

SIS Search Efficiency(se_eff%):
        A ratio expressed as a percentage of runqueues scanned versus
        idle CPUs found. A 100% efficiency indicates that the target,
        prev or recent CPU of a task was idle at wakeup. The lower the
        efficiency, the more runqueues were scanned before an idle CPU
        was found.

SIS Domain Search Efficiency(dom_eff%):
        Similar, except only for the slower SIS
	patch.

SIS Fast Success Rate(fast_rate%):
        Percentage of SIS that used target, prev or
	recent CPUs.

SIS Success rate(success_rate%):
        Percentage of scans that found an idle CPU.

netperf, hackbench, schbench, tbench
were tested with 25% 50% 75% 100% 125% 150% 175% 200% of cpu number
respectively. Each test lasts for 60 seconds, and repeats 3 times.
The system would reboot into a fresh environment for each benchmark testing.

Test on vanilla kernel:
schedstat_parse.py -f netperf_vanilla.log
case	        load	    se_eff%	    dom_eff%	  fast_rate%	success_rate%
TCP_RR	   thread-28	     99.978	      18.535	      99.995	     100.000
TCP_RR	   thread-56	     99.397	       5.671	      99.964	     100.000
TCP_RR	   thread-84	     21.721	       6.818	      73.632	     100.000
TCP_RR	  thread-112	     12.500	       5.533	      59.000	     100.000
TCP_RR	  thread-140	      8.524	       4.535	      49.020	     100.000
TCP_RR	  thread-168	      6.438	       3.945	      40.309	      99.999
TCP_RR	  thread-196	      5.397	       3.718	      32.320	      99.982
TCP_RR	  thread-224	      4.874	       3.661	      25.775	      99.767
UDP_RR	   thread-28	     99.988	      17.704	      99.997	     100.000
UDP_RR	   thread-56	     99.528	       5.977	      99.970	     100.000
UDP_RR	   thread-84	     24.219	       6.992	      76.479	     100.000
UDP_RR	  thread-112	     13.907	       5.706	      62.538	     100.000
UDP_RR	  thread-140	      9.408	       4.699	      52.519	     100.000
UDP_RR	  thread-168	      7.095	       4.077	      44.352	     100.000
UDP_RR	  thread-196	      5.757	       3.775	      35.764	      99.991
UDP_RR	  thread-224	      5.124	       3.704	      28.748	      99.860

schedstat_parse.py -f schbench_vanilla.log
(mthread-n has 1/4 * n * 112 tasks)
case	        load	    se_eff%	    dom_eff%	  fast_rate%	success_rate%
normal	   mthread-1	     99.152	       6.400	      99.941	     100.000
normal	   mthread-2	     97.844	       4.003	      99.908	     100.000
normal	   mthread-3	     96.395	       2.118	      99.917	      99.998
normal	   mthread-4	     55.288	       1.451	      98.615	      99.804
normal	   mthread-5	      7.004	       1.870	      45.597	      61.036
normal	   mthread-6	      3.354	       1.346	      20.777	      34.230
normal	   mthread-7	      2.183	       1.028	      11.257	      21.055
normal	   mthread-8	      1.653	       0.825	       7.849	      15.549

schedstat_parse.py -f hackbench_vanilla.log
(group-n has 1/4 * n * 112 tasks)
case			load	        se_eff%	    dom_eff%	  fast_rate%	success_rate%
process-pipe	     group-1	         99.991	       7.692	      99.999	     100.000
process-pipe	     group-2	         99.934	       4.615	      99.997	     100.000
process-pipe	     group-3	         99.597	       3.198	      99.987	     100.000
process-pipe	     group-4	         98.378	       2.464	      99.958	     100.000
process-pipe	     group-5	         27.474	       3.653	      89.811	      99.800
process-pipe	     group-6	         20.201	       4.098	      82.763	      99.570
process-pipe	     group-7	         16.423	       4.156	      77.398	      99.316
process-pipe	     group-8	         13.165	       3.920	      72.232	      98.828
process-sockets	     group-1	         99.977	       5.882	      99.999	     100.000
process-sockets	     group-2	         99.927	       5.505	      99.996	     100.000
process-sockets	     group-3	         99.397	       3.250	      99.980	     100.000
process-sockets	     group-4	         79.680	       4.258	      98.864	      99.998
process-sockets	     group-5	          7.673	       2.503	      63.659	      92.115
process-sockets	     group-6	          4.642	       1.584	      58.946	      88.048
process-sockets	     group-7	          3.493	       1.379	      49.816	      81.164
process-sockets	     group-8	          3.015	       1.407	      40.845	      75.500
threads-pipe	     group-1	         99.997	       0.000	     100.000	     100.000
threads-pipe	     group-2	         99.894	       2.932	      99.997	     100.000
threads-pipe	     group-3	         99.611	       4.117	      99.983	     100.000
threads-pipe	     group-4	         97.703	       2.624	      99.937	     100.000
threads-pipe	     group-5	         22.919	       3.623	      87.150	      99.764
threads-pipe	     group-6	         18.016	       4.038	      80.491	      99.557
threads-pipe	     group-7	         14.663	       3.991	      75.239	      99.247
threads-pipe	     group-8	         12.242	       3.808	      70.651	      98.644
threads-sockets	     group-1	         99.990	       6.667	      99.999	     100.000
threads-sockets	     group-2	         99.940	       5.114	      99.997	     100.000
threads-sockets	     group-3	         99.469	       4.115	      99.977	     100.000
threads-sockets	     group-4	         87.528	       4.038	      99.400	     100.000
threads-sockets	     group-5	          6.942	       2.398	      59.244	      88.337
threads-sockets	     group-6	          4.359	       1.954	      49.448	      87.860
threads-sockets	     group-7	          2.845	       1.345	      41.198	      77.102
threads-sockets	     group-8	          2.871	       1.404	      38.512	      74.312

schedstat_parse.py -f tbench_vanilla.log
case			load	      se_eff%	    dom_eff%	  fast_rate%	success_rate%
loopback	   thread-28	       99.976	      18.369	      99.995	     100.000
loopback	   thread-56	       99.222	       7.799	      99.934	     100.000
loopback	   thread-84	       19.723	       6.819	      70.215	     100.000
loopback	  thread-112	       11.283	       5.371	      55.371	      99.999
loopback	  thread-140	        0.000	       0.000	       0.000	       0.000
loopback	  thread-168	        0.000	       0.000	       0.000	       0.000
loopback	  thread-196	        0.000	       0.000	       0.000	       0.000
loopback	  thread-224	        0.000	       0.000	       0.000	       0.000

According to the test on vanilla kernel, if the system is busy,
the SIS Search Efficiency(se_eff%) drops significantly. Although some
benchmarks would finally find an idle cpu(success_rate% = 100%), it is
doubtful whether it is worth it to search the whole LLC domain.

[Proposal]
It would be ideal to have a crystal ball to predict the success rate
of finding an idle cpu/core in the LLC. If it is doomed to fail,
there is no need to search in the LLC domain. There are many potential
metrics which could be used to predict the success rate. And the
metric should be carefully chosen that, it should help reduce the
unnecessary cpu runqueue scan, but meanwhile not give up the opportunity
to find an idle cpu.

Choose average cpu utilization as the candidate, since the util_avg is
a metric of accumulated historic activity, which seems to be more accurate
than instantaneous metrics(such as rq->nr_running) on calculating the probability
of find an idle cpu. Only when the average cpu utilization has reaches
85% of the total cpu capacity, this domain is regarded as overloaded.
The reason to choose 85% is that, this is the threshold of an overloaded
LLC sched group(imbalance_pct = 117, threshold = 100 / 117 * 100%).

Furthermore, to minimize the overhead of calculating the metrics in
select_idle_cpu(), borrow the statistics from periodic load balance.

[Benchmark result]
In summary, patched kernel has better performance than vanilla
in some microbenchmarks, and no significant negative impact to other
microbenchmarks. Patched kernel also benefits a known OLTP benchmark,
which operates with system about 95% busy.

The following is the benchmark result comparison between
baseline:vanilla and compare:patched kernel. Positive compare%
indicates better performance.

OLTP(95% busy)
baseline    compare
1.00        +1.41%

hackbench(Throughput)
(group-n has 1/4 * n * 112 tasks)
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	group-1 	 1.00 (  0.32)	 -0.03 (  0.22)
process-pipe    	group-2 	 1.00 (  0.60)	 +1.12 (  0.46)
process-pipe    	group-3 	 1.00 (  0.03)	 +1.44 (  0.63)
process-pipe    	group-4 	 1.00 (  0.44)	 +1.52 (  0.66)
process-pipe    	group-5 	 1.00 (  0.13)	 +0.02 (  0.45)
process-pipe    	group-6 	 1.00 (  0.65)	 -0.13 (  0.36)
process-pipe    	group-7 	 1.00 (  0.12)	 -0.35 (  0.15)
process-pipe    	group-8 	 1.00 (  0.05)	 -0.72 (  0.09)
process-sockets 	group-1 	 1.00 (  0.08)	 -0.75 (  0.61)
process-sockets 	group-2 	 1.00 (  0.32)	 +0.15 (  0.28)
process-sockets 	group-3 	 1.00 (  0.19)	 +0.33 (  0.22)
process-sockets 	group-4 	 1.00 (  0.40)	 +0.47 (  0.22)
process-sockets 	group-5 	 1.00 (  1.96)	 +6.09 (  0.36)
process-sockets 	group-6 	 1.00 (  0.42)	 -1.18 (  0.64)
process-sockets 	group-7 	 1.00 (  0.12)	 -0.57 (  0.12)
process-sockets 	group-8 	 1.00 (  0.14)	 +0.33 (  0.29)
threads-pipe    	group-1 	 1.00 (  0.25)	 -1.08 (  0.30)
threads-pipe    	group-2 	 1.00 (  0.59)	 +0.54 (  0.60)
threads-pipe    	group-3 	 1.00 (  0.98)	 -0.47 (  0.74)
threads-pipe    	group-4 	 1.00 (  0.24)	 +0.10 (  0.14)
threads-pipe    	group-5 	 1.00 (  0.15)	 -0.03 (  0.28)
threads-pipe    	group-6 	 1.00 (  0.28)	 -0.50 (  0.18)
threads-pipe    	group-7 	 1.00 (  0.11)	 -0.63 (  0.04)
threads-pipe    	group-8 	 1.00 (  0.08)	 -0.43 (  0.04)
threads-sockets 	group-1 	 1.00 (  0.49)	 -1.30 (  0.16)
threads-sockets 	group-2 	 1.00 (  0.19)	 -0.18 (  0.09)
threads-sockets 	group-3 	 1.00 (  0.28)	 +0.50 (  0.04)
threads-sockets 	group-4 	 1.00 (  1.36)	 +1.50 (  0.78)
threads-sockets 	group-5 	 1.00 (  0.33)	 +1.33 (  0.50)
threads-sockets 	group-6 	 1.00 (  0.21)	 +0.36 (  0.16)
threads-sockets 	group-7 	 1.00 (  0.09)	 -0.36 (  0.15)
threads-sockets 	group-8 	 1.00 (  0.12)	 +1.07 (  0.03)

netperf(Throughput)
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	thread-28	 1.00 (  0.29)	 -0.23 (  0.42)
TCP_RR          	thread-56	 1.00 (  1.03)	 +0.42 (  1.00)
TCP_RR          	thread-84	 1.00 (  0.80)	 +0.39 (  0.84)
TCP_RR          	thread-112	 1.00 (  0.43)	 +0.45 (  0.35)
TCP_RR          	thread-140	 1.00 (  0.26)	 +0.58 (  0.32)
TCP_RR          	thread-168	 1.00 (  0.21)	 +0.69 (  0.23)
TCP_RR          	thread-196	 1.00 (  0.20)	 +0.77 (  0.18)
TCP_RR          	thread-224	 1.00 (  0.18)	+164.89 ( 44.90)
UDP_RR          	thread-28	 1.00 (  0.38)	 -0.48 (  0.34)
UDP_RR          	thread-56	 1.00 (  0.59)	 +1.07 (  0.62)
UDP_RR          	thread-84	 1.00 (  1.04)	 +0.44 (  1.03)
UDP_RR          	thread-112	 1.00 ( 14.96)	 +2.53 ( 32.65)
UDP_RR          	thread-140	 1.00 ( 14.83)	 +0.96 ( 18.83)
UDP_RR          	thread-168	 1.00 ( 13.12)	 +0.76 (  8.64)
UDP_RR          	thread-196	 1.00 (  9.67)	 +1.32 ( 18.53)
UDP_RR          	thread-224	 1.00 ( 14.10)	+126.46 ( 42.27)

tbench(Throughput)
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	thread-28	 1.00 (  0.12)	 +0.25 (  0.08)
loopback        	thread-56	 1.00 (  0.10)	 +0.15 (  0.11)
loopback        	thread-84	 1.00 (  0.11)	 +0.09 (  0.09)
loopback        	thread-112	 1.00 (  0.08)	 -0.11 (  0.09)
loopback        	thread-140	 1.00 (  0.17)	 +2.54 (  0.24)
loopback        	thread-168	 1.00 (  0.04)	 +2.44 (  0.16)
loopback        	thread-196	 1.00 (  0.10)	 +2.41 (  0.10)
loopback        	thread-224	 1.00 (  0.17)	 +2.30 (  0.10)

schbench(Latency)
(mthread-n has 1/4 * n * 112 tasks)
========
case            	load    	baseline(std%)	compare%( std%)
normal          	mthread-1	 1.00 (  1.01)	 +0.57 (  1.06)
normal          	mthread-2	 1.00 ( 20.99)	+14.65 (  4.67)
normal          	mthread-3	 1.00 (  3.03)	 -0.12 (  3.41)
normal          	mthread-4	 1.00 (  0.76)	 -4.71 ( 21.04)
normal          	mthread-5	 1.00 (  1.80)	 -4.90 (  1.39)
normal          	mthread-6	 1.00 (  0.08)	 -0.59 (  1.56)
normal          	mthread-7	 1.00 (  2.68)	 -1.70 (  3.53)
normal          	mthread-8	 1.00 (  2.19)	 -0.50 (  3.46)

According to the results above, when the workloads is 2 times of the cpu
number(224), the throughput of netperf improves a lot(164.89% and 126.46%).
It might be interesting to look into the reason why this patch benefits
netperf significantly. Further investigation has shown that, the system
utilization is around 90% on vanilla kernel, while 100% on patched kernel.
It is still under investigation why vanilla kernel could not reach 100%.

For the latency result from schbench, there seems to be some regressions.
And consider the standard deviation ratio, only when the running task is
125% of the cpu number, there is a valid regression.

[Limitation]

A corner case needs to be covered that, it is possible that there is unbalanced
tasks among CPUs due to cpu affinity. For example, suppose the LLC domain is
composed of 8 cpus, and 10 tasks are bound to cpu0~cpu6, while cpu7 is idle:

		cpu0	cpu1	cpu2	cpu3	cpu4	cpu5	cpu6	cpu7
util_avg	1024	1024	1024	1024	1024	1024	1024	0

Since the total average util is higher than 85% of cpu capacity
(7 * 1024 / 8 * 1024 = 87.5%), this LLC domain is regarded as overloaded and
will not be scanned, leaving the idle cpu7 undetected.

A possible workaround to mitigate this problem is that, the idle cpu's capacity
can be subtracted from the total cpu util. In the example above, the adjusted
total average util becomes 1024 * 7 - 1024, and the util ratio is 6/8 = 75%,
as it is lower than 85%. the idle cpu searching will continue. But currently
I don't have better solution in mind to deal with it gracefully.

Link: https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/ #1
Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8054641c0a7b..ec0cc3fe5b0a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -81,6 +81,7 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	bool		overloaded;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..1a58befe892d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6273,6 +6273,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
+	struct sched_domain_shared *sd_share;
 	struct sched_domain *this_sd;
 	u64 time = 0;
 
@@ -6280,6 +6281,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!this_sd)
 		return -1;
 
+	sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
+	if (sd_share && READ_ONCE(sd_share->overloaded))
+		return -1;
+
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
@@ -9212,6 +9217,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	int sg_status = 0;
+	unsigned long sum_util = 0;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -9242,6 +9248,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
+		sum_util += sgs->group_util;
 
 		sg = sg->next;
 	} while (sg != env->sd->groups);
@@ -9268,6 +9275,29 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
 		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
 	}
+
+	/*
+	 * Check if the LLC domain is overloaded. The overload hint
+	 * could be used to skip the LLC domain idle cpu search in
+	 * select_idle_cpu(). The update of this hint occurs during
+	 * periodic load balancing, rather than frequent newidle balance.
+	 */
+	if (env->idle != CPU_NEWLY_IDLE &&
+	    env->sd->span_weight == per_cpu(sd_llc_size, env->dst_cpu)) {
+		struct sched_domain_shared *sd_share =
+			rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
+
+		if (!sd_share)
+			return;
+
+		/*
+		 * Derived from group_is_overloaded(). The default imbalance_pct
+		 * is 117 on LLC domain, which means the threshold of average
+		 * utilization is 85%.
+		 */
+		WRITE_ONCE(sd_share->overloaded, (sds->total_capacity * 100) <
+			   (sum_util * env->sd->imbalance_pct));
+	}
 }
 
 #define NUMA_IMBALANCE_MIN 2
-- 
2.25.1

