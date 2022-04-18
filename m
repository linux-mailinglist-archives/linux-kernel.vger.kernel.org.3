Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9C505AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbiDRPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbiDRPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:22:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824AED5542
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650291581; x=1681827581;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pxh/tZ5j+Gi52wPYD39tmFFYYUaLqmwJnUzeU8J2FJs=;
  b=VF0cnBmcfmupLHHVh2tKiKt8hDkWdMEufj5LPz88QJN99TnHjJZcs02f
   VPNBpkW5ey2+4435M6jkX90XLp2dMlLH1P9P5m17Po8NQO3aIBN3JJ6QJ
   2txVtdIobSlGV2cHMUwtaVyXyNgeCtd1Z114o7Z7R5layWMwn3qPQiBW/
   T9RBvDFwunbK5mkGX4LH6IHNPazvTS+1svoJzRfBSBStsG801CSL0BUru
   8Mblxl1ERq0hLGcqnPWLJFsVZrKPHZL1eMn4xn4TsXZAgtKey43k4miwH
   wOAnucavosp/hsiVvKeeZZ5LesAHhvLfZgSelcrnAKn16jZ72Nepqy4Xr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262986713"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="yaml'?scan'208";a="262986713"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:19:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="yaml'?scan'208";a="575589454"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:18:59 -0700
Date:   Mon, 18 Apr 2022 22:18:57 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: [sched/fair]  2cfb7a1b03:  stress-ng.fstat.ops_per_sec -19.8%
 regression
Message-ID: <20220418141856.GC25584@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


(please be noted we reported "[sched/fair]  2cfb7a1b03:  fsmark.files_per_sec
-26.2% regression" at
https://lore.kernel.org/all/20220303153108.GC14527@xsang-OptiPlex-9020/
when this is still on branch:
commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a ("sched/fair: Improve consistency of allowed NUMA balance calculations")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

now we noticed the similar performance changes as well as some others are
still existing on mainline, so report this again for information)


Greeting,

FYI, we noticed a -19.8% regression of stress-ng.fstat.ops_per_sec due to commit:


commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a ("sched/fair: Improve consistency of allowed NUMA balance calculations")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: stress-ng
on test machine: 96 threads 2 sockets Ice Lake with 256G memory
with following parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: f2fs
	class: filesystem
	test: fstat
	cpufreq_governor: performance
	ucode: 0xb000280


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.neatbench.CPU.fps 12.5% improvement        |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory      |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | option_a=CPU                                                                        |
|                  | test=neatbench-1.0.4                                                                |
|                  | ucode=0x500320a                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.neatbench.All.fps 15.2% improvement        |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory      |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | option_a=All (CPU + GPU)                                                            |
|                  | test=neatbench-1.0.4                                                                |
|                  | ucode=0x500320a                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec -9.9% regression                                       |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | disk=1BRD_48G                                                                       |
|                  | filesize=4M                                                                         |
|                  | fs=f2fs                                                                             |
|                  | iterations=1x                                                                       |
|                  | nr_threads=64t                                                                      |
|                  | sync_method=fsyncBeforeClose                                                        |
|                  | test_size=24G                                                                       |
|                  | ucode=0x500320a                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec -26.2% regression                                      |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | disk=1BRD_48G                                                                       |
|                  | filesize=4M                                                                         |
|                  | fs=ext4                                                                             |
|                  | iterations=1x                                                                       |
|                  | nr_threads=64t                                                                      |
|                  | sync_method=NoSync                                                                  |
|                  | test_size=24G                                                                       |
|                  | ucode=0x500320a                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -20.1% regression                            |
| test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                      |
| test parameters  | class=filesystem                                                                    |
|                  | cpufreq_governor=performance                                                        |
|                  | disk=1HDD                                                                           |
|                  | fs=xfs                                                                              |
|                  | nr_threads=10%                                                                      |
|                  | test=fstat                                                                          |
|                  | testtime=60s                                                                        |
|                  | ucode=0xb000280                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec -16.3% regression                                      |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | disk=1BRD_48G                                                                       |
|                  | filesize=4M                                                                         |
|                  | fs=ext4                                                                             |
|                  | iterations=1x                                                                       |
|                  | nr_threads=64t                                                                      |
|                  | sync_method=fsyncBeforeClose                                                        |
|                  | test_size=24G                                                                       |
|                  | ucode=0x500320a                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -20.2% regression                            |
| test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                      |
| test parameters  | class=filesystem                                                                    |
|                  | cpufreq_governor=performance                                                        |
|                  | disk=1HDD                                                                           |
|                  | fs=xfs                                                                              |
|                  | nr_threads=10%                                                                      |
|                  | test=fstat                                                                          |
|                  | testtime=60s                                                                        |
|                  | ucode=0xb000280                                                                     |
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
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp1/fstat/stress-ng/60s/0xb000280

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1910790           -19.8%    1531715        stress-ng.fstat.ops
     31846           -19.8%      25528        stress-ng.fstat.ops_per_sec
    824867 ±  5%     -30.7%     571652        stress-ng.time.involuntary_context_switches
      2888            +5.8%       3055        stress-ng.time.percent_of_cpu_this_job_got
      1626            +8.3%       1762        stress-ng.time.system_time
    165.22           -19.2%     133.56        stress-ng.time.user_time
   3574287           -20.1%    2855119        stress-ng.time.voluntary_context_switches
  19230901           -12.8%   16761104        cpuidle..usage
      2.88            -0.5        2.37        mpstat.cpu.all.usr%
     38279 ±  4%     -14.5%      32721        numa-meminfo.node1.Active(anon)
    308558 ±  5%     -16.2%     258505 ±  3%  sched_debug.cpu.avg_idle.stddev
    568500           -21.9%     444186        vmstat.system.cs
     68.58            -2.3%      67.01        iostat.cpu.idle
     28.61            +7.2%      30.67        iostat.cpu.system
      2.82           -17.7%       2.32        iostat.cpu.user
     58109 ±  2%      -9.2%      52752        meminfo.Active
     39809 ±  3%     -13.4%      34471 ±  2%  meminfo.Active(anon)
  22895621           -35.9%   14670649 ± 14%  meminfo.DirectMap2M
  19806137 ±  2%     -33.3%   13203212 ±  2%  numa-numastat.node0.local_node
  19870464 ±  2%     -33.3%   13253265 ±  2%  numa-numastat.node0.numa_hit
  16553028 ±  4%     -13.9%   14259589 ±  2%  numa-numastat.node1.local_node
  16565135 ±  4%     -13.7%   14292196 ±  2%  numa-numastat.node1.numa_hit
  19871046 ±  2%     -33.3%   13253475 ±  2%  numa-vmstat.node0.numa_hit
  19806719 ±  2%     -33.3%   13203423 ±  2%  numa-vmstat.node0.numa_local
      9591 ±  4%     -14.5%       8199        numa-vmstat.node1.nr_active_anon
      9591 ±  4%     -14.5%       8199        numa-vmstat.node1.nr_zone_active_anon
  16565272 ±  4%     -13.7%   14292210 ±  2%  numa-vmstat.node1.numa_hit
  16553148 ±  4%     -13.9%   14259557 ±  2%  numa-vmstat.node1.numa_local
    101175 ±  5%     -23.9%      77036        turbostat.C1
  18210758 ±  6%     -17.7%   14992364 ±  5%  turbostat.C1E
      0.29 ± 10%     -26.5%       0.21 ±  6%  turbostat.IPC
      0.18 ± 26%      -0.1        0.05 ± 68%  turbostat.PKG_%
     24063 ±  4%     -23.3%      18463 ±  2%  turbostat.POLL
      0.02            -0.0        0.01        turbostat.POLL%
      9964 ±  3%     -13.4%       8632 ±  2%  proc-vmstat.nr_active_anon
    115321            -1.8%     113295        proc-vmstat.nr_inactive_anon
     25779            -3.7%      24818        proc-vmstat.nr_kernel_stack
     42573            -7.1%      39538        proc-vmstat.nr_shmem
      9964 ±  3%     -13.4%       8632 ±  2%  proc-vmstat.nr_zone_active_anon
    115321            -1.8%     113295        proc-vmstat.nr_zone_inactive_anon
  36437989           -24.4%   27549314        proc-vmstat.numa_hit
  36361554           -24.5%   27467330        proc-vmstat.numa_local
      1905 ±  2%      -8.9%       1735 ±  4%  proc-vmstat.pgactivate
  36389058           -24.3%   27528706        proc-vmstat.pgalloc_normal
  36169726           -24.5%   27314323        proc-vmstat.pgfree
      7.92 ±  5%     +15.5%       9.15 ±  5%  perf-stat.i.MPKI
 1.433e+10           -21.0%  1.132e+10        perf-stat.i.branch-instructions
      0.92 ±  5%      +0.1        1.02 ±  4%  perf-stat.i.branch-miss-rate%
 1.247e+08 ±  2%     -13.0%  1.085e+08        perf-stat.i.branch-misses
     16.99 ±  2%      +8.3       25.31 ±  2%  perf-stat.i.cache-miss-rate%
  1.01e+08           +34.7%   1.36e+08        perf-stat.i.cache-misses
 5.967e+08 ±  2%     -10.7%   5.33e+08        perf-stat.i.cache-references
    591451           -22.7%     457367        perf-stat.i.context-switches
      1.37           +30.5%       1.79        perf-stat.i.cpi
 1.035e+11            +4.2%  1.079e+11        perf-stat.i.cpu-cycles
      9193 ±  6%     +39.7%      12844 ±  2%  perf-stat.i.cpu-migrations
      1061           -21.1%     837.52 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.03 ± 28%      +0.0        0.04 ± 19%  perf-stat.i.dTLB-load-miss-rate%
   4758679 ± 12%     +23.7%    5884602 ±  9%  perf-stat.i.dTLB-load-misses
  2.18e+10           -21.1%  1.719e+10        perf-stat.i.dTLB-loads
   1489612 ±  3%     -11.2%    1322879 ±  5%  perf-stat.i.dTLB-store-misses
 1.297e+10           -21.6%  1.017e+10        perf-stat.i.dTLB-stores
 7.708e+10           -21.2%  6.074e+10        perf-stat.i.instructions
      0.74           -23.8%       0.56        perf-stat.i.ipc
      1.08            +4.2%       1.12        perf-stat.i.metric.GHz
    842.21           +20.6%       1015        perf-stat.i.metric.K/sec
    517.46           -21.1%     408.30        perf-stat.i.metric.M/sec
     85.06            +5.7       90.75        perf-stat.i.node-load-miss-rate%
  13175467 ±  2%     +61.3%   21248434        perf-stat.i.node-load-misses
   2181296 ±  2%     -14.2%    1871438        perf-stat.i.node-loads
     19.61 ±  2%     +16.4       35.98        perf-stat.i.node-store-miss-rate%
  11968394 ±  2%    +115.9%   25835847        perf-stat.i.node-store-misses
  50644280           -10.0%   45599834        perf-stat.i.node-stores
      7.83           +13.1%       8.85        perf-stat.overall.MPKI
      0.87 ±  3%      +0.1        0.96        perf-stat.overall.branch-miss-rate%
     16.74 ±  2%      +8.2       24.96        perf-stat.overall.cache-miss-rate%
      1.34           +31.3%       1.76        perf-stat.overall.cpi
      1025           -22.2%     798.32        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 12%      +0.0        0.03 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  3%      +0.0        0.01 ±  6%  perf-stat.overall.dTLB-store-miss-rate%
      0.74           -23.8%       0.57        perf-stat.overall.ipc
     85.82            +6.0       91.82        perf-stat.overall.node-load-miss-rate%
     19.23 ±  2%     +16.6       35.87        perf-stat.overall.node-store-miss-rate%
 1.416e+10           -20.6%  1.125e+10        perf-stat.ps.branch-instructions
 1.233e+08 ±  2%     -12.7%  1.077e+08        perf-stat.ps.branch-misses
  99801466           +33.7%  1.334e+08        perf-stat.ps.cache-misses
 5.962e+08 ±  2%     -10.3%  5.347e+08        perf-stat.ps.cache-references
    582660           -22.2%     453372        perf-stat.ps.context-switches
 1.024e+11            +4.0%  1.065e+11        perf-stat.ps.cpu-cycles
      9286 ±  5%     +36.7%      12693 ±  2%  perf-stat.ps.cpu-migrations
   4738332 ± 12%     +22.6%    5807697 ±  9%  perf-stat.ps.dTLB-load-misses
 2.152e+10           -20.7%  1.707e+10        perf-stat.ps.dTLB-loads
   1467487 ±  3%     -11.0%    1305700 ±  5%  perf-stat.ps.dTLB-store-misses
 1.279e+10           -21.1%  1.009e+10        perf-stat.ps.dTLB-stores
 7.618e+10           -20.7%  6.038e+10        perf-stat.ps.instructions
  13071092 ±  2%     +59.6%   20858289        perf-stat.ps.node-load-misses
   2158639 ±  2%     -13.9%    1859163 ±  2%  perf-stat.ps.node-loads
  11864450 ±  2%    +112.2%   25178871        perf-stat.ps.node-store-misses
  49828833            -9.7%   45018219        perf-stat.ps.node-stores
 4.792e+12           -21.0%  3.787e+12        perf-stat.total.instructions
      9.68            -2.4        7.31        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      9.68            -2.4        7.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.66            -2.4        7.29        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.66            -2.4        7.30        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.97            -2.3        7.62        perf-profile.calltrace.cycles-pp.__clone
      7.55 ±  2%      -2.2        5.34        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.81 ±  2%      -1.8        4.00 ±  2%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.54 ±  3%      -1.6        2.99 ±  3%  perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      4.17 ±  3%      -1.4        2.77 ±  3%  perf-profile.calltrace.cycles-pp.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      1.92            -1.3        0.63 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx
      3.06 ±  5%      -1.1        1.92 ±  5%  perf-profile.calltrace.cycles-pp.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      3.72            -1.0        2.76        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx
      2.72 ±  5%      -0.9        1.78 ±  5%  perf-profile.calltrace.cycles-pp.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      2.50 ±  4%      -0.8        1.67        perf-profile.calltrace.cycles-pp.ret_from_fork
      2.50 ±  4%      -0.8        1.67        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      2.44 ±  3%      -0.8        1.63        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      1.93 ±  3%      -0.8        1.17 ±  2%  perf-profile.calltrace.cycles-pp.__vunmap.free_work.process_one_work.worker_thread.kthread
      1.98 ±  3%      -0.8        1.22        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      1.96 ±  3%      -0.8        1.20 ±  2%  perf-profile.calltrace.cycles-pp.free_work.process_one_work.worker_thread.kthread.ret_from_fork
      2.49            -0.7        1.80        perf-profile.calltrace.cycles-pp.__entry_text_start.statx
      2.95            -0.7        2.29        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      2.45            -0.6        1.81        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      2.48            -0.6        1.85        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64
      1.40 ±  6%      -0.6        0.84 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      2.18 ±  2%      -0.6        1.63        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.do_statx
      1.23 ±  3%      -0.5        0.70 ±  2%  perf-profile.calltrace.cycles-pp.remove_vm_area.__vunmap.free_work.process_one_work.worker_thread
      1.32 ±  6%      -0.5        0.80 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      1.46            -0.4        1.08        perf-profile.calltrace.cycles-pp.__fxstat
      1.40 ±  2%      -0.4        1.03        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat
      5.54            -0.4        5.17        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.41            -0.4        1.05        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newlstat
      5.47            -0.4        5.11        perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
      5.46            -0.4        5.10        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      4.23            -0.4        3.88 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      3.90            -0.4        3.55 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.30 ±  2%      -0.3        1.97 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.99            -0.3        3.65        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      1.58            -0.3        1.25        perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      2.28 ±  2%      -0.3        1.94 ±  2%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.49            -0.3        1.17        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task
      2.46 ±  2%      -0.3        2.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.46 ±  2%      -0.3        2.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.45 ±  2%      -0.3        2.16        perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.45 ±  2%      -0.3        2.16        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.10 ±  3%      -0.3        0.84        perf-profile.calltrace.cycles-pp.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      0.99            -0.3        0.74        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.user_path_at_empty.vfs_statx.do_statx
      0.82 ±  2%      -0.2        0.58        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      1.12 ±  2%      -0.2        0.91        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74            -0.2        0.54 ±  4%  perf-profile.calltrace.cycles-pp.shim_statx
      0.87 ±  3%      -0.2        0.68 ±  2%  perf-profile.calltrace.cycles-pp.vm_area_alloc_pages.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      1.66            -0.2        1.47        perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.74 ±  2%      -0.2        0.56        perf-profile.calltrace.cycles-pp.cp_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.67            -0.2        1.49        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.81 ±  3%      -0.2        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_bulk.vm_area_alloc_pages.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      2.07            -0.2        1.92        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83 ±  2%      -0.1        0.68        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.do_syscall_64
      1.10 ±  2%      -0.0        1.05 ±  2%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.66 ±  2%      -0.0        0.61        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.09 ±  2%      -0.0        1.05 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.56 ±  2%      +0.0        0.58        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.99            +0.1        1.06        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      0.80 ±  3%      +0.1        0.87        perf-profile.calltrace.cycles-pp.start_thread
     28.57            +0.2       28.79        perf-profile.calltrace.cycles-pp.statx
      1.49            +0.3        1.80        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      1.45            +0.3        1.77        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.do_statx.__x64_sys_statx
      1.48            +0.3        1.81        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.44            +0.3        1.77        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.__do_sys_newlstat.do_syscall_64
      1.45            +0.3        1.80        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.41            +0.4        1.76        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.__do_sys_newstat.do_syscall_64
     13.44            +0.5       13.91        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
     12.56            +1.1       13.61        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.49            +1.1       12.60        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.26            +1.4       25.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.statx
     23.81            +1.5       25.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      5.18 ±  2%      +1.6        6.74        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.do_statx
      5.48            +1.6        7.06        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      5.46            +1.6        7.04        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.do_statx.__x64_sys_statx
      9.01            +1.6       10.62        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx
      5.07 ±  2%      +1.6        6.70        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.__do_sys_newlstat
      5.37 ±  2%      +1.6        7.02        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.34 ±  2%      +1.6        6.99        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.__do_sys_newlstat.do_syscall_64
      4.98 ±  2%      +1.7        6.64        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.__do_sys_newstat
      5.28 ±  2%      +1.7        6.96        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.75            +1.7       10.43        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.do_statx
      5.25 ±  2%      +1.7        6.94        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.__do_sys_newstat.do_syscall_64
      9.73            +1.8       11.52        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      9.54            +1.8       11.36        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat
      8.63            +1.8       10.46        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64
     22.50            +1.8       24.34        perf-profile.calltrace.cycles-pp.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      8.47            +1.9       10.33        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newlstat
     22.04            +2.0       24.00        perf-profile.calltrace.cycles-pp.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
     22.00            +2.2       24.15        perf-profile.calltrace.cycles-pp.__lxstat64
     22.94            +2.2       25.11        perf-profile.calltrace.cycles-pp.__xstat
     20.96            +2.2       23.19        perf-profile.calltrace.cycles-pp.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.41            +2.6       23.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat
     20.44            +2.6       23.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lxstat64
     21.23            +2.6       23.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat
     20.26            +2.6       22.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     20.55            +2.8       23.34        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat
     19.59            +2.8       22.39        perf-profile.calltrace.cycles-pp.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     18.82            +3.0       21.80        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     19.77            +3.0       22.74        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat
     20.82            +6.3       27.16        perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
     20.66            +6.4       27.04        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
     20.40            +6.4       26.84        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
     19.93            +6.5       26.44        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      9.67            -2.4        7.31        perf-profile.children.cycles-pp.__do_sys_clone
      9.66            -2.4        7.30        perf-profile.children.cycles-pp.kernel_clone
      9.99            -2.4        7.63        perf-profile.children.cycles-pp.__clone
      9.08            -2.3        6.74        perf-profile.children.cycles-pp.getname_flags
      7.56 ±  2%      -2.2        5.35        perf-profile.children.cycles-pp.copy_process
      5.81 ±  2%      -1.8        4.00 ±  2%  perf-profile.children.cycles-pp.dup_task_struct
      4.54 ±  3%      -1.6        2.99 ±  3%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      3.18 ±  3%      -1.4        1.74 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.61 ±  3%      -1.4        2.17 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      4.17 ±  3%      -1.4        2.77 ±  3%  perf-profile.children.cycles-pp.__vmalloc_node_range
      5.13            -1.3        3.80        perf-profile.children.cycles-pp.strncpy_from_user
      3.06 ±  5%      -1.1        1.93 ±  5%  perf-profile.children.cycles-pp.__get_vm_area_node
      2.72 ±  5%      -0.9        1.78 ±  5%  perf-profile.children.cycles-pp.alloc_vmap_area
      3.36            -0.9        2.45        perf-profile.children.cycles-pp.__entry_text_start
      2.50 ±  4%      -0.8        1.67        perf-profile.children.cycles-pp.kthread
      2.44 ±  3%      -0.8        1.63        perf-profile.children.cycles-pp.worker_thread
      2.66 ±  3%      -0.8        1.86        perf-profile.children.cycles-pp.ret_from_fork
      1.94 ±  3%      -0.8        1.17        perf-profile.children.cycles-pp.__vunmap
      1.96 ±  3%      -0.8        1.20 ±  2%  perf-profile.children.cycles-pp.free_work
      1.98 ±  3%      -0.8        1.23        perf-profile.children.cycles-pp.process_one_work
      2.88            -0.8        2.13        perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.02            -0.7        2.34        perf-profile.children.cycles-pp.link_path_walk
      2.44            -0.6        1.83        perf-profile.children.cycles-pp.kmem_cache_alloc
      2.19            -0.6        1.62        perf-profile.children.cycles-pp.__check_object_size
      1.23 ±  3%      -0.5        0.70 ±  2%  perf-profile.children.cycles-pp.remove_vm_area
      1.84 ±  2%      -0.5        1.36        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.68            -0.4        1.23        perf-profile.children.cycles-pp.__fxstat
      0.79 ±  3%      -0.4        0.38 ±  4%  perf-profile.children.cycles-pp.find_vmap_area
      2.17 ±  2%      -0.4        1.78        perf-profile.children.cycles-pp.kmem_cache_free
      5.54            -0.4        5.17        perf-profile.children.cycles-pp.do_idle
      5.54            -0.4        5.17        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      5.54            -0.4        5.17        perf-profile.children.cycles-pp.cpu_startup_entry
      4.28            -0.4        3.93 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      2.33 ±  2%      -0.3        1.99 ±  2%  perf-profile.children.cycles-pp.intel_idle
      4.04            -0.3        3.70        perf-profile.children.cycles-pp.cpuidle_enter
      4.03            -0.3        3.69        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.31 ±  2%      -0.3        1.97 ±  2%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      1.59            -0.3        1.26        perf-profile.children.cycles-pp.find_idlest_group
      2.95            -0.3        2.62        perf-profile.children.cycles-pp.walk_component
      1.53            -0.3        1.20        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.80 ±  3%      -0.3        0.49 ±  3%  perf-profile.children.cycles-pp.free_vmap_area_noflush
      1.21 ±  2%      -0.3        0.92        perf-profile.children.cycles-pp._copy_to_user
      1.20 ±  2%      -0.3        0.90        perf-profile.children.cycles-pp.__might_resched
      1.26            -0.3        0.97        perf-profile.children.cycles-pp.cp_new_stat
      1.11 ±  2%      -0.3        0.85        perf-profile.children.cycles-pp.__vmalloc_area_node
      3.12 ±  2%      -0.3        2.86        perf-profile.children.cycles-pp.__x64_sys_exit
      3.12 ±  2%      -0.3        2.86        perf-profile.children.cycles-pp.do_exit
      0.91 ±  2%      -0.2        0.69        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      3.18 ±  3%      -0.2        2.96        perf-profile.children.cycles-pp.__schedule
      0.97 ±  2%      -0.2        0.76        perf-profile.children.cycles-pp.__might_fault
      1.12 ±  2%      -0.2        0.91        perf-profile.children.cycles-pp.exit_notify
      0.77            -0.2        0.57        perf-profile.children.cycles-pp.__check_heap_object
      0.77 ±  2%      -0.2        0.56 ±  4%  perf-profile.children.cycles-pp.shim_statx
      0.87 ±  3%      -0.2        0.68 ±  2%  perf-profile.children.cycles-pp.vm_area_alloc_pages
      0.34 ±  3%      -0.2        0.16 ±  6%  perf-profile.children.cycles-pp.find_vm_area
      0.90 ±  2%      -0.2        0.71        perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.76 ±  2%      -0.2        0.57        perf-profile.children.cycles-pp.cp_statx
      1.66            -0.2        1.48        perf-profile.children.cycles-pp.find_idlest_cpu
      0.82 ±  3%      -0.2        0.65 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_bulk
      1.62 ±  3%      -0.2        1.45        perf-profile.children.cycles-pp.lookup_fast
      1.68            -0.2        1.51        perf-profile.children.cycles-pp.select_task_rq_fair
      0.71 ±  2%      -0.2        0.54        perf-profile.children.cycles-pp.vfs_getattr_nosec
      1.46 ±  5%      -0.2        1.30 ±  2%  perf-profile.children.cycles-pp.schedule
      2.07            -0.2        1.92        perf-profile.children.cycles-pp.wake_up_new_task
      0.56 ±  2%      -0.2        0.41        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.55 ±  3%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.89 ±  6%      -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.83 ±  2%      -0.1        0.68        perf-profile.children.cycles-pp.release_task
      0.59 ±  3%      -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      0.76 ±  2%      -0.1        0.62        perf-profile.children.cycles-pp.path_init
      0.73            -0.1        0.60        perf-profile.children.cycles-pp.inode_permission
      0.50 ±  3%      -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.62            -0.1        0.50        perf-profile.children.cycles-pp.__might_sleep
      0.60 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.sched_yield
      0.90            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.step_into
      0.41 ±  3%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.40 ±  5%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.52 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.memcpy_erms
      0.51 ±  2%      -0.1        0.41        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.35 ±  2%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.50 ±  2%      -0.1        0.41        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.31 ±  2%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.alloc_pid
      0.26 ±  4%      -0.1        0.17 ±  6%  perf-profile.children.cycles-pp.insert_vmap_area
      0.37 ±  2%      -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.38            -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.33 ±  2%      -0.1        0.25        perf-profile.children.cycles-pp.pfn_valid
      0.59 ±  5%      -0.1        0.52 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.43            -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.generic_permission
      0.29 ±  3%      -0.1        0.22        perf-profile.children.cycles-pp.map_id_up
      0.29 ±  3%      -0.1        0.22        perf-profile.children.cycles-pp.putname
      0.29            -0.1        0.22        perf-profile.children.cycles-pp.cpumask_next
      0.22 ±  2%      -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.55 ±  6%      -0.1        0.48 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.43 ±  5%      -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.28 ±  2%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.21 ±  4%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.cgroup_can_fork
      0.30 ±  5%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.17 ±  4%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.cgroup_release
      0.30 ±  2%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.terminate_walk
      0.22 ±  6%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.25 ±  2%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.cgroup_free
      0.19 ±  5%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.cgroup_post_fork
      0.36            -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.24 ±  3%      -0.1        0.19 ±  8%  perf-profile.children.cycles-pp.refcount_dec_not_one
      0.34 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.nd_jump_root
      1.12 ±  2%      -0.0        1.07 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.32 ±  5%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.stress_fstat_helper
      0.20 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.22 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.generic_fillattr
      0.23 ±  4%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.page_counter_charge
      0.18 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.security_inode_permission
      0.17 ±  5%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.vfs_fstat
      0.12 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.insert_vmap_area_augment
      0.17 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__x64_sys_newlstat
      0.28 ±  5%      -0.0        0.24        perf-profile.children.cycles-pp.try_to_wake_up
      0.45 ±  5%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.page_counter_cancel
      0.37            -0.0        0.33 ±  6%  perf-profile.children.cycles-pp.__put_task_struct
      0.17 ±  5%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.from_kuid_munged
      0.22 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.21            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.20 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.17 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.from_kgid_munged
      0.16 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__x64_sys_newstat
      0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.76 ±  2%      -0.0        0.72 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.15 ±  3%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.add_device_randomness
      0.44 ±  2%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.__exit_signal
      0.18 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.perf_event_task_output
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.cgroup_exit
      0.29            -0.0        0.25        perf-profile.children.cycles-pp.dequeue_entity
      0.12 ±  6%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.rb_insert_color
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pids_can_fork
      0.14 ±  3%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.sched_post_fork
      0.21 ±  3%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.29 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp._find_next_bit
      0.13 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.24 ±  4%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.32 ±  4%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.sched_move_task
      0.07            -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.idr_alloc_u32
      0.14            -0.0        0.11        perf-profile.children.cycles-pp.do_sched_yield
      0.07 ±  9%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.refill_stock
      0.16 ±  5%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.wake_up_q
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.10 ±  6%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.cgroup_css_set_fork
      0.16 ±  6%      -0.0        0.14 ± 11%  perf-profile.children.cycles-pp.menu_select
      0.09 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.cpu_cgroup_fork
      0.07 ±  5%      -0.0        0.05 ± 50%  perf-profile.children.cycles-pp.pids_release
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.copy_thread
      0.11            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._mix_pool_bytes
      0.13 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.allocate_slab
      0.09 ±  7%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.task_rq_lock
      0.09 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.__x64_sys_newfstat
      0.16 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.mntput_no_expire
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.queue_work_on
      0.19 ±  4%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.14 ±  4%      -0.0        0.12        perf-profile.children.cycles-pp.__queue_work
      0.09 ±  7%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.10 ± 10%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.vunmap_range_noflush
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_event_fork
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.idr_alloc_cyclic
      0.06            -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.__call_rcu
      0.13 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.ttwu_do_activate
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_fork_fair
      0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.12 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.25 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.should_failslab
      0.08 ±  8%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__purge_vmap_area_lazy
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_change_group_fair
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.rb_erase
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.12 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.21 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__free_pages
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.do_prlimit
      0.06 ±  7%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.free_pid
      0.07 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.pid_revalidate
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.stress_fstat
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.proc_fd_link
      0.06 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.taskstats_exit
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tid_fd_revalidate
      0.12 ±  6%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.pthread_create
      0.24 ±  2%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.schedule_tail
      0.06 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.try_get_compound_head
      0.26 ±  3%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.get_pid_task
      0.05 ± 45%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.llist_add_batch
      0.14 ±  2%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.kfree
      0.14 ±  5%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.__slab_free
      0.27 ±  5%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.23 ±  4%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.pick_link
      0.13 ±  5%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.get_futex_key
      0.28 ±  4%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.11 ±  6%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.gup_pgd_range
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.task_dump_owner
      0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.lockless_pages_from_mm
      0.12 ±  5%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.internal_get_user_pages_fast
      0.13 ±  7%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.08 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.gup_pte_range
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__cleanup_sighand
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.18 ±  5%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.82 ±  3%      +0.1        0.88        perf-profile.children.cycles-pp.start_thread
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.memset_erms
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.52 ±  4%      +0.1        0.64 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      4.46            +1.0        5.43        perf-profile.children.cycles-pp.security_inode_getattr
      4.32            +1.0        5.32        perf-profile.children.cycles-pp.common_perm_cond
     22.55            +1.8       24.37        perf-profile.children.cycles-pp.__x64_sys_statx
     22.08            +2.0       24.03        perf-profile.children.cycles-pp.do_statx
     22.42            +2.0       24.46        perf-profile.children.cycles-pp.__lxstat64
     23.37            +2.1       25.42        perf-profile.children.cycles-pp.__xstat
     37.65            +2.6       40.24        perf-profile.children.cycles-pp.user_path_at_empty
     20.58            +2.8       23.36        perf-profile.children.cycles-pp.__do_sys_newstat
     19.61            +2.8       22.40        perf-profile.children.cycles-pp.__do_sys_newlstat
     81.83            +3.5       85.35        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     81.06            +3.7       84.77        perf-profile.children.cycles-pp.do_syscall_64
     16.16            +4.9       21.05        perf-profile.children.cycles-pp.path_put
     15.40 ±  2%      +4.9       20.31        perf-profile.children.cycles-pp.lockref_put_or_lock
     16.38            +5.0       21.33        perf-profile.children.cycles-pp.dput
     27.42            +5.2       32.65        perf-profile.children.cycles-pp.filename_lookup
     26.88            +5.3       32.22        perf-profile.children.cycles-pp.path_lookupat
     20.85            +6.3       27.18        perf-profile.children.cycles-pp.complete_walk
     20.72            +6.4       27.08        perf-profile.children.cycles-pp.try_to_unlazy
     20.63            +6.4       27.08        perf-profile.children.cycles-pp.__legitimize_path
     20.14            +6.5       26.69        perf-profile.children.cycles-pp.lockref_get_not_dead
     59.67            +8.1       67.82        perf-profile.children.cycles-pp.vfs_statx
      3.15 ±  3%      -1.4        1.73 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.84            -0.7        2.09        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.29 ±  2%      -0.6        1.69        perf-profile.self.cycles-pp.strncpy_from_user
      1.97            -0.5        1.43        perf-profile.self.cycles-pp.statx
      1.32 ±  2%      -0.3        0.97        perf-profile.self.cycles-pp.kmem_cache_alloc
      1.25 ±  2%      -0.3        0.91        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      2.30 ±  2%      -0.3        1.96 ±  2%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      1.22 ±  2%      -0.3        0.90        perf-profile.self.cycles-pp.__entry_text_start
      1.09 ±  2%      -0.3        0.83        perf-profile.self.cycles-pp.__might_resched
      1.03 ±  2%      -0.3        0.77 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      1.28            -0.3        1.01 ±  2%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.88 ±  2%      -0.2        0.64 ±  2%  perf-profile.self.cycles-pp.link_path_walk
      0.85 ±  2%      -0.2        0.62        perf-profile.self.cycles-pp.__check_object_size
      0.87 ±  8%      -0.2        0.65 ±  9%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.86            -0.2        0.64        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.88 ±  2%      -0.2        0.66        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.79            -0.2        0.59        perf-profile.self.cycles-pp.getname_flags
      0.72 ±  2%      -0.2        0.53 ±  4%  perf-profile.self.cycles-pp.shim_statx
      0.70            -0.2        0.52        perf-profile.self.cycles-pp.__check_heap_object
      0.70 ±  2%      -0.2        0.52        perf-profile.self.cycles-pp.do_syscall_64
      0.64            -0.2        0.47        perf-profile.self.cycles-pp.__lxstat64
      0.64            -0.2        0.47        perf-profile.self.cycles-pp.__xstat
      0.92 ±  2%      -0.1        0.78        perf-profile.self.cycles-pp._raw_spin_lock
      0.59 ±  3%      -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.57 ±  2%      -0.1        0.43        perf-profile.self.cycles-pp.vfs_statx
      0.85 ±  6%      -0.1        0.71 ±  2%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.53 ±  2%      -0.1        0.41        perf-profile.self.cycles-pp.step_into
      0.47 ±  2%      -0.1        0.35        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.44 ±  2%      -0.1        0.32        perf-profile.self.cycles-pp.__x64_sys_statx
      0.52 ±  2%      -0.1        0.41        perf-profile.self.cycles-pp.filename_lookup
      0.47 ±  2%      -0.1        0.36        perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.46 ±  3%      -0.1        0.36        perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.36 ±  2%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__fxstat
      0.52            -0.1        0.42        perf-profile.self.cycles-pp.memcpy_erms
      0.35 ±  3%      -0.1        0.25 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.51 ±  2%      -0.1        0.42        perf-profile.self.cycles-pp.__might_sleep
      0.36            -0.1        0.27        perf-profile.self.cycles-pp.path_lookupat
      0.40            -0.1        0.31        perf-profile.self.cycles-pp.lookup_fast
      0.32 ±  2%      -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.path_init
      0.32            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.do_statx
      0.30 ±  3%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.user_path_at_empty
      0.34 ±  2%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.walk_component
      0.24 ±  3%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.find_vmap_area
      0.24 ±  3%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.26 ±  4%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.27 ±  2%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.inode_permission
      0.24 ±  4%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.free_vmap_area_noflush
      0.26            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.pfn_valid
      0.40            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.generic_permission
      0.26 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.map_id_up
      0.40 ±  4%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.20 ±  6%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.__vmalloc_area_node
      0.18 ±  4%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.insert_vmap_area
      0.17 ±  4%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.20 ±  4%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.24 ±  3%      -0.1        0.19 ±  8%  perf-profile.self.cycles-pp.refcount_dec_not_one
      0.23 ±  3%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.putname
      0.30            -0.0        0.25 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.23 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.cp_statx
      0.19 ±  5%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.11 ±  7%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__alloc_pages_bulk
      0.25 ±  3%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.cp_new_stat
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.45 ±  6%      -0.0        0.40 ±  2%  perf-profile.self.cycles-pp.page_counter_cancel
      0.20 ±  3%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.generic_fillattr
      0.20 ±  5%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.page_counter_charge
      0.16 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.terminate_walk
      0.21 ±  5%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.15 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.__x64_sys_newstat
      0.15 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.security_inode_permission
      0.12 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.rb_insert_color
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.pids_can_fork
      0.19 ±  3%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.dput
      0.15 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__x64_sys_newlstat
      0.13 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__do_sys_newstat
      0.18 ±  4%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__might_fault
      0.13 ±  5%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.26 ±  5%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.stress_fstat_helper
      0.12 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.nd_jump_root
      0.26 ±  3%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.try_to_unlazy
      0.06            -0.0        0.03 ± 81%  perf-profile.self.cycles-pp.__free_pages
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.complete_walk
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.dup_task_struct
      0.12 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp._copy_to_user
      0.07 ±  5%      -0.0        0.04 ± 51%  perf-profile.self.cycles-pp.pids_release
      0.14 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.__do_sys_newlstat
      0.11            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp._mix_pool_bytes
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.cpumask_next
      0.27 ±  3%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.12 ±  6%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__legitimize_path
      0.10 ±  7%      -0.0        0.08        perf-profile.self.cycles-pp.update_curr
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.legitimize_links
      0.15 ±  4%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.mntput_no_expire
      0.10 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.check_stack_object
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.__x64_sys_newfstat
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.security_inode_getattr
      0.11 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.native_sched_clock
      0.09 ±  6%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.__list_add_valid
      0.10 ±  3%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__fget_files
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.rb_erase
      0.06 ±  7%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.mntput
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.cpuidle_idle_call
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.pthread_create
      0.06 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.try_get_compound_head
      0.10 ±  7%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.start_thread
      0.14 ±  5%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__slab_free
      0.03 ±100%      +0.0        0.07        perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__cleanup_sighand
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.get_pid_task
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.memset_erms
      0.05 ±  7%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.find_idlest_cpu
      0.51 ±  4%      +0.1        0.64 ±  3%  perf-profile.self.cycles-pp.lockref_put_return
      4.26            +1.0        5.26        perf-profile.self.cycles-pp.common_perm_cond
     15.25 ±  2%      +4.9       20.12        perf-profile.self.cycles-pp.lockref_put_or_lock
     19.94            +6.5       26.44        perf-profile.self.cycles-pp.lockref_get_not_dead


