Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD44C5FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiB0XOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB0XOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:14:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293FF255B7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 15:14:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id l19so9442773pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEz8S7bFkwneq3PE9tC9dbzJqghqcLtq6Jn9Mzewnt8=;
        b=GnJnp52S2sgob7YzJQwUJ2E/C4ktnqkOB3F8UtNdCrRtL2BOTqvlTf79FozbBrvB1T
         OjFClYb6wrMcn4OIpJ7BZTtHDzJcrxoXoDUcuCGT4h9ZcOG+3qFO+V2SevTtNATYh6U1
         C/Z6Jm3J2Vc0y3lSAVJ/MGGqDkzyu7vj8gTQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEz8S7bFkwneq3PE9tC9dbzJqghqcLtq6Jn9Mzewnt8=;
        b=AruZ644gqbYBzpMdCf6ljIPJWly/np7OnfidtM5nLHprhT83oVzmj9b4VqYB+M5ntO
         oq70GCTU1ver3JlXuN9a/ibm9SmLGmwH/ZJDYKCtp4NKsaGbItGS2f1L+YnLrmpQwgfb
         SxyobbL0yTHQdrJCfs9OHeKsfZAfg+ZObtKYyKc47uMgANLTDSKExaO8fEZiNlO7OBr1
         L9xlWDXrYoP26jmgtC5bNlZm8DaVqma0Qnt6C0RICJ0WyM+mnqcG+2ChlI/TYqmTrErz
         V+v003TXc5wWs8dlDDEFMzirFkNq/vMyIBnmKpovG90yjTn8SyYzYv2DCcrkE+0nwRYs
         SZWA==
X-Gm-Message-State: AOAM530kTG0w776s5l97B+pymkgYdrJtYS+VAS7adk5NHUWtFARLEnhc
        a7SnfmwJxl9ZwpFMFAWfSvrErA==
X-Google-Smtp-Source: ABdhPJwHXwSmdwy1jcXiNiohtMPQbFABBWndNv7Rc+IH8LJGX+ZYl0dMjBxKzDu/5pFtY9Up6dz9aQ==
X-Received: by 2002:a63:fb44:0:b0:372:9ec8:745a with SMTP id w4-20020a63fb44000000b003729ec8745amr15051137pgj.551.1646003647597;
        Sun, 27 Feb 2022 15:14:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3-20020a056a00114300b004e099ec2871sm10766165pfm.154.2022.02.27.15.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 15:14:07 -0800 (PST)
Date:   Sun, 27 Feb 2022 15:14:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
Message-ID: <202202271513.3756A55EF7@keescook>
References: <20220227184517.504931-1-keescook@chromium.org>
 <20220227184517.504931-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227184517.504931-8-keescook@chromium.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 10:45:17AM -0800, Kees Cook wrote:
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

This fails the hdrtest checks, so I'll need to rework it...

-Kees

