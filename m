Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444124CB8CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiCCI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCCI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:28:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305F55204
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:27:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so2741550wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3QV3fMGNyf/oJKYptIIbSLgLU+YemaMLsAmmraW46s=;
        b=FykKw7tipsjPC09UlAXmrYsKjF/adLORe3i0+8gl8CVsIMB6k2ppdsjfBY7jqnSL8s
         N+JjPcgombWXq0wyFvTiC1BDOd1BiisnLENA/yrmF6ysL2KBYiND8sxrEtbi7I8pBuH0
         U8xvVP2BbfOyW7Z4sR09DqSF7no9rHnR6pG8UmaJIMRE1pxb0juPSQCkVUvCaZX3bCn8
         DKFVzrsLRWM0/dwyqCHVbWhLiqDrvmLqdG5K1so57Fh8urHlUYNoL5Q0zYMAe2A183ZJ
         no6eezxprwr3EiIt2e7KtIueAhRKwj8/G/6ULjefuQ9NnBjQ7uUDv309Npmqi9k1UgMj
         NFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3QV3fMGNyf/oJKYptIIbSLgLU+YemaMLsAmmraW46s=;
        b=g0/KDhGFsiiJER5/Z8xxMYX20qiKcn7rpiCt4/ZQwYZiINip+mj1azNiB+J8h75V3G
         lK2bUzQXlIUkugPQ2P7TU+qz0yyqCTNJ/NEoxwnUP1att4nvFr3Lj9lRJIo0Z++9Wb9G
         HABKdwfKdmZGFvwPBCWxA95CHwBtjLsA0JLtYjYpf34ZAaW1MjH6FoUuYIsM00bl44wl
         jQZQJJhfRHl6hHKDNPg+uKaTqxDAaFr1n6QnfKfPIBPfnOB4S1oYKy28RldmUg5//CPE
         RxxOqYfZg7v7fpdexv5p449AAIQr2M/AGQkmv2rNKHPPDVt6R7c/X7ZOst92OjVq8JZc
         /85w==
X-Gm-Message-State: AOAM530qGeTLHrsTD2XhuIvHWhRRL5cYvptcvQlh817CNNN681Fg4hvy
        kRLN9klEvEoWrngYwQqjVmtStubAc1ea7AwfyNCwJg==
X-Google-Smtp-Source: ABdhPJzdCGaw/8uL0lyhL09DBVR6a+lT73YPwaFTJ5piAOaoi9EbtyGfLTEr2RA6fN0BxaEVXaJ0G5H9b5/2Hl8b0Rk=
X-Received: by 2002:a05:600c:4fd0:b0:382:716a:c5fc with SMTP id
 o16-20020a05600c4fd000b00382716ac5fcmr2817856wmq.81.1646296044579; Thu, 03
 Mar 2022 00:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20220227184517.504931-1-keescook@chromium.org> <20220227184517.504931-8-keescook@chromium.org>
In-Reply-To: <20220227184517.504931-8-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Mar 2022 16:27:13 +0800
Message-ID: <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f5950105d94c2a2d"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f5950105d94c2a2d
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 28, 2022 at 2:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> The original lib/test_stackinit.c, which exclusively tests toolchain
> features, was designed to also be built without the full Linux kernel
> sources so that compiler developers and distro maintainers had an easy
> way to check for toolchain behaviors. When it was ported to KUnit, this
> mode was removed to simplify the code.
>
> Add a small header that provides a minimally operational KUnit API that
> can allow unit tests that don't depend on kernel-specific behaviors
> to build and run strictly from userspace without kernel sources. Add
> userspace-build support back to the renamed lib/stackinit_kunit.c test.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220224055145.1853657-1-keescook@chromium.org
> v2:
>  - split from stackinit_kunit.c refactoring patch
>  - add missing returns (Daniel)
>  - report expression mismatch in assert msg (Daniel)
>  - emulate kunit_test_suites() (Daniel)
>  - emit valid KTAP (David)
> ---

This looks pretty good on-the-whole to me, modulo one bug (test suites
being marked as SKIPPED instead of FAILED) below. And checkpatch being
grumpy.

I do like the idea of putting this in uapi/ -- it solves the problem
of distributing it quite elegantly, IMO.

