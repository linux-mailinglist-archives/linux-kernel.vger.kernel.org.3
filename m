Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21589564149
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiGBQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGBQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:08:43 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FAE0B8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:08:40 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0037D2F29DB;
        Sat,  2 Jul 2022 18:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656778115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIfcv98TK79lXB1Xs2fPU/OqBYaVs4O/uwnTJaPycVY=;
        b=PL7ZSkg1br50+AbV6Lvrm+pET2SO3PARypCXNyEaQcSoEABFbFmrTp5mEWmQJlinwasXRd
        j3J4tyMoisD0oBKspw7sVg34hldwTfC9K91PfEostphXXaUkhEq4XbmrXMjTGTj/xnE6YY
        MKPpI/blQ458YsG1DezvIjzT5kg24chhGs7pJtGM2TaTQYgwSPSFPmqZUXXZ3oVWjonuia
        ZiwbSeM/WNj0GS1sFqAkkMFCAm1r4DHyhoOOnX2/0JoKbUG0VZXsfL7NFClRXEmLUJtkX5
        7uDCaRAjtrttrTOzt+Nm2bqya3oGv8kdAjxky0LC6RK5TpmJ1cuk8hl5C8LoVg==
From:   Sander Vanheule <sander@svanheule.net>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 3/5] lib/test: Introduce cpumask KUnit test suite
Date:   Sat,  2 Jul 2022 18:08:26 +0200
Message-Id: <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656777646.git.sander@svanheule.net>
References: <cover.1656777646.git.sander@svanheule.net>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Notes:
    Changes since v3:
    - Test for_each_cpu*() over empty mask and cpu_possible_mask
    - Add Andy's Reviewed-by
    - Use num_{online,present,possible}_cpus() for builtin masks
    - Guard against CPU hotplugging during test for dynamic builtin CPU masks
    
    Changes since v2:
    - Rework for_each_* test macros, as suggested by Yury
    
    Changes since v1:
    - New patch

 lib/Kconfig.debug  |   9 +++
 lib/Makefile       |   1 +
 lib/test_cpumask.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 lib/test_cpumask.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..04aaa20d50f9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2021,6 +2021,15 @@ config LKDTM
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
index bcc7e8ea0cde..de3e47453fe8 100644
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
index 000000000000..a31a1622f1f6
--- /dev/null
+++ b/lib/test_cpumask.c
@@ -0,0 +1,138 @@
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