***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/CPU/debian-x86_64-phoronix/lkp-csl-2sp7/neatbench-1.0.4/phoronix-test-suite/0x500320a

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     21.93           +12.5%      24.67        phoronix-test-suite.neatbench.CPU.fps
  29295274           -15.5%   24743253 ±  2%  meminfo.DirectMap2M
     90734 ±  2%     -10.5%      81194 ±  4%  numa-vmstat.node1.nr_anon_pages
    487282           +24.8%     608044 ±  4%  numa-meminfo.node0.AnonPages.max
    174060           -15.4%     147263 ±  4%  numa-meminfo.node1.AnonHugePages
    362897 ±  2%     -10.5%     324765 ±  4%  numa-meminfo.node1.AnonPages
    204270           +24.3%     253988 ± 16%  proc-vmstat.numa_hint_faults
     27906 ± 10%    +239.6%      94760 ± 29%  proc-vmstat.numa_pages_migrated
     27906 ± 10%    +239.6%      94760 ± 29%  proc-vmstat.pgmigrate_success
    507.87 ±  3%     +11.3%     565.26 ±  7%  perf-stat.i.cpu-migrations
   2761308 ±  2%     +19.0%    3286398 ± 13%  perf-stat.i.dTLB-load-misses
 8.745e+09 ±  2%      +6.0%  9.273e+09        perf-stat.i.dTLB-loads
 1.654e+08            +3.1%  1.705e+08        perf-stat.i.metric.M/sec
     29.42            +8.9       38.28 ±  2%  perf-stat.i.node-load-miss-rate%
   6226327           +57.2%    9785959 ±  2%  perf-stat.i.node-load-misses
  20558122           -14.3%   17615819 ±  3%  perf-stat.i.node-loads
     32.14 ±  2%      +4.5       36.69 ±  3%  perf-stat.i.node-store-miss-rate%
  11969241 ±  3%     +17.5%   14067728 ±  6%  perf-stat.i.node-store-misses
  26170161           -12.8%   22819269 ±  6%  perf-stat.i.node-stores
     35.48            -1.1       34.40 ±  2%  perf-stat.overall.cache-miss-rate%
      0.03            +0.0        0.04 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
     23.27           +12.5       35.72 ±  3%  perf-stat.overall.node-load-miss-rate%
     31.40 ±  2%      +6.8       38.18 ±  7%  perf-stat.overall.node-store-miss-rate%
   2740309 ±  2%     +18.9%    3258409 ± 13%  perf-stat.ps.dTLB-load-misses
 8.672e+09 ±  2%      +6.0%  9.191e+09        perf-stat.ps.dTLB-loads
   6183578           +56.9%    9702575 ±  2%  perf-stat.ps.node-load-misses
  20393328           -14.4%   17466096 ±  2%  perf-stat.ps.node-loads
  11891538 ±  3%     +17.4%   13956458 ±  6%  perf-stat.ps.node-store-misses
  25975231           -12.8%   22637665 ±  6%  perf-stat.ps.node-stores
     14.49 ± 17%      -6.9        7.63 ± 58%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.48 ± 17%      -6.9        7.62 ± 58%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.44 ± 26%      -5.6        3.87 ± 70%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.43 ± 26%      -5.6        3.87 ± 70%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.22 ± 27%      -5.5        3.76 ± 70%  perf-profile.calltrace.cycles-pp.zap_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      9.23 ± 27%      -5.5        3.77 ± 70%  perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.66 ± 28%      -5.2        3.46 ± 70%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      8.64 ± 28%      -5.2        3.45 ± 70%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.zap_page_range.madvise_vma_behavior.do_madvise
      8.43 ± 29%      -5.1        3.31 ± 70%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.zap_page_range.madvise_vma_behavior
      8.88 ± 16%      -4.3        4.56 ± 59%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      8.57 ± 17%      -4.1        4.43 ± 60%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      7.77 ± 17%      -3.8        4.00 ± 60%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      7.72 ± 17%      -3.7        3.97 ± 60%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      7.42 ± 21%      -2.8        4.58 ± 30%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      5.09 ± 20%      -2.8        2.25 ± 71%  perf-profile.calltrace.cycles-pp.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      7.48 ± 20%      -2.8        4.67 ± 30%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      7.78 ± 21%      -2.6        5.16 ± 21%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      9.08 ± 20%      -2.4        6.64 ± 17%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.22 ± 21%      -2.4        1.86 ± 71%  perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      3.82 ± 22%      -2.1        1.68 ± 71%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.task_tick_fair.scheduler_tick.update_process_times
      3.61 ± 22%      -2.0        1.59 ± 71%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.task_tick_fair.scheduler_tick
      3.32 ± 20%      -1.8        1.48 ± 71%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.task_tick_fair
      4.11 ±  8%      -1.8        2.35 ± 48%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.11 ±  8%      -1.8        2.36 ± 48%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      4.12 ±  8%      -1.7        2.41 ± 44%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.80 ± 19%      -1.4        1.43 ± 70%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
      2.49 ± 18%      -1.2        1.32 ± 71%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      2.40 ± 18%      -1.1        1.29 ± 71%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      2.82 ±  9%      -1.0        1.80 ± 42%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.62 ±  9%      -0.9        1.71 ± 40%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.75 ±  5%      -0.8        0.92 ± 71%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.57 ± 15%      -0.7        0.84 ± 70%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      1.35 ±  9%      -0.6        0.76 ± 71%  perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.36 ±  9%      -0.6        0.76 ± 71%  perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99 ± 21%      -0.6        0.42 ± 70%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function
      1.21 ± 14%      -0.6        0.65 ± 71%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92 ± 20%      -0.5        0.39 ± 70%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function
      0.87            -0.5        0.37 ± 70%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.95 ±  3%      -0.5        0.45 ± 71%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.83 ±  2%      -0.5        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__schedule.schedule.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault
      0.83 ±  2%      -0.5        0.34 ± 70%  perf-profile.calltrace.cycles-pp.schedule.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.90 ±  4%      -0.5        0.43 ± 71%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.82 ± 19%      -0.5        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      0.79 ± 19%      -0.4        0.34 ± 70%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      0.84 ±  4%      -0.4        0.39 ± 71%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_vma.do_anonymous_page.__handle_mm_fault
      0.83 ±  8%      -0.4        0.41 ± 70%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.83 ±  8%      -0.4        0.42 ± 71%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.78 ± 14%      -0.3        0.45 ± 71%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.71 ± 17%      -0.3        0.39 ± 71%  perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      1.36 ± 14%      -0.2        1.14 ± 18%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.6        0.61 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.6        0.61 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.6        0.61 ±  9%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
     61.21 ±  6%     +12.0       73.25 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     60.63 ±  6%     +12.2       72.83 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     64.35 ±  5%     +12.7       77.08 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     64.35 ±  5%     +12.7       77.08 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     64.34 ±  5%     +12.7       77.07 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     64.72 ±  4%     +13.0       77.69 ±  9%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      9.44 ± 26%      -5.6        3.87 ± 70%  perf-profile.children.cycles-pp.__x64_sys_madvise
      9.44 ± 26%      -5.6        3.87 ± 70%  perf-profile.children.cycles-pp.do_madvise
      9.22 ± 27%      -5.5        3.76 ± 70%  perf-profile.children.cycles-pp.zap_page_range
      9.23 ± 27%      -5.5        3.77 ± 70%  perf-profile.children.cycles-pp.madvise_vma_behavior
      8.75 ± 28%      -5.1        3.61 ± 66%  perf-profile.children.cycles-pp.tlb_flush_mmu
      8.76 ± 28%      -5.1        3.63 ± 65%  perf-profile.children.cycles-pp.tlb_finish_mmu
      8.50 ± 29%      -5.1        3.39 ± 69%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      8.45 ± 29%      -5.1        3.34 ± 70%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      8.45 ± 29%      -5.1        3.34 ± 70%  perf-profile.children.cycles-pp.smp_call_function_many_cond
     16.82 ± 14%      -5.1       11.72 ± 18%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.81 ± 14%      -5.1       11.71 ± 18%  perf-profile.children.cycles-pp.do_syscall_64
      7.62 ± 20%      -2.8        4.85 ± 25%  perf-profile.children.cycles-pp.update_process_times
      5.25 ± 20%      -2.8        2.49 ± 57%  perf-profile.children.cycles-pp.task_tick_fair
      7.69 ± 20%      -2.7        4.94 ± 25%  perf-profile.children.cycles-pp.tick_sched_handle
      5.85 ± 18%      -2.7        3.13 ± 59%  perf-profile.children.cycles-pp.update_curr
      6.30 ± 20%      -2.6        3.70 ± 30%  perf-profile.children.cycles-pp.scheduler_tick
      7.99 ± 20%      -2.6        5.44 ± 18%  perf-profile.children.cycles-pp.tick_sched_timer
      5.71 ± 16%      -2.4        3.27 ± 59%  perf-profile.children.cycles-pp.perf_swevent_overflow
      9.37 ± 20%      -2.4        6.94 ± 15%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      5.29 ± 19%      -2.4        2.87 ± 59%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      5.67 ± 16%      -2.4        3.25 ± 59%  perf-profile.children.cycles-pp.__perf_event_overflow
      5.60 ± 16%      -2.4        3.20 ± 60%  perf-profile.children.cycles-pp.perf_event_output_forward
      4.94 ±  9%      -1.9        3.00 ± 40%  perf-profile.children.cycles-pp.asm_exc_page_fault
      4.67 ± 15%      -1.9        2.73 ± 60%  perf-profile.children.cycles-pp.perf_prepare_sample
      4.62 ±  9%      -1.9        2.73 ± 40%  perf-profile.children.cycles-pp.exc_page_fault
      4.30 ±  8%      -1.7        2.61 ± 39%  perf-profile.children.cycles-pp.do_user_addr_fault
      4.13 ± 15%      -1.6        2.52 ± 60%  perf-profile.children.cycles-pp.perf_callchain
      4.02 ± 15%      -1.5        2.47 ± 59%  perf-profile.children.cycles-pp.get_perf_callchain
      3.43 ±  7%      -1.4        2.07 ± 62%  perf-profile.children.cycles-pp.__schedule
      2.78 ± 12%      -1.0        1.80 ± 58%  perf-profile.children.cycles-pp.perf_callchain_kernel
      2.94 ±  9%      -0.9        2.03 ± 31%  perf-profile.children.cycles-pp.handle_mm_fault
      1.76 ±  6%      -0.8        0.96 ± 65%  perf-profile.children.cycles-pp.do_anonymous_page
      2.73 ±  8%      -0.8        1.93 ± 29%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.23 ± 16%      -0.7        0.54 ± 70%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      2.06 ± 12%      -0.7        1.39 ± 54%  perf-profile.children.cycles-pp.unwind_next_frame
      1.08 ± 19%      -0.6        0.47 ± 70%  perf-profile.children.cycles-pp.sysvec_call_function
      1.36 ±  9%      -0.6        0.76 ± 71%  perf-profile.children.cycles-pp.__x64_sys_exit
      1.02 ±  2%      -0.6        0.45 ± 70%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.16 ± 21%      -0.6        0.60 ± 72%  perf-profile.children.cycles-pp.perf_callchain_user
      0.99 ± 14%      -0.6        0.43 ± 70%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.12 ± 21%      -0.6        0.57 ± 72%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.95 ± 18%      -0.5        0.40 ± 70%  perf-profile.children.cycles-pp.__sysvec_call_function
      1.88 ± 15%      -0.5        1.35 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.03 ±  2%      -0.5        0.53 ± 62%  perf-profile.children.cycles-pp.__alloc_pages
      0.98            -0.5        0.50 ± 62%  perf-profile.children.cycles-pp.alloc_pages_vma
      1.36 ± 13%      -0.5        0.88 ± 44%  perf-profile.children.cycles-pp.clear_page_erms
      0.93 ±  3%      -0.5        0.45 ± 71%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.90 ± 14%      -0.4        0.46 ± 59%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.86 ± 15%      -0.4        0.43 ± 59%  perf-profile.children.cycles-pp.dequeue_entity
      0.97 ± 26%      -0.4        0.54 ± 70%  perf-profile.children.cycles-pp.vfs_read
      0.97 ± 26%      -0.4        0.55 ± 70%  perf-profile.children.cycles-pp.ksys_read
      0.69 ± 16%      -0.4        0.29 ± 70%  perf-profile.children.cycles-pp.update_load_avg
      0.80 ± 10%      -0.4        0.41 ± 70%  perf-profile.children.cycles-pp.kernel_init_free_pages
      0.75 ±  9%      -0.4        0.39 ± 70%  perf-profile.children.cycles-pp.newidle_balance
      0.67 ± 10%      -0.4        0.32 ± 70%  perf-profile.children.cycles-pp.prep_new_page
      0.66 ± 10%      -0.3        0.33 ± 75%  perf-profile.children.cycles-pp.try_to_wake_up
      0.83 ±  8%      -0.3        0.51 ± 32%  perf-profile.children.cycles-pp.schedule_idle
      0.61 ± 14%      -0.3        0.30 ± 72%  perf-profile.children.cycles-pp.finish_task_switch
      0.73 ± 24%      -0.3        0.43 ± 68%  perf-profile.children.cycles-pp.seq_read_iter
      0.57 ±  8%      -0.3        0.31 ± 56%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.46 ± 12%      -0.2        0.24 ± 72%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.40 ± 28%      -0.2        0.19 ± 45%  perf-profile.children.cycles-pp.flush_tlb_func
      0.41 ± 10%      -0.2        0.19 ± 71%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.42 ± 14%      -0.2        0.20 ± 75%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.32 ± 11%      -0.2        0.12 ± 71%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      1.36 ± 14%      -0.2        1.17 ± 16%  perf-profile.children.cycles-pp.ret_from_fork
      0.94 ± 16%      -0.2        0.75 ± 14%  perf-profile.children.cycles-pp.load_balance
      0.38 ± 11%      -0.2        0.21 ± 71%  perf-profile.children.cycles-pp.put_task_stack
      0.32            -0.2        0.15 ± 70%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.26 ± 14%      -0.2        0.10 ± 70%  perf-profile.children.cycles-pp.perf_event_pid_type
      0.32 ± 13%      -0.2        0.15 ± 73%  perf-profile.children.cycles-pp.llist_reverse_order
      0.44 ±  8%      -0.2        0.27 ± 36%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.58 ± 14%      -0.2        0.41 ± 11%  perf-profile.children.cycles-pp.unmap_page_range
      0.31 ± 12%      -0.2        0.15 ± 70%  perf-profile.children.cycles-pp.llist_add_batch
      0.31 ±  3%      -0.2        0.15 ± 77%  perf-profile.children.cycles-pp.wake_up_q
      0.40 ±  8%      -0.2        0.24 ± 71%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.31 ±  4%      -0.1        0.16 ± 77%  perf-profile.children.cycles-pp.rwsem_wake
      0.22 ± 19%      -0.1        0.07 ± 70%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.23 ± 30%      -0.1        0.10 ± 74%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.21 ± 15%      -0.1        0.09 ± 73%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.20 ±  7%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.27 ±  4%      -0.1        0.15 ± 70%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.24 ± 10%      -0.1        0.12 ± 73%  perf-profile.children.cycles-pp.rmqueue
      0.19 ± 11%      -0.1        0.07 ± 70%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.21 ± 20%      -0.1        0.09 ± 72%  perf-profile.children.cycles-pp.do_task_stat
      0.38 ± 15%      -0.1        0.26 ± 33%  perf-profile.children.cycles-pp.sync_regs
      0.36 ±  7%      -0.1        0.24 ± 29%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.36 ±  7%      -0.1        0.24 ± 29%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.21 ± 12%      -0.1        0.10 ± 70%  perf-profile.children.cycles-pp.down_write_killable
      0.18 ±  7%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.28 ± 17%      -0.1        0.17 ± 41%  perf-profile.children.cycles-pp.queue_work_on
      0.19 ± 11%      -0.1        0.09 ± 71%  perf-profile.children.cycles-pp.native_flush_tlb_local
      0.26 ±  4%      -0.1        0.17 ± 41%  perf-profile.children.cycles-pp.sched_move_task
      0.20 ±  6%      -0.1        0.10 ± 71%  perf-profile.children.cycles-pp.___perf_sw_event
      0.17 ± 19%      -0.1        0.08 ± 73%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.21 ± 14%      -0.1        0.12 ± 29%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.18 ± 24%      -0.1        0.10 ± 80%  perf-profile.children.cycles-pp.trigger_load_balance
      0.19 ± 14%      -0.1        0.10 ± 73%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.18 ± 26%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp.note_gp_changes
      0.13 ± 28%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.11 ± 29%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.cpuacct_charge
      0.13 ±  3%      -0.1        0.06 ± 73%  perf-profile.children.cycles-pp.find_vma
      0.14 ± 20%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.10 ±  4%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.update_min_vruntime
      0.10 ±  9%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.10 ± 16%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.__split_huge_pmd
      0.10            -0.1        0.05 ± 74%  perf-profile.children.cycles-pp.hrtimer_active
      0.09 ± 22%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__split_vma
      0.17 ±  9%      -0.0        0.12 ± 31%  perf-profile.children.cycles-pp.release_task
      0.09 ± 14%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.mm_release
      0.13 ± 21%      -0.0        0.09 ± 27%  perf-profile.children.cycles-pp.link_path_walk
      0.08 ± 11%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__put_task_struct
      0.08 ± 16%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.futex_wake
      0.08 ± 16%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.__switch_to
      0.11 ± 19%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 19%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.mod_objcg_state
      0.13 ± 25%      +0.1        0.23 ± 36%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.13 ± 25%      +0.1        0.23 ± 36%  perf-profile.children.cycles-pp.do_execveat_common
      0.11 ± 26%      +0.1        0.22 ± 42%  perf-profile.children.cycles-pp.bprm_execve
      0.38 ± 27%      +0.2        0.61 ±  9%  perf-profile.children.cycles-pp.start_kernel
      0.19 ± 60%      +0.9        1.11 ±103%  perf-profile.children.cycles-pp.delay_tsc
     61.55 ±  6%     +12.3       73.84 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     61.53 ±  6%     +12.3       73.83 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     64.35 ±  5%     +12.7       77.08 ±  9%  perf-profile.children.cycles-pp.start_secondary
     64.72 ±  4%     +13.0       77.69 ±  9%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     64.72 ±  4%     +13.0       77.69 ±  9%  perf-profile.children.cycles-pp.cpu_startup_entry
     64.72 ±  4%     +13.0       77.69 ±  9%  perf-profile.children.cycles-pp.do_idle
      1.88 ± 15%      -0.5        1.35 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.33 ± 13%      -0.5        0.86 ± 44%  perf-profile.self.cycles-pp.clear_page_erms
      0.32 ± 23%      -0.2        0.13 ± 71%  perf-profile.self.cycles-pp.update_load_avg
      0.32            -0.2        0.15 ± 70%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.32 ± 13%      -0.2        0.15 ± 73%  perf-profile.self.cycles-pp.llist_reverse_order
      0.44 ±  8%      -0.2        0.27 ± 36%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.28 ±  8%      -0.2        0.13 ± 70%  perf-profile.self.cycles-pp.llist_add_batch
      0.22 ± 44%      -0.1        0.07 ± 72%  perf-profile.self.cycles-pp.flush_tlb_func
      0.22 ± 18%      -0.1        0.07 ± 70%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.23 ± 30%      -0.1        0.10 ± 76%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.19 ± 11%      -0.1        0.07 ± 71%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.22 ±  7%      -0.1        0.09 ± 71%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.21 ± 23%      -0.1        0.09 ± 74%  perf-profile.self.cycles-pp.perf_output_sample
      0.38 ± 15%      -0.1        0.26 ± 33%  perf-profile.self.cycles-pp.sync_regs
      0.19 ± 19%      -0.1        0.08 ± 72%  perf-profile.self.cycles-pp.__unwind_start
      0.18 ± 21%      -0.1        0.08 ± 77%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.19 ± 11%      -0.1        0.09 ± 71%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.19 ± 33%      -0.1        0.09 ± 39%  perf-profile.self.cycles-pp.perf_tp_event
      0.19 ± 14%      -0.1        0.10 ± 73%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ± 21%      -0.1        0.07 ± 78%  perf-profile.self.cycles-pp.trigger_load_balance
      0.11 ± 29%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.cpuacct_charge
      0.15 ±  3%      -0.1        0.09 ± 71%  perf-profile.self.cycles-pp.___perf_sw_event
      0.11 ± 14%      -0.1        0.05 ± 81%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.15 ± 28%      -0.1        0.09 ± 24%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.09 ±  5%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.update_min_vruntime
      0.11 ± 23%      -0.1        0.05 ± 71%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.10 ±  9%      -0.1        0.04 ± 70%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.09 ±  5%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.find_vma
      0.10 ± 14%      -0.1        0.05 ± 70%  perf-profile.self.cycles-pp.perf_callchain
      0.10            -0.1        0.05 ± 74%  perf-profile.self.cycles-pp.hrtimer_active
      0.08 ± 16%      -0.0        0.04 ± 73%  perf-profile.self.cycles-pp.__switch_to
      0.13 ± 24%      +0.9        1.06 ±111%  perf-profile.self.cycles-pp.delay_tsc



