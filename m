Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF2578F15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiGSAO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiGSAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:14:44 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E784110
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:14:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07r2mZKCyHd2fu+4Bk2w4QXaKiSUtwJ2KOZg+LGbxK4=;
        b=aTN/zjk7uS6S0RwRQItzAjQzXpZSvjVXH5zWtkHeZcgHLUShe+C/xHuVjuEP1eZBDfhUoh
        60mTHwOSUrhc0cNWGcF9KD1KXvnSz4dfrms59St1aY0L8kF0ZJ1a3b6ltpdXBxlchoPcsj
        d28/iEFaetAq/mjLrfuJf6sLFZz0WJA=
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
Subject: [PATCH mm v2 28/33] kasan: rework function arguments in report.c
Date:   Tue, 19 Jul 2022 02:10:08 +0200
Message-Id: <0333e02a35742ef14103440a7091b34ce437ddf3.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Pass a pointer to kasan_report_info to describe_object() and
describe_object_stacks(), instead of passing the structure's fields.

The untagged pointer and the tag are still passed as separate arguments
to some of the functions to avoid duplicating the untagging logic.

This is preparatory change for the next patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 763de8e68887..ec018f849992 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -213,8 +213,8 @@ static inline struct page *addr_to_page(const void *addr)
 	return NULL;
 }
 
-static void describe_object_addr(struct kmem_cache *cache, void *object,
-				const void *addr)
+static void describe_object_addr(const void *addr, struct kmem_cache *cache,
+				 void *object)
 {
 	unsigned long access_addr = (unsigned long)addr;
 	unsigned long object_addr = (unsigned long)object;
@@ -242,33 +242,32 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 		(void *)(object_addr + cache->object_size));
 }
 
-static void describe_object_stacks(struct kmem_cache *cache, void *object,
-					const void *addr, u8 tag)
+static void describe_object_stacks(u8 tag, struct kasan_report_info *info)
 {
 	struct kasan_track *alloc_track;
 	struct kasan_track *free_track;
 
-	alloc_track = kasan_get_alloc_track(cache, object);
+	alloc_track = kasan_get_alloc_track(info->cache, info->object);
 	if (alloc_track) {
 		print_track(alloc_track, "Allocated");
 		pr_err("\n");
 	}
 
-	free_track = kasan_get_free_track(cache, object, tag);
+	free_track = kasan_get_free_track(info->cache, info->object, tag);
 	if (free_track) {
 		print_track(free_track, "Freed");
 		pr_err("\n");
 	}
 
-	kasan_print_aux_stacks(cache, object);
+	kasan_print_aux_stacks(info->cache, info->object);
 }
 
-static void describe_object(struct kmem_cache *cache, void *object,
-				const void *addr, u8 tag)
+static void describe_object(const void *addr, u8 tag,
+			    struct kasan_report_info *info)
 {
 	if (kasan_stack_collection_enabled())
-		describe_object_stacks(cache, object, addr, tag);
-	describe_object_addr(cache, object, addr);
+		describe_object_stacks(tag, info);
+	describe_object_addr(addr, info->cache, info->object);
 }
 
 static inline bool kernel_or_module_addr(const void *addr)
@@ -296,7 +295,7 @@ static void print_address_description(void *addr, u8 tag,
 	pr_err("\n");
 
 	if (info->cache && info->object) {
-		describe_object(info->cache, info->object, addr, tag);
+		describe_object(addr, tag, info);
 		pr_err("\n");
 	}
 
-- 
2.25.1

