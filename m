Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F254CAA7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiCBQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiCBQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:38:38 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856D2B261
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:37:55 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swbTnyAsWMCMrpYXsiQkz6QMlKhIbhxptnYL52Z/im0=;
        b=ZVIurZ/9fvOAIOeiHUu/51xa78T1S/EHbzaNuZFvr3Srvw8s0IvbIDUTTKHU5Gu1lJOxjk
        ErkFaSBxK5IA9zzvUzW0UfjElafHDIE7JrnZlrAYQnAs4Dz/71sspxvUR5aLoZkM4KKxR4
        ikwGE2jqH2t6ZZKqmGUUwGZ7eIfyuOA=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 09/22] kasan: move update_kunit_status to start_report
Date:   Wed,  2 Mar 2022 17:36:29 +0100
Message-Id: <cae5c845a0b6f3c867014e53737cdac56b11edc7.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Instead of duplicating calls to update_kunit_status() in every error
report routine, call it once in start_report(). Pass the sync flag
as an additional argument to start_report().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 75 +++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 93543157d3e1..0b6c8a14f0ea 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -98,13 +98,40 @@ static void print_error_description(struct kasan_access_info *info)
 			info->access_addr, current->comm, task_pid_nr(current));
 }
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+static void update_kunit_status(bool sync)
+{
+	struct kunit *test;
+	struct kunit_resource *resource;
+	struct kunit_kasan_status *status;
+
+	test = current->kunit_test;
+	if (!test)
+		return;
+
+	resource = kunit_find_named_resource(test, "kasan_status");
+	if (!resource) {
+		kunit_set_failure(test);
+		return;
+	}
+
+	status = (struct kunit_kasan_status *)resource->data;
+	WRITE_ONCE(status->report_found, true);
+	WRITE_ONCE(status->sync_fault, sync);
+
+	kunit_put_resource(resource);
+}
+#else
+static void update_kunit_status(bool sync) { }
+#endif
+
 static DEFINE_SPINLOCK(report_lock);
 
-static void start_report(unsigned long *flags)
+static void start_report(unsigned long *flags, bool sync)
 {
-	/*
-	 * Make sure we don't end up in loop.
-	 */
+	/* Update status of the currently running KASAN test. */
+	update_kunit_status(sync);
+	/* Make sure we don't end up in loop. */
 	kasan_disable_current();
 	spin_lock_irqsave(&report_lock, *flags);
 	pr_err("==================================================================\n");
@@ -356,33 +383,6 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
-#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
-static void update_kunit_status(bool sync)
-{
-	struct kunit *test;
-	struct kunit_resource *resource;
-	struct kunit_kasan_status *status;
-
-	test = current->kunit_test;
-	if (!test)
-		return;
-
-	resource = kunit_find_named_resource(test, "kasan_status");
-	if (!resource) {
-		kunit_set_failure(test);
-		return;
-	}
-
-	status = (struct kunit_kasan_status *)resource->data;
-	WRITE_ONCE(status->report_found, true);
-	WRITE_ONCE(status->sync_fault, sync);
-
-	kunit_put_resource(resource);
-}
-#else
-static void update_kunit_status(bool sync) { }
-#endif
-
 void kasan_report_invalid_free(void *object, unsigned long ip)
 {
 	unsigned long flags;
@@ -390,9 +390,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 
 	object = kasan_reset_tag(object);
 
-	update_kunit_status(true);
-
-	start_report(&flags);
+	start_report(&flags, true);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	kasan_print_tags(tag, object);
 	pr_err("\n");
@@ -406,9 +404,7 @@ void kasan_report_async(void)
 {
 	unsigned long flags;
 
-	update_kunit_status(false);
-
-	start_report(&flags);
+	start_report(&flags, false);
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous mode enabled: no access details available\n");
 	pr_err("\n");
@@ -425,9 +421,8 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	void *untagged_addr;
 	unsigned long flags;
 
-	update_kunit_status(true);
-
 	disable_trace_on_warning();
+	start_report(&flags, true);
 
 	tagged_addr = (void *)addr;
 	untagged_addr = kasan_reset_tag(tagged_addr);
@@ -442,8 +437,6 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	info.is_write = is_write;
 	info.ip = ip;
 
-	start_report(&flags);
-
 	print_error_description(&info);
 	if (addr_has_metadata(untagged_addr))
 		kasan_print_tags(get_tag(tagged_addr), info.first_bad_addr);
-- 
2.25.1

