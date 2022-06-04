Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10453D7FF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiFDRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiFDRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:16:14 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54348286D4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:16:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 76B102E2936;
        Sat,  4 Jun 2022 19:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654362969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIeD4GYUpGif2uY8WZoeDbu3gkmjTMXFybpVd2A6ewQ=;
        b=oVxnb3IuWxPCuVYNFbuSOI/4i4NrkgwUjeBrTlnX2wQeT1Tuv0uay0pOz+DlHbGw7L6cR/
        6/VK2DY+fvLBJD92R2R50JbAi8AFaRovJkrSEYmQzquuYFxMtFCSwIBLXf44D0uAHG5DJE
        PV9TF5dGBc/SlMuF7k4LnDguufA+ubiFzAOSd0yXMRiIGeF6DraThVhlNaT3kHmE75gT/C
        CGdNYL1aMAdvAPzT+FUYe/5c0/DBi6bnkPd9W/IEJuaQqf3CSvCLMPSJc4FhoapiD8hHWj
        GJGTVQ53/NT4Hz+AtJ8G9mUHhYSbOS9CiYXd4eVsvcj58OxpreCe5gUF3DNkRw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 1/4] lib/test: Introduce cpumask KUnit test suite
Date:   Sat,  4 Jun 2022 19:15:56 +0200
Message-Id: <5a55f41812dc18fccf66f8130682ff8e669e0c80.1654362935.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654362935.git.sander@svanheule.net>
References: <cover.1654362935.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic suite of tests for cpumask, providing some tests for empty
and completely filled cpumasks.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 lib/Kconfig.debug  |   9 ++++
 lib/Makefile       |   1 +
 lib/test_cpumask.c | 115 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 lib/test_cpumask.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b8cc65d22169..85f2eb5c0b07 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2100,6 +2100,15 @@ config LKDTM
 	Documentation on how to use the module can be found in
 	Documentation/fault-injection/provoke-crashes.rst
 
+config TEST_CPUMASK
+	tristate "cpumask tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable to turn on cpumask tests, running at boot or module load time.
+
+	  If unsure, say N.
+
 config TEST_LIST_SORT
 	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 89fcae891361..81f944cd74ae 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+obj-$(CONFIG_TEST_CPUMASK) += test_cpumask.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 #
diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
new file mode 100644
index 000000000000..3b69fcb6730e
--- /dev/null
+++ b/lib/test_cpumask.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for cpumask.
+ *
+ * Author: Sander Vanheule <sander@svanheule.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/cpumask.h>
+
+#define FOR_EACH_ITER_EQ(_test, _iter, _expect, _loop)		\
+	do {							\
+		(_iter) = 0;					\
+		_loop						\
+			(_iter)++;				\
+		KUNIT_EXPECT_EQ((_test), (_expect), (_iter));	\
+	} while (0)
+
+static cpumask_t mask_empty;
+static cpumask_t mask_all;
+
+static void test_cpumask_weight(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
+	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
+	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
+
+	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
+	KUNIT_EXPECT_EQ(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask));
+	KUNIT_EXPECT_EQ(test, nr_cpumask_bits, cpumask_weight(&mask_all));
+}
+
+static void test_cpumask_first(struct kunit *test)
+{
+	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first(&mask_empty));
+	KUNIT_EXPECT_EQ(test, 0, cpumask_first(cpu_possible_mask));
+
+	KUNIT_EXPECT_EQ(test, 0, cpumask_first_zero(&mask_empty));
+	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first_zero(cpu_possible_mask));
+}
+
+static void test_cpumask_last(struct kunit *test)
+{
+	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
+	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
+}
+
+static void test_cpumask_next(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0, cpumask_next_zero(-1, &mask_empty));
+	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next_zero(-1, cpu_possible_mask));
+
+	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next(-1, &mask_empty));
+	KUNIT_EXPECT_EQ(test, 0, cpumask_next(-1, cpu_possible_mask));
+}
+
+static void test_cpumask_iterators(struct kunit *test)
+{
+	unsigned int iterations;
+	int cpu;
+
+	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(&mask_empty),
+			for_each_cpu(cpu, &mask_empty));
+	FOR_EACH_ITER_EQ(test, iterations, nr_cpu_ids - cpumask_weight(&mask_empty),
+			for_each_cpu_not(cpu, &mask_empty));
+	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(&mask_empty),
+			for_each_cpu_wrap(cpu, &mask_empty, nr_cpu_ids / 2));
+
+	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_possible_mask),
+			for_each_cpu(cpu, cpu_possible_mask));
+	FOR_EACH_ITER_EQ(test, iterations, nr_cpu_ids - cpumask_weight(cpu_possible_mask),
+			for_each_cpu_not(cpu, cpu_possible_mask));
+	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_possible_mask),
+			for_each_cpu_wrap(cpu, cpu_possible_mask, nr_cpu_ids / 2));
+}
+
+static void test_cpumask_iterators_builtin(struct kunit *test)
+{
+	unsigned int iterations;
+	int cpu;
+
+	FOR_EACH_ITER_EQ(test, iterations, nr_cpu_ids,
+		for_each_possible_cpu(cpu));
+	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_online_mask),
+		for_each_online_cpu(cpu));
+	FOR_EACH_ITER_EQ(test, iterations, cpumask_weight(cpu_present_mask),
+		for_each_present_cpu(cpu));
+}
+
+static int test_cpumask_init(struct kunit *test)
+{
+	cpumask_clear(&mask_empty);
+	cpumask_setall(&mask_all);
+
+	return 0;
+}
+
+static struct kunit_case test_cpumask_cases[] = {
+	KUNIT_CASE(test_cpumask_weight),
+	KUNIT_CASE(test_cpumask_first),
+	KUNIT_CASE(test_cpumask_last),
+	KUNIT_CASE(test_cpumask_next),
+	KUNIT_CASE(test_cpumask_iterators),
+	KUNIT_CASE(test_cpumask_iterators_builtin),
+	{}
+};
+
+static struct kunit_suite test_cpumask_suite = {
+	.name = "cpumask",
+	.init = test_cpumask_init,
+	.test_cases = test_cpumask_cases,
+};
+kunit_test_suite(test_cpumask_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.36.1

