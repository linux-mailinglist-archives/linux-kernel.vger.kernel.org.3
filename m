Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E4465FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345898AbhLBIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:47:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:50516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhLBIrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:47:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260655908"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="yaml'?scan'208";a="260655908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:44:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="yaml'?scan'208";a="500644948"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:44:10 -0800
Date:   Thu, 2 Dec 2021 16:44:07 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: [f2fs]  4fa18391ae:  aim7.jobs-per-min -35.5% regression
Message-ID: <20211202084407.GB30817@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -35.5% regression of aim7.jobs-per-min due to commit:


commit: 4fa18391ae8cf8f1e498d54b46c571aebf3aa806 ("f2fs: do not expose unwritten blocks to user by DIO")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: aim7
on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
with following parameters:

	disk: 1BRD_48G
	fs: f2fs
	test: disk_cp
	load: 3000
	cpufreq_governor: performance
	ucode: 0x700001e

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -53.2% regression                                       |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | disk=4BRD_12G                                                                   |
|                  | fs=f2fs                                                                         |
|                  | load=3000                                                                       |
|                  | md=RAID1                                                                        |
|                  | test=disk_rw                                                                    |
|                  | ucode=0x5003006                                                                 |
+------------------+---------------------------------------------------------------------------------+


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
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/f2fs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/disk_cp/aim7/0x700001e

commit: 
  3d697a4a6b ("f2fs: rework write preallocations")
  4fa18391ae ("f2fs: do not expose unwritten blocks to user by DIO")

