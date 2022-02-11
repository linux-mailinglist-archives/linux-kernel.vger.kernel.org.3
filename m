Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821BD4B1B47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbiBKBaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:30:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiBKBah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:30:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB2270E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:30:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a19-20020a25ca13000000b0061db44646b3so15848786ybg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RwWv/SBL/Nyi8PpdOWc2WYYolbunK2i/wwZuLVvrMdU=;
        b=Z4Gcf5jxsCohz3DzslMLUD9BZ0sfIvdQc/l/pfpYkaUizqSs5vQTWP9KlApyuwnYCr
         qy247Gemtbao51i9GOoeeVL8rOFfjxRT9wak9oSCVYh+4cQOjBAbpKIqMXGkWbt/zD09
         msccdqxt52B6jGckc2BsgP1Q6P6Kp0BlzBIkCLJn+KvVbnGKDwfcRlNKv6pRFUoe+//i
         cTxLOD6/FMIBKG+JKDc254144JQxm1nlu+JM/ra8cOmfS9L3T911IVV6So8v11uPLwJm
         vZd9G/InsrCn5Gq5EHq0cTvIRB63h3F/h1SDH+GBPkwKJ3HlHxvqNMl3VpNFNPfugBUs
         0cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RwWv/SBL/Nyi8PpdOWc2WYYolbunK2i/wwZuLVvrMdU=;
        b=aPdJlrr+W3srTFGszHg9DmJ7LmXW235xeCVJZbD5VZsGXoiE6s/2DBAd4GHz05iml2
         h9E5SCFKR/dH6/WJ3pkaN8mJKFyE0jPvjDStWz3fbwSHstsXfeDCwsfvN2C8jXctsaJv
         XSf87ss/Gh7870+90PWVJvzW6hLYxmtmdDy961A5hiM7wJac5IDPCNoJDQhJKdEFLc/O
         9McNEJn6oZhVkfo21JgIaoZ1EL+q0e2/2XQ2DcIbf/fGztCt/GkudwQw74YjeB7gTpB2
         KhZHERcMPhj0YcV18CnFnDucWlqSHT5XTDjQ8BNBxgmCLNGSNXEJQQV6UVnvnp8grow+
         4UxA==
X-Gm-Message-State: AOAM532V0P7wpzfyO1ESELSLMXh1eRgZGcmlkYAmAHdoXGqyqx2CwbAC
        uulUCtqFjVhDcCT0ZY1Nusy80w7wmho=
X-Google-Smtp-Source: ABdhPJzj3s6SYcdRagPBA21xyaJguhhzfjpx9zuxrGEaA597KYb2tBxd2wNkgkrtJfb4pye2OSntVUn2lr4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:cf5c:490c:4286:b6a6])
 (user=surenb job=sendgmr) by 2002:a25:b98c:: with SMTP id r12mr9938344ybg.529.1644543036677;
 Thu, 10 Feb 2022 17:30:36 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:30:32 -0800
Message-Id: <20220211013032.623763-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
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
        kernel-team@android.com, surenb@google.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

When adjacent vmas are being merged it can result in the vma that was
originally passed to madvise_update_vma being destroyed. In the current
implementation, the name parameter passed to madvise_update_vma points
directly to vma->anon_name->name and it is used after the call to
vma_merge. In the cases when vma_merge merges the original vma and
destroys it, this will result in use-after-free bug as shown below:

madvise_vma_behavior << passes vma->anon_name->name as name param
  madvise_update_vma(name)
    vma_merge
      __vma_adjust
        vm_area_free <-- frees the vma
    replace_vma_anon_name(name) <-- UAF

Fix this by raising the name refcount and stabilizing it. Introduce
vma_anon_name_{get/put} API for this purpose.

Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v3:
- Change madvise_vma_anon_name and replace_vma_anon_name to accept struct
anon_vma_name* instead of char*, per Michal Hocko and Matthew Wilcox

 include/linux/mm_inline.h | 13 ++++++++
 mm/madvise.c              | 67 +++++++++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b725839dfe71..2ad9b28499b1 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -145,6 +145,11 @@ static __always_inline void del_page_from_lru_list(struct page *page,
  */
 extern const char *vma_anon_name(struct vm_area_struct *vma);
 
+/* mmap_lock should be read-locked */
+extern struct anon_vma_name *vma_anon_name_get(struct vm_area_struct *vma);
+
+extern void vma_anon_name_put(struct anon_vma_name *anon_name);
+
 /*
  * mmap_lock should be read-locked for orig_vma->vm_mm.
  * mmap_lock should be write-locked for new_vma->vm_mm or new_vma should be
@@ -176,6 +181,14 @@ static inline const char *vma_anon_name(struct vm_area_struct *vma)
 {
 	return NULL;
 }
+
+static inline
+struct anon_vma_name *vma_anon_name_get(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline void vma_anon_name_put(struct anon_vma_name *anon_name) {}
 static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
 			      struct vm_area_struct *new_vma) {}
 static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..1807778a5f70 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -70,6 +70,9 @@ static struct anon_vma_name *anon_vma_name_alloc(const char *name)
 	struct anon_vma_name *anon_name;
 	size_t count;
 
+	if (!name)
+		return NULL;
+
 	/* Add 1 for NUL terminator at the end of the anon_name->name */
 	count = strlen(name) + 1;
 	anon_name = kmalloc(struct_size(anon_name, name, count), GFP_KERNEL);
@@ -103,6 +106,23 @@ const char *vma_anon_name(struct vm_area_struct *vma)
 	return vma->anon_name->name;
 }
 
