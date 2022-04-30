Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B919515B93
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiD3Iyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiD3Iy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:54:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96139F1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651308661; x=1682844661;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3epEshL7uwvfQf7UTfOkfy8C1g/O5q6aP9F6/f8GT/8=;
  b=ClGN7Y9NwGmvqFVtPyNI728xK35S5jjKOTSQOXDMvTd3PeGe8+8Ve5Ti
   BxtVPiZVVgvQlGtbwlUXFJekrhDbet6AqG5XuwUVJ2AVU9+139EGv2shY
   B2HxtNNOB+m0tCkOP5OY/e2ld+ql8cpsyiuRs4lvmeoG0UdcjMnEALV+9
   +DyJmvgk2JdZbZUZoB3rqnMcxDRNJ84Dt8yoPfCNAUUceSsyGqaq8TjHZ
   3cvSQLsEokDAQSyX2WyEgKlhTVi0J7rwdK05PaZtU3TALAlik2OFte2Ud
   dPAFu8/UXowYA4lhdHReWLXfud9kRKDsmxh0m9ak754IfLIfFTEdIRGo4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="247412694"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="yaml'?scan'208";a="247412694"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 01:51:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="yaml'?scan'208";a="560795642"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 01:50:56 -0700
Date:   Sat, 30 Apr 2022 16:50:49 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [net]  5aa32dd9bd:  netperf.Throughput_tps -23.5% regression
Message-ID: <20220430085049.GA24415@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -23.5% regression of netperf.Throughput_tps due to commit:


commit: 5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c ("net: add support for fast socket release")
https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock.2

in testcase: netperf
on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 50%
	cluster: cs-localhost
	test: SCTP_RR
	cpufreq_governor: performance
	ucode: 0xd000331

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -89.4% regression                                  |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
| test parameters  | cluster=cs-localhost                                                                |
|                  | cpufreq_governor=performance                                                        |
|                  | ip=ipv4                                                                             |
|                  | nr_threads=1                                                                        |
|                  | runtime=300s                                                                        |
|                  | send_size=10K                                                                       |
|                  | test=SCTP_STREAM_MANY                                                               |
|                  | ucode=0xd000331                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -86.8% regression                                  |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
| test parameters  | cluster=cs-localhost                                                                |
|                  | cpufreq_governor=performance                                                        |
|                  | ip=ipv4                                                                             |
|                  | nr_threads=25%                                                                      |
|                  | runtime=300s                                                                        |
|                  | send_size=10K                                                                       |
|                  | test=SCTP_STREAM_MANY                                                               |
|                  | ucode=0xd000331                                                                     |
+------------------+-------------------------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-11/performance/ipv4/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/300s/lkp-icl-2sp4/SCTP_RR/netperf/0xd000331

commit: 
  4033d677de ("Merge branch 'for-5.19/io_uring-socket' into sock-nolock.2")
  5aa32dd9bd ("net: add support for fast socket release")

