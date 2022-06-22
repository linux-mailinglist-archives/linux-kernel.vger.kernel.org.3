Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2B553F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355004AbiFVAZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiFVAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:25:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7312D00
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655857519; x=1687393519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jV7fU9mHGjNtEZDY1UE7qbOKeSgmvK3WN34xbjHnjJI=;
  b=SdwRUg3JjORZ5iYOAmD2fRmO9tGfGb8wPVOzxglgXGQ9akdi2zbmRPiJ
   K8LEOL3NSdQwkFzBvBmwKfKo+3j/mYD32/aIomS6AHVge4i82R8iaqFCF
   hem2FT9Z72TQB4fxqaXRk0j20K75RLHGh/S1d/uQaLuwno08jsqc8kRGi
   /wpSlu1nobbvAOkB8OZ1bouwbYFahRX7Gc2/g+UFrzxi1CmqKoqZmXjti
   oCDRrJjOSef4qd52gYGBriEF8HwRuExYyO+PvlOgDLaD+5a/6NkmwC2ag
   43VVaOiIl8GJRbWVsblrmSGfDBzq1c4QTtETSCWJC8FLwcyMzZ95wyNyO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281345076"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="281345076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833828072"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 17:25:16 -0700
Date:   Wed, 22 Jun 2022 08:25:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [af_unix]  afd20b9290:  stress-ng.sockdiag.ops_per_sec -26.3%
 regression
Message-ID: <20220622002515.GA4273@shbuild999.sh.intel.com>
References: <20211219083847.GA14057@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211219083847.GA14057@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 19, 2021 at 04:38:47PM +0800, Sang, Oliver wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -26.3% regression of stress-ng.sockdiag.ops_per_sec due to commit:
 
Some update on this,

We did some further check, and commit afd20b9290 seems to be a nice
optimization as it replaces a big lock with many split locks, which
could reduce lock contention and is also shown in the  performance
data from the commit log.

We first thought this strange change is also related to underlying
cache alignment changes, and we tried disabling HW cache prefetch,
forcing 'data' section aligned (patch [1]), 'bss' section aligned
(patch [2]), but the regression stays.  

Then we did an experiment, afd20b9290 replace one lock with
'2 * UNIX_HASH_SIZE' locks, and we first changed the UNIX_HASH_SIZE
from 256 to 64 or 32, and then applied afd20b9290, and found the
regression is reduced to -5.7%(64) and -1.6%(32). So this regression
is related with the commit.

From the original profile

>      97.56            +0.5       98.04        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.sock_diag_rcv.netlink_unicast.netlink_sendmsg
>      99.22            +0.5       99.70        perf-profile.calltrace.cycles-pp.netlink_unicast.netlink_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
>      99.19            +0.5       99.68        perf-profile.calltrace.cycles-pp.sock_diag_rcv.netlink_unicast.netlink_sendmsg.sock_sendmsg.____sys_sendmsg
>      98.41            +0.5       98.90        perf-profile.calltrace.cycles-pp.__mutex_lock.sock_diag_rcv.netlink_unicast.netlink_sendmsg.sock_sendmsg

The hottest spot is not the 'unix_table_locks' touched by afd20b9290,
which is hard to explain. One guess is that loosening one lock makes
another lock contention in critical path more severe, but we don't
have data to prove it. 

[1]. https://lore.kernel.org/lkml/20220426071523.71923-1-feng.tang@intel.com/
[2]. https://lore.kernel.org/lkml/20220613020943.GD75244@shbuild999.sh.intel.com/

Thanks,
Feng
 
