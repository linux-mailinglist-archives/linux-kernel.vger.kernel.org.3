Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23B5A7469
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiHaDVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiHaDUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4264C618
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso19832540pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Aa9yqb8lqoZTwAblsaxo7iVAt4Fo5BpnbvdwKRhtu2w=;
        b=h7WvKt+dUFOBsAYlRo/uJqchGIfXUfUuKWd6zCwlKIFeMb6CJxQfkVgOpK4ayoCP84
         s+9IqY2ANy0W/ch18D3lPWZKnnpMY8wz8I3zbhj2/Gh2e5e8e/Unv1bInQSZgKN4zVlW
         yoeJDM+QlTqwrFQuQbCFy/c1VrF5YnE7aakkjnwlxYyctPIchbtli2hfw7Y3jdA4l/W/
         DFYrVb3MQ8eUsIoAFIoV8dznIl15cXTJKdBlLJqs4/3gPT6gIdqnZSHt1x+R7/gbvbFi
         045lJL96THdxnyze7WqFqAQjxRFSXHOUJXAEAtaj2b7iDdlh5ypWKXi6FkcBnm091oB8
         j3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Aa9yqb8lqoZTwAblsaxo7iVAt4Fo5BpnbvdwKRhtu2w=;
        b=fcESER7SB9zl1Xf5gbHBR7qpFN4URwwODrGZoEsIZ1/k96jl8mpcCo/2ZZOw175e0Z
         Cjcoe2yxPnWkc+GnoZC78NNw720ke1uVgTmhLHRthIDGY7x4gRbriEaWBIkdTQl4/LrM
         xVFsQ1QO648Y6x4B8l+MRoFISLyl5+2rnJTgA6DzaYl5YLCyJkqk7TopFLkJnyzlS37+
         09UK6hn5JwT3fE8L/WJ4VtVFIouKKWVKPv+2MvGSXIhzbujYVxS8OLq5stvThVuDZ7eG
         W/HFW739/h4nUROLb/ZKEfVJs2ofzVzlZ+sv2KhMhve+4pBRA/EIPl0OnX43qRPbBhQZ
         GM1A==
X-Gm-Message-State: ACgBeo3OQPMsNZjHJPisjpy66XkT+Hfks+PAwbqoLBuKPJtJpaHiYJRL
        IJRxxY6oQ/k9TixqUmFXT6fZug==
X-Google-Smtp-Source: AA6agR7xt56mkesUzkLJqn+xuZ4Qnr9M3/bm6/s2f5r7foTtKA+jk2//H6GVazB4X1hWoBsbWYXCag==
X-Received: by 2002:a17:90a:d151:b0:1fa:b2a6:226a with SMTP id t17-20020a17090ad15100b001fab2a6226amr1197842pjw.104.1661916027839;
        Tue, 30 Aug 2022 20:20:27 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:27 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 4/7] ksm: add the ksm prefix to the names of the ksm private structures
Date:   Wed, 31 Aug 2022 11:19:48 +0800
Message-Id: <20220831031951.43152-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
References: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent the name of the private structure of ksm
from being the same as the name of the common structure used
in subsequent patches, prefix their names with ksm in advance.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/mm/ksm.rst |   2 +-
 mm/ksm.c                 | 216 +++++++++++++++++++--------------------
 2 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/Documentation/mm/ksm.rst b/Documentation/mm/ksm.rst
index 9e37add068e6..f83cfbc12f4c 100644
--- a/Documentation/mm/ksm.rst
+++ b/Documentation/mm/ksm.rst
@@ -26,7 +26,7 @@ tree.
 
 If a KSM page is shared between less than ``max_page_sharing`` VMAs,
 the node of the stable tree that represents such KSM page points to a
-list of struct rmap_item and the ``page->mapping`` of the
+list of struct ksm_rmap_item and the ``page->mapping`` of the
 KSM page points to the stable tree node.
 
 When the sharing passes this threshold, KSM adds a second dimension to
diff --git a/mm/ksm.c b/mm/ksm.c
index e34cc21d5556..3937111f9ab8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -82,7 +82,7 @@
  *   different KSM page copy of that content
  *
  * Internally, the regular nodes, "dups" and "chains" are represented
- * using the same struct stable_node structure.
+ * using the same struct ksm_stable_node structure.
  *
  * In addition to the stable tree, KSM uses a second data structure called the
  * unstable tree: this tree holds pointers to pages which have been found to
