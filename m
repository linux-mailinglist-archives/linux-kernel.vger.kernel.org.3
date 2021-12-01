Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B60465438
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhLARt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:49:57 -0500
Received: from foss.arm.com ([217.140.110.172]:43298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhLARtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:49:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB3C14BF;
        Wed,  1 Dec 2021 09:46:29 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9BAD3F766;
        Wed,  1 Dec 2021 09:46:26 -0800 (PST)
Date:   Wed, 1 Dec 2021 17:46:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if
 ARCH_WANTS_NO_INSTR
Message-ID: <Yae08MUQn5SxPwZ/@FVFF77S0Q05N>
References: <20211201152604.3984495-1-elver@google.com>
 <YaebeW5uYWFsDD8W@FVFF77S0Q05N>
 <CANpmjNO9f2SD6PAz_pF3Rg_XOmBtqEB_DNsoUY1ycwiFjoP88Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO9f2SD6PAz_pF3Rg_XOmBtqEB_DNsoUY1ycwiFjoP88Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:10:39PM +0100, Marco Elver wrote:
> On Wed, 1 Dec 2021 at 16:57, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Marco,
> >
> > On Wed, Dec 01, 2021 at 04:26:04PM +0100, Marco Elver wrote:
> > > Until recent versions of GCC and Clang, it was not possible to disable
> > > KCOV instrumentation via a function attribute. The relevant function
> > > attribute was introduced in 540540d06e9d9 ("kcov: add
> > > __no_sanitize_coverage to fix noinstr for all architectures").
> > >
> > > x86 was the first architecture to want a working noinstr, and at the
> > > time no compiler support for the attribute existed yet. Therefore,
> > > 0f1441b44e823 ("objtool: Fix noinstr vs KCOV") introduced the ability to
> > > NOP __sanitizer_cov_*() calls in .noinstr.text.
> > >
> > > However, this doesn't work for other architectures like arm64 and s390
> > > that want a working noinstr per ARCH_WANTS_NO_INSTR.
> > >
> > > At the time of 0f1441b44e823, we didn't yet have ARCH_WANTS_NO_INSTR,
> > > but now we can move the Kconfig dependency checks to the generic KCOV
> > > option. KCOV will be available if:
> > >
> > >       - architecture does not care about noinstr, OR
> > >       - we have objtool support (like on x86), OR
> > >       - GCC is 12.0 or newer, OR
> > >       - Clang is 13.0 or newer.
> >
> > I agree this is the right thing to do, but since GCC 12.0 isn't out yet (and
> > only x86 has objtool atm) this will prevent using KCOV with a released GCC on
> > arm64 and s390, which would be unfortunate for Syzkaller.
> >
> > AFAICT the relevant GCC commit is:
> >
> >    https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
> >
> > Currently we mostly get away with disabling KCOV for while compilation units,
> > so maybe it's worth waiting for the GCC 12.0 release, and restricting things
> > once that's out?
> 
> An alternative would be to express 'select ARCH_WANTS_NO_INSTR' more
> precisely, say with an override or something. Because as-is,
> ARCH_WANTS_NO_INSTR then doesn't quite reflect reality on arm64
> (yet?).

It's more of a pragmatic thing -- ARCH_WANTS_NO_INSTR does reflect reality, and
we do *want* to enforce that strictly, it's just that we're just struck between
a rock and a hard place where until GCC 12 is released we either:

a) Strictly enforce noinstr, and be sure there aren't any bugs from unexpected
   instrumentation, but we can't test GCC-built kernels under Syzkaller due to
   the lack of KCOV.

b) Don't strictly enforce noinstr, and have the same latent bugs as today (of
   unknown severity), but we can test GCC-built kernels under Syzkaller.

... and since this (currently only affects KCOV, which people only practically
enable for Syzkaller, I think it's ok to wait until GCC 12 is out, so that we
can have the benefit of Sykaller in the mean time, and subsequrntly got for
option (a) and say those people need to use GCC 12+ (and clang 13+).

> But it does look simpler to wait, so I'm fine with that. I leave it to you.

FWIW, for my purposes I'm happy to take this immediately and to have to apply a
local patch to my fuzzing branches until GCC 12 is out, but I assume we'd want
the upstream testing to work in the mean time without requiring additional
patches.

Thanks,
Mark.
