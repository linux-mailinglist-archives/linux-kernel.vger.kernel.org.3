Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3751DC47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443011AbiEFPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443007AbiEFPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:40:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7158E6D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651851398; x=1683387398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=el0IBGxTns9Dxb1F3bdqBwH5UgFr25B3LKd9vA5BBAA=;
  b=OkPXA8oFkFoLZfFgZsdoC3CPiy+ebvTw63wjd6d2jjTqpw7ALzve3vZa
   VaKMOXT7GxVbOSZUdv9Z947WoKavweGNBO0OE4hf6PspFsFi3oI3AenGI
   jq6zx6Jd/myGsH83MvvJalGS+s1bf35kL/xnN/insWL/ZN2F/5ym7nzMe
   NwwXjQTN58FhzZ5a2iCWjkVHi9F4xlijsW3Ztqw6KlrznmN71mC0zEBwZ
   iFDsR6cZ6uCbllT+jdJjBZwUnx8H0iNwdJD95PnOBzI6jGDmr46ISFtxG
   91QcWsH1FV8jcfIe4VTlFnwmPxMbQDMhmVEsTRCT+0H/jAVD2bhMBSXCO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="266088873"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266088873"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="632979179"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2022 08:36:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 08:36:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 08:36:37 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Fri, 6 May 2022 08:36:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: RE: [x86/split_lock]  b041b525da:  stress-ng.lockbus.ops_per_sec
 -48.3% regression
Thread-Topic: [x86/split_lock]  b041b525da:  stress-ng.lockbus.ops_per_sec
 -48.3% regression
Thread-Index: AQHYYSVTGBB9FHbdw0S/Nntwl9Z12K0R+ekA
Date:   Fri, 6 May 2022 15:36:37 +0000
Message-ID: <e45c465ac52843168a7ba7c6834fa697@intel.com>
References: <20220506084306.GG23061@xsang-OptiPlex-9020>
In-Reply-To: <20220506084306.GG23061@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only -43.8%? That just sounds like I made life "pretty unpleasant", not "mi=
serable" :-)

This regression is expected. No plans to fix it.

You might look into a benchmark that measures performance of other applicat=
ions while this
stress-ng.lockbus.ops_per_sec is running. The intent of this patch is to re=
duce the impact
of bus locks on the rest of the system.

-Tony

-----Original Message-----
From: Sang, Oliver <oliver.sang@intel.com>=20
Sent: Friday, May 06, 2022 1:43 AM
To: Luck, Tony <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; LKML <linux-kernel@vger.kernel.or=
g>; x86@kernel.org; lkp@lists.01.org; lkp <lkp@intel.com>; Huang, Ying <yin=
g.huang@intel.com>; Tang, Feng <feng.tang@intel.com>; zhengjun.xing@linux.i=
ntel.com; Yin, Fengwei <fengwei.yin@intel.com>
Subject: [x86/split_lock] b041b525da: stress-ng.lockbus.ops_per_sec -48.3% =
regression



Greeting,

FYI, we noticed a -48.3% regression of stress-ng.lockbus.ops_per_sec due to=
 commit:


commit: b041b525dab95352fbd666b14dc73ab898df465f ("x86/split_lock: Make lif=
e miserable for split lockers")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/splitlock

in testcase: stress-ng
on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @=
 2.60GHz with 128G memory
with following parameters:

	nr_threads: 100%
	testtime: 60s
	class: memory
	test: lockbus
	cpufreq_governor: performance
	ucode: 0xd000331




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
---------------------------------------------------------------------------=
----------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in t=
his email
        bin/lkp split-job --compatible job.yaml # generate the yaml file fo=
r lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/t=
estcase/testtime/ucode:
  memory/gcc-11/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-2020060=
3.cgz/lkp-icl-2sp6/lockbus/stress-ng/60s/0xd000331

commit:=20
  v5.18-rc4
  b041b525da ("x86/split_lock: Make life miserable for split lockers")

       v5.18-rc4 b041b525dab95352fbd666b14dc=20
---------------- ---------------------------=20
         %stddev     %change         %stddev
             \          |                \ =20
     84375           -48.3%      43587 =B1  3%  stress-ng.lockbus.ops
      1400           -48.3%     723.64 =B1  3%  stress-ng.lockbus.ops_per_s=
ec
     46977 =B1  2%     -61.4%      18141 =B1 11%  stress-ng.time.involuntar=
y_context_switches
      7779           -98.7%      97.67        stress-ng.time.percent_of_cpu=
_this_job_got
    251.13 =B1 21%     -99.3%       1.80 =B1  3%  stress-ng.time.system_tim=
e
      4660           -98.7%      59.55        stress-ng.time.user_time
    431.40 =B1 10%   +8470.7%      36974 =B1 11%  stress-ng.time.voluntary_=
context_switches
    293203           +12.9%     331056        meminfo.AnonHugePages
      4712 =B1  3%    +156.4%      12081        uptime.idle
 5.616e+08 =B1  2%   +1311.6%  7.927e+09        cpuidle..time
   1017813 =B1 20%   +1502.7%   16312100        cpuidle..usage
      6.44 =B1  8%     +90.9       97.30        mpstat.cpu.all.idle%
     34.59 =B1  7%     -32.8        1.76 =B1 31%  mpstat.cpu.all.irq%
      0.89 =B1 13%      -0.8        0.09 =B1 44%  mpstat.cpu.all.soft%
      5.10 =B1  8%      -5.0        0.07 =B1  3%  mpstat.cpu.all.sys%
     52.99 =B1  6%     -52.2        0.78        mpstat.cpu.all.usr%
    878964 =B1  5%     +10.8%     974067        numa-meminfo.node0.Shmem
   1018902 =B1  7%     +16.1%    1183099 =B1  5%  numa-meminfo.node1.Inacti=
ve
   1018902 =B1  7%     +16.1%    1183099 =B1  5%  numa-meminfo.node1.Inacti=
ve(anon)
    842061 =B1  6%     +17.5%     989596 =B1  2%  numa-meminfo.node1.Mapped
    848272 =B1  5%     +15.2%     976855        numa-meminfo.node1.Shmem
      9.80 =B1  4%    +886.4%      96.67        vmstat.cpu.id
     50.00 =B1  6%    -100.0%       0.00        vmstat.cpu.us
    121.40           -99.2%       1.00        vmstat.procs.r
      2548           +34.1%       3418 =B1 10%  vmstat.system.cs
    144004 =B1  9%     +74.3%     250999        vmstat.system.in
    282203 =B1  4%     +14.8%     323935 =B1  5%  numa-vmstat.node0.nr_inac=
tive_anon
    211496 =B1  6%     +16.6%     246585 =B1  2%  numa-vmstat.node0.nr_mapp=
ed
    206680 =B1  5%     +18.9%     245754 =B1  2%  numa-vmstat.node0.nr_shme=
m
    282195 =B1  4%     +14.8%     323935 =B1  5%  numa-vmstat.node0.nr_zone=
_inactive_anon
    240558 =B1  8%     +24.0%     298317 =B1  5%  numa-vmstat.node1.nr_inac=
tive_anon
    197879 =B1  7%     +26.2%     249742 =B1  2%  numa-vmstat.node1.nr_mapp=
ed
      1642 =B1 40%     +27.4%       2093 =B1 40%  numa-vmstat.node1.nr_page=
_table_pages
    199997 =B1  6%     +23.2%     246443        numa-vmstat.node1.nr_shmem
    240505 =B1  8%     +24.0%     298317 =B1  5%  numa-vmstat.node1.nr_zone=
_inactive_anon
      3066           -97.4%      78.67 =B1 19%  turbostat.Avg_MHz
     93.28           -89.2        4.07 =B1 22%  turbostat.Busy%
      3296           -40.8%       1952 =B1  5%  turbostat.Bzy_MHz
    781444 =B1 54%   +1628.9%   13510398 =B1 28%  turbostat.C1E
      4.23 =B1 61%     +64.0       68.28 =B1 57%  turbostat.C1E%
      4.44 =B1 55%   +1453.3%      69.03 =B1 55%  turbostat.CPU%c1
     63.20           -16.4%      52.83 =B1  4%  turbostat.CoreTmp
   8352767 =B1  8%     +97.6%   16501874        turbostat.IRQ
     63.00 =B1  2%     -16.1%      52.83 =B1  2%  turbostat.PkgTmp
    375.56           -39.9%     225.74 =B1  6%  turbostat.PkgWatt
    121375            +7.5%     130425        proc-vmstat.nr_anon_pages
    987453            +7.0%    1056187        proc-vmstat.nr_file_pages
    537372           +14.8%     616827        proc-vmstat.nr_inactive_anon
    422895           +16.2%     491550        proc-vmstat.nr_mapped
      4107 =B1  2%      +6.8%       4385 =B1  2%  proc-vmstat.nr_page_table=
_pages
    418750           +16.4%     487474        proc-vmstat.nr_shmem
    537370           +14.8%     616827        proc-vmstat.nr_zone_inactive_=
anon
      3330 =B1 61%     -99.7%      11.50 =B1186%  proc-vmstat.numa_hint_fau=
lts
      2035 =B1 59%     -99.9%       1.67 =B1197%  proc-vmstat.numa_hint_fau=
lts_local
   1002524            +4.6%    1048399        proc-vmstat.numa_hit
    886626            +5.0%     931095        proc-vmstat.numa_local
      5946 =B1116%     -98.4%      95.00 =B1223%  proc-vmstat.numa_pages_mi=
grated
    493749 =B1  3%     -99.8%     853.33 =B1223%  proc-vmstat.numa_pte_upda=
tes
   1001222            +4.6%    1046837        proc-vmstat.pgalloc_normal
    841720            +8.6%     914206        proc-vmstat.pgfault
    775048           +18.1%     915055        proc-vmstat.pgfree
      5946 =B1116%     -98.4%      95.00 =B1223%  proc-vmstat.pgmigrate_suc=
cess
     17361           +54.0%      26742        proc-vmstat.pgreuse
 5.129e+08 =B1  7%     -41.1%  3.022e+08 =B1  2%  perf-stat.i.branch-instru=
ctions
      0.95 =B1 11%      +3.6        4.58 =B1 99%  perf-stat.i.branch-miss-r=
ate%
   2382071 =B1  7%     -44.4%    1324699 =B1  8%  perf-stat.i.cache-misses
      2539 =B1  2%     +20.4%       3057 =B1 12%  perf-stat.i.context-switc=
hes
    426.49 =B1  4%     -97.6%      10.23 =B1 13%  perf-stat.i.cpi
    139782            -8.4%     128033        perf-stat.i.cpu-clock
 2.639e+11           -95.8%  1.118e+10 =B1 11%  perf-stat.i.cpu-cycles
    752036 =B1  5%     -98.0%      14941 =B1 26%  perf-stat.i.cycles-betwee=
n-cache-misses
 5.608e+08 =B1  9%     -32.0%  3.812e+08        perf-stat.i.dTLB-loads
      0.41 =B1  6%      -0.3        0.13 =B1118%  perf-stat.i.dTLB-store-mi=
ss-rate%
 2.391e+08 =B1  9%     -20.5%    1.9e+08        perf-stat.i.dTLB-stores
  2.44e+09 =B1  9%     -38.9%   1.49e+09 =B1  2%  perf-stat.i.instructions
     54.70 =B1  5%     -77.1%      12.51        perf-stat.i.major-faults
      1.88 =B1  2%     -95.4%       0.09 =B1 11%  perf-stat.i.metric.GHz
    944.84 =B1 19%     -64.4%     336.04 =B1112%  perf-stat.i.metric.K/sec
      8.61 =B1  8%     -20.7%       6.83        perf-stat.i.metric.M/sec
     10898 =B1  6%     -58.0%       4579        perf-stat.i.minor-faults
     65.86 =B1  4%     +18.6       84.51        perf-stat.i.node-load-miss-=
rate%
    141261 =B1  8%     +56.6%     221158 =B1 15%  perf-stat.i.node-load-mis=
ses
     91471 =B1  5%     -46.1%      49309 =B1 16%  perf-stat.i.node-loads
     89300 =B1 11%     -54.1%      40980 =B1 21%  perf-stat.i.node-store-mi=
sses
   1212554 =B1  7%     -57.6%     514245 =B1  4%  perf-stat.i.node-stores
     10953 =B1  6%     -58.1%       4591        perf-stat.i.page-faults
    139787            -8.4%     128033        perf-stat.i.task-clock
    254.01 =B1  8%     -97.0%       7.52 =B1 12%  perf-stat.overall.cpi
    286326 =B1  9%     -97.0%       8577 =B1 19%  perf-stat.overall.cycles-=
between-cache-misses
      0.00 =B1  9%   +3300.4%       0.13 =B1 11%  perf-stat.overall.ipc
     61.44 =B1  9%     +20.3       81.74        perf-stat.overall.node-load=
-miss-rate%
  1.77e+08 =B1  9%     +67.8%   2.97e+08 =B1  2%  perf-stat.ps.branch-instr=
uctions
   2702583 =B1 18%    +329.2%   11598999 =B1 82%  perf-stat.ps.branch-misse=
s
    716805 =B1 10%     +81.6%    1301900 =B1  8%  perf-stat.ps.cache-misses
      1459 =B1  5%    +106.1%       3008 =B1 12%  perf-stat.ps.context-swit=
ches
     95205 =B1  8%     +32.3%     125997        perf-stat.ps.cpu-clock
 2.037e+11 =B1  7%     -94.6%    1.1e+10 =B1 11%  perf-stat.ps.cpu-cycles
    120.76 =B1  7%     +42.3%     171.90 =B1  9%  perf-stat.ps.cpu-migratio=
ns
 2.002e+08 =B1 10%     +87.2%  3.748e+08        perf-stat.ps.dTLB-loads
  89201266 =B1 11%    +109.5%  1.868e+08        perf-stat.ps.dTLB-stores
 8.074e+08 =B1 10%     +81.4%  1.465e+09 =B1  2%  perf-stat.ps.instructions
      3184 =B1  8%     +41.1%       4492        perf-stat.ps.minor-faults
     61589 =B1 10%    +253.4%     217652 =B1 15%  perf-stat.ps.node-load-mi=
sses
     29168 =B1  6%     +38.2%      40305 =B1 21%  perf-stat.ps.node-store-m=
isses
    303641 =B1 13%     +66.2%     504661 =B1  4%  perf-stat.ps.node-stores
      3198 =B1  8%     +40.8%       4504        perf-stat.ps.page-faults
     95207 =B1  8%     +32.3%     125997        perf-stat.ps.task-clock
  4.66e+10 =B1 12%     +99.4%  9.294e+10 =B1  2%  perf-stat.total.instructi=
ons
     32354 =B1 57%     -99.8%      61.76 =B1 70%  sched_debug.cfs_rq:/.MIN_=
vruntime.avg
   2247989 =B1 26%     -99.8%       5064 =B1 56%  sched_debug.cfs_rq:/.MIN_=
vruntime.max
    247145 =B1 39%     -99.8%     537.60 =B1 62%  sched_debug.cfs_rq:/.MIN_=
vruntime.stddev
      0.57 =B1  4%     -83.4%       0.10 =B1 28%  sched_debug.cfs_rq:/.h_nr=
_running.avg
     32354 =B1 57%     -99.8%      61.76 =B1 70%  sched_debug.cfs_rq:/.max_=
vruntime.avg
   2247991 =B1 26%     -99.8%       5064 =B1 56%  sched_debug.cfs_rq:/.max_=
vruntime.max
    247145 =B1 39%     -99.8%     537.60 =B1 62%  sched_debug.cfs_rq:/.max_=
vruntime.stddev
   2763104           -99.7%       8913 =B1 36%  sched_debug.cfs_rq:/.min_vr=
untime.avg
   3358182 =B1  4%     -99.3%      24400 =B1 13%  sched_debug.cfs_rq:/.min_=
vruntime.max
   1538537 =B1 12%     -99.8%       2844 =B1 28%  sched_debug.cfs_rq:/.min_=
vruntime.min
    156471 =B1  5%     -97.6%       3686 =B1 24%  sched_debug.cfs_rq:/.min_=
vruntime.stddev
      0.55 =B1  3%     -82.7%       0.10 =B1 28%  sched_debug.cfs_rq:/.nr_r=
unning.avg
    119.88 =B1 20%     +55.8%     186.73 =B1 29%  sched_debug.cfs_rq:/.remo=
ved.load_avg.stddev
     59.29 =B1 28%     +51.4%      89.77 =B1 30%  sched_debug.cfs_rq:/.remo=
ved.util_avg.stddev
    665.61           -64.8%     234.43 =B1 18%  sched_debug.cfs_rq:/.runnab=
le_avg.avg
      1886 =B1  8%     -37.4%       1181 =B1 16%  sched_debug.cfs_rq:/.runn=
able_avg.max
    528967 =B1  9%    -101.6%      -8642        sched_debug.cfs_rq:/.spread=
0.avg
   1119786 =B1 10%     -99.4%       6842 =B1 55%  sched_debug.cfs_rq:/.spre=
ad0.max
   -715437           -97.9%     -14712        sched_debug.cfs_rq:/.spread0.=
min
    152488 =B1  7%     -97.6%       3686 =B1 24%  sched_debug.cfs_rq:/.spre=
ad0.stddev
    628.76           -62.8%     233.60 =B1 18%  sched_debug.cfs_rq:/.util_a=
vg.avg
      1585 =B1 13%     -25.6%       1179 =B1 16%  sched_debug.cfs_rq:/.util=
_avg.max
    303.61 =B1  3%     -93.0%      21.11 =B1 34%  sched_debug.cfs_rq:/.util=
_est_enqueued.avg
      1127           -32.9%     756.50 =B1 18%  sched_debug.cfs_rq:/.util_e=
st_enqueued.max
    206.96 =B1  4%     -51.3%     100.87 =B1 22%  sched_debug.cfs_rq:/.util=
_est_enqueued.stddev
   2525689 =B1 11%     -64.2%     903412 =B1  2%  sched_debug.cpu.avg_idle.=
avg
   6234029 =B1  9%     -79.7%    1266582 =B1 16%  sched_debug.cpu.avg_idle.=
max
    299393 =B1 18%     -95.8%      12702 =B1196%  sched_debug.cpu.avg_idle.=
min
   1331474 =B1 13%     -86.1%     185160 =B1 11%  sched_debug.cpu.avg_idle.=
stddev
     68351           -39.0%      41714 =B1 24%  sched_debug.cpu.clock.avg
     68613           -39.2%      41719 =B1 24%  sched_debug.cpu.clock.max
     67731           -38.4%      41708 =B1 24%  sched_debug.cpu.clock.min
    275.33 =B1 28%     -98.9%       3.00 =B1 33%  sched_debug.cpu.clock.std=
dev
      1145 =B1 11%     -58.0%     481.20 =B1 36%  sched_debug.cpu.clock_tas=
k.stddev
      3293 =B1  2%     -89.3%     352.66 =B1 26%  sched_debug.cpu.curr->pid=
.avg
   1704382 =B1  8%     -70.6%     501841        sched_debug.cpu.max_idle_ba=
lance_cost.avg
   3528217 =B1  7%     -80.3%     695415 =B1 14%  sched_debug.cpu.max_idle_=
balance_cost.max
    638236 =B1 16%     -97.1%      18481 =B1 54%  sched_debug.cpu.max_idle_=
balance_cost.stddev
      0.00 =B1 37%     -97.0%       0.00 =B1 32%  sched_debug.cpu.next_bala=
nce.stddev
      0.57 =B1  3%     -83.3%       0.10 =B1 26%  sched_debug.cpu.nr_runnin=
g.avg
      2.40 =B1  8%     -51.4%       1.17 =B1 31%  sched_debug.cpu.nr_runnin=
g.max
      0.34 =B1  4%     -13.2%       0.29 =B1 15%  sched_debug.cpu.nr_runnin=
g.stddev
     67624           -38.3%      41712 =B1 24%  sched_debug.cpu_clk
     66904           -38.7%      40993 =B1 24%  sched_debug.ktime
      0.00          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_mig=
ratory.avg
      0.50          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_mig=
ratory.max
      0.04          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_mig=
ratory.stddev
      0.00 =B1 33%    -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_r=
unning.avg
      0.50          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_run=
ning.max
      0.05 =B1 15%    -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_r=
unning.stddev
      2.18 =B1 19%    -100.0%       0.00        sched_debug.rt_rq:/.rt_time=
.avg
    273.15 =B1 24%    -100.0%       0.00        sched_debug.rt_rq:/.rt_time=
.max
     24.05 =B1 24%    -100.0%       0.00        sched_debug.rt_rq:/.rt_time=
.stddev
     68997           -37.0%      43458 =B1 25%  sched_debug.sched_clk
    128.87 =B1 15%    -122.8        6.06 =B1 45%  perf-profile.calltrace.cy=
cles-pp.asm_sysvec_apic_timer_interrupt.stress_lockbus
     43.54 =B1 21%     -18.7       24.80 =B1 11%  perf-profile.calltrace.cy=
cles-pp.stress_lockbus
     15.57 =B1  3%     -15.6        0.00        perf-profile.calltrace.cycl=
es-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_lo=
ckbus
     13.77 =B1  3%     -13.8        0.00        perf-profile.calltrace.cycl=
es-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_=
apic_timer_interrupt.stress_lockbus
     13.65 =B1  3%     -13.7        0.00        perf-profile.calltrace.cycl=
es-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_int=
errupt.asm_sysvec_apic_timer_interrupt.stress_lockbus
     10.18 =B1  7%      -5.4        4.76 =B1 55%  perf-profile.calltrace.cy=
cles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrup=
t.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      6.71 =B1 12%      -3.7        2.97 =B1 54%  perf-profile.calltrace.cy=
cles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_ap=
ic_timer_interrupt.sysvec_apic_timer_interrupt
      5.91 =B1 14%      -3.6        2.32 =B1 55%  perf-profile.calltrace.cy=
cles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_r=
un_queues.hrtimer_interrupt
      6.06 =B1 14%      -3.5        2.54 =B1 60%  perf-profile.calltrace.cy=
cles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_int=
errupt.__sysvec_apic_timer_interrupt
      4.80 =B1 15%      -3.5        1.31 =B1 44%  perf-profile.calltrace.cy=
cles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_ti=
mer.__hrtimer_run_queues
      2.12 =B1 10%      -1.3        0.84 =B1 46%  perf-profile.calltrace.cy=
cles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__s=
ysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      2.01 =B1  8%      -0.5        1.49 =B1 19%  perf-profile.calltrace.cy=
cles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_int=
errupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.58 =B1  6%      +0.4        1.02 =B1 20%  perf-profile.calltrace.cy=
cles-pp.rebalance_domains.__softirqentry_text_start.__irq_exit_rcu.sysvec_a=
pic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.6        0.61 =B1  7%  perf-profile.calltrace.cycl=
es-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sys=
vec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.7        0.70 =B1 22%  perf-profile.calltrace.cycl=
es-pp.load_balance.rebalance_domains.__softirqentry_text_start.__irq_exit_r=
cu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.78 =B1 37%  perf-profile.calltrace.cycl=
es-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.as=
m_sysvec_apic_timer_interrupt
      0.00            +1.2        1.17 =B1 27%  perf-profile.calltrace.cycl=
es-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_a=
pic_timer_interrupt.cpuidle_enter_state
      0.00            +1.2        1.21 =B1 26%  perf-profile.calltrace.cycl=
es-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_inter=
rupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.4        1.38 =B1 12%  perf-profile.calltrace.cycl=
es-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_i=
dle_call.do_idle
      0.00            +1.9        1.87 =B1 28%  perf-profile.calltrace.cycl=
es-pp.__softirqentry_text_start.__irq_exit_rcu.sysvec_apic_timer_interrupt.=
asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +2.1        2.10 =B1  6%  perf-profile.calltrace.cycl=
es-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_=
startup_entry
      0.00            +2.8        2.84 =B1 14%  perf-profile.calltrace.cycl=
es-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_inte=
rrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +4.4        4.42 =B1 18%  perf-profile.calltrace.cycl=
es-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_sta=
rtup_64_no_verify
      0.00            +7.3        7.34 =B1 36%  perf-profile.calltrace.cycl=
es-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_int=
errupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +7.5        7.53 =B1 38%  perf-profile.calltrace.cycl=
es-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_=
apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00           +12.6       12.59 =B1 31%  perf-profile.calltrace.cycl=
es-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_e=
nter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +15.9       15.90 =B1 26%  perf-profile.calltrace.cycl=
es-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpu=
idle_idle_call.do_idle
      0.00           +47.0       47.02 =B1  8%  perf-profile.calltrace.cycl=
es-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cp=
uidle_idle_call
      0.00           +47.2       47.21 =B1  8%  perf-profile.calltrace.cycl=
es-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idl=
e
      0.00           +65.0       64.98 =B1  3%  perf-profile.calltrace.cycl=
es-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_start=
up_entry
      0.00           +65.3       65.26 =B1  3%  perf-profile.calltrace.cycl=
es-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_s=
tartup_64_no_verify
      0.00           +70.6       70.57 =B1  4%  perf-profile.calltrace.cycl=
es-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_v=
erify
      0.00           +71.3       71.30 =B1  4%  perf-profile.calltrace.cycl=
es-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.00           +71.4       71.39 =B1  4%  perf-profile.calltrace.cycl=
es-pp.cpu_startup_entry.secondary_startup_64_no_verify
      0.00           +72.0       71.98 =B1  4%  perf-profile.calltrace.cycl=
es-pp.secondary_startup_64_no_verify
     95.06           -68.0       27.09 =B1 12%  perf-profile.children.cycle=
s-pp.stress_lockbus
     80.12 =B1 13%     -61.7       18.47 =B1 23%  perf-profile.children.cyc=
les-pp.asm_sysvec_apic_timer_interrupt
     14.64 =B1  3%      -7.2        7.48 =B1 36%  perf-profile.children.cyc=
les-pp.hrtimer_interrupt
     14.76 =B1  3%      -7.1        7.66 =B1 38%  perf-profile.children.cyc=
les-pp.__sysvec_apic_timer_interrupt
     10.91 =B1  7%      -6.1        4.86 =B1 54%  perf-profile.children.cyc=
les-pp.__hrtimer_run_queues
      7.20 =B1 12%      -4.2        3.02 =B1 54%  perf-profile.children.cyc=
les-pp.tick_sched_timer
      6.33 =B1 14%      -4.0        2.38 =B1 55%  perf-profile.children.cyc=
les-pp.update_process_times
      6.48 =B1 14%      -3.9        2.58 =B1 60%  perf-profile.children.cyc=
les-pp.tick_sched_handle
      5.18 =B1 15%      -3.8        1.35 =B1 43%  perf-profile.children.cyc=
les-pp.scheduler_tick
      2.95 =B1  9%      -2.5        0.43 =B1 17%  perf-profile.children.cyc=
les-pp.entry_SYSCALL_64_after_hwframe
      2.95 =B1  9%      -2.5        0.43 =B1 17%  perf-profile.children.cyc=
les-pp.do_syscall_64
      2.32 =B1 10%      -1.4        0.87 =B1 43%  perf-profile.children.cyc=
les-pp.perf_mux_hrtimer_handler
      1.61 =B1  5%      -1.3        0.27 =B1 10%  perf-profile.children.cyc=
les-pp.__intel_pmu_enable_all
      1.37 =B1 12%      -1.3        0.07 =B1 55%  perf-profile.children.cyc=
les-pp.update_load_avg
      1.41 =B1  2%      -1.3        0.15 =B1 28%  perf-profile.children.cyc=
les-pp.error_entry
      1.46 =B1  4%      -0.9        0.56 =B1 21%  perf-profile.children.cyc=
les-pp.native_sched_clock
      0.82 =B1 10%      -0.7        0.10 =B1 27%  perf-profile.children.cyc=
les-pp.asm_exc_page_fault
      2.21 =B1  8%      -0.7        1.52 =B1 18%  perf-profile.children.cyc=
les-pp.clockevents_program_event
      0.71 =B1  9%      -0.6        0.09 =B1 28%  perf-profile.children.cyc=
les-pp.exc_page_fault
      0.70 =B1  9%      -0.6        0.09 =B1 27%  perf-profile.children.cyc=
les-pp.do_user_addr_fault
      0.58 =B1  7%      -0.5        0.08 =B1 29%  perf-profile.children.cyc=
les-pp.handle_mm_fault
      0.53 =B1  7%      -0.5        0.08 =B1 35%  perf-profile.children.cyc=
les-pp.__handle_mm_fault
      0.53 =B1 10%      -0.5        0.07 =B1 39%  perf-profile.children.cyc=
les-pp.__update_load_avg_cfs_rq
      0.51 =B1  4%      -0.4        0.09 =B1 11%  perf-profile.children.cyc=
les-pp.__x64_sys_execve
      0.51 =B1  3%      -0.4        0.09 =B1 11%  perf-profile.children.cyc=
les-pp.do_execveat_common
      0.50 =B1  2%      -0.4        0.09 =B1 11%  perf-profile.children.cyc=
les-pp.execve
      0.67 =B1 17%      -0.4        0.28 =B1 30%  perf-profile.children.cyc=
les-pp.ret_from_fork
      0.65 =B1 17%      -0.4        0.28 =B1 31%  perf-profile.children.cyc=
les-pp.kthread
      0.76 =B1 10%      -0.3        0.41 =B1 41%  perf-profile.children.cyc=
les-pp.update_rq_clock
      0.40 =B1  4%      -0.3        0.07 =B1 18%  perf-profile.children.cyc=
les-pp.bprm_execve
      0.36 =B1  4%      -0.3        0.06 =B1 46%  perf-profile.children.cyc=
les-pp.exec_binprm
      0.35 =B1  7%      -0.3        0.04 =B1 73%  perf-profile.children.cyc=
les-pp.exit_mmap
      0.36 =B1  4%      -0.3        0.06 =B1 46%  perf-profile.children.cyc=
les-pp.search_binary_handler
      0.36 =B1  3%      -0.3        0.06 =B1 46%  perf-profile.children.cyc=
les-pp.load_elf_binary
      0.35 =B1  6%      -0.3        0.05 =B1 48%  perf-profile.children.cyc=
les-pp.mmput
      0.40 =B1  7%      -0.3        0.12 =B1 20%  perf-profile.children.cyc=
les-pp.__schedule
      0.36 =B1  8%      -0.3        0.08 =B1 19%  perf-profile.children.cyc=
les-pp.schedule
      0.72 =B1  5%      -0.3        0.45 =B1 27%  perf-profile.children.cyc=
les-pp._raw_spin_lock
      0.30 =B1  3%      -0.3        0.03 =B1100%  perf-profile.children.cyc=
les-pp.__x64_sys_openat
      0.30 =B1  4%      -0.3        0.03 =B1100%  perf-profile.children.cyc=
les-pp.do_sys_openat2
      0.34 =B1  8%      -0.3        0.08 =B1 36%  perf-profile.children.cyc=
les-pp.ksys_read
      0.33 =B1  7%      -0.3        0.08 =B1 37%  perf-profile.children.cyc=
les-pp.vfs_read
      0.38 =B1  2%      -0.2        0.13 =B1 27%  perf-profile.children.cyc=
les-pp._raw_spin_lock_irq
      0.27 =B1  2%      -0.2        0.03 =B1100%  perf-profile.children.cyc=
les-pp.do_filp_open
      0.27 =B1  2%      -0.2        0.03 =B1100%  perf-profile.children.cyc=
les-pp.path_openat
      0.65 =B1 13%      -0.2        0.45 =B1  9%  perf-profile.children.cyc=
les-pp.ktime_get_update_offsets_now
      0.33 =B1 17%      -0.2        0.16 =B1 55%  perf-profile.children.cyc=
les-pp.process_one_work
      0.35 =B1 17%      -0.2        0.18 =B1 42%  perf-profile.children.cyc=
les-pp.worker_thread
      0.12 =B1 10%      -0.1        0.02 =B1 99%  perf-profile.children.cyc=
les-pp.smpboot_thread_fn
      0.20 =B1  7%      -0.1        0.11 =B1 33%  perf-profile.children.cyc=
les-pp._raw_spin_unlock_irqrestore
      0.07 =B1  9%      +0.0        0.10 =B1 20%  perf-profile.children.cyc=
les-pp.cpumask_next_and
      0.02 =B1122%      +0.1        0.07 =B1 28%  perf-profile.children.cyc=
les-pp.update_group_capacity
      0.00            +0.1        0.06 =B1 19%  perf-profile.children.cycle=
s-pp.cpuidle_reflect
      0.13 =B1  7%      +0.1        0.20 =B1 27%  perf-profile.children.cyc=
les-pp._raw_spin_trylock
      0.00            +0.1        0.07 =B1 23%  perf-profile.children.cycle=
s-pp.sched_clock
      0.00            +0.1        0.10 =B1 26%  perf-profile.children.cycle=
s-pp.arch_cpu_idle_exit
      0.00            +0.1        0.11 =B1 41%  perf-profile.children.cycle=
s-pp.rcu_eqs_enter
      0.01 =B1200%      +0.1        0.12 =B1 28%  perf-profile.children.cyc=
les-pp.__libc_start_main
      0.01 =B1200%      +0.1        0.12 =B1 28%  perf-profile.children.cyc=
les-pp.main
      0.01 =B1200%      +0.1        0.12 =B1 28%  perf-profile.children.cyc=
les-pp.run_builtin
      0.24 =B1  4%      +0.1        0.36 =B1 11%  perf-profile.children.cyc=
les-pp.update_sg_lb_stats
      0.00            +0.1        0.12 =B1 47%  perf-profile.children.cycle=
s-pp.calc_global_load_tick
      0.00            +0.1        0.12 =B1 13%  perf-profile.children.cycle=
s-pp.menu_reflect
      0.00            +0.1        0.13 =B1 67%  perf-profile.children.cycle=
s-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.14 =B1 26%  perf-profile.children.cycle=
s-pp.call_cpuidle
      0.00            +0.2        0.15 =B1 25%  perf-profile.children.cycle=
s-pp.rcu_dynticks_inc
      0.00            +0.2        0.18 =B1 58%  perf-profile.children.cycle=
s-pp.timerqueue_iterate_next
      0.00            +0.2        0.19 =B1 42%  perf-profile.children.cycle=
s-pp.io_serial_in
      0.23 =B1 13%      +0.2        0.44 =B1 17%  perf-profile.children.cyc=
les-pp.__hrtimer_next_event_base
      0.03 =B1 82%      +0.2        0.26 =B1 45%  perf-profile.children.cyc=
les-pp.__update_blocked_fair
      0.33 =B1  6%      +0.2        0.56 =B1 10%  perf-profile.children.cyc=
les-pp.update_sd_lb_stats
      0.00            +0.2        0.24 =B1 65%  perf-profile.children.cycle=
s-pp.nr_iowait_cpu
      0.34 =B1  6%      +0.3        0.59 =B1 11%  perf-profile.children.cyc=
les-pp.find_busiest_group
      0.00            +0.3        0.25 =B1 46%  perf-profile.children.cycle=
s-pp.serial8250_console_putchar
      0.52 =B1  7%      +0.3        0.78 =B1 17%  perf-profile.children.cyc=
les-pp.load_balance
      0.39 =B1 15%      +0.3        0.64 =B1  7%  perf-profile.children.cyc=
les-pp.lapic_next_deadline
      0.00            +0.3        0.26 =B1 43%  perf-profile.children.cycle=
s-pp.wait_for_xmitr
      0.00            +0.3        0.26 =B1 44%  perf-profile.children.cycle=
s-pp.uart_console_write
      0.22 =B1 10%      +0.3        0.48 =B1 48%  perf-profile.children.cyc=
les-pp.update_blocked_averages
      0.00            +0.3        0.27 =B1 44%  perf-profile.children.cycle=
s-pp.serial8250_console_write
      0.00            +0.3        0.27 =B1 18%  perf-profile.children.cycle=
s-pp.hrtimer_get_next_event
      0.23 =B1 11%      +0.3        0.50 =B1 50%  perf-profile.children.cyc=
les-pp.run_rebalance_domains
      0.00            +0.3        0.27 =B1 42%  perf-profile.children.cycle=
s-pp.console_unlock
      0.00            +0.3        0.27 =B1 42%  perf-profile.children.cycle=
s-pp.call_console_drivers
      0.03 =B1 82%      +0.3        0.31 =B1 42%  perf-profile.children.cyc=
les-pp.irq_work_run_list
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp._printk
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp.vprintk_emit
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp.asm_sysvec_irq_work
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp.sysvec_irq_work
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp.__sysvec_irq_work
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp.irq_work_run
      0.00            +0.3        0.28 =B1 42%  perf-profile.children.cycle=
s-pp.irq_work_single
      0.00            +0.3        0.29 =B1 55%  perf-profile.children.cycle=
s-pp.rcu_eqs_exit
      0.00            +0.3        0.31 =B1 16%  perf-profile.children.cycle=
s-pp.tsc_verify_tsc_adjust
      0.00            +0.3        0.32 =B1 18%  perf-profile.children.cycle=
s-pp.arch_cpu_idle_enter
      0.00            +0.3        0.33 =B1 63%  perf-profile.children.cycle=
s-pp.cpuidle_governor_latency_req
      0.20 =B1 13%      +0.4        0.56 =B1  6%  perf-profile.children.cyc=
les-pp.read_tsc
      0.67 =B1  6%      +0.4        1.06 =B1 18%  perf-profile.children.cyc=
les-pp.rebalance_domains
      0.00            +0.4        0.41 =B1 16%  perf-profile.children.cycle=
s-pp.tick_nohz_irq_exit
      0.00            +0.4        0.43 =B1 23%  perf-profile.children.cycle=
s-pp.timekeeping_max_deferment
      0.00            +0.5        0.48 =B1 19%  perf-profile.children.cycle=
s-pp.get_next_timer_interrupt
      0.00            +0.5        0.51 =B1 45%  perf-profile.children.cycle=
s-pp.rcu_idle_exit
      1.40 =B1 15%      +0.5        1.94 =B1 27%  perf-profile.children.cyc=
les-pp.__softirqentry_text_start
      0.10 =B1 11%      +0.5        0.65 =B1 45%  perf-profile.children.cyc=
les-pp.idle_cpu
      0.00            +0.6        0.59 =B1  9%  perf-profile.children.cycle=
s-pp.hrtimer_next_event_without
      0.00            +0.6        0.60 =B1 14%  perf-profile.children.cycle=
s-pp.start_kernel
      1.43 =B1  9%      +0.8        2.20 =B1 29%  perf-profile.children.cyc=
les-pp.ktime_get
      0.00            +0.9        0.94 =B1 13%  perf-profile.children.cycle=
s-pp.native_irq_return_iret
      1.92 =B1 10%      +1.0        2.92 =B1 13%  perf-profile.children.cyc=
les-pp.__irq_exit_rcu
      0.00            +1.2        1.20 =B1 27%  perf-profile.children.cycle=
s-pp.tick_irq_enter
      0.00            +1.2        1.23 =B1 27%  perf-profile.children.cycle=
s-pp.irq_enter_rcu
      0.00            +1.4        1.41 =B1 12%  perf-profile.children.cycle=
s-pp.tick_nohz_next_event
      0.00            +2.1        2.14 =B1  6%  perf-profile.children.cycle=
s-pp.tick_nohz_get_sleep_length
      0.00            +4.5        4.50 =B1 18%  perf-profile.children.cycle=
s-pp.menu_select
      0.00           +47.4       47.42 =B1  8%  perf-profile.children.cycle=
s-pp.mwait_idle_with_hints
      0.00           +47.6       47.62 =B1  8%  perf-profile.children.cycle=
s-pp.intel_idle
      0.00           +65.6       65.64 =B1  3%  perf-profile.children.cycle=
s-pp.cpuidle_enter_state
      0.00           +65.8       65.83 =B1  3%  perf-profile.children.cycle=
s-pp.cpuidle_enter
      0.00           +71.2       71.22 =B1  4%  perf-profile.children.cycle=
s-pp.cpuidle_idle_call
      0.01 =B1200%     +72.0       71.98 =B1  4%  perf-profile.children.cyc=
les-pp.secondary_startup_64_no_verify
      0.01 =B1200%     +72.0       71.98 =B1  4%  perf-profile.children.cyc=
les-pp.cpu_startup_entry
      0.01 =B1200%     +72.0       71.98 =B1  4%  perf-profile.children.cyc=
les-pp.do_idle
     66.95           -41.4       25.58 =B1 13%  perf-profile.self.cycles-pp=
.stress_lockbus
      5.20 =B1 24%      -3.5        1.73 =B1 55%  perf-profile.self.cycles-=
pp.asm_sysvec_apic_timer_interrupt
      1.56 =B1  5%      -1.3        0.27 =B1 10%  perf-profile.self.cycles-=
pp.__intel_pmu_enable_all
      1.31 =B1 13%      -1.2        0.09 =B1 36%  perf-profile.self.cycles-=
pp.clockevents_program_event
      1.44 =B1  4%      -0.9        0.52 =B1 19%  perf-profile.self.cycles-=
pp.native_sched_clock
      0.45 =B1 10%      -0.4        0.07 =B1 39%  perf-profile.self.cycles-=
pp.__update_load_avg_cfs_rq
      0.42 =B1 10%      -0.3        0.14 =B1 30%  perf-profile.self.cycles-=
pp.error_entry
      0.61 =B1 13%      -0.3        0.34 =B1 13%  perf-profile.self.cycles-=
pp.ktime_get_update_offsets_now
      0.36 =B1  3%      -0.2        0.12 =B1 31%  perf-profile.self.cycles-=
pp._raw_spin_lock_irq
      0.12 =B1 10%      -0.1        0.04 =B1105%  perf-profile.self.cycles-=
pp.tick_sched_timer
      0.02 =B1125%      +0.1        0.09 =B1 35%  perf-profile.self.cycles-=
pp.__softirqentry_text_start
      0.00            +0.1        0.07 =B1 27%  perf-profile.self.cycles-pp=
.update_group_capacity
      0.00            +0.1        0.08 =B1 27%  perf-profile.self.cycles-pp=
.menu_reflect
      0.29 =B1  8%      +0.1        0.38 =B1 11%  perf-profile.self.cycles-=
pp._raw_spin_lock_irqsave
      0.11 =B1  9%      +0.1        0.20 =B1 27%  perf-profile.self.cycles-=
pp._raw_spin_trylock
      0.00            +0.1        0.09 =B1 17%  perf-profile.self.cycles-pp=
.sched_clock_cpu
      0.18 =B1  6%      +0.1        0.27 =B1 15%  perf-profile.self.cycles-=
pp.update_sg_lb_stats
      0.00            +0.1        0.10 =B1 36%  perf-profile.self.cycles-pp=
.rcu_eqs_enter
      0.00            +0.1        0.10 =B1 22%  perf-profile.self.cycles-pp=
.update_sd_lb_stats
      0.02 =B1122%      +0.1        0.13 =B1 37%  perf-profile.self.cycles-=
pp.load_balance
      0.05            +0.1        0.16 =B1 61%  perf-profile.self.cycles-pp=
.rebalance_domains
      0.00            +0.1        0.12 =B1 26%  perf-profile.self.cycles-pp=
.tick_nohz_get_sleep_length
      0.00            +0.1        0.12 =B1 51%  perf-profile.self.cycles-pp=
.cpuidle_governor_latency_req
      0.00            +0.1        0.12 =B1 48%  perf-profile.self.cycles-pp=
.calc_global_load_tick
      0.00            +0.1        0.13 =B1 27%  perf-profile.self.cycles-pp=
.call_cpuidle
      0.00            +0.1        0.13 =B1 36%  perf-profile.self.cycles-pp=
.cpuidle_enter
      0.02 =B1122%      +0.1        0.16 =B1 87%  perf-profile.self.cycles-=
pp.sysvec_apic_timer_interrupt
      0.00            +0.1        0.14 =B1 24%  perf-profile.self.cycles-pp=
.rcu_dynticks_inc
      0.00            +0.1        0.14 =B1 64%  perf-profile.self.cycles-pp=
.get_next_timer_interrupt
      0.00            +0.1        0.15 =B1 25%  perf-profile.self.cycles-pp=
.hrtimer_get_next_event
      0.00            +0.2        0.15 =B1 58%  perf-profile.self.cycles-pp=
.__update_blocked_fair
      0.00            +0.2        0.17 =B1  4%  perf-profile.self.cycles-pp=
.hrtimer_next_event_without
      0.00            +0.2        0.18 =B1 61%  perf-profile.self.cycles-pp=
.timerqueue_iterate_next
      0.00            +0.2        0.19 =B1 60%  perf-profile.self.cycles-pp=
.rcu_eqs_exit
      0.00            +0.2        0.19 =B1 42%  perf-profile.self.cycles-pp=
.io_serial_in
      0.00            +0.2        0.20 =B1 36%  perf-profile.self.cycles-pp=
.do_idle
      0.00            +0.2        0.20 =B1 19%  perf-profile.self.cycles-pp=
.rcu_idle_exit
      0.00            +0.2        0.21 =B1 27%  perf-profile.self.cycles-pp=
.intel_idle
      0.00            +0.2        0.23 =B1 69%  perf-profile.self.cycles-pp=
.nr_iowait_cpu
      0.00            +0.3        0.26 =B1 15%  perf-profile.self.cycles-pp=
.tsc_verify_tsc_adjust
      0.37 =B1 15%      +0.3        0.64 =B1  7%  perf-profile.self.cycles-=
pp.lapic_next_deadline
      0.00            +0.4        0.38 =B1 18%  perf-profile.self.cycles-pp=
.cpuidle_idle_call
      0.16 =B1 16%      +0.4        0.54 =B1  6%  perf-profile.self.cycles-=
pp.read_tsc
      0.00            +0.4        0.42 =B1 37%  perf-profile.self.cycles-pp=
.tick_nohz_next_event
      0.00            +0.4        0.42 =B1 26%  perf-profile.self.cycles-pp=
.timekeeping_max_deferment
      0.09 =B1 12%      +0.6        0.64 =B1 45%  perf-profile.self.cycles-=
pp.idle_cpu
      0.00            +0.9        0.94 =B1 13%  perf-profile.self.cycles-pp=
.native_irq_return_iret
      0.00            +1.9        1.93 =B1 28%  perf-profile.self.cycles-pp=
.menu_select
      0.00            +2.5        2.48 =B1 16%  perf-profile.self.cycles-pp=
.cpuidle_enter_state
      0.00           +47.4       47.40 =B1  8%  perf-profile.self.cycles-pp=
.mwait_idle_with_hints




Disclaimer:
Results have been estimated based on internal Intel analysis and are provid=
ed
for informational purposes only. Any difference in system hardware or softw=
are
design or configuration may affect actual performance.


--=20
0-DAY CI Kernel Test Service
https://01.org/lkp