@@ -112,16 +112,16 @@
  */
 
 /**
- * struct mm_slot - ksm information per mm that is being scanned
+ * struct ksm_mm_slot - ksm information per mm that is being scanned
  * @link: link to the mm_slots hash list
  * @mm_list: link into the mm_slots list, rooted in ksm_mm_head
  * @rmap_list: head for this mm_slot's singly-linked list of rmap_items
  * @mm: the mm that this information is valid for
  */
-struct mm_slot {
+struct ksm_mm_slot {
 	struct hlist_node link;
 	struct list_head mm_list;
-	struct rmap_item *rmap_list;
+	struct ksm_rmap_item *rmap_list;
 	struct mm_struct *mm;
 };
 
@@ -135,14 +135,14 @@ struct mm_slot {
  * There is only the one ksm_scan instance of this cursor structure.
  */
 struct ksm_scan {
-	struct mm_slot *mm_slot;
+	struct ksm_mm_slot *mm_slot;
 	unsigned long address;
-	struct rmap_item **rmap_list;
+	struct ksm_rmap_item **rmap_list;
 	unsigned long seqnr;
 };
 
 /**
- * struct stable_node - node of the stable rbtree
+ * struct ksm_stable_node - node of the stable rbtree
  * @node: rb node of this ksm page in the stable tree
  * @head: (overlaying parent) &migrate_nodes indicates temporarily on that list
  * @hlist_dup: linked into the stable_node->hlist with a stable_node chain
@@ -153,7 +153,7 @@ struct ksm_scan {
  * @rmap_hlist_len: number of rmap_item entries in hlist or STABLE_NODE_CHAIN
  * @nid: NUMA node id of stable tree in which linked (may not match kpfn)
  */
-struct stable_node {
+struct ksm_stable_node {
 	union {
 		struct rb_node node;	/* when node of stable tree */
 		struct {		/* when listed for migration */
@@ -182,7 +182,7 @@ struct stable_node {
 };
 
 /**
- * struct rmap_item - reverse mapping item for virtual addresses
+ * struct ksm_rmap_item - reverse mapping item for virtual addresses
  * @rmap_list: next rmap_item in mm_slot's singly-linked rmap_list
  * @anon_vma: pointer to anon_vma for this mm,address, when in stable tree
  * @nid: NUMA node id of unstable tree in which linked (may not match page)
@@ -193,8 +193,8 @@ struct stable_node {
  * @head: pointer to stable_node heading this list in the stable tree
  * @hlist: link into hlist of rmap_items hanging off that stable_node
  */
-struct rmap_item {
-	struct rmap_item *rmap_list;
+struct ksm_rmap_item {
+	struct ksm_rmap_item *rmap_list;
 	union {
 		struct anon_vma *anon_vma;	/* when stable */
 #ifdef CONFIG_NUMA
@@ -207,7 +207,7 @@ struct rmap_item {
 	union {
 		struct rb_node node;	/* when node of unstable tree */
 		struct {		/* when listed from stable tree */
-			struct stable_node *head;
+			struct ksm_stable_node *head;
 			struct hlist_node hlist;
 		};
 	};
@@ -230,7 +230,7 @@ static LIST_HEAD(migrate_nodes);
 #define MM_SLOTS_HASH_BITS 10
 static DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
-static struct mm_slot ksm_mm_head = {
+static struct ksm_mm_slot ksm_mm_head = {
 	.mm_list = LIST_HEAD_INIT(ksm_mm_head.mm_list),
 };
 static struct ksm_scan ksm_scan = {
@@ -298,21 +298,21 @@ static DECLARE_WAIT_QUEUE_HEAD(ksm_iter_wait);
 static DEFINE_MUTEX(ksm_thread_mutex);
 static DEFINE_SPINLOCK(ksm_mmlist_lock);
 
-#define KSM_KMEM_CACHE(__struct, __flags) kmem_cache_create("ksm_"#__struct,\
+#define KSM_KMEM_CACHE(__struct, __flags) kmem_cache_create(#__struct,\
 		sizeof(struct __struct), __alignof__(struct __struct),\
 		(__flags), NULL)
 
 static int __init ksm_slab_init(void)
 {
-	rmap_item_cache = KSM_KMEM_CACHE(rmap_item, 0);
+	rmap_item_cache = KSM_KMEM_CACHE(ksm_rmap_item, 0);
 	if (!rmap_item_cache)
 		goto out;
 
-	stable_node_cache = KSM_KMEM_CACHE(stable_node, 0);
+	stable_node_cache = KSM_KMEM_CACHE(ksm_stable_node, 0);
 	if (!stable_node_cache)
 		goto out_free1;
 
-	mm_slot_cache = KSM_KMEM_CACHE(mm_slot, 0);
+	mm_slot_cache = KSM_KMEM_CACHE(ksm_mm_slot, 0);
 	if (!mm_slot_cache)
 		goto out_free2;
 
@@ -334,18 +334,18 @@ static void __init ksm_slab_free(void)
 	mm_slot_cache = NULL;
 }
 
-static __always_inline bool is_stable_node_chain(struct stable_node *chain)
+static __always_inline bool is_stable_node_chain(struct ksm_stable_node *chain)
 {
 	return chain->rmap_hlist_len == STABLE_NODE_CHAIN;
 }
 
-static __always_inline bool is_stable_node_dup(struct stable_node *dup)
+static __always_inline bool is_stable_node_dup(struct ksm_stable_node *dup)
 {
 	return dup->head == STABLE_NODE_DUP_HEAD;
 }
 
-static inline void stable_node_chain_add_dup(struct stable_node *dup,
-					     struct stable_node *chain)
+static inline void stable_node_chain_add_dup(struct ksm_stable_node *dup,
+					     struct ksm_stable_node *chain)
 {
 	VM_BUG_ON(is_stable_node_dup(dup));
 	dup->head = STABLE_NODE_DUP_HEAD;
@@ -354,14 +354,14 @@ static inline void stable_node_chain_add_dup(struct stable_node *dup,
 	ksm_stable_node_dups++;
 }
 
-static inline void __stable_node_dup_del(struct stable_node *dup)
+static inline void __stable_node_dup_del(struct ksm_stable_node *dup)
 {
 	VM_BUG_ON(!is_stable_node_dup(dup));
 	hlist_del(&dup->hlist_dup);
 	ksm_stable_node_dups--;
 }
 
-static inline void stable_node_dup_del(struct stable_node *dup)
+static inline void stable_node_dup_del(struct ksm_stable_node *dup)
 {
 	VM_BUG_ON(is_stable_node_chain(dup));
 	if (is_stable_node_dup(dup))
@@ -373,9 +373,9 @@ static inline void stable_node_dup_del(struct stable_node *dup)
 #endif
 }
 
-static inline struct rmap_item *alloc_rmap_item(void)
+static inline struct ksm_rmap_item *alloc_rmap_item(void)
 {
-	struct rmap_item *rmap_item;
+	struct ksm_rmap_item *rmap_item;
 
 	rmap_item = kmem_cache_zalloc(rmap_item_cache, GFP_KERNEL |
 						__GFP_NORETRY | __GFP_NOWARN);
@@ -384,14 +384,14 @@ static inline struct rmap_item *alloc_rmap_item(void)
 	return rmap_item;
 }
 
-static inline void free_rmap_item(struct rmap_item *rmap_item)
+static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
 {
 	ksm_rmap_items--;
 	rmap_item->mm = NULL;	/* debug safety */
 	kmem_cache_free(rmap_item_cache, rmap_item);
 }
 
-static inline struct stable_node *alloc_stable_node(void)
+static inline struct ksm_stable_node *alloc_stable_node(void)
 {
 	/*
 	 * The allocation can take too long with GFP_KERNEL when memory is under
@@ -401,28 +401,28 @@ static inline struct stable_node *alloc_stable_node(void)
 	return kmem_cache_alloc(stable_node_cache, GFP_KERNEL | __GFP_HIGH);
 }
 
-static inline void free_stable_node(struct stable_node *stable_node)
+static inline void free_stable_node(struct ksm_stable_node *stable_node)
 {
 	VM_BUG_ON(stable_node->rmap_hlist_len &&
 		  !is_stable_node_chain(stable_node));
 	kmem_cache_free(stable_node_cache, stable_node);
 }
 
-static inline struct mm_slot *alloc_mm_slot(void)
+static inline struct ksm_mm_slot *alloc_mm_slot(void)
 {
 	if (!mm_slot_cache)	/* initialization failed */
 		return NULL;
 	return kmem_cache_zalloc(mm_slot_cache, GFP_KERNEL);
 }
 
-static inline void free_mm_slot(struct mm_slot *mm_slot)
+static inline void free_mm_slot(struct ksm_mm_slot *mm_slot)
 {
 	kmem_cache_free(mm_slot_cache, mm_slot);
 }
 
-static struct mm_slot *get_mm_slot(struct mm_struct *mm)
+static struct ksm_mm_slot *get_mm_slot(struct mm_struct *mm)
 {
-	struct mm_slot *slot;
+	struct ksm_mm_slot *slot;
 
 	hash_for_each_possible(mm_slots_hash, slot, link, (unsigned long)mm)
 		if (slot->mm == mm)
@@ -432,7 +432,7 @@ static struct mm_slot *get_mm_slot(struct mm_struct *mm)
 }
 
 static void insert_to_mm_slots_hash(struct mm_struct *mm,
-				    struct mm_slot *mm_slot)
+				    struct ksm_mm_slot *mm_slot)
 {
 	mm_slot->mm = mm;
 	hash_add(mm_slots_hash, &mm_slot->link, (unsigned long)mm);
@@ -528,7 +528,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	return vma;
 }
 
-static void break_cow(struct rmap_item *rmap_item)
+static void break_cow(struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
 	unsigned long addr = rmap_item->address;
@@ -547,7 +547,7 @@ static void break_cow(struct rmap_item *rmap_item)
 	mmap_read_unlock(mm);
 }
 
-static struct page *get_mergeable_page(struct rmap_item *rmap_item)
+static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
 	unsigned long addr = rmap_item->address;
@@ -588,10 +588,10 @@ static inline int get_kpfn_nid(unsigned long kpfn)
 	return ksm_merge_across_nodes ? 0 : NUMA(pfn_to_nid(kpfn));
 }
 
-static struct stable_node *alloc_stable_node_chain(struct stable_node *dup,
+static struct ksm_stable_node *alloc_stable_node_chain(struct ksm_stable_node *dup,
 						   struct rb_root *root)
 {
-	struct stable_node *chain = alloc_stable_node();
+	struct ksm_stable_node *chain = alloc_stable_node();
 	VM_BUG_ON(is_stable_node_chain(dup));
 	if (likely(chain)) {
 		INIT_HLIST_HEAD(&chain->hlist);
@@ -621,7 +621,7 @@ static struct stable_node *alloc_stable_node_chain(struct stable_node *dup,
 	return chain;
 }
 
-static inline void free_stable_node_chain(struct stable_node *chain,
+static inline void free_stable_node_chain(struct ksm_stable_node *chain,
 					  struct rb_root *root)
 {
 	rb_erase(&chain->node, root);
@@ -629,9 +629,9 @@ static inline void free_stable_node_chain(struct stable_node *chain,
 	ksm_stable_node_chains--;
 }
 
-static void remove_node_from_stable_tree(struct stable_node *stable_node)
+static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
 {
-	struct rmap_item *rmap_item;
+	struct ksm_rmap_item *rmap_item;
 
 	/* check it's not STABLE_NODE_CHAIN or negative */
 	BUG_ON(stable_node->rmap_hlist_len < 0);
@@ -693,7 +693,7 @@ enum get_ksm_page_flags {
  * a page to put something that might look like our key in page->mapping.
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
-static struct page *get_ksm_page(struct stable_node *stable_node,
+static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
 				 enum get_ksm_page_flags flags)
 {
 	struct page *page;
@@ -772,10 +772,10 @@ static struct page *get_ksm_page(struct stable_node *stable_node,
  * Removing rmap_item from stable or unstable tree.
  * This function will clean the information from the stable/unstable tree.
  */
-static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
+static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 {
 	if (rmap_item->address & STABLE_FLAG) {
-		struct stable_node *stable_node;
+		struct ksm_stable_node *stable_node;
 		struct page *page;
 
 		stable_node = rmap_item->head;
@@ -822,10 +822,10 @@ static void remove_rmap_item_from_tree(struct rmap_item *rmap_item)
 	cond_resched();		/* we're called from many long loops */
 }
 
-static void remove_trailing_rmap_items(struct rmap_item **rmap_list)
+static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
 {
 	while (*rmap_list) {
-		struct rmap_item *rmap_item = *rmap_list;
+		struct ksm_rmap_item *rmap_item = *rmap_list;
 		*rmap_list = rmap_item->rmap_list;
 		remove_rmap_item_from_tree(rmap_item);
 		free_rmap_item(rmap_item);
@@ -862,18 +862,18 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 	return err;
 }
 
-static inline struct stable_node *folio_stable_node(struct folio *folio)
+static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
 {
 	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
 }
 
-static inline struct stable_node *page_stable_node(struct page *page)
+static inline struct ksm_stable_node *page_stable_node(struct page *page)
 {
 	return folio_stable_node(page_folio(page));
 }
 
 static inline void set_page_stable_node(struct page *page,
-					struct stable_node *stable_node)
+					struct ksm_stable_node *stable_node)
 {
 	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
 	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
@@ -883,7 +883,7 @@ static inline void set_page_stable_node(struct page *page,
 /*
  * Only called through the sysfs control interface:
  */
-static int remove_stable_node(struct stable_node *stable_node)
+static int remove_stable_node(struct ksm_stable_node *stable_node)
 {
 	struct page *page;
 	int err;
@@ -921,10 +921,10 @@ static int remove_stable_node(struct stable_node *stable_node)
 	return err;
 }
 
-static int remove_stable_node_chain(struct stable_node *stable_node,
+static int remove_stable_node_chain(struct ksm_stable_node *stable_node,
 				    struct rb_root *root)
 {
-	struct stable_node *dup;
+	struct ksm_stable_node *dup;
 	struct hlist_node *hlist_safe;
 
 	if (!is_stable_node_chain(stable_node)) {
@@ -948,14 +948,14 @@ static int remove_stable_node_chain(struct stable_node *stable_node,
 
 static int remove_all_stable_nodes(void)
 {
-	struct stable_node *stable_node, *next;
+	struct ksm_stable_node *stable_node, *next;
 	int nid;
 	int err = 0;
 
 	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
 		while (root_stable_tree[nid].rb_node) {
 			stable_node = rb_entry(root_stable_tree[nid].rb_node,
-						struct stable_node, node);
+						struct ksm_stable_node, node);
 			if (remove_stable_node_chain(stable_node,
 						     root_stable_tree + nid)) {
 				err = -EBUSY;
@@ -974,14 +974,14 @@ static int remove_all_stable_nodes(void)
 
 static int unmerge_and_remove_all_rmap_items(void)
 {
-	struct mm_slot *mm_slot;
+	struct ksm_mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int err = 0;
 
 	spin_lock(&ksm_mmlist_lock);
 	ksm_scan.mm_slot = list_entry(ksm_mm_head.mm_list.next,
-						struct mm_slot, mm_list);
+						struct ksm_mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
 
 	for (mm_slot = ksm_scan.mm_slot; mm_slot != &ksm_mm_head;
@@ -1006,7 +1006,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 
 		spin_lock(&ksm_mmlist_lock);
 		ksm_scan.mm_slot = list_entry(mm_slot->mm_list.next,
-						struct mm_slot, mm_list);
+						struct ksm_mm_slot, mm_list);
 		if (ksm_test_exit(mm)) {
 			hash_del(&mm_slot->link);
 			list_del(&mm_slot->mm_list);
@@ -1293,7 +1293,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
  *
  * This function returns 0 if the pages were merged, -EFAULT otherwise.
  */
-static int try_to_merge_with_ksm_page(struct rmap_item *rmap_item,
+static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 				      struct page *page, struct page *kpage)
 {
 	struct mm_struct *mm = rmap_item->mm;
@@ -1330,9 +1330,9 @@ static int try_to_merge_with_ksm_page(struct rmap_item *rmap_item,
  * Note that this function upgrades page to ksm page: if one of the pages
  * is already a ksm page, try_to_merge_with_ksm_page should be used.
  */
-static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
+static struct page *try_to_merge_two_pages(struct ksm_rmap_item *rmap_item,
 					   struct page *page,
-					   struct rmap_item *tree_rmap_item,
+					   struct ksm_rmap_item *tree_rmap_item,
 					   struct page *tree_page)
 {
 	int err;
@@ -1352,7 +1352,7 @@ static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
 }
 
 static __always_inline
-bool __is_page_sharing_candidate(struct stable_node *stable_node, int offset)
+bool __is_page_sharing_candidate(struct ksm_stable_node *stable_node, int offset)
 {
 	VM_BUG_ON(stable_node->rmap_hlist_len < 0);
 	/*
@@ -1366,17 +1366,17 @@ bool __is_page_sharing_candidate(struct stable_node *stable_node, int offset)
 }
 
 static __always_inline
-bool is_page_sharing_candidate(struct stable_node *stable_node)
+bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
 {
 	return __is_page_sharing_candidate(stable_node, 0);
 }
 
-static struct page *stable_node_dup(struct stable_node **_stable_node_dup,
-				    struct stable_node **_stable_node,
+static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
+				    struct ksm_stable_node **_stable_node,
 				    struct rb_root *root,
 				    bool prune_stale_stable_nodes)
 {
-	struct stable_node *dup, *found = NULL, *stable_node = *_stable_node;
+	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
 	struct page *_tree_page, *tree_page = NULL;
 	int nr = 0;
@@ -1490,7 +1490,7 @@ static struct page *stable_node_dup(struct stable_node **_stable_node_dup,
 	return tree_page;
 }
 
-static struct stable_node *stable_node_dup_any(struct stable_node *stable_node,
+static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
 					       struct rb_root *root)
 {
 	if (!is_stable_node_chain(stable_node))
@@ -1517,12 +1517,12 @@ static struct stable_node *stable_node_dup_any(struct stable_node *stable_node,
  * function and will be overwritten in all cases, the caller doesn't
  * need to initialize it.
  */
-static struct page *__stable_node_chain(struct stable_node **_stable_node_dup,
-					struct stable_node **_stable_node,
+static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
+					struct ksm_stable_node **_stable_node,
 					struct rb_root *root,
 					bool prune_stale_stable_nodes)
 {
-	struct stable_node *stable_node = *_stable_node;
+	struct ksm_stable_node *stable_node = *_stable_node;
 	if (!is_stable_node_chain(stable_node)) {
 		if (is_page_sharing_candidate(stable_node)) {
 			*_stable_node_dup = stable_node;
@@ -1539,18 +1539,18 @@ static struct page *__stable_node_chain(struct stable_node **_stable_node_dup,
 			       prune_stale_stable_nodes);
 }
 
-static __always_inline struct page *chain_prune(struct stable_node **s_n_d,
-						struct stable_node **s_n,
+static __always_inline struct page *chain_prune(struct ksm_stable_node **s_n_d,
+						struct ksm_stable_node **s_n,
 						struct rb_root *root)
 {
 	return __stable_node_chain(s_n_d, s_n, root, true);
 }
 
-static __always_inline struct page *chain(struct stable_node **s_n_d,
-					  struct stable_node *s_n,
+static __always_inline struct page *chain(struct ksm_stable_node **s_n_d,
+					  struct ksm_stable_node *s_n,
 					  struct rb_root *root)
 {
-	struct stable_node *old_stable_node = s_n;
+	struct ksm_stable_node *old_stable_node = s_n;
 	struct page *tree_page;
 
 	tree_page = __stable_node_chain(s_n_d, &s_n, root, false);
@@ -1574,8 +1574,8 @@ static struct page *stable_tree_search(struct page *page)
 	struct rb_root *root;
 	struct rb_node **new;
 	struct rb_node *parent;
-	struct stable_node *stable_node, *stable_node_dup, *stable_node_any;
-	struct stable_node *page_node;
+	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
+	struct ksm_stable_node *page_node;
 
 	page_node = page_stable_node(page);
 	if (page_node && page_node->head != &migrate_nodes) {
@@ -1595,7 +1595,7 @@ static struct page *stable_tree_search(struct page *page)
 		int ret;
 
 		cond_resched();
-		stable_node = rb_entry(*new, struct stable_node, node);
+		stable_node = rb_entry(*new, struct ksm_stable_node, node);
 		stable_node_any = NULL;
 		tree_page = chain_prune(&stable_node_dup, &stable_node,	root);
 		/*
@@ -1818,14 +1818,14 @@ static struct page *stable_tree_search(struct page *page)
  * This function returns the stable tree node just allocated on success,
  * NULL otherwise.
  */
-static struct stable_node *stable_tree_insert(struct page *kpage)
+static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 {
 	int nid;
 	unsigned long kpfn;
 	struct rb_root *root;
 	struct rb_node **new;
 	struct rb_node *parent;
-	struct stable_node *stable_node, *stable_node_dup, *stable_node_any;
+	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	bool need_chain = false;
 
 	kpfn = page_to_pfn(kpage);
@@ -1840,7 +1840,7 @@ static struct stable_node *stable_tree_insert(struct page *kpage)
 		int ret;
 
 		cond_resched();
-		stable_node = rb_entry(*new, struct stable_node, node);
+		stable_node = rb_entry(*new, struct ksm_stable_node, node);
 		stable_node_any = NULL;
 		tree_page = chain(&stable_node_dup, stable_node, root);
 		if (!stable_node_dup) {
@@ -1909,7 +1909,7 @@ static struct stable_node *stable_tree_insert(struct page *kpage)
 		rb_insert_color(&stable_node_dup->node, root);
 	} else {
 		if (!is_stable_node_chain(stable_node)) {
-			struct stable_node *orig = stable_node;
+			struct ksm_stable_node *orig = stable_node;
 			/* chain is missing so create it */
 			stable_node = alloc_stable_node_chain(orig, root);
 			if (!stable_node) {
@@ -1938,7 +1938,7 @@ static struct stable_node *stable_tree_insert(struct page *kpage)
  * the same walking algorithm in an rbtree.
  */
 static
-struct rmap_item *unstable_tree_search_insert(struct rmap_item *rmap_item,
+struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_item,
 					      struct page *page,
 					      struct page **tree_pagep)
 {
@@ -1952,12 +1952,12 @@ struct rmap_item *unstable_tree_search_insert(struct rmap_item *rmap_item,
 	new = &root->rb_node;
 
 	while (*new) {
-		struct rmap_item *tree_rmap_item;
+		struct ksm_rmap_item *tree_rmap_item;
 		struct page *tree_page;
 		int ret;
 
 		cond_resched();
-		tree_rmap_item = rb_entry(*new, struct rmap_item, node);
+		tree_rmap_item = rb_entry(*new, struct ksm_rmap_item, node);
 		tree_page = get_mergeable_page(tree_rmap_item);
 		if (!tree_page)
 			return NULL;
@@ -2009,8 +2009,8 @@ struct rmap_item *unstable_tree_search_insert(struct rmap_item *rmap_item,
  * rmap_items hanging off a given node of the stable tree, all sharing
  * the same ksm page.
  */
-static void stable_tree_append(struct rmap_item *rmap_item,
-			       struct stable_node *stable_node,
+static void stable_tree_append(struct ksm_rmap_item *rmap_item,
+			       struct ksm_stable_node *stable_node,
 			       bool max_page_sharing_bypass)
 {
 	/*
@@ -2052,12 +2052,12 @@ static void stable_tree_append(struct rmap_item *rmap_item,
  * @page: the page that we are searching identical page to.
  * @rmap_item: the reverse mapping into the virtual address of this page
  */
-static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
+static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
-	struct rmap_item *tree_rmap_item;
+	struct ksm_rmap_item *tree_rmap_item;
 	struct page *tree_page = NULL;
-	struct stable_node *stable_node;
+	struct ksm_stable_node *stable_node;
 	struct page *kpage;
 	unsigned int checksum;
 	int err;
@@ -2213,11 +2213,11 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 	}
 }
 
-static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
-					    struct rmap_item **rmap_list,
+static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
+					    struct ksm_rmap_item **rmap_list,
 					    unsigned long addr)
 {
-	struct rmap_item *rmap_item;
+	struct ksm_rmap_item *rmap_item;
 
 	while (*rmap_list) {
 		rmap_item = *rmap_list;
@@ -2241,12 +2241,12 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
 	return rmap_item;
 }
 
-static struct rmap_item *scan_get_next_rmap_item(struct page **page)
+static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
-	struct mm_slot *slot;
+	struct ksm_mm_slot *slot;
 	struct vm_area_struct *vma;
-	struct rmap_item *rmap_item;
+	struct ksm_rmap_item *rmap_item;
 	struct vma_iterator vmi;
 	int nid;
 
@@ -2274,7 +2274,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * so prune them once before each full scan.
 		 */
 		if (!ksm_merge_across_nodes) {
-			struct stable_node *stable_node, *next;
+			struct ksm_stable_node *stable_node, *next;
 			struct page *page;
 
 			list_for_each_entry_safe(stable_node, next,
@@ -2291,7 +2291,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 			root_unstable_tree[nid] = RB_ROOT;
 
 		spin_lock(&ksm_mmlist_lock);
-		slot = list_entry(slot->mm_list.next, struct mm_slot, mm_list);
+		slot = list_entry(slot->mm_list.next, struct ksm_mm_slot, mm_list);
 		ksm_scan.mm_slot = slot;
 		spin_unlock(&ksm_mmlist_lock);
 		/*
@@ -2365,7 +2365,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 
 	spin_lock(&ksm_mmlist_lock);
 	ksm_scan.mm_slot = list_entry(slot->mm_list.next,
-						struct mm_slot, mm_list);
+						struct ksm_mm_slot, mm_list);
 	if (ksm_scan.address == 0) {
 		/*
 		 * We've completed a full scan of all vmas, holding mmap_lock
@@ -2411,7 +2411,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
  */
 static void ksm_do_scan(unsigned int scan_npages)
 {
-	struct rmap_item *rmap_item;
+	struct ksm_rmap_item *rmap_item;
 	struct page *page;
 
 	while (scan_npages-- && likely(!freezing(current))) {
@@ -2515,7 +2515,7 @@ EXPORT_SYMBOL_GPL(ksm_madvise);
 
 int __ksm_enter(struct mm_struct *mm)
 {
-	struct mm_slot *mm_slot;
+	struct ksm_mm_slot *mm_slot;
 	int needs_wakeup;
 
 	mm_slot = alloc_mm_slot();
@@ -2554,7 +2554,7 @@ int __ksm_enter(struct mm_struct *mm)
 
 void __ksm_exit(struct mm_struct *mm)
 {
-	struct mm_slot *mm_slot;
+	struct ksm_mm_slot *mm_slot;
 	int easy_to_free = 0;
 
 	/*
@@ -2632,8 +2632,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 
 void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 {
-	struct stable_node *stable_node;
-	struct rmap_item *rmap_item;
+	struct ksm_stable_node *stable_node;
+	struct ksm_rmap_item *rmap_item;
 	int search_new_forks = 0;
 
 	VM_BUG_ON_FOLIO(!folio_test_ksm(folio), folio);
@@ -2703,7 +2703,7 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 #ifdef CONFIG_MIGRATION
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 {
-	struct stable_node *stable_node;
+	struct ksm_stable_node *stable_node;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(newfolio), newfolio);
@@ -2736,7 +2736,7 @@ static void wait_while_offlining(void)
 	}
 }
 
-static bool stable_node_dup_remove_range(struct stable_node *stable_node,
+static bool stable_node_dup_remove_range(struct ksm_stable_node *stable_node,
 					 unsigned long start_pfn,
 					 unsigned long end_pfn)
 {
@@ -2752,12 +2752,12 @@ static bool stable_node_dup_remove_range(struct stable_node *stable_node,
 	return false;
 }
 
-static bool stable_node_chain_remove_range(struct stable_node *stable_node,
+static bool stable_node_chain_remove_range(struct ksm_stable_node *stable_node,
 					   unsigned long start_pfn,
 					   unsigned long end_pfn,
 					   struct rb_root *root)
 {
-	struct stable_node *dup;
+	struct ksm_stable_node *dup;
 	struct hlist_node *hlist_safe;
 
 	if (!is_stable_node_chain(stable_node)) {
@@ -2781,14 +2781,14 @@ static bool stable_node_chain_remove_range(struct stable_node *stable_node,
 static void ksm_check_stable_tree(unsigned long start_pfn,
 				  unsigned long end_pfn)
 {
-	struct stable_node *stable_node, *next;
+	struct ksm_stable_node *stable_node, *next;
 	struct rb_node *node;
 	int nid;
 
 	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
 		node = rb_first(root_stable_tree + nid);
 		while (node) {
-			stable_node = rb_entry(node, struct stable_node, node);
+			stable_node = rb_entry(node, struct ksm_stable_node, node);
 			if (stable_node_chain_remove_range(stable_node,
 							   start_pfn, end_pfn,
 							   root_stable_tree +
-- 
2.20.1

