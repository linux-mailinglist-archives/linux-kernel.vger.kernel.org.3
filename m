Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C304C16EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbiBWPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbiBWPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:36:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCF3BB0BC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:36:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d17-20020a253611000000b006244e94b7b4so15422199yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0jlBYSzC1iOrURM/ZpgWtomcSNFX+zqFekNCVbI//Ec=;
        b=ALSOS/gNT1XcRQFP+1XlL6AmfcsY6K5rqQSA31+Q0COg/UFp7O2Gg93H2aSJroc4QG
         T5YNE1dX6eJa9CB114KloTMq8O3R7ST8ZEDZ+h5Bnh8dcOvo1t9Icak1yGiHLTIUrI+F
         Cv9Z2Q+4Zim7b5cPgUzTx611hYgXd+tmVFQgsG2zO51rHhk4qA9E6/VoqZEzVdeCOYtz
         OKKbVuQTiaWyRW5EM7qzapnK3kcFAqPz507Vwle2+U7K5CNzLS5Qkq1gkFEIXKVuPq9L
         ELQhzfMueWJB0i3xCZM6Mrdkj3OGRF6W3Ktwon2EvkVO1boFsPh472kC5CAHqjTSfH53
         NR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0jlBYSzC1iOrURM/ZpgWtomcSNFX+zqFekNCVbI//Ec=;
        b=U1EqcazFIPCsIHpOqIlV0smCUtpooCe0Wx9SI1aHGy8t5mTL7bA7iHpT48RwBo9gfZ
         vs1LuFVfgKk0znadMzxLLjU/N32ZMhc1GwgBk/Zo3johjwhJrQeYf94ESPbPXxyKpM5e
         l+h7p7zSYzDA1A0C4a+big6Y4yftIabM6RsDPIba2di8U7LnMMAJABSMNGsEAsqnt2Ue
         1aMFu03ejL65Ifp01H05KiWKqVTJjKvu6oxF8ywa5DuvX7By0xPCYeIrzRzBJUeUhdAw
         hHrBJ9FzyE8uxjDa1f4JX/4V/fFfvP6YnLqYM3gMhGPzTX4pYiLbOaJVliQXJA3xvk2i
         5inA==
X-Gm-Message-State: AOAM531jxIl3iWiEhx6x1itKKInNf4q0nfnTmIVn+svfRg5oamQCUu3i
        tX8CoYs0feCkmEr7+NDfWwjM6gE6C4w=
X-Google-Smtp-Source: ABdhPJz18sJDSoDMIA1lXiC6NZRE9PnrM6GWO5dLGmYy4xddx1o0HJSOjAxrYq/MWXvZdTj0VP0A8nGR2qI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5093:9fb5:d0ba:a5f])
 (user=surenb job=sendgmr) by 2002:a25:b098:0:b0:624:634d:c2f5 with SMTP id
 f24-20020a25b098000000b00624634dc2f5mr273606ybj.214.1645630577965; Wed, 23
 Feb 2022 07:36:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 07:36:11 -0800
Message-Id: <20220223153613.835563-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 1/3] mm: refactor vm_area_struct::anon_vma_name usage code
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
changes in v2:
- renamed vma_anon_name to anon_vma_name, dup_vma_anon_name to
dup_anon_vma_name and free_vma_anon_name to free_anon_vma_name,
per Michal Hocko
- moved anon_vma_name_get and anon_vma_name_put close together,
per Michal Hocko
- Updated the comment in free_anon_vma_name, per Michal Hocko
- Removed extra check in anon_vma_name_alloc, per Michal Hocko
- Removed extra variable usage in madvise_vma_behavior, per Michal Hocko
- Cleaned whitespace noise in madvise_set_anon_name, per Michal Hocko

 fs/proc/task_mmu.c        |  6 +--
 fs/userfaultfd.c          |  6 +--
 include/linux/mm.h        |  7 ++--
 include/linux/mm_inline.h | 87 ++++++++++++++++++++++++++-------------
 include/linux/mm_types.h  |  5 ++-
 kernel/fork.c             |  4 +-
 kernel/sys.c              | 19 +++++----
 mm/madvise.c              | 87 +++++++++++++--------------------------
 mm/mempolicy.c            |  2 +-
 mm/mlock.c                |  2 +-
 mm/mmap.c                 | 12 +++---
 mm/mprotect.c             |  2 +-
 12 files changed, 125 insertions(+), 114 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6e97ed775074..2c48b1eaaa9c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -309,7 +309,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 
 	name = arch_vma_name(vma);
 	if (!name) {
-		const char *anon_name;
+		struct anon_vma_name *anon_name;
 
 		if (!mm) {
 			name = "[vdso]";
@@ -327,10 +327,10 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 			goto done;
 		}
 
-		anon_name = vma_anon_name(vma);
+		anon_name = anon_vma_name(vma);
 		if (anon_name) {
 			seq_pad(m, ' ');
-			seq_printf(m, "[anon:%s]", anon_name);
+			seq_printf(m, "[anon:%s]", anon_name->name);
 		}
 	}
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e26b10132d47..8e03b3d3f5fa 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -878,7 +878,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, vma_anon_name(vma));
+				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev)
 			vma = prev;
 		else
