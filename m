Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF26527EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiEPH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbiEPH40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:56:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4078CB33
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:56:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25a086000000b0064d8822f94bso2505188ybh.22
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AkzbZUUJbKkKZF8OCLuIxnaK4yhhmDEBAMVwQQZIjPw=;
        b=NHb73BqEQQrOLYwOniqH+I1KrZOGNOQlLtgMcagSkYUSWDy6GPOzxTw7tEKSlK2J3N
         FR54JD6olOOTL2vnRrP48GyP8UtZGMbg2uZS6ZK31kbD65Rwi1MmwobJYt4XF6bDT45N
         MkZvFxTloWynDzi7URUQCiKC112K+j2qIf1uRoQpmYLqbcjcS9EHTOzECCiTGM7jqIoP
         X9V58uSAJjXUTQv31yTK45lW/bIhqPTIVXc7063Q1rAPzZ9hULPMnuAeGQEl3DnHO3N3
         zF1GXUi+2rVHEJwDxlzfwGpDsI/apcxtXOY7QYv3qlM6SUbPtxAneseB5rQOd7rWf7/s
         mf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AkzbZUUJbKkKZF8OCLuIxnaK4yhhmDEBAMVwQQZIjPw=;
        b=KM3easg+bo5qvqQ4Wa08O0pm7HSLE8g/ukXDmuN/Bm7rhdQwyXCxx9hl5ojrJ2XNY7
         kh/ytp+y32diIOcr874IDaGMpZ26cPdsKcNZ97bRLobZxt7GA5WMOGpxML302vaoH0xt
         kN4FO9L4mPGXdbctKp7L0u4GMDKOWUvwtxVdFy8TGu7uFYYW4Z3SDI1N0ALJTl/d6F/W
         h6F2U68kqfRPGgHKRgmDu3Ozxcn9+Bda5/CKEKCBh0d1R03VA/sPMdZ3AEPhbYgWhANP
         FNnQmvmQ3RzBoEw0e8zFWVL7pOIlQIm0REJcLHvzxzP+EqNc8PJ/8PkIkqzLnOFLTb+5
         8kkw==
X-Gm-Message-State: AOAM530/8n3D53TVZrGDNjL20qIKHS+WCYFyeK+p05DGKz6ZPkiGRAZe
        /yPdQGCBmrAGzEBt1sgQnqRwmdxEPIA=
X-Google-Smtp-Source: ABdhPJyBBCojxk0seMo3izlq0YIsm5tU550dSAqNmlgmosNUvnP68lSg1jhby26PHmTgALdpi3FuEyIMnak=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:97b7:3e1e:26a3:690f])
 (user=surenb job=sendgmr) by 2002:a0d:eb53:0:b0:2fe:b6bb:aa38 with SMTP id
 u80-20020a0deb53000000b002feb6bbaa38mr15064368ywe.377.1652687783377; Mon, 16
 May 2022 00:56:23 -0700 (PDT)
Date:   Mon, 16 May 2022 00:56:18 -0700
Message-Id: <20220516075619.1277152-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 1/2] mm: drop oom code from exit_mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

The primary reason to invoke the oom reaper from the exit_mmap path used
to be a prevention of an excessive oom killing if the oom victim exit
races with the oom reaper (see [1] for more details). The invocation has
moved around since then because of the interaction with the munlock
logic but the underlying reason has remained the same (see [2]).

Munlock code is no longer a problem since [3] and there shouldn't be
any blocking operation before the memory is unmapped by exit_mmap so
the oom reaper invocation can be dropped. The unmapping part can be done
with the non-exclusive mmap_sem and the exclusive one is only required
when page tables are freed.

Remove the oom_reaper from exit_mmap which will make the code easier to
read. This is really unlikely to make any observable difference although
some microbenchmarks could benefit from one less branch that needs to be
evaluated even though it almost never is true.

[1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
[2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
[3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/oom.h |  2 --
 mm/mmap.c           | 31 ++++++++++++-------------------
 mm/oom_kill.c       |  2 +-
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..6cdf0772dbae 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }
 
-bool __oom_reap_task_mm(struct mm_struct *mm);
-
 long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 313b57d55a63..ded42150e706 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
 
-	if (unlikely(mm_is_oom_victim(mm))) {
-		/*
-		 * Manually reap the mm to free as much memory as possible.
-		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
-		 * this mm from further consideration.  Taking mm->mmap_lock for
-		 * write after setting MMF_OOM_SKIP will guarantee that the oom
-		 * reaper will not run on this mm again after mmap_lock is
-		 * dropped.
-		 *
-		 * Nothing can be holding mm->mmap_lock here and the above call
-		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
-		 * __oom_reap_task_mm() will not block.
-		 */
-		(void)__oom_reap_task_mm(mm);
-		set_bit(MMF_OOM_SKIP, &mm->flags);
-	}
-
-	mmap_write_lock(mm);
+	mmap_read_lock(mm);
 	arch_exit_mmap(mm);
 
 	vma = mm->mmap;
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
-		mmap_write_unlock(mm);
+		mmap_read_unlock(mm);
 		return;
 	}
 
@@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
+	mmap_read_unlock(mm);
+
+	/*
+	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
+	 * because the memory has been already freed. Do not bother checking
+	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
+	 */
+	set_bit(MMF_OOM_SKIP, &mm->flags);
+
+	mmap_write_lock(mm);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 49d7df39b02d..36355b162727 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -509,7 +509,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-bool __oom_reap_task_mm(struct mm_struct *mm)
+static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-- 
2.36.0.550.gb090851708-goog