-- David

>  include/uapi/misc/kunit.h | 181 ++++++++++++++++++++++++++++++++++++++
>  lib/stackinit_kunit.c     |  11 +++
>  2 files changed, 192 insertions(+)
>  create mode 100644 include/uapi/misc/kunit.h
>
> diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
> new file mode 100644
> index 000000000000..afdffda583ae
> --- /dev/null
> +++ b/include/uapi/misc/kunit.h
> @@ -0,0 +1,181 @@
> +#ifndef __UAPI_MISC_KUNIT_H__
> +#define __UAPI_MISC_KUNIT_H__
> +/*
> + * This is a light-weight userspace drop-in replacement for the in-kernel
> + * KUnit API. It seeks to implement a minimal subset of features so that
> + * a concisely written KUnit test can be made to run entirely in userspace
> + * when it doesn't actually depend on any real kernel internals.
> + *
> + * Additionally contains many refactored kernel-isms to support building
> + * and running in userspace without full kernel source.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#define __user                 /**/
> +#define noinline               __attribute__((__noinline__))
> +#define __aligned(x)           __attribute__((__aligned__(x)))
> +#ifdef __clang__
> +# define __compiletime_error(message) /**/
> +#else
> +# define __compiletime_error(message) __attribute__((__error__(message)))
> +#endif
> +#define __compiletime_assert(condition, msg, prefix, suffix)           \
> +       do {                                                            \
> +               extern void prefix ## suffix(void) __compiletime_error(msg); \
> +               if (!(condition))                                       \
> +                       prefix ## suffix();                             \
> +       } while (0)
> +#define _compiletime_assert(condition, msg, prefix, suffix) \
> +       __compiletime_assert(condition, msg, prefix, suffix)
> +#define compiletime_assert(condition, msg) \
> +       _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> +#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> +#define BUILD_BUG_ON(condition) \
> +       BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> +
> +#define ARRAY_SIZE(a)          (sizeof (a) / sizeof ((a)[0]))
> +
> +#define MODULE_LICENSE(str)    /* str */
> +
> +typedef uint8_t                        u8;
> +typedef uint16_t               u16;
> +typedef uint32_t               u32;
> +typedef uint64_t               u64;
> +
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

Nit: tabs/spaces.

