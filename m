Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668464A5CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiBANCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbiBANCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:02:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE2C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 05:02:37 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i186so13340178pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQ75oOsrQQpZ/sBCi0Hueijj/QjsAuG7qkYPeQXVNlc=;
        b=p4rh8auqqhz7W98VDVqUil43a7r7Agb6SuFGqda1CkG1SPjjeGCiDemHlsztV4SaWa
         rpnILIqRmwQyG5Gnj6VP/HZMCNMCk2G1QwC9ymHjoy7Q5r/sV9gd7Xg/mGxJCCUL0t8D
         L4epWy632RtGq/YiPXwU5o7nTLdx8oUOoFnjlWUB9ucQsh11RwI4ne5dRNzHTm+vGBJz
         jBV/iCamC/sMPKX+zhIBnUtHhZrrt9ZSyoeNE1GU04dAVuiBm8myHQDXTmSqh4EEM/8u
         F43mHeD3li5yiRqj8fQgjDd/ttxGsP00INkDFrJtaBXLLne96n+Cqd4pMvMLNhJv6sf8
         HeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQ75oOsrQQpZ/sBCi0Hueijj/QjsAuG7qkYPeQXVNlc=;
        b=vmpUQ0cZwIVcNFTGpj38lmCVOF5RXEJDpqAOX+IO4iRmi873mAjdYYe1O4N/Ox4v+t
         Cysg3/qpPLZRFhtazcdcjvzTu2OByaesIUscuVgcMYq/Gbc5LVJ/tqemzvbRII5zu0/z
         ST5cMfWFuI+tBq404gnWiVHPqWXywTwkNOX/Nzi4mrzCSaifh8A37uat/x9zy6LeyP3E
         lGVUIpKlXTfPFpf8K81ifgcaDaJIJsjDIgWogwKgnnqp3zAOFazgtmpo2Hfd65bkpfCx
         bSa6hG4BcmjCTCMM3Ec2AH/ZPqMIHeDEfy2NKNLbptZiyiiW12sYHri/lgdRdjM9EW/a
         g/SQ==
X-Gm-Message-State: AOAM531oBNUqvSMcV7R4GkrTmg3P2gSs7KngLEP92KIOeyStLMKda/mS
        9Eh5K85+zkU1XXpSvjimliIJYA==
X-Google-Smtp-Source: ABdhPJwm4p2R5zXvzEwShX4rUJL5nm9Egsi5+XvFspYf0ETiYgHqIVOxFZIc2M0wYC4KJQDDJJ5Hjw==
X-Received: by 2002:a05:6a00:841:: with SMTP id q1mr3452865pfk.21.1643720556426;
        Tue, 01 Feb 2022 05:02:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.180.250])
        by smtp.gmail.com with ESMTPSA id lr7sm3301766pjb.42.2022.02.01.05.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 05:02:35 -0800 (PST)
Date:   Tue, 1 Feb 2022 21:02:28 +0800
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
Message-ID: <20220201130228.GA1939745@leoy-ThinkPad-X240s>
References: <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
 <Ya9J8HnMWxBy3MJv@arm.com>
 <20211207123118.GA255238@leoy-ThinkPad-X240s>
 <YbDrhQLeBdn0wqKT@arm.com>
 <20211210075918.GD622826@leoy-ThinkPad-X240s>
 <YeW56uyxJ42oEn8L@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeW56uyxJ42oEn8L@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Mon, Jan 17, 2022 at 06:48:10PM +0000, Catalin Marinas wrote:
> Hi Leo,
> 
> (sorry for the delay, holidays, merging window)

I am sorry too for the delay.  I read your email but have no sufficient
time to reply it in the past two weeks.

[...]

> > > I don't think your approach fully works. Let's say you are tracing two
> > > processes, one in the root PID namespace, the other not. Since the
> > > former enables PID in CONTEXTIDR, you automatically get some PID in
> > > CONTEXTIDR for the latter whether you requested it explicitly or not.
> > 
> > The key point is kernel always sets a PID number from the root PID
> > namespace into the system register CONTEXTIDR.
> 
> So earlier you mentioned that CONFIG_PID_IN_CONTEXTIDR=y is not always
> right since a profiled task may run in a non-root PID namespace. But
> this series introduces a single knob to turn on PID in CONTEXTIDR for
> all CPUs, irrespective of whether they run a task in the root PID
> namespace or not. The CPU running a task in the root ns may call
> contextidr_enable() but the other CPUs may run tasks in non-root ns.

