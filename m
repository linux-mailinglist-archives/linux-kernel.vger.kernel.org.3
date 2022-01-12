Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3648BC68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347717AbiALB12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbiALB11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:27:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30DC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:27:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e9so1446388wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tj2pvYDv6Ipnrldy/N1q6PhVC/7W/hCwGex/zPraktk=;
        b=o3jJ2+e5hJrAN1DGFKBJn81jFwORNK6a+QbJmIlx+gXamt1ChCJGXNBi1lK9po0Ogl
         m1dTjf8EYASkNsYV54O0swKjlFo2bPfpYecAkLutmEwJdmuWXyVdpOe0ajpBSyKAWgZo
         dMaWtESTTjnhJ846vqIMBazHoF6rAkqQ0skfv8Ln1FXvefWQ2Ko9a1L+KdvhFBuNwYh+
         lOkOHtX4YcNrU2QVk5W0URUlQTAetVpTWA9jFeRgKkQu8cbljJKPcNgmHrX22Kps9Z7v
         0TefQtYWMwbSaqw1bgiesWmXV37LtHLhkOZ+LWJvynCFCdkh8ZOBaUcH2+RUsaKfI5EC
         XsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tj2pvYDv6Ipnrldy/N1q6PhVC/7W/hCwGex/zPraktk=;
        b=4YUmrStJoij72IXE8idxisBCGMoFQ/wE4a/XqMKj6e4oG+w2XKkpttj8FRRmTpLEHe
         mIKelXc6D8axszPkRYt8jJaFY5kzzIlxOC7mlUeX4UJxhQ4dYxT7DdC5iOdxSg6oo9Rz
         pj6quqomZZ/CyQ7EPYw4aAyXYDDDTkyLR6Dtsb5y5ayyAD44XrIHZ9/wq51JoI7wGnIg
         TjMG3P7eLWaPBcnDDGoBSFPRWJA1pbX3A6UWXvq/I74Y6hSrDHQ5j4VEZ9WQOw+XCUtQ
         QpPby4vISklT15VjfX6glOpHnPvjxapPXObQsMtQtuoHtnEnp8yviQYaRFQ0GzizrPL7
         K7fQ==
X-Gm-Message-State: AOAM533itB2ghbVXRbbGq0eVtO21qmDjGPI1LynqhiCTbFFLTQbHc0D/
        T4aBStC7dQo4oPTWI4j6Rd3DUc7lyYTbsYNWNxmeuA==
X-Google-Smtp-Source: ABdhPJyAZRep2+ICv+QETxvVv0pXaOckG5uppkj2uo5sB2zlApP3xXncehYz1Dj27z2GFj+GHkIkZTP4ll4UXoYrgjU=
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr5905274wry.447.1641950845305;
 Tue, 11 Jan 2022 17:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-3-dlatypov@google.com>
In-Reply-To: <20220111194231.1797841-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 12 Jan 2022 09:27:13 +0800
Message-ID: <CABVgOSnpGBsm9nONGyKkNFOb8ycxnt4pe4P65R7Gp0eYBJW9pA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kunit: move check if assertion passed into the macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:42 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently the code always calls kunit_do_assertion() even though it does
> nothing when `pass` is true.
>
> This change moves the `if(!(pass))` check into the macro instead
> and renames the function to kunit_do_failed_assertion().
> I feel this a  bit easier to read and understand.
>
> This has the potential upside of avoiding a function call that does
> nothing most of the time (assuming your tests are passing) but comes
> with the downside of generating a bit more code and branches. We try to
> mitigate the branches by tagging them with `unlikely()`.
>
> This also means we don't have to initialize structs that we don't need,
> which will become a tiny bit more expensive if we switch over to using
> static variables to try and reduce stack usage. (There's runtime code
> to check if the variable has been initialized yet or not).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---

This looks good. I'm still not 100% sold that putting the if() outside
the function is significantly easier to read, but I don't think it's
harder to read either, and getting rid of the function call is
probably worth it.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  include/kunit/test.h | 21 +++++++++++----------
>  lib/kunit/test.c     | 13 ++++---------
>  2 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b26400731c02..12cabd15449a 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -12,6 +12,7 @@
>  #include <kunit/assert.h>
>  #include <kunit/try-catch.h>
>
> +#include <linux/compiler.h>
>  #include <linux/container_of.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -770,18 +771,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>   */
>  #define KUNIT_SUCCEED(test) do {} while (0)
>
> -void kunit_do_assertion(struct kunit *test,
> -                       struct kunit_assert *assert,
> -                       bool pass,
> -                       const char *fmt, ...);
> +void kunit_do_failed_assertion(struct kunit *test,
> +                              struct kunit_assert *assert,
> +                              const char *fmt, ...);
>
>  #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> -       struct assert_class __assertion = INITIALIZER;                         \
> -       kunit_do_assertion(test,                                               \
> -                          &__assertion.assert,                                \
> -                          pass,                                               \
> -                          fmt,                                                \
> -                          ##__VA_ARGS__);                                     \
> +       if (unlikely(!(pass))) {                                               \
> +               struct assert_class __assertion = INITIALIZER;                 \
> +               kunit_do_failed_assertion(test,                                \
> +                                         &__assertion.assert,                 \
> +                                         fmt,                                 \
> +                                         ##__VA_ARGS__);                      \
> +       }                                                                      \
>  } while (0)
>
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c7ed4aabec04..3a52c321c280 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
>         WARN_ONCE(true, "Throw could not abort from test!\n");
>  }
>
> -void kunit_do_assertion(struct kunit *test,
> -                       struct kunit_assert *assert,
> -                       bool pass,
> -                       const char *fmt, ...)
> +void kunit_do_failed_assertion(struct kunit *test,
> +                              struct kunit_assert *assert,
> +                              const char *fmt, ...)
>  {
>         va_list args;
> -
> -       if (pass)
> -               return;
> -
>         va_start(args, fmt);
>
>         assert->message.fmt = fmt;
> @@ -297,7 +292,7 @@ void kunit_do_assertion(struct kunit *test,
>         if (assert->type == KUNIT_ASSERTION)
>                 kunit_abort(test);
>  }
> -EXPORT_SYMBOL_GPL(kunit_do_assertion);
> +EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log)
>  {
> --
> 2.34.1.575.g55b058a8bb-goog
>
