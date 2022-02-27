Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765D4C5E42
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiB0SqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiB0SqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D259A4F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bx5so9229431pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6m+DhiSNpp0WEg7Y2GFtce2qoilswFv9XNCymBz300=;
        b=adurY7lnz6k4Lj7dGkSWg3wTjUo42w1bdJZXLgnRdjA8hkoEPM7J4cvLrp/CrDlLZl
         Kp5lTQEv4oXe/qyvj2H1tsFXgV69fEpPRjxajXYVyMOv4OHWkZ3G6MpUWIT0wSgreplv
         PXCW9ylgqLq1EAmFd14NpGlzCdpa8Ed3aenmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6m+DhiSNpp0WEg7Y2GFtce2qoilswFv9XNCymBz300=;
        b=WAVholQWEbgXEoPwo7feDrGFcl47G8KQnPupjSiTvxI1zbzd8RVKNxpgWirUmC2wAa
         sd/iuUiHVrqXy3d7ptlpYHuSEY0x412/+hEvKdUGRah+gUx/iIV4nYMhVqqFNmEURPNO
         AaP4p0DQt/KAZBT9lHfFE5WXg5mhMlmxtzI8YocEKjNI2GnjJwpA1QVGfWEZss0cAM0B
         UzxmGt13dOCbA0+enpjygH1y1LM+SmC4tdr3Pt3K7yg0edrJiUz242Vv1b85+gLk0xwu
         2wMzeIgcUEXYP17Zx4Tun8l7cSnrKKW3TdgxykLM52sZZ5zvB4kdTIR3Kf+smZgrjNMN
         9ZYg==
X-Gm-Message-State: AOAM531mNOBPp3LvxIxApwVZ3uWsFHvb8EI3a/cVZjBDRfGchax+4bDg
        5V1lPUCknQ2gL4kV7rkikjMOCA==
X-Google-Smtp-Source: ABdhPJwSlhs6c8I9Lo6GGuabSIXJWoTu3k7tDJKSwX1nd4WRcf7i7kGNzdvNDJBsvRw8NeGFJP+y+Q==
X-Received: by 2002:a17:902:d4d1:b0:150:1d1c:30bd with SMTP id o17-20020a170902d4d100b001501d1c30bdmr15303539plg.1.1645987523611;
        Sun, 27 Feb 2022 10:45:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o10-20020a056a0015ca00b004e0ff94313esm11270971pfu.91.2022.02.27.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kbuild@vger.kernel.org, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 6/7] lib: stackinit: Convert to KUnit
Date:   Sun, 27 Feb 2022 10:45:16 -0800
Message-Id: <20220227184517.504931-7-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18150; h=from:subject; bh=UP9YVxfMlY8O0+NQMLGofpK4VLIvcpYgNEp/ewL3Cy0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a8zSAsXG7oEnfr4TxZoZxcd4Pag+vI1Jn94X84 /Vw1XsGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGvAAKCRCJcvTf3G3AJjCiD/ 0aDe79UaDsyIhrBubBQeRFGV5QTV312hqgfejYoVW3REqLHpl78/fSarG3KikpGeFhv1YY0RcRM+LB cK57iEymCQLba9GlFso5OpTJToY/PjfR7MdxaKgNDVPwQi2NMFIA7gyqoiKZsOBXxJ5x4jYCH1Eiim /B2r2PzGMQC1gXPAlZUi9SrWk7VG9xVFtI2d35Ki7YXslzg7B5/2lwufNFNBaLpoAszcwuKKGZ0xbE njN41caNWtAz1mNT6PlY2vpI/yLkQU38Zq4CdOmmTl8FVL1N+/fpBsc9dnhQcgbuxf2Tr+56NriT1/ y39P7GrZ/F6upX1PxoAMj2Q1FMFERWjLra2zRy8a9m8cxyGcrrkDP3CuqeyusBU0pfLYyQstsNFzhr D+NTQrT2sA8Owp5qm5oHhVqLK5ffOr8T23fQlfdaXqOlzQ0OLngadBP8F1MoMsIvaOM5M1c0W30RYl AK6fvvMbQVMzXs1KYhWTIYIy7saF7GE5bkGm8ILXL/bl9DSo1qKyCk1RakqLj+Uae9gEKF2R1DWBmZ u3kSM4yxBfl3kbobot0gBrqat9yf9vdWWka4EsDWulrAykZB5rGiUXgx4Cf2S62VwtKeVy9hj++1Rp zYZWWyU1BqVm+FQrm3AitOiotMe+NuQz/twVybOPywFHWrllAtWKN6S5obvQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert stackinit unit tests to KUnit, for better integration
into the kernel self test framework. Includes a rename of
test_stackinit.c to stackinit_kunit.c, and CONFIG_TEST_STACKINIT to
CONFIG_STACKINIT_KUNIT_TEST.

