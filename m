Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610765AB990
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiIBUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIBUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:43:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467CFFC30C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:43:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mj6so3100684pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=11eq7C02DkLHkN1mpM6ixOmAQBAalq2XQGnZ/0wFgUE=;
        b=YekDNkaDEXx3tOwqZSpb28rswmxi6VukTDlHFMFbuzo4drdNePzLNrvB8BSgxPbwzr
         Sw7t3v65kjlbaJcfVwI/9f7FEpNB5AvNv9+V0DRA6TDdmhZVKwto4ecN+D4Vakhbors0
         O4diPe0rk0iti//UvXUxKbvepriRjKqo7GO44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=11eq7C02DkLHkN1mpM6ixOmAQBAalq2XQGnZ/0wFgUE=;
        b=ESLqqOrobN3AYJ9pGL5A4XKst6v2RIlJ+ll0IvmbRauMTetLfe1QzmBZSEq92I5WUo
         F0w9uGdk6NLsWM+h5CHA1G2xL1yFGokBI39FWwVzmcW3oExnzUuJwUUqvMHQ7WL+JiWV
         MRRzNMoWaRiKTd0ZbDjMsp3KlyyA9z90n51DflKtdZp5ajsKhGOYiO8R9hRzFFxF8sZo
         1EjJcPueZzomQ+l0AVBVQbllpm2IyUnAtDdAEkl4rwXvvphMbsfy6IQDLbGPsqlOgMIr
         S7I0fmKlnr/GLWzyRl6lIiJtKbqFw07BLhIFKwiJ7iY713Ehso5cI8CJalDjOxfRgHYH
         t68Q==
X-Gm-Message-State: ACgBeo2vTnbhuQu9Eb31IAGdOqDTqk6yngrVvJoMcFN5fjhod8x6Gd6M
        v1Y8iM2WUNyXac54NS8QL0pKhg==
X-Google-Smtp-Source: AA6agR5EIIBM1SzL1l5QK6QislgosQ1gopreWOv6IaGskuQlsesx6oKdIhDCE2fIibxIAgqPEIXrqw==
X-Received: by 2002:a17:903:11c7:b0:170:cde7:d24a with SMTP id q7-20020a17090311c700b00170cde7d24amr37435905plh.91.1662151435118;
        Fri, 02 Sep 2022 13:43:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b0017297a6b39dsm2107978plx.265.2022.09.02.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:43:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
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
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] fortify: Add KUnit test for FORTIFY_SOURCE internals
Date:   Fri,  2 Sep 2022 13:43:50 -0700
Message-Id: <20220902204351.2521805-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902204351.2521805-1-keescook@chromium.org>
References: <20220902204351.2521805-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5052; h=from:subject; bh=EhBou5R7iywWQm92DBW52vtC8yIHPBoPeRV2MePXGPs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEmsHkVjN+RQcAgkUEMuTHUDCp68OjSiaM44cDvJo 0E3u/CSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxJrBwAKCRCJcvTf3G3AJmN5EA Cd3Ipn2P0PeDGd5LAmQjiUDnlS0Rd4tQKQ4Hpmk59gXWJs4yTG9tpBJBVeWrRgWXVGNEaa1b3GOWzU TSj/pa/BUlkoIGHep9AuZHfO97eaDz8d5RY9K6QSd/RmE+oZ7netglOF7KQxHvAeyTseNR+xkEeuLc Y8GxSowoYzISzgA3+giN4pHHZ9D+ekb7wk+L/YR/wYP1MF9OLvz8Y8AMk76urAPTp381TfOhW+p81S jI53/LMHNwGwIWxBCM3b/+6582Zpu2916LHtYdx+oIn7HyApPNyZeGadvilheiUVFLzG93/wD/kvLR l4ZnJzecvKIr/kAVRCpmk3t2CXc4ONOkiyvTAdV4NwLeJa3HJY7AfBePRfZ8C2kSDqq6uVMBbXvtUV dC5OrQlIUIxHOs3HFTr3ZC/K7LRzPfRGpVeq8DkCaQuwKmQB5s5qkKOI2jmvr28hrGv6JHS6eAHHSE E4KZaWI3/blzV/kUHE3k8DNaO2B7lLnkk1ypltg/uWJzw4odve2oRl24DBGYDzU0bkK4ZdRJLMDfju cX8sQU+3Dt8iVag+HGm001Y9aLpFZhjfSwrDCErbmgzXTEMwOgD2PcSquny73x2ncADSz4nWuEwUtB SMEIa7Zh02gVoAKaBia2CgBDLpYddX6HlaGfh5Qy47K5Ko/Ftxs7YSJR4fuA==
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