4033d677de27560d 5aa32dd9bdb57e4a26143216df5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3433333           -23.5%    2626482 ±  2%  netperf.Throughput_total_tps
     53645           -23.5%      41038 ±  2%  netperf.Throughput_tps
     26529          +220.7%      85082 ±  2%  netperf.time.involuntary_context_switches
     20836           +15.6%      24085        netperf.time.minor_page_faults
      2728           -33.4%       1818 ±  3%  netperf.time.percent_of_cpu_this_job_got
      8062           -33.4%       5372 ±  3%  netperf.time.system_time
    261.11           -32.8%     175.44 ±  3%  netperf.time.user_time
  1.03e+09           -23.5%  7.879e+08 ±  2%  netperf.time.voluntary_context_switches
  1.03e+09           -23.5%  7.879e+08 ±  2%  netperf.workload
     18864           +42.3%      26841        uptime.idle
 1.414e+10           +57.9%  2.232e+10 ±  2%  cpuidle..time
 2.069e+09           -22.2%  1.609e+09 ±  2%  cpuidle..usage
     36.85           +20.0       56.90 ±  2%  mpstat.cpu.all.idle%
     20.45            -6.6       13.85 ±  3%  mpstat.cpu.all.soft%
     40.36           -13.0       27.40 ±  3%  mpstat.cpu.all.sys%
      1.60            -0.4        1.19 ±  2%  mpstat.cpu.all.usr%
     37.00           +53.6%      56.83 ±  2%  vmstat.cpu.id
  10728248           +30.2%   13968645        vmstat.memory.cache
     81.83           -33.8%      54.17 ±  3%  vmstat.procs.r
  13355055           -23.4%   10223620 ±  2%  vmstat.system.cs
    270894            -1.9%     265686        vmstat.system.in
      2570 ± 20%    +129.0%       5886 ± 37%  numa-meminfo.node0.Active
      2233 ± 13%    +157.1%       5741 ± 38%  numa-meminfo.node0.Active(anon)
    357686 ± 23%    +374.5%    1697374 ± 61%  numa-meminfo.node0.Inactive
    356300 ± 23%    +376.3%    1697227 ± 61%  numa-meminfo.node0.Inactive(anon)
     55002 ±155%   +2490.2%    1424655 ± 74%  numa-meminfo.node0.Shmem
    158899 ±  2%     -60.1%      63469 ±  5%  numa-meminfo.node1.Active
    158875 ±  2%     -60.2%      63227 ±  5%  numa-meminfo.node1.Active(anon)
    558.50 ± 13%    +157.2%       1436 ± 38%  numa-vmstat.node0.nr_active_anon
     89148 ± 23%    +376.9%     425139 ± 61%  numa-vmstat.node0.nr_inactive_anon
     13801 ±155%   +2486.8%     357010 ± 74%  numa-vmstat.node0.nr_shmem
    558.50 ± 13%    +157.2%       1436 ± 38%  numa-vmstat.node0.nr_zone_active_anon
     89148 ± 23%    +376.9%     425139 ± 61%  numa-vmstat.node0.nr_zone_inactive_anon
     39849 ±  2%     -60.2%      15855 ±  4%  numa-vmstat.node1.nr_active_anon
     39849 ±  2%     -60.2%      15855 ±  4%  numa-vmstat.node1.nr_zone_active_anon
    161692 ±  2%     -57.0%      69501 ±  3%  meminfo.Active
    161330 ±  3%     -57.2%      69113 ±  3%  meminfo.Active(anon)
  10573214           +30.3%   13781428        meminfo.Cached
   8859541 ±  2%     +36.1%   12057551 ±  2%  meminfo.Committed_AS
   8504943 ±  2%     +38.7%   11795316 ±  2%  meminfo.Inactive
   8503533 ±  2%     +38.7%   11793931 ±  2%  meminfo.Inactive(anon)
  12718214           +25.2%   15927055        meminfo.Memused
   8309280 ±  2%     +38.6%   11517491 ±  2%  meminfo.Shmem
  12745350           +25.2%   15956173        meminfo.max_used_kB
      2241           -30.4%       1560 ±  3%  turbostat.Avg_MHz
     69.91           -22.3       47.58 ±  3%  turbostat.Busy%
      3212            +2.3%       3287        turbostat.Bzy_MHz
 1.321e+09           -13.0%  1.149e+09        turbostat.C1
     20.90            -5.0       15.86 ±  2%  turbostat.C1%
 7.435e+08           -39.4%  4.508e+08 ±  4%  turbostat.C1E
     29.50 ±  2%     +69.9%      50.11 ±  7%  turbostat.CPU%c1
    149.34          -102.7       46.64 ± 16%  turbostat.PKG_%
   4171491           -22.1%    3248601 ±  2%  turbostat.POLL
      0.12            -0.0        0.08 ±  5%  turbostat.POLL%
    493.52            -2.6%     480.46        turbostat.PkgWatt
     46.41           +16.5%      54.05        turbostat.RAMWatt
     40372 ±  3%     -57.3%      17245 ±  3%  proc-vmstat.nr_active_anon
     88810            -2.6%      86525        proc-vmstat.nr_anon_pages
   2954748            -2.7%    2874535        proc-vmstat.nr_dirty_background_threshold
   5916722            -2.7%    5756100        proc-vmstat.nr_dirty_threshold
   2637514           +30.4%    3440467        proc-vmstat.nr_file_pages
  29744635            -2.7%   28941332        proc-vmstat.nr_free_pages
   2119986 ±  2%     +38.9%    2943612 ±  2%  proc-vmstat.nr_inactive_anon
   2071529 ±  2%     +38.8%    2874482 ±  2%  proc-vmstat.nr_shmem
     33158            +5.3%      34918        proc-vmstat.nr_slab_reclaimable
     40372 ±  3%     -57.3%      17245 ±  3%  proc-vmstat.nr_zone_active_anon
   2119986 ±  2%     +38.9%    2943612 ±  2%  proc-vmstat.nr_zone_inactive_anon
   6354131 ±  2%     +33.8%    8498909 ±  2%  proc-vmstat.numa_hit
   6243316 ±  2%     +34.4%    8388940 ±  2%  proc-vmstat.numa_local
     53928 ±  5%     -65.7%      18516 ±  2%  proc-vmstat.pgactivate
   6302302           +32.4%    8344162        proc-vmstat.pgalloc_normal
     75331            +6.8%      80462        proc-vmstat.pgreuse
    485653 ±  6%     -70.0%     145855 ± 16%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   4889101           -58.2%    2043999 ± 11%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1435112 ±  3%     -65.2%     499003 ± 13%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.61 ±  2%     -28.4%       0.43 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.58 ±  8%     -36.8%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      3.61 ±  9%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
    485653 ±  6%     -70.0%     145855 ± 16%  sched_debug.cfs_rq:/.max_vruntime.avg
   4889101           -58.2%    2043999 ± 11%  sched_debug.cfs_rq:/.max_vruntime.max
   1435112 ±  3%     -65.2%     499003 ± 13%  sched_debug.cfs_rq:/.max_vruntime.stddev
   4779886           -60.8%    1875015 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
   5195166 ±  2%     -59.2%    2121407 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
   4718128           -65.7%    1617047 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
     54838 ± 17%    +123.7%     122676 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.59 ±  3%     -27.2%       0.43 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
    170.67          +130.0%     392.53 ± 38%  sched_debug.cfs_rq:/.removed.load_avg.max
     89.36 ±  4%    +125.3%     201.32 ± 36%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     89.36 ±  4%    +125.3%     201.32 ± 36%  sched_debug.cfs_rq:/.removed.util_avg.max
    528.93           -27.5%     383.41 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      1181 ±  6%     -19.5%     950.95 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    142.14 ± 25%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    145.62 ±  5%     +77.3%     258.24 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1064 ±1490%  +22998.7%     245807 ± 23%  sched_debug.cfs_rq:/.spread0.avg
    -60742           -80.1%     -12113        sched_debug.cfs_rq:/.spread0.min
     54851 ± 17%    +123.6%     122647 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
    527.04           -27.3%     382.97 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1177 ±  7%     -19.3%     949.82 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    142.25 ± 25%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    145.27 ±  5%     +77.5%     257.90 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    317.21 ±  2%     -29.5%     223.78 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    946.06 ± 10%     -18.0%     775.41 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
    153421           +53.6%     235687 ±  4%  sched_debug.cpu.avg_idle.avg
    265800 ±  7%    +301.8%    1068044 ±  8%  sched_debug.cpu.avg_idle.max
      3500 ±  5%      -9.6%       3163 ±  3%  sched_debug.cpu.avg_idle.min
     34824 ±  6%    +545.9%     224936 ±  8%  sched_debug.cpu.avg_idle.stddev
    185175           -13.3%     160515 ±  6%  sched_debug.cpu.clock.avg
    185182           -13.3%     160520 ±  6%  sched_debug.cpu.clock.max
    185168           -13.3%     160509 ±  6%  sched_debug.cpu.clock.min
      3.72 ±  4%     -20.3%       2.96 ±  5%  sched_debug.cpu.clock.stddev
    571.80 ± 30%    +126.1%       1292 ±  9%  sched_debug.cpu.clock_task.stddev
      3426           -34.1%       2256 ±  4%  sched_debug.cpu.curr->pid.avg
      0.59 ±  2%     -33.4%       0.39 ±  5%  sched_debug.cpu.nr_running.avg
      1.56 ± 10%     -33.6%       1.03 ±  7%  sched_debug.cpu.nr_running.max
  16149103           -36.7%   10228798 ±  9%  sched_debug.cpu.nr_switches.avg
  16701556           -30.4%   11624015 ±  8%  sched_debug.cpu.nr_switches.max
  14782067 ±  2%     -43.0%    8430068 ± 10%  sched_debug.cpu.nr_switches.min
    351193 ±  9%    +136.9%     831814 ± 10%  sched_debug.cpu.nr_switches.stddev
    185169           -13.3%     160510 ±  6%  sched_debug.cpu_clk
    184449           -13.4%     159790 ±  6%  sched_debug.ktime
     10.22 ±  2%     +24.4%      12.71 ±  2%  perf-stat.i.MPKI
 4.027e+10           -24.3%  3.047e+10 ±  2%  perf-stat.i.branch-instructions
 4.187e+08           -25.8%  3.105e+08 ±  2%  perf-stat.i.branch-misses
      1.24 ± 12%      +6.7        7.92 ±  5%  perf-stat.i.cache-miss-rate%
  20998336 ± 11%    +557.9%  1.381e+08 ±  4%  perf-stat.i.cache-misses
 1.989e+09            -9.2%  1.805e+09        perf-stat.i.cache-references
  13504754           -23.5%   10324651 ±  2%  perf-stat.i.context-switches
      1.59            -5.7%       1.50        perf-stat.i.cpi
  3.15e+11           -30.1%  2.201e+11 ±  2%  perf-stat.i.cpu-cycles
     45199           -95.1%       2197 ±  3%  perf-stat.i.cpu-migrations
     19508 ± 25%     -90.9%       1767 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.04 ± 14%      +0.0        0.06 ± 11%  perf-stat.i.dTLB-load-miss-rate%
 5.827e+10           -24.7%   4.39e+10 ±  2%  perf-stat.i.dTLB-loads
 3.517e+10           -24.7%   2.65e+10 ±  2%  perf-stat.i.dTLB-stores
  2.03e+11           -24.5%  1.533e+11 ±  2%  perf-stat.i.instructions
      0.64            +8.2%       0.69        perf-stat.i.ipc
      2.46           -30.1%       1.72 ±  2%  perf-stat.i.metric.GHz
    220.84 ±  4%    +212.3%     689.61 ±  3%  perf-stat.i.metric.K/sec
      1060           -24.3%     802.22 ±  2%  perf-stat.i.metric.M/sec
     85.79            +6.8       92.57        perf-stat.i.node-load-miss-rate%
   6746106 ±  9%    +565.5%   44893575 ±  4%  perf-stat.i.node-load-misses
   1469235 ±  9%     +95.2%    2868455 ±  6%  perf-stat.i.node-loads
     63.12 ±  3%      +6.4       69.52        perf-stat.i.node-store-miss-rate%
   3224894 ±  8%    +535.6%   20495885 ±  4%  perf-stat.i.node-store-misses
   2375887 ±  7%    +276.1%    8935513 ±  4%  perf-stat.i.node-stores
      9.80           +20.2%      11.78        perf-stat.overall.MPKI
      1.04            -0.0        1.02        perf-stat.overall.branch-miss-rate%
      1.06 ± 11%      +6.6        7.65 ±  5%  perf-stat.overall.cache-miss-rate%
      1.55            -7.5%       1.44        perf-stat.overall.cpi
     15203 ± 12%     -89.5%       1596 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  3%      +0.0        0.02 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.64            +8.1%       0.70        perf-stat.overall.ipc
     82.03 ±  2%     +12.0       93.98        perf-stat.overall.node-load-miss-rate%
     57.54 ±  2%     +12.1       69.62        perf-stat.overall.node-store-miss-rate%
     60057            -1.1%      59408        perf-stat.overall.path-length
 4.014e+10           -24.3%  3.038e+10 ±  2%  perf-stat.ps.branch-instructions
 4.173e+08           -25.8%  3.095e+08 ±  2%  perf-stat.ps.branch-misses
  20930523 ± 11%    +557.8%  1.377e+08 ±  4%  perf-stat.ps.cache-misses
 1.982e+09            -9.2%  1.799e+09        perf-stat.ps.cache-references
  13459625           -23.5%   10290156 ±  2%  perf-stat.ps.context-switches
  3.14e+11           -30.1%  2.193e+11 ±  2%  perf-stat.ps.cpu-cycles
     45141           -95.1%       2190 ±  3%  perf-stat.ps.cpu-migrations
 5.808e+10           -24.7%  4.376e+10 ±  2%  perf-stat.ps.dTLB-loads
 3.505e+10           -24.7%  2.641e+10 ±  2%  perf-stat.ps.dTLB-stores
 2.023e+11           -24.5%  1.528e+11 ±  2%  perf-stat.ps.instructions
   6723213 ±  9%    +565.4%   44738975 ±  4%  perf-stat.ps.node-load-misses
   1463122 ±  9%     +95.4%    2859072 ±  6%  perf-stat.ps.node-loads
   3214426 ±  8%    +535.4%   20425091 ±  4%  perf-stat.ps.node-store-misses
   2369833 ±  7%    +275.9%    8907536 ±  4%  perf-stat.ps.node-stores
 6.186e+13           -24.3%  4.681e+13 ±  2%  perf-stat.total.instructions
     51.77            -4.7       47.02        perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.57            -4.6       47.94        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     49.67            -4.4       45.27        perf-profile.calltrace.cycles-pp.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     49.15            -4.3       44.80        perf-profile.calltrace.cycles-pp.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     48.34            -4.3       44.09        perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
     43.17            -3.7       39.49        perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
     42.04            -3.6       38.42        perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
     34.99            -3.5       31.47        perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
     30.32            -3.4       26.90        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
     29.73            -3.3       26.39        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
     28.05            -3.1       24.92        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit
     28.17            -3.1       25.04        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
     27.90            -3.1       24.78        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit
     26.60            -3.0       23.64        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
     26.90            -2.9       23.96        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
     26.68            -2.9       23.74        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
     25.86            -2.9       22.96        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
     26.87            -2.8       24.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.process_requests.spawn_child.accept_connection
     26.76            -2.8       24.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.process_requests.spawn_child
     26.63            -2.7       23.88        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.process_requests
     25.32            -2.7       22.60        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     25.22            -2.7       22.54        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     25.02            -2.6       22.44        perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     26.78            -2.1       24.66        perf-profile.calltrace.cycles-pp.sendmsg.main.__libc_start_main
     26.54            -2.1       24.43 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.main.__libc_start_main
     21.68            -2.1       19.59 ±  2%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     26.44            -2.1       24.35 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main.__libc_start_main
     23.76            -2.1       21.68        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
     15.78            -2.0       13.76        perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.56 ±  4%      -2.0        3.57 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      5.47 ±  4%      -2.0        3.48 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
     16.64            -2.0       14.66        perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     26.31            -2.0       24.33        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
     16.95            -2.0       14.97        perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     15.17            -1.9       13.25        perf-profile.calltrace.cycles-pp.inet_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     15.10            -1.9       13.20        perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     18.73            -1.9       16.85        perf-profile.calltrace.cycles-pp.recvmsg
     17.27            -1.8       15.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      5.87 ±  4%      -1.8        4.06 ±  2%  perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
     17.50            -1.8       15.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
      8.28 ±  2%      -1.7        6.54        perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
     22.16            -1.7       20.48        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
     18.42            -1.4       16.99 ±  2%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     17.64            -1.3       16.34 ±  2%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
      8.26 ±  2%      -1.0        7.29        perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm
      8.61 ±  2%      -1.0        7.65        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.06 ±  2%      -0.9        1.18 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.01 ±  2%      -0.9        1.13 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      6.98 ±  2%      -0.8        6.19        perf-profile.calltrace.cycles-pp.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack
      7.08 ±  2%      -0.8        6.30        perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      2.18            -0.7        1.46 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      5.32 ±  2%      -0.7        4.65        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.__sctp_write_space.sctp_wfree
      5.23 ±  2%      -0.6        4.59        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.__sctp_write_space
      4.06            -0.6        3.43 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      4.19            -0.6        3.56 ±  2%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      5.76 ±  2%      -0.6        5.14        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.__sctp_write_space.sctp_wfree.skb_release_head_state
     13.51            -0.6       12.92        perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      5.91 ±  2%      -0.6        5.33        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__sctp_write_space.sctp_wfree.skb_release_head_state.consume_skb
      2.63 ±  2%      -0.6        2.08        perf-profile.calltrace.cycles-pp.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      2.17 ±  2%      -0.5        1.64        perf-profile.calltrace.cycles-pp._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
      6.23 ±  2%      -0.5        5.75        perf-profile.calltrace.cycles-pp.__sctp_write_space.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put
      1.82            -0.4        1.38 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      2.29 ±  2%      -0.4        1.87 ±  2%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      4.10 ±  2%      -0.4        3.69        perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      1.57            -0.4        1.20 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.86 ±  3%      -0.3        1.52 ±  4%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      3.60 ±  2%      -0.3        3.26 ±  2%  perf-profile.calltrace.cycles-pp.sctp_packet_append_chunk.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      3.63 ±  2%      -0.3        3.30 ±  2%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.33            -0.3        1.05 ±  3%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      0.71            -0.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.kmem_cache_free.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      2.48            -0.2        2.25        perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.63            -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.update_rq_clock.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      2.18 ±  2%      -0.2        1.99        perf-profile.calltrace.cycles-pp.sctp_make_sack.sctp_packet_append_chunk.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush
      1.32            -0.2        1.16        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      1.54 ±  3%      -0.1        1.40 ±  2%  perf-profile.calltrace.cycles-pp.__sctp_rcv_lookup.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      1.22 ±  2%      -0.1        1.08 ±  4%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
      1.50 ±  3%      -0.1        1.36 ±  2%  perf-profile.calltrace.cycles-pp.sctp_addrs_lookup_transport.__sctp_rcv_lookup.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.78            -0.1        0.66 ±  3%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call
      1.27 ±  3%      -0.1        1.15 ±  3%  perf-profile.calltrace.cycles-pp.__rhashtable_lookup.sctp_addrs_lookup_transport.__sctp_rcv_lookup.sctp_rcv.ip_protocol_deliver_rcu
      0.67            -0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.88            -0.1        0.81 ±  3%  perf-profile.calltrace.cycles-pp.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.73 ±  2%      -0.0        0.69 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      0.81            +0.0        0.85 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      0.63            +0.0        0.67        perf-profile.calltrace.cycles-pp.prepare_to_wait_exclusive.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      0.60            +0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.sctp_inet_skb_msgname.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.56 ±  4%      +0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.dst_release.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_ulpevent_free
      0.69            +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg
      0.66            +0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      1.57            +0.1        1.64 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      1.54            +0.1        1.62 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      0.61 ±  4%      +0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg
      0.90 ±  2%      +0.1        1.00 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      1.14 ±  2%      +0.2        1.29        perf-profile.calltrace.cycles-pp.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.72 ±  2%      +0.2        1.95        perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.83 ±  2%      +0.4        2.20 ±  3%  perf-profile.calltrace.cycles-pp.sctp_outq_select_transport.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      0.96 ± 20%      +0.4        1.34 ±  2%  perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      0.08 ±223%      +0.5        0.56        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_exclusive.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      0.00            +1.0        0.96 ± 12%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      2.12            +1.0        3.12 ±  3%  perf-profile.calltrace.cycles-pp.sctp_check_transmitted.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.00            +1.2        1.18 ± 32%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +1.4        1.35 ± 31%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.08 ±223%      +1.4        1.44 ±  2%  perf-profile.calltrace.cycles-pp.sctp_packet_config.sctp_outq_select_transport.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      0.00            +1.4        1.44 ± 12%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     15.63            +4.5       20.17 ±  2%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     15.89            +4.6       20.48 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     16.90            +6.1       22.97 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     16.97            +6.2       23.18 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     19.28            +6.3       25.55 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     24.93            +7.0       31.98 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     25.02            +7.1       32.07 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
     25.26            +7.1       32.37 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     71.34            -6.8       64.49        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.91            -6.8       64.09        perf-profile.children.cycles-pp.do_syscall_64
     54.38            -5.1       49.29        perf-profile.children.cycles-pp.sendmsg
     52.12            -5.0       47.12        perf-profile.children.cycles-pp.____sys_sendmsg
     53.30            -5.0       48.31        perf-profile.children.cycles-pp.__sys_sendmsg
     52.93            -4.9       48.05        perf-profile.children.cycles-pp.___sys_sendmsg
     50.00            -4.6       45.36        perf-profile.children.cycles-pp.sock_sendmsg
     49.80            -4.6       45.19        perf-profile.children.cycles-pp.sctp_sendmsg
     48.69            -4.5       44.21        perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
     43.46            -3.8       39.65        perf-profile.children.cycles-pp.sctp_primitive_SEND
     43.31            -3.8       39.54        perf-profile.children.cycles-pp.sctp_do_sm
     42.46            -3.8       38.70        perf-profile.children.cycles-pp.sctp_outq_flush
     43.13            -3.7       39.38        perf-profile.children.cycles-pp.sctp_cmd_interpreter
     35.24            -3.6       31.62        perf-profile.children.cycles-pp.sctp_packet_transmit
     30.53            -3.5       27.02        perf-profile.children.cycles-pp.__ip_queue_xmit
     29.94            -3.4       26.51        perf-profile.children.cycles-pp.ip_finish_output2
     28.50            -3.3       25.21        perf-profile.children.cycles-pp.__local_bh_enable_ip
     28.25            -3.2       25.02        perf-profile.children.cycles-pp.do_softirq
     28.19            -3.1       25.10        perf-profile.children.cycles-pp.__softirqentry_text_start
     26.78            -3.0       23.74        perf-profile.children.cycles-pp.process_backlog
     26.86            -3.0       23.85        perf-profile.children.cycles-pp.__napi_poll
     27.09            -3.0       24.10        perf-profile.children.cycles-pp.net_rx_action
     26.04            -3.0       23.07        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     27.54            -2.9       24.68        perf-profile.children.cycles-pp.accept_connection
     27.54            -2.9       24.68        perf-profile.children.cycles-pp.spawn_child
     27.54            -2.9       24.68        perf-profile.children.cycles-pp.process_requests
     25.50            -2.8       22.70        perf-profile.children.cycles-pp.ip_local_deliver_finish
     25.39            -2.8       22.64        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     25.23            -2.7       22.56        perf-profile.children.cycles-pp.sctp_rcv
      9.66 ±  2%      -2.6        7.02 ±  2%  perf-profile.children.cycles-pp.__schedule
     21.85            -2.2       19.69        perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
      3.77 ±  6%      -2.1        1.71 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
     15.79            -2.0       13.77        perf-profile.children.cycles-pp.____sys_recvmsg
     16.66            -2.0       14.68        perf-profile.children.cycles-pp.___sys_recvmsg
      5.56 ±  4%      -2.0        3.58 ±  3%  perf-profile.children.cycles-pp.schedule
     16.97            -2.0       14.99        perf-profile.children.cycles-pp.__sys_recvmsg
     15.46            -1.9       13.53        perf-profile.children.cycles-pp.sctp_recvmsg
     15.18            -1.9       13.26        perf-profile.children.cycles-pp.inet_recvmsg
     18.87            -1.9       16.98        perf-profile.children.cycles-pp.recvmsg
      5.89 ±  4%      -1.8        4.08 ±  2%  perf-profile.children.cycles-pp.schedule_timeout
      8.32 ±  2%      -1.7        6.59        perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      1.50 ± 16%      -1.3        0.17 ± 10%  perf-profile.children.cycles-pp.newidle_balance
      9.61            -1.1        8.54        perf-profile.children.cycles-pp.consume_skb
      7.16            -0.9        6.22        perf-profile.children.cycles-pp.sctp_wfree
      8.16            -0.9        7.25        perf-profile.children.cycles-pp.skb_release_head_state
     11.66            -0.9       10.76        perf-profile.children.cycles-pp.sctp_chunk_put
      5.47            -0.8        4.68        perf-profile.children.cycles-pp.autoremove_wake_function
     13.75            -0.8       13.00        perf-profile.children.cycles-pp.sctp_outq_sack
      5.91            -0.7        5.17        perf-profile.children.cycles-pp.__wake_up_common
      5.40            -0.7        4.65        perf-profile.children.cycles-pp.try_to_wake_up
      6.07            -0.7        5.36        perf-profile.children.cycles-pp.__wake_up_common_lock
      1.56            -0.7        0.86        perf-profile.children.cycles-pp.kmem_cache_alloc
      3.38            -0.7        2.69        perf-profile.children.cycles-pp._sctp_make_chunk
      1.61            -0.6        0.98        perf-profile.children.cycles-pp.sctp_chunkify
      4.24            -0.6        3.62        perf-profile.children.cycles-pp.schedule_idle
      6.40            -0.6        5.78        perf-profile.children.cycles-pp.__sctp_write_space
      2.71            -0.6        2.09        perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      0.73 ± 18%      -0.6        0.11 ± 17%  perf-profile.children.cycles-pp.load_balance
      0.61 ± 17%      -0.5        0.09 ± 12%  perf-profile.children.cycles-pp.find_busiest_group
      4.22            -0.5        3.72        perf-profile.children.cycles-pp.sctp_datamsg_from_user
      2.94            -0.5        2.45 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.56 ± 16%      -0.5        0.08 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.83            -0.4        1.40 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.17 ±  3%      -0.4        0.74 ±  5%  perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      1.61            -0.4        1.20        perf-profile.children.cycles-pp.enqueue_entity
      3.72            -0.4        3.32 ±  2%  perf-profile.children.cycles-pp.sctp_packet_transmit_chunk
      3.70            -0.4        3.30 ±  2%  perf-profile.children.cycles-pp.sctp_packet_append_chunk
      0.47 ± 18%      -0.4        0.07 ± 29%  perf-profile.children.cycles-pp.update_blocked_averages
      0.77            -0.4        0.37 ±  9%  perf-profile.children.cycles-pp.sock_kmalloc
      2.08            -0.4        1.68        perf-profile.children.cycles-pp.enqueue_task_fair
      0.46 ± 16%      -0.4        0.07 ±  8%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.93            -0.4        1.54 ±  4%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
      2.12            -0.4        1.74        perf-profile.children.cycles-pp.ttwu_do_activate
      1.62            -0.4        1.24 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      2.32            -0.3        1.98 ±  3%  perf-profile.children.cycles-pp.skb_release_data
      0.51 ±  9%      -0.3        0.17 ±  8%  perf-profile.children.cycles-pp.__skb_clone
      1.06 ±  2%      -0.3        0.73 ±  3%  perf-profile.children.cycles-pp.sctp_sf_eat_data_6_2
      3.00            -0.3        2.67 ±  3%  perf-profile.children.cycles-pp.kfree
      0.41 ± 11%      -0.3        0.09 ±  7%  perf-profile.children.cycles-pp.__copy_skb_header
      3.11            -0.3        2.82        perf-profile.children.cycles-pp.kmem_cache_free
      1.38            -0.3        1.10 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      1.09 ±  2%      -0.3        0.82 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.93 ±  2%      -0.3        0.67 ±  3%  perf-profile.children.cycles-pp.sctp_sf_do_no_pending_tsn
      0.91 ±  3%      -0.3        0.66 ±  3%  perf-profile.children.cycles-pp.sctp_ulpevent_make_sender_dry_event
      0.92            -0.3        0.67 ±  3%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.80            -0.3        0.55 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.54            -0.2        0.30 ± 11%  perf-profile.children.cycles-pp.resched_curr
      0.84            -0.2        0.60 ±  3%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      1.11            -0.2        0.88 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      2.24            -0.2        2.01        perf-profile.children.cycles-pp.sctp_make_sack
      2.61            -0.2        2.38        perf-profile.children.cycles-pp.sctp_ulpevent_free
      0.88            -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.sctp_addto_chunk
      0.45            -0.2        0.25 ±  4%  perf-profile.children.cycles-pp.skb_put
      1.16            -0.2        0.96 ±  3%  perf-profile.children.cycles-pp.sctp_make_control
      0.85            -0.2        0.65 ±  3%  perf-profile.children.cycles-pp.sctp_eat_data
      0.91 ±  2%      -0.2        0.72 ±  3%  perf-profile.children.cycles-pp.do_ulpq_tail_event
      0.55 ±  3%      -0.2        0.36 ± 18%  perf-profile.children.cycles-pp.enqueue_timer
      0.22 ±  4%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      1.58 ±  2%      -0.2        1.40 ±  2%  perf-profile.children.cycles-pp.__sctp_rcv_lookup
      1.55 ±  2%      -0.2        1.38 ±  3%  perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      1.27 ±  3%      -0.2        1.10 ±  4%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.60            -0.2        0.44 ±  8%  perf-profile.children.cycles-pp.check_preempt_curr
      0.64            -0.2        0.48 ±  7%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      3.48            -0.2        3.31        perf-profile.children.cycles-pp.__alloc_skb
      0.57            -0.2        0.41 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.69            -0.2        0.53 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.46            -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.pick_next_entity
      0.39            -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.70            -0.1        0.57 ±  2%  perf-profile.children.cycles-pp.__might_resched
      1.30 ±  3%      -0.1        1.17 ±  3%  perf-profile.children.cycles-pp.__rhashtable_lookup
      0.79            -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.52            -0.1        0.38 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.55            -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.80            -0.1        0.67 ±  3%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.30 ± 11%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.sctp_outq_tail
      0.35 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      1.46            -0.1        1.35        perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      1.12            -0.1        1.01 ±  2%  perf-profile.children.cycles-pp.kfree_skb_reason
      0.83            -0.1        0.72        perf-profile.children.cycles-pp.skb_set_owner_w
      0.27 ±  8%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.26 ±  2%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.ip_rcv
      0.75 ±  2%      -0.1        0.64 ±  3%  perf-profile.children.cycles-pp.sctp_queue_purge_ulpevents
      0.54            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.26            -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.41 ±  2%      -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.28            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      1.22            -0.1        1.13 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.53            -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.sctp_association_put
      0.36            -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      0.33 ±  3%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.release_sock
      0.18 ±  6%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.77            -0.1        0.68        perf-profile.children.cycles-pp.import_iovec
      0.68            -0.1        0.59 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      1.14            -0.1        1.05        perf-profile.children.cycles-pp._copy_from_user
      0.27 ± 11%      -0.1        0.18 ± 12%  perf-profile.children.cycles-pp.sctp_v4_xmit
      0.74            -0.1        0.66        perf-profile.children.cycles-pp.__import_iovec
      0.17 ±  5%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.sctp_cmp_addr_exact
      0.36            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.35            -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.50            -0.1        0.43 ±  3%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.32 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.30 ±  2%      -0.1        0.23        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.56            -0.1        0.49 ±  3%  perf-profile.children.cycles-pp.sctp_sf_eat_sack_6_2
      0.70            -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.63            -0.1        0.57 ±  2%  perf-profile.children.cycles-pp.iovec_from_user
      0.11 ±  9%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.sctp_validate_data
      0.44            -0.1        0.39 ±  5%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.60            -0.1        0.54        perf-profile.children.cycles-pp.memset_erms
      0.39 ±  4%      -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.74 ±  2%      -0.0        0.69        perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.28 ±  3%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.recv_sctp_rr
      0.39 ±  2%      -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.15 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.27 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.send_sctp_rr
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ip_output
      0.30 ±  5%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.sctp_chunk_hold
      0.19 ± 10%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.sctp_datamsg_put
      0.16 ±  5%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.update_cfs_group
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.perf_tp_event
      0.17 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.08 ±  6%      -0.0        0.04 ± 47%  perf-profile.children.cycles-pp.sctp_sm_lookup_event
      0.24 ±  2%      -0.0        0.22 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.skb_dequeue
      0.17 ±  6%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.sctp_ulpevent_init
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.update_min_vruntime
      0.24            -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__sctp_packet_append_chunk
      0.10 ±  5%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.09 ±  5%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.kmalloc_slab
      0.23 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.09 ±  9%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__ip_finish_output
      0.09 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.should_failslab
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.check_stack_object
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__update_idle_core
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.24 ±  2%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.11 ±  3%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sctp_bind_addr_match
      0.18 ±  2%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.memcpy_erms
      0.17 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.copyin
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sctp_ulpq_order
      0.10 ±  9%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ip_rcv_core
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.perf_trace_buf_update
      0.11            -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__build_skb_around
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sctp_sock_rfree
      0.32            +0.0        0.35 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.call_cpuidle
      0.14 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.sock_wfree
      0.11 ±  4%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.rcu_dynticks_inc
      0.82            +0.0        0.86 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      0.30 ±  3%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp._copy_from_iter
      0.08 ±  5%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.rebalance_domains
      0.64            +0.0        0.68        perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      1.55            +0.0        1.59        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.60            +0.0        0.65 ±  2%  perf-profile.children.cycles-pp.sctp_inet_skb_msgname
      0.69            +0.1        0.74 ±  2%  perf-profile.children.cycles-pp.copyout
      0.44 ±  2%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.77            +0.1        0.83 ±  3%  perf-profile.children.cycles-pp.select_task_rq
      1.59            +0.1        1.66        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.sctp_v4_ecn_capable
      0.00            +0.1        0.07 ± 33%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.14 ±  7%      +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.14 ± 14%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.rcu_eqs_exit
      1.58            +0.1        1.65 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.lapic_next_deadline
      1.55            +0.1        1.62 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.52            +0.1        0.59 ±  4%  perf-profile.children.cycles-pp.sctp_data_ready
      0.38            +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.23 ±  2%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.sctp_association_hold
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.llist_add_batch
      0.00            +0.1        0.09 ± 40%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.07 ±  6%      +0.1        0.17 ± 32%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.36            +0.1        0.46 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.31 ±  5%      +0.1        0.41 ±  7%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.26 ±  3%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.27 ±  3%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.wake_affine
      0.69            +0.1        0.81        perf-profile.children.cycles-pp.sendmsg_copy_msghdr
      0.61            +0.1        0.74 ±  2%  perf-profile.children.cycles-pp.sctp_transport_hold
      0.00            +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.sctp_auth_send_cid
      0.00            +0.1        0.15 ± 32%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.30 ±  7%      +0.2        0.45 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.57            +0.2        0.73 ±  2%  perf-profile.children.cycles-pp.__copy_msghdr_from_user
      0.12 ±  6%      +0.2        0.28 ± 20%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.13 ±  3%      +0.2        0.30 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.08            +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.switch_fpu_return
      0.48            +0.2        0.66        perf-profile.children.cycles-pp.sctp_chunk_abandoned
      0.70            +0.2        0.88 ±  5%  perf-profile.children.cycles-pp.ktime_get
      0.10 ±  4%      +0.2        0.30 ± 39%  perf-profile.children.cycles-pp.update_process_times
      1.80            +0.2        1.99        perf-profile.children.cycles-pp.sctp_packet_pack
      0.32            +0.2        0.52 ±  6%  perf-profile.children.cycles-pp.sctp_transport_put
      0.00            +0.2        0.21 ± 11%  perf-profile.children.cycles-pp.llist_reverse_order
      0.11 ±  6%      +0.2        0.32 ± 43%  perf-profile.children.cycles-pp.tick_sched_handle
      0.14 ±  3%      +0.2        0.38 ± 37%  perf-profile.children.cycles-pp.tick_sched_timer
      0.22 ± 10%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.15 ±  3%      +0.3        0.42 ±  6%  perf-profile.children.cycles-pp.sctp_tsnmap_check
      1.10            +0.3        1.39 ±  4%  perf-profile.children.cycles-pp.del_timer
      0.85            +0.3        1.16 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.3        0.32 ± 13%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.89            +0.3        2.22 ±  2%  perf-profile.children.cycles-pp.sctp_outq_select_transport
      0.00            +0.3        0.34 ± 13%  perf-profile.children.cycles-pp.send_call_function_single_ipi
      1.13            +0.4        1.51 ±  2%  perf-profile.children.cycles-pp.__ksize
      0.17 ±  2%      +0.4        0.56 ± 40%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.30 ±  4%      +0.5        1.76        perf-profile.children.cycles-pp.lock_timer_base
      0.98 ±  2%      +0.5        1.45 ±  2%  perf-profile.children.cycles-pp.sctp_packet_config
      0.07 ± 10%      +0.5        0.54 ± 12%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.36 ±  4%      +0.5        0.89 ± 29%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.36 ±  4%      +0.6        0.91 ± 31%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.13 ±  2%      +0.7        2.87        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.54 ±  3%      +0.9        1.48 ± 26%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.21            +1.0        3.17 ±  3%  perf-profile.children.cycles-pp.sctp_check_transmitted
      0.00            +1.0        0.98 ± 12%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.72 ±  3%      +1.1        1.87 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +1.5        1.46 ± 12%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
     15.91            +4.6       20.52 ±  2%  perf-profile.children.cycles-pp.mwait_idle_with_hints
     16.04            +4.6       20.67 ±  2%  perf-profile.children.cycles-pp.intel_idle
     17.13            +6.3       23.38 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     17.08            +6.3       23.34 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     19.48            +6.3       25.80 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
     25.20            +7.1       32.30 ±  2%  perf-profile.children.cycles-pp.do_idle
     25.26            +7.1       32.37 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     25.26            +7.1       32.37 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      2.90            -0.5        2.42 ±  2%  perf-profile.self.cycles-pp.__slab_free
      1.51            -0.5        1.04 ±  2%  perf-profile.self.cycles-pp.sctp_outq_sack
      1.01            -0.4        0.56        perf-profile.self.cycles-pp.enqueue_entity
      0.55            -0.4        0.16 ±  4%  perf-profile.self.cycles-pp.sctp_eat_data
      0.50            -0.4        0.14 ± 14%  perf-profile.self.cycles-pp.sock_kmalloc
      0.69 ±  2%      -0.3        0.37 ±  4%  perf-profile.self.cycles-pp.sctp_wfree
      0.36 ± 17%      -0.3        0.04 ± 45%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.40 ± 12%      -0.3        0.09 ±  7%  perf-profile.self.cycles-pp.__copy_skb_header
      0.69            -0.3        0.42        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.70            -0.3        0.44 ±  3%  perf-profile.self.cycles-pp.sctp_packet_transmit
      0.54            -0.2        0.30 ± 11%  perf-profile.self.cycles-pp.resched_curr
      1.06            -0.2        0.83 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.99            -0.2        0.77 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.41            -0.2        0.21 ±  7%  perf-profile.self.cycles-pp.skb_put
      0.90 ±  2%      -0.2        0.72 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.54 ±  3%      -0.2        0.36 ± 19%  perf-profile.self.cycles-pp.enqueue_timer
      0.21 ±  3%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.49            -0.2        0.32 ±  3%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.35 ±  9%      -0.2        0.20 ± 19%  perf-profile.self.cycles-pp.__rhashtable_lookup
      1.19            -0.2        1.04 ±  5%  perf-profile.self.cycles-pp.kfree
      0.62            -0.1        0.47 ±  2%  perf-profile.self.cycles-pp.sctp_rcv
      0.38            -0.1        0.24 ±  6%  perf-profile.self.cycles-pp.sctp_chunkify
      0.38            -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.process_backlog
      0.27 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.lock_timer_base
      0.45            -0.1        0.31 ±  5%  perf-profile.self.cycles-pp.pick_next_entity
      0.51 ±  3%      -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.sctp_sendmsg_to_asoc
      0.25            -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.sctp_packet_append_chunk
      0.51            -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.21 ±  7%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.sctp_sf_eat_data_6_2
      0.64            -0.1        0.52 ±  3%  perf-profile.self.cycles-pp.__might_resched
      0.89            -0.1        0.76 ±  4%  perf-profile.self.cycles-pp.sctp_outq_select_transport
      0.22 ±  7%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.newidle_balance
      0.46 ±  2%      -0.1        0.34 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.64            -0.1        0.53 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.24 ± 14%      -0.1        0.12 ± 14%  perf-profile.self.cycles-pp.sctp_outq_tail
      0.44 ±  2%      -0.1        0.33 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.82            -0.1        0.71        perf-profile.self.cycles-pp.skb_set_owner_w
      0.33            -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.sctp_assoc_bh_rcv
      0.30 ±  4%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.50            -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.52            -0.1        0.42 ±  4%  perf-profile.self.cycles-pp.sctp_association_put
      0.34 ±  2%      -0.1        0.25 ±  5%  perf-profile.self.cycles-pp.skb_release_data
      0.18 ±  6%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.14 ±  6%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.26 ± 11%      -0.1        0.18 ± 13%  perf-profile.self.cycles-pp.sctp_v4_xmit
      0.31 ±  2%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.50            -0.1        0.42 ±  4%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.16 ±  3%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.sctp_cmp_addr_exact
      0.16 ±  7%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.24 ±  2%      -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.32 ±  2%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.30            -0.1        0.23 ±  5%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.49            -0.1        0.42 ±  3%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.22 ±  4%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.sctp_ulpevent_make_sender_dry_event
      0.31 ±  2%      -0.1        0.25 ±  4%  perf-profile.self.cycles-pp.__fget_light
      0.10 ±  4%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.54            -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.sctp_sf_eat_sack_6_2
      0.16 ±  3%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.sctp_ulpq_tail_event
      0.34 ±  2%      -0.1        0.28 ±  5%  perf-profile.self.cycles-pp.sctp_do_sm
      0.19 ±  2%      -0.1        0.13        perf-profile.self.cycles-pp.dequeue_task_fair
      0.38 ±  4%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.26 ±  2%      -0.1        0.20        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.44 ±  2%      -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.23 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.38 ±  2%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.70 ±  2%      -0.0        0.65 ±  2%  perf-profile.self.cycles-pp.memcg_slab_free_hook
      1.22            -0.0        1.18        perf-profile.self.cycles-pp.update_rq_clock
      0.27 ±  3%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.recv_sctp_rr
      0.56            -0.0        0.52        perf-profile.self.cycles-pp.memset_erms
      0.15 ±  7%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.26            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.send_sctp_rr
      0.14 ±  3%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.sctp_sm_lookup_event
      0.30 ±  4%      -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.sctp_chunk_hold
      0.17 ± 10%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.sctp_datamsg_put
      0.27 ±  4%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.ip_finish_output2
      0.14 ±  2%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.21            -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.sendmsg
      0.18 ±  2%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.08 ±  6%      -0.0        0.04 ± 72%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.14 ±  3%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.sctp_primitive_SEND
      0.26 ±  5%      -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.sctp_outq_flush
      0.18 ±  2%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp._copy_from_user
      0.16 ±  2%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.09 ±  7%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.sctp_bind_addr_match
      0.22            -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.dequeue_entity
      0.12 ±  4%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.sctp_hash_cmp
      0.08 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.perf_tp_event
      0.15 ±  7%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.12 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.10 ±  6%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__skb_clone
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.09            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.update_min_vruntime
      0.32            -0.0        0.30 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.24 ±  2%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.loopback_xmit
      0.24            -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.11 ±  5%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__import_iovec
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.11 ±  6%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.kmalloc_slab
      0.07 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.check_stack_object
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.kmalloc_reserve
      0.07            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__update_idle_core
      0.12 ±  4%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ±  9%      -0.0        0.08        perf-profile.self.cycles-pp.ip_rcv_core
      0.09            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__put_user_nocheck_8
      0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sctp_sock_rfree
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.sctp_packet_pack
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.___sys_sendmsg
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.lock_sock_nested
      0.09            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__build_skb_around
      0.08            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp._copy_to_iter
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.schedule_idle
      0.06            +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.09 ±  4%      +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.poll_idle
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.call_cpuidle
      0.07 ±  9%      +0.0        0.10 ± 14%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.25 ±  3%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.32            +0.0        0.35 ±  3%  perf-profile.self.cycles-pp.do_idle
      0.14 ±  2%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.skb_release_head_state
      0.14 ±  2%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.sock_wfree
      0.16 ±  3%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.13 ±  2%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.____sys_recvmsg
      0.10            +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.rcu_dynticks_inc
      0.45            +0.0        0.48 ±  2%  perf-profile.self.cycles-pp.__wake_up_common
      0.02 ±141%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.06 ±  7%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.07 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp._copy_from_iter
      0.55            +0.0        0.59 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
      1.51            +0.0        1.56        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.20            +0.0        0.24 ±  3%  perf-profile.self.cycles-pp._sctp_make_chunk
      0.60            +0.0        0.64 ±  2%  perf-profile.self.cycles-pp.sctp_inet_skb_msgname
      0.21 ±  2%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.net_rx_action
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.sctp_v4_ecn_capable
      0.60            +0.1        0.66        perf-profile.self.cycles-pp.sctp_make_sack
      1.24            +0.1        1.31 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.77            +0.1        0.84 ±  2%  perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.51            +0.1        0.58 ±  4%  perf-profile.self.cycles-pp.sctp_data_ready
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.07 ±  5%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.check_preempt_curr
      0.17 ±  2%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.sctp_outq_flush_data
      0.37            +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.read_tsc
      0.22            +0.1        0.30 ±  5%  perf-profile.self.cycles-pp.sctp_association_hold
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.1        0.08 ± 42%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.23 ±  4%      +0.1        0.31 ±  6%  perf-profile.self.cycles-pp.consume_skb
      0.26 ±  4%      +0.1        0.35 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.16 ±  3%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.___sys_recvmsg
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.72            +0.1        0.82        perf-profile.self.cycles-pp.sctp_datamsg_from_user
      0.36 ±  2%      +0.1        0.46 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.33 ±  4%      +0.1        0.44 ± 10%  perf-profile.self.cycles-pp.ktime_get
      0.30 ±  3%      +0.1        0.41 ±  5%  perf-profile.self.cycles-pp.__sctp_write_space
      0.00            +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.98            +0.1        1.09 ±  2%  perf-profile.self.cycles-pp.sctp_recvmsg
      0.93            +0.1        1.05 ±  3%  perf-profile.self.cycles-pp.__schedule
      1.15            +0.1        1.27 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.07 ±  6%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.release_sock
      1.02            +0.1        1.15 ±  2%  perf-profile.self.cycles-pp.sctp_cmd_interpreter
      0.60 ±  2%      +0.1        0.74 ±  2%  perf-profile.self.cycles-pp.sctp_transport_hold
      0.59            +0.2        0.75 ±  3%  perf-profile.self.cycles-pp.sctp_chunk_put
      0.00            +0.2        0.16 ± 13%  perf-profile.self.cycles-pp.flush_smp_call_function_from_idle
      0.48            +0.2        0.65        perf-profile.self.cycles-pp.sctp_chunk_abandoned
      0.08 ±  6%      +0.2        0.25 ±  5%  perf-profile.self.cycles-pp.switch_fpu_return
      0.32 ±  3%      +0.2        0.51 ±  5%  perf-profile.self.cycles-pp.schedule_timeout
      0.11 ±  4%      +0.2        0.30 ±  5%  perf-profile.self.cycles-pp.__copy_msghdr_from_user
      0.32            +0.2        0.51 ±  6%  perf-profile.self.cycles-pp.sctp_transport_put
      0.00            +0.2        0.21 ± 11%  perf-profile.self.cycles-pp.llist_reverse_order
      0.74            +0.2        0.95 ±  2%  perf-profile.self.cycles-pp.sctp_packet_config
      0.30            +0.2        0.52 ± 11%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.21 ±  9%      +0.2        0.46 ±  2%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.15 ±  3%      +0.3        0.42 ±  6%  perf-profile.self.cycles-pp.sctp_tsnmap_check
      0.48 ±  2%      +0.3        0.78 ±  2%  perf-profile.self.cycles-pp.sctp_check_transmitted
      0.82 ±  2%      +0.3        1.13 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.3        0.34 ± 14%  perf-profile.self.cycles-pp.send_call_function_single_ipi
      1.12            +0.4        1.50        perf-profile.self.cycles-pp.__ksize
      2.08 ±  2%      +0.8        2.84        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
     15.73            +4.7       20.40 ±  2%  perf-profile.self.cycles-pp.mwait_idle_with_hints


