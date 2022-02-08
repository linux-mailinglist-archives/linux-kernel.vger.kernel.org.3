Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006064AE55B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiBHXRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBHXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:17:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E2C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:17:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i34so920926lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uV9MHzT3yqaSJ8VvyobC0sdXGQe9fB58ozgnu6xiqyY=;
        b=o9cIyt5bY7tBJycqX+8faJX72GU6lGkN/ohJfrqEdo0bZnpl6VntHVjHKLxO6fpEeS
         iLf8pFroVszcKHeVggFtDlA+/ahQl3iX1R9v4sYDnfrhyannRYLCftIoDkTkZ4LWdZ8e
         eTTW3/lWIDj82yqfzAs6m33+pXHmp+1TZM6C5KQ3xixSli3TEnfD9bLpdm+Ayj3FoQgG
         SA5BZBXbeirjsZcyi7cw5gEhLmJvfNhrSqTn8AVDVcHxUN6yKrr/cwPpVdE+tUgSOeZ5
         eOi3DyPC6N0NZbjqqScdyo/fT+aS95PhLxpARudPtka+wNBCsaFXjp7qXE/MZCXgcaXz
         Yyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uV9MHzT3yqaSJ8VvyobC0sdXGQe9fB58ozgnu6xiqyY=;
        b=assXzxtIvlqevNq55uxSZA5FQqghhxEA+C13h12Vy6YC3k84py+On/L7/UJFop2Zy9
         zW/6EwpPBB6h/2FkEvyQgY/G8N4SakErw+SA7Azjys2Mdpbz2FjGskxw+4IW7jNJ4MB0
         z5daAOx8XtEONkGU/PGPd8hMF4NAYsfzIyA9ea0rXHcUeB83zpGHRYQ2PdIFXpwOP/52
         OvLNbplBJXUhEePNWq+0V+LxT9P+JBVLSh2FMQg6/S8Z5d/g6UaliJqawpBMEqkWGy8o
         De/EwmedYDGbERsvh20TzPPNulNnNgSwtRPzCI7k1schZequabJwgp1FvnCX4ntPpFDQ
         PaFQ==
X-Gm-Message-State: AOAM530m1kZayg9Ah3sFm0erSREPU3T0UBctC2sCQ7qUnf9ehjZRQyTT
        +fDJr6NgNOZ29S3Fcdf+kLA4WEvbJqaY3h5CU4VCXQ==
X-Google-Smtp-Source: ABdhPJzEdVmqLDi7X6N3Z46Ig8r2EtxJrWgkjU4z9gBLfTsztBj2W7LYuSaUTleZLNiFoJLMfZzFlIFwEMqAL3kJPUI=
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr4287394lfk.523.1644362244992;
 Tue, 08 Feb 2022 15:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-8-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-8-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 15:17:13 -0800
Message-ID: <CAKwvOd=wre3uzFVBFaOs4Oud+SobxiW_BwKXMsa5p0tEy6BsiA@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] fortify: Make sure strlen() may still be used as a
 constant expression
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for enabling Clang FORTIFY_SOURCE support, redefine
> strlen() as a macro that tests for being a constant expression
> so that strlen() can still be used in static initializers, which is
> lost when adding __pass_object_size and __overloadable.
>
> An example of this usage can be seen here:
>         https://lore.kernel.org/all/202201252321.dRmWZ8wW-lkp@intel.com/
>
> Notably, this constant expression feature of strlen() is not available
> for architectures that build with -ffreestanding. This means the kernel
> currently does not universally expect strlen() to be used this way, but
> since there _are_ some build configurations that depend on it, retain
> the characteristic for Clang FORTIFY_SOURCE builds too.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index db1ad1c1c79a..f77cf22e2d60 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> +#include <linux/const.h>
> +
>  #define __FORTIFY_INLINE extern __always_inline __gnu_inline
>  #define __RENAME(x) __asm__(#x)
>
> @@ -95,9 +97,16 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
>         return ret;
>  }
>
> -/* defined after fortified strnlen to reuse it. */
> +/*
> + * Defined after fortified strnlen to reuse it. However, it must still be
> + * possible for strlen() to be used on compile-time strings for use in
> + * static initializers (i.e. as a constant expression).
> + */
> +#define strlen(p)                                                      \
> +       __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \

Is `__is_constexpr(p) == __is_constexpr(__builtin_strlen(p))`? i.e.
can we drop the first `__builtin_strlen`? It seems redundant.

So instead, we'd have:

#define strlen(p) __builtin_choose_expr(__is_constexpr(p),
__builtin_strlen(p), __fortify_strlen(p))

Or is there some funny business where p isn't constexpr but strlen(p)
somehow is? I doubt that.  (Or is it that p is constexpr, but
strlen(p) is not?)

(Guess I'm wrong: https://godbolt.org/z/19ffz7vjx)

Ok then.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +               __builtin_strlen(p), __fortify_strlen(p))
>  __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
> -__kernel_size_t strlen(const char * const p)
> +__kernel_size_t __fortify_strlen(const char * const p)
>  {
>         __kernel_size_t ret;
>         size_t p_size = __builtin_object_size(p, 1);
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
