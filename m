Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1AF4B047D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiBJEcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiBJEcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:32:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5E104
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:32:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h6-20020a253a06000000b0061de83305f2so9513587yba.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 20:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E8K8TY3WQoynog2K9gwGq6HZDB3C8OmCo9KzOU7aa4U=;
        b=VEq3M9r04ewU0yeCOsrcI4pyk+UJTphQS82dmWEm3+OMDQREuGfAOz66hclRVOeZPD
         ZkC69UIzNyQi6XmZpcslNpsl2HEelRcVlEXaDRkt2aw3y45RBwGwxv4oFj5Gr81rkpnZ
         4598402E+4Auf/fBvEb1Ioi/v/xEnobpA+UFSpdYQfKb0f5g09hnpQQdJUGOAkepQpqU
         zFll3rEYgI9LnfylK5231W2slHLyhBVMIhnsqyG/wWMHNJRWStBANCvFiL+Y9ix5O22I
         3qMjxH8FHrqQ5rhhzvN9OTn5kn33m+nDDsm26bRLzAvDWbY8RHGDwr+3F4EX/Rlq9iAa
         kV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E8K8TY3WQoynog2K9gwGq6HZDB3C8OmCo9KzOU7aa4U=;
        b=urmUs+kDh+CYVg9o/pLsfgwQZto9ttT+RCvSGL3ydeRWYWeBrTHV+BT2T+FTvGtgzD
         quzZWb5dPczbuKEjIZQGQeAnzb5QAueeFhWzONjhsVfdIEbt4GfGT1VmU9CgLu4vGqj/
         FpQej8tFwlD7GRGTVe0wxw+BOffpR/SB7YcmqvF0vQNaowLZOwQMlVclRj+OnmOw1RfP
         +Ti+zfgZnD/rBc1biyHsWWW/cy0fj5aTu0554pdpkfLWY33ZV64A+pfzxLV1+MJu8BTI
         MiPn1jF1sl9kRK3ibRWvv5ak3ttJcRbSFhUt5mdNKWL67EAM4sFGxYhFmNl6u/mAW6kH
         F+hg==
X-Gm-Message-State: AOAM531niQtCpE/onMSzJNmoWWt37TEo8SfAe4mGPd9fXJm755/KEAhq
        h36QEGh+zKSf5gvxW5BflJXPmpyWbas=
X-Google-Smtp-Source: ABdhPJwKTQEQto4N95ge0VYx34aTFFH/Juo7oMq89toei9Qj5rVoHC7Yc4AOA00i28n5/HaHyoRoWiP7jJE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:17d2:7c05:7f59:da03])
 (user=surenb job=sendgmr) by 2002:a25:8f92:: with SMTP id u18mr5679417ybl.446.1644467539833;
 Wed, 09 Feb 2022 20:32:19 -0800 (PST)
Date:   Wed,  9 Feb 2022 20:32:15 -0800
Message-Id: <20220210043215.42794-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
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
changes in v2:
- Replaces name copying with refcounting and added vma_anon_name_{get/put} API,
per Andrew Morton

 include/linux/mm_inline.h | 13 +++++++++++++
 mm/madvise.c              | 28 ++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

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
index 5604064df464..9cf069e574c0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -103,6 +103,22 @@ const char *vma_anon_name(struct vm_area_struct *vma)
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
+	kref_put(&anon_name->kref, vma_anon_name_free);
+}
+
 void dup_vma_anon_name(struct vm_area_struct *orig_vma,
 		       struct vm_area_struct *new_vma)
 {
@@ -976,6 +992,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 {
 	int error;
 	unsigned long new_flags = vma->vm_flags;
+	struct anon_vma_name *anon_name;
 
 	switch (behavior) {
 	case MADV_REMOVE:
@@ -1040,8 +1057,15 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	}
 
-	error = madvise_update_vma(vma, prev, start, end, new_flags,
-				   vma_anon_name(vma));
+	anon_name = vma_anon_name_get(vma);
+	if (anon_name) {
+		error = madvise_update_vma(vma, prev, start, end, new_flags,
+					   anon_name->name);
+		vma_anon_name_put(anon_name);
+	} else {
+		error = madvise_update_vma(vma, prev, start, end, new_flags,
+					   NULL);
+	}
 
 out:
 	/*
-- 
2.35.1.265.g69c8d7142f-goog

