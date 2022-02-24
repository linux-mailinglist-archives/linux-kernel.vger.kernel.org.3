Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725504C360A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiBXTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiBXToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:44:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D31C6EF2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:43:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm8so4395243edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cT6VTaPBAvZcJT0C07jbq6jkkSfnrkv3DOfnLzZ77CM=;
        b=cph9wo/cKs42xh7OHpJ1L4/fItWA1YtsVsR8Di5tl2igWrI3LjGzwy+GTVPrIL3I1Z
         GPmf1B0NtZnAEE3hGPmw8LkPPA+8eTx1vMqrbiZJvC6TMFfHROnbmMiYXNJp8huLI+gx
         qO7LzfpbfGtaHrKawj/KVlZawWWAemhDdkG+FfRsf2zbCwRLYY8yk1hUtHQPAc+vZfmk
         RxJzf8gEOCvxp1Kuikw1mJyQ5GskvlzG3ChUBTmfgr88rXLMULIcbZFULMD36AaKUC3e
         HhchVJPs5IExtwcXN/IpVT84JaqinlITjSuAktAm60Cw3JGxFH3MCqXm65fyUBe1lLZi
         IxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cT6VTaPBAvZcJT0C07jbq6jkkSfnrkv3DOfnLzZ77CM=;
        b=LXPJ7g9199ZFylDr9Hpl5H0EZgxNKvPPwHu0C06bD1lS7ta+8HPaEzYMwjBXZFy/UI
         enOnU3c90nmPfpu+pnyj8jwIxrJin2nvm8TnivCRkahqHSmKSqiBB3K/RtW6sWFgPKhU
         kdbXxP1HOudJnTIGhLwoFX4Ad+ryi1HOMEhp9pdZZxxFnUjYqLimNU5YkMT2MWBABzUd
         IJOp0GuuRLBkXJQKDwf9E4wvAijNlWTUqpcNJBnBl7YlNNeCw0r60GUrBi6tJQe/tOf+
         2vTkCYqzkKQDKbi/bmRNS+GF0KoW5wTbnMyq04YcXQ9QrxbdpNH2JDRvDr1WCJqNIKVp
         RSuw==
X-Gm-Message-State: AOAM533suIoXeqR+3dx1kSrb6Rx/R9hngGgxHe7R3itOdnI47NX0hbMf
        HFDXwm5T8TYs3Mlj2i78E0evbvLoLsbFiAuMGV2gKQ==
X-Google-Smtp-Source: ABdhPJwrdy9Ks+AvYVAONIODLhAaLZ43j966hZvJwXtEANqW/+4iWi8AF6gH87RMvVRxu+szCttnMs6KWkl6HKVvHdU=
X-Received: by 2002:a05:6402:2546:b0:412:d0eb:2a4a with SMTP id
 l6-20020a056402254600b00412d0eb2a4amr3924248edb.306.1645731832090; Thu, 24
 Feb 2022 11:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20220224055145.1853657-1-keescook@chromium.org>
In-Reply-To: <20220224055145.1853657-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 24 Feb 2022 11:43:40 -0800
Message-ID: <CAGS_qxrRi0zvGnoi-Ne=wp8xkuFKPzNj9d57eq=51gg5gwX=eA@mail.gmail.com>
Subject: Re: [PATCH] lib: stackinit: Convert to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 9:51 PM Kees Cook <keescook@chromium.org> wrote:
>

<snip>


>  /* Userspace headers. */
> +#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdint.h>
> +#include <stdlib.h>
>  #include <string.h>
>  #include <stdbool.h>
>  #include <errno.h>
>  #include <sys/types.h>
>
>  /* Linux kernel-ism stubs for stand-alone userspace build. */

This is neat and esp. so that it works.
But may I ask, what's the value of using this vs UML?

Given this has changed into mainly just a KUnit-compatibility layer,
it feels like it can maybe live as a standalone file, if there's ever
interest in doing this for other tests.

It feels like something that will never quite be "supported", but I
find it neat enough I'd have fun sending some patches to make it more
realistic.

