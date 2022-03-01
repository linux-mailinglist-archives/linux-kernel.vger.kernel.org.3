Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F934C942A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiCATVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiCATVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:21:39 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19F52E20;
        Tue,  1 Mar 2022 11:20:57 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d07ae0b1c4so155875677b3.11;
        Tue, 01 Mar 2022 11:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSEjLnvfrlzDKBKyYr5gFF+7i9AJoEANYsRlQjCZNV4=;
        b=Mj/yyNh84U/+3GOCDp9QMKiGkajAiSWKCFQzRPa+0vS6FA9hlBxt7bgv2ofa4rsiRK
         Yyju1CAE96lpqzYnkUTdeoH98TVBttxxcUh7sOK2uLcZmY+pniP+gz2EcDDmNXqQE+/u
         D4OmxJF/cEqzp5PbSFZdjFOI3y9odWR0G0j1hmba767oC0Ous+jSOIsPLyFg6q32CzZ6
         5VseR2CCc4fMfo1ph3Mio7397BmLdIHEBX4vnhL8jgcHhTp7OrXVRXrVq45t3972s9Ok
         xEKb49mHndpn2JLuIaMHbKUFcHXXICr5pRezx13PZFocMHyJfdK5IqnLvlo5gI5/Tt7o
         qf6Q==
X-Gm-Message-State: AOAM531BpHRkOIH1IAKHY1mk3kMqdvFpwJLbwhn/H+WlliyhpwqCeixy
        zXT2oojRyid5gRNShcQrqY8XmVwpCY7dNT342kU=
X-Google-Smtp-Source: ABdhPJyLmWbtSKgcXsl7hWwlL/svnCzsLyibcCbPx1KfUAIfiII01B0kuaTaybiNrmiNE6X9odkY/nOYCEA2lgVnEWk=
X-Received: by 2002:a0d:e8d2:0:b0:2d6:1743:4023 with SMTP id
 r201-20020a0de8d2000000b002d617434023mr26860712ywe.7.1646162456365; Tue, 01
 Mar 2022 11:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214101450.356047-1-ray.huang@amd.com>
In-Reply-To: <20220214101450.356047-1-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:20:45 +0100
Message-ID: <CAJZ5v0jgqzzog_F+DtgKk544FDQ=iQ_rDfwKeHnEiLLrCyi9Hw@mail.gmail.com>
Subject: Re: [PATCH 0/4] x86/acpi/cppc: Minor clean up for x86 CPPC implementation
To:     Huang Rui <ray.huang@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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

On Mon, Feb 14, 2022 at 11:51 AM Huang Rui <ray.huang@amd.com> wrote:
>
> Hi all,
>
> While we were fixing the legacy issue below, we found the dependencies
> between smpboot and CPPC were not very good. But due to urgent fix for
> 5.17-rc1, I didn't have much time to provide a complete solution.
>
> https://lore.kernel.org/lkml/YdeWDDCwBQAYnlKb@amd.com/
>
> In these series, I expand the scope of acpi/cppc_msr to acpi/cppc to cover
> the all the CPPC helper functions for x86 ACPI. And then clean up the
> smpboot and move CPPC related functions into the acpi/cppc.c. This design
> is more straightforward and more clear to handle the CPPC in x86 and
> resolve dependency issues between CPPC and smpboot.c.
>
> Thanks,
> Ray
>
> Huang Rui (4):
>   x86/acpi: Expand the CPPC MSR file to cover the whole CPPC
>     implementation
>   x86, sched: Move AMD maximum frequency ratio setting function into x86
>     CPPC
>   x86, sched: Expose init_freq_invariance to topology header
>   x86/acpi: Move init_freq_invariance_cppc into x86 CPPC
>
>  arch/x86/include/asm/topology.h |  13 +++-
>  arch/x86/kernel/acpi/Makefile   |   2 +-
>  arch/x86/kernel/acpi/cppc.c     | 103 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/acpi/cppc_msr.c |  49 ---------------
>  arch/x86/kernel/smpboot.c       |  72 +---------------------
>  5 files changed, 118 insertions(+), 121 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/cppc.c
>  delete mode 100644 arch/x86/kernel/acpi/cppc_msr.c
>
> --

This series makes sense to me and I'm inclined to take it if there are
no objections, so if there are any, please let me know.
