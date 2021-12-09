Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9846E0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhLICgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:36:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:17777 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhLICgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:36:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235512392"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="235512392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:33:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="463037538"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.92])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:33:01 -0800
Date:   Thu, 9 Dec 2021 10:30:33 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, fengwei.yin@intel.com
Subject: Re: [LKP] Re: [x86/signal]  3aac3ebea0:
  will-it-scale.per_thread_ops -11.9% regression
Message-ID: <20211209023032.GA8503@linux.intel.com>
References: <20211207012128.GA16074@xsang-OptiPlex-9020>
 <87bl1s357p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl1s357p.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Dec 07, 2021 at 02:38:34PM +0100, Thomas Gleixner wrote:
> Hi!
> 
> On Tue, Dec 07 2021 at 09:21, kernel test robot wrote:
> 
> > (please be noted we made some further analysis before reporting out,
> > and thought it's likely the regression is related with the extra spinlock
> > introducded by enalbling DYNAMIC_SIGFRAME. below is the full report.)
> >
> > FYI, we noticed a -11.9% regression of will-it-scale.per_thread_ops due to commit:
> 
> Does that use sigaltstack() ?
> 
> > 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >     754824 ±  2%     -11.9%     664668 ±  2%  will-it-scale.16.threads
> >      47176 ±  2%     -11.9%      41541 ±  2%  will-it-scale.per_thread_ops
> >     754824 ±  2%     -11.9%     664668 ±  2%  will-it-scale.workload
> >    1422782 ±  8%  +3.3e+05     1751520 ± 12%  syscalls.sys_getpid.noise.5%
> 
> Somehow the printout got confused ...
> 
> >  1.583e+10            -2.1%   1.55e+10        perf-stat.i.instructions
> >    6328594 ±  2%     +11.1%    7032338 ±  2%  perf-stat.overall.path-length
> >  1.578e+10            -2.1%  1.545e+10        perf-stat.ps.instructions
> >  4.774e+12            -2.2%  4.671e+12        perf-stat.total.instructions
> >       0.00            +6.3        6.33 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn
> >       0.00            +6.5        6.51 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
> >       0.00            +6.6        6.58 ±  8%  perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +6.6        6.62 ±  8%  perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
> >       0.00            +6.9        6.88 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
> >       7.99 ± 12%      +6.0       14.00 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
> >       0.05 ± 44%      +6.6        6.62 ±  8%  perf-profile.children.cycles-pp.restore_altstack
> >       0.00            +6.6        6.58 ±  8%  perf-profile.children.cycles-pp.do_sigaltstack
> 
> It looks like it does. The problem is that sighand->lock is process
> wide.
> 
> Can you test whether the below cures it?
> 

