Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA49953176B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiEWTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiEWTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:38:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEB13FD71
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:27:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q21so10717481ejm.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnEqzAa5MrDPpGUe/M7x5bqylpvm6YOMOApXfWi/olA=;
        b=LspSdIob/xrLDiCBpxSjz/Y59V/lAAqiMZOrGMMiK/6nnM5+tKgV1q0Q0F2U7Q6dWC
         vxmYhLmeSDWDxiDlQXus6oQw8tmOHHra7YEM4RTQjij2v3QhUlcLc5aJT1mGSlaHI4y2
         T17UZPlwx6RTrJm/IchLaHMdiq1oEZ/cIUXj2bE6v4o7QYqYy3V+2eFTTHFncTEyvYha
         RQfLovmsdJIJSHhQlYxt8LeeUmzB1wE4sWopPEB8+Er32BrpRP1a1vdyNWtDy9tmJ4QI
         F2b+gGwaLmnw1Q4YDcvtuFz4O3Cg61O/1NysaGaOM9KvccYp0gm9GMDbhbv8K6GYSFBn
         RHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnEqzAa5MrDPpGUe/M7x5bqylpvm6YOMOApXfWi/olA=;
        b=OipGUQ/v+xVZtSjY7/7JqqcSn/ERlgV5RpVcnlgj6KOBXw2RuyNPQVRIoyhFSIDuX6
         sS/kYv/43xA6OPp2NmYkR5q40/TbZDQH9ZafIfnyk3Jhho0L9VEMHkr2MzGe6/PzIGxd
         RHV87+efsYIOx18FOYfgF0mv9flt0qEyl0FexdD3SjzWGchjLbjYtgVq0ovjFFHdRTbd
         NYweWn/kDMByz/zlSHNpQyDdj1oxyQM33ufK2kySO4tntU2s4jNdXvEcDlSnEr8lKOfU
         SCgmzGJDno7EiVvUo2N4Kx7PUc9g5X1i2iclvRqj8eF2f7r8TE9DLYYViO8ewc1Jxk23
         D8DQ==
X-Gm-Message-State: AOAM530smywIhvXvgtENoOng+XX5UXK2ixg1ydhdgXvv+MOah/QBjGdD
        nNEB7H/vjkcb7laHkwhfL39IBL2dqo5DWJw+FT42+g==
X-Google-Smtp-Source: ABdhPJzWsndwJPfbya9692gt8RuMi6gpQqWby0N9ksrdA6UQytaoA2DFtqAh87nZuCrMlro7sjHMvldwZaWnFhCNvEY=
X-Received: by 2002:a17:907:2998:b0:6fe:a132:5e72 with SMTP id
 eu24-20020a170907299800b006fea1325e72mr17365236ejc.320.1653334055603; Mon, 23
 May 2022 12:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045ApiMSvP--f2E0=VdMbjE8oibvy921m8JASf4kaCCuU2RA@mail.gmail.com>
 <87ilpxmvg3.wl-maz@kernel.org>
In-Reply-To: <87ilpxmvg3.wl-maz@kernel.org>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 23 May 2022 12:27:24 -0700
Message-ID: <CAP045AroJ3vd8yn+_+F8ANnaUjFL41juQw9Uc9GUSGaKsd_TYA@mail.gmail.com>
Subject: Re: arm64 equivalents of PR_SET_TSC/ARCH_SET_CPUID
To:     Marc Zyngier <maz@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yyc1992@gmail.com, Keno Fischer <keno@juliacomputing.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 8:35 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 21 May 2022 21:07:14 +0100,
> Kyle Huey <me@kylehuey.com> wrote:
> >
> > There is ongoing work by Yichao Yu to make rr, a userspace record and
> > replay debugger[0], production quality on arm64[1]. One of the bigger
> > remaining issues is the kernel's emulation of accesses to certain
> > system registers[2] that reflect timing and CPU capabilities and are
> > either non-deterministic or can vary from processor to processor.
>
> Just to make things clear: the kernel usually doesn't provide any
> emulation for registers such as CNTVCT_EL0. On sane HW, userspace is
> free to access it directly without any mediation (we only use the trap
> for the sake of dealing with HW bugs).

Right, in this case we would also want to set e.g.
CNTKCTL_EL1.EL0VCTEN = 0 whenever a task that has used PR_SET_TSC is
running. Then the hardware would deliver the fault, and the kernel
would decline to emulate the instruction, ultimately leading to the rr
supervisor seeing the signal, looking at the offending instruction,
and deciding how to handle it itself.