+struct anon_vma_name *vma_anon_name_get(struct vm_area_struct *vma)
+{
+	if (!has_vma_anon_name(vma))
+		return NULL;
+
+	mmap_assert_locked(vma->vm_mm);
+
+	kref_get(&vma->anon_name->kref);
+	return vma->anon_name;
+}
+
+void vma_anon_name_put(struct anon_vma_name *anon_name)
+{
+	if (anon_name)
+		kref_put(&anon_name->kref, vma_anon_name_free);
+}
+
 void dup_vma_anon_name(struct vm_area_struct *orig_vma,
 		       struct vm_area_struct *new_vma)
 {
@@ -126,33 +146,34 @@ void free_vma_anon_name(struct vm_area_struct *vma)
 }
 
 /* mmap_lock should be write-locked */
-static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
+static int replace_vma_anon_name(struct vm_area_struct *vma,
+				 struct anon_vma_name *anon_name)
 {
-	const char *anon_name;
+	const char *orig_name;
 
-	if (!name) {
+	if (!anon_name) {
 		free_vma_anon_name(vma);
 		return 0;
 	}
 
-	anon_name = vma_anon_name(vma);
-	if (anon_name) {
+	orig_name = vma_anon_name(vma);
+	if (orig_name) {
 		/* Same name, nothing to do here */
-		if (!strcmp(name, anon_name))
+		if (!strcmp(anon_name->name, orig_name))
 			return 0;
 
 		free_vma_anon_name(vma);
 	}
-	vma->anon_name = anon_vma_name_alloc(name);
-	if (!vma->anon_name)
-		return -ENOMEM;
+	kref_get(&anon_name->kref);
+	vma->anon_name = anon_name;
 
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
@@ -161,12 +182,15 @@ static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
 /*
  * Update the vm_flags on region of a vma, splitting it or merging it as
  * necessary.  Must be called with mmap_sem held for writing;
+ * Caller should ensure anon_name stability by raising its refcount even when
+ * anon_name belongs to a valid vma because this function might free that vma.
  */
 static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct vm_area_struct **prev, unsigned long start,
 			      unsigned long end, unsigned long new_flags,
-			      const char *name)
+			      struct anon_vma_name *anon_name)
 {
+	const char *name = anon_name ? anon_name->name : NULL;
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
@@ -209,7 +233,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	 */
 	vma->vm_flags = new_flags;
 	if (!vma->vm_file) {
-		error = replace_vma_anon_name(vma, name);
+		error = replace_vma_anon_name(vma, anon_name);
 		if (error)
 			return error;
 	}
@@ -976,6 +1000,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 {
 	int error;
 	unsigned long new_flags = vma->vm_flags;
+	struct anon_vma_name *anon_name;
 
 	switch (behavior) {
 	case MADV_REMOVE:
@@ -1040,8 +1065,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	}
 
+	anon_name = vma_anon_name_get(vma);
 	error = madvise_update_vma(vma, prev, start, end, new_flags,
-				   vma_anon_name(vma));
+				   anon_name);
+	vma_anon_name_put(anon_name);
 
 out:
 	/*
@@ -1225,7 +1252,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long name)
+				 unsigned long anon_name)
 {
 	int error;
 
@@ -1234,7 +1261,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
-				   (const char *)name);
+				   (struct anon_vma_name *)anon_name);
 
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
@@ -1248,8 +1275,10 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in, const char *name)
 {
+	struct anon_vma_name *anon_name;
 	unsigned long end;
 	unsigned long len;
+	int ret;
 
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
@@ -1266,8 +1295,12 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, (unsigned long)name,
+	anon_name = anon_vma_name_alloc(name);
+	ret = madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
 				 madvise_vma_anon_name);
+	vma_anon_name_put(anon_name);
+
+	return ret;
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 /*
-- 
2.35.1.265.g69c8d7142f-goog

