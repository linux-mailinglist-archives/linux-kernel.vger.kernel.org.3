Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9934BF1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiBVFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:41:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiBVFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:40:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4D19BB8F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d74a0ff060so44802287b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PyCoBTuVnCCgGWzJAr27O1YS5hZPDa+2/ZY9Qp3jx0E=;
        b=pVKsN6uoJTTW7d5y8Ow04h/N2xLRfXbsytaoZFLAt8NkNYe7iJtrunlLWlWG5P41aw
         ujQ0w+u+kPlxSmHslv7fpyOCFHkz0aChiaFWxHbL9Y7kqWmrEOM9hbRaCeWJt0jFx/w6
         STF9z7phyPLci+0jpEwvu24alh4xnHih95HMhT2u3N0S4A7zG2ra47psdruVAjnaQeq3
         d497aGHv5vCowQ7010K//43nQqMjkl7QAxI5FqNhMct1BRW5jDLDRQLMlu1iJ86n8qW8
         lKqtxWWknh5LkFlfMmvxgAOIKVAkEpHZ33k2u/oBTIhJa3R6hb6Q6M78Ljc9VNdbT/Hz
         KNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PyCoBTuVnCCgGWzJAr27O1YS5hZPDa+2/ZY9Qp3jx0E=;
        b=dKcICG0aE1h9o+4UAxW05YVcRivuL9uHmPowGe0x4jXi3V4d0arPW2+TRXNd3p9Pnr
         t5Tgikqt4Im0sFyDgp6hSKFzDyGf4atrXOO41hNxgQd7g9zMYvdJLKpABVb86ozn7ke8
         Ay0+8Bn6P/M1F3RFqoZElDeGAXrUyyFNk1jq6y8ddhrYLS+rgWrmFUduenyAI9ksQ/9/
         BHQzNyiHxclvDX1k5xiLrEoLv99CRJnd7dwEadMbKJq0EpJrWloEmrILmh7D9JmzAF8j
         JhZazCWRXZszP7rPJWeAPtWjWDRfjBjJuXoLqNdzBeOAuLIjI4cGIt45BDZ3pR3FmtNL
         0R1Q==
X-Gm-Message-State: AOAM530NPBu6VSsz98J9c3eIWsjVopG7U9zGayKfUtgoIwMRhN9cmkjb
        F3yvDtlaboEJFdFzfFP4ic99rFFIsy8=
X-Google-Smtp-Source: ABdhPJzusLduYMb9MkqGSwaYKTlX17vUZOdoY4+DW5HRT6s3+1UAWAMN6c0idnPvIpH1ahiC7JQXwoekXzI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:79c1:8a4c:5d17:670f])
 (user=surenb job=sendgmr) by 2002:a81:120d:0:b0:2d7:7e79:e298 with SMTP id
 13-20020a81120d000000b002d77e79e298mr4244852yws.346.1645508429807; Mon, 21
 Feb 2022 21:40:29 -0800 (PST)
Date:   Mon, 21 Feb 2022 21:40:23 -0800
Message-Id: <20220222054025.3412898-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH 1/3] mm: refactor vm_area_struct::anon_vma_name usage code
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
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

Avoid mixing strings and their anon_vma_name referenced pointers
by using struct anon_vma_name whenever possible. This simplifies
the code and allows easier sharing of anon_vma_name structures when
they represent the same name.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c        |   4 +-
 include/linux/mm.h        |   7 +--
 include/linux/mm_inline.h |  75 ++++++++++++++++++----------
 include/linux/mm_types.h  |   5 +-
 kernel/sys.c              |  18 +++++--
 mm/madvise.c              | 100 ++++++++++++++++----------------------
 mm/mmap.c                 |  10 ++--
 7 files changed, 118 insertions(+), 101 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6e97ed775074..5bfcf24493ac 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -309,7 +309,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 
 	name = arch_vma_name(vma);
 	if (!name) {
-		const char *anon_name;
+		struct anon_vma_name *anon_name;
 
 		if (!mm) {
 			name = "[vdso]";
@@ -330,7 +330,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 		anon_name = vma_anon_name(vma);
 		if (anon_name) {
 			seq_pad(m, ' ');
-			seq_printf(m, "[anon:%s]", anon_name);
+			seq_printf(m, "[anon:%s]", anon_name->name);
 		}
 	}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..5744a3fc4716 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2626,7 +2626,7 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 extern struct vm_area_struct *vma_merge(struct mm_struct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx, const char *);
+	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
@@ -3372,11 +3372,12 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 
 #ifdef CONFIG_ANON_VMA_NAME
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
-			  unsigned long len_in, const char *name);
+			  unsigned long len_in,
+			  struct anon_vma_name *anon_name);
 #else
 static inline int
 madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
