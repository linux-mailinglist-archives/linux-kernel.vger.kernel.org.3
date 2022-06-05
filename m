Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7899753DA6A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiFEGXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346790AbiFEGWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:22:54 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37413D56
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:22:52 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id D5C852E2DA3;
        Sun,  5 Jun 2022 08:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654410168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7l9dggY+wM+wbegFqEN6bcdYY4spsvRDlPNIgKK29Kg=;
        b=UwAmaWU9Wk0SklBKAKYGtPGzZdraBi+TS/X5QaVrx2zAW3PGnz3haBGnOlW3PMzZy1CMDq
        0w3mlNr+pjXWF5qp8mGsBy2HG1mxdx1T+Ro8iSw1za3TfvuVtQ3VtfYkEwYzWfugGSbF2l
        7+88n3EDR8F89r3yUNsvh1I00URn/UMEYKclWWGy1ePmH2rs8bUo2B5gj5LAX7Syd50sHm
        IOtQ57YvMsxNlWvnZQkiou8FS4h2ffu3aWOfgwqW+d7Z6Fh8yiM6lJv3k6zEVPLLYJ0W9x
        G+WKEYXfT5r93v8VVyqfLLo+j3r+IcaIEV+DDNS/hGuABK+slSIoX+xICPoObQ==
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
Subject: [PATCH v3 2/4] lib/test: Introduce cpumask KUnit test suite
Date:   Sun,  5 Jun 2022 08:22:39 +0200
Message-Id: <8b60c0d5add21b43dd75e92d48f2df011f63c6bf.1654410109.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654410109.git.sander@svanheule.net>
References: <cover.1654410109.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
Changes since v2:
- Rework for_each_* test macros, as suggested by Yury
---
 lib/Kconfig.debug  |   9 ++++
 lib/Makefile       |   1 +
 lib/test_cpumask.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
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
index 6f26a429115b..5abd7b2064f1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+obj-$(CONFIG_TEST_CPUMASK) += test_cpumask.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 #
diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
new file mode 100644
index 000000000000..3f43b9a6548c
--- /dev/null
+++ b/lib/test_cpumask.c
@@ -0,0 +1,132 @@
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
+#define EXPECT_FOR_EACH_CPU_EQ(test, mask)			\
+	do {							\
+		const cpumask_t *m = (mask);			\
+		int mask_weight = cpumask_weight(m);		\
+		int cpu, iter = 0;				\
+		for_each_cpu(cpu, m)				\
+			iter++;					\
+		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
+	} while (0)
+
+#define EXPECT_FOR_EACH_CPU_NOT_EQ(test, mask)					\
+	do {									\
+		const cpumask_t *m = (mask);					\
+		int mask_weight = cpumask_weight(m);				\
+		int cpu, iter = 0;						\
+		for_each_cpu_not(cpu, m)					\
+			iter++;							\
+		KUNIT_EXPECT_EQ((test), nr_cpu_ids - mask_weight, iter);	\
+	} while (0)
+
+#define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
+	do {							\
+		const cpumask_t *m = (mask);			\
+		int mask_weight = cpumask_weight(m);		\
+		int cpu, iter = 0;				\
+		for_each_cpu_wrap(cpu, m, nr_cpu_ids / 2)	\
+			iter++;					\
+		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
+	} while (0)
+
+#define EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, name)		\
+	do {							\
+		const cpumask_t *m = cpu_##name##_mask;		\
+		int mask_weight = cpumask_weight(m);		\
+		int cpu, iter = 0;				\
+		for_each_##name##_cpu(cpu)			\
+			iter++;					\
+		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
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
+	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
+
+	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
+}
+
+static void test_cpumask_iterators_builtin(struct kunit *test)
+{
+	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, possible);
+	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
+	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
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

