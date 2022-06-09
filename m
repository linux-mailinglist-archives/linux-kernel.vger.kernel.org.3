Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F6544C98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbiFIMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbiFIMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:51:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7456399
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:50:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1318687pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EATzTqJA26CcqIUbCI5V7nNL9XJq45wIulrxBrVLYks=;
        b=Nr4lPTaBeFU/+ThnnKI5ZNeBs4isqeW/eCkDJqq9HffaN3pRiipHzVVf6GA3vU2F1N
         biOi5JsicylGuvpsd0eDUQY224O0fKgUe5y1xiZlEt1W7saYBn3N+Lz/dg2IFGwg6oua
         L6a3UjjXwzwzTZhPk8qquS2/O0EztFAkXVCyFcYHmhujMF1bbOooo0+eU4foE0FCSoyI
         ZF5YjADR6p2sBkhSF5AKia1IzcomLMypmaKPVeJfu9ihTyAliSHRZVmv5rqgVPSP6RXf
         6Q1STj3KtMI+Yrko16o5QcVpRVoUsQwd8PHdukPC7V13qVYxg4JqgqIK7pmEqX1EuCvI
         qzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EATzTqJA26CcqIUbCI5V7nNL9XJq45wIulrxBrVLYks=;
        b=CeQ2rTZCqL9gxJrzYHo8IDB2TgN29REtNgehDSdUANc/QKTQ/+u+btSVQBWyzM+sym
         UG2PbLTIAi4SoODGcdr15YzOdAZt1oYLw7THoJqmHV1yiRQdNdfdMeem15Km0FEk2ucP
         0HhILULz6wsX2azguf55hZr1IJZALULHKHxeFHE+L08I3faBDgLRUfNcd0dAdMolSDpM
         +HfNdp3oBfxl1M9ghxtve7T564x041CwZfy4NOdxXUftRg5YqT8x5G9O10vplUYJy8Ql
         IIurGEAjaTgqOcukIVdk3aP2rbpZz6PgSHyG4/mi58xOUToeBNtFkemrSMjHwyO7PQ5C
         YNwQ==
X-Gm-Message-State: AOAM530oYscDi0BMQf3hmJqLRbPOEOF0jrR5sOhfwCA/vwHw32An1AoJ
        /ZTWDUt3YCcvBSjPQAueZdQ=
X-Google-Smtp-Source: ABdhPJyqLFXK6TLZ5EjskzrqgxTJtqZHVVP6dGqh5/Fk1wWI6DsuvX5n6d53xH7ufOvPa1ojiTtwdw==
X-Received: by 2002:a17:90a:3182:b0:1e3:530d:6994 with SMTP id j2-20020a17090a318200b001e3530d6994mr3341173pjb.69.1654779058703;
        Thu, 09 Jun 2022 05:50:58 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id b20-20020aa79514000000b0051b97828505sm17262562pfp.166.2022.06.09.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:50:58 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v3 1/3] mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical address
Date:   Thu,  9 Jun 2022 20:49:48 +0800
Message-Id: <20220609124950.1694394-2-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
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

Add OBJECT_PHYS flag for object. This flag is used
to identify the objects allocated with physical
address.The create_object_phys() function is added as
well to set that flag. And remove the min_count
argument to kmemleak_alloc_phys() function, assume
it's 0.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 drivers/of/fdt.c                        |  2 +-
 include/linux/kmemleak.h                |  4 +--
 mm/kmemleak.c                           | 44 ++++++++++++++++++-------
 mm/memblock.c                           | 14 ++++----
 tools/testing/memblock/linux/kmemleak.h |  2 +-
 5 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..2c677e84c3f5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -529,7 +529,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
 			if (!nomap)
-				kmemleak_alloc_phys(base, size, 0, 0);
+				kmemleak_alloc_phys(base, size, 0);
 		}
 		else
 			pr_info("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 34684b2026ab..df245d875b1e 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -29,7 +29,7 @@ extern void kmemleak_not_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
-extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
+extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				gfp_t gfp) __ref;
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
 extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
