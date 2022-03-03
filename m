Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833584CB920
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiCCIea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiCCIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:34:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41A12E768
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646296405; x=1677832405;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IP5OOSjBHOijJAjUGEicvh0vUoOkIooCO4oQGfwvSAA=;
  b=H5NX0wDDF/2sk6cPciEU7So/k9A++CCaIYAikcAsy0nHkqDnmNCD4ThL
   b3Zh5+teSUL3bNmMlp635GUhkMlqE1WW4pwTx6kqyaIc9oSWbgjzPXiwa
   LptxI+VIvgcl5LnrpiVrW1TSCWF+V/ZOyeiF9Adu3L5zzyBK+1ih9e/Cj
   a8NDJCNhdUEkqGb48NdiyMCGoRnhgYyN4FtRqyL4XMR7l4UReIZXVKscC
   rSpkkx++PfFuZgxditUwP5m3sOIKGn4oNHlUR3Wcrh66O1HppsFEq7VZQ
   EqerIHTaPMF3D70evI4iSn2yeWEPpelktM6dUDar4sHt1MNscpaRed8qK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233579512"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="yaml'?scan'208";a="233579512"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:33:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="yaml'?scan'208";a="551654511"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:33:20 -0800
Date:   Thu, 3 Mar 2022 16:33:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tim Murray <timmurray@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: [f2fs]  e4544b63a7:  aim7.jobs-per-min -26.7% regression
Message-ID: <20220303083310.GA5802@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


(please be noted we reported "[f2fs] ae7d29380b: aim7.jobs-per-min -29.5% regression"
on https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/C7ZFECOTJH34SXUR6JFXZDCQDRPS27XP/
before when it's still on branch: jaegeuk-f2fs/dev-test,
now we still found it causing regression on linux-next/master, also we noticed there
is a fix commit "c7f91bd410290 f2fs: Restore rwsem lockdep support"
but we found regression not recovered on this fix, so we report again)


Greeting,

FYI, we noticed a -26.7% regression of aim7.jobs-per-min due to commit:


commit: e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae ("f2fs: move f2fs to use reader-unfair rwsems")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: aim7
on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID0
	fs: f2fs
	test: sync_disk_rw
	load: 100
	cpufreq_governor: performance
	ucode: 0x500320a

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -28.4% regression                                        |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=4BRD_12G                                                                    |
|                  | fs=f2fs                                                                          |
|                  | load=100                                                                         |
|                  | md=RAID0                                                                         |
|                  | test=sync_disk_rw                                                                |
|                  | ucode=0x5003006                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -84.3% regression                                        |
| test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                   |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=1BRD_48G                                                                    |
|                  | fs=f2fs                                                                          |
|                  | load=200                                                                         |
|                  | test=sync_disk_rw                                                                |
|                  | ucode=0xb000280                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -77.3% regression                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=1BRD_48G                                                                    |
|                  | fs=f2fs                                                                          |
|                  | load=200                                                                         |
|                  | test=sync_disk_rw                                                                |
|                  | ucode=0xd000280                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -70.8% regression                                        |
| test machine     | 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=1BRD_48G                                                                    |
|                  | fs=f2fs                                                                          |
|                  | load=200                                                                         |
|                  | test=sync_disk_rw                                                                |
|                  | ucode=0x7002302                                                                  |
+------------------+----------------------------------------------------------------------------------+


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
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/f2fs/x86_64-rhel-8.3/100/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/sync_disk_rw/aim7/0x500320a

commit: 
  dd81e1c7d5 ("Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux")
  e4544b63a7 ("f2fs: move f2fs to use reader-unfair rwsems")

dd81e1c7d5fb126e e4544b63a7ee49e7fbebf35ece0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      9978           -26.7%       7313 ±  2%  aim7.jobs-per-min
     60.15           +36.5%      82.11 ±  2%  aim7.time.elapsed_time
     60.15           +36.5%      82.11 ±  2%  aim7.time.elapsed_time.max
  86454336            -4.8%   82328562        aim7.time.file_system_outputs
   1260157           -38.4%     776761        aim7.time.involuntary_context_switches
      9671           +63.3%      15797 ±  3%  aim7.time.minor_page_faults
    632.42          +676.7%       4912 ±  2%  aim7.time.system_time
  31621531           +13.3%   35841551        aim7.time.voluntary_context_switches
 4.552e+09           -54.1%  2.091e+09 ±  2%  cpuidle..time
  38581492           -29.4%   27250516 ±  3%  cpuidle..usage
     86.88           -65.2%      30.24        iostat.cpu.idle
     12.86          +440.3%      69.50        iostat.cpu.system
     97.09           +24.1%     120.45 ±  2%  uptime.boot
      7319           -32.3%       4957 ±  3%  uptime.idle
     86.57           -57.9       28.64        mpstat.cpu.all.idle%
      0.08            +0.0        0.10 ±  3%  mpstat.cpu.all.soft%
     12.06           +57.9       69.96        mpstat.cpu.all.sys%
   4265528 ±  3%     -15.8%    3590110        numa-numastat.node0.local_node
   4301858 ±  2%     -15.5%    3635818        numa-numastat.node0.numa_hit
   4414095 ±  2%     -14.8%    3760555        numa-numastat.node1.local_node
   4457744 ±  2%     -14.9%    3794659        numa-numastat.node1.numa_hit
     86.33           -65.3%      30.00        vmstat.cpu.id
     12.00          +475.0%      69.00        vmstat.cpu.sy
    679863           -29.3%     480775        vmstat.io.bo
      9.33 ± 10%    +560.7%      61.67        vmstat.procs.r
   1131254           -25.2%     845926        vmstat.system.cs
    232063           +28.4%     297944 ±  7%  vmstat.system.in
     26261 ±  4%    +166.2%      69919 ±  6%  meminfo.Active
     20883 ±  5%    +195.6%      61737 ±  6%  meminfo.Active(anon)
      5377 ±  2%     +52.1%       8181 ±  2%  meminfo.Active(file)
     77019           +22.4%      94261 ±  4%  meminfo.AnonHugePages
     84083           -11.1%      74713        meminfo.Inactive(file)
     33624           +16.6%      39219        meminfo.Mapped
  18344714            -9.5%   16593518        meminfo.Memused
     30859 ±  3%    +148.3%      76619 ±  5%  meminfo.Shmem
    437.00 ± 39%    +302.9%       1760 ±  3%  meminfo.Writeback
  18346630            -9.5%   16594683        meminfo.max_used_kB
    475.33          +322.9%       2010        turbostat.Avg_MHz
     17.31           +55.0       72.30        turbostat.Busy%
      2753            +1.3%       2787        turbostat.Bzy_MHz
   4305528          +231.1%   14253828 ±  3%  turbostat.C1
      4.30 ±  2%      +3.5        7.78 ±  7%  turbostat.C1%
  34109110           -64.3%   12176611 ± 13%  turbostat.C1E
     78.72           -66.4       12.30 ± 50%  turbostat.C1E%
     55047 ± 43%   +1143.9%     684721 ± 63%  turbostat.C6
      0.56 ± 52%      +7.7        8.23 ± 66%  turbostat.C6%
     82.55           -69.2%      25.39 ±  7%  turbostat.CPU%c1
  14662404           +73.4%   25424942 ±  9%  turbostat.IRQ
     54.00            +8.6%      58.67        turbostat.PkgTmp
    159.42           +28.1%     204.27        turbostat.PkgWatt
     58.79            -1.8%      57.72        turbostat.RAMWatt
      4519 ± 20%     +48.1%       6692 ±  3%  numa-meminfo.node0.Active
      2973 ± 33%     +70.0%       5056 ±  2%  numa-meminfo.node0.Active(file)
     72916 ±  4%     +22.3%      89175 ±  4%  numa-meminfo.node0.AnonHugePages
     41387           -10.5%      37023        numa-meminfo.node0.Inactive(file)
      9562 ±  7%     +15.5%      11045        numa-meminfo.node0.KernelStack
      3322 ± 38%     +61.5%       5364 ±  2%  numa-meminfo.node0.PageTables
     21743          +190.8%      63230 ±  6%  numa-meminfo.node1.Active
     19338 ±  5%    +210.8%      60101 ±  7%  numa-meminfo.node1.Active(anon)
     42553           -11.4%      37720        numa-meminfo.node1.Inactive(file)
      8504 ±  8%     -17.5%       7015        numa-meminfo.node1.KernelStack
      1528 ± 19%    +751.7%      13020 ± 93%  numa-meminfo.node1.Mapped
      2959 ± 43%     -69.5%     901.67 ± 19%  numa-meminfo.node1.PageTables
     78251 ±  4%     -17.1%      64867 ±  2%  numa-meminfo.node1.SUnreclaim
     20024 ±  6%    +228.3%      65740 ±  6%  numa-meminfo.node1.Shmem
    352.67 ± 25%    +266.5%       1292 ± 14%  numa-meminfo.node1.Writeback
    733.67 ± 32%     +72.1%       1262 ±  2%  numa-vmstat.node0.nr_active_file
     10366           -10.2%       9309 ±  2%  numa-vmstat.node0.nr_inactive_file
      9567 ±  7%     +15.4%      11041        numa-vmstat.node0.nr_kernel_stack
    832.00 ± 37%     +60.7%       1337 ±  3%  numa-vmstat.node0.nr_page_table_pages
    733.67 ± 32%     +72.1%       1262 ±  2%  numa-vmstat.node0.nr_zone_active_file
     10364           -10.2%       9308 ±  2%  numa-vmstat.node0.nr_zone_inactive_file
      4451 ±  2%     -12.7%       3887 ±  3%  numa-vmstat.node0.nr_zone_write_pending
      4814 ±  5%    +211.5%      14996 ±  7%  numa-vmstat.node1.nr_active_anon
     10591           -10.3%       9498        numa-vmstat.node1.nr_inactive_file
      8514 ±  8%     -17.6%       7018        numa-vmstat.node1.nr_kernel_stack
    467.67 ± 27%    +615.3%       3345 ± 93%  numa-vmstat.node1.nr_mapped
    742.00 ± 43%     -69.4%     227.00 ± 19%  numa-vmstat.node1.nr_page_table_pages
      4986 ±  5%    +229.7%      16439 ±  6%  numa-vmstat.node1.nr_shmem
     19561 ±  4%     -17.1%      16215 ±  2%  numa-vmstat.node1.nr_slab_unreclaimable
     97.00 ± 30%    +219.6%     310.00 ±  2%  numa-vmstat.node1.nr_writeback
      4814 ±  5%    +211.5%      14996 ±  7%  numa-vmstat.node1.nr_zone_active_anon
     10589           -10.3%       9498        numa-vmstat.node1.nr_zone_inactive_file
   2767104 ±  7%     -10.2%    2484087 ± 10%  numa-vmstat.node1.numa_local
      5199 ±  4%    +196.8%      15433 ±  6%  proc-vmstat.nr_active_anon
      1323           +54.7%       2047 ±  2%  proc-vmstat.nr_active_file
  10796536            -4.7%   10285714        proc-vmstat.nr_dirtied
   2817394            +1.5%    2859147        proc-vmstat.nr_dirty_background_threshold
   5641678            +1.5%    5725285        proc-vmstat.nr_dirty_threshold
    668359            +1.5%     678413        proc-vmstat.nr_file_pages
  28347195            +1.5%   28766875        proc-vmstat.nr_free_pages
     67487            +2.3%      69016        proc-vmstat.nr_inactive_anon
     20963           -10.8%      18701        proc-vmstat.nr_inactive_file
      8659           +16.3%      10071        proc-vmstat.nr_mapped
      7694 ±  3%    +149.0%      19154 ±  5%  proc-vmstat.nr_shmem
     34245            -2.4%      33433        proc-vmstat.nr_slab_reclaimable
    109.67 ± 23%    +312.2%     452.00 ±  4%  proc-vmstat.nr_writeback
  10753492            -4.7%   10246115        proc-vmstat.nr_written
      5199 ±  4%    +196.8%      15433 ±  6%  proc-vmstat.nr_zone_active_anon
      1323           +54.7%       2047 ±  2%  proc-vmstat.nr_zone_active_file
     67487            +2.3%      69016        proc-vmstat.nr_zone_inactive_anon
     20963           -10.8%      18701        proc-vmstat.nr_zone_inactive_file
      7473 ±  3%      +9.8%       8202        proc-vmstat.nr_zone_write_pending
      2519 ±  2%    +238.6%       8528 ±  5%  proc-vmstat.numa_hint_faults
      1478 ±  2%    +298.8%       5897 ±  5%  proc-vmstat.numa_hint_faults_local
   8760986           -15.2%    7431885        proc-vmstat.numa_hit
   8681011           -15.3%    7352072        proc-vmstat.numa_local
    947.33 ±  4%     +82.8%       1731 ±  4%  proc-vmstat.numa_pages_migrated
      5655 ± 39%    +130.8%      13052        proc-vmstat.numa_pte_updates
     16049 ±  2%     +73.6%      27865 ±  4%  proc-vmstat.pgactivate
   8768768           -15.2%    7439827        proc-vmstat.pgalloc_normal
      9865           -36.6%       6252 ±  6%  proc-vmstat.pgdeactivate
    336322           +24.1%     417504        proc-vmstat.pgfault
   1715624            +2.7%    1762666        proc-vmstat.pgfree
    947.33 ±  4%     +82.8%       1731 ±  4%  proc-vmstat.pgmigrate_success
  43055686            -4.8%   41010292        proc-vmstat.pgpgout
     19077 ±  2%     +32.0%      25176        proc-vmstat.pgreuse
     19724           -37.6%      12300 ±  6%  proc-vmstat.pgrotated
 3.212e+09           +73.6%  5.575e+09        perf-stat.i.branch-instructions
  46408388           +19.9%   55635668        perf-stat.i.branch-misses
     18.37            +1.4       19.79        perf-stat.i.cache-miss-rate%
  71783743            -6.8%   66894966        perf-stat.i.cache-misses
  3.64e+08           -13.6%  3.143e+08 ±  2%  perf-stat.i.cache-references
   1175973           -26.2%     867946        perf-stat.i.context-switches
      2.56          +159.9%       6.67 ±  2%  perf-stat.i.cpi
 4.203e+10          +325.6%  1.789e+11        perf-stat.i.cpu-cycles
     28248          +272.5%     105225        perf-stat.i.cpu-migrations
      1418 ±  3%     +94.9%       2764 ±  5%  perf-stat.i.cycles-between-cache-misses
   3524200 ±  3%     +12.2%    3953541 ±  4%  perf-stat.i.dTLB-load-misses
 4.883e+09           +45.5%  7.104e+09        perf-stat.i.dTLB-loads
      0.01 ±  4%      +0.0        0.02 ± 40%  perf-stat.i.dTLB-store-miss-rate%
  2.07e+09           -19.5%  1.667e+09        perf-stat.i.dTLB-stores
     33.63            +4.0       37.60        perf-stat.i.iTLB-load-miss-rate%
   7946600           -23.5%    6080185 ±  2%  perf-stat.i.iTLB-load-misses
  15545961           -31.4%   10662684 ±  2%  perf-stat.i.iTLB-loads
 1.668e+10           +54.9%  2.583e+10        perf-stat.i.instructions
      2349           +76.8%       4154        perf-stat.i.instructions-per-iTLB-miss
      0.41           -57.1%       0.18 ±  4%  perf-stat.i.ipc
      2.10 ± 23%     -30.4%       1.46 ±  9%  perf-stat.i.major-faults
      0.48          +325.6%       2.03        perf-stat.i.metric.GHz
    119.62           +39.2%     166.50        perf-stat.i.metric.M/sec
     89.69            +0.9       90.55        perf-stat.i.node-load-miss-rate%
  32390308            -8.0%   29805668        perf-stat.i.node-load-misses
   2784797           -13.9%    2397028        perf-stat.i.node-loads
  13193625            -6.6%   12317889        perf-stat.i.node-store-misses
   1086843           -10.9%     968243        perf-stat.i.node-stores
     21.82           -44.2%      12.17        perf-stat.overall.MPKI
      1.45            -0.4        1.00        perf-stat.overall.branch-miss-rate%
     19.72            +1.6       21.28        perf-stat.overall.cache-miss-rate%
      2.52          +174.8%       6.93        perf-stat.overall.cpi
    585.53          +356.9%       2675 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.07 ±  2%      -0.0        0.06 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  4%      +0.0        0.01 ± 13%  perf-stat.overall.dTLB-store-miss-rate%
     33.83            +2.5       36.32 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      2099          +102.5%       4251 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.40           -63.6%       0.14        perf-stat.overall.ipc
 3.158e+09           +74.4%  5.509e+09        perf-stat.ps.branch-instructions
  45638775           +20.4%   54971063        perf-stat.ps.branch-misses
  70571438            -6.3%   66107192        perf-stat.ps.cache-misses
 3.579e+08           -13.2%  3.106e+08 ±  2%  perf-stat.ps.cache-references
   1156109           -25.8%     857744        perf-stat.ps.context-switches
 4.132e+10          +327.8%  1.768e+11        perf-stat.ps.cpu-cycles
     27770          +274.5%     103989        perf-stat.ps.cpu-migrations
   3464601 ±  3%     +12.8%    3907119 ±  4%  perf-stat.ps.dTLB-load-misses
 4.801e+09           +46.2%   7.02e+09        perf-stat.ps.dTLB-loads
 2.035e+09           -19.1%  1.647e+09        perf-stat.ps.dTLB-stores
   7812679           -23.1%    6008510 ±  2%  perf-stat.ps.iTLB-load-misses
  15284035           -31.1%   10536964 ±  2%  perf-stat.ps.iTLB-loads
  1.64e+10           +55.7%  2.553e+10        perf-stat.ps.instructions
      2.07 ± 23%     -30.2%       1.44 ±  9%  perf-stat.ps.major-faults
  31843231            -7.5%   29454978        perf-stat.ps.node-load-misses
   2737765           -13.5%    2369026        perf-stat.ps.node-loads
  12970733            -6.2%   12172439        perf-stat.ps.node-store-misses
   1068457           -10.5%     956624        perf-stat.ps.node-stores
 1.005e+12          +110.9%   2.12e+12        perf-stat.total.instructions
     50.73           -38.5       12.25        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     50.09           -38.0       12.08        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     50.09           -38.0       12.08        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.07           -38.0       12.08        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.78           -34.8       10.96        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.70           -34.8       10.95        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     44.11           -33.8       10.29        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.57            -4.8        0.80        perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      5.31 ±  4%      -4.5        0.79        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      5.89 ±  2%      -3.9        2.01        perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      4.49 ±  4%      -3.9        0.64        perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      4.80 ±  6%      -3.5        1.34 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      4.49 ±  6%      -3.3        1.20 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      3.75 ±  7%      -2.8        0.96 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      7.02 ±  5%      -2.2        4.83 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      6.66 ±  5%      -2.0        4.71 ±  3%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      2.46 ±  2%      -1.6        0.86 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      2.17            -1.5        0.64 ±  3%  perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.16            -1.5        0.64 ±  2%  perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.04            -1.3        0.75 ±  3%  perf-profile.calltrace.cycles-pp.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.01            -1.3        0.73 ±  3%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter
      1.97            -1.3        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush
      1.97            -1.2        0.72 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file
      3.09            -1.1        1.95 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      1.70            -1.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_for_completion
      1.70            -1.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_timeout
      1.42            -1.1        0.34 ± 70%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.39            -1.0        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.63 ±  4%      -0.8        0.85 ± 70%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle
      2.79 ±  6%      -0.7        2.05 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      2.48 ±  6%      -0.6        1.87 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page
      2.21            -0.5        1.68 ±  4%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      1.69            -0.2        1.49 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page
      0.57 ±  9%      +0.2        0.82 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter
      1.65 ±  4%      +0.3        1.94 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__submit_merged_write_cond.f2fs_write_cache_pages
      0.20 ±141%      +0.6        0.80 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file
      0.00            +0.7        0.74 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.87 ±  5%      +0.8        1.63 ±  5%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.schedule.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.58 ±  5%      +0.9        1.43 ±  6%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00            +1.0        1.03        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +1.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +1.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page
      0.00            +1.2        1.17 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.2        1.25 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +1.3        1.26 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.3        1.26 ±  2%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +1.3        1.28 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_outplace_write_data
      0.00            +1.3        1.28 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.00            +1.3        1.29 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_write_cache_pages
      0.00            +1.3        1.30 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +1.3        1.30 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +1.3        1.31 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.3        1.31 ±  2%  perf-profile.calltrace.cycles-pp.schedule.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      6.14 ±  3%      +1.4        7.53        perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      6.13 ±  3%      +1.4        7.53        perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.4        1.41 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +1.6        1.56 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.6        1.56 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +1.6        1.57 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.6        1.61        perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.__submit_merged_write_cond
      0.00            +1.6        1.64 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +1.6        1.64 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +1.6        1.65 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +1.9        1.88 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.9        1.88 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +1.9        1.88 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     15.20            +2.4       17.59        perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      9.66 ±  4%      +2.5       12.18 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      9.46 ±  4%      +2.7       12.13 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +2.8        2.77        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_fsync_node_pages
      2.60            +2.8        5.37 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +2.8        2.78        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.8        2.78        perf-profile.calltrace.cycles-pp.finish_wait.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      1.92 ±  2%      +3.2        5.14        perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +3.3        3.26 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page
      0.00            +3.3        3.27 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page.__write_node_page
      0.00            +3.5        3.51 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      0.00            +3.6        3.62        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page
      0.00            +3.6        3.63        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +3.6        3.65        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages
      0.00            +3.7        3.66        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +3.7        3.67        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +3.8        3.80 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +3.8        3.81 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +3.8        3.85 ±  3%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +4.1        4.06        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.00 ±  2%      +4.7        6.74        perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +4.8        4.76        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +4.8        4.77        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +4.8        4.82        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +5.1        5.07        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +5.1        5.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +5.1        5.14        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      1.75            +5.3        7.10 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      2.42            +5.8        8.20        perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +5.8        5.85        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +5.9        5.87        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +5.9        5.92        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +6.8        6.82 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_write_cache_pages
      0.00            +6.9        6.86 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +7.0        6.95 ±  3%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      2.87            +7.2       10.09 ±  3%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
     13.30 ±  3%      +9.2       22.51 ±  2%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     13.24 ±  3%      +9.2       22.48 ±  2%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     13.23 ±  3%      +9.3       22.48 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
     13.21 ±  3%      +9.3       22.48 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file
     13.08 ±  3%      +9.4       22.43 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      0.00           +17.5       17.52 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00           +17.6       17.57 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +17.7       17.74 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.11           +21.0       23.11 ±  2%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     22.69           +25.7       48.42        perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     47.25           +39.9       87.15        perf-profile.calltrace.cycles-pp.write
     46.98           +40.1       87.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     46.97           +40.1       87.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.90           +40.1       87.02        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.88           +40.1       87.02        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.79           +40.2       87.00        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.77           +40.2       86.99        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     45.22           +41.3       86.55        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     50.73           -38.5       12.25        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     50.73           -38.5       12.25        perf-profile.children.cycles-pp.cpu_startup_entry
     50.72           -38.5       12.25        perf-profile.children.cycles-pp.do_idle
     50.09           -38.0       12.08        perf-profile.children.cycles-pp.start_secondary
     46.36           -35.3       11.11        perf-profile.children.cycles-pp.cpuidle_enter
     46.35           -35.2       11.11        perf-profile.children.cycles-pp.cpuidle_enter_state
     44.82           -33.8       10.99        perf-profile.children.cycles-pp.intel_idle
     10.44           -10.4        0.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     12.98 ±  4%      -8.7        4.23 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     11.09            -6.0        5.06        perf-profile.children.cycles-pp.__schedule
      9.61            -5.0        4.56        perf-profile.children.cycles-pp.schedule
      4.56            -4.4        0.13 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      7.94            -4.2        3.70        perf-profile.children.cycles-pp.pick_next_task_fair
     10.18 ±  6%      -4.2        5.95        perf-profile.children.cycles-pp.osq_lock
      7.60 ±  6%      -4.2        3.40 ±  2%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      7.44            -3.9        3.54        perf-profile.children.cycles-pp.newidle_balance
      4.51 ±  4%      -3.9        0.64        perf-profile.children.cycles-pp.set_node_addr
      6.43            -3.6        2.79        perf-profile.children.cycles-pp.find_busiest_group
      6.36            -3.6        2.75        perf-profile.children.cycles-pp.update_sd_lb_stats
      6.82            -3.6        3.26        perf-profile.children.cycles-pp.load_balance
      2.75            -2.5        0.21 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      7.02 ±  5%      -2.2        4.83 ±  3%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      2.23            -2.1        0.15 ±  5%  perf-profile.children.cycles-pp.wake_up_q
      2.39            -1.8        0.59 ±  2%  perf-profile.children.cycles-pp.submit_bio_noacct
      2.38            -1.8        0.59        perf-profile.children.cycles-pp.__submit_bio
      2.46 ±  2%      -1.6        0.86 ±  2%  perf-profile.children.cycles-pp.f2fs_issue_flush
      2.23            -1.6        0.66 ±  3%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      2.22            -1.6        0.66 ±  3%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      2.58            -1.4        1.22        perf-profile.children.cycles-pp.try_to_wake_up
      2.05            -1.3        0.75 ±  3%  perf-profile.children.cycles-pp.wait_for_completion
      1.76            -1.3        0.46 ±  2%  perf-profile.children.cycles-pp.__submit_merged_bio
      2.01            -1.3        0.74 ±  2%  perf-profile.children.cycles-pp.schedule_timeout
      2.30 ±  2%      -1.2        1.05 ± 10%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.75            -1.2        0.53        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.46 ±  2%      -1.0        0.44 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.33 ±  2%      -1.0        0.35 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      1.33 ±  2%      -1.0        0.35 ±  3%  perf-profile.children.cycles-pp.kthread
      1.29            -1.0        0.31        perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      1.29            -1.0        0.34        perf-profile.children.cycles-pp.f2fs_buffered_write_iter
      1.27            -0.9        0.34        perf-profile.children.cycles-pp.generic_perform_write
      1.45            -0.9        0.52 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      1.33            -0.9        0.44        perf-profile.children.cycles-pp.ttwu_do_activate
      1.48 ±  3%      -0.9        0.59 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      4.75 ±  2%      -0.9        3.90 ±  4%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      1.29            -0.8        0.46        perf-profile.children.cycles-pp.enqueue_task_fair
      1.11 ±  2%      -0.8        0.29 ±  2%  perf-profile.children.cycles-pp.brd_submit_bio
      0.99            -0.8        0.18        perf-profile.children.cycles-pp.menu_select
      1.09 ±  2%      -0.8        0.29 ±  2%  perf-profile.children.cycles-pp.brd_do_bvec
      1.08 ±  2%      -0.8        0.31 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.07 ±  2%      -0.8        0.30 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.01            -0.7        0.34        perf-profile.children.cycles-pp.enqueue_entity
      0.98            -0.6        0.35 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.15            -0.6        0.55 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.08 ±  2%      -0.6        0.50        perf-profile.children.cycles-pp.idle_cpu
      0.80 ±  4%      -0.5        0.26 ±  3%  perf-profile.children.cycles-pp.issue_flush_thread
      0.70 ±  3%      -0.5        0.18        perf-profile.children.cycles-pp.f2fs_write_begin
      0.99            -0.5        0.48        perf-profile.children.cycles-pp.dequeue_entity
      0.72            -0.5        0.23 ±  4%  perf-profile.children.cycles-pp.__pagevec_release
      0.67            -0.5        0.18 ±  2%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.71            -0.5        0.22 ±  5%  perf-profile.children.cycles-pp.release_pages
      0.67 ±  4%      -0.5        0.19 ±  6%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.64 ±  6%      -0.5        0.17 ± 11%  perf-profile.children.cycles-pp.start_kernel
      0.50 ±  3%      -0.5        0.03 ± 70%  perf-profile.children.cycles-pp.ktime_get
      0.89            -0.4        0.44        perf-profile.children.cycles-pp.update_load_avg
      0.52            -0.4        0.09        perf-profile.children.cycles-pp.worker_thread
      0.57 ±  2%      -0.4        0.15 ±  3%  perf-profile.children.cycles-pp.brd_insert_page
      0.60 ±  3%      -0.4        0.24        perf-profile.children.cycles-pp.cpumask_next_and
      0.52            -0.4        0.16        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.42 ±  4%      -0.4        0.07 ±  7%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.41 ±  3%      -0.3        0.07        perf-profile.children.cycles-pp.__submit_flush_wait
      0.41            -0.3        0.07        perf-profile.children.cycles-pp.blkdev_issue_flush
      0.68            -0.3        0.34 ±  2%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.56 ±  2%      -0.3        0.23 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.41 ±  4%      -0.3        0.08 ±  6%  perf-profile.children.cycles-pp.md_submit_bio
      0.44 ±  2%      -0.3        0.12 ±  8%  perf-profile.children.cycles-pp.__get_node_page
      0.40 ±  2%      -0.3        0.07        perf-profile.children.cycles-pp.submit_bio_wait
      0.45 ±  2%      -0.3        0.13 ± 12%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.45 ±  2%      -0.3        0.13 ± 12%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.45 ±  2%      -0.3        0.14 ±  3%  perf-profile.children.cycles-pp.xas_find_marked
      0.35            -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.45            -0.3        0.16 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.50 ±  3%      -0.3        0.22 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.39 ±  3%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.folio_end_writeback
      0.34 ±  2%      -0.3        0.06        perf-profile.children.cycles-pp.md_handle_request
      0.43 ±  2%      -0.3        0.15 ± 11%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.37 ±  2%      -0.3        0.09        perf-profile.children.cycles-pp.f2fs_write_end
      0.34            -0.3        0.06        perf-profile.children.cycles-pp.process_one_work
      0.39 ±  6%      -0.3        0.11 ± 11%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.37 ±  2%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.36            -0.3        0.10 ±  4%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.36 ±  7%      -0.3        0.10 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
      0.35            -0.3        0.10 ±  4%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.35 ±  6%      -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.31 ±  4%      -0.2        0.06 ±  8%  perf-profile.children.cycles-pp.raid0_make_request
      0.29 ±  4%      -0.2        0.05        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.41 ±  2%      -0.2        0.17 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.36            -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.up_read
      0.34 ±  2%      -0.2        0.10        perf-profile.children.cycles-pp.set_next_entity
      0.27            -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.__list_add_valid
      0.38 ±  2%      -0.2        0.16 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.31 ±  5%      -0.2        0.09        perf-profile.children.cycles-pp.down_write
      0.33 ±  6%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.33 ±  6%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.29 ±  3%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.f2fs_write_inode
      0.28 ±  5%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.f2fs_update_inode_page
      0.37 ±  3%      -0.2        0.16 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.28 ±  4%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.update_sit_entry
      0.36 ±  2%      -0.2        0.16        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.27 ±  3%      -0.2        0.07        perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.45 ±  3%      -0.2        0.25        perf-profile.children.cycles-pp.update_curr
      0.27 ±  3%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.28            -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.30 ±  2%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.33 ±  2%      -0.2        0.16 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.23 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.llist_add_batch
      0.22 ±  7%      -0.2        0.05        perf-profile.children.cycles-pp.mutex_lock
      0.24 ±  6%      -0.2        0.08        perf-profile.children.cycles-pp.__switch_to_asm
      0.44            -0.2        0.28        perf-profile.children.cycles-pp.finish_task_switch
      0.25            -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.22 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.23 ±  3%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.22 ±  3%      -0.2        0.07        perf-profile.children.cycles-pp.__switch_to
      0.22 ±  5%      -0.1        0.07        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.19 ±  2%      -0.1        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.18 ± 11%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.21 ±  6%      -0.1        0.07        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.21 ±  2%      -0.1        0.08        perf-profile.children.cycles-pp.__alloc_pages
      0.30            -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.complete
      0.16            -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.locate_dirty_segment
      0.19 ±  2%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.up_write
      0.25            -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.15 ±  8%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__fput
      0.15 ±  8%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__dentry_kill
      0.15 ±  8%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.evict
      0.20 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.21 ±  8%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.14 ± 17%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.xas_load
      0.25 ±  5%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.update_blocked_averages
      0.15 ±  8%      -0.1        0.05        perf-profile.children.cycles-pp.task_work_run
      0.15 ±  8%      -0.1        0.05        perf-profile.children.cycles-pp.__close
      0.15 ±  8%      -0.1        0.05        perf-profile.children.cycles-pp.dput
      0.16 ±  6%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.cpuacct_charge
      0.20            -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.20 ±  4%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.19 ±  4%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.25 ±  4%      -0.1        0.17        perf-profile.children.cycles-pp.swake_up_locked
      0.12            -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.prep_new_page
      0.12 ±  4%      -0.1        0.05        perf-profile.children.cycles-pp.kernel_init_free_pages
      0.12 ±  4%      -0.1        0.05        perf-profile.children.cycles-pp.clear_page_erms
      0.10 ±  4%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.reweight_entity
      0.22 ±  6%      -0.0        0.17 ±  8%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.10 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.perf_tp_event
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.f2fs_wait_on_node_pages_writeback
      0.11 ±  7%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.set_task_cpu
      0.26            +0.1        0.31        perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.f2fs_wait_on_page_writeback
      0.00            +0.2        0.18        perf-profile.children.cycles-pp.select_idle_cpu
      0.02 ±141%      +0.2        0.21        perf-profile.children.cycles-pp.select_idle_sibling
      3.08 ±  2%      +0.2        3.31 ±  5%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.3        0.28 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
      0.08 ± 27%      +0.3        0.40 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ±  6%      +0.9        0.97        perf-profile.children.cycles-pp.autoremove_wake_function
      0.08 ±  5%      +0.9        1.01        perf-profile.children.cycles-pp.__wake_up_common
      6.14 ±  3%      +1.4        7.53        perf-profile.children.cycles-pp.f2fs_do_write_node_page
     15.20            +2.4       17.59        perf-profile.children.cycles-pp.__write_node_page
      9.66 ±  4%      +2.5       12.18 ±  2%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      9.46 ±  4%      +2.7       12.13 ±  2%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      2.60            +2.8        5.37 ±  3%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      2.00 ±  2%      +4.7        6.74        perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      2.42            +5.8        8.20        perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      3.68            +8.6       12.25        perf-profile.children.cycles-pp.f2fs_get_node_info
     13.30 ±  3%      +9.2       22.51 ±  2%  perf-profile.children.cycles-pp.file_write_and_wait_range
     13.24 ±  3%      +9.2       22.48 ±  2%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     13.23 ±  3%      +9.3       22.48 ±  2%  perf-profile.children.cycles-pp.do_writepages
     13.21 ±  3%      +9.3       22.48 ±  2%  perf-profile.children.cycles-pp.f2fs_write_data_pages
     13.08 ±  3%      +9.4       22.43 ±  2%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      0.12 ±  8%     +10.1       10.18        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00           +11.6       11.63 ±  2%  perf-profile.children.cycles-pp.finish_wait
     22.69           +25.7       48.42        perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      4.99           +28.3       33.28        perf-profile.children.cycles-pp.__submit_merged_write_cond
     47.29           +39.9       87.17        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     47.27           +39.9       87.16        perf-profile.children.cycles-pp.write
     47.28           +39.9       87.17        perf-profile.children.cycles-pp.do_syscall_64
     46.90           +40.1       87.03        perf-profile.children.cycles-pp.ksys_write
     46.88           +40.1       87.03        perf-profile.children.cycles-pp.vfs_write
     46.79           +40.2       87.00        perf-profile.children.cycles-pp.new_sync_write
     46.77           +40.2       86.99        perf-profile.children.cycles-pp.f2fs_file_write_iter
     45.22           +41.3       86.55        perf-profile.children.cycles-pp.f2fs_do_sync_file
      0.00           +48.2       48.15        perf-profile.children.cycles-pp.prepare_to_wait_event
      5.27           +64.0       69.27        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.81 ±  3%     +67.8       69.63        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     44.59           -33.7       10.92        perf-profile.self.cycles-pp.intel_idle
     10.09 ±  6%      -4.2        5.92        perf-profile.self.cycles-pp.osq_lock
      4.75            -2.7        2.05        perf-profile.self.cycles-pp.update_sd_lb_stats
      1.77            -1.2        0.52 ±  3%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      1.71            -1.2        0.52        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.33 ±  2%      -0.9        0.45 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.73            -0.6        0.15 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      1.06 ±  2%      -0.6        0.50        perf-profile.self.cycles-pp.idle_cpu
      0.72            -0.5        0.23 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.56 ±  2%      -0.5        0.10        perf-profile.self.cycles-pp.menu_select
      0.67            -0.5        0.21 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.68            -0.3        0.34 ±  2%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.41            -0.3        0.09        perf-profile.self.cycles-pp.f2fs_fsync_node_pages
      0.45 ±  2%      -0.3        0.14 ±  3%  perf-profile.self.cycles-pp.xas_find_marked
      0.38 ±  2%      -0.3        0.10 ±  4%  perf-profile.self.cycles-pp.brd_do_bvec
      0.35 ±  2%      -0.3        0.08 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.46 ±  2%      -0.3        0.20 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.35            -0.3        0.10 ±  4%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.33 ± 22%      -0.2        0.09        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.36            -0.2        0.12 ±  4%  perf-profile.self.cycles-pp.up_read
      0.29 ±  5%      -0.2        0.05        perf-profile.self.cycles-pp.__radix_tree_lookup
      0.26            -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.__list_add_valid
      0.80 ±  4%      -0.2        0.57        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.33            -0.2        0.12        perf-profile.self.cycles-pp.update_rq_clock
      0.28 ±  5%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.update_sit_entry
      0.35 ±  3%      -0.2        0.15        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.28 ±  4%      -0.2        0.08        perf-profile.self.cycles-pp.down_write
      0.28 ±  3%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.23 ±  2%      -0.2        0.06        perf-profile.self.cycles-pp.llist_add_batch
      0.33            -0.2        0.16 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.28 ±  5%      -0.2        0.12        perf-profile.self.cycles-pp.newidle_balance
      0.24 ±  6%      -0.2        0.08        perf-profile.self.cycles-pp.__switch_to_asm
      0.21 ±  4%      -0.2        0.06        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.22 ±  2%      -0.2        0.07 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.22 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.__switch_to
      0.20 ±  8%      -0.1        0.05        perf-profile.self.cycles-pp.mutex_lock
      0.20 ±  2%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.19 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.21 ±  3%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.21 ±  2%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.f2fs_do_sync_file
      0.33 ±  4%      -0.1        0.19        perf-profile.self.cycles-pp.update_load_avg
      0.19 ±  4%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.cpumask_next_and
      0.19 ±  2%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.19 ±  2%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.up_write
      0.21 ±  8%      -0.1        0.09        perf-profile.self.cycles-pp.__update_load_avg_se
      0.16 ±  6%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.14 ±  3%      -0.1        0.05        perf-profile.self.cycles-pp.dequeue_task_fair
      0.16 ±  2%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.finish_task_switch
      0.18 ±  5%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.15 ±  5%      -0.1        0.07        perf-profile.self.cycles-pp.try_to_wake_up
      0.13 ±  9%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.12 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.clear_page_erms
      0.26 ±  4%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.load_balance
      0.15 ±  6%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.11 ±  7%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.select_idle_cpu
      0.00            +0.2        0.24        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.00            +0.3        0.28 ±  2%  perf-profile.self.cycles-pp.down_read_trylock
      5.26           +64.0       69.27        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/f2fs/x86_64-rhel-8.3/100/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/sync_disk_rw/aim7/0x5003006