3d697a4a6b7dab8f 4fa18391ae8cf8f1e498d54b46c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     74254           -35.5%      47877 ±  2%  aim7.jobs-per-min
    242.67           +55.1%     376.33 ±  2%  aim7.time.elapsed_time
    242.67           +55.1%     376.33 ±  2%  aim7.time.elapsed_time.max
   2145257 ±  5%    +193.1%    6287243 ±  5%  aim7.time.involuntary_context_switches
    297540 ±  2%     +25.9%     374643 ±  3%  aim7.time.minor_page_faults
     32890           +52.7%      50236 ±  2%  aim7.time.system_time
     27.09           +27.3%      34.49 ±  2%  aim7.time.user_time
    421880 ± 21%   +2657.0%   11631366 ± 11%  aim7.time.voluntary_context_switches
      6.03 ±  2%     +12.9%       6.81 ±  4%  iostat.cpu.idle
 1.847e+09 ±  2%     +85.7%  3.428e+09 ±  4%  cpuidle..time
   3876146 ± 14%    +226.0%   12637810 ± 12%  cpuidle..usage
   2826103 ± 46%    +274.8%   10593320 ± 21%  turbostat.C1E
  73187009           +55.6%  1.139e+08 ±  4%  turbostat.IRQ
    299.26           +44.6%     432.71 ±  2%  uptime.boot
      9119 ±  4%     +17.1%      10680 ±  3%  uptime.idle
      5.28 ±  2%      +1.0        6.32 ±  4%  mpstat.cpu.all.idle%
      0.00 ± 65%      -0.0        0.00 ± 83%  mpstat.cpu.all.iowait%
      0.02 ±  6%      +0.0        0.03 ±  6%  mpstat.cpu.all.soft%
      5206           -17.8%       4279 ±  2%  vmstat.io.bo
   3449254           +55.8%    5375641        vmstat.memory.cache
    267.50 ±  3%     +55.8%     416.67 ±  3%  vmstat.procs.r
     13082 ±  3%    +396.8%      64991 ±  7%  vmstat.system.cs
      4053 ±  2%     +65.0%       6688 ±  2%  slabinfo.f2fs_inode_cache.active_objs
      4053 ±  2%     +68.9%       6845 ±  2%  slabinfo.f2fs_inode_cache.num_objs
     30617 ±  2%      -7.8%      28224 ±  4%  slabinfo.lsm_file_cache.active_objs
     43090           +16.7%      50281        slabinfo.radix_tree_node.active_objs
    775.17           +22.9%     952.50        slabinfo.radix_tree_node.active_slabs
     43439           +22.9%      53368        slabinfo.radix_tree_node.num_objs
    775.17           +22.9%     952.50        slabinfo.radix_tree_node.num_slabs
      5863 ± 10%     +14.7%       6728 ±  3%  slabinfo.shmem_inode_cache.active_objs
      5863 ± 10%     +14.7%       6728 ±  3%  slabinfo.shmem_inode_cache.num_objs
    510198 ±  3%    +286.5%    1971756 ±  2%  meminfo.Active
    504595 ±  3%    +289.3%    1964178 ±  2%  meminfo.Active(anon)
      5602 ±  3%     +35.2%       7577        meminfo.Active(file)
   3279800           +58.5%    5199801        meminfo.Cached
   3235772           +50.3%    4863430        meminfo.Committed_AS
    127149 ±  2%    +249.3%     444125 ±  6%  meminfo.Dirty
    569998           +80.8%    1030479 ±  3%  meminfo.Inactive
    445430           +32.0%     587968 ±  6%  meminfo.Inactive(anon)
    124568 ±  2%    +255.2%     442511 ±  6%  meminfo.Inactive(file)
    116537 ±  2%     +95.7%     228065 ± 22%  meminfo.Mapped
   6080907           +42.7%    8677900 ±  7%  meminfo.Memused
    578794 ±  2%    +276.3%    2178122        meminfo.Shmem
   6531876           +58.6%   10359908 ±  5%  meminfo.max_used_kB
     32624 ±  3%    +243.2%     111961 ±  6%  numa-meminfo.node0.Dirty
     32163 ±  3%    +247.1%     111637 ±  6%  numa-meminfo.node0.Inactive(file)
     39026 ±114%    +415.2%     201066 ± 25%  numa-meminfo.node1.Active
     38236 ±117%    +420.7%     199109 ± 25%  numa-meminfo.node1.Active(anon)
     31896 ±  3%    +252.2%     112348 ±  6%  numa-meminfo.node1.Dirty
    128417 ± 83%    +265.7%     469606 ± 35%  numa-meminfo.node1.FilePages
     31133 ±  3%    +259.4%     111876 ±  6%  numa-meminfo.node1.Inactive(file)
     17929 ± 33%    +104.0%      36582 ± 16%  numa-meminfo.node1.Mapped
    668841 ± 34%    +107.6%    1388183 ± 37%  numa-meminfo.node1.MemUsed
     47191 ±117%    +378.5%     225818 ± 22%  numa-meminfo.node1.Shmem
     14889 ± 91%   +1353.8%     216463 ± 16%  numa-meminfo.node2.Active
     13790 ± 96%   +1458.0%     214844 ± 17%  numa-meminfo.node2.Active(anon)
     32130 ±  3%    +249.6%     112328 ±  6%  numa-meminfo.node2.Dirty
     31451 ±  4%    +255.5%     111802 ±  6%  numa-meminfo.node2.Inactive(file)
     18670 ± 86%   +1222.0%     246811 ± 20%  numa-meminfo.node2.Shmem
    345708 ± 20%    +278.7%    1309082 ±  9%  numa-meminfo.node3.Active
    344607 ± 20%    +279.4%    1307362 ±  9%  numa-meminfo.node3.Active(anon)
     32034 ±  4%    +249.0%     111794 ±  6%  numa-meminfo.node3.Dirty
    483217 ± 26%    +310.2%    1982305 ± 42%  numa-meminfo.node3.FilePages
     31339 ±  4%    +255.6%     111429 ±  6%  numa-meminfo.node3.Inactive(file)
     30679 ± 28%    +218.0%      97565 ± 37%  numa-meminfo.node3.Mapped
  31871824           -17.7%   26220660 ± 15%  numa-meminfo.node3.MemFree
   1105046 ± 36%    +137.8%    2627440 ± 33%  numa-meminfo.node3.MemUsed
    377293 ± 21%    +280.9%    1437212 ±  9%  numa-meminfo.node3.Shmem
    126093 ±  3%    +289.2%     490726 ±  2%  proc-vmstat.nr_active_anon
      1399 ±  3%     +35.4%       1895        proc-vmstat.nr_active_file
     32182 ±  3%    +245.4%     111167 ±  6%  proc-vmstat.nr_dirty
   3124644           -34.7%    2040439 ± 51%  proc-vmstat.nr_dirty_background_threshold
   6256929           -34.7%    4085867 ± 51%  proc-vmstat.nr_dirty_threshold
    820380           +58.4%    1299662        proc-vmstat.nr_file_pages
  31392561           -34.9%   20422143 ± 51%  proc-vmstat.nr_free_pages
    111459           +31.8%     146918 ±  6%  proc-vmstat.nr_inactive_anon
     31518 ±  3%    +251.3%     110738 ±  6%  proc-vmstat.nr_inactive_file
     29350 ±  2%     +93.5%      56798 ± 22%  proc-vmstat.nr_mapped
    144728 ±  2%    +276.0%     544126        proc-vmstat.nr_shmem
     41915            +6.0%      44432        proc-vmstat.nr_slab_reclaimable
    319571 ±  2%     +27.0%     405943 ±  4%  proc-vmstat.nr_written
    126093 ±  3%    +289.2%     490726 ±  2%  proc-vmstat.nr_zone_active_anon
      1399 ±  3%     +35.4%       1895        proc-vmstat.nr_zone_active_file
    111459           +31.8%     146918 ±  6%  proc-vmstat.nr_zone_inactive_anon
     31518 ±  3%    +251.3%     110738 ±  6%  proc-vmstat.nr_zone_inactive_file
     32190 ±  3%    +245.4%     111176 ±  6%  proc-vmstat.nr_zone_write_pending
    160622 ±  3%    +214.7%     505422 ±  5%  proc-vmstat.numa_hint_faults
    107007 ±  9%    +119.8%     235173 ±  3%  proc-vmstat.numa_hint_faults_local
  78831382            +1.2%   79756673        proc-vmstat.numa_hit
  78645280            +1.2%   79565383        proc-vmstat.numa_local
    348125 ±  3%    +105.9%     716714 ±  5%  proc-vmstat.numa_pte_updates
    252370 ±  2%    +131.6%     584436        proc-vmstat.pgactivate
  78837491            +1.2%   79765368        proc-vmstat.pgalloc_normal
   1481521           +51.5%    2244332        proc-vmstat.pgfault
   1279742 ±  2%     +26.9%    1624069 ±  4%  proc-vmstat.pgpgout
     77086 ±  2%     +45.2%     111961 ±  2%  proc-vmstat.pgreuse
      8204 ±  2%    +243.2%      28153 ±  6%  numa-vmstat.node0.nr_dirty
      8086 ±  2%    +247.3%      28083 ±  6%  numa-vmstat.node0.nr_inactive_file
      8086 ±  3%    +247.3%      28083 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
      8209 ±  2%    +243.0%      28154 ±  6%  numa-vmstat.node0.nr_zone_write_pending
      9580 ±117%    +419.5%      49767 ± 25%  numa-vmstat.node1.nr_active_anon
      8035 ±  3%    +252.0%      28282 ±  6%  numa-vmstat.node1.nr_dirty
     32176 ± 82%    +265.5%     117617 ± 35%  numa-vmstat.node1.nr_file_pages
      7844 ±  3%    +259.3%      28180 ±  6%  numa-vmstat.node1.nr_inactive_file
      4436 ± 33%    +106.0%       9137 ± 16%  numa-vmstat.node1.nr_mapped
     11807 ±118%    +378.2%      56456 ± 22%  numa-vmstat.node1.nr_shmem
      9580 ±117%    +419.5%      49767 ± 25%  numa-vmstat.node1.nr_zone_active_anon
      7842 ±  3%    +259.4%      28182 ±  6%  numa-vmstat.node1.nr_zone_inactive_file
      8037 ±  3%    +251.9%      28286 ±  6%  numa-vmstat.node1.nr_zone_write_pending
      3453 ± 96%   +1454.2%      53675 ± 17%  numa-vmstat.node2.nr_active_anon
      8063 ±  3%    +251.7%      28356 ±  6%  numa-vmstat.node2.nr_dirty
      7891 ±  3%    +258.0%      28246 ±  6%  numa-vmstat.node2.nr_inactive_file
      4674 ± 86%   +1219.2%      61670 ± 20%  numa-vmstat.node2.nr_shmem
      3453 ± 96%   +1454.2%      53675 ± 17%  numa-vmstat.node2.nr_zone_active_anon
      7891 ±  3%    +257.9%      28245 ±  6%  numa-vmstat.node2.nr_zone_inactive_file
      8064 ±  3%    +251.6%      28358 ±  6%  numa-vmstat.node2.nr_zone_write_pending
     86302 ± 20%    +278.5%     326666 ±  9%  numa-vmstat.node3.nr_active_anon
      8089 ±  4%    +248.2%      28168 ±  6%  numa-vmstat.node3.nr_dirty
    120914 ± 26%    +310.0%     495749 ± 42%  numa-vmstat.node3.nr_file_pages
   7967855           -17.7%    6555056 ± 15%  numa-vmstat.node3.nr_free_pages
      7914 ±  4%    +254.9%      28087 ±  6%  numa-vmstat.node3.nr_inactive_file
      7570 ± 28%    +223.7%      24509 ± 36%  numa-vmstat.node3.nr_mapped
     94354 ± 21%    +280.7%     359225 ±  9%  numa-vmstat.node3.nr_shmem
     86302 ± 20%    +278.5%     326665 ±  9%  numa-vmstat.node3.nr_zone_active_anon
      7916 ±  4%    +254.8%      28086 ±  6%  numa-vmstat.node3.nr_zone_inactive_file
      8093 ±  4%    +248.1%      28171 ±  6%  numa-vmstat.node3.nr_zone_write_pending
 4.368e+09           -12.4%  3.828e+09        perf-stat.i.branch-instructions
  62313172 ±  3%     -14.0%   53571269 ±  2%  perf-stat.i.cache-misses
  1.23e+08 ±  2%      -7.5%  1.138e+08 ±  2%  perf-stat.i.cache-references
     13039 ±  3%    +425.8%      68561 ±  7%  perf-stat.i.context-switches
     22.22           +17.6%      26.14        perf-stat.i.cpi
 4.464e+11            -1.1%  4.415e+11        perf-stat.i.cpu-cycles
      1253 ± 11%    +769.8%      10902 ±  9%  perf-stat.i.cpu-migrations
      7048 ±  3%     +20.9%       8521 ±  2%  perf-stat.i.cycles-between-cache-misses
    903165 ± 29%    +120.2%    1988492 ± 11%  perf-stat.i.dTLB-load-misses
  5.24e+09           -14.4%  4.487e+09        perf-stat.i.dTLB-loads
      0.02 ± 37%      +0.0        0.03 ± 25%  perf-stat.i.dTLB-store-miss-rate%
 1.494e+09           -21.5%  1.172e+09        perf-stat.i.dTLB-stores
     91.97           -11.7       80.23        perf-stat.i.iTLB-load-miss-rate%
   8340455 ±  4%     -25.2%    6235004 ±  9%  perf-stat.i.iTLB-load-misses
    565944 ±  7%    +313.3%    2339210 ±  6%  perf-stat.i.iTLB-loads
 1.948e+10           -13.8%  1.679e+10        perf-stat.i.instructions
      0.06 ±  4%     -19.5%       0.05 ±  2%  perf-stat.i.ipc
      3.10            -1.1%       3.07        perf-stat.i.metric.GHz
      1006 ±  2%     -28.8%     716.09 ±  4%  perf-stat.i.metric.K/sec
     77.11           -14.2%      66.14        perf-stat.i.metric.M/sec
     91.04            +0.9       91.97        perf-stat.i.node-load-miss-rate%
  12487874 ±  2%     +10.0%   13732587 ±  3%  perf-stat.i.node-load-misses
     85.06            +2.2       87.26        perf-stat.i.node-store-miss-rate%
   9673418            -8.0%    8902435        perf-stat.i.node-store-misses
   1618007           -23.9%    1231200        perf-stat.i.node-stores
      6.31 ±  2%      +6.1%       6.70 ±  2%  perf-stat.overall.MPKI
      0.40 ±  2%      +0.0        0.44 ±  2%  perf-stat.overall.branch-miss-rate%
     50.71 ±  2%      -3.3       47.39        perf-stat.overall.cache-miss-rate%
     22.94           +15.2%      26.43        perf-stat.overall.cpi
      7176 ±  3%     +16.0%       8327 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.02 ± 25%      +0.0        0.04 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ± 23%      +0.0        0.03 ± 20%  perf-stat.overall.dTLB-store-miss-rate%
     93.81           -20.2       73.60 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      0.04           -13.2%       0.04        perf-stat.overall.ipc
     85.66            +2.2       87.83        perf-stat.overall.node-store-miss-rate%
 4.373e+09           -12.6%  3.821e+09        perf-stat.ps.branch-instructions
  62406854 ±  3%     -14.8%   53156258 ±  2%  perf-stat.ps.cache-misses
 1.231e+08 ±  2%      -8.9%  1.122e+08 ±  2%  perf-stat.ps.cache-references
     13029 ±  3%    +400.6%      65217 ±  7%  perf-stat.ps.context-switches
 4.473e+11            -1.1%  4.424e+11        perf-stat.ps.cpu-cycles
      1247 ± 11%    +718.0%      10208 ±  9%  perf-stat.ps.cpu-migrations
    957219 ± 25%    +103.1%    1944276 ± 10%  perf-stat.ps.dTLB-load-misses
 5.246e+09           -14.7%  4.473e+09        perf-stat.ps.dTLB-loads
 1.495e+09           -22.2%  1.163e+09        perf-stat.ps.dTLB-stores
   8350584 ±  4%     -25.5%    6222734 ±  9%  perf-stat.ps.iTLB-load-misses
    550897 ±  7%    +303.4%    2222438 ±  6%  perf-stat.ps.iTLB-loads
  1.95e+10           -14.1%  1.674e+10        perf-stat.ps.instructions
  12506886 ±  2%      +7.9%   13489702 ±  3%  perf-stat.ps.node-load-misses
   9691776            -8.7%    8848452        perf-stat.ps.node-store-misses
   1621745           -24.4%    1226078        perf-stat.ps.node-stores
 4.748e+12           +33.1%  6.318e+12        perf-stat.total.instructions
     94.68           -35.4       59.23        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     94.64           -35.4       59.21        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write
     62.29           -23.3       38.95        perf-profile.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
     61.76           -23.1       38.64        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write.__generic_file_write_iter
     61.76           -23.1       38.64        perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
     61.74           -23.1       38.63        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write
     61.49           -23.0       38.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end
     32.17           -12.0       20.14        perf-profile.calltrace.cycles-pp.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
     31.08           -11.6       19.45        perf-profile.calltrace.cycles-pp.f2fs_get_block.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
     31.03           -11.6       19.41        perf-profile.calltrace.cycles-pp.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
     31.02           -11.6       19.41        perf-profile.calltrace.cycles-pp.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin.generic_perform_write
     15.52            -5.9        9.66        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin
     15.44            -5.8        9.62        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_reserve_block
     15.45            -5.8        9.62        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block
     15.39            -5.8        9.58        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks
     15.38            -5.7        9.68        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_reserve_block
     15.38            -5.7        9.68        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block
     15.38            -5.7        9.68        perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin
     15.36            -5.7        9.66        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks
     95.40            +3.0       98.39        perf-profile.calltrace.cycles-pp.write
     95.33            +3.0       98.33        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     95.31            +3.0       98.32        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.30            +3.0       98.31        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.28            +3.0       98.30        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.24            +3.0       98.27        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     95.23            +3.0       98.27        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00           +38.5       38.49        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter
      0.00           +38.6       38.56        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter.new_sync_write
      0.00           +38.6       38.59        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00           +38.6       38.59        perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     94.69           -35.4       59.24        perf-profile.children.cycles-pp.__generic_file_write_iter
     94.66           -35.4       59.22        perf-profile.children.cycles-pp.generic_perform_write
     62.29           -23.3       38.95        perf-profile.children.cycles-pp.f2fs_write_end
     32.18           -12.0       20.14        perf-profile.children.cycles-pp.f2fs_write_begin
     31.15           -11.7       19.49        perf-profile.children.cycles-pp.f2fs_reserve_block
     31.14           -11.7       19.48        perf-profile.children.cycles-pp.f2fs_reserve_new_blocks
     31.08           -11.6       19.45        perf-profile.children.cycles-pp.f2fs_get_block
     15.78            -6.0        9.82        perf-profile.children.cycles-pp.__mark_inode_dirty
      3.04 ± 12%      -2.4        0.62 ± 26%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      2.58 ± 14%      -2.2        0.41 ± 36%  perf-profile.children.cycles-pp.osq_lock
      1.97 ± 11%      -1.5        0.50 ± 20%  perf-profile.children.cycles-pp.unlink
      1.97 ± 11%      -1.5        0.50 ± 20%  perf-profile.children.cycles-pp.__x64_sys_unlink
      1.97 ± 11%      -1.5        0.50 ± 20%  perf-profile.children.cycles-pp.do_unlinkat
      1.52 ± 10%      -1.1        0.40 ± 15%  perf-profile.children.cycles-pp.creat64
      1.52 ± 10%      -1.1        0.40 ± 15%  perf-profile.children.cycles-pp.do_filp_open
      1.52 ± 10%      -1.1        0.40 ± 15%  perf-profile.children.cycles-pp.path_openat
      1.52 ± 10%      -1.1        0.41 ± 15%  perf-profile.children.cycles-pp.do_sys_open
      1.52 ± 10%      -1.1        0.41 ± 15%  perf-profile.children.cycles-pp.do_sys_openat2
      0.45 ±  2%      -0.2        0.20 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.61 ±  3%      -0.2        0.39 ±  3%  perf-profile.children.cycles-pp.read
      0.53 ±  4%      -0.2        0.34 ±  3%  perf-profile.children.cycles-pp.ksys_read
      0.51 ±  3%      -0.2        0.33 ±  3%  perf-profile.children.cycles-pp.vfs_read
      0.47 ±  3%      -0.2        0.30 ±  2%  perf-profile.children.cycles-pp.new_sync_read
      0.46 ±  4%      -0.2        0.29 ±  3%  perf-profile.children.cycles-pp.f2fs_file_read_iter
      0.42 ±  3%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.filemap_read
      0.40            -0.1        0.25        perf-profile.children.cycles-pp.__close
      0.39            -0.1        0.25        perf-profile.children.cycles-pp.task_work_run
      0.41            -0.1        0.26        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.40            -0.1        0.26        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.39            -0.1        0.25        perf-profile.children.cycles-pp.dput
      0.39            -0.1        0.25        perf-profile.children.cycles-pp.__fput
      0.39            -0.1        0.25        perf-profile.children.cycles-pp.__dentry_kill
      0.39            -0.1        0.25        perf-profile.children.cycles-pp.f2fs_evict_inode
      0.39            -0.1        0.25        perf-profile.children.cycles-pp.evict
      0.29            -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      0.32            -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
      0.31 ±  2%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.f2fs_convert_inline_page
      0.26            -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.24 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.28 ±  5%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.filemap_get_pages
      0.26 ±  4%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.25            -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.f2fs_create
      0.26 ±  4%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.pagecache_get_page
      0.24 ±  2%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.f2fs_do_add_link
      0.24 ±  2%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.f2fs_add_dentry
      0.24 ±  2%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.f2fs_add_regular_entry
      0.27 ±  6%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.22 ±  3%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.f2fs_lookup_extent_cache
      0.18 ±  2%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.f2fs_update_dirty_page
      0.18 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.f2fs_unlink
      0.20 ±  4%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__get_node_page
      0.19 ±  3%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.f2fs_truncate
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.vfs_unlink
      0.18            -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.f2fs_inode_synced
      0.40 ±  6%      -0.1        0.33 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  6%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.36 ±  6%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.18            -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.f2fs_update_parent_metadata
      0.30 ±  7%      -0.1        0.23 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.37 ±  6%      -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.27 ±  7%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.16 ±  9%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.update_cfs_group
      0.13 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.f2fs_do_truncate_blocks
      0.13 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.f2fs_truncate_data_blocks_range
      0.12 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.12            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.f2fs_update_inode
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.xas_load
      0.06 ±  7%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.08            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.09 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.filemap_add_folio
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
     99.78            +0.1       99.86        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.77            +0.1       99.85        perf-profile.children.cycles-pp.do_syscall_64
     95.42            +3.0       98.40        perf-profile.children.cycles-pp.write
     95.30            +3.0       98.32        perf-profile.children.cycles-pp.ksys_write
     95.29            +3.0       98.30        perf-profile.children.cycles-pp.vfs_write
     95.25            +3.0       98.28        perf-profile.children.cycles-pp.new_sync_write
     95.23            +3.0       98.27        perf-profile.children.cycles-pp.f2fs_file_write_iter
     93.92            +3.4       97.33        perf-profile.children.cycles-pp._raw_spin_lock
     93.48            +3.5       97.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     93.60            +3.6       97.16        perf-profile.children.cycles-pp.f2fs_inode_dirtied
     77.91            +9.5       87.39        perf-profile.children.cycles-pp.f2fs_mark_inode_dirty_sync
      2.57 ± 14%      -2.2        0.41 ± 36%  perf-profile.self.cycles-pp.osq_lock
      0.44 ±  2%      -0.2        0.20 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.29 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.44            -0.1        0.33        perf-profile.self.cycles-pp._raw_spin_lock
      0.25 ±  7%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.19            -0.1        0.13        perf-profile.self.cycles-pp.f2fs_write_begin
      0.14 ±  7%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.f2fs_lookup_extent_cache
      0.16 ±  9%      -0.1        0.10 ± 14%  perf-profile.self.cycles-pp.update_cfs_group
      0.08 ±  5%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.f2fs_update_dirty_page
      0.12 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__get_node_page
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp._raw_read_lock
      0.16 ±  7%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.f2fs_file_write_iter
     92.94            +3.6       96.50        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.16 ± 87%     -90.4%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.85 ±103%     -99.7%       0.02 ± 98%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.06 ± 18%     -72.1%       0.02 ± 52%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.54 ± 33%     -97.9%       0.01 ± 34%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.64 ±186%     -97.5%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.22 ± 72%     -83.6%       0.04 ± 13%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±140%     -96.1%       0.01 ± 46%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2.86 ± 55%     -99.3%       0.02 ±158%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_getxattr.__f2fs_get_acl
      0.07 ± 58%    +190.8%       0.19 ± 34%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.35 ± 61%     -74.6%       0.09 ±  6%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      8.61 ± 25%     -98.0%       0.17 ±137%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_nat_entry.constprop
      4.91 ±158%     -98.5%       0.07 ± 12%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     10.70 ±  7%     -99.5%       0.05 ± 49%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.86 ± 10%     -91.0%       0.08 ± 18%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      3.41 ±194%     -93.4%       0.23 ± 34%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
      0.00 ±117%   +6386.7%       0.16 ± 46%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
      0.00 ±223%  +55000.0%       0.09 ± 13%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      0.00 ±223%   +4125.0%       0.03 ± 26%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync
      0.98 ± 96%     -96.4%       0.04 ± 17%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.40 ± 49%     -74.7%       0.10 ± 18%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      0.32 ± 17%     -88.6%       0.04 ± 28%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1.00 ± 14%     -92.4%       0.08 ± 59%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
      1.11 ±  9%     -97.4%       0.03 ± 38%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
      0.31 ±167%     -94.5%       0.02 ± 29%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.05 ± 38%     -83.9%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.02 ± 92%     -99.3%       0.00 ±223%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.07 ± 14%     -74.5%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.07 ±  2%     -70.2%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.13 ± 91%     -85.2%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      5.59 ± 98%     -99.7%       0.02 ±114%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.part.0.kmsg_read
      2.86 ± 20%     -99.3%       0.02 ± 75%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.07 ±  4%     -38.9%       0.04 ±  9%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      1.97 ±128%     -96.5%       0.07 ± 38%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.87 ±102%     -99.6%       0.02 ± 99%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.18 ± 12%     -60.3%       0.07 ± 68%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     13.10 ± 19%     -93.3%       0.88 ± 43%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    175.40 ±212%     -99.7%       0.56 ± 43%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    348.26 ±137%     -99.8%       0.72 ± 30%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      9.26 ± 43%     -87.0%       1.21 ± 28%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.f2fs_file_read_iter
     11.10 ± 49%     -99.6%       0.04 ±146%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_getxattr.__f2fs_get_acl
      9.45 ± 23%     -82.4%       1.67 ± 14%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      3966 ±  5%     -99.4%      23.21 ± 30%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
     18.16 ± 11%     -98.1%       0.34 ±137%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_nat_entry.constprop
    687.44 ±219%     -99.7%       2.05 ± 24%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     47.23 ± 19%     -97.6%       1.13 ± 37%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
     22.99 ± 97%     -91.0%       2.08 ± 18%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    690.65 ±220%     -99.6%       2.85 ± 94%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
      0.01 ±223%  +6.1e+05%      31.52 ± 18%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      0.05 ±123%   +1835.7%       1.01 ± 25%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__submit_merged_write_cond.f2fs_wait_on_page_writeback.f2fs_convert_inline_page
      0.00 ±223%  +1.1e+05%       1.23 ± 98%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync
      1256 ±140%     -99.8%       2.10 ± 45%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
      9.78 ± 20%     -85.3%       1.43 ±  9%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
     40.64 ± 78%     -95.3%       1.91 ± 25%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     19.70 ± 35%     -96.6%       0.67 ± 76%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
     26.77 ± 81%     -95.9%       1.11 ± 55%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
      2.03 ±200%     -95.5%       0.09 ± 46%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.10 ± 60%     -89.7%       0.01 ± 18%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.21 ±  3%     -33.3%       0.14 ± 34%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.59 ± 98%     -99.6%       0.02 ±100%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.part.0.kmsg_read
     19.24 ± 60%     -96.6%       0.65 ± 63%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.36 ± 51%     -75.0%       0.09 ± 12%  perf-sched.total_sch_delay.average.ms
      3968 ±  5%     -99.2%      31.62 ± 18%  perf-sched.total_sch_delay.max.ms
    174.33 ±  6%     -90.8%      15.99        perf-sched.total_wait_and_delay.average.ms
    125363 ±  5%   +1515.1%    2024743        perf-sched.total_wait_and_delay.count.ms
    173.97 ±  6%     -90.9%      15.90        perf-sched.total_wait_time.average.ms
    226.65 ±  2%     -32.6%     152.83 ± 13%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     39.90 ± 29%    +159.1%     103.40 ± 62%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    375.82 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.f2fs_drop_nlink.f2fs_unlink
    274.64 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.__x64_sys_unlink
    162.15 ± 11%     -91.0%      14.67 ±  2%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      1079 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      6.64 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
    456.33 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    818.49 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
     19.96 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
    691.67 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1141 ± 60%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
     79.17 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    617.75 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
     15.65 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
      4.65          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    607.44 ±  2%     -31.1%     418.23 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      4093 ± 43%    +687.5%      32234 ±  6%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4147 ± 42%     -55.0%       1864 ± 30%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
     39.17 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.f2fs_drop_nlink.f2fs_unlink
    175.33 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.do_unlinkat.__x64_sys_unlink
     93296 ±  8%     -50.3%      46324 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
    168.50 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      1343 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
    388.83 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    150.00 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
      1785 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
     29.67 ±223%  +6.5e+06%    1918472 ±  2%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      1975 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
    124.67 ± 56%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      5226 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     94.00 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
      1676 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
      2177          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3150 ±  3%     +21.0%       3813 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      3045 ± 34%     -67.1%       1000        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4155 ±  2%     -99.0%      41.14 ± 12%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1254 ±  2%     -17.0%       1041        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      4055 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.f2fs_drop_nlink.f2fs_unlink
      4156 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.__x64_sys_unlink
      4713 ± 21%     -99.2%      38.66 ± 31%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      4219 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      1002          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      4230 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      4207 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
      3391 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
      4274 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3922 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      4225 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      4203 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
    787.44 ±200%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
      5.42          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.81 ±100%    +110.3%       1.70 ±  4%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    226.11 ±  2%     -32.4%     152.82 ± 13%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     53.90 ± 24%     -71.9%      15.12 ± 28%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    112.48 ± 63%     -88.2%      13.32 ±  5%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     39.75 ± 30%    +160.1%     103.39 ± 62%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    148.34 ± 35%     -90.1%      14.71 ±  2%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio
     96.54 ± 41%     -85.8%      13.67        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__filemap_get_folio.pagecache_get_page.__get_node_page
    194.05 ± 14%     -93.0%      13.67 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
     15.14 ±  8%     -25.6%      11.26 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__invalidate_mapping_pages.truncate_node.f2fs_remove_inode_page
    159.26 ± 30%     -90.9%      14.47 ±  2%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.f2fs_file_read_iter
    433.64 ±135%     -97.1%      12.45 ± 82%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
    188.13 ± 35%     -93.7%      11.85 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.__submit_merged_write_cond.f2fs_wait_on_page_writeback
    277.46 ± 35%     -95.1%      13.48 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_get_node_info.f2fs_convert_inline_page
     12.47 ± 22%     -74.3%       3.21 ±141%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_getxattr.__f2fs_get_acl
    528.68 ±151%     -99.0%       5.18 ±133%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_unlink.vfs_unlink
    186.00 ± 22%     -92.2%      14.59 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_write_begin.generic_perform_write
    375.67 ± 36%     -96.9%      11.75 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.f2fs_drop_nlink.f2fs_unlink
    156.96 ± 63%     -90.9%      14.36 ±  2%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.f2fs_file_write_iter.new_sync_write
      4.43 ± 13%     -91.5%       0.38 ±146%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
    271.05 ± 23%     -96.5%       9.44 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.__x64_sys_unlink
     89.30 ± 47%     -86.8%      11.75 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
    167.73 ± 55%     -91.7%      13.95 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.f2fs_file_read_iter.new_sync_read
    161.80 ± 10%     -91.0%      14.58 ±  2%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
    585.90 ± 64%     -98.3%      10.19 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
    164.56 ± 47%     -93.0%      11.60 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__add_ino_entry.f2fs_add_orphan_inode
     64.17 ±174%     -88.5%       7.40 ± 58%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_nat_entry.constprop
    966.48 ±145%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.f2fs_build_free_nids.f2fs_balance_fs_bg
    240.61 ± 49%     -95.9%       9.89 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      1074 ± 16%     -98.8%      12.85        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
    105.36 ± 85%     -88.1%      12.55 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      6.64 ±  4%     -13.2%       5.77 ±  2%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
    455.47 ± 14%     -97.1%      13.29 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.00 ±223%  +1.2e+06%      14.02        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.f2fs_do_truncate_blocks.f2fs_truncate.f2fs_evict_inode
      1.96 ±223%    +436.4%      10.52 ± 34%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.f2fs_evict_inode.evict.__dentry_kill
    815.08 ± 31%     -99.1%       6.95 ±  5%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
     19.96 ± 30%     -61.6%       7.66 ±  7%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
      0.00 ±223%  +1.1e+05%       5.30 ±  3%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync
    690.69 ± 11%     -99.5%       3.14 ± 17%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1140 ± 60%     -99.4%       7.01 ±  5%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
     78.85 ±  5%     -96.6%       2.71 ±  6%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    616.75 ±  7%     -98.1%      11.80 ±  3%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
     14.54 ± 10%     -84.8%       2.20 ± 10%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
     63.82 ±  8%     -77.4%      14.45 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      3.16 ± 36%     -87.4%       0.40 ± 72%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      4.58           -14.4%       3.93        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±223%   +5360.0%       0.14 ± 41%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
    607.31 ±  2%     -31.1%     418.21 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.46 ± 17%     -98.7%       0.02 ± 73%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1.61 ±100%    +110.3%       3.39 ±  4%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3045 ± 34%     -67.2%       1000        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3269 ± 44%     -99.5%      15.50 ±  3%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.75 ±155%    +617.4%      26.87 ± 57%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      4155 ±  2%     -99.3%      30.92 ± 24%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1254 ±  2%     -17.0%       1041        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      3909 ±  3%     -99.6%      16.33 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio
      4072 ±  4%     -99.6%      17.93 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__filemap_get_folio.pagecache_get_page.__get_node_page
      4130 ±  2%     -99.6%      16.33 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
     45.57 ± 22%     -64.7%      16.08 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__invalidate_mapping_pages.truncate_node.f2fs_remove_inode_page
      4128 ±  4%     -99.6%      16.32 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.f2fs_file_read_iter
      3883 ±  3%     -99.6%      15.85 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.__submit_merged_write_cond.f2fs_wait_on_page_writeback
     37.90 ± 22%     -56.2%      16.60 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_evict_inode.evict
      4057 ±  4%     -99.6%      16.11 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_get_node_info.f2fs_convert_inline_page
     20.56 ± 16%     -74.2%       5.30 ±140%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_getxattr.__f2fs_get_acl
      1364 ±140%     -99.6%       5.18 ±133%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_unlink.vfs_unlink
      4109 ±  3%     -99.6%      15.96        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.f2fs_write_begin.generic_perform_write
      4054 ±  4%     -99.6%      15.96 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.f2fs_drop_nlink.f2fs_unlink
      4001 ±  6%     -99.6%      16.21 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.f2fs_file_write_iter.new_sync_write
     21.79 ± 11%     -83.3%       3.65 ±160%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      4156 ±  4%     -99.6%      18.65 ± 21%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.__x64_sys_unlink
      4102 ±  5%     -99.6%      16.85 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      4004 ±  7%     -99.6%      16.49 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.f2fs_file_read_iter.new_sync_read
      4285 ±  3%     -99.4%      26.93 ± 21%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      3224 ± 44%     -99.5%      16.99 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__add_ino_entry.f2fs_add_orphan_inode
    767.10 ±216%     -98.3%      12.95 ± 44%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_nat_entry.constprop
      1326 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.f2fs_build_free_nids.f2fs_balance_fs_bg
      2.09 ±218%   +1554.5%      34.55 ± 44%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
      3909 ±  7%     -99.6%      16.64 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      1297 ±138%     -98.8%      15.88 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
      4216 ±  3%     -99.2%      32.99 ± 19%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
    732.06 ±209%     -97.8%      16.19 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.f2fs_evict_inode.evict
      2115 ± 96%     -98.8%      24.82 ± 41%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      4228 ±  3%     -95.5%     189.67 ±191%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      3292 ± 44%     -99.5%      17.11 ±  2%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_wait_on_page_writeback.f2fs_convert_inline_page
      0.00 ±223%  +7.3e+05%      18.13 ±  3%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.f2fs_do_truncate_blocks.f2fs_truncate.f2fs_evict_inode
      1.96 ±223%    +699.0%      15.68 ±  2%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.f2fs_evict_inode.evict.__dentry_kill
      4204 ±  4%     -99.6%      18.38 ± 13%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_convert_inline_page.f2fs_convert_inline_inode
      3389 ± 44%     -99.5%      17.36        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.f2fs_get_node_info.truncate_node.f2fs_remove_inode_page
      0.02 ±223%  +69711.4%      15.36 ±  2%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync
      4272 ±  3%     -99.4%      27.57 ± 27%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3919 ±  5%     -99.6%      16.94 ±  3%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      4221 ±  3%     -99.4%      23.69 ± 32%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      4202 ±  4%     -99.6%      17.16 ±  5%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.set_node_addr.f2fs_new_node_page.f2fs_new_inode_page
    783.28 ±201%     -98.0%      15.67 ±  4%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.set_node_addr.truncate_node.f2fs_remove_inode_page
      3.16 ± 36%     -87.4%       0.40 ± 72%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      5.20          +206.7%      15.95 ± 49%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±223%  +22853.3%       0.57 ± 34%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
     10.65 ± 29%     -91.9%       0.87 ± 77%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
     10815 ±  7%     +75.0%      18927 ±  5%  softirqs.CPU0.RCU
     12622 ±  7%    +125.4%      28452 ±  8%  softirqs.CPU0.SCHED
      8626 ± 13%    +101.7%      17398 ±  4%  softirqs.CPU1.RCU
      9883 ± 12%    +151.8%      24890 ±  7%  softirqs.CPU1.SCHED
      8171 ±  8%    +110.5%      17200 ±  5%  softirqs.CPU10.RCU
      7984 ±  8%    +198.5%      23832 ±  8%  softirqs.CPU10.SCHED
      7374 ±  7%    +150.5%      18472 ±  7%  softirqs.CPU100.RCU
      7018 ±  4%    +236.7%      23633 ±  9%  softirqs.CPU100.SCHED
      7413 ±  8%    +150.2%      18551 ±  7%  softirqs.CPU101.RCU
      6968 ±  4%    +240.8%      23748 ±  8%  softirqs.CPU101.SCHED
      7340 ±  5%    +156.1%      18799 ±  9%  softirqs.CPU102.RCU
      7126 ±  5%    +235.2%      23889 ±  9%  softirqs.CPU102.SCHED
      7206 ±  4%    +162.1%      18890 ±  9%  softirqs.CPU103.RCU
      7009 ±  4%    +239.7%      23809 ±  9%  softirqs.CPU103.SCHED
      7100 ±  3%    +165.9%      18879 ±  7%  softirqs.CPU104.RCU
      7007 ±  5%    +238.2%      23702 ±  9%  softirqs.CPU104.SCHED
      7139 ±  3%    +165.4%      18948 ±  7%  softirqs.CPU105.RCU
      6958 ±  3%    +242.5%      23831 ±  9%  softirqs.CPU105.SCHED
      7339 ±  5%    +156.2%      18803 ±  6%  softirqs.CPU106.RCU
      7021 ±  5%    +235.1%      23530 ±  8%  softirqs.CPU106.SCHED
      7745 ± 13%    +143.8%      18885 ±  7%  softirqs.CPU107.RCU
      7877 ± 16%    +215.8%      24878 ± 12%  softirqs.CPU107.SCHED
      6032 ±  5%    +162.7%      15850 ±  7%  softirqs.CPU108.RCU
      6971 ±  6%    +238.8%      23620 ±  9%  softirqs.CPU108.SCHED
      6203 ±  7%    +144.2%      15148 ±  6%  softirqs.CPU109.RCU
      7302 ±  9%    +223.4%      23616 ±  9%  softirqs.CPU109.SCHED
      8270 ±  8%    +126.1%      18702 ±  7%  softirqs.CPU11.RCU
      7439 ±  7%    +241.6%      25410 ± 11%  softirqs.CPU11.SCHED
      6065 ±  5%    +147.6%      15020 ±  6%  softirqs.CPU110.RCU
      6857 ± 12%    +243.6%      23565 ±  9%  softirqs.CPU110.SCHED
      6014 ±  5%    +158.0%      15519 ±  4%  softirqs.CPU111.RCU
      7015 ±  6%    +237.0%      23643 ±  8%  softirqs.CPU111.SCHED
      7635 ±  9%    +139.0%      18249 ±  8%  softirqs.CPU112.RCU
      6969 ±  4%    +240.0%      23694 ± 10%  softirqs.CPU112.SCHED
      7341 ±  2%    +156.3%      18815 ±  7%  softirqs.CPU113.RCU
      6881 ±  7%    +245.2%      23751 ±  9%  softirqs.CPU113.SCHED
      7364          +155.5%      18813 ±  8%  softirqs.CPU114.RCU
      7038 ±  6%    +234.8%      23569 ±  9%  softirqs.CPU114.SCHED
      7295 ±  4%    +150.6%      18283 ± 11%  softirqs.CPU115.RCU
      7022 ±  6%    +235.9%      23588 ±  9%  softirqs.CPU115.SCHED
      7437 ±  2%    +150.6%      18636 ±  7%  softirqs.CPU116.RCU
      7108 ±  7%    +232.8%      23655 ±  8%  softirqs.CPU116.SCHED
      7306 ±  2%    +155.6%      18674 ±  8%  softirqs.CPU117.RCU
      7077 ±  7%    +232.9%      23561 ±  9%  softirqs.CPU117.SCHED
      7401          +149.9%      18498 ±  7%  softirqs.CPU118.RCU
      7331 ± 11%    +223.2%      23697 ±  8%  softirqs.CPU118.SCHED
      7300 ±  2%    +155.6%      18661 ±  7%  softirqs.CPU119.RCU
      7040 ±  6%    +236.0%      23657 ±  9%  softirqs.CPU119.SCHED
      8881 ± 13%    +120.1%      19543 ± 15%  softirqs.CPU12.RCU
      8651 ± 19%    +177.6%      24016 ±  7%  softirqs.CPU12.SCHED
      7347 ±  3%    +152.3%      18541 ±  8%  softirqs.CPU120.RCU
      7111 ±  6%    +233.3%      23699 ±  9%  softirqs.CPU120.SCHED
      8354 ± 18%    +121.8%      18529 ±  7%  softirqs.CPU121.RCU
      6872 ±  4%    +245.7%      23759 ±  8%  softirqs.CPU121.SCHED
      7318 ±  6%    +153.8%      18570 ±  7%  softirqs.CPU122.RCU
      7038 ±  7%    +235.9%      23642 ±  9%  softirqs.CPU122.SCHED
      7418 ±  6%    +152.8%      18758 ±  6%  softirqs.CPU123.RCU
      7122 ±  7%    +234.4%      23819 ± 10%  softirqs.CPU123.SCHED
      7279 ±  3%    +155.2%      18574 ±  7%  softirqs.CPU124.RCU
      7001 ±  5%    +236.5%      23560 ±  9%  softirqs.CPU124.SCHED
      7619 ± 10%    +142.5%      18479 ±  6%  softirqs.CPU125.RCU
      7293 ± 23%    +232.4%      24245 ±  6%  softirqs.CPU125.SCHED
      5313 ±  5%    +156.7%      13641 ±  4%  softirqs.CPU126.RCU
      6947 ±  3%    +238.1%      23492 ±  9%  softirqs.CPU126.SCHED
      5554 ± 13%    +145.1%      13613 ±  4%  softirqs.CPU127.RCU
      7076 ±  4%    +231.2%      23441 ±  8%  softirqs.CPU127.SCHED
      7414 ± 15%    +127.4%      16863 ±  4%  softirqs.CPU128.RCU
      7113 ±  4%    +226.5%      23229 ±  9%  softirqs.CPU128.SCHED
      6822 ±  6%    +152.0%      17195 ±  4%  softirqs.CPU129.RCU
      6907 ±  4%    +243.6%      23730 ±  8%  softirqs.CPU129.SCHED
      7912 ± 10%    +126.8%      17947 ±  6%  softirqs.CPU13.RCU
      7374 ±  7%    +226.0%      24042 ±  7%  softirqs.CPU13.SCHED
      7122 ± 10%    +137.3%      16899 ±  4%  softirqs.CPU130.RCU
      6981 ±  3%    +234.3%      23335 ± 10%  softirqs.CPU130.SCHED
      7111 ± 10%    +141.1%      17145 ±  4%  softirqs.CPU131.RCU
      6993 ±  4%    +236.9%      23563 ± 10%  softirqs.CPU131.SCHED
      6976 ±  6%    +140.6%      16788 ±  4%  softirqs.CPU132.RCU
      6974 ±  4%    +237.5%      23543 ±  8%  softirqs.CPU132.SCHED
      7088 ±  6%    +139.5%      16974 ±  3%  softirqs.CPU133.RCU
      7051 ±  3%    +233.9%      23546 ±  8%  softirqs.CPU133.SCHED
      7095 ± 11%    +138.9%      16952 ±  4%  softirqs.CPU134.RCU
      7257 ± 10%    +224.5%      23548 ±  8%  softirqs.CPU134.SCHED
      6911 ±  5%    +147.8%      17126 ±  3%  softirqs.CPU135.RCU
      7030 ±  3%    +241.0%      23971 ±  9%  softirqs.CPU135.SCHED
      6996 ±  5%    +141.1%      16869 ±  4%  softirqs.CPU136.RCU
      7070 ±  3%    +232.2%      23491 ±  8%  softirqs.CPU136.SCHED
      7047 ±  6%    +138.4%      16799 ±  4%  softirqs.CPU137.RCU
      6998 ±  5%    +234.8%      23431 ±  9%  softirqs.CPU137.SCHED
      6901 ±  6%    +153.5%      17492 ± 11%  softirqs.CPU138.RCU
      7036 ±  4%    +235.3%      23591 ±  9%  softirqs.CPU138.SCHED
      7007 ±  6%    +141.2%      16905 ±  3%  softirqs.CPU139.RCU
      7077 ±  3%    +233.0%      23568 ±  8%  softirqs.CPU139.SCHED
      7657 ±  8%    +125.6%      17272 ±  7%  softirqs.CPU14.RCU
      7596 ±  9%    +211.7%      23676 ±  8%  softirqs.CPU14.SCHED
      6971 ±  8%    +142.8%      16927 ±  3%  softirqs.CPU140.RCU
      7455 ± 13%    +216.3%      23580 ±  8%  softirqs.CPU140.SCHED
      7003 ±  6%    +138.2%      16681 ±  5%  softirqs.CPU141.RCU
      7055 ±  4%    +232.3%      23447 ±  8%  softirqs.CPU141.SCHED
      6841 ±  6%    +150.5%      17134 ±  4%  softirqs.CPU142.RCU
      7045 ±  4%    +238.1%      23823 ±  9%  softirqs.CPU142.SCHED
      6916 ±  4%    +146.1%      17022 ±  3%  softirqs.CPU143.RCU
      6635 ±  6%    +247.5%      23056 ±  8%  softirqs.CPU143.SCHED
      9055 ± 17%     +91.7%      17362 ±  5%  softirqs.CPU15.RCU
      7529 ±  8%    +214.9%      23708 ±  8%  softirqs.CPU15.SCHED
      6375 ± 11%    +125.6%      14385 ±  8%  softirqs.CPU16.RCU
      7352 ±  5%    +222.4%      23699 ±  9%  softirqs.CPU16.SCHED
      6021 ±  2%    +138.4%      14358 ±  7%  softirqs.CPU17.RCU
      7199 ±  5%    +230.7%      23808 ±  8%  softirqs.CPU17.SCHED
      7547 ±  3%    +152.9%      19085 ±  7%  softirqs.CPU18.RCU
      7469 ± 12%    +220.0%      23903 ±  9%  softirqs.CPU18.SCHED
      7405 ±  3%    +156.1%      18965 ±  7%  softirqs.CPU19.RCU
      6945 ±  8%    +243.2%      23840 ±  9%  softirqs.CPU19.SCHED
      8323 ±  9%    +111.6%      17609 ±  6%  softirqs.CPU2.RCU
      7990 ±  8%    +205.1%      24379 ±  9%  softirqs.CPU2.SCHED
      7603 ±  3%    +148.0%      18861 ±  6%  softirqs.CPU20.RCU
      7076 ±  4%    +233.0%      23565 ±  8%  softirqs.CPU20.SCHED
      7536 ±  4%    +149.0%      18763 ±  6%  softirqs.CPU21.RCU
      6956 ±  4%    +242.3%      23811 ±  8%  softirqs.CPU21.SCHED
      7603 ±  4%    +151.3%      19104 ±  6%  softirqs.CPU22.RCU
      7005 ±  4%    +239.4%      23774 ±  8%  softirqs.CPU22.SCHED
      7815 ±  7%    +148.3%      19406 ±  7%  softirqs.CPU23.RCU
      6980 ±  4%    +240.3%      23752 ±  8%  softirqs.CPU23.SCHED
      7503 ±  3%    +153.4%      19012 ±  9%  softirqs.CPU24.RCU
      6976 ±  4%    +242.5%      23891 ±  9%  softirqs.CPU24.SCHED
      7936 ±  7%    +138.8%      18955 ±  7%  softirqs.CPU25.RCU
      7154 ±  6%    +233.1%      23832 ±  9%  softirqs.CPU25.SCHED
      7663 ±  4%    +147.7%      18984 ±  7%  softirqs.CPU26.RCU
      7036 ±  4%    +238.2%      23793 ±  8%  softirqs.CPU26.SCHED
      7585 ±  3%    +149.5%      18929 ±  7%  softirqs.CPU27.RCU
      7018 ±  4%    +242.7%      24050 ± 10%  softirqs.CPU27.SCHED
      7643 ±  3%    +149.7%      19084 ±  8%  softirqs.CPU28.RCU
      6952 ±  3%    +243.2%      23859 ±  9%  softirqs.CPU28.SCHED
      7751 ±  7%    +147.1%      19155 ±  9%  softirqs.CPU29.RCU
      6893 ±  8%    +248.0%      23991 ±  9%  softirqs.CPU29.SCHED
      7684 ±  7%    +125.5%      17326 ±  7%  softirqs.CPU3.RCU
      7587 ±  6%    +212.2%      23691 ±  8%  softirqs.CPU3.SCHED
      7667 ±  4%    +148.4%      19044 ± 10%  softirqs.CPU30.RCU
      7012 ±  4%    +241.5%      23945 ±  9%  softirqs.CPU30.SCHED
      7625 ±  3%    +151.3%      19163 ±  8%  softirqs.CPU31.RCU
      7049 ±  5%    +235.9%      23676 ±  8%  softirqs.CPU31.SCHED
      6267 ±  5%    +152.3%      15810 ± 10%  softirqs.CPU32.RCU
      6983 ±  4%    +240.3%      23763 ±  8%  softirqs.CPU32.SCHED
      6379 ±  7%    +148.2%      15831 ±  8%  softirqs.CPU33.RCU
      7070 ±  5%    +238.0%      23901 ±  9%  softirqs.CPU33.SCHED
      6283 ±  3%    +154.8%      16014 ±  9%  softirqs.CPU34.RCU
      6955 ±  4%    +245.2%      24012 ± 10%  softirqs.CPU34.SCHED
      6348 ±  5%    +152.1%      16002 ±  8%  softirqs.CPU35.RCU
      7025 ±  4%    +245.7%      24285 ±  9%  softirqs.CPU35.SCHED
      7711 ±  5%    +138.3%      18373 ±  7%  softirqs.CPU36.RCU
      6930 ±  5%    +239.2%      23506 ±  8%  softirqs.CPU36.SCHED
      7671 ±  3%    +138.1%      18266 ±  7%  softirqs.CPU37.RCU
      7109 ±  7%    +237.6%      24000 ±  8%  softirqs.CPU37.SCHED
      7452 ±  3%    +142.6%      18081 ±  7%  softirqs.CPU38.RCU
      6928 ±  7%    +244.6%      23875 ±  8%  softirqs.CPU38.SCHED
      8280 ± 16%    +127.0%      18799 ±  6%  softirqs.CPU39.RCU
      7003 ±  5%    +247.4%      24332 ±  8%  softirqs.CPU39.SCHED
      7541 ±  9%    +136.1%      17804 ±  6%  softirqs.CPU4.RCU
      7236 ±  4%    +229.4%      23835 ±  8%  softirqs.CPU4.SCHED
      8123 ± 15%    +123.9%      18190 ± 10%  softirqs.CPU40.RCU
      6932 ±  4%    +246.6%      24026 ±  9%  softirqs.CPU40.SCHED
      7735 ±  8%    +136.8%      18317 ±  7%  softirqs.CPU41.RCU
      7111 ±  7%    +233.6%      23722 ±  9%  softirqs.CPU41.SCHED
      7462 ±  2%    +147.5%      18466 ±  7%  softirqs.CPU42.RCU
      7114 ±  6%    +237.0%      23979 ±  9%  softirqs.CPU42.SCHED
      7477 ±  2%    +144.6%      18292 ±  8%  softirqs.CPU43.RCU
      7080 ±  5%    +236.4%      23815 ±  9%  softirqs.CPU43.SCHED
      7580 ±  2%    +144.7%      18546 ±  7%  softirqs.CPU44.RCU
      7048 ±  5%    +238.8%      23877 ±  9%  softirqs.CPU44.SCHED
      7373 ±  3%    +148.8%      18343 ±  7%  softirqs.CPU45.RCU
      6959 ±  4%    +243.8%      23928 ±  8%  softirqs.CPU45.SCHED
      7679 ±  5%    +138.3%      18297 ±  7%  softirqs.CPU46.RCU
      7037 ±  6%    +237.9%      23782 ±  9%  softirqs.CPU46.SCHED
      7521 ±  2%    +148.2%      18664 ±  6%  softirqs.CPU47.RCU
      7028 ±  6%    +239.8%      23886 ±  9%  softirqs.CPU47.SCHED
      6951 ±  4%    +143.4%      16918 ±  7%  softirqs.CPU48.RCU
      7081 ±  5%    +235.0%      23724 ±  9%  softirqs.CPU48.SCHED
      7224 ±  9%    +137.5%      17159 ±  7%  softirqs.CPU49.RCU
      7211 ±  8%    +231.9%      23935 ±  7%  softirqs.CPU49.SCHED
      7993 ± 13%    +118.1%      17438 ±  5%  softirqs.CPU5.RCU
      7338 ±  4%    +229.2%      24154 ±  7%  softirqs.CPU5.SCHED
      6685 ±  2%    +147.8%      16569 ±  7%  softirqs.CPU50.RCU
      6994 ±  5%    +239.6%      23751 ±  8%  softirqs.CPU50.SCHED
      6915 ±  4%    +143.2%      16821 ±  7%  softirqs.CPU51.RCU
      7008 ±  5%    +236.8%      23605 ±  9%  softirqs.CPU51.SCHED
      6976 ±  4%    +143.3%      16970 ±  7%  softirqs.CPU52.RCU
      7033 ±  6%    +232.9%      23415 ± 10%  softirqs.CPU52.SCHED
      6957 ±  6%    +144.1%      16981 ±  7%  softirqs.CPU53.RCU
      7009 ±  6%    +240.3%      23852 ±  8%  softirqs.CPU53.SCHED
      7206 ±  6%    +135.5%      16971 ±  4%  softirqs.CPU54.RCU
      7143 ±  3%    +228.0%      23431 ±  9%  softirqs.CPU54.SCHED
      7055 ±  3%    +143.1%      17152 ±  4%  softirqs.CPU55.RCU
      7268 ± 12%    +218.2%      23126 ± 10%  softirqs.CPU55.SCHED
      6974 ±  4%    +145.9%      17149 ±  4%  softirqs.CPU56.RCU
      6974 ±  4%    +239.0%      23644 ±  8%  softirqs.CPU56.SCHED
      7307 ±  7%    +135.0%      17171 ±  4%  softirqs.CPU57.RCU
      7077 ±  4%    +232.8%      23555 ±  8%  softirqs.CPU57.SCHED
      7012 ±  4%    +148.6%      17432 ±  4%  softirqs.CPU58.RCU
      6992 ±  3%    +235.4%      23452 ±  8%  softirqs.CPU58.SCHED
      7011 ±  8%    +142.9%      17029 ±  5%  softirqs.CPU59.RCU
      6979 ±  4%    +236.4%      23478 ±  9%  softirqs.CPU59.SCHED
      7519 ±  5%    +129.5%      17255 ±  5%  softirqs.CPU6.RCU
      7198 ±  5%    +226.2%      23479 ±  9%  softirqs.CPU6.SCHED
      6924 ±  4%    +149.2%      17253 ±  4%  softirqs.CPU60.RCU
      6984 ±  3%    +238.3%      23628 ±  9%  softirqs.CPU60.SCHED
      7311 ±  6%    +141.1%      17623 ±  4%  softirqs.CPU61.RCU
      7254 ± 10%    +223.4%      23458 ±  8%  softirqs.CPU61.SCHED
      7365 ±  8%    +137.6%      17496 ±  4%  softirqs.CPU62.RCU
      7073 ±  3%    +233.8%      23614 ±  8%  softirqs.CPU62.SCHED
      7169 ± 10%    +137.2%      17007 ±  4%  softirqs.CPU63.RCU
      7141 ±  3%    +226.7%      23331 ± 10%  softirqs.CPU63.SCHED
      6942 ±  5%    +136.6%      16427 ±  4%  softirqs.CPU64.RCU
      7338 ±  8%    +221.8%      23617 ±  8%  softirqs.CPU64.SCHED
      6722 ±  2%    +145.5%      16504 ±  4%  softirqs.CPU65.RCU
      6997 ±  4%    +236.6%      23552 ±  8%  softirqs.CPU65.SCHED
      7092 ±  7%    +135.1%      16673 ±  4%  softirqs.CPU66.RCU
      7137 ±  4%    +229.5%      23521 ±  9%  softirqs.CPU66.SCHED
      7049 ±  9%    +137.0%      16708 ±  4%  softirqs.CPU67.RCU
      6987 ±  4%    +241.8%      23887 ± 10%  softirqs.CPU67.SCHED
      6846 ±  4%    +143.9%      16695 ±  4%  softirqs.CPU68.RCU
      7191 ±  4%    +229.1%      23666 ±  8%  softirqs.CPU68.SCHED
      6809 ±  6%    +138.5%      16237 ±  5%  softirqs.CPU69.RCU
      6984 ±  3%    +235.4%      23426 ±  9%  softirqs.CPU69.SCHED
      7592 ±  7%    +129.3%      17406 ±  7%  softirqs.CPU7.RCU
      7198 ±  3%    +226.9%      23529 ±  7%  softirqs.CPU7.SCHED
      6869 ±  4%    +139.2%      16434 ±  4%  softirqs.CPU70.RCU
      7063 ±  3%    +235.0%      23661 ±  8%  softirqs.CPU70.SCHED
      6903 ±  6%    +140.4%      16594 ±  4%  softirqs.CPU71.RCU
      7067 ±  3%    +232.9%      23528 ±  8%  softirqs.CPU71.SCHED
      7060 ±  4%    +139.3%      16895 ±  8%  softirqs.CPU72.RCU
      6673 ± 10%    +251.9%      23484 ±  9%  softirqs.CPU72.SCHED
      6712 ±  6%    +152.2%      16930 ±  7%  softirqs.CPU73.RCU
      7038 ±  5%    +239.0%      23862 ±  9%  softirqs.CPU73.SCHED
      6858 ±  4%    +151.0%      17218 ±  6%  softirqs.CPU74.RCU
      6761 ± 13%    +250.1%      23672 ±  8%  softirqs.CPU74.SCHED
      7050 ±  4%    +145.5%      17311 ±  6%  softirqs.CPU75.RCU
      7119 ±  5%    +232.1%      23640 ±  8%  softirqs.CPU75.SCHED
      7115 ±  6%    +140.1%      17088 ±  6%  softirqs.CPU76.RCU
      7207 ±  5%    +221.1%      23142 ±  9%  softirqs.CPU76.SCHED
      7311 ±  7%    +135.4%      17210 ±  6%  softirqs.CPU77.RCU
      7264 ± 12%    +231.6%      24086 ± 10%  softirqs.CPU77.SCHED
      6991 ±  3%    +143.4%      17016 ±  6%  softirqs.CPU78.RCU
      6384 ± 10%    +269.7%      23603 ±  9%  softirqs.CPU78.SCHED
      6827 ±  4%    +148.5%      16965 ±  5%  softirqs.CPU79.RCU
      7175 ±  5%    +229.4%      23636 ±  8%  softirqs.CPU79.SCHED
      7790 ±  4%    +132.3%      18093 ±  8%  softirqs.CPU8.RCU
      7776 ± 10%    +204.8%      23700 ±  9%  softirqs.CPU8.SCHED
      7173 ±  8%    +147.9%      17782 ±  5%  softirqs.CPU80.RCU
      7024 ±  5%    +236.4%      23629 ±  8%  softirqs.CPU80.SCHED
      6849 ±  7%    +159.8%      17796 ±  6%  softirqs.CPU81.RCU
      7089 ±  5%    +235.3%      23768 ±  8%  softirqs.CPU81.SCHED
      7285 ±  4%    +143.7%      17755 ±  6%  softirqs.CPU82.RCU
      7120 ±  4%    +232.0%      23640 ±  8%  softirqs.CPU82.SCHED
      7064 ±  4%    +149.7%      17643 ±  5%  softirqs.CPU83.RCU
      7046 ±  4%    +233.3%      23485 ±  8%  softirqs.CPU83.SCHED
      7375 ±  7%    +140.9%      17770 ±  7%  softirqs.CPU84.RCU
      7171 ±  4%    +230.9%      23729 ±  8%  softirqs.CPU84.SCHED
      7274 ±  9%    +142.5%      17640 ±  5%  softirqs.CPU85.RCU
      7155 ±  5%    +229.2%      23553 ±  8%  softirqs.CPU85.SCHED
      8084 ± 21%    +124.9%      18179 ±  7%  softirqs.CPU86.RCU
      7262 ±  4%    +226.1%      23683 ±  8%  softirqs.CPU86.SCHED
      7756 ± 10%    +130.7%      17892 ±  6%  softirqs.CPU87.RCU
      7348 ±  5%    +222.1%      23666 ±  8%  softirqs.CPU87.SCHED
      7336 ±  4%    +146.4%      18076 ±  7%  softirqs.CPU88.RCU
      7183 ±  4%    +230.0%      23702 ±  8%  softirqs.CPU88.SCHED
      7696 ±  9%    +142.6%      18670 ±  8%  softirqs.CPU89.RCU
      7821 ±  9%    +205.4%      23884 ±  7%  softirqs.CPU89.SCHED
     10128 ± 18%     +75.5%      17773 ±  8%  softirqs.CPU9.RCU
     10395 ± 17%    +130.4%      23951 ±  7%  softirqs.CPU9.SCHED
      6410 ±  2%    +171.3%      17394 ± 10%  softirqs.CPU90.RCU
      6999 ±  4%    +240.6%      23839 ±  9%  softirqs.CPU90.SCHED
      6715 ± 11%    +154.3%      17077 ± 10%  softirqs.CPU91.RCU
      7277 ±  7%    +223.5%      23546 ±  8%  softirqs.CPU91.SCHED
      6445 ±  2%    +162.1%      16895 ±  8%  softirqs.CPU92.RCU
      6858 ±  4%    +247.1%      23806 ±  9%  softirqs.CPU92.SCHED
      6511 ±  2%    +156.4%      16697 ±  7%  softirqs.CPU93.RCU
      6897 ±  4%    +244.0%      23724 ±  8%  softirqs.CPU93.SCHED
      6447          +163.8%      17008 ±  7%  softirqs.CPU94.RCU
      7024 ±  4%    +236.4%      23633 ±  8%  softirqs.CPU94.SCHED
      6573 ±  4%    +155.3%      16785 ±  8%  softirqs.CPU95.RCU
      7115 ±  5%    +233.9%      23761 ±  8%  softirqs.CPU95.SCHED
      7281 ±  4%    +155.0%      18568 ±  9%  softirqs.CPU96.RCU
      7036 ±  4%    +237.7%      23762 ±  9%  softirqs.CPU96.SCHED
      7311 ±  5%    +158.7%      18918 ±  6%  softirqs.CPU97.RCU
      6970 ±  3%    +244.0%      23979 ±  9%  softirqs.CPU97.SCHED
      7275 ±  5%    +155.6%      18594 ±  7%  softirqs.CPU98.RCU
      6978 ±  4%    +241.9%      23857 ±  9%  softirqs.CPU98.SCHED
      7223 ±  3%    +158.7%      18690 ±  8%  softirqs.CPU99.RCU
      6980 ±  3%    +240.0%      23734 ±  8%  softirqs.CPU99.SCHED
   1047424 ±  3%    +141.9%    2534003 ±  5%  softirqs.RCU
   1035968 ±  4%    +230.4%    3422827 ±  8%  softirqs.SCHED
     62978 ±  3%     +39.5%      87842 ±  2%  softirqs.TIMER
    445184 ± 17%    +827.6%    4129649 ± 13%  interrupts.CAL:Function_call_interrupts
      3492 ± 31%    +739.6%      29320 ± 16%  interrupts.CPU0.CAL:Function_call_interrupts
    487082           +52.0%     740155 ±  5%  interrupts.CPU0.LOC:Local_timer_interrupts
    869.50 ± 14%    +233.1%       2896 ± 14%  interrupts.CPU0.RES:Rescheduling_interrupts
      3490 ± 30%    +715.0%      28448 ± 15%  interrupts.CPU1.CAL:Function_call_interrupts
    487092           +52.2%     741504 ±  4%  interrupts.CPU1.LOC:Local_timer_interrupts
    714.33 ± 13%    +249.9%       2499 ±  7%  interrupts.CPU1.RES:Rescheduling_interrupts
      3023 ± 21%    +833.5%      28220 ± 15%  interrupts.CPU10.CAL:Function_call_interrupts
    487061           +52.3%     741612 ±  4%  interrupts.CPU10.LOC:Local_timer_interrupts
    736.50 ± 16%    +217.9%       2341 ±  7%  interrupts.CPU10.RES:Rescheduling_interrupts
      3101 ± 18%    +827.1%      28754 ± 12%  interrupts.CPU100.CAL:Function_call_interrupts
    487296           +52.5%     743050 ±  4%  interrupts.CPU100.LOC:Local_timer_interrupts
    428.67 ±  6%    +420.0%       2229 ± 10%  interrupts.CPU100.RES:Rescheduling_interrupts
      3075 ± 16%    +834.5%      28737 ± 12%  interrupts.CPU101.CAL:Function_call_interrupts
    487344           +52.4%     742943 ±  4%  interrupts.CPU101.LOC:Local_timer_interrupts
    449.17 ±  6%    +387.3%       2188 ±  9%  interrupts.CPU101.RES:Rescheduling_interrupts
      3089 ± 16%    +839.1%      29014 ± 12%  interrupts.CPU102.CAL:Function_call_interrupts
    487370           +52.4%     742976 ±  4%  interrupts.CPU102.LOC:Local_timer_interrupts
    451.83 ±  6%    +392.4%       2224 ± 12%  interrupts.CPU102.RES:Rescheduling_interrupts
      3106 ± 18%    +829.1%      28861 ± 11%  interrupts.CPU103.CAL:Function_call_interrupts
    487340           +52.5%     742952 ±  4%  interrupts.CPU103.LOC:Local_timer_interrupts
    454.00 ±  8%    +386.8%       2210 ±  9%  interrupts.CPU103.RES:Rescheduling_interrupts
      3101 ± 17%    +829.2%      28821 ± 11%  interrupts.CPU104.CAL:Function_call_interrupts
    487360           +52.4%     742860 ±  4%  interrupts.CPU104.LOC:Local_timer_interrupts
    441.00 ±  4%    +400.6%       2207 ± 11%  interrupts.CPU104.RES:Rescheduling_interrupts
      3074 ± 17%    +829.6%      28575 ± 11%  interrupts.CPU105.CAL:Function_call_interrupts
    487347           +52.4%     742943 ±  4%  interrupts.CPU105.LOC:Local_timer_interrupts
    425.67 ±  3%    +415.0%       2192 ± 11%  interrupts.CPU105.RES:Rescheduling_interrupts
      3099 ± 15%    +825.3%      28684 ± 11%  interrupts.CPU106.CAL:Function_call_interrupts
    487373           +52.4%     742836 ±  4%  interrupts.CPU106.LOC:Local_timer_interrupts
    453.83 ±  6%    +394.5%       2244 ± 12%  interrupts.CPU106.RES:Rescheduling_interrupts
      3085 ± 17%    +835.0%      28851 ± 11%  interrupts.CPU107.CAL:Function_call_interrupts
    487353           +52.4%     742823 ±  4%  interrupts.CPU107.LOC:Local_timer_interrupts
    446.67 ±  7%    +392.0%       2197 ± 11%  interrupts.CPU107.RES:Rescheduling_interrupts
      3029 ± 20%    +848.3%      28729 ± 14%  interrupts.CPU108.CAL:Function_call_interrupts
    486780           +52.7%     743168 ±  4%  interrupts.CPU108.LOC:Local_timer_interrupts
    453.33 ± 16%    +368.8%       2125 ±  8%  interrupts.CPU108.RES:Rescheduling_interrupts
      3065 ± 20%    +843.4%      28916 ± 14%  interrupts.CPU109.CAL:Function_call_interrupts
    486706           +52.7%     743121 ±  4%  interrupts.CPU109.LOC:Local_timer_interrupts
    486.67 ± 12%    +349.9%       2189 ±  7%  interrupts.CPU109.RES:Rescheduling_interrupts
      3027 ± 17%    +835.6%      28321 ± 14%  interrupts.CPU11.CAL:Function_call_interrupts
    487015           +52.2%     741464 ±  4%  interrupts.CPU11.LOC:Local_timer_interrupts
    713.17 ± 11%    +239.8%       2423 ±  7%  interrupts.CPU11.RES:Rescheduling_interrupts
      3152 ± 14%    +818.6%      28959 ± 15%  interrupts.CPU110.CAL:Function_call_interrupts
    486728           +52.7%     743215 ±  4%  interrupts.CPU110.LOC:Local_timer_interrupts
    497.50 ± 31%    +330.4%       2141 ±  8%  interrupts.CPU110.RES:Rescheduling_interrupts
      2994 ± 21%    +867.7%      28980 ± 14%  interrupts.CPU111.CAL:Function_call_interrupts
    486750           +52.7%     743088 ±  4%  interrupts.CPU111.LOC:Local_timer_interrupts
    452.33 ±  7%    +380.0%       2171 ±  5%  interrupts.CPU111.RES:Rescheduling_interrupts
      3081 ± 19%    +832.4%      28728 ± 14%  interrupts.CPU112.CAL:Function_call_interrupts
    486734           +50.8%     733783 ±  7%  interrupts.CPU112.LOC:Local_timer_interrupts
    460.33 ± 16%    +362.6%       2129 ±  7%  interrupts.CPU112.RES:Rescheduling_interrupts
      3073 ± 20%    +840.5%      28902 ± 14%  interrupts.CPU113.CAL:Function_call_interrupts
    486755           +52.7%     743229 ±  4%  interrupts.CPU113.LOC:Local_timer_interrupts
    479.67 ± 12%    +343.7%       2128 ± 10%  interrupts.CPU113.RES:Rescheduling_interrupts
      3070 ± 20%    +841.3%      28902 ± 14%  interrupts.CPU114.CAL:Function_call_interrupts
    486791           +52.7%     743096 ±  4%  interrupts.CPU114.LOC:Local_timer_interrupts
    499.67 ± 24%    +332.3%       2160 ±  8%  interrupts.CPU114.RES:Rescheduling_interrupts
      3114 ± 19%    +829.7%      28954 ± 14%  interrupts.CPU115.CAL:Function_call_interrupts
    486756           +52.7%     743215 ±  4%  interrupts.CPU115.LOC:Local_timer_interrupts
    477.33 ± 18%    +350.4%       2149 ±  9%  interrupts.CPU115.RES:Rescheduling_interrupts
      3030 ± 19%    +847.1%      28703 ± 14%  interrupts.CPU116.CAL:Function_call_interrupts
    486791           +52.7%     743179 ±  4%  interrupts.CPU116.LOC:Local_timer_interrupts
    467.50 ± 17%    +352.2%       2113 ±  9%  interrupts.CPU116.RES:Rescheduling_interrupts
      3055 ± 20%    +842.1%      28784 ± 15%  interrupts.CPU117.CAL:Function_call_interrupts
    486795           +52.7%     743347 ±  4%  interrupts.CPU117.LOC:Local_timer_interrupts
    462.17 ± 20%    +357.7%       2115 ±  7%  interrupts.CPU117.RES:Rescheduling_interrupts
      3094 ± 21%    +833.8%      28900 ± 14%  interrupts.CPU118.CAL:Function_call_interrupts
    486828           +52.7%     743378 ±  4%  interrupts.CPU118.LOC:Local_timer_interrupts
    479.17 ± 22%    +342.0%       2117 ±  6%  interrupts.CPU118.RES:Rescheduling_interrupts
      3122 ± 16%    +831.0%      29071 ± 14%  interrupts.CPU119.CAL:Function_call_interrupts
    486797           +52.7%     743293 ±  4%  interrupts.CPU119.LOC:Local_timer_interrupts
    478.50 ± 19%    +348.6%       2146 ± 10%  interrupts.CPU119.RES:Rescheduling_interrupts
      2949 ± 20%    +858.9%      28280 ± 15%  interrupts.CPU12.CAL:Function_call_interrupts
    487292           +52.2%     741434 ±  4%  interrupts.CPU12.LOC:Local_timer_interrupts
    712.83 ± 14%    +238.1%       2410 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
      3068 ± 18%    +846.8%      29047 ± 14%  interrupts.CPU120.CAL:Function_call_interrupts
    486780           +52.7%     743502 ±  4%  interrupts.CPU120.LOC:Local_timer_interrupts
    469.00 ± 16%    +347.3%       2097 ±  7%  interrupts.CPU120.RES:Rescheduling_interrupts
      3089 ± 18%    +836.3%      28921 ± 14%  interrupts.CPU121.CAL:Function_call_interrupts
    486752           +52.7%     743238 ±  4%  interrupts.CPU121.LOC:Local_timer_interrupts
    462.50 ± 18%    +359.4%       2124 ±  7%  interrupts.CPU121.RES:Rescheduling_interrupts
      3082 ± 18%    +834.4%      28798 ± 14%  interrupts.CPU122.CAL:Function_call_interrupts
    486770           +52.7%     743206 ±  4%  interrupts.CPU122.LOC:Local_timer_interrupts
    473.67 ± 27%    +334.8%       2059 ±  6%  interrupts.CPU122.RES:Rescheduling_interrupts
      3087 ± 19%    +836.5%      28917 ± 14%  interrupts.CPU123.CAL:Function_call_interrupts
    486767           +52.7%     743240 ±  4%  interrupts.CPU123.LOC:Local_timer_interrupts
    464.83 ± 25%    +347.4%       2079 ±  8%  interrupts.CPU123.RES:Rescheduling_interrupts
      3055 ± 18%    +843.7%      28833 ± 14%  interrupts.CPU124.CAL:Function_call_interrupts
    486694           +52.7%     743032 ±  4%  interrupts.CPU124.LOC:Local_timer_interrupts
    443.50 ± 19%    +373.3%       2099 ±  9%  interrupts.CPU124.RES:Rescheduling_interrupts
      3090 ± 19%    +838.9%      29015 ± 13%  interrupts.CPU125.CAL:Function_call_interrupts
    486797           +52.6%     743008 ±  4%  interrupts.CPU125.LOC:Local_timer_interrupts
    472.83 ± 24%    +346.5%       2111 ±  6%  interrupts.CPU125.RES:Rescheduling_interrupts
      3046 ± 17%    +839.8%      28624 ± 13%  interrupts.CPU126.CAL:Function_call_interrupts
    486711           +52.7%     743080 ±  4%  interrupts.CPU126.LOC:Local_timer_interrupts
    440.00 ± 12%    +403.9%       2217 ±  9%  interrupts.CPU126.RES:Rescheduling_interrupts
      3081 ± 17%    +826.6%      28555 ± 14%  interrupts.CPU127.CAL:Function_call_interrupts
    486703           +52.7%     743033 ±  4%  interrupts.CPU127.LOC:Local_timer_interrupts
    444.17 ± 14%    +400.3%       2222 ± 10%  interrupts.CPU127.RES:Rescheduling_interrupts
      3082 ± 16%    +825.7%      28534 ± 13%  interrupts.CPU128.CAL:Function_call_interrupts
    486688           +52.7%     743207 ±  4%  interrupts.CPU128.LOC:Local_timer_interrupts
    460.50 ± 14%    +377.2%       2197 ± 12%  interrupts.CPU128.RES:Rescheduling_interrupts
      3040 ± 17%    +846.4%      28774 ± 13%  interrupts.CPU129.CAL:Function_call_interrupts
    486683           +52.7%     743097 ±  4%  interrupts.CPU129.LOC:Local_timer_interrupts
    440.67 ± 12%    +410.0%       2247 ± 11%  interrupts.CPU129.RES:Rescheduling_interrupts
      2942 ± 20%    +854.7%      28090 ± 15%  interrupts.CPU13.CAL:Function_call_interrupts
    487053           +52.2%     741255 ±  5%  interrupts.CPU13.LOC:Local_timer_interrupts
    684.17 ± 13%    +244.9%       2359 ±  5%  interrupts.CPU13.RES:Rescheduling_interrupts
      3083 ± 19%    +818.8%      28334 ± 13%  interrupts.CPU130.CAL:Function_call_interrupts
    486682           +52.7%     743009 ±  4%  interrupts.CPU130.LOC:Local_timer_interrupts
    446.17 ± 12%    +391.6%       2193 ± 10%  interrupts.CPU130.RES:Rescheduling_interrupts
      3078 ± 17%    +810.2%      28018 ± 13%  interrupts.CPU131.CAL:Function_call_interrupts
    486681           +52.7%     743341 ±  4%  interrupts.CPU131.LOC:Local_timer_interrupts
    429.00 ± 12%    +400.9%       2148 ± 10%  interrupts.CPU131.RES:Rescheduling_interrupts
      3076 ± 16%    +829.4%      28592 ± 13%  interrupts.CPU132.CAL:Function_call_interrupts
    486702           +52.7%     743190 ±  4%  interrupts.CPU132.LOC:Local_timer_interrupts
    459.00 ±  8%    +380.2%       2204 ±  9%  interrupts.CPU132.RES:Rescheduling_interrupts
      3112 ± 17%    +819.5%      28614 ± 14%  interrupts.CPU133.CAL:Function_call_interrupts
    486690           +52.7%     743126 ±  4%  interrupts.CPU133.LOC:Local_timer_interrupts
    452.17 ± 13%    +406.0%       2288 ±  7%  interrupts.CPU133.RES:Rescheduling_interrupts
      3111 ± 16%    +824.4%      28764 ± 14%  interrupts.CPU134.CAL:Function_call_interrupts
    486723           +52.6%     742953 ±  4%  interrupts.CPU134.LOC:Local_timer_interrupts
    445.33 ± 11%    +398.3%       2219 ± 10%  interrupts.CPU134.RES:Rescheduling_interrupts
      3085 ± 17%    +834.2%      28820 ± 13%  interrupts.CPU135.CAL:Function_call_interrupts
    486699           +52.7%     743192 ±  4%  interrupts.CPU135.LOC:Local_timer_interrupts
    436.50 ±  7%    +412.9%       2239 ± 11%  interrupts.CPU135.RES:Rescheduling_interrupts
      3092 ± 18%    +821.1%      28482 ± 13%  interrupts.CPU136.CAL:Function_call_interrupts
    486679           +52.7%     742986 ±  4%  interrupts.CPU136.LOC:Local_timer_interrupts
    433.83 ± 11%    +420.3%       2257 ±  9%  interrupts.CPU136.RES:Rescheduling_interrupts
      3096 ± 17%    +821.6%      28534 ± 13%  interrupts.CPU137.CAL:Function_call_interrupts
    486675           +52.7%     743227 ±  4%  interrupts.CPU137.LOC:Local_timer_interrupts
    448.17 ± 10%    +398.1%       2232 ± 10%  interrupts.CPU137.RES:Rescheduling_interrupts
      3023 ± 18%    +850.2%      28725 ± 14%  interrupts.CPU138.CAL:Function_call_interrupts
    486711           +52.7%     742996 ±  4%  interrupts.CPU138.LOC:Local_timer_interrupts
    440.50 ±  8%    +400.0%       2202 ±  9%  interrupts.CPU138.RES:Rescheduling_interrupts
      3033 ± 19%    +848.2%      28767 ± 14%  interrupts.CPU139.CAL:Function_call_interrupts
    486719           +52.7%     742997 ±  4%  interrupts.CPU139.LOC:Local_timer_interrupts
    442.17 ± 13%    +412.9%       2267 ±  9%  interrupts.CPU139.RES:Rescheduling_interrupts
      2961 ± 20%    +867.7%      28655 ± 14%  interrupts.CPU14.CAL:Function_call_interrupts
    486965           +52.3%     741610 ±  4%  interrupts.CPU14.LOC:Local_timer_interrupts
    686.83 ± 11%    +250.3%       2406 ±  6%  interrupts.CPU14.RES:Rescheduling_interrupts
      3023 ± 15%    +852.5%      28798 ± 13%  interrupts.CPU140.CAL:Function_call_interrupts
    486753           +52.7%     743181 ±  4%  interrupts.CPU140.LOC:Local_timer_interrupts
    461.00 ± 14%    +381.8%       2221 ±  8%  interrupts.CPU140.RES:Rescheduling_interrupts
      3042 ± 18%    +839.3%      28572 ± 12%  interrupts.CPU141.CAL:Function_call_interrupts
    486715           +52.7%     743148 ±  4%  interrupts.CPU141.LOC:Local_timer_interrupts
    437.67 ± 13%    +399.3%       2185 ±  9%  interrupts.CPU141.RES:Rescheduling_interrupts
      3100 ± 15%    +823.1%      28620 ± 13%  interrupts.CPU142.CAL:Function_call_interrupts
    486722           +52.7%     742995 ±  4%  interrupts.CPU142.LOC:Local_timer_interrupts
    461.50 ± 13%    +384.1%       2234 ±  9%  interrupts.CPU142.RES:Rescheduling_interrupts
      3131 ± 16%    +813.3%      28595 ± 13%  interrupts.CPU143.CAL:Function_call_interrupts
    486720           +52.7%     742985 ±  4%  interrupts.CPU143.LOC:Local_timer_interrupts
    503.83 ± 13%    +346.3%       2248 ±  9%  interrupts.CPU143.RES:Rescheduling_interrupts
      2983 ± 21%    +854.1%      28466 ± 14%  interrupts.CPU15.CAL:Function_call_interrupts
    487042           +52.2%     741464 ±  4%  interrupts.CPU15.LOC:Local_timer_interrupts
    722.33 ± 16%    +230.0%       2383 ±  6%  interrupts.CPU15.RES:Rescheduling_interrupts
      2940 ± 19%    +861.2%      28259 ± 15%  interrupts.CPU16.CAL:Function_call_interrupts
    487099           +52.2%     741364 ±  4%  interrupts.CPU16.LOC:Local_timer_interrupts
    674.00 ± 14%    +250.5%       2362 ±  5%  interrupts.CPU16.RES:Rescheduling_interrupts
      2858 ± 20%    +897.5%      28508 ± 15%  interrupts.CPU17.CAL:Function_call_interrupts
    487086           +52.2%     741199 ±  5%  interrupts.CPU17.LOC:Local_timer_interrupts
    695.50 ± 17%    +246.8%       2411 ±  7%  interrupts.CPU17.RES:Rescheduling_interrupts
      3268 ± 22%    +781.3%      28805 ± 12%  interrupts.CPU18.CAL:Function_call_interrupts
    487377           +52.4%     742840 ±  4%  interrupts.CPU18.LOC:Local_timer_interrupts
      1052 ±  2%    +165.1%       2789 ±  8%  interrupts.CPU18.RES:Rescheduling_interrupts
      3324 ± 14%    +767.1%      28827 ± 11%  interrupts.CPU19.CAL:Function_call_interrupts
    487369           +52.4%     742896 ±  4%  interrupts.CPU19.LOC:Local_timer_interrupts
    611.50 ±  2%    +290.2%       2386 ±  9%  interrupts.CPU19.RES:Rescheduling_interrupts
      3171 ± 11%    +791.5%      28275 ± 15%  interrupts.CPU2.CAL:Function_call_interrupts
    487065           +52.2%     741466 ±  4%  interrupts.CPU2.LOC:Local_timer_interrupts
    717.50 ± 19%    +227.4%       2349 ±  7%  interrupts.CPU2.RES:Rescheduling_interrupts
      3153 ± 17%    +818.4%      28958 ± 11%  interrupts.CPU20.CAL:Function_call_interrupts
    487382           +52.4%     742811 ±  4%  interrupts.CPU20.LOC:Local_timer_interrupts
    564.83 ±  4%    +315.8%       2348 ± 11%  interrupts.CPU20.RES:Rescheduling_interrupts
      3155 ± 18%    +811.4%      28757 ± 11%  interrupts.CPU21.CAL:Function_call_interrupts
    487271           +52.4%     742756 ±  4%  interrupts.CPU21.LOC:Local_timer_interrupts
    589.67 ±  4%    +293.0%       2317 ±  9%  interrupts.CPU21.RES:Rescheduling_interrupts
      3263 ± 14%    +781.8%      28776 ± 11%  interrupts.CPU22.CAL:Function_call_interrupts
    487401           +52.4%     742929 ±  4%  interrupts.CPU22.LOC:Local_timer_interrupts
    588.67 ±  5%    +294.2%       2320 ±  9%  interrupts.CPU22.RES:Rescheduling_interrupts
      3123 ± 16%    +815.3%      28583 ± 11%  interrupts.CPU23.CAL:Function_call_interrupts
    487357           +52.4%     742935 ±  4%  interrupts.CPU23.LOC:Local_timer_interrupts
    575.50 ±  3%    +299.9%       2301 ± 10%  interrupts.CPU23.RES:Rescheduling_interrupts
      3094 ± 17%    +835.4%      28941 ± 11%  interrupts.CPU24.CAL:Function_call_interrupts
    487248           +52.5%     742909 ±  4%  interrupts.CPU24.LOC:Local_timer_interrupts
    584.67 ±  7%    +295.0%       2309 ±  9%  interrupts.CPU24.RES:Rescheduling_interrupts
      3189 ± 16%    +803.9%      28830 ± 12%  interrupts.CPU25.CAL:Function_call_interrupts
    487361           +52.4%     742807 ±  4%  interrupts.CPU25.LOC:Local_timer_interrupts
    598.33 ±  8%    +292.5%       2348 ±  8%  interrupts.CPU25.RES:Rescheduling_interrupts
      2958 ± 17%    +871.5%      28737 ± 11%  interrupts.CPU26.CAL:Function_call_interrupts
    487369           +52.4%     742721 ±  4%  interrupts.CPU26.LOC:Local_timer_interrupts
    573.83 ±  5%    +303.9%       2317 ±  9%  interrupts.CPU26.RES:Rescheduling_interrupts
      3081 ± 17%    +838.8%      28928 ± 12%  interrupts.CPU27.CAL:Function_call_interrupts
    487395           +52.4%     742997 ±  4%  interrupts.CPU27.LOC:Local_timer_interrupts
    575.33 ±  4%    +299.8%       2300 ± 10%  interrupts.CPU27.RES:Rescheduling_interrupts
      3103 ± 17%    +823.2%      28650 ± 12%  interrupts.CPU28.CAL:Function_call_interrupts
    487388           +52.4%     742886 ±  4%  interrupts.CPU28.LOC:Local_timer_interrupts
    578.67 ±  4%    +300.5%       2317 ± 11%  interrupts.CPU28.RES:Rescheduling_interrupts
      2929 ± 17%    +873.1%      28509 ± 10%  interrupts.CPU29.CAL:Function_call_interrupts
    487445           +52.4%     742893 ±  4%  interrupts.CPU29.LOC:Local_timer_interrupts
    564.50 ±  6%    +312.8%       2330 ±  9%  interrupts.CPU29.RES:Rescheduling_interrupts
      2985 ± 19%    +851.1%      28397 ± 14%  interrupts.CPU3.CAL:Function_call_interrupts
    487074           +52.2%     741389 ±  4%  interrupts.CPU3.LOC:Local_timer_interrupts
    695.33 ± 13%    +238.2%       2351 ±  7%  interrupts.CPU3.RES:Rescheduling_interrupts
      3114 ± 16%    +827.8%      28896 ± 12%  interrupts.CPU30.CAL:Function_call_interrupts
    487375           +52.4%     742816 ±  4%  interrupts.CPU30.LOC:Local_timer_interrupts
    585.00 ±  4%    +306.9%       2380 ± 11%  interrupts.CPU30.RES:Rescheduling_interrupts
      3127 ± 17%    +813.9%      28582 ± 12%  interrupts.CPU31.CAL:Function_call_interrupts
    487393           +52.4%     742865 ±  4%  interrupts.CPU31.LOC:Local_timer_interrupts
    579.50 ±  3%    +305.3%       2348 ± 10%  interrupts.CPU31.RES:Rescheduling_interrupts
      2980 ± 18%    +862.4%      28686 ± 12%  interrupts.CPU32.CAL:Function_call_interrupts
    487370           +52.4%     742989 ±  4%  interrupts.CPU32.LOC:Local_timer_interrupts
    563.50 ±  6%    +308.7%       2303 ± 10%  interrupts.CPU32.RES:Rescheduling_interrupts
      3119 ± 18%    +820.7%      28719 ± 11%  interrupts.CPU33.CAL:Function_call_interrupts
    487360           +52.4%     742960 ±  4%  interrupts.CPU33.LOC:Local_timer_interrupts
    587.00 ±  5%    +296.8%       2329 ± 11%  interrupts.CPU33.RES:Rescheduling_interrupts
      3083 ± 17%    +833.8%      28793 ± 11%  interrupts.CPU34.CAL:Function_call_interrupts
    487354           +52.4%     742690 ±  4%  interrupts.CPU34.LOC:Local_timer_interrupts
    576.17 ±  4%    +303.2%       2322 ± 10%  interrupts.CPU34.RES:Rescheduling_interrupts
      3135 ± 16%    +822.2%      28919 ± 12%  interrupts.CPU35.CAL:Function_call_interrupts
    487390           +52.4%     742785 ±  4%  interrupts.CPU35.LOC:Local_timer_interrupts
    579.67 ±  5%    +301.5%       2327 ± 11%  interrupts.CPU35.RES:Rescheduling_interrupts
      3075 ± 18%    +833.3%      28705 ± 14%  interrupts.CPU36.CAL:Function_call_interrupts
    486770           +52.6%     742982 ±  4%  interrupts.CPU36.LOC:Local_timer_interrupts
      1100 ± 10%    +150.2%       2752 ±  9%  interrupts.CPU36.RES:Rescheduling_interrupts
      2971 ± 20%    +869.5%      28806 ± 13%  interrupts.CPU37.CAL:Function_call_interrupts
    486730           +52.7%     743040 ±  4%  interrupts.CPU37.LOC:Local_timer_interrupts
    597.17 ±  9%    +289.5%       2326 ±  8%  interrupts.CPU37.RES:Rescheduling_interrupts
      3131 ± 19%    +822.8%      28895 ± 14%  interrupts.CPU38.CAL:Function_call_interrupts
    486743           +52.6%     742891 ±  4%  interrupts.CPU38.LOC:Local_timer_interrupts
    596.17 ± 14%    +287.0%       2307 ±  5%  interrupts.CPU38.RES:Rescheduling_interrupts
      3121 ± 17%    +833.1%      29125 ± 14%  interrupts.CPU39.CAL:Function_call_interrupts
    486833           +52.6%     742976 ±  4%  interrupts.CPU39.LOC:Local_timer_interrupts
    601.00 ± 11%    +279.5%       2280 ±  7%  interrupts.CPU39.RES:Rescheduling_interrupts
      2985 ± 22%    +851.0%      28388 ± 15%  interrupts.CPU4.CAL:Function_call_interrupts
    486986           +52.2%     741386 ±  4%  interrupts.CPU4.LOC:Local_timer_interrupts
    682.00 ± 13%    +257.7%       2439 ±  6%  interrupts.CPU4.RES:Rescheduling_interrupts
      3080 ± 19%    +834.0%      28774 ± 14%  interrupts.CPU40.CAL:Function_call_interrupts
    486717           +53.1%     745155 ±  4%  interrupts.CPU40.LOC:Local_timer_interrupts
    579.33 ± 12%    +296.8%       2298 ±  7%  interrupts.CPU40.RES:Rescheduling_interrupts
      3077 ± 20%    +837.3%      28849 ± 14%  interrupts.CPU41.CAL:Function_call_interrupts
    486774           +52.7%     743289 ±  4%  interrupts.CPU41.LOC:Local_timer_interrupts
    608.50 ± 18%    +269.9%       2250 ±  8%  interrupts.CPU41.RES:Rescheduling_interrupts
      3089 ± 19%    +833.6%      28846 ± 14%  interrupts.CPU42.CAL:Function_call_interrupts
    486799           +52.7%     743424 ±  4%  interrupts.CPU42.LOC:Local_timer_interrupts
    602.17 ± 12%    +281.9%       2299 ±  9%  interrupts.CPU42.RES:Rescheduling_interrupts
      3086 ± 16%    +839.6%      28999 ± 14%  interrupts.CPU43.CAL:Function_call_interrupts
    486768           +52.7%     743297 ±  4%  interrupts.CPU43.LOC:Local_timer_interrupts
    618.17 ± 17%    +267.7%       2272 ±  8%  interrupts.CPU43.RES:Rescheduling_interrupts
      3001 ± 21%    +864.7%      28951 ± 14%  interrupts.CPU44.CAL:Function_call_interrupts
    486814           +52.6%     743114 ±  4%  interrupts.CPU44.LOC:Local_timer_interrupts
    587.67 ±  9%    +287.1%       2274 ±  7%  interrupts.CPU44.RES:Rescheduling_interrupts
      3123 ± 19%    +827.1%      28955 ± 14%  interrupts.CPU45.CAL:Function_call_interrupts
    486764           +52.7%     743329 ±  4%  interrupts.CPU45.LOC:Local_timer_interrupts
    609.00 ± 12%    +278.8%       2307 ±  6%  interrupts.CPU45.RES:Rescheduling_interrupts
      3093 ± 16%    +834.7%      28916 ± 13%  interrupts.CPU46.CAL:Function_call_interrupts
    486788           +52.7%     743194 ±  4%  interrupts.CPU46.LOC:Local_timer_interrupts
    638.33 ± 19%    +256.8%       2277 ±  7%  interrupts.CPU46.RES:Rescheduling_interrupts
      3065 ± 18%    +847.8%      29052 ± 14%  interrupts.CPU47.CAL:Function_call_interrupts
    486799           +52.6%     743046 ±  4%  interrupts.CPU47.LOC:Local_timer_interrupts
    612.67 ± 15%    +266.2%       2243 ±  6%  interrupts.CPU47.RES:Rescheduling_interrupts
      3033 ± 20%    +852.5%      28893 ± 14%  interrupts.CPU48.CAL:Function_call_interrupts
    486791           +52.7%     743286 ±  4%  interrupts.CPU48.LOC:Local_timer_interrupts
    594.67 ±  9%    +274.6%       2227 ±  8%  interrupts.CPU48.RES:Rescheduling_interrupts
      3094 ± 20%    +831.8%      28836 ± 14%  interrupts.CPU49.CAL:Function_call_interrupts
    486791           +52.7%     743219 ±  4%  interrupts.CPU49.LOC:Local_timer_interrupts
    620.67 ± 14%    +263.2%       2254 ±  7%  interrupts.CPU49.RES:Rescheduling_interrupts
      2959 ± 18%    +860.9%      28442 ± 13%  interrupts.CPU5.CAL:Function_call_interrupts
    487094           +52.2%     741600 ±  4%  interrupts.CPU5.LOC:Local_timer_interrupts
    697.17 ±  8%    +246.5%       2416 ±  7%  interrupts.CPU5.RES:Rescheduling_interrupts
      3046 ± 20%    +847.0%      28851 ± 13%  interrupts.CPU50.CAL:Function_call_interrupts
    486780           +52.7%     743459 ±  4%  interrupts.CPU50.LOC:Local_timer_interrupts
    606.17 ± 10%    +269.2%       2238 ±  7%  interrupts.CPU50.RES:Rescheduling_interrupts
      3051 ± 20%    +850.8%      29018 ± 14%  interrupts.CPU51.CAL:Function_call_interrupts
    486794           +52.7%     743396 ±  4%  interrupts.CPU51.LOC:Local_timer_interrupts
    604.00 ±  9%    +271.9%       2246 ±  6%  interrupts.CPU51.RES:Rescheduling_interrupts
      3031 ± 22%    +844.3%      28622 ± 13%  interrupts.CPU52.CAL:Function_call_interrupts
    486730           +52.7%     743019 ±  4%  interrupts.CPU52.LOC:Local_timer_interrupts
    602.00 ±  9%    +269.8%       2226 ±  7%  interrupts.CPU52.RES:Rescheduling_interrupts
      3086 ± 19%    +836.8%      28911 ± 14%  interrupts.CPU53.CAL:Function_call_interrupts
    486796           +52.6%     743093 ±  4%  interrupts.CPU53.LOC:Local_timer_interrupts
    604.17 ± 11%    +278.2%       2284 ±  7%  interrupts.CPU53.RES:Rescheduling_interrupts
      3066 ± 18%    +820.5%      28228 ± 14%  interrupts.CPU54.CAL:Function_call_interrupts
    486721           +52.7%     743023 ±  4%  interrupts.CPU54.LOC:Local_timer_interrupts
      1017 ± 13%    +188.5%       2933 ± 14%  interrupts.CPU54.RES:Rescheduling_interrupts
      3068 ± 17%    +807.3%      27838 ± 16%  interrupts.CPU55.CAL:Function_call_interrupts
    486751           +52.6%     743015 ±  4%  interrupts.CPU55.LOC:Local_timer_interrupts
    627.33 ±  8%    +274.0%       2346 ± 11%  interrupts.CPU55.RES:Rescheduling_interrupts
      3139 ± 16%    +814.3%      28705 ± 12%  interrupts.CPU56.CAL:Function_call_interrupts
    486627           +52.7%     742990 ±  4%  interrupts.CPU56.LOC:Local_timer_interrupts
    605.00 ± 13%    +301.1%       2426 ±  8%  interrupts.CPU56.RES:Rescheduling_interrupts
      3092 ± 19%    +823.4%      28557 ± 13%  interrupts.CPU57.CAL:Function_call_interrupts
    486697           +52.7%     742981 ±  4%  interrupts.CPU57.LOC:Local_timer_interrupts
    601.83 ±  9%    +304.0%       2431 ±  9%  interrupts.CPU57.RES:Rescheduling_interrupts
      2869 ± 19%    +884.7%      28260 ± 14%  interrupts.CPU58.CAL:Function_call_interrupts
    486728           +52.7%     743011 ±  4%  interrupts.CPU58.LOC:Local_timer_interrupts
    589.00 ±  9%    +305.3%       2387 ±  8%  interrupts.CPU58.RES:Rescheduling_interrupts
      3087 ± 17%    +816.4%      28298 ± 14%  interrupts.CPU59.CAL:Function_call_interrupts
    486638           +52.7%     743122 ±  4%  interrupts.CPU59.LOC:Local_timer_interrupts
    606.83 ±  7%    +295.5%       2400 ± 10%  interrupts.CPU59.RES:Rescheduling_interrupts
      2950 ± 16%    +853.7%      28134 ± 13%  interrupts.CPU6.CAL:Function_call_interrupts
    487085           +52.2%     741518 ±  4%  interrupts.CPU6.LOC:Local_timer_interrupts
    688.33 ± 11%    +250.0%       2409 ±  5%  interrupts.CPU6.RES:Rescheduling_interrupts
      3046 ± 18%    +837.8%      28569 ± 14%  interrupts.CPU60.CAL:Function_call_interrupts
    486713           +52.7%     743209 ±  4%  interrupts.CPU60.LOC:Local_timer_interrupts
    575.83 ±  7%    +329.1%       2471 ±  9%  interrupts.CPU60.RES:Rescheduling_interrupts
      3099 ± 17%    +819.3%      28495 ± 13%  interrupts.CPU61.CAL:Function_call_interrupts
    486750           +52.6%     742985 ±  4%  interrupts.CPU61.LOC:Local_timer_interrupts
    590.83 ± 11%    +303.3%       2382 ±  9%  interrupts.CPU61.RES:Rescheduling_interrupts
      3091 ± 17%    +834.6%      28888 ± 13%  interrupts.CPU62.CAL:Function_call_interrupts
    486710           +52.6%     742904 ±  4%  interrupts.CPU62.LOC:Local_timer_interrupts
    607.17 ±  8%    +299.4%       2425 ±  9%  interrupts.CPU62.RES:Rescheduling_interrupts
      3082 ± 17%    +817.5%      28284 ± 15%  interrupts.CPU63.CAL:Function_call_interrupts
    486691           +52.7%     743057 ±  4%  interrupts.CPU63.LOC:Local_timer_interrupts
    585.17 ±  3%    +307.8%       2386 ± 12%  interrupts.CPU63.RES:Rescheduling_interrupts
      3104 ± 19%    +824.1%      28686 ± 13%  interrupts.CPU64.CAL:Function_call_interrupts
    486692           +52.7%     743020 ±  4%  interrupts.CPU64.LOC:Local_timer_interrupts
    586.00 ±  8%    +302.1%       2356 ± 10%  interrupts.CPU64.RES:Rescheduling_interrupts
      3134 ± 16%    +812.4%      28597 ± 13%  interrupts.CPU65.CAL:Function_call_interrupts
    486641           +52.7%     743055 ±  4%  interrupts.CPU65.LOC:Local_timer_interrupts
    616.33 ±  8%    +285.0%       2373 ± 10%  interrupts.CPU65.RES:Rescheduling_interrupts
      2841 ± 18%    +901.8%      28470 ± 14%  interrupts.CPU66.CAL:Function_call_interrupts
    486753           +52.6%     742991 ±  4%  interrupts.CPU66.LOC:Local_timer_interrupts
    596.67 ±  7%    +295.9%       2362 ±  9%  interrupts.CPU66.RES:Rescheduling_interrupts
      2992 ± 18%    +848.8%      28386 ± 13%  interrupts.CPU67.CAL:Function_call_interrupts
    486726           +52.6%     742794 ±  4%  interrupts.CPU67.LOC:Local_timer_interrupts
    587.83 ±  7%    +305.9%       2386 ±  8%  interrupts.CPU67.RES:Rescheduling_interrupts
      3105 ± 17%    +819.7%      28559 ± 14%  interrupts.CPU68.CAL:Function_call_interrupts
    486718           +52.7%     743179 ±  4%  interrupts.CPU68.LOC:Local_timer_interrupts
    604.17 ±  9%    +299.0%       2410 ± 10%  interrupts.CPU68.RES:Rescheduling_interrupts
      3073 ± 15%    +826.6%      28478 ± 13%  interrupts.CPU69.CAL:Function_call_interrupts
    486691           +52.7%     743035 ±  4%  interrupts.CPU69.LOC:Local_timer_interrupts
    601.67 ± 11%    +304.1%       2431 ±  8%  interrupts.CPU69.RES:Rescheduling_interrupts
      3019 ± 21%    +832.0%      28139 ± 13%  interrupts.CPU7.CAL:Function_call_interrupts
    486988           +52.3%     741486 ±  4%  interrupts.CPU7.LOC:Local_timer_interrupts
    729.83 ± 11%    +224.9%       2371 ±  4%  interrupts.CPU7.RES:Rescheduling_interrupts
      3058 ± 16%    +829.7%      28432 ± 13%  interrupts.CPU70.CAL:Function_call_interrupts
    486702           +52.6%     742802 ±  4%  interrupts.CPU70.LOC:Local_timer_interrupts
    583.83 ±  5%    +310.9%       2399 ± 10%  interrupts.CPU70.RES:Rescheduling_interrupts
      6390 ±  9%    +416.6%      33010 ± 11%  interrupts.CPU71.CAL:Function_call_interrupts
    486784           +52.6%     742926 ±  4%  interrupts.CPU71.LOC:Local_timer_interrupts
      1423 ±  9%    +157.9%       3670 ±  5%  interrupts.CPU71.RES:Rescheduling_interrupts
      3021 ± 17%    +830.6%      28117 ± 15%  interrupts.CPU72.CAL:Function_call_interrupts
    487036           +52.4%     742341 ±  4%  interrupts.CPU72.LOC:Local_timer_interrupts
    658.17 ± 12%    +258.0%       2356 ±  4%  interrupts.CPU72.RES:Rescheduling_interrupts
      3140 ± 19%    +808.0%      28519 ± 14%  interrupts.CPU73.CAL:Function_call_interrupts
    487006           +52.2%     741396 ±  4%  interrupts.CPU73.LOC:Local_timer_interrupts
    741.83 ± 12%    +223.5%       2400 ±  7%  interrupts.CPU73.RES:Rescheduling_interrupts
      3032 ± 16%    +834.2%      28332 ± 15%  interrupts.CPU74.CAL:Function_call_interrupts
    487026           +52.3%     741506 ±  4%  interrupts.CPU74.LOC:Local_timer_interrupts
    720.50 ± 15%    +233.9%       2405 ±  7%  interrupts.CPU74.RES:Rescheduling_interrupts
      3003 ± 16%    +846.3%      28425 ± 14%  interrupts.CPU75.CAL:Function_call_interrupts
    487028           +52.3%     741605 ±  4%  interrupts.CPU75.LOC:Local_timer_interrupts
    694.17 ± 15%    +245.4%       2397 ±  6%  interrupts.CPU75.RES:Rescheduling_interrupts
      2925 ± 20%    +858.7%      28050 ± 15%  interrupts.CPU76.CAL:Function_call_interrupts
    486998           +52.2%     741381 ±  4%  interrupts.CPU76.LOC:Local_timer_interrupts
    677.67 ± 12%    +251.1%       2379 ±  8%  interrupts.CPU76.RES:Rescheduling_interrupts
      3011 ± 22%    +847.9%      28545 ± 14%  interrupts.CPU77.CAL:Function_call_interrupts
    487138           +52.2%     741649 ±  4%  interrupts.CPU77.LOC:Local_timer_interrupts
    662.67 ± 12%    +257.7%       2370 ±  8%  interrupts.CPU77.RES:Rescheduling_interrupts
      3097 ± 20%    +824.4%      28630 ± 14%  interrupts.CPU78.CAL:Function_call_interrupts
    487107           +52.2%     741528 ±  4%  interrupts.CPU78.LOC:Local_timer_interrupts
    691.50 ± 11%    +248.5%       2409 ±  8%  interrupts.CPU78.RES:Rescheduling_interrupts
      3001 ± 17%    +849.2%      28494 ± 14%  interrupts.CPU79.CAL:Function_call_interrupts
    487080           +52.2%     741446 ±  4%  interrupts.CPU79.LOC:Local_timer_interrupts
    672.50 ± 12%    +262.3%       2436 ±  7%  interrupts.CPU79.RES:Rescheduling_interrupts
      3077 ± 16%    +807.1%      27914 ± 15%  interrupts.CPU8.CAL:Function_call_interrupts
    487014           +52.2%     741404 ±  4%  interrupts.CPU8.LOC:Local_timer_interrupts
    699.67 ± 14%    +240.1%       2379 ±  8%  interrupts.CPU8.RES:Rescheduling_interrupts
      3076 ± 15%    +829.5%      28592 ± 14%  interrupts.CPU80.CAL:Function_call_interrupts
    487016           +52.2%     741388 ±  4%  interrupts.CPU80.LOC:Local_timer_interrupts
    716.17 ± 21%    +238.4%       2423 ±  9%  interrupts.CPU80.RES:Rescheduling_interrupts
      2922 ± 17%    +880.8%      28658 ± 14%  interrupts.CPU81.CAL:Function_call_interrupts
    486965           +52.3%     741508 ±  4%  interrupts.CPU81.LOC:Local_timer_interrupts
    641.33 ± 17%    +282.6%       2453 ±  6%  interrupts.CPU81.RES:Rescheduling_interrupts
      2930 ± 18%    +869.8%      28416 ± 15%  interrupts.CPU82.CAL:Function_call_interrupts
    487018           +52.3%     741612 ±  4%  interrupts.CPU82.LOC:Local_timer_interrupts
    633.17 ± 15%    +279.7%       2404 ±  6%  interrupts.CPU82.RES:Rescheduling_interrupts
      3025 ± 17%    +844.9%      28592 ± 14%  interrupts.CPU83.CAL:Function_call_interrupts
    486935           +52.3%     741530 ±  4%  interrupts.CPU83.LOC:Local_timer_interrupts
    665.67 ± 15%    +258.8%       2388 ±  7%  interrupts.CPU83.RES:Rescheduling_interrupts
      3044 ± 18%    +833.9%      28435 ± 15%  interrupts.CPU84.CAL:Function_call_interrupts
    487201           +52.2%     741427 ±  4%  interrupts.CPU84.LOC:Local_timer_interrupts
    628.00 ± 12%    +279.8%       2385 ±  8%  interrupts.CPU84.RES:Rescheduling_interrupts
      2942 ± 16%    +863.4%      28347 ± 14%  interrupts.CPU85.CAL:Function_call_interrupts
    487042           +52.2%     741305 ±  5%  interrupts.CPU85.LOC:Local_timer_interrupts
    596.00 ± 16%    +303.1%       2402 ±  4%  interrupts.CPU85.RES:Rescheduling_interrupts
      3044 ± 17%    +837.6%      28542 ± 14%  interrupts.CPU86.CAL:Function_call_interrupts
    486993           +52.2%     741355 ±  4%  interrupts.CPU86.LOC:Local_timer_interrupts
    647.67 ± 19%    +272.2%       2410 ±  7%  interrupts.CPU86.RES:Rescheduling_interrupts
      2936 ± 19%    +865.2%      28338 ± 14%  interrupts.CPU87.CAL:Function_call_interrupts
    487005           +52.2%     741411 ±  4%  interrupts.CPU87.LOC:Local_timer_interrupts
    602.00 ± 14%    +290.0%       2347 ±  6%  interrupts.CPU87.RES:Rescheduling_interrupts
      2912 ± 16%    +881.2%      28575 ± 14%  interrupts.CPU88.CAL:Function_call_interrupts
    487115           +52.2%     741612 ±  4%  interrupts.CPU88.LOC:Local_timer_interrupts
    597.67 ± 16%    +299.4%       2386 ±  7%  interrupts.CPU88.RES:Rescheduling_interrupts
      2979 ± 18%    +855.5%      28473 ± 15%  interrupts.CPU89.CAL:Function_call_interrupts
    487078           +52.2%     741416 ±  4%  interrupts.CPU89.LOC:Local_timer_interrupts
    646.17 ± 16%    +271.6%       2401 ±  7%  interrupts.CPU89.RES:Rescheduling_interrupts
      3046 ± 14%    +823.8%      28139 ± 15%  interrupts.CPU9.CAL:Function_call_interrupts
    487114           +52.2%     741616 ±  4%  interrupts.CPU9.LOC:Local_timer_interrupts
    712.33 ± 18%    +239.6%       2419 ±  7%  interrupts.CPU9.RES:Rescheduling_interrupts
      3034 ± 16%    +845.5%      28687 ± 11%  interrupts.CPU90.CAL:Function_call_interrupts
    487326           +52.5%     742970 ±  4%  interrupts.CPU90.LOC:Local_timer_interrupts
    460.50 ± 10%    +397.9%       2292 ±  9%  interrupts.CPU90.RES:Rescheduling_interrupts
      3126 ± 18%    +818.9%      28729 ± 11%  interrupts.CPU91.CAL:Function_call_interrupts
    487370           +52.4%     742848 ±  4%  interrupts.CPU91.LOC:Local_timer_interrupts
    460.00 ±  9%    +391.1%       2259 ±  9%  interrupts.CPU91.RES:Rescheduling_interrupts
      3094 ± 19%    +829.8%      28767 ± 12%  interrupts.CPU92.CAL:Function_call_interrupts
    487351           +52.4%     742922 ±  4%  interrupts.CPU92.LOC:Local_timer_interrupts
    493.17 ±  8%    +367.0%       2303 ± 12%  interrupts.CPU92.RES:Rescheduling_interrupts
      3143 ± 16%    +807.0%      28515 ± 11%  interrupts.CPU93.CAL:Function_call_interrupts
    487320           +52.4%     742795 ±  4%  interrupts.CPU93.LOC:Local_timer_interrupts
    472.67 ±  6%    +381.7%       2276 ± 10%  interrupts.CPU93.RES:Rescheduling_interrupts
      3072 ± 17%    +828.5%      28531 ± 11%  interrupts.CPU94.CAL:Function_call_interrupts
    487359           +52.4%     742843 ±  4%  interrupts.CPU94.LOC:Local_timer_interrupts
    463.83 ±  8%    +387.7%       2262 ± 10%  interrupts.CPU94.RES:Rescheduling_interrupts
      3071 ± 19%    +839.8%      28860 ± 10%  interrupts.CPU95.CAL:Function_call_interrupts
    487324           +52.4%     742821 ±  4%  interrupts.CPU95.LOC:Local_timer_interrupts
    462.83 ± 10%    +395.6%       2293 ±  9%  interrupts.CPU95.RES:Rescheduling_interrupts
      3088 ± 18%    +833.7%      28835 ± 12%  interrupts.CPU96.CAL:Function_call_interrupts
    487363           +52.4%     742915 ±  4%  interrupts.CPU96.LOC:Local_timer_interrupts
    456.17 ±  3%    +397.0%       2267 ± 11%  interrupts.CPU96.RES:Rescheduling_interrupts
      3138 ± 16%    +817.0%      28784 ± 11%  interrupts.CPU97.CAL:Function_call_interrupts
    487336           +52.4%     742851 ±  4%  interrupts.CPU97.LOC:Local_timer_interrupts
    485.33 ±  7%    +375.3%       2306 ±  8%  interrupts.CPU97.RES:Rescheduling_interrupts
      3111 ± 19%    +825.8%      28806 ± 12%  interrupts.CPU98.CAL:Function_call_interrupts
    487340           +52.4%     742828 ±  4%  interrupts.CPU98.LOC:Local_timer_interrupts
    426.67 ±  4%    +422.8%       2230 ± 10%  interrupts.CPU98.RES:Rescheduling_interrupts
      3147 ± 14%    +817.4%      28876 ± 12%  interrupts.CPU99.CAL:Function_call_interrupts
    487380           +52.4%     742982 ±  4%  interrupts.CPU99.LOC:Local_timer_interrupts
    451.00 ±  3%    +410.4%       2302 ± 13%  interrupts.CPU99.RES:Rescheduling_interrupts
    617.83 ±  9%    +165.3%       1639        interrupts.IWI:IRQ_work_interrupts
  70124050           +52.5%  1.069e+08 ±  4%  interrupts.LOC:Local_timer_interrupts
      0.00       +1.4e+104%     144.00        interrupts.MCP:Machine_check_polls
     83786 ±  2%    +299.0%     334310 ±  7%  interrupts.RES:Rescheduling_interrupts
    207.17 ± 58%    +120.5%     456.83 ± 22%  interrupts.TLB:TLB_shootdowns


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  80000 +-------------------------------------------------------------------+   
        |                                                                   |   
  75000 |-++.+ .+   +. +.             +  +.++. +. +. +.+ .+ .+ .++. +. +.++.|   
        |.+   +  +.+  +  + .++.++.++.+ + :    +  +  +   +  +  +    +  +     |   
  70000 |-+               +             +                                   |   
        |                                                                   |   
  65000 |-+                                                                 |   
        |                                                                   |   
  60000 |-+                                                                 |   
        |                                                                   |   
  55000 |-+                                                                 |   
        |                                                                   |   
  50000 |-+                                                                 |   
        | OO OO OO OO OO OO OO  O O  O  OO OO O                             |   
  45000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_time.average.ms                    
                                                                                
  200 +---------------------------------------------------------------------+   
  180 |-+   +.       .+   +       +.      +        +.+        +     +. +.   |   
      |.+ .+  + .++.+  :  :+ +.  +  ++.  + +.+ .+. :  +.+ .+ + + +. : +  + .|   
  160 |-++     +       +.+  +  ++      ++     +   +      +  +   +  +      + |   
  140 |-+                                                                   |   
      |                                                                     |   
  120 |-+                                                                   |   
  100 |-+                                                                   |   
   80 |-+                                                                   |   
      |                                                                     |   
   60 |-+                                                                   |   
   40 |-+                                                                   |   
      |                                                                     |   
   20 |-OO OO OO OO O OO OO OO OO O OO OO OO O                              |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_and_delay.count.ms                 
                                                                                
  2.2e+06 +-----------------------------------------------------------------+   
    2e+06 |O+O  OO OO OO OO OO O O O  O  OO OO O                            |   
          |   O                 O   O  O                                    |   
  1.8e+06 |-+                                                               |   
  1.6e+06 |-+                                                               |   
  1.4e+06 |-+                                                               |   
  1.2e+06 |-+                                                               |   
          |                                                                 |   
    1e+06 |-+                                                               |   
   800000 |-+                                                               |   
   600000 |-+                                                               |   
   400000 |-+                                                               |   
          |                                                                 |   
   200000 |+.++.++.++.++.++.++.+++.++.++.++.++.++.++.+++.++.++.++.++.++.++.+|   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    perf-sched.total_wait_and_delay.average.ms                  
                                                                                
  200 +---------------------------------------------------------------------+   
  180 |-+   +.       .+   +  +    +.      +        +.+        +     +. +.   |   
      |.+ .+  + .++.+  :  :+ :+  +  ++.  + +.+ .+. :  +.+ .+ + + +. : +  + .|   
  160 |-++     +       +.+  +  ++      ++     +   +      +  +   +  +      + |   
  140 |-+                                                                   |   
      |                                                                     |   
  120 |-+                                                                   |   
  100 |-+                                                                   |   
   80 |-+                                                                   |   
      |                                                                     |   
   60 |-+                                                                   |   
   40 |-+                                                                   |   
      |                                                                     |   
   20 |-OO OO OO OO O OO OO OO OO O OO OO OO O                              |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                aim7.time.system_time                           
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                      O   O  O                                     |   
        | OO OO O   O    OO OO  O O  O                                      |   
  50000 |-+      O O  OO                OO OO O                             |   
        |                                                                   |   
        |                                                                   |   
  45000 |-+                                                                 |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  35000 |-+               +.            +                                   |   
        |.+   +. +.+ .+ .+  ++.++.++.+ + :   .+ .+ .+   +. +. +. +.++.+ .++.|   
        |  +.+  +   +  +              +  +.++  +  +  +.+  +  +  +      +    |   
  30000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  400 +---------------------------------------------------------------------+   
      | OO OO O   O    O OO    O    OO                                      |   
  380 |-+      O O  O O     O   O      OO OO O                              |   
  360 |-+                                                                   |   
      |                                                                     |   
  340 |-+                                                                   |   
  320 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  280 |-+                                                                   |   
      |                                                                     |   
  260 |-+               .+            .+                                    |   
  240 |.+   +. +.+ .+. +  +.++.++.+.++  +.++.++.+.++.++.++.++.+.++.++.+ .++.|   
      |  +.+  +   +   +                                                +    |   
  220 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  400 +---------------------------------------------------------------------+   
      | OO OO O   O    O OO    O    OO                                      |   
  380 |-+      O O  O O     O   O      OO OO O                              |   
  360 |-+                                                                   |   
      |                                                                     |   
  340 |-+                                                                   |   
  320 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  280 |-+                                                                   |   
      |                                                                     |   
  260 |-+               .+            .+                                    |   
  240 |.+   +. +.+ .+. +  +.++.++.+.++  +.++.++.+.++.++.++.++.+.++.++.+ .++.|   
      |  +.+  +   +   +                                                +    |   
  220 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             aim7.time.minor_page_faults                        
                                                                                
  420000 +------------------------------------------------------------------+   
         |                                                                  |   
  400000 |-+   O     O   O     O    O                                       |   
  380000 |O+O     OO  O O   O O  OO  O O      O                             |   
         |   O             O              OO                                |   
  360000 |-+    O                            O                              |   
         |                              O                                   |   
  340000 |-+                                                                |   
         |                                                                  |   
  320000 |++                                                                |   
  300000 |:+       +. +   .+ .++.++. +. +  +    ++   .+   +.+       .++.  .+|   
         |  + .+   : + + +  +       +  + + :+  +  + +  :  :  :.+   +    ++  |   
  280000 |-+ +  :.+     +                 +  ++    +   +.+   +  +.+         |   
         |      +                                                           |   
  260000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         aim7.time.voluntary_context_switches                   
                                                                                
  1.4e+07 +-----------------------------------------------------------------+   
          |O     O  O     O     OO  O OO    O  O                            |   
  1.2e+07 |-+   O  O  O                                                     |   
          |   O              O           OO                                 |   
    1e+07 |-+                                                               |   
          |            O                     O                              |   
    8e+06 |-+                  O   O                                        |   
          |                                                                 |   
    6e+06 |-+                                                               |   
          |                                                                 |   
    4e+06 |-+                                                               |   
          |                                                                 |   
    2e+06 |-+                                                               |   
          |+.+ .+ .+      +.      .+   +.  .++.  .+ .+++.  .+ .+   +.    +.+|   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        aim7.time.involuntary_context_switches                  
                                                                                
    7e+06 +-----------------------------------------------------------------+   
  6.5e+06 |-+O        O   O O  OO  OO          O                            |   
          |O  O OO OO    O       O    O  OO  O                              |   
    6e+06 |-+          O     O              O                               |   
  5.5e+06 |-+                                                               |   
    5e+06 |-+                                                               |   
  4.5e+06 |-+                                                               |   
          |                                                                 |   
    4e+06 |-+                                                               |   
  3.5e+06 |-+                                                               |   
    3e+06 |-+                                                               |   
  2.5e+06 |-+                                                               |   
          |+.     .+ .++.++.++.+++.++.+ .++.  .++.++.+  .++.++.++.++.++.  .+|   
    2e+06 |-+++.++  +                  +    ++        ++                ++  |   
  1.5e+06 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/f2fs/x86_64-rhel-8.3/3000/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  3d697a4a6b ("f2fs: rework write preallocations")
  4fa18391ae ("f2fs: do not expose unwritten blocks to user by DIO")

