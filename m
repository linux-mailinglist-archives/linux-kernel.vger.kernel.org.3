Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD4472ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhLMK7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:59:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:43342 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhLMK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639393172; x=1670929172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XUb4hvq2AteVRKiH+fd5MzzgI9+T+fVEiCzjOafJwC4=;
  b=g81QvrlKSVeT0CpLP1z3cFcCTJPaX862i/GNBu8B/zUXYMKTRt7E+4Hk
   15+kLHxXHZ0q/hZfqqlnkW3Vrc1wZEtgz/L8N4CitngcTeRug2ReWATAK
   Cj1uH31taYB32VCLcLajm2e+2neLYs2KG+a+IU9ERINttbkibCgz/cy1G
   hz/K+4wrsbhfI1xZz2aSgfmV/qiExruLrRq5pMrYP8PiMbYmFDw0N2+cG
   u2nwKff4wP7wqq9uqRrJzDw1Vn6Kh2ofM248S9fvTYPUMyOWK6472T5Hm
   boL2kCa+lzKinWoW/BZjeweoeDEPCgr28Bl+RPuwaCjgylbgX6VTl0n18
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="218724038"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="218724038"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:59:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="464585781"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.92])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:59:28 -0800
Date:   Mon, 13 Dec 2021 18:57:29 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jann Horn <jannh@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, fengwei.yin@intel.com
Subject: Re: [LKP] Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7%
 regression
Message-ID: <20211213105728.GA21139@linux.intel.com>
References: <20211210053743.GA36420@xsang-OptiPlex-9020>
 <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Dec 10, 2021 at 10:33:43AM -0800, Linus Torvalds wrote:
> On Thu, Dec 9, 2021 at 9:38 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -5.7% regression of will-it-scale.per_thread_ops due to commit:
> > 054aa8d439b9  ("fget: check that the fd still exists after getting a ref to it")
> 
> Well, some downside of the new checks was expected, that's just much
> more than I really like or would have thought.
> 
> But it's exactly where you'd expect:
> 
> >      27.16 ± 10%      +4.3       31.51 ±  2%  perf-profile.calltrace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      22.91 ± 10%      +4.4       27.34 ±  2%  perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64
> >      26.33 ± 10%      +4.4       30.70 ±  2%  perf-profile.children.cycles-pp.__fget_light
> >      22.92 ± 10%      +4.4       27.35 ±  2%  perf-profile.children.cycles-pp.__fget_files
> >      22.70 ± 10%      +4.4       27.11 ±  2%  perf-profile.self.cycles-pp.__fget_files
> 
> although there's odd spikes in dTLB-loads etc.
> 
> I checked whether it's some unexpected code generation issue, but the
> new "re-check file table after refcount update" really looks very
> cheap when I look at what gcc generates, there's nothing really
> unexpected there.
> 
> What did change was:
> 
>  (a) some branches go other ways, which might well affect branch
> prediction and just be unlucky. It might be that just marking the
> mismatch case "unlikely()" will help.
> 
>  (b) the obvious few new instructions (re-load and check file table
> pointer, re-load and check file pointer)
> 
>  (c) that __fget_files() function is now no longer a leaf function in
> a simple config case, since it calls "fput_many" in the error case.
> 
> And that (c) is worth mentioning simply because it means that the
> function goes from not having any stack frame at all, to having to
> save/restore four registers. So now it has the usual push/pop
> sequences.
> 
> It may also be that the test-case actually does a lot of threaded
> open/close/poll, and either actually triggers the re-lookup looping
> case (unlikely) or just sees a lot of cacheline bouncing that now got
> worse due to the re-check of the file pointer.
> 
> So this regression looks real, and the issue seems to be that
> __fget_files() really is _that_ important for this do_sys_poll()
> benchmark, and even just the handful of extra instructions end up
> being meaningful.
> 
> Oliver - I'm attaching the obvious "unlikely9)" oneliner in case it's
> just "gcc thought the retry loop was the common case" issue and bad
> branch prediction.

We tested your patch, it didn't work, still has -6.0% regression, thanks.

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/poll2/will-it-scale/0x42e

