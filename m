Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9873B47C1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhLUO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:56:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43766 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbhLUO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:56:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167CE61636;
        Tue, 21 Dec 2021 14:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15313C36AE8;
        Tue, 21 Dec 2021 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098597;
        bh=22qvJ7y7GPyhJpPRwy+UIXlOuZLVydB9WksWqVLwcY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/cbHiIk+u3f68V+Mvs866QkNeNXjJ/Ktgo5cPMO6CrAccoTM1Qf/Ch4/+T+iHmoJ
         k3Lsp+ekFrGoXYuWKQawy52GdnexukARCvdqpbSAAkUNwD8viSPWuIAiW7AqrcCrVE
         rr5eFl6vGmMBd53oWX6N1wfciv9sihJuJFyBkzCkE+5UaRplsJ3XkiFvjuRlZscVmv
         wjk2kQ+UmaQZVT9QkHgyzF1kvk3lRHEzbcDYwC4NiQhksOx0XmeHTO7tDG7gx3SlVQ
         a102b9+X9f4cO7/ryNqgXr+lBT/nDaT+YS0vhF2BlGb5uQhD2JovgKAKN6BnP7X1JQ
         hUvobDeo/u3iA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB4CF40B92; Tue, 21 Dec 2021 11:17:03 -0300 (-03)
Date:   Tue, 21 Dec 2021 11:17:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/6] perf arm64: inject missing frames if perf-record
 used "--call-graph=fp"
Message-ID: <YcHh37Iw2GXBkXm9@kernel.org>
References: <20211217154521.80603-1-german.gomez@arm.com>
 <20211217154521.80603-7-german.gomez@arm.com>
 <YcGfQr43ChIgtacC@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGfQr43ChIgtacC@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 21, 2021 at 10:32:50AM +0100, Jiri Olsa escreveu:
> On Fri, Dec 17, 2021 at 03:45:20PM +0000, German Gomez wrote:
> 
> SNIP
> 
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
> 
> just curious, did you try this with both unwinders libunwind/libdw?
> 
> any chance you could add arm specific test for this?
> 
> otherwise it looks good to me

Whole patchkit?
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> 
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
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