-		      unsigned long len_in, const char *name) {
+		      unsigned long len_in, struct anon_vma_name *anon_name) {
 	return 0;
 }
 #endif
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b725839dfe71..70b619442d56 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -140,50 +140,73 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 
 #ifdef CONFIG_ANON_VMA_NAME
 /*
- * mmap_lock should be read-locked when calling vma_anon_name() and while using
- * the returned pointer.
+ * mmap_lock should be read-locked when calling vma_anon_name(). Caller should
+ * either keep holding the lock while using the returned pointer or it should
+ * raise anon_vma_name refcount before releasing the lock.
  */
-extern const char *vma_anon_name(struct vm_area_struct *vma);
+extern struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma);
+extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
 
-/*
- * mmap_lock should be read-locked for orig_vma->vm_mm.
- * mmap_lock should be write-locked for new_vma->vm_mm or new_vma should be
- * isolated.
- */
-extern void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-			      struct vm_area_struct *new_vma);
+/* mmap_lock should be read-locked */
+static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
+{
+	if (anon_name)
+		kref_get(&anon_name->kref);
+}
 
-/*
- * mmap_lock should be write-locked or vma should have been isolated under
- * write-locked mmap_lock protection.
- */
-extern void free_vma_anon_name(struct vm_area_struct *vma);
+extern void anon_vma_name_put(struct anon_vma_name *anon_name);
 
-/* mmap_lock should be read-locked */
-static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
-					 const char *name)
+static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
 {
-	const char *vma_name = vma_anon_name(vma);
+	struct anon_vma_name *anon_name = vma_anon_name(orig_vma);
 
-	/* either both NULL, or pointers to same string */
-	if (vma_name == name)
+	if (anon_name) {
+		anon_vma_name_get(anon_name);
+		new_vma->anon_name = anon_name;
+	}
+}
+
+static inline void free_vma_anon_name(struct vm_area_struct *vma)
+{
+	/* Can't use vma_anon_name because vma->vm_mm might not be held */
+	if (!vma->vm_file)
+		anon_vma_name_put(vma->anon_name);
+}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	if (anon_name1 == anon_name2)
 		return true;
 
-	return name && vma_name && !strcmp(name, vma_name);
+	return anon_name1 && anon_name2 &&
+		!strcmp(anon_name1->name, anon_name2->name);
 }
+
 #else /* CONFIG_ANON_VMA_NAME */
-static inline const char *vma_anon_name(struct vm_area_struct *vma)
+static inline struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma)
 {
 	return NULL;
 }
+
+static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	return NULL;
+}
+
+static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
+static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
 static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-			      struct vm_area_struct *new_vma) {}
+				     struct vm_area_struct *new_vma) {}
 static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
-static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
-					 const char *name)
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
 {
 	return true;
 }
+
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..1d298ff2e1d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -416,7 +416,10 @@ struct vm_area_struct {
 			struct rb_node rb;
 			unsigned long rb_subtree_last;
 		} shared;
-		/* Serialized by mmap_sem. */
+		/*
+		 * Serialized by mmap_sem. Never use directly because it is
+		 * valid only when vm_file is NULL. Use vma_anon_name instead.
+		 */
 		struct anon_vma_name *anon_name;
 	};
 
diff --git a/kernel/sys.c b/kernel/sys.c
index ecc4cf019242..60c3f9eac9eb 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/utsname.h>
 #include <linux/mman.h>
 #include <linux/reboot.h>
