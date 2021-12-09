Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9546F3AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhLITRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLITRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:17:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A8C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:13:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a2584c5000000b005f89a35e57eso12061949ybm.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iP6OFT0YZhBctvqcWIj5MZywUhn3cHVX5RMNAeQUo1A=;
        b=jUTWtoDW+lW2eysMZOwD8mkRgut+cjRxDaSoCvuduzR8mUCxdf8WG7ntQjhOEcLQ1T
         aaDYa2vrJyl+idaBN7hwroB5GfZij+ik8jukThK1/e3/aCAX/fr953tOEHnXAzQN0Af5
         AD6uflmjVnnppsgwjBCe3aX5bsBt0iJe85wzutNYszCcujaVVTgO7zEX4gmELOBq/uiu
         WBjFgz7lbPvtPN9VNLH1N/U7Y9IRQyO343//H/BpbaqnbcERRZwUZBlsEisF67kEzyRQ
         1GrE9FDjQE5MfzI+9TqZyC1ArdwYBqDKIbCj1zhUdNt8uObUMaYcQqw9pav1v8hRorEx
         ZR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iP6OFT0YZhBctvqcWIj5MZywUhn3cHVX5RMNAeQUo1A=;
        b=yXnKhWs63ySGSIejQKnlrgya+IF1LlcrxaFjTe/pgiZ171QpPP5S88kUa6CDX05Lqn
         Ou4RKj5woLkMrRt4srAJTPelNeUhZ0Ja/A/MAwgqyFK7OSvhYUsg5y+sQZJzjYU1Dpkl
         eys9nN+FpkBVljGPECLquu9BUOCfxq0jiAEpUd2LlCBJ/a2NuQTXpRr1e53lOSm7eqvj
         WTI3WRwj/BB0Oy7s7lGbj4RDoLMPWUwvn0QqL3JDx1O3tFeYwyB0AG0Ko49JyHtIwTqq
         muafYa3DKpByvecwxlazxkkMHjyWaATUoTHmpbCV+tj6HvSoSXb1kRJwPGt3+w17nSHs
         9GnA==
X-Gm-Message-State: AOAM5324JC0YOGPseIXONpxxsZa/jmaYInTMOVMlauRPQjx0faaE4dR5
        ZljdaB0L5owPoCrAfzKZfqkMaRzC2Aw=
X-Google-Smtp-Source: ABdhPJwRa0DrovLmXnVJtJ/EBrf/knW3YT2e46j6n37V+4D5mBIE+WTkDPzGI87t5yBEusZSVhTpSs4h37w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:8b23:8fcc:c6e4:3a65])
 (user=surenb job=sendgmr) by 2002:a25:d16:: with SMTP id 22mr8606614ybn.51.1639077209831;
 Thu, 09 Dec 2021 11:13:29 -0800 (PST)
Date:   Thu,  9 Dec 2021 11:13:23 -0800
Message-Id: <20211209191325.3069345-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 1/3] mm: protect free_pgtables with mmap_lock write lock in exit_mmap
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
unlock_range, free_pgtables and remove_vma. Note also that because
oom-reaper checks VM_LOCKED flag, unlock_range() should not be allowed
to race with it. Before this patch, remove_vma used to be called with
no locks held, however with fput being executed asynchronously and
vm_ops->close not being allowed to hold mmap_lock (it is called from
__split_vma with mmap_sem held for write), changing that should be fine.
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
Acked-by: Michal Hocko <mhocko@suse.com>
---
changes in v5
- Corrected patch description, per Michal Hocko
- Added Acked-by

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
2.34.1.173.g76aa8bc2d0-goog

