Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686744CAAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiCBQlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243177AbiCBQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:40:49 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4CCF38A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:40:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djMH4j9HV8SXlCfl9Af/XXd5VDpDAiry7CNPlQpwESU=;
        b=PnZ2t/ANIdtINzZYFaDix7C8GIFWc+Tcr3lo2iGiNpriUbTepgZwinlIDD+IUj0vIZXPAT
        PUWWJBTw6hHckQ1Q+E98GyyjPVqju9Ydl66WDlbG/CQjQkd9tMJr4XtT5MULXn29AcSCz2
        GJxDfbMqH3fNp2GkTIiuEGRW74+fR8I=
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
Subject: [PATCH mm 20/22] kasan: reorder reporting functions
Date:   Wed,  2 Mar 2022 17:36:40 +0100
Message-Id: <82aa926c411e00e76e97e645a551ede9ed0c5e79.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Move print_error_description()'s, report_suppressed()'s, and
report_enabled()'s definitions to improve the logical order of
function definitions in report.c.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 82 +++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ef649f5cee29..7ef3b0455603 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -84,24 +84,29 @@ static int __init kasan_set_multi_shot(char *str)
 }
 __setup("kasan_multi_shot", kasan_set_multi_shot);
 
-static void print_error_description(struct kasan_report_info *info)
+/*
+ * Used to suppress reports within kasan_disable/enable_current() critical
+ * sections, which are used for marking accesses to slab metadata.
+ */
+static bool report_suppressed(void)
 {
-	if (info->type == KASAN_REPORT_INVALID_FREE) {
-		pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
-		       (void *)info->ip);
-		return;
-	}
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+	if (current->kasan_depth)
+		return true;
+#endif
+	return false;
+}
 
-	pr_err("BUG: KASAN: %s in %pS\n",
-		kasan_get_bug_type(info), (void *)info->ip);
-	if (info->access_size)
-		pr_err("%s of size %zu at addr %px by task %s/%d\n",
-			info->is_write ? "Write" : "Read", info->access_size,
-			info->access_addr, current->comm, task_pid_nr(current));
-	else
-		pr_err("%s at addr %px by task %s/%d\n",
-			info->is_write ? "Write" : "Read",
-			info->access_addr, current->comm, task_pid_nr(current));
+/*
+ * Used to avoid reporting more than one KASAN bug unless kasan_multi_shot
+ * is enabled. Note that KASAN tests effectively enable kasan_multi_shot
+ * for their duration.
+ */
+static bool report_enabled(void)
+{
+	if (test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
+		return true;
+	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
@@ -160,6 +165,26 @@ static void end_report(unsigned long *flags, void *addr)
 	kasan_enable_current();
 }
 
+static void print_error_description(struct kasan_report_info *info)
+{
+	if (info->type == KASAN_REPORT_INVALID_FREE) {
+		pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
+		       (void *)info->ip);
+		return;
+	}
+
+	pr_err("BUG: KASAN: %s in %pS\n",
+		kasan_get_bug_type(info), (void *)info->ip);
+	if (info->access_size)
+		pr_err("%s of size %zu at addr %px by task %s/%d\n",
+			info->is_write ? "Write" : "Read", info->access_size,
+			info->access_addr, current->comm, task_pid_nr(current));
+	else
+		pr_err("%s at addr %px by task %s/%d\n",
+			info->is_write ? "Write" : "Read",
+			info->access_addr, current->comm, task_pid_nr(current));
+}
+
 static void print_track(struct kasan_track *track, const char *prefix)
 {
 	pr_err("%s by task %u:\n", prefix, track->pid);
@@ -381,31 +406,6 @@ static void print_memory_metadata(const void *addr)
 	}
 }
 
-/*
- * Used to suppress reports within kasan_disable/enable_current() critical
- * sections, which are used for marking accesses to slab metadata.
- */
-static bool report_suppressed(void)
-{
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
-	if (current->kasan_depth)
-		return true;
-#endif
-	return false;
-}
-
-/*
- * Used to avoid reporting more than one KASAN bug unless kasan_multi_shot
- * is enabled. Note that KASAN tests effectively enable kasan_multi_shot
- * for their duration.
- */
-static bool report_enabled(void)
-{
-	if (test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
-		return true;
-	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
-}
-
 static void print_report(struct kasan_report_info *info)
 {
 	void *tagged_addr = info->access_addr;
-- 
2.25.1