There are a few other checkpatch warnings, mostly it just complaining
about the use of 'return' in macros, which I think is probably still
better than trying to hack something out of setjmp/longjmp at this
point.

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
> +               return;                                                 \
> +       }                                                               \
> +} while (0)
> +
> +#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)               \
> +       KUNIT_ASSERT_TRUE_MSG(test, (left) == (right),                  \
> +                             #left " != " #right ": " fmt,             \
> +                             ##__VA_ARGS__)
> +
> +#define kunit_skip(test, fmt, ...)                                     \
> +do {                                                                   \
> +       test->status = TEST_SKIP;                                       \
> +       if (test->msg)                                                  \
> +               free(test->msg);                                        \
> +       asprintf(&test->msg, fmt, ##__VA_ARGS__);                       \
> +       return;                                                         \
> +} while (0)
> +
> +static int do_kunit_test_suite(struct kunit_suite *suite)
> +{
> +       const struct kunit_case *test_case;
> +       int pass = 0, fail = 0, skip = 0;
> +       int rc = 0;
> +       size_t i = 0;
> +
> +       printf("  TAP version 14\n");
> +       for (test_case = suite->test_cases; test_case->run_case; test_case++)
> +               i++;
> +       printf("  1..%zu\n", i);
> +       i = 0;
> +       for (test_case = suite->test_cases; test_case->run_case; test_case++) {
> +               struct kunit test = { };
> +
> +               i++;
> +               test_case->run_case(&test);
> +               switch (test.status) {
> +               default:
> +               case TEST_FAIL:
> +                       fprintf(stderr, "  not ok %zu - %s%s%s",
> +                               i, test_case->name,
> +                               test.msg ? " # ERROR " : "",
> +                               test.msg ?: "\n");
> +                       rc = 1;

What is this function trying to return? If 'rc' is supposed to be a
result status, this should be TEST_FAIL (2)?

As-is, when a test case fails, the whole suite is being marked as SKIPPED.

The other thing worth noting is that -- if this is fixed -- there's no
way a whole suite can be marked SKIPPED. KUnit will mark a suite as
skipped if all of its subtests are skipped. (This is a much more niche
case, though.)

> +                       fail++;
> +                       break;
> +               case TEST_SKIP:
> +                       fprintf(stdout, "  ok %zu - %s # SKIP%s%s",
> +                               i, test_case->name,
> +                               test.msg ? " " : "",
> +                               test.msg ?: "\n");
> +                       skip++;
> +                       break;
> +               case TEST_PASS:
> +                       fprintf(stdout, "  ok %zu - %s\n",
> +                               i, test_case->name);
> +                       pass++;
> +                       break;
> +               }
> +               if (test.msg)
> +                       free(test.msg);
> +       }
> +       printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
> +               suite->name, pass, fail, skip, i);
> +       return rc;
> +}
> +
> +static int run_suites(char *name, struct kunit_suite *suites[], size_t count)
> +{
> +       int pass = 0, fail = 0, skip = 0;
> +       int one, ret = 0;
> +       size_t i;
> +
> +       printf("TAP version 14\n");
> +       printf("1..%zu\n", count);
> +       for (i = 0; i < count; ++i) {
> +               one = do_kunit_test_suite(suites[i]);
> +               switch (one) {
> +               case TEST_SKIP:
> +                       skip++;
> +                       break;
> +               case TEST_PASS:
> +                       pass++;
> +                       break;
> +               default:
> +                       fail++;
> +                       break;
> +               }
> +               printf("%sok %zu - %s\n",
> +                       one == TEST_FAIL ? "not " : "",
> +                       i + 1, suites[i]->name);
> +               ret |= one;
> +       }
> +       printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
> +               name, pass, fail, skip, count);
> +       return ret;
> +}
> +
> +#define kunit_test_suites(suite...)                            \
> +int main(int argc, char *argv[]) {                             \

Nit: checkpatch really wants the '{' on the next line.

> +       static struct kunit_suite *suites[] = { suite };        \
> +       return run_suites(argv[0], suites, ARRAY_SIZE(suites)); \
> +}
> +
> +#endif /* __UAPI_MISC_KUNIT_H__ */
> diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
> index 35c69aa425b2..6d468630c90a 100644
> --- a/lib/stackinit_kunit.c
> +++ b/lib/stackinit_kunit.c
> @@ -8,7 +8,13 @@
>   *             --make_option LLVM=1 \
>   *             --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
>   *
> + * External build example:
> + *     clang -O2 -Wall -ftrivial-auto-var-init=pattern \
> + *             -o stackinit_kunit stackinit_kunit.c
> + *     ./stackinit_kunit
> + *
>   */
> +#ifdef __KERNEL__
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <kunit/test.h>
> @@ -17,6 +23,11 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>
> +#else
> +/* Userspace KUnit stub header. */
> +#include <misc/kunit.h>
> +#endif
> +
>  /* Exfiltration buffer. */
>  #define MAX_VAR_SIZE   128
>  static u8 check_buf[MAX_VAR_SIZE];
> --
> 2.32.0
>

--000000000000f5950105d94c2a2d
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAX
yQJVv0ndeUJqk1EoyZMJ4g/z7lYiSUs3MTpbBdsdKzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMDMwODI3MjVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAR5p/jPnpODA46aDn/kj1
48NrhXCZBrrGLQfr2GCmO5QoKe4/Fc21IUtRn4jgtAhlLpIrYV6wK89jfVLWuDt/0J8E45jihCKl
xB7BlwFwN3K9ZtqqpOWs5ZiI29Lf3xql3Oc4DHxKobkC1gxjbOLQ4TNWX9sngGkp2UrPq9c/YQl3
NrogjidgTmtJkrII/ULXpY+hgoPOUiX4OK8HJ3kA5mKdr9PerKAFjknoFhOJtNlvZkFQSenv+dwz
bgtZMcSSp+YRULH6GFdAet6Qw3lM4aJC368ZXO2CV2ihPOt4kYgPZQrJmqK5shw0ftNnIhLV0e3g
UxOPJaxoovCmSvoRNw==
--000000000000f5950105d94c2a2d--
