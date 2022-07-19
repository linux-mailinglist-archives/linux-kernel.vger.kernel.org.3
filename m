Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C5578ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiGSAL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiGSALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:11:25 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB632BAD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ehF4bGijVTADFCfUkTF0e1lkPULvRdunOUAUodeJIk=;
        b=CLMXnkWOj2n5IWpBCIiR4ZeX1dUIdiIAbfnEz5VnVO3FX9lheLf/Vgelqcm6jjScybZBSU
        GVDs5blXdQhmebtiukHp3fWAZ04NV7He/Ecisd/1XH/pk0hRDh3VVCqmOI1bt96SSmm3Yw
        niZdVOfFTB+As4u2tDx56QRDcESSs7E=
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
Subject: [PATCH mm v2 06/33] kasan: introduce kasan_print_aux_stacks
Date:   Tue, 19 Jul 2022 02:09:46 +0200
Message-Id: <b94138a02e12dd8f1417dd815a183b296bcc70ef.1658189199.git.andreyknvl@google.com>
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

Add a kasan_print_aux_stacks() helper that prints the auxiliary stack
traces for the Generic mode.

This change hides references to alloc_meta from the common reporting code.
This is desired as only the Generic mode will be using per-object metadata
after this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h          |  6 ++++++
 mm/kasan/report.c         | 15 +--------------
 mm/kasan/report_generic.c | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 15c718782c1f..30ff341b6d35 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -266,6 +266,12 @@ void kasan_print_address_stack_frame(const void *addr);
 static inline void kasan_print_address_stack_frame(const void *addr) { }
 #endif
 
+#ifdef CONFIG_KASAN_GENERIC
+void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object);
+#else
+static inline void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object) { }
+#endif
+
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report_type type);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index fe3f606b3a98..cd9f5c7fc6db 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -270,20 +270,7 @@ static void describe_object_stacks(struct kmem_cache *cache, void *object,
 		pr_err("\n");
 	}
 
-#ifdef CONFIG_KASAN_GENERIC
-	if (!alloc_meta)
-		return;
-	if (alloc_meta->aux_stack[0]) {
-		pr_err("Last potentially related work creation:\n");
-		stack_depot_print(alloc_meta->aux_stack[0]);
-		pr_err("\n");
-	}
-	if (alloc_meta->aux_stack[1]) {
-		pr_err("Second to last potentially related work creation:\n");
-		stack_depot_print(alloc_meta->aux_stack[1]);
-		pr_err("\n");
-	}
-#endif
+	kasan_print_aux_stacks(cache, object);
 }
 
 static void describe_object(struct kmem_cache *cache, void *object,
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 6689fb9a919b..348dc207d462 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -132,6 +132,26 @@ void kasan_metadata_fetch_row(char *buffer, void *row)
 	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
 }
 
+void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return;
+
+	if (alloc_meta->aux_stack[0]) {
+		pr_err("Last potentially related work creation:\n");
+		stack_depot_print(alloc_meta->aux_stack[0]);
+		pr_err("\n");
+	}
+	if (alloc_meta->aux_stack[1]) {
+		pr_err("Second to last potentially related work creation:\n");
+		stack_depot_print(alloc_meta->aux_stack[1]);
+		pr_err("\n");
+	}
+}
+
 #ifdef CONFIG_KASAN_STACK
 static bool __must_check tokenize_frame_descr(const char **frame_descr,
 					      char *token, size_t max_tok_len,
-- 
2.25.1