@@ -2278,15 +2279,16 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	const char __user *uname;
-	char *name, *pch;
+	struct anon_vma_name *anon_name;
 	int error;
 
 	switch (opt) {
 	case PR_SET_VMA_ANON_NAME:
 		uname = (const char __user *)arg;
 		if (uname) {
-			name = strndup_user(uname, ANON_VMA_NAME_MAX_LEN);
+			char *name, *pch;
 
+			name = strndup_user(uname, ANON_VMA_NAME_MAX_LEN);
 			if (IS_ERR(name))
 				return PTR_ERR(name);
 
@@ -2296,15 +2298,21 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
 					return -EINVAL;
 				}
 			}
+			/* anon_vma has its own copy */
+			anon_name = anon_vma_name_alloc(name);
+			kfree(name);
+			if (!anon_name)
+				return -ENOMEM;
+
 		} else {
 			/* Reset the name */
-			name = NULL;
+			anon_name = NULL;
 		}
 
 		mmap_write_lock(mm);
-		error = madvise_set_anon_name(mm, addr, size, name);
+		error = madvise_set_anon_name(mm, addr, size, anon_name);
 		mmap_write_unlock(mm);
-		kfree(name);
+		anon_vma_name_put(anon_name);
 		break;
 	default:
 		error = -EINVAL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..f81d62d8ce9b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -65,11 +65,14 @@ static int madvise_need_mmap_write(int behavior)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
-static struct anon_vma_name *anon_vma_name_alloc(const char *name)
+struct anon_vma_name *anon_vma_name_alloc(const char *name)
 {
 	struct anon_vma_name *anon_name;
 	size_t count;
 
+	if (!name)
+		return NULL;
+
 	/* Add 1 for NUL terminator at the end of the anon_name->name */
 	count = strlen(name) + 1;
 	anon_name = kmalloc(struct_size(anon_name, name, count), GFP_KERNEL);
@@ -81,78 +84,55 @@ static struct anon_vma_name *anon_vma_name_alloc(const char *name)
 	return anon_name;
 }
 
-static void vma_anon_name_free(struct kref *kref)
+struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma)
 {
-	struct anon_vma_name *anon_name =
-			container_of(kref, struct anon_vma_name, kref);
-	kfree(anon_name);
-}
-
-static inline bool has_vma_anon_name(struct vm_area_struct *vma)
-{
-	return !vma->vm_file && vma->anon_name;
-}
+	mmap_assert_locked(vma->vm_mm);
 
-const char *vma_anon_name(struct vm_area_struct *vma)
-{
-	if (!has_vma_anon_name(vma))
+	if (vma->vm_file)
 		return NULL;
 
-	mmap_assert_locked(vma->vm_mm);
-
-	return vma->anon_name->name;
+	return vma->anon_name;
 }
 
-void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-		       struct vm_area_struct *new_vma)
+static void vma_anon_name_free(struct kref *kref)
 {
-	if (!has_vma_anon_name(orig_vma))
-		return;
-
-	kref_get(&orig_vma->anon_name->kref);
-	new_vma->anon_name = orig_vma->anon_name;
+	struct anon_vma_name *anon_name =
+			container_of(kref, struct anon_vma_name, kref);
+	kfree(anon_name);
 }
 
-void free_vma_anon_name(struct vm_area_struct *vma)
+void anon_vma_name_put(struct anon_vma_name *anon_name)
 {
-	struct anon_vma_name *anon_name;
-
-	if (!has_vma_anon_name(vma))
-		return;
-
-	anon_name = vma->anon_name;
-	vma->anon_name = NULL;
-	kref_put(&anon_name->kref, vma_anon_name_free);
+	if (anon_name)
+		kref_put(&anon_name->kref, vma_anon_name_free);
 }
 
 /* mmap_lock should be write-locked */
