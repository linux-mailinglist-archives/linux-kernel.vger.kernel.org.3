Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74215AC3F8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiIDKo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiIDKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:44:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C023AE7B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:44:15 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oUn6p-0004TU-Vs; Sun, 04 Sep 2022 12:44:12 +0200
Message-ID: <5d611439-3b09-af07-b579-139eee276a70@leemhuis.info>
Date:   Sun, 4 Sep 2022 12:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     lkp@lists.01.org, kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220821130126.GA29794@inn2.lkp.intel.com>
 <8a410343-b82a-0972-0f26-cc63b50d2ef9@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [copy_page_{to,from}_iter()] 59bb69c67c: hackbench.throughput
 -37.6% regression
In-Reply-To: <8a410343-b82a-0972-0f26-cc63b50d2ef9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662288256;34616497;
X-HE-SMSGID: 1oUn6p-0004TU-Vs
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

As per recent general discussions with the 0-day folks, I'm dropping
below regression from the list of tracked issues, as there were no
replies from any developers the report was sent to. That for example can
happen if the developers considered the difference of no practical
relevance, as they assume it only materializes in micro-benchmarks.

Not sure if that or something else is the reason why this particular
report was ignored, but I lack the bandwidth to follow-up on each and
every some CI system found and reported. At the same time I don't want
to keep these reports in the list of tracked issues forever, as that
creates noise and makes it harder to spot the important issues in
regzbot's reports and lists. That's why I hearby remove it:

#regzbot invalid: 0-day report that didn't get tracktion; might be of no
relevance

Ciao, Thorsten

