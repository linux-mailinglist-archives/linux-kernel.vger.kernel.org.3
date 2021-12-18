Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1930F479A98
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhLRLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhLRLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:35:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB79C061574;
        Sat, 18 Dec 2021 03:35:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B721660A3A;
        Sat, 18 Dec 2021 11:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B982AC36AE5;
        Sat, 18 Dec 2021 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639827309;
        bh=04pLrZFuqCkSrnuUu0DYS0PBuxWp5YCZIGjnTuEqInU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTpOi9HQx42hFEtJp9seBAkBDfNJedd7fjzn5h6c5cxPt8HFPnToDm+kAoXj3lzzv
         k2Q6ESN2kSVHVB53FEPEBnCh7GXyrPKF74W3PHDdy4x+SAu9efZrrq6xinhwvYCPDp
         CskYXYpVHjdOmRVXUVNeRAK6nzTooGWgCO2yPFQDOUYJNqJLbzH4+YbKDSYSrYXJXd
         LKb2/rJIgvQ+KTZ2rLfozJ9xB+Vm+KsNnvhRJp7X6AFBg/+EIFJLnNoORW1AJTnkiL
         WjEU/xeLzAASlpUoBhJq5230mm4NoX2r+usIG4Cb+++wy6CTeQ0hq5IO9Isst9ciuP
         8FYs1YEkCLMaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E701C40B92; Sat, 18 Dec 2021 08:35:05 -0300 (-03)
Date:   Sat, 18 Dec 2021 08:35:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/6] perf arm64: inject missing frames if perf-record
 used "--call-graph=fp"
Message-ID: <Yb3HaQrm1RuI52/j@kernel.org>
References: <20211217154521.80603-1-german.gomez@arm.com>
 <20211217154521.80603-7-german.gomez@arm.com>
 <207eade3-6719-f028-22a1-d050c10288e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207eade3-6719-f028-22a1-d050c10288e0@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 17, 2021 at 04:01:38PM +0000, James Clark escreveu:
