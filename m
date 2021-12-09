Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65F46ED02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhLIQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhLIQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:27:51 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6218FC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:24:18 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g17so14802105ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyvL9YX3JikjfEwvnMbTqan/wb4X4wF7RWIiupf6vyc=;
        b=SXpLskh8ID9WUMu48p7COzm7XOWwZSI8zSjw2PIpwtRQ4RFUSbW9OdExgxyesXeWRE
         jHd6QNSTNKTwMsSWh/mk0W2kKLb2uG6Oceccl1H3Z5UTrz+fj3bcLIT47lnk5ZTWpeND
         7Tvd+GgLZf51WHnGpYZVZzYOMyQhBA5WHHXU4PDitEp9/JzC996EphPVHDtjogFWsbis
         7SyPeKmKp1jTVQelWF6zJ1FzOnw7W0lL68MxhVABWCogVu38SKoir6o+aSPgN6vXM7yk
         zP04lpq9+8Unq+BplFEnuh38QPuhx9KRQq8y5yrCnvCYNXz0p24gb9aDCGjjj77c0C51
         D8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyvL9YX3JikjfEwvnMbTqan/wb4X4wF7RWIiupf6vyc=;
        b=HdKxRF2Zba3rfptL2ulTKULfobY7DkV23rJQUZJ01DA7YRICfmox2nl55uTBNDqt8C
         7c63rNwDNGDAh5tAeHcXllvtoqtQ+yWLh+umWKpsy6N5JFxWU3lD1W2TSPS3wu6RL0yX
         6QMAPOF1T7QgVaH1hgF/eN+VMJHlEdT+Qc2+SkXXn9EZVCYHtIHgcs4IoT9D4m8/2xNK
         Ie3inZ5iq88uTDJDy2NRCjeNWy7rNjHG03qp3g+LzNrKT3Pc4sdDsWZTRT/wk8RowpFj
         7tiSCM0B6P/eGJMlC1i+vfET8bzO6Nmpxv4Lr0Z/djrMtpRjgoXd0rDOGFdTbJF/h6uW
         ZshQ==
X-Gm-Message-State: AOAM530Z8cS46ZEqlfVLNUMM3wAnheApptUuXet+PXFJyiSOy1Bxqevj
        UEwnBQ/9DhrjOSBpIq36fHyL5xrSEc08Pm0XPqet+w==
X-Google-Smtp-Source: ABdhPJzNvWXS1A5jCK7LOPHhMdyEnvfuKQORKBnUgVm497593BgIOQDrRAOYzhkTUIOoFvvu5thD/oCRJEDSh3hfWRo=
X-Received: by 2002:a25:6ec5:: with SMTP id j188mr7418743ybc.602.1639067055146;
 Thu, 09 Dec 2021 08:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
In-Reply-To: <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 9 Dec 2021 08:24:04 -0800
Message-ID: <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
>
> Do we want this on top?

As we discussed in this thread
https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
__oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
unmap pages in parallel with exit_mmap without blocking each other.
Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
and has a negative impact on performance. So the conclusion of that
thread I thought was to keep that part. My understanding is that we
also wanted to remove MMF_OOM_SKIP as a follow-up patch but
__oom_reap_task_mm would stay.


> ----
> From 58b04ae6dc97b0105ea2651daca55cf2386f69b4 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 9 Dec 2021 10:07:51 +0100
> Subject: [PATCH] mm: drop MMF_OOM_SKIP from exit_mmap
>
> MMF_OOM_SKIP used to play a synchronization role between exit_mmap and
> oom repear in the past. Since the exclusive mmap_sem is held in
> exit_mmap to cover all destructive operations the flag synchronization
> is not needed anymore and we can safely drop it. Just make sure that
> mm->mmap is set to NULL so that nobody will access the freed vma list.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/mmap.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f4e09d390a07..0d6af9d89aa8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3129,28 +3129,6 @@ void exit_mmap(struct mm_struct *mm)
>         /* mm's last user has gone, and its about to be pulled down */
>         mmu_notifier_release(mm);
>
> -       if (unlikely(mm_is_oom_victim(mm))) {
> -               /*
> -                * Manually reap the mm to free as much memory as possible.
> -                * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -                * this mm from further consideration.  Taking mm->mmap_lock for
> -                * write after setting MMF_OOM_SKIP will guarantee that the oom
> -                * reaper will not run on this mm again after mmap_lock is
> -                * dropped.
> -                *
> -                * Nothing can be holding mm->mmap_lock here and the above call
> -                * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> -                * __oom_reap_task_mm() will not block.
> -                *
> -                * This needs to be done before calling unlock_range(),
> -                * which clears VM_LOCKED, otherwise the oom reaper cannot
> -                * reliably test it.
> -                */
> -               (void)__oom_reap_task_mm(mm);
> -
> -               set_bit(MMF_OOM_SKIP, &mm->flags);
> -       }
> -
>         mmap_write_lock(mm);
>         if (mm->locked_vm)
>                 unlock_range(mm->mmap, ULONG_MAX);
> @@ -3180,6 +3158,7 @@ void exit_mmap(struct mm_struct *mm)
>                 vma = remove_vma(vma);
>                 cond_resched();
>         }
> +       mm->mmap = NULL;
>         mmap_write_unlock(mm);
>         vm_unacct_memory(nr_accounted);
>  }
> --
> 2.30.2
>
> --
> Michal Hocko
> SUSE Labs
