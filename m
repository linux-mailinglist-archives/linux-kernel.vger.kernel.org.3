Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6414C3FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiBYH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiBYH6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:58:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A8D19BB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:57:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r10so3178223wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehs8GvkCBdhk9kP1lS7y4o84/MRpPifelGKXODnTEVo=;
        b=QHCqdEGUT3Y03CDQjQvv0OMWbJRWem4k7EIiMaBJKTy10TbpW6CDixrzWmwkLcGlbS
         7bWhL6kN6M1kZ6iSDfkn0uuLQoE8imEvWxaVsgLIwlHpKfjGMEy4q6fEiHeYEJfS/aN2
         trWvdpXGg9prdL6e3mNsy+8qiS0A3LASapsFya1xOwLfJYap33mgh/O9gymnFwl1ZqaY
         Ij4wFsAXqm9H0xNrCO1HKDNE5LI+HCFU2oaeV7rtfgnVwn87BZlejf9ktBy9jXV4FSA+
         mJtA4zIMqgl5Br1Kccx7Jl3y0ENw/7fhlj1H+dtTLbEbENA+8em8RTQsjcTx81mMe8ks
         XfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehs8GvkCBdhk9kP1lS7y4o84/MRpPifelGKXODnTEVo=;
        b=HZ8r+ofUJCFeu8OJWSLDYJCs/g3niJAYeBOqkkkkXdoe2wsFos9p1FNKGNrdcxslro
         Z0jyYse2C5/dG1JhbXEiOtdKKsAFmh18ZEHHjfx8W2eB+zJw8j5HI/O+QoweQpkJKd44
         h6hsk3xc8FvLopMeIo4NWrkAG8jAKSGsvhRYry1iIXMF15siFadNQiUtziD+sbmNHFoH
         jGaNx+yflC++Bzqi8oUbelL1EXkSxQ1/8A+UCXavBJ/DqImUr13d0U4/SRVrDIGz8Za7
         7O+i+qWFRL0V9eDuKxuoLcsH2jwUHWWoSvEoI3PFGdgSs3ABt2F8JYuWtg1PfHQr6Sqx
         q8Jg==
X-Gm-Message-State: AOAM530XqQNiglrKkVCMe3EkGgunZOZKn2iRceH79Gpl01xYK57P+Llt
        48/B3V3PMa7HCS+FG2gIM0M7Olr7xisxNTN6Hf7XfQ==
X-Google-Smtp-Source: ABdhPJw7QbrQ/3otql1uAtKEW88WGI6yKrHoCqPxkR43f1Bgo5ljNh6k7HWs2Pis8PworLKv1V9D/DsNxyxILTbJEy8=
X-Received: by 2002:adf:de0b:0:b0:1ed:c0ae:cf76 with SMTP id
 b11-20020adfde0b000000b001edc0aecf76mr5061806wrm.501.1645775848787; Thu, 24
 Feb 2022 23:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20220224054825.1853314-1-keescook@chromium.org>
In-Reply-To: <20220224054825.1853314-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Feb 2022 15:57:17 +0800
Message-ID: <CABVgOS=TWVh649_Vjo3wnMu9gZnq66gkV-LtGgsksAWMqc+MSA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e1fb7d05d8d30cf6"
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

--000000000000e1fb7d05d8d30cf6
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 24, 2022 at 1:48 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert overflow unit tests to KUnit, for better integration into the
> kernel self test framework. Includes a rename of test_overflow.c to
> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
>
> $ ./tools/testing/kunit/kunit.py config
> ...
(This 'config' step should be unnecessary... See below)

> $ ./tools/testing/kunit/kunit.py run overflow
> ...
> [14:33:51] Starting KUnit Kernel (1/1)...
> [14:33:51] ============================================================
> [14:33:51] ================== overflow (11 subtests) ==================
> [14:33:51] [PASSED] u8_overflow_test
> [14:33:51] [PASSED] s8_overflow_test
> [14:33:51] [PASSED] u16_overflow_test
> [14:33:51] [PASSED] s16_overflow_test
> [14:33:51] [PASSED] u32_overflow_test
> [14:33:51] [PASSED] s32_overflow_test
> [14:33:51] [PASSED] u64_overflow_test
> [14:33:51] [PASSED] s64_overflow_test
> [14:33:51] [PASSED] overflow_shift_test
> [14:33:51] [PASSED] overflow_allocation_test
> [14:33:51] [PASSED] overflow_size_helpers_test
> [14:33:51] ==================== [PASSED] overflow =====================
> [14:33:51] ============================================================
> [14:33:51] Testing complete. Passed: 11, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> [14:33:51] Elapsed time: 12.525s total, 0.001s configuring, 12.402s building, 0.101s running
>
> Cc: David Gow <davidgow@google.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Link: https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/lkml/CAKwvOdm62iA1dNiC6Q11UJ-MnTqtc4kXkm-ubPaFMK824_k0nw@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220216224153.2242451-1-keescook@chromium.org/
> v2: Fixed up the authorship more, pulled in other prior changes (Daniel)

