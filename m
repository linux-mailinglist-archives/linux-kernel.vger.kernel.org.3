Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B4481E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhL3R3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhL3R3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:29:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:29:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id w184so54367497ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHSt4ia9HUMCTnajrSH0I50wrVyu7BkC7WP9xxYyS7k=;
        b=AOm95os7wumcTlCNjGWCKpfopdAzw1OsbSc+dt4WPheXzeGd8PLat3bxu66O6gcjBj
         2g+hWptJKS+CKtxJjX9Fqn/8SbLmbGeL+59ZH80o68wrfyC++pDtbNmDsh8bXk0zpD6d
         isnUP2vMv/Ti8zotAJYNY6PJvJ5Sq8MKNslUnbDyM3ZsXEfDki+4vfPeuzr23dwmQD6P
         z4GbOVABFNv+567EEAlbg9Qatx6WQhXSDMLUWkmdHsAYiXgyMLkQPu/p5jmZ0ee2Fo5l
         4bTlhjLrtqf4qWk62qhR5kn28H/+gYENSX33XjzqavQtZYgjGg6K0rdrI/W0aE0VNIXW
         5Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHSt4ia9HUMCTnajrSH0I50wrVyu7BkC7WP9xxYyS7k=;
        b=uPhsPicCX0iOayTCVKqDtcDzrHqyUhTbn8RMRY7BTXSpGivm4/OwMHaIqLhpxWveIa
         DrjQHb0AOUMogq1IrzuSRFAiBfumkgtq0Yg3xF2P6ZWfTbSGM1fPseQGy3JJxHCzQONr
         j5bQ3/QVUEgtMO/gDyUaFjuzSFndqJtHv3hOjz6Vc6Sq75Tg05rDZqFD3jA6Dt2NiyMT
         X8uXk61JfZFqzCV3QZLgHz4uDo3pzEmp/mxJBWT3Ff0JZ/FSkDuMwpJVq/Oi0e76YRrM
         2tXKkAbuVurbQ6nPPCw9dEZnJC+f5Gjrt8oSFKuBeZKKcAcRSzQ5Ljt2n4vNN6h1a/Ay
         p7iw==
X-Gm-Message-State: AOAM531PC6GmVxzAs3IqCsiIzw3+fsch1bg4TGqDFkTaPeKayX+XMJQR
        K7h33coA6c2X6JziHpnsby6U7G7O4B3b286+BG7Vrw==
X-Google-Smtp-Source: ABdhPJzXnsvrLp/bjUIpiAU8JAapt9I7Y9HTXQGuQGBZNebyOcws9IdTpASUVoie96Vk3fmx1uf8/o8R9e/GZ9v26dM=
X-Received: by 2002:a25:a448:: with SMTP id f66mr39114675ybi.225.1640885391860;
 Thu, 30 Dec 2021 09:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz> <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
 <Ybsn2hJZXRofwuv+@cmpxchg.org> <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
 <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com> <Yc1spBeXal373b4A@dhcp22.suse.cz>
In-Reply-To: <Yc1spBeXal373b4A@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Dec 2021 09:29:40 -0800
Message-ID: <CAJuCfpGNCX=Z=Bi0N7DAj=CXdLqJOqQ_8kq_HQNaLhAvA5tjPw@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 12:24 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 29-12-21 21:59:55, Suren Baghdasaryan wrote:
> [...]
> > After some more digging I think there are two acceptable options:
> >
> > 1. Call unlock_range() under mmap_write_lock and then downgrade it to
> > read lock so that both exit_mmap() and __oom_reap_task_mm() can unmap
> > vmas in parallel like this:
> >
> >     if (mm->locked_vm) {
> >         mmap_write_lock(mm);
> >         unlock_range(mm->mmap, ULONG_MAX);
> >         mmap_write_downgrade(mm);
> >     } else
> >         mmap_read_lock(mm);
> > ...
> >     unmap_vmas(&tlb, vma, 0, -1);
> >     mmap_read_unlock(mm);
> >     mmap_write_lock(mm);
> >     free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > ...
> >     mm->mmap = NULL;
> >     mmap_write_unlock(mm);
> >
> > This way exit_mmap() might block __oom_reap_task_mm() but for a much
> > shorter time during unlock_range() call.
>
> IIRC unlock_range depends on page lock at some stage and that can mean
> this will block for a long time or for ever when the holder of the lock
> depends on a memory allocation. This was the primary problem why the oom
> reaper skips over mlocked vmas.

Oh, I missed that detail. I thought __oom_reap_task_mm() skips locked
vmas only to avoid destroying pgds from under follow_page().

>
> > 2. Introduce another vm_flag mask similar to VM_LOCKED which is set
> > before munlock_vma_pages_range() clears VM_LOCKED so that
> > __oom_reap_task_mm() can identify vmas being unlocked and skip them.
> >
> > Option 1 seems cleaner to me because it keeps the locking pattern
> > around unlock_range() in exit_mmap() consistent with all other places
> > it is used (in mremap() and munmap()) with mmap_write_lock taken.
> > WDYT?
>
> It would be really great to make unlock_range oom reaper aware IMHO.

What exactly do you envision? Say unlock_range() knows that it's
racing with __oom_reap_task_mm() and that calling follow_page() is
unsafe without locking, what should it do?

>
> You do not quote your change in the full length so it is not really
> clear whether you are planning to drop __oom_reap_task_mm from exit_mmap
> as well.

Yes, that was the plan.

> If yes then 1) could push oom reaper to timeout while the
> unlock_range could be dropped on something so that wouldn't be an
> improvement. 2) sounds like a workaround to me as it doesn't really
> address the underlying problem.

With (1) potentially blocking due to allocation I can see why this is a problem.
Agree about (2).

>
> I have to say that I am not really a great fan of __oom_reap_task_mm in
> exit_mmap but I would rather see it in place than making the surrounding
> code more complex/tricky.

Agree. So far I could not find a cleaner solution. I thought (1) would
be a good one but the point you made renders it invalid. If you
clarify your comment about making unlock_range oom reaper aware maybe
that will open a new line of investigation?
Thanks,
Suren.

>
> --
> Michal Hocko
> SUSE Labs