> ---
> v1: https://lore.kernel.org/lkml/20220224055145.1853657-1-keescook@chromium.org
> v2:
>  - split from stackinit_kunit.c refactoring patch
>  - add missing returns (Daniel)
>  - report expression mismatch in assert msg (Daniel)
>  - emulate kunit_test_suites() (Daniel)
>  - emit valid KTAP (David)
> ---
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
> +#define __user			/**/
> +#define noinline		__attribute__((__noinline__))
> +#define __aligned(x)		__attribute__((__aligned__(x)))
> +#ifdef __clang__
> +# define __compiletime_error(message) /**/
> +#else
> +# define __compiletime_error(message) __attribute__((__error__(message)))
> +#endif
> +#define __compiletime_assert(condition, msg, prefix, suffix)		\
> +	do {								\
> +		extern void prefix ## suffix(void) __compiletime_error(msg); \
> +		if (!(condition))					\
> +			prefix ## suffix();				\
> +	} while (0)
> +#define _compiletime_assert(condition, msg, prefix, suffix) \
> +	__compiletime_assert(condition, msg, prefix, suffix)
> +#define compiletime_assert(condition, msg) \
> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> +#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> +#define BUILD_BUG_ON(condition) \
> +	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> +
> +#define ARRAY_SIZE(a)		(sizeof (a) / sizeof ((a)[0]))
> +
> +#define MODULE_LICENSE(str)	/* str */
> +
> +typedef uint8_t			u8;
> +typedef uint16_t		u16;
> +typedef uint32_t		u32;
> +typedef uint64_t		u64;
> +
> +#define TEST_PASS	0
> +#define TEST_SKIP	1
> +#define TEST_FAIL	2
> +struct kunit {
> +	int status;
> +	char *msg;
> +};
> +struct kunit_case {
> +        void (*run_case)(struct kunit *test);
> +        const char *name;
> +};
> +struct kunit_suite {
> +	const char *name;
> +	const struct kunit_case *test_cases;
> +};
> +#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +
> +#define KUNIT_ASSERT_TRUE_MSG(test, expr, fmt, ...)			\
> +do {									\
> +	if (!(expr)) {							\
> +		if (test->status != TEST_SKIP)				\
> +			test->status = TEST_FAIL;			\
> +		if (test->msg)						\
> +			free(test->msg);				\
> +		asprintf(&test->msg, fmt, ##__VA_ARGS__);		\
> +		return;							\
> +	}								\
> +} while (0)
> +
> +#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		\
> +	KUNIT_ASSERT_TRUE_MSG(test, (left) == (right),			\
> +			      #left " != " #right ": " fmt,		\
> +			      ##__VA_ARGS__)
> +
> +#define kunit_skip(test, fmt, ...)					\
> +do {									\
> +	test->status = TEST_SKIP;					\
> +	if (test->msg)							\
> +		free(test->msg);					\
> +	asprintf(&test->msg, fmt, ##__VA_ARGS__);			\
> +	return;								\
> +} while (0)
> +
> +static int do_kunit_test_suite(struct kunit_suite *suite)
> +{
> +	const struct kunit_case *test_case;
> +	int pass = 0, fail = 0, skip = 0;
> +	int rc = 0;
> +	size_t i = 0;
> +
> +	printf("  TAP version 14\n");
> +	for (test_case = suite->test_cases; test_case->run_case; test_case++)
> +		i++;
> +	printf("  1..%zu\n", i);
> +	i = 0;
> +	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
> +		struct kunit test = { };
> +
> +		i++;
> +		test_case->run_case(&test);
> +		switch (test.status) {
> +		default:
> +		case TEST_FAIL:
> +			fprintf(stderr, "  not ok %zu - %s%s%s",
> +				i, test_case->name,
> +				test.msg ? " # ERROR " : "",
> +				test.msg ?: "\n");
> +			rc = 1;
> +			fail++;
> +			break;
> +		case TEST_SKIP:
> +			fprintf(stdout, "  ok %zu - %s # SKIP%s%s",
> +				i, test_case->name,
> +				test.msg ? " " : "",
> +				test.msg ?: "\n");
> +			skip++;
> +			break;
> +		case TEST_PASS:
> +			fprintf(stdout, "  ok %zu - %s\n",
> +				i, test_case->name);
> +			pass++;
> +			break;
> +		}
> +		if (test.msg)
> +			free(test.msg);
> +	}
> +	printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
> +		suite->name, pass, fail, skip, i);
> +	return rc;
> +}
> +
> +static int run_suites(char *name, struct kunit_suite *suites[], size_t count)
> +{
> +	int pass = 0, fail = 0, skip = 0;
> +	int one, ret = 0;
> +	size_t i;
> +
> +	printf("TAP version 14\n");
> +	printf("1..%zu\n", count);
> +	for (i = 0; i < count; ++i) {
> +		one = do_kunit_test_suite(suites[i]);
> +		switch (one) {
> +		case TEST_SKIP:
> +			skip++;
> +			break;
> +		case TEST_PASS:
> +			pass++;
> +			break;
> +		default:
> +			fail++;
> +			break;
> +		}
> +		printf("%sok %zu - %s\n",
> +			one == TEST_FAIL ? "not " : "",
> +			i + 1, suites[i]->name);
> +		ret |= one;
> +	}
> +	printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
> +		name, pass, fail, skip, count);
> +	return ret;
> +}
> +
> +#define kunit_test_suites(suite...)				\
> +int main(int argc, char *argv[]) {				\
> +	static struct kunit_suite *suites[] = { suite };	\
> +	return run_suites(argv[0], suites, ARRAY_SIZE(suites));	\
> +}
> +
> +#endif /* __UAPI_MISC_KUNIT_H__ */
> diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
> index 35c69aa425b2..6d468630c90a 100644
> --- a/lib/stackinit_kunit.c
> +++ b/lib/stackinit_kunit.c
> @@ -8,7 +8,13 @@
>   *		--make_option LLVM=1 \
>   *		--kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
>   *
> + * External build example:
> + *	clang -O2 -Wall -ftrivial-auto-var-init=pattern \
> + *		-o stackinit_kunit stackinit_kunit.c
> + *	./stackinit_kunit
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
>  #define MAX_VAR_SIZE	128
>  static u8 check_buf[MAX_VAR_SIZE];
> -- 
> 2.32.0
> 

-- 
Kees Cook