Adjust expected test results based on which stack initialization method
was chosen:

 $ CMD="./tools/testing/kunit/kunit.py run stackinit --raw_output \
        --arch=x86_64 --kconfig_add"

 $ $CMD | grep stackinit:
 # stackinit: pass:36 fail:0 skip:29 total:65

 $ $CMD CONFIG_GCC_PLUGIN_STRUCTLEAK_USER=y | grep stackinit:
 # stackinit: pass:37 fail:0 skip:28 total:65

 $ $CMD CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF=y | grep stackinit:
 # stackinit: pass:55 fail:0 skip:10 total:65

 $ $CMD CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y | grep stackinit:
 # stackinit: pass:62 fail:0 skip:3 total:65

 $ $CMD CONFIG_INIT_STACK_ALL_PATTERN=y --make_option LLVM=1 | grep stackinit:
 # stackinit: pass:60 fail:0 skip:5 total:65

 $ $CMD CONFIG_INIT_STACK_ALL_ZERO=y --make_option LLVM=1 | grep stackinit:
 # stackinit: pass:60 fail:0 skip:5 total:65

Temporarily remove the userspace-build mode, which will be restored in a
later patch.

Expand the size of the pre-case switch variable so it doesn't get
accidentally cleared.

Cc: David Gow <davidgow@google.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220224055145.1853657-1-keescook@chromium.org
v2:
 - split "userspace KUnit stub" into separate header and patch (Daniel)
 - Improve commit log and comments (David)
 - Provide mapping of expected XFAIL tests to CONFIGs (David)
