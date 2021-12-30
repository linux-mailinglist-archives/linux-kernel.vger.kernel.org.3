Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A964819DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhL3GAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhL3GAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:00:09 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A773C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 22:00:08 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i3so54722474ybh.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYXuL9NU5LzCPQzMYGqg0I+VEYjMhL1XTirwxHq3oIg=;
        b=qvnEWfVmgZFESuSi9Qa5PzKpTVCpHJTyk601vUFn+q6W3BeHPHFDqGQvF6k7Neg+fo
         g5Jaf5L+I85IR0SVzqdOXNGwaB8QKZXRTsClCZvasmt27A8I0PTyg0jaYmO84oNC+ZYv
         xi9ZdF7NhLzpaBv3Mqjdp2CaCph9gXbvVG7uIRVBObnE22DvV8uVdE40O/osioddnH5O
         t1I/iwEAWfVUlZLsUsNdRpsE6mVBP53p9KosGs8rLkUtbWIe+fmg8pB7fXelc4RKm0rI
         IbfCuZc3ipvWU7gpfuX1wxaulNm5tpQr2dT6Ae973XsYdhJr437Gf91C+UFEJFssLT8E
         E5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYXuL9NU5LzCPQzMYGqg0I+VEYjMhL1XTirwxHq3oIg=;
        b=QAWGm3z3vtSXcaHtYybAIuHW//ogEZvlyrMJY+/AS1AniWXVOobszwt2u6/CjDHHJS
         sAc1X2smVKqV4PTIIVw3mXDRXww7WJC9C6ESectkWT2G66OIECi37zsBYDVRunECrNvv
         0ZNBzed3ErzVvJFBEbJfFVl3bR9YtNGItCNY0MBxsBWmUIEd4R/5EnYyJ6G8jwQd1cGu
         QbW0SbYSqc7CG4fjpTNqJWAY1yIiIGkwmVn7mRSwklXiBayTZKR/47+ooA4y3ZnlJawu
         LTCtP+H/CRYGkFmD5i6Upqlq+Qgy3uMr6ZMraM3mJSkE9oN4uIJRC0d7w9qq1qRey0pg
         jIFA==
X-Gm-Message-State: AOAM5321JMGx2Q4rEcjyGkoRMJ40k3HLb6UV366A+z2mB/XBwHY+hHKp
        tTc8XdgJ3PPUM62EryAwYZ0Wk4E7t1Z6iN4tdO4zLQ==
X-Google-Smtp-Source: ABdhPJwtlkvMGG8ueFd0I2R6MMvTgca99twHThfkO6dm7IvNHwKGG7bS3ZDFGfryMgKw5iJYgNHLtsEL0sk8IToPhk8=
X-Received: by 2002:a5b:881:: with SMTP id e1mr22171341ybq.602.1640844006794;
 Wed, 29 Dec 2021 22:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz> <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
 <Ybsn2hJZXRofwuv+@cmpxchg.org> <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
In-Reply-To: <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 29 Dec 2021 21:59:55 -0800
Message-ID: <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        rientjes@google.com, willy@infradead.org, guro@fb.com,
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

On Thu, Dec 16, 2021 at 9:23 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Dec 16, 2021 at 3:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Dec 15, 2021 at 06:26:11PM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Dec 9, 2021 at 9:06 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Thu, Dec 9, 2021 at 8:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 09-12-21 08:24:04, Suren Baghdasaryan wrote:
> > > > > > On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > Do we want this on top?
> > > > > >
> > > > > > As we discussed in this thread
> > > > > > https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
> > > > > > __oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
> > > > > > unmap pages in parallel with exit_mmap without blocking each other.
> > > > > > Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
> > > > > > and has a negative impact on performance. So the conclusion of that
> > > > > > thread I thought was to keep that part. My understanding is that we
> > > > > > also wanted to remove MMF_OOM_SKIP as a follow-up patch but
> > > > > > __oom_reap_task_mm would stay.
> > > > >
> > > > > OK, then we were talking past each other, I am afraid. I really wanted
> > > > > to get rid of this oom specific stuff from exit_mmap. It was there out
> > > > > of necessity. With a proper locking we can finally get rid of the crud.
> > > > > As I've said previously oom reaping has never been a hot path.
> > > > >
> > > > > If we really want to optimize this path then I would much rather see a
> > > > > generic solution which would allow to move the write lock down after
> > > > > unmap_vmas. That would require oom reaper to be able to handle mlocked
> > > > > memory.
> > > >
> > > > Ok, let's work on that and when that's done we can get rid of the oom
> > > > stuff in exit_mmap. I'll look into this over the weekend and will
> > > > likely be back with questions.
> > >
> > > As promised, I have a question:
> > > Any particular reason why munlock_vma_pages_range clears VM_LOCKED
> > > before unlocking pages and not after (see:
> > > https://elixir.bootlin.com/linux/latest/source/mm/mlock.c#L424)? Seems
> > > to me if VM_LOCKED was reset at the end (with proper ordering) then
> > > __oom_reap_task_mm would correctly skip VM_LOCKED vmas.
> > > https://lore.kernel.org/lkml/20180514064824.534798031@linuxfoundation.org/
> > > has this explanation:
> > >
> > > "Since munlock_vma_pages_range() depends on clearing VM_LOCKED from
> > > vm_flags before actually doing the munlock to determine if any other
> > > vmas are locking the same memory, the check for VM_LOCKED in the oom
> > > reaper is racy."
> > >
> > > but "to determine if any other vmas are locking the same memory"
> > > explanation eludes me... Any insights?
> >
> > A page's mlock state is determined by whether any of the vmas that map
> > it are mlocked. The munlock code does:
> >
> > vma->vm_flags &= VM_LOCKED_CLEAR_MASK
> > TestClearPageMlocked()
> > isolate_lru_page()
> > __munlock_isolated_page()
> >   page_mlock()
> >     rmap_walk() # for_each_vma()
> >       page_mlock_one()
> >         (vma->vm_flags & VM_LOCKED) && TestSetPageMlocked()
> >
> > If we didn't clear the VM_LOCKED flag first, racing threads could
> > re-lock pages under us because they see that flag and think our vma
> > wants those pages mlocked when we're in the process of munlocking.
>
> Thanks for the explanation Johannes!
> So far I didn't find an easy way to let __oom_reap_task_mm() run
> concurrently with unlock_range(). Will keep exploring.

After some more digging I think there are two acceptable options:

1. Call unlock_range() under mmap_write_lock and then downgrade it to
read lock so that both exit_mmap() and __oom_reap_task_mm() can unmap
vmas in parallel like this:

    if (mm->locked_vm) {
        mmap_write_lock(mm);
        unlock_range(mm->mmap, ULONG_MAX);
        mmap_write_downgrade(mm);
    } else
        mmap_read_lock(mm);
...
    unmap_vmas(&tlb, vma, 0, -1);
    mmap_read_unlock(mm);
    mmap_write_lock(mm);
    free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
...
    mm->mmap = NULL;
    mmap_write_unlock(mm);

This way exit_mmap() might block __oom_reap_task_mm() but for a much
shorter time during unlock_range() call.

2. Introduce another vm_flag mask similar to VM_LOCKED which is set
before munlock_vma_pages_range() clears VM_LOCKED so that
__oom_reap_task_mm() can identify vmas being unlocked and skip them.

Option 1 seems cleaner to me because it keeps the locking pattern
around unlock_range() in exit_mmap() consistent with all other places
it is used (in mremap() and munmap()) with mmap_write_lock taken.
WDYT?

> >
