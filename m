Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C55424CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392429AbiFHB54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588582AbiFGXys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F41B828A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:43:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w20so8999817lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsJ4E/n6E6WEYC3xGqcJLEMCmh5wzfUdFOjfQObwoo0=;
        b=MiLDd7q0UzhgPqtULsC28miEBwaRcoPU5dgYwC8Vnb3XkpW6tvL29D9H61eOW5mkU7
         RtydIL+wpjs3qQwcBNDZrTRSNEfNeLR4ECa2gln2u/GCeQgaBoKORAuAN3akCT3pUIce
         C04A4X1xY6BG5tDDEXmSV3c8OFFspxcjkkWOk+yUJRtgKYgQ/Ph5TrkL2THDj6D42B2H
         TscnQy/usJ58iOhHOuoDeeOFTvps9u8Wz4RdtyK4cCwu6zLxdOFGOxrTBp7Se+/r2EkI
         XzYlUI/kTG5IP2+O0uu8+suzgo4VnVGpttk/9STP++GmrvKOp17sZojssv7ryL6Edcqu
         fOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsJ4E/n6E6WEYC3xGqcJLEMCmh5wzfUdFOjfQObwoo0=;
        b=lnjJ9gV4iRCWNLTuMfZFmSozubQ1ENbYiy4vNjc5Vvt7NXIrAXtiHaL+ewN46ugc2x
         5VrLC/7pQeqsCtPPZbdRND6MfpQyTv/HVIQsfNIsMKxsV3Gv6iy8YrIENzre/xm8wl5G
         oYR7T6Qew1B92edu4shiTaKM74fQpcB3gB44QKRH7wNq06ywH2pg0Gn1S6suZv3nH2qL
         PJW38fgeMnbgvw6U/eUvzBKVek7a2vWSKzmXzRYTK3wLZy8SJo8gsF7SwJrcBMxeFeJM
         Xg8tPcZ4QGgXTPEFEVA/BA9EqQGBkuFrNty72VEKzFgxQzkyMKJODOYrhAHMF+ZNsjcm
         3nwg==
X-Gm-Message-State: AOAM5309eiQZPLnsjtxqVerFOgBYuuBfkWma4bRV0yFBNLlAjI48JCLC
        3X3e4/EzIXzSrZDMSsISAxYBHsH+UnaMFmI5Xhgfvg==
X-Google-Smtp-Source: ABdhPJxMSdiKma4gy0XJ31Ei7YNJtDAZetRdNPGU1knDY0iRcPr5fqk/dczy94U1kwwpxw5G9qq8r/um7sgG9zZftLI=
X-Received: by 2002:a05:6512:3f94:b0:478:7abe:de4a with SMTP id
 x20-20020a0565123f9400b004787abede4amr54365154lfa.401.1654645423956; Tue, 07
 Jun 2022 16:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220607222006.22719-1-jstitt007@gmail.com> <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
 <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com> <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org>
In-Reply-To: <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 16:43:32 -0700
Message-ID: <CAKwvOd=KxY5PBgedkerrL_3BAV_ri8N4F-=piJ6tQXHwFDSr3g@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16 conditional
To:     Andrew Morton <akpm@linux-foundation.org>,
        Justin Stitt <jstitt007@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Richard Smith <richardsmith@google.com>
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

On Tue, Jun 7, 2022 at 4:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 7 Jun 2022 15:42:56 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > On Tue, Jun 7, 2022 at 3:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue,  7 Jun 2022 15:20:06 -0700 Justin Stitt <jstitt007@gmail.com> wrote:
> > >
> > > > if __HAVE_BUILTIN_BSWAP16__ is defined then __swab16 utilizes a __u16 cast.
> > > > This same cast should be used if __HAVE_BUILTIN_BSWAP16__ is not defined as
> > > > well. This should fix loads (at least a few) clang -Wformat warnings
> > > > specifically with `ntohs()`
> > > >
> > > > ...
> > > >
> > > > --- a/include/uapi/linux/swab.h
> > > > +++ b/include/uapi/linux/swab.h
> > > > @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
> > > >  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> > > >  #else
> > > >  #define __swab16(x)                          \
> > > > -     (__builtin_constant_p((__u16)(x)) ?     \
> > > > +     (__u16)(__builtin_constant_p((__u16)(x)) ?      \
> > > >       ___constant_swab16(x) :                 \
> > > >       __fswab16(x))
> > > >  #endif
> > >
> > > More explanation, please?  Both ___constant_swab16() and __fswab16()
> > > return __u16, so why does this patch have any effect?
> > >
> >
> > See this example:
> > https://godbolt.org/z/fzE73jn13
> > And the ImplicitCastExpr nodes adding to the AST:
> > https://godbolt.org/z/oYeYxYdKW
> >
> > Both the second and third operand are promoted to int.
> >
> > C11: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
> >
> > 6.5.15/5
> > >> If both the second and third operands have arithmetic type, the result type that would be determined by the usual arithmetic conversions, were they applied to those two operands, is the type of the result.
> > 6.3.1.8/1
> > >> Otherwise, the integer promotions are performed on both operands.
> > 6.3.1.1/2
> > >> If an int can represent all values of the original type (as restricted by the width, for a bit-field), the value is converted to an int; otherwise, it is converted to an unsigned int. These are called the integer promotions.
>
> Geeze.  Can we please turn this into English and add it to the changelog?
>
> Is it saying that an expression
>
>         int ? u16 : u16
>
> has type int?

Yep.

> Or something else?

Technically, the `int` in your example (the first operand) doesn't
matter. Could be a `long long` or a `char` and it would not matter.

> What did we do wrong here and is it

Perhaps the simplest English explanation would be "ternary expressions
with then/else clauses with types smaller than int undergo implicit
promotion to int."

> possible to correct our types rather than adding a cast?

I think the cast is the explicit cast back to __u16 way to go here,
IMO.  I don't think anything within the ternary could be changed to
avoid implicit promotions.


Justin, can you please send a v2 removing the casts withing
__builtin_constant_p (as in the diff I posted previously in this
thread) and with the below text added to the commit message:

Ternary expressions with then/else clauses with types smaller than int
undergo implicit promotion to int. Cast the result of the ternary back
to the expected __u16 to match the type when __HAVE_BUILTIN_BSWAP16__
is defined.

Also remove pointless casts within __builtin_constant_p argument lists.
--
Thanks,
~Nick Desaulniers
