Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE554A08E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbiFMU5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352088AbiFMUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:10 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DBA2A243
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:19:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4luxyHsp81FOFiUT/6yoqfYUWRQbE1ZGpW4pjt9Mu8s=;
        b=wrqv7ohOF96qGiSQuPggQGcjaCvog98ApGuHxDFierBEUu/M31pb0J67CQIkajDOQYJQER
        YuDnSp2V6YbPoBkcPXwEnEdjyMR+pJGczOFfBWwr4cvGnkAYWCX7vQpjjcSJ9wtyoKpbVh
        ZPeMiUpOhK1ShOgWWyVcqDCuLD/pVRs=
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
Subject: [PATCH 28/32] kasan: fill in cache and object in complete_report_info
Date:   Mon, 13 Jun 2022 22:14:19 +0200
Message-Id: <1e3e75cbcf4f258701b325dbad8b2a43c2633b7b.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add cache and object fields to kasan_report_info and fill them in in
complete_report_info() instead of fetching them in the middle of the
report printing code.

This allows the reporting code to get access to the object information
before starting printing the report. One of the following patches uses
this information to determine the bug type with the tag-based modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  |  2 ++
 mm/kasan/report.c | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 0261d1530055..b9bd9f1656bf 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -156,6 +156,8 @@ struct kasan_report_info {
 
 	/* Filled in by the common reporting code. */
 	void *first_bad_addr;
+	struct kmem_cache *cache;
+	void *object;
 };
 
 /* Do not change the struct layout: compiler ABI. */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 214ba7cb654c..a6b36eb4c33b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -281,19 +281,16 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
-static void print_address_description(void *addr, u8 tag)
+static void print_address_description(void *addr, u8 tag,
+				      struct kasan_report_info *info)
 {
 	struct page *page = addr_to_page(addr);
-	struct slab *slab = kasan_addr_to_slab(addr);
 
 	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
-	if (slab) {
-		struct kmem_cache *cache = slab->slab_cache;
-		void *object = nearest_obj(cache, slab,	addr);
-
-		describe_object(cache, object, addr, tag);
+	if (info->cache && info->object) {
+		describe_object(info->cache, info->object, addr, tag);
 		pr_err("\n");
 	}
 
@@ -400,7 +397,7 @@ static void print_report(struct kasan_report_info *info)
 	pr_err("\n");
 
 	if (addr_has_metadata(addr)) {
-		print_address_description(addr, tag);
+		print_address_description(addr, tag, info);
 		print_memory_metadata(info->first_bad_addr);
 	} else {
 		dump_stack_lvl(KERN_ERR);
@@ -410,12 +407,20 @@ static void print_report(struct kasan_report_info *info)
 static void complete_report_info(struct kasan_report_info *info)
 {
 	void *addr = kasan_reset_tag(info->access_addr);
+	struct slab *slab;
 
 	if (info->is_free)
 		info->first_bad_addr = addr;
 	else
 		info->first_bad_addr = kasan_find_first_bad_addr(
 					info->access_addr, info->access_size);
+
+	slab = kasan_addr_to_slab(addr);
+	if (slab) {
+		info->cache = slab->slab_cache;
+		info->object = nearest_obj(info->cache, slab, addr);
+	} else
+		info->cache = info->object = NULL;
 }
 
 void kasan_report_invalid_free(void *ptr, unsigned long ip)
-- 
2.25.1