This is how RDTSC is handled on x86.  prctl(PR_SET_TSC,
PR_TSC_SIGSEGV) sets TIF_NOTSC on the task, and then at context
switches that leads to setting and clearing CR4.TSD as appropriate.

My understanding is that some of these (e.g. MIDR_EL1) actually are
always emulated by the kernel.

> > We
> > would like to add the ability to tell the kernel to decline to emulate
> > these instructions for a given task and pass that responsibility onto
> > the supervising rr ptracer. There are analogous processor features and
> > disabling mechanisms on x86. The RDTSC instruction is controlled by
> > prctl(PR_SET_TSC) and the CPUID instruction is controlled (when the
> > hardware allows) by arch_prctl(ARCH_SET_CPUID).
> >
> > The questions I'd like to raise are:
> >
> > 1. Is it appropriate to reuse PR_SET_TSC for roughly equivalent
> > functionality on AArch64? (even if the AArch64 feature is not actually
> > named Time Stamp Counter).
>
> My gut feeling is that you really don't want to hijack an existing
> API, because this is fundamentally different. The Linux arm64 ABI
> mandates that the counter (and the frequency register associated with
> it) are accessible, and you can't make them disappear.

We don't want to make them disappear per se. rr would emulate accesses
to these features. On x86 rr itself runs an rdtsc during recording
after the hardware traps for the tracee and notes the value it
returns. rr then sticks that value into the supervised process and
resumes execution. During replay we inject the same rdtsc value we
noted during recording to produce deterministic behavior.

> From what I understand, you are relying on the TSC being disabled in
> the tracee and intercepting the signal that gets delivered when it
> accesses the counter. Is that correct?

Yes.

> Assuming I'm right, I think it'd make a lot more sense if there was a
> first class ptrace option, if only because this would mandate the
> kernel to start trapping things that are not trapped today.
>
> It also begs the question of the fate of CNTFRQ_EL0, since you want to
> be able to replay traces from one system to another (and the counter
> is meaningless without the frequency).

Yes, we'd want that too.

> Finally, what of the VDSO, which is by far the most common user of the
> counter? I can totally imagine the VDSO getting stuck if emulation is
> used and the sequence counter moves synchronously with the traps
> (which is why we disable the VDSO when trapping CNTVCT_EL0).

prctl(PR_SET_TSC, PR_TSC_SIGSEGV) will break RDTSC-using VDSO syscalls
like gettimeofday entirely on x86 so this isn't a new issue. rr
disables the VDSO anyways for other reasons, so this doesn't actually
apply to us. Like Keno I am curious what problem you expect if the
counter is actually emulated though.

> > 2. Likewise for ARCH_SET_CPUID
>
> We don't just emulate a single register, but a whole class of them. If
> you are to present a different view for any of those, you'll need to
> handle the lot (I really can't see why one would be more important
> than the others).
>
> So SET_CPUID really is the wrong tool. I'd rather there was (again) an
> API that described exactly that.

I don't think I communicated accurately what this does. PR_SET_TSC and
ARCH_SET_CPUID don't actually set the values returned from RDTSC and
CPUID. They instead control whether the instruction is enabled or uses
hardware capabilities to trap when executed. The rr supervisor then
figures out what to do.  x86's CPUID is also quite complicated and has
many different sets of information that can be accessed based on the
value of %eax,%edx when the CPUID instruction is executed.

> > 3. Since arch_prctl is x86-only, does it make more sense to add
> > arch_prctl to arm64 or to duplicate ARCH_SET_CPUID into the prctl
> > world? (e.g. a PR_SET_CPUID that works on both x86/arm64)
>
> I don't think any applies here. Different architectures have different
> ABI requirements, and you can't really merge the two. Because the next
> thing you know, you'll ask for the same thing for PMU registers, and
> try to map them onto something else.
>
> Overall, this would be better served by a framework for userspace
> delegation of sysreg access by a ptrace'd process. Let's try to look
> at it in those terms rather than casting arm64 into a seemingly
> unrelated API.

Explicit mechanisms to provide control over the hardware level trap
features provided by AArch64 (e.g. SCTLR_EL1.UCT and
CNTKCTL_EL1.EL0VCTEN) and the kernel's emulation of other sysregs
(e.g. MIDR_EL1) might make more sense. I share Keno's wariness of
running it through ptrace specifically (as opposed to a prctl and
signal like on x86) though.

- Kyle

> Thanks,
>
>         M.
>
> >
> > - Kyle
> >
> > [0] https://rr-project.org/
> > [1] https://github.com/rr-debugger/rr/issues/3234
> > [2] e.g. CNTVCT_EL0 and MIDR_EL1, among others
> >
>
> --
> Without deviation from the norm, progress is not possible.
