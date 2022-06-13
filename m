Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E454A08D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiFMU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352078AbiFMUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:09 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCEB1A07A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:19:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8Ujjn8ODA+o6f5+82XskCVtNKiV5I0P+bzfQLYNt08=;
        b=tNdYTuepZITenpSdu58grTXSjaXt9OL81buen5Wm+++wlMotQfJq9n+UcKkTTT5gZ+gc4f
        uF7AU1aiTFH85x0uVzzaLfcIcYPfeoCLX+3KfygTgZO4Vq+i5p7QD74yy+0ekX5HwMhW75
        QJqnizRPQmY2NxNZs3S4Cds/DJ8v8dA=
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
Subject: [PATCH 24/32] kasan: move kasan_addr_to_slab to common.c
Date:   Mon, 13 Jun 2022 22:14:15 +0200
Message-Id: <5ea6f55fb645405bb52cb15b8d30544ba3f189b0.1655150842.git.andreyknvl@google.com>
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

Move the definition of kasan_addr_to_slab() to the common KASAN code,
as this function is not only used by the reporting code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 7 +++++++
 mm/kasan/report.c | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 519fd0b3040b..5d5b4cfae503 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -30,6 +30,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
+struct slab *kasan_addr_to_slab(const void *addr)
+{
+	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
+		return virt_to_slab(addr);
+	return NULL;
+}
+
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 1dd6fc8a678f..ed8234516bab 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -207,13 +207,6 @@ struct page *kasan_addr_to_page(const void *addr)
 	return NULL;
 }
 
-struct slab *kasan_addr_to_slab(const void *addr)
-{
-	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
-		return virt_to_slab(addr);
-	return NULL;
-}
-
 static void describe_object_addr(struct kmem_cache *cache, void *object,
 				const void *addr)
 {
-- 
2.25.1