***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/All (CPU + GPU)/debian-x86_64-phoronix/lkp-csl-2sp7/neatbench-1.0.4/phoronix-test-suite/0x500320a

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     21.90           +15.2%      25.23        phoronix-test-suite.neatbench.All.fps
    240.02 ± 79%     -57.9%     100.99        phoronix-test-suite.time.elapsed_time
    240.02 ± 79%     -57.9%     100.99        phoronix-test-suite.time.elapsed_time.max
      2106 ±  6%      -8.8%       1920        phoronix-test-suite.time.percent_of_cpu_this_job_got
     90.11 ± 82%     -63.1%      33.23 ±  2%  phoronix-test-suite.time.system_time
      5230 ± 85%     -63.5%       1906        phoronix-test-suite.time.user_time
  29614080 ±  3%     -14.2%   25394517 ±  5%  meminfo.DirectMap2M
   5613969 ± 70%     -66.2%    1894969 ± 39%  numa-numastat.node0.local_node
   5639979 ± 69%     -65.3%    1957289 ± 38%  numa-numastat.node0.numa_hit
  26828862 ± 63%     -69.9%    8072601 ± 68%  turbostat.C1E
    170.80            +0.7%     171.92        turbostat.RAMWatt
    606.67 ± 50%     +45.9%     885.00 ±  2%  vmstat.io.bi
     23.33 ±  7%     -18.6%      19.00 ±  7%  vmstat.procs.r
    361167 ± 15%     -32.2%     244960 ± 25%  numa-meminfo.node0.AnonHugePages
     82728 ± 20%    +114.0%     177014 ± 62%  numa-meminfo.node1.AnonPages
     89169 ± 15%    +124.0%     199717 ± 69%  numa-meminfo.node1.Inactive
     85555 ± 17%    +109.1%     178925 ± 63%  numa-meminfo.node1.Inactive(anon)
      8604 ±  2%     +15.7%       9958 ±  4%  numa-meminfo.node1.KernelStack
    843417 ±  6%     +30.6%    1101447 ± 16%  numa-meminfo.node1.MemUsed
   4147856 ± 48%     -45.2%    2272023 ± 13%  numa-vmstat.node0.numa_hit
   4119756 ± 48%     -46.4%    2208525 ± 14%  numa-vmstat.node0.numa_local
     20691 ± 20%    +113.9%      44251 ± 62%  numa-vmstat.node1.nr_anon_pages
     21398 ± 17%    +109.0%      44724 ± 63%  numa-vmstat.node1.nr_inactive_anon
      8606 ±  2%     +15.7%       9955 ±  4%  numa-vmstat.node1.nr_kernel_stack
     21398 ± 17%    +109.0%      44724 ± 63%  numa-vmstat.node1.nr_zone_inactive_anon
    190582 ±  3%      -4.5%     181962        proc-vmstat.nr_anon_pages
    417246            -2.5%     406841        proc-vmstat.nr_inactive_anon
     20308 ±  2%      -3.5%      19599        proc-vmstat.nr_mapped
    229553            -1.5%     226075        proc-vmstat.nr_shmem
    417246            -2.5%     406841        proc-vmstat.nr_zone_inactive_anon
    572357 ± 96%     -72.9%     155080 ±  5%  proc-vmstat.numa_hint_faults_local
   1571296 ± 96%     -69.9%     473479        proc-vmstat.numa_pte_updates
     28837 ± 65%     -47.1%      15245        proc-vmstat.pgactivate
   7313749 ± 79%     -56.6%    3171525        proc-vmstat.pgfault
    187098 ± 63%     -46.0%     100957        proc-vmstat.pgreuse
 2.741e+09            +3.2%  2.829e+09        perf-stat.i.branch-instructions
  23946611 ±  3%     +11.0%   26584797 ±  8%  perf-stat.i.branch-misses
 5.418e+10 ±  6%      -8.2%  4.973e+10        perf-stat.i.cpu-cycles
    550.15 ±  2%     +11.1%     611.20 ±  2%  perf-stat.i.cpu-migrations
   2562764 ±  4%      +6.8%    2737034 ±  3%  perf-stat.i.dTLB-store-misses
 3.302e+10            +3.2%  3.409e+10        perf-stat.i.instructions
    565991 ±  6%      -8.3%     519287        perf-stat.i.metric.GHz
     27.15 ±  5%     +10.6       37.77        perf-stat.i.node-load-miss-rate%
   6023051           +68.7%   10161660 ±  3%  perf-stat.i.node-load-misses
  20814028           -12.6%   18197576        perf-stat.i.node-loads
     28.25 ± 12%      +5.9       34.16 ±  2%  perf-stat.i.node-store-miss-rate%
  11383164 ± 11%     +32.8%   15111590 ±  2%  perf-stat.i.node-store-misses
  27464998 ±  7%     -16.6%   22902472        perf-stat.i.node-stores
      1.64 ±  5%     -11.1%       1.46        perf-stat.overall.cpi
    245.86 ±  4%      -9.2%     223.35        perf-stat.overall.cycles-between-cache-misses
      0.61 ±  5%     +12.1%       0.68        perf-stat.overall.ipc
     22.46           +13.4       35.83 ±  3%  perf-stat.overall.node-load-miss-rate%
     29.38 ± 12%     +10.4       39.76        perf-stat.overall.node-store-miss-rate%
 2.724e+09            +2.9%  2.803e+09        perf-stat.ps.branch-instructions
  23798405 ±  3%     +10.7%   26346637 ±  8%  perf-stat.ps.branch-misses
 5.393e+10 ±  6%      -8.5%  4.933e+10        perf-stat.ps.cpu-cycles
    548.77 ±  2%     +10.7%     607.37 ±  2%  perf-stat.ps.cpu-migrations
 3.281e+10            +2.9%  3.377e+10        perf-stat.ps.instructions
   5993351 ±  2%     +68.1%   10075396 ±  4%  perf-stat.ps.node-load-misses
  20693312 ±  2%     -12.8%   18041364        perf-stat.ps.node-loads
  11326881 ± 11%     +32.4%   15001975 ±  2%  perf-stat.ps.node-store-misses
  27328186 ±  7%     -16.9%   22721712        perf-stat.ps.node-stores
     10.70 ±  9%     -10.7        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
     10.12 ± 13%     -10.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      9.17 ± 14%      -9.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      9.10 ± 14%      -9.1        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     11.57 ± 10%      -7.6        3.98 ±102%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     11.56 ± 10%      -7.6        3.98 ±102%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.53 ± 14%      -6.5        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.52 ± 14%      -6.5        0.00        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.34 ± 14%      -6.3        0.00        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.33 ± 14%      -6.3        0.00        perf-profile.calltrace.cycles-pp.zap_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      5.95 ± 17%      -5.9        0.00        perf-profile.calltrace.cycles-pp.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      5.88 ± 16%      -5.9        0.00        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      5.86 ± 16%      -5.9        0.00        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.zap_page_range.madvise_vma_behavior.do_madvise
      6.94 ± 14%      -5.7        1.23 ± 70%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      5.63 ± 17%      -5.6        0.00        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.zap_page_range.madvise_vma_behavior
      5.60 ± 16%      -5.6        0.00        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.zap_page_range
      5.59 ± 16%      -5.6        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu
      8.53 ± 12%      -5.4        3.10 ± 17%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      8.45 ± 12%      -5.4        3.04 ± 16%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      4.93 ± 17%      -4.9        0.00        perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      8.84 ± 11%      -4.6        4.20 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     10.15 ±  9%      -4.5        5.60 ±  9%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.34 ±  4%      -3.4        0.96 ± 11%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      4.14 ± 10%      -3.2        0.91 ± 12%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.14 ± 11%      -3.2        0.91 ± 12%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.73 ± 11%      -1.9        0.86 ± 11%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.56 ± 10%      -1.4        1.13 ± 31%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.40 ± 71%      +0.7        1.07 ± 40%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.40 ± 71%      +0.7        1.07 ± 40%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.40 ± 71%      +0.7        1.07 ± 40%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.37 ± 70%      +1.0        1.36 ± 29%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.1        1.08 ± 18%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.3        1.27 ± 24%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.80 ± 15%      +1.4        2.20 ± 13%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.95 ± 15%      +1.6        2.60 ± 15%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.21 ± 18%      +6.7        9.96 ± 36%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.28 ± 18%      +7.3       10.59 ± 27%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      5.04 ± 19%     +10.4       15.46 ± 26%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      6.11 ± 22%     +12.4       18.52 ± 33%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     62.20 ±  2%     +15.1       77.26 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     62.78 ±  2%     +15.2       77.99 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     65.95 ±  3%     +17.6       83.53 ± 10%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     65.95 ±  3%     +17.6       83.53 ± 10%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     65.94 ±  3%     +17.6       83.53 ± 10%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.51 ±  3%     +18.1       84.59 ± 10%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      6.53 ± 14%      -6.5        0.00        perf-profile.children.cycles-pp.__x64_sys_madvise
      6.52 ± 14%      -6.5        0.00        perf-profile.children.cycles-pp.do_madvise
      6.34 ± 14%      -6.3        0.00        perf-profile.children.cycles-pp.madvise_vma_behavior
      6.33 ± 14%      -6.3        0.00        perf-profile.children.cycles-pp.zap_page_range
      6.45 ± 17%      -6.2        0.21 ± 71%  perf-profile.children.cycles-pp.update_curr
      6.81 ± 15%      -6.2        0.62 ± 22%  perf-profile.children.cycles-pp.perf_tp_event
      6.14 ± 16%      -6.0        0.09 ± 93%  perf-profile.children.cycles-pp.task_tick_fair
      7.28 ± 14%      -6.0        1.33 ± 70%  perf-profile.children.cycles-pp.scheduler_tick
      6.25 ± 15%      -5.9        0.35 ± 71%  perf-profile.children.cycles-pp.perf_swevent_overflow
      6.20 ± 15%      -5.8        0.35 ± 71%  perf-profile.children.cycles-pp.__perf_event_overflow
      6.10 ± 15%      -5.8        0.35 ± 71%  perf-profile.children.cycles-pp.perf_event_output_forward
      5.68 ± 17%      -5.7        0.00        perf-profile.children.cycles-pp.flush_tlb_mm_range
      5.86 ± 17%      -5.7        0.20 ± 70%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      5.64 ± 16%      -5.6        0.00        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      5.64 ± 16%      -5.6        0.00        perf-profile.children.cycles-pp.smp_call_function_many_cond
      8.77 ± 12%      -5.5        3.22 ± 20%  perf-profile.children.cycles-pp.tick_sched_handle
      8.70 ± 12%      -5.5        3.18 ± 19%  perf-profile.children.cycles-pp.update_process_times
      5.10 ± 17%      -4.9        0.22 ± 71%  perf-profile.children.cycles-pp.perf_prepare_sample
      5.96 ± 15%      -4.8        1.13 ±133%  perf-profile.children.cycles-pp.tlb_flush_mmu
      5.95 ± 15%      -4.8        1.13 ±133%  perf-profile.children.cycles-pp.tlb_finish_mmu
      9.11 ± 11%      -4.7        4.40 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
     10.43 ±  9%      -4.5        5.89 ± 12%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.61 ± 19%      -4.4        0.21 ± 72%  perf-profile.children.cycles-pp.perf_callchain
      4.50 ± 19%      -4.3        0.21 ± 72%  perf-profile.children.cycles-pp.get_perf_callchain
      5.18 ±  4%      -3.7        1.52 ±  5%  perf-profile.children.cycles-pp.asm_exc_page_fault
      4.67 ±  8%      -3.3        1.40 ± 12%  perf-profile.children.cycles-pp.exc_page_fault
      3.21 ± 20%      -3.1        0.13 ± 71%  perf-profile.children.cycles-pp.perf_callchain_kernel
      4.33 ±  9%      -3.0        1.38 ± 12%  perf-profile.children.cycles-pp.do_user_addr_fault
      3.33 ± 13%      -2.8        0.52 ± 39%  perf-profile.children.cycles-pp.__schedule
      2.41 ± 18%      -2.3        0.10 ± 70%  perf-profile.children.cycles-pp.unwind_next_frame
      2.15 ± 20%      -2.0        0.13 ± 71%  perf-profile.children.cycles-pp.schedule
      1.75 ± 12%      -1.6        0.12 ± 73%  perf-profile.children.cycles-pp.do_anonymous_page
      2.84 ± 10%      -1.5        1.37 ± 13%  perf-profile.children.cycles-pp.handle_mm_fault
      1.47 ± 18%      -1.4        0.10 ± 70%  perf-profile.children.cycles-pp.__unwind_start
      2.68 ±  9%      -1.3        1.36 ± 14%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.21 ± 17%      -1.1        0.07 ± 86%  perf-profile.children.cycles-pp.perf_callchain_user
      1.17 ± 18%      -1.1        0.07 ± 86%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      1.28 ± 11%      -0.9        0.35 ± 92%  perf-profile.children.cycles-pp.clear_page_erms
      1.03 ± 12%      -0.9        0.12 ± 73%  perf-profile.children.cycles-pp.__alloc_pages
      0.94 ± 13%      -0.9        0.09 ± 71%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.83 ± 15%      -0.8        0.07 ± 86%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.81 ± 18%      -0.8        0.05 ± 72%  perf-profile.children.cycles-pp.__orc_find
      0.80 ±  5%      -0.7        0.10 ± 86%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.75 ± 18%      -0.7        0.07 ± 86%  perf-profile.children.cycles-pp.kernel_init_free_pages
      0.75 ±  5%      -0.7        0.10 ± 86%  perf-profile.children.cycles-pp.dequeue_entity
      0.73 ± 18%      -0.6        0.14 ± 80%  perf-profile.children.cycles-pp.rcu_core
      0.63 ± 20%      -0.6        0.07 ± 86%  perf-profile.children.cycles-pp.prep_new_page
      0.58 ± 10%      -0.5        0.10 ± 70%  perf-profile.children.cycles-pp.perf_output_sample
      0.54 ±  5%      -0.5        0.07 ± 83%  perf-profile.children.cycles-pp.error_entry
      0.83 ± 11%      -0.4        0.39 ± 76%  perf-profile.children.cycles-pp.schedule_idle
      0.32 ± 16%      -0.2        0.10 ± 97%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.24 ±  6%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.try_charge_memcg
      0.16 ± 15%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.19 ± 24%      -0.1        0.10 ± 70%  perf-profile.children.cycles-pp.note_gp_changes
      0.13 ± 18%      +0.3        0.40 ± 72%  perf-profile.children.cycles-pp.unmap_vmas
      0.22 ± 11%      +0.3        0.51 ± 41%  perf-profile.children.cycles-pp.update_blocked_averages
      0.04 ± 71%      +0.3        0.35 ± 94%  perf-profile.children.cycles-pp.dup_mmap
      0.00            +0.3        0.31 ±112%  perf-profile.children.cycles-pp.__get_free_pages
      0.03 ±141%      +0.3        0.34 ± 96%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.02 ±141%      +0.3        0.34 ± 99%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.3        0.32 ±106%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.05 ± 78%      +0.3        0.37 ± 84%  perf-profile.children.cycles-pp.task_work_run
      0.02 ±141%      +0.3        0.35 ± 92%  perf-profile.children.cycles-pp.__fput
      0.07 ± 25%      +0.3        0.41 ± 71%  perf-profile.children.cycles-pp.new_sync_read
      0.19 ± 15%      +0.4        0.54 ± 34%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.07 ± 20%      +0.4        0.44 ± 60%  perf-profile.children.cycles-pp.filemap_map_pages
      0.12 ± 24%      +0.4        0.50 ± 49%  perf-profile.children.cycles-pp.do_fault
      0.28 ± 17%      +0.4        0.69 ± 19%  perf-profile.children.cycles-pp.read_tsc
      0.56 ±  9%      +0.5        1.07 ± 40%  perf-profile.children.cycles-pp.start_kernel
      0.05 ± 71%      +0.6        0.62 ±115%  perf-profile.children.cycles-pp.dup_mm
      1.64 ± 16%      +0.6        2.25 ± 12%  perf-profile.children.cycles-pp.__softirqentry_text_start
      2.04 ± 15%      +0.6        2.67 ± 16%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.20 ± 47%      +0.6        0.84 ± 69%  perf-profile.children.cycles-pp.perf_event_read
      0.26 ± 83%      +0.7        0.92 ± 66%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.23 ± 41%      +0.7        0.91 ± 60%  perf-profile.children.cycles-pp.perf_read
      0.37 ± 16%      +0.7        1.08 ± 18%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.45 ± 15%      +0.8        1.28 ± 24%  perf-profile.children.cycles-pp.rebalance_domains
      0.45 ± 33%      +0.9        1.37 ± 30%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.26 ± 38%      +1.0        1.26 ± 67%  perf-profile.children.cycles-pp.__libc_read
      0.47 ±  2%      +1.1        1.56 ± 76%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.12 ± 24%      +1.2        1.32 ±103%  perf-profile.children.cycles-pp.__libc_fork
      0.20 ± 49%      +1.2        1.44 ± 90%  perf-profile.children.cycles-pp.smp_call_function_single
      0.75 ± 43%      +1.3        2.03 ± 45%  perf-profile.children.cycles-pp.ksys_read
      0.75 ± 43%      +1.3        2.03 ± 45%  perf-profile.children.cycles-pp.vfs_read
      0.12 ± 23%      +1.8        1.95 ±106%  perf-profile.children.cycles-pp.mmput
      0.11 ± 27%      +1.8        1.95 ±106%  perf-profile.children.cycles-pp.exit_mmap
      0.10 ± 21%      +2.6        2.74 ±118%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.11 ± 26%      +3.2        3.31 ±120%  perf-profile.children.cycles-pp.do_group_exit
     63.32 ±  2%     +15.6       78.95 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     63.29 ±  2%     +15.6       78.93 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     65.95 ±  3%     +17.6       83.53 ± 10%  perf-profile.children.cycles-pp.start_secondary
     66.51 ±  3%     +18.1       84.59 ± 10%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     66.51 ±  3%     +18.1       84.59 ± 10%  perf-profile.children.cycles-pp.cpu_startup_entry
     66.51 ±  3%     +18.1       84.59 ± 10%  perf-profile.children.cycles-pp.do_idle
      5.00 ± 17%      -5.0        0.00        perf-profile.self.cycles-pp.smp_call_function_many_cond
      1.26 ± 11%      -0.9        0.35 ± 92%  perf-profile.self.cycles-pp.clear_page_erms
      0.81 ± 18%      -0.8        0.05 ± 72%  perf-profile.self.cycles-pp.__orc_find
      0.22 ±  3%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.zap_pte_range
      0.22 ± 23%      -0.1        0.11 ± 72%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.09 ± 15%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.36 ±  2%      +0.3        0.64 ± 24%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28 ± 18%      +0.4        0.69 ± 19%  perf-profile.self.cycles-pp.read_tsc
      0.34 ±  2%      +0.7        1.01 ± 43%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.37 ±  9%      +0.7        1.05 ± 44%  perf-profile.self.cycles-pp.update_process_times
      0.19 ± 50%      +1.2        1.43 ± 91%  perf-profile.self.cycles-pp.smp_call_function_single



***************************************************************************************************
lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/f2fs/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap4/24G/fsmark/0x500320a

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     88507 ±  2%      -4.9%      84186        fsmark.app_overhead
    389.87            -9.9%     351.27        fsmark.files_per_sec
     60.58 ±  3%     +19.3%      72.26 ±  7%  fsmark.time.system_time
      1.19 ± 12%      -0.2        0.97 ±  2%  mpstat.cpu.all.irq%
   1131873 ±  2%      -7.0%    1052808        vmstat.io.bo
      5605           +14.7%       6432 ±  4%  meminfo.Active(anon)
    281974           +12.2%     316254        meminfo.SUnreclaim
     32.33 ±  5%     +47.4%      47.67 ±  3%  turbostat.Avg_MHz
      1852 ± 12%     +31.9%       2443 ±  2%  turbostat.Bzy_MHz
   2210427 ± 66%     +90.4%    4207690        turbostat.C1E
   1398445 ± 65%     -90.1%     138730 ± 38%  turbostat.C6
      6.92 ± 76%     -92.7%       0.51 ± 31%  turbostat.CPU%c6
      9.65 ±108%     -99.9%       0.01 ±141%  turbostat.Pkg%pc2
    106.24 ±  7%     +10.8%     117.67        turbostat.PkgWatt
   9155566           -65.2%    3186814 ±  4%  numa-numastat.node0.local_node
   9158181           -64.4%    3262229 ±  4%  numa-numastat.node0.numa_hit
      3.33 ±101%  +2.3e+06%      76644 ± 19%  numa-numastat.node0.other_node
   1457380 ±  5%    +119.1%    3192690 ±  6%  numa-numastat.node1.local_node
   1544426 ±  5%    +109.9%    3241511 ±  5%  numa-numastat.node1.numa_hit
     87046           -42.9%      49694 ± 53%  numa-numastat.node1.other_node
   1166175 ±  9%    +168.5%    3131073 ±  5%  numa-numastat.node2.local_node
   1253220 ±  9%    +156.0%    3207626 ±  5%  numa-numastat.node2.numa_hit
   1215097 ±  8%    +186.4%    3480151 ±  3%  numa-numastat.node3.local_node
   1301898 ±  7%    +171.8%    3537939 ±  3%  numa-numastat.node3.numa_hit
     87047           -33.4%      57973 ± 39%  numa-numastat.node3.other_node
      1401           +14.7%       1608 ±  4%  proc-vmstat.nr_active_anon
     31600            +3.6%      32724        proc-vmstat.nr_kernel_stack
      1434 ±  2%      -5.4%       1357 ±  2%  proc-vmstat.nr_page_table_pages
      6359            +3.2%       6563        proc-vmstat.nr_shmem
     49106            +3.0%      50574        proc-vmstat.nr_slab_reclaimable
     70492           +12.2%      79065        proc-vmstat.nr_slab_unreclaimable
      1401           +14.7%       1608 ±  4%  proc-vmstat.nr_zone_active_anon
      4624 ±133%     -98.6%      65.33 ±115%  proc-vmstat.numa_pages_migrated
      2629            +6.7%       2805 ±  2%  proc-vmstat.pgactivate
      4624 ±133%     -98.6%      65.33 ±115%  proc-vmstat.pgmigrate_success
     16244            +7.9%      17527 ±  6%  proc-vmstat.pgreuse
 2.599e+09            -2.1%  2.543e+09        perf-stat.i.branch-instructions
     40.08 ± 11%     +11.5       51.53        perf-stat.i.cache-miss-rate%
  83712718 ± 18%     -26.5%   61515419        perf-stat.i.cache-references
      3602            -1.9%       3534        perf-stat.i.context-switches
    270.60            -3.4%     261.51        perf-stat.i.cpu-migrations
      0.04 ± 62%      -0.0        0.01        perf-stat.i.dTLB-load-miss-rate%
   1127093 ± 63%     -82.7%     195421 ±  2%  perf-stat.i.dTLB-load-misses
 3.052e+09 ±  2%      -6.6%   2.85e+09 ±  2%  perf-stat.i.dTLB-loads
      0.01 ± 58%      -0.0        0.00        perf-stat.i.dTLB-store-miss-rate%
    163825 ± 58%     -72.0%      45947        perf-stat.i.dTLB-store-misses
 1.205e+09            -5.9%  1.134e+09        perf-stat.i.dTLB-stores
   2754325 ±  8%     +11.9%    3080812        perf-stat.i.iTLB-loads
 1.245e+10            -2.2%  1.217e+10        perf-stat.i.instructions
    529.53 ± 14%     -21.8%     414.06        perf-stat.i.metric.K/sec
     35.67            -4.8%      33.97        perf-stat.i.metric.M/sec
     12565 ±  4%      -6.1%      11793        perf-stat.i.minor-faults
     19.67 ± 11%     +13.4       33.04 ±  5%  perf-stat.i.node-load-miss-rate%
   1932373 ±  4%     +74.9%    3380337 ±  4%  perf-stat.i.node-load-misses
   9008481 ±  5%     -19.0%    7299190 ±  2%  perf-stat.i.node-loads
     23.58 ±  9%      +6.9       30.45 ±  9%  perf-stat.i.node-store-miss-rate%
    963702 ± 14%     +31.7%    1269384 ±  4%  perf-stat.i.node-store-misses
   3311559 ±  3%      -9.0%    3014187 ±  4%  perf-stat.i.node-stores
     12575 ±  4%      -6.1%      11803        perf-stat.i.page-faults
     39.24 ± 12%     +12.0       51.20        perf-stat.overall.cache-miss-rate%
      0.04 ± 62%      -0.0        0.01        perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 57%      -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     17.68 ±  6%     +13.9       31.63        perf-stat.overall.node-load-miss-rate%
     22.50 ± 12%      +7.1       29.65 ±  6%  perf-stat.overall.node-store-miss-rate%
 2.465e+09            -1.7%  2.424e+09        perf-stat.ps.branch-instructions
  79393861 ± 18%     -26.2%   58619062        perf-stat.ps.cache-references
    256.54            -2.9%     248.99        perf-stat.ps.cpu-migrations
   1068598 ± 63%     -82.6%     185709 ±  2%  perf-stat.ps.dTLB-load-misses
 2.895e+09 ±  2%      -6.1%  2.717e+09 ±  2%  perf-stat.ps.dTLB-loads
    155087 ± 58%     -71.9%      43504        perf-stat.ps.dTLB-store-misses
 1.144e+09            -5.5%  1.081e+09        perf-stat.ps.dTLB-stores
   2614299 ±  8%     +12.3%    2936796        perf-stat.ps.iTLB-loads
 1.181e+10            -1.8%   1.16e+10        perf-stat.ps.instructions
     11807 ±  3%      -5.6%      11141        perf-stat.ps.minor-faults
   1832971 ±  4%     +75.7%    3221390 ±  4%  perf-stat.ps.node-load-misses
   8554322 ±  5%     -18.6%    6960163 ±  2%  perf-stat.ps.node-loads
    914226 ± 14%     +32.3%    1209266 ±  5%  perf-stat.ps.node-store-misses
   3143274 ±  3%      -8.6%    2874173 ±  4%  perf-stat.ps.node-stores
     11817 ±  3%      -5.6%      11150        perf-stat.ps.page-faults
 2.361e+11 ±  3%      +6.4%  2.512e+11        perf-stat.total.instructions
     19132           -63.9%       6901 ± 12%  numa-meminfo.node0.Active
      2088 ±  3%     -68.7%     654.00 ± 22%  numa-meminfo.node0.Active(anon)
     17043           -63.3%       6246 ± 11%  numa-meminfo.node0.Active(file)
     68298           -75.8%      16532 ±141%  numa-meminfo.node0.AnonHugePages
    276292 ±  9%     -68.0%      88420 ±123%  numa-meminfo.node0.AnonPages
    307916 ±  5%     -68.9%      95617 ±123%  numa-meminfo.node0.AnonPages.max
    145189           -62.5%      54414 ±  7%  numa-meminfo.node0.Dirty
   9777470 ± 12%     -56.1%    4293645 ± 25%  numa-meminfo.node0.FilePages
   8269055           -66.6%    2758978 ±  5%  numa-meminfo.node0.Inactive
    285386 ± 12%     -67.0%      94262 ±117%  numa-meminfo.node0.Inactive(anon)
   7983669           -66.6%    2664715        numa-meminfo.node0.Inactive(file)
    126968 ± 14%     -43.1%      72212 ± 35%  numa-meminfo.node0.KReclaimable
     11018 ±  4%     -20.0%       8816 ±  9%  numa-meminfo.node0.KernelStack
  29011509 ±  4%     +41.2%   40974386 ±  2%  numa-meminfo.node0.MemFree
  20145006 ±  6%     -59.4%    8182129 ± 14%  numa-meminfo.node0.MemUsed
      5210 ±  4%     -77.1%       1191 ± 23%  numa-meminfo.node0.PageTables
    126968 ± 14%     -43.1%      72212 ± 35%  numa-meminfo.node0.SReclaimable
    113658 ±  9%     -18.0%      93208 ±  9%  numa-meminfo.node0.SUnreclaim
    240627 ±  8%     -31.3%     165421 ± 20%  numa-meminfo.node0.Slab
      1540 ± 25%     -67.1%     507.00 ± 20%  numa-meminfo.node0.Writeback
      2507 ±  7%    +152.3%       6327 ±  4%  numa-meminfo.node1.Active
      2411 ±  4%    +138.9%       5762 ±  2%  numa-meminfo.node1.Active(file)
      3150 ± 61%   +1841.7%      61170 ± 48%  numa-meminfo.node1.AnonPages
      3473 ± 57%   +1747.1%      64157 ± 45%  numa-meminfo.node1.AnonPages.max
     24014 ±  8%    +108.7%      50127 ±  3%  numa-meminfo.node1.Dirty
   1262798 ±  4%    +138.7%    3014286 ±  2%  numa-meminfo.node1.Inactive
      9488 ± 65%    +548.6%      61540 ± 48%  numa-meminfo.node1.Inactive(anon)
   1253310 ±  4%    +135.6%    2952745 ±  3%  numa-meminfo.node1.Inactive(file)
      6724 ±  3%     +26.6%       8509 ±  2%  numa-meminfo.node1.KernelStack
   4051006 ± 26%     +73.8%    7040111        numa-meminfo.node1.MemUsed
    138.33 ± 54%   +1289.6%       1922 ± 41%  numa-meminfo.node1.PageTables
      2109 ± 10%    +196.2%       6247 ± 13%  numa-meminfo.node2.Active
      2087 ± 10%    +169.5%       5625 ± 13%  numa-meminfo.node2.Active(file)
     18867 ±134%    +571.6%     126709 ± 68%  numa-meminfo.node2.AnonPages
     27004 ±135%    +410.3%     137813 ± 67%  numa-meminfo.node2.AnonPages.max
     19080 ±  8%    +178.5%      53131 ±  7%  numa-meminfo.node2.Dirty
   1073700 ± 11%    +157.4%    2763903 ±  2%  numa-meminfo.node2.FilePages
   1089976 ±  9%    +156.8%    2798747 ±  4%  numa-meminfo.node2.Inactive
     21869 ±133%    +507.8%     132924 ± 62%  numa-meminfo.node2.Inactive(anon)
   1068106 ± 11%    +149.6%    2665823 ±  2%  numa-meminfo.node2.Inactive(file)
     14479 ±  2%    +152.4%      36538 ± 26%  numa-meminfo.node2.KReclaimable
      1726 ±106%    +139.9%       4141 ± 58%  numa-meminfo.node2.Mapped
   2850224 ±  8%    +130.9%    6580642        numa-meminfo.node2.MemUsed
     67.33 ± 74%   +1243.1%     904.33 ±  9%  numa-meminfo.node2.PageTables
     14479 ±  2%    +152.4%      36538 ± 26%  numa-meminfo.node2.SReclaimable
     51831 ±  2%     +44.3%      74799 ± 18%  numa-meminfo.node2.SUnreclaim
      3038 ±123%    +130.9%       7016 ± 62%  numa-meminfo.node2.Shmem
     66311           +67.9%     111337 ± 20%  numa-meminfo.node2.Slab
    359.00 ±141%  +23589.4%      85045 ± 86%  numa-meminfo.node2.Unevictable
      5571 ±  2%     +92.9%      10745 ±  2%  numa-meminfo.node3.Active
      3401 ±  2%     +35.0%       4593 ±  4%  numa-meminfo.node3.Active(anon)
      2169 ±  2%    +183.5%       6152        numa-meminfo.node3.Active(file)
      2313 ±  4%    +961.4%      24557 ± 50%  numa-meminfo.node3.AnonPages
     10494 ± 17%    +271.4%      38973 ± 34%  numa-meminfo.node3.AnonPages.max
     20071 ± 10%    +168.8%      53950 ±  5%  numa-meminfo.node3.Dirty
   1111599 ±  4%    +253.5%    3929901 ± 27%  numa-meminfo.node3.FilePages
   1109455 ±  4%    +189.1%    3207390 ±  3%  numa-meminfo.node3.Inactive
      4665 ± 10%    +567.5%      31145 ± 56%  numa-meminfo.node3.Inactive(anon)
   1104789 ±  4%    +187.5%    3176244 ±  3%  numa-meminfo.node3.Inactive(file)
     17657          +207.4%      54286 ± 43%  numa-meminfo.node3.KReclaimable
      7059 ±  9%     +12.5%       7943 ±  6%  numa-meminfo.node3.KernelStack
  46560977           -11.3%   41306504 ±  2%  numa-meminfo.node3.MemFree
   2928314 ±  3%    +179.4%    8182782 ± 14%  numa-meminfo.node3.MemUsed
    318.33 ±  8%    +341.9%       1406 ± 37%  numa-meminfo.node3.PageTables
     17657          +207.4%      54286 ± 43%  numa-meminfo.node3.SReclaimable
     55405 ±  4%     +35.1%      74849 ±  9%  numa-meminfo.node3.SUnreclaim
      4507 ± 10%    +152.5%      11382 ± 69%  numa-meminfo.node3.Shmem
     73062 ±  3%     +76.7%     129136 ± 23%  numa-meminfo.node3.Slab
     87.67 ±109%    +831.6%     816.67 ± 62%  numa-meminfo.node3.Writeback
    521.67 ±  3%     -68.8%     163.00 ± 22%  numa-vmstat.node0.nr_active_anon
      4270 ±  2%     -63.5%       1558 ± 11%  numa-vmstat.node0.nr_active_file
     69116 ± 10%     -68.0%      22118 ±123%  numa-vmstat.node0.nr_anon_pages
   2361412           -66.6%     789675        numa-vmstat.node0.nr_dirtied
     36058 ±  2%     -62.7%      13445 ±  8%  numa-vmstat.node0.nr_dirty
   2441191 ± 12%     -56.1%    1072902 ± 25%  numa-vmstat.node0.nr_file_pages
   7244956 ±  4%     +41.3%   10240234 ±  2%  numa-vmstat.node0.nr_free_pages
     71387 ± 12%     -67.0%      23577 ±117%  numa-vmstat.node0.nr_inactive_anon
   1992723           -66.6%     665671        numa-vmstat.node0.nr_inactive_file
     10994 ±  4%     -19.9%       8809 ±  9%  numa-vmstat.node0.nr_kernel_stack
      1283 ±  5%     -76.9%     296.33 ± 22%  numa-vmstat.node0.nr_page_table_pages
     31799 ± 14%     -43.2%      18054 ± 35%  numa-vmstat.node0.nr_slab_reclaimable
     28408 ±  9%     -18.0%      23301 ±  9%  numa-vmstat.node0.nr_slab_unreclaimable
    405.67 ±  5%     -71.5%     115.67 ± 19%  numa-vmstat.node0.nr_writeback
   2324918           -66.6%     776126        numa-vmstat.node0.nr_written
    521.67 ±  3%     -68.8%     163.00 ± 22%  numa-vmstat.node0.nr_zone_active_anon
      4270 ±  2%     -63.5%       1558 ± 11%  numa-vmstat.node0.nr_zone_active_file
     71385 ± 12%     -67.0%      23576 ±117%  numa-vmstat.node0.nr_zone_inactive_anon
   1992709           -66.6%     665647        numa-vmstat.node0.nr_zone_inactive_file
     36410 ±  2%     -62.8%      13546 ±  7%  numa-vmstat.node0.nr_zone_write_pending
   6403385 ±  4%     -58.3%    2673098 ± 12%  numa-vmstat.node0.numa_hit
   6399174 ±  4%     -59.4%    2596121 ± 13%  numa-vmstat.node0.numa_local
      3604 ± 57%   +2061.9%      77913 ± 17%  numa-vmstat.node0.numa_other
     23.33 ± 96%    +502.9%     140.67 ± 37%  numa-vmstat.node1.nr_active_anon
    605.00 ±  4%    +138.3%       1442 ±  2%  numa-vmstat.node1.nr_active_file
    784.33 ± 61%   +1852.8%      15316 ± 47%  numa-vmstat.node1.nr_anon_pages
    367180 ±  4%    +130.4%     845833 ±  3%  numa-vmstat.node1.nr_dirtied
      5937 ±  8%    +109.3%      12426 ±  3%  numa-vmstat.node1.nr_dirty
      2370 ± 65%    +550.2%      15410 ± 47%  numa-vmstat.node1.nr_inactive_anon
    312758 ±  4%    +135.6%     736785 ±  3%  numa-vmstat.node1.nr_inactive_file
      6721 ±  3%     +26.5%       8499        numa-vmstat.node1.nr_kernel_stack
     32.67 ± 58%   +1356.1%     475.67 ± 42%  numa-vmstat.node1.nr_page_table_pages
    361167 ±  4%    +130.7%     833225 ±  3%  numa-vmstat.node1.nr_written
     23.33 ± 96%    +501.4%     140.33 ± 37%  numa-vmstat.node1.nr_zone_active_anon
    605.00 ±  4%    +138.3%       1441 ±  2%  numa-vmstat.node1.nr_zone_active_file
      2370 ± 65%    +550.2%      15410 ± 47%  numa-vmstat.node1.nr_zone_inactive_anon
    312746 ±  4%    +135.6%     736794 ±  3%  numa-vmstat.node1.nr_zone_inactive_file
      5985 ±  8%    +110.0%      12567 ±  2%  numa-vmstat.node1.nr_zone_write_pending
   1348209 ± 20%     +69.1%    2279324 ±  3%  numa-vmstat.node1.numa_hit
   1241961 ± 21%     +77.6%    2206168 ±  3%  numa-vmstat.node1.numa_local
      5.33 ± 35%   +2812.5%     155.33 ± 22%  numa-vmstat.node2.nr_active_anon
    520.67 ± 11%    +172.2%       1417 ± 14%  numa-vmstat.node2.nr_active_file
      4719 ±134%    +571.5%      31688 ± 68%  numa-vmstat.node2.nr_anon_pages
    311740 ± 12%    +150.5%     780761        numa-vmstat.node2.nr_dirtied
      4746 ±  8%    +177.3%      13163 ±  8%  numa-vmstat.node2.nr_dirty
    268033 ± 11%    +157.6%     690490        numa-vmstat.node2.nr_file_pages
      5468 ±133%    +507.9%      33242 ± 62%  numa-vmstat.node2.nr_inactive_anon
    266633 ± 11%    +149.8%     665970 ±  2%  numa-vmstat.node2.nr_inactive_file
    431.33 ±106%    +147.4%       1067 ± 52%  numa-vmstat.node2.nr_mapped
     16.67 ± 73%   +1238.0%     223.00 ±  9%  numa-vmstat.node2.nr_page_table_pages
    759.67 ±123%    +130.8%       1753 ± 62%  numa-vmstat.node2.nr_shmem
      3630 ±  2%    +152.6%       9169 ± 26%  numa-vmstat.node2.nr_slab_reclaimable
     12957 ±  2%     +44.3%      18698 ± 18%  numa-vmstat.node2.nr_slab_unreclaimable
     89.33 ±141%  +23699.6%      21261 ± 86%  numa-vmstat.node2.nr_unevictable
    306939 ± 12%    +150.0%     767458        numa-vmstat.node2.nr_written
      5.33 ± 35%   +2812.5%     155.33 ± 22%  numa-vmstat.node2.nr_zone_active_anon
    520.67 ± 11%    +172.2%       1417 ± 14%  numa-vmstat.node2.nr_zone_active_file
      5468 ±133%    +507.9%      33242 ± 62%  numa-vmstat.node2.nr_zone_inactive_anon
    266639 ± 11%    +149.8%     665976 ±  2%  numa-vmstat.node2.nr_zone_inactive_file
     89.33 ±141%  +23699.6%      21261 ± 86%  numa-vmstat.node2.nr_zone_unevictable
      4803 ±  8%    +176.8%      13297 ±  8%  numa-vmstat.node2.nr_zone_write_pending
    990757 ±  5%    +121.4%    2193355 ±  5%  numa-vmstat.node2.numa_hit
    881411 ±  6%    +137.7%    2094791 ±  5%  numa-vmstat.node2.numa_local
    850.00 ±  2%     +35.1%       1148 ±  4%  numa-vmstat.node3.nr_active_anon
    548.00 ±  3%    +182.2%       1546        numa-vmstat.node3.nr_active_file
    638.67 ±  3%    +873.8%       6219 ± 49%  numa-vmstat.node3.nr_anon_pages
    322944 ±  4%    +181.9%     910237 ±  3%  numa-vmstat.node3.nr_dirtied
      4951 ± 11%    +171.7%      13451 ±  5%  numa-vmstat.node3.nr_dirty
    277018 ±  4%    +253.8%     980150 ± 27%  numa-vmstat.node3.nr_file_pages
  11639803           -11.3%   10325268 ±  2%  numa-vmstat.node3.nr_free_pages
      1222 ± 12%    +543.0%       7862 ± 56%  numa-vmstat.node3.nr_inactive_anon
    275308 ±  4%    +187.6%     791735 ±  3%  numa-vmstat.node3.nr_inactive_file
      7059 ±  9%     +12.5%       7944 ±  6%  numa-vmstat.node3.nr_kernel_stack
     79.00 ±  8%    +341.4%     348.67 ± 36%  numa-vmstat.node3.nr_page_table_pages
      1126 ± 10%    +152.7%       2847 ± 69%  numa-vmstat.node3.nr_shmem
      4431          +206.9%      13601 ± 43%  numa-vmstat.node3.nr_slab_reclaimable
     13850 ±  4%     +35.1%      18717 ±  9%  numa-vmstat.node3.nr_slab_unreclaimable
     41.33 ±122%    +373.4%     195.67 ± 44%  numa-vmstat.node3.nr_writeback
    317952 ±  3%    +182.0%     896576 ±  3%  numa-vmstat.node3.nr_written
    850.00 ±  2%     +35.1%       1148 ±  4%  numa-vmstat.node3.nr_zone_active_anon
    548.00 ±  3%    +182.2%       1546        numa-vmstat.node3.nr_zone_active_file
      1222 ± 12%    +543.0%       7862 ± 56%  numa-vmstat.node3.nr_zone_inactive_anon
    275306 ±  4%    +187.6%     791737 ±  3%  numa-vmstat.node3.nr_zone_inactive_file
      4987 ± 11%    +173.4%      13634 ±  5%  numa-vmstat.node3.nr_zone_write_pending
   1015839 ±  3%    +151.1%    2551060 ± 10%  numa-vmstat.node3.numa_hit
    907100 ±  3%    +172.4%    2471388 ± 11%  numa-vmstat.node3.numa_local
      7.36 ±  3%      -1.7        5.70 ± 16%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      7.36 ±  3%      -1.7        5.70 ± 16%  perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      7.35 ±  3%      -1.7        5.70 ± 16%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      7.35 ±  3%      -1.7        5.70 ± 16%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages
      6.60 ±  3%      -1.5        5.09 ± 17%  perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.submit_bio_noacct.__submit_merged_bio.__submit_merged_write_cond
      6.58 ±  3%      -1.5        5.08 ± 17%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_submit_bio.__submit_bio.submit_bio_noacct.__submit_merged_bio
      4.39 ±  3%      -1.0        3.38 ± 18%  perf-profile.calltrace.cycles-pp.brd_insert_page.brd_do_bvec.brd_submit_bio.__submit_bio.submit_bio_noacct
      3.18 ±  3%      -0.7        2.45 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_submit_bio.__submit_bio
      1.76 ±  5%      -0.3        1.42 ± 17%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.f2fs_write_begin.generic_perform_write.f2fs_buffered_write_iter
      1.78 ±  4%      -0.3        1.45 ± 17%  perf-profile.calltrace.cycles-pp.pagecache_get_page.f2fs_write_begin.generic_perform_write.f2fs_buffered_write_iter.f2fs_file_write_iter
      0.73 ±  7%      -0.3        0.41 ± 72%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
      1.11 ±  6%      -0.2        0.87 ± 19%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.75 ±  3%      -0.1        0.60 ± 13%  perf-profile.calltrace.cycles-pp.f2fs_write_end_io.__submit_bio.submit_bio_noacct.__submit_merged_bio.__submit_merged_write_cond
      0.69 ± 20%      +0.1        0.82 ± 16%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.17 ±141%      +0.4        0.62 ± 22%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
      7.38 ±  3%      -1.7        5.71 ± 16%  perf-profile.children.cycles-pp.submit_bio_noacct
      7.38 ±  3%      -1.7        5.71 ± 16%  perf-profile.children.cycles-pp.__submit_bio
      7.38 ±  3%      -1.7        5.72 ± 16%  perf-profile.children.cycles-pp.__submit_merged_bio
      7.38 ±  3%      -1.7        5.72 ± 16%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      6.61 ±  3%      -1.5        5.11 ± 17%  perf-profile.children.cycles-pp.brd_submit_bio
      6.59 ±  3%      -1.5        5.09 ± 17%  perf-profile.children.cycles-pp.brd_do_bvec
      4.42 ±  3%      -1.0        3.42 ± 17%  perf-profile.children.cycles-pp.brd_insert_page
      0.88 ± 95%      -0.7        0.15 ± 16%  perf-profile.children.cycles-pp.start_kernel
      2.27 ±  5%      -0.4        1.83 ± 15%  perf-profile.children.cycles-pp.pagecache_get_page
      2.21 ±  4%      -0.4        1.79 ± 15%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.12 ±  6%      -0.2        0.88 ± 19%  perf-profile.children.cycles-pp.filemap_add_folio
      0.74 ±  7%      -0.2        0.58 ± 16%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.76 ±  3%      -0.1        0.61 ± 13%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.58 ±  4%      -0.1        0.45 ± 13%  perf-profile.children.cycles-pp.folio_end_writeback
      0.50 ±  5%      -0.1        0.39 ± 14%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.30 ±  8%      -0.1        0.19 ± 21%  perf-profile.children.cycles-pp.update_rq_clock
      0.39 ± 18%      -0.1        0.30 ± 27%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.39 ± 17%      -0.1        0.30 ± 27%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.11 ± 11%      -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.23 ±  4%      -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.__radix_tree_preload
      0.11 ±  7%      -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.18 ±  6%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.18 ± 17%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      0.22 ± 21%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.12 ± 22%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.09 ± 10%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.__xa_set_mark
      0.25 ±  9%      -0.0        0.20 ± 12%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.10 ± 21%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.timerqueue_add
      0.16 ±  7%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.15 ± 14%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.brd_lookup_page
      0.10 ± 21%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.14 ±  6%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.fault_in_readable
      0.13 ± 15%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.__cond_resched
      0.11 ±  7%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.xas_store
      0.12 ± 10%      -0.0        0.09        perf-profile.children.cycles-pp.__might_sleep
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.alloc_pages
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.08 ±  6%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.try_charge_memcg
      0.06 ±  8%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.f2fs_update_iostat
      0.08 ± 11%      +0.0        0.11 ± 16%  perf-profile.children.cycles-pp.f2fs_inode_chksum_verify
      0.12 ± 10%      +0.0        0.16 ± 13%  perf-profile.children.cycles-pp.update_sit_entry
      0.10 ±  8%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.__get_segment_type
      0.02 ±141%      +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.f2fs_target_device
      0.41 ± 14%      +0.1        0.48 ± 12%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.22 ± 11%      +0.1        0.33 ± 13%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.40 ±  9%      +0.1        0.51 ± 21%  perf-profile.children.cycles-pp.io_serial_in
      0.29 ±  8%      +0.1        0.43 ± 14%  perf-profile.children.cycles-pp.f2fs_balance_fs
      0.37 ± 24%      +0.2        0.56 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      2.01 ±  5%      -0.5        1.55 ± 15%  perf-profile.self.cycles-pp.brd_do_bvec
      1.42 ±  8%      -0.3        1.07 ± 16%  perf-profile.self.cycles-pp.f2fs_write_end
      0.12 ± 16%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.update_rq_clock
      0.11 ±  8%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.22 ±  4%      -0.1        0.16 ± 10%  perf-profile.self.cycles-pp.__radix_tree_preload
      0.18 ±  7%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.10 ± 25%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.rebalance_domains
      0.12 ±  3%      -0.0        0.08 ± 17%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.14 ±  8%      -0.0        0.10 ± 19%  perf-profile.self.cycles-pp.rmqueue
      0.21 ±  7%      -0.0        0.18 ±  9%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.16 ±  3%      -0.0        0.12 ± 15%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.14 ±  6%      -0.0        0.11 ± 18%  perf-profile.self.cycles-pp.fault_in_readable
      0.09 ±  5%      -0.0        0.06 ± 23%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.11 ±  8%      -0.0        0.08        perf-profile.self.cycles-pp.__might_sleep
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.mutex_lock
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.08 ±  5%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.folio_end_writeback
      0.17 ±  4%      +0.0        0.19 ±  6%  perf-profile.self.cycles-pp.f2fs_map_blocks
      0.08 ± 10%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.__folio_mark_dirty
      0.06 ±  8%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.f2fs_update_iostat
      0.12 ± 10%      +0.0        0.16 ± 13%  perf-profile.self.cycles-pp.update_sit_entry
      0.10 ±  8%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__get_segment_type
      0.02 ±141%      +0.0        0.06 ± 19%  perf-profile.self.cycles-pp.f2fs_inode_chksum_verify
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.f2fs_target_device
      0.11 ±  7%      +0.1        0.18 ± 21%  perf-profile.self.cycles-pp.__get_node_page
      0.12 ± 17%      +0.1        0.18 ± 17%  perf-profile.self.cycles-pp.f2fs_write_begin
      0.17 ± 19%      +0.1        0.27 ± 13%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.29 ±  8%      +0.1        0.43 ± 14%  perf-profile.self.cycles-pp.f2fs_balance_fs
      0.34 ± 28%      +0.2        0.54 ± 10%  perf-profile.self.cycles-pp.percpu_counter_add_batch