***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-11/performance/ipv4/x86_64-rhel-8.3/1/debian-10.4-x86_64-20200603.cgz/300s/10K/lkp-icl-2sp4/SCTP_STREAM_MANY/netperf/0xd000331

commit: 
  4033d677de ("Merge branch 'for-5.19/io_uring-socket' into sock-nolock.2")
  5aa32dd9bd ("net: add support for fast socket release")

4033d677de27560d 5aa32dd9bdb57e4a26143216df5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     26120 ±  3%     -89.4%       2765 ± 43%  netperf.Throughput_Mbps
     26120 ±  3%     -89.4%       2765 ± 43%  netperf.Throughput_total_Mbps
     68.00 ±  3%     -90.2%       6.67 ± 45%  netperf.time.percent_of_cpu_this_job_got
    200.48 ±  3%     -89.4%      21.27 ± 43%  netperf.time.system_time
  95657220 ±  3%     -89.4%   10129003 ± 43%  netperf.workload
 1.037e+08           -29.8%   72801990 ± 17%  cpuidle..usage
      1.00          -100.0%       0.00        vmstat.procs.r
    181178 ±  3%     -88.7%      20405 ± 40%  vmstat.system.cs
      9846 ±  3%     -26.4%       7249 ±  4%  meminfo.Active
      9565 ±  3%     -25.7%       7108 ±  4%  meminfo.Active(anon)
     43557 ±  5%     -40.3%      26003        meminfo.Shmem
      0.26 ±  9%      -0.1        0.12 ± 39%  mpstat.cpu.all.soft%
      0.87 ±  3%      -0.8        0.11 ± 35%  mpstat.cpu.all.sys%
      0.05 ±  2%      -0.0        0.02 ±  8%  mpstat.cpu.all.usr%
      7848 ± 14%     -28.2%       5634 ± 17%  numa-meminfo.node1.Active
      7688 ± 12%     -27.0%       5610 ± 17%  numa-meminfo.node1.Active(anon)
     25304 ± 14%     -61.1%       9832 ± 33%  numa-meminfo.node1.Shmem
      1921 ± 13%     -26.9%       1403 ± 17%  numa-vmstat.node1.nr_active_anon
      6113 ± 17%     -60.0%       2446 ± 33%  numa-vmstat.node1.nr_shmem
      1921 ± 13%     -26.9%       1403 ± 17%  numa-vmstat.node1.nr_zone_active_anon
     91.17 ± 12%     -49.4%      46.17 ± 22%  turbostat.Avg_MHz
      1977 ±  3%     -47.4%       1040 ±  6%  turbostat.Bzy_MHz
  27146212 ±  3%     -88.7%    3079005 ± 41%  turbostat.C1
      0.19 ± 17%     -50.0%       0.10 ± 25%  turbostat.IPC
     64301 ±  3%     -71.0%      18646 ± 42%  turbostat.POLL
      2391 ±  3%     -25.7%       1775 ±  4%  proc-vmstat.nr_active_anon
     75563            -5.0%      71769        proc-vmstat.nr_inactive_anon
     10126            -7.4%       9372        proc-vmstat.nr_mapped
     10974 ±  5%     -40.7%       6505        proc-vmstat.nr_shmem
      2391 ±  3%     -25.7%       1775 ±  4%  proc-vmstat.nr_zone_active_anon
     75563            -5.0%      71769        proc-vmstat.nr_zone_inactive_anon
 1.262e+08 ±  3%     -88.8%   14105228 ± 40%  proc-vmstat.numa_hit
 1.254e+08 ±  3%     -88.9%   13940984 ± 40%  proc-vmstat.numa_local
     41165 ± 27%     -72.1%      11505 ± 94%  proc-vmstat.numa_pte_updates
    185099 ± 11%     -97.0%       5540 ± 23%  proc-vmstat.pgactivate
 3.291e+08 ±  3%     -89.1%   35736732 ± 42%  proc-vmstat.pgalloc_normal
   1082855            -1.6%    1065851        proc-vmstat.pgfault
 3.291e+08 ±  3%     -89.1%   35774585 ± 42%  proc-vmstat.pgfree
      0.09 ± 19%     -33.5%       0.06 ± 14%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.27 ±  7%     -18.2%       0.22 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
    339173 ± 16%    +101.0%     681903 ± 17%  sched_debug.cfs_rq:/.load.max
     72238 ± 14%     +48.3%     107141 ± 11%  sched_debug.cfs_rq:/.load.stddev
    637.81 ±  9%     +56.9%       1000 ± 30%  sched_debug.cfs_rq:/.load_avg.max
     12493 ± 20%     -26.6%       9173 ± 19%  sched_debug.cfs_rq:/.min_vruntime.avg
     55491 ± 16%     -50.9%      27233 ± 24%  sched_debug.cfs_rq:/.min_vruntime.max
      9118 ± 12%     -55.2%       4080 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.09 ± 19%     -33.3%       0.06 ± 14%  sched_debug.cfs_rq:/.nr_running.avg
      0.26 ±  7%     -17.7%       0.22 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
     94.00 ± 10%     -31.0%      64.83 ± 14%  sched_debug.cfs_rq:/.runnable_avg.avg
      1011 ±  4%     -34.3%     664.78 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    203.48 ±  5%     -37.2%     127.70 ± 13%  sched_debug.cfs_rq:/.runnable_avg.stddev
     28619 ± 49%     -87.4%       3612 ±109%  sched_debug.cfs_rq:/.spread0.max
      9119 ± 12%     -55.2%       4082 ± 17%  sched_debug.cfs_rq:/.spread0.stddev
     93.77 ± 10%     -31.0%      64.68 ± 14%  sched_debug.cfs_rq:/.util_avg.avg
      1009 ±  4%     -34.2%     664.03 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    203.16 ±  5%     -37.2%     127.54 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
     29.56 ± 25%     -77.9%       6.53 ± 37%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    901.92 ± 11%     -74.2%     232.78 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.max
    139.45 ± 11%     -76.0%      33.42 ± 27%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      7123 ±124%   +2073.3%     154810 ± 70%  sched_debug.cpu.avg_idle.min
    145981 ±  4%     -20.7%     115693 ± 12%  sched_debug.cpu.avg_idle.stddev
      1171 ± 16%     -54.3%     535.47 ± 26%  sched_debug.cpu.clock_task.stddev
    210.71 ±  9%     -19.0%     170.71 ±  7%  sched_debug.cpu.curr->pid.avg
      1207 ±  3%     -10.3%       1083 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.19 ±  5%     -15.8%       0.16 ±  3%  sched_debug.cpu.nr_running.stddev
    215273 ±  3%     -87.3%      27274 ± 38%  sched_debug.cpu.nr_switches.avg
   5835932 ± 20%     -78.6%    1247699 ± 30%  sched_debug.cpu.nr_switches.max
    806025 ± 15%     -82.6%     139959 ± 29%  sched_debug.cpu.nr_switches.stddev
 1.301e+09 ±  2%     -75.2%  3.222e+08 ±  8%  perf-stat.i.branch-instructions
      0.20 ± 31%      +1.2        1.40 ± 84%  perf-stat.i.cache-miss-rate%
    363891 ±  7%     -26.6%     267229 ±  4%  perf-stat.i.cache-misses
  2.12e+08 ± 21%     -66.3%   71465630 ± 76%  perf-stat.i.cache-references
    182433 ±  3%     -88.8%      20505 ± 40%  perf-stat.i.context-switches
      1.78 ± 12%     +90.9%       3.40 ± 23%  perf-stat.i.cpi
 1.146e+10 ± 10%     -58.5%  4.754e+09 ± 19%  perf-stat.i.cpu-cycles
     47305 ± 10%     -56.1%      20788 ± 14%  perf-stat.i.cycles-between-cache-misses
 1.864e+09 ±  2%     -76.2%  4.436e+08 ±  9%  perf-stat.i.dTLB-loads
 1.085e+09 ±  2%     -77.4%  2.447e+08 ± 10%  perf-stat.i.dTLB-stores
 6.539e+09 ±  2%     -75.5%  1.605e+09 ±  8%  perf-stat.i.instructions
      0.58 ± 13%     -42.8%       0.33 ± 20%  perf-stat.i.ipc
      0.94 ±  5%     +27.4%       1.20 ±  9%  perf-stat.i.major-faults
      0.09 ± 10%     -58.6%       0.04 ± 19%  perf-stat.i.metric.GHz
     62.43 ±134%    +580.9%     425.09 ± 69%  perf-stat.i.metric.K/sec
     34.80           -76.9%       8.03 ±  9%  perf-stat.i.metric.M/sec
      3213            -2.1%       3144        perf-stat.i.minor-faults
     18739 ± 12%     -45.6%      10195 ±  6%  perf-stat.i.node-loads
     65638 ± 14%     -26.4%      48301 ± 11%  perf-stat.i.node-stores
      3214            -2.1%       3145        perf-stat.i.page-faults
      0.18 ± 27%      +0.7        0.86 ± 74%  perf-stat.overall.cache-miss-rate%
      1.76 ± 12%     +70.4%       3.00 ± 23%  perf-stat.overall.cpi
     31731 ± 13%     -44.2%      17693 ± 15%  perf-stat.overall.cycles-between-cache-misses
      0.58 ± 13%     -39.3%       0.35 ± 20%  perf-stat.overall.ipc
     76.18 ±  3%      +8.2       84.36        perf-stat.overall.node-load-miss-rate%
     20575          +163.9%      54303 ± 29%  perf-stat.overall.path-length
 1.296e+09 ±  2%     -75.2%  3.211e+08 ±  8%  perf-stat.ps.branch-instructions
    362514 ±  7%     -26.5%     266277 ±  4%  perf-stat.ps.cache-misses
 2.113e+08 ± 21%     -66.3%   71226434 ± 76%  perf-stat.ps.cache-references
    181839 ±  3%     -88.8%      20437 ± 40%  perf-stat.ps.context-switches
 1.143e+10 ± 10%     -58.5%  4.738e+09 ± 19%  perf-stat.ps.cpu-cycles
 1.857e+09 ±  2%     -76.2%  4.421e+08 ±  9%  perf-stat.ps.dTLB-loads
 1.081e+09 ±  2%     -77.4%  2.439e+08 ± 10%  perf-stat.ps.dTLB-stores
 6.517e+09 ±  2%     -75.5%  1.599e+09 ±  8%  perf-stat.ps.instructions
      0.94 ±  5%     +27.3%       1.19 ±  9%  perf-stat.ps.major-faults
      3200            -2.1%       3131        perf-stat.ps.minor-faults
     18658 ± 12%     -45.6%      10158 ±  6%  perf-stat.ps.node-loads
     65389 ± 14%     -26.4%      48115 ± 11%  perf-stat.ps.node-stores
      3201            -2.1%       3132        perf-stat.ps.page-faults
 1.968e+12 ±  2%     -75.3%  4.853e+11 ±  8%  perf-stat.total.instructions
     28.26 ± 22%     -23.2        5.06 ± 35%  perf-profile.calltrace.cycles-pp.__libc_start_main
     28.07 ± 22%     -23.2        4.90 ± 37%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
     27.53 ± 22%     -22.7        4.80 ± 37%  perf-profile.calltrace.cycles-pp.sendmsg.main.__libc_start_main
     27.16 ± 22%     -22.4        4.73 ± 37%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.main.__libc_start_main
     27.00 ± 22%     -22.3        4.70 ± 37%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main.__libc_start_main
     26.82 ± 22%     -22.2        4.66 ± 37%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
     26.63 ± 22%     -22.0        4.62 ± 37%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     25.53 ± 22%     -21.1        4.42 ± 37%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.53 ± 22%     -20.3        4.24 ± 38%  perf-profile.calltrace.cycles-pp.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     24.27 ± 22%     -20.1        4.19 ± 38%  perf-profile.calltrace.cycles-pp.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     13.89 ± 21%     -11.6        2.34 ± 39%  perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
     10.92 ±  5%      -8.4        2.54 ± 31%  perf-profile.calltrace.cycles-pp.recvmsg
     10.46 ±  5%      -8.0        2.42 ± 31%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
     10.37 ±  5%      -8.0        2.39 ± 31%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     10.24 ±  5%      -7.9        2.36 ± 31%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     10.10 ±  5%      -7.8        2.32 ± 31%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      9.45 ± 23%      -7.8        1.69 ± 37%  perf-profile.calltrace.cycles-pp.release_sock.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
      9.38 ± 23%      -7.7        1.68 ± 37%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      9.34 ± 23%      -7.7        1.68 ± 37%  perf-profile.calltrace.cycles-pp.sctp_backlog_rcv.__release_sock.release_sock.sctp_sendmsg.sock_sendmsg
      9.47 ±  5%      -7.3        2.18 ± 31%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.05 ±  5%      -7.0        2.09 ± 31%  perf-profile.calltrace.cycles-pp.inet_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
      9.01 ±  5%      -6.9        2.08 ± 31%  perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
      8.31 ± 21%      -6.9        1.40 ± 41%  perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      7.25 ± 21%      -6.1        1.20 ± 43%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
      7.03 ± 22%      -6.0        0.98 ± 86%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      7.29 ± 24%      -6.0        1.26 ± 37%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_backlog_rcv.__release_sock.release_sock.sctp_sendmsg
      7.30 ± 24%      -6.0        1.27 ± 36%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv.__release_sock
      6.92 ± 22%      -6.0        0.96 ± 86%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      7.14 ± 24%      -5.9        1.24 ± 36%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv.__release_sock.release_sock
      6.74 ± 22%      -5.8        0.95 ± 86%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
      6.70 ± 22%      -5.8        0.94 ± 86%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit
      6.66 ± 22%      -5.7        0.94 ± 86%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit
      6.50 ± 22%      -5.7        0.83 ±102%  perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
      6.44 ± 22%      -5.6        0.83 ±102%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
      6.42 ± 22%      -5.6        0.83 ±102%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
      6.30 ± 22%      -5.5        0.81 ±102%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
      6.69 ± 23%      -5.5        1.22 ± 37%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv
      6.54 ± 27%      -5.4        1.14 ± 37%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      6.09 ± 22%      -5.4        0.71 ±111%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      6.06 ± 22%      -5.4        0.71 ±110%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      5.99 ± 22%      -5.3        0.70 ±110%  perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      6.24 ± 22%      -5.2        1.05 ± 45%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      5.50 ± 21%      -4.8        0.74 ± 75%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
      5.36 ± 21%      -4.6        0.73 ± 75%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      5.07 ± 21%      -4.5        0.58 ±111%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      4.81 ± 23%      -4.4        0.41 ±118%  perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      5.08 ± 21%      -4.3        0.76 ± 55%  perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      4.74 ± 21%      -4.2        0.55 ±111%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      4.32 ± 21%      -3.9        0.44 ±116%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
      4.93 ±  5%      -3.8        1.13 ± 31%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      4.91 ±  5%      -3.8        1.13 ± 31%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      4.20 ±  5%      -3.3        0.90 ± 51%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      4.08 ±  5%      -3.2        0.87 ± 51%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg
      4.06 ±  5%      -3.2        0.87 ± 51%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.49 ± 70%      +0.5        0.95 ± 19%  perf-profile.calltrace.cycles-pp.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.28 ±100%      +0.5        0.76 ± 12%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call
      0.47 ± 70%      +0.6        1.08 ± 21%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.08 ±223%      +0.6        0.72 ± 23%  perf-profile.calltrace.cycles-pp.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +0.7        0.68 ± 13%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.09 ±223%      +0.7        0.77 ± 14%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu
      0.00            +0.7        0.71 ± 13%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start
      0.00            +0.7        0.74 ± 27%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.88 ± 17%      +0.8        1.66 ± 12%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.50 ± 45%      +0.8        1.31 ± 30%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.96 ± 13%      +0.8        1.78 ± 15%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.83 ± 19%      +1.0        1.85 ± 21%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.85 ± 51%      +1.2        2.02 ± 17%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.51 ± 18%      +1.2        2.72 ±  9%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.08 ±223%      +1.2        1.30 ± 28%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.90 ± 51%      +1.2        2.12 ± 17%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.51 ± 24%      +1.3        2.78 ± 19%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.93 ± 26%      +1.6        3.56 ± 17%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      7.52 ± 32%      +7.5       15.02 ± 20%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      7.82 ± 33%      +7.6       15.43 ± 21%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     35.11           +11.3       46.39 ± 13%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     11.67 ± 31%     +11.3       22.99 ± 19%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     35.38 ±  2%     +11.5       46.88 ± 13%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     14.93 ± 25%     +15.2       30.10 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     51.69 ±  9%     +27.4       79.13 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     52.49 ±  9%     +27.8       80.28 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     59.18 ± 10%     +30.3       89.51 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     59.30 ± 10%     +30.4       89.69 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
     59.70 ± 10%     +30.9       90.62 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     57.21 ± 10%     +31.0       88.18 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     37.96 ± 16%     -30.0        7.96 ± 32%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.73 ± 16%     -29.8        7.89 ± 32%  perf-profile.children.cycles-pp.do_syscall_64
     28.26 ± 22%     -23.2        5.06 ± 35%  perf-profile.children.cycles-pp.main
     28.26 ± 22%     -23.2        5.06 ± 35%  perf-profile.children.cycles-pp.__libc_start_main
     27.68 ± 22%     -22.8        4.83 ± 37%  perf-profile.children.cycles-pp.sendmsg
     26.83 ± 22%     -22.2        4.66 ± 37%  perf-profile.children.cycles-pp.__sys_sendmsg
     26.65 ± 22%     -22.0        4.62 ± 37%  perf-profile.children.cycles-pp.___sys_sendmsg
     25.54 ± 22%     -21.1        4.43 ± 37%  perf-profile.children.cycles-pp.____sys_sendmsg
     24.54 ± 22%     -20.3        4.24 ± 38%  perf-profile.children.cycles-pp.sock_sendmsg
     24.50 ± 22%     -20.3        4.24 ± 38%  perf-profile.children.cycles-pp.sctp_sendmsg
     17.28 ± 22%     -14.3        3.02 ± 39%  perf-profile.children.cycles-pp.sctp_do_sm
     17.15 ± 22%     -14.1        3.00 ± 39%  perf-profile.children.cycles-pp.sctp_cmd_interpreter
     14.68 ± 22%     -12.1        2.57 ± 39%  perf-profile.children.cycles-pp.sctp_outq_flush
     13.92 ± 21%     -11.6        2.35 ± 39%  perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
     13.02 ± 22%     -10.7        2.31 ± 40%  perf-profile.children.cycles-pp.sctp_packet_transmit
     12.39 ± 23%     -10.2        2.22 ± 38%  perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
     11.02 ±  5%      -8.5        2.56 ± 31%  perf-profile.children.cycles-pp.recvmsg
     10.25 ±  5%      -7.9        2.36 ± 31%  perf-profile.children.cycles-pp.__sys_recvmsg
      9.56 ± 23%      -7.8        1.72 ± 36%  perf-profile.children.cycles-pp.release_sock
     10.13 ±  5%      -7.8        2.33 ± 31%  perf-profile.children.cycles-pp.___sys_recvmsg
      9.38 ± 23%      -7.7        1.68 ± 37%  perf-profile.children.cycles-pp.__release_sock
      9.35 ± 23%      -7.7        1.68 ± 37%  perf-profile.children.cycles-pp.sctp_backlog_rcv
      9.48 ±  5%      -7.3        2.18 ± 32%  perf-profile.children.cycles-pp.____sys_recvmsg
      9.19 ±  5%      -7.1        2.13 ± 31%  perf-profile.children.cycles-pp.sctp_recvmsg
      9.05 ±  5%      -7.0        2.09 ± 31%  perf-profile.children.cycles-pp.inet_recvmsg
      8.32 ± 21%      -6.9        1.40 ± 41%  perf-profile.children.cycles-pp.sctp_primitive_SEND
      7.23 ± 22%      -5.9        1.33 ± 42%  perf-profile.children.cycles-pp.__ip_queue_xmit
      7.08 ± 22%      -5.8        1.30 ± 41%  perf-profile.children.cycles-pp.ip_finish_output2
      6.82 ± 22%      -5.6        1.26 ± 40%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      6.97 ±  9%      -5.5        1.46 ± 30%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      6.71 ± 22%      -5.5        1.24 ± 41%  perf-profile.children.cycles-pp.do_softirq
      6.50 ± 22%      -5.3        1.21 ± 41%  perf-profile.children.cycles-pp.net_rx_action
      6.44 ± 22%      -5.2        1.20 ± 41%  perf-profile.children.cycles-pp.__napi_poll
      6.43 ± 22%      -5.2        1.20 ± 42%  perf-profile.children.cycles-pp.process_backlog
      6.30 ± 22%      -5.1        1.18 ± 41%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      6.10 ± 22%      -5.0        1.14 ± 42%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      6.07 ± 22%      -4.9        1.14 ± 42%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      6.02 ± 22%      -4.9        1.13 ± 42%  perf-profile.children.cycles-pp.sctp_rcv
      5.09 ± 21%      -4.2        0.84 ± 35%  perf-profile.children.cycles-pp.sctp_datamsg_from_user
      5.02 ± 22%      -4.2        0.85 ± 38%  perf-profile.children.cycles-pp.sctp_packet_pack
      8.21 ± 13%      -4.1        4.10 ± 19%  perf-profile.children.cycles-pp.__softirqentry_text_start
      4.68 ± 23%      -3.9        0.79 ± 39%  perf-profile.children.cycles-pp.memcpy_erms
      4.93 ±  5%      -3.8        1.13 ± 31%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      4.92 ±  5%      -3.8        1.13 ± 31%  perf-profile.children.cycles-pp.__skb_datagram_iter
      4.20 ±  5%      -3.2        0.98 ± 31%  perf-profile.children.cycles-pp._copy_to_iter
      4.09 ±  5%      -3.1        0.96 ± 31%  perf-profile.children.cycles-pp.copyout
      3.15 ± 22%      -2.6        0.58 ± 43%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
      2.36 ± 21%      -2.0        0.40 ± 36%  perf-profile.children.cycles-pp.sctp_user_addto_chunk
      2.20 ± 25%      -1.8        0.38 ± 38%  perf-profile.children.cycles-pp.sctp_outq_sack
      2.12 ± 22%      -1.8        0.34 ± 35%  perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      2.11 ± 21%      -1.8        0.34 ± 33%  perf-profile.children.cycles-pp._copy_from_iter
      2.18 ± 21%      -1.8        0.42 ± 40%  perf-profile.children.cycles-pp.sctp_chunk_put
      2.12 ± 23%      -1.8        0.37 ± 36%  perf-profile.children.cycles-pp.__alloc_skb
      1.97 ± 21%      -1.7        0.32 ± 31%  perf-profile.children.cycles-pp.copyin
      1.93 ± 22%      -1.6        0.33 ± 36%  perf-profile.children.cycles-pp._sctp_make_chunk
      1.93 ± 20%      -1.6        0.35 ± 40%  perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      1.83 ± 20%      -1.5        0.34 ± 41%  perf-profile.children.cycles-pp.sctp_data_ready
      1.63 ± 20%      -1.3        0.31 ± 39%  perf-profile.children.cycles-pp.__wake_up_common_lock
      1.83 ±  6%      -1.3        0.52 ± 19%  perf-profile.children.cycles-pp.__schedule
      1.58 ± 20%      -1.3        0.30 ± 39%  perf-profile.children.cycles-pp.__wake_up_common
      1.62 ±  7%      -1.3        0.34 ± 34%  perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      1.52 ± 21%      -1.3        0.25 ± 31%  perf-profile.children.cycles-pp.sctp_outq_flush_data
      1.49 ± 24%      -1.2        0.26 ± 34%  perf-profile.children.cycles-pp.kmalloc_reserve
      1.44 ± 25%      -1.2        0.25 ± 34%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      1.41 ± 20%      -1.1        0.27 ± 41%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.42 ± 20%      -1.1        0.29 ± 40%  perf-profile.children.cycles-pp.try_to_wake_up
      1.34 ± 25%      -1.1        0.23 ± 37%  perf-profile.children.cycles-pp.kmalloc_large_node
      1.34 ± 13%      -1.1        0.26 ± 29%  perf-profile.children.cycles-pp._copy_from_user
      1.31 ± 21%      -1.1        0.24 ± 48%  perf-profile.children.cycles-pp.consume_skb
      1.30 ± 15%      -1.0        0.30 ± 25%  perf-profile.children.cycles-pp.kmem_cache_free
      1.20 ± 13%      -1.0        0.24 ± 41%  perf-profile.children.cycles-pp.skb_release_data
      1.15 ± 24%      -0.9        0.23 ± 30%  perf-profile.children.cycles-pp.__alloc_pages
      1.06 ± 24%      -0.9        0.20 ± 46%  perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      1.04 ± 20%      -0.9        0.18 ± 35%  perf-profile.children.cycles-pp.sendmsg_copy_msghdr
      0.99 ±  7%      -0.8        0.21 ± 34%  perf-profile.children.cycles-pp.schedule_timeout
      0.91 ± 24%      -0.7        0.18 ± 32%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.89 ± 11%      -0.7        0.18 ± 31%  perf-profile.children.cycles-pp.__check_object_size
      0.87 ± 14%      -0.7        0.17 ± 37%  perf-profile.children.cycles-pp.__copy_msghdr_from_user
      0.94 ±  6%      -0.7        0.25 ± 24%  perf-profile.children.cycles-pp.schedule_idle
      0.93 ±  6%      -0.7        0.27 ± 17%  perf-profile.children.cycles-pp.schedule
      0.79 ± 14%      -0.6        0.14 ± 38%  perf-profile.children.cycles-pp.skb_release_head_state
      0.80 ±  4%      -0.6        0.18 ± 40%  perf-profile.children.cycles-pp.kfree_skb_reason
      0.67 ± 21%      -0.6        0.11 ± 30%  perf-profile.children.cycles-pp.sctp_outq_select_transport
      0.68 ± 12%      -0.5        0.13 ± 32%  perf-profile.children.cycles-pp.import_iovec
      0.66 ± 12%      -0.5        0.13 ± 31%  perf-profile.children.cycles-pp.__import_iovec
      0.69 ±  7%      -0.5        0.19 ± 36%  perf-profile.children.cycles-pp.sctp_ulpevent_free
      0.61 ± 20%      -0.5        0.12 ± 49%  perf-profile.children.cycles-pp.__rhashtable_lookup
      0.60 ± 20%      -0.5        0.11 ± 32%  perf-profile.children.cycles-pp.sctp_packet_config
      0.58 ± 18%      -0.5        0.10 ± 25%  perf-profile.children.cycles-pp.kfree
      0.57 ±  9%      -0.5        0.11 ± 48%  perf-profile.children.cycles-pp.iovec_from_user
      0.59 ± 22%      -0.5        0.14 ± 36%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.53 ± 20%      -0.4        0.10 ± 79%  perf-profile.children.cycles-pp.free_unref_page
      0.50 ± 24%      -0.4        0.08 ± 60%  perf-profile.children.cycles-pp.sctp_chunkify
      0.51 ± 24%      -0.4        0.10 ± 36%  perf-profile.children.cycles-pp.rmqueue
      0.49 ± 21%      -0.4        0.10 ± 57%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.44 ± 23%      -0.4        0.06 ± 81%  perf-profile.children.cycles-pp.__skb_clone
      0.47 ± 20%      -0.4        0.09 ± 61%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.50 ±  7%      -0.4        0.13 ± 46%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.49 ± 15%      -0.4        0.12 ± 38%  perf-profile.children.cycles-pp.lock_sock_nested
      0.50 ± 19%      -0.4        0.14 ± 36%  perf-profile.children.cycles-pp.__might_resched
      0.44 ± 17%      -0.4        0.08 ± 33%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.40 ±  9%      -0.4        0.05 ±104%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.44 ±  7%      -0.4        0.08 ± 32%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.42 ± 23%      -0.3        0.08 ± 72%  perf-profile.children.cycles-pp.sctp_hash_cmp
      0.38 ± 22%      -0.3        0.04 ±102%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.40 ± 25%      -0.3        0.06 ± 79%  perf-profile.children.cycles-pp.__sctp_rcv_lookup
      0.38 ± 25%      -0.3        0.06 ± 81%  perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      0.37 ± 23%      -0.3        0.05 ± 74%  perf-profile.children.cycles-pp.sctp_packet_transmit_chunk
      0.36 ± 26%      -0.3        0.04 ±100%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.42 ±  8%      -0.3        0.11 ± 25%  perf-profile.children.cycles-pp.__slab_free
      0.40 ± 21%      -0.3        0.08 ± 57%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.38 ± 17%      -0.3        0.06 ± 55%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.36 ± 20%      -0.3        0.05 ± 75%  perf-profile.children.cycles-pp.sctp_addto_chunk
      0.35 ± 16%      -0.3        0.06 ± 79%  perf-profile.children.cycles-pp.sctp_endpoint_lookup_assoc
      0.33 ± 25%      -0.3        0.04 ±101%  perf-profile.children.cycles-pp.sctp_wfree
      0.33 ± 27%      -0.3        0.04 ± 72%  perf-profile.children.cycles-pp.sctp_chunk_free
      0.36 ± 23%      -0.3        0.08 ± 64%  perf-profile.children.cycles-pp.enqueue_entity
      0.33 ± 18%      -0.3        0.04 ± 73%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.32 ± 25%      -0.3        0.03 ±103%  perf-profile.children.cycles-pp.__copy_skb_header
      0.32 ± 19%      -0.3        0.04 ± 74%  perf-profile.children.cycles-pp.sctp_sf_eat_data_6_2
      0.33 ± 15%      -0.3        0.06 ± 77%  perf-profile.children.cycles-pp.sctp_epaddr_lookup_transport
      0.32 ± 21%      -0.3        0.04 ± 75%  perf-profile.children.cycles-pp.sctp_packet_append_chunk
      0.34 ±  9%      -0.3        0.07 ± 81%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.31 ± 18%      -0.3        0.04 ± 73%  perf-profile.children.cycles-pp.memset_erms
      0.34 ± 17%      -0.3        0.08 ± 25%  perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.34 ± 21%      -0.3        0.08 ± 28%  perf-profile.children.cycles-pp.__might_fault
      0.34 ±  7%      -0.3        0.08 ± 50%  perf-profile.children.cycles-pp.set_next_entity
      0.31 ± 10%      -0.3        0.06 ± 82%  perf-profile.children.cycles-pp.dequeue_entity
      0.32 ± 15%      -0.2        0.08 ± 60%  perf-profile.children.cycles-pp.__entry_text_start
      0.30 ± 16%      -0.2        0.05 ± 50%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.28 ± 21%      -0.2        0.04 ± 75%  perf-profile.children.cycles-pp.sctp_eat_data
      0.30 ± 23%      -0.2        0.07 ± 54%  perf-profile.children.cycles-pp.__might_sleep
      0.28 ± 23%      -0.2        0.04 ± 77%  perf-profile.children.cycles-pp.sock_kmalloc
      0.28 ±  8%      -0.2        0.05 ± 71%  perf-profile.children.cycles-pp.dst_release
      0.29 ± 26%      -0.2        0.05 ± 77%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.31 ± 17%      -0.2        0.08 ± 68%  perf-profile.children.cycles-pp.update_load_avg
      0.26 ± 19%      -0.2        0.04 ±103%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.27 ± 21%      -0.2        0.06 ± 13%  perf-profile.children.cycles-pp.select_task_rq
      0.24 ± 14%      -0.2        0.03 ±111%  perf-profile.children.cycles-pp.aa_sk_perm
      0.24 ± 23%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.23 ± 27%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.sctp_check_transmitted
      0.25 ± 18%      -0.2        0.05 ± 82%  perf-profile.children.cycles-pp.sctp_gen_sack
      0.23 ± 25%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.__zone_watermark_ok
      0.24 ± 19%      -0.2        0.05 ± 85%  perf-profile.children.cycles-pp.sctp_make_sack
      0.24 ± 18%      -0.2        0.05 ± 73%  perf-profile.children.cycles-pp.__cond_resched
      0.22 ± 25%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.22 ± 22%      -0.2        0.05 ± 49%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.20 ± 13%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.21 ± 26%      -0.2        0.04 ±112%  perf-profile.children.cycles-pp.sctp_ulpevent_receive_data
      0.20 ± 11%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.__list_add_valid
      0.18 ± 23%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.kmem_cache_alloc_trace
      0.20 ± 18%      -0.1        0.06 ± 30%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.16 ± 15%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__free_pages_ok
      0.16 ± 26%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.17 ± 13%      -0.1        0.05 ± 50%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.12 ± 17%      -0.1        0.07 ± 51%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.09 ± 10%      +0.0        0.14 ± 12%  perf-profile.children.cycles-pp.sched_clock
      0.02 ±142%      +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.error_return
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.unmap_page_range
      0.06 ± 21%      +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.04 ± 71%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.11 ±  6%      +0.1        0.17 ± 21%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.mmap_region
      0.05 ± 51%      +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.read_counters
      0.05 ± 51%      +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.unmap_vmas
      0.05 ± 51%      +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.cmd_stat
      0.05 ± 51%      +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.1        0.07 ± 27%  perf-profile.children.cycles-pp._dl_rtld_di_serinfo
      0.00            +0.1        0.07 ± 36%  perf-profile.children.cycles-pp.exit_mm
      0.01 ±223%      +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.new_sync_read
      0.01 ±223%      +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.do_filp_open
      0.02 ±142%      +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.hrtimer_forward
      0.10 ± 33%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp._find_next_bit
      0.06 ±  9%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.13 ± 12%      +0.1        0.22 ± 27%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.01 ±223%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.fork
      0.06 ±  6%      +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.handle_mm_fault
      0.18 ± 17%      +0.1        0.27 ± 24%  perf-profile.children.cycles-pp.call_cpuidle
      0.02 ± 99%      +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.bprm_execve
      0.02 ±141%      +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.do_sys_openat2
      0.11 ± 33%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.cpumask_next_and
      0.07 ± 12%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.exc_page_fault
      0.07 ± 12%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.1        0.09 ± 35%  perf-profile.children.cycles-pp.__get_cpu_features
      0.02 ±141%      +0.1        0.11 ± 27%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.do_exit
      0.05 ± 47%      +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.vfs_read
      0.07 ± 18%      +0.1        0.17 ± 18%  perf-profile.children.cycles-pp.read
      0.00            +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.load_elf_binary
      0.05 ± 46%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.05 ± 46%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.do_execveat_common
      0.05 ± 46%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.execve
      0.05 ± 46%      +0.1        0.16 ± 16%  perf-profile.children.cycles-pp.ksys_read
      0.05 ± 76%      +0.1        0.15 ± 33%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.search_binary_handler
      0.09 ± 15%      +0.1        0.20 ± 19%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.mmput
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.exit_mmap
      0.09 ± 33%      +0.1        0.22 ± 24%  perf-profile.children.cycles-pp.rcu_core
      0.18 ±  9%      +0.1        0.32 ±  8%  perf-profile.children.cycles-pp.rcu_dynticks_inc
      0.07 ±  6%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp._dl_catch_error
      0.60 ±  9%      +0.2        0.75 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.19 ±  9%      +0.2        0.35 ± 19%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.13 ± 42%      +0.2        0.29 ± 22%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.17 ± 25%      +0.2        0.34 ± 21%  perf-profile.children.cycles-pp.error_entry
      0.15 ± 37%      +0.3        0.41 ± 47%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.26 ± 17%      +0.3        0.53 ± 12%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.48 ± 26%      +0.3        0.79 ± 11%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.41 ± 23%      +0.3        0.74 ± 22%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.64 ± 22%      +0.3        0.98 ± 18%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.42 ± 14%      +0.4        0.77 ± 14%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.45 ± 13%      +0.4        0.83 ± 14%  perf-profile.children.cycles-pp.find_busiest_group
      0.58 ± 19%      +0.4        1.01 ± 17%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.37 ± 16%      +0.4        0.80 ± 18%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.24 ±  7%      +0.4        0.69 ± 12%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.32 ± 20%      +0.5        0.78 ± 26%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.78 ± 13%      +0.5        1.26 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.65 ± 21%      +0.5        1.14 ± 21%  perf-profile.children.cycles-pp.load_balance
      0.39 ± 41%      +0.5        0.92 ± 33%  perf-profile.children.cycles-pp.start_kernel
      0.93 ± 12%      +0.6        1.54 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.76 ±  6%      +0.6        1.37 ± 21%  perf-profile.children.cycles-pp.read_tsc
      0.60 ± 11%      +0.8        1.39 ± 31%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.89 ± 17%      +0.8        1.69 ± 12%  perf-profile.children.cycles-pp.rebalance_domains
      1.02 ± 15%      +0.9        1.87 ± 14%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.73 ± 10%      +0.9        1.64 ± 30%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.86 ± 18%      +1.1        1.92 ± 20%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.96 ± 34%      +1.1        2.09 ± 18%  perf-profile.children.cycles-pp.tick_irq_enter
      0.99 ± 33%      +1.2        2.14 ± 17%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.55 ± 17%      +1.3        2.81 ±  9%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.97 ± 25%      +1.7        3.66 ± 17%  perf-profile.children.cycles-pp.__irq_exit_rcu
      1.56 ± 18%      +2.4        3.99 ± 41%  perf-profile.children.cycles-pp.ktime_get
      7.68 ± 32%      +7.6       15.26 ± 20%  perf-profile.children.cycles-pp.hrtimer_interrupt
      7.97 ± 33%      +7.7       15.64 ± 21%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     35.41           +11.3       46.71 ± 13%  perf-profile.children.cycles-pp.mwait_idle_with_hints
     11.89 ± 31%     +11.5       23.35 ± 19%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     35.63           +11.5       47.14 ± 13%  perf-profile.children.cycles-pp.intel_idle
     13.80 ± 27%     +13.6       27.37 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     52.77 ±  9%     +28.2       80.99 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     52.87 ±  9%     +28.3       81.17 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     59.70 ± 10%     +30.9       90.62 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     59.70 ± 10%     +30.9       90.62 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     59.68 ± 10%     +30.9       90.61 ±  2%  perf-profile.children.cycles-pp.do_idle
     57.68 ± 10%     +31.6       89.24 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      6.92 ±  9%      -5.5        1.45 ± 30%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      4.66 ± 23%      -3.9        0.78 ± 39%  perf-profile.self.cycles-pp.memcpy_erms
      0.62 ± 22%      -0.5        0.12 ± 29%  perf-profile.self.cycles-pp.kmem_cache_free
      0.57 ± 13%      -0.5        0.12 ± 38%  perf-profile.self.cycles-pp.__check_object_size
      0.43 ± 18%      -0.4        0.05 ± 80%  perf-profile.self.cycles-pp.sctp_datamsg_from_user
      0.45 ± 19%      -0.3        0.12 ± 37%  perf-profile.self.cycles-pp.__might_resched
      0.36 ±  8%      -0.3        0.04 ±114%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.39 ± 17%      -0.3        0.06 ± 50%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.42 ±  8%      -0.3        0.10 ± 23%  perf-profile.self.cycles-pp.__slab_free
      0.41 ± 10%      -0.3        0.10 ± 33%  perf-profile.self.cycles-pp.sctp_recvmsg
      0.39 ± 21%      -0.3        0.08 ± 55%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.37 ± 17%      -0.3        0.06 ± 55%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.33 ± 20%      -0.3        0.04 ± 74%  perf-profile.self.cycles-pp.kfree
      0.31 ± 25%      -0.3        0.03 ±103%  perf-profile.self.cycles-pp.__copy_skb_header
      0.32 ± 19%      -0.3        0.06 ± 49%  perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.32 ± 18%      -0.3        0.06 ± 53%  perf-profile.self.cycles-pp.sctp_chunk_put
      0.30 ± 18%      -0.3        0.04 ± 73%  perf-profile.self.cycles-pp.memset_erms
      0.29 ± 25%      -0.2        0.05 ± 82%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.28 ± 27%      -0.2        0.04 ±102%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.31 ±  5%      -0.2        0.08 ± 23%  perf-profile.self.cycles-pp.__schedule
      0.28 ±  8%      -0.2        0.05 ± 71%  perf-profile.self.cycles-pp.dst_release
      0.25 ± 25%      -0.2        0.03 ±101%  perf-profile.self.cycles-pp.sctp_outq_flush_data
      0.26 ± 17%      -0.2        0.04 ±103%  perf-profile.self.cycles-pp.free_pcp_prepare
      0.28 ± 14%      -0.2        0.06 ± 48%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.25 ± 18%      -0.2        0.03 ±101%  perf-profile.self.cycles-pp.sctp_cmd_interpreter
      0.25 ± 22%      -0.2        0.04 ± 75%  perf-profile.self.cycles-pp.__might_sleep
      0.26 ±  9%      -0.2        0.06 ± 49%  perf-profile.self.cycles-pp.set_next_entity
      0.24 ±  8%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.22 ± 25%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.24 ± 13%      -0.2        0.06 ± 76%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.19 ± 17%      -0.2        0.02 ± 99%  perf-profile.self.cycles-pp._copy_from_user
      0.16 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__list_add_valid
      0.14 ± 26%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.12 ± 19%      -0.0        0.07 ± 52%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.02 ±142%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.08 ± 16%      +0.1        0.15 ± 19%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.irqentry_exit
      0.17 ± 15%      +0.1        0.25 ± 25%  perf-profile.self.cycles-pp.call_cpuidle
      0.12 ± 16%      +0.1        0.20 ± 26%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.13 ± 15%      +0.1        0.21 ± 16%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.09 ± 54%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp._find_next_bit
      0.08 ± 25%      +0.1        0.16 ± 11%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.18 ± 11%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.rcu_dynticks_inc
      0.09 ± 64%      +0.1        0.22 ± 24%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.56 ± 11%      +0.1        0.70 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      0.25 ± 20%      +0.1        0.39 ± 19%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.15 ± 29%      +0.2        0.31 ± 24%  perf-profile.self.cycles-pp.error_entry
      0.24 ±  4%      +0.2        0.42 ± 18%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.17 ± 13%      +0.2        0.37 ± 12%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.30 ± 30%      +0.2        0.51 ± 29%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.22 ±  9%      +0.2        0.44 ± 25%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.24 ± 15%      +0.2        0.46 ±  8%  perf-profile.self.cycles-pp.intel_idle
      0.13 ± 17%      +0.3        0.41 ± 47%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.46 ± 18%      +0.3        0.75 ± 13%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.20 ± 27%      +0.3        0.53 ± 33%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.36 ± 16%      +0.4        0.80 ± 18%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.24 ±  7%      +0.4        0.69 ± 12%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.73 ± 12%      +0.5        1.20 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.74 ±  6%      +0.6        1.32 ± 21%  perf-profile.self.cycles-pp.read_tsc
      0.60 ± 11%      +0.8        1.38 ± 31%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.73 ± 10%      +0.9        1.64 ± 30%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.89 ± 33%      +2.0        2.85 ± 51%  perf-profile.self.cycles-pp.ktime_get
      2.60 ± 10%      +2.9        5.47 ± 13%  perf-profile.self.cycles-pp.cpuidle_enter_state
     35.37           +11.3       46.62 ± 13%  perf-profile.self.cycles-pp.mwait_idle_with_hints



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-11/performance/1HDD/4K/nfsv4/xfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-icl-2sp6/50M/fsmark/0xd000331

