Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19C578F07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiGSAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiGSANt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:13:49 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EAA110
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:13:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4rrLBlHP9NeNLXeiOhUcDB35KsXuF54OmWKXqnLQEA=;
        b=LVpP162eLUxzWlXtaxlkTzHQo3R5Fis/5GLAtxi/j6wpKDGiKXVYJoi7lSpsJ8H2ipShH9
        U67DZCr01gJUMpX9uvkhL3FAd85KZadfQH+1BRwA8i0tq68mD/rOmLQleoXo9DYfuRbNhW
        /JFX9VzJnoP/OSo0f9jEPUzSBkqyKBQ=
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
Subject: [PATCH mm v2 23/33] kasan: use kasan_addr_to_slab in print_address_description
Date:   Tue, 19 Jul 2022 02:10:03 +0200
Message-Id: <b564ec299087548c5391ccea6f589a9370116d51.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Use the kasan_addr_to_slab() helper in print_address_description()
instead of separately invoking PageSlab() and page_slab().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c |  7 +++++++
 mm/kasan/report.c | 11 ++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 3dc57a199893..cfb85b65fa44 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -30,6 +30,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
+struct slab *kasan_addr_to_slab(const void *addr)
+{
+	if (virt_addr_valid(addr))
+		return virt_to_slab(addr);
+	return NULL;
+}
+
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 570f9419b90c..cd31b3b89ca1 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -213,13 +213,6 @@ struct page *kasan_addr_to_page(const void *addr)
 	return NULL;
 }
 
-struct slab *kasan_addr_to_slab(const void *addr)
-{
-	if (virt_addr_valid(addr))
-		return virt_to_slab(addr);
-	return NULL;
-}
-
 static void describe_object_addr(struct kmem_cache *cache, void *object,
 				const void *addr)
 {
@@ -297,12 +290,12 @@ static inline bool init_task_stack_addr(const void *addr)
 static void print_address_description(void *addr, u8 tag)
 {
 	struct page *page = kasan_addr_to_page(addr);
+	struct slab *slab = kasan_addr_to_slab(addr);
 
 	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
-	if (page && PageSlab(page)) {
-		struct slab *slab = page_slab(page);
+	if (slab) {
 		struct kmem_cache *cache = slab->slab_cache;
 		void *object = nearest_obj(cache, slab,	addr);
 
-- 
2.25.1

