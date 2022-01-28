Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6F4A00B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350862AbiA1TPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350845AbiA1TPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:15:08 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:15:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id y23so14075060oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jg3x9AtL/f6z9LGi2iYoNteBrHSWn1nyhxat7ZXxLM=;
        b=H85h2T7hcgJ2PVmA5frj0F4m8+z7kNMHjwITaB/vigmhWxha7poMjo9y+uuVPbOqvP
         pYg3DgnEkdAMSVgFnKWl2x/bSWXSYvlEnM/PEy6m2B9e0YpDQMX0i1M7M2npQvw13M0+
         YxdgD7A621HLrQEYVB+Nph4jfPiQzxD7CmB3Jfv5q+v1xtLmk+g1LpJId3gYGm0izucq
         biMCOz2/RlknQ/QFb38dvuAhVPY8aK/qpmg+JGzV3wAHKDf5LZxfFQOW1iGVHZ51KAmC
         hwDSp2Lz8zfQ53VwsOzXFSRfGpR88fxRR9BEul/+84zn0Elc+Lx8csnk3dQDSj2Xl22a
         E90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jg3x9AtL/f6z9LGi2iYoNteBrHSWn1nyhxat7ZXxLM=;
        b=vu54170gRErfJu6oDHxdNpDit0stMMrfVUHJe8mCFnpdFLOHVsHFD0b479ZWbYvIjQ
         pRmHREhjzzmmCKulZl1xbUev68MrJa8U/rrZdzltBmxCQ3REk6ReuBXkMQJf4XIjPPWf
         h0gHQKkCIKabzyjZFlolfXBxG2EH8R/GorDUJOjgMJFTg3ZPPMLs2oISJA2BsTRnqDM5
         VOeBLd/YD5kPH/eyX0nQ6+aURqug56NdKILkliRucolsoX1W2D0lo+KfMdzKZBWgRnkR
         4nEHfrstv8JRCvxgkkO67pVqjstta7SMMmBCU6YTM4N7gOsCQcaYj8YGQ9Fdgx5x2Qx5
         p5IA==
X-Gm-Message-State: AOAM532jPytZX1XtAStQWgM3Y1tvB0fX5BS/a/0RK2d1Yvy0w7v5UWG0
        pBJj61eqqUYqDLojBMK+b+Vpm+e1KWpd6igLA4H0dQ==
X-Google-Smtp-Source: ABdhPJziHaXrYHt+PYKYiMAEu501P49cMI9eqaDGMeh+Kt5aygRqLCedT1zNRdwqNB7W+x0cRAPLUqnBVrGh4Zl7yE0=
X-Received: by 2002:aca:2b16:: with SMTP id i22mr9743887oik.128.1643397307599;
 Fri, 28 Jan 2022 11:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20220128114446.740575-1-elver@google.com> <20220128114446.740575-2-elver@google.com>
 <YfQ8IwCSzbtAhC3B@dev-arch.archlinux-ax161>
In-Reply-To: <YfQ8IwCSzbtAhC3B@dev-arch.archlinux-ax161>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Jan 2022 20:14:55 +0100
Message-ID: <CANpmjNOVWx_Vpy6kuSzR9E0m=xJqbsF6ypCyfdzGZsGzgUfccQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] stack: Constrain stack offset randomization with
 Clang builds
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 19:55, Nathan Chancellor <nathan@kernel.org> wrote:
[...]
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> One comment below.

Thanks!

Though with Kees's requested changes I'll probably let you re-review it.

> > ---
> >  arch/Kconfig                     |  1 +
> >  include/linux/randomize_kstack.h | 14 ++++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 2cde48d9b77c..c5b50bfe31c1 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1163,6 +1163,7 @@ config RANDOMIZE_KSTACK_OFFSET
> >       bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
> >       default y
> >       depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> > +     depends on INIT_STACK_NONE || !CC_IS_CLANG || CLANG_VERSION >= 140000
> >       help
> >         The kernel stack offset can be randomized (after pt_regs) by
> >         roughly 5 bits of entropy, frustrating memory corruption
> > diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> > index 91f1b990a3c3..5c711d73ed10 100644
> > --- a/include/linux/randomize_kstack.h
> > +++ b/include/linux/randomize_kstack.h
> > @@ -17,8 +17,18 @@ DECLARE_PER_CPU(u32, kstack_offset);
> >   * alignment. Also, since this use is being explicitly masked to a max of
> >   * 10 bits, stack-clash style attacks are unlikely. For more details see
> >   * "VLAs" in Documentation/process/deprecated.rst
> > + *
> > + * The normal alloca() can be initialized with INIT_STACK_ALL. Initializing the
> > + * unused area on each syscall entry is expensive, and generating an implicit
> > + * call to memset() may also be problematic (such as in noinstr functions).
> > + * Therefore, if the compiler provides it, use the "uninitialized" variant.
> >   */
> > -void *__builtin_alloca(size_t size);
>
> Is it okay to remove the declaration? Why was it even added in the first
> place (Kees)?

Declaring __builtins is redundant for as long as I remember.
