Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE4481ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhL3IYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:24:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhL3IYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:24:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B9832110A;
        Thu, 30 Dec 2021 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640852646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JxnSqIMHr+BgE97LBs91W+feMoqDwMqWu8wZ+Ikqz8=;
        b=nrOgplTb19y65LHU5ZKcAb74rZyNL3m/d/IiGmdNF3bUu5YLoTdiB8WbshXkithtc9Zbbs
        LKkAA16B9Hxs/5gXBbvuwsAUz+k21fAqxwsyt+pGcLieNdVMoSIJXap2eDAFB+n7AFWAxI
        p9an3amA8NKF9DIqo8RHr0m4hwhwo6U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99BF0A3B81;
        Thu, 30 Dec 2021 08:24:05 +0000 (UTC)
Date:   Thu, 30 Dec 2021 09:24:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        rientjes@google.com, willy@infradead.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
Message-ID: <Yc1spBeXal373b4A@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
 <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz>
 <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
 <Ybsn2hJZXRofwuv+@cmpxchg.org>
 <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
 <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-12-21 21:59:55, Suren Baghdasaryan wrote:
[...]
> After some more digging I think there are two acceptable options:
> 
> 1. Call unlock_range() under mmap_write_lock and then downgrade it to
> read lock so that both exit_mmap() and __oom_reap_task_mm() can unmap
> vmas in parallel like this:
> 
>     if (mm->locked_vm) {
>         mmap_write_lock(mm);
>         unlock_range(mm->mmap, ULONG_MAX);
>         mmap_write_downgrade(mm);
>     } else
>         mmap_read_lock(mm);
> ...
>     unmap_vmas(&tlb, vma, 0, -1);
>     mmap_read_unlock(mm);
>     mmap_write_lock(mm);
>     free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> ...
>     mm->mmap = NULL;
>     mmap_write_unlock(mm);
> 
> This way exit_mmap() might block __oom_reap_task_mm() but for a much
> shorter time during unlock_range() call.

IIRC unlock_range depends on page lock at some stage and that can mean
this will block for a long time or for ever when the holder of the lock
depends on a memory allocation. This was the primary problem why the oom
reaper skips over mlocked vmas.

> 2. Introduce another vm_flag mask similar to VM_LOCKED which is set
> before munlock_vma_pages_range() clears VM_LOCKED so that
> __oom_reap_task_mm() can identify vmas being unlocked and skip them.
> 
> Option 1 seems cleaner to me because it keeps the locking pattern
> around unlock_range() in exit_mmap() consistent with all other places
> it is used (in mremap() and munmap()) with mmap_write_lock taken.
> WDYT?

It would be really great to make unlock_range oom reaper aware IMHO.

You do not quote your change in the full length so it is not really
clear whether you are planning to drop __oom_reap_task_mm from exit_mmap
as well. If yes then 1) could push oom reaper to timeout while the
unlock_range could be dropped on something so that wouldn't be an
improvement. 2) sounds like a workaround to me as it doesn't really
address the underlying problem.

I have to say that I am not really a great fan of __oom_reap_task_mm in
exit_mmap but I would rather see it in place than making the surrounding
code more complex/tricky.

-- 
Michal Hocko
SUSE Labs