This looks good to me. Some of the test cases _could_ probably be done
as parameterised tests (given they're already basically table-driven),
but I admit that could end up being excessively verbose.

Apart from my not being able to find a tree this applies cleanly on,
the tests work well here.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> ---
>  lib/Kconfig.debug                         |  16 +-
>  lib/Makefile                              |   2 +-
>  lib/{test_overflow.c => overflow_kunit.c} | 555 ++++++++++------------
>  3 files changed, 264 insertions(+), 309 deletions(-)
>  rename lib/{test_overflow.c => overflow_kunit.c} (54%)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 14b89aa37c5c..14d90d03bc8d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2214,9 +2214,6 @@ config TEST_UUID
>  config TEST_XARRAY
>         tristate "Test the XArray code at runtime"
>
> -config TEST_OVERFLOW
> -       tristate "Test check_*_overflow() functions at runtime"
> -
>  config TEST_RHASHTABLE
>         tristate "Perform selftest on resizable hash table"
>         help
> @@ -2501,6 +2498,19 @@ config MEMCPY_KUNIT_TEST
>
>           If unsure, say N.
>
> +config OVERFLOW_KUNIT_TEST
> +       tristate "Test check_*_overflow() functions at runtime" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Builds unit tests for the check_*_overflow(), size_*(), allocation, and
> +         related functions.
> +
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index 300f569c626b..fdfcbfaff32f 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -77,7 +77,6 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
>  obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
>  obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> -obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
>  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
>  obj-$(CONFIG_TEST_SORT) += test_sort.o
>  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> @@ -363,6 +362,7 @@ obj-$(CONFIG_BITS_TEST) += test_bits.o
>  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
>  obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
>  obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
> +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>
> diff --git a/lib/test_overflow.c b/lib/overflow_kunit.c
> similarity index 54%
> rename from lib/test_overflow.c
> rename to lib/overflow_kunit.c
> index f6530fce799d..835b1a312c76 100644
> --- a/lib/test_overflow.c
> +++ b/lib/overflow_kunit.c
> @@ -1,11 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Test cases for arithmetic overflow checks.
> + * Test cases for arithmetic overflow checks. See:
> + * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
> + *     ./tools/testing/kunit/kunit.py config

The kunit.py run command should automatically run kunit.py config
(while it can be useful to split them up to inspect the generated
config, and/or build manually, it's not required).
You can run the various stages of kunit.py run independently with
kunit.py {config, build, exec} in order.

> + *     ./tools/testing/kunit/kunit.py run overflow [--raw_output]
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <kunit/test.h>
>  #include <linux/device.h>
> -#include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> @@ -19,7 +22,7 @@
>                 t a, b;                         \
>                 t sum, diff, prod;              \
>                 bool s_of, d_of, p_of;          \
> -       } t ## _tests[] __initconst
> +       } t ## _tests[]
>
>  DEFINE_TEST_ARRAY(u8) = {
>         {0, 0, 0, 0, 0, false, false, false},
> @@ -220,43 +223,31 @@ DEFINE_TEST_ARRAY(s64) = {
>         bool _of;                                               \
>                                                                 \
>         _of = check_ ## op ## _overflow(a, b, &_r);             \
> -       if (_of != of) {                                        \
> -               pr_warn("expected "fmt" "sym" "fmt              \
> -                       " to%s overflow (type %s)\n",           \
> -                       a, b, of ? "" : " not", #t);            \
> -               err = 1;                                        \
> -       }                                                       \
> -       if (_r != r) {                                          \
> -               pr_warn("expected "fmt" "sym" "fmt" == "        \
> -                       fmt", got "fmt" (type %s)\n",           \
> -                       a, b, r, _r, #t);                       \
> -               err = 1;                                        \
> -       }                                                       \
> +       KUNIT_EXPECT_EQ_MSG(test, _of, of,                      \
> +               "expected "fmt" "sym" "fmt" to%s overflow (type %s)\n", \
> +               a, b, of ? "" : " not", #t);                    \
> +       KUNIT_EXPECT_EQ_MSG(test, _r, r,                        \
> +               "expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> +               a, b, r, _r, #t);                               \
>  } while (0)
>
>  #define DEFINE_TEST_FUNC(t, fmt)                                       \
> -static int __init do_test_ ## t(const struct test_ ## t *p)            \
> +static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
>  {                                                                      \
> -       int err = 0;                                                    \
> -                                                                       \
>         check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);    \
>         check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);    \
>         check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);   \
>         check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);   \
>         check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);   \
> -                                                                       \
> -       return err;                                                     \
>  }                                                                      \
>                                                                         \
> -static int __init test_ ## t ## _overflow(void) {                      \
> -       int err = 0;                                                    \
> +static void t ## _overflow_test(struct kunit *test) {                  \
>         unsigned i;                                                     \
>                                                                         \
>         for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)                   \
> -               err |= do_test_ ## t(&t ## _tests[i]);                  \
> -       pr_info("%zu %s arithmetic tests finished\n",                   \
> +               do_test_ ## t(test, &t ## _tests[i]);                   \
> +       kunit_info(test, "%zu %s arithmetic tests finished\n",          \
>                 ARRAY_SIZE(t ## _tests), #t);                           \
> -       return err;                                                     \
>  }
>
>  DEFINE_TEST_FUNC(u8, "%d");
> @@ -270,198 +261,176 @@ DEFINE_TEST_FUNC(u64, "%llu");
>  DEFINE_TEST_FUNC(s64, "%lld");
>  #endif
>
> -static int __init test_overflow_calculation(void)
> +static void overflow_shift_test(struct kunit *test)
>  {
> -       int err = 0;
> -
> -       err |= test_u8_overflow();
> -       err |= test_s8_overflow();
> -       err |= test_u16_overflow();
> -       err |= test_s16_overflow();
> -       err |= test_u32_overflow();
> -       err |= test_s32_overflow();
> -#if BITS_PER_LONG == 64
> -       err |= test_u64_overflow();
> -       err |= test_s64_overflow();
> -#endif
> -
> -       return err;
> -}
> -
> -static int __init test_overflow_shift(void)
> -{
> -       int err = 0;
>         int count = 0;
>
>  /* Args are: value, shift, type, expected result, overflow expected */
> -#define TEST_ONE_SHIFT(a, s, t, expect, of) ({                         \
> -       int __failed = 0;                                               \
> +#define TEST_ONE_SHIFT(a, s, t, expect, of)    do {                    \
>         typeof(a) __a = (a);                                            \
>         typeof(s) __s = (s);                                            \
>         t __e = (expect);                                               \
>         t __d;                                                          \
>         bool __of = check_shl_overflow(__a, __s, &__d);                 \
>         if (__of != of) {                                               \
> -               pr_warn("expected (%s)(%s << %s) to%s overflow\n",      \
> +               KUNIT_EXPECT_EQ_MSG(test, __of, of,                     \
> +                       "expected (%s)(%s << %s) to%s overflow\n",      \
>                         #t, #a, #s, of ? "" : " not");                  \
> -               __failed = 1;                                           \
>         } else if (!__of && __d != __e) {                               \
> -               pr_warn("expected (%s)(%s << %s) == %s\n",              \
> +               KUNIT_EXPECT_EQ_MSG(test, __d, __e,                     \
> +                       "expected (%s)(%s << %s) == %s\n",              \
>                         #t, #a, #s, #expect);                           \
>                 if ((t)-1 < 0)                                          \
> -                       pr_warn("got %lld\n", (s64)__d);                \
> +                       kunit_info(test, "got %lld\n", (s64)__d);       \
>                 else                                                    \
> -                       pr_warn("got %llu\n", (u64)__d);                \
> -               __failed = 1;                                           \
> +                       kunit_info(test, "got %llu\n", (u64)__d);       \
>         }                                                               \
>         count++;                                                        \
> -       __failed;                                                       \
> -})
> +} while (0)
>
>         /* Sane shifts. */
> -       err |= TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
> -       err |= TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
> -       err |= TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
> -       err |= TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
> -       err |= TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
> -       err |= TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
> -       err |= TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
> -       err |= TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
> -       err |= TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
> -       err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
> -       err |= TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
> -       err |= TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
> -       err |= TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
> -       err |= TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
> -       err |= TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
> -       err |= TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64,
> -                             0xFFFFFFFFULL << 32, false);
> +       TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
> +       TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
> +       TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
> +       TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
> +       TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
> +       TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
> +       TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
> +       TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
> +       TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
> +       TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
> +       TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
> +       TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
> +       TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
> +       TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
> +       TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
> +       TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
> +       TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
> +       TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
> +       TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
> +       TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
> +       TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
> +       TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
> +       TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64, 0xFFFFFFFFULL << 32, false);
>
>         /* Sane shift: start and end with 0, without a too-wide shift. */
> -       err |= TEST_ONE_SHIFT(0, 7, u8, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 15, u16, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, u32, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 63, u64, 0, false);
> +       TEST_ONE_SHIFT(0, 7, u8, 0, false);
> +       TEST_ONE_SHIFT(0, 15, u16, 0, false);
> +       TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
> +       TEST_ONE_SHIFT(0, 31, u32, 0, false);
> +       TEST_ONE_SHIFT(0, 63, u64, 0, false);
>
>         /* Sane shift: start and end with 0, without reaching signed bit. */
> -       err |= TEST_ONE_SHIFT(0, 6, s8, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 14, s16, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 30, int, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 30, s32, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 62, s64, 0, false);
> +       TEST_ONE_SHIFT(0, 6, s8, 0, false);
> +       TEST_ONE_SHIFT(0, 14, s16, 0, false);
> +       TEST_ONE_SHIFT(0, 30, int, 0, false);
> +       TEST_ONE_SHIFT(0, 30, s32, 0, false);
> +       TEST_ONE_SHIFT(0, 62, s64, 0, false);
>
>         /* Overflow: shifted the bit off the end. */
> -       err |= TEST_ONE_SHIFT(1, 8, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 16, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 32, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 64, u64, 0, true);
> +       TEST_ONE_SHIFT(1, 8, u8, 0, true);
> +       TEST_ONE_SHIFT(1, 16, u16, 0, true);
> +       TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(1, 32, u32, 0, true);
> +       TEST_ONE_SHIFT(1, 64, u64, 0, true);
>
>         /* Overflow: shifted into the signed bit. */
> -       err |= TEST_ONE_SHIFT(1, 7, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 15, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 31, int, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 31, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(1, 63, s64, 0, true);
> +       TEST_ONE_SHIFT(1, 7, s8, 0, true);
> +       TEST_ONE_SHIFT(1, 15, s16, 0, true);
> +       TEST_ONE_SHIFT(1, 31, int, 0, true);
> +       TEST_ONE_SHIFT(1, 31, s32, 0, true);
> +       TEST_ONE_SHIFT(1, 63, s64, 0, true);
>
>         /* Overflow: high bit falls off unsigned types. */
>         /* 10010110 */
> -       err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
> +       TEST_ONE_SHIFT(150, 1, u8, 0, true);
>         /* 1000100010010110 */
> -       err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
> +       TEST_ONE_SHIFT(34966, 1, u16, 0, true);
>         /* 10000100000010001000100010010110 */
> -       err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> +       TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
>         /* 1000001000010000010000000100000010000100000010001000100010010110 */
> -       err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
> +       TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
>
>         /* Overflow: bit shifted into signed bit on signed types. */
>         /* 01001011 */
> -       err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
> +       TEST_ONE_SHIFT(75, 1, s8, 0, true);
>         /* 0100010001001011 */
> -       err |= TEST_ONE_SHIFT(17483, 1, s16, 0, true);
> +       TEST_ONE_SHIFT(17483, 1, s16, 0, true);
>         /* 01000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
>         /* 0100000100001000001000000010000001000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
> +       TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
>
>         /* Overflow: bit shifted past signed bit on signed types. */
>         /* 01001011 */
> -       err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);
> +       TEST_ONE_SHIFT(75, 2, s8, 0, true);
>         /* 0100010001001011 */
> -       err |= TEST_ONE_SHIFT(17483, 2, s16, 0, true);
> +       TEST_ONE_SHIFT(17483, 2, s16, 0, true);
>         /* 01000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
> +       TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
>         /* 0100000100001000001000000010000001000010000001000100010001001011 */
> -       err |= TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
> +       TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
>
>         /* Overflow: values larger than destination type. */
> -       err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
> +       TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
> +       TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
> +       TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
> +       TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
> +       TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
> +       TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
>
>         /* Nonsense: negative initial value. */
> -       err |= TEST_ONE_SHIFT(-1, 0, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(-1, 0, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(-5, 0, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(-5, 0, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(-10, 0, int, 0, true);
> -       err |= TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(-100, 0, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(-100, 0, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
> -       err |= TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
> +       TEST_ONE_SHIFT(-1, 0, s8, 0, true);
> +       TEST_ONE_SHIFT(-1, 0, u8, 0, true);
> +       TEST_ONE_SHIFT(-5, 0, s16, 0, true);
> +       TEST_ONE_SHIFT(-5, 0, u16, 0, true);
> +       TEST_ONE_SHIFT(-10, 0, int, 0, true);
> +       TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(-100, 0, s32, 0, true);
> +       TEST_ONE_SHIFT(-100, 0, u32, 0, true);
> +       TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
> +       TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
>
>         /* Nonsense: negative shift values. */
> -       err |= TEST_ONE_SHIFT(0, -5, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -5, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -10, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -10, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -15, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -20, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -20, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -30, s64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, -30, u64, 0, true);
> +       TEST_ONE_SHIFT(0, -5, s8, 0, true);
> +       TEST_ONE_SHIFT(0, -5, u8, 0, true);
> +       TEST_ONE_SHIFT(0, -10, s16, 0, true);
> +       TEST_ONE_SHIFT(0, -10, u16, 0, true);
> +       TEST_ONE_SHIFT(0, -15, int, 0, true);
> +       TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
> +       TEST_ONE_SHIFT(0, -20, s32, 0, true);
> +       TEST_ONE_SHIFT(0, -20, u32, 0, true);
> +       TEST_ONE_SHIFT(0, -30, s64, 0, true);
> +       TEST_ONE_SHIFT(0, -30, u64, 0, true);
>
>         /* Overflow: shifted at or beyond entire type's bit width. */
> -       err |= TEST_ONE_SHIFT(0, 8, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 9, u8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 8, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 9, s8, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 16, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 17, u16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 16, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 17, s16, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 32, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 33, u32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 32, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 33, int, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 32, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 33, s32, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 64, u64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 65, u64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 64, s64, 0, true);
> -       err |= TEST_ONE_SHIFT(0, 65, s64, 0, true);
> +       TEST_ONE_SHIFT(0, 8, u8, 0, true);
> +       TEST_ONE_SHIFT(0, 9, u8, 0, true);
> +       TEST_ONE_SHIFT(0, 8, s8, 0, true);
> +       TEST_ONE_SHIFT(0, 9, s8, 0, true);
> +       TEST_ONE_SHIFT(0, 16, u16, 0, true);
> +       TEST_ONE_SHIFT(0, 17, u16, 0, true);
> +       TEST_ONE_SHIFT(0, 16, s16, 0, true);
> +       TEST_ONE_SHIFT(0, 17, s16, 0, true);
> +       TEST_ONE_SHIFT(0, 32, u32, 0, true);
> +       TEST_ONE_SHIFT(0, 33, u32, 0, true);
> +       TEST_ONE_SHIFT(0, 32, int, 0, true);
> +       TEST_ONE_SHIFT(0, 33, int, 0, true);
> +       TEST_ONE_SHIFT(0, 32, s32, 0, true);
> +       TEST_ONE_SHIFT(0, 33, s32, 0, true);
> +       TEST_ONE_SHIFT(0, 64, u64, 0, true);
> +       TEST_ONE_SHIFT(0, 65, u64, 0, true);
> +       TEST_ONE_SHIFT(0, 64, s64, 0, true);
> +       TEST_ONE_SHIFT(0, 65, s64, 0, true);
>
>         /*
>          * Corner case: for unsigned types, we fail when we've shifted
> @@ -472,17 +441,14 @@ static int __init test_overflow_shift(void)
>          * signed bit). So, for now, we will test this condition but
>          * mark it as not expected to overflow.
>          */
> -       err |= TEST_ONE_SHIFT(0, 7, s8, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 15, s16, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, int, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
> -       err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> -
> -       pr_info("%d shift tests finished\n", count);
> +       TEST_ONE_SHIFT(0, 7, s8, 0, false);
> +       TEST_ONE_SHIFT(0, 15, s16, 0, false);
> +       TEST_ONE_SHIFT(0, 31, int, 0, false);
> +       TEST_ONE_SHIFT(0, 31, s32, 0, false);
> +       TEST_ONE_SHIFT(0, 63, s64, 0, false);
>
> +       kunit_info(test, "%d shift tests finished\n", count);
>  #undef TEST_ONE_SHIFT
> -
> -       return err;
>  }
>
>  /*
> @@ -502,7 +468,7 @@ static int __init test_overflow_shift(void)
>  #define TEST_SIZE              (5 * 4096)
>
>  #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
> -static int __init test_ ## func (void *arg)                            \
> +static void test_ ## func (struct kunit *test, void *arg)              \
>  {                                                                      \
>         volatile size_t a = TEST_SIZE;                                  \
>         volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;                 \
> @@ -510,30 +476,24 @@ static int __init test_ ## func (void *arg)                               \
>                                                                         \
>         /* Tiny allocation test. */                                     \
>         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
> -       if (!ptr) {                                                     \
> -               pr_warn(#func " failed regular allocation?!\n");        \
> -               return 1;                                               \
> -       }                                                               \
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,                     \
> +                           #func " failed regular allocation?!\n");    \
>         free ## want_arg (free_func, arg, ptr);                         \
>                                                                         \
>         /* Wrapped allocation test. */                                  \
>         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
>                                                           a * b);       \
> -       if (!ptr) {                                                     \
> -               pr_warn(#func " unexpectedly failed bad wrapping?!\n"); \
> -               return 1;                                               \
> -       }                                                               \
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,                     \
> +                           #func " unexpectedly failed bad wrapping?!\n"); \
>         free ## want_arg (free_func, arg, ptr);                         \
>                                                                         \
>         /* Saturated allocation test. */                                \
>         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
>                                                    array_size(a, b));   \
>         if (ptr) {                                                      \
> -               pr_warn(#func " missed saturation!\n");                 \
> +               KUNIT_FAIL(test, #func " missed saturation!\n");        \
>                 free ## want_arg (free_func, arg, ptr);                 \
> -               return 1;                                               \
>         }                                                               \
> -       return 0;                                                       \
>  }
>
>  /*
> @@ -554,44 +514,38 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
>  DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
>  DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
>
> -static int __init test_overflow_allocation(void)
> +static void overflow_allocation_test(struct kunit *test)
>  {
>         const char device_name[] = "overflow-test";
>         struct device *dev;
>         int count = 0;
> -       int err = 0;
>
> -#define check_allocation_overflow(alloc)       ({      \
> +#define check_allocation_overflow(alloc)       do {    \
>         count++;                                        \
> -       test_ ## alloc(dev);                            \
> -})
> +       test_ ## alloc(test, dev);                      \
> +} while (0)
>
>         /* Create dummy device for devm_kmalloc()-family tests. */
>         dev = root_device_register(device_name);
> -       if (IS_ERR(dev)) {
> -               pr_warn("Cannot register test device\n");
> -               return 1;
> -       }
> -
> -       err |= check_allocation_overflow(kmalloc);
> -       err |= check_allocation_overflow(kmalloc_node);
> -       err |= check_allocation_overflow(kzalloc);
> -       err |= check_allocation_overflow(kzalloc_node);
> -       err |= check_allocation_overflow(__vmalloc);
> -       err |= check_allocation_overflow(kvmalloc);
> -       err |= check_allocation_overflow(kvmalloc_node);
> -       err |= check_allocation_overflow(kvzalloc);
> -       err |= check_allocation_overflow(kvzalloc_node);
> -       err |= check_allocation_overflow(devm_kmalloc);
> -       err |= check_allocation_overflow(devm_kzalloc);
> +       KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
> +                              "Cannot register test device\n");
> +
> +       check_allocation_overflow(kmalloc);
> +       check_allocation_overflow(kmalloc_node);
> +       check_allocation_overflow(kzalloc);
> +       check_allocation_overflow(kzalloc_node);
> +       check_allocation_overflow(__vmalloc);
> +       check_allocation_overflow(kvmalloc);
> +       check_allocation_overflow(kvmalloc_node);
> +       check_allocation_overflow(kvzalloc);
> +       check_allocation_overflow(kvzalloc_node);
> +       check_allocation_overflow(devm_kmalloc);
> +       check_allocation_overflow(devm_kzalloc);
>
>         device_unregister(dev);
>
> -       pr_info("%d allocation overflow tests finished\n", count);
> -
> +       kunit_info(test, "%d allocation overflow tests finished\n", count);
>  #undef check_allocation_overflow
> -
> -       return err;
>  }
>
>  struct __test_flex_array {
> @@ -600,127 +554,118 @@ struct __test_flex_array {
>         unsigned long data[];
">  };
>
> -static int __init test_overflow_size_helpers(void)
> +static void overflow_size_helpers_test(struct kunit *test)
>  {
>         /* Make sure struct_size() can be used in a constant expression. */
>         u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
>         struct __test_flex_array *obj;
>         int count = 0;
> -       int err = 0;
>         int var;
>         volatile int unconst = 0;

Where does this variable declaration (and its use below) come from?
It's not in the version of the "overflow: Implement size_t saturating
arithmetic helpers" patch in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6312fc63aee9d2fef2f9c4d42e57e5b46828f0dc

It all works if I add it in manually, but it does make applying the
change as-is something of a pain.

>
>         /* Verify constant expression against runtime version. */
>         var = 55;
>         OPTIMIZER_HIDE_VAR(var);
> -       err |= sizeof(ce_array) != struct_size(obj, data, var);
> +       KUNIT_EXPECT_EQ(test, sizeof(ce_array), struct_size(obj, data, var));
>
> -#define check_one_size_helper(expected, func, args...) ({      \
> -       bool __failure = false;                                 \
> -       size_t _r;                                              \
> -                                                               \
> -       _r = func(args);                                        \
> -       if (_r != (expected)) {                                 \
> -               pr_warn("expected " #func "(" #args ") "        \
> -                       "to return %zu but got %zu instead\n",  \
> -                       (size_t)(expected), _r);                \
> -               __failure = true;                               \
> -       }                                                       \
> +#define check_one_size_helper(expected, func, args...) do {    \
> +       size_t _r = func(args);                                 \
> +       KUNIT_EXPECT_EQ_MSG(test, _r, expected,                 \
> +               "expected " #func "(" #args ") to return %zu but got %zu instead\n", \
> +               (size_t)(expected), _r);                        \
>         count++;                                                \
> -       __failure;                                              \
> -})
> +} while (0)
>
>         var = 4;
> -       err |= check_one_size_helper(20,       size_mul, var++, 5);
> -       err |= check_one_size_helper(20,       size_mul, 4, var++);
> -       err |= check_one_size_helper(0,        size_mul, 0, 3);
> -       err |= check_one_size_helper(0,        size_mul, 3, 0);
> -       err |= check_one_size_helper(6,        size_mul, 2, 3);
> -       err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  1);
> -       err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  3);
> -       err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX, -3);
> +       check_one_size_helper(20,       size_mul, var++, 5);
> +       check_one_size_helper(20,       size_mul, 4, var++);
> +       check_one_size_helper(0,        size_mul, 0, 3);
> +       check_one_size_helper(0,        size_mul, 3, 0);
> +       check_one_size_helper(6,        size_mul, 2, 3);
> +       check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  1);
> +       check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  3);
> +       check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX, -3);
>
>         var = 4;
> -       err |= check_one_size_helper(9,        size_add, var++, 5);
> -       err |= check_one_size_helper(9,        size_add, 4, var++);
> -       err |= check_one_size_helper(9,        size_add, 9, 0);
> -       err |= check_one_size_helper(9,        size_add, 0, 9);
> -       err |= check_one_size_helper(5,        size_add, 2, 3);
> -       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
> -       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
> -       err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
> +       check_one_size_helper(9,        size_add, var++, 5);
> +       check_one_size_helper(9,        size_add, 4, var++);
> +       check_one_size_helper(9,        size_add, 9, 0);
> +       check_one_size_helper(9,        size_add, 0, 9);
> +       check_one_size_helper(5,        size_add, 2, 3);
> +       check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
> +       check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
> +       check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
>
>         var = 4;
> -       err |= check_one_size_helper(1,        size_sub, var--, 3);
> -       err |= check_one_size_helper(1,        size_sub, 4, var--);
> -       err |= check_one_size_helper(1,        size_sub, 3, 2);
> -       err |= check_one_size_helper(9,        size_sub, 9, 0);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, 9, -3);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, 0, 9);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, 2, 3);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX,  0);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX, 10);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, 0,  SIZE_MAX);
> -       err |= check_one_size_helper(SIZE_MAX, size_sub, 14, SIZE_MAX);
> -       err |= check_one_size_helper(SIZE_MAX - 2, size_sub, SIZE_MAX - 1,  1);
> -       err |= check_one_size_helper(SIZE_MAX - 4, size_sub, SIZE_MAX - 1,  3);
> -       err |= check_one_size_helper(1,         size_sub, SIZE_MAX - 1, -3);
> +       check_one_size_helper(1,        size_sub, var--, 3);
> +       check_one_size_helper(1,        size_sub, 4, var--);
> +       check_one_size_helper(1,        size_sub, 3, 2);
> +       check_one_size_helper(9,        size_sub, 9, 0);
> +       check_one_size_helper(SIZE_MAX, size_sub, 9, -3);
> +       check_one_size_helper(SIZE_MAX, size_sub, 0, 9);
> +       check_one_size_helper(SIZE_MAX, size_sub, 2, 3);
> +       check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX,  0);
> +       check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX, 10);
> +       check_one_size_helper(SIZE_MAX, size_sub, 0,  SIZE_MAX);
> +       check_one_size_helper(SIZE_MAX, size_sub, 14, SIZE_MAX);
> +       check_one_size_helper(SIZE_MAX - 2, size_sub, SIZE_MAX - 1,  1);
> +       check_one_size_helper(SIZE_MAX - 4, size_sub, SIZE_MAX - 1,  3);
> +       check_one_size_helper(1,                size_sub, SIZE_MAX - 1, -3);
>
>         var = 4;
> -       err |= check_one_size_helper(4 * sizeof(*obj->data),
> -                                    flex_array_size, obj, data, var++);
> -       err |= check_one_size_helper(5 * sizeof(*obj->data),
> -                                    flex_array_size, obj, data, var++);
> -       err |= check_one_size_helper(0, flex_array_size, obj, data, 0 + unconst);
> -       err |= check_one_size_helper(sizeof(*obj->data),
> -                                    flex_array_size, obj, data, 1 + unconst);
> -       err |= check_one_size_helper(7 * sizeof(*obj->data),
> -                                    flex_array_size, obj, data, 7 + unconst);
> -       err |= check_one_size_helper(SIZE_MAX,
> -                                    flex_array_size, obj, data, -1 + unconst);
> -       err |= check_one_size_helper(SIZE_MAX,
> -                                    flex_array_size, obj, data, SIZE_MAX - 4 + unconst);
> +       check_one_size_helper(4 * sizeof(*obj->data),
> +                             flex_array_size, obj, data, var++);
> +       check_one_size_helper(5 * sizeof(*obj->data),
> +                             flex_array_size, obj, data, var++);
> +       check_one_size_helper(0, flex_array_size, obj, data, 0 + unconst);
> +       check_one_size_helper(sizeof(*obj->data),
> +                             flex_array_size, obj, data, 1 + unconst);
> +       check_one_size_helper(7 * sizeof(*obj->data),
> +                             flex_array_size, obj, data, 7 + unconst);
> +       check_one_size_helper(SIZE_MAX,
> +                             flex_array_size, obj, data, -1 + unconst);
> +       check_one_size_helper(SIZE_MAX,
> +                             flex_array_size, obj, data, SIZE_MAX - 4 + unconst);
>
+ all these uses of "unconst" here and below.

