Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86257726B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiGPXRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiGPXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FF1AF19
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:13 -0700 (PDT)
Message-ID: <20220716230344.239749011@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yOtYZr5+Pahqs+AW9/vnNXO5Em6kS4LfOO8zBrZ2YZA=;
        b=fM+dxU3nqFrwhB/Oq1d14LYOb14B73yW3uHVB0riYixWDcv5+3B5hnm6yq7KA7fZu75Bgx
        Gy/GLaglhnMbtjandsPhYtI3DPZv+kF/0MnxtFXdL/jbbpIQEzxCAYOGcr0kaelLXC331s
        LDXEIj85BTCYBBbOQs3kC5oNvpiUTRNL1sjQVeYR3rscJdVyX78jLiE1fmvpyv/uT8YUJl
        Ty+VE5VszHaccwFG6m1k6gjTRyJgFjAhhjHmbYcmYv4+mtRKktsnDROZg0QS65AkEKsn9p
        DeINjs4Bj5TucyEY0l/lQ9ZJaNUx+G9BcZW5wejYEN1Rei8v349BdBy7K8hccQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yOtYZr5+Pahqs+AW9/vnNXO5Em6kS4LfOO8zBrZ2YZA=;
        b=v78dtPUW8TUeOtpaHIxPPZEe7FHlXLuJe6l/Ih0Douo6WawxbDuSw7H2BdeRB4jQEOuzXs
        T6lPAuvwHlWBAjAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Date:   Sun, 17 Jul 2022 01:17:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

Back in the good old spectre v2 days (2018) we decided to not use
IBRS. In hindsight this might have been the wrong decision because it did
not force people to come up with alternative approaches.

It was already discussed back then to try software based call depth
accounting and RSB stuffing on underflow for Intel SKL[-X] systems to avoid
the insane overhead of IBRS.

This has been tried in 2018 and was rejected due to the massive overhead
and other shortcomings of the approach to put the accounting into each
function prologue:

  1) Text size increase which is inflicted on everyone.  While CPUs are
     good in ignoring NOPs they still pollute the I-cache.

  2) That results in tail call over-accounting which can be exploited.

Disabling tail calls is not an option either and adding a 10 byte padding
in front of every direct call is even worse in terms of text size and
I-cache impact. We also could patch calls past the accounting in the
function prologue but that becomes a nightmare vs. ENDBR.

As IBRS is a performance horror show, Peter Zijstra and me revisited the
call depth tracking approach and implemented it in a way which is hopefully
more palatable and avoids the downsides of the original attempt.

We both unsurprisingly hate the result with a passion...

The way we approached this is:

 1) objtool creates a list of function entry points and a list of direct
    call sites into new sections which can be discarded after init.

 2) On affected machines, use the new sections, allocate module memory
    and create a call thunk per function (16 bytes without
    debug/statistics). Then patch all direct calls to invoke the thunk,
    which does the call accounting and then jumps to the original call
    site.

 3) Utilize the retbleed return thunk mechanism by making the jump
    target run-time configurable. Add the accounting counterpart and
    stuff RSB on underflow in that alternate implementation.

This does not need a new compiler and avoids almost all overhead for
non-affected machines. It can be selected via 'retbleed=stuff' on the
kernel command line.

The memory consumption is impressive. On a affected server with a Debian
config this results in about 1.8MB call thunk memory and 2MB btree memory
to keep track of the thunks. The call thunk memory is overcommitted due to
the way how objtool collects symbols. This probably could be cut in half,
but we need to allocate a 2MB region anyway due to the following:

Our initial approach of just using module_alloc() turned out to create a
massive ITLB miss rate, which is not surprising as each call goes out to a
randomly distributed call thunk. Peter added a method to allocate with
large 2MB TLBs which made that problem mostly go away and gave us another
nice performance gain. It obviously does not reduce ICache overhead. It
neither cures the problem that the ITLB cache has one slot permanently
occupied by the call-thunk mapping.

The theory behind call depth tracking is:

RSB is a stack with depth 16 which is filled on every call. On the return
path speculation "pops" entries to speculate down the call chain. Once the
speculative RSB is empty it switches to other predictors, e.g. the Branch
History Buffer, which can be mistrained by user space and misguides the
speculation path to a disclosure gadget as described in the retbleed paper.

Call depth tracking is designed to break this speculation path by stuffing
speculation trap calls into the RSB which are never getting a corresponding
return executed. This stalls the prediction path until it gets resteered,

The assumption is that stuffing at the 12th return is sufficient to break
the speculation before it hits the underflow and the fallback to the other
predictors. Testing confirms that it works. Johannes, one of the retbleed
researchers. tried to attack this approach and confirmed that it brings
the signal to noise ratio down to the crystal ball level.

