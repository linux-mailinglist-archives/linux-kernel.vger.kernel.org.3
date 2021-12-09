Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8346F61B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhLIVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhLIVo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:44:29 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50144C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:40:55 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so7631909otv.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2j4bcO0qWcjtdm6gaythjKIq7TrKLkjf4762fiQLRQ0=;
        b=n+iW5W03vOmikDQVZSWQcgPuAXsqlpYitFH3tqr1et/5xDWgIOK9kThPpB4jjcss7O
         ZjKxF3TDq3+qYgAR34dCu9tp7H29+MEY+CKVOT8Cu5nSalC9nry4JRVeQwtb5mFMGxx4
         0Lrq7s1aA6kfllDO2MYNWDOxtPlfeKSyCNjCmjQQkbinkKepobynjZB6jMFVB7zRu+PI
         HA3tTIceGbVxrBdplywneV5MEcGEf9V9+aUNX+klezWgHY8yJV2RfQRBLEAWhP+53zaZ
         SZWl51lhczQ6oKPPd3mHs3KDTspweD+IxPTjc8DLzr1bJEU5iEfGredzBeBHFOV6jMAc
         Bxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2j4bcO0qWcjtdm6gaythjKIq7TrKLkjf4762fiQLRQ0=;
        b=sUGs/3zFTBE/KrKkZrzciSrM6C2Yyx+8H0ksUYtru72NqEtcT34iSUBhjPjsNU0Q3x
         9qVvJTcDDS50IUCO894ALbPBx94lvTyQfeVUhPc6OQKgT/LD6XeU1/p8uXoTXaNTjpWF
         GwlSltwGpea/Bu3YOPans3EGkaRUpwi6hU67muZVcnIZAiBMpht10BPodAScII/I1LJd
         FcV2SlVhOZdfx+S5vgN9ZQhaUe4XgzEsCSRngfpDpSZI8lQ/+GpT5mKdnVAh1zOEfxO/
         B8i3Iq0+x9Lb+F+LTRFnslZwsp44OF/wwHu04zvE1Pn3Y7VwM90OAFoutdPMjgkxdBNA
         tt3w==
X-Gm-Message-State: AOAM531LqHK/qd8gQ1h4s//TPqK5jVuPJVCzezh2rW1JwamsfwfnH3pT
        JO0mzpyG33p3COHY9ZYgSuVbyr+KzI2QzGmHjDAmKw==
X-Google-Smtp-Source: ABdhPJwpwysTautUApz45OTaJShVoj3kfQ/D0iI37xiT5amNXd6UQf69KpysDtdv3QZosj8cf/QWH8aL9M87PP25N+M=
X-Received: by 2002:a9d:7548:: with SMTP id b8mr7757039otl.92.1639086054434;
 Thu, 09 Dec 2021 13:40:54 -0800 (PST)
MIME-Version: 1.0
References: <YbHTKUjEejZCLyhX@elver.google.com> <CAG48ez0dZwigkLHVWvNS6Cg-7bL4GoCMULyQzWteUv4zZ=OnWQ@mail.gmail.com>
In-Reply-To: <CAG48ez0dZwigkLHVWvNS6Cg-7bL4GoCMULyQzWteUv4zZ=OnWQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Dec 2021 22:40:42 +0100
Message-ID: <CANpmjNOA2BKJfPAFH56etdQ70hsoPFb_VJizipKdJMgEgf3jTg@mail.gmail.com>
Subject: Re: randomize_kstack: To init or not to init?
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 22:16, Jann Horn <jannh@google.com> wrote:
>
> On Thu, Dec 9, 2021 at 10:58 AM Marco Elver <elver@google.com> wrote:
> > Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> > default since dcb7c0b9461c2, which is why this came on my radar. And
> > Clang also performs auto-init of allocas when auto-init is on
> > (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> > aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> > allocas.
> >
> > add_random_kstack_offset() uses __builtin_alloca() to add a stack
> > offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> > enabled, add_random_kstack_offset() will auto-init that unused portion
> > of the stack used to add an offset.
> >
> > There are several problems with this:
> >
> >         1. These offsets can be as large as 1023 bytes. Performing
> >            memset() on them isn't exactly cheap, and this is done on
> >            every syscall entry.
> >
> >         2. Architectures adding add_random_kstack_offset() to syscall
> >            entry implemented in C require them to be 'noinstr' (e.g. see
> >            x86 and s390). The potential problem here is that a call to
> >            memset may occur, which is not noinstr.
>
> This doesn't just affect alloca(), right? According to godbolt.org
> (https://godbolt.org/z/jYrWEx7o8):
>
> void bar(char *p);
> void foo() {
>   char arr[512];
>   bar(arr);
> }
>
> when compiled with "-ftrivial-auto-var-init=pattern -O2 -mno-sse"
> gives this result:
>
> foo:                                    # @foo
>         push    rbx
>         sub     rsp, 512
>         mov     rbx, rsp
>         mov     edx, 512
>         mov     rdi, rbx
>         mov     esi, 170
>         call    memset@PLT
>         mov     rdi, rbx
>         call    bar
>         add     rsp, 512
>         pop     rbx
>         ret
>
> So I think to fix this properly in a way that doesn't conflict with
> noinstr validation, I think you'll have to add a compiler flag that
> lets you specify a noinstr-safe replacement for memset() that should
> be used here?

Yeah, this story isn't over with __builtin_alloca().

A workaround would be to use __attribute__((uninitialized)). Of course
that implies there are no uninit bugs. ;-)
To initialize in noinstr, __memset can be used explicitly.

Maybe there's some guidance on what is and what isn't ok in noinstr
code so we can actually decide what is the right thing to do. I found
this: https://lore.kernel.org/all/878rx5b7i5.ffs@tglx/

Thanks,
-- Marco
