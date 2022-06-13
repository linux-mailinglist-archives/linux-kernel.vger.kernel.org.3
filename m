Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20FE54A085
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351391AbiFMU44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352081AbiFMUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:09 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD23275EA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:19:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NlTYbbmb8K8Hz7QxoFNu4DEEzvlhQuGMJFGkSKrxTzk=;
        b=U/iYTMjjDHVUZCoLW/1BknQkILDEl85phr4wKanZLDwM4Jn+hUSCLwE24HlVfV0VaWnFGZ
        5AwsB6PXGbJcILtgvt/a2jxzEYgsMtJLT/bXeJD/yxxPbvpTCCioX7PAW1dxA4jrSRwzdu
        UhNm0cH9ryd0tC9r9ti+IK4+K3cI+g0=
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
Subject: [PATCH 25/32] kasan: make kasan_addr_to_page static
Date:   Mon, 13 Jun 2022 22:14:16 +0200
Message-Id: <810b29bfb50dad8cdc5a5a7075e0da1104de1665.1655150842.git.andreyknvl@google.com>
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

As kasan_addr_to_page() is only used in report.c, rename it to
addr_to_page() and make it static.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  | 1 -
 mm/kasan/report.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f696d50b09fb..e3f100833154 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -285,7 +285,6 @@ bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
-struct page *kasan_addr_to_page(const void *addr);
 struct slab *kasan_addr_to_slab(const void *addr);
 
 #ifdef CONFIG_KASAN_GENERIC
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ed8234516bab..f3ec6f86b199 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -200,7 +200,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
 		pr_err("(stack is not available)\n");
 }
 
-struct page *kasan_addr_to_page(const void *addr)
+static inline struct page *addr_to_page(const void *addr)
 {
 	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
 		return virt_to_head_page(addr);
@@ -283,7 +283,7 @@ static inline bool init_task_stack_addr(const void *addr)
 
 static void print_address_description(void *addr, u8 tag)
 {
-	struct page *page = kasan_addr_to_page(addr);
+	struct page *page = addr_to_page(addr);
 	struct slab *slab = kasan_addr_to_slab(addr);
 
 	dump_stack_lvl(KERN_ERR);
-- 
2.25.1

