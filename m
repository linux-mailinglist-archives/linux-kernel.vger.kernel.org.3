Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC8A5200A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiEIPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiEIPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:04:56 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32E15710
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:00:59 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f7b815ac06so147740837b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNn5pADeSTEeIqgaMpExgJfErrD9ld+adA+VZngH5Qk=;
        b=EYKTrdCktjaN+OPNJLxCktWADLAsYB1EjQKQFnHfYnjc0/zEx5rcuj0MAnilmGRoKd
         hOfc5w2J9oLJqoO3uUfaiWP83mVXmI4oGrx0DZ6QPYEjjfgD9wHAtiiw/W4G4d3qywZP
         Dd9v3SPIOET7TXgnBjRrn85Iq71Op8Dxcsf4fI4sGnasJkpYDGfKlQ34VN3xwqRapyne
         H1coiRRiHPhR5ubAUyW7UJcs/Dbs+o+h2LdiFDlqRWPN8zW2k0PUi3Agh4I66JtYZa3M
         dgirn6p8mSYKB+hMu5Q6wYgO5v7hBOxL6zk0X6ymMdNYQl+sTppcJIWY66r0X+cdxBt3
         fwcg==
X-Gm-Message-State: AOAM530f/uHb3oa4YjqGpDWCKQEOu7Zi83gkJiR7NPBIAMqDB01kV5I2
        XtbZX6FDhjav11zgvhd0K+BFcy/tMSyv7NKLiQQ=
X-Google-Smtp-Source: ABdhPJyUY4icHT63L6LWy80zsvn+CHkz/Ny7UxZ9DY8uY29DUI2O7NtRvr2guftQozVuG55DmBrb/jwCYyzLZYw2AOc=
X-Received: by 2002:a81:34f:0:b0:2f7:bbb1:1576 with SMTP id
 76-20020a81034f000000b002f7bbb11576mr14564264ywd.45.1652108459058; Mon, 09
 May 2022 08:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr> <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
 <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com> <YnhXgzhghfi17vMX@dev-arch.thelio-3990X>
In-Reply-To: <YnhXgzhghfi17vMX@dev-arch.thelio-3990X>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 10 May 2022 00:00:48 +0900
Message-ID: <CAMZ6RqL7543LFU7ywbr-FV9A3n+m7zNy-J00j=ZrNMkDonq2aw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 9 May 2022 at 08:51, Nathan Chancellor <nathan@kernel.org> wrote:
> On Sun, May 08, 2022 at 09:37:14PM +0900, Vincent MAILHOL wrote:
> > Hi Arnd,
> >
> > +CC: Kees Cook
> >
> > On Sun. 8 May 2022 at 19:27, Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Sun, May 8, 2022 at 12:09 PM Vincent Mailhol
> > > <mailhol.vincent@wanadoo.fr> wrote:
> > > >
> > > > Aside of the __builtin_foo() ones, x86 does not directly rely on any
> > > > builtin functions.
> > > >
> > > > However, such builtin functions are not explicitly deactivated,
> > > > creating some collisions, concrete example being ffs() from bitops.h,
> > > > c.f.:
> > > >
> > > > | ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
> > > > |   283 | static __always_inline int ffs(int x)
> > > >
> > > > This patch adds -fno-builtin to KBUILD_CFLAGS for the x86
> > > > architectures in order to prevent shadowing of builtin functions.
> > > >
> > > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > ---
> > > > FYI, I tested this patch on a "make allyesconfig" for both x86_32 and
> > > > x86_64.
> > > >
> > > > This is a resend. Only difference is that I dropped the RFC flag and
> > > > added Arnd in CC because he did a similar patch to fix ffs shadow
> > > > warnings in the past:
> > > >
> > > > https://lore.kernel.org/all/20201026160006.3704027-1-arnd@kernel.org/
> > >
> > > I think this is a correct change, but unfortunately it exposes a clang bug
> > >  with -mregparm=3. Nick should be able to provide more details, I think
> > > he has a plan.
> >
> > Interesting. I admittedly did not do extensive tests on clang
> > but I would have expected the Linux kernel bot to have warned me
> > on my previous patch.
> >
> > I did research on mregparm and clang. I found this thread:
> > https://lore.kernel.org/r/20220208225350.1331628-9-keescook@chromium.org
> >
> > and the associated LLVM issue:
> > https://github.com/llvm/llvm-project/issues/53645
> >
> > Those threads mention that some clang builtins become unusable
> > when combining -mregparm=3 and -m32. But I could not find a
> > bug reference about -mregparm=3 and -fno-builtin combination.
> >
> > Could you just double confirm that you indeed saw the issue with
> > -fno-builtin? If that the case, I am really curious to get the
> > details :)
>
> -ffreestanding implies -fno-builtin; removing -ffreestanding from
> arch/x86/Makefile for 32-bit x86 caused the problem so I don't think
> that your patch would cause any issue but I could be missing something.
>
> However, doesn't -fno-builtin remove the ability for GCC and clang to
> perform certain libcall optimizations? I seem to recall this coming up
> in previous threads but I am having a hard time finding the exact
> language that I was looking for.

I was not aware. I did the test with a dummy memset implementation:

| void foo(char *s, unsigned int count)
| {
|     while (count--)
|         *s++ = 0;
| }

Before this patch (i.e. with builtins), GCC does this:

| foo:
|     testl    %esi, %esi    # count
|     je    .L7    #,
|     pushq    %rbp    #
|     movl    %esi, %edx    # count, count
|     xorl    %esi, %esi    #
|     movq    %rsp, %rbp    #,
|     call    memset    #
|     popq    %rbp    #
|     ret
| .L7:
|     ret

Here, we can clearly see that the function is optimized to a call
to memset.

After this patch (i.e. without builtins), the call disappears:

| foo:
|     testl    %esi, %esi    # count
|     je    .L1    #,
|     movl    %esi, %esi    # count, count
|     leaq    (%rdi,%rsi), %rax    #, _12
| .L3:
|     addq    $1, %rdi    #, s
|     movb    $0, -1(%rdi)    #, MEM[(char *)s_8 + -1B]
|     cmpq    %rax, %rdi    # _12, s
|     jne    .L3    #,
| .L1:
|     ret

So yes, the -fno-builtin will remove the optimizations at least
for GCC (not tested for clang).

> This thread seems to be the most recent
> one that I can remember:
>
> https://lore.kernel.org/CAHk-=whn91ar+EbcBXQb9UXad00Q5WjU-TCB6UBzVba682a4ew@mail.gmail.com/

What is funny is that the thread you are pointing at mostly
complains about the compiler doing optimization in the user's
back.

There will be some cases in which the compiler will find valid
optimizations and some cases it will do some silly
one (e.g. transform a very small loop to a function call). The
problem is to know whether the clever optimizations outweigh the silly
ones or not. I wonder if any benchmark exists on that.

If compiler optimizations are indeed worth it, we should then have
a look at the other architecture which uses the -fno-builtin flag
(or the -ffreestanding).

Regarding this patch, I do not think it should be applied anymore
unless proven that "optimizations" are detrimental and thus
unwanted.

Instead, I am thinking of just using -fno-builtin-ffs to remove
the annoying -Wshadow warning. Would that make more sense?

Thank you.


Yours sincerely,
Vincent Mailhol