@@ -1438,7 +1438,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
-				 vma_anon_name(vma));
+				 anon_vma_name(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
@@ -1615,7 +1615,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, vma_anon_name(vma));
+				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
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
index b725839dfe71..4bad32507570 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -140,50 +140,81 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 
 #ifdef CONFIG_ANON_VMA_NAME
 /*
- * mmap_lock should be read-locked when calling vma_anon_name() and while using
- * the returned pointer.
+ * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
+ * either keep holding the lock while using the returned pointer or it should
+ * raise anon_vma_name refcount before releasing the lock.
  */
-extern const char *vma_anon_name(struct vm_area_struct *vma);
+extern struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
+extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
+extern void anon_vma_name_free(struct kref *kref);
 
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
+static inline void anon_vma_name_put(struct anon_vma_name *anon_name)
+{
+	if (anon_name)
+		kref_put(&anon_name->kref, anon_vma_name_free);
+}
 
-/* mmap_lock should be read-locked */
-static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
-					 const char *name)
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
+{
+	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
+
+	if (anon_name) {
+		anon_vma_name_get(anon_name);
+		new_vma->anon_name = anon_name;
+	}
+}
+
+static inline void free_anon_vma_name(struct vm_area_struct *vma)
 {
-	const char *vma_name = vma_anon_name(vma);
+	/*
+	 * Not using anon_vma_name because it generates a warning if vma->vm_mm
+	 * is not held, which might be the case here.
+	 */
+	if (!vma->vm_file)
+		anon_vma_name_put(vma->anon_name);
+}
 
-	/* either both NULL, or pointers to same string */
-	if (vma_name == name)
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
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
 	return NULL;
 }
-static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-			      struct vm_area_struct *new_vma) {}
-static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
-static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
-					 const char *name)
+
+static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	return NULL;
+}
+
+static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
+static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma) {}
+static inline void free_anon_vma_name(struct vm_area_struct *vma) {}
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
index 5140e5feb486..0f549870da6a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -416,7 +416,10 @@ struct vm_area_struct {
 			struct rb_node rb;
 			unsigned long rb_subtree_last;
 		} shared;
-		/* Serialized by mmap_sem. */
+		/*
+		 * Serialized by mmap_sem. Never use directly because it is
+		 * valid only when vm_file is NULL. Use anon_vma_name instead.
+		 */
 		struct anon_vma_name *anon_name;
 	};
 
diff --git a/kernel/fork.c b/kernel/fork.c
index a024bf6254df..f1e89007f228 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -366,14 +366,14 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		new->vm_next = new->vm_prev = NULL;
-		dup_vma_anon_name(orig, new);
+		dup_anon_vma_name(orig, new);
 	}
 	return new;
 }
 
 void vm_area_free(struct vm_area_struct *vma)
 {
-	free_vma_anon_name(vma);
+	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 97dc9e5d6bf9..5b0e172c4d47 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/utsname.h>
 #include <linux/mman.h>
 #include <linux/reboot.h>
@@ -2286,15 +2287,16 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	const char __user *uname;
-	char *name, *pch;
+	struct anon_vma_name *anon_name = NULL;
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
 
@@ -2304,15 +2306,18 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
 					return -EINVAL;
 				}
 			}