On 22.08.22 03:13, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -37.6% regression of hackbench.throughput due to commit:
> 
> 
> commit: 59bb69c67cf1475a04cd5629d9c4f6dbbcba5e4a
> ("copy_page_{to,from}_iter(): switch iovec variants to generic")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: hackbench
> on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @
> 2.50GHz with 128G memory
> with following parameters:
> 
>     nr_threads: 100%
>     iterations: 4
>     mode: threads
>     ipc: pipe
>     cpufreq_governor: performance
>     ucode: 0x7002501
> 
> test-description: Hackbench is both a benchmark and a stress test for
> the Linux kernel scheduler.
> test-url:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached
> in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file
> for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
>  
> gcc-11/performance/pipe/4/x86_64-rhel-8.3/threads/100%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp1/hackbench/0x7002501
> 
> commit:
>   164f4064ca ("keep iocb_flags() result cached in struct file")
>   59bb69c67c ("copy_page_{to,from}_iter(): switch iovec variants to
> generic")
> 
> 164f4064ca81eefc 59bb69c67cf1475a04cd5629d9c
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     489102           -37.6%     305349 ± 13%  hackbench.throughput
>     152.60           +80.1%     274.90 ± 10%  hackbench.time.elapsed_time
>     152.60           +80.1%     274.90 ± 10% 
> hackbench.time.elapsed_time.max
>  1.404e+09          +101.3%  2.827e+09 ± 14% 
> hackbench.time.involuntary_context_switches
>     986.17 ± 18%    +136.2%       2328 ± 15% 
> hackbench.time.major_page_faults
>     274197 ±  3%    +142.3%     664339 ± 13% 
> hackbench.time.minor_page_faults
>      13936            -3.2%      13497       
> hackbench.time.percent_of_cpu_this_job_got
>      19872           +75.3%      34829 ± 11%  hackbench.time.system_time
>       1396           +63.5%       2282 ± 11%  hackbench.time.user_time
>  2.338e+09           +79.0%  4.184e+09 ±  9% 
> hackbench.time.voluntary_context_switches
>   13265456 ± 10%     -22.9%   10229449 ±  9%  cpuidle..usage
>     198.33           +61.5%     320.24 ±  9%  uptime.boot
>       1.33 ±  5%      +3.6        4.95 ±  6%  mpstat.cpu.all.irq%
>       0.04 ±  2%      -0.0        0.04 ±  9%  mpstat.cpu.all.soft%
>       1463           +22.3%       1789 ±  6%  vmstat.procs.r
>    1813234           +53.8%    2788498 ±  8%  vmstat.system.in
>      57096 ± 14%    +133.1%     133100 ± 49%  meminfo.Active
>      56878 ± 14%    +133.8%     132977 ± 49%  meminfo.Active(anon)
>     160758 ±  2%     +34.3%     215911 ±  6%  meminfo.AnonHugePages
>     326854 ±  3%     +95.0%     637420 ±  7%  meminfo.Mapped
>       3031            +2.1%       3093        turbostat.Bzy_MHz
>       0.45 ± 67%     -89.6%       0.05 ± 38%  turbostat.CPU%c6
>       0.15           -23.3%       0.12 ±  6%  turbostat.IPC
>  3.029e+08          +172.5%  8.253e+08 ±  4%  turbostat.IRQ
>    3398377 ±  7%     -84.7%     520088 ± 12%  turbostat.POLL
>       0.05 ± 15%      -0.0        0.01 ± 70%  turbostat.POLL%
>      10.02           +37.7%      13.79        turbostat.RAMWatt
>   14027902 ± 16%     -69.3%    4313384 ± 24% 
> numa-numastat.node0.local_node
>   14083684 ± 16%     -69.1%    4354549 ± 24%  numa-numastat.node0.numa_hit
>   12038117 ± 13%     -62.5%    4519914 ± 37% 
> numa-numastat.node1.local_node
>   12092443 ± 13%     -62.2%    4567078 ± 36%  numa-numastat.node1.numa_hit
>   11573244 ±  6%     -67.1%    3801899 ± 10% 
> numa-numastat.node2.local_node
>   11615332 ±  6%     -66.8%    3851401 ± 11%  numa-numastat.node2.numa_hit
>   11405434 ±  9%     -55.6%    5062395 ± 23% 
> numa-numastat.node3.local_node
>   11447818 ±  9%     -55.3%    5119841 ± 23%  numa-numastat.node3.numa_hit
>      67489 ± 18%     +63.9%     110630 ± 13%  numa-meminfo.node0.Mapped
>       4571 ±136%    +348.9%      20520 ± 81% 
> numa-meminfo.node1.AnonHugePages
>      66557 ± 20%     +48.4%      98758 ± 13%  numa-meminfo.node1.Mapped
>       5303 ±  3%     +11.7%       5921 ±  7% 
> numa-meminfo.node2.KernelStack
>      52917 ±  2%     +86.7%      98805 ±  6%  numa-meminfo.node2.Mapped
>      53719 ± 13%     +80.8%      97098 ± 14%  numa-meminfo.node3.Active
>      53607 ± 13%     +81.1%      97079 ± 14% 
> numa-meminfo.node3.Active(anon)
>     141608 ±  5%    +135.7%     333801 ±  9%  numa-meminfo.node3.Mapped
>    1295651 ± 28%     +84.6%    2391708 ± 42%  numa-meminfo.node3.MemUsed
>      17123 ± 18%     +62.9%      27899 ± 14%  numa-vmstat.node0.nr_mapped
>   14083744 ± 16%     -69.1%    4354624 ± 24%  numa-vmstat.node0.numa_hit
>   14027962 ± 16%     -69.3%    4313459 ± 24%  numa-vmstat.node0.numa_local
>      16922 ± 19%     +46.8%      24848 ± 13%  numa-vmstat.node1.nr_mapped
>   12092369 ± 13%     -62.2%    4567042 ± 36%  numa-vmstat.node1.numa_hit
>   12038043 ± 13%     -62.5%    4519877 ± 37%  numa-vmstat.node1.numa_local
>       5303 ±  3%     +11.6%       5920 ±  7% 
> numa-vmstat.node2.nr_kernel_stack
>      13496 ±  3%     +84.4%      24884 ±  6%  numa-vmstat.node2.nr_mapped
>   11615668 ±  6%     -66.8%    3851152 ± 11%  numa-vmstat.node2.numa_hit
>   11573580 ±  6%     -67.2%    3801650 ± 10%  numa-vmstat.node2.numa_local
>      13880 ± 14%     +75.0%      24296 ± 16% 
> numa-vmstat.node3.nr_active_anon
>      36367 ±  6%    +130.7%      83911 ± 10%  numa-vmstat.node3.nr_mapped
>      13880 ± 14%     +75.0%      24296 ± 16% 
> numa-vmstat.node3.nr_zone_active_anon
>   11447946 ±  9%     -55.3%    5119567 ± 23%  numa-vmstat.node3.numa_hit
>   11405562 ±  9%     -55.6%    5062121 ± 23%  numa-vmstat.node3.numa_local
>      14221 ± 12%    +133.7%      33239 ± 49%  proc-vmstat.nr_active_anon
>      87510            +6.3%      92997        proc-vmstat.nr_anon_pages
>     100316            -6.2%      94080        proc-vmstat.nr_kernel_stack
>      81858 ±  2%     +94.7%     159397 ±  8%  proc-vmstat.nr_mapped
>       1443            +4.9%       1514       
> proc-vmstat.nr_page_table_pages
>      34015            +2.0%      34707       
> proc-vmstat.nr_slab_reclaimable
>      99374            -1.6%      97758       
> proc-vmstat.nr_slab_unreclaimable
>      14221 ± 12%    +133.7%      33239 ± 49% 
> proc-vmstat.nr_zone_active_anon
>     367327 ± 10%     +98.5%     729299 ±  8%  proc-vmstat.numa_hint_faults
>     219391 ±  8%    +139.8%     526037 ± 11% 
> proc-vmstat.numa_hint_faults_local
>   49242297 ±  2%     -63.7%   17894676 ± 14%  proc-vmstat.numa_hit
>   49047749 ±  2%     -63.9%   17699399 ± 14%  proc-vmstat.numa_local
>      62425 ± 11%     +70.6%     106470 ± 14% 
> proc-vmstat.numa_pages_migrated
>     590356 ±  8%     +72.2%    1016367 ±  5%  proc-vmstat.numa_pte_updates
>   49230729 ±  2%     -63.7%   17893980 ± 14%  proc-vmstat.pgalloc_normal
>    1177103 ±  2%     +52.5%    1795115 ±  5%  proc-vmstat.pgfault
>   48382203 ±  2%     -64.7%   17055561 ± 12%  proc-vmstat.pgfree
>      62425 ± 11%     +70.6%     106470 ± 14%  proc-vmstat.pgmigrate_success
>      24411           +33.8%      32664 ±  6%  proc-vmstat.pgreuse
>       0.56 ± 44%    +288.5%       2.16 ± 61% 
> sched_debug.cfs_rq:/.h_nr_running.min
>       4.62 ± 14%     -50.7%       2.28 ± 25% 
> sched_debug.cfs_rq:/.h_nr_running.stddev
>      31.46 ± 26%     -34.9%      20.48 ± 21% 
> sched_debug.cfs_rq:/.load_avg.avg
>       1.17 ± 42%    +127.9%       2.66 ± 28% 
> sched_debug.cfs_rq:/.load_avg.min
>      87.49 ± 18%     -33.2%      58.48 ± 24% 
> sched_debug.cfs_rq:/.load_avg.stddev
>    8625569          +113.5%   18419082 ±  9% 
> sched_debug.cfs_rq:/.min_vruntime.avg
>   10168067 ±  3%    +147.5%   25167143 ± 12% 
> sched_debug.cfs_rq:/.min_vruntime.max
>    7592982 ±  2%    +100.6%   15232132 ± 13% 
> sched_debug.cfs_rq:/.min_vruntime.min
>     617068 ± 15%    +160.1%    1604747 ±  8% 
> sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.69           +15.2%       0.80 ±  3% 
> sched_debug.cfs_rq:/.nr_running.avg
>       0.44 ± 35%     +63.1%       0.72 ± 20% 
> sched_debug.cfs_rq:/.nr_running.min
>      20.05 ± 41%     -53.0%       9.43 ± 36% 
> sched_debug.cfs_rq:/.removed.load_avg.avg
>     341.33           -37.0%     214.90 ±  8% 
> sched_debug.cfs_rq:/.removed.load_avg.max
>      78.01 ± 20%     -44.9%      43.02 ± 13% 
> sched_debug.cfs_rq:/.removed.load_avg.stddev
>       9.16 ± 42%     -50.2%       4.56 ± 32% 
> sched_debug.cfs_rq:/.removed.runnable_avg.avg
>     176.72 ±  3%     -36.3%     112.65 ±  7% 
> sched_debug.cfs_rq:/.removed.runnable_avg.max
>      36.16 ± 20%     -41.7%      21.08 ± 11% 
> sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>       9.16 ± 42%     -50.3%       4.55 ± 32% 
> sched_debug.cfs_rq:/.removed.util_avg.avg
>     176.72 ±  3%     -36.4%     112.42 ±  8% 
> sched_debug.cfs_rq:/.removed.util_avg.max
>      36.16 ± 20%     -41.8%      21.06 ± 11% 
> sched_debug.cfs_rq:/.removed.util_avg.stddev
>    1638316 ± 32%    +285.2%    6311285 ± 18% 
> sched_debug.cfs_rq:/.spread0.max
>    -846609          +332.4%   -3660690       
> sched_debug.cfs_rq:/.spread0.min
>     600389 ± 15%    +164.3%    1586953 ±  7% 
> sched_debug.cfs_rq:/.spread0.stddev
>     724.12 ±  2%     +15.6%     836.78 ±  4% 
> sched_debug.cfs_rq:/.util_avg.avg
>     301.06 ± 16%     +67.7%     504.82 ±  9% 
> sched_debug.cfs_rq:/.util_avg.min
>     199.53 ±  5%     -29.8%     140.12 ±  9% 
> sched_debug.cfs_rq:/.util_avg.stddev
>     334.32 ± 10%     +53.2%     512.20 ± 16% 
> sched_debug.cfs_rq:/.util_est_enqueued.avg
>      16.06 ± 63%    +502.1%      96.68 ± 55% 
> sched_debug.cfs_rq:/.util_est_enqueued.min
>     105237 ±  2%     +60.0%     168333 ±  7%  sched_debug.cpu.clock.avg
>     105780 ±  2%     +61.4%     170776 ±  7%  sched_debug.cpu.clock.max
>     104562 ±  2%     +57.9%     165117 ±  7%  sched_debug.cpu.clock.min
>     374.97 ± 58%    +328.7%       1607 ± 52%  sched_debug.cpu.clock.stddev
>     104364 ±  2%     +55.3%     162027 ±  7% 
> sched_debug.cpu.clock_task.avg
>     105020 ±  2%     +57.9%     165873 ±  6% 
> sched_debug.cpu.clock_task.max
>     101770 ±  2%     +54.2%     156906 ±  7% 
> sched_debug.cpu.clock_task.min
>     519.26 ± 40%    +251.6%       1825 ± 32% 
> sched_debug.cpu.clock_task.stddev
>       8702 ± 50%     +47.5%      12838 ± 11%  sched_debug.cpu.curr->pid.min
>    1397213 ± 25%     -31.6%     955865 ± 27% 
> sched_debug.cpu.max_idle_balance_cost.max
>       0.00 ± 57%    +325.8%       0.00 ± 52% 
> sched_debug.cpu.next_balance.stddev
>       0.50 ± 33%    +351.7%       2.26 ± 53% 
> sched_debug.cpu.nr_running.min
>       4.66 ± 13%     -50.2%       2.32 ± 26% 
> sched_debug.cpu.nr_running.stddev
>   10618467          +116.7%   23010023 ± 10% 
> sched_debug.cpu.nr_switches.avg
>   11604438 ±  3%    +146.5%   28605638 ±  9% 
> sched_debug.cpu.nr_switches.max
>    9614849 ±  2%     +69.4%   16290926 ± 11% 
> sched_debug.cpu.nr_switches.min
>     409020 ± 26%    +482.2%    2381126 ± 14% 
> sched_debug.cpu.nr_switches.stddev
>     104527 ±  2%     +57.9%     165046 ±  7%  sched_debug.cpu_clk
>     103657 ±  2%     +58.4%     164178 ±  7%  sched_debug.ktime
>       0.00 ±181%  +10052.7%       0.32 ±141% 
> sched_debug.rt_rq:/.rt_time.avg
>       0.38 ±218%  +11898.7%      45.56 ±142% 
> sched_debug.rt_rq:/.rt_time.max
>       0.03 ±210%  +11503.4%       3.78 ±142% 
> sched_debug.rt_rq:/.rt_time.stddev
>     105896 ±  2%     +57.2%     166486 ±  7%  sched_debug.sched_clk
>      11.37            +9.9%      12.51        perf-stat.i.MPKI
>  4.608e+10           -22.9%  3.553e+10 ±  4% 
> perf-stat.i.branch-instructions
>       0.98            +0.2        1.17        perf-stat.i.branch-miss-rate%
>       4.23 ±  4%     +13.0       17.25 ±  3%  perf-stat.i.cache-miss-rate%
>   94243104 ±  5%    +232.8%  3.136e+08 ±  2%  perf-stat.i.cache-misses
>  2.441e+09           -14.5%  2.086e+09 ±  5%  perf-stat.i.cache-references
>       1.99           +60.7%       3.20 ±  8%  perf-stat.i.cpi
>  4.246e+11            +2.6%  4.358e+11        perf-stat.i.cpu-cycles
>    1946034 ±  3%     +31.7%    2562014 ±  3%  perf-stat.i.cpu-migrations
>       4979 ±  4%     -71.5%       1419 ±  3% 
> perf-stat.i.cycles-between-cache-misses
>  6.662e+10           -23.5%    5.1e+10 ±  5%  perf-stat.i.dTLB-loads
>     187259 ± 10%     +69.8%     318016 ±  9%  perf-stat.i.dTLB-store-misses
>  3.956e+10           -22.8%  3.055e+10 ±  5%  perf-stat.i.dTLB-stores
>  1.177e+08 ±  6%     -35.3%   76112476 ±  6%  perf-stat.i.iTLB-load-misses
>  2.256e+11           -22.8%  1.742e+11 ±  5%  perf-stat.i.instructions
>       1992 ±  5%     +20.2%       2394 ±  2% 
> perf-stat.i.instructions-per-iTLB-miss
>       0.53           -23.9%       0.41 ±  6%  perf-stat.i.ipc
>       2.95            +2.7%       3.02        perf-stat.i.metric.GHz
>     490.25 ±  5%    +131.1%       1133 ±  6%  perf-stat.i.metric.K/sec
>       1073           -22.9%     827.94 ±  5%  perf-stat.i.metric.M/sec
>       6951 ±  4%     -13.4%       6017 ±  6%  perf-stat.i.minor-faults
>      87.95            +6.7       94.67       
> perf-stat.i.node-load-miss-rate%
>   23701486 ± 11%    +465.2%   1.34e+08 ±  3%  perf-stat.i.node-load-misses
>    2999385 ±  8%    +144.4%    7330698 ±  2%  perf-stat.i.node-loads
>      69.45 ±  2%     +28.6       98.01       
> perf-stat.i.node-store-miss-rate%
>   10499384 ±  8%    +314.7%   43541240 ±  3%  perf-stat.i.node-store-misses
>    4750209 ±  4%     -82.2%     845534 ± 29%  perf-stat.i.node-stores
>       6960 ±  4%     -13.4%       6027 ±  6%  perf-stat.i.page-faults
>      10.79           +10.8%      11.96        perf-stat.overall.MPKI
>       0.94            +0.2        1.13       
> perf-stat.overall.branch-miss-rate%
>       3.87 ±  6%     +11.2       15.04 ±  3% 
> perf-stat.overall.cache-miss-rate%
>       1.87           +33.4%       2.50 ±  5%  perf-stat.overall.cpi
>       4497 ±  5%     -69.1%       1389 ±  3% 
> perf-stat.overall.cycles-between-cache-misses
>       0.01 ±  2%      +0.0        0.01 ± 10% 
> perf-stat.overall.dTLB-load-miss-rate%
>       0.00 ± 10%      +0.0        0.00 ±  8% 
> perf-stat.overall.dTLB-store-miss-rate%
>       1923 ±  6%     +18.9%       2286 ±  2% 
> perf-stat.overall.instructions-per-iTLB-miss
>       0.53           -24.8%       0.40 ±  6%  perf-stat.overall.ipc
>      88.60            +6.2       94.80       
> perf-stat.overall.node-load-miss-rate%
>      68.41 ±  2%     +29.6       98.04       
> perf-stat.overall.node-store-miss-rate%
>  4.584e+10           -22.7%  3.545e+10 ±  4% 
> perf-stat.ps.branch-instructions
>   93789280 ±  5%    +232.8%  3.122e+08 ±  2%  perf-stat.ps.cache-misses
>  2.422e+09           -14.2%  2.078e+09 ±  5%  perf-stat.ps.cache-references
>  4.205e+11            +3.0%  4.332e+11        perf-stat.ps.cpu-cycles
>    1916167 ±  2%     +32.3%    2534886 ±  3%  perf-stat.ps.cpu-migrations
>  6.634e+10           -23.3%  5.091e+10 ±  5%  perf-stat.ps.dTLB-loads
>     185792 ± 10%     +70.4%     316635 ±  9% 
> perf-stat.ps.dTLB-store-misses
>  3.939e+10           -22.6%   3.05e+10 ±  5%  perf-stat.ps.dTLB-stores
>  1.171e+08 ±  6%     -35.0%   76093293 ±  6%  perf-stat.ps.iTLB-load-misses
>  2.245e+11           -22.6%  1.738e+11 ±  5%  perf-stat.ps.instructions
>       6810 ±  3%     -12.6%       5951 ±  6%  perf-stat.ps.minor-faults
>   23430403 ± 10%    +468.8%  1.333e+08 ±  3%  perf-stat.ps.node-load-misses
>    3007245 ±  8%    +142.9%    7304955        perf-stat.ps.node-loads
>   10398685 ±  7%    +316.5%   43306438 ±  3% 
> perf-stat.ps.node-store-misses
>    4785933 ±  4%     -81.8%     871562 ± 28%  perf-stat.ps.node-stores
>       6818 ±  3%     -12.6%       5961 ±  6%  perf-stat.ps.page-faults
>  3.473e+13           +38.3%  4.803e+13 ±  6%  perf-stat.total.instructions
>      42.84 ± 43%     -32.5       10.29 ±128% 
> perf-profile.calltrace.cycles-pp.__get_user_nocheck_8.perf_callchain_user.get_perf_callchain.perf_callchain.perf_prepare_sample
>      41.85 ± 43%     -31.8       10.04 ±128% 
> perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
>      41.79 ± 43%     -31.8       10.02 ±128% 
> perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
>      30.90 ± 43%     -23.5        7.40 ±127% 
> perf-profile.calltrace.cycles-pp.perf_callchain_user.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
>      18.12 ± 43%     -14.0        4.11 ±127% 
> perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
>      17.93 ± 43%     -13.9        4.07 ±127% 
> perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
>      14.00 ± 54%     -11.4        2.62 ±152% 
> perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__get_user_nocheck_8.perf_callchain_user.get_perf_callchain.perf_callchain
>      31.01 ±  9%     -10.5       20.50 ± 24% 
> perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.new_sync_read.vfs_read
>      31.10 ±  9%     -10.4       20.69 ± 23% 
> perf-profile.calltrace.cycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
>      13.76 ± 44%     -10.3        3.43 ±125% 
> perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
>      13.73 ± 44%     -10.3        3.42 ±125% 
> perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
>      41.24 ±  4%     -10.1       31.11 ± 11% 
> perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
>      13.51 ± 44%     -10.1        3.39 ±125% 
> perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
>      41.49 ±  4%      -9.7       31.83 ± 10% 
> perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
>      41.71 ±  4%      -9.1       32.56 ± 10% 
> perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
>      17.44 ±  5%      -8.2        9.20 ± 23% 
> perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
>      10.14 ± 44%      -8.2        1.98 ±151% 
> perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
>      17.53 ±  5%      -8.1        9.42 ± 22% 
> perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>      42.61 ±  4%      -8.0       34.58 ± 10% 
> perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>       9.46 ± 43%      -7.5        1.97 ±127% 
> perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate
>       9.20 ± 47%      -7.4        1.83 ±149% 
> perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__get_user_nocheck_8.perf_callchain_user.get_perf_callchain
>       9.20 ± 43%      -7.3        1.88 ±129% 
> perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair
>       9.11 ± 43%      -7.2        1.86 ±129% 
> perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity
>       9.99 ± 40%      -7.2        2.81 ± 71% 
> perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
>       9.27 ± 43%      -7.0        2.28 ±128% 
> perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
>       9.25 ± 43%      -7.0        2.28 ±128% 
> perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
>       9.28 ± 43%      -6.9        2.36 ±124% 
> perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
>       9.16 ± 43%      -6.9        2.26 ±128% 
> perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template
>       9.15 ± 43%      -6.9        2.29 ±125% 
> perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
>       9.04 ± 43%      -6.8        2.26 ±125% 
> perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
>      11.81 ± 27%      -6.7        5.15 ± 30% 
> perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
>      16.02 ±  4%      -6.6        9.38 ± 33% 
> perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.new_sync_read
>       8.83 ± 43%      -6.6        2.26 ±124% 
> perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.pipe_read.new_sync_read
>       8.66 ± 43%      -6.5        2.18 ±125% 
> perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.pipe_read
>       9.73 ± 39%      -6.5        3.25 ± 83% 
> perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       9.59 ± 42%      -6.5        3.12 ± 90% 
> perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
>      10.53 ± 33%      -5.7        4.78 ± 49% 
> perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
>       9.88 ± 39%      -5.7        4.15 ± 63% 
> perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>      35.84 ±  4%      -4.5       31.34 ±  8% 
> perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
>      36.07 ±  4%      -4.3       31.80 ±  7% 
> perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.36 ± 45%      -4.0        1.36 ±123% 
> perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
>       5.24 ± 46%      -3.9        1.29 ±125% 
> perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_loop
>       6.10 ±  7%      -3.8        2.34 ± 37% 
> perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
>      36.68 ±  3%      -3.6       33.04 ±  6% 
> perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>       3.86 ± 62%      -3.3        0.58 ±223% 
> perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
>       6.36 ±  7%      -3.1        3.22 ± 18% 
> perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>      37.32 ±  2%      -2.7       34.64 ±  5% 
> perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.start_thread
>       8.10 ± 26%      -2.4        5.66 ± 21% 
> perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       8.15 ± 26%      -2.4        5.76 ± 20% 
> perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       8.22 ± 25%      -2.3        5.91 ± 19% 
> perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.16 ±  7%      -2.0        1.19 ± 33% 
> perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule.pipe_read
>      38.53 ±  2%      -2.0       36.57 ±  4% 
> perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.start_thread
>      38.68            -1.8       36.84 ±  4% 
> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.start_thread
>       3.32 ±  6%      -1.7        1.63 ± 19% 
> perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.pipe_read.new_sync_read
>       1.04 ±  7%      -0.6        0.41 ± 72% 
> perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
>       0.32 ±102%      +0.8        1.08 ± 23% 
> perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel.start_thread
>       0.64 ± 10%      +0.8        1.44 ± 21% 
> perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
>       0.00            +0.8        0.81 ± 33% 
> perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single._raw_spin_unlock_irqrestore
>       0.90 ± 48%      +0.9        1.78 ± 26% 
> perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
>       0.00            +0.9        0.94 ± 22% 
> perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.new_sync_write.vfs_write.ksys_write
>       0.00            +0.9        0.94 ± 27% 
> perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>       0.00            +1.0        0.98 ± 29% 
> perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single._raw_spin_unlock_irqrestore.__wake_up_common_lock
>       0.00            +1.0        1.00 ± 28% 
> perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single._raw_spin_unlock_irqrestore.__wake_up_common_lock.pipe_write
>       0.12 ±223%      +1.0        1.15 ± 27% 
> perf-profile.calltrace.cycles-pp.task_h_load.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up
>       0.09 ±223%      +1.1        1.14 ± 29% 
> perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.new_sync_read
>       0.00            +1.1        1.09 ± 24% 
> perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_to_iter.copy_page_to_iter.pipe_read.new_sync_read
>       0.23 ±146%      +1.1        1.33 ± 18% 
> perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
>       0.47 ± 45%      +1.1        1.57 ± 17% 
> perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.new_sync_read
>       0.00            +1.1        1.11 ± 26% 
> perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single._raw_spin_unlock_irqrestore.__wake_up_common_lock.pipe_write.new_sync_write
>       0.00            +1.1        1.13 ± 46% 
> perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch
>       0.00            +1.2        1.20 ± 24% 
> perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>       0.00            +1.3        1.32 ± 40% 
> perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule
>       0.00            +1.3        1.34 ± 40% 
> perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule
>       0.18 ±141%      +1.3        1.53 ± 28% 
> perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
>       0.00            +1.4        1.36 ± 18% 
> perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule.pipe_read
>       0.33 ±100%      +1.4        1.70 ± 35% 
> perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.44 ±104%      +1.4        1.82 ± 23% 
> perf-profile.calltrace.cycles-pp.__fget_files.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +1.4        1.40 ± 25% 
> perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.pipe_write.new_sync_write
>       0.58 ± 80%      +1.4        1.99 ± 22% 
> perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       0.18 ±141%      +1.5        1.64 ± 28% 
> perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.new_sync_read.vfs_read
>       0.37 ±103%      +1.5        1.85 ± 27% 
> perf-profile.calltrace.cycles-pp.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
>       0.00            +1.5        1.49 ± 25% 
> perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.pipe_write.new_sync_write.vfs_write
>       0.00            +1.6        1.56 ± 27% 
> perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.new_sync_read.vfs_read
>       0.60 ± 81%      +1.7        2.27 ± 22% 
> perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>       1.03 ± 33%      +2.2        3.26 ± 29% 
> perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
>       0.56 ± 74%      +2.6        3.11 ± 28% 
> perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.new_sync_read.vfs_read.ksys_read
>       0.00            +3.0        2.99 ± 28% 
> perf-profile.calltrace.cycles-pp._copy_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
>       1.65 ± 32%      +3.8        5.43 ± 28% 
> perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
>       2.36 ± 33%      +5.3        7.61 ± 26% 
> perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
>       2.47 ± 33%      +5.5        7.97 ± 26% 
> perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>      45.25 ± 42%     -34.3       10.95 ±126% 
> perf-profile.children.cycles-pp.__perf_event_overflow
>      45.18 ± 42%     -34.3       10.93 ±126% 
> perf-profile.children.cycles-pp.perf_event_output_forward
>      45.97 ± 42%     -34.1       11.91 ±116% 
> perf-profile.children.cycles-pp.perf_tp_event
>      44.74 ± 42%     -33.9       10.82 ±126% 
> perf-profile.children.cycles-pp.perf_prepare_sample
>      44.00 ± 42%     -33.4       10.64 ±126% 
> perf-profile.children.cycles-pp.perf_callchain
>      43.94 ± 42%     -33.3       10.63 ±126% 
> perf-profile.children.cycles-pp.get_perf_callchain
>      32.59 ± 43%     -24.7        7.89 ±126% 
> perf-profile.children.cycles-pp.perf_callchain_user
>      32.34 ± 43%     -24.5        7.83 ±126% 
> perf-profile.children.cycles-pp.__get_user_nocheck_8
>      19.92 ± 42%     -14.9        5.05 ±114% 
> perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>      40.50 ± 12%     -13.6       26.91 ± 22% 
> perf-profile.children.cycles-pp.__schedule
>      40.47 ± 12%     -13.4       27.04 ± 22% 
> perf-profile.children.cycles-pp.schedule
>      21.52 ± 36%     -13.4        8.17 ± 62% 
> perf-profile.children.cycles-pp.update_curr
>      17.49 ± 41%     -12.9        4.64 ±114% 
> perf-profile.children.cycles-pp.native_irq_return_iret
>      14.83 ± 43%     -11.0        3.81 ±117% 
> perf-profile.children.cycles-pp.perf_trace_sched_switch
>      42.34 ±  4%     -10.7       31.63 ± 10% 
> perf-profile.children.cycles-pp.try_to_wake_up
>      42.51 ±  4%     -10.2       32.34 ± 10% 
> perf-profile.children.cycles-pp.autoremove_wake_function
>      13.06 ± 45%      -9.9        3.12 ±128% 
> perf-profile.children.cycles-pp.asm_exc_page_fault
>      42.72 ±  4%      -9.6       33.08 ±  9% 
> perf-profile.children.cycles-pp.__wake_up_common
>      43.67 ±  4%      -8.5       35.17 ±  9% 
> perf-profile.children.cycles-pp.__wake_up_common_lock
>      10.98 ± 42%      -8.3        2.64 ±125% 
> perf-profile.children.cycles-pp.perf_callchain_kernel
>       9.78 ± 45%      -7.4        2.34 ±128% 
> perf-profile.children.cycles-pp.exc_page_fault
>      16.53 ±  4%      -6.9        9.58 ± 33% 
> perf-profile.children.cycles-pp.dequeue_task_fair
>      18.15 ±  5%      -6.5       11.66 ± 24% 
> perf-profile.children.cycles-pp.enqueue_task_fair
>      10.64 ±  6%      -6.5        4.14 ± 36% 
> perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>      18.24 ±  5%      -6.3       11.90 ± 23% 
> perf-profile.children.cycles-pp.ttwu_do_activate
>       8.29 ± 42%      -6.3        1.96 ±125% 
> perf-profile.children.cycles-pp.unwind_next_frame
>      10.93 ± 33%      -6.0        4.88 ± 48% 
> perf-profile.children.cycles-pp.dequeue_entity
>      10.16 ± 38%      -5.9        4.22 ± 62% 
> perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>      12.40 ± 25%      -5.9        6.53 ± 31% 
> perf-profile.children.cycles-pp.enqueue_entity
>      11.22 ±  7%      -4.8        6.45 ± 13% 
> perf-profile.children.cycles-pp._raw_spin_lock
>      35.89 ±  4%      -4.4       31.45 ±  8% 
> perf-profile.children.cycles-pp.pipe_read
>      36.10 ±  4%      -4.3       31.85 ±  7% 
> perf-profile.children.cycles-pp.new_sync_read
>      95.76 ±  2%      -3.8       91.97 ±  2% 
> perf-profile.children.cycles-pp.do_syscall_64
>       4.85 ± 42%      -3.7        1.16 ±125% 
> perf-profile.children.cycles-pp.__unwind_start
>      96.04            -3.6       92.44 ±  2% 
> perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      36.72 ±  3%      -3.6       33.13 ±  6% 
> perf-profile.children.cycles-pp.vfs_read
>      37.36 ±  2%      -2.6       34.71 ±  5% 
> perf-profile.children.cycles-pp.ksys_read
>       8.57 ± 23%      -2.3        6.24 ± 18% 
> perf-profile.children.cycles-pp.exit_to_user_mode_loop
>       2.24 ± 42%      -1.7        0.53 ±126% 
> perf-profile.children.cycles-pp.__orc_find
>       2.02 ± 41%      -1.4        0.58 ±132% 
> perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
>       1.45 ± 44%      -1.1        0.34 ±127% 
> perf-profile.children.cycles-pp.bad_get_user
>       1.28 ± 42%      -1.0        0.32 ±125% 
> perf-profile.children.cycles-pp.unwind_get_return_address
>       1.25 ± 41%      -0.9        0.30 ±124% 
> perf-profile.children.cycles-pp.orc_find
>       0.97 ± 42%      -0.9        0.05 ± 45% 
> perf-profile.children.cycles-pp.copy_page_from_iter
>       1.19 ± 42%      -0.9        0.28 ±125% 
> perf-profile.children.cycles-pp.stack_access_ok
>       1.07 ± 42%      -0.8        0.26 ±126% 
> perf-profile.children.cycles-pp.__kernel_text_address
>       0.85 ± 42%      -0.6        0.21 ±125% 
> perf-profile.children.cycles-pp.kernel_text_address
>       0.80 ± 41%      -0.6        0.19 ±124% 
> perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
>       0.71 ± 40%      -0.5        0.18 ±123% 
> perf-profile.children.cycles-pp.fixup_exception
>       0.60 ± 40%      -0.5        0.15 ±124% 
> perf-profile.children.cycles-pp.search_exception_tables
>       0.58 ± 40%      -0.4        0.14 ±123% 
> perf-profile.children.cycles-pp.search_extable
>       0.56 ± 40%      -0.4        0.14 ±124% 
> perf-profile.children.cycles-pp.bsearch
>       0.45 ± 40%      -0.3        0.11 ±124% 
> perf-profile.children.cycles-pp.__perf_event_header__init_id
>       0.51 ± 19%      -0.3        0.24 ± 42% 
> perf-profile.children.cycles-pp.scheduler_tick
>       0.35 ± 37%      -0.3        0.09 ±121% 
> perf-profile.children.cycles-pp.cmp_ex_search
>       0.54 ± 17%      -0.3        0.28 ± 32% 
> perf-profile.children.cycles-pp.update_process_times
>       0.33 ± 43%      -0.3        0.08 ±125% 
> perf-profile.children.cycles-pp.core_kernel_text
>       0.54 ± 17%      -0.2        0.29 ± 31% 
> perf-profile.children.cycles-pp.tick_sched_handle
>       0.44 ± 20%      -0.2        0.19 ± 53% 
> perf-profile.children.cycles-pp.task_tick_fair
>       0.59 ± 15%      -0.2        0.35 ± 24% 
> perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.55 ± 16%      -0.2        0.32 ± 26% 
> perf-profile.children.cycles-pp.tick_sched_timer
>       0.26 ± 41%      -0.2        0.06 ±127% 
> perf-profile.children.cycles-pp.perf_output_begin_forward
>       0.24 ± 41%      -0.2        0.06 ±125% 
> perf-profile.children.cycles-pp.ftrace_graph_ret_addr
>       0.70 ± 12%      -0.2        0.54 ± 10% 
> perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.70 ± 12%      -0.2        0.54 ± 10% 
> perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.75 ± 11%      -0.2        0.60 ±  9% 
> perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.21 ± 41%      -0.2        0.06 ±121% 
> perf-profile.children.cycles-pp.__task_pid_nr_ns
>       0.15 ± 62%      -0.1        0.04 ± 72% 
> perf-profile.children.cycles-pp.__cmd_record
>       0.13 ± 14%      -0.0        0.10 ± 14% 
> perf-profile.children.cycles-pp.perf_trace_buf_alloc
>       0.06 ±  9%      +0.0        0.09 ± 11% 
> perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.04 ± 75%      +0.1        0.09 ± 22% 
> perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.07 ± 24%      +0.1        0.16 ± 21% 
> perf-profile.children.cycles-pp.anon_pipe_buf_release
>       0.00            +0.1        0.11 ± 29% 
> perf-profile.children.cycles-pp.__mnt_want_write
>       0.06 ±  9%      +0.1        0.18 ± 24% 
> perf-profile.children.cycles-pp.generic_update_time
>       0.01 ±223%      +0.1        0.16 ± 49% 
> perf-profile.children.cycles-pp.mutex_spin_on_owner
>       0.00            +0.2        0.18 ± 25% 
> perf-profile.children.cycles-pp.place_entity
>       0.06 ± 75%      +0.2        0.25 ± 46% 
> perf-profile.children.cycles-pp.remove_entity_load_avg
>       0.19 ± 38%      +0.2        0.41 ± 20% 
> perf-profile.children.cycles-pp.aa_file_perm
>       0.09 ±  4%      +0.2        0.32 ± 23% 
> perf-profile.children.cycles-pp.__mark_inode_dirty
>       0.23 ± 42%      +0.3        0.48 ± 23% 
> perf-profile.children.cycles-pp.atime_needs_update
>       0.02 ± 99%      +0.3        0.30 ± 22% 
> perf-profile.children.cycles-pp.llist_reverse_order
>       0.17 ± 40%      +0.4        0.58 ± 42% 
> perf-profile.children.cycles-pp.migrate_task_rq_fair
>       0.40 ± 34%      +0.4        0.82 ± 20% 
> perf-profile.children.cycles-pp.touch_atime
>       0.32 ± 24%      +0.6        0.87 ± 20% 
> perf-profile.children.cycles-pp.__list_del_entry_valid
>       0.55 ± 43%      +0.6        1.14 ± 24% 
> perf-profile.children.cycles-pp.apparmor_file_permission
>       0.12 ± 15%      +0.6        0.74 ± 20% 
> perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.62 ± 44%      +0.6        1.24 ± 25% 
> perf-profile.children.cycles-pp.security_file_permission
>       0.45 ± 43%      +0.6        1.08 ± 23% 
> perf-profile.children.cycles-pp.__pthread_disable_asynccancel
>       0.32 ± 29%      +0.6        0.95 ± 22% 
> perf-profile.children.cycles-pp.file_update_time
>       0.48 ± 26%      +0.6        1.13 ± 23% 
> perf-profile.children.cycles-pp.__update_load_avg_se
>       0.54 ± 31%      +0.7        1.20 ± 22% 
> perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.49 ± 31%      +0.7        1.16 ± 27% 
> perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
>       0.34 ± 46%      +0.7        1.04 ± 29% 
> perf-profile.children.cycles-pp.fput
>       0.00            +0.8        0.77 ± 29% 
> perf-profile.children.cycles-pp.__smp_call_single_queue
>       0.02 ± 99%      +0.8        0.80 ± 29% 
> perf-profile.children.cycles-pp.llist_add_batch
>       0.37 ± 49%      +0.8        1.15 ± 27% 
> perf-profile.children.cycles-pp.task_h_load
>       0.24 ± 37%      +0.8        1.07 ± 31% 
> perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.92 ± 47%      +0.9        1.80 ± 26% 
> perf-profile.children.cycles-pp.copy_page_to_iter
>       0.59 ± 33%      +1.0        1.59 ± 28% 
> perf-profile.children.cycles-pp.__switch_to_asm
>       0.74 ± 34%      +1.1        1.82 ± 27% 
> perf-profile.children.cycles-pp.switch_fpu_return
>       0.09 ± 31%      +1.1        1.21 ± 24% 
> perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.38 ± 48%      +1.1        1.51 ± 25% 
> perf-profile.children.cycles-pp.copyin
>       0.63 ± 50%      +1.3        1.90 ± 20% 
> perf-profile.children.cycles-pp.mutex_unlock
>       0.62 ± 43%      +1.3        1.90 ± 29% 
> perf-profile.children.cycles-pp.prepare_task_switch
>       0.87 ±  5%      +1.3        2.18 ± 11% 
> perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>       0.54 ± 43%      +1.3        1.85 ± 27% 
> perf-profile.children.cycles-pp.wake_affine
>       0.86 ± 44%      +1.4        2.22 ± 22% 
> perf-profile.children.cycles-pp.__fget_files
>       1.06 ± 42%      +1.6        2.64 ± 21% 
> perf-profile.children.cycles-pp.__fdget_pos
>       0.00            +1.6        1.59 ± 27% 
> perf-profile.children.cycles-pp._copy_to_iter
>       0.91 ±  9%      +1.6        2.51 ± 16% 
> perf-profile.children.cycles-pp.finish_task_switch
>       0.87 ± 45%      +1.8        2.62 ± 23% 
> perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       1.18 ± 43%      +2.1        3.24 ± 23% 
> perf-profile.children.cycles-pp.mutex_lock
>       0.71 ± 29%      +2.1        2.85 ± 27% 
> perf-profile.children.cycles-pp.available_idle_cpu
>       1.08 ± 33%      +2.3        3.39 ± 28% 
> perf-profile.children.cycles-pp.select_idle_cpu
>       0.90 ± 33%      +2.3        3.24 ± 27% 
> perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.73 ± 33%      +2.4        3.15 ± 28% 
> perf-profile.children.cycles-pp.prepare_to_wait_event
>       0.56 ± 22%      +2.8        3.41 ± 16% 
> perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.00            +3.0        3.01 ± 28% 
> perf-profile.children.cycles-pp._copy_from_iter
>       0.58 ± 22%      +3.4        3.97 ± 12% 
> perf-profile.children.cycles-pp.__sysvec_call_function_single
>       0.58 ± 22%      +3.4        4.03 ± 12% 
> perf-profile.children.cycles-pp.sysvec_call_function_single
>       1.71 ± 32%      +3.9        5.58 ± 28% 
> perf-profile.children.cycles-pp.select_idle_sibling
>       0.62 ± 22%      +3.9        4.52 ± 10% 
> perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>       2.42 ± 33%      +5.3        7.75 ± 26% 
> perf-profile.children.cycles-pp.select_task_rq_fair
>       2.53 ± 33%      +5.6        8.12 ± 26% 
> perf-profile.children.cycles-pp.select_task_rq
>      17.49 ± 41%     -12.9        4.64 ±114% 
> perf-profile.self.cycles-pp.native_irq_return_iret
>       8.85 ± 46%      -6.8        2.08 ±130% 
> perf-profile.self.cycles-pp.exc_page_fault
>      10.63 ±  6%      -6.5        4.14 ± 36% 
> perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       4.76 ± 43%      -3.6        1.12 ±126% 
> perf-profile.self.cycles-pp.__get_user_nocheck_8
>       3.48 ± 42%      -2.7        0.83 ±125% 
> perf-profile.self.cycles-pp.unwind_next_frame
>       2.23 ± 42%      -1.7        0.53 ±126% 
> perf-profile.self.cycles-pp.__orc_find
>       1.20 ± 41%      -0.9        0.29 ±124% 
> perf-profile.self.cycles-pp.orc_find
>       1.08 ± 42%      -0.8        0.25 ±124% 
> perf-profile.self.cycles-pp.stack_access_ok
>       0.91 ± 42%      -0.7        0.24 ±126% 
> perf-profile.self.cycles-pp.perf_callchain_kernel
>       0.46 ± 42%      -0.3        0.12 ±124% 
> perf-profile.self.cycles-pp.__unwind_start
>       0.36 ± 41%      -0.3        0.09 ±126% 
> perf-profile.self.cycles-pp.kernel_text_address
>       0.34 ± 38%      -0.3        0.08 ±124% 
> perf-profile.self.cycles-pp.cmp_ex_search
>       0.30 ± 44%      -0.2        0.07 ±127% 
> perf-profile.self.cycles-pp.asm_exc_page_fault
>       0.26 ± 42%      -0.2        0.07 ±127% 
> perf-profile.self.cycles-pp.get_perf_callchain
>       0.24 ± 41%      -0.2        0.06 ±127% 
> perf-profile.self.cycles-pp.perf_output_begin_forward
>       0.21 ± 40%      -0.2        0.06 ±121% 
> perf-profile.self.cycles-pp.__task_pid_nr_ns
>       0.15 ± 46%      -0.1        0.04 ± 45% 
> perf-profile.self.cycles-pp.copy_page_from_iter
>       0.00            +0.1        0.11 ± 27% 
> perf-profile.self.cycles-pp.__mnt_want_write
>       0.01 ±223%      +0.1        0.15 ± 51% 
> perf-profile.self.cycles-pp.mutex_spin_on_owner
>       0.08 ± 26%      +0.2        0.24 ± 32% 
> perf-profile.self.cycles-pp.ttwu_do_activate
>       0.16 ± 22%      +0.2        0.31 ± 18% 
> perf-profile.self.cycles-pp.dequeue_entity
>       0.00            +0.2        0.16 ± 23% 
> perf-profile.self.cycles-pp.place_entity
>       0.14 ± 34%      +0.2        0.31 ± 21% 
> perf-profile.self.cycles-pp.atime_needs_update
>       0.08 ± 56%      +0.2        0.25 ± 24% 
> perf-profile.self.cycles-pp.wake_affine
>       0.19 ± 34%      +0.2        0.40 ± 20% 
> perf-profile.self.cycles-pp.__fdget_pos
>       0.18 ± 39%      +0.2        0.38 ± 20% 
> perf-profile.self.cycles-pp.aa_file_perm
>       0.09 ±  5%      +0.2        0.30 ± 23% 
> perf-profile.self.cycles-pp.__mark_inode_dirty
>       0.08 ± 59%      +0.2        0.31 ± 41% 
> perf-profile.self.cycles-pp.migrate_task_rq_fair
>       0.22 ± 17%      +0.2        0.46 ± 20% 
> perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.14 ± 21%      +0.2        0.38 ± 18% 
> perf-profile.self.cycles-pp.finish_task_switch
>       0.12 ± 30%      +0.2        0.37 ± 27% 
> perf-profile.self.cycles-pp.select_task_rq
>       0.00            +0.3        0.25 ± 34% 
> perf-profile.self.cycles-pp._copy_to_iter
>       0.25 ± 41%      +0.3        0.50 ± 23% 
> perf-profile.self.cycles-pp.vfs_read
>       0.00            +0.3        0.26 ± 18% 
> perf-profile.self.cycles-pp.sched_ttwu_pending
>       0.52 ± 15%      +0.3        0.79 ± 10% 
> perf-profile.self.cycles-pp.perf_tp_event
>       0.02 ± 99%      +0.3        0.30 ± 22% 
> perf-profile.self.cycles-pp.llist_reverse_order
>       0.05 ± 74%      +0.3        0.34 ± 14% 
> perf-profile.self.cycles-pp.ttwu_queue_wakelist
>       0.14 ± 35%      +0.3        0.47 ± 22% 
> perf-profile.self.cycles-pp.file_update_time
>       0.04 ± 71%      +0.4        0.40 ± 15% 
> perf-profile.self.cycles-pp.__flush_smp_call_function_queue
>       0.25 ± 28%      +0.5        0.73 ± 21% 
> perf-profile.self.cycles-pp.dequeue_task_fair
>       0.22 ± 30%      +0.5        0.74 ± 21% 
> perf-profile.self.cycles-pp.__wake_up_common
>       0.29 ± 25%      +0.5        0.84 ± 20% 
> perf-profile.self.cycles-pp.__list_del_entry_valid
>       0.36 ± 30%      +0.6        0.92 ± 19% 
> perf-profile.self.cycles-pp.enqueue_task_fair
>       0.43 ± 45%      +0.6        1.00 ± 25% 
> perf-profile.self.cycles-pp.__pthread_disable_asynccancel
>       0.31 ± 46%      +0.6        0.94 ± 30% 
> perf-profile.self.cycles-pp.fput
>       0.48 ± 26%      +0.6        1.11 ± 23% 
> perf-profile.self.cycles-pp.__update_load_avg_se
>       0.52 ± 31%      +0.6        1.16 ± 21% 
> perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.56 ± 37%      +0.7        1.22 ± 22% 
> perf-profile.self.cycles-pp.pipe_read
>       0.49 ± 31%      +0.7        1.16 ± 27% 
> perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
>       0.23 ± 31%      +0.7        0.94 ± 23% 
> perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
>       0.02 ± 99%      +0.8        0.80 ± 29% 
> perf-profile.self.cycles-pp.llist_add_batch
>       0.37 ± 49%      +0.8        1.15 ± 27% 
> perf-profile.self.cycles-pp.task_h_load
>       0.24 ± 37%      +0.8        1.04 ± 31% 
> perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.34 ± 32%      +0.8        1.18 ± 29% 
> perf-profile.self.cycles-pp.select_idle_sibling
>       0.28 ± 35%      +0.8        1.13 ± 29% 
> perf-profile.self.cycles-pp.prepare_to_wait_event
>       0.40 ± 45%      +1.0        1.39 ± 28% 
> perf-profile.self.cycles-pp.prepare_task_switch
>       0.59 ± 33%      +1.0        1.59 ± 28% 
> perf-profile.self.cycles-pp.__switch_to_asm
>       0.54 ± 40%      +1.1        1.61 ± 28% 
> perf-profile.self.cycles-pp.pipe_write
>       0.61 ± 50%      +1.2        1.81 ± 20% 
> perf-profile.self.cycles-pp.mutex_unlock
>       0.85 ± 44%      +1.3        2.13 ± 22% 
> perf-profile.self.cycles-pp.__fget_files
>       0.00            +1.3        1.28 ± 33% 
> perf-profile.self.cycles-pp._copy_from_iter
>       0.77 ± 32%      +1.4        2.19 ± 24% 
> perf-profile.self.cycles-pp.__schedule
>       0.77 ± 44%      +1.5        2.31 ± 24% 
> perf-profile.self.cycles-pp.mutex_lock
>       0.84 ± 46%      +1.6        2.47 ± 23% 
> perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>       0.61 ± 37%      +1.7        2.34 ± 30% 
> perf-profile.self.cycles-pp._raw_spin_lock
>       0.69 ± 29%      +2.1        2.83 ± 27% 
> perf-profile.self.cycles-pp.available_idle_cpu
>       0.86 ± 32%      +2.4        3.21 ± 27% 
> perf-profile.self.cycles-pp._raw_spin_lock_irqsave
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are
> provided
> for informational purposes only. Any difference in system hardware or
> software
> design or configuration may affect actual performance.
> 
> 
> #regzbot introduced: 59bb69c67c
> 
