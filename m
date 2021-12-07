Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851EF46B000
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhLGBsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:48:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:7245 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhLGBsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:48:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298251065"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="xz'?scan'208";a="298251065"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 17:44:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="xz'?scan'208";a="462104269"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 17:44:46 -0800
Date:   Tue, 7 Dec 2021 09:44:44 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [x86/signal]  3aac3ebea0:  will-it-scale.per_thread_ops -11.9%
 regression
Message-ID: <20211207014444.GB16074@xsang-OptiPlex-9020>
References: <20211207012128.GA16074@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207012128.GA16074@xsang-OptiPlex-9020>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

BTW, attached dmesg, and parent dmesg (dmesg-parent.xz) FYI

On Tue, Dec 07, 2021 at 09:21:28AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> (please be noted we made some further analysis before reporting out,
> and thought it's likely the regression is related with the extra spinlock
> introducded by enalbling DYNAMIC_SIGFRAME. below is the full report.)
> 
> FYI, we noticed a -11.9% regression of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: 3aac3ebea08f2d342364f827c8979ab0e1dd591e ("x86/signal: Implement sigaltstack size validation")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 144 threads 4 sockets Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> with following parameters:
> 
> 	nr_task: 16
> 	mode: thread
> 	test: signal1
> 	cpufreq_governor: performance
> 	ucode: 0x16
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -13.5% regression                       |
> | test machine     | 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory    |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=thread                                                                         |
> |                  | nr_task=16                                                                          |
> |                  | test=signal1                                                                        |
> |                  | ucode=0x7002302                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -12.8% regression                       |
> | test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory     |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=thread                                                                         |
> |                  | nr_task=16                                                                          |
> |                  | test=signal1                                                                        |
> |                  | ucode=0x5003006                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -10.2% regression                       |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=thread                                                                         |
> |                  | nr_task=16                                                                          |
> |                  | test=signal1                                                                        |
> |                  | ucode=0xd000280                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -11.9% regression                       |
> | test machine     | 144 threads 4 sockets Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory    |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | debug-setup=no-monitor                                                              |
> |                  | mode=thread                                                                         |
> |                  | nr_task=16                                                                          |
> |                  | test=signal1                                                                        |
> |                  | ucode=0x16                                                                          |
> +------------------+-------------------------------------------------------------------------------------+
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
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/thread/16/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/signal1/will-it-scale/0x16
> 
> commit: 
>   1bdda24c4a ("signal: Add an optional check for altstack size")
>   3aac3ebea0 ("x86/signal: Implement sigaltstack size validation")
> 
> 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     754824 ±  2%     -11.9%     664668 ±  2%  will-it-scale.16.threads
>      47176 ±  2%     -11.9%      41541 ±  2%  will-it-scale.per_thread_ops
>     754824 ±  2%     -11.9%     664668 ±  2%  will-it-scale.workload
>    1422782 ±  8%  +3.3e+05     1751520 ± 12%  syscalls.sys_getpid.noise.5%
>  1.583e+10            -2.1%   1.55e+10        perf-stat.i.instructions
>    6328594 ±  2%     +11.1%    7032338 ±  2%  perf-stat.overall.path-length
>  1.578e+10            -2.1%  1.545e+10        perf-stat.ps.instructions
>  4.774e+12            -2.2%  4.671e+12        perf-stat.total.instructions
>       0.00            +6.3        6.33 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn
>       0.00            +6.5        6.51 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
>       0.00            +6.6        6.58 ±  8%  perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +6.6        6.62 ±  8%  perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       0.00            +6.9        6.88 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       7.99 ± 12%      +6.0       14.00 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
>       0.05 ± 44%      +6.6        6.62 ±  8%  perf-profile.children.cycles-pp.restore_altstack
>       0.00            +6.6        6.58 ±  8%  perf-profile.children.cycles-pp.do_sigaltstack
> 
> 
> ***************************************************************************************************
> lkp-cpl-4sp1: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/thread/16/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/signal1/will-it-scale/0x7002302
> 
> commit: 
>   1bdda24c4a ("signal: Add an optional check for altstack size")
>   3aac3ebea0 ("x86/signal: Implement sigaltstack size validation")
> 
> 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     675380           -13.5%     584407        will-it-scale.16.threads
>      42210           -13.5%      36524        will-it-scale.per_thread_ops
>     675380           -13.5%     584407        will-it-scale.workload
>       0.15 ±  5%      -0.0        0.13 ±  3%  mpstat.cpu.all.usr%
>      63069 ± 94%    +215.0%     198665 ± 69%  numa-numastat.node2.local_node
>     124789 ± 47%    +101.2%     251132 ± 55%  numa-numastat.node2.numa_hit
>       4994 ±129%    +930.8%      51482 ±120%  numa-meminfo.node2.AnonPages
>       8822 ±104%    +546.6%      57051 ±103%  numa-meminfo.node2.Inactive
>       8822 ±104%    +546.6%      57051 ±103%  numa-meminfo.node2.Inactive(anon)
>       1248 ±129%    +930.8%      12868 ±120%  numa-vmstat.node2.nr_anon_pages
>       2205 ±104%    +546.6%      14260 ±102%  numa-vmstat.node2.nr_inactive_anon
>       2205 ±104%    +546.6%      14260 ±102%  numa-vmstat.node2.nr_zone_inactive_anon
>       6100 ±114%    +323.1%      25809 ± 49%  proc-vmstat.numa_pages_migrated
>      55034 ± 12%     +66.9%      91844 ± 28%  proc-vmstat.numa_pte_updates
>       6100 ±114%    +323.1%      25809 ± 49%  proc-vmstat.pgmigrate_success
>  1.244e+09 ±  2%      -6.6%  1.163e+09        perf-stat.i.branch-instructions
>  1.666e+09 ±  2%      -7.4%  1.543e+09 ±  2%  perf-stat.i.dTLB-loads
>   8.87e+08 ±  2%      -9.5%  8.031e+08        perf-stat.i.dTLB-stores
>    5723495            -9.7%    5166133 ±  2%  perf-stat.i.iTLB-load-misses
>  5.918e+09 ±  2%      -6.8%  5.513e+09 ±  2%  perf-stat.i.instructions
>      27.07 ±  2%      -9.3%      24.54        perf-stat.i.metric.M/sec
>    2636841            +7.7%    2840349 ±  2%  perf-stat.overall.path-length
>   1.24e+09 ±  2%      -6.6%  1.159e+09        perf-stat.ps.branch-instructions
>  1.661e+09 ±  2%      -7.4%  1.538e+09 ±  2%  perf-stat.ps.dTLB-loads
>   8.84e+08 ±  2%      -9.5%  8.004e+08        perf-stat.ps.dTLB-stores
>    5704350            -9.7%    5148701 ±  2%  perf-stat.ps.iTLB-load-misses
>  5.898e+09 ±  2%      -6.8%  5.494e+09 ±  2%  perf-stat.ps.instructions
>  1.781e+12 ±  2%      -6.8%   1.66e+12 ±  2%  perf-stat.total.instructions
>       0.00            +8.6        8.55 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn
>       0.00            +8.7        8.71 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
>       0.00            +8.8        8.77 ±  8%  perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +8.8        8.83 ±  8%  perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       0.31 ± 86%      +8.9        9.19 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       0.39 ±  5%      -0.0        0.34 ±  7%  perf-profile.children.cycles-pp.__dequeue_signal
>       0.24 ±  8%      -0.0        0.21 ±  9%  perf-profile.children.cycles-pp.__sigqueue_alloc
>       0.15 ±  7%      -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.inc_rlimit_ucounts
>      11.19 ±  9%      +7.3       18.49 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
>       0.07 ± 14%      +8.8        8.83 ±  8%  perf-profile.children.cycles-pp.restore_altstack
>       0.00            +8.8        8.77 ±  8%  perf-profile.children.cycles-pp.do_sigaltstack
>       0.23 ± 10%      -0.0        0.19 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.15 ±  7%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.inc_rlimit_ucounts
>       0.10 ± 13%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
> 
> 
> 
> ***************************************************************************************************
> lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/thread/16/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/signal1/will-it-scale/0x5003006
> 
> commit: 
>   1bdda24c4a ("signal: Add an optional check for altstack size")
>   3aac3ebea0 ("x86/signal: Implement sigaltstack size validation")
> 
> 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     644316 ±  2%     -12.8%     561880        will-it-scale.16.threads
>      40269 ±  2%     -12.8%      35117        will-it-scale.per_thread_ops
>     644316 ±  2%     -12.8%     561880        will-it-scale.workload
>       0.28            -0.0        0.24 ±  2%  mpstat.cpu.all.usr%
>       1453 ±  6%    +109.8%       3049 ±113%  interrupts.CPU5.CAL:Function_call_interrupts
>     605222           -23.8%     461290 ± 29%  interrupts.CPU82.LOC:Local_timer_interrupts
>      15.18 ± 12%     +23.5%      18.74 ± 11%  perf-stat.i.MPKI
>   1.64e+09            -5.4%  1.551e+09        perf-stat.i.branch-instructions
>       6.29            +6.7%       6.71        perf-stat.i.cpi
>  2.009e+09            -6.3%  1.883e+09        perf-stat.i.dTLB-loads
>  7.932e+08 ±  2%     -10.8%  7.078e+08        perf-stat.i.dTLB-stores
>    5140324           -12.9%    4475639        perf-stat.i.iTLB-load-misses
>  7.391e+09            -5.9%  6.952e+09        perf-stat.i.instructions
>       1443            +8.0%       1558        perf-stat.i.instructions-per-iTLB-miss
>       0.16            -6.2%       0.15        perf-stat.i.ipc
>      51.74            -6.2%      48.53        perf-stat.i.metric.M/sec
>      15.11 ± 12%     +23.3%      18.63 ± 11%  perf-stat.overall.MPKI
>       6.25            +6.6%       6.67        perf-stat.overall.cpi
>       1437            +8.1%       1553        perf-stat.overall.instructions-per-iTLB-miss
>       0.16            -6.2%       0.15        perf-stat.overall.ipc
>    3451539            +7.8%    3720150        perf-stat.overall.path-length
>  1.634e+09            -5.4%  1.546e+09        perf-stat.ps.branch-instructions
>  2.002e+09            -6.3%  1.876e+09        perf-stat.ps.dTLB-loads
>  7.905e+08 ±  2%     -10.8%  7.053e+08        perf-stat.ps.dTLB-stores
>    5123258           -12.9%    4460593        perf-stat.ps.iTLB-load-misses
>  7.366e+09            -5.9%  6.928e+09        perf-stat.ps.instructions
>  2.223e+12            -6.0%   2.09e+12        perf-stat.total.instructions
>      23.41            -4.4       18.99 ±  9%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      22.62            -4.2       18.44 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      22.34            -4.1       18.20 ± 10%  perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      22.31            -4.1       18.18 ±  9%  perf-profile.calltrace.cycles-pp.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      21.51            -4.0       17.52 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64
>      21.03            -3.8       17.21 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask
>      12.26            -2.3        9.95 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      11.59 ±  2%      -2.3        9.29 ±  9%  perf-profile.calltrace.cycles-pp.__restore_rt
>      12.21            -2.3        9.92 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      11.53 ±  2%      -2.3        9.25 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__restore_rt
>      11.50 ±  2%      -2.3        9.23 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
>      11.52 ±  2%      -2.3        9.24 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
>      11.25 ±  2%      -2.2        9.03 ±  9%  perf-profile.calltrace.cycles-pp.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
>      11.70 ±  2%      -2.2        9.48 ±  9%  perf-profile.calltrace.cycles-pp.handler
>      11.79 ±  2%      -2.2        9.60 ± 10%  perf-profile.calltrace.cycles-pp.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      11.79 ±  2%      -2.2        9.60 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      11.74 ±  2%      -2.2        9.55 ± 10%  perf-profile.calltrace.cycles-pp.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      10.86 ±  2%      -2.2        8.70 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      11.26 ±  2%      -2.1        9.13 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.handler
>      11.26 ±  2%      -2.1        9.13 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>      11.25 ±  2%      -2.1        9.12 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>      11.25 ±  2%      -2.1        9.12 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>      11.35 ±  2%      -2.1        9.22 ± 10%  perf-profile.calltrace.cycles-pp.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64
>      11.38            -2.1        9.26 ±  9%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      10.63 ±  2%      -2.1        8.52 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64
>      11.03 ±  2%      -2.1        8.94 ±  9%  perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      11.01 ±  2%      -2.1        8.92 ±  9%  perf-profile.calltrace.cycles-pp.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>      10.80            -2.0        8.78 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>      10.61 ±  2%      -2.0        8.60 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare
>      10.64 ±  2%      -2.0        8.66 ± 10%  perf-profile.calltrace.cycles-pp.__lock_task_sighand.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill
>      10.63 ±  2%      -2.0        8.65 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific.do_tkill
>      10.40            -2.0        8.43 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart
>      10.60            -2.0        8.63 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
>      10.40 ±  2%      -1.9        8.48 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific
>       0.64 ±  3%      -0.2        0.39 ± 63%  perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       0.66 ±  4%      -0.2        0.42 ± 63%  perf-profile.calltrace.cycles-pp.__set_task_blocked.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64
>       0.65 ±  4%      -0.2        0.41 ± 63%  perf-profile.calltrace.cycles-pp.recalc_sigpending.__set_task_blocked.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask
>       0.76 ±  4%      -0.2        0.54 ± 42%  perf-profile.calltrace.cycles-pp.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.00            +8.6        8.56 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn
>       0.59 ±  3%      +8.7        9.29 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       0.00            +8.7        8.75 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
>       0.00            +8.8        8.80 ±  9%  perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +8.9        8.87 ±  9%  perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      44.60            -8.5       36.15 ±  9%  perf-profile.children.cycles-pp.__set_current_blocked
>      23.53            -4.4       19.09 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>      23.47            -4.4       19.05 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      23.41            -4.4       19.00 ±  9%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>      22.62            -4.2       18.45 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
>      22.34            -4.1       18.20 ±  9%  perf-profile.children.cycles-pp.sigprocmask
>      11.63 ±  2%      -2.3        9.33 ±  9%  perf-profile.children.cycles-pp.__restore_rt
>      11.73 ±  2%      -2.2        9.50 ±  9%  perf-profile.children.cycles-pp.handler
>      11.79 ±  2%      -2.2        9.60 ± 10%  perf-profile.children.cycles-pp.do_tkill
>      11.80 ±  2%      -2.2        9.60 ± 10%  perf-profile.children.cycles-pp.__x64_sys_tgkill
>      11.74 ±  2%      -2.2        9.55 ± 10%  perf-profile.children.cycles-pp.do_send_specific
>      11.35 ±  2%      -2.1        9.22 ± 10%  perf-profile.children.cycles-pp.do_send_sig_info
>      11.39            -2.1        9.26 ±  9%  perf-profile.children.cycles-pp.get_signal
>      11.03 ±  2%      -2.1        8.94 ±  9%  perf-profile.children.cycles-pp.signal_setup_done
>      10.66 ±  2%      -2.0        8.67 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>      10.64 ±  2%      -2.0        8.66 ± 10%  perf-profile.children.cycles-pp.__lock_task_sighand
>       1.32 ±  4%      -0.2        1.10 ± 11%  perf-profile.children.cycles-pp.recalc_sigpending
>       1.32 ±  4%      -0.2        1.10 ± 11%  perf-profile.children.cycles-pp.__set_task_blocked
>       0.76 ±  4%      -0.2        0.61 ± 12%  perf-profile.children.cycles-pp.__setup_rt_frame
>       0.65 ±  3%      -0.1        0.53 ± 11%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
>       0.63 ±  3%      -0.1        0.51 ± 10%  perf-profile.children.cycles-pp.restore_sigcontext
>       0.59 ±  2%      -0.1        0.48 ± 10%  perf-profile.children.cycles-pp.__send_signal
>       0.42 ±  4%      -0.1        0.33 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.49 ±  3%      -0.1        0.40 ± 11%  perf-profile.children.cycles-pp.fpu__restore_sig
>       0.45 ±  5%      -0.1        0.36 ± 11%  perf-profile.children.cycles-pp.dequeue_signal
>       0.49 ±  3%      -0.1        0.40 ± 11%  perf-profile.children.cycles-pp.__fpu_restore_sig
>       0.41 ±  5%      -0.1        0.33 ± 11%  perf-profile.children.cycles-pp.__dequeue_signal
>       0.33 ±  6%      -0.1        0.26 ± 12%  perf-profile.children.cycles-pp.__sigqueue_free
>       0.34 ±  3%      -0.1        0.27 ±  9%  perf-profile.children.cycles-pp._copy_from_user
>       0.34 ±  4%      -0.1        0.27 ± 13%  perf-profile.children.cycles-pp.recalc_sigpending_tsk
>       0.32 ±  6%      -0.1        0.26 ± 12%  perf-profile.children.cycles-pp.dec_rlimit_ucounts
>       0.27 ±  6%      -0.1        0.21 ± 14%  perf-profile.children.cycles-pp.__sigqueue_alloc
>       0.29 ±  6%      -0.1        0.24 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.17 ±  7%      -0.0        0.14 ± 11%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       0.19 ±  4%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       0.25 ±  4%      -0.0        0.22 ±  8%  perf-profile.children.cycles-pp.security_task_kill
>       0.20 ±  5%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.fpu__clear_user_states
>       0.24 ±  4%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.apparmor_task_kill
>      12.10 ±  2%      +6.4       18.52 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
>       0.08 ± 10%      +8.8        8.87 ±  9%  perf-profile.children.cycles-pp.restore_altstack
>       0.00            +8.8        8.81 ±  9%  perf-profile.children.cycles-pp.do_sigaltstack
>       0.99 ±  4%      -0.2        0.83 ± 10%  perf-profile.self.cycles-pp.recalc_sigpending
>       1.13 ±  2%      -0.1        1.00 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.42 ±  4%      -0.1        0.33 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.40 ±  3%      -0.1        0.32 ± 11%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
>       0.34 ±  4%      -0.1        0.27 ± 12%  perf-profile.self.cycles-pp.recalc_sigpending_tsk
>       0.31 ±  3%      -0.1        0.25 ±  9%  perf-profile.self.cycles-pp.__send_signal
>       0.32 ±  6%      -0.1        0.26 ± 12%  perf-profile.self.cycles-pp.dec_rlimit_ucounts
>       0.25 ±  5%      -0.1        0.20 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.31 ±  3%      -0.1        0.25 ± 12%  perf-profile.self.cycles-pp.__fpu_restore_sig
>       0.29 ±  6%      -0.1        0.23 ± 13%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.17 ±  6%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       0.18 ±  4%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>       0.16 ±  3%      -0.0        0.13 ± 12%  perf-profile.self.cycles-pp.fpu__clear_user_states
>       0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__set_current_blocked
>       0.12 ±  9%      +0.1        0.25 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
> 
> 
> 
> ***************************************************************************************************
> lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/thread/16/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp6/signal1/will-it-scale/0xd000280
> 
> commit: 
>   1bdda24c4a ("signal: Add an optional check for altstack size")
>   3aac3ebea0 ("x86/signal: Implement sigaltstack size validation")
> 
> 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     980404 ±  3%     -10.2%     880436 ±  2%  will-it-scale.16.threads
>      61274 ±  3%     -10.2%      55027 ±  2%  will-it-scale.per_thread_ops
>     980404 ±  3%     -10.2%     880436 ±  2%  will-it-scale.workload
>    9745749 ± 18%     +26.8%   12356608 ±  4%  meminfo.DirectMap2M
>       0.19 ±  3%      -0.0        0.17        mpstat.cpu.all.usr%
>     678.67 ±102%    +162.5%       1781        numa-meminfo.node0.Mlocked
>     169.33 ±102%    +162.8%     445.00        numa-vmstat.node0.nr_mlock
>      14980 ± 24%     +32.1%      19788 ± 15%  softirqs.CPU10.SCHED
>      22443 ± 26%     -31.6%      15357 ± 11%  softirqs.CPU3.SCHED
>      22798 ±  8%     +25.2%      28542 ±  9%  softirqs.CPU70.SCHED
>       1027 ±  8%      +9.1%       1120 ±  5%  slabinfo.file_lock_cache.active_objs
>       1027 ±  8%      +9.1%       1120 ±  5%  slabinfo.file_lock_cache.num_objs
>       2206 ±  5%      +9.2%       2410 ±  4%  slabinfo.khugepaged_mm_slot.active_objs
>       2206 ±  5%      +9.2%       2410 ±  4%  slabinfo.khugepaged_mm_slot.num_objs
>      71217 ±  3%      -9.3%      64617 ±  4%  slabinfo.vm_area_struct.active_objs
>       1782 ±  3%      -9.1%       1620 ±  4%  slabinfo.vm_area_struct.active_slabs
>      71334 ±  3%      -9.1%      64821 ±  4%  slabinfo.vm_area_struct.num_objs
>       1782 ±  3%      -9.1%       1620 ±  4%  slabinfo.vm_area_struct.num_slabs
>  2.198e+09            -4.3%  2.103e+09        perf-stat.i.branch-instructions
>       5.71            +3.4%       5.90        perf-stat.i.cpi
>   2.75e+09            -4.8%  2.619e+09        perf-stat.i.dTLB-loads
>  1.002e+10            -4.6%  9.559e+09        perf-stat.i.instructions
>      33163 ± 14%     +26.0%      41783 ±  6%  perf-stat.i.node-stores
>       5.68            +3.3%       5.87        perf-stat.overall.cpi
>    3079620 ±  2%      +6.3%    3272934        perf-stat.overall.path-length
>  2.191e+09            -4.3%  2.096e+09        perf-stat.ps.branch-instructions
>  2.741e+09            -4.8%   2.61e+09        perf-stat.ps.dTLB-loads
>  9.988e+09            -4.6%  9.526e+09        perf-stat.ps.instructions
>      33002 ± 14%     +25.9%      41562 ±  6%  perf-stat.ps.node-stores
>  3.017e+12            -4.5%   2.88e+12        perf-stat.total.instructions
>       0.33 ±223%  +54200.0%     181.00 ±133%  interrupts.153:PCI-MSI.12058647-edge.i40e-eth0-TxRx-22
>     706.83 ±  8%     -36.5%     449.00 ± 18%  interrupts.CPU127.NMI:Non-maskable_interrupts
>     706.83 ±  8%     -36.5%     449.00 ± 18%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
>     366.17 ± 11%     -18.9%     297.00 ± 15%  interrupts.CPU14.TLB:TLB_shootdowns
>     255.83 ± 21%     -33.2%     171.00 ± 14%  interrupts.CPU16.NMI:Non-maskable_interrupts
>     255.83 ± 21%     -33.2%     171.00 ± 14%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
>     445.17 ± 16%     +53.4%     682.75 ± 34%  interrupts.CPU2.CAL:Function_call_interrupts
>      13115 ± 43%     -98.8%     163.75 ± 16%  interrupts.CPU2.NMI:Non-maskable_interrupts
>      13115 ± 43%     -98.8%     163.75 ± 16%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>       0.17 ±223%  +1.1e+05%     180.50 ±133%  interrupts.CPU22.153:PCI-MSI.12058647-edge.i40e-eth0-TxRx-22
>     439.17 ± 17%     +24.2%     545.50 ±  8%  interrupts.CPU5.CAL:Function_call_interrupts
>     262.17 ± 20%     +51.6%     397.50 ± 15%  interrupts.CPU6.TLB:TLB_shootdowns
>       2824 ±213%    +251.7%       9935 ± 67%  interrupts.CPU65.NMI:Non-maskable_interrupts
>       2824 ±213%    +251.7%       9935 ± 67%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
>       2624 ±149%    +525.3%      16413        interrupts.CPU66.NMI:Non-maskable_interrupts
>       2624 ±149%    +525.3%      16413        interrupts.CPU66.PMI:Performance_monitoring_interrupts
>     150.33 ± 26%     +52.7%     229.50 ± 19%  interrupts.CPU78.TLB:TLB_shootdowns
>     216.83 ± 19%     -29.1%     153.75 ±  7%  interrupts.CPU85.NMI:Non-maskable_interrupts
>     216.83 ± 19%     -29.1%     153.75 ±  7%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
>     196.00 ± 13%    +847.6%       1857 ±144%  interrupts.CPU87.CAL:Function_call_interrupts
>      28.72            -3.7       25.02        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      28.25            -3.7       24.57        perf-profile.calltrace.cycles-pp.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      28.27            -3.7       24.59        perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      29.98            -3.6       26.39        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      27.65            -3.6       24.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64
>      26.88            -3.5       23.41        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask
>      14.84            -2.4       12.46        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
>      14.94            -2.4       12.56        perf-profile.calltrace.cycles-pp.__restore_rt
>      14.85            -2.4       12.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__restore_rt
>      14.81            -2.4       12.43        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
>      14.34            -2.3       12.02        perf-profile.calltrace.cycles-pp.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
>      14.06            -2.3       11.77        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      13.61            -2.2       11.41        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64
>      15.40 ±  2%      -2.1       13.35        perf-profile.calltrace.cycles-pp.handler
>      15.57            -1.8       13.75        perf-profile.calltrace.cycles-pp.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      15.56            -1.8       13.74        perf-profile.calltrace.cycles-pp.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      14.63            -1.8       12.81        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.handler
>      14.63            -1.8       12.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>      14.62            -1.8       12.80        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>      14.62            -1.8       12.80        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>      15.46            -1.8       13.64        perf-profile.calltrace.cycles-pp.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      14.26            -1.8       12.48        perf-profile.calltrace.cycles-pp.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>      14.28            -1.8       12.50        perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      15.55            -1.8       13.77        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      15.47            -1.8       13.70        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      14.80            -1.8       13.04        perf-profile.calltrace.cycles-pp.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64
>      13.97            -1.7       12.23        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare
>      13.56            -1.7       11.87        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart
>      14.39            -1.7       12.72        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      13.91            -1.7       12.26        perf-profile.calltrace.cycles-pp.__lock_task_sighand.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill
>      13.90            -1.6       12.25        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific.do_tkill
>      13.48            -1.6       11.85        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific
>      13.80            -1.6       12.18        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>      13.55            -1.6       11.96        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
>       0.74 ±  3%      -0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__send_signal.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill
>      61.68            +5.1       66.82        perf-profile.calltrace.cycles-pp.raise
>      60.97            +5.2       66.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      61.08            +5.2       66.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.raise
>       0.00           +12.1       12.06        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn
>       0.90 ±  5%     +12.4       13.32        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       0.00           +12.4       12.43        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
>       0.00           +12.5       12.50        perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00           +12.6       12.63        perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      56.89            -7.8       49.10        perf-profile.children.cycles-pp.__set_current_blocked
>      28.31            -3.7       24.62        perf-profile.children.cycles-pp.sigprocmask
>      28.74            -3.6       25.10        perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
>      30.21            -3.6       26.61        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>      30.10            -3.6       26.52        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      29.98            -3.6       26.40        perf-profile.children.cycles-pp.arch_do_signal_or_restart
>      15.02            -2.4       12.62        perf-profile.children.cycles-pp.__restore_rt
>      15.29            -1.9       13.40        perf-profile.children.cycles-pp.handler
>      15.58            -1.8       13.75        perf-profile.children.cycles-pp.__x64_sys_tgkill
>      15.57            -1.8       13.74        perf-profile.children.cycles-pp.do_tkill
>      15.47            -1.8       13.66        perf-profile.children.cycles-pp.do_send_specific
>      14.28            -1.8       12.50        perf-profile.children.cycles-pp.signal_setup_done
>      14.82            -1.8       13.05        perf-profile.children.cycles-pp.do_send_sig_info
>      14.40            -1.7       12.73        perf-profile.children.cycles-pp.get_signal
>      13.96            -1.7       12.30        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>      13.92            -1.7       12.27        perf-profile.children.cycles-pp.__lock_task_sighand
>       1.02 ±  4%      -0.1        0.91 ±  3%  perf-profile.children.cycles-pp.restore_sigcontext
>       0.74 ±  3%      -0.1        0.65 ±  2%  perf-profile.children.cycles-pp.__send_signal
>       0.46            -0.0        0.40        perf-profile.children.cycles-pp.dequeue_signal
>       0.40 ±  5%      -0.0        0.35 ±  6%  perf-profile.children.cycles-pp.__sigqueue_alloc
>       0.23 ±  9%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.recalc_sigpending_tsk
>       0.39 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.__dequeue_signal
>       0.29 ±  6%      -0.0        0.26        perf-profile.children.cycles-pp.fpu__clear_user_states
>       0.42 ±  2%      -0.0        0.39 ±  3%  perf-profile.children.cycles-pp.apparmor_task_kill
>       0.44            -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.security_task_kill
>       0.24 ±  7%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__might_fault
>       0.12 ±  7%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp._copy_to_user
>       0.22 ±  4%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__sigqueue_free
>       0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.find_task_by_vpid
>       0.22 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.aa_get_task_label
>       0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__radix_tree_lookup
>       0.09 ±  8%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>      69.51            +3.2       72.74        perf-profile.children.cycles-pp._raw_spin_lock_irq
>      62.03            +5.1       67.12        perf-profile.children.cycles-pp.raise
>      15.72           +10.0       25.76        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
>       0.15 ±  3%     +12.5       12.64        perf-profile.children.cycles-pp.restore_altstack
>       0.00           +12.5       12.51        perf-profile.children.cycles-pp.do_sigaltstack
>       0.31 ±  3%      -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.__send_signal
>       0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__radix_tree_lookup
>       0.06 ± 13%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__x64_sys_rt_sigprocmask
>       1.90 ±  3%      +0.1        2.02        perf-profile.self.cycles-pp._raw_spin_lock_irq
> 
> 
> 
> ***************************************************************************************************
> lkp-hsw-4ex1: 144 threads 4 sockets Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> =========================================================================================
> compiler/cpufreq_governor/debug-setup/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/no-monitor/x86_64-rhel-8.3/thread/16/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/signal1/will-it-scale/0x16
> 
> commit: 
>   1bdda24c4a ("signal: Add an optional check for altstack size")
>   3aac3ebea0 ("x86/signal: Implement sigaltstack size validation")
> 
> 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     779005 ±  2%     -11.9%     686435 ±  2%  will-it-scale.16.threads
>      48687 ±  2%     -11.9%      42901 ±  2%  will-it-scale.per_thread_ops
>     779005 ±  2%     -11.9%     686435 ±  2%  will-it-scale.workload
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 5.15.0-rc5 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23502
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23502
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_IRQ_MSI_IOMMU=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> CONFIG_CONTEXT_TRACKING=y
> # CONFIG_CONTEXT_TRACKING_FORCE is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> CONFIG_BPF_JIT_ALWAYS_ON=y
> CONFIG_BPF_JIT_DEFAULT_ON=y
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> # CONFIG_BPF_PRELOAD is not set
> # CONFIG_BPF_LSM is not set
> # end of BPF subsystem
> 
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_SCHED_CORE is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # end of RCU Subsystem
> 
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_SWAP=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> CONFIG_RT_GROUP_SCHED=y
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLAB_FREELIST_RANDOM=y
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=1024
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_HAVE_INTEL_TXT=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_X2APIC=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=y
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=y
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=y
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=y
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> # CONFIG_GART_IOMMU is not set
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> CONFIG_X86_MCE_THRESHOLD=y
> CONFIG_X86_MCE_INJECT=m
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=m
> CONFIG_PERF_EVENTS_INTEL_RAPL=m
> CONFIG_PERF_EVENTS_INTEL_CSTATE=m
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_PERF_EVENTS_AMD_UNCORE=y
> # end of Performance monitoring
> 
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_I8K=m
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_5LEVEL=y
> CONFIG_X86_DIRECT_GBPAGES=y
> # CONFIG_X86_CPA_STATISTICS is not set
> # CONFIG_AMD_MEM_ENCRYPT is not set
> CONFIG_NUMA=y
> # CONFIG_AMD_NUMA is not set
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NUMA_EMU=y
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=m
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_X86_SGX is not set
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_EFI_MIXED=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> # CONFIG_KEXEC_SIG is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_HOTPLUG_CPU=y
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_LIVEPATCH=y
> # end of Processor type and features
> 
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> CONFIG_ACPI_EC_DEBUGFS=m
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_TAD=m
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_PLATFORM_PROFILE=m
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=m
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_ACPI_BGRT=y
> CONFIG_ACPI_NFIT=m
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=y
> # CONFIG_ACPI_HMAT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_PCIEAER=y
> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> CONFIG_ACPI_APEI_EINJ=m
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> # CONFIG_ACPI_DPTF is not set
> CONFIG_ACPI_WATCHDOG=y
> CONFIG_ACPI_EXTLOG=m
> CONFIG_ACPI_ADXL=y
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_PMIC_OPREGION=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_ACPI_PRMT=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> # CONFIG_X86_PCC_CPUFREQ is not set
> CONFIG_X86_ACPI_CPUFREQ=m
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> CONFIG_X86_POWERNOW_K8=m
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=m
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=m
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_HAVE_KVM_NO_POLL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_HAVE_KVM_PM_NOTIFIER=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=m
> CONFIG_KVM_INTEL=m
> # CONFIG_KVM_AMD is not set
> # CONFIG_KVM_XEN is not set
> CONFIG_KVM_MMU_AUDIT=y
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=y
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> CONFIG_MODULE_SIG_SHA256=y
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH="sha256"
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=m
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_DEV_THROTTLING=y
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> CONFIG_BLK_WBT=y
> CONFIG_BLK_WBT_MQ=y
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=y
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=y
> CONFIG_KARMA_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> # end of Partition Types
> 
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> CONFIG_BLOCK_HOLDER_DEPRECATED=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=y
> CONFIG_BFQ_GROUP_IOSCHED=y
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
> 
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_NUMA_KEEP_MEMINFO=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG_SPARSE=y
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_MHP_MEMMAP_ON_MEMORY=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> CONFIG_HWPOISON_INJECT=m
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> CONFIG_CLEANCACHE=y
> CONFIG_FRONTSWAP=y
> # CONFIG_CMA is not set
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=y
> CONFIG_ZSMALLOC_STAT=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ZONE_DMA=y
> CONFIG_ZONE_DMA32=y
> CONFIG_ZONE_DEVICE=y
> CONFIG_DEV_PAGEMAP_OPS=y
> CONFIG_DEVICE_PRIVATE=y
> CONFIG_VMAP_PFN=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_SECRETMEM=y
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> CONFIG_UNIX_DIAG=m
> CONFIG_TLS=m
> CONFIG_TLS_DEVICE=y
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_OFFLOAD=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=y
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> CONFIG_XFRM_SUB_POLICY=y
> CONFIG_XFRM_MIGRATE=y
> CONFIG_XFRM_STATISTICS=y
> CONFIG_XFRM_AH=m
> CONFIG_XFRM_ESP=m
> CONFIG_XFRM_IPCOMP=m
> CONFIG_NET_KEY=m
> CONFIG_NET_KEY_MIGRATE=y
> CONFIG_XDP_SOCKETS=y
> # CONFIG_XDP_SOCKETS_DIAG is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_FIB_TRIE_STATS=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE_DEMUX=m
> CONFIG_NET_IP_TUNNEL=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> CONFIG_NET_IPVTI=m
> CONFIG_NET_UDP_TUNNEL=m
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_ESP_OFFLOAD=m
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=m
> CONFIG_INET_DIAG=m
> CONFIG_INET_TCP_DIAG=m
> CONFIG_INET_UDP_DIAG=m
> CONFIG_INET_RAW_DIAG=m
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=y
> CONFIG_TCP_CONG_BIC=m
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_TCP_CONG_WESTWOOD=m
> CONFIG_TCP_CONG_HTCP=m
> CONFIG_TCP_CONG_HSTCP=m
> CONFIG_TCP_CONG_HYBLA=m
> CONFIG_TCP_CONG_VEGAS=m
> CONFIG_TCP_CONG_NV=m
> CONFIG_TCP_CONG_SCALABLE=m
> CONFIG_TCP_CONG_LP=m
> CONFIG_TCP_CONG_VENO=m
> CONFIG_TCP_CONG_YEAH=m
> CONFIG_TCP_CONG_ILLINOIS=m
> CONFIG_TCP_CONG_DCTCP=m
> # CONFIG_TCP_CONG_CDG is not set
> CONFIG_TCP_CONG_BBR=m
> CONFIG_DEFAULT_CUBIC=y
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_TCP_MD5SIG=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> CONFIG_IPV6_ROUTE_INFO=y
> CONFIG_IPV6_OPTIMISTIC_DAD=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_ESP_OFFLOAD=m
> # CONFIG_INET6_ESPINTCP is not set
> CONFIG_INET6_IPCOMP=m
> CONFIG_IPV6_MIP6=m
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=m
> CONFIG_INET6_TUNNEL=m
> CONFIG_IPV6_VTI=m
> CONFIG_IPV6_SIT=m
> CONFIG_IPV6_SIT_6RD=y
> CONFIG_IPV6_NDISC_NODETYPE=y
> CONFIG_IPV6_TUNNEL=m
> CONFIG_IPV6_GRE=m
> CONFIG_IPV6_MULTIPLE_TABLES=y
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IPV6_PIMSM_V2=y
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=y
> # CONFIG_MPTCP is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=m
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_FAMILY_BRIDGE=y
> CONFIG_NETFILTER_FAMILY_ARP=y
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> CONFIG_NETFILTER_NETLINK_OSF=m
> CONFIG_NF_CONNTRACK=m
> CONFIG_NF_LOG_SYSLOG=m
> CONFIG_NETFILTER_CONNCOUNT=m
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_SECMARK=y
> CONFIG_NF_CONNTRACK_ZONES=y
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> CONFIG_NF_CONNTRACK_TIMEOUT=y
> CONFIG_NF_CONNTRACK_TIMESTAMP=y
> CONFIG_NF_CONNTRACK_LABELS=y
> CONFIG_NF_CT_PROTO_DCCP=y
> CONFIG_NF_CT_PROTO_GRE=y
> CONFIG_NF_CT_PROTO_SCTP=y
> CONFIG_NF_CT_PROTO_UDPLITE=y
> CONFIG_NF_CONNTRACK_AMANDA=m
> CONFIG_NF_CONNTRACK_FTP=m
> CONFIG_NF_CONNTRACK_H323=m
> CONFIG_NF_CONNTRACK_IRC=m
> CONFIG_NF_CONNTRACK_BROADCAST=m
> CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> CONFIG_NF_CONNTRACK_SNMP=m
> CONFIG_NF_CONNTRACK_PPTP=m
> CONFIG_NF_CONNTRACK_SANE=m
> CONFIG_NF_CONNTRACK_SIP=m
> CONFIG_NF_CONNTRACK_TFTP=m
> CONFIG_NF_CT_NETLINK=m
> CONFIG_NF_CT_NETLINK_TIMEOUT=m
> CONFIG_NF_CT_NETLINK_HELPER=m
> CONFIG_NETFILTER_NETLINK_GLUE_CT=y
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_AMANDA=m
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_SIP=m
> CONFIG_NF_NAT_TFTP=m
> CONFIG_NF_NAT_REDIRECT=y
> CONFIG_NF_NAT_MASQUERADE=y
> CONFIG_NETFILTER_SYNPROXY=m
> CONFIG_NF_TABLES=m
> CONFIG_NF_TABLES_INET=y
> CONFIG_NF_TABLES_NETDEV=y
> CONFIG_NFT_NUMGEN=m
> CONFIG_NFT_CT=m
> CONFIG_NFT_COUNTER=m
> CONFIG_NFT_CONNLIMIT=m
> CONFIG_NFT_LOG=m
> CONFIG_NFT_LIMIT=m
> CONFIG_NFT_MASQ=m
> CONFIG_NFT_REDIR=m
> CONFIG_NFT_NAT=m
> # CONFIG_NFT_TUNNEL is not set
> CONFIG_NFT_OBJREF=m
> CONFIG_NFT_QUEUE=m
> CONFIG_NFT_QUOTA=m
> CONFIG_NFT_REJECT=m
> CONFIG_NFT_REJECT_INET=m
> CONFIG_NFT_COMPAT=m
> CONFIG_NFT_HASH=m
> CONFIG_NFT_FIB=m
> CONFIG_NFT_FIB_INET=m
> # CONFIG_NFT_XFRM is not set
> CONFIG_NFT_SOCKET=m
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> # CONFIG_NFT_SYNPROXY is not set
> CONFIG_NF_DUP_NETDEV=m
> CONFIG_NFT_DUP_NETDEV=m
> CONFIG_NFT_FWD_NETDEV=m
> CONFIG_NFT_FIB_NETDEV=m
> # CONFIG_NFT_REJECT_NETDEV is not set
> # CONFIG_NF_FLOW_TABLE is not set
> CONFIG_NETFILTER_XTABLES=y
> CONFIG_NETFILTER_XTABLES_COMPAT=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=m
> CONFIG_NETFILTER_XT_CONNMARK=m
> CONFIG_NETFILTER_XT_SET=m
> 
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=m
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
> CONFIG_NETFILTER_XT_TARGET_CT=m
> CONFIG_NETFILTER_XT_TARGET_DSCP=m
> CONFIG_NETFILTER_XT_TARGET_HL=m
> CONFIG_NETFILTER_XT_TARGET_HMARK=m
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> CONFIG_NETFILTER_XT_TARGET_LOG=m
> CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NETFILTER_XT_NAT=m
> CONFIG_NETFILTER_XT_TARGET_NETMAP=m
> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
> CONFIG_NETFILTER_XT_TARGET_RATEEST=m
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> CONFIG_NETFILTER_XT_TARGET_TEE=m
> CONFIG_NETFILTER_XT_TARGET_TPROXY=m
> CONFIG_NETFILTER_XT_TARGET_TRACE=m
> CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> CONFIG_NETFILTER_XT_MATCH_BPF=m
> CONFIG_NETFILTER_XT_MATCH_CGROUP=m
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> CONFIG_NETFILTER_XT_MATCH_CPU=m
> CONFIG_NETFILTER_XT_MATCH_DCCP=m
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
> CONFIG_NETFILTER_XT_MATCH_DSCP=m
> CONFIG_NETFILTER_XT_MATCH_ECN=m
> CONFIG_NETFILTER_XT_MATCH_ESP=m
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_HELPER=m
> CONFIG_NETFILTER_XT_MATCH_HL=m
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> CONFIG_NETFILTER_XT_MATCH_IPVS=m
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> CONFIG_NETFILTER_XT_MATCH_MAC=m
> CONFIG_NETFILTER_XT_MATCH_MARK=m
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=m
> CONFIG_NETFILTER_XT_MATCH_OWNER=m
> CONFIG_NETFILTER_XT_MATCH_POLICY=m
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
> CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> CONFIG_NETFILTER_XT_MATCH_RATEEST=m
> CONFIG_NETFILTER_XT_MATCH_REALM=m
> CONFIG_NETFILTER_XT_MATCH_RECENT=m
> CONFIG_NETFILTER_XT_MATCH_SCTP=m
> CONFIG_NETFILTER_XT_MATCH_SOCKET=m
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> CONFIG_NETFILTER_XT_MATCH_STRING=m
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
> 
> CONFIG_IP_SET=m
> CONFIG_IP_SET_MAX=256
> CONFIG_IP_SET_BITMAP_IP=m
> CONFIG_IP_SET_BITMAP_IPMAC=m
> CONFIG_IP_SET_BITMAP_PORT=m
> CONFIG_IP_SET_HASH_IP=m
> CONFIG_IP_SET_HASH_IPMARK=m
> CONFIG_IP_SET_HASH_IPPORT=m
> CONFIG_IP_SET_HASH_IPPORTIP=m
> CONFIG_IP_SET_HASH_IPPORTNET=m
> CONFIG_IP_SET_HASH_IPMAC=m
> CONFIG_IP_SET_HASH_MAC=m
> CONFIG_IP_SET_HASH_NETPORTNET=m
> CONFIG_IP_SET_HASH_NET=m
> CONFIG_IP_SET_HASH_NETNET=m
> CONFIG_IP_SET_HASH_NETPORT=m
> CONFIG_IP_SET_HASH_NETIFACE=m
> CONFIG_IP_SET_LIST_SET=m
> CONFIG_IP_VS=m
> CONFIG_IP_VS_IPV6=y
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_AH_ESP=y
> CONFIG_IP_VS_PROTO_ESP=y
> CONFIG_IP_VS_PROTO_AH=y
> CONFIG_IP_VS_PROTO_SCTP=y
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_FO=m
> CONFIG_IP_VS_OVF=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> # CONFIG_IP_VS_MH is not set
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
> # CONFIG_IP_VS_TWOS is not set
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=12
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=m
> CONFIG_IP_VS_NFCT=y
> CONFIG_IP_VS_PE_SIP=m
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=m
> CONFIG_NF_SOCKET_IPV4=m
> CONFIG_NF_TPROXY_IPV4=m
> CONFIG_NF_TABLES_IPV4=y
> CONFIG_NFT_REJECT_IPV4=m
> CONFIG_NFT_DUP_IPV4=m
> CONFIG_NFT_FIB_IPV4=m
> CONFIG_NF_TABLES_ARP=y
> CONFIG_NF_DUP_IPV4=m
> CONFIG_NF_LOG_ARP=m
> CONFIG_NF_LOG_IPV4=m
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_NF_NAT_SNMP_BASIC=m
> CONFIG_NF_NAT_PPTP=m
> CONFIG_NF_NAT_H323=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_AH=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_RPFILTER=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_SYNPROXY=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_MANGLE=m
> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_TTL=m
> CONFIG_IP_NF_RAW=m
> CONFIG_IP_NF_SECURITY=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=m
> CONFIG_NF_TPROXY_IPV6=m
> CONFIG_NF_TABLES_IPV6=y
> CONFIG_NFT_REJECT_IPV6=m
> CONFIG_NFT_DUP_IPV6=m
> CONFIG_NFT_FIB_IPV6=m
> CONFIG_NF_DUP_IPV6=m
> CONFIG_NF_REJECT_IPV6=m
> CONFIG_NF_LOG_IPV6=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_AH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_MH=m
> CONFIG_IP6_NF_MATCH_RPFILTER=m
> CONFIG_IP6_NF_MATCH_RT=m
> # CONFIG_IP6_NF_MATCH_SRH is not set
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_REJECT=m
> CONFIG_IP6_NF_TARGET_SYNPROXY=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_RAW=m
> CONFIG_IP6_NF_SECURITY=m
> CONFIG_IP6_NF_NAT=m
> CONFIG_IP6_NF_TARGET_MASQUERADE=m
> CONFIG_IP6_NF_TARGET_NPT=m
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=m
> CONFIG_NF_TABLES_BRIDGE=m
> # CONFIG_NFT_BRIDGE_META is not set
> CONFIG_NFT_BRIDGE_REJECT=m
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> CONFIG_BRIDGE_NF_EBTABLES=m
> CONFIG_BRIDGE_EBT_BROUTE=m
> CONFIG_BRIDGE_EBT_T_FILTER=m
> CONFIG_BRIDGE_EBT_T_NAT=m
> CONFIG_BRIDGE_EBT_802_3=m
> CONFIG_BRIDGE_EBT_AMONG=m
> CONFIG_BRIDGE_EBT_ARP=m
> CONFIG_BRIDGE_EBT_IP=m
> CONFIG_BRIDGE_EBT_IP6=m
> CONFIG_BRIDGE_EBT_LIMIT=m
> CONFIG_BRIDGE_EBT_MARK=m
> CONFIG_BRIDGE_EBT_PKTTYPE=m
> CONFIG_BRIDGE_EBT_STP=m
> CONFIG_BRIDGE_EBT_VLAN=m
> CONFIG_BRIDGE_EBT_ARPREPLY=m
> CONFIG_BRIDGE_EBT_DNAT=m
> CONFIG_BRIDGE_EBT_MARK_T=m
> CONFIG_BRIDGE_EBT_REDIRECT=m
> CONFIG_BRIDGE_EBT_SNAT=m
> CONFIG_BRIDGE_EBT_LOG=m
> CONFIG_BRIDGE_EBT_NFLOG=m
> # CONFIG_BPFILTER is not set
> CONFIG_IP_DCCP=y
> CONFIG_INET_DCCP_DIAG=m
> 
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> CONFIG_IP_DCCP_CCID3=y
> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> CONFIG_IP_DCCP_TFRC_LIB=y
> # end of DCCP CCIDs Configuration
> 
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> # end of DCCP Kernel Hacking
> 
> CONFIG_IP_SCTP=m
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=y
> CONFIG_SCTP_COOKIE_HMAC_SHA1=y
> CONFIG_INET_SCTP_DIAG=m
> # CONFIG_RDS is not set
> CONFIG_TIPC=m
> CONFIG_TIPC_MEDIA_UDP=y
> CONFIG_TIPC_CRYPTO=y
> CONFIG_TIPC_DIAG=m
> CONFIG_ATM=m
> CONFIG_ATM_CLIP=m
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=m
> # CONFIG_ATM_MPOA is not set
> CONFIG_ATM_BR2684=m
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=m
> CONFIG_L2TP_DEBUGFS=m
> CONFIG_L2TP_V3=y
> CONFIG_L2TP_IP=m
> CONFIG_L2TP_ETH=m
> CONFIG_STP=m
> CONFIG_GARP=m
> CONFIG_MRP=m
> CONFIG_BRIDGE=m
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_BRIDGE_VLAN_FILTERING=y
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=m
> CONFIG_VLAN_8021Q_GVRP=y
> CONFIG_VLAN_8021Q_MVRP=y
> # CONFIG_DECNET is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> CONFIG_6LOWPAN=m
> # CONFIG_6LOWPAN_DEBUGFS is not set
> # CONFIG_6LOWPAN_NHC is not set
> CONFIG_IEEE802154=m
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=m
> CONFIG_IEEE802154_6LOWPAN=m
> CONFIG_MAC802154=m
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_ATM=m
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_MULTIQ=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFB=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> CONFIG_NET_SCH_NETEM=m
> CONFIG_NET_SCH_DRR=m
> CONFIG_NET_SCH_MQPRIO=m
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=m
> CONFIG_NET_SCH_QFQ=m
> CONFIG_NET_SCH_CODEL=m
> CONFIG_NET_SCH_FQ_CODEL=y
> # CONFIG_NET_SCH_CAKE is not set
> CONFIG_NET_SCH_FQ=m
> CONFIG_NET_SCH_HHF=m
> CONFIG_NET_SCH_PIE=m
> # CONFIG_NET_SCH_FQ_PIE is not set
> CONFIG_NET_SCH_INGRESS=m
> CONFIG_NET_SCH_PLUG=m
> # CONFIG_NET_SCH_ETS is not set
> CONFIG_NET_SCH_DEFAULT=y
> # CONFIG_DEFAULT_FQ is not set
> # CONFIG_DEFAULT_CODEL is not set
> CONFIG_DEFAULT_FQ_CODEL=y
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH="fq_codel"
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=m
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_CLS_U32_PERF=y
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> CONFIG_NET_CLS_FLOW=m
> CONFIG_NET_CLS_CGROUP=y
> CONFIG_NET_CLS_BPF=m
> CONFIG_NET_CLS_FLOWER=m
> CONFIG_NET_CLS_MATCHALL=m
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=m
> CONFIG_NET_EMATCH_NBYTE=m
> CONFIG_NET_EMATCH_U32=m
> CONFIG_NET_EMATCH_META=m
> CONFIG_NET_EMATCH_TEXT=m
> # CONFIG_NET_EMATCH_CANID is not set
> CONFIG_NET_EMATCH_IPSET=m
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=m
> CONFIG_NET_ACT_GACT=m
> CONFIG_GACT_PROB=y
> CONFIG_NET_ACT_MIRRED=m
> CONFIG_NET_ACT_SAMPLE=m
> # CONFIG_NET_ACT_IPT is not set
> CONFIG_NET_ACT_NAT=m
> CONFIG_NET_ACT_PEDIT=m
> CONFIG_NET_ACT_SIMP=m
> CONFIG_NET_ACT_SKBEDIT=m
> CONFIG_NET_ACT_CSUM=m
> # CONFIG_NET_ACT_MPLS is not set
> CONFIG_NET_ACT_VLAN=m
> CONFIG_NET_ACT_BPF=m
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> CONFIG_NET_ACT_SKBMOD=m
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=m
> # CONFIG_NET_ACT_GATE is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> CONFIG_OPENVSWITCH=m
> CONFIG_OPENVSWITCH_GRE=m
> CONFIG_VSOCKETS=m
> CONFIG_VSOCKETS_DIAG=m
> CONFIG_VSOCKETS_LOOPBACK=m
> CONFIG_VMWARE_VMCI_VSOCKETS=m
> CONFIG_VIRTIO_VSOCKETS=m
> CONFIG_VIRTIO_VSOCKETS_COMMON=m
> CONFIG_HYPERV_VSOCKETS=m
> CONFIG_NETLINK_DIAG=m
> CONFIG_MPLS=y
> CONFIG_NET_MPLS_GSO=y
> CONFIG_MPLS_ROUTING=m
> CONFIG_MPLS_IPTUNNEL=m
> CONFIG_NET_NSH=y
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=y
> CONFIG_NET_L3_MASTER_DEV=y
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=y
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_STREAM_PARSER=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=m
> CONFIG_NET_DROP_MONITOR=y
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=m
> CONFIG_CAN_RAW=m
> CONFIG_CAN_BCM=m
> CONFIG_CAN_GW=m
> # CONFIG_CAN_J1939 is not set
> # CONFIG_CAN_ISOTP is not set
> 
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=m
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_SLCAN=m
> CONFIG_CAN_DEV=m
> CONFIG_CAN_CALC_BITTIMING=y
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_C_CAN=m
> CONFIG_CAN_C_CAN_PLATFORM=m
> CONFIG_CAN_C_CAN_PCI=m
> CONFIG_CAN_CC770=m
> # CONFIG_CAN_CC770_ISA is not set
> CONFIG_CAN_CC770_PLATFORM=m
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> CONFIG_CAN_SJA1000=m
> CONFIG_CAN_EMS_PCI=m
> # CONFIG_CAN_F81601 is not set
> CONFIG_CAN_KVASER_PCI=m
> CONFIG_CAN_PEAK_PCI=m
> CONFIG_CAN_PEAK_PCIEC=y
> CONFIG_CAN_PLX_PCI=m
> # CONFIG_CAN_SJA1000_ISA is not set
> CONFIG_CAN_SJA1000_PLATFORM=m
> CONFIG_CAN_SOFTING=m
> 
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
> 
> #
> # CAN USB interfaces
> #
> # CONFIG_CAN_8DEV_USB is not set
> # CONFIG_CAN_EMS_USB is not set
> # CONFIG_CAN_ESD_USB2 is not set
> # CONFIG_CAN_ETAS_ES58X is not set
> # CONFIG_CAN_GS_USB is not set
> # CONFIG_CAN_KVASER_USB is not set
> # CONFIG_CAN_MCBA_USB is not set
> # CONFIG_CAN_PEAK_USB is not set
> # CONFIG_CAN_UCAN is not set
> # end of CAN USB interfaces
> 
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # end of CAN Device Drivers
> 
> CONFIG_BT=m
> CONFIG_BT_BREDR=y
> CONFIG_BT_RFCOMM=m
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=m
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HIDP=m
> CONFIG_BT_HS=y
> CONFIG_BT_LE=y
> # CONFIG_BT_6LOWPAN is not set
> # CONFIG_BT_LEDS is not set
> # CONFIG_BT_MSFTEXT is not set
> # CONFIG_BT_AOSPEXT is not set
> CONFIG_BT_DEBUGFS=y
> # CONFIG_BT_SELFTEST is not set
> 
> #
> # Bluetooth device drivers
> #
> # CONFIG_BT_HCIBTUSB is not set
> # CONFIG_BT_HCIBTSDIO is not set
> CONFIG_BT_HCIUART=m
> CONFIG_BT_HCIUART_H4=y
> CONFIG_BT_HCIUART_BCSP=y
> CONFIG_BT_HCIUART_ATH3K=y
> # CONFIG_BT_HCIUART_INTEL is not set
> # CONFIG_BT_HCIUART_AG6XX is not set
> # CONFIG_BT_HCIBCM203X is not set
> # CONFIG_BT_HCIBPA10X is not set
> # CONFIG_BT_HCIBFUSB is not set
> CONFIG_BT_HCIVHCI=m
> CONFIG_BT_MRVL=m
> # CONFIG_BT_MRVL_SDIO is not set
> # CONFIG_BT_MTKSDIO is not set
> # CONFIG_BT_VIRTIO is not set
> # end of Bluetooth device drivers
> 
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=y
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> CONFIG_CFG80211=m
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> CONFIG_CFG80211_DEFAULT_PS=y
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=y
> # CONFIG_CFG80211_WEXT is not set
> CONFIG_MAC80211=m
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> # CONFIG_MAC80211_MESH is not set
> CONFIG_MAC80211_LEDS=y
> CONFIG_MAC80211_DEBUGFS=y
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_RFKILL=m
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=m
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=m
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=y
> CONFIG_LWTUNNEL_BPF=y
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_SOCK_VALIDATE_XMIT=y
> CONFIG_NET_SELFTESTS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_FAILOVER=m
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> CONFIG_PCIEAER_INJECT=m
> CONFIG_PCIE_ECRC=y
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=m
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> CONFIG_PCI_PASID=y
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=y
> CONFIG_PCI_HYPERV=m
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=m
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # PCI controller drivers
> #
> CONFIG_VMD=y
> CONFIG_PCI_HYPERV_INTERFACE=m
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=y
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=m
> CONFIG_REGMAP_SPI=m
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=m
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> CONFIG_DMI_SYSFS=y
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT is not set
> CONFIG_FW_CFG_SYSFS=y
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=y
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=y
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=y
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_APPLE_PROPERTIES=y
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> CONFIG_EFI_DEV_PATH_PARSER=y
> CONFIG_EFI_EARLYCON=y
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_SERIAL=m
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_AX88796 is not set
> CONFIG_PARPORT_1284=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=m
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=m
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=m
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=m
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=16384
> CONFIG_CDROM_PKTCDVD=m
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=m
> CONFIG_BLK_DEV_RBD=m
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=m
> CONFIG_BLK_DEV_NVME=m
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_FC=m
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=m
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> CONFIG_TIFM_CORE=m
> CONFIG_TIFM_7XX1=m
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=m
> CONFIG_SGI_XP=m
> CONFIG_HP_ILO=m
> CONFIG_SGI_GRU=m
> # CONFIG_SGI_GRU_DEBUG is not set
> CONFIG_APDS9802ALS=m
> CONFIG_ISL29003=m
> CONFIG_ISL29020=m
> CONFIG_SENSORS_TSL2550=m
> CONFIG_SENSORS_BH1770=m
> CONFIG_SENSORS_APDS990X=m
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> CONFIG_VMWARE_BALLOON=m
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=m
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=m
> CONFIG_EEPROM_MAX6875=m
> CONFIG_EEPROM_93CX6=m
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=m
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> CONFIG_SENSORS_LIS3_I2C=m
> CONFIG_ALTERA_STAPL=m
> CONFIG_INTEL_MEI=m
> CONFIG_INTEL_MEI_ME=m
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> CONFIG_VMWARE_VMCI=m
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=m
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_UACCE is not set
> CONFIG_PVPANIC=y
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=m
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_CHR_DEV_SG=m
> CONFIG_BLK_DEV_BSG=y
> CONFIG_CHR_DEV_SCH=m
> CONFIG_SCSI_ENCLOSURE=m
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> CONFIG_SCSI_ISCSI_ATTRS=m
> CONFIG_SCSI_SAS_ATTRS=m
> CONFIG_SCSI_SAS_LIBSAS=m
> CONFIG_SCSI_SAS_ATA=y
> CONFIG_SCSI_SAS_HOST_SMP=y
> CONFIG_SCSI_SRP_ATTRS=m
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_MPT3SAS=m
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> CONFIG_HYPERV_STORAGE=m
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_ISCI=m
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_EFCT is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> CONFIG_SCSI_DEBUG=m
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> # CONFIG_SCSI_VIRTIO is not set
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=y
> CONFIG_SCSI_DH_HP_SW=y
> CONFIG_SCSI_DH_EMC=y
> CONFIG_SCSI_DH_ALUA=y
> # end of SCSI device support
> 
> CONFIG_ATA=m
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=0
> CONFIG_SATA_AHCI_PLATFORM=m
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=m
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> 
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=m
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> # CONFIG_MD_MULTIPATH is not set
> CONFIG_MD_FAULTY=m
> CONFIG_MD_CLUSTER=m
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=m
> CONFIG_DM_DEBUG=y
> CONFIG_DM_BUFIO=m
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=m
> CONFIG_DM_PERSISTENT_DATA=m
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=m
> CONFIG_DM_SNAPSHOT=m
> CONFIG_DM_THIN_PROVISIONING=m
> CONFIG_DM_CACHE=m
> CONFIG_DM_CACHE_SMQ=m
> CONFIG_DM_WRITECACHE=m
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=m
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=m
> CONFIG_DM_LOG_USERSPACE=m
> CONFIG_DM_RAID=m
> CONFIG_DM_ZERO=m
> CONFIG_DM_MULTIPATH=m
> CONFIG_DM_MULTIPATH_QL=m
> CONFIG_DM_MULTIPATH_ST=m
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> CONFIG_DM_DELAY=m
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=y
> CONFIG_DM_FLAKEY=m
> CONFIG_DM_VERITY=m
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> # CONFIG_DM_VERITY_FEC is not set
> CONFIG_DM_SWITCH=m
> CONFIG_DM_LOG_WRITES=m
> CONFIG_DM_INTEGRITY=m
> CONFIG_TARGET_CORE=m
> CONFIG_TCM_IBLOCK=m
> CONFIG_TCM_FILEIO=m
> CONFIG_TCM_PSCSI=m
> CONFIG_TCM_USER2=m
> CONFIG_LOOPBACK_TARGET=m
> CONFIG_ISCSI_TARGET=m
> # CONFIG_SBP_TARGET is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=m
> CONFIG_FIREWIRE_OHCI=m
> CONFIG_FIREWIRE_SBP2=m
> CONFIG_FIREWIRE_NET=m
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=m
> CONFIG_NETCONSOLE_DYNAMIC=y
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_TUN=m
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> # CONFIG_NET_VRF is not set
> # CONFIG_VSOCKMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=y
> # CONFIG_ATM_DUMMY is not set
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_ATM_SOLOS is not set
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> # CONFIG_NET_VENDOR_3COM is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> CONFIG_CAVIUM_PTP=y
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> # CONFIG_IXGBE_DCB is not set
> CONFIG_IXGBE_IPSEC=y
> # CONFIG_IXGBEVF is not set
> CONFIG_I40E=y
> # CONFIG_I40E_DCB is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> CONFIG_IGC=y
> CONFIG_NET_VENDOR_MICROSOFT=y
> # CONFIG_MICROSOFT_MANA is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_PRESTERA is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> CONFIG_R8169=y
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> # CONFIG_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> # CONFIG_LED_TRIGGER_PHY is not set
> CONFIG_FIXED_PHY=y
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> CONFIG_AX88796B_PHY=y
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM84881_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_MOTORCOMM_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> CONFIG_REALTEK_PHY=y
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_FWNODE_MDIO=y
> CONFIG_ACPI_MDIO=y
> CONFIG_MDIO_DEVRES=y
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_THUNDER is not set
> 
> #
> # MDIO Multiplexers
> #
> 
> #
> # PCS device drivers
> #
> # CONFIG_PCS_XPCS is not set
> # end of PCS device drivers
> 
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> CONFIG_USB_RTL8152=y
> # CONFIG_USB_LAN78XX is not set
> CONFIG_USB_USBNET=y
> CONFIG_USB_NET_AX8817X=y
> CONFIG_USB_NET_AX88179_178A=y
> # CONFIG_USB_NET_CDCETHER is not set
> # CONFIG_USB_NET_CDC_EEM is not set
> # CONFIG_USB_NET_CDC_NCM is not set
> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> # CONFIG_USB_NET_CDC_MBIM is not set
> # CONFIG_USB_NET_DM9601 is not set
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> # CONFIG_USB_NET_SMSC75XX is not set
> # CONFIG_USB_NET_SMSC95XX is not set
> # CONFIG_USB_NET_GL620A is not set
> # CONFIG_USB_NET_NET1080 is not set
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_MCS7830 is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> # CONFIG_USB_NET_CDC_SUBSET is not set
> # CONFIG_USB_NET_ZAURUS is not set
> # CONFIG_USB_NET_CX82310_ETH is not set
> # CONFIG_USB_NET_KALMIA is not set
> # CONFIG_USB_NET_QMI_WWAN is not set
> # CONFIG_USB_HSO is not set
> # CONFIG_USB_NET_INT51X1 is not set
> # CONFIG_USB_IPHETH is not set
> # CONFIG_USB_SIERRA_NET is not set
> # CONFIG_USB_NET_CH9200 is not set
> # CONFIG_USB_NET_AQC111 is not set
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> # CONFIG_ADM8211 is not set
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> # CONFIG_ATH9K is not set
> # CONFIG_ATH9K_HTC is not set
> # CONFIG_CARL9170 is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_AR5523 is not set
> # CONFIG_WIL6210 is not set
> # CONFIG_ATH10K is not set
> # CONFIG_WCN36XX is not set
> # CONFIG_ATH11K is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> # CONFIG_ATMEL is not set
> # CONFIG_AT76C50X_USB is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> # CONFIG_BRCMSMAC is not set
> # CONFIG_BRCMFMAC is not set
> CONFIG_WLAN_VENDOR_CISCO=y
> # CONFIG_AIRO is not set
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_IWL4965 is not set
> # CONFIG_IWL3945 is not set
> # CONFIG_IWLWIFI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_HERMES is not set
> # CONFIG_P54_COMMON is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> # CONFIG_LIBERTAS is not set
> # CONFIG_LIBERTAS_THINFIRM is not set
> # CONFIG_MWIFIEX is not set
> # CONFIG_MWL8K is not set
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> CONFIG_WLAN_VENDOR_RALINK=y
> # CONFIG_RT2X00 is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_RTL8180 is not set
> # CONFIG_RTL8187 is not set
> CONFIG_RTL_CARDS=m
> # CONFIG_RTL8192CE is not set
> # CONFIG_RTL8192SE is not set
> # CONFIG_RTL8192DE is not set
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> # CONFIG_RTL8821AE is not set
> # CONFIG_RTL8192CU is not set
> # CONFIG_RTL8XXXU is not set
> # CONFIG_RTW88 is not set
> CONFIG_WLAN_VENDOR_RSI=y
> # CONFIG_RSI_91X is not set
> CONFIG_WLAN_VENDOR_ST=y
> # CONFIG_CW1200 is not set
> CONFIG_WLAN_VENDOR_TI=y
> # CONFIG_WL1251 is not set
> # CONFIG_WL12XX is not set
> # CONFIG_WL18XX is not set
> # CONFIG_WLCORE is not set
> CONFIG_WLAN_VENDOR_ZYDAS=y
> # CONFIG_USB_ZD1201 is not set
> # CONFIG_ZD1211RW is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_QTNFMAC_PCIE is not set
> # CONFIG_MAC80211_HWSIM is not set
> # CONFIG_USB_NET_RNDIS_WLAN is not set
> # CONFIG_VIRT_WIFI is not set
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=m
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ATUSB is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_HYPERV_NET is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=m
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=m
> CONFIG_INPUT_SPARSEKMAP=m
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> CONFIG_MOUSE_PS2_SENTELIC=y
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> CONFIG_MOUSE_PS2_VMMOUSE=y
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=m
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> CONFIG_MOUSE_CYAPA=m
> CONFIG_MOUSE_ELAN_I2C=m
> CONFIG_MOUSE_ELAN_I2C_I2C=y
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> CONFIG_MOUSE_VSXXXAA=m
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=m
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> CONFIG_RMI4_CORE=m
> CONFIG_RMI4_I2C=m
> CONFIG_RMI4_SPI=m
> CONFIG_RMI4_SMB=m
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=m
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F3A is not set
> # CONFIG_RMI4_F54 is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=m
> CONFIG_SERIO_ALTERA_PS2=m
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=m
> CONFIG_HYPERV_KEYBOARD=m
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=64
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_JSM=m
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_ARC=m
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_SYNCLINK_GT=m
> CONFIG_N_HDLC=m
> CONFIG_N_GSM=m
> CONFIG_NOZOMI=m
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=y
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=m
> CONFIG_VIRTIO_CONSOLE=m
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> CONFIG_IPMI_PANIC_EVENT=y
> CONFIG_IPMI_PANIC_STRING=y
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_SI=m
> CONFIG_IPMI_SSIF=m
> CONFIG_IPMI_WATCHDOG=m
> CONFIG_IPMI_POWEROFF=m
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=m
> CONFIG_HW_RANDOM_INTEL=m
> CONFIG_HW_RANDOM_AMD=m
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=m
> CONFIG_HW_RANDOM_VIRTIO=y
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=y
> CONFIG_NVRAM=y
> CONFIG_DEVPORT=y
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=m
> CONFIG_UV_MMTIMER=m
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=m
> CONFIG_TCG_TIS_I2C_INFINEON=m
> CONFIG_TCG_TIS_I2C_NUVOTON=m
> CONFIG_TCG_NSC=m
> CONFIG_TCG_ATMEL=m
> CONFIG_TCG_INFINEON=m
> CONFIG_TCG_CRB=y
> # CONFIG_TCG_VTPM_PROXY is not set
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=m
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> # CONFIG_RANDOM_TRUST_CPU is not set
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=m
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=m
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> CONFIG_I2C_AMD756=m
> CONFIG_I2C_AMD756_S4882=m
> CONFIG_I2C_AMD8111=m
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=y
> CONFIG_I2C_ISCH=m
> CONFIG_I2C_ISMT=m
> CONFIG_I2C_PIIX4=m
> CONFIG_I2C_NFORCE2=m
> CONFIG_I2C_NFORCE2_S4985=m
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=m
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=m
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=m
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=m
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=m
> CONFIG_I2C_SIMTEC=m
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=m
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=m
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> # CONFIG_SPI_MEM is not set
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_NXP_FLEXSPI is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
> 
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=m
> CONFIG_PPS_CLIENT_PARPORT=m
> CONFIG_PPS_CLIENT_GPIO=m
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> # CONFIG_DP83640_PHY is not set
> # CONFIG_PTP_1588_CLOCK_INES is not set
> CONFIG_PTP_1588_CLOCK_KVM=m
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> CONFIG_PINCTRL_AMD=m
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_BAYTRAIL=y
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=y
> # CONFIG_PINCTRL_ALDERLAKE is not set
> CONFIG_PINCTRL_BROXTON=m
> CONFIG_PINCTRL_CANNONLAKE=m
> CONFIG_PINCTRL_CEDARFORK=m
> CONFIG_PINCTRL_DENVERTON=m
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=m
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> CONFIG_PINCTRL_LEWISBURG=m
> CONFIG_PINCTRL_SUNRISEPOINT=m
> # CONFIG_PINCTRL_TIGERLAKE is not set
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=y
> CONFIG_GPIO_CDEV_V1=y
> CONFIG_GPIO_GENERIC=m
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_AMDPT=m
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_ICH=m
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # end of Virtual GPIO drivers
> 
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=m
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=m
> CONFIG_SENSORS_ABITUGURU3=m
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=m
> CONFIG_SENSORS_AD7418=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> CONFIG_SENSORS_ADM1026=m
> CONFIG_SENSORS_ADM1029=m
> CONFIG_SENSORS_ADM1031=m
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=m
> CONFIG_SENSORS_ADT7X10=m
> # CONFIG_SENSORS_ADT7310 is not set
> CONFIG_SENSORS_ADT7410=m
> CONFIG_SENSORS_ADT7411=m
> CONFIG_SENSORS_ADT7462=m
> CONFIG_SENSORS_ADT7470=m
> CONFIG_SENSORS_ADT7475=m
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=m
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=m
> CONFIG_SENSORS_K10TEMP=m
> CONFIG_SENSORS_FAM15H_POWER=m
> CONFIG_SENSORS_APPLESMC=m
> CONFIG_SENSORS_ASB100=m
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=m
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=m
> CONFIG_SENSORS_DS1621=m
> CONFIG_SENSORS_DELL_SMM=m
> CONFIG_SENSORS_I5K_AMB=m
> CONFIG_SENSORS_F71805F=m
> CONFIG_SENSORS_F71882FG=m
> CONFIG_SENSORS_F75375S=m
> CONFIG_SENSORS_FSCHMD=m
> # CONFIG_SENSORS_FTSTEUTATES is not set
> CONFIG_SENSORS_GL518SM=m
> CONFIG_SENSORS_GL520SM=m
> CONFIG_SENSORS_G760A=m
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=m
> CONFIG_SENSORS_IBMPEX=m
> CONFIG_SENSORS_I5500=m
> CONFIG_SENSORS_CORETEMP=m
> CONFIG_SENSORS_IT87=m
> CONFIG_SENSORS_JC42=m
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=m
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=m
> CONFIG_SENSORS_LTC4215=m
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=m
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=m
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=m
> CONFIG_SENSORS_MAX1619=m
> CONFIG_SENSORS_MAX1668=m
> CONFIG_SENSORS_MAX197=m
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=m
> CONFIG_SENSORS_MAX6642=m
> CONFIG_SENSORS_MAX6650=m
> CONFIG_SENSORS_MAX6697=m
> # CONFIG_SENSORS_MAX31790 is not set
> CONFIG_SENSORS_MCP3021=m
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=m
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=m
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=m
> CONFIG_SENSORS_LM90=m
> CONFIG_SENSORS_LM92=m
> CONFIG_SENSORS_LM93=m
> CONFIG_SENSORS_LM95234=m
> CONFIG_SENSORS_LM95241=m
> CONFIG_SENSORS_LM95245=m
> CONFIG_SENSORS_PC87360=m
> CONFIG_SENSORS_PC87427=m
> CONFIG_SENSORS_NTC_THERMISTOR=m
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=m
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> CONFIG_SENSORS_PMBUS=m
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=m
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_DPS920AB is not set
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=m
> CONFIG_SENSORS_LTC2978=m
> # CONFIG_SENSORS_LTC3815 is not set
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=m
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> # CONFIG_SENSORS_MAX20751 is not set
> # CONFIG_SENSORS_MAX31785 is not set
> CONFIG_SENSORS_MAX34440=m
> CONFIG_SENSORS_MAX8688=m
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=m
> CONFIG_SENSORS_UCD9200=m
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=m
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=m
> CONFIG_SENSORS_SHT21=m
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=m
> CONFIG_SENSORS_DME1737=m
> CONFIG_SENSORS_EMC1403=m
> # CONFIG_SENSORS_EMC2103 is not set
> CONFIG_SENSORS_EMC6W201=m
> CONFIG_SENSORS_SMSC47M1=m
> CONFIG_SENSORS_SMSC47M192=m
> CONFIG_SENSORS_SMSC47B397=m
> CONFIG_SENSORS_SCH56XX_COMMON=m
> CONFIG_SENSORS_SCH5627=m
> CONFIG_SENSORS_SCH5636=m
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=m
> # CONFIG_SENSORS_ADS7871 is not set
> CONFIG_SENSORS_AMC6821=m
> CONFIG_SENSORS_INA209=m
> CONFIG_SENSORS_INA2XX=m
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=m
> CONFIG_SENSORS_TMP102=m
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=m
> CONFIG_SENSORS_TMP421=m
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=m
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_VT1211=m
> CONFIG_SENSORS_VT8231=m
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=m
> CONFIG_SENSORS_W83791D=m
> CONFIG_SENSORS_W83792D=m
> CONFIG_SENSORS_W83793=m
> CONFIG_SENSORS_W83795=m
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83L786NG=m
> CONFIG_SENSORS_W83627HF=m
> CONFIG_SENSORS_W83627EHF=m
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=m
> CONFIG_SENSORS_ATK0110=m
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=m
> CONFIG_X86_THERMAL_VECTOR=y
> CONFIG_X86_PKG_TEMP_THERMAL=m
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=m
> CONFIG_ACPI_THERMAL_REL=m
> # CONFIG_INT3406_THERMAL is not set
> CONFIG_PROC_THERMAL_MMIO_RAPL=m
> # end of ACPI INT340X thermal drivers
> 
> CONFIG_INTEL_PCH_THERMAL=m
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_MENLOW is not set
> # end of Intel thermal drivers
> 
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> CONFIG_WATCHDOG_SYSFS=y
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=m
> CONFIG_WDAT_WDT=m
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_MLX_WDT is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> CONFIG_ALIM1535_WDT=m
> CONFIG_ALIM7101_WDT=m
> # CONFIG_EBC_C384_WDT is not set
> CONFIG_F71808E_WDT=m
> CONFIG_SP5100_TCO=m
> CONFIG_SBC_FITPC2_WATCHDOG=m
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=m
> CONFIG_IBMASR=m
> # CONFIG_WAFER_WDT is not set
> CONFIG_I6300ESB_WDT=y
> CONFIG_IE6XX_WDT=m
> CONFIG_ITCO_WDT=y
> CONFIG_ITCO_VENDOR_SUPPORT=y
> CONFIG_IT8712F_WDT=m
> CONFIG_IT87_WDT=m
> CONFIG_HP_WATCHDOG=m
> CONFIG_HPWDT_NMI_DECODING=y
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=m
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=m
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=m
> CONFIG_W83627HF_WDT=m
> CONFIG_W83877F_WDT=m
> CONFIG_W83977F_WDT=m
> CONFIG_MACHZ_WDT=m
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> CONFIG_INTEL_MEI_WDT=m
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=m
> CONFIG_WDTPCI=m
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> CONFIG_BCMA_DRIVER_GPIO=y
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=m
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> CONFIG_MFD_INTEL_LPSS_PCI=y
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_INTEL_PMT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=m
> CONFIG_MFD_SM501_GPIO=y
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=m
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
> 
> # CONFIG_REGULATOR is not set
> CONFIG_RC_CORE=m
> CONFIG_RC_MAP=m
> CONFIG_LIRC=y
> CONFIG_RC_DECODERS=y
> CONFIG_IR_NEC_DECODER=m
> CONFIG_IR_RC5_DECODER=m
> CONFIG_IR_RC6_DECODER=m
> CONFIG_IR_JVC_DECODER=m
> CONFIG_IR_SONY_DECODER=m
> CONFIG_IR_SANYO_DECODER=m
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_MCE_KBD_DECODER=m
> # CONFIG_IR_XMP_DECODER is not set
> CONFIG_IR_IMON_DECODER=m
> # CONFIG_IR_RCMM_DECODER is not set
> CONFIG_RC_DEVICES=y
> # CONFIG_RC_ATI_REMOTE is not set
> CONFIG_IR_ENE=m
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_MCEUSB is not set
> CONFIG_IR_ITE_CIR=m
> CONFIG_IR_FINTEK=m
> CONFIG_IR_NUVOTON=m
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_STREAMZAP is not set
> CONFIG_IR_WINBOND_CIR=m
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_TTUSBIR is not set
> # CONFIG_RC_LOOPBACK is not set
> CONFIG_IR_SERIAL=m
> CONFIG_IR_SERIAL_TRANSMITTER=y
> CONFIG_IR_SIR=m
> # CONFIG_RC_XBOX_DVD is not set
> # CONFIG_IR_TOY is not set
> CONFIG_MEDIA_CEC_SUPPORT=y
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_PULSE8_CEC is not set
> # CONFIG_USB_RAINSHADOW_CEC is not set
> CONFIG_MEDIA_SUPPORT=m
> # CONFIG_MEDIA_SUPPORT_FILTER is not set
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> CONFIG_MEDIA_SDR_SUPPORT=y
> CONFIG_MEDIA_PLATFORM_SUPPORT=y
> CONFIG_MEDIA_TEST_SUPPORT=y
> # end of Media device types
> 
> #
> # Media core support
> #
> CONFIG_VIDEO_DEV=m
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=m
> # end of Media core support
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=m
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> # CONFIG_MEDIA_CONTROLLER_DVB is not set
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> CONFIG_DVB_DYNAMIC_MINORS=y
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> CONFIG_RADIO_ADAPTERS=y
> # CONFIG_RADIO_SI470X is not set
> # CONFIG_RADIO_SI4713 is not set
> # CONFIG_USB_MR800 is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_SHARK is not set
> # CONFIG_RADIO_SHARK2 is not set
> # CONFIG_USB_KEENE is not set
> # CONFIG_USB_RAREMONO is not set
> # CONFIG_USB_MA901 is not set
> # CONFIG_RADIO_TEA5764 is not set
> # CONFIG_RADIO_SAA7706H is not set
> # CONFIG_RADIO_TEF6862 is not set
> # CONFIG_RADIO_WL1273 is not set
> CONFIG_VIDEOBUF2_CORE=m
> CONFIG_VIDEOBUF2_V4L2=m
> CONFIG_VIDEOBUF2_MEMOPS=m
> CONFIG_VIDEOBUF2_VMALLOC=m
> # CONFIG_V4L_PLATFORM_DRIVERS is not set
> # CONFIG_V4L_MEM2MEM_DRIVERS is not set
> # CONFIG_DVB_PLATFORM_DRIVERS is not set
> # CONFIG_SDR_PLATFORM_DRIVERS is not set
> 
> #
> # MMC/SDIO DVB adapters
> #
> # CONFIG_SMS_SDIO_DRV is not set
> # CONFIG_V4L_TEST_DRIVERS is not set
> # CONFIG_DVB_TEST_DRIVERS is not set
> 
> #
> # FireWire (IEEE 1394) Adapters
> #
> # CONFIG_DVB_FIREDTV is not set
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> CONFIG_VIDEO_IR_I2C=m
> 
> #
> # Audio decoders, processors and mixers
> #
> # CONFIG_VIDEO_TVAUDIO is not set
> # CONFIG_VIDEO_TDA7432 is not set
> # CONFIG_VIDEO_TDA9840 is not set
> # CONFIG_VIDEO_TEA6415C is not set
> # CONFIG_VIDEO_TEA6420 is not set
> # CONFIG_VIDEO_MSP3400 is not set
> # CONFIG_VIDEO_CS3308 is not set
> # CONFIG_VIDEO_CS5345 is not set
> # CONFIG_VIDEO_CS53L32A is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> # CONFIG_VIDEO_UDA1342 is not set
> # CONFIG_VIDEO_WM8775 is not set
> # CONFIG_VIDEO_WM8739 is not set
> # CONFIG_VIDEO_VP27SMPX is not set
> # CONFIG_VIDEO_SONY_BTF_MPX is not set
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> # CONFIG_VIDEO_SAA6588 is not set
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> # CONFIG_VIDEO_ADV7183 is not set
> # CONFIG_VIDEO_ADV7604 is not set
> # CONFIG_VIDEO_ADV7842 is not set
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> # CONFIG_VIDEO_BT866 is not set
> # CONFIG_VIDEO_KS0127 is not set
> # CONFIG_VIDEO_ML86V7667 is not set
> # CONFIG_VIDEO_SAA7110 is not set
> # CONFIG_VIDEO_SAA711X is not set
> # CONFIG_VIDEO_TC358743 is not set
> # CONFIG_VIDEO_TVP514X is not set
> # CONFIG_VIDEO_TVP5150 is not set
> # CONFIG_VIDEO_TVP7002 is not set
> # CONFIG_VIDEO_TW2804 is not set
> # CONFIG_VIDEO_TW9903 is not set
> # CONFIG_VIDEO_TW9906 is not set
> # CONFIG_VIDEO_TW9910 is not set
> # CONFIG_VIDEO_VPX3220 is not set
> 
> #
> # Video and audio decoders
> #
> # CONFIG_VIDEO_SAA717X is not set
> # CONFIG_VIDEO_CX25840 is not set
> # end of Video decoders
> 
> #
> # Video encoders
> #
> # CONFIG_VIDEO_SAA7127 is not set
> # CONFIG_VIDEO_SAA7185 is not set
> # CONFIG_VIDEO_ADV7170 is not set
> # CONFIG_VIDEO_ADV7175 is not set
> # CONFIG_VIDEO_ADV7343 is not set
> # CONFIG_VIDEO_ADV7393 is not set
> # CONFIG_VIDEO_ADV7511 is not set
> # CONFIG_VIDEO_AD9389B is not set
> # CONFIG_VIDEO_AK881X is not set
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> # CONFIG_VIDEO_UPD64031A is not set
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> # CONFIG_VIDEO_SAA6752HS is not set
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> # CONFIG_SDR_MAX2175 is not set
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_THS7303 is not set
> # CONFIG_VIDEO_M52790 is not set
> # CONFIG_VIDEO_I2C is not set
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # end of Miscellaneous helper chips
> 
> #
> # Camera sensor devices
> #
> # CONFIG_VIDEO_HI556 is not set
> # CONFIG_VIDEO_IMX208 is not set
> # CONFIG_VIDEO_IMX214 is not set
> # CONFIG_VIDEO_IMX219 is not set
> # CONFIG_VIDEO_IMX258 is not set
> # CONFIG_VIDEO_IMX274 is not set
> # CONFIG_VIDEO_IMX290 is not set
> # CONFIG_VIDEO_IMX319 is not set
> # CONFIG_VIDEO_IMX355 is not set
> # CONFIG_VIDEO_OV02A10 is not set
> # CONFIG_VIDEO_OV2640 is not set
> # CONFIG_VIDEO_OV2659 is not set
> # CONFIG_VIDEO_OV2680 is not set
> # CONFIG_VIDEO_OV2685 is not set
> # CONFIG_VIDEO_OV2740 is not set
> # CONFIG_VIDEO_OV5647 is not set
> # CONFIG_VIDEO_OV5648 is not set
> # CONFIG_VIDEO_OV6650 is not set
> # CONFIG_VIDEO_OV5670 is not set
> # CONFIG_VIDEO_OV5675 is not set
> # CONFIG_VIDEO_OV5695 is not set
> # CONFIG_VIDEO_OV7251 is not set
> # CONFIG_VIDEO_OV772X is not set
> # CONFIG_VIDEO_OV7640 is not set
> # CONFIG_VIDEO_OV7670 is not set
> # CONFIG_VIDEO_OV7740 is not set
> # CONFIG_VIDEO_OV8856 is not set
> # CONFIG_VIDEO_OV8865 is not set
> # CONFIG_VIDEO_OV9640 is not set
> # CONFIG_VIDEO_OV9650 is not set
> # CONFIG_VIDEO_OV9734 is not set
> # CONFIG_VIDEO_OV13858 is not set
> # CONFIG_VIDEO_VS6624 is not set
> # CONFIG_VIDEO_MT9M001 is not set
> # CONFIG_VIDEO_MT9M032 is not set
> # CONFIG_VIDEO_MT9M111 is not set
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T001 is not set
> # CONFIG_VIDEO_MT9T112 is not set
> # CONFIG_VIDEO_MT9V011 is not set
> # CONFIG_VIDEO_MT9V032 is not set
> # CONFIG_VIDEO_MT9V111 is not set
> # CONFIG_VIDEO_SR030PC30 is not set
> # CONFIG_VIDEO_NOON010PC30 is not set
> # CONFIG_VIDEO_M5MOLS is not set
> # CONFIG_VIDEO_RDACM20 is not set
> # CONFIG_VIDEO_RDACM21 is not set
> # CONFIG_VIDEO_RJ54N1 is not set
> # CONFIG_VIDEO_S5K6AA is not set
> # CONFIG_VIDEO_S5K6A3 is not set
> # CONFIG_VIDEO_S5K4ECGX is not set
> # CONFIG_VIDEO_S5K5BAF is not set
> # CONFIG_VIDEO_CCS is not set
> # CONFIG_VIDEO_ET8EK8 is not set
> # CONFIG_VIDEO_S5C73M3 is not set
> # end of Camera sensor devices
> 
> #
> # Lens drivers
> #
> # CONFIG_VIDEO_AD5820 is not set
> # CONFIG_VIDEO_AK7375 is not set
> # CONFIG_VIDEO_DW9714 is not set
> # CONFIG_VIDEO_DW9768 is not set
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> # CONFIG_VIDEO_LM3646 is not set
> # end of Flash devices
> 
> #
> # SPI helper chips
> #
> # CONFIG_VIDEO_GS1662 is not set
> # end of SPI helper chips
> 
> #
> # Media SPI Adapters
> #
> CONFIG_CXD2880_SPI_DRV=m
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=m
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_SIMPLE=m
> CONFIG_MEDIA_TUNER_TDA18250=m
> CONFIG_MEDIA_TUNER_TDA8290=m
> CONFIG_MEDIA_TUNER_TDA827X=m
> CONFIG_MEDIA_TUNER_TDA18271=m
> CONFIG_MEDIA_TUNER_TDA9887=m
> CONFIG_MEDIA_TUNER_TEA5761=m
> CONFIG_MEDIA_TUNER_TEA5767=m
> CONFIG_MEDIA_TUNER_MSI001=m
> CONFIG_MEDIA_TUNER_MT20XX=m
> CONFIG_MEDIA_TUNER_MT2060=m
> CONFIG_MEDIA_TUNER_MT2063=m
> CONFIG_MEDIA_TUNER_MT2266=m
> CONFIG_MEDIA_TUNER_MT2131=m
> CONFIG_MEDIA_TUNER_QT1010=m
> CONFIG_MEDIA_TUNER_XC2028=m
> CONFIG_MEDIA_TUNER_XC5000=m
> CONFIG_MEDIA_TUNER_XC4000=m
> CONFIG_MEDIA_TUNER_MXL5005S=m
> CONFIG_MEDIA_TUNER_MXL5007T=m
> CONFIG_MEDIA_TUNER_MC44S803=m
> CONFIG_MEDIA_TUNER_MAX2165=m
> CONFIG_MEDIA_TUNER_TDA18218=m
> CONFIG_MEDIA_TUNER_FC0011=m
> CONFIG_MEDIA_TUNER_FC0012=m
> CONFIG_MEDIA_TUNER_FC0013=m
> CONFIG_MEDIA_TUNER_TDA18212=m
> CONFIG_MEDIA_TUNER_E4000=m
> CONFIG_MEDIA_TUNER_FC2580=m
> CONFIG_MEDIA_TUNER_M88RS6000T=m
> CONFIG_MEDIA_TUNER_TUA9001=m
> CONFIG_MEDIA_TUNER_SI2157=m
> CONFIG_MEDIA_TUNER_IT913X=m
> CONFIG_MEDIA_TUNER_R820T=m
> CONFIG_MEDIA_TUNER_MXL301RF=m
> CONFIG_MEDIA_TUNER_QM1D1C0042=m
> CONFIG_MEDIA_TUNER_QM1D1B0004=m
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_STB0899=m
> CONFIG_DVB_STB6100=m
> CONFIG_DVB_STV090x=m
> CONFIG_DVB_STV0910=m
> CONFIG_DVB_STV6110x=m
> CONFIG_DVB_STV6111=m
> CONFIG_DVB_MXL5XX=m
> CONFIG_DVB_M88DS3103=m
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=m
> CONFIG_DVB_TDA18271C2DD=m
> CONFIG_DVB_SI2165=m
> CONFIG_DVB_MN88472=m
> CONFIG_DVB_MN88473=m
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=m
> CONFIG_DVB_CX24123=m
> CONFIG_DVB_MT312=m
> CONFIG_DVB_ZL10036=m
> CONFIG_DVB_ZL10039=m
> CONFIG_DVB_S5H1420=m
> CONFIG_DVB_STV0288=m
> CONFIG_DVB_STB6000=m
> CONFIG_DVB_STV0299=m
> CONFIG_DVB_STV6110=m
> CONFIG_DVB_STV0900=m
> CONFIG_DVB_TDA8083=m
> CONFIG_DVB_TDA10086=m
> CONFIG_DVB_TDA8261=m
> CONFIG_DVB_VES1X93=m
> CONFIG_DVB_TUNER_ITD1000=m
> CONFIG_DVB_TUNER_CX24113=m
> CONFIG_DVB_TDA826X=m
> CONFIG_DVB_TUA6100=m
> CONFIG_DVB_CX24116=m
> CONFIG_DVB_CX24117=m
> CONFIG_DVB_CX24120=m
> CONFIG_DVB_SI21XX=m
> CONFIG_DVB_TS2020=m
> CONFIG_DVB_DS3000=m
> CONFIG_DVB_MB86A16=m
> CONFIG_DVB_TDA10071=m
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP887X=m
> CONFIG_DVB_CX22700=m
> CONFIG_DVB_CX22702=m
> CONFIG_DVB_S5H1432=m
> CONFIG_DVB_DRXD=m
> CONFIG_DVB_L64781=m
> CONFIG_DVB_TDA1004X=m
> CONFIG_DVB_NXT6000=m
> CONFIG_DVB_MT352=m
> CONFIG_DVB_ZL10353=m
> CONFIG_DVB_DIB3000MB=m
> CONFIG_DVB_DIB3000MC=m
> CONFIG_DVB_DIB7000M=m
> CONFIG_DVB_DIB7000P=m
> CONFIG_DVB_DIB9000=m
> CONFIG_DVB_TDA10048=m
> CONFIG_DVB_AF9013=m
> CONFIG_DVB_EC100=m
> CONFIG_DVB_STV0367=m
> CONFIG_DVB_CXD2820R=m
> CONFIG_DVB_CXD2841ER=m
> CONFIG_DVB_RTL2830=m
> CONFIG_DVB_RTL2832=m
> CONFIG_DVB_RTL2832_SDR=m
> CONFIG_DVB_SI2168=m
> CONFIG_DVB_ZD1301_DEMOD=m
> CONFIG_DVB_CXD2880=m
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=m
> CONFIG_DVB_TDA10021=m
> CONFIG_DVB_TDA10023=m
> CONFIG_DVB_STV0297=m
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=m
> CONFIG_DVB_OR51211=m
> CONFIG_DVB_OR51132=m
> CONFIG_DVB_BCM3510=m
> CONFIG_DVB_LGDT330X=m
> CONFIG_DVB_LGDT3305=m
> CONFIG_DVB_LGDT3306A=m
> CONFIG_DVB_LG2160=m
> CONFIG_DVB_S5H1409=m
> CONFIG_DVB_AU8522=m
> CONFIG_DVB_AU8522_DTV=m
> CONFIG_DVB_AU8522_V4L=m
> CONFIG_DVB_S5H1411=m
> CONFIG_DVB_MXL692=m
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_S921=m
> CONFIG_DVB_DIB8000=m
> CONFIG_DVB_MB86A20S=m
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_TC90522=m
> CONFIG_DVB_MN88443X=m
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=m
> CONFIG_DVB_TUNER_DIB0070=m
> CONFIG_DVB_TUNER_DIB0090=m
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=m
> CONFIG_DVB_LNBH25=m
> CONFIG_DVB_LNBH29=m
> CONFIG_DVB_LNBP21=m
> CONFIG_DVB_LNBP22=m
> CONFIG_DVB_ISL6405=m
> CONFIG_DVB_ISL6421=m
> CONFIG_DVB_ISL6423=m
> CONFIG_DVB_A8293=m
> CONFIG_DVB_LGS8GL5=m
> CONFIG_DVB_LGS8GXX=m
> CONFIG_DVB_ATBM8830=m
> CONFIG_DVB_TDA665x=m
> CONFIG_DVB_IX2505V=m
> CONFIG_DVB_M88RS2000=m
> CONFIG_DVB_AF9033=m
> CONFIG_DVB_HORUS3A=m
> CONFIG_DVB_ASCOT2E=m
> CONFIG_DVB_HELENE=m
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=m
> CONFIG_DVB_SP2=m
> # end of Customise DVB Frontends
> 
> #
> # Tools to develop new frontends
> #
> # CONFIG_DVB_DUMMY_FE is not set
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=m
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=64
> CONFIG_VGA_SWITCHEROO=y
> CONFIG_DRM=m
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=m
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=m
> CONFIG_DRM_VRAM_HELPER=m
> CONFIG_DRM_TTM_HELPER=m
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=m
> CONFIG_DRM_I2C_SIL164=m
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=m
> CONFIG_DRM_I915_FORCE_PROBE=""
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> CONFIG_DRM_I915_COMPRESS_ERROR=y
> CONFIG_DRM_I915_USERPTR=y
> CONFIG_DRM_I915_GVT=y
> # CONFIG_DRM_I915_GVT_KVMGT is not set
> CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
> CONFIG_DRM_I915_STOP_TIMEOUT=100
> CONFIG_DRM_I915_TIMESLICE_DURATION=1
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> CONFIG_DRM_GMA500=m
> # CONFIG_DRM_UDL is not set
> CONFIG_DRM_AST=m
> CONFIG_DRM_MGAG200=m
> CONFIG_DRM_QXL=m
> CONFIG_DRM_VIRTIO_GPU=m
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_BOCHS=m
> CONFIG_DRM_CIRRUS_QEMU=m
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_HYPERV is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=m
> CONFIG_FB_SYS_COPYAREA=m
> CONFIG_FB_SYS_IMAGEBLIT=m
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=m
> CONFIG_FB_DEFERRED_IO=y
> # CONFIG_FB_MODE_HELPERS is not set
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_HYPERV=m
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=m
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=m
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_APPLE=m
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=m
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
> 
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HIDRAW=y
> CONFIG_UHID=m
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=m
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=m
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=m
> # CONFIG_HID_APPLEIR is not set
> CONFIG_HID_ASUS=m
> CONFIG_HID_AUREAL=m
> CONFIG_HID_BELKIN=m
> # CONFIG_HID_BETOP_FF is not set
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=m
> CONFIG_HID_CHICONY=m
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_CMEDIA=m
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=m
> CONFIG_HID_DRAGONRISE=m
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELAN is not set
> CONFIG_HID_ELECOM=m
> # CONFIG_HID_ELO is not set
> CONFIG_HID_EZKEY=m
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=m
> CONFIG_HID_GFRM=m
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_GT683R is not set
> CONFIG_HID_KEYTOUCH=m
> CONFIG_HID_KYE=m
> # CONFIG_HID_UCLOGIC is not set
> CONFIG_HID_WALTOP=m
> # CONFIG_HID_VIEWSONIC is not set
> CONFIG_HID_GYRATION=m
> CONFIG_HID_ICADE=m
> CONFIG_HID_ITE=m
> CONFIG_HID_JABRA=m
> CONFIG_HID_TWINHAN=m
> CONFIG_HID_KENSINGTON=m
> CONFIG_HID_LCPOWER=m
> CONFIG_HID_LED=m
> CONFIG_HID_LENOVO=m
> CONFIG_HID_LOGITECH=m
> CONFIG_HID_LOGITECH_DJ=m
> CONFIG_HID_LOGITECH_HIDPP=m
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=m
> CONFIG_HID_MONTEREY=m
> CONFIG_HID_MULTITOUCH=m
> CONFIG_HID_NTI=m
> # CONFIG_HID_NTRIG is not set
> CONFIG_HID_ORTEK=m
> CONFIG_HID_PANTHERLORD=m
> # CONFIG_PANTHERLORD_FF is not set
> # CONFIG_HID_PENMOUNT is not set
> CONFIG_HID_PETALYNX=m
> CONFIG_HID_PICOLCD=m
> CONFIG_HID_PICOLCD_FB=y
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> CONFIG_HID_PICOLCD_LCD=y
> CONFIG_HID_PICOLCD_LEDS=y
> CONFIG_HID_PICOLCD_CIR=y
> CONFIG_HID_PLANTRONICS=m
> # CONFIG_HID_PLAYSTATION is not set
> CONFIG_HID_PRIMAX=m
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> CONFIG_HID_SAITEK=m
> CONFIG_HID_SAMSUNG=m
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SONY is not set
> CONFIG_HID_SPEEDLINK=m
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=m
> CONFIG_HID_SUNPLUS=m
> CONFIG_HID_RMI=m
> CONFIG_HID_GREENASIA=m
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_HYPERV_MOUSE=m
> CONFIG_HID_SMARTJOYPLUS=m
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=m
> CONFIG_HID_TOPSEED=m
> CONFIG_HID_THINGM=m
> CONFIG_HID_THRUSTMASTER=m
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_WACOM is not set
> CONFIG_HID_WIIMOTE=m
> CONFIG_HID_XINMO=m
> CONFIG_HID_ZEROPLUS=m
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=m
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> CONFIG_HID_ALPS=m
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> # CONFIG_HID_PID is not set
> # CONFIG_USB_HIDDEV is not set
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
> 
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=m
> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> # end of Intel ISH HID support
> 
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> CONFIG_USB_MON=y
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI=y
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_REALTEK is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> # CONFIG_USB_UAS is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_SIMPLE is not set
> # CONFIG_USB_SERIAL_AIRCABLE is not set
> # CONFIG_USB_SERIAL_ARK3116 is not set
> # CONFIG_USB_SERIAL_BELKIN is not set
> # CONFIG_USB_SERIAL_CH341 is not set
> # CONFIG_USB_SERIAL_WHITEHEAT is not set
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> # CONFIG_USB_SERIAL_CP210X is not set
> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> # CONFIG_USB_SERIAL_VISOR is not set
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_F81232 is not set
> # CONFIG_USB_SERIAL_F8153X is not set
> # CONFIG_USB_SERIAL_GARMIN is not set
> # CONFIG_USB_SERIAL_IPW is not set
> # CONFIG_USB_SERIAL_IUU is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> # CONFIG_USB_SERIAL_METRO is not set
> # CONFIG_USB_SERIAL_MOS7720 is not set
> # CONFIG_USB_SERIAL_MOS7840 is not set
> # CONFIG_USB_SERIAL_MXUPORT is not set
> # CONFIG_USB_SERIAL_NAVMAN is not set
> # CONFIG_USB_SERIAL_PL2303 is not set
> # CONFIG_USB_SERIAL_OTI6858 is not set
> # CONFIG_USB_SERIAL_QCAUX is not set
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> # CONFIG_USB_SERIAL_SYMBOL is not set
> # CONFIG_USB_SERIAL_TI is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> # CONFIG_USB_SERIAL_OPTION is not set
> # CONFIG_USB_SERIAL_OMNINET is not set
> # CONFIG_USB_SERIAL_OPTICON is not set
> # CONFIG_USB_SERIAL_XSENS_MT is not set
> # CONFIG_USB_SERIAL_WISHBONE is not set
> # CONFIG_USB_SERIAL_SSU100 is not set
> # CONFIG_USB_SERIAL_QT2 is not set
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=m
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> # CONFIG_USB_ATM is not set
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=y
> # CONFIG_TYPEC_TCPM is not set
> CONFIG_TYPEC_UCSI=y
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=y
> # CONFIG_TYPEC_TPS6598X is not set
> # CONFIG_TYPEC_STUSB160X is not set
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> 
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_DP_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
> 
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=m
> CONFIG_MMC_BLOCK=m
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=m
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=m
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_PCI=m
> CONFIG_MMC_RICOH_MMC=y
> CONFIG_MMC_SDHCI_ACPI=m
> CONFIG_MMC_SDHCI_PLTFM=m
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> # CONFIG_MMC_REALTEK_PCI is not set
> CONFIG_MMC_CQHCI=m
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> CONFIG_LEDS_LM3530=m
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=m
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> CONFIG_LEDS_CLEVO_MAIL=m
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2802 is not set
> CONFIG_LEDS_INTEL_SS4200=m
> CONFIG_LEDS_LT3593=m
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=m
> CONFIG_LEDS_MLXCPLD=m
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=m
> CONFIG_LEDS_TRIGGER_ONESHOT=m
> # CONFIG_LEDS_TRIGGER_DISK is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=m
> CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=m
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=m
> CONFIG_LEDS_TRIGGER_CAMERA=m
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> CONFIG_LEDS_TRIGGER_AUDIO=m
> # CONFIG_LEDS_TRIGGER_TTY is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=m
> CONFIG_EDAC_GHES=y
> CONFIG_EDAC_AMD64=m
> CONFIG_EDAC_E752X=m
> CONFIG_EDAC_I82975X=m
> CONFIG_EDAC_I3000=m
> CONFIG_EDAC_I3200=m
> CONFIG_EDAC_IE31200=m
> CONFIG_EDAC_X38=m
> CONFIG_EDAC_I5400=m
> CONFIG_EDAC_I7CORE=m
> CONFIG_EDAC_I5000=m
> CONFIG_EDAC_I5100=m
> CONFIG_EDAC_I7300=m
> CONFIG_EDAC_SBRIDGE=m
> CONFIG_EDAC_SKX=m
> # CONFIG_EDAC_I10NM is not set
> CONFIG_EDAC_PND2=m
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=m
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=m
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=m
> CONFIG_RTC_DRV_MAX6900=m
> CONFIG_RTC_DRV_RS5C372=m
> CONFIG_RTC_DRV_ISL1208=m
> CONFIG_RTC_DRV_ISL12022=m
> CONFIG_RTC_DRV_X1205=m
> CONFIG_RTC_DRV_PCF8523=m
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=m
> CONFIG_RTC_DRV_PCF8583=m
> CONFIG_RTC_DRV_M41T80=m
> CONFIG_RTC_DRV_M41T80_WDT=y
> CONFIG_RTC_DRV_BQ32K=m
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=m
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=m
> CONFIG_RTC_DRV_RX8025=m
> CONFIG_RTC_DRV_EM3027=m
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=m
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=m
> CONFIG_RTC_DRV_DS3232_HWMON=y
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=m
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> CONFIG_RTC_DRV_DS1286=m
> CONFIG_RTC_DRV_DS1511=m
> CONFIG_RTC_DRV_DS1553=m
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=m
> CONFIG_RTC_DRV_DS2404=m
> CONFIG_RTC_DRV_STK17TA8=m
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=m
> CONFIG_RTC_DRV_M48T59=m
> CONFIG_RTC_DRV_MSM6242=m
> CONFIG_RTC_DRV_BQ4802=m
> CONFIG_RTC_DRV_RP5C01=m
> CONFIG_RTC_DRV_V3020=m
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=m
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IOATDMA=m
> # CONFIG_PLX_DMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=m
> CONFIG_DW_DMAC_PCI=y
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> CONFIG_HSU_DMA=y
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=m
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
> 
> CONFIG_DCA=m
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_UIO=m
> CONFIG_UIO_CIF=m
> CONFIG_UIO_PDRV_GENIRQ=m
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=m
> CONFIG_UIO_SERCOS3=m
> CONFIG_UIO_PCI_GENERIC=m
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_HV_GENERIC=m
> CONFIG_VFIO=m
> CONFIG_VFIO_IOMMU_TYPE1=m
> CONFIG_VFIO_VIRQFD=m
> CONFIG_VFIO_NOIOMMU=y
> CONFIG_VFIO_PCI_CORE=m
> CONFIG_VFIO_PCI_MMAP=y
> CONFIG_VFIO_PCI_INTX=y
> CONFIG_VFIO_PCI=m
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> CONFIG_VFIO_MDEV=m
> CONFIG_IRQ_BYPASS_MANAGER=m
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_PCI_LIB=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=m
> CONFIG_VIRTIO_MEM=m
> CONFIG_VIRTIO_INPUT=m
> # CONFIG_VIRTIO_MMIO is not set
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=m
> CONFIG_VHOST=m
> CONFIG_VHOST_MENU=y
> CONFIG_VHOST_NET=m
> # CONFIG_VHOST_SCSI is not set
> CONFIG_VHOST_VSOCK=m
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=m
> CONFIG_HYPERV_TIMER=y
> CONFIG_HYPERV_UTILS=m
> CONFIG_HYPERV_BALLOON=m
> # end of Microsoft Hyper-V guest support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACPI_WMI=m
> CONFIG_WMI_BMOF=m
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> CONFIG_MXM_WMI=m
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> CONFIG_ACERHDF=m
> # CONFIG_ACER_WIRELESS is not set
> CONFIG_ACER_WMI=m
> # CONFIG_AMD_PMC is not set
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=m
> CONFIG_ASUS_LAPTOP=m
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ASUS_WMI=m
> CONFIG_ASUS_NB_WMI=m
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=m
> CONFIG_EEEPC_WMI=m
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_AMILO_RFKILL=m
> CONFIG_FUJITSU_LAPTOP=m
> CONFIG_FUJITSU_TABLET=m
> # CONFIG_GPD_POCKET_FAN is not set
> CONFIG_HP_ACCEL=m
> # CONFIG_WIRELESS_HOTKEY is not set
> CONFIG_HP_WMI=m
> # CONFIG_IBM_RTL is not set
> CONFIG_IDEAPAD_LAPTOP=m
> CONFIG_SENSORS_HDAPS=m
> CONFIG_THINKPAD_ACPI=m
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=y
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
> # CONFIG_THINKPAD_LMI is not set
> CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> CONFIG_INTEL_PMC_CORE=m
> 
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
> 
> CONFIG_INTEL_WMI=y
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=m
> CONFIG_INTEL_HID_EVENT=m
> CONFIG_INTEL_VBTN=m
> # CONFIG_INTEL_INT0002_VGPIO is not set
> CONFIG_INTEL_OAKTRAIL=m
> # CONFIG_INTEL_PUNIT_IPC is not set
> CONFIG_INTEL_RST=m
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TURBO_MAX_3=y
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> CONFIG_MSI_LAPTOP=m
> CONFIG_MSI_WMI=m
> # CONFIG_PCENGINES_APU2 is not set
> CONFIG_SAMSUNG_LAPTOP=m
> CONFIG_SAMSUNG_Q10=m
> CONFIG_TOSHIBA_BT_RFKILL=m
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=m
> CONFIG_COMPAL_LAPTOP=m
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=m
> CONFIG_SONY_LAPTOP=m
> CONFIG_SONYPI_COMPAT=y
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=m
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> CONFIG_MLX_PLATFORM=m
> CONFIG_INTEL_IPS=m
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=y
> CONFIG_MLXREG_HOTPLUG=m
> # CONFIG_MLXREG_IO is not set
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Clock driver for ARM Reference designs
> #
> # CONFIG_ICST is not set
> # CONFIG_CLK_SP810 is not set
> # end of Clock driver for ARM Reference designs
> 
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOASID=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=y
> # CONFIG_AMD_IOMMU is not set
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> # CONFIG_INTEL_IOMMU_SVM is not set
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
> CONFIG_IRQ_REMAP=y
> CONFIG_HYPERV_IOMMU=y
> # CONFIG_VIRTIO_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> CONFIG_NTB=m
> # CONFIG_NTB_MSI is not set
> # CONFIG_NTB_AMD is not set
> # CONFIG_NTB_IDT is not set
> # CONFIG_NTB_INTEL is not set
> # CONFIG_NTB_EPF is not set
> # CONFIG_NTB_SWITCHTEC is not set
> # CONFIG_NTB_PINGPONG is not set
> # CONFIG_NTB_TOOL is not set
> # CONFIG_NTB_PERF is not set
> # CONFIG_NTB_TRANSPORT is not set
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_DWC is not set
> CONFIG_PWM_LPSS=m
> CONFIG_PWM_LPSS_PCI=m
> CONFIG_PWM_LPSS_PLATFORM=m
> # CONFIG_PWM_PCA9685 is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> 
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL_CORE=m
> CONFIG_INTEL_RAPL=m
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_DTPM is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_RAS_CEC is not set
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=m
> CONFIG_BLK_DEV_PMEM=m
> CONFIG_ND_BLK=m
> CONFIG_ND_CLAIM=y
> CONFIG_ND_BTT=m
> CONFIG_BTT=y
> CONFIG_ND_PFN=m
> CONFIG_NVDIMM_PFN=y
> CONFIG_NVDIMM_DAX=y
> CONFIG_NVDIMM_KEYS=y
> CONFIG_DAX_DRIVER=y
> CONFIG_DAX=y
> CONFIG_DEV_DAX=m
> CONFIG_DEV_DAX_PMEM=m
> CONFIG_DEV_DAX_KMEM=m
> CONFIG_DEV_DAX_PMEM_COMPAT=m
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=m
> # CONFIG_STM_PROTO_BASIC is not set
> # CONFIG_STM_PROTO_SYS_T is not set
> CONFIG_STM_DUMMY=m
> CONFIG_STM_SOURCE_CONSOLE=m
> CONFIG_STM_SOURCE_HEARTBEAT=m
> CONFIG_STM_SOURCE_FTRACE=m
> CONFIG_INTEL_TH=m
> CONFIG_INTEL_TH_PCI=m
> CONFIG_INTEL_TH_ACPI=m
> CONFIG_INTEL_TH_GTH=m
> CONFIG_INTEL_TH_STH=m
> CONFIG_INTEL_TH_MSU=m
> CONFIG_INTEL_TH_PTI=m
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_UNISYS_VISORBUS is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=m
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=m
> CONFIG_XFS_SUPPORT_V4=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> CONFIG_XFS_RT=y
> CONFIG_XFS_ONLINE_SCRUB=y
> # CONFIG_XFS_ONLINE_REPAIR is not set
> CONFIG_XFS_DEBUG=y
> CONFIG_XFS_ASSERT_FATAL=y
> CONFIG_GFS2_FS=m
> CONFIG_GFS2_FS_LOCKING_DLM=y
> CONFIG_OCFS2_FS=m
> CONFIG_OCFS2_FS_O2CB=m
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
> CONFIG_OCFS2_FS_STATS=y
> CONFIG_OCFS2_DEBUG_MASKLOG=y
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> CONFIG_F2FS_FS=m
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> CONFIG_F2FS_FS_POSIX_ACL=y
> # CONFIG_F2FS_FS_SECURITY is not set
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=y
> CONFIG_FS_DAX=y
> CONFIG_FS_DAX_PMD=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=m
> CONFIG_CUSE=m
> # CONFIG_VIRTIO_FS is not set
> CONFIG_OVERLAY_FS=m
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=m
> CONFIG_NETFS_STATS=y
> CONFIG_FSCACHE=m
> CONFIG_FSCACHE_STATS=y
> # CONFIG_FSCACHE_DEBUG is not set
> CONFIG_CACHEFILES=m
> # CONFIG_CACHEFILES_DEBUG is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=m
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
> # CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=m
> CONFIG_CRAMFS_BLOCKDEV=y
> CONFIG_SQUASHFS=m
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=m
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=m
> CONFIG_PNFS_BLOCK=m
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=y
> CONFIG_ROOT_NFS=y
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DEBUG=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_PNFS=y
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> CONFIG_NFSD_SCSILAYOUT=y
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=y
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=y
> CONFIG_NFS_COMMON=y
> CONFIG_NFS_V4_2_SSC_HELPER=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> CONFIG_SUNRPC_BACKCHANNEL=y
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> CONFIG_SUNRPC_DEBUG=y
> CONFIG_CEPH_FS=m
> # CONFIG_CEPH_FSCACHE is not set
> CONFIG_CEPH_FS_POSIX_ACL=y
> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> CONFIG_CIFS_UPCALL=y
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=y
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=m
> CONFIG_NLS_CODEPAGE_850=m
> CONFIG_NLS_CODEPAGE_852=m
> CONFIG_NLS_CODEPAGE_855=m
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=m
> CONFIG_NLS_CODEPAGE_862=m
> CONFIG_NLS_CODEPAGE_863=m
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=m
> CONFIG_NLS_CODEPAGE_866=m
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=m
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=m
> CONFIG_NLS_CODEPAGE_949=m
> CONFIG_NLS_CODEPAGE_874=m
> CONFIG_NLS_ISO8859_8=m
> CONFIG_NLS_CODEPAGE_1250=m
> CONFIG_NLS_CODEPAGE_1251=m
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=m
> CONFIG_NLS_ISO8859_2=m
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=m
> CONFIG_NLS_ISO8859_5=m
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=m
> CONFIG_NLS_ISO8859_9=m
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> CONFIG_NLS_KOI8_U=m
> CONFIG_NLS_MAC_ROMAN=m
> CONFIG_NLS_MAC_CELTIC=m
> CONFIG_NLS_MAC_CENTEURO=m
> CONFIG_NLS_MAC_CROATIAN=m
> CONFIG_NLS_MAC_CYRILLIC=m
> CONFIG_NLS_MAC_GAELIC=m
> CONFIG_NLS_MAC_GREEK=m
> CONFIG_NLS_MAC_ICELAND=m
> CONFIG_NLS_MAC_INUIT=m
> CONFIG_NLS_MAC_ROMANIAN=m
> CONFIG_NLS_MAC_TURKISH=m
> CONFIG_NLS_UTF8=m
> CONFIG_DLM=m
> CONFIG_DLM_DEBUG=y
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_TRUSTED_KEYS=y
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITY_WRITABLE_HOOKS=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_NETWORK_XFRM=y
> CONFIG_SECURITY_PATH=y
> CONFIG_INTEL_TXT=y
> CONFIG_LSM_MMAP_MIN_ADDR=65535
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_DISABLE=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_SECURITY_APPARMOR_HASH=y
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=y
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH="sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> # CONFIG_IMA_READ_POLICY is not set
> CONFIG_IMA_APPRAISE=y
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> # CONFIG_IMA_APPRAISE_MODSIG is not set
> CONFIG_IMA_TRUSTED_KEYRING=y
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> # CONFIG_EVM_ADD_XATTRS is not set
> # CONFIG_EVM_LOAD_X509 is not set
> CONFIG_DEFAULT_SECURITY_SELINUX=y
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=m
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> CONFIG_CRYPTO_USER=m
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=m
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=m
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_SIMD=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=m
> CONFIG_CRYPTO_ECC=m
> CONFIG_CRYPTO_ECDH=m
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=m
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=m
> # CONFIG_CRYPTO_OFB is not set
> CONFIG_CRYPTO_PCBC=m
> CONFIG_CRYPTO_XTS=m
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ESSIV=m
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=m
> CONFIG_CRYPTO_VMAC=m
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=m
> CONFIG_CRYPTO_CRC32=m
> CONFIG_CRYPTO_CRC32_PCLMUL=m
> CONFIG_CRYPTO_XXHASH=m
> CONFIG_CRYPTO_BLAKE2B=m
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=m
> CONFIG_CRYPTO_POLY1305_X86_64=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_RMD160=m
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> CONFIG_CRYPTO_SHA256_SSSE3=y
> CONFIG_CRYPTO_SHA512_SSSE3=m
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=m
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_ANUBIS=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> CONFIG_CRYPTO_BLOWFISH_X86_64=m
> CONFIG_CRYPTO_CAMELLIA=m
> CONFIG_CRYPTO_CAMELLIA_X86_64=m
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
> CONFIG_CRYPTO_CAST_COMMON=m
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST5_AVX_X86_64=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_CAST6_AVX_X86_64=m
> CONFIG_CRYPTO_DES=m
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> CONFIG_CRYPTO_FCRYPT=m
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_CHACHA20=m
> CONFIG_CRYPTO_CHACHA20_X86_64=m
> CONFIG_CRYPTO_SEED=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
> # CONFIG_CRYPTO_SM4 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_TWOFISH_COMMON=m
> CONFIG_CRYPTO_TWOFISH_X86_64=m
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_USER_API_SKCIPHER=y
> CONFIG_CRYPTO_USER_API_RNG=y
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
> # CONFIG_CRYPTO_STATS is not set
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=m
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=m
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=m
> CONFIG_CRYPTO_DEV_PADLOCK_AES=m
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=m
> CONFIG_CRYPTO_DEV_SP_CCP=y
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
> CONFIG_CRYPTO_DEV_SP_PSP=y
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> CONFIG_CRYPTO_DEV_QAT=m
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
> CONFIG_CRYPTO_DEV_QAT_C3XXX=m
> CONFIG_CRYPTO_DEV_QAT_C62X=m
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
> CONFIG_CRYPTO_DEV_QAT_C62XVF=m
> CONFIG_CRYPTO_DEV_NITROX=m
> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_RAID6_PQ_BENCHMARK=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_CORDIC=m
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=m
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=m
> CONFIG_CRC8=m
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=m
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=m
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=m
> CONFIG_TEXTSEARCH_BM=m
> CONFIG_TEXTSEARCH_FSM=m
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_COPY_MC=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> CONFIG_ASN1_ENCODER=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=y
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_STACK_VALIDATION=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_OBJTOOL_MCOUNT=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_FUNCTION_PROFILER=y
> CONFIG_STACK_TRACER=y
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_SCHED_TRACER=y
> CONFIG_HWLAT_TRACER=y
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENTS=y
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> # CONFIG_BPF_KPROBE_OVERRIDE is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_CC=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> CONFIG_HIST_TRIGGERS=y
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=m
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_X86_DECODER_SELFTEST=y
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_KPROBES_SANITY_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> CONFIG_TEST_BPF=m
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_LIVEPATCH is not set
> # CONFIG_TEST_STACKINIT is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='will-it-scale'
> 	export testcase='will-it-scale'
> 	export category='benchmark'
> 	export nr_task=16
> 	export job_origin='will-it-scale-part4.yaml'
> 	export testbox='lkp-hsw-4ex1'
> 	export arch='x86_64'
> 	export tbox_group='lkp-hsw-4ex1'
> 	export serial_servers='lkp-wildcat lkp-nhm-dp2 lkp-nhm-d01 lkp-serial02 lkp-serial03 lkp-serial04'
> 	export boot_watchdog_mail='ignore'
> 	export queue_cmdline_keys=
> 	export schedule_notify_address=
> 	export queue='vip'
> 	export branch='linus/master'
> 	export commit='3aac3ebea08f2d342364f827c8979ab0e1dd591e'
> 	export kconfig='x86_64-rhel-8.3'
> 	export submit_id='61a866eb0b9a93fb97f8a107'
> 	export job_file='/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-thread-16-signal1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-3aac3ebea08f2d342364f827c8979ab0e1dd591e-20211202-64407-vaznym-0.yaml'
> 	export id='b18865e73bc3268790d6bce8b871591cb54175ce'
> 	export queuer_version='/lkp/xsang/.src-20211202-092226'
> 	export model='Haswell-EX'
> 	export nr_node=4
> 	export nr_cpu=144
> 	export memory='512G'
> 	export nr_ssd_partitions=1
> 	export nr_hdd_partitions=1
> 	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50067bdf9c3-part1'
> 	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e40003aeb61-part1'
> 	export swap_partitions=
> 	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e404c2e98e3-part1'
> 	export brand='Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz'
> 	export ucode='0x16'
> 	export kernel_cmdline_hw='cma=0'
> 	export need_kconfig_hw='{"IXGBE"=>"y"}
> SCSI_MPT3SAS
> SATA_AHCI'
> 	export bisect_dmesg=true
> 	export rootfs='debian-10.4-x86_64-20200603.cgz'
> 	export enqueue_time='2021-12-02 14:25:47 +0800'
> 	export compiler='gcc-9'
> 	export _id='61a866eb0b9a93fb97f8a107'
> 	export _rt='/result/will-it-scale/performance-thread-16-signal1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/vmlinuz-5.15.0-rc5-00088-g3aac3ebea08f'
> 	export result_root='/result/will-it-scale/performance-thread-16-signal1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/8'
> 	export dequeue_time='2021-12-02 15:25:08 +0800'
> 	export scheduler_version='/lkp/lkp/.src-20211202-144518'
> 	export max_uptime=2100
> 	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-thread-16-signal1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-3aac3ebea08f2d342364f827c8979ab0e1dd591e-20211202-64407-vaznym-0.yaml
> ARCH=x86_64
> kconfig=x86_64-rhel-8.3
> branch=linus/master
> commit=3aac3ebea08f2d342364f827c8979ab0e1dd591e
> BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/vmlinuz-5.15.0-rc5-00088-g3aac3ebea08f
> cma=0
> max_uptime=2100
> RESULT_ROOT=/result/will-it-scale/performance-thread-16-signal1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/8
> LKP_SERVER=internal-lkp-server
> nokaslr
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/will-it-scale_20210906.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/will-it-scale-x86_64-a34a85c-1_20211201.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211128.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-4f0dda359c45-1_20211127.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
> 	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export job_initrd='/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-thread-16-signal1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-3aac3ebea08f2d342364f827c8979ab0e1dd591e-20211202-64407-vaznym-0.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper uptime
> 	run_monitor $LKP_SRC/monitors/wrapper iostat
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper proc-stat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper slabinfo
> 	run_monitor $LKP_SRC/monitors/wrapper interrupts
> 	run_monitor $LKP_SRC/monitors/wrapper lock_stat
> 	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
> 	run_monitor $LKP_SRC/monitors/wrapper softirqs
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
> 	run_monitor $LKP_SRC/monitors/wrapper diskstats
> 	run_monitor $LKP_SRC/monitors/wrapper nfsstat
> 	run_monitor $LKP_SRC/monitors/wrapper cpuidle
> 	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
> 	run_monitor $LKP_SRC/monitors/wrapper turbostat
> 	run_monitor $LKP_SRC/monitors/wrapper sched_debug
> 	run_monitor $LKP_SRC/monitors/wrapper perf-stat
> 	run_monitor $LKP_SRC/monitors/wrapper mpstat
> 	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
> 	run_monitor $LKP_SRC/monitors/wrapper syscalls
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test mode='thread' test='signal1' $LKP_SRC/tests/wrapper will-it-scale
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	env mode='thread' test='signal1' $LKP_SRC/stats/wrapper will-it-scale
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper uptime
> 	$LKP_SRC/stats/wrapper iostat
> 	$LKP_SRC/stats/wrapper vmstat
> 	$LKP_SRC/stats/wrapper numa-numastat
> 	$LKP_SRC/stats/wrapper numa-vmstat
> 	$LKP_SRC/stats/wrapper numa-meminfo
> 	$LKP_SRC/stats/wrapper proc-vmstat
> 	$LKP_SRC/stats/wrapper meminfo
> 	$LKP_SRC/stats/wrapper slabinfo
> 	$LKP_SRC/stats/wrapper interrupts
> 	$LKP_SRC/stats/wrapper lock_stat
> 	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
> 	$LKP_SRC/stats/wrapper softirqs
> 	$LKP_SRC/stats/wrapper diskstats
> 	$LKP_SRC/stats/wrapper nfsstat
> 	$LKP_SRC/stats/wrapper cpuidle
> 	$LKP_SRC/stats/wrapper turbostat
> 	$LKP_SRC/stats/wrapper sched_debug
> 	$LKP_SRC/stats/wrapper perf-stat
> 	$LKP_SRC/stats/wrapper mpstat
> 	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile
> 	$LKP_SRC/stats/wrapper syscalls
> 
> 	$LKP_SRC/stats/wrapper time will-it-scale.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"

