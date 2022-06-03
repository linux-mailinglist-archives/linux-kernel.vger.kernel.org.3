Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2F53C377
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiFCDyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiFCDyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:54:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979A31513
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:54:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso11137439pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lq9PaAAUkOHkx4AcYY1vM1d5i0BVbXyZKhkfL+qmMNk=;
        b=S8V6YFCOFgX8PDLZsDNJWzJsn/waZfRN2onxmJaVeXwtTEbhc8Sr74wIeEYFO7M65D
         KBAvBCTzPAHhFCxO/wfLlg+xYcdmK6bCuq1+8rKRtTtL6ov7PIi8sQ6IZJ+mN+LMcRVk
         b9ioEe7c03t+ve8kMODATqS5c9eWG97nySgXQi0nxWTHTe8C0UoRgTZ6jsehpUXDsP4D
         UhVYw5TUJ3P8mlEAQljHnV7y07LirOOliVUimuCVAoUQGkgruAV+tNIFxy+wUwb/YZgJ
         oatO0pLTRhuc03m/XlFRD3yCSL/AErzL6kqaW/aBilunXT4fOiVOolFJGxZh7ApH7kaW
         qYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lq9PaAAUkOHkx4AcYY1vM1d5i0BVbXyZKhkfL+qmMNk=;
        b=JHBrRgyDqh/7++y1E1toj3Y829pNpsl7yhS+V/OZRiYkI/AOcviy5SPeA1iKuXiVRF
         j4g7NRyiGp/9rnRpw/74CecHWhyS+m85VwSBYHwp+xStLgzfCdT298EDwwxWkxlIcGM8
         faN1ZC+MvqH2N0ZMdDX+1nSKe0LFU0aQklpZEip0FoRa7m4ApDmwxkzH88iW8MG+bXhX
         oKJUCHN9eu561cUkl0fJ+z6bgS0HQ9RwmES6WmmUSZYXPKi04fcL61Fky+yEilQIOct8
         ev7fq3Mx1lS0ud1jQSFuL0wyBlmxeZ0qTjcreBtKEkF+5LLfu03sqhN/9kF4j4dVKAG+
         /oaQ==
X-Gm-Message-State: AOAM530Er9Ymdu9HznUyFTdROhDIEERUA6A0jV5gp6HAF66/gkJEWtvh
        zqvE80GuyeNLq4iIneqQjk4=
X-Google-Smtp-Source: ABdhPJynxSbkQybaJsrmvd7I5qxXJyHbTUa/u2cCWN2Ll5D77yawEg+TVEUA/BZkcawq0jWXMw6TBA==
X-Received: by 2002:a17:90b:3b8a:b0:1e2:f1da:bf9b with SMTP id pc10-20020a17090b3b8a00b001e2f1dabf9bmr27399469pjb.77.1654228468890;
        Thu, 02 Jun 2022 20:54:28 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902934700b0015e8d4eb1e5sm4245281plp.47.2022.06.02.20.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:54:28 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v2 2/4] mm: kmemleak: add rbtree for objects allocated with physical address
Date:   Fri,  3 Jun 2022 11:54:13 +0800
Message-Id: <20220603035415.1243913-3-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
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
OBJECT_PHYS flag or function argument.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 99 +++++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 42 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1e9e0aa93ae5..218144392446 100644
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
@@ -380,9 +384,11 @@ static void dump_object_info(struct kmemleak_object *object)
  * beginning of the memory block are allowed. The kmemleak_lock must be held
  * when calling this function.
  */
-static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
+static struct kmemleak_object *lookup_object(unsigned long ptr, int alias,
+					     bool is_phys)
 {
-	struct rb_node *rb = object_tree_root.rb_node;
+	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
+			     object_tree_root.rb_node;
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
@@ -517,14 +523,15 @@ static void put_object(struct kmemleak_object *object)
 /*
  * Look up an object in the object search tree and increase its use_count.
  */
-static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
+static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias,
+						   bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = lookup_object(ptr, alias);
+	object = lookup_object(ptr, alias, is_phys);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
@@ -536,27 +543,32 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 }
 
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
+	object = lookup_object(ptr, alias, is_phys);
 	if (object)
 		__remove_object(object);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -574,7 +586,8 @@ static int __save_stack_trace(unsigned long *trace)
 
 /*
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
- * memory block and add it to the object_list and object_tree_root.
+ * memory block and add it to the object_list and object_tree_root (or
+ * object_phys_tree_root).
  */
 static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 					     int min_count, gfp_t gfp,
@@ -633,7 +646,8 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 	min_addr = min(min_addr, untagged_ptr);
 	max_addr = max(max_addr, untagged_ptr + size);