commit: 
  4033d677de ("Merge branch 'for-5.19/io_uring-socket' into sock-nolock.2")
  5aa32dd9bd ("net: add support for fast socket release")

4033d677de27560d 5aa32dd9bdb57e4a26143216df5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10335            -3.1%      10012        proc-vmstat.nr_shmem
     96.15            +0.9%      96.98        iostat.cpu.idle
      3.40 ±  3%     -24.8%       2.56 ± 19%  iostat.cpu.system
      3.19 ±  3%      -0.8        2.42 ± 18%  mpstat.cpu.all.irq%
      0.03 ±  2%      -0.0        0.02 ±  6%  mpstat.cpu.all.sys%
      0.01 ±  4%      -0.0        0.01 ±  4%  mpstat.cpu.all.usr%
     10.89 ± 34%     -77.7%       2.43 ±122%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    724.26 ± 11%     -73.5%     192.06 ±114%  sched_debug.cfs_rq:/.MIN_vruntime.max
     82.06 ± 16%     -76.0%      19.70 ±115%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     10.89 ± 34%     -77.7%       2.43 ±122%  sched_debug.cfs_rq:/.max_vruntime.avg
    724.26 ± 11%     -73.5%     192.06 ±114%  sched_debug.cfs_rq:/.max_vruntime.max
     82.06 ± 16%     -76.0%      19.70 ±115%  sched_debug.cfs_rq:/.max_vruntime.stddev
     24.45 ±  2%      +9.9%      26.87 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
     24.37 ±  2%      +9.9%      26.79 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      5.52 ±  3%      -1.4        4.08 ± 21%  turbostat.Busy%
     16.33 ± 47%     +55.7       72.07 ± 48%  turbostat.C1E%
     78.99 ±  9%     -54.5       24.53 ±138%  turbostat.C6%
     19.49 ± 40%    +275.3%      73.16 ± 45%  turbostat.CPU%c1
     74.99 ± 10%     -69.7%      22.76 ±141%  turbostat.CPU%c6
     48.33 ±  3%      +7.6%      52.00 ±  3%  turbostat.CoreTmp
     22.51 ± 19%     -70.5%       6.63 ±142%  turbostat.Pkg%pc2
     10.15 ± 39%     -78.4%       2.20 ±193%  turbostat.Pkg%pc6
     48.67 ±  3%      +7.5%      52.33 ±  3%  turbostat.PkgTmp
    181.48 ±  5%     +11.4%     202.20 ±  4%  turbostat.PkgWatt
     60.39 ±  2%      +4.5%      63.11 ±  2%  turbostat.RAMWatt
     11.29            -6.7        4.56 ±102%  perf-stat.i.branch-miss-rate%
  23636197           -60.3%    9387443 ±102%  perf-stat.i.branch-misses
      1.20            -0.8        0.39 ±136%  perf-stat.i.dTLB-load-miss-rate%
   3477591           -67.4%    1133867 ±136%  perf-stat.i.dTLB-load-misses
      0.35            -0.2        0.12 ±127%  perf-stat.i.dTLB-store-miss-rate%
    544620           -65.2%     189537 ±127%  perf-stat.i.dTLB-store-misses
     11.20            -6.7        4.54 ±102%  perf-stat.overall.branch-miss-rate%
      1.19            -0.8        0.39 ±136%  perf-stat.overall.dTLB-load-miss-rate%
      0.35            -0.2        0.12 ±127%  perf-stat.overall.dTLB-store-miss-rate%
  23620071           -60.3%    9381070 ±102%  perf-stat.ps.branch-misses
   3475219           -67.4%    1133091 ±136%  perf-stat.ps.dTLB-load-misses
    544246           -65.2%     189406 ±127%  perf-stat.ps.dTLB-store-misses
      8.50 ±  8%      -2.3        6.19 ± 20%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     95.43            -1.9       93.52        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     95.59            -1.9       93.70        perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
     93.89            -1.5       92.37        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      5.25 ±  5%      -0.8        4.42 ± 14%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.22 ±  5%      -0.7        3.48 ± 16%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.04            -0.6        2.49 ± 15%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.27 ±  2%      -0.3        0.96 ± 15%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt
      1.83            -0.2        1.60 ±  9%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.87 ±  9%      -0.2        0.71 ± 10%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu
      0.81 ± 11%      -0.2        0.66 ± 10%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start
      1.88 ±  7%      +1.8        3.72 ± 39%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      8.67 ±  8%      -2.3        6.34 ± 20%  perf-profile.children.cycles-pp.menu_select
      5.37 ±  5%      -0.8        4.56 ± 13%  perf-profile.children.cycles-pp.__irq_exit_rcu
      4.37 ±  6%      -0.7        3.67 ± 15%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.88            -0.4        0.48 ± 57%  perf-profile.children.cycles-pp.timerqueue_add
      0.77            -0.3        0.42 ± 51%  perf-profile.children.cycles-pp.timerqueue_del
      0.70 ±  3%      -0.3        0.38 ± 42%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      1.39 ±  3%      -0.3        1.11 ± 13%  perf-profile.children.cycles-pp.load_balance
      0.52 ±  7%      -0.3        0.25 ± 65%  perf-profile.children.cycles-pp.irqentry_enter
      1.86 ±  2%      -0.2        1.62 ±  9%  perf-profile.children.cycles-pp.rebalance_domains
      0.41 ±  4%      -0.2        0.24 ± 47%  perf-profile.children.cycles-pp.rb_insert_color
      0.26 ±  5%      -0.2        0.10 ± 93%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.62 ±  3%      -0.2        0.46 ± 21%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.28 ± 10%      -0.2        0.12 ± 84%  perf-profile.children.cycles-pp.rcu_nmi_enter
      0.22 ± 12%      -0.1        0.10 ± 59%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.25 ± 11%      -0.1        0.14 ± 42%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.25            -0.1        0.14 ± 40%  perf-profile.children.cycles-pp.get_cpu_device
      0.19 ± 22%      -0.1        0.08 ± 96%  perf-profile.children.cycles-pp.rcu_nmi_exit
      0.20 ± 18%      -0.1        0.12 ± 50%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.13 ± 10%      -0.1        0.05 ±101%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.09 ± 13%      +0.0        0.14 ± 21%  perf-profile.children.cycles-pp.load_elf_binary
      0.09 ± 13%      +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.exec_binprm
      0.09 ± 13%      +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.search_binary_handler
      0.07 ± 23%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.exit_mmap
      0.26 ±  4%      +0.1        0.33 ± 16%  perf-profile.children.cycles-pp.schedule
      0.28 ± 10%      +0.1        0.36 ± 14%  perf-profile.children.cycles-pp.rcu_dynticks_inc
      0.43 ± 11%      +0.1        0.52 ± 10%  perf-profile.children.cycles-pp.__schedule
      0.07 ± 23%      +0.1        0.16 ± 34%  perf-profile.children.cycles-pp._IO_str_seekoff
      0.16 ±  5%      +0.1        0.26 ± 28%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.28 ±  4%      +0.1        0.39 ± 19%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.20 ± 10%      +0.1        0.33 ± 28%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.09 ± 18%      +0.2        0.25 ± 58%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.09 ± 18%      +0.2        0.25 ± 58%  perf-profile.children.cycles-pp.devkmsg_emit
      0.61 ±  8%      +0.3        0.92 ± 25%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.15 ±  6%      +0.5        1.66 ± 20%  perf-profile.children.cycles-pp.read_tsc
      0.42 ± 14%      +0.7        1.10 ± 39%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      1.97 ±  8%      +1.8        3.81 ± 39%  perf-profile.children.cycles-pp.clockevents_program_event
      2.22 ±  6%      +2.5        4.72 ± 39%  perf-profile.children.cycles-pp.ktime_get
      4.77 ± 15%      -2.1        2.63 ± 41%  perf-profile.self.cycles-pp.menu_select
      0.51 ±  7%      -0.2        0.27 ± 54%  perf-profile.self.cycles-pp.timerqueue_add
      0.40 ±  4%      -0.2        0.22 ± 52%  perf-profile.self.cycles-pp.rb_insert_color
      0.61 ±  2%      -0.2        0.44 ± 23%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.23 ±  7%      -0.2        0.08 ±116%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.22 ± 10%      -0.1        0.07 ±115%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.29 ± 28%      -0.1        0.14 ± 62%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.28 ± 11%      -0.1        0.14 ± 43%  perf-profile.self.cycles-pp.load_balance
      0.23 ± 11%      -0.1        0.10 ± 61%  perf-profile.self.cycles-pp.irqentry_enter
      0.25 ± 10%      -0.1        0.13 ± 51%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.25            -0.1        0.13 ± 44%  perf-profile.self.cycles-pp.get_cpu_device
      0.24 ± 12%      -0.1        0.14 ± 40%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.30 ± 10%      -0.1        0.20 ± 34%  perf-profile.self.cycles-pp.tick_irq_enter
      0.22 ±  9%      -0.1        0.13 ± 37%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.17 ± 25%      -0.1        0.08 ± 78%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.22 ±  9%      -0.1        0.15 ± 18%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.16 ± 18%      -0.1        0.10 ± 54%  perf-profile.self.cycles-pp.menu_reflect
      0.27 ± 10%      +0.1        0.35 ± 15%  perf-profile.self.cycles-pp.rcu_dynticks_inc
      0.59 ±  8%      +0.3        0.88 ± 25%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.12 ±  6%      +0.5        1.60 ± 20%  perf-profile.self.cycles-pp.read_tsc
      5.11 ±  2%      +1.2        6.35 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.24 ± 11%      +2.1        3.38 ± 50%  perf-profile.self.cycles-pp.ktime_get





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.18.0-rc4-00071-g5aa32dd9bdb5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.18.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.2.0-20) 11.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_DP_HELPER=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=m
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='netperf'
	export testcase='netperf'
	export category='benchmark'
	export disable_latency_stats=1
	export set_nic_irq_affinity=1
	export ip='ipv4'
	export runtime=300
	export nr_threads=64
	export cluster='cs-localhost'
	export job_origin='netperf-small-threads.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-icl-2sp4'
	export tbox_group='lkp-icl-2sp4'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='626b228a20a3905a2c96f811'
	export job_file='/lkp/jobs/scheduled/lkp-icl-2sp4/netperf-cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-5aa32dd9bdb57e4a26143216d-20220429-23084-vib9c0-5.yaml'
	export id='b4e7b391f899c89f8b58d8fbcd9deb7b6c27e3a0'
	export queuer_version='/zday/lkp'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=128
	export memory='128G'
	export nr_ssd_partitions=3
	export nr_hdd_partitions=6
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20SPZX-08UA7_WD-WXE2EA0ECVAS-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BA800G3_BTTV34510181800JGN-part*'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB240G4_CVWL422602EB240NGN-part1'
	export kernel_cmdline_hw='acpi_rsdp=0x69ffd014'
	export brand='Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz'
	export commit='5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c'
	export ucode='0xd000331'
	export bisect_dmesg=true
	export enqueue_time='2022-04-29 07:26:02 +0800'
	export _id='626b228b20a3905a2c96f813'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331/lkp-icl-2sp4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='0ae1f1c5893c8eecea0fcc669a620cab08b41c23'
	export base_commit='af2d861d4cd2a4da5137f795ee3509e6f944a25b'
	export branch='ammarfaizi2-block/axboe/linux-block/sock-nolock.2'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331/lkp-icl-2sp4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/3'
	export scheduler_version='/lkp/lkp/.src-20220427-234559'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331/lkp-icl-2sp4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/vmlinuz-5.18.0-rc4-00071-g5aa32dd9bdb5