commit: 
  dd81e1c7d5 ("Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux")
  e4544b63a7 ("f2fs: move f2fs to use reader-unfair rwsems")

dd81e1c7d5fb126e e4544b63a7ee49e7fbebf35ece0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      9906           -28.4%       7090 ±  2%  aim7.jobs-per-min
     60.59           +39.8%      84.69 ±  2%  aim7.time.elapsed_time
     60.59           +39.8%      84.69 ±  2%  aim7.time.elapsed_time.max
  86565317            -4.6%   82609528        aim7.time.file_system_outputs
   1270786 ±  2%     -39.5%     768683 ±  2%  aim7.time.involuntary_context_switches
      9732           +62.3%      15792        aim7.time.minor_page_faults
    626.92 ±  2%    +714.1%       5103 ±  2%  aim7.time.system_time
  31655631           +15.7%   36625324        aim7.time.voluntary_context_switches
 4.614e+09           -54.1%   2.12e+09        cpuidle..time
  38849547           -27.2%   28280820        cpuidle..usage
     87.07           -65.4%      30.09        iostat.cpu.idle
     12.67 ±  3%    +449.7%      69.65        iostat.cpu.system
     86.75           -58.2       28.54        mpstat.cpu.all.idle%
     11.88 ±  3%     +58.2       70.08        mpstat.cpu.all.sys%
    100.27           +22.5%     122.80 ±  2%  uptime.boot
      7593 ±  2%     -34.6%       4968 ±  3%  uptime.idle
     34.99 ±  4%      -3.7%      33.68 ±  4%  boot-time.boot
     16.17 ±  9%      -7.7%      14.93 ± 10%  boot-time.dhcp
      2723 ±  4%      -4.0%       2614 ±  5%  boot-time.idle
   4253025           -14.0%    3657579 ±  3%  numa-numastat.node0.local_node
   4298702           -14.5%    3676699 ±  2%  numa-numastat.node0.numa_hit
   4388572 ±  2%     -17.3%    3627513 ±  3%  numa-numastat.node1.local_node
   4422807 ±  2%     -16.6%    3688297 ±  3%  numa-numastat.node1.numa_hit
     86.33           -65.6%      29.67        vmstat.cpu.id
     12.33 ±  3%    +459.5%      69.00        vmstat.cpu.sy
    673698           -30.8%     466051        vmstat.io.bo
      9.67 ±  9%    +551.7%      63.00        vmstat.procs.r
   1121558           -25.7%     833207        vmstat.system.cs
    234510 ±  2%     +32.6%     310900        vmstat.system.in
     25364 ±  4%    +203.9%      77087 ±  5%  meminfo.Active
     19734 ±  6%    +248.1%      68690 ±  7%  meminfo.Active(anon)
      5629 ±  4%     +49.1%       8395 ±  2%  meminfo.Active(file)
     80138 ±  2%     +22.7%      98298 ±  2%  meminfo.AnonHugePages
     83799           -10.1%      75348        meminfo.Inactive(file)
     33634           +17.9%      39639        meminfo.Mapped
  18358339           -10.3%   16476181        meminfo.Memused
     29667 ±  4%    +182.9%      83919 ±  6%  meminfo.Shmem
    358.33 ± 22%    +259.1%       1286 ± 33%  meminfo.Writeback
  18359748           -10.3%   16477422        meminfo.max_used_kB
    468.67 ±  2%    +331.7%       2023        turbostat.Avg_MHz
     17.07 ±  2%     +55.6       72.71        turbostat.Busy%
      2751            +1.4%       2789        turbostat.Bzy_MHz
   4252328 ±  2%    +232.4%   14135410        turbostat.C1
      4.18 ±  2%      +3.1        7.27        turbostat.C1%
  34437096           -60.3%   13661464 ±  3%  turbostat.C1E
     79.04           -62.4       16.60 ± 30%  turbostat.C1E%
     82.78           -68.2%      26.29 ±  6%  turbostat.CPU%c1
     53.00           +12.6%      59.67        turbostat.CoreTmp
  14972112           +83.1%   27413037        turbostat.IRQ
     53.00           +12.6%      59.67        turbostat.PkgTmp
    158.98           +28.9%     204.96        turbostat.PkgWatt
     58.54            -1.2%      57.85        turbostat.RAMWatt
     68548 ± 18%     +30.1%      89169 ± 10%  numa-meminfo.node0.AnonHugePages
   2609293           -32.7%    1756149 ± 57%  numa-meminfo.node0.FilePages
  10692310 ±  2%     -17.5%    8825889 ± 11%  numa-meminfo.node0.MemUsed
   2552310           -33.3%    1701845 ± 59%  numa-meminfo.node0.Unevictable
     20091 ±  6%    +253.4%      70995 ±  6%  numa-meminfo.node1.Active
     18324 ±  7%    +266.4%      67134 ±  6%  numa-meminfo.node1.Active(anon)
      1767 ±  6%    +118.5%       3861 ± 24%  numa-meminfo.node1.Active(file)
     62770 ±  2%   +1437.0%     964802 ±103%  numa-meminfo.node1.FilePages
     41410           -11.3%      36722        numa-meminfo.node1.Inactive(file)
     38431 ±  5%     +38.1%      53089 ± 31%  numa-meminfo.node1.KReclaimable
      1030 ±  7%   +1209.3%      13490 ± 87%  numa-meminfo.node1.Mapped
     38431 ±  5%     +38.1%      53089 ± 31%  numa-meminfo.node1.SReclaimable
     19088 ±  6%    +281.8%      72880 ±  7%  numa-meminfo.node1.Shmem
    106871 ±  5%     +18.2%     126282 ± 10%  numa-meminfo.node1.Slab
    175.33 ± 22%  +4.9e+05%     851161 ±118%  numa-meminfo.node1.Unevictable
    316.00 ± 26%    +156.1%     809.33 ± 33%  numa-meminfo.node1.Writeback
    652411           -32.7%     439050 ± 57%  numa-vmstat.node0.nr_file_pages
     10661            -9.5%       9645        numa-vmstat.node0.nr_inactive_file
    638077           -33.3%     425461 ± 59%  numa-vmstat.node0.nr_unevictable
     76.00 ± 31%    +190.8%     221.00 ± 19%  numa-vmstat.node0.nr_writeback
     10661            -9.5%       9645        numa-vmstat.node0.nr_zone_inactive_file
    638077           -33.3%     425461 ± 59%  numa-vmstat.node0.nr_zone_unevictable
      4845 ±  4%     -13.5%       4190 ±  4%  numa-vmstat.node0.nr_zone_write_pending
   3851529           -14.7%    3286217 ±  7%  numa-vmstat.node0.numa_hit
   3806477           -14.2%    3265483 ±  7%  numa-vmstat.node0.numa_local
      4564 ±  8%    +267.7%      16783 ±  6%  numa-vmstat.node1.nr_active_anon
    435.00 ±  3%    +121.8%     965.00 ± 24%  numa-vmstat.node1.nr_active_file
     15745 ±  2%   +1432.2%     241250 ±103%  numa-vmstat.node1.nr_file_pages
     10421           -11.5%       9224        numa-vmstat.node1.nr_inactive_file
    258.33 ±  7%   +1244.8%       3474 ± 86%  numa-vmstat.node1.nr_mapped
      4756 ±  7%    +283.1%      18219 ±  7%  numa-vmstat.node1.nr_shmem
      9591 ±  5%     +38.4%      13273 ± 31%  numa-vmstat.node1.nr_slab_reclaimable
     43.33 ± 23%  +4.9e+05%     212790 ±118%  numa-vmstat.node1.nr_unevictable
     73.33 ± 33%    +287.7%     284.33 ± 16%  numa-vmstat.node1.nr_writeback
      4564 ±  8%    +267.7%      16783 ±  6%  numa-vmstat.node1.nr_zone_active_anon
    435.00 ±  3%    +121.8%     965.00 ± 24%  numa-vmstat.node1.nr_zone_active_file
     10419           -11.5%       9224        numa-vmstat.node1.nr_zone_inactive_file
     43.33 ± 23%  +4.9e+05%     212790 ±118%  numa-vmstat.node1.nr_zone_unevictable
      4833 ±  6%     -14.6%       4126 ±  3%  numa-vmstat.node1.nr_zone_write_pending
      4934 ±  6%    +248.0%      17172 ±  7%  proc-vmstat.nr_active_anon
      1413 ±  4%     +48.5%       2098 ±  2%  proc-vmstat.nr_active_file
  10819468            -4.6%   10317972        proc-vmstat.nr_dirtied
   2815140            +1.7%    2862098        proc-vmstat.nr_dirty_background_threshold
   5637165            +1.7%    5731195        proc-vmstat.nr_dirty_threshold
    668051            +1.8%     680232        proc-vmstat.nr_file_pages
  28324567            +1.7%   28796253        proc-vmstat.nr_free_pages
     68055            +1.4%      69025        proc-vmstat.nr_inactive_anon
     20939           -10.1%      18822        proc-vmstat.nr_inactive_file
      8663           +17.3%      10159        proc-vmstat.nr_mapped
      7417 ±  4%    +182.9%      20979 ±  6%  proc-vmstat.nr_shmem
     34084            -1.6%      33522        proc-vmstat.nr_slab_reclaimable
     74.67 ± 47%    +431.7%     397.00 ± 25%  proc-vmstat.nr_writeback
  10776634            -4.6%   10277772        proc-vmstat.nr_written
      4934 ±  6%    +248.0%      17172 ±  7%  proc-vmstat.nr_zone_active_anon
      1413 ±  4%     +48.5%       2098 ±  2%  proc-vmstat.nr_zone_active_file
     68055            +1.4%      69025        proc-vmstat.nr_zone_inactive_anon
     20939           -10.1%      18822        proc-vmstat.nr_zone_inactive_file
      9111 ±  3%      -8.1%       8369        proc-vmstat.nr_zone_write_pending
      4296 ± 60%     +97.3%       8477 ±  2%  proc-vmstat.numa_hint_faults
      1576 ± 14%    +264.4%       5743 ±  4%  proc-vmstat.numa_hint_faults_local
   8723644           -15.6%    7366610        proc-vmstat.numa_hit
   8643732           -15.7%    7286707        proc-vmstat.numa_local
     15558 ±  4%     +92.4%      29936 ±  5%  proc-vmstat.pgactivate
   8731532           -15.5%    7374524        proc-vmstat.pgalloc_normal
      9875           -35.5%       6365 ±  5%  proc-vmstat.pgdeactivate
    340704           +24.9%     425445        proc-vmstat.pgfault
   1720430            +3.0%    1771822        proc-vmstat.pgfree
  43110466            -4.6%   41148513        proc-vmstat.pgpgout
     19123           +34.1%      25635 ±  3%  proc-vmstat.pgreuse
     19745           -36.7%      12508 ±  5%  proc-vmstat.pgrotated
     19.38           -30.3%      13.50 ± 23%  perf-stat.i.MPKI
 3.189e+09           +73.4%   5.53e+09        perf-stat.i.branch-instructions
  46555527 ±  2%     +18.7%   55278064        perf-stat.i.branch-misses
     18.27            +1.4       19.70        perf-stat.i.cache-miss-rate%
  70430074            -7.2%   65328234        perf-stat.i.cache-misses
 3.619e+08           -14.3%  3.103e+08        perf-stat.i.cache-references
   1169939           -26.8%     856977        perf-stat.i.context-switches
      2.54          +162.8%       6.66 ±  3%  perf-stat.i.cpi
 4.157e+10 ±  2%    +332.8%  1.799e+11        perf-stat.i.cpu-cycles
     27900          +279.3%     105823        perf-stat.i.cpu-migrations
      1319 ±  4%    +132.1%       3062 ±  7%  perf-stat.i.cycles-between-cache-misses
   3050049 ±  3%     +16.8%    3561030 ±  7%  perf-stat.i.dTLB-load-misses
 4.871e+09           +44.2%  7.026e+09        perf-stat.i.dTLB-loads
      0.01 ±  3%      +0.0        0.01 ± 53%  perf-stat.i.dTLB-store-miss-rate%
    168434 ±  6%     -10.5%     150827 ±  4%  perf-stat.i.dTLB-store-misses
 2.074e+09           -20.2%  1.655e+09        perf-stat.i.dTLB-stores
     33.12            +3.4       36.55 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   7805140           -23.4%    5979299 ±  4%  perf-stat.i.iTLB-load-misses
  15708273           -34.1%   10356852 ±  2%  perf-stat.i.iTLB-loads
 1.658e+10           +54.2%  2.556e+10        perf-stat.i.instructions
      2348 ±  2%     +80.3%       4234 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.41           -56.6%       0.18 ±  5%  perf-stat.i.ipc
      2.13 ± 11%     -28.9%       1.52 ±  5%  perf-stat.i.major-faults
      0.47 ±  2%    +332.8%       2.04        perf-stat.i.metric.GHz
    767.32           -11.6%     678.07 ±  4%  perf-stat.i.metric.K/sec
    119.24           +38.3%     164.97        perf-stat.i.metric.M/sec
  32026246            -7.8%   29524133        perf-stat.i.node-load-misses
   2741192           -14.1%    2355999        perf-stat.i.node-loads
  13057055            -6.5%   12207837        perf-stat.i.node-store-misses
   1090894           -12.8%     951653        perf-stat.i.node-stores
     21.83           -44.4%      12.14        perf-stat.overall.MPKI
      1.46            -0.5        1.00        perf-stat.overall.branch-miss-rate%
     19.46            +1.6       21.05        perf-stat.overall.cache-miss-rate%
      2.51          +180.7%       7.04        perf-stat.overall.cpi
    590.22          +366.6%       2754        perf-stat.overall.cycles-between-cache-misses
      0.06 ±  2%      -0.0        0.05 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  5%      +0.0        0.01 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     33.20            +3.4       36.59        perf-stat.overall.iTLB-load-miss-rate%
      2124          +101.5%       4281 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.40           -64.4%       0.14        perf-stat.overall.ipc
 3.136e+09           +74.3%  5.467e+09        perf-stat.ps.branch-instructions
  45795098 ±  2%     +19.3%   54641207        perf-stat.ps.branch-misses
  69278385            -6.8%   64589920        perf-stat.ps.cache-misses
  3.56e+08           -13.8%  3.068e+08        perf-stat.ps.cache-references
   1150809           -26.4%     847302        perf-stat.ps.context-switches
 4.089e+10 ±  2%    +335.0%  1.779e+11        perf-stat.ps.cpu-cycles
     27444          +281.3%     104632        perf-stat.ps.cpu-migrations
   3000171 ±  3%     +17.4%    3522315 ±  7%  perf-stat.ps.dTLB-load-misses
 4.791e+09           +45.0%  6.947e+09        perf-stat.ps.dTLB-loads
    165678 ±  6%     -10.0%     149175 ±  4%  perf-stat.ps.dTLB-store-misses
  2.04e+09           -19.8%  1.636e+09        perf-stat.ps.dTLB-stores
   7677575           -23.0%    5911409 ±  3%  perf-stat.ps.iTLB-load-misses
  15451579           -33.7%   10239236 ±  2%  perf-stat.ps.iTLB-loads
 1.631e+10           +55.0%  2.527e+10        perf-stat.ps.instructions
      2.10 ± 11%     -28.7%       1.50 ±  5%  perf-stat.ps.major-faults
  31502576            -7.3%   29190451        perf-stat.ps.node-load-misses
   2696363           -13.6%    2329952        perf-stat.ps.node-loads
  12843536            -6.0%   12069090        perf-stat.ps.node-store-misses
   1073039           -12.3%     940643        perf-stat.ps.node-stores
  1.01e+12          +113.8%   2.16e+12        perf-stat.total.instructions
     50.96           -38.7       12.26        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     50.27           -38.1       12.13        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     50.26           -38.1       12.13        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.24           -38.1       12.12        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.97           -35.0       10.99        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.89           -34.9       10.99        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     44.30           -34.0       10.29        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.69 ±  3%      -4.9        0.76 ±  2%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      5.42 ±  8%      -4.7        0.75 ±  2%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      6.03 ±  3%      -4.4        1.60 ± 17%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      4.52 ±  6%      -3.8        0.70 ±  2%  perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      4.25 ±  6%      -3.7        0.54 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      4.58 ±  5%      -3.4        1.22 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      4.25 ±  5%      -3.2        1.09 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      3.52 ±  6%      -2.6        0.88 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      6.81 ±  4%      -2.5        4.34 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      6.45 ±  4%      -2.2        4.23 ±  6%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      2.50 ±  4%      -1.7        0.84 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      2.19            -1.6        0.62 ±  5%  perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.18            -1.6        0.62 ±  5%  perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.09 ±  4%      -1.3        0.75 ±  3%  perf-profile.calltrace.cycles-pp.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.05 ±  4%      -1.3        0.73 ±  2%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter
      2.00 ±  4%      -1.3        0.71 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush
      2.01 ±  4%      -1.3        0.72 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file
      1.72 ±  4%      -1.1        0.57 ±  3%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_timeout
      2.90 ±  4%      -1.1        1.76 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      1.72 ±  4%      -1.1        0.58 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_for_completion
      1.43            -1.1        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.46            -0.9        0.51        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.60 ±  8%      -0.8        1.81 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      2.30 ±  8%      -0.7        1.65 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page
      2.07 ±  5%      -0.6        1.50 ± 10%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      1.66 ±  4%      -0.4        1.24 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle
      1.56 ±  7%      -0.2        1.33 ± 11%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page
      0.88 ±  6%      +0.6        1.45 ±  9%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__submit_merged_write_cond.f2fs_write_cache_pages
      0.18 ±141%      +0.6        0.83 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.59 ±  9%      +0.7        1.27 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00            +0.7        0.74 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +0.7        0.74 ±  6%  perf-profile.calltrace.cycles-pp.schedule.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +0.8        0.81 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file
      5.75 ±  6%      +1.0        6.71 ±  3%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      5.76 ±  6%      +1.0        6.71 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.0        0.97        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +1.1        1.11 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_outplace_write_data
      0.00            +1.1        1.11 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_write_cache_pages
      0.00            +1.1        1.12 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +1.1        1.12 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.00            +1.1        1.12 ± 10%  perf-profile.calltrace.cycles-pp.finish_wait.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +1.2        1.24        perf-profile.calltrace.cycles-pp.__schedule.schedule.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.2        1.24        perf-profile.calltrace.cycles-pp.schedule.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.2        1.24 ±  7%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +1.3        1.25 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page
      0.00            +1.3        1.26 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +1.3        1.26 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.4        1.43 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.4        1.43 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +1.4        1.44 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +1.5        1.53 ±  3%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.__submit_merged_write_cond
      0.00            +1.7        1.70 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +1.7        1.71 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.7        1.71 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.8        1.77        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +1.8        1.77        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +1.8        1.78        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +2.0        2.04 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +2.0        2.04 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.0        2.05 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.5        2.46 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +2.5        2.46        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.5        2.47        perf-profile.calltrace.cycles-pp.finish_wait.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.9        2.88 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page
      0.00            +2.9        2.89 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page.__write_node_page
     14.97            +2.9       17.91        perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      9.47 ±  2%      +3.1       12.57        perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      0.00            +3.1        3.11 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      9.27 ±  3%      +3.2       12.52        perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      2.66            +3.6        6.25 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      2.03 ±  6%      +3.8        5.80 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +4.0        4.01 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages
      0.00            +4.0        4.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +4.1        4.14 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page
      0.00            +4.2        4.15 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +4.2        4.20 ±  4%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +4.4        4.45 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +4.5        4.46 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +4.5        4.48 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +4.5        4.51 ±  3%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +5.4        5.42 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +5.4        5.43 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +5.5        5.49 ±  4%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.09 ±  4%      +5.5        7.61 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +5.8        5.77 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +5.8        5.78 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +5.9        5.86 ±  4%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +6.1        6.08 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_write_cache_pages
      0.00            +6.1        6.11 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      2.84            +6.2        9.03 ±  7%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      0.00            +6.2        6.19 ±  8%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      1.78 ±  2%      +6.2        7.99 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +6.7        6.68 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +6.7        6.69 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      2.52 ±  3%      +6.7        9.27 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +6.8        6.76 ±  4%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     13.10 ±  2%      +8.7       21.82 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     13.04 ±  2%      +8.8       21.80 ±  3%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     13.03 ±  2%      +8.8       21.80 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
     13.02 ±  2%      +8.8       21.79 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file
     12.88            +8.9       21.75 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      0.00           +15.6       15.61        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00           +15.7       15.66        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +15.8       15.82        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.07 ±  3%     +18.6       20.71        perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     22.55           +24.6       47.18        perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     46.97           +40.2       87.15        perf-profile.calltrace.cycles-pp.write
     46.70           +40.4       87.06        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     46.69           +40.4       87.06        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.62           +40.4       87.03        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.61           +40.4       87.02        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.53           +40.5       87.00        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.50           +40.5       86.99        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     44.98           +41.6       86.57        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     50.96           -38.7       12.26        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     50.96           -38.7       12.26        perf-profile.children.cycles-pp.cpu_startup_entry
     50.95           -38.7       12.25        perf-profile.children.cycles-pp.do_idle
     50.27           -38.1       12.13        perf-profile.children.cycles-pp.start_secondary
     46.60           -35.5       11.11        perf-profile.children.cycles-pp.cpuidle_enter
     46.59           -35.5       11.11        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.05           -34.1       10.99        perf-profile.children.cycles-pp.intel_idle
     10.72 ±  2%     -10.7        0.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     12.55 ±  2%      -8.6        3.92 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     11.34 ±  2%      -6.2        5.17 ±  3%  perf-profile.children.cycles-pp.__schedule
      9.83 ±  2%      -5.1        4.68 ±  3%  perf-profile.children.cycles-pp.schedule
      4.77 ±  6%      -4.7        0.12 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      8.10 ±  3%      -4.3        3.80 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      9.54 ±  5%      -4.2        5.36 ±  5%  perf-profile.children.cycles-pp.osq_lock
      7.18 ±  5%      -4.1        3.04 ±  4%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      7.60 ±  3%      -4.0        3.65 ±  3%  perf-profile.children.cycles-pp.newidle_balance
      4.54 ±  6%      -3.8        0.71 ±  3%  perf-profile.children.cycles-pp.set_node_addr
      6.57 ±  3%      -3.7        2.89 ±  3%  perf-profile.children.cycles-pp.find_busiest_group
      6.49 ±  3%      -3.6        2.86 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      6.97 ±  3%      -3.6        3.36 ±  3%  perf-profile.children.cycles-pp.load_balance
      2.78            -2.6        0.20 ±  4%  perf-profile.children.cycles-pp.rwsem_wake
      6.81 ±  4%      -2.5        4.34 ±  6%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      2.25            -2.1        0.15 ±  3%  perf-profile.children.cycles-pp.wake_up_q
      2.37            -1.8        0.56 ±  2%  perf-profile.children.cycles-pp.__submit_bio
      2.37            -1.8        0.57        perf-profile.children.cycles-pp.submit_bio_noacct
      2.50 ±  4%      -1.7        0.85 ±  3%  perf-profile.children.cycles-pp.f2fs_issue_flush
      2.25            -1.6        0.64 ±  5%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      2.24            -1.6        0.64 ±  5%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      2.62            -1.4        1.25        perf-profile.children.cycles-pp.try_to_wake_up
      2.09 ±  4%      -1.3        0.75 ±  3%  perf-profile.children.cycles-pp.wait_for_completion
      2.05 ±  4%      -1.3        0.74 ±  3%  perf-profile.children.cycles-pp.schedule_timeout
     12.21 ±  4%      -1.3       10.93 ±  4%  perf-profile.children.cycles-pp.do_write_page
      1.72            -1.3        0.45 ±  2%  perf-profile.children.cycles-pp.__submit_merged_bio
      1.74            -1.2        0.50        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      2.35 ±  3%      -1.2        1.11 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.57 ±  3%      -1.1        3.51 ±  4%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      1.40 ±  2%      -1.1        0.35 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      1.40 ±  2%      -1.0        0.35 ±  2%  perf-profile.children.cycles-pp.kthread
      1.50 ±  6%      -1.0        0.46        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.29 ±  2%      -1.0        0.30 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      1.49 ±  2%      -1.0        0.52        perf-profile.children.cycles-pp.schedule_idle
      1.27            -0.9        0.33 ±  2%  perf-profile.children.cycles-pp.f2fs_buffered_write_iter
      1.50 ±  2%      -0.9        0.58 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      1.25            -0.9        0.33 ±  3%  perf-profile.children.cycles-pp.generic_perform_write
      1.32 ±  3%      -0.9        0.45        perf-profile.children.cycles-pp.ttwu_do_activate
      1.29 ±  3%      -0.8        0.46        perf-profile.children.cycles-pp.enqueue_task_fair
      1.09            -0.8        0.28        perf-profile.children.cycles-pp.brd_do_bvec
      1.10            -0.8        0.28 ±  2%  perf-profile.children.cycles-pp.brd_submit_bio
      0.95            -0.8        0.18 ±  2%  perf-profile.children.cycles-pp.menu_select
      1.07 ±  5%      -0.7        0.32 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.05 ±  6%      -0.7        0.32        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.99 ±  3%      -0.7        0.34        perf-profile.children.cycles-pp.enqueue_entity
      0.97            -0.6        0.36        perf-profile.children.cycles-pp.sched_ttwu_pending
      1.10 ±  3%      -0.6        0.51 ±  3%  perf-profile.children.cycles-pp.idle_cpu
      0.84 ±  3%      -0.6        0.25        perf-profile.children.cycles-pp.issue_flush_thread
      1.16 ±  2%      -0.6        0.58 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.69 ±  9%      -0.6        0.13 ± 29%  perf-profile.children.cycles-pp.start_kernel
      1.01 ±  2%      -0.5        0.49 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.68 ±  3%      -0.5        0.18 ± 10%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.72            -0.5        0.22 ±  4%  perf-profile.children.cycles-pp.__pagevec_release
      0.68 ±  2%      -0.5        0.18 ±  4%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.71            -0.5        0.22 ±  4%  perf-profile.children.cycles-pp.release_pages
      0.64            -0.5        0.17 ±  4%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.54 ±  4%      -0.4        0.09 ±  5%  perf-profile.children.cycles-pp.worker_thread
      0.48 ±  9%      -0.4        0.03 ± 70%  perf-profile.children.cycles-pp.ktime_get
      0.89 ±  2%      -0.4        0.45        perf-profile.children.cycles-pp.update_load_avg
      0.57 ±  3%      -0.4        0.15        perf-profile.children.cycles-pp.brd_insert_page
      0.44 ±  4%      -0.4        0.06 ±  7%  perf-profile.children.cycles-pp.__submit_flush_wait
      0.44 ±  4%      -0.4        0.06 ±  7%  perf-profile.children.cycles-pp.blkdev_issue_flush
      0.42 ±  5%      -0.4        0.06        perf-profile.children.cycles-pp.submit_bio_wait
      0.61 ±  4%      -0.4        0.25 ±  3%  perf-profile.children.cycles-pp.cpumask_next_and
      0.43 ±  6%      -0.4        0.07        perf-profile.children.cycles-pp.__lookup_nat_cache
      0.43 ±  5%      -0.4        0.07        perf-profile.children.cycles-pp.md_submit_bio
      0.52 ±  2%      -0.4        0.17 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.66 ±  2%      -0.4        0.31        perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.48            -0.3        0.13 ±  3%  perf-profile.children.cycles-pp.xas_find_marked
      0.57 ±  6%      -0.3        0.24        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.46 ±  5%      -0.3        0.13 ± 14%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.46 ±  5%      -0.3        0.13 ± 14%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.44 ±  2%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.__get_node_page
      0.36 ±  4%      -0.3        0.06 ±  8%  perf-profile.children.cycles-pp.md_handle_request
      0.40 ±  5%      -0.3        0.11 ± 12%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.51 ±  3%      -0.3        0.23 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.45 ±  2%      -0.3        0.17 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.38 ±  5%      -0.3        0.10 ±  4%  perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.37 ±  2%      -0.3        0.09        perf-profile.children.cycles-pp.f2fs_write_end
      0.42 ±  4%      -0.3        0.14 ± 11%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.39 ±  9%      -0.3        0.12 ±  4%  perf-profile.children.cycles-pp.up_read
      0.37            -0.3        0.09 ±  5%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.34 ±  2%      -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.process_one_work
      0.32 ±  6%      -0.3        0.05        perf-profile.children.cycles-pp.raid0_make_request
      0.37 ±  4%      -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.folio_end_writeback
      0.37 ±  7%      -0.3        0.10 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
      0.33 ±  2%      -0.3        0.07 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.36 ±  7%      -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.33 ±  2%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.41 ±  7%      -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.33 ±  3%      -0.2        0.10        perf-profile.children.cycles-pp.set_next_entity
      0.28            -0.2        0.05 ±  8%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.29 ±  4%      -0.2        0.07 ± 14%  perf-profile.children.cycles-pp.f2fs_update_inode_page
      0.33 ±  5%      -0.2        0.11 ± 17%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.33 ±  5%      -0.2        0.11 ± 17%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.31 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.down_write
      0.30 ±  3%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.f2fs_write_inode
      0.37 ± 10%      -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.28            -0.2        0.07 ± 11%  perf-profile.children.cycles-pp.update_sit_entry
      0.37 ±  9%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.27            -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.29            -0.2        0.09        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.36 ± 10%      -0.2        0.17 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.45            -0.2        0.26        perf-profile.children.cycles-pp.update_curr
      0.32 ± 14%      -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.32 ±  2%      -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.27 ±  4%      -0.2        0.08 ± 20%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.34            -0.2        0.15        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.24            -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.llist_add_batch
      0.24 ±  3%      -0.2        0.06        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.45 ±  6%      -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.27 ± 13%      -0.2        0.10        perf-profile.children.cycles-pp.__softirqentry_text_start
      0.25 ±  7%      -0.2        0.09        perf-profile.children.cycles-pp.sched_clock_cpu
      0.25 ±  3%      -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.21 ±  2%      -0.2        0.05 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.23 ±  8%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.22 ±  2%      -0.2        0.07        perf-profile.children.cycles-pp.__switch_to
      0.18 ±  2%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.20 ±  4%      -0.2        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.19 ±  2%      -0.1        0.06        perf-profile.children.cycles-pp.up_write
      0.31 ±  5%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.complete
      0.21 ±  3%      -0.1        0.08        perf-profile.children.cycles-pp.__alloc_pages
      0.20            -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.19 ±  4%      -0.1        0.07        perf-profile.children.cycles-pp.get_page_from_freelist
      0.16 ± 21%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.xas_load
      0.19 ±  2%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.22 ±  5%      -0.1        0.10        perf-profile.children.cycles-pp.__update_load_avg_se
      0.26 ±  3%      -0.1        0.14        perf-profile.children.cycles-pp.update_blocked_averages
      0.14 ±  3%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__dentry_kill
      0.14            -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.evict
      0.14            -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.f2fs_evict_inode
      0.16 ±  5%      -0.1        0.06        perf-profile.children.cycles-pp.cpuacct_charge
      0.15 ±  3%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__close
      0.15 ±  3%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.task_work_run
      0.26 ±  5%      -0.1        0.17        perf-profile.children.cycles-pp.swake_up_locked
      0.14 ±  3%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.dput
      0.14 ±  3%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__fput
      0.19 ±  6%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.20 ±  7%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.12 ± 10%      -0.1        0.05        perf-profile.children.cycles-pp.prep_new_page
      0.10 ±  8%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.reweight_entity
      0.11 ±  7%      -0.1        0.05        perf-profile.children.cycles-pp.kernel_init_free_pages
      0.11 ±  7%      -0.1        0.05        perf-profile.children.cycles-pp.clear_page_erms
      0.11 ±  4%      -0.1        0.05        perf-profile.children.cycles-pp.perf_tp_event
      0.10            -0.1        0.05        perf-profile.children.cycles-pp.rebalance_domains
      0.22 ±  6%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.10 ±  8%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.f2fs_wait_on_node_pages_writeback
      0.11 ±  7%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.set_task_cpu
      0.26 ±  5%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.f2fs_wait_on_page_writeback
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
      0.02 ±141%      +0.2        0.22 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
      0.00            +0.3        0.28        perf-profile.children.cycles-pp.down_read_trylock
      0.07 ± 12%      +0.3        0.42 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ± 14%      +0.9        0.99        perf-profile.children.cycles-pp.autoremove_wake_function
      0.08 ± 12%      +0.9        1.02        perf-profile.children.cycles-pp.__wake_up_common
      5.76 ±  6%      +1.0        6.71 ±  3%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
     14.97            +2.9       17.91        perf-profile.children.cycles-pp.__write_node_page
      9.47 ±  2%      +3.1       12.57        perf-profile.children.cycles-pp.f2fs_write_single_data_page
      9.27 ±  3%      +3.2       12.52        perf-profile.children.cycles-pp.f2fs_do_write_data_page
      2.66            +3.6        6.25 ±  3%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      2.09 ±  4%      +5.5        7.61 ±  3%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      2.52 ±  3%      +6.7        9.27 ±  3%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
     13.10            +8.7       21.82 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
     13.04 ±  2%      +8.8       21.80 ±  3%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     13.03 ±  2%      +8.8       21.80 ±  3%  perf-profile.children.cycles-pp.do_writepages
     13.02 ±  2%      +8.8       21.79 ±  3%  perf-profile.children.cycles-pp.f2fs_write_data_pages
     12.88 ±  2%      +8.9       21.75 ±  3%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      0.11 ± 12%      +9.8        9.89        perf-profile.children.cycles-pp.__wake_up_common_lock
      3.81 ±  4%     +10.0       13.81 ±  3%  perf-profile.children.cycles-pp.f2fs_get_node_info
      0.00           +11.8       11.84        perf-profile.children.cycles-pp.finish_wait
     22.55           +24.6       47.18        perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      4.92           +24.9       29.81 ±  3%  perf-profile.children.cycles-pp.__submit_merged_write_cond
     47.00           +40.2       87.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     46.99           +40.2       87.16        perf-profile.children.cycles-pp.write
     46.98           +40.2       87.18        perf-profile.children.cycles-pp.do_syscall_64
     46.62           +40.4       87.03        perf-profile.children.cycles-pp.ksys_write
     46.61           +40.4       87.03        perf-profile.children.cycles-pp.vfs_write
     46.53           +40.5       87.01        perf-profile.children.cycles-pp.new_sync_write
     46.50           +40.5       86.99        perf-profile.children.cycles-pp.f2fs_file_write_iter
     44.98           +41.6       86.57        perf-profile.children.cycles-pp.f2fs_do_sync_file
      0.00           +48.9       48.88        perf-profile.children.cycles-pp.prepare_to_wait_event
      5.41 ±  4%     +64.5       69.90        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.72 ±  5%     +68.5       70.27        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     44.80           -33.9       10.92        perf-profile.self.cycles-pp.intel_idle
      9.47 ±  5%      -4.1        5.32 ±  5%  perf-profile.self.cycles-pp.osq_lock
      4.87 ±  3%      -2.7        2.14 ±  3%  perf-profile.self.cycles-pp.update_sd_lb_stats
      1.77            -1.3        0.51 ±  5%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      1.70            -1.2        0.49        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.34            -0.9        0.46 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.71            -0.6        0.14 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      1.07 ±  3%      -0.6        0.50 ±  4%  perf-profile.self.cycles-pp.idle_cpu
      0.74            -0.5        0.22 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.68            -0.5        0.21 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.55 ±  2%      -0.4        0.10 ±  4%  perf-profile.self.cycles-pp.menu_select
      0.43 ±  3%      -0.4        0.08        perf-profile.self.cycles-pp.f2fs_fsync_node_pages
      0.65 ±  3%      -0.3        0.31        perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.47 ±  2%      -0.3        0.13 ±  6%  perf-profile.self.cycles-pp.xas_find_marked
      0.38 ±  2%      -0.3        0.09 ±  5%  perf-profile.self.cycles-pp.brd_do_bvec
      0.39 ±  8%      -0.3        0.12 ±  4%  perf-profile.self.cycles-pp.up_read
      0.35            -0.3        0.08 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.36 ±  2%      -0.3        0.09 ±  5%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.46 ±  2%      -0.3        0.21 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.80            -0.2        0.57        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.28 ±  3%      -0.2        0.05 ±  8%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.36 ± 10%      -0.2        0.15 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.28 ±  4%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.down_write
      0.27 ±  3%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.update_sit_entry
      0.33 ±  3%      -0.2        0.13 ±  3%  perf-profile.self.cycles-pp.update_rq_clock
      0.28 ±  5%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.33 ±  2%      -0.2        0.15        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.24            -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.llist_add_batch
      0.28 ±  7%      -0.2        0.11 ± 23%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.29 ±  3%      -0.2        0.12        perf-profile.self.cycles-pp.newidle_balance
      0.25 ±  3%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.19 ±  2%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.mutex_lock
      0.22 ±  2%      -0.2        0.07        perf-profile.self.cycles-pp.__switch_to
      0.23 ±  7%      -0.2        0.07 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.21 ±  6%      -0.2        0.06        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.20 ±  4%      -0.2        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.20 ±  4%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.f2fs_do_sync_file
      0.20 ±  7%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.19 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.__filemap_get_folio
      0.19 ±  2%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.19 ±  2%      -0.1        0.06        perf-profile.self.cycles-pp.up_write
      0.21 ±  6%      -0.1        0.09        perf-profile.self.cycles-pp.__update_load_avg_se
      0.32 ±  2%      -0.1        0.20        perf-profile.self.cycles-pp.update_load_avg
      0.19 ±  6%      -0.1        0.07        perf-profile.self.cycles-pp.cpumask_next_and
      0.15 ±  5%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__write_node_page
      0.16 ±  5%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.16 ±  5%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.try_to_wake_up
      0.16 ± 10%      -0.1        0.07        perf-profile.self.cycles-pp.finish_task_switch
      0.14            -0.1        0.06        perf-profile.self.cycles-pp.dequeue_task_fair
      0.11 ±  8%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.dequeue_entity
      0.18 ±  9%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.13 ±  3%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.27 ±  4%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.load_balance
      0.11 ±  7%      -0.1        0.05        perf-profile.self.cycles-pp.clear_page_erms
      0.15 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.11 ±  7%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.select_idle_cpu
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.24 ±  3%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.00            +0.3        0.28        perf-profile.self.cycles-pp.down_read_trylock
      5.41 ±  5%     +64.5       69.90        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp1: 96 threads 2 sockets Ice Lake with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/f2fs/x86_64-rhel-8.3/200/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp1/sync_disk_rw/aim7/0xb000280

