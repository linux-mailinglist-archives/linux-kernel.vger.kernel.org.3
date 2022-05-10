Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E454520A84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiEJBO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiEJBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:14:53 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD41E16
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:10:54 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id v59so28000982ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 18:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pu2anZ+R3B06nqhjgv9ISwTVomKwIVTtmDdQYWCLtaU=;
        b=SBzbIGwpogQjc7IMGMxjUwPJcIQHt3GZd3N3nyAvbiVGChqLplRFXUoE1yQym1UPXB
         ASGMAXbvkzLxER8KdGaoH/ygXeJn5ZoS4BBzbtAGJbH/jh9aagcP52uoALMAp5f4KeQ3
         U4282yK7pydR8J8bLtDiwg39BWZ1yAgyQvpXq9Xr4oR2FRJZCj9ja4aOagMQHIqr3tvI
         Js91IopKS6+Cy49fqkNsNpLqY7dcj0oXxGlPHSTOvtj0QE9JXVeXkoRNBxZUrRVNKvhO
         Xt+h+lTicrLalVat1V4xkdwJVBJApxkRng6TBN1dTO6PiJXVsmFtD+uGdefGWoSgb2Vz
         qOfw==
X-Gm-Message-State: AOAM5307xGmM73jHMnywd633NZw7CRWOA4PONckI+G4ti3UAhW+nw9T4
        4JRMXm+5Zi62gOinS3tksSAP1lkl0F1SgQmItwk=
X-Google-Smtp-Source: ABdhPJxt8ljHX+a7Cku4rMKwAxeR+LFa7WwyvBewPPYp9BYbLUHVF00V/WCIrRFQ9WDFNtfesjm+bdIYzcxLt6dyA0s=
X-Received: by 2002:a5b:491:0:b0:64a:f42f:6973 with SMTP id
 n17-20020a5b0491000000b0064af42f6973mr3469601ybp.20.1652145054084; Mon, 09
 May 2022 18:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr> <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
 <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
 <YnhXgzhghfi17vMX@dev-arch.thelio-3990X> <CAMZ6RqL7543LFU7ywbr-FV9A3n+m7zNy-J00j=ZrNMkDonq2aw@mail.gmail.com>
 <CAKwvOdniSVMOwkBke2EcgONn_Vmv88M+B2FTYL_BKtWawCSLAw@mail.gmail.com>
 <CAMZ6Rq+q44vAeqa7HN8mfoNXzv9GndnQDm1e4_kyMXf_+oADdQ@mail.gmail.com> <CAKwvOdnf5f_eNz0FTiYfUf=TtEqWTZTFNN7UpmH3qCcKQGkkHg@mail.gmail.com>
In-Reply-To: <CAKwvOdnf5f_eNz0FTiYfUf=TtEqWTZTFNN7UpmH3qCcKQGkkHg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 10 May 2022 10:10:43 +0900
Message-ID: <CAMZ6RqLp86ca6s-dO-Zre=PzOLr6JK9qu-8uAxfMym+X0a19yQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 10 May 2022 at 08:26, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Mon, May 9, 2022 at 4:12 PM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > Hi Nick,
> >
> > On Tue. 10 May 2022 at 04:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > On Mon, May 9, 2022 at 8:01 AM Vincent MAILHOL
> > > <mailhol.vincent@wanadoo.fr> wrote:
> > > >
> > > > Instead, I am thinking of just using -fno-builtin-ffs to remove
> > > > the annoying -Wshadow warning. Would that make more sense?
> > >
> > > Perhaps a pragma would be the best tool to silence this instance of
> > > -Wshadow?  I understand what GCC is trying to express, but the kernel
> > > does straddle a weird place between -ffreestanding and a "hosted" env.
> >
> > I was a bit reluctant to propose the use of pragma because I received
> > negative feedback in another patch for using the __diag_ignore()
> > c.f.:
> > https://lore.kernel.org/all/YmhZSZWg9YZZLRHA@yury-laptop/
> >
> > But the context here is a bit different, I guess. If I receive your support, I
> > am fully OK to silence this with some #pragma.
> >
> > The patch would look as below (I just need to test with clang
> > before submitting).
>
> Do you have a sense for how many other functions trigger -Wshadow?

I only witnessed such -Wshadow warnings for ffs().

> For
> example, one question I have is:
> Why does ffs() trigger this, but not any of the functions defined in
> lib/string.c (or declared in include/linux/string.h) which surely also
> shadow existing builtins?  I can't see your example being sprinkled
> all over include/linux/string.h as being ok.

Thanks, you are touching on a really interesting point.

After checking, the other builtin functions declare the function with
two leading underscores (e.g. __foo(...)) and then do:

#define foo(...) __foo(...)

Or alternatively, if using the builtin function:

#define foo(...) __builtin_foo(...)

Compilers do not trigger the -Wshadow for such patterns.

Example with memcpy():
https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/string_64.h#L75

So, in light of your comment doing this would be more consistent:

#define ffs(x) _ffs(x)

> If it's more than just ffs(), perhaps the GCC developers can split the
> shadowing of builtins into a sub flag under -Wshadow that can then be
> disabled; we do want to shadow these functions, but -Wno-shadow would
> miss warnings on variables being shadowed due to scope.
>
> We've done this in the past with various flags in clang. Rather than
> having semantic analysis trigger the same warning flag for different
> concerns, we split the flag into distinct concerns, and reuse the
> original flag as a group that enables the new flags. This gives
> developers fine grain control over enabling/disabling distinct
> concerns.
>
> >
> > diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> > index a288ecd230ab..e44911253bdf 100644
> > --- a/arch/x86/include/asm/bitops.h
> > +++ b/arch/x86/include/asm/bitops.h
> > @@ -269,6 +269,9 @@ static __always_inline unsigned long
> > __fls(unsigned long word)
> >  #undef ADDR
> >
> >  #ifdef __KERNEL__
> > +__diag_push();
> > +__diag_ignore_all("-Wshadow",
> > +                  "-fno-builtin-foo would remove optimization, just
> > silence it instead");
> >  /**
> >   * ffs - find first set bit in word
> >   * @x: the word to search
> > @@ -309,6 +312,7 @@ static __always_inline int ffs(int x)
> >  #endif
> >         return r + 1;
> >  }
> > +__diag_pop(); /* ignore -Wshadow */
> >
> >  /**
> >   * fls - find last set bit in word
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
