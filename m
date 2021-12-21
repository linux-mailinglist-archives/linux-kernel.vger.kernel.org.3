Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AC47C238
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhLUPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235692AbhLUPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640099178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2/5378vJkI/nGE10wiVmv6nrnuShHw+Qz8qvJTGnTc=;
        b=SFN2uXranBkf3/hI4NhGITupua/ZMj12QZSW9+Pp+QIThbPCSTGjQ01stntEBZqFfx0kaI
        vm3UiG/mzsrNItONVd4CPJbVl3sn6jZEk7HO/uCWHBSP1Ve5+tIN5eBQLHTMYplNjX0Vj8
        c+vSBN1Ta9hX1/wFsAD6DbAzAamEpUc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-a7lSF4VCPy6iHlQdDaMhLw-1; Tue, 21 Dec 2021 10:06:17 -0500
X-MC-Unique: a7lSF4VCPy6iHlQdDaMhLw-1
Received: by mail-wm1-f69.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so2885054wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2/5378vJkI/nGE10wiVmv6nrnuShHw+Qz8qvJTGnTc=;
        b=G89ccM3ONxEZcPelfPlXZ1rbO19mmUQdE6ha/XpOTExhkqriRRS0RKamuoHIRK2I2P
         FyhFri6X9cDGTjPBsnsUDARw8df2/+OsolB/7osTgK+VizMZS5zyTJLg7bcQz13AVSHO
         SHzgzoLJaCZeNmNnoRE8cj7xHAzBp71cJcX/IMIfT8X8Ji0HpDgI81vx9x5Y7UzZSKbj
         EHhO1WbCphum8HkF8pZosGcdWe1JNlfEI4XQ+cfjvZd5bWq4rkiYkDa//PTraFZHob00
         QIKnWPYvQjUANxzMM2uORbxvzZA43DUhK/SS0AkO40t38RXY9J1RHnNjCRjR6onhSaRK
         MXUg==
X-Gm-Message-State: AOAM532e44WVs5GdtdUZ2dgUWQRLQ4RzVkhJbPqTr75LLNJCs41sGGJ2
        zLT+XAfO78bVVVTRfc2KUxLpBrLUJM6tYO1EK7auhhWJ2KojRoofb32GGyH/UQduAP+R/grP2JF
        NqrmkCSUT+XPR2frG547G4wcS
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr1089340wrz.261.1640099175698;
        Tue, 21 Dec 2021 07:06:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW2v8WERWGu+sSoYYkZhnbIfrNmbd8S4tpusx4TGNi3J5MHxBIJP6WocZBQnVYe+8cpWVYDg==
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr1089322wrz.261.1640099175468;
        Tue, 21 Dec 2021 07:06:15 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id w8sm18992648wre.106.2021.12.21.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:06:15 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:06:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <YcHtZbTQ7B64Py+7@krava>
References: <20211217154521.80603-1-german.gomez@arm.com>
 <20211217154521.80603-7-german.gomez@arm.com>
 <YcGfQr43ChIgtacC@krava>
 <YcHh37Iw2GXBkXm9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcHh37Iw2GXBkXm9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:17:03AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 21, 2021 at 10:32:50AM +0100, Jiri Olsa escreveu:
> > On Fri, Dec 17, 2021 at 03:45:20PM +0000, German Gomez wrote:
> > 
> > SNIP
> > 
> > > +}
> > > +
> > > +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int usr_idx)
> > > +{
> > > +	int ret;
> > > +	struct entries entries = {};
> > > +	struct regs_dump old_regs = sample->user_regs;
> > > +
> > > +	if (!get_leaf_frame_caller_enabled(sample))
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * If PC and SP are not recorded, get the value of PC from the stack
> > > +	 * and set its mask. SP is not used when doing the unwinding but it
> > > +	 * still needs to be set to prevent failures.
> > > +	 */
> > > +
> > > +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_PC))) {
> > > +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_PC);
> > > +		sample->user_regs.cache_regs[PERF_REG_ARM64_PC] = sample->callchain->ips[usr_idx+1];
> > > +	}
> > > +
> > > +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_SP))) {
> > > +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_SP);
> > > +		sample->user_regs.cache_regs[PERF_REG_ARM64_SP] = 0;
> > > +	}
> > > +
> > > +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
> > 
> > just curious, did you try this with both unwinders libunwind/libdw?
> > 
> > any chance you could add arm specific test for this?
> > 
> > otherwise it looks good to me
> 
> Whole patchkit?

yes, it's for the patchset

jirka

>  
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > thanks,
> > jirka
> > 
> > 
> > > +	sample->user_regs = old_regs;
> > > +
> > > +	if (ret || entries.length != 2)
> > > +		return ret;
> > > +
> > > +	return callchain_param.order == ORDER_CALLER ? entries.stack[0] : entries.stack[1];
> > > +}
> > > diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> > > new file mode 100644
> > > index 000000000000..32af9ce94398
> > > --- /dev/null
> > > +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> > > @@ -0,0 +1,10 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> > > +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> > > +
> > > +#include "event.h"
> > > +#include "thread.h"
> > > +
> > > +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int user_idx);
> > > +
> > > +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 3eddad009f78..a00fd6796b35 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -34,6 +34,7 @@
> > >  #include "bpf-event.h"
> > >  #include <internal/lib.h> // page_size
> > >  #include "cgroup.h"
> > > +#include "arm64-frame-pointer-unwind-support.h"
> > >  
> > >  #include <linux/ctype.h>
> > >  #include <symbol/kallsyms.h>
> > > @@ -2710,10 +2711,13 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
> > >  	return err;
> > >  }
> > >  
> > > -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
> > > -		struct thread *thread __maybe_unused, int usr_idx __maybe_unused)
> > > +static u64 get_leaf_frame_caller(struct perf_sample *sample,
> > > +		struct thread *thread, int usr_idx)
> > >  {
> > > -	return 0;
> > > +	if (machine__normalize_is(thread->maps->machine, "arm64"))
> > > +		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
> > > +	else
> > > +		return 0;
> > >  }
> > >  
> > >  static int thread__resolve_callchain_sample(struct thread *thread,
> > > @@ -3114,14 +3118,19 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
> > >  }
> > >  
> > >  /*
> > > - * Compares the raw arch string. N.B. see instead perf_env__arch() if a
> > > - * normalized arch is needed.
> > > + * Compares the raw arch string. N.B. see instead perf_env__arch() or
> > > + * machine__normalize_is() if a normalized arch is needed.
> > >   */
> > >  bool machine__is(struct machine *machine, const char *arch)
> > >  {
> > >  	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
> > >  }
> > >  
> > > +bool machine__normalize_is(struct machine *machine, const char *arch)
> > > +{
> > > +	return machine && !strcmp(perf_env__arch(machine->env), arch);
> > > +}
> > > +
> > >  int machine__nr_cpus_avail(struct machine *machine)
> > >  {
> > >  	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
> > > diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> > > index a143087eeb47..665535153411 100644
> > > --- a/tools/perf/util/machine.h
> > > +++ b/tools/perf/util/machine.h
> > > @@ -208,6 +208,7 @@ static inline bool machine__is_host(struct machine *machine)
> > >  }
> > >  
> > >  bool machine__is(struct machine *machine, const char *arch);
> > > +bool machine__normalize_is(struct machine *machine, const char *arch);
> > >  int machine__nr_cpus_avail(struct machine *machine);
> > >  
> > >  struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> 
> - Arnaldo
> 