@@ -107,7 +107,7 @@ static inline void kmemleak_no_scan(const void *ptr)
 {
 }
 static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
-				       int min_count, gfp_t gfp)
+				       gfp_t gfp)
 {
 }
 static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a182f5ddaf68..85ed719e750d 100644
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
@@ -574,8 +576,9 @@ static int __save_stack_trace(unsigned long *trace)
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
  * memory block and add it to the object_list and object_tree_root.
  */
-static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
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
@@ -662,6 +665,20 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	return object;
 }
 
+/* Create kmemleak object which allocated with virtual address. */
+static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp)
+{
+	return __create_object(ptr, size, min_count, gfp, false);
+}
+
+/* Create kmemleak object which allocated with physical address. */
+static struct kmemleak_object *create_object_phys(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp)
+{
+	return __create_object(ptr, size, min_count, gfp, true);
+}
+
 /*
  * Mark the object as not allocated and schedule RCU freeing via put_object().
  */
@@ -728,11 +745,11 @@ static void delete_object_part(unsigned long ptr, size_t size)
 	start = object->pointer;
 	end = object->pointer + object->size;
 	if (ptr > start)
-		create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL);
+		__create_object(start, ptr - start, object->min_count,
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 	if (ptr + size < end)
-		create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL);
+		__create_object(ptr + size, end - ptr - size, object->min_count,
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 
 	__delete_object(object);
 }
@@ -1125,15 +1142,18 @@ EXPORT_SYMBOL(kmemleak_no_scan);
  *			 address argument
  * @phys:	physical address of the object
  * @size:	size of the object
- * @min_count:	minimum number of references to this object.
- *              See kmemleak_alloc()
  * @gfp:	kmalloc() flags used for kmemleak internal memory allocations
  */
-void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
-			       gfp_t gfp)
+void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
+	pr_debug("%s(0x%pa, %zu)\n", __func__, &phys, size);
+
 	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_alloc(__va(phys), size, min_count, gfp);
+		/*
+		 * Create object with OBJECT_PHYS flag and
+		 * assume min_count 0.
+		 */
+		create_object_phys((unsigned long)__va(phys), size, 0, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8e56..749abd2685c4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1345,8 +1345,8 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
  * from the regions with mirroring enabled and then retried from any
  * memory region.
  *
- * In addition, function sets the min_count to 0 using kmemleak_alloc_phys for
- * allocated boot memory block, so that it is never reported as leaks.
+ * In addition, function using kmemleak_alloc_phys for allocated boot
+ * memory block, it is never reported as leaks.
  *
  * Return:
  * Physical address of allocated memory block on success, %0 on failure.
@@ -1398,12 +1398,12 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	 */
 	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
 		/*
-		 * The min_count is set to 0 so that memblock allocated
-		 * blocks are never reported as leaks. This is because many
-		 * of these blocks are only referred via the physical
-		 * address which is not looked up by kmemleak.
+		 * Memblock allocated blocks are never reported as
+		 * leaks. This is because many of these blocks are
+		 * only referred via the physical address which is
+		 * not looked up by kmemleak.
 		 */
-		kmemleak_alloc_phys(found, size, 0, 0);
+		kmemleak_alloc_phys(found, size, 0);
 
 	return found;
 }
diff --git a/tools/testing/memblock/linux/kmemleak.h b/tools/testing/memblock/linux/kmemleak.h
index 462f8c5e8aa0..5fed13bb9ec4 100644
--- a/tools/testing/memblock/linux/kmemleak.h
+++ b/tools/testing/memblock/linux/kmemleak.h
@@ -7,7 +7,7 @@ static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 }
 
 static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
-				       int min_count, gfp_t gfp)
+				       gfp_t gfp)
 {
 }
 
-- 
2.25.1

