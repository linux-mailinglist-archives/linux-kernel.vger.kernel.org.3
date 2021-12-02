Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9F466942
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376389AbhLBRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376374AbhLBRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:41:49 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325FC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:38:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bj13so634742oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur6dUBVD60Gl/OuuEHFc1N/ZnkqMrKChf9cSJr/RUAk=;
        b=GeF+Yeygf4IzE1fclg2kIv3h09kKzZsSTiuQW7I2WnPBSEIsRHyIQzA61XlblOkdy0
         Dc1IhKLKUHSm7iwAX6nx/48y8jXT00QRCeXdVieyUuHyrQTy+g9zj5S/WiYss0Z7/2xD
         TVU7p8+TNOgnU27ml6rN/VwY5n7w8xGhFVs3fOj+tvtKbmMP1A3FdRl1DM7/C8VwCm9q
         BAf2LqhFhr7u45HqGueuy5p/n9EcleJGiW8Wnt3cejzFciPQPgF3jvLLNd+yj+j+4127
         RTQ4XE4juuyHAflDsdonn4SqvBaBH6hhPq3iBl0ZOnl3cHSwvJew2vEVy/QqStiZRIe4
         DZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur6dUBVD60Gl/OuuEHFc1N/ZnkqMrKChf9cSJr/RUAk=;
        b=E0PWFVoamohrfB+1hlVaWFh6I7iEMhYt07dQLUokyPmNV78axuGeTmIpt0IWKgQCqw
         NUP9Pu/Vt7Mgai76dYh1Uji7BrsMkF13EDTxhgWq+t4GN3RYkBXox3RIajlZ31amp0Qz
         /yHJxO8nic8kEqTVSp4JBE3mU+ECjcnYUye+yLlDT4giV8gTUloSFtVe/LOU32ueOYUy
         WTKiAko1phtt7xQYIEwixZbMqkaD2nRA9psQZ+pwcD/w4FQQsPp6CrtHzeD5Bl2paYUS
         LCqKC2OddZlIdU4vcf0mzUv5IKP9jRXWzB5UrNZDGhFTtep8FSPnD4rXuQhvE8wS1BaS
         wOwA==
X-Gm-Message-State: AOAM532b9l+eoRXPRDAqCvpyiOEcqqrcoopveZXC3tzTWfLpQ+tJcEBw
        8CgeBQy6iCRWI5+1MmETwiRY2perW4JPQ3wtw3dSUQ==
X-Google-Smtp-Source: ABdhPJxoSpQPlarKGw7YSqx+v17ArOyU4hdSF2CErmLByJpd3JitW9ZlXg2woaikg258p5Q1mVOtLxbAfdJVgbnW7Hs=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr5492643oil.65.1638466705594;
 Thu, 02 Dec 2021 09:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20211201152604.3984495-1-elver@google.com> <YajdN5T8vi2ZzP3D@hirez.programming.kicks-ass.net>
In-Reply-To: <YajdN5T8vi2ZzP3D@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Dec 2021 18:38:13 +0100
Message-ID: <CANpmjNM4nxnwt7iWF+kCT862H21CHL-cshYyugBei0ysGAt5uA@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if ARCH_WANTS_NO_INSTR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 18:30, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 01, 2021 at 04:26:04PM +0100, Marco Elver wrote:
> > Until recent versions of GCC and Clang, it was not possible to disable
> > KCOV instrumentation via a function attribute. The relevant function
> > attribute was introduced in 540540d06e9d9 ("kcov: add
> > __no_sanitize_coverage to fix noinstr for all architectures").
> >
> > x86 was the first architecture to want a working noinstr, and at the
> > time no compiler support for the attribute existed yet. Therefore,
> > 0f1441b44e823 ("objtool: Fix noinstr vs KCOV") introduced the ability to
> > NOP __sanitizer_cov_*() calls in .noinstr.text.
> >
> > However, this doesn't work for other architectures like arm64 and s390
> > that want a working noinstr per ARCH_WANTS_NO_INSTR.
> >
> > At the time of 0f1441b44e823, we didn't yet have ARCH_WANTS_NO_INSTR,
> > but now we can move the Kconfig dependency checks to the generic KCOV
> > option. KCOV will be available if:
> >
> >       - architecture does not care about noinstr, OR
> >       - we have objtool support (like on x86), OR
> >       - GCC is 12.0 or newer, OR
> >       - Clang is 13.0 or newer.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  arch/x86/Kconfig  | 2 +-
> >  lib/Kconfig.debug | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 95dd1ee01546..c030b2ee93b3 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -78,7 +78,7 @@ config X86
> >       select ARCH_HAS_FILTER_PGPROT
> >       select ARCH_HAS_FORTIFY_SOURCE
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> > -     select ARCH_HAS_KCOV                    if X86_64 && STACK_VALIDATION
> > +     select ARCH_HAS_KCOV                    if X86_64
> >       select ARCH_HAS_MEM_ENCRYPT
> >       select ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 9ef7ce18b4f5..589c8aaa2d5b 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1977,6 +1977,8 @@ config KCOV
> >       bool "Code coverage for fuzzing"
> >       depends on ARCH_HAS_KCOV
> >       depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
> > +     depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION || \
> > +                GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
>
> Can we write that as something like:
>
>         $(cc-attribute,__no_sanitize_coverage)
>
> instead? Other than that, yes totally.

That'd be nice, but I think we don't have that cc-attribute helper? I
checked how e.g. CC_HAS_NO_PROFILE_FN_ATTR does it, but it won't work
like that because gcc and clang define the attribute differently and
it becomes a mess. That's also what Nathan pointed out here I think:
https://lkml.kernel.org/r/Yaet8x/1WYiADlPh@archlinux-ax161

Let's keep it simple.

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!