---
 lib/Kconfig.debug                           |  22 +-
 lib/Makefile                                |   4 +-
 lib/{test_stackinit.c => stackinit_kunit.c} | 269 ++++++++------------
 3 files changed, 121 insertions(+), 174 deletions(-)
 rename lib/{test_stackinit.c => stackinit_kunit.c} (66%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14d90d03bc8d..a5556ab05240 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2511,6 +2511,17 @@ config OVERFLOW_KUNIT_TEST
 
 	  If unsure, say N.
 
+config STACKINIT_KUNIT_TEST
+	tristate "Test level of stack variable initialization" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Test if the kernel is zero-initializing stack variables and
+	  padding. Coverage is controlled by compiler flags,
+	  CONFIG_INIT_STACK_ALL_PATTERN, CONFIG_INIT_STACK_ALL_ZERO,
+	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
+	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
@@ -2602,17 +2613,6 @@ config TEST_OBJAGG
 	  Enable this option to test object aggregation manager on boot
 	  (or module load).
 
-
-config TEST_STACKINIT
-	tristate "Test level of stack variable initialization"
-	help
-	  Test if the kernel is zero-initializing stack variables and
-	  padding. Coverage is controlled by compiler flags,
-	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
-	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
-
-	  If unsure, say N.
-
 config TEST_MEMINIT
 	tristate "Test heap/page initialization"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index fdfcbfaff32f..353bc09ce38d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -93,8 +93,6 @@ obj-$(CONFIG_TEST_KMOD) += test_kmod.o
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
 obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
-CFLAGS_test_stackinit.o += $(call cc-disable-warning, switch-unreachable)
-obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
@@ -363,6 +361,8 @@ obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
+CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
+obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_stackinit.c b/lib/stackinit_kunit.c
similarity index 66%
rename from lib/test_stackinit.c
rename to lib/stackinit_kunit.c
index a3c74e6a21ff..35c69aa425b2 100644
--- a/lib/test_stackinit.c
+++ b/lib/stackinit_kunit.c
@@ -2,76 +2,21 @@
 /*
  * Test cases for compiler-based stack variable zeroing via
  * -ftrivial-auto-var-init={zero,pattern} or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
+ * For example, see:
+ * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
+ *	./tools/testing/kunit/kunit.py run stackinit [--raw_output] \
+ *		--make_option LLVM=1 \
+ *		--kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
  *
- * External build example:
- *	clang -O2 -Wall -ftrivial-auto-var-init=pattern \
- *		-o test_stackinit test_stackinit.c
  */
-#ifdef __KERNEL__
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 
-#else
-
-/* Userspace headers. */
-#include <stdio.h>
-#include <stdint.h>
-#include <string.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <sys/types.h>
-
-/* Linux kernel-ism stubs for stand-alone userspace build. */
-#define KBUILD_MODNAME		"stackinit"
-#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
-#define pr_err(fmt, ...)	fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warn(fmt, ...)	fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_info(fmt, ...)	fprintf(stdout, pr_fmt(fmt), ##__VA_ARGS__)
-#define __init			/**/
-#define __exit			/**/
-#define __user			/**/
-#define noinline		__attribute__((__noinline__))
-#define __aligned(x)		__attribute__((__aligned__(x)))
-#ifdef __clang__
-# define __compiletime_error(message) /**/
-#else
-# define __compiletime_error(message) __attribute__((__error__(message)))
-#endif
-#define __compiletime_assert(condition, msg, prefix, suffix)		\
-	do {								\
-		extern void prefix ## suffix(void) __compiletime_error(msg); \
-		if (!(condition))					\
-			prefix ## suffix();				\
-	} while (0)
-#define _compiletime_assert(condition, msg, prefix, suffix) \
-	__compiletime_assert(condition, msg, prefix, suffix)
-#define compiletime_assert(condition, msg) \
-	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
-#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
-#define BUILD_BUG_ON(condition) \
-	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
-typedef uint8_t			u8;
-typedef uint16_t		u16;
-typedef uint32_t		u32;
-typedef uint64_t		u64;
-
-#define module_init(func)	static int (*do_init)(void) = func
-#define module_exit(func)	static void (*do_exit)(void) = func
-#define MODULE_LICENSE(str)	int main(void) {		\
-					int rc;			\
-					/* License: str */	\
-					rc = do_init();		\
-					if (rc == 0)		\
-						do_exit();	\
-					return rc;		\
-				}
-
-#endif /* __KERNEL__ */
-
 /* Exfiltration buffer. */
 #define MAX_VAR_SIZE	128
 static u8 check_buf[MAX_VAR_SIZE];
@@ -201,7 +146,7 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
  */
 #define DEFINE_TEST_DRIVER(name, var_type, which, xfail)	\
 /* Returns 0 on success, 1 on failure. */			\
