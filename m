Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6312D4CAA81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbiCBQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243076AbiCBQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:38:40 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C32B261
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:37:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRHB3LUc8++0z9iu+FYKeD7NJQddTec6mZHPvLpKAps=;
        b=NANHGuVo79ac5h1H9z/xdbN0S2ODebC1PPyX7v+0niwvNGDbza3rCrxqcl3DL4YRtR9DD1
        wSLvWbTLE+wqDALlXZXFka7ou//FdTOhlj58dZ8IqPanORtbIJqtFMOpQxJnjpdBkNT/OP
        KjF5N6KaUSsac5BDFSM8aLHfBo4gFL0=
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
Subject: [PATCH mm 11/22] kasan: split out print_report from __kasan_report
Date:   Wed,  2 Mar 2022 17:36:31 +0100
Message-Id: <9be3ed99dd24b9c4e1c4a848b69a0c6ecefd845e.1646237226.git.andreyknvl@google.com>
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

Split out the part of __kasan_report() that prints things into
print_report(). One of the subsequent patches makes another error
handler use print_report() as well.

Includes lower-level changes:

- Allow addr_has_metadata() accepting a tagged address.
- Drop the const qualifier from the fields of kasan_access_info to avoid
  excessive type casts.
- Change the type of the address argument of __kasan_report() and
  end_report() to void * to reduce the number of type casts.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  |  7 +++---
 mm/kasan/report.c | 58 +++++++++++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cc7162a9f304..40b863e289ec 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -128,8 +128,8 @@ static inline bool kasan_sync_fault_possible(void)
 #define META_ROWS_AROUND_ADDR 2
 
 struct kasan_access_info {
-	const void *access_addr;
-	const void *first_bad_addr;
+	void *access_addr;
+	void *first_bad_addr;
 	size_t access_size;
 	bool is_write;
 	unsigned long ip;
@@ -239,7 +239,8 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 
 static inline bool addr_has_metadata(const void *addr)
 {
-	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
+	return (kasan_reset_tag(addr) >=
+		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
 
 /**
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 9286ff6ae1a7..bb4c29b439b1 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -139,10 +139,11 @@ static void start_report(unsigned long *flags, bool sync)
 	pr_err("==================================================================\n");
 }
 
-static void end_report(unsigned long *flags, unsigned long addr)
+static void end_report(unsigned long *flags, void *addr)
 {
 	if (addr)
-		trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
+		trace_error_report_end(ERROR_DETECTOR_KASAN,
+				       (unsigned long)addr);
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
@@ -398,7 +399,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	pr_err("\n");
 	print_address_description(object, tag);
 	print_memory_metadata(object);
-	end_report(&flags, (unsigned long)object);
+	end_report(&flags, object);
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
@@ -411,44 +412,47 @@ void kasan_report_async(void)
 	pr_err("Asynchronous mode enabled: no access details available\n");
 	pr_err("\n");
 	dump_stack_lvl(KERN_ERR);
-	end_report(&flags, 0);
+	end_report(&flags, NULL);
 }
 #endif /* CONFIG_KASAN_HW_TAGS */
 
-static void __kasan_report(unsigned long addr, size_t size, bool is_write,
+static void print_report(struct kasan_access_info *info)
+{
+	void *tagged_addr = info->access_addr;
+	void *untagged_addr = kasan_reset_tag(tagged_addr);
+	u8 tag = get_tag(tagged_addr);
+
+	print_error_description(info);
+	if (addr_has_metadata(untagged_addr))
+		kasan_print_tags(tag, info->first_bad_addr);
+	pr_err("\n");
+
+	if (addr_has_metadata(untagged_addr)) {
+		print_address_description(untagged_addr, tag);
+		print_memory_metadata(info->first_bad_addr);
+	} else {
+		dump_stack_lvl(KERN_ERR);
+	}
+}
+
+static void __kasan_report(void *addr, size_t size, bool is_write,
 				unsigned long ip)
 {
 	struct kasan_access_info info;
-	void *tagged_addr;
-	void *untagged_addr;
 	unsigned long flags;
 
 	start_report(&flags, true);
 
-	tagged_addr = (void *)addr;
-	untagged_addr = kasan_reset_tag(tagged_addr);
-
-	info.access_addr = tagged_addr;
-	if (addr_has_metadata(untagged_addr))
-		info.first_bad_addr =
-			kasan_find_first_bad_addr(tagged_addr, size);
+	info.access_addr = addr;
+	if (addr_has_metadata(addr))
+		info.first_bad_addr = kasan_find_first_bad_addr(addr, size);
 	else
-		info.first_bad_addr = untagged_addr;
+		info.first_bad_addr = addr;
 	info.access_size = size;
 	info.is_write = is_write;
 	info.ip = ip;
 
-	print_error_description(&info);
-	if (addr_has_metadata(untagged_addr))
-		kasan_print_tags(get_tag(tagged_addr), info.first_bad_addr);
-	pr_err("\n");
-
-	if (addr_has_metadata(untagged_addr)) {
-		print_address_description(untagged_addr, get_tag(tagged_addr));
-		print_memory_metadata(info.first_bad_addr);
-	} else {
-		dump_stack_lvl(KERN_ERR);
-	}
+	print_report(&info);
 
 	end_report(&flags, addr);
 }
@@ -460,7 +464,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	bool ret = false;
 
 	if (likely(report_enabled())) {
-		__kasan_report(addr, size, is_write, ip);
+		__kasan_report((void *)addr, size, is_write, ip);
 		ret = true;
 	}
 
-- 
2.25.1

