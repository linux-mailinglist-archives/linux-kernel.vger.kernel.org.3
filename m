Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D34B725B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiBOP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:28:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiBOP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:28:14 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E330A8895
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:27:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644938859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dd7SzABTkib4AM799BUOL90w6kNVBveLZbvtnSYlKo4=;
        b=TyqFfmBROv3yov1tgSTviqz3K1YLxu0KgqlzMwoyzgZecvJFQdDfSkcDJT60dRiuwMK2vG
        x+Aq0PcBTXNeg+nVy7uMH1UqQ77nU0g8uiJclHFJJpyQXNbIkAfO6zJdhTNcoMGGBEfudr
        LuHmdw4sEqXK0cn3u6ACd/oTvmnOkkg=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan: test: support async (again) and asymm modes for HW_TAGS
Date:   Tue, 15 Feb 2022 16:27:36 +0100
Message-Id: <51ae4a56205a41953971113ab2c264c7e2e5d969.1644938763.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Async mode support has already been implemented in commit
e80a76aa1a91 ("kasan, arm64: tests supports for HW_TAGS async mode")
but then got accidentally broken in
commit 99734b535d9b ("kasan: detect false-positives in tests").

Restore the changes removed by the latter patch and adapt them for
asymm mode: add a sync_fault flag to kunit_kasan_expectation that
only get set if the MTE fault was synchronous, and reenable MTE
on such faults in tests.

Also rename kunit_kasan_expectation to kunit_kasan_status and move its
definition to mm/kasan/kasan.h from include/linux/kasan.h, as this
structure is only internally used by KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  5 -----
 lib/test_kasan.c      | 39 ++++++++++++++++++++++-----------------
 mm/kasan/hw_tags.c    | 18 +++++++++---------
 mm/kasan/kasan.h      | 14 ++++++++++++--
 mm/kasan/report.c     | 17 +++++++++--------
 5 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4a45562d8893..d9c3f9e79d7d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -18,11 +18,6 @@ struct task_struct;
 #include <linux/linkage.h>
 #include <asm/kasan.h>
 
-/* kasan_data struct is used in KUnit tests for KASAN expected failures */
-struct kunit_kasan_expectation {
-	bool report_found;
-};
-
 #endif
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 26a5c9007653..f90ed146ed23 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -36,7 +36,7 @@ void *kasan_ptr_result;
 int kasan_int_result;
 
 static struct kunit_resource resource;
-static struct kunit_kasan_expectation fail_data;
+static struct kunit_kasan_status test_status;
 static bool multishot;
 
 /*
@@ -53,58 +53,63 @@ static int kasan_test_init(struct kunit *test)
 	}
 
 	multishot = kasan_save_enable_multi_shot();
-	fail_data.report_found = false;
+	test_status.report_found = false;
+	test_status.sync_fault = false;
 	kunit_add_named_resource(test, NULL, NULL, &resource,
-					"kasan_data", &fail_data);
+					"kasan_status", &test_status);
 	return 0;
 }
 
 static void kasan_test_exit(struct kunit *test)
 {
 	kasan_restore_multi_shot(multishot);
-	KUNIT_EXPECT_FALSE(test, fail_data.report_found);
+	KUNIT_EXPECT_FALSE(test, test_status.report_found);
 }
 
 /**
  * KUNIT_EXPECT_KASAN_FAIL() - check that the executed expression produces a
  * KASAN report; causes a test failure otherwise. This relies on a KUnit
- * resource named "kasan_data". Do not use this name for KUnit resources
+ * resource named "kasan_status". Do not use this name for KUnit resources
  * outside of KASAN tests.
  *
- * For hardware tag-based KASAN in sync mode, when a tag fault happens, tag
+ * For hardware tag-based KASAN, when a synchronous tag fault happens, tag
  * checking is auto-disabled. When this happens, this test handler reenables
  * tag checking. As tag checking can be only disabled or enabled per CPU,
  * this handler disables migration (preemption).
  *
- * Since the compiler doesn't see that the expression can change the fail_data
+ * Since the compiler doesn't see that the expression can change the test_status
  * fields, it can reorder or optimize away the accesses to those fields.
  * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
  * expression to prevent that.
  *
- * In between KUNIT_EXPECT_KASAN_FAIL checks, fail_data.report_found is kept as
- * false. This allows detecting KASAN reports that happen outside of the checks
- * by asserting !fail_data.report_found at the start of KUNIT_EXPECT_KASAN_FAIL
- * and in kasan_test_exit.
+ * In between KUNIT_EXPECT_KASAN_FAIL checks, test_status.report_found is kept
+ * as false. This allows detecting KASAN reports that happen outside of the
+ * checks by asserting !test_status.report_found at the start of
+ * KUNIT_EXPECT_KASAN_FAIL and in kasan_test_exit.
  */
 #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {			\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
 	    kasan_sync_fault_possible())				\
 		migrate_disable();					\
-	KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));	\
+	KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));	\
 	barrier();							\
 	expression;							\
 	barrier();							\
