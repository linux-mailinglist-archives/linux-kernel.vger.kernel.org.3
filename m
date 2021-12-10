Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3F46FC33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhLJIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:03:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D5C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 23:59:34 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r130so7808765pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNinaVrdsMrbiVJ2MkfipvbYHsm1uZYj0uiJQ7D0ATk=;
        b=QDNcJlRz3YpRjeGxYErhFrB7s/fNLorYReGM95wIZrJmNYd9T947ap6WFzTd40O9rg
         HhP3Rgt5NfSAYizAvx/XBv8yqurQb0Ku2rseT2PQBll20cWmxtBwz0+GBDkoGQ2+gN+8
         R2RtqVuFZPIRdTmohEeMkBSv1b/cSrpelkfcg5EkoYaHcKDnwaiH3NgOEaDQdP52hzyS
         15wD8qq9dVb4y+PAzFEjVIVZdzM3hCpg1haxj0+9VEeWKYw+aDPZ9aWj6uxqDpqb+rbr
         oHiiTA/ld4T2QynoWDxXugP0dOa154clHpcCFa8ZeHXu2c/qLg5o+KScsq+AbHZw8V81
         qyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNinaVrdsMrbiVJ2MkfipvbYHsm1uZYj0uiJQ7D0ATk=;
        b=um0aPxfSlVdV1BdN73wvGkl5cxl5Btpfzbh87WRhXX5wchvcAIECSDgA+wNYUnMNTP
         xtLDv9VBEsvp6RSlO8/2jMK5UomX3hOjV6P5NUI3UY7xrDBff62dytu3Asi0wcJWhktl
         n2TAMbV3Evm+oVwQ8oMrNnVcUmNU2PbAmqH7+yonuRv3tpPLJNYuNg3LT4mkfqbU2dRG
         M9kMYbdO/I34zVHFx6/cV86qHO6GgnqpJfYoLaCe9/Drk+Ru2Y/4d9CM1iXXIb9yvnHg
         lNSb6+zjhcZ3Kd+l8wj/QD+t1jIBEl8767YwDJXhvt79QINp4vahLqRqJ4FjkcHv4Mmr
         pD8g==
X-Gm-Message-State: AOAM530z5Zq3bzyemjeV2GiE/R0yVzEDqmuSQZzKAXHnrgZEttI7J9hz
        XG6/mjvZTr5q6Q9faDWhXdSdLg==
X-Google-Smtp-Source: ABdhPJzTRuAzhRlVZHzQelb62GNxonzKw2BuLckUJwO5xdBO1y3LLkGsAFkMKqH6OmjiHlMZDOZ4LA==
X-Received: by 2002:a62:b418:0:b0:4a0:3696:dec0 with SMTP id h24-20020a62b418000000b004a03696dec0mr16470789pfn.73.1639123174024;
        Thu, 09 Dec 2021 23:59:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s (216.24.179.124.16clouds.com. [216.24.179.124])
        by smtp.gmail.com with ESMTPSA id r6sm1831332pjg.21.2021.12.09.23.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:59:33 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:59:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <20211210075918.GD622826@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
 <Ya9J8HnMWxBy3MJv@arm.com>
 <20211207123118.GA255238@leoy-ThinkPad-X240s>
 <YbDrhQLeBdn0wqKT@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbDrhQLeBdn0wqKT@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:29:41PM +0000, Catalin Marinas wrote:
> On Tue, Dec 07, 2021 at 08:31:18PM +0800, Leo Yan wrote:
> > On Tue, Dec 07, 2021 at 11:48:00AM +0000, Catalin Marinas wrote:
> > > On Sun, Dec 05, 2021 at 09:51:03PM +0800, Leo Yan wrote:
> > > > On Fri, Dec 03, 2021 at 04:22:42PM +0000, Catalin Marinas wrote:
> > > > > What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
> > > > > negligible, I'd not bother at all with any of the enabling/disabling.
> > > > 
> > > > Yes, I compared performance for PID tracing with always enabling and
> > > > disabling CONFIG_PID_IN_CONTEXTIDR, and also compared with using
> > > > static key for enabling/disabling PID tracing.  The result shows the
> > > > cost is negligible based on the benchmark 'perf bench sched'.
> > > > 
> > > > Please see the detailed data in below link (note the testing results
> > > > came from my Juno board):
> > > > https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/
> > > 
> > > The table wasn't entirely clear to me. So the dis/enb benchmarks are
> > > without this patchset applied.
> > 
> > Yes, dis/enb metrics don't apply this patchset.
> > 
> > > There seems to be a minor drop but it's
> > > probably noise. Anyway, do we need this patchset or we just make
> > > CONFIG_PID_IN_CONTEXTIDR default to y?
> > 
> > Good point.  I remembered before we had discussed for making
> > CONFIG_PID_IN_CONTEXTIDR to 'y', but this approach is not always valid,
> > especially when the profiling process runs in non-root PID namespace,
> > in this case, hardware tracing data (e.g. Arm SPE or CoreSight) cannot
> > trust the PID values from tracing since the PID conflicts between
> > different PID namespaces.
> > 
> > So this patchset is to add the fundamental mechanism for dynamically
> > enabling and disable PID tracing into CONTEXTIDR.  Based on it, we can
> > use helpers to dynamically enable PID tracing _only_ when process runs
> > in root PID namespace.
> 
> I don't think your approach fully works. Let's say you are tracing two
> processes, one in the root PID namespace, the other not. Since the
> former enables PID in CONTEXTIDR, you automatically get some PID in
> CONTEXTIDR for the latter whether you requested it explicitly or not.

