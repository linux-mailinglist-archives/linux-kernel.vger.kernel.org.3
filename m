Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04C446909B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhLFHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbhLFHFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:05:04 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E03C061359
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:01:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bj13so19809370oib.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gB5LF9YPwwTzjtszS9NiPGbxbvt4uXsWrHHq1Mo0sqY=;
        b=pfdkMFZhQiBvWr4WiE+V9LycNs7cwBCQYUt2PXd1tvMVTYvNhEcm5BTZ6oiJAT9xNH
         2XBC5LCm7nJOu2wfwsCbEE9PTQ6O8ru9EkQC379YociLkihwhenYcjXy8pYO9UOt3ScQ
         SfQr+OpBEq2PFpvZqnQx0G9WzRWeCFOlFOK9qXJjrj9KEX0KtL3jUYh2Zexn6R3KaCXm
         jZh0Hk4B8wJl5d7Cox7K7fKV5V9OgsY1YeOAWZVGhf+ogQjJnVGXzS9345cYCzbvtUwJ
         s4WvNBZu8n6x75z/fwWyHkp3agBwAQLaAxaprOh96TYa2TOO6B6Gv0nUd/plFCYBQpHk
         fU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gB5LF9YPwwTzjtszS9NiPGbxbvt4uXsWrHHq1Mo0sqY=;
        b=PjVaMsc/O7uCd+Nj160K6/ZiKpUHXPRXDvbpj9aBdCQTfUs4UIZHmYBh1Dq5ne8OcM
         TSpXJwC9KHIpFnhzv4eeOUispSIVwOriLHMHBpxTN2BfOuFHW/cP/qfSBnPP4SNxf6Na
         cgICeHm+yI/WmiI61hV55U0C5bnjGMirBUFrNqbjq4xGBEFy9ky6ax1DMAVGmTyV61YA
         LaOzIk1Xi81MJapuTchBf5hrhFc6ARQKak+817suaR9wqSAOcDNtS84XwiuiGHxiC4+b
         bY/EMrn0fuKrvY+Tl7YnJ12WaZBOzGrYK0HeWZotpUx/BJxNgHSveTHUC/jzV0OfYshS
         TmWQ==
X-Gm-Message-State: AOAM530bxErzCrKcuQVGibnwhD7rPwNZRSimZTdcpbS6jFwmhBPkajaW
        RNgnmihrVKnjASW/mpDKxR5UT5YgRUv04Kn/Uhy0Ng==
X-Google-Smtp-Source: ABdhPJz2VEzeFRmQbkvN/DYiD+KZA8vOAtqU+2Td6RPO0eQreX0PlwZ++Fy4+DwuMSt5s1I6lLNqm2t8c+9sdNh1+kM=
X-Received: by 2002:aca:af50:: with SMTP id y77mr22500904oie.134.1638774094811;
 Sun, 05 Dec 2021 23:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20211203235346.110809-1-keescook@chromium.org>
In-Reply-To: <20211203235346.110809-1-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Dec 2021 08:00:00 +0100
Message-ID: <CANpmjNPn4kVRfb2R=_QyKQtmj-TN+=xn3sHkQwNsq4fcJuvNzQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Remove CONFIG_UBSAN_OBJECT_SIZE
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 at 00:53, Kees Cook <keescook@chromium.org> wrote:
> The object-size sanitizer is redundant to -Warray-bounds, and
> inappropriately performs its checks at run-time when all information
> needed for the evaluation is available at compile-time, making it quite
> difficult to use:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214861
>
> With -Warray-bounds almost enabled globally, it doesn't make sense to
> keep this around.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  lib/Kconfig.ubsan      | 13 -------------
>  lib/test_ubsan.c       | 22 ----------------------
>  scripts/Makefile.ubsan |  1 -
>  3 files changed, 36 deletions(-)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index e5372a13511d..236c5cefc4cc 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -112,19 +112,6 @@ config UBSAN_UNREACHABLE
>           This option enables -fsanitize=unreachable which checks for control
>           flow reaching an expected-to-be-unreachable position.
>
> -config UBSAN_OBJECT_SIZE
> -       bool "Perform checking for accesses beyond the end of objects"
> -       default UBSAN
> -       # gcc hugely expands stack usage with -fsanitize=object-size
> -       # https://lore.kernel.org/lkml/CAHk-=wjPasyJrDuwDnpHJS2TuQfExwe=px-SzLeN8GFMAQJPmQ@mail.gmail.com/
> -       depends on !CC_IS_GCC
> -       depends on $(cc-option,-fsanitize=object-size)
> -       help
> -         This option enables -fsanitize=object-size which checks for accesses
> -         beyond the end of objects where the optimizer can determine both the
> -         object being operated on and its size, usually seen with bad downcasts,
> -         or access to struct members from NULL pointers.
> -
>  config UBSAN_BOOL
>         bool "Perform checking for non-boolean values used as boolean"
>         default UBSAN
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 7e7bbd0f3fd2..2062be1f2e80 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -79,15 +79,6 @@ static void test_ubsan_load_invalid_value(void)
>         eval2 = eval;
>  }
>
> -static void test_ubsan_null_ptr_deref(void)
> -{
> -       volatile int *ptr = NULL;
> -       int val;
> -
> -       UBSAN_TEST(CONFIG_UBSAN_OBJECT_SIZE);
> -       val = *ptr;
> -}
> -
>  static void test_ubsan_misaligned_access(void)
>  {
>         volatile char arr[5] __aligned(4) = {1, 2, 3, 4, 5};
> @@ -98,29 +89,16 @@ static void test_ubsan_misaligned_access(void)
>         *ptr = val;
>  }
>
> -static void test_ubsan_object_size_mismatch(void)
> -{
> -       /* "((aligned(8)))" helps this not into be misaligned for ptr-access. */
> -       volatile int val __aligned(8) = 4;
> -       volatile long long *ptr, val2;
> -
> -       UBSAN_TEST(CONFIG_UBSAN_OBJECT_SIZE);
> -       ptr = (long long *)&val;
> -       val2 = *ptr;
> -}
> -
>  static const test_ubsan_fp test_ubsan_array[] = {
>         test_ubsan_shift_out_of_bounds,
>         test_ubsan_out_of_bounds,
>         test_ubsan_load_invalid_value,
>         test_ubsan_misaligned_access,
> -       test_ubsan_object_size_mismatch,
>  };
>
>  /* Excluded because they Oops the module. */
>  static const test_ubsan_fp skip_ubsan_array[] = {
>         test_ubsan_divrem_overflow,
> -       test_ubsan_null_ptr_deref,
>  };
>
>  static int __init test_ubsan_init(void)
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 9e2092fd5206..7099c603ff0a 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -8,7 +8,6 @@ ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)       += -fsanitize=local-bounds
>  ubsan-cflags-$(CONFIG_UBSAN_SHIFT)             += -fsanitize=shift
>  ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)          += -fsanitize=integer-divide-by-zero
>  ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)       += -fsanitize=unreachable
> -ubsan-cflags-$(CONFIG_UBSAN_OBJECT_SIZE)       += -fsanitize=object-size
>  ubsan-cflags-$(CONFIG_UBSAN_BOOL)              += -fsanitize=bool
>  ubsan-cflags-$(CONFIG_UBSAN_ENUM)              += -fsanitize=enum
>  ubsan-cflags-$(CONFIG_UBSAN_TRAP)              += -fsanitize-undefined-trap-on-error
> --
> 2.30.2
>