commit: 
  dd81e1c7d5 ("Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux")
  e4544b63a7 ("f2fs: move f2fs to use reader-unfair rwsems")

dd81e1c7d5fb126e e4544b63a7ee49e7fbebf35ece0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12483           -84.3%       1962        aim7.jobs-per-min
     96.14          +536.0%     611.49        aim7.time.elapsed_time
     96.14          +536.0%     611.49        aim7.time.elapsed_time.max
 1.692e+08            +1.8%  1.723e+08        aim7.time.file_system_outputs
      6160 ±  4%  +1.1e+05%    6694136        aim7.time.involuntary_context_switches
     18099          +664.3%     138328        aim7.time.minor_page_faults
      1299 ±  2%   +4081.0%      54312        aim7.time.system_time
  58056898          +290.6%  2.267e+08        aim7.time.voluntary_context_switches
 7.893e+09           -55.5%  3.514e+09        cpuidle..time
  73095489           -20.9%   57810565        cpuidle..usage
     85.58           -92.7%       6.29        iostat.cpu.idle
     14.22 ±  2%    +558.2%      93.61        iostat.cpu.system
    145.34          +355.2%     661.63        uptime.boot
     11998           -35.9%       7689 ±  5%  uptime.idle
   6742969           -17.4%    5571083        numa-numastat.node0.local_node
   6823709           -17.4%    5639266        numa-numastat.node0.numa_hit
   6798264           -14.5%    5815068        numa-numastat.node1.local_node
   6804464           -14.3%    5833861        numa-numastat.node1.numa_hit
     85.35           -79.4        5.99        mpstat.cpu.all.idle%
      0.08 ±  4%      -0.0        0.04        mpstat.cpu.all.iowait%
      0.84            -0.1        0.76        mpstat.cpu.all.irq%
      0.07 ±  4%      -0.0        0.06 ±  3%  mpstat.cpu.all.soft%
     13.56 ±  2%     +79.5       93.09        mpstat.cpu.all.sys%
      0.10            -0.0        0.06 ±  4%  mpstat.cpu.all.usr%
     85.00           -93.3%       5.67 ±  8%  vmstat.cpu.id
     13.50 ±  3%    +588.9%      93.00        vmstat.cpu.sy
    846764           -83.5%     139684        vmstat.io.bo
     11.00 ±  9%    +933.3%     113.67        vmstat.procs.r
   1183936           -59.7%     477355        vmstat.system.cs
    211025           +56.6%     330512 ±  2%  vmstat.system.in
    533.50          +464.7%       3012        turbostat.Avg_MHz
     16.94           +77.2       94.16        turbostat.Busy%
      3150            +1.6%       3199        turbostat.Bzy_MHz
    579094 ±  5%     -22.8%     447105 ±  2%  turbostat.C1
      0.33 ± 51%      -0.3        0.01        turbostat.C1%
  71295956           -20.5%   56653835        turbostat.C1E
     73.94           -68.7        5.28 ± 11%  turbostat.C1E%
      9.78 ± 10%      -9.1        0.67 ± 93%  turbostat.C6%
  20957361          +869.3%  2.031e+08 ±  2%  turbostat.IRQ
     56908          +353.4%     257999 ±  3%  meminfo.Active
     39602          +530.7%     249767 ±  3%  meminfo.Active(anon)
     17306           -52.4%       8231        meminfo.Active(file)
    105917           +79.9%     190493        meminfo.AnonHugePages
    594255           +40.5%     834703        meminfo.Committed_AS
     63409 ±  4%     -42.0%      36801        meminfo.Dirty
    291621           +20.5%     351546        meminfo.Inactive(anon)
    169783           -11.8%     149753        meminfo.KReclaimable
     38138          +136.7%      90271        meminfo.Mapped
  28475029           -34.0%   18798070        meminfo.Memused
    636.00 ±  3%    +177.4%       1764 ± 24%  meminfo.Mlocked
      9850 ±  3%      -5.1%       9345 ±  4%  meminfo.PageTables
    169783           -11.8%     149753        meminfo.SReclaimable
     58115          +490.9%     343429 ±  2%  meminfo.Shmem
  28483719           -33.5%   18949734        meminfo.max_used_kB
      9581 ± 13%     +51.7%      14539        numa-meminfo.node0.Active
    934.00          +881.5%       9167        numa-meminfo.node0.Active(anon)
      8647 ± 14%     -37.9%       5371        numa-meminfo.node0.Active(file)
     95760           +76.3%     168809 ± 16%  numa-meminfo.node0.AnonHugePages
     31891 ± 10%     -39.6%      19270        numa-meminfo.node0.Dirty
     23476 ± 55%    +147.4%      58089 ±  4%  numa-meminfo.node0.Mapped
  14415585 ±  6%     -26.1%   10649512        numa-meminfo.node0.MemUsed
    372.50 ± 76%    +373.3%       1763 ± 24%  numa-meminfo.node0.Mlocked
     18462          +194.6%      54386 ±  7%  numa-meminfo.node0.Shmem
     47350          +414.4%     243549 ±  3%  numa-meminfo.node1.Active
     38668          +522.4%     240689 ±  4%  numa-meminfo.node1.Active(anon)
      8681 ± 15%     -67.1%       2859 ±  2%  numa-meminfo.node1.Active(file)
     32058 ±  7%     -44.9%      17649        numa-meminfo.node1.Dirty
    117743           +28.0%     150756 ± 14%  numa-meminfo.node1.Inactive
     40960 ±  5%    +102.5%      82950 ± 26%  numa-meminfo.node1.Inactive(anon)
     76782           -11.7%      67806        numa-meminfo.node1.Inactive(file)
     78459 ± 27%     -39.3%      47626 ±  7%  numa-meminfo.node1.KReclaimable
      9789 ± 17%     -27.9%       7059        numa-meminfo.node1.KernelStack
  14079524 ±  7%     -42.2%    8143366        numa-meminfo.node1.MemUsed
      4192 ± 74%     -82.2%     746.67 ± 13%  numa-meminfo.node1.PageTables
     78459 ± 27%     -39.3%      47626 ±  7%  numa-meminfo.node1.SReclaimable
    103123 ±  6%      -7.3%      95605        numa-meminfo.node1.SUnreclaim
     39654          +630.2%     289555 ±  2%  numa-meminfo.node1.Shmem
    181582 ±  7%     -21.1%     143232 ±  3%  numa-meminfo.node1.Slab
   1254572 ± 86%     -95.3%      59268 ±140%  numa-meminfo.node1.Unevictable
    232.50          +870.5%       2256        numa-vmstat.node0.nr_active_anon
      2156 ± 15%     -37.8%       1342        numa-vmstat.node0.nr_active_file
      8229 ± 10%     -41.7%       4795        numa-vmstat.node0.nr_dirty
      6054 ± 54%    +139.0%      14470 ±  4%  numa-vmstat.node0.nr_mapped
     91.00 ± 75%    +384.2%     440.67 ± 24%  numa-vmstat.node0.nr_mlock
      4614          +189.5%      13357 ±  6%  numa-vmstat.node0.nr_shmem
    232.50          +870.5%       2256        numa-vmstat.node0.nr_zone_active_anon
      2156 ± 15%     -37.8%       1342        numa-vmstat.node0.nr_zone_active_file
      6890 ±  2%     -28.6%       4922        numa-vmstat.node0.nr_zone_write_pending
   5033122 ±  4%      -8.0%    4630395 ±  3%  numa-vmstat.node0.numa_hit
   4948093 ±  4%      -7.8%    4561425 ±  3%  numa-vmstat.node0.numa_local
      9649          +523.1%      60122 ±  4%  numa-vmstat.node1.nr_active_anon
      2164 ± 14%     -67.0%     714.00 ±  2%  numa-vmstat.node1.nr_active_file
   4707044           +13.9%    5363169        numa-vmstat.node1.nr_dirtied
      8055 ± 11%     -45.3%       4407        numa-vmstat.node1.nr_dirty
     10262 ±  5%     +98.4%      20358 ± 27%  numa-vmstat.node1.nr_inactive_anon
     19206           -11.7%      16955        numa-vmstat.node1.nr_inactive_file
      9811 ± 17%     -28.1%       7058        numa-vmstat.node1.nr_kernel_stack
      1055 ± 74%     -82.4%     185.67 ± 13%  numa-vmstat.node1.nr_page_table_pages
      9896          +627.2%      71971 ±  2%  numa-vmstat.node1.nr_shmem
     19597 ± 27%     -39.2%      11906 ±  7%  numa-vmstat.node1.nr_slab_reclaimable
     25785 ±  6%      -7.3%      23901        numa-vmstat.node1.nr_slab_unreclaimable
    313642 ± 86%     -95.3%      14816 ±140%  numa-vmstat.node1.nr_unevictable
   4684528           +14.0%    5341105        numa-vmstat.node1.nr_written
      9649          +523.1%      60122 ±  4%  numa-vmstat.node1.nr_zone_active_anon
      2164 ± 14%     -67.0%     714.00 ±  2%  numa-vmstat.node1.nr_zone_active_file
     10262 ±  5%     +98.4%      20358 ± 27%  numa-vmstat.node1.nr_zone_inactive_anon
     19205           -11.7%      16955        numa-vmstat.node1.nr_zone_inactive_file
    313642 ± 86%     -95.3%      14816 ±140%  numa-vmstat.node1.nr_zone_unevictable
      6901 ±  3%     -35.1%       4478        numa-vmstat.node1.nr_zone_write_pending
   4486602 ±  5%     -17.9%    3684591 ±  4%  numa-vmstat.node1.numa_hit
   4440568 ±  5%     -18.4%    3621361 ±  4%  numa-vmstat.node1.numa_local
      9901          +536.1%      62980 ±  3%  proc-vmstat.nr_active_anon
      4336           -52.6%       2057        proc-vmstat.nr_active_file
     68316            -5.5%      64565        proc-vmstat.nr_anon_pages
  21148734            +1.8%   21537941        proc-vmstat.nr_dirtied
     15918 ±  8%     -42.1%       9218        proc-vmstat.nr_dirty
   5849571            +4.1%    6091176        proc-vmstat.nr_dirty_background_threshold
  11713447            +4.1%   12197246        proc-vmstat.nr_dirty_threshold
    694874            +9.5%     761213        proc-vmstat.nr_file_pages
  58823752            +4.1%   61248436        proc-vmstat.nr_free_pages
     72904           +20.1%      87544        proc-vmstat.nr_inactive_anon
     38227            -7.4%      35404        proc-vmstat.nr_inactive_file
     21036            -8.2%      19316        proc-vmstat.nr_kernel_stack
      9777          +127.9%      22280        proc-vmstat.nr_mapped
    158.50 ±  3%    +178.0%     440.67 ± 24%  proc-vmstat.nr_mlock
      2457 ±  3%      -4.9%       2336 ±  4%  proc-vmstat.nr_page_table_pages
     14529          +492.2%      86047 ±  2%  proc-vmstat.nr_shmem
     42465           -11.8%      37438        proc-vmstat.nr_slab_reclaimable
     59654            -1.9%      58528        proc-vmstat.nr_slab_unreclaimable
  21062816            +1.9%   21461542        proc-vmstat.nr_written
      9901          +536.1%      62980 ±  3%  proc-vmstat.nr_zone_active_anon
      4336           -52.6%       2057        proc-vmstat.nr_zone_active_file
     72904           +20.1%      87544        proc-vmstat.nr_zone_inactive_anon
     38227            -7.4%      35404        proc-vmstat.nr_zone_inactive_file
     13650 ±  2%     -31.0%       9415        proc-vmstat.nr_zone_write_pending
      6159         +3856.2%     243662        proc-vmstat.numa_hint_faults
      3574 ±  2%   +4123.5%     150947 ±  2%  proc-vmstat.numa_hint_faults_local
  13630061           -15.8%   11475136        proc-vmstat.numa_hit
  13543124           -15.9%   11388160        proc-vmstat.numa_local
      2201 ± 11%   +1251.0%      29742 ± 31%  proc-vmstat.numa_pages_migrated
     32942         +1067.5%     384615        proc-vmstat.numa_pte_updates
     30788         +1735.5%     565120        proc-vmstat.pgactivate
  13629985           -15.8%   11475237        proc-vmstat.pgalloc_normal
    464647          +395.9%    2304278        proc-vmstat.pgfault
   3169981           +53.8%    4874411        proc-vmstat.pgfree
      2201 ± 11%   +1251.0%      29742 ± 31%  proc-vmstat.pgmigrate_success
  84250926            +1.9%   85851960        proc-vmstat.pgpgout
     29076          +373.8%     137766        proc-vmstat.pgreuse
     32.86 ±  3%     -39.4%      19.92 ±  3%  perf-stat.i.MPKI
 2.756e+09            +3.0%  2.838e+09        perf-stat.i.branch-instructions
      2.05 ±  4%      -1.2        0.81 ±  7%  perf-stat.i.branch-miss-rate%
  35951043           -39.5%   21764863        perf-stat.i.branch-misses
     28.77            -9.4       19.39        perf-stat.i.cache-miss-rate%
 1.136e+08           -56.1%   49846483        perf-stat.i.cache-misses
 3.656e+08           -30.1%  2.556e+08        perf-stat.i.cache-references
   1215541           -60.6%     478901        perf-stat.i.context-switches
      4.10          +435.8%      21.97        perf-stat.i.cpi
 5.345e+10          +440.2%  2.887e+11        perf-stat.i.cpu-cycles
     66411 ±  2%     +44.2%      95797        perf-stat.i.cpu-migrations
      1525 ±  5%    +281.4%       5817        perf-stat.i.cycles-between-cache-misses
      0.16 ±  5%      -0.1        0.04 ± 15%  perf-stat.i.dTLB-load-miss-rate%
   3023623           -59.2%    1234888        perf-stat.i.dTLB-load-misses
      0.03 ±  6%      -0.0        0.01 ± 11%  perf-stat.i.dTLB-store-miss-rate%
    294812           -74.0%      76526        perf-stat.i.dTLB-store-misses
  1.76e+09           -45.4%  9.608e+08        perf-stat.i.dTLB-stores
  1.34e+10            -2.7%  1.304e+10        perf-stat.i.instructions
      0.25 ±  2%     -80.0%       0.05 ±  2%  perf-stat.i.ipc
      2.08           -81.1%       0.39 ±  4%  perf-stat.i.major-faults
      0.56          +440.2%       3.01        perf-stat.i.metric.GHz
    839.16           -60.2%     334.10 ±  2%  perf-stat.i.metric.K/sec
     87.52            -9.5%      79.18        perf-stat.i.metric.M/sec
      3594            -2.4%       3507        perf-stat.i.minor-faults
     90.71            +3.7       94.43        perf-stat.i.node-load-miss-rate%
  25173486           -47.0%   13342739        perf-stat.i.node-load-misses
   1990993           -63.0%     737592        perf-stat.i.node-loads
     44.15            -2.1       42.01        perf-stat.i.node-store-miss-rate%
  20372419           -64.9%    7153908        perf-stat.i.node-store-misses
  24828843           -60.8%    9722644        perf-stat.i.node-stores
      3596            -2.4%       3508        perf-stat.i.page-faults
     27.29           -28.2%      19.60        perf-stat.overall.MPKI
      1.30            -0.5        0.77        perf-stat.overall.branch-miss-rate%
     31.07           -11.6       19.50        perf-stat.overall.cache-miss-rate%
      3.99          +455.1%      22.14        perf-stat.overall.cpi
    470.62 ±  2%   +1130.9%       5792        perf-stat.overall.cycles-between-cache-misses
      0.09            -0.1        0.03        perf-stat.overall.dTLB-load-miss-rate%
      0.02            -0.0        0.01        perf-stat.overall.dTLB-store-miss-rate%
      0.25           -82.0%       0.05        perf-stat.overall.ipc
     92.67            +2.1       94.76        perf-stat.overall.node-load-miss-rate%
     45.07            -2.7       42.38        perf-stat.overall.node-store-miss-rate%
 2.726e+09            +4.0%  2.834e+09        perf-stat.ps.branch-instructions
  35568993           -38.9%   21733078        perf-stat.ps.branch-misses
 1.124e+08           -55.7%   49768816        perf-stat.ps.cache-misses
 3.617e+08           -29.4%  2.552e+08        perf-stat.ps.cache-references
   1202229           -60.2%     478124        perf-stat.ps.context-switches
 5.287e+10          +445.3%  2.883e+11        perf-stat.ps.cpu-cycles
     65684 ±  3%     +45.6%      95643        perf-stat.ps.cpu-migrations
   2991936           -58.6%    1240028        perf-stat.ps.dTLB-load-misses
  3.49e+09            +1.5%  3.543e+09        perf-stat.ps.dTLB-loads
    291762           -73.8%      76570        perf-stat.ps.dTLB-store-misses
 1.741e+09           -44.9%  9.597e+08        perf-stat.ps.dTLB-stores
 1.325e+10            -1.8%  1.302e+10        perf-stat.ps.instructions
      2.06           -81.0%       0.39 ±  4%  perf-stat.ps.major-faults
      3555            -1.4%       3505        perf-stat.ps.minor-faults
  24897847           -46.5%   13321377        perf-stat.ps.node-load-misses
   1969209           -62.6%     737076        perf-stat.ps.node-loads
  20149400           -64.6%    7140855        perf-stat.ps.node-store-misses
  24557175           -60.5%    9709014        perf-stat.ps.node-stores
      3557            -1.5%       3505        perf-stat.ps.page-faults
 1.284e+12          +521.0%  7.972e+12        perf-stat.total.instructions
     18.77           -18.8        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     18.60           -18.6        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     18.58           -18.6        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     18.54           -18.5        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     17.80 ±  3%     -17.8        0.00        perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
     17.12 ±  3%     -17.1        0.00        perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
     13.68 ±  4%     -13.7        0.00        perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
     13.22 ±  4%     -13.2        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
     12.74           -12.7        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     12.56           -12.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     11.96 ±  4%     -12.0        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
     26.24 ±  2%     -10.6       15.69 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     26.17 ±  2%     -10.5       15.69 ±  3%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     26.16 ±  2%     -10.5       15.69 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
     26.14 ±  2%     -10.5       15.69 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file
     25.93 ±  2%     -10.2       15.68 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
     10.22           -10.2        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      9.25            -9.2        0.00        perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      9.24            -9.2        0.00        perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      8.64 ±  3%      -8.6        0.00        perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      8.17 ±  3%      -8.2        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      6.54            -6.5        0.00        perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      6.48            -6.5        0.00        perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     20.78 ±  2%      -5.9       14.89        perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      5.83            -5.8        0.00        perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
     20.54 ±  2%      -5.7       14.88        perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
     25.66            -3.4       22.25        perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.18 ±  3%      -1.2        1.03 ± 59%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.__write_node_page
      0.00            +0.7        0.71        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
     41.07            +1.6       42.71        perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +1.6        1.65        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page
      0.00            +1.6        1.65        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +1.6        1.65        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.7        1.67        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +1.7        1.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +1.7        1.67        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +2.1        2.09        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +2.1        2.09        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.1        2.10        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.3        2.28        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +2.3        2.29        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.3        2.29        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.4        2.35        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +2.4        2.36        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.4        2.36        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +5.7        5.70        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages
      0.00            +5.7        5.70        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +6.5        6.46        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      3.66 ±  6%     +11.4       15.09        perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +12.5       12.54        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page
      0.00           +12.6       12.56        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00           +12.7       12.68        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      1.71 ±  5%     +12.9       14.57        perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00           +13.1       13.06        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page
      0.00           +13.1       13.07        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00           +13.2       13.19        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      3.30 ±  7%     +15.7       19.01        perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00           +16.4       16.43        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00           +16.4       16.45        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +16.6       16.60        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +17.0       17.03        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00           +17.1       17.06        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +17.2       17.21        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.48 ±  2%     +17.4       19.88        perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      3.06 ±  5%     +17.7       20.72        perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00           +17.9       17.92        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00           +17.9       17.94        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +18.1       18.10        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     79.76           +19.6       99.33        perf-profile.calltrace.cycles-pp.write
     79.41           +19.9       99.27        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     79.38           +19.9       99.27        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     79.23           +20.0       99.27        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     79.21           +20.1       99.26        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     79.08           +20.2       99.26        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.06           +20.2       99.26        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     76.57           +22.6       99.14        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     27.22           -26.8        0.42 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     26.37 ±  2%     -25.8        0.56 ± 15%  perf-profile.children.cycles-pp.do_write_page
     23.81 ±  2%     -23.5        0.32 ±  4%  perf-profile.children.cycles-pp.osq_lock
     18.77           -18.3        0.46        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     18.77           -18.3        0.46        perf-profile.children.cycles-pp.cpu_startup_entry
     18.76           -18.3        0.46        perf-profile.children.cycles-pp.do_idle
     18.60           -18.1        0.46        perf-profile.children.cycles-pp.start_secondary
     17.81 ±  3%     -17.6        0.25 ±  5%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
     16.83 ±  4%     -16.7        0.15 ±  6%  perf-profile.children.cycles-pp.f2fs_submit_page_write
     12.68 ±  6%     -12.7        0.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     12.87           -12.6        0.27        perf-profile.children.cycles-pp.cpuidle_enter
     12.84           -12.6        0.27        perf-profile.children.cycles-pp.cpuidle_enter_state
     12.19 ±  7%     -12.1        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     26.25 ±  2%     -10.6       15.69 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
     26.17 ±  2%     -10.5       15.69 ±  3%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     26.16 ±  2%     -10.5       15.69 ±  3%  perf-profile.children.cycles-pp.do_writepages
     26.14 ±  2%     -10.5       15.69 ±  3%  perf-profile.children.cycles-pp.f2fs_write_data_pages
     25.94 ±  2%     -10.3       15.68 ±  3%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
     10.38           -10.1        0.24        perf-profile.children.cycles-pp.intel_idle
      9.25            -8.9        0.34 ± 22%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
      8.96            -8.7        0.24 ±  8%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      8.66 ±  3%      -8.3        0.31        perf-profile.children.cycles-pp.set_node_addr
      6.62            -6.5        0.16 ±  7%  perf-profile.children.cycles-pp.__mutex_lock
      6.62            -6.3        0.31 ±  3%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      6.60            -6.3        0.30        perf-profile.children.cycles-pp.find_get_pages_range_tag
     20.78 ±  2%      -5.9       14.89        perf-profile.children.cycles-pp.f2fs_write_single_data_page
     20.54 ±  2%      -5.7       14.88        perf-profile.children.cycles-pp.f2fs_do_write_data_page
      6.57 ±  2%      -5.3        1.29 ± 48%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      5.78            -4.4        1.42 ±  2%  perf-profile.children.cycles-pp.__schedule
      3.74            -3.7        0.05        perf-profile.children.cycles-pp.rwsem_wake
     25.66            -3.4       22.25        perf-profile.children.cycles-pp.__write_node_page
      2.73            -2.6        0.09        perf-profile.children.cycles-pp.submit_bio_noacct
      2.73            -2.6        0.09        perf-profile.children.cycles-pp.__submit_bio
      2.86            -2.6        0.22        perf-profile.children.cycles-pp._raw_spin_lock
      3.92 ±  3%      -2.6        1.37 ±  2%  perf-profile.children.cycles-pp.schedule
      3.29            -2.5        0.79        perf-profile.children.cycles-pp.try_to_wake_up
      2.54            -2.4        0.10 ±  4%  perf-profile.children.cycles-pp.__pagevec_release
      2.52            -2.4        0.10 ±  4%  perf-profile.children.cycles-pp.release_pages
      2.48 ±  2%      -2.4        0.07 ±  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      2.32            -2.2        0.08        perf-profile.children.cycles-pp.__submit_merged_bio
      2.20            -2.1        0.06        perf-profile.children.cycles-pp.f2fs_buffered_write_iter
      2.20            -2.1        0.07        perf-profile.children.cycles-pp.generic_perform_write
      2.10            -2.0        0.06        perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      1.94            -1.9        0.07        perf-profile.children.cycles-pp.schedule_idle
      1.97 ±  3%      -1.7        0.31 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.69 ±  4%      -1.4        0.26 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.44 ±  2%      -1.4        0.05        perf-profile.children.cycles-pp.brd_submit_bio
      1.42 ±  2%      -1.4        0.05        perf-profile.children.cycles-pp.brd_do_bvec
      1.40            -1.2        0.22        perf-profile.children.cycles-pp.sched_ttwu_pending
      1.45            -1.2        0.28        perf-profile.children.cycles-pp.ttwu_do_activate
      1.40            -1.2        0.24        perf-profile.children.cycles-pp.dequeue_task_fair
      2.08 ±  6%      -1.1        0.94 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.30            -1.1        0.16 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      1.38            -1.1        0.30        perf-profile.children.cycles-pp.enqueue_task_fair
      1.22 ±  2%      -1.0        0.25        perf-profile.children.cycles-pp.update_load_avg
      1.08            -0.9        0.19 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      1.04 ±  2%      -0.9        0.18 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.97 ±  3%      -0.8        0.17 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.72            -0.6        0.10 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.16 ± 11%      -0.6        0.57 ±  2%  perf-profile.children.cycles-pp.find_busiest_group
      1.16 ± 11%      -0.6        0.57 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.43 ± 10%      -0.5        0.88 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.55            -0.5        0.05        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.32 ± 11%      -0.5        0.82 ±  3%  perf-profile.children.cycles-pp.load_balance
      0.49            -0.4        0.05 ±  8%  perf-profile.children.cycles-pp.llist_add_batch
      0.56            -0.4        0.13 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.47            -0.4        0.06 ±  8%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.46 ±  3%      -0.4        0.06        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.45 ±  4%      -0.4        0.06        perf-profile.children.cycles-pp.__list_add_valid
      0.47 ±  4%      -0.4        0.09        perf-profile.children.cycles-pp.update_rq_clock
      0.53            -0.4        0.16 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.41 ±  2%      -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.36            -0.3        0.05 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.38 ±  6%      -0.3        0.08 ± 10%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.35            -0.3        0.05        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.38 ±  2%      -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.34 ±  7%      -0.3        0.07 ±  7%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.36            -0.3        0.10        perf-profile.children.cycles-pp.tick_sched_timer
      0.32            -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.32 ±  4%      -0.2        0.07        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.27 ±  3%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.32            -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.31            -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.28 ±  3%      -0.2        0.07        perf-profile.children.cycles-pp.available_idle_cpu
      0.52            -0.2        0.32        perf-profile.children.cycles-pp.select_task_rq_fair
      0.28            -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.__close
      0.27 ±  3%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.dput
      0.27 ±  3%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.__fput
      0.27 ±  3%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.26            -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.__dentry_kill
      0.26            -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.evict
      0.26            -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.f2fs_evict_inode
      0.26 ±  5%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp._find_next_bit
      0.18 ± 16%      -0.1        0.07        perf-profile.children.cycles-pp.idle_cpu
      0.18            -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.10 ±  5%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.update_blocked_averages
      0.16 ±  9%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.cpumask_next_and
      0.10            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.09            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.05            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.f2fs_remove_inode_page
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.truncate_node
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.cpumask_next_wrap
      0.12 ±  4%      +0.1        0.24        perf-profile.children.cycles-pp.select_idle_sibling
      0.08 ±  6%      +0.1        0.21        perf-profile.children.cycles-pp.select_idle_cpu
      0.08 ±  6%      +0.1        0.22        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.08 ±  5%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.10 ±  4%      +0.2        0.27        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.09            +0.5        0.57        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ±  9%      +0.7        0.78        perf-profile.children.cycles-pp.__wake_up_common
      0.02 ±100%      +0.7        0.76        perf-profile.children.cycles-pp.autoremove_wake_function
     41.09            +1.6       42.71        perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      0.08 ± 12%      +6.7        6.78        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00           +10.2       10.18        perf-profile.children.cycles-pp.finish_wait
      3.30 ±  7%     +15.7       19.01        perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      2.48 ±  2%     +17.4       19.88        perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      3.07 ±  5%     +17.6       20.72        perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
     79.91           +19.5       99.41        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     79.82           +19.5       99.33        perf-profile.children.cycles-pp.write
     79.88           +19.5       99.41        perf-profile.children.cycles-pp.do_syscall_64
     79.24           +20.0       99.28        perf-profile.children.cycles-pp.ksys_write
     79.22           +20.1       99.28        perf-profile.children.cycles-pp.vfs_write
     79.10           +20.2       99.27        perf-profile.children.cycles-pp.new_sync_write
     79.06           +20.2       99.26        perf-profile.children.cycles-pp.f2fs_file_write_iter
     76.58           +22.6       99.14        perf-profile.children.cycles-pp.f2fs_do_sync_file
      5.38 ±  6%     +24.4       29.76        perf-profile.children.cycles-pp.f2fs_get_node_info
      0.00           +79.3       79.29        perf-profile.children.cycles-pp.prepare_to_wait_event
     14.18 ±  8%     +80.5       94.72        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.16 ±  4%     +91.7       94.86        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     23.71 ±  2%     -23.4        0.32 ±  5%  perf-profile.self.cycles-pp.osq_lock
     10.34           -10.1        0.23 ±  2%  perf-profile.self.cycles-pp.intel_idle
      5.68            -5.4        0.27        perf-profile.self.cycles-pp.find_get_pages_range_tag
      2.44 ±  2%      -2.4        0.06 ±  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.44            -2.4        0.09 ±  9%  perf-profile.self.cycles-pp.release_pages
      2.19            -2.0        0.15 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.16            -0.9        0.26        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.82            -0.7        0.08 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.56 ±  3%      -0.4        0.11        perf-profile.self.cycles-pp.update_load_avg
      0.86 ±  9%      -0.4        0.42 ±  2%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.49            -0.4        0.05        perf-profile.self.cycles-pp.llist_add_batch
      0.46 ±  2%      -0.4        0.06        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.44 ±  4%      -0.4        0.06        perf-profile.self.cycles-pp.__list_add_valid
      0.32            -0.3        0.06        perf-profile.self.cycles-pp.update_rq_clock
      0.31            -0.2        0.06        perf-profile.self.cycles-pp.__update_load_avg_se
      0.28 ±  3%      -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.26            -0.2        0.05 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.27 ±  3%      -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
      0.22 ±  6%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      0.17 ± 17%      -0.1        0.07        perf-profile.self.cycles-pp.idle_cpu
      0.10            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.load_balance
      0.02 ±100%      +0.1        0.08        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.05            +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.select_idle_cpu
      0.00            +0.2        0.21        perf-profile.self.cycles-pp.prepare_to_wait_event
     14.16 ±  8%     +80.6       94.72        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/f2fs/x86_64-rhel-8.3/200/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp2/sync_disk_rw/aim7/0xd000280

