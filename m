Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C44722C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhLMId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:33:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:39149 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhLMId4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639384436; x=1670920436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+7HIjLhqurniQteq2ekg4ZRaZcZSWzuxQjGIuPCsCvY=;
  b=U3VKHExRZUoblU3+nlSbJBs69IYwsGILnHIR58mLueT0UFamdmvySHTJ
   N6lPWZWPskOyyJNi4C2N+V9fu/IvcopMXad8XsYL9ZFpy0Eh/bPOmJhNY
   //LUfTkJ4iVNCITEot0E4iW+GiIR8uJXLKJSzTB/zvt5HSw9YEyqpRSui
   d/Jj8cc080IYe8eVte1LMN93i2Q17nwDer0bkfl2/gOSiYeepa0a9J0Pw
   L5lW502fPkeFTbJvOB4eYQlMyiyvw5oB4LvWwPK7urzFKgTYi+nIw+QU7
   dcOxSko6I9Yex288CD6zNF3sgPDUiSUZGlaDaj5ZoTgmUI9TtgtTzmv93
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="225963879"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="225963879"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:33:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="752145783"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.92])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:33:51 -0800
Date:   Mon, 13 Dec 2021 16:31:55 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, fengwei.yin@intel.com
Subject: Re: [LKP] Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7%
 regression
Message-ID: <20211213083154.GA20853@linux.intel.com>
References: <20211210053743.GA36420@xsang-OptiPlex-9020>
 <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
 <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
 <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Dec 10, 2021 at 01:59:08PM -0800, Linus Torvalds wrote:
> On Fri, Dec 10, 2021 at 1:25 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We could make a special light-weight version of files_lookup_fd_raw(),
> > I guess. We don't need the *whole* "look it up again".  We don't need
> > to re-check the array bounds, and we don't need to do the nospec
> > lookup - we would have triggered a NULL file pointer if that happened
> > the first time around.
> >
> > So all we'd need to do is "check that fdt is the same, and check that
> > fdt->fd[fd] is the same".
> 
> This is an ENTIRELY UNTESTED patch to do that.
> 
> It basically rewrites __fget_files() from scratch: it really wants to
> do the fd array lookup by hand, in order to cache the intermediate fdt
> pointer, and in order to cache the intermediate speculation-safe fd
> array index etc.
> 
> It's not a very complicated function, and rewriting it actually cleans
> up the loop to not need the ugly goto.
> 
> I made it use a helper wrapper function for the rcu locking, so that
> the "meat" of the function can just use plain "return NULL" for the
> error cases.
> 
> However, not only is it entirely untested, this rewrite also means
> that gcc has now decided that the result is so simple and clear that
> it will inline it into all the callers.
> 
> I guess that's a good sign - writing the code in a way that makes the
> compiler say "now it's so trivial that it should be inlined" is
> certainly not a bad thing. But it makes it hard to really compare the
> asm.
> 
> I did try a version with "noinline" just to make it more comparable,
> and hey, it all looked sane to me there too.
> 
> I added more comments about what is going on.
> 
> Again - this is UNTESTED. I've looked at the code, I've looked at the
> diff, and I've looked at the code it generates. It all looks fine to
> me. But I've looked at it so much that I suspect that I'd be entirely
> blind to any completely obvious bug by now.
> 
> Comments?
> 
> Oliver, does this make any difference in the performance department?

We tested your patch, the performance regression has recovered from -5.7% to 
-0.4%, thanks.

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/poll2/will-it-scale/0x42e

commit: 
  5f58da2bef ("Merge tag 'drm-fixes-2021-12-03-1' of git://anongit.freedesktop.org/drm/drm")
  054aa8d439 ("fget: check that the fd still exists after getting a ref to it")
  242d36be3a ("fixup-for-054aa8d439")

