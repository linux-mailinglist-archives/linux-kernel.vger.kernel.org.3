Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347295A9E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIARgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiIARfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85B58DE3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-343a77f2129so37851527b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=OSuAy3hdf+ZsQNxs3kxuMbhy9QBzPPm6GtoQo3aB3NA=;
        b=KO0CCoeJjfr6uQrGAGyvNgiswHns8WtW+vNCGbmb+v3lgrTdGqCfv4Q0htUhCqi7L8
         NjudqvxWt3vJ1U4f4TaUrpiWDGDkYHTslXKwJR5AqzCzKMPyrwODeBVbDXy2W3OJ+0AJ
         32abPt60ZQu7g2dOidue0bSh6Xh6XjE19T0FxDLe4AuFdEJaS9z9AXmzzaZHqpBfL4WP
         CC3bKhkCnU66eINFmY1rA50iR0WfFedon1RB2Q6DxPGeP1j32wzMpXKoaqT2OAwWSdUJ
         2Dr+2H3hwJpx9s6tPPyXHohy9BSbHgL+aey4lgZu/S9fAtQBjK/jZiqIlpp1Ch7Jebxy
         Blpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=OSuAy3hdf+ZsQNxs3kxuMbhy9QBzPPm6GtoQo3aB3NA=;
        b=myoKrZKJIYrbGLzTa/fQhuV5Da8WFJdGpxhSTgGM99Galvn/giAVnzrN6kZXoiBxOl
         jPbJg9MjMy/ZzgpguMnZJYiKDHmDKQA2m1NQEFku4LHdcavfUdS3bZvyKDxm0n3L6d9t
         wi7xBWmeSpePQorRi53GfpZEHaMVRRyiViGBwgWC0iPhschWmhXf4VrTuWV/5gBTrEKa
         N841m/PqAoVESCR2qxbcTgJDxddqkqy69vnrnPifOy1H3l/VGwYg00zeWr8JzIBZVFte
         0E1I+StKBlOzq6+aE2NJFnVecNa9HpHOr379LUFBF8+Sh1Zd5iOkpcRwV0eBr6C/MkPe
         hN8g==
X-Gm-Message-State: ACgBeo37iOUS7qmiLSJI4+fvIn9TjpQ4N+Z/PSwoKzRw3jkNRcxZjUfT
        CK2vCrPaijWZk51CRhnx83q/LmeVLmM=
X-Google-Smtp-Source: AA6agR5mOhnOZ5TXGA7QbMyhBcTFpfMYAPy+7Q1nZkdORl1Ru4vF2e+A26u5Wht4tIYfxlBv6SIkkjkdNGw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a0d:edc2:0:b0:338:957:a719 with SMTP id
 w185-20020a0dedc2000000b003380957a719mr24916063ywe.132.1662053737185; Thu, 01
 Sep 2022 10:35:37 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:54 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-7-surenb@google.com>
Subject: [RFC PATCH RESEND 06/28] mm: mark VMA as locked whenever
 vma->vm_flags are modified
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
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

VMA flag modifications should be done under VMA lock to prevent concurrent
page fault handling in that area.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 1 +
 fs/userfaultfd.c   | 6 ++++++
 mm/madvise.c       | 1 +
 mm/mlock.c         | 2 ++
 mm/mmap.c          | 1 +
 mm/mprotect.c      | 1 +
 6 files changed, 12 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4e0023643f8b..ceffa5c2c650 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1285,6 +1285,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
+				vma_mark_locked(vma);
 				vma->vm_flags &= ~VM_SOFTDIRTY;
 				vma_set_page_prot(vma);
 			}
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 175de70e3adf..fe557b3d1c07 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -620,6 +620,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		mmap_write_lock(mm);
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
+				vma_mark_locked(vma);
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 				vma->vm_flags &= ~__VM_UFFD_FLAGS;
 			}
@@ -653,6 +654,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 
 	octx = vma->vm_userfaultfd_ctx.ctx;
 	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
+		vma_mark_locked(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 		return 0;
@@ -734,6 +736,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		atomic_inc(&ctx->mmap_changing);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
+		vma_mark_locked(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 	}
@@ -891,6 +894,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			vma = prev;
 		else
 			prev = vma;
+		vma_mark_locked(vma);
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
@@ -1449,6 +1453,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_mark_locked(vma);
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
@@ -1630,6 +1635,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_mark_locked(vma);
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 5f0f0948a50e..a173f0025abd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -181,6 +181,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	/*
 	 * vm_flags is protected by the mmap_lock held in write mode.
 	 */
+	vma_mark_locked(vma);
 	vma->vm_flags = new_flags;
 	if (!vma->vm_file) {
 		error = replace_anon_vma_name(vma, anon_name);
diff --git a/mm/mlock.c b/mm/mlock.c
index b14e929084cc..f62e1a4d05f2 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -380,6 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (newflags & VM_LOCKED)
 		newflags |= VM_IO;
+	vma_mark_locked(vma);
 	WRITE_ONCE(vma->vm_flags, newflags);
 
 	lru_add_drain();
@@ -456,6 +457,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 
 	if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
 		/* No work to do, and mlocking twice would be wrong */
+		vma_mark_locked(vma);
 		vma->vm_flags = newflags;
 	} else {
 		mlock_vma_pages_range(vma, start, end, newflags);
diff --git a/mm/mmap.c b/mm/mmap.c
index 693e6776be39..f89c9b058105 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1818,6 +1818,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 out:
 	perf_event_mmap(vma);
 
+	vma_mark_locked(vma);
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bc6bddd156ca..df47fc21b0e4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -621,6 +621,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
 	 */
+	vma_mark_locked(vma);
 	vma->vm_flags = newflags;
 	/*
 	 * We want to check manually if we can change individual PTEs writable
-- 
2.37.2.789.g6183377224-goog