> 
> 
> On 17/12/2021 15:45, German Gomez wrote:
> > From: Alexandre Truong <alexandre.truong@arm.com>
> > 
> > When unwinding using frame pointers on ARM64, the return address of the
> > current function may not have been pushed into the stack when a function
> > was interrupted, which makes perf show an incorrect call graph to the
> > user.
> > 
> > Consider the following example program:
> > 
> >   void leaf() {
> >       /* long computation */
> >   }
> > 
> >   void parent() {
> >       // (1)
> >       leaf();
> >       // (2)
> >   }
> > 
> >   ... could be compiled into (using gcc -fno-inline -fno-omit-frame-pointer):
> > 
> >   leaf:
> >       /* long computation */
> >       nop
> >       ret
> >   parent:
> >       // (1)
> >       stp     x29, x30, [sp, -16]!
> >       mov     x29, sp
> >       bl      parent
> >       nop
> >       ldp     x29, x30, [sp], 16
> >       // (2)
> >       ret
> > 
> > If the program is interrupted at (1), (2), or any point in "leaf:", the
> > call graph will skip the callers of the current function. We can unwind
> > using the dwarf info and check if the return addr is the same as the LR
> > register, and inject the missing frame into the call graph.
> > 
> > Before this patch, the above example shows the following call-graph when
> > recording using "--call-graph fp" mode in ARM64:
> > 
> >   # Children      Self  Command   Shared Object     Symbol
> >   # ........  ........  ........  ................  ......................
> >   #
> >       99.86%    99.86%  program3  program3          [.] leaf
> >   	    |
> >   	    ---_start
> >   	       __libc_start_main
> >   	       main
> >   	       leaf
> > 
> > As can be seen, the "parent" function is missing. This is specially
> > problematic in "leaf" because for leaf functions the compiler may always
> > omit pushing the return addr into the stack. After this patch, it shows
> > the correct graph:
> > 
> >   # Children      Self  Command   Shared Object     Symbol
> >   # ........  ........  ........  ................  ......................
> >   #
> >       99.86%    99.86%  program3  program3          [.] leaf
> >   	    |
> >   	    ---_start
> >   	       __libc_start_main
> >   	       main
> >   	       parent
> >   	       leaf
> > 
> > Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> > ---
> >  tools/perf/util/Build                         |  1 +
> >  .../util/arm64-frame-pointer-unwind-support.c | 63 +++++++++++++++++++
> >  .../util/arm64-frame-pointer-unwind-support.h | 10 +++
> >  tools/perf/util/machine.c                     | 19 ++++--
> >  tools/perf/util/machine.h                     |  1 +
> >  5 files changed, 89 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.c
> >  create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.h
> > 
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 2e5bfbb69960..03d4c647bd86 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -1,3 +1,4 @@
> > +perf-y += arm64-frame-pointer-unwind-support.o
> >  perf-y += annotate.o
> >  perf-y += block-info.o
> >  perf-y += block-range.o
> > diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> > new file mode 100644
> > index 000000000000..4f5ecf51ed38
> > --- /dev/null
> > +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "arm64-frame-pointer-unwind-support.h"
> > +#include "callchain.h"
> > +#include "event.h"
> > +#include "perf_regs.h" // SMPL_REG_MASK
> > +#include "unwind.h"
> > +
> > +#define perf_event_arm_regs perf_event_arm64_regs
> > +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> > +#undef perf_event_arm_regs
> > +
> > +struct entries {
> > +	u64 stack[2];
> > +	size_t length;
> > +};
> > +
> > +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
> > +{
> > +	return callchain_param.record_mode == CALLCHAIN_FP && sample->user_regs.regs
> > +		&& sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_LR);
> > +}
> > +
> > +static int add_entry(struct unwind_entry *entry, void *arg)
> > +{
> > +	struct entries *entries = arg;
> > +
> > +	entries->stack[entries->length++] = entry->ip;
> > +	return 0;
> > +}
> > +
> > +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int usr_idx)
> > +{
> > +	int ret;
> > +	struct entries entries = {};
> > +	struct regs_dump old_regs = sample->user_regs;
> > +
> > +	if (!get_leaf_frame_caller_enabled(sample))
> > +		return 0;
> > +
> > +	/*
> > +	 * If PC and SP are not recorded, get the value of PC from the stack
> > +	 * and set its mask. SP is not used when doing the unwinding but it
> > +	 * still needs to be set to prevent failures.
> > +	 */
> > +
> > +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_PC))) {
> > +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_PC);
> > +		sample->user_regs.cache_regs[PERF_REG_ARM64_PC] = sample->callchain->ips[usr_idx+1];
> > +	}
> > +
> > +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_SP))) {
> > +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_SP);
> > +		sample->user_regs.cache_regs[PERF_REG_ARM64_SP] = 0;
> > +	}
> > +
> > +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
> > +	sample->user_regs = old_regs;
> > +
> > +	if (ret || entries.length != 2)
> > +		return ret;
> > +
> > +	return callchain_param.order == ORDER_CALLER ? entries.stack[0] : entries.stack[1];
> > +}
> > diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> > new file mode 100644
> > index 000000000000..32af9ce94398
> > --- /dev/null
> > +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> > +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> > +
> > +#include "event.h"
> > +#include "thread.h"
> > +
> > +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int user_idx);
> > +
> > +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3eddad009f78..a00fd6796b35 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -34,6 +34,7 @@
> >  #include "bpf-event.h"
> >  #include <internal/lib.h> // page_size
> >  #include "cgroup.h"
> > +#include "arm64-frame-pointer-unwind-support.h"
> >  
> >  #include <linux/ctype.h>
> >  #include <symbol/kallsyms.h>
> > @@ -2710,10 +2711,13 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
> >  	return err;
> >  }
> >  
> > -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
> > -		struct thread *thread __maybe_unused, int usr_idx __maybe_unused)
> > +static u64 get_leaf_frame_caller(struct perf_sample *sample,
> > +		struct thread *thread, int usr_idx)
> >  {
> > -	return 0;
> > +	if (machine__normalize_is(thread->maps->machine, "arm64"))
> > +		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
> > +	else
> > +		return 0;
> >  }
> >  
> >  static int thread__resolve_callchain_sample(struct thread *thread,
> > @@ -3114,14 +3118,19 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
> >  }
> >  
> >  /*
> > - * Compares the raw arch string. N.B. see instead perf_env__arch() if a
> > - * normalized arch is needed.
> > + * Compares the raw arch string. N.B. see instead perf_env__arch() or
> > + * machine__normalize_is() if a normalized arch is needed.
> >   */
> >  bool machine__is(struct machine *machine, const char *arch)
> >  {
> >  	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
> >  }
> >  
> > +bool machine__normalize_is(struct machine *machine, const char *arch)
> > +{
> > +	return machine && !strcmp(perf_env__arch(machine->env), arch);
> > +}
> > +
> 
> I think this function name would be clearer as something like "machine__normalized_is" or
> "machine__normalized_arch_is". The tense is slightly off because it's a test rather than a
> verb.

Agreed, its a question, not a command.

- Arnaldo
 
> With that change, for the whole set:
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> 
> 
> >  int machine__nr_cpus_avail(struct machine *machine)
> >  {
> >  	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
> > diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> > index a143087eeb47..665535153411 100644
> > --- a/tools/perf/util/machine.h
> > +++ b/tools/perf/util/machine.h
> > @@ -208,6 +208,7 @@ static inline bool machine__is_host(struct machine *machine)
> >  }
> >  
> >  bool machine__is(struct machine *machine, const char *arch);
> > +bool machine__normalize_is(struct machine *machine, const char *arch);
> >  int machine__nr_cpus_avail(struct machine *machine);
> >  
> >  struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
> > 

-- 

- Arnaldo
