Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE65AED94
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiIFOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbiIFOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:39:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9483F03
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:01:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j6-20020a170902da8600b00176a4279ba4so4079177plx.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=2iqiRoRfI36tlnsgrgLfPSRPdRupjE9Pp67XbsjYly0=;
        b=FJNt4yzR1tqqVD7b94MqM0o6NGe/NKEGqyWS1EReZ+MxJS1kjyqazZLpTY4oekYzs7
         Sng9fkDy2iMwDpVYVyArnXX4EL1AFcW+vtwK38W/dEISkHGGz9tJc2Anw8mV2TuWAJ1x
         k1wBMYd6KwUVQa9EOnjuz8+C8U36lsX3ORfPBcZ1BusJCpH1LwTMjK6+RI+aDInCa+gf
         l9xGkTL7Re6HoZMsJeLl5T6wS5rb59mMfqqIgOL5me4LHPIlWJesiVB8i4nd0H8PUhYk
         ZqDBLK4jf+xBnDVIk2hS/kHsU68K7a7kCXkWQDCPGqhA9zUKivfMVCbcPJqpTPPXDjei
         WzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=2iqiRoRfI36tlnsgrgLfPSRPdRupjE9Pp67XbsjYly0=;
        b=3ssc5XJZ4N7aqrvu59prQvaULQLtD4ET6GKyLYpwRunRGoXpyQv7b5GHtYuNoVMFb9
         0eOZh0ZlfNoL3Vf+HJ19rjjePmwZqo2pRRXYaAjvuOzMo7Kdvy+bJqUpixo0Vv+Ppix2
         5eS/6zPdIIAHE5s3EVPO05lmDUoB0hYNuyXHuGpzl9tMDbb8mg667R4yaBck77Yx9E4v
         E8XFTfRF9ly4Z48D4QXNGOMUHIVfvfkhHHp9/7+yvIYKPDteY8am3ILbkhyrEwYtqZ68
         mD4TI3RvK851q7lEPhXwE8ZwhnO3PHlZwAlgNasHNxCTm4pKH24sAomYsktDG+MOrvi5
         +17Q==
X-Gm-Message-State: ACgBeo3K5sR7smFQXTXqfzUVVOKeqxvtxQpWivPV/8OGDNUdoIFHV70I
        mUkaT1ifacGEr+P2rzRudV8gtqUdkOVYFQ==
X-Google-Smtp-Source: AA6agR5YYsr/GVCs9t6zlz+hfvPQyJdxROPp63UBu2hEbJkjuAoirddkE5tRjPY9YaqrPuRbCNnUfs83/DtQbA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:164f:b0:1f5:4ced:ed81 with SMTP
 id il15-20020a17090b164f00b001f54ceded81mr24638688pjb.122.1662472799293; Tue,
 06 Sep 2022 06:59:59 -0700 (PDT)
Date:   Tue,  6 Sep 2022 13:59:45 +0000
In-Reply-To: <20220906135948.3048225-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220906135948.3048225-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220906135948.3048225-2-cmllamas@google.com>
Subject: [PATCH RESEND 1/3] binder: rename alloc->vma_vm_mm to alloc->mm
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        linux-kernel@vger.kernel.org
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

Rename ->vma_vm_mm to ->mm to reflect the fact that we no longer cache
this reference from vma->vm_mm but from current->mm instead.

No functional changes in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Acked-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder_alloc.c | 34 +++++++++++++++++-----------------
 drivers/android/binder_alloc.h |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 9b1778c00610..749a4cd30a83 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -208,8 +208,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		}
 	}
 
