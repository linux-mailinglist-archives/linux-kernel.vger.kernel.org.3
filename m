Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCB491073
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbiAQSsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:48:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44798 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAQSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:48:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AD13B81151
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673BEC36AE3;
        Mon, 17 Jan 2022 18:48:13 +0000 (UTC)
Date:   Mon, 17 Jan 2022 18:48:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <YeW56uyxJ42oEn8L@arm.com>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
 <Ya9J8HnMWxBy3MJv@arm.com>
 <20211207123118.GA255238@leoy-ThinkPad-X240s>
 <YbDrhQLeBdn0wqKT@arm.com>
 <20211210075918.GD622826@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210075918.GD622826@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

(sorry for the delay, holidays, merging window)

On Fri, Dec 10, 2021 at 03:59:18PM +0800, Leo Yan wrote:
> On Wed, Dec 08, 2021 at 05:29:41PM +0000, Catalin Marinas wrote:
> > On Tue, Dec 07, 2021 at 08:31:18PM +0800, Leo Yan wrote:
> > > On Tue, Dec 07, 2021 at 11:48:00AM +0000, Catalin Marinas wrote:
> > > > On Sun, Dec 05, 2021 at 09:51:03PM +0800, Leo Yan wrote:
> > > > > On Fri, Dec 03, 2021 at 04:22:42PM +0000, Catalin Marinas wrote:
> > > > > > What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
> > > > > > negligible, I'd not bother at all with any of the enabling/disabling.
> > > > > 
> > > > > Yes, I compared performance for PID tracing with always enabling and
> > > > > disabling CONFIG_PID_IN_CONTEXTIDR, and also compared with using
> > > > > static key for enabling/disabling PID tracing.  The result shows the
> > > > > cost is negligible based on the benchmark 'perf bench sched'.
> > > > > 
> > > > > Please see the detailed data in below link (note the testing results
> > > > > came from my Juno board):
> > > > > https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/
> > > > 
> > > > The table wasn't entirely clear to me. So the dis/enb benchmarks are
> > > > without this patchset applied.
> > > 
> > > Yes, dis/enb metrics don't apply this patchset.
> > > 
> > > > There seems to be a minor drop but it's
> > > > probably noise. Anyway, do we need this patchset or we just make
> > > > CONFIG_PID_IN_CONTEXTIDR default to y?
> > > 
> > > Good point.  I remembered before we had discussed for making
> > > CONFIG_PID_IN_CONTEXTIDR to 'y', but this approach is not always valid,
> > > especially when the profiling process runs in non-root PID namespace,
> > > in this case, hardware tracing data (e.g. Arm SPE or CoreSight) cannot
> > > trust the PID values from tracing since the PID conflicts between
> > > different PID namespaces.
> > > 
> > > So this patchset is to add the fundamental mechanism for dynamically
> > > enabling and disable PID tracing into CONTEXTIDR.  Based on it, we can
> > > use helpers to dynamically enable PID tracing _only_ when process runs
> > > in root PID namespace.
> > 
> > I don't think your approach fully works. Let's say you are tracing two
> > processes, one in the root PID namespace, the other not. Since the
> > former enables PID in CONTEXTIDR, you automatically get some PID in
> > CONTEXTIDR for the latter whether you requested it explicitly or not.
> 
> The key point is kernel always sets a PID number from the root PID
> namespace into the system register CONTEXTIDR.

So earlier you mentioned that CONFIG_PID_IN_CONTEXTIDR=y is not always
right since a profiled task may run in a non-root PID namespace. But
this series introduces a single knob to turn on PID in CONTEXTIDR for
all CPUs, irrespective of whether they run a task in the root PID
namespace or not. The CPU running a task in the root ns may call
contextidr_enable() but the other CPUs may run tasks in non-root ns.

IIUC, with this patch, to avoid the root ns PID for a non-root ns task,
the SPE driver only sets the SYS_PMSCR_EL1_CX_SHIFT bit for the root ns
tasks. So, in this case, for a non-root ns task, does it matter that
CONTEXTIDR always contain the root ns PID? If it matters, see above why
a single knob is already doing this.

> Let's see a case:
> 
>   # unshare --fork --pid perf record -e cs_etm// -m 64K,64K -a -o perf_test.data -- ./multi_threads_test
> 
> In this case, with command "unshare --fork --pid", perf tool and the
> profiled program multi_threads_test run in the created PID namespace.
> We can see the dumped PID values:
> 
>    <idle>-0       [000] d..2.   331.751681: __switch_to: contextidr_thread_switch: task perf-exec pid 840 ns_pid 2
>    <idle>-0       [002] d..2.   331.755930: __switch_to: contextidr_thread_switch: task multi_threads_t pid 842 ns_pid 4
>    <idle>-0       [003] d..2.   331.755993: __switch_to: contextidr_thread_switch: task multi_threads_t pid 843 ns_pid 5
>   sugov:0-129     [005] d..2.   332.323469: __switch_to: contextidr_thread_switch: task perf pid 841 ns_pid 3
> 
> We can see processes have two different PIDs values, say task
> 'perf-exec', 840 is its PID number from the root PID namespace, and 2
> is its PID from the active namespace the task is belonging to.
> 
> But the register CONTEXTIDR is _only_ used to trace PIDs from the root
> PID namespace and ignores PID values from any other PID namespace.

Would it help if we used task_pid_nr_ns() instead for setting
CONTEXTIDR?

> Come back to your question, if there have two tracing sessions, one
> session runs in the root PID namespace, and another runs in the
> non-root PID namespace.  Since we can gather the PIDs in the root namespace,
> the session in the root PID namespace can work perfectly, and we can
> ensure the PID infos matching well between kernel's PID tracing and user
> space tool (note: perf needs gather process info with process' pid/tid for
> post parsing).
> 
> For the later session in non-root PID name space, we doesn't capture
> any PID tracing data.  This results in the profiled result doesn't
> contain any PID info, although it's painful that the PID info is
> incomplete but we don't deliver any wrong info for users studying
> profiling result and PID is always '-1'.

So what's actually disabling the capture of PID tracing data? Is it the
PMSCR_EL1.CX bit being 0?

> I think the purpose for this patchset is to allow us to dynamically
> enable PID tracing when the tracing session runs in root namespace.

But it doesn't do this with a single global knob for all CPUs. You only
need the SPE patch together with the CONTEXTIDR config set to y.

> Alternatively, if you accept to always set PID to CONTEXTIDR in
> contextidr_thread_switch(), it would be fine for me and we can only
> need to control PID packets in SPE and CoreSight drivers.

Well, we have the config option and infrastructure already, it's up to
Linux distros to turn it on. It doesn't necessarily need to be in
defconfig.

Now, if we removed the CONTEXTIDR setting altogether, is there a way for
perf tools to coordinate the traces with the scheduling events? This
would be a simpler approach from the kernel perspective (i.e. no work).
Alternatively, could we move the CONTEXTIDR setting to a perf driver.
I'm not too familiar with perf but I guess we could add some scheduling
event hooks.

-- 
Catalin
