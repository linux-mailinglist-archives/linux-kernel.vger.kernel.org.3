Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4904F6434
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiDFPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiDFPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:53:39 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D9165E52
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:16:09 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id bc9-20020a056402204900b0041cc2b0bff3so1220615edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EHYoTVl+gP3yMHYun3dql2NLB7u3fhlJOn8FiiSfr2I=;
        b=Noky0cu7xqpjnpqu6STFHmJfFpJZg/VVn1f3blFr8T21WVfQoZuJ/vXdE/kc32iSKB
         cfBw6Z34aHcDIAvdYm145qkK200hwyTp9lCzLI+aZlNylMwhrUKfs4bcmgvf3lYpiirW
         /TyLAmBJEpBfJR6AmA3LBIBXu03EUT82wuWaW7xK97+HpLyzfL69cPvE+19FERKZ8/B5
         WLqMrw9pc4EHRm9KuKBCfOt30GHtUBs8RNxo/MRoOeTXCDfb4KoGT57ZBZdSu2c7az5d
         qOXGtRcCQjv6Vqw7pQSoDGyjPPRdRnLd+paCJtir/AwRD7ksiHq2dLG0/EywRbrtXzlL
         Mg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EHYoTVl+gP3yMHYun3dql2NLB7u3fhlJOn8FiiSfr2I=;
        b=HCgZSEOqoQ+kTrEan+KYbI9vIHZtHmm6OP7IGDKDUBErOSU51t95gmHG50GhB58fMW
         y0fnJMsiC0rvQ2M0MmL8FxmIjPz9hjTFXQN0PRwbow6XmA2buhz2g9lj2AAFoUDnkmI4
         DOdDE1KW3Ay7+WmK/v3YVhDmGwJclNeqWQR8hW+vZm2eh12ZWWkyY5YqMuBfMVZN6Jkw
         iM5cBarlYOpPp0UlJYechQM0K61Ocfw5nuYmGcAPHjtqQv78wL43OyDjGauFAMd7+5NS
         h6oHW9FUgZpEPlgFCGH1qxcXOghWoIhCFLeR8sSEqUOzaMIKwov8168D2UR16pU7GPFx
         LmWw==
X-Gm-Message-State: AOAM532jTGixe6M7jFhH0e6bSE+El7BnBrCu+c6NvVFFzIjpvkLgTazx
        wefXuwmFlYBXT9+F9wt2tks2eJ6yEg==
X-Google-Smtp-Source: ABdhPJxkorYlqzFdoIXmJO8KBXp7IoSQI/nJRYgHcIrtFXHH99aJnuWpTmsdSjcX9uQKspVen/k4u5uvPg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:5d29:f2b6:6b0b:ac46])
 (user=elver job=sendgmr) by 2002:a50:fe0d:0:b0:415:e2ee:65af with SMTP id
 f13-20020a50fe0d000000b00415e2ee65afmr8642207edt.383.1649250968143; Wed, 06
 Apr 2022 06:16:08 -0700 (PDT)
Date:   Wed,  6 Apr 2022 15:15:58 +0200
Message-Id: <20220406131558.3558585-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] mm, kfence: support kmem_dump_obj() for KFENCE objects
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling kmem_obj_info() via kmem_dump_obj() on KFENCE objects has been
producing garbage data due to the object not actually being maintained
by SLAB or SLUB.

Fix this by implementing __kfence_obj_info() that copies relevant
information to struct kmem_obj_info when the object was allocated by
KFENCE; this is called by a common kmem_obj_info(), which also calls the
slab/slub/slob specific variant now called __kmem_obj_info().

For completeness, kmem_dump_obj() now displays if the object was
allocated by KFENCE.

Link: https://lore.kernel.org/all/20220323090520.GG16885@xsang-OptiPlex-9020/
Fixes: b89fb5ef0ce6 ("mm, kfence: insert KFENCE hooks for SLUB")
Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/kfence.h | 24 +++++++++++++++++++++
 mm/kfence/core.c       | 21 -------------------
 mm/kfence/kfence.h     | 21 +++++++++++++++++++
 mm/kfence/report.c     | 47 ++++++++++++++++++++++++++++++++++++++++++
 mm/slab.c              |  2 +-
 mm/slab.h              |  2 +-
 mm/slab_common.c       |  9 ++++++++
 mm/slob.c              |  2 +-
 mm/slub.c              |  2 +-
 9 files changed, 105 insertions(+), 25 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index f49e64222628..726857a4b680 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -204,6 +204,22 @@ static __always_inline __must_check bool kfence_free(void *addr)
  */
 bool __must_check kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs);
 
+#ifdef CONFIG_PRINTK
+struct kmem_obj_info;
+/**
+ * __kfence_obj_info() - fill kmem_obj_info struct
+ * @kpp: kmem_obj_info to be filled
+ * @object: the object
+ *
+ * Return:
+ * * false - not a KFENCE object
+ * * true - a KFENCE object, filled @kpp
+ *
+ * Copies information to @kpp for KFENCE objects.
+ */
+bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
+#endif
+
 #else /* CONFIG_KFENCE */
 
 static inline bool is_kfence_address(const void *addr) { return false; }
@@ -221,6 +237,14 @@ static inline bool __must_check kfence_handle_page_fault(unsigned long addr, boo
 	return false;
 }
 
