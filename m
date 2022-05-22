Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC90530520
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 20:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbiEVSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiEVSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 14:22:50 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04B15822
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 11:22:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z16so2342207ilp.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tE8WqZzfOUJN2zSX+4Vir8QOi6nMy7D6r1Ae/XTxJ/s=;
        b=SlqvKxwH9G/5iO+xjA0hBg81hK37y9bUcgTmFRUKWRzdNTxgAVLmvAULrdfT+nUedd
         JcYcNfRa2HmBdm7s5tdpEhNRqAVJhJV4SZOmKQVhjWE+PA9oXEVnxktwiVTzTB/cJ25F
         w2HJ5v69QOjBHo/TEJoSrcWn8vnS2d2v2zuPBS6tyUuX/laI+z9Wuqaka8FK+GJl932v
         63dbDojN6k8jQwdlV/n5L6iLHPsDXOE7lIVP6VxMSJA7pxQMG6cK/VzAu3nSLABiyu23
         rrhG8ADYMSYHxdDJtsXsCevmPId8ynmw2J2Uhk6Jz7tYrco+5566UW60dhIvShOwc4DV
         cXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tE8WqZzfOUJN2zSX+4Vir8QOi6nMy7D6r1Ae/XTxJ/s=;
        b=U7fVa3ukcFw2fFUpiG57HQ6cWJWdESJt2vX3u9m5MaEM+qzJRvyixCq72s4xkkGj6r
         WJ0yUhbM7ScVYvLRLLRkJiYnzYOaIpGZNBvXtFsaAxPj+HR3hME5CNRgiHyk5QiP5fUv
         rDnJTkAxTP1PKs03zHHm+5jayyflsipc6lByFKBE+3PKKF19l6LRRDuCIAWfkwSQezo7
         mebGtkrWzhhzvbJskbIDQ828iJskBP1YgLo995ktEcQ7nidqiYnqlkxQui6ZOb6VUgrU
         wvZU7m5ph5KmrER7d2Wl4OGuCJfl3A95eu1Yju/a5lrFVY6FlAFcohXWKEDhP5iD5GaF
         i+jg==
X-Gm-Message-State: AOAM531ocxmvDNd8YWxfizGsMWqK8qRsKI30MvkkNldCVile5IcHU66s
        dkEf7I7EWpLXLJtRITCOdS1H8DnD2hPkfCAHXMrN8ZMPnEpgkQ==
X-Google-Smtp-Source: ABdhPJzrQva0YQ8rKPi+yqROj98/y42yMUpo8gSstb5UM2lZICPSKQKEpxWYQ8cVAvShf7IhDeek4aSVQpM0atY5FvA=
X-Received: by 2002:a05:6e02:12e3:b0:2d1:583e:32bb with SMTP id
 l3-20020a056e0212e300b002d1583e32bbmr9821443iln.14.1653243768620; Sun, 22 May
 2022 11:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045ApiMSvP--f2E0=VdMbjE8oibvy921m8JASf4kaCCuU2RA@mail.gmail.com>
 <87ilpxmvg3.wl-maz@kernel.org>
In-Reply-To: <87ilpxmvg3.wl-maz@kernel.org>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 22 May 2022 14:22:12 -0400
Message-ID: <CABV8kRyzTB1X0po8h0qa8Ey92QvhJdZNBKg0pkQqCrwar0eXNw@mail.gmail.com>
Subject: Re: arm64 equivalents of PR_SET_TSC/ARCH_SET_CPUID
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yyc1992@gmail.com, "Robert O'Callahan" <robert@ocallahan.org>,
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

On Sun, May 22, 2022 at 11:35 AM Marc Zyngier <maz@kernel.org> wrote:
> From what I understand, you are relying on the TSC being disabled in
> the tracee and intercepting the signal that gets delivered when it
> accesses the counter. Is that correct?

Yes, this is correct. The way that these kernel APIs work is that they turn
any use of `rdtsc` (respectively `cpuid`) into SIGSEGV signals that the
ptracer intercepts and emulates. It's not particularly pretty, but it
works reasonably well in practice.

> Assuming I'm right, I think it'd make a lot more sense if there was a
> first class ptrace option, if only because this would mandate the
> kernel to start trapping things that are not trapped today.

I'm a bit nervous about "first class ptrace option" if only because ptrace
is already a complicated mess and having spent a significant amount
of time hunting down architecture-specific ptrace quirks, I'd be quite
hesitant to introduce another one without a very strong justification.
If the proposed mechanism is essentially signal-equivalent
(i.e. it causes a ptrace stop and lets the ptracer emulate the instruction),
then I'd strongly advocate for making it an actual, proper signal which
has well-understood quirks (as the PR_SET_TSC/ARCH_SET_CPUID
do on x86).

The other consideration here is that disabling these sorts of counters
may have non-ptrace applications e.g. sandboxes may want to disable
these sorts of capabilities to harden against timing attacks, which
may suggest that ptrace isn't the right place for it.

If we're considering something more fancy, that's a different story of
course. Naturally causing a ptrace trap on these instructions has
significant overhead, but because they're usually fast, existing userspace
is not particularly judicious in their use (the same issue happens on x86
of course). One could imagine a light-weight kernel-level record/replay
capability where all accesses to these registers are traced and dumped
into a buffer (with the corresponding capability to feed the values from
a buffer). That kind of capability feels like a more natural fit for the perf
subsystem, which already has capabilities to shuffle trace buffers around.

> It also begs the question of the fate of CNTFRQ_EL0, since you want to
> be able to replay traces from one system to another (and the counter
> is meaningless without the frequency).

Yes, it'd have to be interceptable also.

> Finally, what of the VDSO, which is by far the most common user of the
> counter? I can totally imagine the VDSO getting stuck if emulation is
> used and the sequence counter moves synchronously with the traps
> (which is why we disable the VDSO when trapping CNTVCT_EL0).

Could you elaborate on this concern? rr does disable the vdso currently,
so it wouldn't be a problem from that perspective, but I don't understand
what you mean by the VDSO getting "stuck".

> > 2. Likewise for ARCH_SET_CPUID
>
> We don't just emulate a single register, but a whole class of them. If
> you are to present a different view for any of those, you'll need to
> handle the lot (I really can't see why one would be more important
> than the others).
>
> So SET_CPUID really is the wrong tool. I'd rather there was (again) an
> API that described exactly that.

I'm assuming these register values are all fixed as long as the process
doesn't get migrated between CPU cores? In that case, it seems quite
doable to introduce another ptrace regset that just has the register
values for everything that could potentially be emulated (and is extensible
for future additions). We'd need to think through the exact semantics
in the ordinary course if one of the emulated registers does change,
but it seems like a solvable issue.

Keno