There is obviously no scientific proof that this will withstand future
research progress, but all we can do right now is to speculate about that.

So much for the theory. Here are numbers for various tests I did myself and
FIO results provided by Tim Chen.

Just to make everyone feel as bad as I feel, this comes with two overhead
values: one against mitigations=off and one against retbleed=off.

hackbench	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	   24.41s			  0.00%		-15.26%
retbleed=off	   28.80s	 		+18.00%		  0.00%
retbleed=ibrs	   34.92s	 		+43.07%		+21.24%
retbleed=stuff	   31.95s	 		+30.91%		+10.94%
----------------------------------------------------------------------------
				
sys_time loop	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	   1.28s			  0.00%		-78.66%
retbleed=off	   5.98s		       +368.50%		  0.00%
retbleed=ibrs	   9.73s		       +662.81%		+62.82%
retbleed=stuff	   6.15s		       +381.93%		 +2.87%
----------------------------------------------------------------------------
				
kernel build	       		Baseline: mitigations=off       retbleed=off
----------------------------------------------------------------------------
mitigations=off	   197.55s			  0.00%		 -3.64%
retbleed=off	   205.02s	  		 +3.78%		  0.00%
retbleed=ibrs	   218.00s			+10.35%		 +6.33%
retbleed=stuff	   209.92s	  		 +6.26%		 +2.39%
----------------------------------------------------------------------------
				
microbench deep
callchain	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	   1.72s			  0.00%		-39.88%
retbleed=off	   2.86s	 	        +66.34%		  0.00%
retbleed=ibrs	   3.92s		       +128.23%		+37.20%
retbleed=stuff	   3.39s		        +97.05%		+18.46%
----------------------------------------------------------------------------

fio rand-read	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	  352.7 kIOPS			  0.00%		 +3.42%
retbleed=off	  341.0 kIOPS			 -3.31%		  0.00%
retbleed=ibrs	  242.0 kIOPS			-31.38%		-29.03%
retbleed=stuff	  288.3	kIOPS			-18.24%		-15.44%
----------------------------------------------------------------------------

fio 70/30	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	  349.0 kIOPS			  0.00%		+10.49%
retbleed=off	  315.9 kIOPS			 -9.49%		  0.00%
retbleed=ibrs	  241.5 kIOPS			-30.80%		-23.54%
retbleed=stuff	  276.2	kIOPS			-20.86%		-12.56%
----------------------------------------------------------------------------

fio write	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	  299.3 kIOPS			  0.00%		+10.49%
retbleed=off	  275.6 kIOPS			 -9.49%		  0.00%
retbleed=ibrs	  232.7 kIOPS			-22.27%		-15.60%
retbleed=stuff	  259.3	kIOPS			-13.36%		 -5.93%
----------------------------------------------------------------------------

Sockperf 14 byte
localhost	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	  4.495 MBps			  0.00%	        +33.19%
retbleed=off	  3.375	MBps		        -24.92%	  	  0.00%
retbleed=ibrs	  2.573	MBps		        -42.76%	        -23.76%
retbleed=stuff	  2.725	MBps		        -39.38%	        -19.26%
----------------------------------------------------------------------------
				
Sockperf 1472 byte
localhost	       		Baseline: mitigations=off	retbleed=off
----------------------------------------------------------------------------
mitigations=off	  425.494 MBps			  0.00%		+26.21%
retbleed=off	  337.132 MBps		        -20.77%		  0.00%
retbleed=ibrs	  261.243 MBps		        -38.60%		-22.51%
retbleed=stuff	  275.111 MBps		        -35.34%		-18.40%
----------------------------------------------------------------------------

The micro benchmark is just an artificial 30 calls deep call-chain through
a syscall with empty functions to measure the overhead. But it's also
interestingly close to the pathological FIO random read case. It just
emphasizes the overhead slightly more. I wrote that because I was not able
to take real FIO numbers as any variant was close to the max-out point of
that not so silly fast SSD/NVME in my machine.

So the benefit varies depending on hardware and workload scenarios. At
least it does not get worse than IBeeRS.

The whole lot is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git depthtracking

The ftrace and BPF changes need some extra scrunity from the respective
experts.

Peter and me went great length to analyze the overhead. Unsurprisingly the
call thunks are contributing the largest amount after the actual stuffing
in the return thunk. The call thunks are creating trouble in various ways:

 1) An extra ITLB which has been very prominent in our first experiments
    where we had 4k PTEs instead of the 2M mapping which we use now.
    But this still causes ITLB misses in certain workloads

 2) Icache footprint is obviously larger and the out of line call-thunks
    are not prefetcher friendly.

 3) The extra jump adds overhead for predictors and branch history