-static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
+static int replace_vma_anon_name(struct vm_area_struct *vma,
+				 struct anon_vma_name *anon_name)
 {
-	const char *anon_name;
+	struct anon_vma_name *orig_name = vma_anon_name(vma);
 
-	if (!name) {
-		free_vma_anon_name(vma);
+	if (!anon_name) {
+		vma->anon_name = NULL;
+		anon_vma_name_put(orig_name);
 		return 0;
 	}
 
-	anon_name = vma_anon_name(vma);
-	if (anon_name) {
-		/* Same name, nothing to do here */
-		if (!strcmp(name, anon_name))
-			return 0;
+	if (anon_vma_name_eq(orig_name, anon_name))
+		return 0;
 
-		free_vma_anon_name(vma);
-	}
-	vma->anon_name = anon_vma_name_alloc(name);
-	if (!vma->anon_name)
-		return -ENOMEM;
+	anon_vma_name_get(anon_name);
+	vma->anon_name = anon_name;
+	anon_vma_name_put(orig_name);
 
 	return 0;
 }
 #else /* CONFIG_ANON_VMA_NAME */
-static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
+static int replace_vma_anon_name(struct vm_area_struct *vma,
+				 struct anon_vma_name *anon_name)
 {
-	if (name)
+	if (anon_name)
 		return -EINVAL;
 
 	return 0;
@@ -165,13 +145,13 @@ static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
 static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct vm_area_struct **prev, unsigned long start,
 			      unsigned long end, unsigned long new_flags,
-			      const char *name)
+			      struct anon_vma_name *anon_name)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
 
-	if (new_flags == vma->vm_flags && is_same_vma_anon_name(vma, name)) {
+	if (new_flags == vma->vm_flags && anon_vma_name_eq(vma_anon_name(vma), anon_name)) {
 		*prev = vma;
 		return 0;
 	}
@@ -179,7 +159,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, name);
+			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
 		vma = *prev;
 		goto success;
@@ -209,7 +189,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	 */
 	vma->vm_flags = new_flags;
 	if (!vma->vm_file) {
-		error = replace_vma_anon_name(vma, name);
+		error = replace_vma_anon_name(vma, anon_name);
 		if (error)
 			return error;
 	}
@@ -976,6 +956,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 {
 	int error;
 	unsigned long new_flags = vma->vm_flags;
+	struct anon_vma_name *anon_name;
 
 	switch (behavior) {
 	case MADV_REMOVE:
@@ -1040,8 +1021,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	}
 
+	anon_name = vma_anon_name(vma);
 	error = madvise_update_vma(vma, prev, start, end, new_flags,
-				   vma_anon_name(vma));
+				   anon_name);
 
 out:
 	/*
@@ -1225,7 +1207,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long name)
+				 unsigned long anon_name)
 {
 	int error;
 
@@ -1234,7 +1216,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
-				   (const char *)name);
+				   (struct anon_vma_name *)anon_name);
 
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
@@ -1246,7 +1228,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 }
 
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
-			  unsigned long len_in, const char *name)
+			  unsigned long len_in, struct anon_vma_name *anon_name)
 {
 	unsigned long end;
 	unsigned long len;
@@ -1266,8 +1248,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, (unsigned long)name,
-				 madvise_vma_anon_name);
+	return  madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
+				  madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..80d2ae204a98 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1031,7 +1031,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
 				struct file *file, unsigned long vm_flags,
 				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-				const char *anon_name)
+				struct anon_vma_name *anon_name)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -1049,7 +1049,7 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
 		return 0;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
 		return 0;
-	if (!is_same_vma_anon_name(vma, anon_name))
+	if (!anon_vma_name_eq(vma_anon_name(vma), anon_name))
 		return 0;
 	return 1;
 }
@@ -1084,7 +1084,7 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		     struct anon_vma *anon_vma, struct file *file,
 		     pgoff_t vm_pgoff,
 		     struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		     const char *anon_name)
+		     struct anon_vma_name *anon_name)
 {
 	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
@@ -1106,7 +1106,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		    struct anon_vma *anon_vma, struct file *file,
 		    pgoff_t vm_pgoff,
 		    struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		    const char *anon_name)
+		    struct anon_vma_name *anon_name)
 {
 	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
@@ -1167,7 +1167,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			struct anon_vma *anon_vma, struct file *file,
 			pgoff_t pgoff, struct mempolicy *policy,
 			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			const char *anon_name)
+			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
-- 
2.35.1.473.g83b2b277ed-goog

