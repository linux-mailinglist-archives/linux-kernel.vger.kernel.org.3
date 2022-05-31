Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483E5393A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbiEaPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344598AbiEaPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:08:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC5522F6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:08:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z17so914115pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtCLAKrrxmjphjB0BYwYyVIB4i2GvLJx2UtZm9gUnlU=;
        b=TF2M/32Edn8t/rV3dSAIATQsHZuBGBzlo28InI+/KY9hjzD8pdGp8qTtJrjUOxPks0
         Oud8wqyVZ9i0s6ZieFJ0Q7nO+ZwZhPxcCfgxklupP5AhE5l4MY319a01REFFFN5cM6LK
         /YS9O92hdO2+bozphu/4LJG9d3wPzDPxN8gQ9MY9SSRCmbiiR7jl8Ft9Y0t1qt7XJwg0
         YqQ5a89Bu7uBxOrLr3XOsIRN9LStSSGsEf4C24NLxgABVtgAzIJ7ihKH56ZMonzpSalC
         ZQZEJnjF/vBQNGwE7NUTwHz6n2H1vbksT+PWhtoc8HmwVvHgPZtn2FPOhGNQbj1TdcES
         Tb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtCLAKrrxmjphjB0BYwYyVIB4i2GvLJx2UtZm9gUnlU=;
        b=uJDXfw3Nbs7RWwddsbH3/jc+cSgz4X7OLExaVbki9ugT0rkoGi1gc5gCzw+kjS0I9U
         EyCrIjFej8cNdxL+v/FXkfGrtGS1TxsmNjhaLWPdXtFDeWxiZOzhXcyImmLIhGhr9NMH
         Z+/em4gkf4lPXLCQMEaYK+tF4Z7W9oI0XChyIDRzEAQ0l+Ap0TLC6BLqeKRqBzSOFFKI
         RPcJQ5WsVXbt8EHNvSJ1MLlrXQf1WUt/HJCCqh/0KY8e056mtLr17ZQwV6H3TqpECm7+
         YVkiOMeMWkhuwFhZudfiSSKGMk/cma1vlb1OR0+VLhdIrzckNdByeqcwjxoZaDIEqm//
         7l8g==
X-Gm-Message-State: AOAM530B1C25AxwFbSpNPF9rzHGea/t1CqKCTm2l3DVo80fbcMc1w8GR
        OwQKDbHpCtk6LF/puk/ND+k=
X-Google-Smtp-Source: ABdhPJySQbQrXw9IAMlZIL+zaMfuj2Xy8+0EBHV1FPz/ikjEX9ROzk1C/I7oAe0PDIzwgkIjcG6EWg==
X-Received: by 2002:a05:6a00:996:b0:505:b6d2:abc8 with SMTP id u22-20020a056a00099600b00505b6d2abc8mr62215705pfg.11.1654009715299;
        Tue, 31 May 2022 08:08:35 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id ij17-20020a170902ab5100b00163c0a1f718sm6133835plb.303.2022.05.31.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:08:35 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH] mm: kmemleak: check boundary of objects allocated with physical address when scan
Date:   Tue, 31 May 2022 23:08:23 +0800
Message-Id: <20220531150823.1004101-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmemleak_*_phys() interface uses "min_low_pfn" and
"max_low_pfn" to check address. But on some architectures,
kmemleak_*_phys() is called before those two variables
initialized. Add OBJECT_PHYS flag for the objects allocated
with physical address, and check the boundary when scan
instead of in kmemleak_*_phys().

