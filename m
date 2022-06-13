Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76B54A078
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiFMU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351923AbiFMUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111325C75
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:18:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UlP4rgYEeC4zjzJGZ6kC7jJ637whgBTqafUFs9KdFM=;
        b=JefL7G+uMUqUoHfYWqpdgoz/IVfPj+68p9IguhAmpQXwywnI1zyQ5WjNpX1CBh3AHwLiXW
        vyxIhpMNSmc+fBPo6tTB92C9YhdzPz89lbk37knbBj6HEIFOl1Fj4YvvVK2Yf/WNk63+41
        DukNNsx5HLFREaWIXGxDjKQqbidMoh8=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 21/32] kasan: simplify invalid-free reporting
Date:   Mon, 13 Jun 2022 22:14:12 +0200
Message-Id: <f7f5cfc5eb8f1a1f849665641b9dd2cfb4a62c3c.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Right now, KASAN uses the kasan_report_type enum to describe report types.

As this enum only has two options, replace it with a bool variable.

Also, unify printing report header for invalid-free and other bug types
in print_error_description().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  |  7 +------
 mm/kasan/report.c | 16 +++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index e8329935fbfb..f696d50b09fb 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -146,16 +146,11 @@ static inline bool kasan_requires_meta(void)
 #define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
 #define META_ROWS_AROUND_ADDR 2
 
-enum kasan_report_type {
-	KASAN_REPORT_ACCESS,
-	KASAN_REPORT_INVALID_FREE,
-};
-
 struct kasan_report_info {
-	enum kasan_report_type type;
 	void *access_addr;
 	void *first_bad_addr;
 	size_t access_size;
+	bool is_free;
 	bool is_write;
 	unsigned long ip;
 };
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index f951fd39db74..7269b6249488 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -175,14 +175,12 @@ static void end_report(unsigned long *flags, void *addr)
 
 static void print_error_description(struct kasan_report_info *info)
 {
-	if (info->type == KASAN_REPORT_INVALID_FREE) {
-		pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
-		       (void *)info->ip);
-		return;
-	}
+	const char *bug_type = info->is_free ?
+		"double-free or invalid-free" : kasan_get_bug_type(info);
 
-	pr_err("BUG: KASAN: %s in %pS\n",
-		kasan_get_bug_type(info), (void *)info->ip);
+	pr_err("BUG: KASAN: %s in %pS\n", bug_type, (void *)info->ip);
+	if (info->is_free)
+		return;
 	if (info->access_size)
 		pr_err("%s of size %zu at addr %px by task %s/%d\n",
 			info->is_write ? "Write" : "Read", info->access_size,
@@ -435,11 +433,11 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
 
 	start_report(&flags, true);
 
-	info.type = KASAN_REPORT_INVALID_FREE;
 	info.access_addr = ptr;
 	info.first_bad_addr = kasan_reset_tag(ptr);
 	info.access_size = 0;
 	info.is_write = false;
+	info.is_free = true;
 	info.ip = ip;
 
 	print_report(&info);
@@ -468,11 +466,11 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	start_report(&irq_flags, true);
 
-	info.type = KASAN_REPORT_ACCESS;
 	info.access_addr = ptr;
 	info.first_bad_addr = kasan_find_first_bad_addr(ptr, size);
 	info.access_size = size;
 	info.is_write = is_write;
+	info.is_free = false;
 	info.ip = ip;
 
 	print_report(&info);
-- 
2.25.1

