Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B348846C6F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhLGVyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhLGVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:54:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C68C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:50:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d9-20020a251d09000000b005c208092922so766808ybd.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eHNFJYUS7s98EY2lIfhsBH85e2eiRptEG86rTMjby3I=;
        b=RNbBJEbidVM5Ac/Cp7hVfDFClsMzd4mI1rxG1KPQsFVPWJN2abVKIN1P4/9ZpccfGR
         V9vgkm9Nx/UjZYBGXXVWJbJHvRqC60ojnHm22fAN9GwqXwVspHv+6DJSiM/10MYSiGAj
         jB2OuTNyULhWhOrJGEhwz5zdqQkZa5czdJoCm829KF5kKUVzkfh69HxjnkrUFq7DzI85
         fLMDtoFtYv0MGvGc2pZMTg3V1yOmlOunZ2ZzyY8odkAYvJyORBooBRt8Uq/DoMkGxGNh
         78ypUVWjtaHb/nD1OqoKpObhCLZXvcQhcqQSvTqbKoZqckZV1TSead7iJEPtJsRgNt5t
         ksRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eHNFJYUS7s98EY2lIfhsBH85e2eiRptEG86rTMjby3I=;
        b=V8HzdX4ipYWD1soz9WlVO6fr0hsSYlR4e2yj9IorFNDJmfpy04Zqo/4gu4LtpkMrKy
         f7pENWWckp65Q+18Fp2U9L0M9jKOVU+3e7iviLtFYB9agMOC+4iaZFFmmLVdyethYqwN
         o0GjN+kFjEGv66EUpWQLO4AXuaj/iXnDGLNhDZhugsX/ffGJB93ZWk4bugJ+QCg0fCNJ
         24PFUUPVDhgWYCHnu5GbyOU5YDoa+ZZ9Hg8y/2AQuXQEoJ2JLGQs79QenYlq2Q5kvoXz
         tPahdb8HtUCQCOl1+BjEs3M2ycdwHjZrp6Vn1x6QIjPO9uQPzPsZO33HKeNpC+5P30L9
         1y5Q==
X-Gm-Message-State: AOAM530fyND2MsunHPC36tVAe7gI8NtJxCCULJQY1CyT3GndZlpKDTaI
        eRVNPI1jqWOt/NKhsstkJCzUv153aFQ=
X-Google-Smtp-Source: ABdhPJxYG9QPsqoonw9DmkWvWnN0thm87lG8wB6LGNRWmRlEYY2T38W/3oBLw3kxcUbqL60HyUffvx8Aqbc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c2df:fc7c:ed5e:6133])
 (user=surenb job=sendgmr) by 2002:a25:d756:: with SMTP id o83mr52328152ybg.394.1638913835585;
 Tue, 07 Dec 2021 13:50:35 -0800 (PST)
Date:   Tue,  7 Dec 2021 13:50:30 -0800
Message-Id: <20211207215031.2251719-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 1/2] mm: protect free_pgtables with mmap_lock write lock in exit_mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oom-reaper and process_mrelease system call should protect against
races with exit_mmap which can destroy page tables while they
walk the VMA tree. oom-reaper protects from that race by setting
MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
before taking and releasing mmap_write_lock. process_mrelease has
to elevate mm->mm_users to prevent such race. Both oom-reaper and
process_mrelease hold mmap_read_lock when walking the VMA tree.
The locking rules and mechanisms could be simpler if exit_mmap takes
mmap_write_lock while executing destructive operations such as
free_pgtables.
Change exit_mmap to hold the mmap_write_lock when calling
free_pgtables and remove_vma. Operations like unmap_vmas and
unlock_range are not destructive and could run under mmap_read_lock
but for simplicity we take one mmap_write_lock during almost the entire
operation. Note also that because oom-reaper checks VM_LOCKED flag,
unlock_range() should not be allowed to race with it.
Before this patch, remove_vma used to be called with no locks held,
however with fput being executed asynchronously and vm_ops->close
not being allowed to hold mmap_lock (it is called from __split_vma
with mmap_sem held for write), changing that should be fine.
In most cases this lock should be uncontended. Previously, Kirill
reported ~4% regression caused by a similar change [1]. We reran the
same test and although the individual results are quite noisy, the
percentiles show lower regression with 1.6% being the worst case [2].
The change allows oom-reaper and process_mrelease to execute safely
under mmap_read_lock without worries that exit_mmap might destroy page
tables from under them.

[1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
[2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v3
- Amended patch description to explain why remove_vma can be called while
holding mmap_write_lock, per Michal Hocko
- Added a comment for vm_operations_struct::close, documenting restriction for
taking mmap_lock in the callback, per Michal Hocko and Matthew Wilcox

 include/linux/mm.h |  4 ++++
 mm/mmap.c          | 16 ++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..97e1a05c3b2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -577,6 +577,10 @@ enum page_entry_size {
  */
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
+    /*
+     * Called with mmap_lock lock held for write from __split_vma and
+     * remove_vma, therefore should never take that lock.
+     */
 	void (*close)(struct vm_area_struct * area);
 	/* Called any time before splitting to check if it's allowed */
 	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
diff --git a/mm/mmap.c b/mm/mmap.c
index bfb0ea164a90..f4e09d390a07 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
 		 * __oom_reap_task_mm() will not block.
 		 *
-		 * This needs to be done before calling munlock_vma_pages_all(),
+		 * This needs to be done before calling unlock_range(),
 		 * which clears VM_LOCKED, otherwise the oom reaper cannot
 		 * reliably test it.
 		 */
 		(void)__oom_reap_task_mm(mm);
 
 		set_bit(MMF_OOM_SKIP, &mm->flags);
-		mmap_write_lock(mm);
-		mmap_write_unlock(mm);
 	}
 
+	mmap_write_lock(mm);
 	if (mm->locked_vm)
 		unlock_range(mm->mmap, ULONG_MAX);
 
 	arch_exit_mmap(mm);
 
 	vma = mm->mmap;
-	if (!vma)	/* Can happen if dup_mmap() received an OOM */
+	if (!vma) {
+		/* Can happen if dup_mmap() received an OOM */
+		mmap_write_unlock(mm);
 		return;
+	}
 
 	lru_add_drain();
 	flush_cache_mm(mm);
@@ -3171,16 +3173,14 @@ void exit_mmap(struct mm_struct *mm)
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 
-	/*
-	 * Walk the list again, actually closing and freeing it,
-	 * with preemption enabled, without holding any MM locks.
-	 */
+	/* Walk the list again, actually closing and freeing it. */
 	while (vma) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
 		vma = remove_vma(vma);
 		cond_resched();
 	}
+	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
 
-- 
2.34.1.400.ga245620fadb-goog