commit:
  5f58da2bef ("Merge tag 'drm-fixes-2021-12-03-1' of git://anongit.freedesktop.org/drm/drm")
  054aa8d439 ("fget: check that the fd still exists after getting a ref to it")
  ef8c68873e ("fixup-for-054aa8d439")

5f58da2befa58edf 054aa8d439b9185d4f5eb9a9028 ef8c68873e75cf486bec22c3e8d 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
   6666720            -5.7%    6288280            -6.0%    6268295        will-it-scale.24.threads
    277779            -5.7%     262011            -6.0%     261178        will-it-scale.per_thread_ops
   6666720            -5.7%    6288280            -6.0%    6268295        will-it-scale.workload
     28.74 ± 23%      -1.9       26.84 ±  6%      +1.2       29.92 ± 25%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     27.82 ± 23%      -1.9       25.93 ±  5%      +1.4       29.20 ± 26%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.82 ± 23%      -1.9       25.93 ±  5%      +1.4       29.20 ± 26%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     27.83 ± 23%      -1.9       25.94 ±  5%      +1.4       29.20 ± 26%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.83 ± 23%      -1.9       25.94 ±  5%      +1.4       29.20 ± 26%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.83 ± 23%      -1.9       25.94 ±  5%      +1.4       29.20 ± 26%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     28.81 ± 23%      -1.9       26.93 ±  6%      +1.2       29.98 ± 25%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     19.12 ±  9%      -1.7       17.39 ±  2%      -2.5       16.64 ± 11%  perf-profile.calltrace.cycles-pp.fput_many.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      -0.2        0.10 ±223%      -0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.__kmalloc.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.88 ±  9%      -0.1        2.76 ±  2%      -0.2        2.64 ± 11%  perf-profile.calltrace.cycles-pp.testcase
      3.27 ±  9%      -0.1        3.18 ±  2%      -0.2        3.04 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      1.70 ±  9%      -0.1        1.63 ±  2%      -0.1        1.56 ± 11%  perf-profile.calltrace.cycles-pp.__fdget.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.70 ± 10%      -0.1        1.64 ±  2%      -0.1        1.58 ± 10%  perf-profile.calltrace.cycles-pp.fput.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04 ±  8%      -0.1        0.98 ±  4%      -0.1        0.96 ± 11%  perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.64 ±  9%      -0.1        1.59 ±  3%      -0.1        1.50 ± 10%  perf-profile.calltrace.cycles-pp.__entry_text_start.__poll
      1.69 ±  9%      -0.0        1.65 ±  3%      -0.1        1.57 ± 12%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
      1.11 ±  9%      -0.0        1.08 ±  4%      -0.1        1.02 ±  9%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.48 ±  8%      -0.0        1.45 ±  4%      -0.1        1.38 ± 10%  perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ± 57%      -0.0        0.92 ± 54%      -0.2        0.74 ± 56%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 57%      -0.0        0.92 ± 54%      -0.2        0.74 ± 56%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 57%      -0.0        0.92 ± 54%      -0.2        0.74 ± 56%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 57%      -0.0        0.92 ± 54%      -0.2        0.74 ± 56%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.94 ± 57%      -0.0        0.92 ± 54%      -0.2        0.74 ± 56%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.54 ± 45%      +0.1        0.59 ±  9%      +0.1        0.66 ±  6%  perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.66 ±  9%      +2.0       69.69 ±  2%      -0.9       66.78 ± 10%  perf-profile.calltrace.cycles-pp.__poll
     63.66 ±  9%      +2.2       65.82 ±  2%      -0.6       63.10 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     63.48 ±  9%      +2.2       65.64 ±  2%      -0.6       62.93 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     59.85 ±  9%      +2.3       62.12 ±  2%      -0.3       59.56 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     57.74 ±  9%      +2.4       60.09 ±  2%      -0.1       57.62 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     27.16 ± 10%      +4.3       31.51 ±  2%      +3.0       30.21 ± 10%  perf-profile.calltrace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.91 ± 10%      +4.4       27.34 ±  2%      +3.3       26.25 ± 10%  perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64
     27.83 ± 23%      -1.9       25.94 ±  5%      +1.4       29.20 ± 26%  perf-profile.children.cycles-pp.start_secondary
     28.80 ± 23%      -1.9       26.92 ±  6%      +1.2       29.98 ± 25%  perf-profile.children.cycles-pp.cpuidle_enter
     28.80 ± 23%      -1.9       26.92 ±  6%      +1.2       29.98 ± 25%  perf-profile.children.cycles-pp.cpuidle_enter_state
     28.81 ± 23%      -1.9       26.93 ±  6%      +1.2       29.98 ± 25%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     28.81 ± 23%      -1.9       26.93 ±  6%      +1.2       29.98 ± 25%  perf-profile.children.cycles-pp.cpu_startup_entry
     28.81 ± 23%      -1.9       26.93 ±  6%      +1.2       29.98 ± 25%  perf-profile.children.cycles-pp.do_idle
     28.78 ± 23%      -1.9       26.91 ±  6%      +1.2       29.96 ± 25%  perf-profile.children.cycles-pp.intel_idle
     18.28 ±  9%      -1.7       16.59 ±  2%      -2.4       15.87 ± 11%  perf-profile.children.cycles-pp.fput_many
      2.90 ±  9%      -0.1        2.76 ±  2%      -0.3        2.64 ± 11%  perf-profile.children.cycles-pp.testcase
      3.29 ±  9%      -0.1        3.20 ±  2%      -0.2        3.07 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.69 ±  9%      -0.1        1.63 ±  2%      -0.1        1.57 ± 10%  perf-profile.children.cycles-pp.__fdget
      1.70 ±  9%      -0.1        1.64 ±  2%      -0.1        1.57 ± 10%  perf-profile.children.cycles-pp.fput
      1.82 ±  9%      -0.1        1.76 ±  3%      -0.2        1.67 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      1.07 ±  9%      -0.1        1.02 ±  4%      -0.1        0.99 ± 10%  perf-profile.children.cycles-pp.__check_object_size
      1.90 ±  9%      -0.0        1.86 ±  2%      -0.1        1.77 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.50 ±  8%      -0.0        1.47 ±  4%      -0.1        1.39 ± 10%  perf-profile.children.cycles-pp._copy_from_user
      1.12 ±  9%      -0.0        1.09 ±  4%      -0.1        1.03 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.30 ±  8%      -0.0        0.26 ± 11%      -0.0        0.29 ± 20%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.12 ±  8%      -0.0        0.09 ± 11%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.poll@plt
      0.04 ± 71%      -0.0        0.01 ±223%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.seq_read_iter
      0.17 ± 26%      -0.0        0.14 ± 32%      -0.0        0.14 ± 23%  perf-profile.children.cycles-pp.cmd_sched
      0.17 ± 26%      -0.0        0.14 ± 32%      -0.0        0.14 ± 23%  perf-profile.children.cycles-pp.cmd_record
      0.04 ± 71%      -0.0        0.02 ±144%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.ksys_read
      0.04 ± 71%      -0.0        0.02 ±144%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.vfs_read
      0.61 ± 13%      -0.0        0.59 ±  9%      +0.1        0.66 ±  5%  perf-profile.children.cycles-pp.kfree
      0.17 ± 26%      -0.0        0.15 ± 30%      -0.0        0.15 ± 21%  perf-profile.children.cycles-pp.__libc_start_main
      0.17 ± 26%      -0.0        0.15 ± 30%      -0.0        0.15 ± 21%  perf-profile.children.cycles-pp.main
      0.17 ± 26%      -0.0        0.15 ± 30%      -0.0        0.15 ± 21%  perf-profile.children.cycles-pp.run_builtin
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.new_sync_write
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.ksys_write
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.vfs_write
      0.04 ± 45%      -0.0        0.02 ± 99%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.13 ± 10%      -0.0        0.12 ±  6%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.kmalloc_slab
      0.02 ± 99%      -0.0        0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.seq_read
      0.02 ± 99%      -0.0        0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__libc_read
      0.15 ± 26%      -0.0        0.14 ± 31%      -0.0        0.13 ± 23%  perf-profile.children.cycles-pp.record__finish_output
      0.15 ± 26%      -0.0        0.14 ± 31%      -0.0        0.13 ± 23%  perf-profile.children.cycles-pp.perf_session__process_events
      0.06 ± 46%      -0.0        0.04 ± 73%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.machines__deliver_event
      0.14 ± 27%      -0.0        0.12 ± 32%      -0.0        0.12 ± 19%  perf-profile.children.cycles-pp.process_simple
      0.09 ± 30%      -0.0        0.08 ± 34%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.05 ± 47%      -0.0        0.04 ± 71%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.exc_page_fault
      0.10 ± 24%      -0.0        0.08 ± 30%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.poll_select_set_timeout
      0.09 ± 24%      -0.0        0.08 ± 28%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.proc_reg_read
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_output_sample
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.04 ± 45%      -0.0        0.04 ± 71%      -0.0        0.00        perf-profile.children.cycles-pp.perf_callchain_user
      0.29 ±  9%      -0.0        0.28 ±  4%      -0.0        0.28 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11 ± 12%      -0.0        0.10 ±  8%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__might_sleep
      0.05 ± 49%      -0.0        0.05 ± 52%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.check_stack_object
      0.16 ± 20%      -0.0        0.16 ±  9%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.12 ± 20%      -0.0        0.11 ±  8%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.unwind_next_frame
      0.29 ± 11%      -0.0        0.28 ±  5%      -0.0        0.26 ±  9%  perf-profile.children.cycles-pp.__check_heap_object
      0.43 ± 19%      +0.0        0.43 ± 10%      -0.1        0.37 ±  9%  perf-profile.children.cycles-pp.update_process_times
      0.23 ± 20%      +0.0        0.23 ± 11%      -0.0        0.18 ±  9%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.21 ± 20%      +0.0        0.21 ± 10%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.perf_callchain
      0.02 ±142%      +0.0        0.02 ±142%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.io_serial_in
      0.02 ±141%      +0.0        0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.ordered_events__queue
      0.07 ± 12%      +0.0        0.07 ±  6%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.uart_console_write
      0.07 ± 12%      +0.0        0.08 ±  6%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.serial8250_console_write
      0.21 ± 21%      +0.0        0.21 ± 10%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.get_perf_callchain
      0.07 ± 12%      +0.0        0.07 ±  6%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.08 ± 12%      +0.0        0.08 ±  6%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.vprintk_emit
      0.08 ± 12%      +0.0        0.08 ±  6%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.console_unlock
      0.48 ± 17%      +0.0        0.48 ±  9%      -0.1        0.42 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.32 ± 21%      +0.0        0.32 ± 11%      -0.1        0.26 ± 11%  perf-profile.children.cycles-pp.update_curr
      0.61 ± 16%      +0.0        0.61 ±  7%      -0.1        0.55 ± 10%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ± 21%      +0.0        0.30 ± 10%      -0.1        0.24 ± 10%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.28 ± 20%      +0.0        0.29 ± 10%      -0.1        0.23 ± 11%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.28 ± 19%      +0.0        0.28 ± 11%      -0.1        0.23 ± 10%  perf-profile.children.cycles-pp.perf_event_output_forward
      0.29 ± 10%      +0.0        0.29 ±  9%      -0.0        0.28 ± 10%  perf-profile.children.cycles-pp.__might_fault
      0.08 ± 12%      +0.0        0.08 ± 22%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.worker_thread
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.process_one_work
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.commit_tail
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.memcpy_toio
      0.07 ±  8%      +0.0        0.07 ±  6%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.43 ± 19%      +0.0        0.44 ±  9%      -0.1        0.38 ±  9%  perf-profile.children.cycles-pp.tick_sched_handle
      0.57 ± 16%      +0.0        0.58 ±  7%      -0.1        0.52 ±  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.05 ± 47%      +0.0        0.06 ±  8%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__unwind_start
      0.28 ± 20%      +0.0        0.29 ± 10%      -0.1        0.23 ± 11%  perf-profile.children.cycles-pp.perf_swevent_overflow
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.irq_work_run
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.irq_work_single
      0.07 ±  9%      +0.0        0.08 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp._printk
      0.44 ± 19%      +0.0        0.45 ±  9%      -0.1        0.38 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      0.54 ± 17%      +0.0        0.55 ±  8%      -0.1        0.49 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.54 ± 17%      +0.0        0.54 ±  8%      -0.1        0.48 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.37 ± 19%      +0.0        0.37 ± 10%      -0.1        0.31 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 47%      +0.0        0.07 ± 18%      -0.0        0.06 ± 21%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.07 ±  9%      +0.0        0.08 ±  8%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.irq_work_run_list
      0.98 ± 47%      +0.0        0.99 ± 38%      -0.2        0.78 ± 45%  perf-profile.children.cycles-pp.start_kernel
      0.29 ± 21%      +0.0        0.30 ± 10%      -0.1        0.24 ± 10%  perf-profile.children.cycles-pp.perf_tp_event
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.queue_event
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.poll_freewait
      0.39 ± 19%      +0.0        0.40 ±  9%      -0.1        0.34 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.04 ± 71%      +0.0        0.04 ± 45%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.06 ±  8%      +0.0        0.07 ± 11%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.ret_from_fork
      0.06 ±  8%      +0.0        0.07 ± 11%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.kthread
      0.19 ± 10%      +0.0        0.20 ±  9%      +0.0        0.19 ± 10%  perf-profile.children.cycles-pp.__might_resched
      0.02 ±141%      +0.0        0.03 ± 70%      -0.0        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±223%      +0.0        0.03 ± 70%      -0.0        0.00        perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.50 ± 12%      +0.0        0.53 ±  9%      -0.0        0.48 ± 11%  perf-profile.children.cycles-pp.__kmalloc
     67.89 ±  9%      +2.0       69.92 ±  2%      -0.9       67.00 ± 10%  perf-profile.children.cycles-pp.__poll
     63.84 ±  9%      +2.1       65.97 ±  2%      -0.6       63.26 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     63.66 ±  9%      +2.1       65.80 ±  2%      -0.6       63.09 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
     59.86 ±  9%      +2.3       62.12 ±  2%      -0.3       59.57 ± 10%  perf-profile.children.cycles-pp.__x64_sys_poll
     59.47 ±  9%      +2.3       61.75 ±  2%      -0.2       59.22 ± 10%  perf-profile.children.cycles-pp.do_sys_poll
     26.33 ± 10%      +4.4       30.70 ±  2%      +3.1       29.43 ± 10%  perf-profile.children.cycles-pp.__fget_light
     22.92 ± 10%      +4.4       27.35 ±  2%      +3.3       26.26 ± 10%  perf-profile.children.cycles-pp.__fget_files
     28.78 ± 23%      -1.9       26.91 ±  6%      +1.2       29.96 ± 25%  perf-profile.self.cycles-pp.intel_idle
     17.29 ±  9%      -1.6       15.64 ±  2%      -2.3       14.96 ± 11%  perf-profile.self.cycles-pp.fput_many
     11.06 ±  9%      -0.3       10.74 ±  2%      -0.8       10.29 ± 10%  perf-profile.self.cycles-pp.do_sys_poll
      2.87 ±  9%      -0.1        2.74 ±  2%      -0.2        2.62 ± 11%  perf-profile.self.cycles-pp.testcase
      3.21 ±  9%      -0.1        3.12 ±  2%      -0.2        3.00 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.60 ±  9%      -0.1        1.54 ±  4%      -0.1        1.47 ± 10%  perf-profile.self.cycles-pp.__entry_text_start
      1.90 ±  8%      -0.0        1.86 ±  3%      -0.1        1.76 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.55 ±  9%      -0.0        2.51 ±  4%      -0.2        2.36 ± 12%  perf-profile.self.cycles-pp.__fget_light
      0.84 ±  8%      -0.0        0.81 ±  2%      -0.1        0.78 ± 10%  perf-profile.self.cycles-pp.fput
      0.29 ±  8%      -0.0        0.26 ± 11%      -0.0        0.28 ± 20%  perf-profile.self.cycles-pp.__virt_addr_valid
      1.10 ±  9%      -0.0        1.07 ±  4%      -0.1        1.01 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.28 ±  8%      -0.0        0.26 ±  5%      -0.0        0.26 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.84 ±  9%      -0.0        0.82 ±  3%      -0.0        0.79 ± 10%  perf-profile.self.cycles-pp.__fdget
      0.10 ±  6%      -0.0        0.08 ± 10%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.poll@plt
      0.60 ± 12%      -0.0        0.59 ±  9%      +0.1        0.66 ±  6%  perf-profile.self.cycles-pp.kfree
      0.11 ± 12%      -0.0        0.09 ±  7%      -0.0        0.10 ± 13%  perf-profile.self.cycles-pp._copy_from_user
      0.44 ±  9%      -0.0        0.43 ±  3%      -0.0        0.40 ± 15%  perf-profile.self.cycles-pp.__check_object_size
      0.31 ± 10%      -0.0        0.30 ±  3%      -0.0        0.28 ± 15%  perf-profile.self.cycles-pp.__x64_sys_poll
      0.18 ±  8%      -0.0        0.17 ±  5%      -0.0        0.16 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.poll_select_set_timeout
      0.04 ± 71%      -0.0        0.02 ± 99%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.12 ± 10%      -0.0        0.12 ±  6%      -0.0        0.12 ± 17%  perf-profile.self.cycles-pp.kmalloc_slab
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06 ± 11%      -0.0        0.05 ±  8%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.03 ±100%      -0.0        0.02 ±142%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.check_stack_object
      0.28 ± 11%      -0.0        0.27 ±  5%      -0.0        0.25 ± 11%  perf-profile.self.cycles-pp.__check_heap_object
      0.09 ± 13%      -0.0        0.09 ±  7%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.__might_sleep
      0.08 ± 17%      -0.0        0.08 ± 25%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__might_fault
      0.03 ±100%      -0.0        0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.unwind_next_frame
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.02 ±142%      +0.0        0.02 ±142%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.io_serial_in
      0.11 ±  9%      +0.0        0.12 ±  8%      -0.0        0.11 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.44 ±  8%      +0.0        0.45 ±  4%      -0.0        0.42 ± 12%  perf-profile.self.cycles-pp.__poll
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.queue_event
      0.18 ± 11%      +0.0        0.19 ±  8%      -0.0        0.18 ± 10%  perf-profile.self.cycles-pp.__might_resched
      0.26 ± 13%      +0.0        0.30 ± 17%      -0.0        0.25 ± 13%  perf-profile.self.cycles-pp.__kmalloc
     22.70 ± 10%      +4.4       27.11 ±  2%      +3.3       26.04 ± 10%  perf-profile.self.cycles-pp.__fget_files

