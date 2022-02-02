Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFEC4A79FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiBBVFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiBBVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:05:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F477C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:05:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p27so1659831lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztwY6ZBrZWpUqw+CT19celenou/iYkz97B3fc17u3eY=;
        b=JVtD8pcgXI9UkJjqKAVeuKawKZbY8m7XmN54kAhK4DD9UcjWcriaZ5t7TZgBO9jjGX
         83IChvWtzGejLjTZpiIhzpUUZmxd+DsMpT4WpjqHG84T9s0mHy3rWlvneH5jFclfnwn8
         yvSzw29bXQI/WiKTNDHYe563YzUHcmyX/aFOrtvVAw7GA2s9NuIffS23BqB5CLTxD+HV
         j0EsNPLSD1i3wOhPhLdkvXWGsKWYb1eG6xxzxpT1UZ0Yny8axatlh/W3sOhvLdwJ1hmf
         E23I+AhsZxLIl71IoHjra9YVhKemDmzTggXEB5rTNYRyDg4lLersUW+PQN2ksPK9Xvwu
         y97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztwY6ZBrZWpUqw+CT19celenou/iYkz97B3fc17u3eY=;
        b=pKDHkccdBZz8KSFhmKE9XxF0Vgz2sZkbPRSxNwyzJ6EV71yiBsi8ofYnbwJO/vK5SJ
         cCc/yKkmZ/K95PzcxGrjzUybvDzEmmMPDIOq2o+9YNrd9eO6FGirMZ7f9rnLL9YzZO98
         mDP1/5icwsXQa8+X70pJGojV+lWIFfa4WcXKNOkcSpnPTY9WAJRjaZIcZNflKNob+8pd
         wkNG5dm2HGUPVOTwjdF5jeLasjUIU+UoCv5kILB4n83DErTZxhr+aHXHFPE+qDmtvQIb
         jVk2T/pRcAo0j+LTD1E8lqWOoai5EX3eNKqosZXG3kuq30Sm6ad6HL+iWkg9jBtbpcgA
         iFZA==
X-Gm-Message-State: AOAM530TUiKD5qIPWz8fXn+BhaSPHEk3tFClNPKVUO5y/QG3iktOrf35
        XvkpQ3P7ehH2LGVr4p5yXN/5DvpLRQkEvVpwnI8h1N3Q/pjWxQ==
X-Google-Smtp-Source: ABdhPJyvqsHNkbdeLA89mOkNNuBDEKYQeYaofCnX76uReVYdPyIgqNbJ4k9f43F7nHdEn7zpvUFKBrgV9AJZwIyxlAY=
X-Received: by 2002:ac2:5510:: with SMTP id j16mr23982724lfk.240.1643835905209;
 Wed, 02 Feb 2022 13:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Feb 2022 13:04:52 -0800
Message-ID: <CAKwvOd=h7NLaqtRwA3FTsq_T-=_0XKL0GRA49CRg5F19m=7xPg@mail.gmail.com>
Subject: Re: [PATCH] include: drop pointless __compiler_offsetof indirection
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 2:21 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> (1) compiler_types.h is unconditionally included via an -include
> flag (see scripts/Makefile.lib), and it defines __compiler_offsetof
> unconditionally. So testing for definedness of __compiler_offsetof is
> mostly pointless.
>
> (2) Every relevant compiler provides __builtin_offsetof (even sparse
> has had that for 14 years), and if for whatever reason one would end
> up picking up the poor man's fallback definition (C file compiler with
> completely custom CFLAGS?), newer clang versions won't treat the
> result as an Integer Constant Expression, so if used in place where
> such is required (static initializer or static_assert), one would
> get errors like
>
> t.c:11:16: error: static_assert expression is not an integral constant expression
> t.c:11:16: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
> t.c:4:33: note: expanded from macro 'offsetof'
> #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
>
> So just define offsetof unconditionally and directly in terms of
> __builtin_offsetof.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/compiler_types.h | 2 --
>  include/linux/stddef.h         | 6 +-----
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3c1795fdb568..83ee7f7ada5d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -137,8 +137,6 @@ struct ftrace_likely_data {
>   */
>  #define __naked                        __attribute__((__naked__)) notrace
>
> -#define __compiler_offsetof(a, b)      __builtin_offsetof(a, b)
> -
>  /*
>   * Prefer gnu_inline, so that extern inline functions do not emit an
>   * externally visible function. This makes extern inline behave as per gnu89
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index ca507bd5f808..929d67710cc5 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -13,11 +13,7 @@ enum {
>  };
>
>  #undef offsetof
> -#ifdef __compiler_offsetof
> -#define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
> -#else
> -#define offsetof(TYPE, MEMBER) ((size_t)&((TYPE *)0)->MEMBER)

RIP `((size_t)&((TYPE *)0)->MEMBER)`; you were beautiful in a way only
a mother could love.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> -#endif
> +#define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
>
>  /**
>   * sizeof_field() - Report the size of a struct field in bytes
> --
> 2.31.1
>


-- 
Thanks,
~Nick Desaulniers