Sorry I introduced confusion.  Let me to clarify:

CONTEXTIDR should be always used to trace root ns PIDs, this can give us
a consistent semantics.  Especially, when we record trace data with
system wide mode (e.g. use perf command with option "-a" for tracing all
CPUs), CONTEXTIDR always contains root ns PIDs for all tasks.

On the flip side when perf and profiled program run in non-root PID
namespace, it must not rely on CONTEXTIDR anymore for PID tracing.  In
some implementations (E.g. Arm SPE, x86 Intel-PT), perf tool can use
the software trace events to retrieve PID numbers, and heavily based on
the timestamp correlation between software trace events and hardware
trace events.

> IIUC, with this patch, to avoid the root ns PID for a non-root ns task,
> the SPE driver only sets the SYS_PMSCR_EL1_CX_SHIFT bit for the root ns
> tasks. So, in this case, for a non-root ns task, does it matter that
> CONTEXTIDR always contain the root ns PID? If it matters, see above why
> a single knob is already doing this.

You are right, even CONTEXTIDR always contains the root ns PID, we
still can control the bit SYS_PMSCR_EL1_CX_SHIFT in SPE driver:
when the profiled program runs in non-root ns, Arm SPE driver clears
SYS_PMSCR_EL1_CX_SHIFT bit; and if the profiled program runs in root
ns, ARM SPE driver sets SYS_PMSCR_EL1_CX_SHIFT bit alternatively.

  Diagram 1: Perf/profiled program run in root namespace
  +------------+    +---------+    +-----------------+
  | CONTEXTIDR | -> | Arm SPE | -> | Perf Trace Data |
  +------------+    +---------+    +-----------------+
                         ^                 ^
                         |                 ` Contains context packet
                         ` Set SYS_PMSCR_EL1_CX_SHIFT bit

  Diagram 2: Perf/profiled program run in non-root namespace
  +------------+    +---------+    +-----------------+
  | CONTEXTIDR | -> | Arm SPE | -> | Perf Trace Data |
  +------------+    +---------+    +-----------------+
                         ^                 ^
                         |                 ` Doesn't contain any context packet
                         ` Clear SYS_PMSCR_EL1_CX_SHIFT bit

As shown in diagram 2, when Arm SPE driver detects if the session runs
in non-root PID namespace, it clears SYS_PMSCR_EL1_CX_SHIFT bit.  As a
result, the SPE tracing data in perf file doesn't contain any context
packets, thus perf tool will rollback to use software events to retrieve
PID numbers and assign them to samples.

> > Let's see a case:
> > 
> >   # unshare --fork --pid perf record -e cs_etm// -m 64K,64K -a -o perf_test.data -- ./multi_threads_test
> > 
> > In this case, with command "unshare --fork --pid", perf tool and the
> > profiled program multi_threads_test run in the created PID namespace.
> > We can see the dumped PID values:
> > 
> >    <idle>-0       [000] d..2.   331.751681: __switch_to: contextidr_thread_switch: task perf-exec pid 840 ns_pid 2
> >    <idle>-0       [002] d..2.   331.755930: __switch_to: contextidr_thread_switch: task multi_threads_t pid 842 ns_pid 4
> >    <idle>-0       [003] d..2.   331.755993: __switch_to: contextidr_thread_switch: task multi_threads_t pid 843 ns_pid 5
> >   sugov:0-129     [005] d..2.   332.323469: __switch_to: contextidr_thread_switch: task perf pid 841 ns_pid 3
> > 
> > We can see processes have two different PIDs values, say task
> > 'perf-exec', 840 is its PID number from the root PID namespace, and 2
> > is its PID from the active namespace the task is belonging to.
> > 
> > But the register CONTEXTIDR is _only_ used to trace PIDs from the root
> > PID namespace and ignores PID values from any other PID namespace.
> 
> Would it help if we used task_pid_nr_ns() instead for setting
> CONTEXTIDR?

