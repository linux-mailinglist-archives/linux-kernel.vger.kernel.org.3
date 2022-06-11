Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229505471B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350146AbiFKD6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350136AbiFKD55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:57:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFA57150
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d129so864557pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8IgHE1RR2lgSzL/zu612niRONbvD1GIsUKzYCMHfLRk=;
        b=k8RDJdXnD6VhFoap8uvxpyCiGOeDFnyeRiHkkndgFuxfGJle0gV8LVxbZFM/WBpfPH
         v+lSzdvM9CKpJ+7soW1fG/Zy9klMZGTaHNHAHj3PBOpJ8ob7FCT2gUV+X7SmMXwvz0NB
         1AVpbPSPBwITkKoACGfTlBEyE62Y0gj3GuWgl0BRcVS5bOh5vu5RZ9wD5aAS+1q0oay8
         LGYLx9sqWRQuiqVeADV1Kz2zXYVKFe58cFBxEMUcYp5Mz+S2GHqwnnuJTBTvt6fLWI9x
         TibA+BTwVKvO5r7ee9BWtkFEcU3o4PI7HePcaMGRigGQSO4AracDekSD6HAZ4Hfs2p3U
         gNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8IgHE1RR2lgSzL/zu612niRONbvD1GIsUKzYCMHfLRk=;
        b=InZ6N/+rGZ/V+L2noMVY98nSE7XPgrbRjP6X7VfiROBmYJjKT1++S+LofeJK2PpDZM
         PXWI+n4N6o9KDEh+Xxv1sekaoqN1OW+UgHpDsdIZ4T7XPuu8yprSeXQzo5Ga4vKg18K/
         hIOPgCvdnh9MamfYFNIPu5Es7/4s8ze6kh1aquaWmCLe4sAHNgOcYrCPLWrlZkDM1GFe
         2bIq/+igMw5s/j/V/MGFMenvwL59Pu4VgpX2uXzpVtfwTGwO2tlhDsl8uHtf8761zgs4
         +OdUGMnDCfWP0sqom4a+dZdzwRDNGZ/YizUOQE9OnLZ2P5m3qkaL4dML2D2d3op58awx
         YjMg==
X-Gm-Message-State: AOAM530VsPI89CPK4zc+28Vc+SM0TmPw7fLC8WUQRUhbzhEgwNh+z+Rc
        DioO9rt+2opmrPT9OepCm7e0kPAExTAK6w==
X-Google-Smtp-Source: ABdhPJxhn4I5BgkSwVGDYsJDfN7HPlUaTn39NLNOK8sRZjpRPnCgeR15BF/a9JElXWec6/nFo7jOYw==
X-Received: by 2002:a63:6cb:0:b0:403:af21:972e with SMTP id 194-20020a6306cb000000b00403af21972emr5311847pgg.90.1654919875484;
        Fri, 10 Jun 2022 20:57:55 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id p10-20020a63950a000000b003fbfe88be17sm490493pgd.24.2022.06.10.20.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:57:54 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v4 3/4] mm: kmemleak: add rbtree and store physical address for objects allocated with PA
Date:   Sat, 11 Jun 2022 11:55:50 +0800
Message-Id: <20220611035551.1823303-4-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
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

Add object_phys_tree_root to store the objects allocated with
physical address. Distinguish it from object_tree_root by
OBJECT_PHYS flag or function argument. The physical address
is stored directly in those objects.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 133 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 42 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d82d8db0e8df..155f50e1a604 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -14,14 +14,16 @@
  * The following locks and mutexes are used by kmemleak:
  *
  * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
- *   accesses to the object_tree_root. The object_list is the main list
- *   holding the metadata (struct kmemleak_object) for the allocated memory
- *   blocks. The object_tree_root is a red black tree used to look-up
- *   metadata based on a pointer to the corresponding memory block.  The
- *   kmemleak_object structures are added to the object_list and
- *   object_tree_root in the create_object() function called from the
- *   kmemleak_alloc() callback and removed in delete_object() called from the
- *   kmemleak_free() callback
+ *   accesses to the object_tree_root (or object_phys_tree_root). The
+ *   object_list is the main list holding the metadata (struct kmemleak_object)
+ *   for the allocated memory blocks. The object_tree_root and object_phys_tree_root
+ *   are red black trees used to look-up metadata based on a pointer to the
+ *   corresponding memory block. The object_phys_tree_root is for objects
+ *   allocated with physical address. The kmemleak_object structures are
+ *   added to the object_list and object_tree_root (or object_phys_tree_root)
+ *   in the create_object() function called from the kmemleak_alloc() (or
+ *   kmemleak_alloc_phys()) callback and removed in delete_object() called from
+ *   the kmemleak_free() callback
  * - kmemleak_object.lock (raw_spinlock_t): protects a kmemleak_object.
  *   Accesses to the metadata (e.g. count) are protected by this lock. Note
  *   that some members of this structure may be protected by other means
