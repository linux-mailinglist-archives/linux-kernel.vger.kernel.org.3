Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE44158CF27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbiHHUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244381AbiHHUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:32:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F51ADA2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:32:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t1so14295985lft.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9afqoEJ3pX/KledohtUjUFflVFqfG6MgRVC4Zz7R1I=;
        b=GKxkQT6h5cDJQOWDClY40dEwoPzV4EkuXe5xNM524LjnYXpv7PqlxkiK6CC4eR9YjT
         utJgUkp0+dR8CbfmFok56kKfHs++46jvx8acLeV8XVt2h0IFDx0Z/v6HkVANGbczhQrQ
         M/F2LhiTHVbSBhUrqxMBbvtMAeMsEykZspXCIr3H4c9HLxYb8PpcLIegY7MPOELuiSkx
         8BD7VYwUCw20prDaph9QBGzEP2kCV2gWediGY5pX13UZEbz5G71EiLrf06l9Tjv/0uOX
         U45zV8hTbL3axMPiXm8shtX/xBmiGrhVLTqOzmmIyB/jUWS54AOepTx7uNxgfEDz4Jq5
         hgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9afqoEJ3pX/KledohtUjUFflVFqfG6MgRVC4Zz7R1I=;
        b=EwoPwIaORBXRQD88p9nnbHQLS9xCY7eShVByyvOzXisWcfqGDoplfiTvpwVy6q7C+k
         kDAUQjX3MM+v9/gSZGkresqFVdiP2YL/RwPr5BO42KWgMO5UOkohe4JxbxOuFNE+T8YE
         OI160zA91bIc7kYLdIioG5tCQvqsoqEQGC5J7gKPQApNulsuV9RHf6P9zedD2E9KKkUs
         PzKpIHtlJvLXJx6++O3ylAVFqn2qC9waPM0rjXDGDqU7SUa+Klz57BuboSRDAMmUNXy+
         jxDOieFfazNNn1C+QOczJOi4/7sDOsu6XrDPZdm1dySXIQgTP6oXdsChBfhc13NyIbSL
         nIAw==
X-Gm-Message-State: ACgBeo1rdbQzIV3AD5rq3sygXyXnokXelCJmNsam15gFW+pNs95leXMc
        OPY+XM/fDGXedjVhhJiIyvxtnaXKFf5Q9RB1sX1wXA==
X-Google-Smtp-Source: AA6agR46qkyX7bDUGyailX3z21cArpXwPMF1t4Fsfj2ILYvF624gplVTkZnJBosL0EMZzYCRz3VWklKTZDNLJ5QEI0k=
X-Received: by 2002:a05:6512:b01:b0:48b:a065:2a8b with SMTP id
 w1-20020a0565120b0100b0048ba0652a8bmr3648405lfu.401.1659990724622; Mon, 08
 Aug 2022 13:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220808192321.3490995-1-ndesaulniers@google.com> <YvFkmfHTUYGzeeQs@dev-arch.thelio-3990X>
