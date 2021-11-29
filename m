Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285174613D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhK2L2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:28:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhK2L0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:26:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E86F212C9;
        Mon, 29 Nov 2021 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638185008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/Fr5NxP2jCRkLtXeiXZXbWtKkV0jHF3GitFDxVGIWg=;
        b=BzpRJa2vr9jLIWnSYSIrW8ycKc8vWG2pId4DDQaGtSKAeZSLGq+SKHboviPUK5oJamwTaO
        nHvEJ704RXZHxIIqGB0Xfd7uEuNtbujL4bVbai2+n80W3c2uuZm6zLBnxpQP8QK2qz432V
        UezHo2aX7Z/bDeoss0EYlq00t0Z7elk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BACC3A3B83;
        Mon, 29 Nov 2021 11:23:27 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:23:23 +0100
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
Subject: Re: [PATCH v2 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
References: <20211124235906.14437-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124235906.14437-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-11-21 15:59:05, Suren Baghdasaryan wrote:
> oom-reaper and process_mrelease system call should protect against
> races with exit_mmap which can destroy page tables while they
> walk the VMA tree. oom-reaper protects from that race by setting
> MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> before taking and releasing mmap_write_lock. process_mrelease has
> to elevate mm->mm_users to prevent such race. Both oom-reaper and
> process_mrelease hold mmap_read_lock when walking the VMA tree.
> The locking rules and mechanisms could be simpler if exit_mmap takes
> mmap_write_lock while executing destructive operations such as
> free_pgtables.
> Change exit_mmap to hold the mmap_write_lock when calling
> free_pgtables. Operations like unmap_vmas() and unlock_range() are not
> destructive and could run under mmap_read_lock but for simplicity we
> take one mmap_write_lock during almost the entire operation. Note
> also that because oom-reaper checks VM_LOCKED flag, unlock_range()
> should not be allowed to race with it.
> In most cases this lock should be uncontended. Previously, Kirill
> reported ~4% regression caused by a similar change [1]. We reran the
> same test and although the individual results are quite noisy, the
> percentiles show lower regression with 1.6% being the worst case [2].
> The change allows oom-reaper and process_mrelease to execute safely
> under mmap_read_lock without worries that exit_mmap might destroy page
> tables from under them.
> 
> [1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
> [2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v2
> - Moved mmap_write_unlock to cover remove_vma loop as well, per Matthew Wilcox
> 
>  mm/mmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bfb0ea164a90..f4e09d390a07 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>  		 * __oom_reap_task_mm() will not block.
>  		 *
> -		 * This needs to be done before calling munlock_vma_pages_all(),
> +		 * This needs to be done before calling unlock_range(),
>  		 * which clears VM_LOCKED, otherwise the oom reaper cannot
>  		 * reliably test it.
>  		 */
>  		(void)__oom_reap_task_mm(mm);
>  
>  		set_bit(MMF_OOM_SKIP, &mm->flags);

Why do you keep this in place?

Other than that looks OK to me. Maybe we want to add an explicit note
that vm_ops::close cannot take mmap_sem in any form. The changelog
should also mention that you have considered remove_vma and its previous
no MM locking assumption. You can argue that fput is async and close
callback shouldn't really need mmap_sem.
-- 
Michal Hocko
SUSE Labs