>         var = 4;
> -       err |= check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
> -                                    struct_size, obj, data, var++);
> -       err |= check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
> -                                    struct_size, obj, data, var++);
> -       err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0 + unconst);
> -       err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
> -                                    struct_size, obj, data, 1 + unconst);
> -       err |= check_one_size_helper(SIZE_MAX,
> -                                    struct_size, obj, data, -3 + unconst);
> -       err |= check_one_size_helper(SIZE_MAX,
> -                                    struct_size, obj, data, SIZE_MAX - 3 + unconst);
> -
> -       pr_info("%d overflow size helper tests finished\n", count);
> -
> -       return err;
> +       check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
> +                             struct_size, obj, data, var++);
> +       check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
> +                             struct_size, obj, data, var++);
> +       check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0 + unconst);
> +       check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
> +                             struct_size, obj, data, 1 + unconst);
> +       check_one_size_helper(SIZE_MAX,
> +                             struct_size, obj, data, -3 + unconst);
> +       check_one_size_helper(SIZE_MAX,
> +                             struct_size, obj, data, SIZE_MAX - 3 + unconst);
> +
> +       kunit_info(test, "%d overflow size helper tests finished\n", count);
> +#undef check_one_size_helper
>  }
>
> -static int __init test_module_init(void)
> -{
> -       int err = 0;
> -
> -       err |= test_overflow_calculation();
> -       err |= test_overflow_shift();
> -       err |= test_overflow_size_helpers();
> -       err |= test_overflow_allocation();
> -
> -       if (err) {
> -               pr_warn("FAIL!\n");
> -               err = -EINVAL;
> -       } else {
> -               pr_info("all tests passed\n");
> -       }
> +static struct kunit_case overflow_test_cases[] = {
> +       KUNIT_CASE(u8_overflow_test),
> +       KUNIT_CASE(s8_overflow_test),
> +       KUNIT_CASE(u16_overflow_test),
> +       KUNIT_CASE(s16_overflow_test),
> +       KUNIT_CASE(u32_overflow_test),
> +       KUNIT_CASE(s32_overflow_test),
> +#if BITS_PER_LONG == 64
> +       KUNIT_CASE(u64_overflow_test),
> +       KUNIT_CASE(s64_overflow_test),
> +#endif
> +       KUNIT_CASE(overflow_shift_test),
> +       KUNIT_CASE(overflow_allocation_test),
> +       KUNIT_CASE(overflow_size_helpers_test),
> +       {}
> +};
>
> -       return err;
> -}
> +static struct kunit_suite overflow_test_suite = {
> +       .name = "overflow",
> +       .test_cases = overflow_test_cases,
> +};
>
> -static void __exit test_module_exit(void)
> -{ }
> +kunit_test_suite(overflow_test_suite);
>
> -module_init(test_module_init);
> -module_exit(test_module_exit);
>  MODULE_LICENSE("Dual MIT/GPL");
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220224054825.1853314-1-keescook%40chromium.org.

--000000000000e1fb7d05d8d30cf6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCL
mkirlZuQ2kJJgmUUUu+LmIdBcm+2xOiMC1rqcGuBmjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjUwNzU3MjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkFvn4ytPYaUiNpCer1NI
4TIq+WAK3wKxezPSiWrAWfO8YhQUStSlKP3z7645YutxwQUzyECEUIjw7X+xArcK2bI3xb+6s5HR
A5RSuUcYDwNcpxMBO6qNkSItQbM8xuyK0xJxl62O5vYPdzS3O4hA+WArcXhGMxFPNEmTz/rSGorC
e9TPSFr7hx7SDFfto3g1buBBZZE3rqpTMYtAkFygfG0Q6/lCMw3SUr8aIUBjvtNUj34nptfKVPDR
HqX2CFu6YOtcs+vw1vabX9oUMlZpdhUClzD9EB7eAH1JxY7+BG4UV/uZ3xUSLqUBTzm3nomTze5/
n0WB+VzDJ5+sj7lQ5Q==
--000000000000e1fb7d05d8d30cf6--
