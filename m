Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E74D1FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349496AbiCHSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349485AbiCHSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:19:42 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040143EDB;
        Tue,  8 Mar 2022 10:18:45 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id u10so19647119ybd.9;
        Tue, 08 Mar 2022 10:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mm42zyukh7VksC1paHdf15HMBSOa0ps1GGtSZmcm+Y=;
        b=dUeqh/2yPGz+muX+vwmG5tihyVuaCZ7b3I27N4BZGhADqL3BVklVQJjU1CXF8dl8Z9
         /ZOhqCGPmE9Jbm1QuLi0e/rNf21EHbPda5ZhV6fTwAFQbMJOHhg4YJvkiOwqBOR0uFEN
         /0acz+InaTh53nQeQxODlSv4JgOvi40Dn7uDI5CpYd/5FGnMWYXjEV5uArSN0lL7zPYr
         L2yFXyCjRHB3vlrsgKIj4hw7svFjFH2bo3RP+s/dvTDLFViL2xdwAtMAaSXaOPYDwSC9
         niYIM3MkSn1GMQeirP0PPDMbrgd+LDoNHDmXMnna8OIJ53H8AJR1U6++ly5j1RDz+Vqu
         yV8w==
X-Gm-Message-State: AOAM532QpzmcAcokpNL1oe4UFldDEiEqh/SDrd0X7imfbPibFaIUSTNu
        vDfcaJNdHp12Iz7ESCkGSa8ePqbfakXOKKacnik=
X-Google-Smtp-Source: ABdhPJyYffrpdeu9Suv/AB1ytcqAuTnHM7S6CYgSrDk1Koww7qVyYWFAEzAtKp9ZiVc467Auy0StfRQPiSlAR7DB+9Y=
X-Received: by 2002:a25:d7c2:0:b0:628:9d06:457b with SMTP id
 o185-20020a25d7c2000000b006289d06457bmr13331613ybg.137.1646763525016; Tue, 08
 Mar 2022 10:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20220214101450.356047-1-ray.huang@amd.com> <CAJZ5v0jgqzzog_F+DtgKk544FDQ=iQ_rDfwKeHnEiLLrCyi9Hw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jgqzzog_F+DtgKk544FDQ=iQ_rDfwKeHnEiLLrCyi9Hw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 19:18:33 +0100
Message-ID: <CAJZ5v0h6DB9d2buHKmdaicszJ0f5h8YxGN6gkLhMV78im61zBw@mail.gmail.com>
Subject: Re: [PATCH 0/4] x86/acpi/cppc: Minor clean up for x86 CPPC implementation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 8:20 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 14, 2022 at 11:51 AM Huang Rui <ray.huang@amd.com> wrote:
> >
> > Hi all,
> >
> > While we were fixing the legacy issue below, we found the dependencies
> > between smpboot and CPPC were not very good. But due to urgent fix for
> > 5.17-rc1, I didn't have much time to provide a complete solution.
> >
> > https://lore.kernel.org/lkml/YdeWDDCwBQAYnlKb@amd.com/
> >
> > In these series, I expand the scope of acpi/cppc_msr to acpi/cppc to cover
> > the all the CPPC helper functions for x86 ACPI. And then clean up the
> > smpboot and move CPPC related functions into the acpi/cppc.c. This design
> > is more straightforward and more clear to handle the CPPC in x86 and
> > resolve dependency issues between CPPC and smpboot.c.
> >
> > Thanks,
> > Ray
> >
> > Huang Rui (4):
> >   x86/acpi: Expand the CPPC MSR file to cover the whole CPPC
> >     implementation
> >   x86, sched: Move AMD maximum frequency ratio setting function into x86
> >     CPPC
> >   x86, sched: Expose init_freq_invariance to topology header
> >   x86/acpi: Move init_freq_invariance_cppc into x86 CPPC
> >
> >  arch/x86/include/asm/topology.h |  13 +++-
> >  arch/x86/kernel/acpi/Makefile   |   2 +-
> >  arch/x86/kernel/acpi/cppc.c     | 103 ++++++++++++++++++++++++++++++++
> >  arch/x86/kernel/acpi/cppc_msr.c |  49 ---------------
> >  arch/x86/kernel/smpboot.c       |  72 +---------------------
> >  5 files changed, 118 insertions(+), 121 deletions(-)
> >  create mode 100644 arch/x86/kernel/acpi/cppc.c
> >  delete mode 100644 arch/x86/kernel/acpi/cppc_msr.c
> >
> > --
>
> This series makes sense to me and I'm inclined to take it if there are
> no objections, so if there are any, please let me know.

And so applied as 5.18 material now with slightly adjusted subjects.

Thanks!
