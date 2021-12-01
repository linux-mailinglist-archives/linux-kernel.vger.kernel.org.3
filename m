Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F3465291
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351447AbhLAQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351425AbhLAQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:14:17 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6527FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:10:55 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so35854688otg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEqb4KAOgMzFJNLkGQkPT3DXIyCBroaySsB9I+dSD/s=;
        b=RLrKil5/ET2RKJZWFZ1FIvXUiN178FVuavqk+u2vTfvDSCgKlRUwc6W4Jl8fSI8UN/
         IgHjKoLCbh1xhH11IuUFST1AOGk7t1wPXKCXwso3Mtk/QeMXq/tzdOzWjhBXbzy0fHmU
         gaRxcEorBZeMJDiKjwQ6FCbbJyZiwijPurG36uUFJnQPOS3aSrUPhRuIen7uNDqWkOVb
         yhiOYYAh2i1veL9v1OA7c1ZGmikQc3l2uBsOjjwNh1/eElnXhGLd/IldE2QYHL2kfphy
         rwfed2QHe+8voYcKHwKblNJflluujJpXSbZxHbUUyH1sCYBHYln59BhWPnYzFuU+L97K
         YEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEqb4KAOgMzFJNLkGQkPT3DXIyCBroaySsB9I+dSD/s=;
        b=vJ1fGyj8ip9oM04iZc9aaA8y2UVHOJl+sXPeNHzLKXzc257fvkAPsZ+3uaR0l1xLeA
         U8IY1BB+WWAlSKGvunRQ1OVOaCyh/EFqP/w8PmJKyR+zXm7wtjrBxCKeLH/q5woEcNuU
         XuaOMdoxCiXNbjXfBtSj4W0ZSRJb+tiYRug0gYZM8gXu/ipHwb5M3F/cHv+nbS9R+FdY
         As3j1yjeKwiXokYkua0OqSv5W2m5FAKBxnMTQHTifd4DCUUyOyzCal3fhr+VK32bzNBy
         E5x5fddbaGEGvt3c+h9kAE9IC6DnE+GV8L5sRAhkI8yl/YtlSOyNDHfavih/+utr023/
         dbTg==
X-Gm-Message-State: AOAM533hdJgObY4K5XOafiTThi/mtEGL5OsVKN5/8HtnPc0vJXPiVgUF
        km6Oi5q87ox6qocxZe+7qIJTQigpquGPfFzRJzudag==
X-Google-Smtp-Source: ABdhPJzTS9wgAfK3dj8teWOUyT6VAGJHZPB2bZWbhYi6D6P/7EKmY33eCGly4ZJH6Lq3o4jdvtfCYY/5z2Bf1An2JmU=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr6449697otl.329.1638375054586;
 Wed, 01 Dec 2021 08:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20211201152604.3984495-1-elver@google.com> <YaebeW5uYWFsDD8W@FVFF77S0Q05N>
In-Reply-To: <YaebeW5uYWFsDD8W@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Dec 2021 17:10:39 +0100
Message-ID: <CANpmjNO9f2SD6PAz_pF3Rg_XOmBtqEB_DNsoUY1ycwiFjoP88Q@mail.gmail.com>
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

On Wed, 1 Dec 2021 at 16:57, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Marco,
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
>
> I agree this is the right thing to do, but since GCC 12.0 isn't out yet (and
> only x86 has objtool atm) this will prevent using KCOV with a released GCC on
> arm64 and s390, which would be unfortunate for Syzkaller.
>
> AFAICT the relevant GCC commit is:
>
>    https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cec4d4a6782c9bd8d071839c50a239c49caca689
>
> Currently we mostly get away with disabling KCOV for while compilation units,
> so maybe it's worth waiting for the GCC 12.0 release, and restricting things
> once that's out?

An alternative would be to express 'select ARCH_WANTS_NO_INSTR' more
precisely, say with an override or something. Because as-is,
ARCH_WANTS_NO_INSTR then doesn't quite reflect reality on arm64
(yet?).

But it does look simpler to wait, so I'm fine with that. I leave it to you.

Thanks,
-- Marco