@@ -195,7 +197,9 @@ static int mem_pool_free_count = ARRAY_SIZE(mem_pool);
 static LIST_HEAD(mem_pool_free_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
-/* protecting the access to object_list and object_tree_root */
+/* search tree for object (with OBJECT_PHYS flag) boundaries */
+static struct rb_root object_phys_tree_root = RB_ROOT;
+/* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
 /* allocation caches for kmemleak internal data */
@@ -287,6 +291,9 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
+	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
+		return;
+
 	/* limit the number of lines to HEX_MAX_LINES */
 	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
 
@@ -380,9 +387,11 @@ static void dump_object_info(struct kmemleak_object *object)
  * beginning of the memory block are allowed. The kmemleak_lock must be held
  * when calling this function.
  */
-static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
+static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
+					       bool is_phys)
 {
-	struct rb_node *rb = object_tree_root.rb_node;
+	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
+			     object_tree_root.rb_node;
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
@@ -408,6 +417,12 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
 	return NULL;
 }
 
+/* Look-up a kmemleak object which allocated with virtual address. */
+static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
+{
+	return __lookup_object(ptr, alias, false);
+}
+
 /*
  * Increment the object use_count. Return 1 if successful or 0 otherwise. Note
  * that once an object's use_count reached 0, the RCU freeing was already
@@ -517,14 +532,15 @@ static void put_object(struct kmemleak_object *object)
 /*
  * Look up an object in the object search tree and increase its use_count.
  */
-static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
+static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alias,
+						     bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = lookup_object(ptr, alias);
+	object = __lookup_object(ptr, alias, is_phys);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
@@ -535,28 +551,39 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 	return object;
 }
 
+/* Look up and get an object which allocated with virtual address. */
+static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
+{
+	return __find_and_get_object(ptr, alias, false);
+}
+
 /*
- * Remove an object from the object_tree_root and object_list. Must be called
- * with the kmemleak_lock held _if_ kmemleak is still enabled.
+ * Remove an object from the object_tree_root (or object_phys_tree_root)
+ * and object_list. Must be called with the kmemleak_lock held _if_ kmemleak
+ * is still enabled.
  */
 static void __remove_object(struct kmemleak_object *object)
 {
-	rb_erase(&object->rb_node, &object_tree_root);
+	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
+				   &object_phys_tree_root :
+				   &object_tree_root);
 	list_del_rcu(&object->object_list);
 }
 
 /*
  * Look up an object in the object search tree and remove it from both
- * object_tree_root and object_list. The returned object's use_count should be
- * at least 1, as initially set by create_object().
+ * object_tree_root (or object_phys_tree_root) and object_list. The
+ * returned object's use_count should be at least 1, as initially set
+ * by create_object().
  */
-static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int alias)
+static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int alias,
+						      bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = lookup_object(ptr, alias);
+	object = __lookup_object(ptr, alias, is_phys);
 	if (object)
 		__remove_object(object);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -574,7 +601,8 @@ static int __save_stack_trace(unsigned long *trace)
 
 /*
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
- * memory block and add it to the object_list and object_tree_root.
+ * memory block and add it to the object_list and object_tree_root (or
+ * object_phys_tree_root).
  */
 static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 					     int min_count, gfp_t gfp,
@@ -631,9 +659,16 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
-	min_addr = min(min_addr, untagged_ptr);
-	max_addr = max(max_addr, untagged_ptr + size);
-	link = &object_tree_root.rb_node;
+	/*
+	 * Only update min_addr and max_addr with object
+	 * storing virtual address.
+	 */
+	if (!is_phys) {
+		min_addr = min(min_addr, untagged_ptr);
+		max_addr = max(max_addr, untagged_ptr + size);
+	}
+	link = is_phys ? &object_phys_tree_root.rb_node :
+		&object_tree_root.rb_node;
 	rb_parent = NULL;
 	while (*link) {
 		rb_parent = *link;
@@ -657,7 +692,8 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 		}
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
-	rb_insert_color(&object->rb_node, &object_tree_root);
+	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
+					  &object_tree_root);
 
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
@@ -707,7 +743,7 @@ static void delete_object_full(unsigned long ptr)
 {
 	struct kmemleak_object *object;
 
-	object = find_and_remove_object(ptr, 0);
+	object = find_and_remove_object(ptr, 0, false);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Freeing unknown object at 0x%08lx\n",
@@ -723,12 +759,12 @@ static void delete_object_full(unsigned long ptr)
  * delete it. If the memory block is partially freed, the function may create
  * additional metadata for the remaining parts of the block.
  */
-static void delete_object_part(unsigned long ptr, size_t size)
+static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 {
 	struct kmemleak_object *object;
 	unsigned long start, end;
 
-	object = find_and_remove_object(ptr, 1);
+	object = find_and_remove_object(ptr, 1, is_phys);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
@@ -746,10 +782,10 @@ static void delete_object_part(unsigned long ptr, size_t size)
 	end = object->pointer + object->size;
 	if (ptr > start)
 		__create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL, object->flags & OBJECT_PHYS);
+			      GFP_KERNEL, is_phys);
 	if (ptr + size < end)
 		__create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL, object->flags & OBJECT_PHYS);
