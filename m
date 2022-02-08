Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5BB4ADFDA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbiBHRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiBHRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:45:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23EC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:45:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id p21so16492435ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2ZOKjsTypCf57frmi1Jqd7Dt7KnItcHNvGL+OMmMpI=;
        b=HmnZrkgiLYXAkRHXqwu5HRn8hAE5ABYzHtzdcNr2aI/43FVw5XZoXDLOe8HJxQZieN
         2MjvRMPQXZl299rU9Knx9Ij48msciGp1dRfUUzi+wlCZcEF8Tng16N7jD0bpcS9zg+4G
         oYIPkkGg9d1egvRkDBlB4lsSpDQOo2KUFWB4PQ9s8Xi8WBvOLeqxN3+2uVrAGUbgEALR
         7PIyPvTfNFAbl5cIkYkHkOAOHeKL8hQxBVRKAyJmQAEvfbCtqpRj/z5QZH2h7DvqVQEj
         HVsEMOsp3KiO7pleWWHNVJ/W0WAW+0qU8v/acQx/twwkqUFn376l6fAmAw9pSM4Vvd/x
         FPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2ZOKjsTypCf57frmi1Jqd7Dt7KnItcHNvGL+OMmMpI=;
        b=XquP7eNVIe0Xnir0fq46Dqb08hja3hQc8R4/jyN/S6XgteF8tKwt1NyXZqC48EK7k8
         SEMqr2Va2OMOueaOA50ye02RM6Ou32uiCtgNclt6gi1GSfqRpa9IoEKFmaNS4KcBzONd
         cDOvweSiGv7GU1qAkx84se8OIrrhpZzt3e2zTa9/LxaF3T5VfGn2nDBpdmQnRuBrGe3R
         Q+V5dUF35rgwTQZIJTtX2GiRwaSHGdsKLBWbpYhkf+shHsc7puywi9a7KgH2d6TuJMg4
         aUdIb/sPCdusJd0xzlqFBNmfg4DWc+NFIvWr9rb/1Ci+RYq9Wy5KbYgO3yOIPsbeEmks
         fOvg==
X-Gm-Message-State: AOAM530Z7XcvrtwV0gTqNyQO+Yj+SHCi/omgNfac0AG+6rhZhFQ4u4Hy
        m1gIN4DrCQhHeX37fKYO7ABsNzz2KbbDJCD9Ae1IxA==
X-Google-Smtp-Source: ABdhPJzNrdZ68YdmVvWF4hTmS7YeVVol3VHv3vV2v9o+W/Ks7y29yAhoN2Wv6L+jm4G3Wbc7HBw11ESczjaG7Lg2RPg=
X-Received: by 2002:a05:651c:1253:: with SMTP id h19mr3483007ljh.338.1644342300206;
 Tue, 08 Feb 2022 09:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20220204123740.GA4077@xsang-OptiPlex-9020> <CAKwvOdm0+bB=UY91V=ai2TPg3XCbNUZQfBzxrSUA0AtW=zM=LA@mail.gmail.com>
 <202202071858.0B5538E7CB@keescook>