> -#define KBUILD_MODNAME         "stackinit"
> -#define pr_fmt(fmt)            KBUILD_MODNAME ": " fmt
> -#define pr_err(fmt, ...)       fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
> -#define pr_warn(fmt, ...)      fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
> -#define pr_info(fmt, ...)      fprintf(stdout, pr_fmt(fmt), ##__VA_ARGS__)
> -#define __init                 /**/
> -#define __exit                 /**/
> +#define TEST_PASS      0
> +#define TEST_SKIP      1
> +#define TEST_FAIL      2
> +struct kunit {
> +       int status;
> +       char *msg;
> +};
> +struct kunit_case {
> +        void (*run_case)(struct kunit *test);
> +        const char *name;
> +};
> +struct kunit_suite {
> +       const char *name;
> +       const struct kunit_case *test_cases;
> +};
> +#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +
> +#define KUNIT_ASSERT_TRUE_MSG(test, expr, fmt, ...)                    \
> +do {                                                                   \
> +       if (!(expr)) {                                                  \
> +               if (test->status != TEST_SKIP)                          \
> +                       test->status = TEST_FAIL;                       \
> +               if (test->msg)                                          \
> +                       free(test->msg);                                \
> +               asprintf(&test->msg, fmt, ##__VA_ARGS__);               \
> +       }                                                               \
> +} while (0)

This looks more like KUNIT_EXPECT_TRUE_MSG(), since this macro won't
abort the test if the expectation fails.

Looking at the code, it looks like we do want the ability to abort.
Perhaps we can do what Googletest does in C++ and just add in a `return;`?

It has some annoying implications, like using them from helper
functions doesn't work as one would expect.
But people seem to be doing fine with that tradeoff in C++ land.

> +
> +#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)               \
> +       KUNIT_ASSERT_TRUE_MSG(test, (left) == (right), fmt, ##__VA_ARGS__)

Very optional:

It might be nice to show the expressions automatically on failure.
We could implement that via something like

KUNIT_ASSERT_TRUE_MSG(test, (left) == (right), #left " != " #right ":
" fmt, ##__VA_ARGS__);

E.g.
KUNIT_ASSERT_EQ_MSG(test, 2+2, 5, "math is broken")
=> 2+2 != 5: math is broken

But I can see that being a bit too complicated to want to do here.
And the failure messages we had before are already decent at giving context.

> +
> +#define kunit_skip(test, fmt, ...)                                     \
> +do {                                                                   \
> +       test->status = TEST_SKIP;                                       \
> +       if (test->msg)                                                  \
> +               free(test->msg);                                        \
> +       asprintf(&test->msg, fmt, ##__VA_ARGS__);                       \
> +} while (0)

Similarly, this has no control flow implications, so the current
semantics match kunit_mark_skipped().

But looking at the code, I think we want to abort early here too.

> +
>  #define __user                 /**/
>  #define noinline               __attribute__((__noinline__))
>  #define __aligned(x)           __attribute__((__aligned__(x)))
> @@ -59,16 +102,44 @@ typedef uint16_t           u16;
>  typedef uint32_t               u32;
>  typedef uint64_t               u64;
>
> -#define module_init(func)      static int (*do_init)(void) = func
> -#define module_exit(func)      static void (*do_exit)(void) = func
> -#define MODULE_LICENSE(str)    int main(void) {                \
> -                                       int rc;                 \
> -                                       /* License: str */      \
> -                                       rc = do_init();         \
> -                                       if (rc == 0)            \
> -                                               do_exit();      \
> -                                       return rc;              \
> -                               }
> +#define MODULE_LICENSE(str)    /* */
> +
> +int do_kunit_test_suite(struct kunit_suite *suite)
> +{
> +       const struct kunit_case *test_case;
> +       int rc = 0;
> +
> +       for (test_case = suite->test_cases; test_case->run_case; test_case++) {
> +               struct kunit test = { };
> +
> +               test_case->run_case(&test);
> +               switch (test.status) {
> +               default:
> +               case TEST_FAIL:
> +                       fprintf(stderr, "FAIL: %s%s%s", test_case->name,
> +                               test.msg ? ": " : "",
> +                               test.msg ?: "\n");
> +                       rc = 1;
> +                       break;
> +               case TEST_SKIP:
> +                       fprintf(stdout, "XFAIL: %s%s%s", test_case->name,
> +                               test.msg ? ": " : "",
> +                               test.msg ?: "\n");
> +                       break;
> +               case TEST_PASS:
> +                       fprintf(stdout, "ok: %s\n", test_case->name);
> +                       break;
> +               }
> +               if (test.msg)
> +                       free(test.msg);
> +       }
> +       return rc;
> +}
> +
> +#define kunit_test_suite(suite)                                        \
> +int main(void) {                                               \
> +       return do_kunit_test_suite(&(suite));                   \
> +}

very optional:
emulating kunit_test_suites() might be more future-proof here, if we
ever want to setup more suites.
There's little reason to do so right now given the lack of init and
exit support.

Like the stuff above, it wouldn't be hard to do, but I can see it not
being worth the extra code, i.e.

#define kunit_test_suites(suites...) \
  int main(void) {
     static struct kunit_suite *suites =[] = { __VA_ARGS__ };
     int i, ret = 0;
     for (i = 0; i < ARRAY_SIZE(suites); ++i)
       ret += do_kunit_test_suite(suites[i]);
     return ret;
   }
