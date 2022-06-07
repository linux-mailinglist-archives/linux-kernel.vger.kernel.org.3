Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94F5422D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiFHByn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586687AbiFGXvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:51:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA228DC2D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:43:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b12so9817041ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt01xp86lqL0/6AjJBope1HTOp03keAnvABg9sLTIEA=;
        b=UHgsazWQmeU1NR6jOOBK0qGzfYbJQXzgSI0eKTHcQO2WAP2crTBr7b/+hBIGmTkWET
         eaeI8PxMo/qMYOJQXvc79Tax4fvqB0zsF+dnhvp4wvLkdHT+KEcQKEYIfyO6dFWS9JAk
         xRe7n/80iXhEW4gCXmy1KpD6JnslfRdVAmFamIl+GjL5w9+W5S5MLB4lQcEzMogc0Sfh
         XF4cvnKjdp6lsHLn/Ker4XPQosO2YPJrCGThRBO0DzyMVpLbyoF0wXM1YwginkQVcP8F
         /ZZtlzXQ6YTWAFzzAeIAaFQH3KIVYsMJh1sMGwJ4CQuqeG6GQ6F82L83ujInHYVddxlK
         ASIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt01xp86lqL0/6AjJBope1HTOp03keAnvABg9sLTIEA=;
        b=rAlajgo9yYsvY+YbeM1h2VwNEpoiLuZL/7D5IPDAli7kZ3SV4eq4VQt4NdsJuVPDqN
         enQqyuwyeegt9tVyDCiiXy3VLTNNRbhccefrj59zfviSvgbM76QFoQvOD4sOn7/ixVe9
         pibL1PulNQTwIBaa26aCyrmQugquYQvljIyFVQy3fkRpUnbnOnB7EbE4ED8/dxWDVrSP
         wPwCjKRfhEF7gs7BUa3ullDpZ8ASZiX46l6HpegM1BKcJbmhmj7fe74b0Zh7IjJOu+cH
         tO7YJRFMcW1cnwpULimH2yNCbEAdHdIvfPafq2sw7LlE4eheEo1HMHsjRYZpzLehvnP9
         Pjrw==
X-Gm-Message-State: AOAM530kAKqJuyoZY2+Todwyyu/S4JYDrrfX3EWC0SCr0Vy6mTYbd7zG
        KKXfpLUPWwWE3G2uTPhGGSXlJVQ0h8ql7H+Bv07pMA==
X-Google-Smtp-Source: ABdhPJylrRmI3sSEhsMpeXgzL2yRHODPE01/WwB6x35Xdnj/KDNkuNvsOgTE/u/vqpRRU0mPfqaMth+nqrwqFZ6C8Sc=
X-Received: by 2002:a2e:8e98:0:b0:255:9d3d:bac3 with SMTP id
 z24-20020a2e8e98000000b002559d3dbac3mr6176311ljk.103.1654641788193; Tue, 07
 Jun 2022 15:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220607222006.22719-1-jstitt007@gmail.com> <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
In-Reply-To: <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 15:42:56 -0700
Message-ID: <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16 conditional
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Justin Stitt <jstitt007@gmail.com>,
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

On Tue, Jun 7, 2022 at 3:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  7 Jun 2022 15:20:06 -0700 Justin Stitt <jstitt007@gmail.com> wrote:
>
> > if __HAVE_BUILTIN_BSWAP16__ is defined then __swab16 utilizes a __u16 cast.
> > This same cast should be used if __HAVE_BUILTIN_BSWAP16__ is not defined as
> > well. This should fix loads (at least a few) clang -Wformat warnings
> > specifically with `ntohs()`
> >
> > ...
> >
> > --- a/include/uapi/linux/swab.h
> > +++ b/include/uapi/linux/swab.h
> > @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
> >  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >  #else
> >  #define __swab16(x)                          \
> > -     (__builtin_constant_p((__u16)(x)) ?     \
> > +     (__u16)(__builtin_constant_p((__u16)(x)) ?      \
> >       ___constant_swab16(x) :                 \
> >       __fswab16(x))
> >  #endif
>
> More explanation, please?  Both ___constant_swab16() and __fswab16()
> return __u16, so why does this patch have any effect?
>

See this example:
https://godbolt.org/z/fzE73jn13
And the ImplicitCastExpr nodes adding to the AST:
https://godbolt.org/z/oYeYxYdKW

Both the second and third operand are promoted to int.

C11: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf

6.5.15/5
>> If both the second and third operands have arithmetic type, the result type that would be determined by the usual arithmetic conversions, were they applied to those two operands, is the type of the result.
6.3.1.8/1
>> Otherwise, the integer promotions are performed on both operands.
6.3.1.1/2
>> If an int can represent all values of the original type (as restricted by the width, for a bit-field), the value is converted to an int; otherwise, it is converted to an unsigned int. These are called the integer promotions.
-- 
Thanks,
~Nick Desaulniers