No, I don't think using task_pid_nr_ns() is a good idea for setting
CONTEXTIDR; this will introduce mess for the system wide mode in the
perf docoding phase.

E.g. for below perf command:

  # perf record -e arm_spe_0// -a -- sleep 1

In this case, perf tool gathers all processes info from the root
PID namespace via proc FS in the recording phase.

If we store task_pid_nr_ns() into CONTEXTIDR, it will lead to confusion
for perf tool, since the PID numbers come from different namespaces,
during the decoding phase perf tool will wrongly match PIDs (from
different PID namespace) with the recorded PIDs from root namespace.

> > Come back to your question, if there have two tracing sessions, one
> > session runs in the root PID namespace, and another runs in the
> > non-root PID namespace.  Since we can gather the PIDs in the root namespace,
> > the session in the root PID namespace can work perfectly, and we can
> > ensure the PID infos matching well between kernel's PID tracing and user
> > space tool (note: perf needs gather process info with process' pid/tid for
> > post parsing).
> > 
> > For the later session in non-root PID name space, we doesn't capture
> > any PID tracing data.  This results in the profiled result doesn't
> > contain any PID info, although it's painful that the PID info is
> > incomplete but we don't deliver any wrong info for users studying
> > profiling result and PID is always '-1'.
> 
> So what's actually disabling the capture of PID tracing data? Is it the
> PMSCR_EL1.CX bit being 0?

Yes.  I agree it does make sense to clear PMSCR_EL1.CX bit for session
in non-root ns.

Sorry before I didn't make clear for this.

> > I think the purpose for this patchset is to allow us to dynamically
> > enable PID tracing when the tracing session runs in root namespace.
> 
> But it doesn't do this with a single global knob for all CPUs. You only
> need the SPE patch together with the CONTEXTIDR config set to y.

Yeah.

> > Alternatively, if you accept to always set PID to CONTEXTIDR in
> > contextidr_thread_switch(), it would be fine for me and we can only
> > need to control PID packets in SPE and CoreSight drivers.
> 
> Well, we have the config option and infrastructure already, it's up to
> Linux distros to turn it on. It doesn't necessarily need to be in
> defconfig.
> 
> Now, if we removed the CONTEXTIDR setting altogether, is there a way for
> perf tools to coordinate the traces with the scheduling events? This
> would be a simpler approach from the kernel perspective (i.e. no work).

Indeed, we can correlate between software scheduling events and
hardware tracing events, which can be sorted with timestamps.  Arm SPE
has supported this mode, please refer to the patch [1] for understanding
the implementation in perf tool.

But using the software scheduling events might introduce inaccuracy
for the statistics, the reason is there have gap between scheduling
events and task context switching, so this is why we still want to
support context packets (by using CONTEXTIDR) for root PID namespace.
this can give us more accurate results.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/util/arm-spe.c?id=9dc9855f18ba25d2bc536ea5ba6682855e385d66

> Alternatively, could we move the CONTEXTIDR setting to a perf driver.
> I'm not too familiar with perf but I guess we could add some scheduling
> event hooks.

It would introduce trouble if we move the CONTEXTIDR setting to a perf
driver, I can think out two reasons:

- The first reason is we might have not only one perf driver to use
  CONTEXTIDR, e.g. Arm SPE and Arm CoreSight both need to use
  CONTEXTIDR for PID tracing.  This means we either need to set
  CONTEXTIDR in both drivers so we will introduce redundant codes.
- Furthermore, for the perf system wide mode, perf only enables
  hardware event when start the session and disables hardware event
  when stop the session.  In this mode, perf driver is not notified
  by any scheduling event during the session.

Seems to me, so far we need to come back to apply below change:

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e1a0c44bc686..a678562253dc 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -127,6 +127,7 @@ config XGENE_PMU
 config ARM_SPE_PMU
        tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
        depends on ARM64
+       select PID_IN_CONTEXTIDR
        help
          Enable perf support for the ARMv8.2 Statistical Profiling
          Extension, which provides periodic sampling of operations in

Thanks,
Leo
