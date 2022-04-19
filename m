Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C642507230
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354069AbiDSPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354062AbiDSPyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:54:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA771E3CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:52:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s33so4390907ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svoxI3P1MTFKEFyUdpPrcgYOwcptyW2jfm7B97EDACE=;
        b=hqY0Brlnj/vptEt82cDudZbgfl/3pzyr/UiAK/HR09LT2qyTDendN2hCQPDULF4qRw
         DMD2WZXHCb7MJ6aZApQPmIIYGkgKyW069+FnJ/ZD6dZVthsZUDW9dcmzZ492aVLwGFEJ
         6l2c0JYNOrFB8mg2mlynr3gwmUfaXR24R65wX0B4FRGrmXixvPYrki9bKMc/kqhY/9H3
         QgRcRDULdmTq/hsEt1UZDfjxOwX/1ydc8yeOfCJRu6Mkx5iP4BBjSFIrY++zZ1nJ9dS2
         MossmJ9Bg137dn4v5St1p4jFCv/YC9o/Y71hNCY1vP+aiUG5nm1GIzZxytpjf2PIvl0g
         8ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svoxI3P1MTFKEFyUdpPrcgYOwcptyW2jfm7B97EDACE=;
        b=OPDpU+pYmHkvUtCu00nR6BcbUD/9W1TBrNNW+2syJAdlalQ9jse12q6fDGFi2My/c8
         hMEbv9p/BjHBDtESePM5D+G/IupPmbl3uEObdu5hB71dBBErF7z6boYn2tacesGjY66F
         1BjEYWvqcfOK0p5oQyY9SwXxA7E5UxZDuv+4KudsLT2g23OTkRunvYRAioyySrOgcHi4
         pMLeqOVB9SWIiWtcPc3n8aI4Mum5REWpH+4KJL94tqsqJDr9fx2Q0m7Hy46qhb68hzs/
         gVcRA9uBdDr/xsDoWMHsasMuAIqKWIOcBVO4oSSqUdZvTH+4KaHj7XpP4nMw9RAn1+FQ
         Lj8w==
X-Gm-Message-State: AOAM532G2FEJyRi9eh1hDjaqDCI0aKDR4vJu1xnBVJ8xrK+8f0NCNSGl
        6hscjeep9u2WUOFf1ppSZr2GrVSbwr/t+bTkgCY7Dg==
X-Google-Smtp-Source: ABdhPJwN4AvAD8+aKlKRmatVjthj6YnAmVf6tJQjltNxIYx9SRXrW98T2rAdS6RIq8B0rMsZFiegW5J8TJY2hfW4B0I=
X-Received: by 2002:a25:ea48:0:b0:644:e2e5:309 with SMTP id
 o8-20020a25ea48000000b00644e2e50309mr11576663ybe.407.1650383525468; Tue, 19
 Apr 2022 08:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de>
In-Reply-To: <20220415133356.179706384@linutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 19 Apr 2022 08:51:54 -0700
Message-ID: <CANn89iL+CHRi1HJ6Mp4u=ECnfAXV2qxXZj_BsQuv+uwheAfDDw@mail.gmail.com>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> APERF/MPERF is utilized in two ways:
>
>   1) Ad hoc readout of CPU frequency which requires IPIs
>
>   2) Frequency scale calculation for frequency invariant scheduling which
>      reads APERF/MPERF on every tick.
>
> These are completely independent code parts. Eric observed long latencies
> when reading /proc/cpuinfo which reads out CPU frequency via #1 and
> proposed to replace the per CPU single IPI with a broadcast IPI.
>
> While this makes the latency smaller, it is not necessary at all because #2
> samples APERF/MPERF periodically, except on idle or isolated NOHZ full CPUs
> which are excluded from IPI already.
>
> It could be argued that not all APERF/MPERF capable systems have the
> required BIOS information to enable frequency invariance support, but in
> practice most of them do. So the APERF/MPERF sampling can be made
> unconditional and just the frequency scale calculation for the scheduler
> excluded.
>
> The following series consolidates that.
>

Thanks a lot for working on that Thomas.

I am not sure I will be able to backport this to a Google prodkernel,
as I guess there will be many merge conflicts.

Do you have by any chance this work available in a git branch ?

Thanks.



> Thanks,
>
>         tglx
> ---
>  arch/x86/include/asm/cpu.h       |    2
>  arch/x86/include/asm/topology.h  |   17 -
>  arch/x86/kernel/acpi/cppc.c      |   28 --
>  arch/x86/kernel/cpu/aperfmperf.c |  474 +++++++++++++++++++++++++++++++--------
>  arch/x86/kernel/cpu/proc.c       |    2
>  arch/x86/kernel/smpboot.c        |  358 -----------------------------
>  fs/proc/cpuinfo.c                |    6
>  include/linux/cpufreq.h          |    1
>  8 files changed, 405 insertions(+), 483 deletions(-)
>
>