-static noinline __init int test_ ## name (void)			\
+static noinline void test_ ## name (struct kunit *test)		\
 {								\
 	var_type zero INIT_CLONE_ ## which;			\
 	int ignored;						\
@@ -220,10 +165,8 @@ static noinline __init int test_ ## name (void)			\
 	/* Verify all bytes overwritten with 0xFF. */		\
 	for (sum = 0, i = 0; i < target_size; i++)		\
 		sum += (check_buf[i] != 0xFF);			\
-	if (sum) {						\
-		pr_err(#name ": leaf fill was not 0xFF!?\n");	\
-		return 1;					\
-	}							\
+	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
+			    "leaf fill was not 0xFF!?\n");	\
 	/* Clear entire check buffer for later bit tests. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Extract stack-defined variable contents. */		\
@@ -231,32 +174,29 @@ static noinline __init int test_ ## name (void)			\
 				FETCH_ARG_ ## which(zero));	\
 								\
 	/* Validate that compiler lined up fill and target. */	\
-	if (!range_contains(fill_start, fill_size,		\
-			    target_start, target_size)) {	\
-		pr_err(#name ": stack fill missed target!?\n");	\
-		pr_err(#name ": fill %zu wide\n", fill_size);	\
-		pr_err(#name ": target offset by %d\n",	\
-			(int)((ssize_t)(uintptr_t)fill_start -	\
-			(ssize_t)(uintptr_t)target_start));	\
-		return 1;					\
-	}							\
+	KUNIT_ASSERT_TRUE_MSG(test,				\
+		range_contains(fill_start, fill_size,		\
+			    target_start, target_size),		\
+		"stack fill missed target!? "			\
+		"(fill %zu wide, target offset by %d)\n",	\
+		fill_size,					\
+		(int)((ssize_t)(uintptr_t)fill_start -		\
+		      (ssize_t)(uintptr_t)target_start));	\
 								\
 	/* Look for any bytes still 0xFF in check region. */	\
 	for (sum = 0, i = 0; i < target_size; i++)		\
 		sum += (check_buf[i] == 0xFF);			\
 								\
-	if (sum == 0) {						\
-		pr_info(#name " ok\n");				\
-		return 0;					\
-	} else {						\
-		pr_warn(#name " %sFAIL (uninit bytes: %d)\n",	\
-			(xfail) ? "X" : "", sum);		\
-		return (xfail) ? 0 : 1;				\
-	}							\
+	if (sum != 0 && xfail)					\
+		kunit_skip(test,				\
+			   "XFAIL uninit bytes: %d\n",		\
+			   sum);				\
+	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
+		"uninit bytes: %d\n", sum);			\
 }
 #define DEFINE_TEST(name, var_type, which, init_level, xfail)	\
 /* no-op to force compiler into ignoring "uninitialized" vars */\
-static noinline __init DO_NOTHING_TYPE_ ## which(var_type)	\
+static noinline DO_NOTHING_TYPE_ ## which(var_type)		\
 do_nothing_ ## name(var_type *ptr)				\
 {								\
 	/* Will always be true, but compiler doesn't know. */	\
@@ -265,9 +205,8 @@ do_nothing_ ## name(var_type *ptr)				\
 	else							\
 		return DO_NOTHING_RETURN_ ## which(ptr + 1);	\
 }								\
-static noinline __init int leaf_ ## name(unsigned long sp,	\
-					 bool fill,		\
-					 var_type *arg)		\
+static noinline int leaf_ ## name(unsigned long sp, bool fill,	\
+				  var_type *arg)		\
 {								\
 	char buf[VAR_BUFFER];					\
 	var_type var						\
@@ -341,6 +280,27 @@ struct test_user {
 	unsigned long four;
 };
 
+#define ALWAYS_PASS	WANT_SUCCESS
+#define ALWAYS_FAIL	XFAIL
+
+#ifdef CONFIG_INIT_STACK_NONE
+# define USER_PASS	XFAIL
+# define BYREF_PASS	XFAIL
+# define STRONG_PASS	XFAIL
+#elif defined(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER)
+# define USER_PASS	WANT_SUCCESS
+# define BYREF_PASS	XFAIL
+# define STRONG_PASS	XFAIL
+#elif defined(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)
+# define USER_PASS	WANT_SUCCESS
+# define BYREF_PASS	WANT_SUCCESS
+# define STRONG_PASS	XFAIL
+#else
+# define USER_PASS	WANT_SUCCESS
+# define BYREF_PASS	WANT_SUCCESS
+# define STRONG_PASS	WANT_SUCCESS
+#endif
+
 #define DEFINE_SCALAR_TEST(name, init, xfail)			\
 		DEFINE_TEST(name ## _ ## init, name, SCALAR,	\
 			    init, xfail)
@@ -364,27 +324,26 @@ struct test_user {
 		DEFINE_STRUCT_TEST(trailing_hole, init, xfail);	\
 		DEFINE_STRUCT_TEST(packed, init, xfail)
 
-#define DEFINE_STRUCT_INITIALIZER_TESTS(base)			\
+#define DEFINE_STRUCT_INITIALIZER_TESTS(base, xfail)		\
 		DEFINE_STRUCT_TESTS(base ## _ ## partial,	\
-				    WANT_SUCCESS);		\
-		DEFINE_STRUCT_TESTS(base ## _ ## all,		\
-				    WANT_SUCCESS)
+				    xfail);			\
+		DEFINE_STRUCT_TESTS(base ## _ ## all, xfail)
 
 /* These should be fully initialized all the time! */
-DEFINE_SCALAR_TESTS(zero, WANT_SUCCESS);
-DEFINE_STRUCT_TESTS(zero, WANT_SUCCESS);
+DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
+DEFINE_STRUCT_TESTS(zero, ALWAYS_PASS);
 /* Struct initializers: padding may be left uninitialized. */
-DEFINE_STRUCT_INITIALIZER_TESTS(static);
-DEFINE_STRUCT_INITIALIZER_TESTS(dynamic);
-DEFINE_STRUCT_INITIALIZER_TESTS(runtime);
-DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static);
-DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic);
-DEFINE_STRUCT_TESTS(assigned_copy, XFAIL);
+DEFINE_STRUCT_INITIALIZER_TESTS(static, STRONG_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(dynamic, STRONG_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(runtime, STRONG_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static, STRONG_PASS);
+DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic, STRONG_PASS);
+DEFINE_STRUCT_TESTS(assigned_copy, ALWAYS_FAIL);
 /* No initialization without compiler instrumentation. */
-DEFINE_SCALAR_TESTS(none, WANT_SUCCESS);
-DEFINE_STRUCT_TESTS(none, WANT_SUCCESS);
+DEFINE_SCALAR_TESTS(none, STRONG_PASS);
+DEFINE_STRUCT_TESTS(none, BYREF_PASS);
 /* Initialization of members with __user attribute. */
-DEFINE_TEST(user, struct test_user, STRUCT, none, WANT_SUCCESS);
+DEFINE_TEST(user, struct test_user, STRUCT, none, USER_PASS);
 
 /*
  * Check two uses through a variable declaration outside either path,
@@ -398,7 +357,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 		 * This is intentionally unreachable. To silence the
 		 * warning, build with -Wno-switch-unreachable
 		 */
-		uint64_t var;
+		uint64_t var[10];
 
 	case 1:
 		target_start = &var;
@@ -423,19 +382,19 @@ static int noinline __leaf_switch_none(int path, bool fill)
 		memcpy(check_buf, target_start, target_size);
 		break;
 	default:
-		var = 5;
-		return var & forced_mask;
+		var[1] = 5;
+		return var[1] & forced_mask;
 	}
 	return 0;
 }
 