> 
> And it would perhaps be interesting to get an actual instruction-level
> profile of that __fget_files() thing for that benchmark, if that
> pinpoints exactly what is going on and in case that would be easy to
> get on that machine.
> 
> Because it might just be truly horrendously bad luck, with the 32-byte
> stack frame meaning that the kernel stack goes one more page down
> (just jhandwaving from the dTLB number spike), and this all being just
> random bad luck on that particular benchmark.
> 
> Of course, the thing about poll() is that for that case, we *don't*
> really need the "re-check the file descriptor" code at all, since the
> resulting fd isn't going to be installed as a new fd, and it doesn't
> matter for the socket garbage collector logic.
> 
> So maybe it was a mistake to put that re-check in the generic fdget()
> code - yes, it should be cheap, but it's also some of the most hot
> code in the kernel on some loads.
> 
> But if we move it elsewhere, we'd need to come up with some list of
> "these cases need it". Some are obvious: dup, dup2, unix domain file
> passing. It's the non-obvious ones I'd worry about.
> 
> Anybody?
> 
>               Linus

>  fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index ad4a8bf3cf10..f802360e240d 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -858,7 +858,7 @@ static struct file *__fget_files(struct files_struct *files, unsigned int fd,
>  			file = NULL;
>  		else if (!get_file_rcu_many(file, refs))
>  			goto loop;
> -		else if (files_lookup_fd_raw(files, fd) != file) {
> +		else if (unlikely(files_lookup_fd_raw(files, fd) != file)) {
>  			fput_many(file, refs);
>  			goto loop;
>  		}

> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