3d697a4a6b7dab8f 4fa18391ae8cf8f1e498d54b46c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     90929 ±  2%     -53.2%      42552 ±  3%  aim7.jobs-per-min
    198.30 ±  2%    +113.7%     423.70 ±  3%  aim7.time.elapsed_time
    198.30 ±  2%    +113.7%     423.70 ±  3%  aim7.time.elapsed_time.max
   2150286 ±  3%    +185.9%    6146859 ± 13%  aim7.time.involuntary_context_switches
    228185           +25.7%     286784 ±  2%  aim7.time.minor_page_faults
     16152 ±  2%    +116.7%      35004 ±  2%  aim7.time.system_time
    874119          +943.2%    9119021 ±104%  aim7.time.voluntary_context_switches
  1.14e+09           +63.2%  1.861e+09 ± 38%  cpuidle..time
    235.35 ±  2%     +95.9%     461.05 ±  3%  uptime.boot
      0.00 ±  8%      -0.0        0.00 ± 21%  mpstat.cpu.all.iowait%
      0.38 ±  7%      -0.2        0.22 ± 21%  mpstat.cpu.all.usr%
      8418 ±  8%     -55.8%       3717 ±  8%  vmstat.io.bo
    256.40 ±  2%     +66.6%     427.20 ±  6%  vmstat.procs.r
      3.04 ± 72%      -2.2        0.80 ±134%  turbostat.C6%
  36502392 ±  6%    +118.9%   79908293 ±  7%  turbostat.IRQ
     57.23            -2.9%      55.58        turbostat.RAMWatt
      4482 ±  4%     +33.8%       5994 ± 18%  slabinfo.ext4_fc_dentry_update.active_objs
      4482 ±  4%     +33.8%       5994 ± 18%  slabinfo.ext4_fc_dentry_update.num_objs
      5381 ±  2%     +12.6%       6061 ±  9%  slabinfo.ext4_io_end.active_objs
      5381 ±  2%     +12.6%       6061 ±  9%  slabinfo.ext4_io_end.num_objs
    158482           +16.8%     185095        meminfo.AnonHugePages
   1953315           -16.4%    1633057        meminfo.Dirty
   2356102           -13.1%    2048324        meminfo.Inactive
   1947087           -16.4%    1628551        meminfo.Inactive(file)
    110665 ±  5%      +3.5%     114560 ±  5%  meminfo.PageTables
      2971 ± 15%   +4198.0%     127712 ±191%  numa-meminfo.node0.Active(anon)
    977407           -16.4%     816829        numa-meminfo.node0.Dirty
   1282403 ±  2%     -12.6%    1120784        numa-meminfo.node0.Inactive
    974889           -16.4%     815389        numa-meminfo.node0.Inactive(file)
    109623 ±  5%      +3.6%     113568 ±  5%  numa-meminfo.node0.PageTables
    978964           -16.8%     814786        numa-meminfo.node1.Dirty
   1077260           -14.0%     926684 ±  2%  numa-meminfo.node1.Inactive
    975291           -16.8%     811876        numa-meminfo.node1.Inactive(file)
    770.40 ± 12%   +4039.6%      31891 ±191%  numa-vmstat.node0.nr_active_anon
    244188           -16.4%     204212        numa-vmstat.node0.nr_dirty
    243567           -16.3%     203829        numa-vmstat.node0.nr_inactive_file
     27386 ±  4%      +3.6%      28381 ±  5%  numa-vmstat.node0.nr_page_table_pages
    770.40 ± 12%   +4039.6%      31891 ±191%  numa-vmstat.node0.nr_zone_active_anon
    243564           -16.3%     203831        numa-vmstat.node0.nr_zone_inactive_file
    244226           -16.4%     204240        numa-vmstat.node0.nr_zone_write_pending
    244559           -16.7%     203834        numa-vmstat.node1.nr_dirty
    243622           -16.6%     203115        numa-vmstat.node1.nr_inactive_file
    243621           -16.6%     203117        numa-vmstat.node1.nr_zone_inactive_file
    244596           -16.7%     203855        numa-vmstat.node1.nr_zone_write_pending
    488730           -16.4%     408353        proc-vmstat.nr_dirty
    487181           -16.4%     407214        proc-vmstat.nr_inactive_file
     27654 ±  5%      +3.6%      28653 ±  5%  proc-vmstat.nr_page_table_pages
    487181           -16.4%     407214        proc-vmstat.nr_zone_inactive_file
    488798           -16.4%     408400        proc-vmstat.nr_zone_write_pending
     78832 ±  3%    +143.0%     191563 ± 40%  proc-vmstat.numa_hint_faults
     49727 ±  4%    +137.0%     117845 ± 36%  proc-vmstat.numa_hint_faults_local
    220945 ±  6%     +46.9%     324636 ± 25%  proc-vmstat.numa_pte_updates
    143107          +116.1%     309219 ± 64%  proc-vmstat.pgactivate
    997125           +64.2%    1636904 ±  7%  proc-vmstat.pgfault
     51933 ±  3%     +92.8%     100129 ±  2%  proc-vmstat.pgreuse
      1734 ±  2%      +7.5%       1865        proc-vmstat.unevictable_pgs_culled
 6.804e+09           -15.9%   5.72e+09        perf-stat.i.branch-instructions
  24882928 ±  2%     -33.1%   16658305 ±  7%  perf-stat.i.branch-misses
  66850630 ±  2%     -31.6%   45743150 ±  5%  perf-stat.i.cache-misses
 1.701e+08 ±  2%     -31.2%   1.17e+08 ±  8%  perf-stat.i.cache-references
      7.54           +25.9%       9.49        perf-stat.i.cpi
      3472 ±  4%     +50.2%       5213 ±  4%  perf-stat.i.cycles-between-cache-misses
 8.008e+09           -20.6%  6.357e+09        perf-stat.i.dTLB-loads
 2.261e+09 ±  2%     -46.7%  1.205e+09 ±  3%  perf-stat.i.dTLB-stores
     92.94            -7.0       85.98 ±  6%  perf-stat.i.iTLB-load-miss-rate%
  13564259 ±  3%     -46.2%    7302051 ±  2%  perf-stat.i.iTLB-load-misses
 2.975e+10           -18.6%  2.422e+10        perf-stat.i.instructions
      2241 ±  3%     +48.9%       3337 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.15 ±  2%     -22.4%       0.11 ±  2%  perf-stat.i.ipc
    310.75 ±  7%     -22.8%     240.04 ± 12%  perf-stat.i.metric.K/sec
    195.92           -22.3%     152.23        perf-stat.i.metric.M/sec
      4409           -19.5%       3547 ±  4%  perf-stat.i.minor-faults
  10313917 ±  2%     -18.9%    8365261 ± 13%  perf-stat.i.node-load-misses
     75.30            +4.5       79.79        perf-stat.i.node-store-miss-rate%
   9204873           -24.4%    6954712 ±  3%  perf-stat.i.node-store-misses
   2871224 ±  3%     -40.2%    1716899 ±  3%  perf-stat.i.node-stores
      4416           -19.6%       3550 ±  4%  perf-stat.i.page-faults
      5.72 ±  2%     -15.5%       4.83 ±  8%  perf-stat.overall.MPKI
      0.37            -0.1        0.29 ±  8%  perf-stat.overall.branch-miss-rate%
      7.72           +24.7%       9.62        perf-stat.overall.cpi
      3436 ±  2%     +48.9%       5115 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 31%      +0.0        0.01 ± 31%  perf-stat.overall.dTLB-store-miss-rate%
     95.11           -11.1       84.03 ± 10%  perf-stat.overall.iTLB-load-miss-rate%
      2196 ±  3%     +51.2%       3320 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.13           -19.8%       0.10        perf-stat.overall.ipc
     76.23            +4.0       80.19        perf-stat.overall.node-store-miss-rate%
 6.778e+09           -15.8%  5.708e+09        perf-stat.ps.branch-instructions
  24742062 ±  2%     -32.8%   16614599 ±  7%  perf-stat.ps.branch-misses
  66579716 ±  2%     -31.4%   45648425 ±  5%  perf-stat.ps.cache-misses
 1.694e+08 ±  2%     -31.1%  1.167e+08 ±  8%  perf-stat.ps.cache-references
 7.978e+09           -20.5%  6.343e+09        perf-stat.ps.dTLB-loads
 2.252e+09 ±  2%     -46.6%  1.203e+09 ±  3%  perf-stat.ps.dTLB-stores
  13509109 ±  3%     -46.1%    7286635 ±  2%  perf-stat.ps.iTLB-load-misses
 2.963e+10           -18.4%  2.417e+10        perf-stat.ps.instructions
      4361           -19.0%       3533 ±  4%  perf-stat.ps.minor-faults
  10270443 ±  2%     -18.7%    8348155 ± 13%  perf-stat.ps.node-load-misses
   9169754           -24.3%    6940506 ±  3%  perf-stat.ps.node-store-misses
   2861078 ±  3%     -40.1%    1713680 ±  3%  perf-stat.ps.node-stores
      4368           -19.0%       3536 ±  4%  perf-stat.ps.page-faults
 5.904e+12           +73.9%  1.026e+13 ±  2%  perf-stat.total.instructions
     95.90           -52.9       43.01        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     95.77           -52.8       42.94        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write
     61.32           -33.6       27.71        perf-profile.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
     60.09           -32.9       27.18        perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
     60.09           -32.9       27.17        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write.__generic_file_write_iter
     60.07           -32.9       27.16        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write
     59.70           -32.7       27.01        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end
     33.71           -18.9       14.84        perf-profile.calltrace.cycles-pp.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
     30.55           -17.0       13.55        perf-profile.calltrace.cycles-pp.f2fs_get_block.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
     30.44           -16.9       13.51        perf-profile.calltrace.cycles-pp.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
     30.42           -16.9       13.51        perf-profile.calltrace.cycles-pp.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin.generic_perform_write
     15.20            -8.5        6.74        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin
     15.09            -8.4        6.69        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_reserve_block
     15.09            -8.4        6.69        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block
     15.00            -8.3        6.66        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks
     14.96            -8.3        6.68        perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block.f2fs_write_begin
     14.96            -8.3        6.67        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_reserve_block
     14.96            -8.3        6.68        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_reserve_block.f2fs_get_block
     14.92            -8.3        6.66        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks
     97.87            +1.3       99.22        perf-profile.calltrace.cycles-pp.write
     97.65            +1.5       99.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     97.62            +1.5       99.09        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.54            +1.5       99.04        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.45            +1.5       99.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.26            +1.7       98.91        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.20            +1.7       98.88        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00           +54.8       54.77        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter
      0.00           +55.0       55.03        perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter.new_sync_write
      0.00           +55.1       55.11        perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00           +55.1       55.12        perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     95.91           -52.9       43.02        perf-profile.children.cycles-pp.__generic_file_write_iter
     95.79           -52.8       42.96        perf-profile.children.cycles-pp.generic_perform_write
     61.32           -33.6       27.71        perf-profile.children.cycles-pp.f2fs_write_end
     33.71           -18.9       14.84        perf-profile.children.cycles-pp.f2fs_write_begin
     30.55           -17.0       13.55        perf-profile.children.cycles-pp.f2fs_get_block
     30.55           -17.0       13.57        perf-profile.children.cycles-pp.f2fs_reserve_block
     30.54           -17.0       13.56        perf-profile.children.cycles-pp.f2fs_reserve_new_blocks
     15.40            -8.5        6.86        perf-profile.children.cycles-pp.__mark_inode_dirty
      0.98 ±  7%      -0.6        0.33 ±  6%  perf-profile.children.cycles-pp.f2fs_lookup_extent_cache
      0.60 ±  4%      -0.5        0.07 ± 17%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.82 ±  4%      -0.5        0.32 ±  2%  perf-profile.children.cycles-pp.__get_node_page
      0.62 ±  2%      -0.5        0.17 ±  6%  perf-profile.children.cycles-pp.do_sys_open
      0.62 ±  2%      -0.5        0.17 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      0.62 ±  2%      -0.5        0.17 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      0.62 ±  2%      -0.5        0.17 ±  6%  perf-profile.children.cycles-pp.path_openat
      0.61 ±  3%      -0.4        0.16 ±  4%  perf-profile.children.cycles-pp.creat64
      0.85 ±  3%      -0.4        0.43 ±  3%  perf-profile.children.cycles-pp.pagecache_get_page
      0.83 ±  3%      -0.4        0.42 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.65 ±  2%      -0.4        0.27 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.67 ±  2%      -0.4        0.31 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.62 ±  2%      -0.4        0.27 ±  4%  perf-profile.children.cycles-pp.dput
      0.48 ±  4%      -0.4        0.12 ±  3%  perf-profile.children.cycles-pp.unlink
      0.48 ±  4%      -0.4        0.12 ±  3%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.48 ±  4%      -0.4        0.12 ±  3%  perf-profile.children.cycles-pp.do_unlinkat
      0.62 ±  2%      -0.4        0.27 ±  4%  perf-profile.children.cycles-pp.__close
      0.62 ±  2%      -0.4        0.27 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.62 ±  2%      -0.4        0.27 ±  4%  perf-profile.children.cycles-pp.__fput
      0.62 ±  2%      -0.4        0.27 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      0.65 ±  3%      -0.3        0.30 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.61 ±  2%      -0.3        0.27 ±  3%  perf-profile.children.cycles-pp.evict
      0.61 ±  2%      -0.3        0.27 ±  3%  perf-profile.children.cycles-pp.f2fs_evict_inode
      0.53 ±  3%      -0.3        0.23 ±  2%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.46            -0.3        0.18 ±  4%  perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.28 ±  2%      -0.2        0.03 ± 81%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.33 ±  2%      -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.f2fs_update_dirty_page
      0.46 ±  3%      -0.2        0.26 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.32 ±  3%      -0.2        0.13 ±  5%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.33            -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
      0.24 ±  5%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.read_node_page
      0.32            -0.2        0.15        perf-profile.children.cycles-pp.f2fs_convert_inline_page
      0.31 ± 10%      -0.2        0.14 ± 12%  perf-profile.children.cycles-pp._raw_read_lock
      0.35 ±  2%      -0.2        0.20 ±  3%  perf-profile.children.cycles-pp.copyin
      0.35 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.26 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.llseek
      0.26 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.f2fs_create
      0.25 ±  3%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.f2fs_do_add_link
      0.25 ±  3%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.f2fs_add_dentry
      0.25 ±  3%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.f2fs_add_regular_entry
      0.21 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.f2fs_truncate
      0.19 ±  4%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.vfs_unlink
      0.19 ±  2%      -0.1        0.09        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.19 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.f2fs_unlink
      0.16 ±  6%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.18 ±  4%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.filemap_add_folio
      0.18 ±  4%      -0.1        0.08        perf-profile.children.cycles-pp.f2fs_update_parent_metadata
      0.17 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.f2fs_inode_synced
      0.16 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.f2fs_do_truncate_blocks
      0.15 ±  5%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.f2fs_truncate_data_blocks_range
      0.16 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.fault_in_readable
      0.18 ±  3%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.xas_load
      0.14 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.__entry_text_start
      0.13 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.12 ±  8%      -0.1        0.05        perf-profile.children.cycles-pp.__might_resched
      0.12 ±  3%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.11 ±  3%      -0.1        0.05        perf-profile.children.cycles-pp.folio_alloc
      0.12 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.f2fs_update_inode
      0.09 ±  5%      -0.1        0.03 ± 81%  perf-profile.children.cycles-pp.__fdget_pos
      0.10            -0.1        0.05        perf-profile.children.cycles-pp.security_file_permission
      0.10 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__alloc_pages
     99.52            +0.2       99.76        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.47            +0.3       99.73        perf-profile.children.cycles-pp.do_syscall_64
     97.94            +1.3       99.25        perf-profile.children.cycles-pp.write
     97.55            +1.5       99.05        perf-profile.children.cycles-pp.ksys_write
     97.47            +1.5       99.01        perf-profile.children.cycles-pp.vfs_write
     97.27            +1.7       98.92        perf-profile.children.cycles-pp.new_sync_write
     97.21            +1.7       98.89        perf-profile.children.cycles-pp.f2fs_file_write_iter
     91.52            +4.7       96.21        perf-profile.children.cycles-pp._raw_spin_lock
     90.82            +4.9       95.68        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     91.08            +5.0       96.11        perf-profile.children.cycles-pp.f2fs_inode_dirtied
     75.81           +13.5       89.31        perf-profile.children.cycles-pp.f2fs_mark_inode_dirty_sync
      0.66 ±  6%      -0.5        0.19 ±  3%  perf-profile.self.cycles-pp.f2fs_lookup_extent_cache
      0.65 ±  2%      -0.4        0.27 ±  5%  perf-profile.self.cycles-pp.folio_unlock
      0.48 ±  4%      -0.3        0.20 ±  3%  perf-profile.self.cycles-pp.f2fs_write_begin
      0.68 ±  6%      -0.2        0.47        perf-profile.self.cycles-pp.f2fs_file_write_iter
      0.32 ±  5%      -0.2        0.14 ±  5%  perf-profile.self.cycles-pp.__get_node_page
      0.70            -0.2        0.53 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.30 ± 11%      -0.2        0.14 ± 11%  perf-profile.self.cycles-pp._raw_read_lock
      0.35 ±  2%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.29 ±  3%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.17 ±  2%      -0.1        0.06 ± 10%  perf-profile.self.cycles-pp.f2fs_update_dirty_page
      0.15 ±  5%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.f2fs_write_end
      0.14 ±  6%      -0.1        0.06        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.14 ±  3%      -0.1        0.07 ±  9%  perf-profile.self.cycles-pp.xas_load
      0.13 ±  3%      -0.1        0.06        perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.11 ±  7%      -0.1        0.05        perf-profile.self.cycles-pp.__might_resched
      0.10 ±  4%      -0.1        0.04 ± 50%  perf-profile.self.cycles-pp.write
      0.11 ±  7%      -0.1        0.05        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.f2fs_inode_dirtied
     90.34            +4.9       95.21        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     16070 ±  7%    +142.5%      38965 ± 13%  softirqs.CPU0.RCU
     11696 ±  7%    +112.8%      24896 ± 51%  softirqs.CPU0.SCHED
     15170 ±  7%    +155.3%      38726 ± 12%  softirqs.CPU1.RCU
      7900 ±  4%    +167.5%      21130 ± 58%  softirqs.CPU1.SCHED
     14327 ±  7%    +174.8%      39372 ± 11%  softirqs.CPU10.RCU
      6520 ±  7%    +212.5%      20379 ± 61%  softirqs.CPU10.SCHED
     13839 ±  3%    +176.7%      38295 ± 12%  softirqs.CPU11.RCU
      6543 ±  8%    +204.6%      19932 ± 64%  softirqs.CPU11.SCHED
     13977 ±  4%    +175.1%      38456 ±  9%  softirqs.CPU12.RCU
      6912 ±  4%    +194.9%      20387 ± 59%  softirqs.CPU12.SCHED
     14092 ±  5%    +170.9%      38181 ± 12%  softirqs.CPU13.RCU
      6888 ±  4%    +192.4%      20144 ± 61%  softirqs.CPU13.SCHED
     14325 ±  5%    +173.4%      39165 ± 13%  softirqs.CPU14.RCU
      6510 ±  5%    +213.4%      20402 ± 63%  softirqs.CPU14.SCHED
     15663 ± 15%    +163.9%      41339 ± 11%  softirqs.CPU15.RCU
      6997 ±  8%    +185.7%      19990 ± 63%  softirqs.CPU15.SCHED
     14391 ±  7%    +190.4%      41788 ± 11%  softirqs.CPU16.RCU
      6446 ±  6%    +213.1%      20183 ± 61%  softirqs.CPU16.SCHED
     15202 ± 11%    +173.9%      41641 ± 11%  softirqs.CPU17.RCU
      7060 ± 12%    +164.8%      18694 ± 58%  softirqs.CPU17.SCHED
     15071 ±  8%    +175.1%      41462 ± 11%  softirqs.CPU18.RCU
      6624 ±  4%    +210.5%      20567 ± 62%  softirqs.CPU18.SCHED
     14443 ±  5%    +192.7%      42275 ± 10%  softirqs.CPU19.RCU
      6410          +215.4%      20217 ± 61%  softirqs.CPU19.SCHED
     15142 ±  8%    +158.4%      39135 ± 11%  softirqs.CPU2.RCU
      7840 ±  2%    +175.1%      21565 ± 58%  softirqs.CPU2.SCHED
     15396 ± 13%    +171.5%      41798 ± 11%  softirqs.CPU20.RCU
      6552 ±  3%    +206.7%      20099 ± 63%  softirqs.CPU20.SCHED
     14915 ±  5%    +179.7%      41716 ± 10%  softirqs.CPU21.RCU
      6546 ±  3%    +202.5%      19804 ± 61%  softirqs.CPU21.SCHED
     14300 ±  5%    +180.0%      40039 ± 11%  softirqs.CPU22.RCU
      6519          +211.5%      20310 ± 61%  softirqs.CPU22.SCHED
     14439 ±  4%    +176.6%      39935 ± 11%  softirqs.CPU23.RCU
      6749 ±  9%    +194.5%      19878 ± 63%  softirqs.CPU23.SCHED
     14086 ±  4%    +180.7%      39546 ± 10%  softirqs.CPU24.RCU
      6388          +214.4%      20089 ± 62%  softirqs.CPU24.SCHED
     14159 ±  5%    +178.1%      39373 ± 11%  softirqs.CPU25.RCU
      6470          +209.0%      19994 ± 63%  softirqs.CPU25.SCHED
     14261 ±  3%    +178.2%      39680 ± 11%  softirqs.CPU26.RCU
      6562 ±  2%    +210.6%      20380 ± 61%  softirqs.CPU26.SCHED
     14147 ±  4%    +181.8%      39865 ± 10%  softirqs.CPU27.RCU
      6405          +215.6%      20216 ± 62%  softirqs.CPU27.SCHED
     14153 ±  3%    +181.1%      39787 ± 12%  softirqs.CPU28.RCU
      6580 ±  4%    +203.9%      19996 ± 63%  softirqs.CPU28.SCHED
     14191 ±  6%    +179.4%      39648 ± 11%  softirqs.CPU29.RCU
      6431          +213.0%      20131 ± 63%  softirqs.CPU29.SCHED
     14550 ±  7%    +169.4%      39198 ± 12%  softirqs.CPU3.RCU
      7132 ±  8%    +191.3%      20773 ± 61%  softirqs.CPU3.SCHED
     14235 ±  4%    +182.9%      40272 ± 11%  softirqs.CPU30.RCU
      6378          +213.2%      19979 ± 63%  softirqs.CPU30.SCHED
     14434 ±  4%    +173.0%      39407 ±  8%  softirqs.CPU31.RCU
      6429          +210.8%      19986 ± 63%  softirqs.CPU31.SCHED
     14471 ±  5%    +179.6%      40463 ± 11%  softirqs.CPU32.RCU
      6386          +212.0%      19929 ± 63%  softirqs.CPU32.SCHED
     14262 ±  4%    +185.2%      40677 ± 10%  softirqs.CPU33.RCU
      6391          +220.1%      20460 ± 57%  softirqs.CPU33.SCHED
     14194 ±  4%    +184.8%      40423 ± 10%  softirqs.CPU34.RCU
      6332 ±  2%    +227.1%      20712 ± 62%  softirqs.CPU34.SCHED
     14306 ±  4%    +180.8%      40169 ± 11%  softirqs.CPU35.RCU
      6391          +217.2%      20273 ± 63%  softirqs.CPU35.SCHED
     14541 ±  5%    +174.3%      39883 ± 11%  softirqs.CPU36.RCU
      6595 ±  5%    +204.5%      20083 ± 62%  softirqs.CPU36.SCHED
     14453 ±  5%    +179.1%      40334 ± 11%  softirqs.CPU37.RCU
      6363          +213.3%      19936 ± 63%  softirqs.CPU37.SCHED
     14375 ±  4%    +181.8%      40509 ± 10%  softirqs.CPU38.RCU
      6328          +220.5%      20284 ± 61%  softirqs.CPU38.SCHED
     14357 ±  7%    +171.7%      39008 ± 12%  softirqs.CPU39.RCU
      6438 ±  5%    +207.3%      19787 ± 63%  softirqs.CPU39.SCHED
     14691 ±  5%    +163.3%      38678 ± 11%  softirqs.CPU4.RCU
      6922 ±  6%    +197.7%      20610 ± 60%  softirqs.CPU4.SCHED
     14464 ±  5%    +175.3%      39815 ± 11%  softirqs.CPU40.RCU
      6462 ±  4%    +209.0%      19970 ± 63%  softirqs.CPU40.SCHED
     14198 ±  5%    +180.7%      39861 ± 11%  softirqs.CPU41.RCU
      6204 ±  2%    +219.8%      19840 ± 63%  softirqs.CPU41.SCHED
     14391 ±  5%    +178.4%      40063 ± 10%  softirqs.CPU42.RCU
      6340 ±  4%    +216.7%      20078 ± 63%  softirqs.CPU42.SCHED
     14408 ±  5%    +179.8%      40314 ± 10%  softirqs.CPU43.RCU
      6238 ±  6%    +219.1%      19908 ± 63%  softirqs.CPU43.SCHED
     11472 ±  4%    +176.1%      31673 ±  9%  softirqs.CPU44.RCU
      6632 ± 11%    +208.7%      20476 ± 59%  softirqs.CPU44.SCHED
     13094 ±  4%    +184.5%      37257 ± 15%  softirqs.CPU45.RCU
      6868 ±  9%    +192.1%      20062 ± 64%  softirqs.CPU45.SCHED
     14034 ±  4%    +175.5%      38667 ±  9%  softirqs.CPU46.RCU
      6149 ±  6%    +227.8%      20155 ± 63%  softirqs.CPU46.SCHED
     14116 ±  7%    +170.0%      38111 ± 12%  softirqs.CPU47.RCU
      6489 ±  3%    +206.9%      19915 ± 65%  softirqs.CPU47.SCHED
     14489 ±  5%    +167.5%      38753 ± 12%  softirqs.CPU48.RCU
      6972 ± 12%    +191.9%      20355 ± 64%  softirqs.CPU48.SCHED
     14832 ±  8%    +166.0%      39448 ± 11%  softirqs.CPU49.RCU
      6842 ±  5%    +199.6%      20499 ± 64%  softirqs.CPU49.SCHED
     14218 ±  6%    +175.1%      39116 ± 10%  softirqs.CPU5.RCU
      7016 ±  8%    +189.9%      20337 ± 60%  softirqs.CPU5.SCHED
     14533 ±  6%    +160.9%      37916 ± 13%  softirqs.CPU50.RCU
      6278 ±  2%    +223.5%      20312 ± 63%  softirqs.CPU50.SCHED
     14426 ±  4%    +166.5%      38442 ± 12%  softirqs.CPU51.RCU
      6720          +203.2%      20375 ± 63%  softirqs.CPU51.SCHED
     15761 ± 17%    +147.9%      39064 ± 14%  softirqs.CPU52.RCU
      6518 ±  2%    +210.9%      20265 ± 63%  softirqs.CPU52.SCHED
     14310 ±  4%    +172.4%      38986 ± 11%  softirqs.CPU53.RCU
      6566 ±  2%    +210.0%      20356 ± 62%  softirqs.CPU53.SCHED
     14328 ±  4%    +172.6%      39058 ± 12%  softirqs.CPU54.RCU
      6688 ±  2%    +204.4%      20360 ± 63%  softirqs.CPU54.SCHED
     14659 ±  3%    +167.0%      39146 ± 12%  softirqs.CPU55.RCU
      6616          +208.7%      20426 ± 64%  softirqs.CPU55.SCHED
     14198 ±  4%    +174.9%      39037 ± 12%  softirqs.CPU56.RCU
      6233 ±  7%    +228.6%      20484 ± 64%  softirqs.CPU56.SCHED
     14251 ±  4%    +170.4%      38541 ± 11%  softirqs.CPU57.RCU
      6678          +208.1%      20577 ± 60%  softirqs.CPU57.SCHED
     14153 ±  5%    +163.5%      37296 ± 14%  softirqs.CPU58.RCU
      6641          +203.1%      20129 ± 63%  softirqs.CPU58.SCHED
     14565 ±  4%    +168.5%      39112 ± 11%  softirqs.CPU59.RCU
      6515 ±  5%    +216.0%      20590 ± 63%  softirqs.CPU59.SCHED
     14546 ±  4%    +163.9%      38382 ± 10%  softirqs.CPU6.RCU
      7020 ±  5%    +189.7%      20333 ± 61%  softirqs.CPU6.SCHED
     14367 ±  5%    +185.7%      41044 ± 12%  softirqs.CPU60.RCU
      6673 ±  2%    +209.5%      20652 ± 62%  softirqs.CPU60.SCHED
     14467 ±  7%    +186.0%      41373 ± 10%  softirqs.CPU61.RCU
      6428 ±  8%    +211.1%      19995 ± 61%  softirqs.CPU61.SCHED
     14646 ±  6%    +182.2%      41332 ± 11%  softirqs.CPU62.RCU
      6728 ±  2%    +201.0%      20255 ± 61%  softirqs.CPU62.SCHED
     14798 ±  8%    +177.4%      41048 ± 11%  softirqs.CPU63.RCU
      6695 ±  3%    +206.0%      20488 ± 62%  softirqs.CPU63.SCHED
     14997 ±  8%    +175.0%      41236 ± 12%  softirqs.CPU64.RCU
      6747 ±  4%    +200.9%      20307 ± 62%  softirqs.CPU64.SCHED
     14849 ±  8%    +176.8%      41096 ± 10%  softirqs.CPU65.RCU
      7213 ± 13%    +182.2%      20353 ± 61%  softirqs.CPU65.SCHED
     14197 ±  6%    +186.6%      40691 ± 11%  softirqs.CPU66.RCU
      6424          +214.6%      20212 ± 62%  softirqs.CPU66.SCHED
     14416 ±  4%    +178.8%      40186 ± 11%  softirqs.CPU67.RCU
      6834 ± 16%    +190.3%      19836 ± 64%  softirqs.CPU67.SCHED
     14052 ±  5%    +186.2%      40216 ± 10%  softirqs.CPU68.RCU
      6434          +212.5%      20106 ± 63%  softirqs.CPU68.SCHED
     14142 ±  5%    +184.0%      40169 ± 11%  softirqs.CPU69.RCU
      6261 ±  4%    +222.1%      20171 ± 64%  softirqs.CPU69.SCHED
     14347 ±  5%    +173.8%      39277 ± 13%  softirqs.CPU7.RCU
      6802 ±  5%    +197.2%      20218 ± 63%  softirqs.CPU7.SCHED
     14211 ±  4%    +181.7%      40035 ± 11%  softirqs.CPU70.RCU
      6337          +216.9%      20081 ± 63%  softirqs.CPU70.SCHED
     14131 ±  5%    +182.5%      39917 ± 12%  softirqs.CPU71.RCU
      6444 ±  2%    +208.6%      19885 ± 63%  softirqs.CPU71.SCHED
     14058 ±  4%    +186.9%      40334 ± 11%  softirqs.CPU72.RCU
      6160 ±  4%    +224.3%      19978 ± 64%  softirqs.CPU72.SCHED
     14369 ±  5%    +179.5%      40164 ± 11%  softirqs.CPU73.RCU
      6372 ±  3%    +215.1%      20078 ± 64%  softirqs.CPU73.SCHED
     14151 ±  4%    +182.3%      39946 ± 11%  softirqs.CPU74.RCU
      6388          +213.2%      20006 ± 64%  softirqs.CPU74.SCHED
     13433 ±  4%    +170.6%      36347 ± 10%  softirqs.CPU75.RCU
      6345          +212.9%      19852 ± 64%  softirqs.CPU75.SCHED
     13655 ±  4%    +167.3%      36501 ± 11%  softirqs.CPU76.RCU
      6414          +211.9%      20008 ± 63%  softirqs.CPU76.SCHED
     13500 ±  4%    +175.0%      37126 ± 11%  softirqs.CPU77.RCU
      6478 ±  2%    +208.4%      19976 ± 64%  softirqs.CPU77.SCHED
     13530 ±  3%    +170.9%      36652 ± 11%  softirqs.CPU78.RCU
      6350 ±  2%    +215.2%      20016 ± 64%  softirqs.CPU78.SCHED
     13783 ±  6%    +166.3%      36708 ± 11%  softirqs.CPU79.RCU
      6359          +215.5%      20063 ± 64%  softirqs.CPU79.SCHED
     14775 ±  4%    +162.1%      38732 ± 14%  softirqs.CPU8.RCU
      6879 ±  8%    +203.2%      20861 ± 62%  softirqs.CPU8.SCHED
     13722 ±  2%    +165.6%      36443 ± 11%  softirqs.CPU80.RCU
      6914 ±  8%    +189.4%      20011 ± 64%  softirqs.CPU80.SCHED
     13773 ±  5%    +166.1%      36647 ± 12%  softirqs.CPU81.RCU
      6894 ±  7%    +186.0%      19719 ± 65%  softirqs.CPU81.SCHED
     13420 ±  4%    +169.6%      36180 ± 11%  softirqs.CPU82.RCU
      6363          +213.2%      19930 ± 64%  softirqs.CPU82.SCHED
     13462 ±  4%    +172.6%      36691 ± 11%  softirqs.CPU83.RCU
      6345          +210.1%      19678 ± 66%  softirqs.CPU83.SCHED
     13822 ±  6%    +166.0%      36765 ± 11%  softirqs.CPU84.RCU
      6436 ±  2%    +209.4%      19916 ± 64%  softirqs.CPU84.SCHED
     13587 ±  6%    +168.9%      36536 ± 11%  softirqs.CPU85.RCU
      6646 ±  8%    +200.6%      19976 ± 64%  softirqs.CPU85.SCHED
     13790 ±  7%    +164.4%      36454 ± 12%  softirqs.CPU86.RCU
      6366          +218.5%      20275 ± 65%  softirqs.CPU86.SCHED
     14165 ±  4%    +159.3%      36733 ± 11%  softirqs.CPU87.RCU
      6303 ±  5%    +216.3%      19933 ± 63%  softirqs.CPU87.SCHED
     15184 ±  9%    +152.6%      38350 ± 12%  softirqs.CPU9.RCU
      6635 ±  7%    +205.1%      20245 ± 62%  softirqs.CPU9.SCHED
   1259928 ±  4%    +173.7%    3448251 ± 11%  softirqs.RCU
    585046          +204.4%    1781134 ± 62%  softirqs.SCHED
     43092 ±  3%     +92.6%      82983 ±  3%  softirqs.TIMER
    615536          +423.4%    3221540 ± 91%  interrupts.CAL:Function_call_interrupts
      7642 ± 10%    +383.6%      36955 ± 92%  interrupts.CPU0.CAL:Function_call_interrupts
    387376 ±  7%    +119.2%     849204 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
      3620 ± 20%    +111.8%       7669 ± 49%  interrupts.CPU0.RES:Rescheduling_interrupts
      6424 ± 11%    +463.5%      36199 ± 92%  interrupts.CPU1.CAL:Function_call_interrupts
    380497 ± 11%    +123.2%     849354 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
      3178 ± 17%    +126.2%       7188 ± 45%  interrupts.CPU1.RES:Rescheduling_interrupts
      7335 ± 16%    +407.3%      37212 ± 91%  interrupts.CPU10.CAL:Function_call_interrupts
    388720 ±  7%    +118.5%     849232 ±  3%  interrupts.CPU10.LOC:Local_timer_interrupts
      6838 ± 11%    +439.1%      36865 ± 94%  interrupts.CPU11.CAL:Function_call_interrupts
    389069 ±  7%    +118.2%     849037 ±  3%  interrupts.CPU11.LOC:Local_timer_interrupts
      3410 ± 21%    +114.6%       7318 ± 52%  interrupts.CPU11.RES:Rescheduling_interrupts
      7341 ± 16%    +398.5%      36598 ± 93%  interrupts.CPU12.CAL:Function_call_interrupts
    388730 ±  7%    +118.4%     849137 ±  3%  interrupts.CPU12.LOC:Local_timer_interrupts
      6642 ± 16%    +457.8%      37048 ± 92%  interrupts.CPU13.CAL:Function_call_interrupts
    388874 ±  7%    +118.4%     849167 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
      3519 ± 28%    +123.5%       7864 ± 50%  interrupts.CPU13.RES:Rescheduling_interrupts
      6402 ±  7%    +494.1%      38031 ± 91%  interrupts.CPU14.CAL:Function_call_interrupts
    389043 ±  7%    +118.3%     849216 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
      3192 ± 16%    +155.5%       8156 ± 44%  interrupts.CPU14.RES:Rescheduling_interrupts
      7059 ± 12%    +419.5%      36669 ± 93%  interrupts.CPU15.CAL:Function_call_interrupts
    388754 ±  7%    +118.4%     849016 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
      3472 ± 15%    +108.9%       7255 ± 50%  interrupts.CPU15.RES:Rescheduling_interrupts
      6818 ±  8%    +456.7%      37956 ± 94%  interrupts.CPU16.CAL:Function_call_interrupts
    388739 ±  7%    +118.5%     849227 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
      3848 ± 12%    +116.5%       8331 ± 56%  interrupts.CPU16.RES:Rescheduling_interrupts
      6371 ±  5%    +405.0%      32178 ± 92%  interrupts.CPU17.CAL:Function_call_interrupts
    388878 ±  7%    +118.4%     849333 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
      3170 ± 14%    +108.6%       6615 ± 43%  interrupts.CPU17.RES:Rescheduling_interrupts
      7237 ± 11%    +406.2%      36636 ± 94%  interrupts.CPU18.CAL:Function_call_interrupts
    388818 ±  7%    +118.4%     849168 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
      6703 ± 12%    +447.8%      36722 ± 95%  interrupts.CPU19.CAL:Function_call_interrupts
    388737 ±  7%    +118.5%     849230 ±  3%  interrupts.CPU19.LOC:Local_timer_interrupts
      7211 ± 13%    +413.6%      37042 ± 93%  interrupts.CPU2.CAL:Function_call_interrupts
    388716 ±  7%    +118.5%     849295 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
      3359 ± 15%    +112.9%       7153 ± 51%  interrupts.CPU2.RES:Rescheduling_interrupts
      6591 ±  7%    +461.9%      37036 ± 92%  interrupts.CPU20.CAL:Function_call_interrupts
    388559 ±  7%    +118.5%     849091 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
      3421 ± 12%    +128.5%       7817 ± 47%  interrupts.CPU20.RES:Rescheduling_interrupts
      6817 ±  8%    +435.5%      36507 ± 95%  interrupts.CPU21.CAL:Function_call_interrupts
    388842 ±  7%    +118.4%     849238 ±  3%  interrupts.CPU21.LOC:Local_timer_interrupts
      7216 ± 11%    +406.6%      36559 ± 89%  interrupts.CPU22.CAL:Function_call_interrupts
    390366 ±  6%    +117.5%     849170 ±  3%  interrupts.CPU22.LOC:Local_timer_interrupts
      3918 ± 20%    +118.7%       8569 ± 53%  interrupts.CPU22.RES:Rescheduling_interrupts
      7698 ±  7%    +365.6%      35846 ± 88%  interrupts.CPU23.CAL:Function_call_interrupts
    390440 ±  6%    +117.5%     849167 ±  3%  interrupts.CPU23.LOC:Local_timer_interrupts
      4061 ± 12%     +84.1%       7476 ± 52%  interrupts.CPU23.RES:Rescheduling_interrupts
      7153 ±  7%    +404.3%      36078 ± 88%  interrupts.CPU24.CAL:Function_call_interrupts
    390475 ±  6%    +117.5%     849162 ±  3%  interrupts.CPU24.LOC:Local_timer_interrupts
      3495 ± 15%    +117.8%       7612 ± 49%  interrupts.CPU24.RES:Rescheduling_interrupts
      7266 ±  7%    +389.2%      35552 ± 92%  interrupts.CPU25.CAL:Function_call_interrupts
    390503 ±  6%    +117.5%     849300 ±  3%  interrupts.CPU25.LOC:Local_timer_interrupts
      6754 ± 13%    +440.9%      36531 ± 89%  interrupts.CPU26.CAL:Function_call_interrupts
    390568 ±  6%    +117.4%     849144 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
      3125 ± 26%    +147.2%       7727 ± 58%  interrupts.CPU26.RES:Rescheduling_interrupts
      6823 ± 12%    +433.5%      36404 ± 90%  interrupts.CPU27.CAL:Function_call_interrupts
    390444 ±  6%    +117.5%     849273 ±  3%  interrupts.CPU27.LOC:Local_timer_interrupts
      6731 ±  7%    +439.2%      36294 ± 89%  interrupts.CPU28.CAL:Function_call_interrupts
    390455 ±  6%    +117.5%     849149 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
      6430 ± 11%    +476.0%      37036 ± 88%  interrupts.CPU29.CAL:Function_call_interrupts
    390516 ±  6%    +117.4%     849097 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
      3095 ± 17%    +159.4%       8029 ± 51%  interrupts.CPU29.RES:Rescheduling_interrupts
      6434 ±  5%    +471.7%      36786 ± 93%  interrupts.CPU3.CAL:Function_call_interrupts
    388744 ±  7%    +118.5%     849247 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
      3230 ±  7%    +125.6%       7286 ± 50%  interrupts.CPU3.RES:Rescheduling_interrupts
      7285 ± 10%    +396.8%      36198 ± 91%  interrupts.CPU30.CAL:Function_call_interrupts
    390345 ±  6%    +117.5%     849103 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
      7124 ± 10%    +418.7%      36952 ± 87%  interrupts.CPU31.CAL:Function_call_interrupts
    390540 ±  6%    +117.4%     849133 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
      3535 ± 20%    +124.4%       7935 ± 49%  interrupts.CPU31.RES:Rescheduling_interrupts
      7139 ±  8%    +406.7%      36171 ± 90%  interrupts.CPU32.CAL:Function_call_interrupts
    390387 ±  6%    +117.5%     849102 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
      7225 ± 11%    +395.6%      35812 ± 90%  interrupts.CPU33.CAL:Function_call_interrupts
    390604 ±  6%    +117.4%     849209 ±  3%  interrupts.CPU33.LOC:Local_timer_interrupts
      7198 ±  3%    +400.2%      36009 ± 88%  interrupts.CPU34.CAL:Function_call_interrupts
    390498 ±  6%    +117.5%     849142 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
      3652 ±  9%    +112.9%       7775 ± 53%  interrupts.CPU34.RES:Rescheduling_interrupts
      6965 ±  6%    +413.1%      35736 ± 90%  interrupts.CPU35.CAL:Function_call_interrupts
    390625 ±  6%    +117.4%     849189 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
      7451 ± 17%    +385.4%      36166 ± 89%  interrupts.CPU36.CAL:Function_call_interrupts
    390622 ±  6%    +117.4%     849106 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
      6702 ±  8%    +445.2%      36541 ± 87%  interrupts.CPU37.CAL:Function_call_interrupts
    390478 ±  6%    +117.5%     849116 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
      3040 ± 15%    +165.0%       8058 ± 48%  interrupts.CPU37.RES:Rescheduling_interrupts
      7555 ±  6%    +375.5%      35924 ± 90%  interrupts.CPU38.CAL:Function_call_interrupts
    390510 ±  6%    +117.5%     849202 ±  3%  interrupts.CPU38.LOC:Local_timer_interrupts
      7351 ± 11%    +387.0%      35804 ± 92%  interrupts.CPU39.CAL:Function_call_interrupts
    390552 ±  6%    +117.4%     849179 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
      7614 ± 12%    +384.1%      36865 ± 92%  interrupts.CPU4.CAL:Function_call_interrupts
    389005 ±  7%    +118.2%     848944 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
      7111 ± 12%    +416.6%      36737 ± 88%  interrupts.CPU40.CAL:Function_call_interrupts
    390368 ±  6%    +117.5%     849130 ±  3%  interrupts.CPU40.LOC:Local_timer_interrupts
      3551 ± 25%    +122.9%       7915 ± 51%  interrupts.CPU40.RES:Rescheduling_interrupts
      7215 ±  9%    +396.0%      35791 ± 90%  interrupts.CPU41.CAL:Function_call_interrupts
    390468 ±  6%    +117.5%     849083 ±  3%  interrupts.CPU41.LOC:Local_timer_interrupts
      7134 ±  6%    +403.5%      35918 ± 90%  interrupts.CPU42.CAL:Function_call_interrupts
    390266 ±  6%    +117.6%     849122 ±  3%  interrupts.CPU42.LOC:Local_timer_interrupts
      8083 ±  4%    +376.7%      38528 ± 86%  interrupts.CPU43.CAL:Function_call_interrupts
    390606 ±  6%    +117.4%     849146 ±  3%  interrupts.CPU43.LOC:Local_timer_interrupts
      4303 ± 11%    +121.2%       9519 ± 55%  interrupts.CPU43.RES:Rescheduling_interrupts
      6523 ±  3%    +458.3%      36418 ± 94%  interrupts.CPU44.CAL:Function_call_interrupts
    389317 ±  6%    +118.2%     849345 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
      6358 ± 12%    +471.0%      36306 ± 94%  interrupts.CPU45.CAL:Function_call_interrupts
    389508 ±  6%    +118.0%     849135 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
      3130 ± 24%    +126.8%       7099 ± 50%  interrupts.CPU45.RES:Rescheduling_interrupts
      6516 ±  7%    +468.8%      37063 ± 94%  interrupts.CPU46.CAL:Function_call_interrupts
    388793 ±  7%    +118.4%     849154 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
      3426 ± 15%    +113.0%       7296 ± 49%  interrupts.CPU46.RES:Rescheduling_interrupts
      6581 ±  6%    +458.0%      36723 ± 94%  interrupts.CPU47.CAL:Function_call_interrupts
    388699 ±  7%    +118.5%     849204 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
      3433 ± 14%    +108.0%       7143 ± 49%  interrupts.CPU47.RES:Rescheduling_interrupts
      7456 ± 13%    +408.6%      37926 ± 93%  interrupts.CPU48.CAL:Function_call_interrupts
    388895 ±  7%    +118.3%     849032 ±  3%  interrupts.CPU48.LOC:Local_timer_interrupts
      6408 ± 11%    +481.7%      37273 ± 92%  interrupts.CPU49.CAL:Function_call_interrupts
    388926 ±  7%    +118.4%     849291 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
      3200 ± 21%    +133.1%       7460 ± 43%  interrupts.CPU49.RES:Rescheduling_interrupts
      6725 ±  8%    +451.1%      37061 ± 93%  interrupts.CPU5.CAL:Function_call_interrupts
    388665 ±  7%    +118.5%     849243 ±  3%  interrupts.CPU5.LOC:Local_timer_interrupts
      3178 ± 12%    +137.8%       7558 ± 52%  interrupts.CPU5.RES:Rescheduling_interrupts
      6486 ±  6%    +476.0%      37363 ± 93%  interrupts.CPU50.CAL:Function_call_interrupts
    388802 ±  7%    +118.4%     849225 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
      3410 ± 15%    +120.9%       7533 ± 45%  interrupts.CPU50.RES:Rescheduling_interrupts
      6693 ±  8%    +452.6%      36982 ± 94%  interrupts.CPU51.CAL:Function_call_interrupts
    388939 ±  7%    +118.3%     849245 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
    388889 ±  7%    +118.4%     849245 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
      6706 ±  8%    +461.8%      37676 ± 94%  interrupts.CPU53.CAL:Function_call_interrupts
    388872 ±  7%    +118.4%     849194 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
      3536 ± 15%    +118.0%       7709 ± 53%  interrupts.CPU53.RES:Rescheduling_interrupts
      6881 ±  7%    +440.7%      37208 ± 92%  interrupts.CPU54.CAL:Function_call_interrupts
    388838 ±  7%    +118.4%     849273 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
      3688 ± 14%    +101.3%       7424 ± 42%  interrupts.CPU54.RES:Rescheduling_interrupts
      6766 ±  6%    +439.3%      36492 ± 94%  interrupts.CPU55.CAL:Function_call_interrupts
    388854 ±  7%    +118.4%     849434 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
      3552 ± 13%     +96.2%       6968 ± 49%  interrupts.CPU55.RES:Rescheduling_interrupts
      7038 ± 16%    +430.0%      37300 ± 93%  interrupts.CPU56.CAL:Function_call_interrupts
    388685 ±  7%    +118.5%     849330 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
      6216 ±  7%    +485.1%      36371 ± 94%  interrupts.CPU57.CAL:Function_call_interrupts
    388824 ±  7%    +118.5%     849427 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
      3073 ± 12%    +123.7%       6875 ± 49%  interrupts.CPU57.RES:Rescheduling_interrupts
      6798 ±  9%    +453.6%      37640 ± 94%  interrupts.CPU58.CAL:Function_call_interrupts
    388740 ±  7%    +118.5%     849206 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
      6742 ± 12%    +465.8%      38147 ± 93%  interrupts.CPU59.CAL:Function_call_interrupts
    388837 ±  7%    +118.4%     849245 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
      3702 ± 24%    +115.4%       7976 ± 46%  interrupts.CPU59.RES:Rescheduling_interrupts
      7071 ±  5%    +415.7%      36466 ± 93%  interrupts.CPU6.CAL:Function_call_interrupts
    388599 ±  7%    +118.6%     849384 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
      3756 ± 13%     +88.9%       7094 ± 46%  interrupts.CPU6.RES:Rescheduling_interrupts
      6960 ± 12%    +429.0%      36826 ± 95%  interrupts.CPU60.CAL:Function_call_interrupts
    388631 ±  7%    +118.5%     849268 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
      6342 ±  3%    +478.8%      36709 ± 92%  interrupts.CPU61.CAL:Function_call_interrupts
    388764 ±  7%    +118.5%     849308 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
      3132 ±  8%    +128.2%       7147 ± 39%  interrupts.CPU61.RES:Rescheduling_interrupts
      7166 ±  8%    +415.7%      36960 ± 93%  interrupts.CPU62.CAL:Function_call_interrupts
    388714 ±  7%    +118.4%     849100 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
      6830 ±  7%    +431.5%      36306 ± 93%  interrupts.CPU63.CAL:Function_call_interrupts
    388727 ±  7%    +118.5%     849278 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
      3606 ± 11%     +97.2%       7110 ± 47%  interrupts.CPU63.RES:Rescheduling_interrupts
      6157 ±  4%    +504.8%      37241 ± 94%  interrupts.CPU64.CAL:Function_call_interrupts
    388562 ±  7%    +118.6%     849206 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
      3021 ±  6%    +159.5%       7841 ± 55%  interrupts.CPU64.RES:Rescheduling_interrupts
    388542 ±  7%    +118.6%     849230 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
      7508 ± 14%    +380.9%      36113 ± 90%  interrupts.CPU66.CAL:Function_call_interrupts
    390568 ±  6%    +117.4%     849172 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
      7378 ± 10%    +392.7%      36354 ± 90%  interrupts.CPU67.CAL:Function_call_interrupts
    390659 ±  6%    +117.4%     849167 ±  3%  interrupts.CPU67.LOC:Local_timer_interrupts
      6935 ±  7%    +427.9%      36612 ± 87%  interrupts.CPU68.CAL:Function_call_interrupts
    390734 ±  6%    +117.3%     849231 ±  3%  interrupts.CPU68.LOC:Local_timer_interrupts
      3319 ± 16%    +135.0%       7801 ± 44%  interrupts.CPU68.RES:Rescheduling_interrupts
      7400 ± 11%    +405.5%      37410 ± 88%  interrupts.CPU69.CAL:Function_call_interrupts
    390590 ±  6%    +117.4%     849186 ±  3%  interrupts.CPU69.LOC:Local_timer_interrupts
      3730 ± 19%    +109.6%       7820 ± 53%  interrupts.CPU69.RES:Rescheduling_interrupts
      6899 ± 15%    +438.8%      37177 ± 92%  interrupts.CPU7.CAL:Function_call_interrupts
    388810 ±  7%    +118.4%     849273 ±  3%  interrupts.CPU7.LOC:Local_timer_interrupts
      3700 ± 28%    +113.8%       7909 ± 50%  interrupts.CPU7.RES:Rescheduling_interrupts
      7103 ±  2%    +409.1%      36160 ± 91%  interrupts.CPU70.CAL:Function_call_interrupts
    390675 ±  6%    +117.4%     849167 ±  3%  interrupts.CPU70.LOC:Local_timer_interrupts
      7491 ±  7%    +377.7%      35780 ± 90%  interrupts.CPU71.CAL:Function_call_interrupts
    390620 ±  6%    +117.4%     849196 ±  3%  interrupts.CPU71.LOC:Local_timer_interrupts
      7438 ± 11%    +392.3%      36619 ± 89%  interrupts.CPU72.CAL:Function_call_interrupts
    390519 ±  6%    +117.5%     849200 ±  3%  interrupts.CPU72.LOC:Local_timer_interrupts
      6536 ±  8%    +469.0%      37197 ± 88%  interrupts.CPU73.CAL:Function_call_interrupts
    390615 ±  6%    +117.4%     849177 ±  3%  interrupts.CPU73.LOC:Local_timer_interrupts
      3003 ± 19%    +166.1%       7993 ± 49%  interrupts.CPU73.RES:Rescheduling_interrupts
      6692 ±  8%    +450.3%      36828 ± 88%  interrupts.CPU74.CAL:Function_call_interrupts
    390533 ±  6%    +117.4%     849163 ±  3%  interrupts.CPU74.LOC:Local_timer_interrupts
      3099 ± 17%    +152.2%       7818 ± 49%  interrupts.CPU74.RES:Rescheduling_interrupts
      7087 ±  7%    +418.7%      36760 ± 89%  interrupts.CPU75.CAL:Function_call_interrupts
    390754 ±  6%    +117.3%     849249 ±  3%  interrupts.CPU75.LOC:Local_timer_interrupts
      3499 ± 13%    +126.3%       7919 ± 52%  interrupts.CPU75.RES:Rescheduling_interrupts
      7517 ± 11%    +381.3%      36180 ± 90%  interrupts.CPU76.CAL:Function_call_interrupts
    390640 ±  6%    +117.4%     849185 ±  3%  interrupts.CPU76.LOC:Local_timer_interrupts
      7406 ±  5%    +386.6%      36042 ± 91%  interrupts.CPU77.CAL:Function_call_interrupts
    390601 ±  6%    +117.4%     849253 ±  3%  interrupts.CPU77.LOC:Local_timer_interrupts
      6893 ±  5%    +429.4%      36494 ± 90%  interrupts.CPU78.CAL:Function_call_interrupts
    390719 ±  6%    +117.3%     849096 ±  3%  interrupts.CPU78.LOC:Local_timer_interrupts
      3361 ±  7%    +121.8%       7455 ± 54%  interrupts.CPU78.RES:Rescheduling_interrupts
      6978 ±  7%    +420.2%      36296 ± 91%  interrupts.CPU79.CAL:Function_call_interrupts
    390688 ±  6%    +117.4%     849222 ±  3%  interrupts.CPU79.LOC:Local_timer_interrupts
      6997 ±  8%    +426.7%      36856 ± 92%  interrupts.CPU8.CAL:Function_call_interrupts
    388855 ±  7%    +118.4%     849266 ±  3%  interrupts.CPU8.LOC:Local_timer_interrupts
      3779 ± 14%    +104.9%       7744 ± 45%  interrupts.CPU8.RES:Rescheduling_interrupts
      6539 ±  8%    +453.8%      36214 ± 92%  interrupts.CPU80.CAL:Function_call_interrupts
    390742 ±  6%    +117.3%     849168 ±  3%  interrupts.CPU80.LOC:Local_timer_interrupts
      3010 ± 17%    +136.6%       7124 ± 64%  interrupts.CPU80.RES:Rescheduling_interrupts
      6863 ± 10%    +425.8%      36083 ± 89%  interrupts.CPU81.CAL:Function_call_interrupts
    390652 ±  6%    +117.4%     849154 ±  3%  interrupts.CPU81.LOC:Local_timer_interrupts
      3419 ± 15%    +116.8%       7413 ± 49%  interrupts.CPU81.RES:Rescheduling_interrupts
      7915 ±  8%    +359.6%      36378 ± 91%  interrupts.CPU82.CAL:Function_call_interrupts
    390600 ±  6%    +117.4%     849219 ±  3%  interrupts.CPU82.LOC:Local_timer_interrupts
      7126 ±  7%    +408.0%      36204 ± 90%  interrupts.CPU83.CAL:Function_call_interrupts
    390593 ±  6%    +117.4%     849229 ±  3%  interrupts.CPU83.LOC:Local_timer_interrupts
      6958 ±  4%    +435.5%      37262 ± 88%  interrupts.CPU84.CAL:Function_call_interrupts
    390708 ±  6%    +117.4%     849259 ±  3%  interrupts.CPU84.LOC:Local_timer_interrupts
      3378 ± 10%    +139.9%       8102 ± 47%  interrupts.CPU84.RES:Rescheduling_interrupts
      7234 ±  8%    +402.3%      36335 ± 91%  interrupts.CPU85.CAL:Function_call_interrupts
    390560 ±  6%    +117.4%     849212 ±  3%  interrupts.CPU85.LOC:Local_timer_interrupts
      7163 ± 10%    +402.6%      36002 ± 92%  interrupts.CPU86.CAL:Function_call_interrupts
    390301 ±  6%    +117.6%     849259 ±  3%  interrupts.CPU86.LOC:Local_timer_interrupts
      7377 ± 11%    +396.9%      36656 ± 89%  interrupts.CPU87.CAL:Function_call_interrupts
    390784 ±  6%    +117.3%     849128 ±  3%  interrupts.CPU87.LOC:Local_timer_interrupts
      6735 ± 11%    +449.9%      37035 ± 93%  interrupts.CPU9.CAL:Function_call_interrupts
    388678 ±  7%    +118.5%     849289 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
      3564 ± 18%    +113.7%       7617 ± 49%  interrupts.CPU9.RES:Rescheduling_interrupts
  34282586 ±  6%    +118.0%   74729713 ±  3%  interrupts.LOC:Local_timer_interrupts
    317089          +109.1%     662999 ± 51%  interrupts.RES:Rescheduling_interrupts





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.16.0-rc1-00006-g4fa18391ae8c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.16.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
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
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
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
CONFIG_X86_MCE_AMD=y
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
CONFIG_MICROCODE_AMD=y
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
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

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
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
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
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
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
CONFIG_CLEANCACHE=y
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
CONFIG_NFT_COUNTER=m
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
CONFIG_HYPERV_VSOCKETS=m
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

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

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
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

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
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
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
# CONFIG_BLK_DEV_RSXX is not set

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
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
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
# CONFIG_MICROSOFT_MANA is not set
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
# CONFIG_MDIO_MSCC_MIIM is not set
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
# CONFIG_HYPERV_NET is not set
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
# CONFIG_RMI4_F54 is not set
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
CONFIG_HYPERV_KEYBOARD=m
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
CONFIG_HW_RANDOM_AMD=m
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
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
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
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
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
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
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
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
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
CONFIG_SP5100_TCO=m
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
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
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
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
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
CONFIG_DRM_GEM_SHMEM_HELPER=y

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
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
CONFIG_FB_HYPERV=m
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
CONFIG_HID_CHICONY=m
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
CONFIG_HID_HYPERV_MOUSE=m
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
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
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
CONFIG_UIO_HV_GENERIC=m
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
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
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
CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
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
CONFIG_HYPERV_IOMMU=y
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
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
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
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
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
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_TEST=m
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
# CONFIG_CRYPTO_OFB is not set
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
# CONFIG_CRYPTO_SM4 is not set
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

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
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
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
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
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
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
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_MULTI_DIRECT=y
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
CONFIG_X86_DECODER_SELFTEST=y
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
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
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
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
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
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='aim7-fs-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cpl-4sp1'
	export tbox_group='lkp-cpl-4sp1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='61a7cc61404f94adc04f6ae4'
	export job_file='/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-4fa18391ae8cf8f1e498d54b46c571aebf3a-20211202-44480-rnzh46-5.yaml'
	export id='6bb32298ef02538851c85a074b0fc4b357a27da9'
	export queuer_version='/lkp-src'
	export model='Cooper Lake'
	export nr_node=4
	export nr_cpu=144
	export memory='128G'
	export nr_hdd_partitions=
	export nr_ssd_partitions=2
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part4
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part5'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part3'
	export kernel_cmdline_hw='acpi_rsdp=0x695fd014'
	export brand='Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz'
	export commit='4fa18391ae8cf8f1e498d54b46c571aebf3aa806'
	export need_kconfig_hw='{"IGB"=>"y"}