> commit: afd20b9290e184c203fe22f2d6b80dc7127ba724 ("af_unix: Replace the big lock with small locks.")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: stress-ng
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	class: network
> 	test: sockdiag
> 	cpufreq_governor: performance
> 	ucode: 0xd000280
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>   network/gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp6/sockdiag/stress-ng/60s/0xd000280
> 
> commit: 
>   e6b4b87389 ("af_unix: Save hash in sk_hash.")
>   afd20b9290 ("af_unix: Replace the big lock with small locks.")
> 
> e6b4b873896f0e92 afd20b9290e184c203fe22f2d6b 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  3.129e+08           -26.3%  2.306e+08        stress-ng.sockdiag.ops
>    5214640           -26.3%    3842782        stress-ng.sockdiag.ops_per_sec
>      82895            -6.9%      77178        stress-ng.time.involuntary_context_switches
>     103737            -9.5%      93892        stress-ng.time.voluntary_context_switches
>       7067            -6.3%       6620        vmstat.system.cs
>       0.05            -0.0        0.04 ±  6%  mpstat.cpu.all.soft%
>       0.13 ±  3%      -0.0        0.12 ±  5%  mpstat.cpu.all.usr%
>    1783836 ±  7%     -21.6%    1397649 ± 12%  numa-vmstat.node1.numa_hit
>    1689477 ±  8%     -22.9%    1303128 ± 13%  numa-vmstat.node1.numa_local
>     894897 ± 22%     +46.6%    1312222 ± 11%  turbostat.C1E
>       3.85 ± 55%      +3.5        7.33 ± 10%  turbostat.C1E%
>    2451882 ±  4%     -24.3%    1855676 ±  2%  numa-numastat.node0.local_node
>    2501404 ±  3%     -23.8%    1905161 ±  3%  numa-numastat.node0.numa_hit
>    2437526           -24.1%    1849165 ±  3%  numa-numastat.node1.local_node
>    2503693           -23.5%    1915338 ±  3%  numa-numastat.node1.numa_hit
>       7977 ± 19%     -22.6%       6178 ±  8%  softirqs.CPU2.RCU
>       7989 ± 25%     -23.4%       6121 ±  3%  softirqs.CPU25.RCU
>       8011 ± 24%     -26.8%       5862 ±  3%  softirqs.CPU8.RCU
>     890963 ±  3%     -17.4%     735738        softirqs.RCU
>      74920            -3.6%      72233        proc-vmstat.nr_slab_unreclaimable
>    5007343           -23.7%    3821593        proc-vmstat.numa_hit
>    4891675           -24.2%    3705934        proc-vmstat.numa_local
>    5007443           -23.7%    3821701        proc-vmstat.pgalloc_normal
>    4796850           -24.7%    3610677        proc-vmstat.pgfree
>       0.71 ± 17%     -41.1%       0.42        perf-stat.i.MPKI
>       0.12 ± 12%      -0.0        0.10 ±  8%  perf-stat.i.branch-miss-rate%
>   10044516 ± 13%     -23.6%    7678759 ±  3%  perf-stat.i.cache-misses
>   42758000 ±  6%     -28.5%   30580693        perf-stat.i.cache-references
>       6920            -5.9%       6510        perf-stat.i.context-switches
>     571.08 ±  2%     -13.4%     494.31 ±  2%  perf-stat.i.cpu-migrations
>      39356 ± 12%     +29.2%      50865 ±  3%  perf-stat.i.cycles-between-cache-misses
>       0.01 ± 36%      -0.0        0.00 ± 24%  perf-stat.i.dTLB-load-miss-rate%
>       0.01 ± 23%      -0.0        0.00 ± 14%  perf-stat.i.dTLB-store-miss-rate%
>  8.447e+08           +27.0%  1.073e+09        perf-stat.i.dTLB-stores
>      13.36            -2.2%      13.07        perf-stat.i.major-faults
>     364.56 ±  9%     -24.9%     273.60        perf-stat.i.metric.K/sec
>     350.63            +0.7%     353.23        perf-stat.i.metric.M/sec
>      87.88            +1.4       89.23        perf-stat.i.node-load-miss-rate%
>    1381985 ± 12%     -27.7%     999393 ±  3%  perf-stat.i.node-load-misses
>     198989 ±  6%     -31.9%     135458 ±  4%  perf-stat.i.node-loads
>    4305132           -27.4%    3124590        perf-stat.i.node-store-misses
>     581796 ±  5%     -25.6%     432807 ±  3%  perf-stat.i.node-stores
>       0.46 ±  5%     -28.7%       0.33        perf-stat.overall.MPKI
>      39894 ± 12%     +28.6%      51310 ±  3%  perf-stat.overall.cycles-between-cache-misses
>       0.01 ± 22%      -0.0        0.00 ± 12%  perf-stat.overall.dTLB-store-miss-rate%
>    9916145 ± 13%     -23.8%    7560589 ±  3%  perf-stat.ps.cache-misses
>   42385546 ±  5%     -28.7%   30225277        perf-stat.ps.cache-references
>       6786            -5.9%       6385        perf-stat.ps.context-switches
>     562.65 ±  2%     -13.5%     486.73 ±  2%  perf-stat.ps.cpu-migrations
>  8.314e+08           +26.8%  1.055e+09        perf-stat.ps.dTLB-stores
>    1359293 ± 11%     -27.7%     982331 ±  3%  perf-stat.ps.node-load-misses
>     205280 ±  6%     -33.3%     136979 ±  5%  perf-stat.ps.node-loads
>    4237942           -27.5%    3070934        perf-stat.ps.node-store-misses
>     585102 ±  5%     -26.6%     429702 ±  3%  perf-stat.ps.node-stores
>  5.844e+12            +0.9%  5.897e+12        perf-stat.total.instructions
>      99.26            +0.5       99.72        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg
>      99.25            +0.5       99.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
>      99.25            +0.5       99.72        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
>      99.26            +0.5       99.73        perf-profile.calltrace.cycles-pp.sendmsg
>      99.24            +0.5       99.71        perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      99.24            +0.5       99.71        perf-profile.calltrace.cycles-pp.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
>      99.25            +0.5       99.72        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
>      99.24            +0.5       99.71        perf-profile.calltrace.cycles-pp.netlink_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
>      97.56            +0.5       98.04        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.sock_diag_rcv.netlink_unicast.netlink_sendmsg
>      99.22            +0.5       99.70        perf-profile.calltrace.cycles-pp.netlink_unicast.netlink_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
>      99.19            +0.5       99.68        perf-profile.calltrace.cycles-pp.sock_diag_rcv.netlink_unicast.netlink_sendmsg.sock_sendmsg.____sys_sendmsg
>      98.41            +0.5       98.90        perf-profile.calltrace.cycles-pp.__mutex_lock.sock_diag_rcv.netlink_unicast.netlink_sendmsg.sock_sendmsg
>       0.48            -0.4        0.07 ±  5%  perf-profile.children.cycles-pp.recvmsg
>       0.46 ±  2%      -0.4        0.06        perf-profile.children.cycles-pp.___sys_recvmsg
>       0.47 ±  2%      -0.4        0.07 ±  6%  perf-profile.children.cycles-pp.__sys_recvmsg
>       0.45            -0.4        0.06 ±  9%  perf-profile.children.cycles-pp.____sys_recvmsg
>       1.14            -0.4        0.76        perf-profile.children.cycles-pp.netlink_dump
>       1.09            -0.4        0.73        perf-profile.children.cycles-pp.unix_diag_dump
>       0.66            -0.3        0.37 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.26 ±  2%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.sk_diag_fill
>       0.07 ±  5%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.__x64_sys_socket
>       0.07 ±  5%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.__sys_socket
>       0.07            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.__close
>       0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.memset_erms
>       0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.nla_put
>       0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__nlmsg_put
>       0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__socket
>       0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__nla_put
>       0.07            -0.0        0.05        perf-profile.children.cycles-pp.__nla_reserve
>       0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_core
>       0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__softirqentry_text_start
>       0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_do_batch
>       0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.sock_i_ino
>      99.89            +0.0       99.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      99.89            +0.0       99.92        perf-profile.children.cycles-pp.do_syscall_64
>       0.00            +0.1        0.08        perf-profile.children.cycles-pp.__raw_callee_save___native_queued_spin_unlock
>      99.26            +0.5       99.73        perf-profile.children.cycles-pp.sendmsg
>      99.25            +0.5       99.72        perf-profile.children.cycles-pp.__sys_sendmsg
>      99.25            +0.5       99.72        perf-profile.children.cycles-pp.___sys_sendmsg
>      99.24            +0.5       99.71        perf-profile.children.cycles-pp.____sys_sendmsg
>      99.24            +0.5       99.71        perf-profile.children.cycles-pp.sock_sendmsg
>      99.24            +0.5       99.71        perf-profile.children.cycles-pp.netlink_sendmsg
>      99.22            +0.5       99.70        perf-profile.children.cycles-pp.netlink_unicast
>      97.59            +0.5       98.08        perf-profile.children.cycles-pp.osq_lock
>      99.19            +0.5       99.68        perf-profile.children.cycles-pp.sock_diag_rcv
>      98.41            +0.5       98.90        perf-profile.children.cycles-pp.__mutex_lock
>       0.12 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.unix_diag_dump
>       0.11            -0.0        0.08        perf-profile.self.cycles-pp.memset_erms
>       0.00            +0.1        0.06        perf-profile.self.cycles-pp.__raw_callee_save___native_queued_spin_unlock
>       0.28 ±  5%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
>      97.23            +0.5       97.72        perf-profile.self.cycles-pp.osq_lock
> 