branch=ammarfaizi2-block/axboe/linux-block/sock-nolock.2
job=/lkp/jobs/scheduled/lkp-icl-2sp4/netperf-cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-5aa32dd9bdb57e4a26143216d-20220429-23084-vib9c0-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c
acpi_rsdp=0x69ffd014
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210930.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20220411.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-22da5264abf4-1_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/cluster_20211026.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.18.0-rc4-intel-next-01272-g4bc8301021bc'
	export repeat_to=6
	export schedule_notify_address=
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/vmlinuz-5.18.0-rc4-00071-g5aa32dd9bdb5'
	export dequeue_time='2022-04-29 07:28:07 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp4/netperf-cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-5aa32dd9bdb57e4a26143216d-20220429-23084-vib9c0-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test test='SCTP_RR' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='SCTP_RR' $LKP_SRC/stats/wrapper netperf
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/netperf-small-threads.yaml:
suite: netperf
testcase: netperf
category: benchmark
:# upto 90% CPU cycles may be used by latency stats:
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 300s
nr_threads: 50%
cluster: cs-localhost
if role server:
  netserver:
if role client:
  netperf:
    test: SCTP_RR
job_origin: netperf-small-threads.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- kbuild_queue_analysis
queue: bisect
testbox: lkp-icl-2sp4
tbox_group: lkp-icl-2sp4
kconfig: x86_64-rhel-8.3
submit_id: 626b1b3020a39054373b1f6b
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp4/netperf-cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-5aa32dd9bdb57e4a26143216d-20220429-21559-391muk-1.yaml"
id: 791c69417f761373711323b951b9139c31e47575
queuer_version: "/zday/lkp"
:#! hosts/lkp-icl-2sp4:
model: Ice Lake
nr_node: 2
nr_cpu: 128
memory: 128G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20SPZX-08UA7_WD-WXE2EA0ECVAS-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BA800G3_BTTV34510181800JGN-part*"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB240G4_CVWL422602EB240NGN-part1"
kernel_cmdline_hw: acpi_rsdp=0x69ffd014
brand: Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: 5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c
:#! include/testbox/lkp-icl-2sp4:
ucode: '0xd000331'
bisect_dmesg: true
enqueue_time: 2022-04-29 06:54:40.789961068 +08:00
_id: 626b1b3020a39054373b1f6c
_rt: "/result/netperf/cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331/lkp-icl-2sp4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 0ae1f1c5893c8eecea0fcc669a620cab08b41c23
base_commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
branch: linux-devel/devel-hourly-20220426-221600
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/netperf/cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331/lkp-icl-2sp4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/0"
scheduler_version: "/lkp/lkp/.src-20220427-234559"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331/lkp-icl-2sp4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/vmlinuz-5.18.0-rc4-00071-g5aa32dd9bdb5
- branch=linux-devel/devel-hourly-20220426-221600
- job=/lkp/jobs/scheduled/lkp-icl-2sp4/netperf-cs-localhost-performance-ipv4-50%-300s-SCTP_RR-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-5aa32dd9bdb57e4a26143216d-20220429-21559-391muk-1.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c
- acpi_rsdp=0x69ffd014
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210930.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20220411.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-22da5264abf4-1_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/cluster_20211026.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220426233220/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.18.0-rc4
repeat_to: 3
schedule_notify_address:
:#! user overrides:
kbuild_queue_analysis: 1
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c/vmlinuz-5.18.0-rc4-00071-g5aa32dd9bdb5"
dequeue_time: 2022-04-29 06:56:43.779700496 +08:00
:#! /cephfs/db/releases/20220428225439/lkp-src/include/site/inn:
job_state: finished
loadavg: 37.10 35.70 16.70 2/1020 15732
start_time: '1651186668'
end_time: '1651186973'
version: "/lkp/lkp/.src-20220427-234641:2ce444ff:9d651bc2d"

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

netserver -4 -D
modprobe sctp
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
wait

--dDRMvlgZJXvWKvBx--
