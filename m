Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1388C477A75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhLPRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbhLPRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:23:24 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:23:24 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d10so66574481ybn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOfddnRBlgrRNJUcJFAYmMl+H47vzBbmtc2FFUjJ1No=;
        b=Yc6wnk82blHZiFBHSFBOZCsbU33ZtmS7OnOP25JEBdLn3pzapUEBPO+ZR+Y5w481i/
         l3Mmya+tO61fJof7XmePit0QMOfUw9bYKVhdflL8+bklYF2rpvn1RMBuLjK34LYSximm
         6+pmof4aUNAinh1CzukO8E4JXiOvIGWxrcU95SWQh1J2wb0fPhVkUNl1Ncc8+eW2crWJ
         /5rRohpENH/kVlLx6PGD3yaPGL1SL712hbmhi8FTZoWjUd8SrSqLphfCnRfb0oPmdhZg
         mL3uvNQRTYEocGJ+kUyNoDRh0G1qL+I9M8d758aBElqO0hsZo0a699PSJLYwxq+CQ7HA
         HlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOfddnRBlgrRNJUcJFAYmMl+H47vzBbmtc2FFUjJ1No=;
        b=ErwVUTE7Sbf+5Jj1HVDskbR+v5APtlh9kIeRIz4B/9saSmFKF0dRSiyZmm00oEnTrz
         gxa0HVYT+T7AjbYop9kEGdgnpl0+U2K+p7/sTE4tJYbwAoRVemkcPOGndNn3pgK726ft
         hkZI3VM40aMWgNF0KVUMqpR6419XaqnGLs6atBmKExtPiz4TE6hR395/yp1FXcm6nXa+
         Jos/+bdvJEQ4aPScNgpGdnYOiVRHnrr8NCVlk4OHcrrBo8zGNW6tjcswfbcM3bN7qn2T
         K6yZIyxroh4J6l9u5ombg7YnSPUv1HRAc38XYMr8gVvTiiuApLUQg/cHYpgHSqHzoJtY
         RGXA==
X-Gm-Message-State: AOAM531HG0AmrH9yHjQArPiRIMFjgHDqySsaUILtEmk5R2mAQ1vhpfkB
        Pvhp34BYVdOcGWd4RugIgv1Fss/7ZKZ0HMnmK4W9Zg==
X-Google-Smtp-Source: ABdhPJwWv5HgWT/NNBKfZuIQk87EsF7CJpgNK4d7YTR8OVigJcUEq9iqCvp4TdlUeADUbnwvUnXcZWCoCH0NCwZ7+uM=
X-Received: by 2002:a25:a448:: with SMTP id f66mr14255921ybi.225.1639675403013;
 Thu, 16 Dec 2021 09:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz> <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com> <Ybsn2hJZXRofwuv+@cmpxchg.org>
In-Reply-To: <Ybsn2hJZXRofwuv+@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 16 Dec 2021 09:23:12 -0800
Message-ID: <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
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

On Thu, Dec 16, 2021 at 3:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Dec 15, 2021 at 06:26:11PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Dec 9, 2021 at 9:06 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Dec 9, 2021 at 8:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 09-12-21 08:24:04, Suren Baghdasaryan wrote:
> > > > > On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > Do we want this on top?
> > > > >
> > > > > As we discussed in this thread
> > > > > https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
> > > > > __oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
> > > > > unmap pages in parallel with exit_mmap without blocking each other.
> > > > > Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
> > > > > and has a negative impact on performance. So the conclusion of that
> > > > > thread I thought was to keep that part. My understanding is that we
> > > > > also wanted to remove MMF_OOM_SKIP as a follow-up patch but
> > > > > __oom_reap_task_mm would stay.
> > > >
> > > > OK, then we were talking past each other, I am afraid. I really wanted
> > > > to get rid of this oom specific stuff from exit_mmap. It was there out
> > > > of necessity. With a proper locking we can finally get rid of the crud.
> > > > As I've said previously oom reaping has never been a hot path.
> > > >
> > > > If we really want to optimize this path then I would much rather see a
> > > > generic solution which would allow to move the write lock down after
> > > > unmap_vmas. That would require oom reaper to be able to handle mlocked
> > > > memory.
> > >
> > > Ok, let's work on that and when that's done we can get rid of the oom
> > > stuff in exit_mmap. I'll look into this over the weekend and will
> > > likely be back with questions.
> >
> > As promised, I have a question:
> > Any particular reason why munlock_vma_pages_range clears VM_LOCKED
> > before unlocking pages and not after (see:
> > https://elixir.bootlin.com/linux/latest/source/mm/mlock.c#L424)? Seems
> > to me if VM_LOCKED was reset at the end (with proper ordering) then
> > __oom_reap_task_mm would correctly skip VM_LOCKED vmas.
> > https://lore.kernel.org/lkml/20180514064824.534798031@linuxfoundation.org/
> > has this explanation:
> >
> > "Since munlock_vma_pages_range() depends on clearing VM_LOCKED from
> > vm_flags before actually doing the munlock to determine if any other
> > vmas are locking the same memory, the check for VM_LOCKED in the oom
> > reaper is racy."
> >
> > but "to determine if any other vmas are locking the same memory"
> > explanation eludes me... Any insights?
>
> A page's mlock state is determined by whether any of the vmas that map
> it are mlocked. The munlock code does:
>
> vma->vm_flags &= VM_LOCKED_CLEAR_MASK
> TestClearPageMlocked()
> isolate_lru_page()
> __munlock_isolated_page()
>   page_mlock()
>     rmap_walk() # for_each_vma()
>       page_mlock_one()
>         (vma->vm_flags & VM_LOCKED) && TestSetPageMlocked()
>
> If we didn't clear the VM_LOCKED flag first, racing threads could
> re-lock pages under us because they see that flag and think our vma
> wants those pages mlocked when we're in the process of munlocking.

Thanks for the explanation Johannes!
So far I didn't find an easy way to let __oom_reap_task_mm() run
concurrently with unlock_range(). Will keep exploring.

>