***************************************************************************************************
lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/ext4/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/NoSync/lkp-csl-2ap4/24G/fsmark/0x500320a

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    122957 ±  7%     -41.3%      72222        fsmark.app_overhead
      2440 ±  2%     -26.2%       1801 ±  4%  fsmark.files_per_sec
    869.83           +25.5%       1091 ±  4%  fsmark.time.percent_of_cpu_this_job_got
    169.06 ±  2%     +29.9%     219.63 ±  4%  fsmark.time.system_time
      5.73 ±  4%     +12.9%       6.46 ±  5%  iostat.cpu.system
   1120075            -7.5%    1036423 ±  9%  vmstat.io.bo
    364503 ±  7%      +5.7%     385342        vmstat.system.in
     10457 ±  6%     +52.1%      15903 ±  9%  meminfo.Active
      6997 ±  9%     +81.0%      12666 ± 13%  meminfo.Active(anon)
     28931 ±  3%     +28.8%      37262 ±  4%  meminfo.Shmem
    844341 ± 13%    +342.6%    3737198 ± 74%  numa-numastat.node2.local_node
    911032 ± 12%    +317.3%    3801896 ± 73%  numa-numastat.node2.numa_hit
    379577 ±146%     -81.7%      69374 ± 27%  numa-numastat.node2.other_node
    849951 ± 20%    +237.0%    2864139 ± 80%  numa-numastat.node3.local_node
    927632 ± 18%    +215.0%    2922048 ± 79%  numa-numastat.node3.numa_hit
 2.262e+09            -3.7%  2.178e+09 ±  4%  perf-stat.i.branch-instructions
  50059502 ±  2%      +9.9%   55031386 ±  5%  perf-stat.i.cache-misses
    267.03            -2.2%     261.23 ±  2%  perf-stat.i.cpu-migrations
 1.206e+09            -4.6%   1.15e+09 ±  5%  perf-stat.i.dTLB-stores
 1.119e+10            -3.6%  1.079e+10 ±  4%  perf-stat.i.instructions
      9.90 ±  5%     -13.4%       8.58 ±  8%  perf-stat.i.major-faults
     68.64 ±  2%     +12.8       81.46        perf-stat.i.node-load-miss-rate%
  12916037 ±  3%     +15.1%   14866227 ±  6%  perf-stat.i.node-load-misses
   5586107 ±  6%     -40.0%    3349633 ±  8%  perf-stat.i.node-loads
      3.50 ±  3%     +14.4%       4.00 ±  3%  perf-stat.overall.cpi
      3328 ±  3%     -10.9%       2966 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.29 ±  3%     -12.5%       0.25 ±  3%  perf-stat.overall.ipc
     69.90 ±  2%     +11.8       81.72        perf-stat.overall.node-load-miss-rate%
  48090872 ±  2%     +11.2%   53476431 ±  4%  perf-stat.ps.cache-misses
 3.747e+10 ±  2%     +10.9%  4.157e+10 ±  5%  perf-stat.ps.cpu-cycles
  12291100 ±  3%     +15.9%   14246666 ±  5%  perf-stat.ps.node-load-misses
   5292116 ±  6%     -39.7%    3191213 ±  8%  perf-stat.ps.node-loads
      1733 ±  8%     +82.8%       3167 ± 13%  proc-vmstat.nr_active_anon
   2334357            -8.8%    2128372 ±  9%  proc-vmstat.nr_dirty
   5347564            -5.9%    5029652 ±  8%  proc-vmstat.nr_file_pages
     79430            +1.0%      80254        proc-vmstat.nr_inactive_anon
   4713828            -6.8%    4395202 ±  9%  proc-vmstat.nr_inactive_file
     31588            +1.6%      32107        proc-vmstat.nr_kernel_stack
     10415            +6.3%      11069        proc-vmstat.nr_mapped
      7220 ±  3%     +29.1%       9318 ±  4%  proc-vmstat.nr_shmem
     87414            +4.2%      91099 ±  2%  proc-vmstat.nr_slab_unreclaimable
      1733 ±  8%     +82.8%       3167 ± 13%  proc-vmstat.nr_zone_active_anon
     79430            +1.0%      80254        proc-vmstat.nr_zone_inactive_anon
   4713828            -6.8%    4395202 ±  9%  proc-vmstat.nr_zone_inactive_file
   2334942            -8.8%    2128919 ±  9%  proc-vmstat.nr_zone_write_pending
   1465471 ±  8%    -100.0%       0.00        proc-vmstat.numa_foreign
  12106397           +11.9%   13543781        proc-vmstat.numa_hit
  11937052           +11.3%   13287929        proc-vmstat.numa_local
   1459228 ±  8%    -100.0%       0.00        proc-vmstat.numa_miss
   1716007 ±  6%     -84.8%     260872        proc-vmstat.numa_other
      2675 ± 14%    +116.9%       5802 ±  9%  proc-vmstat.pgactivate
     50209 ± 31%     -63.8%      18155 ± 74%  numa-meminfo.node0.AnonHugePages
   8252135 ± 17%     -37.3%    5174756 ± 24%  numa-meminfo.node0.FilePages
   7185000 ±  5%     -31.1%    4948415 ± 19%  numa-meminfo.node1.FilePages
   7146622 ±  3%     -36.6%    4533737 ±  9%  numa-meminfo.node1.Inactive
   7091176 ±  4%     -36.9%    4476760 ±  9%  numa-meminfo.node1.Inactive(file)
    307.00 ± 41%    +333.4%       1330 ± 48%  numa-meminfo.node2.Active
    219.50 ± 12%    +280.4%     835.00 ± 71%  numa-meminfo.node2.Active(file)
      3261 ±198%   +1417.1%      49473 ±155%  numa-meminfo.node2.AnonPages
      6083 ±188%    +855.5%      58123 ±132%  numa-meminfo.node2.AnonPages.max
   1477008 ± 24%     +43.5%    2118995 ±  8%  numa-meminfo.node2.Dirty
      3557 ±178%   +1420.0%      54067 ±145%  numa-meminfo.node2.Inactive(anon)
     75574 ±  8%     +98.3%     149829 ±  6%  numa-meminfo.node2.KReclaimable
    551.67 ±  5%    +733.2%       4596 ± 45%  numa-meminfo.node2.Mapped
     85.33 ±128%    +852.9%     813.17 ± 22%  numa-meminfo.node2.PageTables
     75574 ±  8%     +98.3%     149829 ±  6%  numa-meminfo.node2.SReclaimable
     61158 ±  4%     +28.9%      78837 ±  5%  numa-meminfo.node2.SUnreclaim
    432.17 ± 66%   +1046.9%       4956 ± 80%  numa-meminfo.node2.Shmem
    136733 ±  5%     +67.2%     228667 ±  4%  numa-meminfo.node2.Slab
     41.67 ±164%  +1.6e+05%      66511 ±113%  numa-meminfo.node2.Unevictable
      5151 ± 13%    +127.5%      11719 ± 14%  numa-meminfo.node3.Active
      4938 ± 14%    +122.3%      10980 ± 15%  numa-meminfo.node3.Active(anon)
    211.67 ±  9%    +248.5%     737.67 ± 92%  numa-meminfo.node3.Active(file)
   1303369 ± 20%     +64.1%    2138250 ± 10%  numa-meminfo.node3.Dirty
   2739749 ± 37%    +103.7%    5579919 ± 16%  numa-meminfo.node3.FilePages
   2390623 ± 14%     +87.9%    4492696 ± 10%  numa-meminfo.node3.Inactive
   2310089 ± 16%     +91.5%    4424939 ± 10%  numa-meminfo.node3.Inactive(file)
     88743 ± 31%     +92.3%     170619 ±  8%  numa-meminfo.node3.KReclaimable
   3580239 ± 30%    +149.2%    8920534 ± 49%  numa-meminfo.node3.MemUsed
    567.83 ± 36%     +85.3%       1052 ± 35%  numa-meminfo.node3.PageTables
     88743 ± 31%     +92.3%     170619 ±  8%  numa-meminfo.node3.SReclaimable
    162480 ± 22%     +56.0%     253448 ±  4%  numa-meminfo.node3.Slab
   2080535 ± 18%     -37.8%    1293625 ± 23%  numa-vmstat.node0.nr_file_pages
     27818 ± 91%    +165.0%      73718 ± 28%  numa-vmstat.node0.numa_other
   1985397 ±  6%     -29.4%    1402170 ±  4%  numa-vmstat.node1.nr_dirtied
   1815794 ±  5%     -31.9%    1237101 ± 18%  numa-vmstat.node1.nr_file_pages
   1792343 ±  5%     -37.6%    1119190 ±  8%  numa-vmstat.node1.nr_inactive_file
   1282190 ±  9%     -32.4%     866377 ±  9%  numa-vmstat.node1.nr_written
   1792321 ±  5%     -37.6%    1119187 ±  8%  numa-vmstat.node1.nr_zone_inactive_file
     21.33 ±153%    +478.1%     123.33 ± 31%  numa-vmstat.node2.nr_active_anon
     55.17 ± 12%    +282.5%     211.00 ± 71%  numa-vmstat.node2.nr_active_file
    371312 ± 22%     +42.7%     529941 ±  7%  numa-vmstat.node2.nr_dirty
    920.17 ±180%   +1372.5%      13549 ±145%  numa-vmstat.node2.nr_inactive_anon
    140.67 ±  6%    +718.2%       1151 ± 45%  numa-vmstat.node2.nr_mapped
     21.33 ±131%    +843.8%     201.33 ± 22%  numa-vmstat.node2.nr_page_table_pages
    107.67 ± 67%   +1050.5%       1238 ± 80%  numa-vmstat.node2.nr_shmem
     19029 ±  7%     +96.8%      37452 ±  6%  numa-vmstat.node2.nr_slab_reclaimable
     15301 ±  4%     +28.9%      19720 ±  5%  numa-vmstat.node2.nr_slab_unreclaimable
     21.33 ±153%    +478.1%     123.33 ± 31%  numa-vmstat.node2.nr_zone_active_anon
     55.17 ± 12%    +282.5%     211.00 ± 71%  numa-vmstat.node2.nr_zone_active_file
    920.17 ±180%   +1372.5%      13549 ±145%  numa-vmstat.node2.nr_zone_inactive_anon
    371434 ± 22%     +42.7%     530074 ±  7%  numa-vmstat.node2.nr_zone_write_pending
   1090475 ±  9%    +179.5%    3048218 ± 49%  numa-vmstat.node2.numa_hit
    999961 ±  9%    +195.7%    2957320 ± 51%  numa-vmstat.node2.numa_local
    343707 ±130%     -72.9%      93030 ± 19%  numa-vmstat.node2.numa_other
      1205 ± 14%    +126.5%       2730 ± 14%  numa-vmstat.node3.nr_active_anon
     53.00 ±  9%    +245.3%     183.00 ± 93%  numa-vmstat.node3.nr_active_file
    672301 ± 15%    +104.4%    1374415 ±  4%  numa-vmstat.node3.nr_dirtied
    328259 ± 19%     +62.8%     534500 ±  9%  numa-vmstat.node3.nr_dirty
    689847 ± 36%    +102.3%    1395219 ± 16%  numa-vmstat.node3.nr_file_pages
    582451 ± 14%     +90.0%    1106487 ±  9%  numa-vmstat.node3.nr_inactive_file
    142.33 ± 37%     +84.1%     262.00 ± 35%  numa-vmstat.node3.nr_page_table_pages
     22316 ± 31%     +91.2%      42672 ±  7%  numa-vmstat.node3.nr_slab_reclaimable
    343968 ± 12%    +144.1%     839703 ± 10%  numa-vmstat.node3.nr_written
      1205 ± 14%    +126.5%       2730 ± 14%  numa-vmstat.node3.nr_zone_active_anon
     53.00 ±  9%    +245.3%     183.00 ± 93%  numa-vmstat.node3.nr_zone_active_file
    582443 ± 14%     +90.0%    1106485 ±  9%  numa-vmstat.node3.nr_zone_inactive_file
    328324 ± 19%     +62.9%     534716 ±  9%  numa-vmstat.node3.nr_zone_write_pending
   1341212 ± 22%    +110.8%    2827390 ± 37%  numa-vmstat.node3.numa_hit
   1242142 ± 24%    +121.1%    2746075 ± 38%  numa-vmstat.node3.numa_local
     12.09 ± 15%      -6.6        5.54 ±  7%  perf-profile.calltrace.cycles-pp.ret_from_fork
     12.09 ± 15%      -6.6        5.54 ±  7%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     11.97 ± 15%      -6.5        5.48 ±  7%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
     11.96 ± 15%      -6.5        5.48 ±  7%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
     11.61 ± 15%      -6.2        5.41 ±  8%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
     11.61 ± 15%      -6.2        5.41 ±  8%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
     10.88 ± 15%      -6.0        4.92 ±  9%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work.worker_thread
     10.87 ± 15%      -6.0        4.92 ±  9%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work
     10.87 ± 15%      -5.9        4.92 ±  9%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback
     10.87 ± 15%      -5.9        4.92 ±  9%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn
      5.95 ± 27%      -4.9        1.09 ± 11%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      5.73 ± 28%      -4.7        1.06 ± 11%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      5.66 ± 27%      -4.6        1.05 ± 10%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter
      8.20 ± 17%      -4.6        3.62 ±  9%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.ext4_io_submit.ext4_writepages.do_writepages.__writeback_single_inode
      8.20 ± 17%      -4.6        3.62 ±  9%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct.ext4_io_submit.ext4_writepages.do_writepages
      8.20 ± 17%      -4.6        3.62 ±  9%  perf-profile.calltrace.cycles-pp.ext4_io_submit.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      8.19 ± 17%      -4.6        3.62 ±  9%  perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.submit_bio_noacct.ext4_io_submit.ext4_writepages
      8.17 ± 17%      -4.6        3.61 ±  9%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_submit_bio.__submit_bio.submit_bio_noacct.ext4_io_submit
      8.07 ± 12%      -4.5        3.55 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.53 ± 11%      -3.5        2.00 ± 32%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      6.69 ± 13%      -3.5        3.17 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      4.29 ± 15%      -2.4        1.93 ±  9%  perf-profile.calltrace.cycles-pp.brd_insert_page.brd_do_bvec.brd_submit_bio.__submit_bio.submit_bio_noacct
      4.31 ± 13%      -2.3        2.02 ± 16%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.23 ± 13%      -2.3        1.98 ± 16%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.20 ± 13%      -2.2        1.02 ± 10%  perf-profile.calltrace.cycles-pp.pagecache_get_page.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      3.19 ± 13%      -2.2        1.01 ± 11%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3.08 ± 16%      -1.7        1.36 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_submit_bio.__submit_bio
      2.84 ± 25%      -1.7        1.12 ± 22%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.50 ± 22%      -1.7        0.81 ± 11%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      2.50 ± 24%      -1.5        0.96 ± 23%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.22 ± 14%      -1.4        0.82 ± 11%  perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      2.11 ± 13%      -1.4        0.74 ±  9%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.pagecache_get_page.ext4_da_write_begin.generic_perform_write
      1.78 ± 22%      -1.2        0.59 ± 49%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.96 ± 21%      -1.2        0.76 ± 21%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.69 ± 20%      -1.1        0.56 ± 48%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      1.98 ± 11%      -1.1        0.90 ± 54%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.10 ± 15%      -0.8        0.27 ±100%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_buffers.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      1.30 ± 10%      -0.8        0.48 ± 45%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page.ext4_da_write_begin
      1.08 ± 16%      -0.8        0.28 ±100%  perf-profile.calltrace.cycles-pp.ext4_put_io_end.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      1.14 ± 27%      -0.7        0.40 ± 75%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.20 ± 23%      -0.6        0.59 ± 12%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.90 ± 14%      -0.5        1.38 ± 10%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      0.73 ± 16%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work
      0.73 ± 16%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn
      0.73 ± 16%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
      0.73 ± 16%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      0.73 ± 16%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work.worker_thread
      0.32 ±103%      +0.9        1.25 ± 11%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_update_time
      0.22 ±143%      +0.9        1.17 ± 11%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.46 ± 75%      +1.0        1.48 ± 12%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks
      0.66 ± 50%      +1.0        1.70 ± 13%  perf-profile.calltrace.cycles-pp.ext4_write_checks.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      0.64 ± 50%      +1.0        1.69 ± 12%  perf-profile.calltrace.cycles-pp.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.62 ± 50%      +1.0        1.67 ± 11%  perf-profile.calltrace.cycles-pp.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write
      0.62 ± 50%      +1.1        1.67 ± 11%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter
      2.42 ± 10%      +1.1        3.54 ± 12%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.79 ±  6%      +1.2        2.98 ± 11%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.90 ± 19%      +1.4        2.28 ±  8%  perf-profile.calltrace.cycles-pp.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      1.18 ± 10%      +1.4        2.55 ±  9%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      3.82 ± 12%      +1.4        5.20 ±  7%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.97 ± 16%      +1.4        2.37 ± 11%  perf-profile.calltrace.cycles-pp.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.07 ± 10%      +1.4        2.47 ±  8%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      3.96 ± 12%      +1.4        5.40 ±  8%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      3.08 ± 13%      +1.6        4.64 ±  9%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      1.02 ± 18%      +1.7        2.68 ±  8%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      4.26 ±  8%      +2.3        6.56 ± 12%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      3.82 ± 15%      +2.4        6.22 ±  8%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
     43.99 ±  8%      +7.8       51.83 ±  9%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
     45.33 ±  9%      +8.4       53.74 ±  9%  perf-profile.calltrace.cycles-pp.write
     45.28 ±  9%      +8.4       53.72 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     45.27 ±  9%      +8.5       53.72 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     45.24 ±  9%      +8.5       53.71 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     45.20 ±  9%      +8.5       53.69 ±  9%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     45.12 ±  9%      +8.5       53.64 ±  9%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.78 ±  9%      +8.8       53.56 ±  9%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     20.02 ± 15%     +13.3       33.28 ±  9%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     20.05 ± 16%     +14.2       34.28 ±  9%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
     21.00 ± 15%     +14.7       35.68 ±  9%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
     32.04 ± 12%     +16.5       48.56 ±  8%  perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     25.28 ± 14%     +17.0       42.26 ±  9%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     29.40 ± 13%     +18.3       47.71 ±  8%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     12.10 ± 15%      -6.6        5.54 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
     12.09 ± 15%      -6.6        5.54 ±  7%  perf-profile.children.cycles-pp.kthread
     11.97 ± 15%      -6.5        5.48 ±  7%  perf-profile.children.cycles-pp.worker_thread
     11.96 ± 15%      -6.5        5.48 ±  7%  perf-profile.children.cycles-pp.process_one_work
     11.61 ± 15%      -6.2        5.41 ±  8%  perf-profile.children.cycles-pp.writeback_sb_inodes
     11.61 ± 15%      -6.2        5.41 ±  8%  perf-profile.children.cycles-pp.wb_workfn
     11.61 ± 15%      -6.2        5.41 ±  8%  perf-profile.children.cycles-pp.wb_writeback
     11.61 ± 15%      -6.2        5.40 ±  8%  perf-profile.children.cycles-pp.__writeback_single_inode
     11.61 ± 15%      -6.2        5.40 ±  8%  perf-profile.children.cycles-pp.do_writepages
     11.61 ± 15%      -6.2        5.40 ±  8%  perf-profile.children.cycles-pp.ext4_writepages
      9.40 ± 24%      -5.4        3.98 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.95 ± 27%      -4.9        1.09 ± 11%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      8.68 ± 15%      -4.7        3.98 ±  7%  perf-profile.children.cycles-pp.submit_bio_noacct
      8.68 ± 15%      -4.7        3.98 ±  7%  perf-profile.children.cycles-pp.__submit_bio
      8.68 ± 15%      -4.7        3.98 ±  7%  perf-profile.children.cycles-pp.brd_submit_bio
      8.65 ± 15%      -4.7        3.96 ±  8%  perf-profile.children.cycles-pp.brd_do_bvec
      5.73 ± 28%      -4.7        1.06 ± 11%  perf-profile.children.cycles-pp.copyin
      5.72 ± 28%      -4.7        1.06 ± 11%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      8.60 ± 15%      -4.6        3.95 ±  7%  perf-profile.children.cycles-pp.ext4_io_submit
      7.86 ± 12%      -4.3        3.52 ± 13%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      5.54 ± 12%      -3.5        2.00 ± 32%  perf-profile.children.cycles-pp.ext4_da_write_begin
      5.17 ± 14%      -2.8        2.33 ± 15%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.10 ± 14%      -2.8        2.30 ± 15%  perf-profile.children.cycles-pp.hrtimer_interrupt
      4.67 ± 16%      -2.5        2.14 ±  8%  perf-profile.children.cycles-pp.brd_insert_page
      3.89 ± 15%      -2.2        1.66 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock
      3.22 ± 13%      -2.2        1.02 ± 10%  perf-profile.children.cycles-pp.pagecache_get_page
      3.20 ± 13%      -2.2        1.02 ± 10%  perf-profile.children.cycles-pp.__filemap_get_folio
      3.13 ± 24%      -1.8        1.30 ± 20%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.50 ± 17%      -1.7        0.82 ± 12%  perf-profile.children.cycles-pp.block_write_end
      2.42 ± 16%      -1.6        0.81 ± 11%  perf-profile.children.cycles-pp.__block_commit_write
      2.53 ± 24%      -1.6        0.97 ± 23%  perf-profile.children.cycles-pp.menu_select
      2.11 ± 13%      -1.4        0.74 ±  9%  perf-profile.children.cycles-pp.filemap_add_folio
      2.19 ± 19%      -1.3        0.92 ± 18%  perf-profile.children.cycles-pp.tick_sched_timer
      1.91 ± 13%      -1.2        0.66 ±  9%  perf-profile.children.cycles-pp.__alloc_pages
      2.00 ± 20%      -1.2        0.80 ± 20%  perf-profile.children.cycles-pp.tick_sched_handle
      1.91 ± 18%      -1.1        0.77 ± 18%  perf-profile.children.cycles-pp.update_process_times
      1.69 ± 14%      -1.1        0.59 ± 10%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.63 ± 21%      -1.1        0.54 ± 32%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.98 ± 11%      -1.1        0.90 ± 54%  perf-profile.children.cycles-pp.ext4_block_write_begin
      1.43 ± 22%      -1.0        0.44 ± 41%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.72 ± 27%      -0.9        0.79 ± 38%  perf-profile.children.cycles-pp.ktime_get
      1.45 ± 11%      -0.8        0.63 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      1.31 ± 10%      -0.7        0.56 ±  9%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.94 ± 17%      -0.7        0.22 ± 16%  perf-profile.children.cycles-pp.folio_alloc
      1.31 ± 21%      -0.7        0.61 ± 28%  perf-profile.children.cycles-pp.clockevents_program_event
      1.26 ± 16%      -0.7        0.58 ±  8%  perf-profile.children.cycles-pp.mpage_map_and_submit_buffers
      1.13 ± 11%      -0.7        0.46 ± 15%  perf-profile.children.cycles-pp.mark_buffer_dirty
      1.00 ± 14%      -0.6        0.36 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.10 ± 11%      -0.6        0.48 ± 15%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.02 ± 18%      -0.6        0.40 ± 16%  perf-profile.children.cycles-pp.scheduler_tick
      0.78 ± 20%      -0.6        0.17 ± 11%  perf-profile.children.cycles-pp.folio_add_lru
      0.99 ± 10%      -0.6        0.39 ± 11%  perf-profile.children.cycles-pp.create_empty_buffers
      1.17 ± 15%      -0.6        0.59 ±  9%  perf-profile.children.cycles-pp.ext4_put_io_end
      1.15 ± 16%      -0.6        0.58 ±  9%  perf-profile.children.cycles-pp.ext4_release_io_end
      1.14 ± 16%      -0.6        0.58 ±  9%  perf-profile.children.cycles-pp.ext4_finish_bio
      0.78 ± 21%      -0.6        0.22 ± 65%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      1.03 ± 17%      -0.6        0.48 ±  8%  perf-profile.children.cycles-pp.mpage_submit_page
      0.68 ± 21%      -0.5        0.16 ± 12%  perf-profile.children.cycles-pp.__pagevec_lru_add
      1.94 ± 14%      -0.5        1.44 ± 10%  perf-profile.children.cycles-pp.stop_this_handle
      0.65 ± 13%      -0.4        0.21 ± 13%  perf-profile.children.cycles-pp.rmqueue
      0.80 ±  8%      -0.4        0.37 ± 10%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.76 ± 18%      -0.4        0.34 ± 10%  perf-profile.children.cycles-pp.ext4_bio_write_page
      0.81 ± 10%      -0.4        0.40 ±  9%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.74 ± 15%      -0.4        0.34 ± 18%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.70 ± 11%      -0.4        0.32 ± 11%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.50 ± 24%      -0.4        0.14 ± 45%  perf-profile.children.cycles-pp.vprintk_emit
      0.58 ± 20%      -0.4        0.22 ± 52%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.66 ± 10%      -0.4        0.32 ± 10%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.65 ± 10%      -0.3        0.30 ± 18%  perf-profile.children.cycles-pp.rebalance_domains
      0.66 ± 15%      -0.3        0.32 ±  9%  perf-profile.children.cycles-pp.folio_end_writeback
      0.48 ± 21%      -0.3        0.14 ± 45%  perf-profile.children.cycles-pp.console_unlock
      0.64 ± 22%      -0.3        0.30 ± 27%  perf-profile.children.cycles-pp.prep_new_page
      0.61 ± 24%      -0.3        0.29 ± 28%  perf-profile.children.cycles-pp.kernel_init_free_pages
      0.60 ± 24%      -0.3        0.28 ± 28%  perf-profile.children.cycles-pp.clear_page_erms
      0.64 ± 15%      -0.3        0.34 ± 30%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.58 ± 15%      -0.3        0.28 ± 10%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.38 ± 21%      -0.3        0.08 ± 78%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.54 ± 19%      -0.3        0.24 ± 18%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.42 ± 23%      -0.3        0.13 ± 45%  perf-profile.children.cycles-pp.serial8250_console_write
      0.60 ± 10%      -0.3        0.33 ±  9%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.52 ± 15%      -0.3        0.24 ± 12%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      0.39 ± 24%      -0.3        0.12 ± 42%  perf-profile.children.cycles-pp.wait_for_lsr
      0.45 ± 28%      -0.3        0.19 ± 11%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.73 ± 16%      -0.2        0.49 ± 17%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      0.37 ± 12%      -0.2        0.13 ± 13%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.26 ± 26%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.node_dirty_ok
      0.45 ± 11%      -0.2        0.23 ± 17%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.42 ± 18%      -0.2        0.20 ± 12%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.30 ± 14%      -0.2        0.08 ± 33%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.30 ± 13%      -0.2        0.08 ± 33%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.47 ± 11%      -0.2        0.25 ± 16%  perf-profile.children.cycles-pp.__getblk_gfp
      0.42 ±  6%      -0.2        0.21 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.31 ± 23%      -0.2        0.10 ± 47%  perf-profile.children.cycles-pp.io_serial_in
      0.43 ± 11%      -0.2        0.23 ± 18%  perf-profile.children.cycles-pp.__find_get_block
      0.39 ± 15%      -0.2        0.20 ± 50%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.34 ± 17%      -0.2        0.15 ± 16%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.43 ±  9%      -0.2        0.24 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.37 ± 16%      -0.2        0.19 ± 51%  perf-profile.children.cycles-pp.tick_irq_enter
      0.30 ± 16%      -0.2        0.13 ± 20%  perf-profile.children.cycles-pp.load_balance
      0.32 ± 23%      -0.2        0.16 ± 12%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.24 ± 10%      -0.2        0.07 ±  9%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.33 ± 29%      -0.2        0.17 ± 34%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.29 ± 16%      -0.2        0.13 ± 17%  perf-profile.children.cycles-pp.native_sched_clock
      0.26 ± 14%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.xas_load
      0.20 ± 18%      -0.2        0.04 ± 72%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.18 ± 20%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.29 ± 23%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.22 ±  8%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__might_resched
      0.29 ± 10%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.read_tsc
      0.32 ± 13%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.charge_memcg
      0.24 ± 17%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.update_rq_clock
      0.20 ± 10%      -0.1        0.06 ± 26%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.22 ± 19%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.update_blocked_averages
      0.26 ± 15%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.21 ± 33%      -0.1        0.08 ± 51%  perf-profile.children.cycles-pp.irq_work_run_list
      0.22 ± 15%      -0.1        0.09 ± 21%  perf-profile.children.cycles-pp.find_busiest_group
      0.20 ± 32%      -0.1        0.07 ± 50%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.20 ± 32%      -0.1        0.07 ± 50%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.20 ± 32%      -0.1        0.07 ± 50%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.20 ± 32%      -0.1        0.07 ± 50%  perf-profile.children.cycles-pp.irq_work_run
      0.20 ± 32%      -0.1        0.07 ± 50%  perf-profile.children.cycles-pp.irq_work_single
      0.20 ± 32%      -0.1        0.07 ± 50%  perf-profile.children.cycles-pp._printk
      0.22 ± 20%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.23 ± 29%      -0.1        0.10 ± 32%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.21 ± 15%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.24 ±  9%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.26 ± 14%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.20 ± 21%      -0.1        0.08 ±  7%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.20 ± 38%      -0.1        0.09 ± 65%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.19 ± 23%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.20 ± 14%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.__radix_tree_preload
      0.19 ± 26%      -0.1        0.09 ± 36%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.18 ± 14%      -0.1        0.09 ± 22%  perf-profile.children.cycles-pp.___slab_alloc
      0.18 ± 14%      -0.1        0.09 ± 21%  perf-profile.children.cycles-pp.__slab_alloc
      0.19 ± 19%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.mpage_process_page_bufs
      0.16 ± 14%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.16 ± 14%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.13 ± 17%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.15 ± 20%      -0.1        0.07 ± 25%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.14 ± 23%      -0.1        0.05 ± 51%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.15 ± 18%      -0.1        0.06 ± 17%  perf-profile.children.cycles-pp.brd_lookup_page
      0.15 ± 21%      -0.1        0.07 ± 31%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.15 ± 14%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.15 ± 35%      -0.1        0.07 ± 41%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.18 ± 21%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.14 ± 11%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.release_pages
      0.15 ± 27%      -0.1        0.07 ± 24%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.16 ± 14%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.allocate_slab
      0.11 ± 26%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.11 ± 12%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.11 ± 15%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ± 17%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.09 ± 14%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__pagevec_release
      0.11 ± 26%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ± 22%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.14 ± 20%      -0.1        0.08 ± 21%  perf-profile.children.cycles-pp.try_charge_memcg
      0.12 ± 16%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__count_memcg_events
      0.16 ±  7%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.10 ± 11%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.09 ± 20%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.16 ±  7%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.do_sys_open
      0.16 ±  7%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.do_sys_openat2
      0.15 ±  5%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.do_filp_open
      0.15 ±  6%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.path_openat
      0.10 ± 20%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.72 ± 28%      +1.0        1.70 ± 13%  perf-profile.children.cycles-pp.ext4_write_checks
      0.70 ± 29%      +1.0        1.69 ± 12%  perf-profile.children.cycles-pp.file_update_time
      0.68 ± 29%      +1.0        1.67 ± 11%  perf-profile.children.cycles-pp.generic_update_time
      2.49 ± 10%      +1.2        3.67 ± 12%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      1.85 ±  6%      +1.3        3.10 ± 11%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.92 ± 19%      +1.4        2.37 ±  8%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      1.22 ± 10%      +1.4        2.66 ±  9%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      1.00 ± 16%      +1.5        2.46 ± 11%  perf-profile.children.cycles-pp.ext4_journal_check_start
      1.11 ± 10%      +1.5        2.59 ±  8%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      3.91 ± 13%      +1.5        5.40 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_stop
      4.06 ± 13%      +1.5        5.60 ±  8%  perf-profile.children.cycles-pp.__ext4_journal_stop
      3.16 ± 13%      +1.6        4.80 ±  9%  perf-profile.children.cycles-pp.add_transaction_credits
      1.06 ± 18%      +1.7        2.78 ±  8%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      4.39 ±  8%      +2.4        6.82 ± 12%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      3.99 ± 15%      +2.5        6.47 ±  8%  perf-profile.children.cycles-pp._raw_read_lock
     44.00 ±  8%      +7.8       51.84 ±  9%  perf-profile.children.cycles-pp.generic_perform_write
     45.75 ±  9%      +8.2       53.97 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     45.73 ±  9%      +8.2       53.96 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
     45.34 ±  9%      +8.4       53.76 ±  9%  perf-profile.children.cycles-pp.write
     45.24 ±  9%      +8.5       53.72 ±  9%  perf-profile.children.cycles-pp.ksys_write
     45.21 ±  9%      +8.5       53.70 ±  9%  perf-profile.children.cycles-pp.vfs_write
     45.13 ±  9%      +8.5       53.66 ±  9%  perf-profile.children.cycles-pp.new_sync_write
     44.78 ±  9%      +8.8       53.56 ±  9%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
     20.52 ± 15%     +14.0       34.49 ±  9%  perf-profile.children.cycles-pp.jbd2__journal_start
     20.34 ± 16%     +14.0       34.34 ±  9%  perf-profile.children.cycles-pp.start_this_handle
     21.53 ± 15%     +15.4       36.97 ±  9%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
     32.08 ± 12%     +16.5       48.56 ±  8%  perf-profile.children.cycles-pp.generic_write_end
     25.87 ± 14%     +17.9       43.73 ±  9%  perf-profile.children.cycles-pp.ext4_dirty_inode
     30.18 ± 13%     +19.2       49.41 ±  8%  perf-profile.children.cycles-pp.__mark_inode_dirty
      5.68 ± 28%      -4.6        1.06 ± 11%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      3.78 ± 15%      -2.1        1.64 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      3.81 ± 15%      -2.0        1.76 ±  7%  perf-profile.self.cycles-pp.brd_do_bvec
      1.49 ± 31%      -0.8        0.68 ± 45%  perf-profile.self.cycles-pp.ktime_get
      0.90 ± 21%      -0.6        0.32 ± 10%  perf-profile.self.cycles-pp.__block_commit_write
      0.78 ± 20%      -0.6        0.22 ± 66%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.99 ± 14%      -0.5        0.50 ± 17%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.92 ± 14%      -0.5        1.43 ± 10%  perf-profile.self.cycles-pp.stop_this_handle
      0.77 ± 12%      -0.4        0.35 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.44 ± 27%      -0.3        0.12 ± 48%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.59 ± 23%      -0.3        0.28 ± 28%  perf-profile.self.cycles-pp.clear_page_erms
      0.38 ± 21%      -0.3        0.08 ± 78%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.42 ± 29%      -0.3        0.14 ± 50%  perf-profile.self.cycles-pp.update_process_times
      0.45 ± 11%      -0.2        0.23 ± 17%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.29 ± 13%      -0.2        0.07 ± 33%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.40 ± 26%      -0.2        0.18 ± 27%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.42 ±  6%      -0.2        0.21 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.31 ± 23%      -0.2        0.10 ± 47%  perf-profile.self.cycles-pp.io_serial_in
      0.23 ± 18%      -0.2        0.04 ± 72%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.41 ± 12%      -0.2        0.22 ± 19%  perf-profile.self.cycles-pp.__find_get_block
      0.28 ± 13%      -0.2        0.10 ± 12%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.23 ± 11%      -0.2        0.07 ±  9%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.33 ± 30%      -0.2        0.17 ± 34%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.38 ±  9%      -0.2        0.22 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.28 ± 16%      -0.2        0.13 ± 15%  perf-profile.self.cycles-pp.native_sched_clock
      0.20 ± 18%      -0.2        0.05 ± 47%  perf-profile.self.cycles-pp.rmqueue
      0.19 ± 16%      -0.2        0.04 ± 73%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.19 ± 13%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.22 ±  9%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.__might_resched
      0.28 ± 11%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.26 ± 12%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.21 ± 13%      -0.1        0.09 ± 10%  perf-profile.self.cycles-pp.xas_load
      0.20 ± 23%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.19 ± 23%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.14 ±  6%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__alloc_pages
      0.20 ± 11%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.20 ± 15%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__radix_tree_preload
      0.19 ± 11%      -0.1        0.09 ± 11%  perf-profile.self.cycles-pp.ext4_bio_write_page
      0.18 ± 37%      -0.1        0.08 ± 61%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.17 ± 12%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.23 ± 13%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.18 ± 20%      -0.1        0.10 ± 14%  perf-profile.self.cycles-pp.mpage_process_page_bufs
      0.17 ± 31%      -0.1        0.08 ± 38%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.16 ± 18%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.do_idle
      0.14 ± 23%      -0.1        0.05 ± 51%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.15 ± 19%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.15 ± 14%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.13 ± 18%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.14 ± 12%      -0.1        0.06 ± 25%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.13 ±  9%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.release_pages
      0.12 ± 12%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.10 ± 22%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.13 ± 15%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
      0.10 ± 23%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.mpage_map_and_submit_buffers
      0.14 ± 15%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.ext4_finish_bio
      0.16 ± 16%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.11 ± 18%      -0.1        0.05 ± 51%  perf-profile.self.cycles-pp.allocate_slab
      0.10 ± 13%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.folio_memcg_lock
      0.11 ± 11%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__count_memcg_events
      0.16 ±  5%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.10 ± 20%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.08 ± 14%      +0.0        0.12 ± 19%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.10 ± 22%      +0.3        0.40 ±  9%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      0.92 ± 19%      +1.4        2.35 ±  8%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.95 ± 17%      +1.5        2.43 ± 12%  perf-profile.self.cycles-pp.ext4_journal_check_start
      0.87 ± 13%      +1.6        2.50 ±  8%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      3.14 ± 13%      +1.6        4.78 ±  9%  perf-profile.self.cycles-pp.add_transaction_credits
      1.93 ± 13%      +2.0        3.93 ±  7%  perf-profile.self.cycles-pp.jbd2_journal_stop
      3.94 ± 15%      +2.5        6.44 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
     13.14 ± 17%      +9.8       22.93 ±  9%  perf-profile.self.cycles-pp.start_this_handle