+#ifdef CONFIG_PRINTK
+struct kmem_obj_info;
+static inline bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
+{
+	return false;
+}
+#endif
+
 #endif
 
 #endif /* _LINUX_KFENCE_H */
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index a203747ad2c0..9b2b5f56f4ae 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -231,27 +231,6 @@ static bool kfence_unprotect(unsigned long addr)
 	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false));
 }
 
-static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
-{
-	long index;
-
-	/* The checks do not affect performance; only called from slow-paths. */
-
-	if (!is_kfence_address((void *)addr))
-		return NULL;
-
-	/*
-	 * May be an invalid index if called with an address at the edge of
-	 * __kfence_pool, in which case we would report an "invalid access"
-	 * error.
-	 */
-	index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
-	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
-		return NULL;
-
-	return &kfence_metadata[index];
-}
-
 static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
 {
 	unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 9a6c4b1b12a8..600f2e2431d6 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -96,6 +96,27 @@ struct kfence_metadata {
 
 extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
 
+static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
+{
+	long index;
+
+	/* The checks do not affect performance; only called from slow-paths. */
+
+	if (!is_kfence_address((void *)addr))
+		return NULL;
+
+	/*
+	 * May be an invalid index if called with an address at the edge of
+	 * __kfence_pool, in which case we would report an "invalid access"
+	 * error.
+	 */
+	index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
+	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
+		return NULL;
+
+	return &kfence_metadata[index];
+}
+
 /* KFENCE error types for report generation. */
 enum kfence_error_type {
 	KFENCE_ERROR_OOB,		/* Detected a out-of-bounds access. */
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index f93a7b2a338b..f5a6d8ba3e21 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -273,3 +273,50 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 	/* We encountered a memory safety error, taint the kernel! */
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
 }
+
+#ifdef CONFIG_PRINTK
+static void kfence_to_kp_stack(const struct kfence_track *track, void **kp_stack)
+{
+	int i, j;
+
+	i = get_stack_skipnr(track->stack_entries, track->num_stack_entries, NULL);
+	for (j = 0; i < track->num_stack_entries && j < KS_ADDRS_COUNT; ++i, ++j)
+		kp_stack[j] = (void *)track->stack_entries[i];
+	if (j < KS_ADDRS_COUNT)
+		kp_stack[j] = NULL;
+}
+
+bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
+{
+	struct kfence_metadata *meta = addr_to_metadata((unsigned long)object);
+	unsigned long flags;
+
+	if (!meta)
+		return false;
+
+	/*
+	 * If state is UNUSED at least show the pointer requested; the rest
+	 * would be garbage data.
+	 */
+	kpp->kp_ptr = object;
+
+	/* Requesting info an a never-used object is almost certainly a bug. */
+	if (WARN_ON(meta->state == KFENCE_OBJECT_UNUSED))
+		return true;
+
+	raw_spin_lock_irqsave(&meta->lock, flags);
+
+	kpp->kp_slab = slab;
+	kpp->kp_slab_cache = meta->cache;
+	kpp->kp_objp = (void *)meta->addr;
+	kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
+	if (meta->state == KFENCE_OBJECT_FREED)
+		kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
+	/* get_stack_skipnr() ensures the first entry is outside allocator. */
+	kpp->kp_ret = kpp->kp_stack[0];
+
+	raw_spin_unlock_irqrestore(&meta->lock, flags);
+
+	return true;
+}
+#endif
diff --git a/mm/slab.c b/mm/slab.c
index b04e40078bdf..0edb474edef1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3665,7 +3665,7 @@ EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_PRINTK
-void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
+void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
 	struct kmem_cache *cachep;
 	unsigned int objnr;
diff --git a/mm/slab.h b/mm/slab.h
index fd7ae2024897..95eb34174c1b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -868,7 +868,7 @@ struct kmem_obj_info {
 	void *kp_stack[KS_ADDRS_COUNT];
 	void *kp_free_stack[KS_ADDRS_COUNT];
 };
-void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
+void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
 #endif
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6ee64d6208b3..2b3206a2c3b5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -555,6 +555,13 @@ bool kmem_valid_obj(void *object)
 }
 EXPORT_SYMBOL_GPL(kmem_valid_obj);
 
+static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
+{
+	if (__kfence_obj_info(kpp, object, slab))
+		return;
+	__kmem_obj_info(kpp, object, slab);
+}
+
 /**
  * kmem_dump_obj - Print available slab provenance information
  * @object: slab object for which to find provenance information.
@@ -590,6 +597,8 @@ void kmem_dump_obj(void *object)
 		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
 	else
 		pr_cont(" slab%s", cp);
+	if (is_kfence_address(object))
+		pr_cont(" (kfence)");
 	if (kp.kp_objp)
 		pr_cont(" start %px", kp.kp_objp);
 	if (kp.kp_data_offset)
diff --git a/mm/slob.c b/mm/slob.c
index dfa6808dff36..40ea6e2d4ccd 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -463,7 +463,7 @@ static void slob_free(void *block, int size)
 }
 
 #ifdef CONFIG_PRINTK
-void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
+void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
 	kpp->kp_ptr = object;
 	kpp->kp_slab = slab;
diff --git a/mm/slub.c b/mm/slub.c
index 74d92aa4a3a2..ed5c2c03a47a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4312,7 +4312,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 }
 
 #ifdef CONFIG_PRINTK
-void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
+void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
 	void *base;
 	int __maybe_unused i;
-- 
2.35.1.1094.g7c7d902a7c-goog

