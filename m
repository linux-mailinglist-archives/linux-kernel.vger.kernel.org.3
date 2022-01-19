Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2130493699
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352608AbiASIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:52:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40580
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352603AbiASIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:52:30 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C0F4C4004F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642582348;
        bh=ai0mtCcxBfPYjg/Rd+cRPtcnrmZDCgQL5kNBaw6vXBk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MpXAuc4JOEkWUtixkFTJTFfCLuRZ0eTXWaVmYanA8zon1qexqm4Z3ZP+rtfuQ2vtP
         8+CEsifp8jxuMKy8pJ353A67J6lF9Xyy2XMPMj3gd0vr7ux5cWaDmNCAQCD5PYLuRf
         XO7u4G5Ex1qjCDCnN2sFBjysWHdK4502r2vL0uvf8+tDeguN91HL0xkN63f1Z05SCt
         Cdfdt6w9VEhSip1Tr5zxYKcUpBQ90DHkmY3ooG3EmKxtElKA96GufQmc9hQdFKRLHb
         qCbWH0Dp6BvxPM8t8jH1IAEBq3Rrov7Ps9TSlUj8eKAF++8fmHalHXTFlvgXBqhC3C
         nOBIURmQkTySQ==
Received: by mail-ed1-f69.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso1696221edw.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai0mtCcxBfPYjg/Rd+cRPtcnrmZDCgQL5kNBaw6vXBk=;
        b=qL9u5wUp1C6f4iQlFPRfpwsqcEy1eiUrZcgRmSl4etFMferGDDdwAu048rAJbF9skc
         AwX81PREPY3XwjrssBJrPVVTH40F67MoaSqxcrkuXUXnoPsSMembxD6uCM5q2yCfg5yT
         ZhEtFXY3XoEYsNCK3OYBtNPVCcOejEGAfCICJHYP2C5fXG+RhBAKBN0rg2TYLJjtluN5
         Qe0DUMGRo4PnXFyto4a9QvqSljzCyqsLcWEKiVJVhS5SRZTeQl6cZoMxhUbl/zoOdOoq
         fxRZgt3w9fVMe/F8b6FY+nW3Ep6HOFB6BiSNMNkUB1NZNEfHSEMyJW+hsLRuICP5td5I
         HoHQ==
X-Gm-Message-State: AOAM531BndyU3AaSnDch1/kLRuq1Md+590RO2J0L49YePSogJ06RzoDg
        rBjv9GIKL1w1qn7jpQP3WhJB8aQr+BnbWdVIuuY9DMIgKbpWvJsxZJNyH6Ovd20dpMg8loQsKsI
        k1Z1xcg5TEB3qJEJJnpMQp1ULkt3g0xw0Nr5FV8LUptsJjT2CgjmBVS1Y9A==
X-Received: by 2002:a17:906:4fcb:: with SMTP id i11mr24904280ejw.297.1642582348164;
        Wed, 19 Jan 2022 00:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvCGsrVfBlF4BoQOo9l1ZqngpC3yvW73O8W0Rn9oOxRM0w3U3Wfwr4FENlXSPIpIE6MAozy60dCLchp0fsayg=
X-Received: by 2002:a17:906:4fcb:: with SMTP id i11mr24904268ejw.297.1642582347994;
 Wed, 19 Jan 2022 00:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20211206160514.2000-1-jszhang@kernel.org> <20220116133847.GE2388@MiWiFi-R3L-srv>
 <YebK70Sx4w8zLfj/@xhacker> <20220119080859.GB4977@MiWiFi-R3L-srv>
In-Reply-To: <20220119080859.GB4977@MiWiFi-R3L-srv>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 19 Jan 2022 09:52:16 +0100
Message-ID: <CA+zEjCvqYAWaWW9hVbHqYm_GbV-BaiOM4c77WHnxDNh+SRDUuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
To:     Baoquan He <bhe@redhat.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Wed, Jan 19, 2022 at 9:11 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 01/18/22 at 10:13pm, Jisheng Zhang wrote:
> > On Sun, Jan 16, 2022 at 09:38:47PM +0800, Baoquan He wrote:
> > > Hi Jisheng,
> >
> > Hi Baoquan,
> >
> > >
> > > On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> > > > Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> > > > by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> > > > and increase compile coverage.
> > >
> > > I go through this patchset, You mention the benefits it brings are
> > > 1) simplity the code;
> > > 2) increase compile coverage;
> > >
> > > For benefit 1), it mainly removes the dummy function in x86, arm and
> > > arm64, right?
> >
> > Another benefit: remove those #ifdef #else #endif usage. Recently, I
> > fixed a bug due to lots of "#ifdefs":
> > http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html
>
> Glad to know the fix. While, sometime the ifdeffery is necessary. I am
> sorry about the one in riscv and you have fixed, it's truly a bug . But,
> the increasing compile coverage at below you tried to make, it may cause
> issue. Please see below my comment.
>
> >
> > >
> > > For benefit 2), increasing compile coverage, could you tell more how it
> > > achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
> > > purpose? Please forgive my poor compiling knowledge.
> >
> > Just my humble opinion, let's compare the code::
> >
> > #ifdef CONFIG_KEXEC_CORE
> >
> > code block A;
> >
> > #endif
> >
> > If KEXEC_CORE is disabled, code block A won't be compiled at all, the
> > preprocessor will remove code block A;
> >
> > If we convert the code to:
> >
> > if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
> >       code block A;
> > }
> >
> > Even if KEXEC_CORE is disabled, code block A is still compiled.
>
> This is what I am worried about. Before, if CONFIG_KEXEC_CORE is
> unset, those relevant codes are not compiled in. I can't see what
> benefit is brought in if compiled in the unneeded code block. Do I miss
> anything?
>

This is explained in Documentation/process/coding-style.rst "21)
Conditional Compilation".

Alex

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