5f58da2befa58edf 054aa8d439b9185d4f5eb9a9028 242d36be3ad02063a1cf6df7802 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
   6666720            -5.7%    6288280            -0.4%    6639231        will-it-scale.24.threads
    277779            -5.7%     262011            -0.4%     276634        will-it-scale.per_thread_ops
   6666720            -5.7%    6288280            -0.4%    6639231        will-it-scale.workload
      0.09 ± 59%     -24.7%       0.07 ± 16%      +5.0%       0.10 ± 38%  perf-stat.overall.MPKI
      0.19            -0.0        0.17            +0.0        0.19        perf-stat.overall.branch-miss-rate%
      8.12 ±118%      -4.7        3.43 ± 14%      +2.6       10.68 ±118%  perf-stat.overall.cache-miss-rate%
      0.74           -13.0%       0.64            -4.6%       0.71        perf-stat.overall.cpi
    234529 ± 42%     +15.5%     270984           -20.6%     186280 ± 55%  perf-stat.overall.cycles-between-cache-misses
      0.19 ±  3%      -0.0        0.14 ±  8%      -0.0        0.16 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.10            -0.0        0.08            -0.0        0.08        perf-stat.overall.dTLB-store-miss-rate%
     95.61            -0.1       95.50            -0.4       95.22        perf-stat.overall.iTLB-load-miss-rate%
     13182           +20.1%      15826            +0.4%      13238 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      1.35           +14.9%       1.55            +4.8%       1.42        perf-stat.overall.ipc
     46.17 ±  3%      -0.8       45.40            +0.2       46.40 ±  4%  perf-stat.overall.node-load-miss-rate%
     34.45 ± 10%      -0.3       34.18 ±  3%      -1.9       32.53 ± 12%  perf-stat.overall.node-store-miss-rate%
   4411089           +21.5%    5360082            +5.3%    4644112        perf-stat.overall.path-length
  2.37e+10            +0.8%  2.388e+10            -4.3%  2.267e+10        perf-stat.ps.branch-instructions
  44188606            -5.4%   41787951            -1.2%   43679032        perf-stat.ps.branch-misses
   1254452 ±177%     -78.9%     264997 ±  2%     +15.0%    1442189 ±160%  perf-stat.ps.cache-misses
   9152124 ± 58%     -13.4%    7923752 ± 17%      +9.6%   10028813 ± 36%  perf-stat.ps.cache-references
      1317 ±  2%      +0.5%       1323 ±  3%      +2.4%       1348 ±  2%  perf-stat.ps.context-switches
     47842            -0.0%      47841            +0.0%      47842        perf-stat.ps.cpu-clock
 7.202e+10            -0.3%  7.179e+10            -0.4%  7.175e+10        perf-stat.ps.cpu-cycles
     72.64            +0.1%      72.68 ±  2%      +1.7%      73.85        perf-stat.ps.cpu-migrations
  42723891 ±  3%      -7.1%   39692131 ±  8%      -0.5%   42496149 ±  6%  perf-stat.ps.dTLB-load-misses
 2.289e+10           +25.4%  2.871e+10           +17.9%  2.698e+10        perf-stat.ps.dTLB-loads
  14395868            -5.8%   13567459 ±  2%      -1.2%   14222816        perf-stat.ps.dTLB-store-misses
 1.453e+10           +21.9%  1.771e+10           +16.7%  1.695e+10        perf-stat.ps.dTLB-stores
   7382256            -4.6%    7043603            +4.0%    7680167 ±  2%  perf-stat.ps.iTLB-load-misses
    339276 ±  2%      -2.1%     332065 ±  4%     +13.3%     384551 ± 29%  perf-stat.ps.iTLB-loads
 9.731e+10           +14.6%  1.115e+11            +4.4%  1.016e+11        perf-stat.ps.instructions
      0.47 ± 14%      -9.2%       0.43 ±  8%      -6.6%       0.44 ± 12%  perf-stat.ps.major-faults
      2699            -0.3%       2690            +0.2%       2705        perf-stat.ps.minor-faults
    788197 ±193%     -86.7%     105083 ±  5%     +13.3%     892699 ±174%  perf-stat.ps.node-load-misses
    817124 ±189%     -84.5%     126259 ±  3%     +13.4%     926398 ±170%  perf-stat.ps.node-loads
    248114 ±168%     -74.7%      62837 ±  5%      +8.2%     268474 ±160%  perf-stat.ps.node-store-misses
    434936 ±163%     -72.2%     120915 ±  3%      +9.9%     477830 ±149%  perf-stat.ps.node-stores
      2700            -0.3%       2691            +0.2%       2705        perf-stat.ps.page-faults
     47842            -0.0%      47841            +0.0%      47842        perf-stat.ps.task-clock
 2.941e+13           +14.6%  3.371e+13            +4.9%  3.083e+13        perf-stat.total.instructions
     28.74 ± 23%      -1.9       26.84 ±  6%      +6.1       34.84 ± 20%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     27.82 ± 23%      -1.9       25.93 ±  5%      +5.7       33.54 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.82 ± 23%      -1.9       25.93 ±  5%      +5.7       33.54 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     27.83 ± 23%      -1.9       25.94 ±  5%      +5.7       33.55 ± 20%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.83 ± 23%      -1.9       25.94 ±  5%      +5.7       33.55 ± 20%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.83 ± 23%      -1.9       25.94 ±  5%      +5.7       33.55 ± 20%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     28.81 ± 23%      -1.9       26.93 ±  6%      +6.0       34.85 ± 20%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     19.12 ±  9%      -1.7       17.39 ±  2%      -2.8       16.33 ± 11%  perf-profile.calltrace.cycles-pp.fput_many.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      -0.2        0.10 ±223%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.__kmalloc.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.88 ±  9%      -0.1        2.76 ±  2%      -0.3        2.62 ± 11%  perf-profile.calltrace.cycles-pp.testcase
      3.27 ±  9%      -0.1        3.18 ±  2%      -0.2        3.06 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      1.70 ±  9%      -0.1        1.63 ±  2%      -0.1        1.57 ± 11%  perf-profile.calltrace.cycles-pp.__fdget.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.70 ± 10%      -0.1        1.64 ±  2%      -0.2        1.52 ± 10%  perf-profile.calltrace.cycles-pp.fput.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04 ±  8%      -0.1        0.98 ±  4%      -0.0        1.00 ± 10%  perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.64 ±  9%      -0.1        1.59 ±  3%      -0.2        1.48 ± 12%  perf-profile.calltrace.cycles-pp.__entry_text_start.__poll
      1.69 ±  9%      -0.0        1.65 ±  3%      -0.1        1.57 ± 12%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
      1.11 ±  9%      -0.0        1.08 ±  4%      -0.1        1.01 ± 11%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.48 ±  8%      -0.0        1.45 ±  4%      -0.1        1.34 ± 10%  perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ± 57%      -0.0        0.92 ± 54%      +0.4        1.31 ± 46%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 57%      -0.0        0.92 ± 54%      +0.4        1.31 ± 46%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 57%      -0.0        0.92 ± 54%      +0.4        1.31 ± 46%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 57%      -0.0        0.92 ± 54%      +0.4        1.31 ± 46%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.94 ± 57%      -0.0        0.92 ± 54%      +0.4        1.31 ± 46%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.54 ± 45%      +0.1        0.59 ±  9%      -0.2        0.29 ±100%  perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.66 ±  9%      +2.0       69.69 ±  2%      -5.7       61.98 ± 11%  perf-profile.calltrace.cycles-pp.__poll
     63.66 ±  9%      +2.2       65.82 ±  2%      -5.4       58.30 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     63.48 ±  9%      +2.2       65.64 ±  2%      -5.3       58.14 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     59.85 ±  9%      +2.3       62.12 ±  2%      -5.1       54.77 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     57.74 ±  9%      +2.4       60.09 ±  2%      -4.9       52.86 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     27.16 ± 10%      +4.3       31.51 ±  2%      -1.1       26.04 ± 10%  perf-profile.calltrace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.91 ± 10%      +4.4       27.34 ±  2%     -22.9        0.00        perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64
     27.83 ± 23%      -1.9       25.94 ±  5%      +5.7       33.55 ± 20%  perf-profile.children.cycles-pp.start_secondary
     28.80 ± 23%      -1.9       26.92 ±  6%      +6.0       34.85 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter
     28.80 ± 23%      -1.9       26.92 ±  6%      +6.0       34.85 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter_state
     28.81 ± 23%      -1.9       26.93 ±  6%      +6.0       34.85 ± 20%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     28.81 ± 23%      -1.9       26.93 ±  6%      +6.0       34.85 ± 20%  perf-profile.children.cycles-pp.cpu_startup_entry
     28.81 ± 23%      -1.9       26.93 ±  6%      +6.0       34.85 ± 20%  perf-profile.children.cycles-pp.do_idle
     28.78 ± 23%      -1.9       26.91 ±  6%      +6.1       34.84 ± 20%  perf-profile.children.cycles-pp.intel_idle
     18.28 ±  9%      -1.7       16.59 ±  2%      -2.7       15.57 ± 11%  perf-profile.children.cycles-pp.fput_many
      2.90 ±  9%      -0.1        2.76 ±  2%      -0.3        2.64 ± 11%  perf-profile.children.cycles-pp.testcase
      3.29 ±  9%      -0.1        3.20 ±  2%      -0.2        3.08 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.69 ±  9%      -0.1        1.63 ±  2%      -0.1        1.56 ± 11%  perf-profile.children.cycles-pp.__fdget
      1.70 ±  9%      -0.1        1.64 ±  2%      -0.2        1.53 ± 10%  perf-profile.children.cycles-pp.fput
      1.82 ±  9%      -0.1        1.76 ±  3%      -0.2        1.66 ± 12%  perf-profile.children.cycles-pp.__entry_text_start
      1.07 ±  9%      -0.1        1.02 ±  4%      -0.0        1.04 ± 10%  perf-profile.children.cycles-pp.__check_object_size
      1.90 ±  9%      -0.0        1.86 ±  2%      -0.1        1.77 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.50 ±  8%      -0.0        1.47 ±  4%      -0.1        1.37 ± 10%  perf-profile.children.cycles-pp._copy_from_user
      1.12 ±  9%      -0.0        1.09 ±  4%      -0.1        1.02 ± 11%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.30 ±  8%      -0.0        0.26 ± 11%      +0.0        0.31 ± 20%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.12 ±  8%      -0.0        0.09 ± 11%      -0.0        0.09 ± 13%  perf-profile.children.cycles-pp.poll@plt
      0.04 ± 71%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.seq_read_iter
      0.17 ± 26%      -0.0        0.14 ± 32%      -0.0        0.13 ± 23%  perf-profile.children.cycles-pp.cmd_sched
      0.17 ± 26%      -0.0        0.14 ± 32%      -0.0        0.13 ± 23%  perf-profile.children.cycles-pp.cmd_record
      0.04 ± 71%      -0.0        0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.ksys_read
      0.04 ± 71%      -0.0        0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.vfs_read
      0.61 ± 13%      -0.0        0.59 ±  9%      -0.1        0.51 ± 13%  perf-profile.children.cycles-pp.kfree
      0.17 ± 26%      -0.0        0.15 ± 30%      -0.0        0.13 ± 20%  perf-profile.children.cycles-pp.__libc_start_main
      0.17 ± 26%      -0.0        0.15 ± 30%      -0.0        0.13 ± 20%  perf-profile.children.cycles-pp.main
      0.17 ± 26%      -0.0        0.15 ± 30%      -0.0        0.13 ± 20%  perf-profile.children.cycles-pp.run_builtin
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.ksys_write
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.vfs_write
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.new_sync_write
      0.04 ± 45%      -0.0        0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.13 ± 10%      -0.0        0.12 ±  6%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.kmalloc_slab
      0.02 ± 99%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.seq_read
      0.02 ± 99%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__libc_read
      0.15 ± 26%      -0.0        0.14 ± 31%      -0.0        0.12 ± 20%  perf-profile.children.cycles-pp.record__finish_output
      0.15 ± 26%      -0.0        0.14 ± 31%      -0.0        0.12 ± 20%  perf-profile.children.cycles-pp.perf_session__process_events
      0.06 ± 46%      -0.0        0.04 ± 73%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.machines__deliver_event
      0.14 ± 27%      -0.0        0.12 ± 32%      -0.0        0.11 ± 20%  perf-profile.children.cycles-pp.process_simple
      0.09 ± 30%      -0.0        0.08 ± 34%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.05 ± 47%      -0.0        0.04 ± 71%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.exc_page_fault
      0.10 ± 24%      -0.0        0.08 ± 30%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.poll_select_set_timeout
      0.09 ± 24%      -0.0        0.08 ± 28%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.proc_reg_read
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_output_sample
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.do_user_addr_fault
      0.04 ± 45%      -0.0        0.04 ± 71%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_callchain_user
      0.29 ±  9%      -0.0        0.28 ±  4%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11 ± 12%      -0.0        0.10 ±  8%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.__might_sleep
      0.05 ± 49%      -0.0        0.05 ± 52%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.check_stack_object
      0.16 ± 20%      -0.0        0.16 ±  9%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.12 ± 20%      -0.0        0.11 ±  8%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.unwind_next_frame
      0.29 ± 11%      -0.0        0.28 ±  5%      -0.0        0.26 ± 14%  perf-profile.children.cycles-pp.__check_heap_object
      0.43 ± 19%      +0.0        0.43 ± 10%      -0.1        0.36 ± 10%  perf-profile.children.cycles-pp.update_process_times
      0.23 ± 20%      +0.0        0.23 ± 11%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.21 ± 20%      +0.0        0.21 ± 10%      -0.0        0.17 ±  8%  perf-profile.children.cycles-pp.perf_callchain
      0.02 ±141%      +0.0        0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.ordered_events__queue
      0.02 ±142%      +0.0        0.02 ±142%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.io_serial_in
      0.07 ± 12%      +0.0        0.07 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.uart_console_write
      0.07 ± 12%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.serial8250_console_write
      0.21 ± 21%      +0.0        0.21 ± 10%      -0.0        0.17 ±  8%  perf-profile.children.cycles-pp.get_perf_callchain
      0.07 ± 12%      +0.0        0.07 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.08 ± 12%      +0.0        0.08 ±  6%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.vprintk_emit
      0.08 ± 12%      +0.0        0.08 ±  6%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.console_unlock
      0.48 ± 17%      +0.0        0.48 ±  9%      -0.1        0.41 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.32 ± 21%      +0.0        0.32 ± 11%      -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.update_curr
      0.61 ± 16%      +0.0        0.61 ±  7%      -0.1        0.53 ± 10%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ± 21%      +0.0        0.30 ± 10%      -0.1        0.24 ±  9%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.28 ± 20%      +0.0        0.29 ± 10%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.28 ± 19%      +0.0        0.28 ± 11%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.perf_event_output_forward
      0.29 ± 10%      +0.0        0.29 ±  9%      -0.0        0.25 ± 10%  perf-profile.children.cycles-pp.__might_fault
      0.08 ± 12%      +0.0        0.08 ± 22%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.worker_thread
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.process_one_work
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.commit_tail
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.memcpy_toio
      0.07 ±  8%      +0.0        0.07 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.43 ± 19%      +0.0        0.44 ±  9%      -0.1        0.36 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      0.57 ± 16%      +0.0        0.58 ±  7%      -0.1        0.50 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.05 ± 47%      +0.0        0.06 ±  8%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__unwind_start
      0.28 ± 20%      +0.0        0.29 ± 10%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.perf_swevent_overflow
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.irq_work_run
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.irq_work_single
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp._printk
      0.44 ± 19%      +0.0        0.45 ±  9%      -0.1        0.37 ± 10%  perf-profile.children.cycles-pp.tick_sched_timer
      0.54 ± 17%      +0.0        0.54 ±  8%      -0.1        0.46 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.54 ± 17%      +0.0        0.55 ±  8%      -0.1        0.47 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.37 ± 19%      +0.0        0.37 ± 10%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.07 ±  9%      +0.0        0.08 ±  8%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.irq_work_run_list
      0.06 ± 47%      +0.0        0.07 ± 18%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.29 ± 21%      +0.0        0.30 ± 10%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.perf_tp_event
      0.98 ± 47%      +0.0        0.99 ± 38%      +0.3        1.31 ± 46%  perf-profile.children.cycles-pp.start_kernel
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__cond_resched
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.queue_event
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.poll_freewait
      0.39 ± 19%      +0.0        0.40 ±  9%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.06 ±  8%      +0.0        0.07 ± 11%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.ret_from_fork
      0.06 ±  8%      +0.0        0.07 ± 11%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.kthread
      0.04 ± 71%      +0.0        0.04 ± 45%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.19 ± 10%      +0.0        0.20 ±  9%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.__might_resched
      0.02 ±141%      +0.0        0.03 ± 70%      +0.0        0.06 ± 50%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±223%      +0.0        0.03 ± 70%      -0.0        0.00        perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.50 ± 12%      +0.0        0.53 ±  9%      -0.0        0.46 ± 12%  perf-profile.children.cycles-pp.__kmalloc
     67.89 ±  9%      +2.0       69.92 ±  2%      -5.7       62.20 ± 11%  perf-profile.children.cycles-pp.__poll
     63.84 ±  9%      +2.1       65.97 ±  2%      -5.4       58.43 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     63.66 ±  9%      +2.1       65.80 ±  2%      -5.4       58.27 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
     59.86 ±  9%      +2.3       62.12 ±  2%      -5.1       54.77 ± 10%  perf-profile.children.cycles-pp.__x64_sys_poll
     59.47 ±  9%      +2.3       61.75 ±  2%      -5.0       54.42 ± 10%  perf-profile.children.cycles-pp.do_sys_poll
     26.33 ± 10%      +4.4       30.70 ±  2%      -1.0       25.29 ± 10%  perf-profile.children.cycles-pp.__fget_light
     22.92 ± 10%      +4.4       27.35 ±  2%     -22.9        0.00        perf-profile.children.cycles-pp.__fget_files
     28.78 ± 23%      -1.9       26.91 ±  6%      +6.1       34.84 ± 20%  perf-profile.self.cycles-pp.intel_idle
     17.29 ±  9%      -1.6       15.64 ±  2%      -2.6       14.67 ± 11%  perf-profile.self.cycles-pp.fput_many
     11.06 ±  9%      -0.3       10.74 ±  2%      -1.0       10.09 ± 11%  perf-profile.self.cycles-pp.do_sys_poll
      2.87 ±  9%      -0.1        2.74 ±  2%      -0.3        2.61 ± 12%  perf-profile.self.cycles-pp.testcase
      3.21 ±  9%      -0.1        3.12 ±  2%      -0.2        2.98 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.60 ±  9%      -0.1        1.54 ±  4%      -0.2        1.45 ± 12%  perf-profile.self.cycles-pp.__entry_text_start
      1.90 ±  8%      -0.0        1.86 ±  3%      -0.1        1.77 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.55 ±  9%      -0.0        2.51 ±  4%     +21.8       24.30 ± 10%  perf-profile.self.cycles-pp.__fget_light
      0.84 ±  8%      -0.0        0.81 ±  2%      -0.1        0.77 ± 11%  perf-profile.self.cycles-pp.fput
      0.29 ±  8%      -0.0        0.26 ± 11%      +0.0        0.30 ± 20%  perf-profile.self.cycles-pp.__virt_addr_valid
      1.10 ±  9%      -0.0        1.07 ±  4%      -0.1        1.00 ± 11%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.28 ±  8%      -0.0        0.26 ±  5%      -0.0        0.24 ± 10%  perf-profile.self.cycles-pp.do_syscall_64
      0.84 ±  9%      -0.0        0.82 ±  3%      -0.1        0.78 ± 11%  perf-profile.self.cycles-pp.__fdget
      0.10 ±  6%      -0.0        0.08 ± 10%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.poll@plt
      0.60 ± 12%      -0.0        0.59 ±  9%      -0.1        0.51 ± 14%  perf-profile.self.cycles-pp.kfree
      0.11 ± 12%      -0.0        0.09 ±  7%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp._copy_from_user
      0.44 ±  9%      -0.0        0.43 ±  3%      -0.0        0.42 ± 15%  perf-profile.self.cycles-pp.__check_object_size
      0.31 ± 10%      -0.0        0.30 ±  3%      -0.0        0.29 ± 12%  perf-profile.self.cycles-pp.__x64_sys_poll
      0.18 ±  8%      -0.0        0.17 ±  5%      -0.0        0.16 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.poll_select_set_timeout
      0.04 ± 71%      -0.0        0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.12 ± 10%      -0.0        0.12 ±  6%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.kmalloc_slab
      0.01 ±223%      -0.0        0.00            +0.0        0.04 ± 73%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06 ± 11%      -0.0        0.05 ±  8%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.03 ±100%      -0.0        0.02 ±142%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.check_stack_object
      0.28 ± 11%      -0.0        0.27 ±  5%      -0.0        0.25 ± 13%  perf-profile.self.cycles-pp.__check_heap_object
      0.09 ± 13%      -0.0        0.09 ±  7%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.__might_sleep
      0.08 ± 17%      -0.0        0.08 ± 25%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.__might_fault
      0.03 ±100%      -0.0        0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.unwind_next_frame
      0.02 ±142%      +0.0        0.02 ±142%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.io_serial_in
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.11 ±  9%      +0.0        0.12 ±  8%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.44 ±  8%      +0.0        0.45 ±  4%      -0.0        0.42 ± 15%  perf-profile.self.cycles-pp.__poll
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.queue_event
      0.18 ± 11%      +0.0        0.19 ±  8%      -0.0        0.16 ± 10%  perf-profile.self.cycles-pp.__might_resched
      0.26 ± 13%      +0.0        0.30 ± 17%      -0.0        0.25 ± 15%  perf-profile.self.cycles-pp.__kmalloc
     22.70 ± 10%      +4.4       27.11 ±  2%     -22.7        0.00        perf-profile.self.cycles-pp.__fget_files