In-Reply-To: <202202071858.0B5538E7CB@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 09:44:48 -0800
Message-ID: <CAKwvOdm1k51OxYqSq1v9UVp8ZptBkJj7FgOA_QhDjEC6vaU+RQ@mail.gmail.com>
Subject: Re: [x86] 1099ce55b0: BUG:kernel_NULL_pointer_dereference,address
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 7:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 07, 2022 at 04:23:06PM -0800, Nick Desaulniers wrote:
> > On Fri, Feb 4, 2022 at 4:37 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > FYI, we noticed the following commit (built with clang-15):
> > >
> > > commit: 1099ce55b0530ff429312dc37362ad43aee8c5c0 ("x86: don't build CONFIG_X86_32 as -ffreestanding")
> > > https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/memcpy
> > >
> > > in testcase: boot
> > [...]
> > I've been having a hard time pinpointing via bisection when this
> > stopped working.  I suspect it's actually the change on llvm's side
> > that would replace memcmp with bcmp.  With this diff, we can boot
> > ARCH=i386 defconfig
> >
> > ```
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 7ef211865239..5e4570495206 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -88,6 +88,8 @@ ifeq ($(CONFIG_X86_32),y)
> >          include $(srctree)/arch/x86/Makefile_32.cpu
> >          KBUILD_CFLAGS += $(cflags-y)
> >
> > +        KBUILD_CFLAGS += -fno-builtin-bcmp
> > +
> >         ifeq ($(CONFIG_STACKPROTECTOR),y)
> >                 ifeq ($(CONFIG_SMP),y)
> >                         KBUILD_CFLAGS +=
> > -mstack-protector-guard-reg=fs
> > -mstack-protector-guard-symbol=__stack_chk_guard
> > ```
> >
> > It looks like the call argument setup in the _callers_ of memcmp is messed up.
> >
> > Before:
> > pushl %ecx
> > pushl %ebx
> > pushl -24(%ebp)
> > calll bcmp
> >
> > After:
> > movl  %ebx, %eax
> > movl  %esi, %edx
> > movl  %ecx, %ebx
> > calll memcmp
> >
> > it looks like they're not obeying `-mregparm=3`.
> >
> > https://godbolt.org/z/z3fjveP4h
> >
> > Diffing the IR between `-mregparm=3` vs not, it looks like there's an
> > LLVM IR function argument attribute inreg.
> > https://llvm.org/docs/LangRef.html#parameter-attributes
> > >> This indicates that this parameter or return value should be treated in a
> > >> special target-dependent fashion while emitting code for a function call
> > >> or return (usually, by putting it in a register as opposed to memory,
> > >> though some targets use it to distinguish between two different kinds of
> > >> registers). Use of this attribute is target-specific.
> >
> > As is tradition, instcombine is not checking+carrying over the
> > function argument attributes when replacing calls to memcmp w/ bcmp.
> >
> > Before:
> >   %4 = call i32 @memcmp(i8* inreg noundef %3, i8* inreg noundef %0,
> > i32 inreg noundef %1) #4, !dbg !22
> >
> > After:
> >   %bcmp = call i32 @bcmp(i8* %3, i8* %0, i32 %1), !dbg !22
> >
> > Filed:
> > https://github.com/llvm/llvm-project/issues/53645
> >
> > So I think the best course of action is to disable memcmp to bcmp
> > BEFORE the removal of -ffreestanding, and only for clang until we have
> > a fix in hand.
>
> What do you mean about BEFORE the removal of -ffreestanding? As in, add
> two patches, one to add -fno-builtin-bcmp and the next to remove
> -ffreestanding? i.e.:
>
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index e84cdd409b64..c92f69e916b4 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -90,6 +90,9 @@ ifeq ($(CONFIG_X86_32),y)
>
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS += -ffreestanding
> +        ifdef CONFIG_CC_IS_CLANG
> +                KBUILD_CFLAGS += -fno-builtin-bcmp
> +        endif
>
>         ifeq ($(CONFIG_STACKPROTECTOR),y)
>                 ifeq ($(CONFIG_SMP),y)
>
>
> then:
>
>
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index c92f69e916b4..f56936aeed9e 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -88,8 +88,6 @@ ifeq ($(CONFIG_X86_32),y)
>          include $(srctree)/arch/x86/Makefile_32.cpu
>          KBUILD_CFLAGS += $(cflags-y)
>
> -        # temporary until string.h is fixed
> -        KBUILD_CFLAGS += -ffreestanding
>          ifdef CONFIG_CC_IS_CLANG
>                  KBUILD_CFLAGS += -fno-builtin-bcmp
>          endif
>
> ?

Yeah, that's what I had in mind yesterday afternoon. Thinking more
about this in the evening though, I think this is a pretty
catastrophic compiler bug in LLVM.

The compiler does change the calling convention (somewhat) as part of
optimizations when the caller and callee are visible within the same
TU. Here, the callee is not visible, and yet the caller is modifying
the calling convention with no corresponding change to the callee.

Essentially, -ffreestanding is holding -mregparam=3 together for
ARCH=i386 LLVM=1 builds.  That my above diff that only avoided the
issue for memcmp -> bcmp was able to boot to command line is kind of a
miracle.  I'm sure there's all kind of things that don't work right,
and we can't ship that since it will come back to bite us for 32b x86
(such as Android Cuttlefish).

Do we need to remove -ffreestanding for ARCH=i386 for FORTIFY_SOURCE
to work _for GCC_?

If yes, then perhaps we can only add -ffreestanding for clang for now?
If no, then perhaps we should leave -ffreestanding for now?

Either way, I would shelve FORTIFY_SOURCE for ARCH=i386 LLVM=1 until
this compiler bug is fixed (and drop my patch, or I can send a v2).
https://github.com/llvm/llvm-project/issues/53645

That said, I would consider this lower priority than
https://github.com/llvm/llvm-project/issues/53118, which looks like a
very obvious clang-14 regression (the 14 release is almost done, so
it's time to fix regression NOW) that produces an true positive
objtool warning.
-- 
Thanks,
~Nick Desaulniers
