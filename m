Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B04C23BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiBXFwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBXFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:52:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C93A5C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:51:51 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 27so863865pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUyrVsxYKzoFXKEYN9KHshPWuvPSKnqtcectixQDdQA=;
        b=Lbru/te6+kMRTjvUPe6/c0OL2WO1aHlKicgqg7B/KwubT3p7wYIJEMmZV7GgWni2ud
         BOSr80DH6D0KpZ0D3ewCD7LroBuXW0/QDMkSBAh9WrC/GcMNbxjyGb6OB+AdNiE9x4oQ
         u472yFu3hXhI5hhyxxsZiH1B2o9sQnAN851q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUyrVsxYKzoFXKEYN9KHshPWuvPSKnqtcectixQDdQA=;
        b=G4DxGdOD+/rHpdpL1l9SbeEdqQsqT/dFOavaq50i3SajTqKl6OtWNHSSgeCH71JCo/
         W7FdqdYn1+nxI07P7opcE4pQsvXXiNO5tN/NOhPnwiJUHyhdGTqM4Z1JkFSTu35PXviJ
         kHbsOe7nq6yc635g1KKKAy5KLPnP3NNZXUux2GD1Duh7UeWRKVs/DdeOmMgIoD9qC2Zy
         pkLBSrpDSDVwae+3hjm3TUpQpmNIjwJwg50RJWWJGg66XxukR1ZPB2oF7SNmoCCW9u7f
         RMqU0R5B2pUvcgrUxrhFmoVfW6Q0jsMqzMpfKZzTg+lsC/w4coZIrDPb3nFs8k2f076O
         Cy1A==
X-Gm-Message-State: AOAM533kyYCdec1sVONdFnhNgMJ+IphWsn+NVinfjqjX8q4GQKaHH5Up
        tmAmamFq6ZFjOe5FabO+w3eJYw==
X-Google-Smtp-Source: ABdhPJyWqW022zP+VhqjaBgpl6IyiWL5VlMdsOaiRefGCiJNqWJTo12HZe6tE+oBFxMUddTqA4ZwjA==
X-Received: by 2002:a62:7c11:0:b0:4e1:7ede:9ca9 with SMTP id x17-20020a627c11000000b004e17ede9ca9mr1323703pfc.84.1645681911074;
        Wed, 23 Feb 2022 21:51:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm1631017pfi.128.2022.02.23.21.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:51:50 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Latypov <dlatypov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] lib: stackinit: Convert to KUnit
Date:   Wed, 23 Feb 2022 21:51:45 -0800
Message-Id: <20220224055145.1853657-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18875; h=from:subject; bh=sQRRbxC2wQHKsdqLZkkKVYTj8xOlF68e/7m0dcGgcAk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFxzx4WFvDH4fan7k6u/tKd6C7zWg6tgBgrx06Hil Ge/wcmmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcc8QAKCRCJcvTf3G3AJuAxD/ 0WCHcH2w2UvY0Ur2uoEGKsyaldv3JxfscUsQeQ3ervs7ZOkZ7QkPOuAZAFB6KJa8UuULbR0zDmWraR gva24JeTka+ZVvywA6TsqqQ7wgUkuhxhNm0KzqyR5BZbA1CV/MMCBNADeIqcBocmlSshOobZ9H83ur L7K8oqJWmu6++hVZW22wq004lQQxPX8sGecAxAF23EuhmvHs9OqQx0/GW3R0pbS7U0EtZj526LaoZv YMCzfJFBTCIXpm/Pge7XjpK+nwWiiBWfhyErj3aRzRajMQs99SmiTd3Qggr8vBwoC9vplTp8DpxpLM TSVaAksAOiNIEnrHkAmTUkxJL0tpu6fkmI4ZmPYE3Co3+OvdeZErXsVw1GQIGU2RAf7LepkQsg4ULU Q1VnWeaa0x1ayN0Rro0ZswxzY2l8RlNgnQp7XCbmezXzQJXzBaOlfUuI+UHRZQrdrBiivO4ADP/9/7 Hu60bslQRv5kAG1MsQpDF31tvUIPX9NI5VhKatYAK4anVI0xHRKn9NCN4y7y7DQugCarN1Ok63EdWw FnyszicvaWAeIcbycZo3di/FIOhcSMVUitCtsloXEXCpfQuqTuH91Vs16WHYc1XL25TEKz0aGM1oIm 67AQu21aduPgUPzb2o6y3K797ceLErFV+1Ar/q9wJTAPmj15zQRS77dSRf5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to running under Kunit (and retain being able to run stand-alone
too). Building under Clang (or GCC 12) with CONFIG_INIT_STACK_ALL_ZERO=y,
this now passes as expected:

$ ./tools/testing/kunit/kunit.py config --make_option LLVM=1
$ ./tools/testing/kunit/kunit.py run overflow --make_option LLVM=1 \
	--kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
...
[09:47:28] ================= stackinit (65 subtests) ==================
[09:47:28] [PASSED] test_u8_zero
[09:47:28] [PASSED] test_u16_zero
[09:47:28] [PASSED] test_u32_zero
[09:47:28] [PASSED] test_u64_zero
[09:47:28] [PASSED] test_char_array_zero
[09:47:28] [PASSED] test_small_hole_zero
[09:47:28] [PASSED] test_big_hole_zero
[09:47:28] [PASSED] test_trailing_hole_zero
[09:47:28] [PASSED] test_packed_zero
[09:47:28] [PASSED] test_small_hole_dynamic_partial
[09:47:28] [PASSED] test_big_hole_dynamic_partial
[09:47:28] [PASSED] test_trailing_hole_dynamic_partial
[09:47:28] [PASSED] test_packed_dynamic_partial
[09:47:28] [PASSED] test_small_hole_assigned_dynamic_partial
[09:47:28] [PASSED] test_big_hole_assigned_dynamic_partial
[09:47:28] [PASSED] test_trailing_hole_assigned_dynamic_partial
[09:47:28] [PASSED] test_packed_assigned_dynamic_partial
[09:47:28] [PASSED] test_small_hole_static_partial
[09:47:28] [PASSED] test_big_hole_static_partial
[09:47:28] [PASSED] test_trailing_hole_static_partial
[09:47:28] [PASSED] test_packed_static_partial
[09:47:28] [PASSED] test_small_hole_static_all
[09:47:28] [PASSED] test_big_hole_static_all
[09:47:28] [PASSED] test_trailing_hole_static_all
[09:47:28] [PASSED] test_packed_static_all
[09:47:28] [PASSED] test_small_hole_dynamic_all
[09:47:28] [PASSED] test_big_hole_dynamic_all
[09:47:28] [PASSED] test_trailing_hole_dynamic_all
[09:47:28] [PASSED] test_packed_dynamic_all
[09:47:28] [PASSED] test_small_hole_runtime_partial
[09:47:28] [PASSED] test_big_hole_runtime_partial
[09:47:28] [PASSED] test_trailing_hole_runtime_partial
[09:47:28] [PASSED] test_packed_runtime_partial
[09:47:28] [PASSED] test_small_hole_runtime_all
[09:47:28] [PASSED] test_big_hole_runtime_all
[09:47:28] [PASSED] test_trailing_hole_runtime_all
[09:47:28] [PASSED] test_packed_runtime_all
[09:47:28] [PASSED] test_small_hole_assigned_static_partial
[09:47:28] [PASSED] test_big_hole_assigned_static_partial
[09:47:28] [PASSED] test_trailing_hole_assigned_static_partial
[09:47:28] [PASSED] test_packed_assigned_static_partial
[09:47:28] [PASSED] test_small_hole_assigned_static_all
[09:47:28] [PASSED] test_big_hole_assigned_static_all
[09:47:28] [PASSED] test_trailing_hole_assigned_static_all
[09:47:28] [PASSED] test_packed_assigned_static_all
[09:47:28] [PASSED] test_small_hole_assigned_dynamic_all
[09:47:28] [PASSED] test_big_hole_assigned_dynamic_all
[09:47:28] [PASSED] test_trailing_hole_assigned_dynamic_all
[09:47:28] [PASSED] test_packed_assigned_dynamic_all
[09:47:28] [SKIPPED] test_small_hole_assigned_copy
[09:47:28] [SKIPPED] test_big_hole_assigned_copy
[09:47:28] [SKIPPED] test_trailing_hole_assigned_copy
[09:47:28] [PASSED] test_packed_assigned_copy
[09:47:28] [PASSED] test_u8_none
[09:47:28] [PASSED] test_u16_none
[09:47:28] [PASSED] test_u32_none
[09:47:28] [PASSED] test_u64_none
[09:47:28] [PASSED] test_char_array_none
[09:47:28] [SKIPPED] test_switch_1_none
[09:47:28] [SKIPPED] test_switch_2_none
[09:47:28] [PASSED] test_small_hole_none
[09:47:28] [PASSED] test_big_hole_none
[09:47:28] [PASSED] test_trailing_hole_none
[09:47:28] [PASSED] test_packed_none
[09:47:28] [PASSED] test_user
[09:47:28] ==================== [PASSED] stackinit ====================
[09:47:28] ============================================================
[09:47:28] Testing complete. Passed: 60, Failed: 0, Crashed: 0, Skipped: 5, Errors: 0
[09:47:28] Elapsed time: 4.192s total, 0.001s configuring, 4.070s building, 0.102s running