commit: 
  dd81e1c7d5 ("Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux")
  e4544b63a7 ("f2fs: move f2fs to use reader-unfair rwsems")

dd81e1c7d5fb126e e4544b63a7ee49e7fbebf35ece0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     13633           -77.3%       3096 ±  5%  aim7.jobs-per-min
     88.04          +341.7%     388.89 ±  5%  aim7.time.elapsed_time
     88.04          +341.7%     388.89 ±  5%  aim7.time.elapsed_time.max
 1.671e+08            +2.5%  1.713e+08        aim7.time.file_system_outputs
      3146        +1.4e+05%    4477159 ± 10%  aim7.time.involuntary_context_switches
     17550          +452.1%      96887 ±  8%  aim7.time.minor_page_faults
      1064         +3932.5%      42928 ±  6%  aim7.time.system_time
  52811785          +169.1%  1.421e+08 ±  4%  aim7.time.voluntary_context_switches
 1.035e+10           -43.4%   5.86e+09 ±  3%  cpuidle..time
     53.54 ±  3%      +9.3%      58.52        boot-time.boot
      6323 ±  3%     +10.1%       6961        boot-time.idle
     90.21           -86.9%      11.80 ±  2%  iostat.cpu.idle
      9.62 ±  2%    +815.6%      88.06        iostat.cpu.system
    145.59          +210.8%     452.54 ±  5%  uptime.boot
     16844           -22.5%      13050        uptime.idle
   6803710           -16.8%    5661011        numa-numastat.node0.local_node
   6886643           -17.3%    5694296        numa-numastat.node0.numa_hit
   7081222           -19.0%    5733563        numa-numastat.node1.local_node
   7113452           -18.2%    5816389        numa-numastat.node1.numa_hit
    325.00 ±  4%    +607.9%       2300        turbostat.Avg_MHz
     12.53 ±  4%     +76.2       88.69        turbostat.Busy%
     89.48           -77.8       11.70 ±  2%  turbostat.C1%
  76767041          +151.7%  1.932e+08 ± 12%  turbostat.IRQ
     68.33            +2.9%      70.33        turbostat.PkgTmp
     90.03           -78.7       11.35 ±  2%  mpstat.cpu.all.idle%
      0.08 ±  4%      -0.0        0.05        mpstat.cpu.all.iowait%
      1.08            -0.2        0.91        mpstat.cpu.all.irq%
      0.05 ±  5%      +0.0        0.06 ±  2%  mpstat.cpu.all.soft%
      8.67 ±  2%     +78.9       87.53        mpstat.cpu.all.sys%
      0.08 ±  3%      +0.0        0.10 ±  6%  mpstat.cpu.all.usr%
     90.00           -87.4%      11.33 ±  4%  vmstat.cpu.id
      9.00          +870.4%      87.33        vmstat.cpu.sy
    911223           -76.1%     217956 ±  5%  vmstat.io.bo
   2953485           +12.5%    3321359        vmstat.memory.cache
     11.67 ±  4%    +962.9%     124.00        vmstat.procs.r
   1178152           -51.2%     574772        vmstat.system.cs
    841212           -41.7%     490576 ±  7%  vmstat.system.in
     48446          +485.0%     283422        meminfo.Active
     32563 ±  2%    +740.0%     273524        meminfo.Active(anon)
     15882           -37.7%       9897 ±  2%  meminfo.Active(file)
    109226           +70.6%     186381        meminfo.AnonHugePages
   2770717           +13.9%    3157035        meminfo.Cached
    574199           +66.6%     956851        meminfo.Committed_AS
     67205 ±  7%     -39.5%      40685        meminfo.Dirty
    441022           +32.9%     586094        meminfo.Inactive
    288732           +54.8%     447100        meminfo.Inactive(anon)
     37886          +372.8%     179143 ±  3%  meminfo.Mapped
  29076961           -29.6%   20478103        meminfo.Memused
     51044          +795.5%     457079        meminfo.Shmem
  29078359           -29.0%   20639335        meminfo.max_used_kB
     11003 ±  7%    +104.6%      22512 ±  3%  numa-meminfo.node0.Active
      2114 ± 34%    +683.2%      16556 ±  3%  numa-meminfo.node0.Active(anon)
      8888           -33.0%       5955 ±  2%  numa-meminfo.node0.Active(file)
     98683 ±  7%     +86.7%     184213        numa-meminfo.node0.AnonHugePages
    253596 ±  6%     +19.8%     303757        numa-meminfo.node0.AnonPages.max
     33181 ± 11%     -37.0%      20905        numa-meminfo.node0.Dirty
    336631 ±  3%     +22.9%     413798 ±  2%  numa-meminfo.node0.Inactive
    259159 ±  4%     +32.0%     342173 ±  3%  numa-meminfo.node0.Inactive(anon)
     25630 ± 51%    +312.3%     105682 ±  6%  numa-meminfo.node0.Mapped
  15090064 ±  7%     -23.2%   11588163        numa-meminfo.node0.MemUsed
     14572 ± 22%    +648.6%     109087 ±  9%  numa-meminfo.node0.Shmem
     37487          +596.2%     261004        numa-meminfo.node1.Active
     30450          +744.2%     257060        numa-meminfo.node1.Active(anon)
      7037           -44.0%       3943 ±  4%  numa-meminfo.node1.Active(file)
     33343 ±  7%     -40.5%      19836        numa-meminfo.node1.Dirty
    104755 ±  9%     +65.2%     173024 ±  7%  numa-meminfo.node1.Inactive
     29644 ± 36%    +256.2%     105604 ± 12%  numa-meminfo.node1.Inactive(anon)
     75111           -10.2%      67420        numa-meminfo.node1.Inactive(file)
     72282 ± 26%     -32.8%      48578 ±  5%  numa-meminfo.node1.KReclaimable
     12295 ±107%    +494.6%      73103 ±  7%  numa-meminfo.node1.Mapped
  14009653 ±  7%     -36.5%    8902458        numa-meminfo.node1.MemUsed
     72282 ± 26%     -32.8%      48578 ±  5%  numa-meminfo.node1.SReclaimable
     36473 ±  9%    +856.3%     348796 ±  2%  numa-meminfo.node1.Shmem
    159721 ±  9%     -11.3%     141602 ±  4%  numa-meminfo.node1.Slab
    528.33 ± 34%    +721.9%       4342 ±  3%  numa-vmstat.node0.nr_active_anon
      2226           -33.1%       1488 ±  2%  numa-vmstat.node0.nr_active_file
      8578 ± 10%     -38.9%       5240        numa-vmstat.node0.nr_dirty
     64795 ±  4%     +31.5%      85199 ±  3%  numa-vmstat.node0.nr_inactive_anon
      6619 ± 50%    +298.3%      26367 ±  6%  numa-vmstat.node0.nr_mapped
      3643 ± 22%    +645.6%      27161 ±  8%  numa-vmstat.node0.nr_shmem
    528.33 ± 34%    +722.0%       4343 ±  3%  numa-vmstat.node0.nr_zone_active_anon
      2226           -33.1%       1488 ±  2%  numa-vmstat.node0.nr_zone_active_file
     64795 ±  4%     +31.5%      85199 ±  3%  numa-vmstat.node0.nr_zone_inactive_anon
      7124           -24.6%       5370        numa-vmstat.node0.nr_zone_write_pending
   5299307 ±  4%      -7.7%    4889023        numa-vmstat.node0.numa_hit
      7612          +748.8%      64610        numa-vmstat.node1.nr_active_anon
      1761           -44.1%     985.00 ±  4%  numa-vmstat.node1.nr_active_file
   4475967           +12.0%    5014630        numa-vmstat.node1.nr_dirtied
      8347 ± 10%     -40.4%       4972        numa-vmstat.node1.nr_dirty
      7422 ± 36%    +251.3%      26075 ± 12%  numa-vmstat.node1.nr_inactive_anon
      3116 ±108%    +475.1%      17921 ±  7%  numa-vmstat.node1.nr_mapped
      9118 ±  9%    +856.4%      87207 ±  2%  numa-vmstat.node1.nr_shmem
     18074 ± 26%     -32.8%      12139 ±  5%  numa-vmstat.node1.nr_slab_reclaimable
   4454020           +12.1%    4992908        numa-vmstat.node1.nr_written
      7612          +748.8%      64610        numa-vmstat.node1.nr_zone_active_anon
      1761           -44.1%     985.00 ±  4%  numa-vmstat.node1.nr_zone_active_file
      7422 ± 36%    +251.3%      26075 ± 12%  numa-vmstat.node1.nr_zone_inactive_anon
      6982           -27.8%       5044        numa-vmstat.node1.nr_zone_write_pending
   4439843 ±  5%     -18.9%    3598683        numa-vmstat.node1.numa_hit
   4365472 ±  4%     -20.5%    3471629        numa-vmstat.node1.numa_local
      8140 ±  2%    +741.0%      68464        proc-vmstat.nr_active_anon
      3981           -37.8%       2474 ±  2%  proc-vmstat.nr_active_file
     67617            -2.5%      65931        proc-vmstat.nr_anon_pages
  20880986            +2.5%   21407324        proc-vmstat.nr_dirtied
     16797 ±  9%     -39.2%      10208        proc-vmstat.nr_dirty
   5833529            +3.7%    6048136        proc-vmstat.nr_dirty_background_threshold
  11681323            +3.7%   12111061        proc-vmstat.nr_dirty_threshold
    692727           +14.0%     789639        proc-vmstat.nr_file_pages
  58663572            +3.7%   60817628        proc-vmstat.nr_free_pages
     72192           +55.2%     112058        proc-vmstat.nr_inactive_anon
     38094            -8.8%      34752        proc-vmstat.nr_inactive_file
     25366            -4.3%      24285        proc-vmstat.nr_kernel_stack
      9721          +364.1%      45122 ±  3%  proc-vmstat.nr_mapped
     12761          +798.4%     114643        proc-vmstat.nr_shmem
     45666            -8.9%      41614        proc-vmstat.nr_slab_reclaimable
  20795895            +2.6%   21329600        proc-vmstat.nr_written
      8140 ±  2%    +741.0%      68464        proc-vmstat.nr_zone_active_anon
      3981           -37.8%       2474 ±  2%  proc-vmstat.nr_zone_active_file
     72192           +55.2%     112058        proc-vmstat.nr_zone_inactive_anon
     38094            -8.8%      34752        proc-vmstat.nr_zone_inactive_file
     14042           -26.0%      10385        proc-vmstat.nr_zone_write_pending
      4754         +5195.2%     251753 ±  4%  proc-vmstat.numa_hint_faults
      2781 ±  2%   +4781.3%     135764 ±  5%  proc-vmstat.numa_hint_faults_local
  14006143           -17.8%   11514659        proc-vmstat.numa_hit
  13887953           -17.9%   11398547        proc-vmstat.numa_local
      1903         +1392.1%      28399 ±  5%  proc-vmstat.numa_pages_migrated
      7967 ± 26%   +5369.8%     435781 ±  5%  proc-vmstat.numa_pte_updates
     29920         +1763.7%     557616        proc-vmstat.pgactivate
  14014518           -17.8%   11526104        proc-vmstat.pgalloc_normal
     19529            -4.2%      18708 ±  2%  proc-vmstat.pgdeactivate
    396700          +327.1%    1694421 ±  4%  proc-vmstat.pgfault
   3094702           +44.0%    4457852        proc-vmstat.pgfree
      1903         +1392.1%      28399 ±  5%  proc-vmstat.pgmigrate_success
  83222972            +2.5%   85326458        proc-vmstat.pgpgout
     23323          +257.1%      83281 ±  4%  proc-vmstat.pgreuse
     39049            -4.3%      37385 ±  2%  proc-vmstat.pgrotated
     15.90 ±  3%     -25.1%      11.91        perf-stat.i.MPKI
 3.519e+09 ±  4%    +100.2%  7.044e+09        perf-stat.i.branch-instructions
      0.94 ±  5%      -0.4        0.55        perf-stat.i.branch-miss-rate%
  32297349           +15.6%   37320651        perf-stat.i.branch-misses
     29.54           -15.5       14.03        perf-stat.i.cache-miss-rate%
  91913432           -42.0%   53308607        perf-stat.i.cache-misses
 2.897e+08           +30.4%  3.777e+08        perf-stat.i.cache-references
   1210985           -52.2%     578441        perf-stat.i.context-switches
      2.81 ±  6%    +230.8%       9.30        perf-stat.i.cpi
 4.486e+10 ±  8%    +556.0%  2.943e+11        perf-stat.i.cpu-cycles
     35459          +300.2%     141913        perf-stat.i.cpu-migrations
      2706 ± 53%    +112.9%       5761        perf-stat.i.cycles-between-cache-misses
      0.06 ±  4%      -0.0        0.04 ±  8%  perf-stat.i.dTLB-load-miss-rate%
  4.35e+09           +93.6%  8.421e+09        perf-stat.i.dTLB-loads
      0.02 ± 10%      -0.0        0.01 ±  5%  perf-stat.i.dTLB-store-miss-rate%
    295192 ± 11%     -49.2%     149935 ±  6%  perf-stat.i.dTLB-store-misses
 1.922e+09           -24.2%  1.458e+09        perf-stat.i.dTLB-stores
 1.677e+10 ±  3%     +86.1%   3.12e+10        perf-stat.i.instructions
      0.37 ±  6%     -69.7%       0.11        perf-stat.i.ipc
      2.04 ±  3%     -61.4%       0.79 ±  5%  perf-stat.i.major-faults
      0.35 ±  8%    +556.0%       2.30        perf-stat.i.metric.GHz
    459.69           -38.6%     282.19        perf-stat.i.metric.K/sec
     78.73 ±  2%     +71.7%     135.15        perf-stat.i.metric.M/sec
      3414           +18.7%       4052        perf-stat.i.minor-faults
     94.15            +1.7       95.85        perf-stat.i.node-load-miss-rate%
  28815204           -32.8%   19364821        perf-stat.i.node-load-misses
   1436041           -46.8%     763611        perf-stat.i.node-loads
     49.83            -8.1       41.77        perf-stat.i.node-store-miss-rate%
  13112467           -53.3%    6124219 ±  2%  perf-stat.i.node-store-misses
  11700482           -28.1%    8413600        perf-stat.i.node-stores
      3416           +18.7%       4053        perf-stat.i.page-faults
     17.29 ±  3%     -30.0%      12.10        perf-stat.overall.MPKI
      0.92 ±  3%      -0.4        0.53        perf-stat.overall.branch-miss-rate%
     31.73           -17.6       14.11        perf-stat.overall.cache-miss-rate%
      2.67 ±  5%    +253.1%       9.43        perf-stat.overall.cpi
    488.19 ±  8%   +1031.8%       5525 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.07 ±  4%      -0.0        0.04 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ± 11%      -0.0        0.01 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      0.38 ±  5%     -71.8%       0.11        perf-stat.overall.ipc
     95.25            +0.9       96.20        perf-stat.overall.node-load-miss-rate%
     52.85           -10.7       42.10        perf-stat.overall.node-store-miss-rate%
  3.48e+09 ±  4%    +102.0%  7.031e+09        perf-stat.ps.branch-instructions
  31936467           +16.6%   37233323        perf-stat.ps.branch-misses
  90890160           -41.5%   53183020        perf-stat.ps.cache-misses
 2.864e+08           +31.6%  3.769e+08        perf-stat.ps.cache-references
   1197506           -51.8%     577002        perf-stat.ps.context-switches
 4.436e+10 ±  8%    +562.1%  2.937e+11        perf-stat.ps.cpu-cycles
     35064          +303.7%     141572        perf-stat.ps.cpu-migrations
 4.301e+09           +95.4%  8.404e+09        perf-stat.ps.dTLB-loads
    291900 ± 11%     -48.8%     149597 ±  6%  perf-stat.ps.dTLB-store-misses
   1.9e+09           -23.4%  1.455e+09        perf-stat.ps.dTLB-stores
 1.658e+10 ±  3%     +87.8%  3.114e+10        perf-stat.ps.instructions
      2.02 ±  3%     -61.3%       0.78 ±  5%  perf-stat.ps.major-faults
      3374           +20.1%       4054        perf-stat.ps.minor-faults
  28494441           -32.2%   19318149        perf-stat.ps.node-load-misses
   1420047           -46.3%     762579        perf-stat.ps.node-loads
  12966465           -52.9%    6105973 ±  2%  perf-stat.ps.node-store-misses
  11570198           -27.4%    8396598        perf-stat.ps.node-stores
      3376           +20.1%       4055        perf-stat.ps.page-faults
 1.482e+12 ±  3%    +721.1%  1.217e+13 ±  5%  perf-stat.total.instructions
     26.76 ± 15%     -25.9        0.87        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     26.57 ± 15%     -25.7        0.86        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     26.55 ± 15%     -25.7        0.86        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.49 ± 15%     -25.6        0.86        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     22.39 ± 20%     -21.8        0.61 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     22.34 ± 20%     -21.7        0.61 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     16.55 ± 12%     -16.0        0.57 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     14.98 ±  5%     -14.8        0.17 ±141%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
     14.15 ±  6%     -14.1        0.00        perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
     10.26 ±  6%     -10.3        0.00        perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
     10.22 ±  9%     -10.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     11.79 ±  7%     -10.2        1.62 ± 38%  perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     11.79 ±  7%     -10.2        1.62 ± 38%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      9.70 ±  6%      -9.7        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
     24.05 ±  5%      -8.7       15.37 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     23.97 ±  5%      -8.6       15.36 ±  3%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      8.60 ±  6%      -8.6        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
     23.95 ±  5%      -8.6       15.36 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
     23.93 ±  5%      -8.6       15.36 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file
     23.68 ±  5%      -8.3       15.35 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      8.23 ± 21%      -8.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      8.14 ±  9%      -8.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      6.81 ±  7%      -6.8        0.00        perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      5.97 ± 14%      -6.0        0.00        perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.do_idle
      5.75 ±  5%      -5.8        0.00        perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      5.45 ±  7%      -5.5        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      5.30 ±  6%      -5.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      4.95 ±  6%      -4.1        0.86 ± 29%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
     17.93 ±  5%      -3.6       14.36 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
     17.67 ±  5%      -3.3       14.35 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +0.5        0.54 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.1        1.09 ± 45%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page
      0.00            +1.1        1.10 ± 45%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page.__write_node_page
      0.00            +1.2        1.15 ± 45%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      0.00            +1.9        1.93 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +1.9        1.93 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page
      0.00            +1.9        1.93 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.1        2.06 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +2.1        2.06 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +2.1        2.06 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +2.4        2.36 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +2.4        2.36 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.4        2.37 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.6        2.60 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +2.6        2.60 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.6        2.61 ±  3%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.8        2.76 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.8        2.76 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +2.8        2.76 ±  4%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.59 ±  6%      +4.8        7.42 ± 45%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +6.3        6.29 ± 46%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +6.3        6.30 ± 46%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +6.4        6.35 ± 46%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +6.6        6.60 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +6.6        6.60 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages
      0.00            +7.2        7.19 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +11.4       11.42 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page
      0.00           +11.4       11.43 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00           +11.5       11.51 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00           +11.5       11.54 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page
      0.00           +11.6       11.55 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00           +11.6       11.64 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      2.16 ±  5%     +11.8       13.95 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      1.59 ±  5%     +12.3       13.89 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
     34.95 ±  5%     +12.3       47.29 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00           +13.5       13.49 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00           +13.5       13.50 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +13.6       13.60 ±  4%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +14.1       14.12 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00           +14.1       14.14 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +14.2       14.24 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.15 ±  5%     +14.2       16.40 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00           +15.2       15.15 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00           +15.2       15.16 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +15.3       15.28 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.09 ±  6%     +15.3       17.42 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      2.26 ±  5%     +16.1       18.31 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     71.79 ±  5%     +27.1       98.92        perf-profile.calltrace.cycles-pp.write
     71.39 ±  5%     +27.5       98.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     71.36 ±  5%     +27.5       98.87        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     71.24 ±  5%     +27.6       98.86        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     71.21 ±  5%     +27.6       98.86        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     71.08 ±  5%     +27.8       98.85        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     71.03 ±  5%     +27.8       98.85        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     68.74 ±  5%     +30.0       98.73        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     26.76 ± 15%     -25.9        0.87        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     26.76 ± 15%     -25.9        0.87        perf-profile.children.cycles-pp.cpu_startup_entry
     26.73 ± 15%     -25.9        0.87        perf-profile.children.cycles-pp.do_idle
     26.57 ± 15%     -25.7        0.86        perf-profile.children.cycles-pp.start_secondary
     25.94 ±  6%     -23.9        1.99 ± 34%  perf-profile.children.cycles-pp.do_write_page
     22.84 ±  6%     -22.1        0.69 ± 11%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     22.56 ± 20%     -21.9        0.62 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     22.52 ± 20%     -21.9        0.62 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     22.43 ±  6%     -21.9        0.57 ± 17%  perf-profile.children.cycles-pp.osq_lock
     16.68 ± 12%     -16.1        0.58        perf-profile.children.cycles-pp.acpi_idle_enter
     16.54 ± 12%     -16.0        0.57 ±  2%  perf-profile.children.cycles-pp.acpi_idle_do_entry
     14.99 ±  5%     -14.6        0.40 ± 16%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
     14.86 ±  6%     -14.5        0.36 ± 23%  perf-profile.children.cycles-pp.f2fs_submit_page_write
     11.79 ±  7%     -10.2        1.62 ± 38%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
     10.34 ±  6%     -10.0        0.34 ± 10%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      8.95 ±  5%      -9.0        0.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     24.05 ±  5%      -8.7       15.37 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
     23.97 ±  5%      -8.6       15.36 ±  3%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     23.95 ±  5%      -8.6       15.36 ±  3%  perf-profile.children.cycles-pp.do_writepages
     23.94 ±  5%      -8.6       15.36 ±  3%  perf-profile.children.cycles-pp.f2fs_write_data_pages
     23.68 ±  5%      -8.3       15.35 ±  3%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      7.71 ±  7%      -7.5        0.23 ± 12%  perf-profile.children.cycles-pp.__mutex_lock
      6.35 ±  5%      -6.3        0.06 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      6.63 ±  8%      -6.2        0.46        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      5.77 ±  5%      -5.4        0.37 ±  3%  perf-profile.children.cycles-pp.set_node_addr
      5.67 ± 12%      -5.2        0.44 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.37 ±  5%      -4.2        0.21 ±  2%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      4.36 ±  5%      -4.2        0.21 ±  2%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      4.30 ±  9%      -4.1        0.19        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      3.67 ±  5%      -3.6        0.07 ±  7%  perf-profile.children.cycles-pp.rwsem_wake
     17.93 ±  5%      -3.6       14.36 ±  4%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      5.82 ±  5%      -3.4        2.45 ±  3%  perf-profile.children.cycles-pp.__schedule
     17.67 ±  5%      -3.3       14.35 ±  4%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      3.47 ±  5%      -3.3        0.16 ± 40%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      3.44 ±  5%      -3.3        0.16 ± 40%  perf-profile.children.cycles-pp.__percpu_counter_sum
      3.07 ±  6%      -3.0        0.05        perf-profile.children.cycles-pp.wake_up_q
      2.82 ±  5%      -2.7        0.10 ±  8%  perf-profile.children.cycles-pp.__submit_bio
      2.81 ±  5%      -2.7        0.10 ±  8%  perf-profile.children.cycles-pp.submit_bio_noacct
      2.68 ±  5%      -2.6        0.09 ±  9%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      2.77 ±  6%      -2.5        0.27        perf-profile.children.cycles-pp.sysvec_call_function_single
      3.18 ±  6%      -2.5        0.69        perf-profile.children.cycles-pp.try_to_wake_up
      2.44 ±  5%      -2.4        0.09 ±  9%  perf-profile.children.cycles-pp.__submit_merged_bio
      2.30 ±  7%      -2.1        0.24        perf-profile.children.cycles-pp.__sysvec_call_function_single
      2.30            -2.0        0.34 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.94 ±  5%      -1.9        0.07 ±  6%  perf-profile.children.cycles-pp.f2fs_buffered_write_iter
      4.17 ±  5%      -1.8        2.32 ±  3%  perf-profile.children.cycles-pp.schedule
      1.91 ±  5%      -1.8        0.09 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
      1.98 ±  6%      -1.7        0.26 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      1.75 ±  5%      -1.6        0.14        perf-profile.children.cycles-pp.schedule_idle
      1.67 ±  6%      -1.5        0.19        perf-profile.children.cycles-pp.sched_ttwu_pending
      1.49 ±  4%      -1.4        0.06 ±  7%  perf-profile.children.cycles-pp.__pagevec_release
      1.47 ±  4%      -1.4        0.06 ±  7%  perf-profile.children.cycles-pp.release_pages
      1.45 ±  5%      -1.4        0.06 ±  8%  perf-profile.children.cycles-pp.folio_mark_dirty
      1.41 ±  6%      -1.4        0.05 ±  8%  perf-profile.children.cycles-pp.brd_submit_bio
      1.39 ±  6%      -1.3        0.05 ±  8%  perf-profile.children.cycles-pp.brd_do_bvec
      1.36 ± 13%      -1.3        0.05        perf-profile.children.cycles-pp.menu_select
      1.48 ±  5%      -1.3        0.23        perf-profile.children.cycles-pp.ttwu_do_activate
      1.46            -1.2        0.25 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.45 ±  5%      -1.2        0.26        perf-profile.children.cycles-pp.enqueue_task_fair
      1.18 ±  4%      -1.1        0.05        perf-profile.children.cycles-pp.xas_find_marked
      1.36            -1.1        0.24 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.34 ±  7%      -1.1        0.27        perf-profile.children.cycles-pp.dequeue_task_fair
      1.24 ±  6%      -1.0        0.20 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      1.22 ±  6%      -1.0        0.19        perf-profile.children.cycles-pp.enqueue_entity
      1.05 ±  5%      -0.8        0.27        perf-profile.children.cycles-pp.update_load_avg
      0.82 ±  4%      -0.6        0.19        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.75 ±  6%      -0.6        0.13 ±  6%  perf-profile.children.cycles-pp.f2fs_issue_flush
      0.70 ±  6%      -0.6        0.10        perf-profile.children.cycles-pp.update_rq_clock
      0.53 ±  6%      -0.5        0.05        perf-profile.children.cycles-pp.native_irq_return_iret
      0.61 ±  6%      -0.5        0.14        perf-profile.children.cycles-pp.update_curr
      0.54 ±  6%      -0.5        0.08 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.52 ±  7%      -0.5        0.07        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.31 ±  5%      -0.4        1.89 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.50 ±  2%      -0.4        0.09 ±  9%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.45 ±  4%      -0.4        0.05        perf-profile.children.cycles-pp.__list_add_valid
      0.45 ±  6%      -0.4        0.06        perf-profile.children.cycles-pp.ret_from_fork
      0.45 ±  6%      -0.4        0.06        perf-profile.children.cycles-pp.kthread
      0.50 ±  7%      -0.4        0.13 ± 40%  perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.43 ±  3%      -0.4        0.06        perf-profile.children.cycles-pp.sched_clock_cpu
      0.42 ±  6%      -0.4        0.05        perf-profile.children.cycles-pp.issue_flush_thread
      0.50 ±  6%      -0.4        0.14 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.39            -0.3        0.07 ±  6%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.45 ±  7%      -0.3        0.14        perf-profile.children.cycles-pp.tick_sched_handle
      0.42 ±  3%      -0.3        0.11 ±  7%  perf-profile.children.cycles-pp.wait_for_completion
      0.40 ±  6%      -0.3        0.09        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.44 ±  7%      -0.3        0.14 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.34 ± 11%      -0.3        0.06        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.39 ±  3%      -0.3        0.11 ±  7%  perf-profile.children.cycles-pp.schedule_timeout
      0.32 ±  8%      -0.3        0.06        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.39 ±  5%      -0.2        0.18 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.28 ±  4%      -0.2        0.08        perf-profile.children.cycles-pp.finish_task_switch
      0.48 ±  7%      -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.25 ± 10%      -0.2        0.06        perf-profile.children.cycles-pp.__update_load_avg_se
      0.23 ± 11%      -0.2        0.05        perf-profile.children.cycles-pp.__close
      0.22 ± 12%      -0.2        0.05        perf-profile.children.cycles-pp.task_work_run
      0.26 ±  4%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.22 ± 11%      -0.2        0.05        perf-profile.children.cycles-pp.dput
      0.22 ± 11%      -0.2        0.05        perf-profile.children.cycles-pp.__fput
      0.22 ± 11%      -0.2        0.05        perf-profile.children.cycles-pp.__dentry_kill
      0.22 ± 11%      -0.2        0.05        perf-profile.children.cycles-pp.evict
      0.21 ±  9%      -0.2        0.05        perf-profile.children.cycles-pp.f2fs_evict_inode
      0.21 ±  8%      -0.2        0.05        perf-profile.children.cycles-pp.update_cfs_group
      1.49 ±  5%      -0.1        1.34 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      1.47 ±  5%      -0.1        1.33 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.25 ±  8%      -0.1        0.11        perf-profile.children.cycles-pp.scheduler_tick
      0.11 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.update_blocked_averages
      0.22 ±  7%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.cpumask_next_wrap
      0.06 ± 13%      +0.1        0.13 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.02 ±141%      +0.1        0.11        perf-profile.children.cycles-pp.down_read_trylock
      0.07 ±  7%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      1.67 ±  5%      +0.2        1.82 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.2        0.19 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      0.13 ±  6%      +0.4        0.50 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.05 ±  8%      +0.6        0.66        perf-profile.children.cycles-pp.__wake_up_common
      0.03 ± 70%      +0.6        0.64        perf-profile.children.cycles-pp.autoremove_wake_function
      0.08 ±  5%      +8.6        8.72 ±  4%  perf-profile.children.cycles-pp.__wake_up_common_lock
     34.96 ±  5%     +12.3       47.29 ±  4%  perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      0.00           +12.4       12.42        perf-profile.children.cycles-pp.finish_wait
      2.16 ±  5%     +14.2       16.40 ±  4%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      2.09 ±  6%     +15.3       17.42 ±  5%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      2.26 ±  5%     +16.0       18.31 ±  5%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      3.76 ±  5%     +24.1       27.90 ±  5%  perf-profile.children.cycles-pp.f2fs_get_node_info
     71.83 ±  5%     +27.1       98.92        perf-profile.children.cycles-pp.write
     71.85 ±  5%     +27.1       98.97        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     71.82 ±  5%     +27.2       98.97        perf-profile.children.cycles-pp.do_syscall_64
     71.24 ±  5%     +27.6       98.87        perf-profile.children.cycles-pp.ksys_write
     71.22 ±  5%     +27.7       98.87        perf-profile.children.cycles-pp.vfs_write
     71.08 ±  5%     +27.8       98.86        perf-profile.children.cycles-pp.new_sync_write
     71.04 ±  5%     +27.8       98.85        perf-profile.children.cycles-pp.f2fs_file_write_iter
     68.74 ±  5%     +30.0       98.73        perf-profile.children.cycles-pp.f2fs_do_sync_file
      0.00           +73.3       73.31        perf-profile.children.cycles-pp.prepare_to_wait_event
      9.27 ±  4%     +84.1       93.35        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.61 ±  3%     +88.8       93.46        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     22.33 ±  6%     -21.8        0.57 ± 17%  perf-profile.self.cycles-pp.osq_lock
     10.94 ± 13%     -10.6        0.37 ±  2%  perf-profile.self.cycles-pp.acpi_idle_do_entry
      3.23 ±  5%      -3.1        0.16        perf-profile.self.cycles-pp.find_get_pages_range_tag
      2.58 ±  5%      -2.5        0.09 ±  9%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.81 ±  6%      -1.6        0.17        perf-profile.self.cycles-pp._raw_spin_lock
      1.37 ±  4%      -1.3        0.06        perf-profile.self.cycles-pp.release_pages
      1.13 ±  4%      -1.1        0.03 ± 70%  perf-profile.self.cycles-pp.xas_find_marked
      1.26 ±  4%      -1.0        0.23 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.64 ±  7%      -0.6        0.09        perf-profile.self.cycles-pp.__schedule
      0.53 ±  6%      -0.5        0.05        perf-profile.self.cycles-pp.native_irq_return_iret
      0.53 ±  6%      -0.5        0.07 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.48 ±  7%      -0.4        0.07 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.44 ±  4%      -0.4        0.05        perf-profile.self.cycles-pp.__list_add_valid
      0.43 ±  3%      -0.3        0.12 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.36 ±  7%      -0.3        0.09 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.29 ±  3%      -0.2        0.05        perf-profile.self.cycles-pp.update_curr
      0.34 ±  5%      -0.2        0.15 ±  3%  perf-profile.self.cycles-pp._find_next_bit
      0.23 ± 10%      -0.2        0.05        perf-profile.self.cycles-pp.__update_load_avg_se
      0.25 ±  5%      -0.2        0.08        perf-profile.self.cycles-pp.available_idle_cpu
      0.21 ±  8%      -0.2        0.05        perf-profile.self.cycles-pp.update_cfs_group
      1.09 ±  5%      -0.1        0.98 ±  4%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.21 ±  7%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.idle_cpu
      0.07 ±  7%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.select_idle_cpu
      0.02 ±141%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.1        0.13        perf-profile.self.cycles-pp.prepare_to_wait_event
      9.26 ±  4%     +84.1       93.35        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-cpl-4sp1: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/f2fs/x86_64-rhel-8.3/200/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/sync_disk_rw/aim7/0x7002302