We applied your patch upon mainline commit 2a987e6502 ("Merge tag 
'perf-tools-fixes-for-v5.16-2021-12-07' of 
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux"), it will bring 9% 
improvement. Thanks.

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/16/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/signal1/will-it-scale/0x16

commit: 
  2a987e6502 ("Merge tag 'perf-tools-fixes-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")
  fceec50b60 ("fixup-for-2a987e6502")

2a987e65025e2b79 fceec50b600c90a3a3ac3406c03 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    660062 ±  2%      +9.0%     719344        will-it-scale.16.threads
     41253 ±  2%      +9.0%      44958        will-it-scale.per_thread_ops
    660062 ±  2%      +9.0%     719344        will-it-scale.workload
     38126 ± 35%      -6.2%      35753 ± 12%  syscalls.sys_getpid.max
    347.25            -0.4%     346.00        syscalls.sys_getpid.med
    324.00            -0.2%     323.50        syscalls.sys_getpid.min
    866263 ±  7%  -44781.2      821482 ± 10%  syscalls.sys_getpid.noise.100%
   1916161 ±  5%  -64520.2     1851640 ±  4%  syscalls.sys_getpid.noise.2%
   1268029 ±  5%  -50154.5     1217875 ±  7%  syscalls.sys_getpid.noise.25%
   1722829 ±  7%    -1e+05     1621521 ±  5%  syscalls.sys_getpid.noise.5%
   1167288 ±  5%  -40972.4     1126316 ±  8%  syscalls.sys_getpid.noise.50%
   1072219 ±  6%  -53120.8     1019098 ±  8%  syscalls.sys_getpid.noise.75%
     54168 ± 39%     -38.5%      33334 ± 15%  syscalls.sys_gettid.max
    333.75            -0.2%     333.00        syscalls.sys_gettid.med
    315.75            -0.2%     315.00        syscalls.sys_gettid.min
    923814 ± 13%  -1.3e+05      795012 ± 11%  syscalls.sys_gettid.noise.100%
   1909235 ±  6%  -1.2e+05     1788745 ±  5%  syscalls.sys_gettid.noise.2%
   1254536 ± 10%  -1.2e+05     1134475 ±  7%  syscalls.sys_gettid.noise.25%
   1664843 ±  8%  -1.2e+05     1544153 ±  6%  syscalls.sys_gettid.noise.5%
   1209931 ± 10%  -1.2e+05     1092160 ±  7%  syscalls.sys_gettid.noise.50%
   1120212 ± 10%  -1.2e+05     1004727 ±  8%  syscalls.sys_gettid.noise.75%
  3.64e+09 ±  8%     +83.1%  6.666e+09 ± 92%  syscalls.sys_read.max
      1837 ±  2%      +3.6%       1902        syscalls.sys_read.med
    669.75 ±  3%      +1.7%     681.33 ±  4%  syscalls.sys_read.min
 8.308e+11        +2.5e+10   8.556e+11 ±  8%  syscalls.sys_read.noise.100%
 8.308e+11        +2.5e+10   8.557e+11 ±  8%  syscalls.sys_read.noise.2%
 8.308e+11        +2.5e+10   8.557e+11 ±  8%  syscalls.sys_read.noise.25%
 8.308e+11        +2.5e+10   8.557e+11 ±  8%  syscalls.sys_read.noise.5%
 8.308e+11        +2.5e+10   8.557e+11 ±  8%  syscalls.sys_read.noise.50%
 8.308e+11        +2.5e+10   8.557e+11 ±  8%  syscalls.sys_read.noise.75%
  27686929 ±172%     -47.1%   14660048 ±219%  syscalls.sys_rt_sigprocmask.max
      7603 ±  2%      +1.1%       7689        syscalls.sys_rt_sigprocmask.med
    554.75 ±  5%      +4.1%     577.67 ±  9%  syscalls.sys_rt_sigprocmask.min
  59550208 ±117%  -2.3e+07    36678292 ±117%  syscalls.sys_rt_sigprocmask.noise.100%
  99385689 ± 69%  -2.4e+07    75649798 ± 55%  syscalls.sys_rt_sigprocmask.noise.2%
  70154045 ± 98%  -2.3e+07    47366143 ± 89%  syscalls.sys_rt_sigprocmask.noise.25%
  96889781 ± 71%  -2.4e+07    72970986 ± 57%  syscalls.sys_rt_sigprocmask.noise.5%
  65994619 ±105%  -2.2e+07    43517676 ± 97%  syscalls.sys_rt_sigprocmask.noise.50%
  62923250 ±110%  -2.3e+07    40273591 ±106%  syscalls.sys_rt_sigprocmask.noise.75%
  28208603 ±171%     -32.8%   18960706 ±220%  syscalls.sys_tgkill.max
      7711 ±  2%      +4.8%       8080        syscalls.sys_tgkill.med
      1337 ±  2%      +1.9%       1362 ±  2%  syscalls.sys_tgkill.min
  51870512 ±109%  -9.8e+06    42069157 ±126%  syscalls.sys_tgkill.noise.100%
 1.015e+08 ± 54%  -1.5e+07    86618122 ± 61%  syscalls.sys_tgkill.noise.2%
  68743216 ± 80%  -1.3e+07    55954685 ± 95%  syscalls.sys_tgkill.noise.25%
  99442048 ± 55%  -1.5e+07    83995198 ± 63%  syscalls.sys_tgkill.noise.5%
  59229382 ± 95%  -9.1e+06    50108976 ±106%  syscalls.sys_tgkill.noise.50%
  55423780 ±101%  -9.6e+06    45845571 ±116%  syscalls.sys_tgkill.noise.75%
      7.13 ± 23%      +7.6%       7.68 ±  7%  perf-stat.i.MPKI
 3.518e+09            -0.1%  3.517e+09        perf-stat.i.branch-instructions
      1.02 ± 18%      +0.1        1.11 ±  6%  perf-stat.i.branch-miss-rate%
  35924567 ± 18%      +9.0%   39155875 ±  6%  perf-stat.i.branch-misses
      0.25 ± 42%      -0.0        0.21 ± 26%  perf-stat.i.cache-miss-rate%
    254920 ±  8%      -0.5%     253744 ± 15%  perf-stat.i.cache-misses
 1.105e+08 ± 24%      +8.2%  1.196e+08 ±  7%  perf-stat.i.cache-references
      1924            -0.6%       1912        perf-stat.i.context-switches
      3.39 ±  2%      +0.0%       3.39        perf-stat.i.cpi
    144011            +0.0%     144013        perf-stat.i.cpu-clock
 5.251e+10 ±  3%      +0.6%  5.283e+10        perf-stat.i.cpu-cycles
    149.17            -0.3%     148.80        perf-stat.i.cpu-migrations
    238223 ± 10%      +3.4%     246267 ± 11%  perf-stat.i.cycles-between-cache-misses
      0.17 ± 17%      +0.0        0.19 ±  6%  perf-stat.i.dTLB-load-miss-rate%
   7107283 ± 17%     +12.4%    7986549 ±  5%  perf-stat.i.dTLB-load-misses
 4.219e+09            +1.7%   4.29e+09        perf-stat.i.dTLB-loads
      0.28            +0.0        0.28        perf-stat.i.dTLB-store-miss-rate%
   4776002 ±  7%      +9.6%    5232957 ±  2%  perf-stat.i.dTLB-store-misses
 1.707e+09 ±  8%      +8.5%  1.852e+09 ±  3%  perf-stat.i.dTLB-stores
     76.72 ±  5%      +2.6       79.30 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   7312020 ±  9%      +6.8%    7811089 ±  2%  perf-stat.i.iTLB-load-misses
   2197456 ± 17%      -7.8%    2024986 ±  6%  perf-stat.i.iTLB-loads
 1.551e+10            +0.6%   1.56e+10        perf-stat.i.instructions
      2153 ±  8%      -6.4%       2016 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.30 ±  2%      -0.0%       0.30        perf-stat.i.ipc
      1.01 ±  3%      +1.4%       1.02 ±  3%  perf-stat.i.major-faults
      0.36 ±  3%      +0.6%       0.37        perf-stat.i.metric.GHz
    811.17 ± 22%      +7.8%     874.34 ±  6%  perf-stat.i.metric.K/sec
     65.59            +2.3%      67.08        perf-stat.i.metric.M/sec
      3816            -0.1%       3812        perf-stat.i.minor-faults
     94.33            +0.6       94.95        perf-stat.i.node-load-miss-rate%
    155138 ± 18%      -2.8%     150833 ± 20%  perf-stat.i.node-load-misses
     17825 ± 11%     -18.6%      14509 ±  6%  perf-stat.i.node-loads
     61.65 ±  7%      +3.6       65.20 ±  4%  perf-stat.i.node-store-miss-rate%
     53253 ± 11%      -1.7%      52341 ±  2%  perf-stat.i.node-store-misses
     36553 ± 18%     -12.1%      32126 ± 19%  perf-stat.i.node-stores
      3817            -0.1%       3813        perf-stat.i.page-faults
    144011            +0.0%     144013        perf-stat.i.task-clock
      7.12 ± 23%      +7.7%       7.66 ±  7%  perf-stat.overall.MPKI
      1.02 ± 17%      +0.1        1.11 ±  6%  perf-stat.overall.branch-miss-rate%
      0.26 ± 43%      -0.0        0.22 ± 26%  perf-stat.overall.cache-miss-rate%
      3.39 ±  2%      -0.0%       3.39        perf-stat.overall.cpi
    207309 ± 10%      +2.3%     211978 ± 12%  perf-stat.overall.cycles-between-cache-misses
      0.17 ± 17%      +0.0        0.19 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.28            +0.0        0.28        perf-stat.overall.dTLB-store-miss-rate%
     76.78 ±  5%      +2.6       79.39 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      2139 ±  8%      -6.5%       2000 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.30 ±  2%      -0.1%       0.30        perf-stat.overall.ipc
     89.49            +1.5       90.98        perf-stat.overall.node-load-miss-rate%
     59.42 ±  7%      +2.8       62.26 ±  6%  perf-stat.overall.node-store-miss-rate%
   7090142            -7.8%    6537840        perf-stat.overall.path-length
 3.507e+09            -0.1%  3.505e+09        perf-stat.ps.branch-instructions
  35849751 ± 18%      +9.0%   39063558 ±  6%  perf-stat.ps.branch-misses
    254856 ±  8%      -0.5%     253483 ± 15%  perf-stat.ps.cache-misses
 1.101e+08 ± 24%      +8.2%  1.192e+08 ±  7%  perf-stat.ps.cache-references
      1916            -0.6%       1904        perf-stat.ps.context-switches
    143524            -0.0%     143524        perf-stat.ps.cpu-clock
 5.234e+10 ±  3%      +0.6%  5.265e+10        perf-stat.ps.cpu-cycles
    148.93            -0.3%     148.51        perf-stat.ps.cpu-migrations
   7083441 ± 17%     +12.4%    7959311 ±  5%  perf-stat.ps.dTLB-load-misses
 4.206e+09            +1.7%  4.276e+09        perf-stat.ps.dTLB-loads
   4760073 ±  7%      +9.6%    5215393 ±  2%  perf-stat.ps.dTLB-store-misses
 1.702e+09 ±  8%      +8.5%  1.846e+09 ±  3%  perf-stat.ps.dTLB-stores
   7286389 ±  9%      +6.8%    7783435 ±  2%  perf-stat.ps.iTLB-load-misses
   2190584 ± 17%      -7.9%    2018547 ±  6%  perf-stat.ps.iTLB-loads
 1.546e+10            +0.6%  1.555e+10        perf-stat.ps.instructions
      1.01 ±  3%      +1.6%       1.02 ±  3%  perf-stat.ps.major-faults
      3788            -0.1%       3784        perf-stat.ps.minor-faults
    154954 ± 18%      -2.8%     150666 ± 20%  perf-stat.ps.node-load-misses
     17958 ± 10%     -18.8%      14577 ±  6%  perf-stat.ps.node-loads
     53120 ± 11%      -1.7%      52211 ±  2%  perf-stat.ps.node-store-misses
     36482 ± 18%     -12.1%      32073 ± 19%  perf-stat.ps.node-stores
      3789            -0.1%       3785        perf-stat.ps.page-faults
    143524            -0.0%     143524        perf-stat.ps.task-clock
 4.678e+12            +0.5%  4.703e+12        perf-stat.total.instructions
      6.28 ± 10%      -6.3        0.00        perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      6.25 ± 10%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.18 ± 10%      -6.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
      6.01 ± 10%      -6.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn
      6.55 ± 10%      -5.9        0.65 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     38.33 ± 15%      -3.5       34.84 ± 17%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     40.09 ± 13%      -3.4       36.70 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     40.26 ± 13%      -3.4       36.88 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.08 ± 13%      -3.3       37.76 ± 13%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.09 ± 13%      -3.3       37.78 ± 13%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.09 ± 13%      -3.3       37.78 ± 13%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     41.76 ± 13%      -3.3       38.44 ± 14%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.29 ±101%      -0.1        0.19 ±142%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.14 ±173%      -0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.45 ± 60%      +0.0        0.48 ± 46%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.60 ±106%      +0.0        0.63 ±103%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.60 ±106%      +0.0        0.63 ±103%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.60 ±106%      +0.0        0.63 ±103%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.60 ±106%      +0.0        0.63 ±103%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.60 ±106%      +0.0        0.63 ±103%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      1.34 ± 18%      +0.0        1.39 ± 13%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.28 ± 18%      +0.0        1.33 ± 13%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.88 ± 23%      +0.1        0.94 ± 12%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.96 ± 17%      +0.1        2.03 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.46 ± 59%      +0.1        0.54 ± 46%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.15 ± 16%      +0.1        2.23 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.__set_task_blocked.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64
      0.60 ±  8%      +0.1        0.72 ±  7%  perf-profile.calltrace.cycles-pp.ring_buffer_lock_reserve.trace_buffer_lock_reserve.ftrace_syscall_exit.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.90 ±  8%      +0.1        1.04 ±  9%  perf-profile.calltrace.cycles-pp.__entry_text_start.raise
      0.66 ±  8%      +0.1        0.79 ±  7%  perf-profile.calltrace.cycles-pp.trace_buffer_lock_reserve.ftrace_syscall_exit.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.25 ±100%      +0.1        0.40 ± 70%  perf-profile.calltrace.cycles-pp.__send_signal.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill
      0.91 ±  8%      +0.2        1.07 ± 10%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.raise
     40.06 ±  9%      +0.2       40.22 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      1.02 ±  7%      +0.2        1.20 ±  8%  perf-profile.calltrace.cycles-pp.ftrace_syscall_enter.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      1.00 ±  9%      +0.2        1.18 ±  8%  perf-profile.calltrace.cycles-pp.ftrace_syscall_exit.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.17 ±  9%      +0.2       40.35 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.raise
      1.11 ±  8%      +0.2        1.30 ±  9%  perf-profile.calltrace.cycles-pp.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      1.08 ±  9%      +0.2        1.27 ±  7%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      0.27 ±100%      +0.3        0.59 ±  9%  perf-profile.calltrace.cycles-pp.trace_buffer_lock_reserve.ftrace_syscall_enter.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±173%      +0.3        0.47 ± 45%  perf-profile.calltrace.cycles-pp.__rb_reserve_next.ring_buffer_lock_reserve.trace_buffer_lock_reserve.ftrace_syscall_exit.syscall_exit_to_user_mode_prepare
      0.00            +0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.ring_buffer_lock_reserve.trace_buffer_lock_reserve.ftrace_syscall_enter.syscall_trace_enter.do_syscall_64
     42.28 ±  9%      +0.5       42.82 ±  8%  perf-profile.calltrace.cycles-pp.raise
      6.59 ±  9%      +1.0        7.56 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
      6.76 ±  9%      +1.0        7.78 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      7.17 ±  9%      +1.1        8.26 ±  8%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.45 ±  9%      +1.1        7.57 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart
      6.12 ± 10%      +1.1        7.26 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64
      6.61 ±  9%      +1.2        7.76 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare
      7.63 ±  9%      +1.2        8.79 ±  8%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      6.30 ± 10%      +1.2        7.50 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.88 ±  9%      +1.2        8.08 ±  9%  perf-profile.calltrace.cycles-pp.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      6.89 ±  9%      +1.2        8.10 ±  9%  perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.56 ±  9%      +1.2        7.79 ±  8%  perf-profile.calltrace.cycles-pp.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
      7.01 ±  9%      +1.2        8.24 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
      6.71 ±  9%      +1.2        7.95 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
      6.96 ±  9%      +1.3        8.26 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__restore_rt
      6.97 ± 10%      +1.3        8.27 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__restore_rt
      7.02 ± 10%      +1.3        8.32 ±  8%  perf-profile.calltrace.cycles-pp.__restore_rt
      6.04 ± 11%      +1.3        7.36 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific
      7.60 ±  9%      +1.3        8.95 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.handler
      7.59 ±  9%      +1.4        8.94 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
      7.58 ±  9%      +1.4        8.93 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
      6.23 ± 10%      +1.4        7.59 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific.do_tkill
      6.23 ± 11%      +1.4        7.60 ±  9%  perf-profile.calltrace.cycles-pp.__lock_task_sighand.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill
      8.27 ±  9%      +1.4        9.72 ±  9%  perf-profile.calltrace.cycles-pp.handler
      6.81 ± 10%      +1.5        8.29 ±  9%  perf-profile.calltrace.cycles-pp.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64
      7.12 ± 10%      +1.6        8.68 ±  9%  perf-profile.calltrace.cycles-pp.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.18 ± 10%      +1.6        8.75 ±  9%  perf-profile.calltrace.cycles-pp.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      7.20 ± 10%      +1.6        8.77 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     11.57 ±  9%      +1.6       13.20 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     14.57 ±  9%      +2.4       16.95 ±  9%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.32 ±  9%      +2.4       14.75 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask
     12.70 ±  9%      +2.5       15.19 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64
     13.20 ±  9%      +2.6       15.79 ±  9%  perf-profile.calltrace.cycles-pp.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.22 ±  9%      +2.6       15.82 ±  9%  perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     13.40 ±  9%      +2.6       16.02 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
      6.28 ± 10%      -5.9        0.34 ± 10%  perf-profile.children.cycles-pp.restore_altstack
      6.25 ± 10%      -5.9        0.31 ± 11%  perf-profile.children.cycles-pp.do_sigaltstack



> Not pretty, but that's what I came up with for now.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -457,10 +457,10 @@ static inline void fpu_inherit_perms(str
>  	if (fpu_state_size_dynamic()) {
>  		struct fpu *src_fpu = &current->group_leader->thread.fpu;
>  
> -		spin_lock_irq(&current->sighand->siglock);
> +		read_lock(&current->sighand->sigaltstack_lock);
>  		/* Fork also inherits the permissions of the parent */
>  		dst_fpu->perm = src_fpu->perm;
> -		spin_unlock_irq(&current->sighand->siglock);
> +		read_unlock(&current->sighand->sigaltstack_lock);
>  	}
>  }
>  
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1582,17 +1582,22 @@ static int validate_sigaltstack(unsigned
>  {
>  	struct task_struct *thread, *leader = current->group_leader;
>  	unsigned long framesize = get_sigframe_size();
> +	int ret = 0;
>  
> -	lockdep_assert_held(&current->sighand->siglock);
> +	lockdep_assert_held_write(&current->sighand->sigaltstack_lock);
>  
>  	/* get_sigframe_size() is based on fpu_user_cfg.max_size */
>  	framesize -= fpu_user_cfg.max_size;
>  	framesize += usize;
> +	read_lock(&tasklist_lock);
>  	for_each_thread(leader, thread) {
> -		if (thread->sas_ss_size && thread->sas_ss_size < framesize)
> -			return -ENOSPC;
> +		if (thread->sas_ss_size && thread->sas_ss_size < framesize) {
> +			ret = -ENOSPC;
> +			break;
> +		}
>  	}
> -	return 0;
> +	read_unlock(&tasklist_lock);
> +	return ret;
>  }
>  
>  static int __xstate_request_perm(u64 permitted, u64 requested)
> @@ -1627,7 +1632,7 @@ static int __xstate_request_perm(u64 per
>  
>  	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
>  	WRITE_ONCE(fpu->perm.__state_perm, requested);
> -	/* Protected by sighand lock */
> +	/* Protected by sighand::sigaltstack_lock */
>  	fpu->perm.__state_size = ksize;
>  	fpu->perm.__user_state_size = usize;
>  	return ret;
> @@ -1666,10 +1671,10 @@ static int xstate_request_perm(unsigned
>  		return 0;
>  
>  	/* Protect against concurrent modifications */
> -	spin_lock_irq(&current->sighand->siglock);
> +	write_lock(&current->sighand->sigaltstack_lock);
>  	permitted = xstate_get_host_group_perm();
>  	ret = __xstate_request_perm(permitted, requested);
> -	spin_unlock_irq(&current->sighand->siglock);
> +	write_unlock(&current->sighand->sigaltstack_lock);
>  	return ret;
>  }
>  
> @@ -1685,11 +1690,11 @@ int xfd_enable_feature(u64 xfd_err)
>  	}
>  
>  	/* Protect against concurrent modifications */
> -	spin_lock_irq(&current->sighand->siglock);
> +	read_lock(&current->sighand->sigaltstack_lock);
>  
>  	/* If not permitted let it die */
>  	if ((xstate_get_host_group_perm() & xfd_event) != xfd_event) {
> -		spin_unlock_irq(&current->sighand->siglock);
> +		read_unlock(&current->sighand->sigaltstack_lock);
>  		return -EPERM;
>  	}
>  
> @@ -1702,7 +1707,7 @@ int xfd_enable_feature(u64 xfd_err)
>  	 * another task, the retrieved buffer sizes are valid for the
>  	 * currently requested feature(s).
>  	 */
> -	spin_unlock_irq(&current->sighand->siglock);
> +	read_unlock(&current->sighand->sigaltstack_lock);
>  
>  	/*
>  	 * Try to allocate a new fpstate. If that fails there is no way
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -939,17 +939,19 @@ static int __init strict_sas_size(char *
>   * the task has permissions to use dynamic features. Tasks which have no
>   * permission are checked against the size of the non-dynamic feature set
>   * if strict checking is enabled. This avoids forcing all tasks on the
> - * system to allocate large sigaltstacks even if they are never going
> - * to use a dynamic feature. As this is serialized via sighand::siglock
> - * any permission request for a dynamic feature either happened already
> - * or will see the newly install sigaltstack size in the permission checks.
> + * system to allocate large sigaltstacks even if they are never going to
> + * use a dynamic feature.
> + *
> + * As this is serialized via sighand::sigaltstack_lock any permission
> + * request for a dynamic feature either happened already or will see the
> + * newly install sigaltstack size in the permission checks.
>   */
>  bool sigaltstack_size_valid(size_t ss_size)
>  {
>  	unsigned long fsize = max_frame_size - fpu_default_state_size;
>  	u64 mask;
>  
> -	lockdep_assert_held(&current->sighand->siglock);
> +	lockdep_assert_held_read(&current->sighand->sigaltstack_lock);
>  
>  	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
>  		return true;
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -19,6 +19,9 @@
>  
>  struct sighand_struct {
>  	spinlock_t		siglock;
> +#ifdef CONFIG_DYNAMIC_SIGFRAME
> +	rwlock_t		sigaltstack_lock;
> +#endif
>  	refcount_t		count;
>  	wait_queue_head_t	signalfd_wqh;
>  	struct k_sigaction	action[_NSIG];
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -48,6 +48,9 @@ static struct sighand_struct init_sighan
>  	.action		= { { { .sa_handler = SIG_DFL, } }, },
>  	.siglock	= __SPIN_LOCK_UNLOCKED(init_sighand.siglock),
>  	.signalfd_wqh	= __WAIT_QUEUE_HEAD_INITIALIZER(init_sighand.signalfd_wqh),
> +#ifdef CONFIG_DYNAMIC_SIGFRAME
> +	.sigaltstack_lock	= __RW_LOCK_UNLOCKED(init_sighand.sigaltstack_lock),
> +#endif
>  };
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2900,6 +2900,9 @@ static void sighand_ctor(void *data)
>  
>  	spin_lock_init(&sighand->siglock);
>  	init_waitqueue_head(&sighand->signalfd_wqh);
> +#ifdef CONFIG_DYNAMIC_SIGFRAME
> +	rwlock_init(&sighand->sigaltstack_lock);
> +#endif
>  }
>  
>  void __init proc_caches_init(void)
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4141,15 +4141,15 @@ int do_sigaction(int sig, struct k_sigac
>  
>  #ifdef CONFIG_DYNAMIC_SIGFRAME
>  static inline void sigaltstack_lock(void)
> -	__acquires(&current->sighand->siglock)
> +	__acquires(&current->sighand->sigaltstack_lock)
>  {
> -	spin_lock_irq(&current->sighand->siglock);
> +	read_lock(&current->sighand->sigaltstack_lock);
>  }
>  
>  static inline void sigaltstack_unlock(void)
> -	__releases(&current->sighand->siglock)
> +	__releases(&current->sighand->sigaltstack_lock)
>  {
> -	spin_unlock_irq(&current->sighand->siglock);
> +	read_unlock(&current->sighand->sigaltstack_lock);
>  }
>  #else
>  static inline void sigaltstack_lock(void) { }
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
