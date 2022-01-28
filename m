Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9F4A00CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiA1TXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiA1TXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:23:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE4C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:23:15 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id b186so7998569oif.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FV7ijIEFX2KU+OD0295yjVLA5VTPNJCCnKWoIm2Gjp4=;
        b=iUhb6agjSx5jWLGzq34eJlbUvULhpyoMpZvDkEsoxstrF4eu/dpf+iBl1XU5kgk8aL
         IPkShYjKV81JID3tUiedmh883nQgZEokqG4xYr6we7aM7Qwy987TTfEcxqzTtgrWV01b
         3pd6vfxchYqCI4GEhVvGCaOytpoGXI7dJutuDIH2ut7l+FA5zBjn/N4vbdSqqrARDXzj
         lg8FV7l1TFsOXcPdPqmV7Y3v0SDO1DBe5wcw5tq5L2yOXPpv4M2+DLC+C8LEHBvRvFmA
         UiWEZMeuoMA6HFzPM8ZOxQxH2iqVX1YuXmonv3B4SUuRN0d/hB1njPXkv2+Zhd1Tx4tj
         Np9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FV7ijIEFX2KU+OD0295yjVLA5VTPNJCCnKWoIm2Gjp4=;
        b=7XmI72apmq5Y0zOndZ0knRzQMz6s06xYleTSGLCCthMlvXwFQNn4IATT2/NMrNoAbp
         vjLfVj52woPe+SWoKGaeFH2rrxY2uvBxN0DE6cW3OdTf4yQwk8ERBxVGhIpGoA5amxNx
         yhxF4sq/LPrNr8nE0gZhDD41C89KPAgNmklhByhP8x9k4s75NTn2S5qbPXE+SPqHdOZm
         WVZ6aEsjFDgLd0Y5jzEpu5eEUJ1yonvAwMexR0kRIoMcfPfFlYArP+DihglpKxbIT7ld
         0oVK/Vqzw82Nwld+JkWiYN67ELCKD2e1m5pyaqvInbgscFkNC8/ClSSw2yLjJqlp/4Oc
         j4FA==
X-Gm-Message-State: AOAM530ZxRCPOerUb/oDy/0zXhJenGKzJU760y56Zah1ljfOP0IHEmDz
        piESJaH8Ju75NwoYAJ7spEXHW0ERulkHbrr0Qm8ZkQ==
X-Google-Smtp-Source: ABdhPJx4KbdjBP/JlGZxxFynPzlG6BGWoGP9FURjIW3s4gYN+KMRGy0s5GJQzfCA6XqqYcNlRHgCMhNEuf2hknIeSys=
X-Received: by 2002:aca:2b16:: with SMTP id i22mr9759910oik.128.1643397794720;
 Fri, 28 Jan 2022 11:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20220128114446.740575-1-elver@google.com> <20220128114446.740575-2-elver@google.com>
 <202201281058.83EC9565@keescook>
In-Reply-To: <202201281058.83EC9565@keescook>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Jan 2022 20:23:02 +0100
Message-ID: <CANpmjNNaQ=06PfmPudBsLG7r9RsFXYo-NQR4CSM=iO11LFSHKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] stack: Constrain stack offset randomization with
 Clang builds
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 20:10, Kees Cook <keescook@chromium.org> wrote:
[...]
> >       2. Architectures adding add_random_kstack_offset() to syscall
> >          entry implemented in C require them to be 'noinstr' (e.g. see
> >          x86 and s390). The potential problem here is that a call to
> >          memset may occur, which is not noinstr.
[...]
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1163,6 +1163,7 @@ config RANDOMIZE_KSTACK_OFFSET
> >       bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
> >       default y
> >       depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> > +     depends on INIT_STACK_NONE || !CC_IS_CLANG || CLANG_VERSION >= 140000
>
> This makes it _unavailable_ for folks with Clang < 14, which seems
> too strong, especially since it's run-time off by default. I'd prefer
> dropping this hunk and adding some language to the _DEFAULT help noting
> the specific performance impact on Clang < 14.

You're right, if it was only about performance. But there's the
correctness issue with ARCH_WANTS_NOINSTR architectures, where we
really shouldn't emit a call. In those cases, even if compiled in,
enabling the feature may cause trouble.

That's how this got on my radar in the first place (the objtool warnings).

So my proposal is to add another "|| !ARCH_WANTS_NO_INSTR", and add
the performance note to the help text for the !ARCH_WANTS_NO_INSTR
case if Clang < 14.

Is that reasonable?

Sadly both arm64 and x86 are ARCH_WANTS_NO_INSTR. :-/

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
>
> Can you include the note that GCC doesn't initialize its alloca()?

I'm guessing this won't change any time soon, so probably adding it in
the code comment is ok.

Thanks,
-- Marco