In-Reply-To: <YvFkmfHTUYGzeeQs@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Aug 2022 13:31:53 -0700
Message-ID: <CAKwvOdk0q1G--S7JhxOdN4KtCgDETDbkMMnfRZoCERfOmVyVyg@mail.gmail.com>
Subject: Re: [PATCH] x86: assemble with -Wa,--noexecstack to avoid BFD 2.39 warning
To:     Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nick Clifton <nickc@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicolas Schier <n.schier@avm.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ben Dooks <ben-linux@fluff.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, Aug 8, 2022 at 12:31 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Aug 08, 2022 at 12:23:05PM -0700, Nick Desaulniers wrote:
> > Users of GNU ld (BFD) from binutils 2.39+ will observe multiple instance
> > of a new warning when linking kernels in the form:
> >
> >   ld: warning: arch/x86/realmode/rm/bioscall.o: missing .note.GNU-stack
> >   section implies executable stack
> >   ld: NOTE: This behaviour is deprecated and will be removed in a future
> >   version of the linker
> >
> > The object files producing these all happen to be out of line assembler
> > sources (*.S files).
> >
> > Generally, we would like to avoid the stack being executable. Because
> > there could be a need for the stack to be executable, assembler sources
> > have to opt-in to this security feature via explicit creation of the
> > .note.GNU-stack feature (which compilers create by default) or command
> > line flag --noexecstack.
> >
> > Boot tested defconfig and i386_defconfig in QEMU. If any assembler
> > sources do require executable stack, they can be built with
> > -Wa,--execstack, though the linker warning would have to be disabled. We
> > might need to extend this more generally to the top level Makefile for
> > all architectures, but I'm not equipped to test the result of such a
> > change.
> >
> > LLVM's LLD linker defaults to -z noexecstack, so this flag isn't
> > strictly necessary when linking with LLD, only BFD, but it doesn't hurt
> > to be explicit here for all linkers IMO.
> >
> > Link: https://lore.kernel.org/linux-block/3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk/
> > Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
> > Link: https://github.com/llvm/llvm-project/issues/57009
> > Reported-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> FWIW, this warning appears for other architectures, as I have seen it
> with powerpc and s390 and there is also a patch for ARM:
>
> https://lore.kernel.org/20220721204709.445216-1-ben-linux@fluff.org/
>
> Perhaps this should be done for all architectures in the main Makefile?

Thanks for the link; I recall Ard mentioning the ELF segments are
ignored by the kernels loader in another thread.

Perhaps we should be adding
--no-warn-execstack
wrapped in an ld-option check to KBUILD_LDFLAGS at the top level?

>
> > ---
> >  arch/x86/Makefile                 | 2 ++
> >  arch/x86/boot/Makefile            | 2 +-
> >  arch/x86/boot/compressed/Makefile | 2 +-
> >  arch/x86/realmode/rm/Makefile     | 2 +-
> >  4 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 7854685c5f25..571546775725 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -159,6 +159,8 @@ else
> >          KBUILD_CFLAGS += -mcmodel=kernel
> >  endif
> >
> > +KBUILD_AFLAGS        += -Wa,--noexecstack
> > +
> >  #
> >  # If the function graph tracer is used with mcount instead of fentry,
> >  # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
> > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> > index b5aecb524a8a..d7f2130f2277 100644
> > --- a/arch/x86/boot/Makefile
> > +++ b/arch/x86/boot/Makefile
> > @@ -67,7 +67,7 @@ targets += cpustr.h
> >  # ---------------------------------------------------------------------------
> >
> >  KBUILD_CFLAGS        := $(REALMODE_CFLAGS) -D_SETUP
> > -KBUILD_AFLAGS        := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> > +KBUILD_AFLAGS        := $(KBUILD_CFLAGS) -D__ASSEMBLY__ -Wa,--noexecstack
> >  KBUILD_CFLAGS        += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> >  KBUILD_CFLAGS        += -fno-asynchronous-unwind-tables
> >  GCOV_PROFILE := n
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 19e1905dcbf6..1587a21a132d 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -57,7 +57,7 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
> >  # that the compiler finds it even with out-of-tree builds (make O=/some/path).
> >  CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
> >
> > -KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> > +KBUILD_AFLAGS        := $(KBUILD_CFLAGS) -D__ASSEMBLY__ -Wa,--noexecstack
> >  GCOV_PROFILE := n
> >  UBSAN_SANITIZE :=n
> >
> > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> > index 83f1b6a56449..5f2fdafaa034 100644
> > --- a/arch/x86/realmode/rm/Makefile
> > +++ b/arch/x86/realmode/rm/Makefile
> > @@ -73,7 +73,7 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
> >
> >  KBUILD_CFLAGS        := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
> >                  -I$(srctree)/arch/x86/boot
> > -KBUILD_AFLAGS        := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> > +KBUILD_AFLAGS        := $(KBUILD_CFLAGS) -D__ASSEMBLY__ -Wa,--noexecstack
> >  KBUILD_CFLAGS        += -fno-asynchronous-unwind-tables
> >  GCOV_PROFILE := n
> >  UBSAN_SANITIZE := n
> > --
> > 2.37.1.559.g78731f0fdb-goog
> >



-- 
Thanks,
~Nick Desaulniers