***************************************************************************************************
lkp-icl-2sp1: 96 threads 2 sockets Ice Lake with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  filesystem/gcc-11/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp1/fstat/stress-ng/60s/0xb000280

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1919597           -20.1%    1534630        stress-ng.fstat.ops
     31993           -20.1%      25577        stress-ng.fstat.ops_per_sec
    817763 ±  4%     -28.9%     581442 ±  2%  stress-ng.time.involuntary_context_switches
      2887            +5.7%       3051        stress-ng.time.percent_of_cpu_this_job_got
      1626            +8.3%       1761        stress-ng.time.system_time
    166.16           -20.0%     132.88        stress-ng.time.user_time
   3587756           -20.4%    2856397        stress-ng.time.voluntary_context_switches
  19377947           -12.9%   16869737        cpuidle..usage
  22169258 ±  6%     -38.4%   13650944        meminfo.DirectMap2M
      0.77 ±  5%      +0.0        0.82 ±  3%  mpstat.cpu.all.irq%
      2.88            -0.6        2.33        mpstat.cpu.all.usr%
    310.30 ±  4%     +16.1%     360.24 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    308.22 ±  4%     +15.1%     354.71 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
    567825           -22.8%     438177        vmstat.system.cs
    237994            -2.0%     233210        vmstat.system.in
     68.72            -1.8%      67.47        iostat.cpu.idle
     28.46            +6.2%      30.24        iostat.cpu.system
      2.82           -19.0%       2.28        iostat.cpu.user
  19720321 ±  3%     -33.4%   13134826 ±  3%  numa-numastat.node0.local_node
  19777686 ±  3%     -33.4%   13181681 ±  3%  numa-numastat.node0.numa_hit
  16776225 ±  4%     -14.3%   14379038 ±  2%  numa-numastat.node1.local_node
  16805121 ±  4%     -14.2%   14420003 ±  2%  numa-numastat.node1.numa_hit
  19777804 ±  3%     -33.4%   13181408 ±  3%  numa-vmstat.node0.numa_hit
  19720438 ±  3%     -33.4%   13134553 ±  3%  numa-vmstat.node0.numa_local
  16805357 ±  4%     -14.2%   14420086 ±  2%  numa-vmstat.node1.numa_hit
  16776463 ±  4%     -14.3%   14379121 ±  2%  numa-vmstat.node1.numa_local
    100111 ±  2%     -20.2%      79842 ±  7%  turbostat.C1
  18109273 ±  5%     -17.9%   14868577 ±  5%  turbostat.C1E
      0.25           -24.2%       0.19        turbostat.IPC
     23591           -17.9%      19362 ±  7%  turbostat.POLL
      0.02            -0.0        0.01        turbostat.POLL%
      9853 ±  4%      -9.4%       8922 ±  2%  proc-vmstat.nr_active_anon
     25609 ±  2%      -4.0%      24587        proc-vmstat.nr_kernel_stack
     42955            -7.1%      39903 ±  2%  proc-vmstat.nr_shmem
     47746            +6.3%      50766        proc-vmstat.nr_slab_reclaimable
      9853 ±  4%      -9.4%       8922 ±  2%  proc-vmstat.nr_zone_active_anon
  36584891           -24.5%   27603451        proc-vmstat.numa_hit
  36498661           -24.6%   27528869        proc-vmstat.numa_local
      0.17 ±223%  +3.6e+05%     604.17 ±213%  proc-vmstat.numa_pages_migrated
      1748 ±  4%     -11.1%       1554 ±  4%  proc-vmstat.pgactivate
  36528014           -24.5%   27580355        proc-vmstat.pgalloc_normal
  36290911           -24.6%   27369541        proc-vmstat.pgfree
      0.17 ±223%  +3.6e+05%     604.17 ±213%  proc-vmstat.pgmigrate_success
      7.98 ±  4%     +15.4%       9.21 ±  5%  perf-stat.i.MPKI
 1.429e+10           -21.2%  1.125e+10        perf-stat.i.branch-instructions
      0.92 ±  3%      +0.1        1.03 ±  4%  perf-stat.i.branch-miss-rate%
 1.241e+08           -12.8%  1.082e+08        perf-stat.i.branch-misses
     17.09 ±  2%      +8.2       25.31 ±  2%  perf-stat.i.cache-miss-rate%
 1.019e+08           +33.9%  1.364e+08        perf-stat.i.cache-misses
 6.012e+08           -11.2%  5.339e+08        perf-stat.i.cache-references
    591439           -22.7%     457142        perf-stat.i.context-switches
      1.36           +32.2%       1.79        perf-stat.i.cpi
 1.031e+11            +4.3%  1.075e+11        perf-stat.i.cpu-cycles
      9522 ±  3%     +37.4%      13088        perf-stat.i.cpu-migrations
      1026           -20.0%     821.06 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.03 ± 24%      +0.0        0.04 ± 14%  perf-stat.i.dTLB-load-miss-rate%
   4941417 ± 12%     +23.0%    6077138 ±  5%  perf-stat.i.dTLB-load-misses
 2.178e+10           -21.5%  1.711e+10        perf-stat.i.dTLB-loads
      0.01 ± 10%      +0.0        0.02 ±  8%  perf-stat.i.dTLB-store-miss-rate%
   1485395 ±  4%     -10.2%    1334061 ±  2%  perf-stat.i.dTLB-store-misses
 1.296e+10           -21.8%  1.013e+10        perf-stat.i.dTLB-stores
 7.687e+10           -21.4%  6.043e+10        perf-stat.i.instructions
      0.74           -24.3%       0.56        perf-stat.i.ipc
      1.07            +4.3%       1.12        perf-stat.i.metric.GHz
    837.30           +20.6%       1009        perf-stat.i.metric.K/sec
    516.87           -21.4%     406.42        perf-stat.i.metric.M/sec
     85.06            +5.6       90.71        perf-stat.i.node-load-miss-rate%
  13326340           +59.8%   21295732        perf-stat.i.node-load-misses
   2193567           -14.3%    1880215        perf-stat.i.node-loads
     20.29           +15.9       36.18        perf-stat.i.node-store-miss-rate%
  12130018          +113.1%   25843397        perf-stat.i.node-store-misses
  49891047            -8.5%   45663845        perf-stat.i.node-stores
      7.88           +12.9%       8.90        perf-stat.overall.MPKI
      0.87            +0.1        0.96        perf-stat.overall.branch-miss-rate%
     16.79            +8.3       25.08        perf-stat.overall.cache-miss-rate%
      1.34           +31.8%       1.77        perf-stat.overall.cpi
      1013           -21.9%     791.55        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 12%      +0.0        0.04 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  4%      +0.0        0.01 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.75           -24.1%       0.57        perf-stat.overall.ipc
     85.88            +5.9       91.76        perf-stat.overall.node-load-miss-rate%
     19.62           +16.3       35.88        perf-stat.overall.node-store-miss-rate%
 1.409e+10           -20.7%  1.117e+10        perf-stat.ps.branch-instructions
 1.224e+08           -12.4%  1.072e+08        perf-stat.ps.branch-misses
 1.004e+08           +33.4%  1.339e+08        perf-stat.ps.cache-misses
 5.977e+08           -10.7%   5.34e+08        perf-stat.ps.cache-references
    582510           -22.2%     453172        perf-stat.ps.context-switches
 1.017e+11            +4.3%   1.06e+11        perf-stat.ps.cpu-cycles
      9553 ±  3%     +35.5%      12949        perf-stat.ps.cpu-migrations
   4912066 ± 12%     +22.9%    6038093 ±  5%  perf-stat.ps.dTLB-load-misses
 2.148e+10           -20.9%  1.699e+10        perf-stat.ps.dTLB-loads
   1463340 ±  4%     -10.0%    1317415 ±  2%  perf-stat.ps.dTLB-store-misses
 1.278e+10           -21.3%  1.005e+10        perf-stat.ps.dTLB-stores
 7.581e+10           -20.9%  5.998e+10        perf-stat.ps.instructions
  13165441           +58.8%   20908585        perf-stat.ps.node-load-misses
   2164818           -13.2%    1878125        perf-stat.ps.node-loads
  11972044          +110.7%   25225320        perf-stat.ps.node-store-misses
  49038059            -8.1%   45075970        perf-stat.ps.node-stores
 4.814e+12           -21.3%  3.788e+12        perf-stat.total.instructions
      9.65            -2.4        7.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.66            -2.4        7.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      9.64            -2.4        7.24        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.63            -2.4        7.23        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.95            -2.4        7.56        perf-profile.calltrace.cycles-pp.__clone
      7.53 ±  2%      -2.3        5.26        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.80 ±  2%      -1.9        3.91        perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.54 ±  2%      -1.7        2.88        perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      4.16 ±  2%      -1.5        2.67        perf-profile.calltrace.cycles-pp.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      1.92            -1.3        0.62 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx
      3.06 ±  2%      -1.2        1.83 ±  2%  perf-profile.calltrace.cycles-pp.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      2.72 ±  2%      -1.0        1.68 ±  2%  perf-profile.calltrace.cycles-pp.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      3.71            -1.0        2.72        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx
      2.54 ±  3%      -0.9        1.68        perf-profile.calltrace.cycles-pp.ret_from_fork
      2.54 ±  3%      -0.9        1.68        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      2.48 ±  3%      -0.8        1.64        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      2.01 ±  4%      -0.8        1.24 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      1.96 ±  4%      -0.8        1.18 ±  2%  perf-profile.calltrace.cycles-pp.__vunmap.free_work.process_one_work.worker_thread.kthread
      1.98 ±  4%      -0.8        1.21        perf-profile.calltrace.cycles-pp.free_work.process_one_work.worker_thread.kthread.ret_from_fork
      2.51            -0.7        1.80        perf-profile.calltrace.cycles-pp.__entry_text_start.statx
      2.94            -0.7        2.27        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      2.46            -0.7        1.81        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64
      2.46            -0.7        1.80        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      1.42 ±  3%      -0.6        0.80        perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      1.34 ±  3%      -0.6        0.75        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      2.19            -0.6        1.60        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.do_statx
      1.25 ±  4%      -0.5        0.71 ±  3%  perf-profile.calltrace.cycles-pp.remove_vm_area.__vunmap.free_work.process_one_work.worker_thread
      1.47            -0.4        1.06        perf-profile.calltrace.cycles-pp.__fxstat
      1.40            -0.4        1.02        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newlstat
      1.40            -0.4        1.02        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat
      4.26            -0.4        3.90        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      3.93            -0.4        3.57        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.02            -0.3        3.68        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      5.57            -0.3        5.23        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      5.50            -0.3        5.16        perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
      5.49            -0.3        5.16        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      2.31            -0.3        1.98        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.28            -0.3        1.96        perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.58            -0.3        1.26 ±  2%  perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      1.49            -0.3        1.18 ±  2%  perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task
      2.49            -0.3        2.22        perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.50            -0.3        2.22        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.50            -0.3        2.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.49 ±  2%      -0.3        2.22        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.09 ±  2%      -0.3        0.83        perf-profile.calltrace.cycles-pp.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      0.97            -0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.user_path_at_empty.vfs_statx.do_statx
      0.82            -0.2        0.59 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      1.14 ±  3%      -0.2        0.93 ±  2%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74            -0.2        0.54 ±  4%  perf-profile.calltrace.cycles-pp.shim_statx
      0.74            -0.2        0.55        perf-profile.calltrace.cycles-pp.cp_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ±  2%      -0.2        0.67        perf-profile.calltrace.cycles-pp.vm_area_alloc_pages.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.80 ±  2%      -0.2        0.63        perf-profile.calltrace.cycles-pp.__alloc_pages_bulk.vm_area_alloc_pages.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      1.66            -0.2        1.49 ±  2%  perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      1.67            -0.2        1.51 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.84 ±  3%      -0.1        0.70 ±  2%  perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.do_syscall_64
      2.06            -0.1        1.94        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.67 ±  6%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.schedule.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.68 ±  6%      -0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
      0.66 ±  6%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.futex_wait_queue.futex_wait.do_futex
      0.78 ±  5%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__pthread_timedjoin_ex
      0.76 ±  5%      -0.1        0.70 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.__pthread_timedjoin_ex
      0.77 ±  5%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__pthread_timedjoin_ex
      0.67 ±  2%      -0.0        0.63 ±  2%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.61 ±  2%      -0.0        0.58 ±  2%  perf-profile.calltrace.cycles-pp.put_task_stack.finish_task_switch.__schedule.schedule_idle.do_idle
      0.66 ±  2%      +0.0        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe.start_thread
      0.66            +0.0        0.69 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe.start_thread
      0.68 ±  2%      +0.0        0.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.start_thread
      0.68 ±  2%      +0.0        0.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.start_thread
      0.54 ±  2%      +0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.80 ±  2%      +0.1        0.87        perf-profile.calltrace.cycles-pp.start_thread
      0.97 ±  2%      +0.1        1.08        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
     28.57            +0.2       28.77        perf-profile.calltrace.cycles-pp.statx
      1.48            +0.3        1.81        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      1.44            +0.3        1.78        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.do_statx.__x64_sys_statx
      1.44            +0.4        1.80        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46            +0.4        1.81        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.40            +0.4        1.76        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.__do_sys_newstat.do_syscall_64
      1.41            +0.4        1.78        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.__do_sys_newlstat.do_syscall_64
     13.42            +0.5       13.89        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
     11.48            +1.1       12.56        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.50            +1.1       13.63        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.25            +1.4       25.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.statx
     23.80            +1.5       25.30        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      5.17            +1.6        6.78        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.do_statx
      5.48            +1.6        7.09        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      5.45            +1.6        7.07        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.do_statx.__x64_sys_statx
      9.01            +1.6       10.64        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx
      8.75            +1.7       10.45        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.do_statx
      4.97            +1.7        6.67        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.__do_sys_newstat
      5.26            +1.7        6.99        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.24            +1.7        6.97        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.__do_sys_newstat.do_syscall_64
      5.05            +1.7        6.78        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.__do_sys_newlstat
      5.35            +1.7        7.10        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.33            +1.7        7.07        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.__do_sys_newlstat.do_syscall_64
      8.64            +1.8       10.48        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64
     22.48            +1.9       24.34        perf-profile.calltrace.cycles-pp.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      8.48            +1.9       10.35        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newlstat
      9.68            +1.9       11.56        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      9.48            +1.9       11.39        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat
     22.02            +2.0       24.02        perf-profile.calltrace.cycles-pp.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
     21.94            +2.2       24.16        perf-profile.calltrace.cycles-pp.__lxstat64
     22.89            +2.2       25.13        perf-profile.calltrace.cycles-pp.__xstat
     20.94            +2.3       23.22        perf-profile.calltrace.cycles-pp.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.40            +2.6       23.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lxstat64
     21.34            +2.7       24.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat
     20.22            +2.7       22.91        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     21.14            +2.7       23.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat
     19.54            +2.9       22.42        perf-profile.calltrace.cycles-pp.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     20.46            +2.9       23.38        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat
     18.78            +3.1       21.84        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     19.68            +3.1       22.79        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat
     20.81            +6.4       27.23        perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
     20.65            +6.5       27.12        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
     20.38            +6.5       26.92        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
     19.93            +6.6       26.52        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      9.64            -2.4        7.24        perf-profile.children.cycles-pp.kernel_clone
      9.05            -2.4        6.64        perf-profile.children.cycles-pp.getname_flags
      9.97            -2.4        7.57        perf-profile.children.cycles-pp.__clone
      9.64            -2.4        7.24        perf-profile.children.cycles-pp.__do_sys_clone
      7.54 ±  2%      -2.3        5.27        perf-profile.children.cycles-pp.copy_process
      5.80 ±  2%      -1.9        3.91        perf-profile.children.cycles-pp.dup_task_struct
      4.54 ±  2%      -1.7        2.88        perf-profile.children.cycles-pp.alloc_thread_stack_node
      3.68 ±  3%      -1.5        2.13        perf-profile.children.cycles-pp._raw_spin_lock
      3.24 ±  4%      -1.5        1.70 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.16 ±  2%      -1.5        2.67        perf-profile.children.cycles-pp.__vmalloc_node_range
      5.13            -1.4        3.74        perf-profile.children.cycles-pp.strncpy_from_user
      3.06 ±  2%      -1.2        1.83 ±  2%  perf-profile.children.cycles-pp.__get_vm_area_node
      2.72 ±  2%      -1.0        1.69 ±  2%  perf-profile.children.cycles-pp.alloc_vmap_area
      3.38            -1.0        2.42        perf-profile.children.cycles-pp.__entry_text_start
      2.54 ±  3%      -0.9        1.68        perf-profile.children.cycles-pp.kthread
      2.48 ±  3%      -0.8        1.64        perf-profile.children.cycles-pp.worker_thread
      2.70 ±  3%      -0.8        1.88        perf-profile.children.cycles-pp.ret_from_fork
      2.90            -0.8        2.10        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.01 ±  4%      -0.8        1.24 ±  2%  perf-profile.children.cycles-pp.process_one_work
      1.96 ±  4%      -0.8        1.19 ±  2%  perf-profile.children.cycles-pp.__vunmap
      1.98 ±  4%      -0.8        1.21 ±  2%  perf-profile.children.cycles-pp.free_work
      3.00            -0.7        2.32        perf-profile.children.cycles-pp.link_path_walk
      2.42            -0.6        1.80        perf-profile.children.cycles-pp.kmem_cache_alloc
      2.18            -0.6        1.59        perf-profile.children.cycles-pp.__check_object_size
      1.25 ±  4%      -0.5        0.71 ±  3%  perf-profile.children.cycles-pp.remove_vm_area
      1.84            -0.5        1.36        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.69            -0.5        1.21        perf-profile.children.cycles-pp.__fxstat
      0.81 ±  5%      -0.4        0.39 ±  3%  perf-profile.children.cycles-pp.find_vmap_area
      2.16            -0.4        1.76        perf-profile.children.cycles-pp.kmem_cache_free
      4.31            -0.4        3.95        perf-profile.children.cycles-pp.cpuidle_idle_call
      4.06            -0.3        3.72        perf-profile.children.cycles-pp.cpuidle_enter_state
      4.06            -0.3        3.72        perf-profile.children.cycles-pp.cpuidle_enter
      5.57            -0.3        5.23        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      5.57            -0.3        5.23        perf-profile.children.cycles-pp.cpu_startup_entry
      5.56            -0.3        5.22        perf-profile.children.cycles-pp.do_idle
      2.34            -0.3        2.01        perf-profile.children.cycles-pp.intel_idle
      2.32            -0.3        1.99        perf-profile.children.cycles-pp.mwait_idle_with_hints
      1.59            -0.3        1.27 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      1.53            -0.3        1.22 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.80 ±  3%      -0.3        0.49 ±  3%  perf-profile.children.cycles-pp.free_vmap_area_noflush
      1.27            -0.3        0.96        perf-profile.children.cycles-pp.cp_new_stat
      1.21            -0.3        0.91 ±  2%  perf-profile.children.cycles-pp._copy_to_user
      1.20            -0.3        0.91        perf-profile.children.cycles-pp.__might_resched
      2.90            -0.3        2.62        perf-profile.children.cycles-pp.walk_component
      1.10 ±  2%      -0.3        0.83        perf-profile.children.cycles-pp.__vmalloc_area_node
      3.16            -0.2        2.91        perf-profile.children.cycles-pp.__x64_sys_exit
      3.16            -0.2        2.91        perf-profile.children.cycles-pp.do_exit
      0.99            -0.2        0.75        perf-profile.children.cycles-pp.__might_fault
      0.91            -0.2        0.69 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.15 ±  3%      -0.2        0.93 ±  2%  perf-profile.children.cycles-pp.exit_notify
      0.77            -0.2        0.56 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.76            -0.2        0.56 ±  4%  perf-profile.children.cycles-pp.shim_statx
      3.20 ±  2%      -0.2        3.00        perf-profile.children.cycles-pp.__schedule
      0.35 ±  4%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.find_vm_area
      0.76            -0.2        0.56 ±  2%  perf-profile.children.cycles-pp.cp_statx
      0.90            -0.2        0.70 ±  2%  perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.86 ±  2%      -0.2        0.67        perf-profile.children.cycles-pp.vm_area_alloc_pages
      1.48 ±  3%      -0.2        1.30        perf-profile.children.cycles-pp.schedule
      0.72            -0.2        0.55 ±  3%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.81 ±  2%      -0.2        0.64        perf-profile.children.cycles-pp.__alloc_pages_bulk
      1.66            -0.2        1.50 ±  2%  perf-profile.children.cycles-pp.find_idlest_cpu
      1.68            -0.2        1.53 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.76 ±  2%      -0.2        0.61        perf-profile.children.cycles-pp.path_init
      0.56            -0.2        0.42 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.56 ±  2%      -0.1        0.41 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.84 ±  3%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.release_task
      0.50 ±  2%      -0.1        0.36        perf-profile.children.cycles-pp.__virt_addr_valid
      0.92 ±  2%      -0.1        0.78 ±  3%  perf-profile.children.cycles-pp.step_into
      0.64            -0.1        0.50        perf-profile.children.cycles-pp.__might_sleep
      0.58 ±  2%      -0.1        0.44        perf-profile.children.cycles-pp.clear_page_erms
      0.74 ±  2%      -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.inode_permission
      2.06            -0.1        1.94        perf-profile.children.cycles-pp.wake_up_new_task
      1.57            -0.1        1.45 ±  2%  perf-profile.children.cycles-pp.lookup_fast
      0.59 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.sched_yield
      0.41 ±  6%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.35            -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.40 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.84            -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.50            -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
      1.56 ±  3%      -0.1        1.47        perf-profile.children.cycles-pp.pick_next_task_fair
      0.51 ±  2%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.memcpy_erms
      0.49 ±  3%      -0.1        0.40        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.25 ±  3%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.insert_vmap_area
      0.33 ±  3%      -0.1        0.24        perf-profile.children.cycles-pp.pfn_valid
      0.30 ±  3%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.alloc_pid
      0.45 ±  2%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.generic_permission
      0.33 ±  3%      -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.stress_fstat_helper
      0.29            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.putname
      0.39 ±  3%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.59 ±  2%      -0.1        0.52        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.37            -0.1        0.30        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.28 ±  3%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.map_id_up
      0.68 ±  6%      -0.1        0.61 ±  2%  perf-profile.children.cycles-pp.futex_wait_queue
      1.20 ±  2%      -0.1        1.13        perf-profile.children.cycles-pp.rcu_core
      0.30 ±  4%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.21 ±  5%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.cgroup_can_fork
      1.16 ±  2%      -0.1        1.09        perf-profile.children.cycles-pp.rcu_do_batch
      0.56 ±  3%      -0.1        0.49        perf-profile.children.cycles-pp.page_counter_uncharge
      0.27 ±  2%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.34 ±  5%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.nd_jump_root
      0.25 ±  6%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.refcount_dec_not_one
      0.25 ±  6%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.cgroup_free
      0.76 ±  5%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.__x64_sys_futex
      0.18 ±  5%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.cgroup_release
      0.20 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.cgroup_post_fork
      1.06 ±  4%      -0.1        1.00 ±  2%  perf-profile.children.cycles-pp.do_futex
      0.43 ±  2%      -0.1        0.37        perf-profile.children.cycles-pp.__legitimize_mnt
      0.29            -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.cpumask_next
      0.30 ±  3%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.terminate_walk
      0.21 ±  3%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.22 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.23 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.generic_fillattr
      0.21 ±  3%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.18 ±  3%      -0.1        0.13 ±  4%  perf-profile.children.cycles-pp.security_inode_permission
      0.17 ±  2%      -0.1        0.12        perf-profile.children.cycles-pp.__x64_sys_newlstat
      0.23 ±  2%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.page_counter_charge
      0.20 ±  2%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.38 ±  3%      -0.0        0.33 ±  3%  perf-profile.children.cycles-pp.__put_task_struct
      0.13 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.insert_vmap_area_augment
      0.14 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.17 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__x64_sys_newstat
      0.17 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.from_kuid_munged
      0.28 ±  3%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.17 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.vfs_fstat
      0.17 ±  4%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.from_kgid_munged
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.45 ±  2%      -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.page_counter_cancel
      0.18 ±  7%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.mntput_no_expire
      0.12 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.cgroup_exit
      0.21 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.65 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.put_task_stack
      0.22 ±  4%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.16 ±  4%      -0.0        0.12        perf-profile.children.cycles-pp.add_device_randomness
      0.10 ±  3%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.cgroup_css_set_fork
      0.07 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.css_set_move_task
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rb_insert_color
      0.29 ±  2%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sched_post_fork
      0.35            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.14 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.do_sched_yield
      0.24 ±  3%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.__fget_light
      0.20 ±  3%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.18 ±  4%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.perf_event_task_output
      0.17 ±  7%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.menu_select
      0.09 ±  7%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.__purge_vmap_area_lazy
      0.11 ±  8%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.pids_can_fork
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__free_pages
      0.22 ±  7%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.set_root
      0.16 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.wake_up_q
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__queue_work
      0.13 ±  9%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.__lookup_mnt
      0.32            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.sched_move_task
      0.10 ±  4%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__x64_sys_newfstat
      0.10 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.task_rq_lock
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.vunmap_range_noflush
      0.21 ±  4%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp._mix_pool_bytes
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cpu_cgroup_fork
      0.14 ±  4%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.15 ±  5%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.queue_work_on
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.copy_thread
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.idr_alloc_u32
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.detach_entity_cfs_rq
      0.19 ±  5%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.zap_pmd_range
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_event_fork
      0.10 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__list_add_valid
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.task_fork_fair
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.idr_alloc_cyclic
      0.12 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.should_failslab
      0.12 ±  6%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.__fget_files
      0.24            -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.account_kernel_stack
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.refill_stock
      0.11 ±  6%      -0.0        0.09        perf-profile.children.cycles-pp.native_irq_return_iret
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.task_change_group_fair
      0.15 ±  5%      -0.0        0.13        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.pids_release
      0.09 ±  4%      +0.0        0.10        perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.14 ±  3%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.sigprocmask
      0.06 ±  6%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.llist_add_batch
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.update_load_avg
      0.06 ±  9%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.tid_fd_revalidate
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.18 ±  4%      +0.0        0.20        perf-profile.children.cycles-pp.scheduler_tick
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.try_get_compound_head
      0.23 ±  4%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.pick_link
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.kfree
      0.12 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.internal_get_user_pages_fast
      0.11 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.gup_pgd_range
      0.04 ± 44%      +0.0        0.07        perf-profile.children.cycles-pp.schedule_tail
      0.13 ±  4%      +0.0        0.16        perf-profile.children.cycles-pp.get_futex_key
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.gup_pte_range
      0.26 ±  5%      +0.0        0.29 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.12 ±  5%      +0.0        0.15        perf-profile.children.cycles-pp.lockless_pages_from_mm
      0.26 ±  6%      +0.0        0.30 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.15 ±  5%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.task_dump_owner
      0.13 ±  5%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.28 ±  5%      +0.0        0.32 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.02 ± 99%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.get_pid_task
      0.18 ±  4%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.19 ±  3%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__cleanup_sighand
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.01 ±223%      +0.1        0.07        perf-profile.children.cycles-pp.memset_erms
      0.81            +0.1        0.88        perf-profile.children.cycles-pp.start_thread
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.52 ±  3%      +0.1        0.64 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      4.41            +1.0        5.44        perf-profile.children.cycles-pp.security_inode_getattr
      4.27            +1.1        5.33        perf-profile.children.cycles-pp.common_perm_cond
     22.53            +1.8       24.38        perf-profile.children.cycles-pp.__x64_sys_statx
     22.07            +2.0       24.05        perf-profile.children.cycles-pp.do_statx
     22.36            +2.1       24.46        perf-profile.children.cycles-pp.__lxstat64
     23.33            +2.1       25.43        perf-profile.children.cycles-pp.__xstat
     37.56            +2.6       40.19        perf-profile.children.cycles-pp.user_path_at_empty
     19.57            +2.9       22.44        perf-profile.children.cycles-pp.__do_sys_newlstat
     20.49            +2.9       23.40        perf-profile.children.cycles-pp.__do_sys_newstat
     81.71            +3.7       85.40        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     80.95            +3.9       84.83        perf-profile.children.cycles-pp.do_syscall_64
     16.12            +5.1       21.20        perf-profile.children.cycles-pp.path_put
     15.35            +5.1       20.45        perf-profile.children.cycles-pp.lockref_put_or_lock
     16.34            +5.1       21.48        perf-profile.children.cycles-pp.dput
     27.38            +5.3       32.71        perf-profile.children.cycles-pp.filename_lookup
     26.84            +5.4       32.29        perf-profile.children.cycles-pp.path_lookupat
     20.84            +6.4       27.25        perf-profile.children.cycles-pp.complete_walk
     20.71            +6.4       27.16        perf-profile.children.cycles-pp.try_to_unlazy
     20.61            +6.5       27.16        perf-profile.children.cycles-pp.__legitimize_path
     20.13            +6.6       26.76        perf-profile.children.cycles-pp.lockref_get_not_dead
     59.52            +8.4       67.94        perf-profile.children.cycles-pp.vfs_statx
      3.21 ±  4%      -1.5        1.69 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.86            -0.8        2.07        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.28            -0.6        1.66        perf-profile.self.cycles-pp.strncpy_from_user
      1.98            -0.6        1.42        perf-profile.self.cycles-pp.statx
      1.25            -0.3        0.90        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.30            -0.3        0.96        perf-profile.self.cycles-pp.kmem_cache_alloc
      1.22            -0.3        0.88        perf-profile.self.cycles-pp.__entry_text_start
      2.30            -0.3        1.98        perf-profile.self.cycles-pp.mwait_idle_with_hints
      1.10            -0.3        0.83 ±  2%  perf-profile.self.cycles-pp.__might_resched
      1.02 ±  2%      -0.3        0.76        perf-profile.self.cycles-pp.kmem_cache_free
      1.27            -0.3        1.02 ±  2%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.85 ±  2%      -0.2        0.60 ±  6%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.87            -0.2        0.64        perf-profile.self.cycles-pp.link_path_walk
      0.88            -0.2        0.66 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.85            -0.2        0.63        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.82 ±  2%      -0.2        0.62 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.78            -0.2        0.58        perf-profile.self.cycles-pp.getname_flags
      0.66            -0.2        0.46        perf-profile.self.cycles-pp.__xstat
      0.72            -0.2        0.52 ±  4%  perf-profile.self.cycles-pp.shim_statx
      0.70            -0.2        0.51 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.70            -0.2        0.52 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.64            -0.2        0.46 ±  2%  perf-profile.self.cycles-pp.__lxstat64
      0.94            -0.2        0.78 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.57 ±  2%      -0.1        0.44        perf-profile.self.cycles-pp.vfs_statx
      0.58 ±  2%      -0.1        0.44        perf-profile.self.cycles-pp.clear_page_erms
      0.53 ±  2%      -0.1        0.40 ±  3%  perf-profile.self.cycles-pp.step_into
      0.48            -0.1        0.35        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.48            -0.1        0.36 ±  2%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.43            -0.1        0.31        perf-profile.self.cycles-pp.__x64_sys_statx
      0.53 ±  2%      -0.1        0.41        perf-profile.self.cycles-pp.__might_sleep
      0.52 ±  2%      -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.filename_lookup
      0.46            -0.1        0.35 ±  3%  perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.35 ±  2%      -0.1        0.25 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.35            -0.1        0.25        perf-profile.self.cycles-pp.__fxstat
      0.40 ±  2%      -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.lookup_fast
      0.33 ±  3%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.do_statx
      0.36            -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.path_lookupat
      0.50 ±  3%      -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.memcpy_erms
      0.31 ±  2%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.path_init
      0.80 ±  2%      -0.1        0.71 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.34 ±  2%      -0.1        0.26        perf-profile.self.cycles-pp.walk_component
      0.30            -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.user_path_at_empty
      0.41 ±  2%      -0.1        0.34 ±  3%  perf-profile.self.cycles-pp.generic_permission
      0.26 ±  4%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.pfn_valid
      0.23 ±  2%      -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.find_vmap_area
      0.26 ±  3%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.map_id_up
      0.27 ±  4%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.inode_permission
      0.25            -0.1        0.18 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.18 ±  4%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.insert_vmap_area
      0.24 ±  2%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.cp_statx
      0.25 ±  6%      -0.1        0.19 ±  5%  perf-profile.self.cycles-pp.refcount_dec_not_one
      0.20 ±  3%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.__vmalloc_area_node
      0.27 ±  3%      -0.1        0.21 ± 12%  perf-profile.self.cycles-pp.stress_fstat_helper
      0.23 ±  3%      -0.1        0.17 ±  3%  perf-profile.self.cycles-pp.putname
      0.20 ±  3%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.24 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.free_vmap_area_noflush
      0.25 ±  4%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.26            -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.cp_new_stat
      0.39 ±  3%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.21 ±  3%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.19 ±  3%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.21 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.generic_fillattr
      0.16 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.security_inode_permission
      0.14 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.15 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__x64_sys_newlstat
      0.16 ±  4%      -0.0        0.12        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.15 ±  5%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__x64_sys_newstat
      0.15 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.terminate_walk
      0.11 ±  3%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__alloc_pages_bulk
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__might_fault
      0.30 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.20 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.page_counter_charge
      0.14 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.try_to_unlazy
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__do_sys_newlstat
      0.12 ±  6%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.complete_walk
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__free_pages
      0.16 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.mntput_no_expire
      0.12 ±  5%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.rb_insert_color
      0.12 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.nd_jump_root
      0.13 ±  6%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__do_sys_newstat
      0.44 ±  2%      -0.0        0.41 ±  2%  perf-profile.self.cycles-pp.page_counter_cancel
      0.18 ±  4%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.dput
      0.26            -0.0        0.22 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.12            -0.0        0.09 ±  6%  perf-profile.self.cycles-pp._copy_to_user
      0.21 ±  5%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.set_root
      0.11 ±  8%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.pids_can_fork
      0.10 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.check_stack_object
      0.14 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.dup_task_struct
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__legitimize_path
      0.10 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.vunmap_range_noflush
      0.26 ±  3%      -0.0        0.24        perf-profile.self.cycles-pp.__schedule
      0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp._mix_pool_bytes
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__x64_sys_newfstat
      0.11 ±  6%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.zap_pte_range
      0.09 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.legitimize_links
      0.10            -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.update_curr
      0.11 ±  6%      -0.0        0.09        perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.security_inode_getattr
      0.09 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.cpumask_next
      0.10            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.pids_release
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__pthread_timedjoin_ex
      0.07 ±  5%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.cpuidle_idle_call
      0.05 ±  8%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.llist_add_batch
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.try_get_compound_head
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.start_thread
      0.14 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.02 ± 99%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.get_pid_task
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__cleanup_sighand
      0.01 ±223%      +0.1        0.07        perf-profile.self.cycles-pp.memset_erms
      0.05 ±  8%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.find_idlest_cpu
      0.52 ±  3%      +0.1        0.64 ±  3%  perf-profile.self.cycles-pp.lockref_put_return
      4.22            +1.1        5.28        perf-profile.self.cycles-pp.common_perm_cond
     15.20            +5.1       20.28        perf-profile.self.cycles-pp.lockref_put_or_lock
     19.93            +6.6       26.52        perf-profile.self.cycles-pp.lockref_get_not_dead



