Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BF46556B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhLAScZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:32:25 -0500
Received: from foss.arm.com ([217.140.110.172]:44372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhLAScY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:32:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AAE01477;
        Wed,  1 Dec 2021 10:29:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AFB73F766;
        Wed,  1 Dec 2021 10:29:00 -0800 (PST)
Date:   Wed, 1 Dec 2021 18:28:57 +0000
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
Message-ID: <Yae+6clmwHox7CHN@FVFF77S0Q05N>
References: <20211201152604.3984495-1-elver@google.com>
 <YaebeW5uYWFsDD8W@FVFF77S0Q05N>
 <CANpmjNO9f2SD6PAz_pF3Rg_XOmBtqEB_DNsoUY1ycwiFjoP88Q@mail.gmail.com>
 <Yae08MUQn5SxPwZ/@FVFF77S0Q05N>
 <CANpmjNMW_BFnVj2Eaai76PQZqOoABLw+oYm8iGy6Vp9r_ru_iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMW_BFnVj2Eaai76PQZqOoABLw+oYm8iGy6Vp9r_ru_iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:16:25PM +0100, Marco Elver wrote:
> On Wed, 1 Dec 2021 at 18:46, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
> > > > Currently we mostly get away with disabling KCOV for while compilation units,
> > > > so maybe it's worth waiting for the GCC 12.0 release, and restricting things
> > > > once that's out?
> > >
> > > An alternative would be to express 'select ARCH_WANTS_NO_INSTR' more
> > > precisely, say with an override or something. Because as-is,
> > > ARCH_WANTS_NO_INSTR then doesn't quite reflect reality on arm64
> > > (yet?).
> >
> > It's more of a pragmatic thing -- ARCH_WANTS_NO_INSTR does reflect reality, and
> > we do *want* to enforce that strictly, it's just that we're just struck between
> > a rock and a hard place where until GCC 12 is released we either:
> >
> > a) Strictly enforce noinstr, and be sure there aren't any bugs from unexpected
> >    instrumentation, but we can't test GCC-built kernels under Syzkaller due to
> >    the lack of KCOV.
> >
> > b) Don't strictly enforce noinstr, and have the same latent bugs as today (of
> >    unknown severity), but we can test GCC-built kernels under Syzkaller.
> >
> > ... and since this (currently only affects KCOV, which people only practically
> > enable for Syzkaller, I think it's ok to wait until GCC 12 is out, so that we
> > can have the benefit of Sykaller in the mean time, and subsequrntly got for
> > option (a) and say those people need to use GCC 12+ (and clang 13+).
> >
> > > But it does look simpler to wait, so I'm fine with that. I leave it to you.
> >
> > FWIW, for my purposes I'm happy to take this immediately and to have to apply a
> > local patch to my fuzzing branches until GCC 12 is out, but I assume we'd want
> > the upstream testing to work in the mean time without requiring additional
> > patches.
> 
> Agree, it's not an ideal situation. :-/
> 
> syzkaller would still work, just not as efficiently. Not sure what's
> worse, less efficient fuzzing, or chance of random crashes. In fact,
> on syzbot we already had to disable it:
> https://github.com/google/syzkaller/blob/61f862782082c777ba335aa4b4b08d4f74d7d86e/dashboard/config/linux/bits/base.yml#L110
> https://lore.kernel.org/linux-arm-kernel/20210119130010.GA2338@C02TD0UTHF1T.local/T/#m78fdfcc41ae831f91c93ad5dabe63f7ccfb482f0
> 
> So if we ran into issues with KCOV on syzbot for arm64, I'm sure it's
> not just us. I can't quite see what the reasons for the crashes are,
> but ruling out noinstr vs. KCOV would be a first step.
> 
> So I'm inclined to suggest we take this patch now and not wait for GCC
> 12, given we're already crashing with KCOV and therefore have KCOV
> disabled on arm64 syzbot.
> 
> I'm still fine waiting, but just wanted to point out you can fuzz
> without KCOV. Preferences?

If it's not used by Syzbot, that's good enough for me -- I can apply local
hacks to run with KCOV if I want to in the mean time, and I can debug my own
mess if I have to.

So FWIW, for taking that now:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