SATA_AHCI'
	export ucode='0x700001e'
	export bisect_dmesg=true
	export need_kconfig='{"BLK_DEV_RAM"=>"m"}
{"BLK_DEV"=>"y"}
{"BLOCK"=>"y"}
F2FS_FS'
	export enqueue_time='2021-12-02 03:26:25 +0800'
	export _id='61a7cc75404f94adc04f6ae6'
	export _rt='/result/aim7/performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='bf0fda4549f73d5a2b7e76f3ccd42e876c1ac3df'
	export base_commit='d58071a8a76d779eedab38033ae4c821c30295a5'
	export branch='jaegeuk-f2fs/dev-test'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/aim7/performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/3'
	export scheduler_version='/lkp/lkp/.src-20211201-170053'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-4fa18391ae8cf8f1e498d54b46c571aebf3a-20211202-44480-rnzh46-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=jaegeuk-f2fs/dev-test
commit=4fa18391ae8cf8f1e498d54b46c571aebf3aa806
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/vmlinuz-5.16.0-rc1-00006-g4fa18391ae8c
acpi_rsdp=0x695fd014
max_uptime=2100
RESULT_ROOT=/result/aim7/performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211128.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-4f0dda359c45-1_20211127.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20211201.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.16.0-rc3'
	export repeat_to=6
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/vmlinuz-5.16.0-rc1-00006-g4fa18391ae8c'
	export dequeue_time='2021-12-02 03:30:44 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-4fa18391ae8cf8f1e498d54b46c571aebf3a-20211202-44480-rnzh46-5.cgz'

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

	run_setup nr_brd=1 ramdisk_size=51539607552 $LKP_SRC/setup/disk

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='disk_cp' load=3000 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=15 $LKP_SRC/stats/wrapper perf-profile
	env test='disk_cp' load=3000 $LKP_SRC/stats/wrapper aim7
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

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/aim7-fs-1brd.yaml:
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 1BRD_48G
fs: f2fs
aim7:
  test: disk_cp
  load: 3000
