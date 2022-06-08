Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D7543CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiFHTfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFHTfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:35:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8720A739
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:35:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c30so7250398ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5G4Fbpw7okaDvJbNf0MUPyOzWFJdsVep+P+r/ikKsg=;
        b=e6MlxKPNbaQV4c4Oo53CyLESL6PSi5lSi46bOHBKBNvjX7e5Kphi0hmQokyPRJxAHs
         avoNesKdfLcgD4ut3r6If0laOOrw+zL2Oh9bpPwSVYsIeyOutzFB6elsI8iheEJghu2b
         aAfhHtH2KFgZ2MfHA+woAIYo8fondvI7mlhWwEXsFeK84ciyLYX76HYY53hsMOgYcuXC
         pwbkY+dv241fFgmbMkV2AD90dSMJQFyo696Uv7f7mwT4ejIUjP36UtTS9afYnDIIpefV
         CNt8MEu/zhuKsNW7At8b0azUSJw7hIayNdrenx8WkuzBAdozllkbnUbVXGvCoPH7DxGu
         uz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5G4Fbpw7okaDvJbNf0MUPyOzWFJdsVep+P+r/ikKsg=;
        b=T1OofxfGwWYiVNBzPOnZf5Sf53HIA/YfmYK09iGT7y5PCIkNjfWClDxaiKfnzaJR6z
         /0EfMUgxf3n50xbyDh/EPNWO/xxh1xqb4faCd0FLwOHhKxoBkEf2RCo+gKOdLp+3idBu
         SVK73cNMfih2j4JjveNnytmZEW92wGAdSHbcHo8a5yCy8rQnwKLfaWiYCw5UH/B6hav2
         IDp58rjJbzl6JGGDa+VSgwKR3KCEEDwTp3fZ2DQSq5JtGGRBvWMbzvDVvkHtR1ehYkLR
         PPbciAYf73iX8xjVLx07INPujZLbW7rnpJzrKCjBFrj2DrIDFmQ9s0kaPAILTrbPdcDE
         SxpQ==
X-Gm-Message-State: AOAM532XIHD1OsKfHxXvt4zyMeE4e22ATYi70pa8IUhvpu5osiKyC2Pa
        f1g6CavzCwqfdP0B87ScYfylM/WZBq6KeIhnjPkkO9FywEGSjA==
X-Google-Smtp-Source: ABdhPJwbJnHAdMV0IB/VPzx2hwY+/y+dUcwA0O9PFdif5ICszkdwEtpDKgAA2Pd14WKKHoo69GKiOtz7wz6Gs5eCUgI=
X-Received: by 2002:a2e:8715:0:b0:255:a7e5:d50d with SMTP id
 m21-20020a2e8715000000b00255a7e5d50dmr6419645lji.26.1654716939750; Wed, 08
 Jun 2022 12:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220607222006.22719-1-jstitt007@gmail.com> <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
 <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com>
 <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org> <YqArhaiEu+6YWZfg@zeniv-ca.linux.org.uk>
In-Reply-To: <YqArhaiEu+6YWZfg@zeniv-ca.linux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Jun 2022 12:35:27 -0700
Message-ID: <CAKwvOdnSSY0jexXioDTZOWSTi0fkaudZbgSjigPr5uzTRmA_Rg@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16 conditional
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Justin Stitt <jstitt007@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Richard Smith <richardsmith@google.com>
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

On Tue, Jun 7, 2022 at 9:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jun 07, 2022 at 04:21:28PM -0700, Andrew Morton wrote:
>
> > > 6.5.15/5
> > > >> If both the second and third operands have arithmetic type, the result type that would be determined by the usual arithmetic conversions, were they applied to those two operands, is the type of the result.
> > > 6.3.1.8/1
> > > >> Otherwise, the integer promotions are performed on both operands.
> > > 6.3.1.1/2
> > > >> If an int can represent all values of the original type (as restricted by the width, for a bit-field), the value is converted to an int; otherwise, it is converted to an unsigned int. These are called the integer promotions.
> >
> > Geeze.  Can we please turn this into English and add it to the changelog?
> >
> > Is it saying that an expression
> >
> >       int ? u16 : u16
> >
> > has type int?  Or something else?  What did we do wrong here and is it
> > possible to correct our types rather than adding a cast?
>
> Not quite.  Same rules as u16 + u16 - on architectures where int is wider
> than 16 bits it's (int)u16 + (int)u16 and yields int, on 16bit ones it's
> (unsigned int)u16 + (unsigned int)u16 and yields unsigned int.
>
> You *can't* get smaller-than-int out of ? :, same as you can't get it
> out of addition, etc.

Exactly, and well put. More concise than I was able to express.  I
think that description will satisfy Andrew's request for additional
context, so I'll recommend Justin add a blurb derived from what you
said when sending a v3.

>
> __builtin_choose_expr() would do it, but I would take a cast over that
> ugliness.
>
> FWIW, it might make sense for clang to keep track of the following
> property: expression has the same value as it would if integer promotions
> in it had been replaced with integer promotion of result.

I'm not sure that's precisely the same issue here.

The issue we're facing is more so that `ntohs` is being used in
printf-like expressions; clang's -Wformat warns about default argument
promotion so we need to clean up cases where smaller-than-int format
flags are being used for promoted-to-int params.  While looking at
that, Nathan noticed that __swab16 will return either a __u16 or an
int based on whether __HAVE_BUILTIN_BSWAP16__ is defined, which
depends on BOTH the compiler being used and target architecture.  This
patch from Justin just cleans that up.

>
> Example: with
>         unsigned short x, y, mask;
>
> expresion "x & y" is interpreted as and_int((int)x, (int)y), which is equal
> to (int)and_u16(x, y), so that expression has the property in question.
> "x != 12 ? x : y" has the same property.  "x + y", OTOH, doesn't - if x and y
> are both 32768, x + y is add_int((int)x, (int)y), i.e. 65536, while
> (int)add_u16(x, y) would be 0.
>
> For a somewhat more subtle example,
>         (x & ~mask) | (y & mask)
> is interpreted as
>         or_int(and_int((int)x, not_int((int)mask)), and_int((int)y, (int)mask))
> which is equal to
>         (int)or_u16(and_u16(x,not_u16(mask)), and_u16(y, mask))
> IOW, the property in question holds for that one, despite having a subexpression
> (~mask) that does *NOT* have that property.  (int)not_u16(0) is 0xffff and
> not_int((int)0) is (assuming 32bit int) 0xffffffff.  Upper 16 bits get fouled;
> applying & with known-16bit launders them off...
>
> That predicate is behind the handling of small bitwise types in sparse;
> otherwise all operations on __be16 would trigger warnings due to promotions
> from __be16 to int.  And aforementioned subtle example is common enough, so we
> had to deal with it.  See commit d24967cb847b "[PATCH] handle fouled-bitwise"
> in sparse git...

https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=d24967cb847b7a04920698a9053ea8195046a831
(For others' reference)
-- 
Thanks,
~Nick Desaulniers
