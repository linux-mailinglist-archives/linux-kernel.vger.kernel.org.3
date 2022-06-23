Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57420558BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiFWXdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiFWXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:33:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F55639F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:33:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a2so1566022lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5t2HdHgbQDM3fVs9f9inVKfPOgEozAtWYglMYVXHeo=;
        b=RuFxaVmx5XYRY5cqHS6MXL8FQOv9P3Qc6bXQm6YEdOifK6a/lTAFCGFL2J4ATAQQFY
         lwCKS6zC7RJM/DUvxNJJCHOVPnF/6IJjID28NEl412feqsYv1uZFexivMdsdVa+7tn2X
         MGMfYO0AbTXmbcfSxsQPuGgp2ZmB8OmFzHZSms9FbzYCu1SojnuuERyeWei46ML1VAnI
         f5+edDfn3TD/BIFurtpH6q80H076WYN2G7TkGUjrLTpAyNcYDfaVP63FXe76kdTu9nr2
         KhrmWXUNpaXlUGfWHxfTczNfXxGUYutkiGRxGjmVn9kcsMYI2nS4Wkona1TX4gvI67M/
         gwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5t2HdHgbQDM3fVs9f9inVKfPOgEozAtWYglMYVXHeo=;
        b=kw8kNB15iC7lTM5PGSm1K6A8T3t3mOG85ka9bROCwY+I2+ttSC/9fIRyvYxhlpJW05
         Est68HEtwsTL0lB22mlqBx32WCo0+YjYv65qzJXs/I26HZfAnC+1EDrGNfA7OGH985up
         140a2L1kOlK3mhLCnsDECe4rHuqX6J3gQkvoaqN4v/C35zS7OpQ9ur3/Y0ukGCo8W1U4
         phUwffOv7/AujbooeFa/VoFlRv3xBQN2nXH4bzAkM9H1ZgtZwrt54IPjyT61tImFlWzY
         eftWJ0DGUeNQ58E4oEaD2Je+KEhTo9fAmVZ3O2sKxAkKwIVt6SqKXjVMHRi7XyANNb1t
         N17A==
X-Gm-Message-State: AJIora9yqepTKw+oQl5kN5Do6LbPCALJoO6U1Gy6QZEvmYJXJG1qzrCU
        8NVv4MtNuvF24MGINDUts8RSJAQuXDwcO2maRS8mrA==
X-Google-Smtp-Source: AGRyM1uUYWe4B92qbAxaSPcEuzt1Jad6zUUVtzIlYMTYhqB8ii9Dkg/YbHjka/rpdX0fYjsiE40wpIwNUslwOZjEXpY=
X-Received: by 2002:a05:6512:3f9f:b0:47d:c87e:f8f3 with SMTP id
 x31-20020a0565123f9f00b0047dc87ef8f3mr6953750lfa.401.1656027227275; Thu, 23
 Jun 2022 16:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X> <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian> <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
In-Reply-To: <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Jun 2022 16:33:35 -0700
Message-ID: <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, Jun 22, 2022 at 3:40 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jun 22, 2022 at 10:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Jun 22, 2022 at 12:26 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Tried it after applying your patch. There was no build failure, but some warnings:
> >
> > So some of those objtool warnings are, I think, because clang does odd
> > and crazy things for when it decides "this is not reachable" code.
> >
> > I don't much like it, and neither does objtool, but it is what it is.
> > When clang decides "I'm calling a function that cannot return", it
> > will have a "call" instruction and then it will just fall off the face
> > of the earth after that.
> >
> > That includes falling through to the next function, or just to random
> > other labels after the function, and then objtool as a result
> > complains about a stack state mismatch (when the fallthrough is the
> > same function, but now the stack pointer is different in different
> > parts), or of the "falls through to next function".
> >
> > I think it's a clang misfeature in that if something goes wrong, you
> > basically execute random code. I'd much rather see clang insert a real
> > 'ud' instruction or 'int3' or whatever. But it doesn't.
>
> So adding `-mllvm -trap-unreachable` will turn these
> `__builtin_unreachable()`'s into trapping instructions.  I think we
> should just do that/enable that in the kernel.  The following patch
> eliminates ALL of the fallthrough warnings observed from objtool on
> x86_64 defconfig builds.
>
> ```
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 87285b76adb2..1fbf8a8f3751 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -36,6 +36,7 @@ endif
>  # so they can be implemented or wrapped in cc-option.
>  CLANG_FLAGS    += -Werror=unknown-warning-option
>  CLANG_FLAGS    += -Werror=ignored-optimization-argument
> +CLANG_FLAGS    += -mllvm -trap-unreachable
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  export CLANG_FLAGS
> ```
>
> There's more I need to do for LTO; `-mllvm` flags need to be passed to
> the linker in that case.  Let me do a few more builds, collect
> statistics on build size differences (guessing neglidgeable), then
> will send out a more formal patch.

Looks like these are actually from calls to
__ubsan_handle_divrem_overflow which is __noreturn when panic_on_warn
is set by the corresponding config.  I wonder if we should be
unconditionally adding __ubsan_handle_divrem_overflow to the allow
list `global_noreturns` in tools/objtool/check.c?  It seems like the
kconfig defines aren't passed through to the tools/ sources.

List of fallthrough warnings from allmodconfig for reference:
https://lore.kernel.org/lkml/YrNQrPNF%2FXfriP99@debian/

--
Thanks,
~Nick Desaulniers