> 
>                  Linus

>  fs/file.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index ad4a8bf3cf10..70662fb1ab32 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -841,28 +841,65 @@ void do_close_on_exec(struct files_struct *files)
>  	spin_unlock(&files->file_lock);
>  }
>  
> +static inline struct file *__fget_files_rcu(struct files_struct *files,
> +	unsigned int fd, fmode_t mask, unsigned int refs)
> +{
> +	for (;;) {
> +		struct file *file;
> +		struct fdtable *fdt = rcu_dereference_raw(files->fdt);
> +		struct file __rcu **fdentry;
> +
> +		if (unlikely(fd >= fdt->max_fds))
> +			return NULL;
> +
> +		fdentry = fdt->fd + array_index_nospec(fd, fdt->max_fds);
> +		file = rcu_dereference_raw(*fdentry);
> +		if (unlikely(!file))
> +			return NULL;
> +
> +		if (unlikely(file->f_mode & mask))
> +			return NULL;
> +
> +		/*
> +		 * Ok, we have a file pointer. However, because we do
> +		 * this all locklessly under RCU, we may be racing with
> +		 * that file being closed.
> +		 *
> +		 * Such a race can take two forms:
> +		 *
> +		 *  (a) the file ref already went down to zero,
> +		 *      and get_file_rcu_many() fails. Just try
> +		 *      again:
> +		 */
> +		if (unlikely(!get_file_rcu_many(file, refs)))
> +			continue;
> +
> +		/*
> +		 *  (b) the file table entry has changed under us.
> +		 *
> +		 * If so, we need to put our refs and try again.
> +		 */
> +		if (unlikely(rcu_dereference_raw(files->fdt) != fdt) ||
> +		    unlikely(rcu_dereference_raw(*fdentry) != file)) {
> +			fput_many(file, refs);
> +			continue;
> +		}
> +
> +		/*
> +		 * Ok, we have a ref to the file, and checked that it
> +		 * still exists.
> +		 */
> +		return file;
> +	}
> +}
> +
>  static struct file *__fget_files(struct files_struct *files, unsigned int fd,
>  				 fmode_t mask, unsigned int refs)
>  {
>  	struct file *file;
>  
>  	rcu_read_lock();
> -loop:
> -	file = files_lookup_fd_rcu(files, fd);
> -	if (file) {
> -		/* File object ref couldn't be taken.
> -		 * dup2() atomicity guarantee is the reason
> -		 * we loop to catch the new file (or NULL pointer)
> -		 */
> -		if (file->f_mode & mask)
> -			file = NULL;
> -		else if (!get_file_rcu_many(file, refs))
> -			goto loop;
> -		else if (files_lookup_fd_raw(files, fd) != file) {
> -			fput_many(file, refs);
> -			goto loop;
> -		}
> -	}
> +	file = __fget_files_rcu(files, fd, mask, refs);
>  	rcu_read_unlock();
>  
>  	return file;

> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