A potential solution for this is to let the compiler add a 16 byte padding
in front of every function. That allows to bring the call thunk into
ITLB/Icache locality and avoids the extra jump.

Obviously this would only affect SKL variants and no other machine would go
through that code (which is just padding in the compiled binary). Contrary
to adding this to the prologue and NOPing it out, this avoids the ICache
overhead for the non SKL case completely.

The function alignment option does not work for that because it just
guarantees that the next function entry is aligned, but the padding size
depends on the position of the last instruction of the previous function
which might be anything between 0 and padsize-1 obviously, which is not a
good starting point to put 10 bytes of accounting code into it reliably.

I hacked up GCC to emit such padding and from first experimentation it
brings quite some performance back.

           	      	 IBRS	    stuff       stuff(pad)
sockperf 14   bytes: 	 -23.76%    -19.26%     -14.31%
sockperf 1472 bytes: 	 -22.51%    -18.40%     -12.25%
microbench:   	     	 +37.20%    +18.46%     +15.47%    
hackbench:	     	 +21.24%    +10.94%     +10.12%

For FIO I don't have numbers yet, but I expect FIO to get a significant
gain too.

>From a quick survey it seems to have no impact for the case where the
thunks are not used. But that really needs some deep investigation and
there is a potential conflict with the clang CFI efforts.

The kernel text size increases with a Debian config from 9.9M to 10.4M, so
about 5%. If the thunk is not 16 byte aligned, the text size increase is
about 3%, but it turned out that 16 byte aligned is slightly faster.

The 16 byte function alignment turned out to be beneficial in general even
without the thunks. Not much of an improvement, but measurable. We should
revisit this independent of these horrors.

The implementation falls back to the allocated thunks when padding is not
available. I'll send out the GCC patch and the required kernel patch as a
reply to this series after polishing it a bit.


We also evaluated another approach to solve this problem, which does not
involve call thunks and solely relies on return thunks. The idea is to have
a return thunk which is not reliably predictable. That option would be
"retbleed=confuse". It looks like this:

retthunk:
	test	$somebit, something
	jz	1f
	ret
	int3
1:
	test	$someotherbit, something
	jnz	2f
	ret
	int3
2:
	....

There are two questions to this approach:

 1) How does $something have enough entropy to be effective

    Ideally we can use a register for that, because the frequent memory
    operation in the return thunk has obviously a significant performance
    penalty.
    
    In combination with stack randomization the RSP looks like a feasible
    option, but for kernel centric workloads that does not create much
    entropy.

    Though keep in mind that the attacks rely on syscalls and observing
    their side effects.

    Which in turn means that entry stack randomization is a good entropy
    source. But it's easy enough to create a scenario where the attacking
    thread spins and relies on interrupts to cause the kernel entry.

    Interrupt entry from user-space does not do kernel task stack
    randomization today, but that's easy enough to fix.

    If we can't use RSP because it turns out to be too predictable, then we
    can still create entropy in a per CPU variable, but RSP is definitely
    faster than a memory access.

 2) How "easy" is it to circumvent the "randomization"

    It makes it impossible for the occasional exploit writer like myself
    and probably for the vast majority of script kiddies, but we really
    need input from the researchers who seem to have way more nasty ideas
    than we can imagine.

    I asked some of those folks, but the answers were not conclusive at
    all. There are some legitimate concerns, but the question is whether
    they are real threats or purely academic problems (at the moment).

    That retthunk "randomization" can easily be extended to have several
    return thunks and they can be assigned during patching randomly. As
    that's a boot time decision it's possible to figure it out, but in the
    worst case we can randomly reassign them once in a while.

But also this approach has quite some performance impact:

For 2 RET pathes randomized with randomize_kstack_offset=y and RSP bit 3:

          	  	IBRS       stuff	 stuff(pad)    confuse
  microbench:	       	+37.20%	   +18.46%	 +15.47%       +6.76%	 
  sockperf 14   bytes: 	-23.76%	   -19.26% 	 -14.31%       -9.04%
  sockperf 1472 bytes: 	-22.51%	   -18.40% 	 -12.25%       -7.51%

For 3 RET pathes randomized with randomize_kstack_offset=y and RSP bit 3, 6:

          	  	IBRS       stuff	 stuff(pad)    confuse
  microbench:	       	+37.20%	   +18.46%	 +15.47%       +7.12%	 
  sockperf 14   bytes: 	-23.76%	   -19.26% 	 -14.31%      -12.03%
  sockperf 1472 bytes: 	-22.51%	   -18.40% 	 -12.25%      -10.49%