***************************************************************************************************
lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-11/performance/1BRD_48G/4M/ext4/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap4/24G/fsmark/0x500320a

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    124108 ±  2%     -13.8%     106934 ±  7%  fsmark.app_overhead
      1561 ±  4%     -16.3%       1306 ±  4%  fsmark.files_per_sec
      2767 ±  2%      +6.4%       2945 ±  2%  fsmark.time.percent_of_cpu_this_job_got
    199.63 ±  3%     +15.9%     231.38 ±  3%  fsmark.time.system_time
      0.20 ± 16%      +0.1        0.30 ±  9%  mpstat.cpu.all.iowait%
     13988 ±  2%      -7.4%      12948 ±  4%  vmstat.system.cs
     87.82            -1.5%      86.54        iostat.cpu.idle
     11.40 ±  3%     +10.6%      12.61 ±  3%  iostat.cpu.system
   3466502 ±  6%     +12.8%    3911067 ±  2%  turbostat.IRQ
    156.89 ±  3%      -6.9%     146.06        turbostat.PkgWatt
    135.26 ±  6%     +32.0%     178.54 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    282.67 ±  6%     -15.4%     239.26        sched_debug.cfs_rq:/.runnable_avg.stddev
    134.95 ±  6%     +32.0%     178.09 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    282.30 ±  6%     -15.4%     238.93        sched_debug.cfs_rq:/.util_avg.stddev
    269695 ±  6%     -13.5%     233318 ±  7%  sched_debug.cpu.avg_idle.stddev
   2891810 ±  3%      +4.7%    3027838 ±  2%  proc-vmstat.nr_file_pages
   2300394 ±  3%      +5.9%    2436615 ±  2%  proc-vmstat.nr_inactive_file
     31775            +2.4%      32536        proc-vmstat.nr_kernel_stack
    110156            +3.8%     114369        proc-vmstat.nr_slab_reclaimable
     81885            +7.2%      87818        proc-vmstat.nr_slab_unreclaimable
   2300394 ±  3%      +5.9%    2436615 ±  2%  proc-vmstat.nr_zone_inactive_file
   7873747 ±  5%     -58.4%    3279053 ±  5%  numa-numastat.node0.local_node
   7872482 ±  4%     -57.5%    3343690 ±  6%  numa-numastat.node0.numa_hit
     19031 ±102%    +274.8%      71322 ± 12%  numa-numastat.node0.other_node
   1977839 ± 14%     +68.6%    3335315 ±  7%  numa-numastat.node1.local_node
   2055359 ± 13%     +65.4%    3399152 ±  7%  numa-numastat.node1.numa_hit
   1683926 ± 15%     +93.5%    3259192 ±  7%  numa-numastat.node2.local_node
   1760441 ± 15%     +87.6%    3303316 ±  7%  numa-numastat.node2.numa_hit
   1650883 ± 12%    +103.7%    3363648 ±  2%  numa-numastat.node3.local_node
   1737678 ± 11%     +96.7%    3418864 ±  2%  numa-numastat.node3.numa_hit
 1.274e+08 ±  4%     +22.2%  1.557e+08 ± 12%  perf-stat.i.cache-misses
      3.62 ±  2%     +13.0%       4.09 ±  5%  perf-stat.i.cpi
    329.11 ±  3%      -8.5%     301.10 ±  2%  perf-stat.i.cpu-migrations
   6033964 ±  4%     +19.0%    7178931 ±  6%  perf-stat.i.iTLB-load-misses
      4140 ±  7%     -15.5%       3497 ±  6%  perf-stat.i.instructions-per-iTLB-miss
     29.80 ±  9%      +9.8       39.64 ±  9%  perf-stat.i.node-load-miss-rate%
   8788835 ±  3%     +55.7%   13680401 ± 25%  perf-stat.i.node-load-misses
     40.53 ± 10%      +8.7       49.21 ± 11%  perf-stat.i.node-store-miss-rate%
   5858142 ± 14%     +36.7%    8008011 ± 16%  perf-stat.i.node-store-misses
      4.24 ±  2%     +11.3%       4.72 ±  4%  perf-stat.overall.cpi
      3730 ±  3%     -15.8%       3139 ±  7%  perf-stat.overall.instructions-per-iTLB-miss
      0.24 ±  2%     -10.1%       0.21 ±  4%  perf-stat.overall.ipc
     23.18 ±  5%      +7.2       30.36 ± 16%  perf-stat.overall.node-load-miss-rate%
 1.151e+08 ±  3%     +22.0%  1.403e+08 ± 12%  perf-stat.ps.cache-misses
 8.487e+10 ±  4%     +11.6%  9.469e+10 ±  3%  perf-stat.ps.cpu-cycles
    287.47 ±  2%      -8.8%     262.11        perf-stat.ps.cpu-migrations
   5375619 ±  4%     +19.4%    6420673 ±  6%  perf-stat.ps.iTLB-load-misses
   7927841 ±  3%     +55.4%   12317393 ± 25%  perf-stat.ps.node-load-misses
      3871 ± 30%     -52.0%       1856 ± 44%  numa-meminfo.node0.Active
      1596 ± 16%     -52.2%     763.33 ± 26%  numa-meminfo.node0.Active(anon)
     19800 ± 15%     -65.8%       6767 ± 19%  numa-meminfo.node0.Dirty
   6729746 ± 17%     -31.9%    4581408 ±  4%  numa-meminfo.node0.FilePages
   5621436 ±  8%     -53.6%    2608180 ±  3%  numa-meminfo.node0.Inactive
   5405663 ±  7%     -54.8%    2443705 ±  5%  numa-meminfo.node0.Inactive(file)
    255360 ± 11%     -36.6%     161831 ±  4%  numa-meminfo.node0.KReclaimable
     10545 ±  5%     -11.8%       9302 ±  5%  numa-meminfo.node0.KernelStack
  31945516 ±  4%     +23.4%   39434773        numa-meminfo.node0.MemFree
  17210998 ±  8%     -43.5%    9721741 ±  3%  numa-meminfo.node0.MemUsed
      5381 ± 13%     -63.5%       1966 ± 20%  numa-meminfo.node0.PageTables
    255360 ± 11%     -36.6%     161831 ±  4%  numa-meminfo.node0.SReclaimable
    138151 ±  6%     -18.9%     112057 ±  3%  numa-meminfo.node0.SUnreclaim
    393512 ±  8%     -30.4%     273889 ±  4%  numa-meminfo.node0.Slab
      7272 ± 45%     -75.5%       1778 ±105%  numa-meminfo.node0.Writeback
      3875 ± 45%    +120.3%       8536 ± 27%  numa-meminfo.node1.Dirty
   1483770 ± 12%     +67.7%    2488545 ±  4%  numa-meminfo.node1.Inactive
   1411062 ± 13%     +72.5%    2433514 ±  6%  numa-meminfo.node1.Inactive(file)
     68073 ± 15%     +50.6%     102530 ±  7%  numa-meminfo.node1.KReclaimable
   4945846 ± 12%     +45.9%    7214903 ±  6%  numa-meminfo.node1.MemUsed
     68073 ± 15%     +50.6%     102530 ±  7%  numa-meminfo.node1.SReclaimable
     64408 ± 10%     +25.8%      81052 ±  5%  numa-meminfo.node1.SUnreclaim
    132481 ±  7%     +38.6%     183583 ±  6%  numa-meminfo.node1.Slab
      3891 ± 50%    +128.8%       8902 ± 25%  numa-meminfo.node2.Dirty
   1208578 ± 12%    +109.5%    2531720 ± 11%  numa-meminfo.node2.FilePages
   1235487 ± 11%    +100.3%    2474364 ±  5%  numa-meminfo.node2.Inactive
   1207177 ± 12%     +98.7%    2398227 ±  8%  numa-meminfo.node2.Inactive(file)
     49965 ± 11%     +97.1%      98463 ±  8%  numa-meminfo.node2.KReclaimable
      6777 ±  3%     +10.7%       7503 ±  4%  numa-meminfo.node2.KernelStack
   3942891 ± 13%     +81.2%    7145601 ±  5%  numa-meminfo.node2.MemUsed
     49965 ± 11%     +97.1%      98463 ±  8%  numa-meminfo.node2.SReclaimable
     57878 ±  2%     +36.3%      78874 ±  7%  numa-meminfo.node2.SUnreclaim
    107844 ±  6%     +64.4%     177338 ±  7%  numa-meminfo.node2.Slab
     21.83 ±131%    +6e+05%     131703 ± 92%  numa-meminfo.node2.Unevictable
      2563 ± 64%    +842.9%      24174 ± 88%  numa-meminfo.node3.AnonPages
      4060 ± 60%    +633.6%      29790 ± 86%  numa-meminfo.node3.AnonPages.max
      3439 ± 28%    +247.2%      11941 ± 17%  numa-meminfo.node3.Dirty
   1187567 ± 10%    +110.9%    2504148 ±  4%  numa-meminfo.node3.Inactive
   1177518 ± 10%    +110.1%    2473678 ±  3%  numa-meminfo.node3.Inactive(file)
      7142 ±  6%     +11.3%       7948 ±  6%  numa-meminfo.node3.KernelStack
   4533549 ± 23%     +55.5%    7049648 ±  2%  numa-meminfo.node3.MemUsed
    241.17 ±110%    +660.1%       1833 ± 49%  numa-meminfo.node3.PageTables
    398.83 ± 16%     -52.3%     190.33 ± 26%  numa-vmstat.node0.nr_active_anon
   3742174 ±  5%     -57.7%    1581110 ±  6%  numa-vmstat.node0.nr_dirtied
      5638 ±  6%     -55.4%       2515 ± 17%  numa-vmstat.node0.nr_dirty
   1675683 ± 17%     -31.8%    1142601 ±  4%  numa-vmstat.node0.nr_file_pages
   7987823 ±  4%     +23.4%    9859439        numa-vmstat.node0.nr_free_pages
   1344664 ±  7%     -54.8%     608172 ±  5%  numa-vmstat.node0.nr_inactive_file
     10557 ±  5%     -11.8%       9312 ±  5%  numa-vmstat.node0.nr_kernel_stack
      1343 ± 14%     -63.4%     492.00 ± 19%  numa-vmstat.node0.nr_page_table_pages
     63683 ± 11%     -36.5%      40411 ±  4%  numa-vmstat.node0.nr_slab_reclaimable
     34563 ±  6%     -18.9%      28025 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
      1978 ± 38%     -80.2%     391.83 ± 64%  numa-vmstat.node0.nr_writeback
   3742175 ±  5%     -57.7%    1581110 ±  6%  numa-vmstat.node0.nr_written
    398.83 ± 16%     -52.3%     190.33 ± 26%  numa-vmstat.node0.nr_zone_active_anon
   1344663 ±  7%     -54.8%     608113 ±  5%  numa-vmstat.node0.nr_zone_inactive_file
      7457 ±  8%     -62.7%       2779 ± 19%  numa-vmstat.node0.nr_zone_write_pending
   7871907 ±  4%     -57.5%    3343740 ±  6%  numa-vmstat.node0.numa_hit
   7873172 ±  5%     -58.4%    3279103 ±  5%  numa-vmstat.node0.numa_local
     19031 ±102%    +274.8%      71322 ± 12%  numa-vmstat.node0.numa_other
     24.00 ±126%    +281.2%      91.50 ± 39%  numa-vmstat.node1.nr_active_anon
    947741 ± 11%     +65.7%    1570584 ±  6%  numa-vmstat.node1.nr_dirtied
      1253 ± 38%    +103.6%       2551 ±  7%  numa-vmstat.node1.nr_dirty
    351145 ± 12%     +72.3%     604947 ±  6%  numa-vmstat.node1.nr_inactive_file
     16987 ± 15%     +50.5%      25572 ±  7%  numa-vmstat.node1.nr_slab_reclaimable
     16102 ± 10%     +25.9%      20271 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
    947741 ± 11%     +65.7%    1570584 ±  6%  numa-vmstat.node1.nr_written
     24.00 ±126%    +281.2%      91.50 ± 39%  numa-vmstat.node1.nr_zone_active_anon
    351137 ± 12%     +72.3%     604932 ±  6%  numa-vmstat.node1.nr_zone_inactive_file
      1600 ± 40%     +92.8%       3086 ± 16%  numa-vmstat.node1.nr_zone_write_pending
   2055417 ± 13%     +65.3%    3398599 ±  7%  numa-vmstat.node1.numa_hit
   1977897 ± 14%     +68.6%    3334762 ±  7%  numa-vmstat.node1.numa_local
    807229 ± 14%     +90.1%    1534388 ±  7%  numa-vmstat.node2.nr_dirtied
    540.50 ± 49%    +390.9%       2653 ± 19%  numa-vmstat.node2.nr_dirty
    300781 ± 12%    +109.5%     630205 ± 11%  numa-vmstat.node2.nr_file_pages
    300427 ± 12%     +98.7%     596826 ±  8%  numa-vmstat.node2.nr_inactive_file
      6777 ±  3%     +10.9%       7518 ±  4%  numa-vmstat.node2.nr_kernel_stack
     12483 ± 11%     +96.5%      24533 ±  8%  numa-vmstat.node2.nr_slab_reclaimable
     14483 ±  2%     +36.3%      19734 ±  7%  numa-vmstat.node2.nr_slab_unreclaimable
      5.00 ±145%  +6.6e+05%      32925 ± 92%  numa-vmstat.node2.nr_unevictable
    807229 ± 14%     +90.1%    1534388 ±  7%  numa-vmstat.node2.nr_written
    300418 ± 12%     +98.7%     596816 ±  8%  numa-vmstat.node2.nr_zone_inactive_file
      5.00 ±145%  +6.6e+05%      32925 ± 92%  numa-vmstat.node2.nr_zone_unevictable
    794.17 ± 38%    +323.9%       3366 ± 15%  numa-vmstat.node2.nr_zone_write_pending
   1760442 ± 15%     +87.6%    3302675 ±  7%  numa-vmstat.node2.numa_hit
   1683927 ± 15%     +93.5%    3258551 ±  7%  numa-vmstat.node2.numa_local
    641.67 ± 64%    +845.2%       6064 ± 88%  numa-vmstat.node3.nr_anon_pages
    795203 ± 12%    +102.0%    1606267        numa-vmstat.node3.nr_dirtied
    796.50 ± 48%    +205.3%       2431 ± 26%  numa-vmstat.node3.nr_dirty
    292940 ± 10%    +110.0%     615274 ±  3%  numa-vmstat.node3.nr_inactive_file
      7142 ±  6%     +11.3%       7950 ±  6%  numa-vmstat.node3.nr_kernel_stack
     59.83 ±111%    +658.5%     453.83 ± 50%  numa-vmstat.node3.nr_page_table_pages
    795203 ± 12%    +102.0%    1606267        numa-vmstat.node3.nr_written
    292935 ± 10%    +110.0%     615267 ±  3%  numa-vmstat.node3.nr_zone_inactive_file
      1242 ± 39%    +167.8%       3327 ± 25%  numa-vmstat.node3.nr_zone_write_pending
   1737678 ± 11%     +96.7%    3418251 ±  2%  numa-vmstat.node3.numa_hit
   1650883 ± 12%    +103.7%    3363015 ±  2%  numa-vmstat.node3.numa_local
      1.88 ± 30%      -0.7        1.16 ±  3%  perf-profile.calltrace.cycles-pp.copy_to_brd.brd_do_bvec.brd_submit_bio.__submit_bio.__submit_bio_noacct
      1.85 ± 19%      -0.7        1.19 ±  5%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.umount2
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.umount2
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.umount2
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.cleanup_mnt.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.deactivate_locked_super.cleanup_mnt.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.kill_block_super.deactivate_locked_super.cleanup_mnt.task_work_run.exit_to_user_mode_loop
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.calltrace.cycles-pp.generic_shutdown_super.kill_block_super.deactivate_locked_super.cleanup_mnt.task_work_run
      2.04 ± 28%      -0.6        1.39 ± 13%  perf-profile.calltrace.cycles-pp.evict.dispose_list.evict_inodes.generic_shutdown_super.kill_block_super
      2.04 ± 28%      -0.6        1.39 ± 13%  perf-profile.calltrace.cycles-pp.evict_inodes.generic_shutdown_super.kill_block_super.deactivate_locked_super.cleanup_mnt
      2.04 ± 28%      -0.6        1.39 ± 13%  perf-profile.calltrace.cycles-pp.dispose_list.evict_inodes.generic_shutdown_super.kill_block_super.deactivate_locked_super
      2.03 ± 28%      -0.6        1.39 ± 13%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.dispose_list.evict_inodes.generic_shutdown_super
      2.03 ± 28%      -0.6        1.39 ± 13%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.dispose_list.evict_inodes
      1.78 ± 16%      -0.6        1.16 ±  4%  perf-profile.calltrace.cycles-pp.pagecache_get_page.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.79 ± 19%      -0.6        1.17 ±  5%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.78 ± 19%      -0.6        1.16 ±  5%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter
      1.78 ± 16%      -0.6        1.15 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.24 ± 14%      -0.4        0.82 ±  6%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.pagecache_get_page.ext4_da_write_begin.generic_perform_write
      1.32 ± 15%      -0.4        0.95 ±  8%  perf-profile.calltrace.cycles-pp.__block_commit_write.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.74 ± 15%      -0.3        0.39 ± 72%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.88 ± 13%      -0.3        0.61 ±  5%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page.ext4_da_write_begin
      1.00 ± 10%      -0.2        0.78 ±  5%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_extent.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      0.91 ± 10%      -0.2        0.69 ±  5%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      0.92 ± 13%      -0.2        0.72 ±  6%  perf-profile.calltrace.cycles-pp.ext4_put_io_end.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      0.78 ±  9%      -0.2        0.61 ±  5%  perf-profile.calltrace.cycles-pp.mpage_submit_page.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_writepages.do_writepages
      0.79 ± 10%      -0.2        0.63 ±  5%  perf-profile.calltrace.cycles-pp.ext4_release_io_end.ext4_put_io_end.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      0.78 ± 10%      -0.2        0.63 ±  6%  perf-profile.calltrace.cycles-pp.ext4_finish_bio.ext4_release_io_end.ext4_put_io_end.ext4_writepages.do_writepages
      0.80 ± 12%      +0.1        0.94 ±  9%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.83 ± 12%      +0.1        0.97 ±  9%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_update_time
      0.98 ± 12%      +0.2        1.16 ± 10%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.file_update_time.ext4_buffered_write_iter.new_sync_write
      0.98 ± 12%      +0.2        1.16 ± 10%  perf-profile.calltrace.cycles-pp.generic_update_time.file_update_time.ext4_buffered_write_iter.new_sync_write.vfs_write
      1.16 ±  8%      +0.3        1.42 ±  4%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      1.24 ±  7%      +0.3        1.53 ±  5%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.65 ±  8%      +0.3        1.95 ± 11%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.02 ±  9%      +0.3        1.36 ±  7%  perf-profile.calltrace.cycles-pp.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      1.08 ±  8%      +0.4        1.43 ±  6%  perf-profile.calltrace.cycles-pp.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.18 ±  9%      +0.4        1.56 ±  7%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      3.66 ± 18%      -1.1        2.53 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.08 ± 13%      -0.8        2.26 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.92 ± 29%      -0.7        1.17 ±  4%  perf-profile.children.cycles-pp.copy_to_brd
      2.06 ± 28%      -0.7        1.41 ± 13%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.85 ± 19%      -0.7        1.19 ±  5%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.children.cycles-pp.umount2
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.children.cycles-pp.cleanup_mnt
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.children.cycles-pp.deactivate_locked_super
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.children.cycles-pp.kill_block_super
      2.05 ± 28%      -0.7        1.40 ± 13%  perf-profile.children.cycles-pp.generic_shutdown_super
      1.29 ± 26%      -0.6        0.64 ±  5%  perf-profile.children.cycles-pp.__alloc_pages
      2.04 ± 28%      -0.6        1.39 ± 13%  perf-profile.children.cycles-pp.evict_inodes
      2.04 ± 28%      -0.6        1.39 ± 13%  perf-profile.children.cycles-pp.dispose_list
      2.04 ± 28%      -0.6        1.39 ± 13%  perf-profile.children.cycles-pp.evict
      2.03 ± 28%      -0.6        1.39 ± 13%  perf-profile.children.cycles-pp.ext4_evict_inode
      2.03 ± 28%      -0.6        1.39 ± 13%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      1.80 ± 15%      -0.6        1.16 ±  4%  perf-profile.children.cycles-pp.pagecache_get_page
      1.79 ± 15%      -0.6        1.16 ±  4%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.80 ± 18%      -0.6        1.17 ±  5%  perf-profile.children.cycles-pp.copyin
      1.79 ± 19%      -0.6        1.16 ±  5%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.15 ± 28%      -0.6        0.54 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
      2.03 ± 11%      -0.5        1.54 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.00 ± 12%      -0.5        1.52 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.24 ± 14%      -0.4        0.82 ±  6%  perf-profile.children.cycles-pp.filemap_add_folio
      1.32 ± 15%      -0.4        0.95 ±  8%  perf-profile.children.cycles-pp.__block_commit_write
      0.59 ± 31%      -0.4        0.24 ±  9%  perf-profile.children.cycles-pp.clear_page_erms
      0.72 ± 17%      -0.3        0.41 ±  6%  perf-profile.children.cycles-pp.create_empty_buffers
      0.79 ± 21%      -0.3        0.50 ± 12%  perf-profile.children.cycles-pp.ktime_get
      0.88 ± 14%      -0.3        0.62 ±  6%  perf-profile.children.cycles-pp.__filemap_add_folio
      1.00 ± 10%      -0.2        0.78 ±  5%  perf-profile.children.cycles-pp.mpage_map_and_submit_extent
      0.62 ± 16%      -0.2        0.40 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.91 ± 10%      -0.2        0.69 ±  5%  perf-profile.children.cycles-pp.mpage_map_and_submit_buffers
      0.56 ± 17%      -0.2        0.34 ±  6%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.92 ± 13%      -0.2        0.72 ±  6%  perf-profile.children.cycles-pp.ext4_put_io_end
      0.53 ± 17%      -0.2        0.33 ±  5%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.54 ± 11%      -0.2        0.35 ±  9%  perf-profile.children.cycles-pp.brd_lookup_page
      0.74 ± 15%      -0.2        0.55 ± 14%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.59 ± 16%      -0.2        0.40 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.44 ± 20%      -0.2        0.26 ±  3%  perf-profile.children.cycles-pp.folio_alloc
      0.74 ± 11%      -0.2        0.55 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.53 ± 11%      -0.2        0.35 ±  9%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.38 ± 28%      -0.2        0.20 ±  6%  perf-profile.children.cycles-pp.rmqueue
      0.78 ±  9%      -0.2        0.61 ±  5%  perf-profile.children.cycles-pp.mpage_submit_page
      0.79 ± 10%      -0.2        0.63 ±  5%  perf-profile.children.cycles-pp.ext4_release_io_end
      0.35 ± 16%      -0.2        0.20 ± 10%  perf-profile.children.cycles-pp.folio_add_lru
      0.78 ± 10%      -0.2        0.63 ±  6%  perf-profile.children.cycles-pp.ext4_finish_bio
      0.36 ± 22%      -0.2        0.21 ±  3%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      0.50 ± 11%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.ext4_bio_write_page
      0.31 ± 17%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.30 ± 28%      -0.1        0.20 ± 14%  perf-profile.children.cycles-pp.free_unref_page_list
      0.22 ± 30%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.29 ± 13%      -0.1        0.20 ± 17%  perf-profile.children.cycles-pp.__getblk_gfp
      0.27 ± 15%      -0.1        0.17 ± 18%  perf-profile.children.cycles-pp.__find_get_block
      0.22 ± 20%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.xas_store
      0.23 ± 20%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.33 ± 10%      -0.1        0.25 ±  7%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.24 ± 26%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.block_invalidatepage
      0.15 ± 10%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.18 ± 16%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.xas_load
      0.21 ± 27%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.21 ± 15%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.20 ± 16%      -0.1        0.13 ± 12%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.12 ± 34%      -0.1        0.05        perf-profile.children.cycles-pp.mpage_process_page_bufs
      0.12 ± 14%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.13 ± 18%      -0.1        0.08 ± 18%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.12 ± 22%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.___slab_alloc
      0.38 ±  7%      -0.0        0.33 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.15 ± 28%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.__free_one_page
      0.16 ± 14%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.09 ± 20%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.node_dirty_ok
      0.18 ± 18%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.12 ± 13%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.17 ±  9%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.10 ± 31%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.10 ± 24%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.allocate_slab
      0.15 ± 12%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.radix_tree_insert
      0.09 ± 19%      -0.0        0.06 ± 48%  perf-profile.children.cycles-pp.__slab_free
      0.09 ± 18%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.folio_unlock
      0.08 ± 34%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.10 ± 18%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.08 ± 16%      -0.0        0.05        perf-profile.children.cycles-pp.__might_sleep
      0.07 ± 11%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.update_rq_clock
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.98 ± 12%      +0.2        1.16 ± 10%  perf-profile.children.cycles-pp.generic_update_time
      1.26 ±  7%      +0.3        1.52 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      1.34 ±  7%      +0.3        1.64 ±  5%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      1.73 ±  8%      +0.3        2.04 ± 11%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      1.10 ±  9%      +0.4        1.46 ±  6%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      1.12 ±  8%      +0.4        1.48 ±  7%  perf-profile.children.cycles-pp.ext4_journal_check_start
      1.27 ±  9%      +0.4        1.68 ±  7%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      1.72 ± 30%      -0.6        1.10 ±  3%  perf-profile.self.cycles-pp.copy_to_brd
      1.78 ± 19%      -0.6        1.16 ±  5%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      2.14 ± 11%      -0.4        1.71 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.59 ± 31%      -0.3        0.24 ± 10%  perf-profile.self.cycles-pp.clear_page_erms
      0.71 ± 24%      -0.3        0.45 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.60 ± 21%      -0.2        0.39 ±  7%  perf-profile.self.cycles-pp.fnmatch
      0.53 ± 10%      -0.2        0.34 ±  7%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.53 ± 16%      -0.2        0.38 ±  4%  perf-profile.self.cycles-pp.__block_commit_write
      0.42 ± 13%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26 ± 16%      -0.1        0.16 ± 19%  perf-profile.self.cycles-pp.__find_get_block
      0.22 ± 15%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.14 ± 10%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.12 ± 34%      -0.1        0.05        perf-profile.self.cycles-pp.mpage_process_page_bufs
      0.11 ± 25%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.rmqueue
      0.15 ± 27%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.16 ± 22%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.10 ± 23%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.xas_store
      0.12 ± 17%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.ext4_bio_write_page
      0.16 ± 14%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.13 ± 20%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.xas_load
      0.18 ± 18%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.09 ± 18%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.folio_unlock
      0.11 ± 23%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.08 ± 34%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.10 ± 19%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.__alloc_pages
      0.09 ± 20%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.09 ± 21%      -0.0        0.05 ± 48%  perf-profile.self.cycles-pp.__slab_free
      0.13 ± 12%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.brd_insert_page
      0.14 ± 13%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.radix_tree_insert
      0.09 ± 15%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.08 ± 13%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.14 ±  9%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      1.46 ± 10%      +0.3        1.78 ±  5%  perf-profile.self.cycles-pp.jbd2_journal_stop
      1.06 ±  9%      +0.4        1.41 ±  7%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      1.04 ±  7%      +0.4        1.39 ±  5%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      1.08 ±  7%      +0.4        1.45 ±  7%  perf-profile.self.cycles-pp.ext4_journal_check_start