commit: 
  dd81e1c7d5 ("Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux")
  e4544b63a7 ("f2fs: move f2fs to use reader-unfair rwsems")

dd81e1c7d5fb126e e4544b63a7ee49e7fbebf35ece0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      9023           -70.8%       2633 ±  4%  aim7.jobs-per-min
    133.01          +243.4%     456.72 ±  4%  aim7.time.elapsed_time
    133.01          +243.4%     456.72 ±  4%  aim7.time.elapsed_time.max
     10962 ±  5%  +23090.1%    2542101 ±  6%  aim7.time.involuntary_context_switches
      2826            -2.5%       2754        aim7.time.maximum_resident_set_size
     30640 ±  5%    +454.9%     170035 ±  7%  aim7.time.minor_page_faults
      2925 ±  4%   +1767.2%      54628 ±  4%  aim7.time.system_time
      6.57 ±  6%    +124.2%      14.73 ±  8%  aim7.time.user_time
  65839654          +103.2%  1.338e+08 ±  3%  aim7.time.voluntary_context_switches
 1.608e+10           -41.7%  9.368e+09 ±  2%  cpuidle..time
     52.73 ±  5%      +9.0%      57.49        boot-time.boot
      6941 ±  5%      +9.9%       7626        boot-time.idle
     83.98           -82.2%      14.91 ±  2%  iostat.cpu.idle
     15.74 ±  3%    +439.8%      84.94        iostat.cpu.system
    190.73          +172.8%     520.31 ±  4%  uptime.boot
     23476 ±  2%     -25.4%      17502 ±  2%  uptime.idle
     83.78           -69.2       14.55 ±  2%  mpstat.cpu.all.idle%
      0.08 ± 10%      -0.0        0.05 ±  6%  mpstat.cpu.all.iowait%
      0.80 ±  4%      -0.1        0.71        mpstat.cpu.all.irq%
     15.06 ±  3%     +69.4       84.51        mpstat.cpu.all.sys%
      0.19            -0.1        0.09 ±  4%  mpstat.cpu.all.usr%
     83.67           -82.9%      14.33 ±  3%  vmstat.cpu.id
     15.33 ±  3%    +452.2%      84.67        vmstat.cpu.sy
    621825           -70.1%     185967 ±  4%  vmstat.io.bo
     21.00 ± 10%    +503.2%     126.67        vmstat.procs.r
    972937           -49.4%     492366        vmstat.system.cs
   3246118           -11.9%    2858570 ±  2%  numa-numastat.node1.local_node
   3303585           -12.0%    2908254 ±  2%  numa-numastat.node1.numa_hit
   3135174 ±  2%     -12.5%    2743411        numa-numastat.node2.local_node
   3178730           -11.6%    2808652        numa-numastat.node2.numa_hit
   3765442           -17.2%    3117446 ±  2%  numa-numastat.node3.local_node
   3795016           -16.9%    3154743        numa-numastat.node3.numa_hit
     17177           -47.9%       8948 ±  2%  meminfo.Active(file)
    142005           +32.7%     188500        meminfo.AnonHugePages
   1224077           -24.4%     925740        meminfo.Committed_AS
     68682 ±  9%     -40.3%      40998        meminfo.Dirty
    895183           -34.5%     586098        meminfo.Inactive
    748295           -40.4%     446216 ±  2%  meminfo.Inactive(anon)
    396841 ±  9%     -54.3%     181234 ±  5%  meminfo.Mapped
  27415214           -27.7%   19813647        meminfo.Memused
    675386 ±  2%     -39.1%     411177 ±  2%  meminfo.Shmem
    994.00 ± 14%     -50.7%     490.00 ± 10%  meminfo.Writeback
  27417659           -27.2%   19970691        meminfo.max_used_kB
    581.67 ±  3%    +386.6%       2830        turbostat.Avg_MHz
     18.02 ±  3%     +68.0       86.04        turbostat.Busy%
      3233            +2.0%       3296        turbostat.Bzy_MHz
   6275606 ±  2%     +66.5%   10446899 ±  8%  turbostat.C1
      2.27 ±  7%      -1.2        1.03 ±  4%  turbostat.C1%
  89353368           -17.6%   73670735 ±  9%  turbostat.C1E
     74.69 ±  4%     -63.9       10.78 ±  2%  turbostat.C1E%
     80.62           -83.5%      13.28        turbostat.CPU%c1
  41908830          +275.6%  1.574e+08 ± 16%  turbostat.IRQ
     49.67 ±  2%     +12.1%      55.67 ±  3%  turbostat.PkgTmp
    378.68           +26.9%     480.36        turbostat.PkgWatt
     39.52 ±  2%      -4.7%      37.68        turbostat.RAMWatt
     52818 ±  3%      +8.6%      57373 ±  3%  proc-vmstat.nr_active_anon
      4297           -47.9%       2236 ±  2%  proc-vmstat.nr_active_file
     70914            -6.7%      66149        proc-vmstat.nr_anon_pages
     18087 ±  9%     -43.3%      10263        proc-vmstat.nr_dirty
   2592031            +7.3%    2782297        proc-vmstat.nr_dirty_background_threshold
   5190400            +7.3%    5571398        proc-vmstat.nr_dirty_threshold
    849437            -8.3%     778715        proc-vmstat.nr_file_pages
  26050640            +7.3%   27959782        proc-vmstat.nr_free_pages
    188213           -40.6%     111868 ±  2%  proc-vmstat.nr_inactive_anon
     36616            -4.5%      34978        proc-vmstat.nr_inactive_file
     27761            -7.1%      25785        proc-vmstat.nr_kernel_stack
    101009 ±  9%     -54.7%      45776 ±  4%  proc-vmstat.nr_mapped
      2454            -7.1%       2280        proc-vmstat.nr_page_table_pages
    170156 ±  2%     -39.4%     103160 ±  2%  proc-vmstat.nr_shmem
     46943            -8.2%      43099        proc-vmstat.nr_slab_reclaimable
    332.00 ± 20%     -63.2%     122.33 ±  5%  proc-vmstat.nr_writeback
     52818 ±  3%      +8.6%      57373 ±  3%  proc-vmstat.nr_zone_active_anon
      4297           -47.9%       2236 ±  2%  proc-vmstat.nr_zone_active_file
    188213           -40.6%     111868 ±  2%  proc-vmstat.nr_zone_inactive_anon
     36616            -4.5%      34978        proc-vmstat.nr_zone_inactive_file
     17322 ±  8%     -39.5%      10475        proc-vmstat.nr_zone_write_pending
    248503 ±  6%     +49.2%     370838 ±  3%  proc-vmstat.numa_hint_faults
     85952 ± 11%    +102.1%     173717 ±  8%  proc-vmstat.numa_hint_faults_local
  13399838           -12.1%   11775591        proc-vmstat.numa_hit
  13204028           -12.3%   11579798        proc-vmstat.numa_local
      7649 ± 60%    +695.1%      60823 ± 17%  proc-vmstat.numa_pages_migrated
    431655 ±  6%     +36.8%     590543 ±  3%  proc-vmstat.numa_pte_updates
     47974         +1007.6%     531369        proc-vmstat.pgactivate
  13411344           -12.1%   11784147        proc-vmstat.pgalloc_normal
     19653            -2.3%      19207        proc-vmstat.pgdeactivate
   1191636 ±  2%    +111.8%    2523476 ±  3%  proc-vmstat.pgfault
   3359965           +44.7%    4860911        proc-vmstat.pgfree
      7649 ± 60%    +695.1%      60823 ± 17%  proc-vmstat.pgmigrate_success
     43664          +174.2%     119718 ±  3%  proc-vmstat.pgreuse
     39295            -2.3%      38392        proc-vmstat.pgrotated
    150754 ± 67%     +63.2%     246013 ±  6%  numa-meminfo.node0.AnonPages.max
     18133 ±  8%     -41.3%      10638        numa-meminfo.node0.Dirty
    821082 ±133%    +115.3%    1767949 ± 61%  numa-meminfo.node0.FilePages
    850.33 ± 47%    +594.5%       5905 ± 57%  numa-meminfo.node0.PageTables
     84047 ± 12%     +32.2%     111126 ±  6%  numa-meminfo.node0.SUnreclaim
    133420 ± 11%     +45.5%     194184 ± 17%  numa-meminfo.node0.Slab
    757135 ±140%    +123.2%    1689707 ± 63%  numa-meminfo.node0.Unevictable
      3868           -53.7%       1789 ±  3%  numa-meminfo.node1.Active(file)
    993.67 ±141%   +2776.0%      28578 ± 73%  numa-meminfo.node1.AnonHugePages
     18175 ±  8%     -40.0%      10909        numa-meminfo.node1.Dirty
    203419 ± 37%     -69.7%      61649 ± 22%  numa-meminfo.node1.FilePages
      5448 ±  2%     -10.5%       4876 ±  3%  numa-meminfo.node1.KernelStack
     51418 ± 18%     -52.9%      24226 ± 35%  numa-meminfo.node1.Mapped
   6199397           -32.1%    4212105        numa-meminfo.node1.MemUsed
      2811 ± 62%    +135.0%       6606 ± 22%  numa-meminfo.node2.Active(anon)
      5167 ± 16%     -53.6%       2395 ± 35%  numa-meminfo.node2.Active(file)
     18314 ±  9%     -46.2%       9856 ±  4%  numa-meminfo.node2.Dirty
   1705745 ± 65%     -51.0%     835428 ±130%  numa-meminfo.node2.FilePages
     37586            -9.6%      33987 ±  3%  numa-meminfo.node2.Inactive(file)
     69606 ± 46%     -48.1%      36151 ± 65%  numa-meminfo.node2.KReclaimable
      8407 ± 25%     -23.3%       6451 ± 28%  numa-meminfo.node2.KernelStack
     57525 ± 25%     -38.2%      35574 ± 42%  numa-meminfo.node2.Mapped
  25320269 ±  4%     +10.9%   28070115 ±  3%  numa-meminfo.node2.MemFree
   7701909 ± 13%     -35.7%    4952063 ± 21%  numa-meminfo.node2.MemUsed
     69606 ± 46%     -48.1%      36151 ± 65%  numa-meminfo.node2.SReclaimable
      7547 ±107%    +349.6%      33932 ± 38%  numa-meminfo.node2.Shmem
    154242 ± 31%     -30.3%     107529 ± 29%  numa-meminfo.node2.Slab
   1655330 ± 67%     -53.8%     765071 ±141%  numa-meminfo.node2.Unevictable
    193071 ±  4%      +8.2%     208882 ±  3%  numa-meminfo.node3.Active(anon)
      4427 ± 20%     -59.5%       1793 ±  4%  numa-meminfo.node3.Active(file)
     18059 ±  9%     -47.9%       9414        numa-meminfo.node3.Dirty
    668283 ±  4%     -32.6%     450427 ± 21%  numa-meminfo.node3.FilePages
    567429 ± 21%     -67.4%     184903 ± 13%  numa-meminfo.node3.Inactive
    530849 ± 22%     -71.2%     152907 ± 16%  numa-meminfo.node3.Inactive(anon)
     36579           -12.5%      31995        numa-meminfo.node3.Inactive(file)
      7283 ± 25%     -26.6%       5344 ± 11%  numa-meminfo.node3.KernelStack
    238607 ± 14%     -69.4%      72943        numa-meminfo.node3.Mapped
   6641259           -31.6%    4545156 ±  2%  numa-meminfo.node3.MemUsed
      3685 ±106%     -88.7%     416.00 ± 15%  numa-meminfo.node3.PageTables
    617405 ±  3%     -48.5%     318247        numa-meminfo.node3.Shmem
      4399           -39.2%       2675        numa-vmstat.node0.nr_dirty
    205234 ±133%    +115.3%     441938 ± 61%  numa-vmstat.node0.nr_file_pages
    211.67 ± 47%    +596.7%       1474 ± 57%  numa-vmstat.node0.nr_page_table_pages
     21011 ± 12%     +32.2%      27781 ±  6%  numa-vmstat.node0.nr_slab_unreclaimable
    189283 ±140%    +123.2%     422426 ± 63%  numa-vmstat.node0.nr_unevictable
    108.00 ±  2%     -55.2%      48.33 ±  9%  numa-vmstat.node0.nr_writeback
    189283 ±140%    +123.2%     422426 ± 63%  numa-vmstat.node0.nr_zone_unevictable
      4191           -34.5%       2744        numa-vmstat.node0.nr_zone_write_pending
    963.33           -53.6%     447.00 ±  3%  numa-vmstat.node1.nr_active_file
   2449050           +17.5%    2876554 ±  2%  numa-vmstat.node1.nr_dirtied
      4451           -38.3%       2745        numa-vmstat.node1.nr_dirty
     50842 ± 38%     -69.8%      15356 ± 22%  numa-vmstat.node1.nr_file_pages
      5446 ±  2%     -10.5%       4876 ±  3%  numa-vmstat.node1.nr_kernel_stack
     12751 ± 17%     -52.0%       6122 ± 34%  numa-vmstat.node1.nr_mapped
    107.33 ± 18%     -58.4%      44.67 ±  5%  numa-vmstat.node1.nr_writeback
   2437553           +17.5%    2863940 ±  2%  numa-vmstat.node1.nr_written
    963.33           -53.6%     447.00 ±  3%  numa-vmstat.node1.nr_zone_active_file
      4240           -34.0%       2799        numa-vmstat.node1.nr_zone_write_pending
   2288218 ±  7%     -21.7%    1792298 ±  5%  numa-vmstat.node1.numa_hit
   2209607 ±  8%     -22.1%    1721115 ±  6%  numa-vmstat.node1.numa_local
    704.33 ± 62%    +133.1%       1642 ± 22%  numa-vmstat.node2.nr_active_anon
      1287 ± 16%     -53.5%     598.33 ± 35%  numa-vmstat.node2.nr_active_file
      4488 ±  2%     -44.7%       2482 ±  4%  numa-vmstat.node2.nr_dirty
    426502 ± 65%     -51.0%     208784 ±130%  numa-vmstat.node2.nr_file_pages
   6333076 ±  4%     +10.8%    7016951 ±  3%  numa-vmstat.node2.nr_free_pages
      9467           -10.2%       8506 ±  3%  numa-vmstat.node2.nr_inactive_file
      8420 ± 25%     -23.4%       6448 ± 28%  numa-vmstat.node2.nr_kernel_stack
     14413 ± 25%     -37.6%       8994 ± 42%  numa-vmstat.node2.nr_mapped
      1890 ±107%    +344.5%       8402 ± 38%  numa-vmstat.node2.nr_shmem
     17394 ± 46%     -48.0%       9038 ± 65%  numa-vmstat.node2.nr_slab_reclaimable
    413832 ± 67%     -53.8%     191267 ±141%  numa-vmstat.node2.nr_unevictable
    107.33 ± 16%     -64.6%      38.00 ± 13%  numa-vmstat.node2.nr_writeback
    704.33 ± 62%    +133.1%       1642 ± 22%  numa-vmstat.node2.nr_zone_active_anon
      1287 ± 16%     -53.5%     598.33 ± 35%  numa-vmstat.node2.nr_zone_active_file
      9467           -10.2%       8506 ±  3%  numa-vmstat.node2.nr_zone_inactive_file
    413832 ± 67%     -53.8%     191267 ±141%  numa-vmstat.node2.nr_zone_unevictable
      4262           -40.5%       2535 ±  5%  numa-vmstat.node2.nr_zone_write_pending
   2787785 ± 18%     -27.8%    2011540 ± 20%  numa-vmstat.node2.numa_hit
   2729197 ± 19%     -29.3%    1928712 ± 21%  numa-vmstat.node2.numa_local
     47937 ±  4%      +8.6%      52081 ±  3%  numa-vmstat.node3.nr_active_anon
      1102 ± 20%     -59.4%     448.00 ±  4%  numa-vmstat.node3.nr_active_file
      4460 ±  2%     -47.1%       2361        numa-vmstat.node3.nr_dirty
    165419 ±  4%     -32.0%     112471 ± 21%  numa-vmstat.node3.nr_file_pages
    131364 ± 22%     -70.9%      38244 ± 17%  numa-vmstat.node3.nr_inactive_anon
      9174 ±  2%     -12.9%       7995        numa-vmstat.node3.nr_inactive_file
      7289 ± 25%     -26.7%       5344 ± 11%  numa-vmstat.node3.nr_kernel_stack
     57899 ± 14%     -68.5%      18264        numa-vmstat.node3.nr_mapped
    921.67 ±106%     -88.6%     104.67 ± 15%  numa-vmstat.node3.nr_page_table_pages
    152671 ±  3%     -48.0%      79429        numa-vmstat.node3.nr_shmem
    103.33 ± 16%     -56.5%      45.00 ±  4%  numa-vmstat.node3.nr_writeback
     47937 ±  4%      +8.6%      52081 ±  3%  numa-vmstat.node3.nr_zone_active_anon
      1102 ± 20%     -59.4%     448.00 ±  4%  numa-vmstat.node3.nr_zone_active_file
    131364 ± 22%     -70.9%      38244 ± 17%  numa-vmstat.node3.nr_zone_inactive_anon
      9175 ±  2%     -12.9%       7995        numa-vmstat.node3.nr_zone_inactive_file
      4251           -43.8%       2387        numa-vmstat.node3.nr_zone_write_pending
 2.966e+09           +28.6%  3.813e+09        perf-stat.i.branch-instructions
  33960441 ±  2%     +31.8%   44745148        perf-stat.i.branch-misses
     41.66           -14.5       27.13        perf-stat.i.cache-miss-rate%
  99821813 ±  2%     -28.2%   71639046        perf-stat.i.cache-misses
 2.316e+08 ±  3%     +12.8%  2.613e+08        perf-stat.i.cache-references
    996227           -50.3%     495444        perf-stat.i.context-switches
      5.94 ±  3%    +278.4%      22.49        perf-stat.i.cpi
 8.402e+10 ±  3%    +385.4%  4.078e+11        perf-stat.i.cpu-cycles
     40611 ±  3%    +166.9%     108409        perf-stat.i.cpu-migrations
    998.32 ±  7%    +465.2%       5642        perf-stat.i.cycles-between-cache-misses
      0.25 ± 15%      -0.1        0.11 ±  7%  perf-stat.i.dTLB-load-miss-rate%
   8934527 ±  7%     -44.7%    4939324 ±  5%  perf-stat.i.dTLB-load-misses
 3.796e+09           +33.3%  5.058e+09        perf-stat.i.dTLB-loads
      0.04 ± 20%      -0.0        0.02 ± 18%  perf-stat.i.dTLB-store-miss-rate%
    459447 ±  7%     -53.5%     213525 ± 15%  perf-stat.i.dTLB-store-misses
 1.614e+09           -22.7%  1.248e+09        perf-stat.i.dTLB-stores
     20.22 ±  3%      +5.5       25.70        perf-stat.i.iTLB-load-miss-rate%
   3979357 ±  2%     -45.7%    2162498 ±  3%  perf-stat.i.iTLB-load-misses
  16841042           -62.9%    6240320 ±  2%  perf-stat.i.iTLB-loads
 1.438e+10           +24.7%  1.794e+10        perf-stat.i.instructions
      3707 ±  3%    +132.8%       8632 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.20 ±  4%     -75.8%       0.05        perf-stat.i.ipc
      2.30           -70.6%       0.68 ±  2%  perf-stat.i.major-faults
      0.58 ±  3%    +385.4%       2.83        perf-stat.i.metric.GHz
    688.00 ±  3%     -35.6%     443.31 ±  2%  perf-stat.i.metric.K/sec
     59.66           +20.8%      72.06        perf-stat.i.metric.M/sec
      8034           -35.6%       5172        perf-stat.i.minor-faults
     93.35            -1.9       91.44        perf-stat.i.node-load-miss-rate%
  46997176 ±  3%     -16.2%   39393426        perf-stat.i.node-load-misses
   3008057 ±  5%     +19.6%    3598593 ±  2%  perf-stat.i.node-loads
     91.88            +4.0       95.90        perf-stat.i.node-store-miss-rate%
  15310460 ±  2%     -30.9%   10580432        perf-stat.i.node-store-misses
    953036           -62.0%     362234 ±  4%  perf-stat.i.node-stores
      8036           -35.6%       5173        perf-stat.i.page-faults
     16.10 ±  2%      -9.6%      14.56        perf-stat.overall.MPKI
      1.14 ±  2%      +0.0        1.17        perf-stat.overall.branch-miss-rate%
     43.11           -15.7       27.41        perf-stat.overall.cache-miss-rate%
      5.84 ±  2%    +289.2%      22.73        perf-stat.overall.cpi
    841.56          +576.7%       5695        perf-stat.overall.cycles-between-cache-misses
      0.23 ±  8%      -0.1        0.10 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  8%      -0.0        0.02 ± 15%  perf-stat.overall.dTLB-store-miss-rate%
     19.11 ±  2%      +6.6       25.75        perf-stat.overall.iTLB-load-miss-rate%
      3616 ±  2%    +129.6%       8304 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.17 ±  2%     -74.3%       0.04        perf-stat.overall.ipc
     93.99            -2.4       91.63        perf-stat.overall.node-load-miss-rate%
     94.14            +2.5       96.69        perf-stat.overall.node-store-miss-rate%
 2.944e+09           +29.3%  3.807e+09        perf-stat.ps.branch-instructions
  33703990 ±  2%     +32.5%   44648438        perf-stat.ps.branch-misses
  99059836 ±  2%     -27.8%   71496503        perf-stat.ps.cache-misses
 2.299e+08 ±  3%     +13.5%  2.608e+08        perf-stat.ps.cache-references
    988599           -50.0%     494339        perf-stat.ps.context-switches
 8.339e+10 ±  3%    +388.2%  4.071e+11        perf-stat.ps.cpu-cycles
     40304 ±  3%    +168.4%     108180        perf-stat.ps.cpu-migrations
   8862497 ±  7%     -44.2%    4945004 ±  5%  perf-stat.ps.dTLB-load-misses
 3.767e+09           +34.1%   5.05e+09        perf-stat.ps.dTLB-loads
    455874 ±  7%     -53.2%     213210 ± 15%  perf-stat.ps.dTLB-store-misses
 1.602e+09           -22.2%  1.246e+09        perf-stat.ps.dTLB-stores
   3948894 ±  2%     -45.3%    2159829 ±  3%  perf-stat.ps.iTLB-load-misses
  16712123           -62.7%    6225920 ±  2%  perf-stat.ps.iTLB-loads
 1.427e+10           +25.5%  1.791e+10        perf-stat.ps.instructions
      2.28           -70.5%       0.67 ±  2%  perf-stat.ps.major-faults
      7966           -35.1%       5167        perf-stat.ps.minor-faults
  46640466 ±  3%     -15.7%   39316797        perf-stat.ps.node-load-misses
   2985172 ±  5%     +20.3%    3592617 ±  2%  perf-stat.ps.node-loads
  15192323 ±  2%     -30.5%   10556476        perf-stat.ps.node-store-misses
    945665           -61.7%     361913 ±  4%  perf-stat.ps.node-stores
      7968           -35.1%       5168        perf-stat.ps.page-faults
 1.918e+12          +327.9%  8.206e+12 ±  4%  perf-stat.total.instructions
     46.10           -37.2        8.88        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     45.77           -37.0        8.80        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     45.76           -37.0        8.80        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.75           -37.0        8.80        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     43.33           -34.9        8.47        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     43.26           -34.8        8.47        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     41.45           -33.2        8.20        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     13.42           -13.2        0.18 ±141%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
     13.15 ±  2%     -13.0        0.17 ±141%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
     13.68 ±  3%     -12.7        0.99 ± 35%  perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     13.68 ±  3%     -12.7        0.99 ± 35%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      8.69 ±  7%      -8.7        0.00        perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      7.90 ±  8%      -7.9        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      7.88 ±  2%      -7.9        0.00        perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      7.65 ±  2%      -7.6        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      7.25 ±  8%      -7.2        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page
      7.02 ±  2%      -7.0        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      5.06 ±  3%      -5.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
     17.60            -2.7       14.91 ±  9%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     17.57            -2.7       14.90 ±  9%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     17.56            -2.7       14.90 ±  9%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
     17.55            -2.7       14.90 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file
     17.41 ±  2%      -2.5       14.89 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
     15.10            -1.5       13.57 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
     14.90            -1.3       13.55 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      1.36            +2.1        3.48 ± 48%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.3        2.34        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +2.3        2.34        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +2.3        2.34        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +2.7        2.66        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page
      0.00            +2.7        2.67        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00            +2.7        2.67        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.8        2.77 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +2.8        2.77 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.8        2.78 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +2.8        2.78 ±  2%  perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.8        2.78        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.8        2.78        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.8        2.83 ± 50%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +2.8        2.83 ± 50%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.8        2.85 ± 50%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.9        2.88        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +2.9        2.88        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +2.9        2.88        perf-profile.calltrace.cycles-pp.finish_wait.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     18.64 ±  3%      +4.5       23.11        perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +6.4        6.45 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages
      0.00            +6.4        6.45        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +7.0        6.96        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +10.2       10.22 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page
      0.00           +10.2       10.23 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00           +10.3       10.30 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00           +11.6       11.63 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page
      0.00           +11.6       11.64 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      0.00           +11.7       11.73 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +12.0       12.01 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00           +12.0       12.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +12.1       12.11 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.83 ±  3%     +12.2       12.99 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00           +12.7       12.70 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00           +12.7       12.72 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +12.8       12.81 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.17           +13.1       15.31 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00           +13.7       13.67 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00           +13.7       13.68 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      1.10 ± 10%     +13.7       14.84 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00           +13.8       13.78 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      1.22 ±  8%     +14.9       16.15 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      1.68 ±  3%     +15.3       17.02        perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     25.25 ±  3%     +18.0       43.21 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     53.14           +37.8       90.94        perf-profile.calltrace.cycles-pp.write
     53.02           +37.9       90.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     53.01           +37.9       90.91        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.96           +37.9       90.90        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.96           +37.9       90.90        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.91           +38.0       90.89        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.90           +38.0       90.89        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     51.86           +38.9       90.78        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     46.10           -37.2        8.88        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     46.10           -37.2        8.88        perf-profile.children.cycles-pp.cpu_startup_entry
     46.09           -37.2        8.88        perf-profile.children.cycles-pp.do_idle
     45.77           -37.0        8.80        perf-profile.children.cycles-pp.start_secondary
     43.65           -35.1        8.54        perf-profile.children.cycles-pp.cpuidle_enter
     43.64           -35.1        8.54        perf-profile.children.cycles-pp.cpuidle_enter_state
     42.27           -33.8        8.44        perf-profile.children.cycles-pp.intel_idle
     26.83 ±  2%     -25.4        1.41 ± 29%  perf-profile.children.cycles-pp.do_write_page
     23.61 ±  3%     -23.0        0.62 ± 26%  perf-profile.children.cycles-pp.osq_lock
     15.99           -15.4        0.56 ± 13%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     13.75 ±  5%     -13.2        0.57 ± 18%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
     13.43           -13.0        0.44 ± 16%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
     13.69 ±  3%     -12.7        0.99 ± 35%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
     12.59           -12.3        0.29 ± 26%  perf-profile.children.cycles-pp.f2fs_submit_page_write
     12.27 ±  6%     -11.8        0.44 ± 20%  perf-profile.children.cycles-pp.__mutex_lock
      6.55 ±  3%      -6.5        0.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      5.42 ±  4%      -5.4        0.00        perf-profile.children.cycles-pp._raw_spin_lock_irq
      4.25 ± 41%      -4.1        0.12 ± 33%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      4.23 ± 41%      -4.1        0.12 ± 37%  perf-profile.children.cycles-pp.__percpu_counter_sum
     17.60            -2.7       14.91 ±  9%  perf-profile.children.cycles-pp.file_write_and_wait_range
     17.57            -2.7       14.90 ±  9%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     17.56            -2.7       14.90 ±  9%  perf-profile.children.cycles-pp.do_writepages
     17.55            -2.7       14.90 ±  9%  perf-profile.children.cycles-pp.f2fs_write_data_pages
     17.41 ±  2%      -2.5       14.89 ±  9%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      2.71 ±  3%      -2.4        0.35 ±  3%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      2.71 ±  3%      -2.4        0.35 ±  3%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      2.10 ±  4%      -1.8        0.27 ±  4%  perf-profile.children.cycles-pp.set_node_addr
      1.82 ±  2%      -1.8        0.05        perf-profile.children.cycles-pp.rwsem_wake
     15.10            -1.5       13.57 ±  2%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      1.99 ±  2%      -1.4        0.55 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     14.90            -1.3       13.55 ±  2%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      1.34 ±  2%      -1.2        0.09 ±  5%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.16 ±  2%      -1.0        0.11 ±  4%  perf-profile.children.cycles-pp.__submit_bio
      1.14 ±  2%      -1.0        0.11 ±  4%  perf-profile.children.cycles-pp.submit_bio_noacct
      1.36 ±  3%      -1.0        0.34        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.99 ±  2%      -0.9        0.07 ± 14%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.97 ±  2%      -0.9        0.09 ±  9%  perf-profile.children.cycles-pp.__submit_merged_bio
      1.00 ±  2%      -0.9        0.14 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      1.41 ±  2%      -0.8        0.57        perf-profile.children.cycles-pp.try_to_wake_up
      0.88 ±  2%      -0.8        0.07 ±  7%  perf-profile.children.cycles-pp.f2fs_buffered_write_iter
      0.88 ±  2%      -0.8        0.07        perf-profile.children.cycles-pp.generic_perform_write
      0.86 ±  2%      -0.8        0.09 ±  5%  perf-profile.children.cycles-pp.__pagevec_release
      0.85 ±  2%      -0.8        0.09 ±  5%  perf-profile.children.cycles-pp.release_pages
      0.94 ±  6%      -0.7        0.25 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.91 ±  3%      -0.7        0.24 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.91 ±  3%      -0.7        0.23 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.65 ±  4%      -0.6        0.07 ±  7%  perf-profile.children.cycles-pp.brd_submit_bio
      0.64 ±  4%      -0.6        0.06 ±  7%  perf-profile.children.cycles-pp.brd_do_bvec
      0.59 ± 10%      -0.6        0.03 ± 70%  perf-profile.children.cycles-pp.menu_select
      0.58 ±  7%      -0.5        0.03 ± 70%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.55 ±  2%      -0.4        0.12        perf-profile.children.cycles-pp.schedule_idle
      0.48 ±  3%      -0.4        0.05        perf-profile.children.cycles-pp.xas_find_marked
      0.64            -0.4        0.22 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.58 ±  2%      -0.4        0.23 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.52 ±  3%      -0.3        0.18 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.55            -0.3        0.21 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.40 ±  3%      -0.3        0.07 ±  6%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.50 ±  6%      -0.3        0.19        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.54            -0.3        0.23 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.46            -0.3        0.16 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.30 ± 10%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.33            -0.3        0.07 ± 12%  perf-profile.children.cycles-pp.start_kernel
      0.30 ± 12%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.41 ±  6%      -0.2        0.16        perf-profile.children.cycles-pp.tick_sched_timer
      0.38 ±  4%      -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.38 ±  4%      -0.2        0.15        perf-profile.children.cycles-pp.update_process_times
      0.43            -0.2        0.23 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.33 ±  2%      -0.2        0.14        perf-profile.children.cycles-pp.f2fs_issue_flush
      0.28 ±  8%      -0.2        0.10 ±  9%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.24            -0.2        0.06 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.25 ±  5%      -0.2        0.07        perf-profile.children.cycles-pp.update_rq_clock
      0.22            -0.2        0.05        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.25 ±  9%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.22 ±  7%      -0.2        0.06        perf-profile.children.cycles-pp.update_cfs_group
      0.21 ±  5%      -0.2        0.06        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.20            -0.1        0.06        perf-profile.children.cycles-pp.ret_from_fork
      0.20            -0.1        0.06        perf-profile.children.cycles-pp.kthread
      0.23 ±  2%      -0.1        0.13        perf-profile.children.cycles-pp.update_curr
      0.23 ±  3%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.20 ±  4%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.wait_for_completion
      0.18 ±  4%      -0.1        0.12        perf-profile.children.cycles-pp.schedule_timeout
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__update_load_avg_se
      0.11 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.23 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.select_task_rq_fair
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.finish_task_switch
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 14%      +0.0        0.10        perf-profile.children.cycles-pp.cpumask_next_and
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.select_idle_cpu
      0.00            +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
      0.00            +0.2        0.15        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.2        0.15        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.2        0.17        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.12            +0.3        2.47 ±  3%  perf-profile.children.cycles-pp.schedule
      0.04 ± 73%      +0.4        0.44 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.5        0.53        perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.6        0.55        perf-profile.children.cycles-pp.__wake_up_common
      1.04 ±  4%      +0.6        1.61 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.05 ±  4%      +0.6        1.63 ±  3%  perf-profile.children.cycles-pp.find_busiest_group
      1.34 ±  3%      +0.8        2.11 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.14 ±  4%      +0.8        1.98 ±  4%  perf-profile.children.cycles-pp.load_balance
      1.18 ±  3%      +0.9        2.08 ±  4%  perf-profile.children.cycles-pp.newidle_balance
     18.64 ±  3%      +4.5       23.11        perf-profile.children.cycles-pp.__write_node_page
      0.00            +7.8        7.76 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
      2.17           +13.1       15.31 ±  2%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      0.00           +13.9       13.87        perf-profile.children.cycles-pp.finish_wait
      1.23 ±  8%     +14.9       16.15 ±  2%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      1.68 ±  3%     +15.3       17.02        perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
     25.25 ±  3%     +18.0       43.21 ±  4%  perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      1.94 ±  7%     +25.9       27.87        perf-profile.children.cycles-pp.f2fs_get_node_info
     53.38           +37.6       90.99        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     53.37           +37.6       90.99        perf-profile.children.cycles-pp.do_syscall_64
     53.16           +37.8       90.94        perf-profile.children.cycles-pp.write
     52.97           +37.9       90.90        perf-profile.children.cycles-pp.ksys_write
     52.97           +37.9       90.90        perf-profile.children.cycles-pp.vfs_write
     52.92           +38.0       90.90        perf-profile.children.cycles-pp.new_sync_write
     52.90           +38.0       90.89        perf-profile.children.cycles-pp.f2fs_file_write_iter
     51.87           +38.9       90.78        perf-profile.children.cycles-pp.f2fs_do_sync_file
      0.00           +64.6       64.55        perf-profile.children.cycles-pp.prepare_to_wait_event
      9.42 ± 14%     +75.8       85.22        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.60 ± 35%     +80.7       85.34        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     42.15           -33.7        8.42        perf-profile.self.cycles-pp.intel_idle
     23.46 ±  3%     -22.8        0.62 ± 26%  perf-profile.self.cycles-pp.osq_lock
      2.23 ±  3%      -1.9        0.30 ±  4%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      1.33            -1.2        0.09        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.99 ±  2%      -0.9        0.07 ± 14%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.83 ±  2%      -0.7        0.09 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.77 ±  2%      -0.6        0.16 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.47 ±  3%      -0.4        0.05        perf-profile.self.cycles-pp.xas_find_marked
      0.53            -0.3        0.23 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26 ±  3%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.24            -0.2        0.06 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.20 ±  6%      -0.1        0.06        perf-profile.self.cycles-pp.update_cfs_group
      0.19 ±  6%      -0.1        0.05        perf-profile.self.cycles-pp.update_rq_clock
      0.22 ±  3%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.11 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.09 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.__update_load_avg_se
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.05 ±  8%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.1        0.12        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.76 ±  3%      +0.5        1.28 ±  3%  perf-profile.self.cycles-pp.update_sd_lb_stats
      9.42 ± 14%     +75.8       85.22        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-rc1-00033-ge4544b63a7ee"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.17.0-rc1 Kernel Configuration
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
# CONFIG_VIDEO_OV5693 is not set
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
# CONFIG_DRM_HYPERV is not set
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
# CONFIG_TEST_REF_TRACKER is not set
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
# CONFIG_TEST_SIPHASH is not set
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

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='aim7-fs-raid.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='lkp-csl-2sp9'
	export tbox_group='lkp-csl-2sp9'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='621b0e80fd380a65f754a150'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-e4544b63a7ee49e7fbebf35ece-20220227-26103-16gs0fw-2.yaml'
	export id='6c6a4570103c570663c582d95ee1a2a25a922934'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2'
	export brand='Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz'
	export commit='e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae'
	export ucode='0x500320a'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI'
	export need_kconfig='{"BLK_DEV_RAM"=>"m"}
{"BLK_DEV"=>"y"}
{"BLOCK"=>"y"}
MD_RAID0
F2FS_FS'
	export enqueue_time='2022-02-27 13:39:12 +0800'
	export _id='621b0e98fd380a65f754a152'
	export _rt='/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='9095376fca24c897bf449018f38af6a2472925a7'
	export base_commit='cfb92440ee71adcc2105b0890bb01ac3cddb8507'
	export branch='linux-devel/devel-hourly-20220226-160717'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/2'
	export scheduler_version='/lkp/lkp/.src-20220225-152656'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/vmlinuz-5.17.0-rc1-00033-ge4544b63a7ee
