Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0738F46DD8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhLHVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhLHVZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:25:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD6C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 13:22:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so6756083ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7AiB4xZKo9CfYCzdKVvxaPbZztKFTU9MCKhfSBvngDw=;
        b=ZD3pyDq6HyIQAbnb53r5xYWhonZl7vzKyzJ/RpgDlART3fRWEPaYJOszMUK/NaeNTT
         EVAq6D6jiUM399ZJA0aFUGReV+gBgR9N6DvGUa8HmyUGYASfD7+6a1KqGS2s0TgEDB1t
         DMcQYFXXQrCpaF07o3JwjWPBEfRI4PBDpxDMkzeinyIdSW7Lhyp0u1iVuHAyMe0sEYL0
         YLMVvjmDEqUctw2SoylPZb2RNh1pfdi8qj0bOtWj31gTfQUaZXDg7+GD7PrcyQEDp0q/
         C5hiVh2hOE971kb4gPu8fEH2H3+SXcP/m8QTTVY4l1sgUbWwtNcHt6kaC6oxm8YpyOve
         COnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7AiB4xZKo9CfYCzdKVvxaPbZztKFTU9MCKhfSBvngDw=;
        b=63552pjX8pGA0QtImgSSRqn/JqzBaTYIagMKbVKSPK6PF76esIUG736WyrtSwRXaWm
         gLdATvZF49Q2W9a0Q1mMrb+6XJLBDtipPBH/Fms4KGOCuZfwaAbzY3vEgz8hwgAs/f9d
         Gh/n2E0hgyS2UvzVfQ4Ip7AXqQ83kcrBeyASLAEVx6OS9dCdzO6d9VYW2qkysEOUZAf8
         EAfhbO3iqEP+I9Wn/J5mqm9iGJc83OQzpTt8ApBsm1qBZJwGA/7TCCO43MFqNBA12E8f
         n2ARmHVn62+r/1sOajcTQ8Cdom5fU87Bf7HBihaP8O9NlXnYJ9KUdV+zT4t4EPm7860H
         U5gQ==
X-Gm-Message-State: AOAM53396zSgMtv6FXT4nmKzND45WoseOOODlXHxieDFUdrHP8s+Ry1X
        3CYUTPJVz8Rktxi5iQ1TsZUP6VbbgMk=
X-Google-Smtp-Source: ABdhPJwmX5ycLZWEvpUwxbN+kx4ZMInSe8TpJ7lAq5TIrjBzoLpXy0BMW3REJ9kApX0vManDCrABDX8hUP0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4efa:9eac:2174:103c])
 (user=surenb job=sendgmr) by 2002:a25:ac23:: with SMTP id w35mr1497904ybi.341.1638998534911;
 Wed, 08 Dec 2021 13:22:14 -0800 (PST)
Date:   Wed,  8 Dec 2021 13:22:09 -0800
Message-Id: <20211208212211.2860249-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v4 1/3] mm: protect free_pgtables with mmap_lock write lock in exit_mmap
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
changes in v4
- Separated comments describing vm_operations_struct::close locking
requirements into a separate patch, per Matthew Wilcox

 mm/mmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

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

