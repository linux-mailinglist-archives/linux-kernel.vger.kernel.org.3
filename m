Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49BE46E54C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhLIJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:15:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36654 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhLIJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:15:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6685F1FD2A;
        Thu,  9 Dec 2021 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639041131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMKe2fpbaFIkwZm6Sx+WeSLDOJ/0w510lqoTLI2UzPI=;
        b=XLV+DOARD1znUeX5QY+Ws9skotH/YYoxpu2j/1lUla0gfpLOKIrx9df+SRHjRaNQli31yJ
        /1SvkgW/vTRWYgL20HgHbCZppbMaam9zpTsg8i0RZ64yCpXyQu6BdmNQl/SnjxRGi+4qF4
        JOxdkVn519bLQWMp8MoizZzsse3vAkk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3481AA3B85;
        Thu,  9 Dec 2021 09:12:11 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:12:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
Message-ID: <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208212211.2860249-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do we want this on top?
----
From 58b04ae6dc97b0105ea2651daca55cf2386f69b4 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 9 Dec 2021 10:07:51 +0100
Subject: [PATCH] mm: drop MMF_OOM_SKIP from exit_mmap

MMF_OOM_SKIP used to play a synchronization role between exit_mmap and
oom repear in the past. Since the exclusive mmap_sem is held in
exit_mmap to cover all destructive operations the flag synchronization
is not needed anymore and we can safely drop it. Just make sure that
mm->mmap is set to NULL so that nobody will access the freed vma list.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/mmap.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f4e09d390a07..0d6af9d89aa8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3129,28 +3129,6 @@ void exit_mmap(struct mm_struct *mm)
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
-		 *
-		 * This needs to be done before calling unlock_range(),
-		 * which clears VM_LOCKED, otherwise the oom reaper cannot
-		 * reliably test it.
-		 */
-		(void)__oom_reap_task_mm(mm);
-
-		set_bit(MMF_OOM_SKIP, &mm->flags);
-	}
-
 	mmap_write_lock(mm);
 	if (mm->locked_vm)
 		unlock_range(mm->mmap, ULONG_MAX);
@@ -3180,6 +3158,7 @@ void exit_mmap(struct mm_struct *mm)
 		vma = remove_vma(vma);
 		cond_resched();
 	}
+	mm->mmap = NULL;
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
