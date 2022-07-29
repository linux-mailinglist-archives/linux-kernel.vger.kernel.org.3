Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE5584C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiG2HCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiG2HBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:01:43 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D251F2E7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:01:41 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AEC5F302C30;
        Fri, 29 Jul 2022 09:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659078096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U38/SCcfeOS4YYtk9BamiWe1ZOK+KPSRSMapins/TDY=;
        b=J67qNbqZBxZRXWfmZKdDOzgJvZ74beVOu1SVrFu4txZ2gvcJplOHzntqRYI+ucQ65D1qcH
        LACJARL2+LxTnnaSHBTJZKBcF6Pq0uuor+B01AaIZlWjICPjBkzm00DulMtJJwVAIPoh3s
        IkptGcyuOstNaGcVwVoNdFqyS7C2zGcLQd7ROamLrbuoR6fYRIBVeOHtNEQe1BXWqQs+ib
        dXvmnJ41T4jkCfNhxmBvpyuuC8UGxl11jKPNvOWYcQNwMy1R6vZVFcCvDqO1cY9Ktj+51v
        GHtakfFotiyKiUWU4UkzTnydPfDE5R6BsQDKbD3mZwQGpCzwHREz+eS+X8s0yg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 4/5] lib/test: introduce cpumask KUnit test suite
Date:   Fri, 29 Jul 2022 09:01:21 +0200
Message-Id: <85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659077534.git.sander@svanheule.net>
References: <cover.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic suite of tests for cpumask, providing some tests for empty and
completely filled cpumasks.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Maíra Canal <mairacanal@riseup.net>
---
Changes since v4:
- Belated addition of Yury's Suggested-by:
- Follow KUnit style more closely
- Drop full check on cpu_possible_mask
- Update last check on cpu_possible_mask
- Log masks when starting test
- Update commit message 
  
Changes since v3:
- Test for_each_cpu*() over empty mask and cpu_possible_mask
- Add Andy's Reviewed-by
- Use num_{online,present,possible}_cpus() for builtin masks
- Guard against CPU hotplugging during test for dynamic builtin CPU masks
 
Changes since v2:
- Rework for_each_* test macros, as suggested by Yury

Changes since v1:
- New patch

 lib/Kconfig.debug  |  12 ++++
 lib/Makefile       |   1 +
 lib/cpumask_test.c | 147 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 lib/cpumask_test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..e85e74646178 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2021,6 +2021,18 @@ config LKDTM
 	Documentation on how to use the module can be found in
 	Documentation/fault-injection/provoke-crashes.rst
 
+config CPUMASK_KUNIT_TEST
+	tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable to turn on cpumask tests, running at boot or module load time.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_LIST_SORT
 	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index bcc7e8ea0cde..9f9db1376538 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
+obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_test.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
diff --git a/lib/cpumask_test.c b/lib/cpumask_test.c
new file mode 100644
index 000000000000..0f8059a5e93b
--- /dev/null
+++ b/lib/cpumask_test.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for cpumask.
+ *
+ * Author: Sander Vanheule <sander@svanheule.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/cpu.h>
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
+		int mask_weight = num_##name##_cpus();		\
+		int cpu, iter = 0;				\
+		for_each_##name##_cpu(cpu)			\
+			iter++;					\
+		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
+	} while (0)
+
+static cpumask_t mask_empty;
+static cpumask_t mask_all;
+
+#define STR_MASK(m)			#m
+#define TEST_CPUMASK_PRINT(test, mask)	\
+	kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits, cpumask_bits(mask))
+
+static void test_cpumask_weight(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
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
+	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
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
+	EXPECT_FOR_EACH_CPU_EQ(test, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_NOT_EQ(test, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, cpu_possible_mask);
+}
+
+static void test_cpumask_iterators_builtin(struct kunit *test)
+{
+	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, possible);
+
+	/* Ensure the dynamic masks are stable while running the tests */
+	cpu_hotplug_disable();
+
+	TEST_CPUMASK_PRINT(test, cpu_online_mask);
+	TEST_CPUMASK_PRINT(test, cpu_present_mask);
+
+	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
+	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
+
+	cpu_hotplug_enable();
+}
+
+static int test_cpumask_init(struct kunit *test)
+{
+	cpumask_clear(&mask_empty);
+	cpumask_setall(&mask_all);
+
+	TEST_CPUMASK_PRINT(test, &mask_all);
+	TEST_CPUMASK_PRINT(test, cpu_possible_mask);
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
2.37.1