job_origin: aim7-fs-1brd.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cpl-4sp1
tbox_group: lkp-cpl-4sp1
kconfig: x86_64-rhel-8.3
submit_id: 61a7950f404f9487ffdc16d8
job_file: "/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-4fa18391ae8cf8f1e498d54b46c571aebf3a-20211202-34815-1dy4zoi-2.yaml"
id: 240fba613ac36d2f787d0526b26abb7eaf653462
queuer_version: "/lkp-src"
:#! hosts/lkp-cpl-4sp1:
model: Cooper Lake
nr_node: 4
nr_cpu: 144
memory: 128G
nr_hdd_partitions:
nr_ssd_partitions: 2
hdd_partitions:
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part4"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part5"
swap_partitions:
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part3"
kernel_cmdline_hw: acpi_rsdp=0x695fd014
brand: Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz
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
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: 4fa18391ae8cf8f1e498d54b46c571aebf3aa806
:#! include/testbox/lkp-cpl-4sp1:
need_kconfig_hw:
- IGB: y
- SATA_AHCI
ucode: '0x700001e'
bisect_dmesg: true
:#! include/disk/nr_brd:
need_kconfig:
- BLK_DEV_RAM: m
- BLK_DEV: y
- BLOCK: y
- F2FS_FS
:#! include/fs/OTHERS:
enqueue_time: 2021-12-01 23:30:25.129739109 +08:00
_id: 61a7a2a4404f9487ffdc16da
_rt: "/result/aim7/performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: bf0fda4549f73d5a2b7e76f3ccd42e876c1ac3df
base_commit: d58071a8a76d779eedab38033ae4c821c30295a5
branch: linux-devel/devel-hourly-20211130-171334
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/aim7/performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/0"
scheduler_version: "/lkp/lkp/.src-20211201-170053"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-4fa18391ae8cf8f1e498d54b46c571aebf3a-20211202-34815-1dy4zoi-2.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20211130-171334
- commit=4fa18391ae8cf8f1e498d54b46c571aebf3aa806
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/vmlinuz-5.16.0-rc1-00006-g4fa18391ae8c
- acpi_rsdp=0x695fd014
- max_uptime=2100
- RESULT_ROOT=/result/aim7/performance-1BRD_48G-f2fs-3000-disk_cp-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211128.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-4f0dda359c45-1_20211127.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20211201.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20211201072516/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.16.0-rc3-wt-ath-05296-g3165df4f9712
repeat_to: 3
schedule_notify_address:
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/4fa18391ae8cf8f1e498d54b46c571aebf3aa806/vmlinuz-5.16.0-rc1-00006-g4fa18391ae8c"
dequeue_time: 2021-12-02 00:33:57.136154684 +08:00
:#! /cephfs/db/releases/20211201170020/lkp-src/include/site/inn:
job_state: finished
loadavg: 1057.63 1712.16 912.24 1/1059 22965
start_time: '1638376541'
end_time: '1638376934'
version: "/lkp/lkp/.src-20211201-170130:5a3fd06b-dirty:9026a2f81"

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=1" "rd_size=50331648"
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t f2fs /dev/ram0
mkdir -p /fs/ram0
mount -t f2fs /dev/ram0 /fs/ram0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo "500 32000 128 512" > /proc/sys/kernel/sem
cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 disk_cp
EOF
echo "/fs/ram0" > config

	(
		echo lkp-cpl-4sp1
		echo disk_cp

		echo 1
		echo 3000
		echo 2
		echo 3000
		echo 1
	) | ./multitask -t &

--JYK4vJDZwFMowpUq--