-	if (need_mm && mmget_not_zero(alloc->vma_vm_mm))
-		mm = alloc->vma_vm_mm;
+	if (need_mm && mmget_not_zero(alloc->mm))
+		mm = alloc->mm;
 
 	if (mm) {
 		mmap_read_lock(mm);
@@ -322,9 +322,9 @@ static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
 	 */
 	if (vma) {
 		vm_start = vma->vm_start;
-		mmap_assert_write_locked(alloc->vma_vm_mm);
+		mmap_assert_write_locked(alloc->mm);
 	} else {
-		mmap_assert_locked(alloc->vma_vm_mm);
+		mmap_assert_locked(alloc->mm);
 	}
 
 	alloc->vma_addr = vm_start;
@@ -336,7 +336,7 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 	struct vm_area_struct *vma = NULL;
 
 	if (alloc->vma_addr)
-		vma = vma_lookup(alloc->vma_vm_mm, alloc->vma_addr);
+		vma = vma_lookup(alloc->mm, alloc->vma_addr);
 
 	return vma;
 }
@@ -401,15 +401,15 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	mmap_read_lock(alloc->vma_vm_mm);
+	mmap_read_lock(alloc->mm);
 	if (!binder_alloc_get_vma(alloc)) {
-		mmap_read_unlock(alloc->vma_vm_mm);
+		mmap_read_unlock(alloc->mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
-	mmap_read_unlock(alloc->vma_vm_mm);
+	mmap_read_unlock(alloc->mm);
 
 	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -823,7 +823,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
 	BUG_ON(alloc->vma_addr &&
-	       vma_lookup(alloc->vma_vm_mm, alloc->vma_addr));
+	       vma_lookup(alloc->mm, alloc->vma_addr));
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -873,8 +873,8 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		kfree(alloc->pages);
 	}
 	mutex_unlock(&alloc->mutex);
-	if (alloc->vma_vm_mm)
-		mmdrop(alloc->vma_vm_mm);
+	if (alloc->mm)
+		mmdrop(alloc->mm);
 
 	binder_alloc_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%s: %d buffers %d, pages %d\n",
@@ -931,13 +931,13 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * read inconsistent state.
 	 */
 
-	mmap_read_lock(alloc->vma_vm_mm);
+	mmap_read_lock(alloc->mm);
 	if (binder_alloc_get_vma(alloc) == NULL) {
-		mmap_read_unlock(alloc->vma_vm_mm);
+		mmap_read_unlock(alloc->mm);
 		goto uninitialized;
 	}
 
-	mmap_read_unlock(alloc->vma_vm_mm);
+	mmap_read_unlock(alloc->mm);
 	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
 		page = &alloc->pages[i];
 		if (!page->page_ptr)
@@ -1020,7 +1020,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	index = page - alloc->pages;
 	page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
 
-	mm = alloc->vma_vm_mm;
+	mm = alloc->mm;
 	if (!mmget_not_zero(mm))
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
@@ -1089,8 +1089,8 @@ static struct shrinker binder_shrinker = {
 void binder_alloc_init(struct binder_alloc *alloc)
 {
 	alloc->pid = current->group_leader->pid;
-	alloc->vma_vm_mm = current->mm;
-	mmgrab(alloc->vma_vm_mm);
+	alloc->mm = current->mm;
+	mmgrab(alloc->mm);
 	mutex_init(&alloc->mutex);
 	INIT_LIST_HEAD(&alloc->buffers);
 }
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index f61a12d5c1e7..ab3b027bcd29 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -78,7 +78,7 @@ struct binder_lru_page {
  *                      (invariant after mmap)
  * @tsk:                tid for task that called init for this proc
  *                      (invariant after init)
- * @vma_vm_mm:          copy of vma->vm_mm (invariant after mmap)
+ * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
  * @free_buffers:       rb tree of buffers available for allocation
@@ -101,7 +101,7 @@ struct binder_lru_page {
 struct binder_alloc {
 	struct mutex mutex;
 	unsigned long vma_addr;
-	struct mm_struct *vma_vm_mm;
+	struct mm_struct *mm;
 	void __user *buffer;
 	struct list_head buffers;
 	struct rb_root free_buffers;
-- 
2.37.2.789.g6183377224-goog