Cc: David Gow <davidgow@google.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug                           |  26 +-
 lib/Makefile                                |   4 +-
 lib/{test_stackinit.c => stackinit_kunit.c} | 249 ++++++++++++--------
 3 files changed, 168 insertions(+), 111 deletions(-)
 rename lib/{test_stackinit.c => stackinit_kunit.c} (73%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14d90d03bc8d..ea4415275563 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2511,6 +2511,21 @@ config OVERFLOW_KUNIT_TEST
 
 	  If unsure, say N.
 
+config STACKINIT_KUNIT_TEST
+	tristate "Test level of stack variable initialization" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Test if the kernel is zero-initializing stack variables and
+	  padding. Coverage is controlled by compiler flags,
+	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
+	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
@@ -2602,17 +2617,6 @@ config TEST_OBJAGG
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
similarity index 73%
rename from lib/test_stackinit.c
rename to lib/stackinit_kunit.c
index a3c74e6a21ff..72c7d4cb8ed2 100644
--- a/lib/test_stackinit.c
+++ b/lib/stackinit_kunit.c
@@ -2,14 +2,23 @@
 /*
  * Test cases for compiler-based stack variable zeroing via
  * -ftrivial-auto-var-init={zero,pattern} or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
+ * For example, see:
+ * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
+ *	./tools/testing/kunit/kunit.py config --make_option LLVM=1
+ *	./tools/testing/kunit/kunit.py run overflow [--raw_output] \
+ *		--make_option LLVM=1 \
+ *		--kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
  *
  * External build example:
  *	clang -O2 -Wall -ftrivial-auto-var-init=pattern \
- *		-o test_stackinit test_stackinit.c
+ *		-o stackinit_kunit stackinit_kunit.c
+ *	./stackinit_kunit
+ *
  */
 #ifdef __KERNEL__
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -18,21 +27,55 @@
 #else
 
 /* Userspace headers. */
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <sys/types.h>
 
 /* Linux kernel-ism stubs for stand-alone userspace build. */
-#define KBUILD_MODNAME		"stackinit"
-#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
-#define pr_err(fmt, ...)	fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warn(fmt, ...)	fprintf(stderr, pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_info(fmt, ...)	fprintf(stdout, pr_fmt(fmt), ##__VA_ARGS__)
-#define __init			/**/
-#define __exit			/**/
+#define TEST_PASS	0
+#define TEST_SKIP	1
+#define TEST_FAIL	2
+struct kunit {
+	int status;
+	char *msg;
+};
+struct kunit_case {
+        void (*run_case)(struct kunit *test);
+        const char *name;
+};
+struct kunit_suite {
+	const char *name;
+	const struct kunit_case *test_cases;
+};
+#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+#define KUNIT_ASSERT_TRUE_MSG(test, expr, fmt, ...)			\
+do {									\
+	if (!(expr)) {							\
+		if (test->status != TEST_SKIP)				\
+			test->status = TEST_FAIL;			\
+		if (test->msg)						\
+			free(test->msg);				\
+		asprintf(&test->msg, fmt, ##__VA_ARGS__);		\
+	}								\
+} while (0)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		\
+	KUNIT_ASSERT_TRUE_MSG(test, (left) == (right), fmt, ##__VA_ARGS__)
+
+#define kunit_skip(test, fmt, ...)					\
+do {									\
+	test->status = TEST_SKIP;					\
+	if (test->msg)							\
+		free(test->msg);					\
+	asprintf(&test->msg, fmt, ##__VA_ARGS__);			\
+} while (0)
+
 #define __user			/**/
 #define noinline		__attribute__((__noinline__))
 #define __aligned(x)		__attribute__((__aligned__(x)))
@@ -59,16 +102,44 @@ typedef uint16_t		u16;
 typedef uint32_t		u32;
 typedef uint64_t		u64;
 
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
+#define MODULE_LICENSE(str)	/* */
+
+int do_kunit_test_suite(struct kunit_suite *suite)
+{
+	const struct kunit_case *test_case;
+	int rc = 0;
+
+	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
+		struct kunit test = { };
+
+		test_case->run_case(&test);
+		switch (test.status) {
+		default:
+		case TEST_FAIL:
+			fprintf(stderr, "FAIL: %s%s%s", test_case->name,
+				test.msg ? ": " : "",
+				test.msg ?: "\n");
+			rc = 1;
+			break;
+		case TEST_SKIP:
+			fprintf(stdout, "XFAIL: %s%s%s", test_case->name,
+				test.msg ? ": " : "",
+				test.msg ?: "\n");
+			break;
+		case TEST_PASS:
+			fprintf(stdout, "ok: %s\n", test_case->name);
+			break;
+		}
+		if (test.msg)
+			free(test.msg);
+	}
+	return rc;
+}
+
+#define kunit_test_suite(suite)					\
+int main(void) {						\
+	return do_kunit_test_suite(&(suite));			\
+}
 
 #endif /* __KERNEL__ */
 
@@ -201,7 +272,7 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
  */
 #define DEFINE_TEST_DRIVER(name, var_type, which, xfail)	\
 /* Returns 0 on success, 1 on failure. */			\
-static noinline __init int test_ ## name (void)			\
+static noinline void test_ ## name (struct kunit *test)		\
 {								\
 	var_type zero INIT_CLONE_ ## which;			\
 	int ignored;						\
@@ -220,10 +291,8 @@ static noinline __init int test_ ## name (void)			\
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
@@ -231,32 +300,29 @@ static noinline __init int test_ ## name (void)			\
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
@@ -265,9 +331,8 @@ do_nothing_ ## name(var_type *ptr)				\
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
@@ -398,7 +463,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 		 * This is intentionally unreachable. To silence the
 		 * warning, build with -Wno-switch-unreachable
 		 */
-		uint64_t var;
+		uint64_t var[10];
 
 	case 1:
 		target_start = &var;
@@ -423,19 +488,19 @@ static int noinline __leaf_switch_none(int path, bool fill)
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
@@ -450,65 +515,53 @@ static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
 DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, XFAIL);
 DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, XFAIL);
 
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
+#define KUNIT_test_scalars(init)			\
+		KUNIT_CASE(test_u8_ ## init),		\
+		KUNIT_CASE(test_u16_ ## init),		\
+		KUNIT_CASE(test_u32_ ## init),		\
+		KUNIT_CASE(test_u64_ ## init),		\
+		KUNIT_CASE(test_char_array_ ## init)
 
-#define test_structs(init)	do {				\
-		failures += test_small_hole_ ## init ();	\
-		failures += test_big_hole_ ## init ();		\
-		failures += test_trailing_hole_ ## init ();	\
-		failures += test_packed_ ## init ();		\
-	} while (0)
+#define KUNIT_test_structs(init)			\
+		KUNIT_CASE(test_small_hole_ ## init),	\
+		KUNIT_CASE(test_big_hole_ ## init),	\
+		KUNIT_CASE(test_trailing_hole_ ## init),\
+		KUNIT_CASE(test_packed_ ## init)	\
 
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
+kunit_test_suite(stackinit_test_suite);
 
 MODULE_LICENSE("GPL");
-- 
2.30.2

