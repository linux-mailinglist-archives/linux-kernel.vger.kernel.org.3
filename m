Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B935ABC83
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiICC7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiICC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:59:39 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F41A818
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 19:59:37 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a18so1456676uak.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CKHvTi4YwJXZJRGwVfRL/R88FULwtUdHKdHzSiNxiUI=;
        b=bxp0HgYTcP7xWd+2+ngcf/N+fj5uqCx1pqSdm2Hxx/eCl96Ydvt3uxLvIsGstcz7/1
         HMcQ7NEzww2XOZV4zsflNCY7eP3eBONkdo0UGFcuiNrTWs4ytrdfRqSmPT2a3r7GEWrq
         pHt+E+JQqOTJiuaBgW02qyPMw4kvn1DMWi3aApYLRw3noVN71QkCqdcFkzKlICxBF7G1
         5TSFOOm1SMGnCTaIVGtOko8QVt9QtPwcCYQwQtfLbG93o7J81+x88sFX0EM5NDJOEPAI
         tKlsbEerlaQhhPOVUOe2amRtykWPxG/4NIDyxueIyawhRz0MN4FLrQtxFHzZ/iFUQGBH
         Oe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CKHvTi4YwJXZJRGwVfRL/R88FULwtUdHKdHzSiNxiUI=;
        b=y5et1Z58AswasB9h5gJONtyQZYoaGAtsEkpFSAYzu3uM6WM2T23wGkTvuvdi/PvCv1
         7lH4l27177UkGGr9ebTiL/ddMAkSgwyjs6Q+agYSQOgBEZbG+2+DrQ1FSdlYEIe/6mhI
         4ASFdXCY47h4vOJrzbHrzlS5sOBnzU7tcsbAqkVrv9/zp88IIv6r2PFms6Nw5/QqKVwS
         C/P/pNapqR5gm14A/gJ54QbBA/wQEuCgL00XzGbBoeMIKEQVG3mm5hi02KxpNDoYaj0j
         uzwjSzmJDEtZu+Bx9OY9U1oFrnGOlh/KJrx2aiGC9f4bY5auLNQ3S/ncAoVky+CKUZnF
         g2cw==
X-Gm-Message-State: ACgBeo2RFdpC5CcNqw77d4Yb6BGSarq2AlroQhqPk5Q1RjrTVl00kurJ
        RB+pr7AKXjx/OWZhaxmuShYOCukMZnXcDiMeh9NxwA==
X-Google-Smtp-Source: AA6agR4vrKugMncNQTjKe9Uv+geBOGHnKMSIYbmveMarldKIsOEUnMPeyJ7VXT9c3Y/iopeUkD6lKEEMjk6YAOAvaKM=
X-Received: by 2002:a05:6130:1102:b0:38c:49b4:bbc3 with SMTP id
 ce2-20020a056130110200b0038c49b4bbc3mr12440605uab.107.1662173976584; Fri, 02
 Sep 2022 19:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220902204351.2521805-1-keescook@chromium.org> <20220902204351.2521805-3-keescook@chromium.org>
In-Reply-To: <20220902204351.2521805-3-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 3 Sep 2022 10:59:24 +0800
Message-ID: <CABVgOS=Ru4Eu03T71svLA=j9jizGro44n3h59pQYw33QYPfLaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fortify: Add KUnit test for FORTIFY_SOURCE internals
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Sep 3, 2022 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> Add lib/fortify_kunit.c KUnit test for checking the expected behavioral
> characteristics of FORTIFY_SOURCE internals.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Sander Vanheule <sander@svanheule.net>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Overall, this looks good. It's a bit of a shame FORTIFY_SOURCE doesn't
work under UML, but I tested it on everything else I had to hand and
it looked good.

One tiny typo in a comment below, but otherwise this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  MAINTAINERS         |  1 +
>  lib/Kconfig.debug   |  9 ++++++
>  lib/Makefile        |  1 +
>  lib/fortify_kunit.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 lib/fortify_kunit.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..640115472199 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8002,6 +8002,7 @@ L:        linux-hardening@vger.kernel.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:     include/linux/fortify-string.h
> +F:     lib/fortify_kunit.c
>  F:     lib/test_fortify/*
>  F:     scripts/test_fortify.sh
>  K:     \b__NO_FORTIFY\b
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 36455953d306..1f267c0ddffd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2542,6 +2542,15 @@ config STACKINIT_KUNIT_TEST
>           CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
>           or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
>
> +config FORTIFY_KUNIT_TEST
> +       tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
> +       depends on KUNIT && FORTIFY_SOURCE
> +       default KUNIT_ALL_TESTS
> +       help
> +         Builds unit tests for checking internals of FORTIFY_SOURCE as used
> +         by the str*() and mem*() family of functions. For testing runtime
> +         traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index f545140ed9e7..4ee1ceae945a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -381,6 +381,7 @@ obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
>  obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>  CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
>  obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
> +obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> new file mode 100644
> index 000000000000..4d7930b65107
> --- /dev/null
> +++ b/lib/fortify_kunit.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Runtime test cases for CONFIG_FORTIFY_SOURCE that aren't expected to
> + * Oops th kernel on success. (For those, see drivers/misc/lkdtm/fortify.c)

Nit: Oops _the_ kernel

> + *
> + * For corner cases with UBSAN, try testing with:
> + *
> + * ./tools/testing/kunit/kunit.py run --arch=x86_64 \
> + *     --kconfig_add CONFIG_FORTIFY_SOURCE=y \
> + *     --kconfig_add CONFIG_UBSAN=y \
> + *     --kconfig_add CONFIG_UBSAN_TRAP=y \
> + *     --kconfig_add CONFIG_UBSAN_BOUNDS=y \
> + *     --kconfig_add CONFIG_UBSAN_LOCAL_BOUNDS=y \
> + *     --make_options LLVM=1 fortify
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +
> +static const char array_of_10[] = "this is 10";
> +static const char *ptr_of_11 = "this is 11!";
> +static char array_unknown[] = "compiler thinks I might change";
> +
> +static void known_sizes_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen(ptr_of_11), 11);
> +
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
> +       /* Externally defined and dynamically sized string pointer: */
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
> +}
> +
> +/* This is volatile so the optimizer can't perform DCE below. */
> +static volatile int pick;
> +
> +/* Not inline to keep optimizer from figuring out which string we want. */
> +static noinline size_t want_minus_one(int pick)
> +{
> +       const char *str;
> +
> +       switch (pick) {
> +       case 1:
> +               str = "4444";
> +               break;
> +       case 2:
> +               str = "333";
> +               break;
> +       default:
> +               str = "1";
> +               break;
> +       }
> +       return __compiletime_strlen(str);
> +}
> +
> +static void control_flow_split_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
> +}
> +
> +static struct kunit_case fortify_test_cases[] = {
> +       KUNIT_CASE(known_sizes_test),
> +       KUNIT_CASE(control_flow_split_test),
> +       {}
> +};
> +
> +static struct kunit_suite fortify_test_suite = {
> +       .name = "fortify",
> +       .test_cases = fortify_test_cases,
> +};
> +
> +kunit_test_suite(fortify_test_suite);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