***************************************************************************************************
lkp-icl-2sp1: 96 threads 2 sockets Ice Lake with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  filesystem/gcc-9/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp1/fstat/stress-ng/60s/0xb000280

commit: 
  889c5d60fb ("selftests/rseq: Change type of rseq_offset to ptrdiff_t")
  2cfb7a1b03 ("sched/fair: Improve consistency of allowed NUMA balance calculations")

889c5d60fbcf332c 2cfb7a1b031b0e816af7a6ee0c6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1877946           -20.2%    1499226        stress-ng.fstat.ops
     31299           -20.2%      24987        stress-ng.fstat.ops_per_sec
    826920 ±  3%     -32.5%     558204 ±  4%  stress-ng.time.involuntary_context_switches
      2887            +5.9%       3057        stress-ng.time.percent_of_cpu_this_job_got
      1626            +8.4%       1762        stress-ng.time.system_time
    165.56           -18.4%     135.09        stress-ng.time.user_time
   3553984           -21.7%    2783175        stress-ng.time.voluntary_context_switches
     18.25            +2.6%      18.72        boot-time.dhcp
  19191253           -12.9%   16709285        cpuidle..usage
      2.87            -0.5        2.38        mpstat.cpu.all.usr%
    563054           -23.0%     433349        vmstat.system.cs
     99176           -22.6%      76767        turbostat.C1
  17615260 ±  7%     -15.2%   14937197 ±  6%  turbostat.C1E
     68.73            -2.0%      67.33        iostat.cpu.idle
     28.46            +6.6%      30.35        iostat.cpu.system
      2.81           -17.3%       2.33        iostat.cpu.user
     38564            -9.5%      34882        meminfo.Active
     38377            -9.8%      34616        meminfo.Active(anon)
  22913024           -41.0%   13527040        meminfo.DirectMap2M
  18658648 ±  3%     -33.3%   12451242 ±  5%  numa-numastat.node0.local_node
  18707476 ±  3%     -33.2%   12502127 ±  5%  numa-numastat.node0.numa_hit
  17372081 ±  2%     -15.7%   14653067 ±  4%  numa-numastat.node1.local_node
  17409491 ±  2%     -15.6%   14688341 ±  4%  numa-numastat.node1.numa_hit
    396952 ±  5%     -22.6%     307388 ± 30%  numa-meminfo.node0.AnonPages.max
      1112           -62.2%     420.33 ± 91%  numa-meminfo.node0.Inactive(file)
     89474 ±  3%     -13.1%      77777 ± 12%  numa-meminfo.node0.KReclaimable
     14690           -12.7%      12824        numa-meminfo.node0.KernelStack
      3996 ±  6%     -28.9%       2843 ± 21%  numa-meminfo.node0.PageTables
     89474 ±  3%     -13.1%      77777 ± 12%  numa-meminfo.node0.SReclaimable
     36499           -10.3%      32749        numa-meminfo.node1.Active
     36499           -10.6%      32641        numa-meminfo.node1.Active(anon)
     10922 ±  4%     +11.8%      12215 ±  2%  numa-meminfo.node1.KernelStack
      1507 ± 12%     +76.3%       2657 ± 23%  numa-meminfo.node1.PageTables
    176.00 ± 49%  +55065.7%      97091 ± 83%  numa-meminfo.node1.Unevictable
      9609            -9.8%       8668        proc-vmstat.nr_active_anon
    111731            -1.4%     110215        proc-vmstat.nr_inactive_anon
     25612 ±  2%      -2.3%      25032        proc-vmstat.nr_kernel_stack
     34054            +2.2%      34793        proc-vmstat.nr_mapped
     42187            -5.3%      39936        proc-vmstat.nr_shmem
      9609            -9.8%       8668        proc-vmstat.nr_zone_active_anon
    111731            -1.4%     110215        proc-vmstat.nr_zone_inactive_anon
  36118982           -24.7%   27192686        proc-vmstat.numa_hit
  36032745           -24.7%   27133038        proc-vmstat.numa_local
      1640            -6.8%       1529        proc-vmstat.pgactivate
  36094672           -24.7%   27170985        proc-vmstat.pgalloc_normal
  35882879           -24.8%   26969209        proc-vmstat.pgfree
     20271            +1.5%      20565        proc-vmstat.pgreuse
    278.00           -62.2%     105.00 ± 91%  numa-vmstat.node0.nr_inactive_file
     14713           -13.0%      12805        numa-vmstat.node0.nr_kernel_stack
    999.00 ±  6%     -29.0%     709.00 ± 21%  numa-vmstat.node0.nr_page_table_pages
     22369 ±  3%     -13.1%      19444 ± 12%  numa-vmstat.node0.nr_slab_reclaimable
    278.00           -62.2%     105.00 ± 91%  numa-vmstat.node0.nr_zone_inactive_file
  10838015           -29.9%    7593976 ±  5%  numa-vmstat.node0.numa_hit
  10789068           -29.9%    7566832 ±  5%  numa-vmstat.node0.numa_local
      9147           -11.2%       8122        numa-vmstat.node1.nr_active_anon
     10911 ±  4%     +11.5%      12163 ±  2%  numa-vmstat.node1.nr_kernel_stack
    376.67 ± 12%     +76.8%     666.00 ± 23%  numa-vmstat.node1.nr_page_table_pages
     43.33 ± 50%  +55913.1%      24272 ± 83%  numa-vmstat.node1.nr_unevictable
      9147           -11.2%       8122        numa-vmstat.node1.nr_zone_active_anon
     43.33 ± 50%  +55913.1%      24272 ± 83%  numa-vmstat.node1.nr_zone_unevictable
   8564698           -13.6%    7399145 ±  4%  numa-vmstat.node1.numa_hit
   8483147           -13.7%    7322816 ±  4%  numa-vmstat.node1.numa_local
      7.50 ±  5%     +14.1%       8.56 ±  5%  perf-stat.i.MPKI
  1.41e+10           -21.2%  1.111e+10        perf-stat.i.branch-instructions
      0.93 ±  4%      +0.1        1.01 ±  4%  perf-stat.i.branch-miss-rate%
 1.251e+08           -14.3%  1.072e+08 ±  2%  perf-stat.i.branch-misses
     17.97 ±  2%      +9.3       27.26 ±  2%  perf-stat.i.cache-miss-rate%
  98129033           +38.9%  1.363e+08        perf-stat.i.cache-misses
  5.48e+08            -9.4%  4.964e+08 ±  2%  perf-stat.i.cache-references
    585589           -23.2%     449975        perf-stat.i.context-switches
      1.38           +31.3%       1.82        perf-stat.i.cpi
 1.026e+11            +4.5%  1.072e+11        perf-stat.i.cpu-cycles
      7465 ±  3%     +56.0%      11648 ±  6%  perf-stat.i.cpu-migrations
      1062           -24.0%     807.28        perf-stat.i.cycles-between-cache-misses
  2.11e+10           -21.2%  1.662e+10        perf-stat.i.dTLB-loads
   1601716 ±  5%     -18.0%    1312862 ±  6%  perf-stat.i.dTLB-store-misses
 1.251e+10           -21.8%   9.78e+09        perf-stat.i.dTLB-stores
 7.503e+10           -21.3%  5.906e+10        perf-stat.i.instructions
      0.73           -23.9%       0.55        perf-stat.i.ipc
      1.07            +4.5%       1.12        perf-stat.i.metric.GHz
    825.91           +25.2%       1034        perf-stat.i.metric.K/sec
    502.50           -21.2%     395.81        perf-stat.i.metric.M/sec
     83.64            +3.7       87.35        perf-stat.i.node-load-miss-rate%
  13945135           +59.2%   22206111        perf-stat.i.node-load-misses
   2607458           +10.8%    2889896        perf-stat.i.node-loads
     19.85           +16.8       36.63        perf-stat.i.node-store-miss-rate%
  11453861          +125.1%   25784492        perf-stat.i.node-store-misses
  48591551            -7.4%   44979157        perf-stat.i.node-stores
      7.36           +14.8%       8.45 ±  2%  perf-stat.overall.MPKI
      0.89            +0.1        0.96 ±  2%  perf-stat.overall.branch-miss-rate%
     17.84            +9.3       27.12        perf-stat.overall.cache-miss-rate%
      1.37           +31.9%       1.81        perf-stat.overall.cpi
      1044           -24.4%     789.38        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 15%      +0.0        0.03 ± 15%  perf-stat.overall.dTLB-load-miss-rate%
      0.73           -24.2%       0.55        perf-stat.overall.ipc
     84.21            +4.2       88.39        perf-stat.overall.node-load-miss-rate%
     19.25           +17.0       36.27        perf-stat.overall.node-store-miss-rate%
 1.388e+10           -20.8%    1.1e+10        perf-stat.ps.branch-instructions
 1.232e+08           -14.1%  1.059e+08 ±  2%  perf-stat.ps.branch-misses
  96942023           +38.1%  1.339e+08        perf-stat.ps.cache-misses
 5.435e+08            -9.1%  4.938e+08 ±  2%  perf-stat.ps.cache-references
    575989           -22.7%     445024        perf-stat.ps.context-switches
 1.012e+11            +4.4%  1.057e+11        perf-stat.ps.cpu-cycles
      7513 ±  4%     +52.8%      11483 ±  6%  perf-stat.ps.cpu-migrations
 2.078e+10           -20.8%  1.646e+10        perf-stat.ps.dTLB-loads
   1574685 ±  5%     -17.8%    1294093 ±  6%  perf-stat.ps.dTLB-store-misses
 1.231e+10           -21.4%  9.678e+09        perf-stat.ps.dTLB-stores
 7.388e+10           -20.9%  5.846e+10        perf-stat.ps.instructions
  13848805           +57.7%   21844951        perf-stat.ps.node-load-misses
   2596916           +10.5%    2869144        perf-stat.ps.node-loads
  11385387          +121.5%   25213701        perf-stat.ps.node-store-misses
  47754773            -7.2%   44308372        perf-stat.ps.node-stores
 4.667e+12           -20.9%  3.694e+12        perf-stat.total.instructions
      9.95            -2.5        7.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      9.93            -2.5        7.46        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.94            -2.5        7.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      9.93            -2.5        7.46        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
     10.22            -2.4        7.78        perf-profile.calltrace.cycles-pp.__clone
      7.78            -2.4        5.42        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.14            -2.0        4.15        perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.56            -1.6        2.96 ±  2%  perf-profile.calltrace.cycles-pp.__vmalloc_node_range.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      3.45 ±  2%      -1.3        2.12 ±  3%  perf-profile.calltrace.cycles-pp.__get_vm_area_node.__vmalloc_node_range.dup_task_struct.copy_process.kernel_clone
      1.82            -1.2        0.57        perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx
      3.12 ±  2%      -1.1        1.98 ±  4%  perf-profile.calltrace.cycles-pp.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.dup_task_struct.copy_process
      3.57            -1.0        2.57 ±  2%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx
      2.48 ±  3%      -0.8        1.63 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork
      2.48 ±  3%      -0.8        1.63 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      2.43 ±  3%      -0.8        1.59 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      1.96 ±  3%      -0.8        1.15 ±  3%  perf-profile.calltrace.cycles-pp.__vunmap.free_work.process_one_work.worker_thread.kthread
      2.01 ±  3%      -0.8        1.20 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      1.98 ±  3%      -0.8        1.18 ±  3%  perf-profile.calltrace.cycles-pp.free_work.process_one_work.worker_thread.kthread.ret_from_fork
      1.59 ±  2%      -0.7        0.90 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.dup_task_struct
      2.96            -0.7        2.28        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      2.42            -0.7        1.74        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64
      2.50            -0.7        1.82        perf-profile.calltrace.cycles-pp.__entry_text_start.statx
      2.39            -0.7        1.73        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      1.51 ±  2%      -0.7        0.85        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      2.13            -0.6        1.55 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.do_statx
      1.25 ±  4%      -0.6        0.69 ±  3%  perf-profile.calltrace.cycles-pp.remove_vm_area.__vunmap.free_work.process_one_work.worker_thread
      5.48            -0.4        5.07        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.89 ±  2%      -0.4        3.48 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      3.98 ±  2%      -0.4        3.58 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.42            -0.4        5.02        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.42            -0.4        5.02        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      5.41            -0.4        5.01        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.32 ±  3%      -0.4        1.94 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.39            -0.4        1.00        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat
      1.44            -0.4        1.06        perf-profile.calltrace.cycles-pp.__fxstat64
      1.40            -0.4        1.02        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newlstat
      1.62            -0.3        1.31        perf-profile.calltrace.cycles-pp.find_idlest_group.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      1.10            -0.3        0.84        perf-profile.calltrace.cycles-pp.__vmalloc_area_node.__vmalloc_node_range.dup_task_struct.copy_process.kernel_clone
      2.36            -0.2        2.12 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.34            -0.2        2.09 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.36            -0.2        2.12 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.33            -0.2        2.09 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.88            -0.2        0.64        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      0.85            -0.2        0.63        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.user_path_at_empty.vfs_statx.do_statx
      0.77 ±  3%      -0.2        0.55 ±  3%  perf-profile.calltrace.cycles-pp.shim_statx
      0.74            -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.cp_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81            -0.2        0.64        perf-profile.calltrace.cycles-pp.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.dup_task_struct.copy_process
      1.73            -0.2        1.58        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.77            -0.1        0.63        perf-profile.calltrace.cycles-pp.release_task.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.11            -0.1        2.01        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64            +0.0        0.68        perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe.start_thread
      0.63            +0.0        0.67        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe.start_thread
      0.73 ±  3%      +0.0        0.78 ±  3%  perf-profile.calltrace.cycles-pp.__GI___pthread_timedjoin_ex
      0.65            +0.0        0.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.start_thread
      0.66            +0.1        0.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.start_thread
      1.00 ±  2%      +0.1        1.07 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      0.77            +0.1        0.85        perf-profile.calltrace.cycles-pp.start_thread
     28.56            +0.1       28.66        perf-profile.calltrace.cycles-pp.statx
      1.61            +0.3        1.91        perf-profile.calltrace.cycles-pp.vfs_getattr.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      1.57            +0.3        1.88        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_getattr.vfs_statx.do_statx.__x64_sys_statx
      1.52            +0.3        1.84        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_getattr.vfs_statx.do_statx
      1.58            +0.3        1.90        perf-profile.calltrace.cycles-pp.vfs_getattr.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.54            +0.3        1.87        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_getattr.vfs_statx.__do_sys_newstat.do_syscall_64
      1.50            +0.3        1.82        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_getattr.vfs_statx.__do_sys_newstat
      1.58            +0.3        1.93        perf-profile.calltrace.cycles-pp.vfs_getattr.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.50            +0.4        1.85        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_getattr.vfs_statx.__do_sys_newlstat
      1.54            +0.4        1.90        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_getattr.vfs_statx.__do_sys_newlstat.do_syscall_64
     13.16            +0.4       13.55        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
     11.39            +1.1       12.46        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.38            +1.1       13.49        perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.32            +1.2       25.53        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.statx
     23.87            +1.3       25.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      5.33            +1.5        6.84        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.do_statx
      5.65            +1.5        7.17        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      5.63            +1.5        7.15        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.do_statx.__x64_sys_statx
      9.07            +1.6       10.63        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.do_statx.__x64_sys_statx
      5.21            +1.6        6.82        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.__do_sys_newlstat
      5.12            +1.6        6.75        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.path_put.vfs_statx.__do_sys_newstat
      5.52            +1.6        7.15        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.50            +1.6        7.14        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.__do_sys_newlstat.do_syscall_64
      5.44            +1.6        7.08        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.79            +1.6       10.44        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.do_statx
      5.41            +1.6        7.06        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.__do_sys_newstat.do_syscall_64
     22.50            +1.7       24.19        perf-profile.calltrace.cycles-pp.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
     22.07            +1.8       23.87        perf-profile.calltrace.cycles-pp.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      8.69            +1.8       10.54        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newlstat.do_syscall_64
      9.72            +1.9       11.58        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      8.52            +1.9       10.41        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newlstat
      9.53            +1.9       11.43        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat
     20.98            +2.1       23.05        perf-profile.calltrace.cycles-pp.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.17            +2.2       24.32        perf-profile.calltrace.cycles-pp.__lxstat64
     23.01            +2.2       25.21        perf-profile.calltrace.cycles-pp.__xstat64
     20.63            +2.5       23.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lxstat64
     20.45            +2.6       23.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     21.50            +2.6       24.09        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
     21.30            +2.6       23.95        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
     19.77            +2.7       22.51        perf-profile.calltrace.cycles-pp.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     20.63            +2.8       23.44        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
     18.98            +2.9       21.91        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
     19.86            +3.0       22.85        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
     20.92            +6.4       27.34        perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
     20.77            +6.5       27.22        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
     20.52            +6.5       27.04        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
     20.03            +6.6       26.61        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      9.94            -2.5        7.47        perf-profile.children.cycles-pp.__do_sys_clone
      9.93            -2.5        7.46        perf-profile.children.cycles-pp.kernel_clone
     10.24            -2.4        7.79        perf-profile.children.cycles-pp.__clone
      8.51            -2.4        6.12        perf-profile.children.cycles-pp.getname_flags
      7.79            -2.4        5.43        perf-profile.children.cycles-pp.copy_process
      6.15            -2.0        4.15        perf-profile.children.cycles-pp.dup_task_struct
      3.76 ±  2%      -1.6        2.13        perf-profile.children.cycles-pp._raw_spin_lock
      4.56            -1.6        2.96 ±  2%  perf-profile.children.cycles-pp.__vmalloc_node_range
      3.32 ±  3%      -1.6        1.72 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.04            -1.4        3.65        perf-profile.children.cycles-pp.strncpy_from_user
      3.46 ±  2%      -1.3        2.12 ±  3%  perf-profile.children.cycles-pp.__get_vm_area_node
      3.12 ±  2%      -1.1        1.99 ±  4%  perf-profile.children.cycles-pp.alloc_vmap_area
      3.34            -0.9        2.44        perf-profile.children.cycles-pp.__entry_text_start
      2.48 ±  3%      -0.8        1.63 ±  3%  perf-profile.children.cycles-pp.kthread
      2.43 ±  3%      -0.8        1.59 ±  3%  perf-profile.children.cycles-pp.worker_thread
      1.96 ±  3%      -0.8        1.15 ±  3%  perf-profile.children.cycles-pp.__vunmap
      2.63 ±  3%      -0.8        1.82 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      2.01 ±  3%      -0.8        1.20 ±  3%  perf-profile.children.cycles-pp.process_one_work
      1.98 ±  3%      -0.8        1.18 ±  3%  perf-profile.children.cycles-pp.free_work
      2.85            -0.7        2.11        perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.04            -0.7        2.34        perf-profile.children.cycles-pp.link_path_walk
      1.25 ±  4%      -0.6        0.69 ±  3%  perf-profile.children.cycles-pp.remove_vm_area
      1.98            -0.6        1.43        perf-profile.children.cycles-pp.__check_object_size
      2.15            -0.6        1.59        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.67            -0.5        1.18        perf-profile.children.cycles-pp.kmem_cache_free
      1.93            -0.5        1.46        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.79 ±  3%      -0.4        0.36 ±  4%  perf-profile.children.cycles-pp.find_vmap_area
      1.65            -0.4        1.22        perf-profile.children.cycles-pp.__fxstat64
      5.48            -0.4        5.07        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      5.48            -0.4        5.07        perf-profile.children.cycles-pp.cpu_startup_entry
      4.03 ±  2%      -0.4        3.62 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      5.48            -0.4        5.07        perf-profile.children.cycles-pp.do_idle
      4.02 ±  2%      -0.4        3.61 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      5.42            -0.4        5.02        perf-profile.children.cycles-pp.start_secondary
      2.36 ±  3%      -0.4        1.97 ±  2%  perf-profile.children.cycles-pp.intel_idle
      3.02            -0.4        2.67        perf-profile.children.cycles-pp.walk_component
      0.80 ±  3%      -0.3        0.47 ±  3%  perf-profile.children.cycles-pp.free_vmap_area_noflush
      1.23            -0.3        0.91        perf-profile.children.cycles-pp._copy_to_user
      1.66            -0.3        1.35        perf-profile.children.cycles-pp.find_idlest_group
      1.28            -0.3        0.98        perf-profile.children.cycles-pp.cp_new_stat
      1.25            -0.3        0.97        perf-profile.children.cycles-pp.__might_resched
      1.10            -0.3        0.84        perf-profile.children.cycles-pp.__vmalloc_area_node
      0.91            -0.2        0.67        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.00            -0.2        0.77        perf-profile.children.cycles-pp.__might_fault
      0.78            -0.2        0.55        perf-profile.children.cycles-pp.__check_heap_object
      0.79 ±  3%      -0.2        0.57 ±  3%  perf-profile.children.cycles-pp.shim_statx
      2.97            -0.2        2.77        perf-profile.children.cycles-pp.__x64_sys_exit
      2.97            -0.2        2.77        perf-profile.children.cycles-pp.do_exit
      0.34 ±  6%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.find_vm_area
      0.76            -0.2        0.57 ±  2%  perf-profile.children.cycles-pp.cp_statx
      0.96 ±  3%      -0.2        0.79 ±  2%  perf-profile.children.cycles-pp.step_into
      0.81            -0.2        0.65        perf-profile.children.cycles-pp.__alloc_pages_bulk
      0.65            -0.2        0.49        perf-profile.children.cycles-pp.__might_sleep
      0.69 ±  2%      -0.2        0.54        perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.78 ±  2%      -0.1        0.63        perf-profile.children.cycles-pp.release_task
      0.58            -0.1        0.44        perf-profile.children.cycles-pp.kernel_init_free_pages
      1.75            -0.1        1.61        perf-profile.children.cycles-pp.select_task_rq_fair
      0.71            -0.1        0.57        perf-profile.children.cycles-pp.path_init
      0.56            -0.1        0.42        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.57            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      0.51            -0.1        0.38 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.74 ±  3%      -0.1        0.61        perf-profile.children.cycles-pp.inode_permission
      1.60 ±  3%      -0.1        1.49        perf-profile.children.cycles-pp.lookup_fast
      2.11            -0.1        2.01        perf-profile.children.cycles-pp.wake_up_new_task
      0.36 ±  3%      -0.1        0.26        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.39            -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.34 ±  4%      -0.1        0.25        perf-profile.children.cycles-pp.__cond_resched
      0.53            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.__sched_yield
      0.32 ±  2%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.putname
      0.46            -0.1        0.37        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.35 ±  4%      -0.1        0.26        perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.25            -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.insert_vmap_area
      0.86 ±  3%      -0.1        0.78        perf-profile.children.cycles-pp.__d_lookup_rcu
      0.51 ±  2%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.memcpy_erms
      0.29            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.alloc_pid
      0.49 ±  2%      -0.1        0.41 ±  3%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.44            -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.22            -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.cgroup_can_fork
      0.42 ±  4%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.generic_permission
      0.36 ±  2%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.31            -0.1        0.24        perf-profile.children.cycles-pp.terminate_walk
      0.26            -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.cgroup_free
      0.29            -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.cpumask_next
      0.28 ±  4%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.15            -0.1        0.09        perf-profile.children.cycles-pp.cgroup_release
      0.29 ±  2%      -0.1        0.23        perf-profile.children.cycles-pp.map_id_up
      0.37 ±  2%      -0.1        0.31 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.18            -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.cgroup_post_fork
      0.25 ±  3%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.refcount_dec_not_one
      0.25 ±  3%      -0.1        0.19        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13            -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.insert_vmap_area_augment
      0.14 ± 21%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__lookup_mnt
      0.20 ±  2%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.31            -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.nd_jump_root
      0.22 ±  3%      -0.0        0.17        perf-profile.children.cycles-pp.page_counter_charge
      0.18            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.security_inode_permission
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__x64_sys_newstat
      0.16 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ±  7%      -0.0        0.08        perf-profile.children.cycles-pp.rb_insert_color
      0.21 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.20 ±  6%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.common_perm
      0.18 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.from_kgid_munged
      0.12            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pids_can_fork
      0.29 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.dequeue_entity
      0.37            -0.0        0.33        perf-profile.children.cycles-pp.__put_task_struct
      0.22 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.generic_fillattr
      0.16 ±  5%      -0.0        0.12        perf-profile.children.cycles-pp.__x64_sys_newlstat
      0.13 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_sched_yield
      0.40 ±  3%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.32            -0.0        0.28        perf-profile.children.cycles-pp.sched_move_task
      0.20            -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.19 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__slab_alloc
      0.19 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.14            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.15 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.vfs_fstat
      0.47 ±  4%      -0.0        0.43 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.27            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.07 ± 14%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__free_pages
      0.17 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mntput_no_expire
      0.17 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.from_kuid_munged
      0.11 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.cgroup_exit
      0.42 ±  4%      -0.0        0.39 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.18 ±  4%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.09            -0.0        0.06        perf-profile.children.cycles-pp.copy_thread
      0.16            -0.0        0.13        perf-profile.children.cycles-pp.wake_up_q
      0.12 ±  6%      -0.0        0.09        perf-profile.children.cycles-pp.sched_post_fork
      0.11 ± 12%      -0.0        0.08        perf-profile.children.cycles-pp.propagate_protected_usage
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.add_device_randomness
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.free_pid
      0.14            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.32 ±  3%      -0.0        0.29        perf-profile.children.cycles-pp.stress_fstat_helper
      0.24 ±  3%      -0.0        0.21        perf-profile.children.cycles-pp.account_kernel_stack
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.perf_event_task
      0.10 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.__list_add_valid
      0.08            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.cpu_cgroup_fork
      0.21            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.20 ±  4%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      0.26 ±  3%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.17 ±  2%      -0.0        0.15        perf-profile.children.cycles-pp.perf_event_task_output
      0.09            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_rq_lock
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__x64_sys_newfstat
      0.20 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.__fget_light
      0.16 ±  5%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
      0.12 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.allocate_slab
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.restore_nameidata
      0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.vunmap_range_noflush
      0.19 ±  5%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.idr_alloc_cyclic
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.idr_alloc_u32
      0.22 ±  4%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.07 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.task_fork_fair
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__purge_vmap_area_lazy
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.task_change_group_fair
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.mntput
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.rb_erase
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.should_failslab
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.refill_stock
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp._mix_pool_bytes
      0.12 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.native_sched_clock
      0.09 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.perf_event_fork
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.read_tsc
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.futex_cleanup_begin
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.task_tick_fair
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.proc_fd_link
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.switch_fpu_return
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.futex_wait_setup
      0.06            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.10            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.pid_revalidate
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.06 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.pid_update_inode
      0.09            +0.0        0.11        perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.09            +0.0        0.11        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.tid_fd_revalidate
      0.24            +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.27            +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.25            +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.14 ±  3%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.stress_fstat
      0.13 ±  6%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.recalc_sigpending
      0.23 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.pick_link
      0.06            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.try_grab_compound_head
      0.11 ±  7%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.pthread_create@@GLIBC_2.2.5
      0.23 ±  2%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.19 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.schedule_tail
      0.10            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.gup_pgd_range
      0.17 ±  7%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.sigprocmask
      0.12            +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.cpumask_next_and
      0.03 ± 70%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.llist_add_batch
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.internal_get_user_pages_fast
      0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.task_dump_owner
      0.12 ±  4%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.get_futex_key
      0.73 ±  3%      +0.0        0.78 ±  3%  perf-profile.children.cycles-pp.__GI___pthread_timedjoin_ex
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.check_preempt_curr
      0.92 ±  3%      +0.1        0.97 ±  2%  perf-profile.children.cycles-pp.do_futex
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__set_task_blocked
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.security_task_free
     28.72            +0.1       28.78        perf-profile.children.cycles-pp.statx
      0.17            +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__set_current_blocked
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.memset_erms
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.get_pid_task
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.78            +0.1        0.86        perf-profile.children.cycles-pp.start_thread
      0.93 ±  2%      +0.1        1.05 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.55            +0.1        0.68 ±  5%  perf-profile.children.cycles-pp.lockref_put_return
      4.80            +1.0        5.76        perf-profile.children.cycles-pp.vfs_getattr
      4.69            +1.0        5.67        perf-profile.children.cycles-pp.security_inode_getattr
      4.56            +1.0        5.54        perf-profile.children.cycles-pp.common_perm_cond
     22.55            +1.7       24.22        perf-profile.children.cycles-pp.__x64_sys_statx
     22.12            +1.8       23.90        perf-profile.children.cycles-pp.do_statx
     22.59            +2.0       24.62        perf-profile.children.cycles-pp.__lxstat64
     23.44            +2.1       25.52        perf-profile.children.cycles-pp.__xstat64
     37.10            +2.5       39.63        perf-profile.children.cycles-pp.user_path_at_empty
     19.79            +2.7       22.53        perf-profile.children.cycles-pp.__do_sys_newlstat
     20.65            +2.8       23.46        perf-profile.children.cycles-pp.__do_sys_newstat
     82.06            +3.4       85.49        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     81.30            +3.6       84.92        perf-profile.children.cycles-pp.do_syscall_64
     15.84            +4.8       20.62        perf-profile.children.cycles-pp.lockref_put_or_lock
     16.63            +4.8       21.42        perf-profile.children.cycles-pp.path_put
     16.87            +4.8       21.70        perf-profile.children.cycles-pp.dput
     27.55            +5.2       32.80        perf-profile.children.cycles-pp.filename_lookup
     26.97            +5.4       32.38        perf-profile.children.cycles-pp.path_lookupat
     20.95            +6.4       27.36        perf-profile.children.cycles-pp.complete_walk
     20.83            +6.4       27.27        perf-profile.children.cycles-pp.try_to_unlazy
     20.74            +6.5       27.27        perf-profile.children.cycles-pp.__legitimize_path
     20.26            +6.6       26.86        perf-profile.children.cycles-pp.lockref_get_not_dead
     59.92            +8.0       67.89        perf-profile.children.cycles-pp.vfs_statx
      3.29 ±  3%      -1.6        1.71 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.81            -0.7        2.08        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.35            -0.6        1.70        perf-profile.self.cycles-pp.strncpy_from_user
      1.92            -0.5        1.45        perf-profile.self.cycles-pp.statx
      1.31 ±  2%      -0.4        0.87        perf-profile.self.cycles-pp.kmem_cache_free
      2.35 ±  3%      -0.4        1.96 ±  2%  perf-profile.self.cycles-pp.intel_idle
      1.23            -0.3        0.90        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.20            -0.3        0.88        perf-profile.self.cycles-pp.__entry_text_start
      1.19 ±  2%      -0.3        0.88        perf-profile.self.cycles-pp.kmem_cache_alloc
      1.09 ±  4%      -0.3        0.81 ±  7%  perf-profile.self.cycles-pp.alloc_vmap_area
      1.15            -0.3        0.89        perf-profile.self.cycles-pp.__might_resched
      1.41            -0.3        1.15        perf-profile.self.cycles-pp.find_idlest_group
      0.88            -0.2        0.65 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.77 ±  3%      -0.2        0.53        perf-profile.self.cycles-pp.__check_object_size
      0.85            -0.2        0.63        perf-profile.self.cycles-pp.link_path_walk
      0.86            -0.2        0.63        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.65            -0.2        0.45 ±  2%  perf-profile.self.cycles-pp.getname_flags
      0.74 ±  3%      -0.2        0.53 ±  3%  perf-profile.self.cycles-pp.shim_statx
      0.71            -0.2        0.51        perf-profile.self.cycles-pp.__check_heap_object
      0.69            -0.2        0.51        perf-profile.self.cycles-pp.do_syscall_64
      0.64            -0.2        0.47        perf-profile.self.cycles-pp.__lxstat64
      0.63 ±  2%      -0.2        0.47        perf-profile.self.cycles-pp.__xstat64
      0.88            -0.2        0.73        perf-profile.self.cycles-pp._raw_spin_lock
      0.58            -0.2        0.43 ±  5%  perf-profile.self.cycles-pp.step_into
      0.56            -0.1        0.42        perf-profile.self.cycles-pp.vfs_statx
      0.57            -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.47            -0.1        0.33        perf-profile.self.cycles-pp.filename_lookup
      0.55            -0.1        0.42        perf-profile.self.cycles-pp.__might_sleep
      0.47            -0.1        0.36        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.47 ±  2%      -0.1        0.36        perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.41 ±  3%      -0.1        0.30        perf-profile.self.cycles-pp.__x64_sys_statx
      0.41            -0.1        0.31        perf-profile.self.cycles-pp.lookup_fast
      0.37            -0.1        0.27        perf-profile.self.cycles-pp.path_lookupat
      0.35 ±  3%      -0.1        0.26        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.31 ±  4%      -0.1        0.21        perf-profile.self.cycles-pp.user_path_at_empty
      0.34            -0.1        0.25        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.34            -0.1        0.25        perf-profile.self.cycles-pp.walk_component
      0.33 ±  2%      -0.1        0.24        perf-profile.self.cycles-pp.do_statx
      0.31            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.path_init
      0.35            -0.1        0.26        perf-profile.self.cycles-pp.__fxstat64
      0.50 ±  2%      -0.1        0.42 ±  3%  perf-profile.self.cycles-pp.memcpy_erms
      0.36            -0.1        0.27 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.83 ±  3%      -0.1        0.75        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.27            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.inode_permission
      0.25            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.putname
      0.24            -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.free_vmap_area_noflush
      0.22 ±  2%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.find_vmap_area
      0.20 ±  4%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__vmalloc_area_node
      0.17 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.insert_vmap_area
      0.26 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.map_id_up
      0.39 ±  5%      -0.1        0.33        perf-profile.self.cycles-pp.generic_permission
      0.25 ±  3%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.refcount_dec_not_one
      0.24            -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.cp_statx
      0.18 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__alloc_pages_bulk
      0.25            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.cp_new_stat
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  2%      -0.0        0.12        perf-profile.self.cycles-pp.terminate_walk
      0.12            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.pids_can_fork
      0.12 ± 24%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__lookup_mnt
      0.39 ±  3%      -0.0        0.35 ±  2%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.19 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.page_counter_charge
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.try_to_unlazy
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__x64_sys_newstat
      0.18 ±  7%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.common_perm
      0.28            -0.0        0.24        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.20            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.dput
      0.19 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.19 ±  4%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__might_fault
      0.15            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.security_inode_permission
      0.15            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__do_sys_newlstat
      0.13 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.nd_jump_root
      0.12 ±  8%      -0.0        0.08        perf-profile.self.cycles-pp.rb_insert_color
      0.31            -0.0        0.28        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.20            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.generic_fillattr
      0.14            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.dup_task_struct
      0.11 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.14 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.__x64_sys_newlstat
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__free_pages
      0.07 ±  7%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.legitimize_links
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.__list_add_valid
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.___slab_alloc
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__do_sys_newstat
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.mntput_no_expire
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp._copy_to_user
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__legitimize_path
      0.19 ±  2%      -0.0        0.17        perf-profile.self.cycles-pp.__fget_light
      0.14 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.10            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.check_stack_object
      0.10 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.enqueue_entity
      0.10 ±  9%      -0.0        0.08        perf-profile.self.cycles-pp.propagate_protected_usage
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.vunmap_range_noflush
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.__x64_sys_newfstat
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.rb_erase
      0.11 ±  7%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.complete_walk
      0.10 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.vfs_getattr
      0.09 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.cpumask_next
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp._mix_pool_bytes
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.security_inode_getattr
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.09 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.update_curr
      0.09 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.restore_nameidata
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.mntput
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.finish_task_switch
      0.18            +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.23 ±  2%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.10 ±  9%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.start_thread
      0.06            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.try_grab_compound_head
      0.11 ±  7%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.pthread_create@@GLIBC_2.2.5
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__GI___pthread_timedjoin_ex
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.03 ± 70%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.llist_add_batch
      0.11            +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.cpumask_next_and
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.gup_pgd_range
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.get_pid_task
      0.58            +0.1        0.66 ±  6%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.06 ±  7%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.54            +0.1        0.68 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
      4.33            +1.0        5.35        perf-profile.self.cycles-pp.common_perm_cond
     15.69            +4.8       20.45        perf-profile.self.cycles-pp.lockref_put_or_lock
     20.07            +6.6       26.62        perf-profile.self.cycles-pp.lockref_get_not_dead





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-rc1-00026-g2cfb7a1b031b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.17.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.2.0-19) 11.2.0"
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
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
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
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
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
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
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
# CONFIG_X86_X32 is not set
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
CONFIG_KVM_MMU_AUDIT=y
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
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
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
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
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
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
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
# CONFIG_CX_ECAT is not set
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
CONFIG_NET_VENDOR_MICROSOFT=y
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
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
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
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
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
# CONFIG_SERIAL_BCM63XX is not set
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
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
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
CONFIG_SENSORS_DELL_SMM=m
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
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set

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
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#