+			      GFP_KERNEL, is_phys);
 
 	__delete_object(object);
 }
@@ -770,11 +806,11 @@ static void paint_it(struct kmemleak_object *object, int color)
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
-static void paint_ptr(unsigned long ptr, int color)
+static void paint_ptr(unsigned long ptr, int color, bool is_phys)
 {
 	struct kmemleak_object *object;
 
-	object = find_and_get_object(ptr, 0);
+	object = __find_and_get_object(ptr, 0, is_phys);
 	if (!object) {
 		kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
 			      ptr,
@@ -792,16 +828,16 @@ static void paint_ptr(unsigned long ptr, int color)
  */
 static void make_gray_object(unsigned long ptr)
 {
-	paint_ptr(ptr, KMEMLEAK_GREY);
+	paint_ptr(ptr, KMEMLEAK_GREY, false);
 }
 
 /*
  * Mark the object as black-colored so that it is ignored from scans and
  * reporting.
  */
-static void make_black_object(unsigned long ptr)
+static void make_black_object(unsigned long ptr, bool is_phys)
 {
-	paint_ptr(ptr, KMEMLEAK_BLACK);
+	paint_ptr(ptr, KMEMLEAK_BLACK, is_phys);
 }
 
 /*
@@ -1007,7 +1043,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		delete_object_part((unsigned long)ptr, size);
+		delete_object_part((unsigned long)ptr, size, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
 
@@ -1095,7 +1131,7 @@ void __ref kmemleak_ignore(const void *ptr)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		make_black_object((unsigned long)ptr);
+		make_black_object((unsigned long)ptr, false);
 }
 EXPORT_SYMBOL(kmemleak_ignore);
 
@@ -1153,7 +1189,7 @@ void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 		 * Create object with OBJECT_PHYS flag and
 		 * assume min_count 0.
 		 */
-		create_object_phys((unsigned long)__va(phys), size, 0, gfp);
+		create_object_phys((unsigned long)phys, size, 0, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
@@ -1166,8 +1202,10 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
+	pr_debug("%s(0x%pa)\n", __func__, &phys);
+
 	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_free_part(__va(phys), size);
+		delete_object_part((unsigned long)phys, size, true);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
 
@@ -1178,8 +1216,10 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
+	pr_debug("%s(0x%pa)\n", __func__, &phys);
+
 	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_ignore(__va(phys));
+		make_black_object((unsigned long)phys, true);
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
@@ -1190,6 +1230,9 @@ static bool update_checksum(struct kmemleak_object *object)
 {
 	u32 old_csum = object->checksum;
 
+	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
+		return false;
+
 	kasan_disable_current();
 	kcsan_disable_current();
 	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
@@ -1343,6 +1386,7 @@ static void scan_object(struct kmemleak_object *object)
 {
 	struct kmemleak_scan_area *area;
 	unsigned long flags;
+	void *obj_ptr;
 
 	/*
 	 * Once the object->lock is acquired, the corresponding memory block
@@ -1354,10 +1398,15 @@ static void scan_object(struct kmemleak_object *object)
 	if (!(object->flags & OBJECT_ALLOCATED))
 		/* already freed object */
 		goto out;
+
+	obj_ptr = object->flags & OBJECT_PHYS ?
+		  __va((phys_addr_t)object->pointer) :
+		  (void *)object->pointer;
+
 	if (hlist_empty(&object->area_list) ||
 	    object->flags & OBJECT_FULL_SCAN) {
-		void *start = (void *)object->pointer;
-		void *end = (void *)(object->pointer + object->size);
+		void *start = obj_ptr;
+		void *end = obj_ptr + object->size;
 		void *next;
 
 		do {
-- 
2.25.1