This commit will solve:
https://lore.kernel.org/r/20220527032504.30341-1-yee.lee@mediatek.com
https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a182f5ddaf68..1e2f90db9850 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -172,6 +172,8 @@ struct kmemleak_object {
 #define OBJECT_NO_SCAN		(1 << 2)
 /* flag set to fully scan the object when scan_area allocation failed */
 #define OBJECT_FULL_SCAN	(1 << 3)
+/* flag set for object allocated with physical address */
+#define OBJECT_PHYS		(1 << 4)
 
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
@@ -575,7 +577,8 @@ static int __save_stack_trace(unsigned long *trace)
  * memory block and add it to the object_list and object_tree_root.
  */
 static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+					     int min_count, gfp_t gfp,
+					     bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
@@ -595,7 +598,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED;
+	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
@@ -729,10 +732,10 @@ static void delete_object_part(unsigned long ptr, size_t size)
 	end = object->pointer + object->size;
 	if (ptr > start)
 		create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL);
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 	if (ptr + size < end)
 		create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL);
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 
 	__delete_object(object);
 }
@@ -904,7 +907,7 @@ void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
 	pr_debug("%s(0x%p, %zu, %d)\n", __func__, ptr, size, min_count);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		create_object((unsigned long)ptr, size, min_count, gfp);
+		create_object((unsigned long)ptr, size, min_count, gfp, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc);
 
@@ -931,7 +934,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		for_each_possible_cpu(cpu)
 			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
-				      size, 0, gfp);
+				      size, 0, gfp, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -953,7 +956,7 @@ void __ref kmemleak_vmalloc(const struct vm_struct *area, size_t size, gfp_t gfp
 	 * the virtual address of the vmalloc'ed block.
 	 */
 	if (kmemleak_enabled) {
-		create_object((unsigned long)area->addr, size, 2, gfp);
+		create_object((unsigned long)area->addr, size, 2, gfp, false);
 		object_set_excess_ref((unsigned long)area,
 				      (unsigned long)area->addr);
 	}
@@ -1132,8 +1135,13 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_alloc(__va(phys), size, min_count, gfp);
+	pr_debug("%s(0x%p, %zu, %d)\n", __func__, __va(phys), size, min_count);
+
+	if (kmemleak_enabled && (unsigned long)__va(phys) >= PAGE_OFFSET &&
+	    !IS_ERR(__va(phys)))
+		/* create object with OBJECT_PHYS flag */
+		create_object((unsigned long)__va(phys), size, min_count,
+			      gfp, true);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
@@ -1146,8 +1154,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_free_part(__va(phys), size);
+	kmemleak_free_part(__va(phys), size);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
 
@@ -1158,8 +1165,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_not_leak_phys(phys_addr_t phys)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_not_leak(__va(phys));
+	kmemleak_not_leak(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_not_leak_phys);
 
@@ -1170,8 +1176,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_ignore(__va(phys));
+	kmemleak_ignore(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
@@ -1436,6 +1441,13 @@ static void kmemleak_scan(void)
 			dump_object_info(object);
 		}
 #endif
+
+		/* outside lowmem, make it black */
+		if (object->flags & OBJECT_PHYS)
+			if (PHYS_PFN(__pa((void *)object->pointer)) < min_low_pfn ||
+			    PHYS_PFN(__pa((void *)object->pointer)) >= max_low_pfn)
+				__paint_it(object, KMEMLEAK_BLACK);
+
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
 		if (color_gray(object) && get_object(object))
@@ -1966,14 +1978,14 @@ void __init kmemleak_init(void)
 
 	/* register the data/bss sections */
 	create_object((unsigned long)_sdata, _edata - _sdata,
-		      KMEMLEAK_GREY, GFP_ATOMIC);
+		      KMEMLEAK_GREY, GFP_ATOMIC, false);
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
-		      KMEMLEAK_GREY, GFP_ATOMIC);
+		      KMEMLEAK_GREY, GFP_ATOMIC, false);
 	/* only register .data..ro_after_init if not within .data */
 	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
 			      __end_ro_after_init - __start_ro_after_init,
-			      KMEMLEAK_GREY, GFP_ATOMIC);
+			      KMEMLEAK_GREY, GFP_ATOMIC, false);
 }
 
 /*
-- 
2.25.1

