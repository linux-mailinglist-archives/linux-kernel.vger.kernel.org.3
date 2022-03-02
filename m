Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED2D4CAA8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiCBQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiCBQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:39:45 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E531369
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:39:00 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsCdzSP/k33pOndnGnQGapEj7FynIvIpYn3S3i9tIEc=;
        b=bWJzl9fxs9+Hc43oKBCqXMPfpYIMGnCyPHr9sDfvUzPlmnCwrFeFx7NDs4btAWRHiFZHKj
        K3vqwcR91Lf9ARkARw3MfapJCPFw3OiKFT1v+6IGHBoUr7f9MTNW0FA6iat+mHcLbsIJG/
        NlqxwlafTq+F9XbykzoviXQXCxoZN1A=
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
Subject: [PATCH mm 15/22] kasan: call print_report from kasan_report_invalid_free
Date:   Wed,  2 Mar 2022 17:36:35 +0100
Message-Id: <9ea6f0604c5d2e1fb28d93dc6c44232c1f8017fe.1646237226.git.andreyknvl@google.com>
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

Call print_report() in kasan_report_invalid_free() instead of calling
printing functions directly. Compared to the existing implementation
of kasan_report_invalid_free(), print_report() makes sure that the
buggy address has metadata before printing it.

The change requires adding a report type field into kasan_access_info
and using it accordingly.

kasan_report_async() is left as is, as using print_report() will only
complicate the code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  |  6 ++++++
 mm/kasan/report.c | 42 ++++++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 40b863e289ec..8c9a855152c2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -127,7 +127,13 @@ static inline bool kasan_sync_fault_possible(void)
 #define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
 #define META_ROWS_AROUND_ADDR 2
 
+enum kasan_report_type {
+	KASAN_REPORT_ACCESS,
+	KASAN_REPORT_INVALID_FREE,
+};
+
 struct kasan_access_info {
+	enum kasan_report_type type;
 	void *access_addr;
 	void *first_bad_addr;
 	size_t access_size;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 56d5ba235542..73348f83b813 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -86,6 +86,12 @@ __setup("kasan_multi_shot", kasan_set_multi_shot);
 
 static void print_error_description(struct kasan_access_info *info)
 {
+	if (info->type == KASAN_REPORT_INVALID_FREE) {
+		pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
+		       (void *)info->ip);
+		return;
+	}
+
 	pr_err("BUG: KASAN: %s in %pS\n",
 		kasan_get_bug_type(info), (void *)info->ip);
 	if (info->access_size)
@@ -386,22 +392,6 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
-void kasan_report_invalid_free(void *object, unsigned long ip)
-{
-	unsigned long flags;
-	u8 tag = get_tag(object);
-
-	object = kasan_reset_tag(object);
-
-	start_report(&flags, true);
-	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
-	kasan_print_tags(tag, object);
-	pr_err("\n");
-	print_address_description(object, tag);
-	print_memory_metadata(object);
-	end_report(&flags, object);
-}
-
 #ifdef CONFIG_KASAN_HW_TAGS
 void kasan_report_async(void)
 {
@@ -435,6 +425,25 @@ static void print_report(struct kasan_access_info *info)
 	}
 }
 
+void kasan_report_invalid_free(void *ptr, unsigned long ip)
+{
+	unsigned long flags;
+	struct kasan_access_info info;
+
+	start_report(&flags, true);
+
+	info.type = KASAN_REPORT_INVALID_FREE;
+	info.access_addr = ptr;
+	info.first_bad_addr = kasan_reset_tag(ptr);
+	info.access_size = 0;
+	info.is_write = false;
+	info.ip = ip;
+
+	print_report(&info);
+
+	end_report(&flags, ptr);
+}
+
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
 			unsigned long ip)
 {
@@ -451,6 +460,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	start_report(&irq_flags, true);
 
+	info.type = KASAN_REPORT_ACCESS;
 	info.access_addr = ptr;
 	info.first_bad_addr = kasan_find_first_bad_addr(ptr, size);
 	info.access_size = size;
-- 
2.25.1