Add lib/fortify_kunit.c KUnit test for checking the expected behavioral
characteristics of FORTIFY_SOURCE internals.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: David Gow <davidgow@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Sander Vanheule <sander@svanheule.net>
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS         |  1 +
 lib/Kconfig.debug   |  9 ++++++
 lib/Makefile        |  1 +
 lib/fortify_kunit.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 lib/fortify_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..640115472199 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8002,6 +8002,7 @@ L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/fortify-string.h
+F:	lib/fortify_kunit.c
 F:	lib/test_fortify/*
 F:	scripts/test_fortify.sh
 K:	\b__NO_FORTIFY\b
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 36455953d306..1f267c0ddffd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2542,6 +2542,15 @@ config STACKINIT_KUNIT_TEST
 	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
 	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
 
+config FORTIFY_KUNIT_TEST
+	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT && FORTIFY_SOURCE
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
+	  by the str*() and mem*() family of functions. For testing runtime
+	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index f545140ed9e7..4ee1ceae945a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -381,6 +381,7 @@ obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
+obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
new file mode 100644
index 000000000000..4d7930b65107
--- /dev/null
+++ b/lib/fortify_kunit.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Runtime test cases for CONFIG_FORTIFY_SOURCE that aren't expected to
+ * Oops th kernel on success. (For those, see drivers/misc/lkdtm/fortify.c)
+ *
+ * For corner cases with UBSAN, try testing with:
+ *
+ * ./tools/testing/kunit/kunit.py run --arch=x86_64 \
+ *	--kconfig_add CONFIG_FORTIFY_SOURCE=y \
+ *	--kconfig_add CONFIG_UBSAN=y \
+ *	--kconfig_add CONFIG_UBSAN_TRAP=y \
+ *	--kconfig_add CONFIG_UBSAN_BOUNDS=y \
+ *	--kconfig_add CONFIG_UBSAN_LOCAL_BOUNDS=y \
+ *	--make_options LLVM=1 fortify
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/string.h>
+#include <linux/init.h>
+
+static const char array_of_10[] = "this is 10";
+static const char *ptr_of_11 = "this is 11!";
+static char array_unknown[] = "compiler thinks I might change";
+
+static void known_sizes_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(ptr_of_11), 11);
+
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
+	/* Externally defined and dynamically sized string pointer: */
+	KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
+}
+
+/* This is volatile so the optimizer can't perform DCE below. */
+static volatile int pick;
+
+/* Not inline to keep optimizer from figuring out which string we want. */
+static noinline size_t want_minus_one(int pick)
+{
+	const char *str;
+
+	switch (pick) {
+	case 1:
+		str = "4444";
+		break;
+	case 2:
+		str = "333";
+		break;
+	default:
+		str = "1";
+		break;
+	}
+	return __compiletime_strlen(str);
+}
+
+static void control_flow_split_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
+}
+
+static struct kunit_case fortify_test_cases[] = {
+	KUNIT_CASE(known_sizes_test),
+	KUNIT_CASE(control_flow_split_test),
+	{}
+};
+
+static struct kunit_suite fortify_test_suite = {
+	.name = "fortify",
+	.test_cases = fortify_test_cases,
+};
+
+kunit_test_suite(fortify_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