#
# Media SPI Adapters
#
# end of Media SPI Adapters
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
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
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
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
# CONFIG_TYPEC_STUSB160X is not set

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
CONFIG_VIRTIO_MEM=m
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
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
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
# CONFIG_I2C_MULTI_INSTANTIATE is not set
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
# CONFIG_COMMON_CLK_LAN966X is not set
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
# CONFIG_DTPM is not set
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
CONFIG_ND_BLK=m
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
CONFIG_NFSD_V3=y
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
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
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
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
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
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
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

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
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

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

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
# CONFIG_TEST_OVERFLOW is not set
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
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=9
	export testtime=60
	export job_origin='stress-ng-class-filesystem.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='lkp-icl-2sp1'
	export tbox_group='lkp-icl-2sp1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='625b3d86c331f097f0966a95'
	export job_file='/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280-debian-10.4-x86_64-20200603.cgz-2cfb7a1b031b0e816af7a6e-20220417-38896-19so86h-3.yaml'
	export id='ae3c57d16105a946336aabcf3b4a7cdc348e1fd9'
	export queuer_version='/zday/lkp'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='256G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST9500530NS_9SP1KLAR-part1'
	export ssd_partitions='/dev/nvme0n1p1'
	export swap_partitions=
	export kernel_cmdline_hw='acpi_rsdp=0x667fd014'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204005K800RGN-part3'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
F2FS_FS'
	export commit='2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a'
	export ucode='0xb000280'
	export need_kconfig_hw='{"IGB"=>"y"}
{"IXGBE"=>"y"}
SATA_AHCI'
	export bisect_dmesg=true
	export enqueue_time='2022-04-17 06:04:55 +0800'
	export _id='625b3d86c331f097f0966a95'
	export _rt='/result/stress-ng/filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='95266ba8cb20a21d3d85fc278fcdcb11648c874c'
	export base_commit='f443e374ae131c168a065ea1748feac6b2e76613'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/stress-ng/filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/3'
	export scheduler_version='/lkp/lkp/.src-20220415-153857'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/stress-ng/filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/vmlinuz-5.17.0-rc1-00026-g2cfb7a1b031b
branch=linus/master
job=/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280-debian-10.4-x86_64-20200603.cgz-2cfb7a1b031b0e816af7a6e-20220417-38896-19so86h-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
acpi_rsdp=0x667fd014
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20220415.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20220415.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-90ea17a9e27b-1_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.18.0-rc2'
	export repeat_to=6
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/vmlinuz-5.17.0-rc1-00026-g2cfb7a1b031b'
	export dequeue_time='2022-04-17 06:09:12 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280-debian-10.4-x86_64-20200603.cgz-2cfb7a1b031b0e816af7a6e-20220417-38896-19so86h-3.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_setup fs='f2fs' $LKP_SRC/setup/fs

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
	run_monitor pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='filesystem' test='fstat' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env class='filesystem' test='fstat' $LKP_SRC/stats/wrapper stress-ng
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
	env pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/stats/wrapper pmeter

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/stress-ng-class-filesystem.yaml:
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 10%
disk: 1HDD
testtime: 60s
fs: f2fs
stress-ng:
  class: filesystem
  test: fstat
job_origin: stress-ng-class-filesystem.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-icl-2sp1
tbox_group: lkp-icl-2sp1
kconfig: x86_64-rhel-8.3
submit_id: 625b1093c331f08f58d883c1
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280-debian-10.4-x86_64-20200603.cgz-2cfb7a1b031b0e816af7a6e-20220417-36696-ivhkwr-1.yaml"
id: 7f6edc98371c847eadc43b67764e990a804a1d16
queuer_version: "/zday/lkp"
:#! hosts/lkp-icl-2sp1:
model: Ice Lake
nr_node: 2
nr_cpu: 96
memory: 256G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST9500530NS_9SP1KLAR-part1"
ssd_partitions: "/dev/nvme0n1p1"
swap_partitions:
kernel_cmdline_hw: acpi_rsdp=0x667fd014
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204005K800RGN-part3"
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
:#! include/disk/nr_hdd:
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- F2FS_FS
:#! include/stress-ng:
:#! include/queue/cyclic:
commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
:#! include/testbox/lkp-icl-2sp1:
ucode: '0xb000280'
need_kconfig_hw:
- IGB: y
- IXGBE: y
- SATA_AHCI
pmeter:
  pmeter_server: lkp-nhm-dp2
  pmeter_device: yokogawa-wt310
bisect_dmesg: true
:#! include/fs/OTHERS:
enqueue_time: 2022-04-17 02:53:07.986088260 +08:00
_id: 625b1581c331f08f58d883c2
_rt: "/result/stress-ng/filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 95266ba8cb20a21d3d85fc278fcdcb11648c874c
base_commit: f443e374ae131c168a065ea1748feac6b2e76613
branch: linus/master
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/stress-ng/filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/0"
scheduler_version: "/lkp/lkp/.src-20220415-153857"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/stress-ng/filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/vmlinuz-5.17.0-rc1-00026-g2cfb7a1b031b
- branch=linus/master
- job=/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-f2fs-10%-fstat-60s-ucode=0xb000280-debian-10.4-x86_64-20200603.cgz-2cfb7a1b031b0e816af7a6e-20220417-36696-ivhkwr-1.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
- acpi_rsdp=0x667fd014
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20220415.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20220415.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-59250f8a7f3a-1_20220416.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220403090403/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.18.0-rc2-intel-next-00849-gbaa4f5e4d753
repeat_to: 3
:#! /cephfs/db/releases/20220415163227/lkp-src/include/site/inn:
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a/vmlinuz-5.17.0-rc1-00026-g2cfb7a1b031b"
dequeue_time: 2022-04-17 03:36:31.283539400 +08:00
:#! /cephfs/db/releases/20220416203257/lkp-src/include/site/inn:
job_state: finished
loadavg: 11.62 5.39 2.02 1/918 2477
start_time: '1650137902'
end_time: '1650137964'
version: "/lkp/lkp/.src-20220415-153936:c7b8fcf9:f06178ed5"

--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t f2fs /dev/sda1
mkdir -p /fs/sda1
mount -t f2fs /dev/sda1 /fs/sda1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "mkdir" "-p" "/mnt/stress-ng"
 "mount" "/dev/sda1" "/mnt/stress-ng"
 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--fstat" "9"

--m51xatjYGsM+13rf--