> ---
> :#! jobs/will-it-scale-part4.yaml:
> suite: will-it-scale
> testcase: will-it-scale
> category: benchmark
> nr_task: 16
> will-it-scale:
>   mode: thread
>   test: signal1
> job_origin: will-it-scale-part4.yaml
> :#! queue options:
> queue_cmdline_keys:
> - branch
> - commit
> - queue_at_least_once
> queue: bisect
> testbox: lkp-hsw-4ex1
> tbox_group: lkp-hsw-4ex1
> kconfig: x86_64-rhel-8.3
> submit_id: 61974237ee612662cdc02cac
> job_file: "/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-thread-16-signal1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-3aac3ebea08f2d342364f827c8979ab0e1dd591e-20211119-25293-1xwl88w-2.yaml"
> id: accafc438a742cc8ba0870fe939abce809c22e1a
> queuer_version: "/lkp-src"
> :#! hosts/lkp-hsw-4ex1:
> model: Haswell-EX
> nr_node: 4
> nr_cpu: 144
> memory: 512G
> nr_ssd_partitions: 1
> nr_hdd_partitions: 1
> hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50067bdf9c3-part1"
> ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL41710016800RGN-part1"
> swap_partitions:
> rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K3400NGN-part1"
> brand: Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz
> :#! include/category/benchmark:
> kmsg:
> boot-time:
> uptime:
> iostat:
> heartbeat:
> vmstat:
> numa-numastat:
> numa-vmstat:
> numa-meminfo:
> proc-vmstat:
> proc-stat:
> meminfo:
> slabinfo:
> interrupts:
> lock_stat:
> perf-sched:
>   lite_mode: 1
> softirqs:
> bdi_dev_mapping:
> diskstats:
> nfsstat:
> cpuidle:
> cpufreq-stats:
> turbostat:
> sched_debug:
> perf-stat:
> mpstat:
> perf-profile:
>   lite_mode: 1
> :#! include/category/ALL:
> cpufreq_governor: performance
> :#! include/queue/cyclic:
> commit: 3aac3ebea08f2d342364f827c8979ab0e1dd591e
> :#! include/testbox/lkp-hsw-4ex1:
> syscalls:
> ucode: '0x16'
> kernel_cmdline_hw: cma=0
> need_kconfig_hw:
> - IXGBE: y
> - SCSI_MPT3SAS
> - SATA_AHCI
> bisect_dmesg: true
> enqueue_time: 2021-11-19 14:20:39.278604666 +08:00
> _id: 61975062ee612662cdc02cae
> _rt: "/result/will-it-scale/performance-thread-16-signal1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e"
> :#! schedule options:
> user: lkp
> compiler: gcc-9
> LKP_SERVER: internal-lkp-server
> head_commit: 853b3fee2abc699bce0c12f889b12c8efb65c38b
> base_commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> branch: linux-devel/devel-hourly-20211115-110950
> rootfs: debian-10.4-x86_64-20200603.cgz
> result_root: "/result/will-it-scale/performance-thread-16-signal1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/1"
> scheduler_version: "/lkp/lkp/.src-20211118-213456"
> arch: x86_64
> max_uptime: 2100
> initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
> bootloader_append:
> - root=/dev/ram0
> - user=lkp
> - job=/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-thread-16-signal1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-3aac3ebea08f2d342364f827c8979ab0e1dd591e-20211119-25293-1xwl88w-2.yaml
> - ARCH=x86_64
> - kconfig=x86_64-rhel-8.3
> - branch=linux-devel/devel-hourly-20211115-110950
> - commit=3aac3ebea08f2d342364f827c8979ab0e1dd591e
> - BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/vmlinuz-5.15.0-rc5-00088-g3aac3ebea08f
> - cma=0
> - max_uptime=2100
> - RESULT_ROOT=/result/will-it-scale/performance-thread-16-signal1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/1
> - LKP_SERVER=internal-lkp-server
> - nokaslr
> - selinux=0
> - debug
> - apic=debug
> - sysrq_always_enabled
> - rcupdate.rcu_cpu_stall_timeout=100
> - net.ifnames=0
> - printk.devkmsg=on
> - panic=-1
> - softlockup_panic=1
> - nmi_watchdog=panic
> - oops=panic
> - load_ramdisk=2
> - prompt_ramdisk=0
> - drbd.minor_count=8
> - systemd.log_level=err
> - ignore_loglevel
> - console=tty0
> - earlyprintk=ttyS0,115200
> - console=ttyS0,115200
> - vga=normal
> - rw
> modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/modules.cgz"
> bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/will-it-scale_20210906.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/will-it-scale-x86_64-a34a85c-1_20211108.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211114.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-ccfff0a2bd2a-1_20211113.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
> ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> site: inn
> :#! /lkp/lkp/.src-20211117-140011/include/site/inn:
> LKP_CGI_PORT: 80
> LKP_CIFS_PORT: 139
> oom-killer:
> watchdog:
> :#! runtime status:
> last_kernel: 5.15.0-rc5-00088-g3aac3ebea08f
> repeat_to: 3
> schedule_notify_address:
> :#! user overrides:
> queue_at_least_once: 0
> kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3aac3ebea08f2d342364f827c8979ab0e1dd591e/vmlinuz-5.15.0-rc5-00088-g3aac3ebea08f"
> dequeue_time: 2021-11-19 15:33:13.789026489 +08:00
> :#! /cephfs/db/releases/20211118215618/lkp-src/include/site/inn:
> job_state: finished
> loadavg: 9.49 9.38 4.46 1/1066 18864
> start_time: '1637307290'
> end_time: '1637307591'
> version: "/lkp/lkp/.src-20211118-213535:f3e25d58:eeb639dcd"

> 
> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
> do
> 	online_file="$cpu_dir"/online
> 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
> 
> 	file="$cpu_dir"/cpufreq/scaling_governor
> 	[ -f "$file" ] && echo "performance" > "$file"
> done
> 
>  "/lkp/benchmarks/python3/bin/python3" "./runtest.py" "signal1" "295" "thread" "16"


--dTy3Mrz/UPE2dbVg
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
WVo=

--dTy3Mrz/UPE2dbVg
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-parent.xz"
Content-Transfer-Encoding: base64

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

--dTy3Mrz/UPE2dbVg--