-	if (!READ_ONCE(fail_data.report_found)) {			\
+	if (kasan_async_fault_possible())				\
+		kasan_force_async_fault();				\
+	if (!READ_ONCE(test_status.report_found)) {			\
 		KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "	\
 				"expected in \"" #expression		\
 				 "\", but none occurred");		\
 	}								\
-	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {				\
-		if (READ_ONCE(fail_data.report_found))			\
-			kasan_enable_tagging_sync();			\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
+	    kasan_sync_fault_possible()) {				\
+		if (READ_ONCE(test_status.report_found) &&		\
+		    READ_ONCE(test_status.sync_fault))			\
+			kasan_enable_tagging();				\
 		migrate_enable();					\
 	}								\
-	WRITE_ONCE(fail_data.report_found, false);			\
+	WRITE_ONCE(test_status.report_found, false);			\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 7355cb534e4f..97c68c9de042 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -132,12 +132,7 @@ void kasan_init_hw_tags_cpu(void)
 	 * Enable async or asymm modes only when explicitly requested
 	 * through the command line.
 	 */
-	if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
-		hw_enable_tagging_async();
-	else if (kasan_arg_mode == KASAN_ARG_MODE_ASYMM)
-		hw_enable_tagging_asymm();
-	else
-		hw_enable_tagging_sync();
+	kasan_enable_tagging();
 }
 
 /* kasan_init_hw_tags() is called once on boot CPU. */
@@ -226,11 +221,16 @@ void kasan_free_pages(struct page *page, unsigned int order)
 
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
-void kasan_enable_tagging_sync(void)
+void kasan_enable_tagging(void)
 {
-	hw_enable_tagging_sync();
+	if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
+		hw_enable_tagging_async();
+	else if (kasan_arg_mode == KASAN_ARG_MODE_ASYMM)
+		hw_enable_tagging_asymm();
+	else
+		hw_enable_tagging_sync();
 }
-EXPORT_SYMBOL_GPL(kasan_enable_tagging_sync);
+EXPORT_SYMBOL_GPL(kasan_enable_tagging);
 
 void kasan_force_async_fault(void)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c17fa8d26ffe..49d8df9cf2c6 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -7,6 +7,16 @@
 #include <linux/kfence.h>
 #include <linux/stackdepot.h>
 
+#ifdef CONFIG_KASAN_KUNIT_TEST
+
+/* Used in KUnit-compatible KASAN tests. */
+struct kunit_kasan_status {
+	bool report_found;
+	bool sync_fault;
+};
+
+#endif
+
 #ifdef CONFIG_KASAN_HW_TAGS
 
 #include <linux/static_key.h>
@@ -340,12 +350,12 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #if defined(CONFIG_KASAN_HW_TAGS) && IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
-void kasan_enable_tagging_sync(void);
+void kasan_enable_tagging(void);
 void kasan_force_async_fault(void);
 
 #else /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
 
-static inline void kasan_enable_tagging_sync(void) { }
+static inline void kasan_enable_tagging(void) { }
 static inline void kasan_force_async_fault(void) { }
 
 #endif /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3ad9624dcc56..c5a8adc570c0 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -344,20 +344,21 @@ static bool report_enabled(void)
 }
 
 #if IS_ENABLED(CONFIG_KUNIT)
-static void kasan_update_kunit_status(struct kunit *cur_test)
+static void kasan_update_kunit_status(struct kunit *cur_test, bool sync)
 {
 	struct kunit_resource *resource;
-	struct kunit_kasan_expectation *kasan_data;
+	struct kunit_kasan_status *status;
 
-	resource = kunit_find_named_resource(cur_test, "kasan_data");
+	resource = kunit_find_named_resource(cur_test, "kasan_status");
 
 	if (!resource) {
 		kunit_set_failure(cur_test);
 		return;
 	}
 
-	kasan_data = (struct kunit_kasan_expectation *)resource->data;
-	WRITE_ONCE(kasan_data->report_found, true);
+	status = (struct kunit_kasan_status *)resource->data;
+	WRITE_ONCE(status->report_found, true);
+	WRITE_ONCE(status->sync_fault, sync);
 	kunit_put_resource(resource);
 }
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
@@ -371,7 +372,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 
 #if IS_ENABLED(CONFIG_KUNIT)
 	if (current->kunit_test)
-		kasan_update_kunit_status(current->kunit_test);
+		kasan_update_kunit_status(current->kunit_test, true);
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
 
 	start_report(&flags);
@@ -391,7 +392,7 @@ void kasan_report_async(void)
 
 #if IS_ENABLED(CONFIG_KUNIT)
 	if (current->kunit_test)
-		kasan_update_kunit_status(current->kunit_test);
+		kasan_update_kunit_status(current->kunit_test, false);
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
 
 	start_report(&flags);
@@ -413,7 +414,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 	if (current->kunit_test)
-		kasan_update_kunit_status(current->kunit_test);
+		kasan_update_kunit_status(current->kunit_test, true);
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
 
 	disable_trace_on_warning();
-- 
2.25.1