The key point is kernel always sets a PID number from the root PID
namespace into the system register CONTEXTIDR.

Let's see a case:

  # unshare --fork --pid perf record -e cs_etm// -m 64K,64K -a -o perf_test.data -- ./multi_threads_test

In this case, with command "unshare --fork --pid", perf tool and the
profiled program multi_threads_test run in the created PID namespace.
We can see the dumped PID values:

   <idle>-0       [000] d..2.   331.751681: __switch_to: contextidr_thread_switch: task perf-exec pid 840 ns_pid 2
   <idle>-0       [002] d..2.   331.755930: __switch_to: contextidr_thread_switch: task multi_threads_t pid 842 ns_pid 4
   <idle>-0       [003] d..2.   331.755993: __switch_to: contextidr_thread_switch: task multi_threads_t pid 843 ns_pid 5
  sugov:0-129     [005] d..2.   332.323469: __switch_to: contextidr_thread_switch: task perf pid 841 ns_pid 3

We can see processes have two different PIDs values, say task
'perf-exec', 840 is its PID number from the root PID namespace, and 2
is its PID from the active namespace the task is belonging to.

But the register CONTEXTIDR is _only_ used to trace PIDs from the root
PID namespace and ignores PID values from any other PID namespace.

Come back to your question, if there have two tracing sessions, one
session runs in the root PID namespace, and another runs in the
non-root PID namespace.  Since we can gather the PIDs in the root namespace,
the session in the root PID namespace can work perfectly, and we can
ensure the PID infos matching well between kernel's PID tracing and user
space tool (note: perf needs gather process info with process' pid/tid for
post parsing).

For the later session in non-root PID name space, we doesn't capture
any PID tracing data.  This results in the profiled result doesn't
contain any PID info, although it's painful that the PID info is
incomplete but we don't deliver any wrong info for users studying
profiling result and PID is always '-1'.

I think the purpose for this patchset is to allow us to dynamically
enable PID tracing when the tracing session runs in root namespace.

Furthermore, please see the patch [1], you could see we also need an
extra checking in SPE driver for setting SPE's control register to
disable PID packets so can avoid PID polutions if the session runs in
non-root PID namespace:

  // Only enable PID packets when run in root namespace
  if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
 		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);

[1] https://lore.kernel.org/lkml/20211021134530.206216-5-leo.yan@linaro.org/

> I wonder whether it makes more sense to turn this on per thread. You set
> some TIF flag and set the PID in contextidr_thread_switch() only if the
> flag is set.

Good point.  IIRC, before Suzuki brought up this suggestion as well.

I considered it and these two days I looked into the perf code, it's feasible
to apply the TIF flag for perf's 'per-thread' mode or process mode.  In these
modes, we can set the thread flags when profiled task/thread is forked.
But the difficult thing is how we can handle for CPU wide profiling.

In CPU wide mode, the perf tool opens the tracing events on several
or all CPUs, the running tasks running on the CPU are not forked
from perf session, in the below diagram, there have three tasks (T1/2/3),
we can see tasks T2/T3 even were created before perf tool is
lanched; in this case, it's hard for perf tool to set TIF flag for all
tasks in the system, and it's possible to see the tasks migrate from
one CPU to another CPU.

            Perf enables event                  Perf disables event
               on the CPU                          on the CPU
                  |                                   |
         ##T2##   V    ###T1###  ##T3##  ####T2#####  V
  CPU0  ------------------------------------------------->
                  |                                   |
            #T3#  V    #######T2######                V
  CPU1  ------------------------------------------------->

                                        ##T1##
  CPU2  ------------------------------------------------->
              ^
              ` The event is not enabled on CPU2 so CPU2 doesn't
                capture any trace data.

> You could also check there if the PID is in the root
> namespace and avoid setting CONTEXTIDR (or write 0).

This could introduce mess.  Writing 0 can lead the decoder to take it
as idle thread; if skip setting CONTEXTIDR, the tracer might use a
stale stale PID number (the previous one ID number).

Alternatively, if you accept to always set PID to CONTEXTIDR in
contextidr_thread_switch(), it would be fine for me and we can only
need to control PID packets in SPE and CoreSight drivers.

Please let me know your opinion, thanks!

Leo