-static noinline __init int leaf_switch_1_none(unsigned long sp, bool fill,
+static noinline int leaf_switch_1_none(unsigned long sp, bool fill,
 					      uint64_t *arg)
 {
 	return __leaf_switch_none(1, fill);
 }
 
-static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
+static noinline int leaf_switch_2_none(unsigned long sp, bool fill,
 					      uint64_t *arg)
 {
 	return __leaf_switch_none(2, fill);
@@ -447,68 +406,56 @@ static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
  * non-code areas (i.e. in a switch statement before the first "case").
  * https://bugs.llvm.org/show_bug.cgi?id=44916
  */
-DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, XFAIL);
-DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, XFAIL);
-
-static int __init test_stackinit_init(void)
-{
-	unsigned int failures = 0;
-
-#define test_scalars(init)	do {				\
-		failures += test_u8_ ## init ();		\
-		failures += test_u16_ ## init ();		\
-		failures += test_u32_ ## init ();		\
-		failures += test_u64_ ## init ();		\
-		failures += test_char_array_ ## init ();	\
-	} while (0)
-
-#define test_structs(init)	do {				\
-		failures += test_small_hole_ ## init ();	\
-		failures += test_big_hole_ ## init ();		\
-		failures += test_trailing_hole_ ## init ();	\
-		failures += test_packed_ ## init ();		\
-	} while (0)
-
+DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, ALWAYS_FAIL);
+DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, ALWAYS_FAIL);
+
+#define KUNIT_test_scalars(init)			\
+		KUNIT_CASE(test_u8_ ## init),		\
+		KUNIT_CASE(test_u16_ ## init),		\
+		KUNIT_CASE(test_u32_ ## init),		\
+		KUNIT_CASE(test_u64_ ## init),		\
+		KUNIT_CASE(test_char_array_ ## init)
+
+#define KUNIT_test_structs(init)			\
+		KUNIT_CASE(test_small_hole_ ## init),	\
+		KUNIT_CASE(test_big_hole_ ## init),	\
+		KUNIT_CASE(test_trailing_hole_ ## init),\
+		KUNIT_CASE(test_packed_ ## init)	\
+
+static struct kunit_case stackinit_test_cases[] = {
 	/* These are explicitly initialized and should always pass. */
-	test_scalars(zero);
-	test_structs(zero);
+	KUNIT_test_scalars(zero),
+	KUNIT_test_structs(zero),
 	/* Padding here appears to be accidentally always initialized? */
-	test_structs(dynamic_partial);
-	test_structs(assigned_dynamic_partial);
+	KUNIT_test_structs(dynamic_partial),
+	KUNIT_test_structs(assigned_dynamic_partial),
 	/* Padding initialization depends on compiler behaviors. */
-	test_structs(static_partial);
-	test_structs(static_all);
-	test_structs(dynamic_all);
-	test_structs(runtime_partial);
-	test_structs(runtime_all);
-	test_structs(assigned_static_partial);
-	test_structs(assigned_static_all);
-	test_structs(assigned_dynamic_all);
+	KUNIT_test_structs(static_partial),
+	KUNIT_test_structs(static_all),
+	KUNIT_test_structs(dynamic_all),
+	KUNIT_test_structs(runtime_partial),
+	KUNIT_test_structs(runtime_all),
+	KUNIT_test_structs(assigned_static_partial),
+	KUNIT_test_structs(assigned_static_all),
+	KUNIT_test_structs(assigned_dynamic_all),
 	/* Everything fails this since it effectively performs a memcpy(). */
-	test_structs(assigned_copy);
-
+	KUNIT_test_structs(assigned_copy),
 	/* STRUCTLEAK_BYREF_ALL should cover everything from here down. */
-	test_scalars(none);
-	failures += test_switch_1_none();
-	failures += test_switch_2_none();
-
+	KUNIT_test_scalars(none),
+	KUNIT_CASE(test_switch_1_none),
+	KUNIT_CASE(test_switch_2_none),
 	/* STRUCTLEAK_BYREF should cover from here down. */
-	test_structs(none);
-
+	KUNIT_test_structs(none),
 	/* STRUCTLEAK will only cover this. */
-	failures += test_user();
-
-	if (failures == 0)
-		pr_info("all tests passed!\n");
-	else
-		pr_err("failures: %u\n", failures);
+	KUNIT_CASE(test_user),
+	{}
+};
 
-	return failures ? -EINVAL : 0;
-}
-module_init(test_stackinit_init);
+static struct kunit_suite stackinit_test_suite = {
+	.name = "stackinit",
+	.test_cases = stackinit_test_cases,
+};
 
-static void __exit test_stackinit_exit(void)
-{ }
-module_exit(test_stackinit_exit);
+kunit_test_suites(&stackinit_test_suite);
 
 MODULE_LICENSE("GPL");
-- 
2.32.0