-	link = &object_tree_root.rb_node;
+	link = is_phys ? &object_phys_tree_root.rb_node :
+		&object_tree_root.rb_node;
 	rb_parent = NULL;
 	while (*link) {
 		rb_parent = *link;
@@ -657,7 +671,8 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 		}
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
-	rb_insert_color(&object->rb_node, &object_tree_root);
+	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
+					  &object_tree_root);
 
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
@@ -693,7 +708,7 @@ static void delete_object_full(unsigned long ptr)
 {
 	struct kmemleak_object *object;
 
-	object = find_and_remove_object(ptr, 0);
+	object = find_and_remove_object(ptr, 0, false);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Freeing unknown object at 0x%08lx\n",
@@ -709,12 +724,12 @@ static void delete_object_full(unsigned long ptr)
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
@@ -756,11 +771,11 @@ static void paint_it(struct kmemleak_object *object, int color)
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
-static void paint_ptr(unsigned long ptr, int color)
+static void paint_ptr(unsigned long ptr, int color, bool is_phys)
 {
 	struct kmemleak_object *object;
 
-	object = find_and_get_object(ptr, 0);
+	object = find_and_get_object(ptr, 0, is_phys);
 	if (!object) {
 		kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
 			      ptr,
@@ -776,18 +791,18 @@ static void paint_ptr(unsigned long ptr, int color)
  * Mark an object permanently as gray-colored so that it can no longer be
  * reported as a leak. This is used in general to mark a false positive.
  */
-static void make_gray_object(unsigned long ptr)
+static void make_gray_object(unsigned long ptr, bool is_phys)
 {
-	paint_ptr(ptr, KMEMLEAK_GREY);
+	paint_ptr(ptr, KMEMLEAK_GREY, is_phys);
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
@@ -802,7 +817,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 	unsigned long untagged_ptr;
 	unsigned long untagged_objp;
 
-	object = find_and_get_object(ptr, 1);
+	object = find_and_get_object(ptr, 1, false);
 	if (!object) {
 		kmemleak_warn("Adding scan area to unknown object at 0x%08lx\n",
 			      ptr);
@@ -852,7 +867,7 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	object = find_and_get_object(ptr, 0);
+	object = find_and_get_object(ptr, 0, false);
 	if (!object) {
 		kmemleak_warn("Setting excess_ref on unknown object at 0x%08lx\n",
 			      ptr);
@@ -875,7 +890,7 @@ static void object_no_scan(unsigned long ptr)
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	object = find_and_get_object(ptr, 0);
+	object = find_and_get_object(ptr, 0, false);
 	if (!object) {
 		kmemleak_warn("Not scanning unknown object at 0x%08lx\n", ptr);
 		return;
@@ -993,7 +1008,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		delete_object_part((unsigned long)ptr, size);
+		delete_object_part((unsigned long)ptr, size, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
 
@@ -1034,7 +1049,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	if (!kmemleak_enabled || IS_ERR_OR_NULL(ptr))
 		return;
 
-	object = find_and_get_object((unsigned long)ptr, 1);
+	object = find_and_get_object((unsigned long)ptr, 1, false);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Updating stack trace for unknown object at %p\n",
@@ -1063,7 +1078,7 @@ void __ref kmemleak_not_leak(const void *ptr)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		make_gray_object((unsigned long)ptr);
+		make_gray_object((unsigned long)ptr, false);
 }
 EXPORT_SYMBOL(kmemleak_not_leak);
 
@@ -1081,7 +1096,7 @@ void __ref kmemleak_ignore(const void *ptr)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		make_black_object((unsigned long)ptr);
+		make_black_object((unsigned long)ptr, false);
 }
 EXPORT_SYMBOL(kmemleak_ignore);
 
@@ -1275,7 +1290,7 @@ static void scan_block(void *_start, void *_end,
 		 * is still present in object_tree_root and object_list
 		 * (with updates protected by kmemleak_lock).
 		 */
-		object = lookup_object(pointer, 1);
+		object = lookup_object(pointer, 1, false);
 		if (!object)
 			continue;
 		if (object == scanned)
@@ -1299,7 +1314,7 @@ static void scan_block(void *_start, void *_end,
 		raw_spin_unlock(&object->lock);
 
 		if (excess_ref) {
-			object = lookup_object(excess_ref, 0);
+			object = lookup_object(excess_ref, 0, false);
 			if (!object)
 				continue;
 			if (object == scanned)
@@ -1728,7 +1743,7 @@ static int dump_str_object_info(const char *str)
 
 	if (kstrtoul(str, 0, &addr))
 		return -EINVAL;
-	object = find_and_get_object(addr, 0);
+	object = find_and_get_object(addr, 0, false);
 	if (!object) {
 		pr_info("Unknown object at 0x%08lx\n", addr);
 		return -EINVAL;
-- 
2.25.1