-		} else {
-			/* Reset the name */
-			name = NULL;
+			/* anon_vma has its own copy */
+			anon_name = anon_vma_name_alloc(name);
+			kfree(name);
+			if (!anon_name)
+				return -ENOMEM;
+
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
index 5604064df464..081b1cded21e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -65,7 +65,7 @@ static int madvise_need_mmap_write(int behavior)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
-static struct anon_vma_name *anon_vma_name_alloc(const char *name)
+struct anon_vma_name *anon_vma_name_alloc(const char *name)
 {
 	struct anon_vma_name *anon_name;
 	size_t count;
@@ -81,78 +81,49 @@ static struct anon_vma_name *anon_vma_name_alloc(const char *name)
 	return anon_name;
 }
 
-static void vma_anon_name_free(struct kref *kref)
+void anon_vma_name_free(struct kref *kref)
 {
 	struct anon_vma_name *anon_name =
 			container_of(kref, struct anon_vma_name, kref);
 	kfree(anon_name);
 }
 
-static inline bool has_vma_anon_name(struct vm_area_struct *vma)
+struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
-	return !vma->vm_file && vma->anon_name;
-}
-
-const char *vma_anon_name(struct vm_area_struct *vma)
-{
-	if (!has_vma_anon_name(vma))
-		return NULL;
-
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name->name;
-}
-
-void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-		       struct vm_area_struct *new_vma)
-{
-	if (!has_vma_anon_name(orig_vma))
-		return;
-
-	kref_get(&orig_vma->anon_name->kref);
-	new_vma->anon_name = orig_vma->anon_name;
-}
-
-void free_vma_anon_name(struct vm_area_struct *vma)
-{
-	struct anon_vma_name *anon_name;
-
-	if (!has_vma_anon_name(vma))
-		return;
+	if (vma->vm_file)
+		return NULL;
 
-	anon_name = vma->anon_name;
-	vma->anon_name = NULL;
-	kref_put(&anon_name->kref, vma_anon_name_free);
+	return vma->anon_name;
 }
 
 /* mmap_lock should be write-locked */
-static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
+static int replace_anon_vma_name(struct vm_area_struct *vma,
+				 struct anon_vma_name *anon_name)
 {
-	const char *anon_name;
+	struct anon_vma_name *orig_name = anon_vma_name(vma);
 
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
+static int replace_anon_vma_name(struct vm_area_struct *vma,
+				 struct anon_vma_name *anon_name)
 {
-	if (name)
+	if (anon_name)
 		return -EINVAL;
 
 	return 0;
@@ -165,13 +136,13 @@ static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
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
+	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
 		*prev = vma;
 		return 0;
 	}
@@ -179,7 +150,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, name);
+			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
 		vma = *prev;
 		goto success;
@@ -209,7 +180,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	 */
 	vma->vm_flags = new_flags;
 	if (!vma->vm_file) {
-		error = replace_vma_anon_name(vma, name);
+		error = replace_anon_vma_name(vma, anon_name);
 		if (error)
 			return error;
 	}
@@ -1041,7 +1012,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	}
 
 	error = madvise_update_vma(vma, prev, start, end, new_flags,
-				   vma_anon_name(vma));
+				   anon_vma_name(vma));
 
 out:
 	/*
@@ -1225,7 +1196,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long name)
+				 unsigned long anon_name)
 {
 	int error;
 
@@ -1234,7 +1205,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
-				   (const char *)name);
+				   (struct anon_vma_name *)anon_name);
 
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
@@ -1246,7 +1217,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 }
 
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
-			  unsigned long len_in, const char *name)
+			  unsigned long len_in, struct anon_vma_name *anon_name)
 {
 	unsigned long end;
 	unsigned long len;
@@ -1266,7 +1237,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, (unsigned long)name,
+	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
 				 madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 028e8dd82b44..69284d3b5e53 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -814,7 +814,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 		prev = vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
-				 vma_anon_name(vma));
+				 anon_vma_name(vma));
 		if (prev) {
 			vma = prev;
 			next = vma->vm_next;
diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..25934e7db3e1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -512,7 +512,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, vma_anon_name(vma));
+			  vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..ad6a1fffee91 100644
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
+	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
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
@@ -3255,7 +3255,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		return NULL;	/* should never get here */
 	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx, vma_anon_name(vma));
+			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 5ca3fbcb1495..2887644fd150 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -464,7 +464,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*pprev = vma_merge(mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx, vma_anon_name(vma));
+			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
 		vma = *pprev;
 		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
-- 
2.35.1.473.g83b2b277ed-goog

