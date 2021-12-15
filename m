Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07F475D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbhLOQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:33:50 -0500
Received: from foss.arm.com ([217.140.110.172]:57148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244841AbhLOQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:33:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EBF26D;
        Wed, 15 Dec 2021 08:33:48 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7279A3F5A1;
        Wed, 15 Dec 2021 08:33:46 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:33:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/6] perf tools: determine if LR is the return address
Message-ID: <YboY541H4dVJDjyp@FVFF77S0Q05N>
References: <20211215151139.40854-1-german.gomez@arm.com>
 <20211215151139.40854-7-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215151139.40854-7-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 15, 2021 at 03:11:38PM +0000, German Gomez wrote:
> From: Alexandre Truong <alexandre.truong@arm.com>
> 
> On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
> use dwarf unwind info to check if the link register is the return
> address in order to inject it to the frame pointer stack.

This series looks good overall, but as a general note the commit messages are a
bit hard to read because they jump into implementation details of the patch
(i.e. the change the patch makes) before explaining the problem (i.e. what the
patch is trying to solve).

It would be nice to have a short introduction, e.g.

  When unwinding using frame pointers on arm64, the return address of the
  current leaf function may be missed. The return address of a leaf function
  may live in the LR and/or a frame record (and the location can change within
  a function), so it is necessary to use DWARF to identify where to look for
  the return address at any given point during a function.

  For example:

  unsigned long foo(unsigned long i)
  {
          i += 2;
	  i += 5;
  }

  ... could be compiled as:

  foo:
  	// return addr in LR
  	add	x0, x0, #2
	// return addr in LR
	stp	x29, x30, [SP, #-16]!
	// return addr in LR
	mov	x29, sp
	// return addr in LR *and* frame record
	add	x0, x0, #5
	// return addr in LR *and* frame record
	ldp	x29, x30, [sp], #16
	// return addr in LR
	ret

> Write the following application:
> 
> 	int a = 10;
> 
> 	void f2(void)
> 	{
> 		for (int i = 0; i < 1000000; i++)
> 			a *= a;
> 	}
> 
> 	void f1()
> 	{
> 		for (int i = 0; i < 10; i++)
> 			f2();
> 	}
> 
> 	int main(void)
> 	{
> 		f1();
> 		return 0;
> 	}
> 
> with the following compilation flags:
>         gcc -fno-omit-frame-pointer -fno-inline -O2
> 
> The compiler omits the frame pointer for f2 on arm. This is a problem
> with any leaf call, for example an application with many different
> calls to malloc() would always omit the calling frame, even if it
> can be determined.

I think the wording here is slightly misleading. For f2, the compiler *doesn't
create a frame record*, but the frame pointer (to the caller's frame record)
remains and is not omitted.

Also, I think it's woth noting (as per the example I gave above) this applies
to *any* function which is the current leaf function, regardless of whether
that function creates a frame record at some point. For example, if `f1` is
interrupted before it creates its own frame record (or after it destroys the
frame record), the FP will point at the record created by `main` (containing
the caller of main), and `main` itself will be missing from the unwind as it
will only exist in the LR.

> 	./perf record --call-graph fp ./a.out
> 	./perf report
> 
> currently gives the following stack:
> 
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f2
> 
> After this change, perf report correctly shows f1() calling f2(),
> even though it was missing from the frame pointer unwind:
> 
> 	./perf report
> 
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f1
> f2
> 
> Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/Build                         |  1 +
>  .../util/arm64-frame-pointer-unwind-support.c | 63 +++++++++++++++++++
>  .../util/arm64-frame-pointer-unwind-support.h | 10 +++
>  tools/perf/util/machine.c                     | 19 ++++--
>  tools/perf/util/machine.h                     |  1 +
>  5 files changed, 89 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.c
>  create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2e5bfbb69960..03d4c647bd86 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -1,3 +1,4 @@
> +perf-y += arm64-frame-pointer-unwind-support.o
>  perf-y += annotate.o
>  perf-y += block-info.o
>  perf-y += block-range.o
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> new file mode 100644
> index 000000000000..4f5ecf51ed38
> --- /dev/null
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arm64-frame-pointer-unwind-support.h"
> +#include "callchain.h"
> +#include "event.h"
> +#include "perf_regs.h" // SMPL_REG_MASK
> +#include "unwind.h"
> +
> +#define perf_event_arm_regs perf_event_arm64_regs
> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#undef perf_event_arm_regs
> +
> +struct entries {
> +	u64 stack[2];
> +	size_t length;
> +};
> +
> +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
> +{
> +	return callchain_param.record_mode == CALLCHAIN_FP && sample->user_regs.regs
> +		&& sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_LR);
> +}
> +
> +static int add_entry(struct unwind_entry *entry, void *arg)
> +{
> +	struct entries *entries = arg;
> +
> +	entries->stack[entries->length++] = entry->ip;
> +	return 0;
> +}
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int usr_idx)
> +{
> +	int ret;
> +	struct entries entries = {};
> +	struct regs_dump old_regs = sample->user_regs;
> +
> +	if (!get_leaf_frame_caller_enabled(sample))
> +		return 0;
> +
> +	/*
> +	 * If PC and SP are not recorded, get the value of PC from the stack
> +	 * and set its mask. SP is not used when doing the unwinding but it
> +	 * still needs to be set to prevent failures.
> +	 */

To prevent failures where? Is this something libunwind requires?

Thanks,
Mark.

> +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_PC))) {
> +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_PC);
> +		sample->user_regs.cache_regs[PERF_REG_ARM64_PC] = sample->callchain->ips[usr_idx+1];
> +	}
> +
> +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_SP))) {
> +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_SP);
> +		sample->user_regs.cache_regs[PERF_REG_ARM64_SP] = 0;
> +	}
> +
> +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
> +	sample->user_regs = old_regs;
> +
> +	if (ret || entries.length != 2)
> +		return ret;
> +
> +	return callchain_param.order == ORDER_CALLER ? entries.stack[0] : entries.stack[1];
> +}
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> new file mode 100644
> index 000000000000..32af9ce94398
> --- /dev/null
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +
> +#include "event.h"
> +#include "thread.h"
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int user_idx);
> +
> +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3eddad009f78..a00fd6796b35 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -34,6 +34,7 @@
>  #include "bpf-event.h"
>  #include <internal/lib.h> // page_size
>  #include "cgroup.h"
> +#include "arm64-frame-pointer-unwind-support.h"
>  
>  #include <linux/ctype.h>
>  #include <symbol/kallsyms.h>
> @@ -2710,10 +2711,13 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
>  	return err;
>  }
>  
> -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
> -		struct thread *thread __maybe_unused, int usr_idx __maybe_unused)
> +static u64 get_leaf_frame_caller(struct perf_sample *sample,
> +		struct thread *thread, int usr_idx)
>  {
> -	return 0;
> +	if (machine__normalize_is(thread->maps->machine, "arm64"))
> +		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
> +	else
> +		return 0;
>  }
>  
>  static int thread__resolve_callchain_sample(struct thread *thread,
> @@ -3114,14 +3118,19 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  }
>  
>  /*
> - * Compares the raw arch string. N.B. see instead perf_env__arch() if a
> - * normalized arch is needed.
> + * Compares the raw arch string. N.B. see instead perf_env__arch() or
> + * machine__normalize_is() if a normalized arch is needed.
>   */
>  bool machine__is(struct machine *machine, const char *arch)
>  {
>  	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
>  }
>  
> +bool machine__normalize_is(struct machine *machine, const char *arch)
> +{
> +	return machine && !strcmp(perf_env__arch(machine->env), arch);
> +}
> +
>  int machine__nr_cpus_avail(struct machine *machine)
>  {
>  	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index a143087eeb47..665535153411 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -208,6 +208,7 @@ static inline bool machine__is_host(struct machine *machine)
>  }
>  
>  bool machine__is(struct machine *machine, const char *arch);
> +bool machine__normalize_is(struct machine *machine, const char *arch);
>  int machine__nr_cpus_avail(struct machine *machine);
>  
>  struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
> -- 
> 2.25.1
> 