branch=linux-devel/devel-hourly-20220226-160717
job=/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-e4544b63a7ee49e7fbebf35ece-20220227-26103-16gs0fw-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220226.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-2293be58d6a1-1_20220227.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20220217.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.17.0-rc5-06463-g9095376fca24'
	export repeat_to=3
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/vmlinuz-5.17.0-rc1-00033-ge4544b63a7ee'
	export dequeue_time='2022-02-27 14:17:35 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-e4544b63a7ee49e7fbebf35ece-20220227-26103-16gs0fw-2.cgz'

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

	run_setup nr_brd=4 ramdisk_size=12884901888 $LKP_SRC/setup/disk

	run_setup raid_level='raid0' $LKP_SRC/setup/md

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

	run_test test='sync_disk_rw' load=100 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=15 $LKP_SRC/stats/wrapper perf-profile
	env test='sync_disk_rw' load=100 $LKP_SRC/stats/wrapper aim7
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

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/aim7-fs-raid.yaml:
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 4BRD_12G
md: RAID0
fs: f2fs
aim7:
  test: sync_disk_rw
  load: 100
job_origin: aim7-fs-raid.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-csl-2sp9
tbox_group: lkp-csl-2sp9
kconfig: x86_64-rhel-8.3
submit_id: 621b0e80fd380a65f754a150
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-e4544b63a7ee49e7fbebf35ece-20220227-26103-16gs0fw-1.yaml"
id: 6edc055b5f5ec2bb5487b79b60efabce9a5b7f7f
queuer_version: "/lkp-src"
:#! hosts/lkp-csl-2sp9:
model: Cascade Lake
nr_node: 2
nr_cpu: 88
memory: 128G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2"
brand: Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz
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
commit: e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae
:#! include/testbox/lkp-csl-2sp9:
ucode: '0x500320a'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
:#! include/disk/nr_brd:
need_kconfig:
- BLK_DEV_RAM: m
- BLK_DEV: y
- BLOCK: y
- MD_RAID0
- F2FS_FS
:#! include/md/raid_level:
:#! include/fs/OTHERS:
enqueue_time: 2022-02-27 13:39:12.445523395 +08:00
_id: 621b0e98fd380a65f754a151
_rt: "/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 9095376fca24c897bf449018f38af6a2472925a7
base_commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
branch: linux-devel/devel-hourly-20220226-160717
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/0"
scheduler_version: "/lkp/lkp/.src-20220225-152656"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/vmlinuz-5.17.0-rc1-00033-ge4544b63a7ee
- branch=linux-devel/devel-hourly-20220226-160717
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x500320a-debian-10.4-x86_64-20200603.cgz-e4544b63a7ee49e7fbebf35ece-20220227-26103-16gs0fw-1.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220226.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-2293be58d6a1-1_20220227.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20210917.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20220217.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220225094351/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.17.0-rc5-00306-g2293be58d6a1
repeat_to: 3
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae/vmlinuz-5.17.0-rc1-00033-ge4544b63a7ee"
dequeue_time: 2022-02-27 14:09:14.337540543 +08:00
job_state: finished
loadavg: 60.00 21.45 7.68 1/868 9071
start_time: '1645942241'
end_time: '1645942322'
version: "/lkp/lkp/.src-20220225-152742:4b9987c8:7e75d265b"

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=4" "rd_size=12582912"
 "dmsetup" "remove_all"
 "wipefs" "-a" "--force" "/dev/ram0"
 "wipefs" "-a" "--force" "/dev/ram1"
 "wipefs" "-a" "--force" "/dev/ram2"
 "wipefs" "-a" "--force" "/dev/ram3"
 "mdadm" "-q" "--create" "/dev/md0" "--chunk=256" "--level=raid0" "--raid-devices=4" "--force" "--assume-clean" "/dev/ram0" "/dev/ram1" "/dev/ram2" "/dev/ram3"
wipefs -a --force /dev/md0
mkfs -t f2fs /dev/md0
mkdir -p /fs/md0
mount -t f2fs /dev/md0 /fs/md0

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
10 sync_disk_rw
EOF
echo "/fs/md0" > config

	(
		echo lkp-csl-2sp9
		echo sync_disk_rw

		echo 1
		echo 100
		echo 2
		echo 100
		echo 1
	) | ./multitask -t &

--Qxx1br4bt0+wmkIi--