For 4 RET pathes randomized with randomize_kstack_offset=y and RSP bit 3, 6, 5:

          	  	IBRS       stuff	 stuff(pad)    confuse
  microbench:	       	+37.20%	   +18.46%	 +15.47%       +7.46%	 
  sockperf 14   bytes: 	-23.76%	   -19.26% 	 -14.31%      -16.80%
  sockperf 1472 bytes: 	-22.51%	   -18.40% 	 -12.25%      -15.95%

So for the more randomized variant sockperf tanks and is already slower
than stuffing with thunks in the compiler provided padding space.

I send out a patch in reply to this series which implements that variant,
but there needs to be input from the security researchers how protective
this is. If we could get away with 2 RET pathes (perhaps multiple instances
with different bits), that would be amazing.

Thanks go to Andrew Cooper for helpful discussions around this, Johannes
Wikner for spending the effort of trying to break the stuffing defense and
to Tim Chen for getting the FIO numbers to us.

And of course many thanks to Peter for working on this with me. We went
through quite some mispredicted branches and had to retire some "brilliant"
ideas on the way.

Thanks,

	tglx
---
 arch/x86/Kconfig                            |   37 +
 arch/x86/entry/entry_64.S                   |   26 
 arch/x86/entry/vdso/Makefile                |   11 
 arch/x86/include/asm/alternative.h          |   69 ++
 arch/x86/include/asm/cpufeatures.h          |    1 
 arch/x86/include/asm/disabled-features.h    |    9 
 arch/x86/include/asm/module.h               |    2 
 arch/x86/include/asm/nospec-branch.h        |  166 +++++
 arch/x86/include/asm/paravirt.h             |    5 
 arch/x86/include/asm/paravirt_types.h       |   21 
 arch/x86/include/asm/processor.h            |    1 
 arch/x86/include/asm/text-patching.h        |    2 
 arch/x86/kernel/Makefile                    |    2 
 arch/x86/kernel/alternative.c               |  114 +++
 arch/x86/kernel/callthunks.c                |  799 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c                  |   32 +
 arch/x86/kernel/cpu/common.c                |   17 
 arch/x86/kernel/ftrace.c                    |   20 
 arch/x86/kernel/ftrace_64.S                 |   31 +
 arch/x86/kernel/kprobes/core.c              |    1 
 arch/x86/kernel/module.c                    |   86 ---
 arch/x86/kernel/static_call.c               |    3 
 arch/x86/kernel/unwind_orc.c                |   21 
 arch/x86/kernel/vmlinux.lds.S               |   14 
 arch/x86/lib/retpoline.S                    |  106 +++
 arch/x86/mm/Makefile                        |    2 
 arch/x86/mm/module_alloc.c                  |   68 ++
 arch/x86/net/bpf_jit_comp.c                 |   56 +
 include/linux/btree.h                       |    6 
 include/linux/kallsyms.h                    |   24 
 include/linux/module.h                      |   72 +-
 include/linux/static_call.h                 |    2 
 include/linux/vmalloc.h                     |    3 
 init/main.c                                 |    2 
 kernel/kallsyms.c                           |   23 
 kernel/kprobes.c                            |   52 +
 kernel/module/internal.h                    |    8 
 kernel/module/main.c                        |    6 
 kernel/module/tree_lookup.c                 |   17 
 kernel/static_call_inline.c                 |   23 
 kernel/trace/trace_selftest.c               |    5 
 lib/btree.c                                 |    8 
 mm/vmalloc.c                                |   33 -
 samples/ftrace/ftrace-direct-modify.c       |    2 
 samples/ftrace/ftrace-direct-multi-modify.c |    2 
 samples/ftrace/ftrace-direct-multi.c        |    1 
 samples/ftrace/ftrace-direct-too.c          |    1 
 samples/ftrace/ftrace-direct.c              |    1 
 scripts/Makefile.lib                        |    3 
 tools/objtool/arch/x86/decode.c             |   26 
 tools/objtool/builtin-check.c               |    7 
 tools/objtool/check.c                       |  160 ++++-
 tools/objtool/include/objtool/arch.h        |    4 
 tools/objtool/include/objtool/builtin.h     |    1 
 tools/objtool/include/objtool/check.h       |   20 
 tools/objtool/include/objtool/elf.h         |    2 
 tools/objtool/include/objtool/objtool.h     |    1 
 tools/objtool/objtool.c                     |    1 
 58 files changed, 1970 insertions(+), 268 deletions(-)
