Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B999465507
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhLASUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbhLASUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:20:03 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D3C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:16:38 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso8073131ood.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGrsaWNUagkaLBjhVNdr8PrYlBPFyk15DPESvwSI7wQ=;
        b=Cg02J9Geyt/0G6GQQniw1BsOs9gOfoTQSZW1pIGvEqFbN2T6wIsOrcxh9jdgAH3JQB
         WQs0TIrwaV0ZkZ153T+Of2tQWCWBHKbeDM0QI6xUWruL13LVQP6EHYu1FOlIEIq16w24
         d8KQYtjL3fG1Xi2cGVJd7QkPUGDg3G2qwUvm2KOlHBwzUKrH3/MEYRs1Z0WK2NbP/HmD
         efPf3paUmLIuSrP5DtZe+nZQnoRFW2Gveow525/meJlfsW6IMNPH3lmf9FzhoxsSju/z
         GR5yXMvKakkJ0CZ9cWEslrU3+D9x1N7ZGbwaJW8oy8grROIWSRXdGIm08psNZyXhh6FL
         wHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGrsaWNUagkaLBjhVNdr8PrYlBPFyk15DPESvwSI7wQ=;
        b=gIoAHP/3idmXBfNMnpWpIXEfnVT9Gs6cIm0xRxdJ9Blell23OMu1DKnVpWysQZc84b
         8+gQG4XBD0RL2dH/4A4xRPmRIa8ubYHndblsaaNrFgoLIqk2kBfSIXyQboZKg3lMvukP
         t7SlISJbxpwtpv4ZGJWsigOlSsPpI6XILwNjeLCzEnlcGkoma5x8KhxdnDtF6vOtHOak
         NInSrveeLeieHi3Q1MjHplLlogX1A/slr7kAJ41uL0aNz/Y7yG4ta5pOu/rvFoyD5T99
         qfGd/rHv/bDMaZqrevg61D+GXRTGy248JCSDJgt+MXAeylWQnraBlLO0fDhc8lVsvfJ/
         n8/A==
X-Gm-Message-State: AOAM530Uv1uHiFQoXlPqtIBSEGOYVyPPXOYdgS0TAmgHvkMmNO4SpJHB
        YPKSOBVw2Ym96DpFiuJfZGvKjxPAf4de4LCynh6CcQ==
X-Google-Smtp-Source: ABdhPJza6pEs9eUV/J8DdSMu19nlAcyEidPBV3ZMA7X/V6SJg0BAsTfx5q0q7Ukk3RC6j651Z4jnhvPbAYFXX2+rIFw=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr5335169oos.25.1638382597543;
 Wed, 01 Dec 2021 10:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20211201152604.3984495-1-elver@google.com> <YaebeW5uYWFsDD8W@FVFF77S0Q05N>
 <CANpmjNO9f2SD6PAz_pF3Rg_XOmBtqEB_DNsoUY1ycwiFjoP88Q@mail.gmail.com> <Yae08MUQn5SxPwZ/@FVFF77S0Q05N>
In-Reply-To: <Yae08MUQn5SxPwZ/@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Dec 2021 19:16:25 +0100
Message-ID: <CANpmjNMW_BFnVj2Eaai76PQZqOoABLw+oYm8iGy6Vp9r_ru_iQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix generic Kconfig dependencies if ARCH_WANTS_NO_INSTR
To:     Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 18:46, Mark Rutland <mark.rutland@arm.com> wrote:
[...]
> > > Currently we mostly get away with disabling KCOV for while compilation units,
> > > so maybe it's worth waiting for the GCC 12.0 release, and restricting things
> > > once that's out?
> >
> > An alternative would be to express 'select ARCH_WANTS_NO_INSTR' more
> > precisely, say with an override or something. Because as-is,
> > ARCH_WANTS_NO_INSTR then doesn't quite reflect reality on arm64
> > (yet?).
>
> It's more of a pragmatic thing -- ARCH_WANTS_NO_INSTR does reflect reality, and
> we do *want* to enforce that strictly, it's just that we're just struck between
> a rock and a hard place where until GCC 12 is released we either:
>
> a) Strictly enforce noinstr, and be sure there aren't any bugs from unexpected
>    instrumentation, but we can't test GCC-built kernels under Syzkaller due to
>    the lack of KCOV.
>
> b) Don't strictly enforce noinstr, and have the same latent bugs as today (of
>    unknown severity), but we can test GCC-built kernels under Syzkaller.
>
> ... and since this (currently only affects KCOV, which people only practically
> enable for Syzkaller, I think it's ok to wait until GCC 12 is out, so that we
> can have the benefit of Sykaller in the mean time, and subsequrntly got for
> option (a) and say those people need to use GCC 12+ (and clang 13+).
>
> > But it does look simpler to wait, so I'm fine with that. I leave it to you.
>
> FWIW, for my purposes I'm happy to take this immediately and to have to apply a
> local patch to my fuzzing branches until GCC 12 is out, but I assume we'd want
> the upstream testing to work in the mean time without requiring additional
> patches.

Agree, it's not an ideal situation. :-/

syzkaller would still work, just not as efficiently. Not sure what's
worse, less efficient fuzzing, or chance of random crashes. In fact,
on syzbot we already had to disable it:
https://github.com/google/syzkaller/blob/61f862782082c777ba335aa4b4b08d4f74d7d86e/dashboard/config/linux/bits/base.yml#L110
https://lore.kernel.org/linux-arm-kernel/20210119130010.GA2338@C02TD0UTHF1T.local/T/#m78fdfcc41ae831f91c93ad5dabe63f7ccfb482f0

So if we ran into issues with KCOV on syzbot for arm64, I'm sure it's
not just us. I can't quite see what the reasons for the crashes are,
but ruling out noinstr vs. KCOV would be a first step.

So I'm inclined to suggest we take this patch now and not wait for GCC
12, given we're already crashing with KCOV and therefore have KCOV
disabled on arm64 syzbot.

I'm still fine waiting, but just wanted to point out you can fuzz
without KCOV. Preferences?

Thanks,
-- Marco
