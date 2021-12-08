Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7071B46DBDA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhLHTR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhLHTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:17:27 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A89C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:13:54 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j2so8248202ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHpSZdPvGjFibcYo2hyq0qpLgoBAK/0GYMl9J5pAYXk=;
        b=SI3J2smLo5pi4P8PXJvn0BlCp8/f1/DlXC7ifXSb43vaejCxj1MNSGEqOywfkZifn+
         ACjfyzVDZsJxyw+Q9JVTcnnX3pH99E7bVoyKR/xj5vCS+XuSvky/phPnkeUNEoAbGaxJ
         +usmBE/+Ift3SFtWlUFNP5iaEpxVCc625ck6WAV85hbUx/UrRCcfIO4ilPq59Ol99n2M
         oQfMx0130AWkeiqH0PgJUKzdQW1voVkOVTnvM+0mXnrI7DIMPHCYvdHCA7YCZGibJH4m
         MNeXDITQbGY4FRXglGmrIGCiJCeNJYX6RuyoDBJdZV1YKvjtMYzB21413xa+rz6JPFI/
         o1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHpSZdPvGjFibcYo2hyq0qpLgoBAK/0GYMl9J5pAYXk=;
        b=j7BEWLBvSXFt69EgUthAmVVa/l9A1TAbXrMABT39weO4KFee9OJh0Mv7ybV8NkNTE+
         x6JHWjxtEtKJVI7Szwivs9gVsNjhFcjtflwVeZk2SGjib18RMcxSdcBq2K6T2HMBMAyL
         uiVgK4WHyjmONGZglcfwvJNxqQa0BoQIpR+Q6uuJI5i8RslsLpiPheld6GCfqva1qIBx
         z2637bMQAGtekJtesPjeWqmjn2P4bwwqhW0DiCa6qXGGxRaB3WoqzTW0XfsjUzQ3u6oD
         NP7mzBpUJ8kLUqWD9srlsZjOAc9xbRjKoIxf5Bxh2q74sP4IjeyPcoTeQX0zl09oBLMi
         4KEQ==
X-Gm-Message-State: AOAM531wFFnwRAlfmhdfyx3lXUxqYsv0k2YQ80PvukyS9+laDdKbQf2T
        z2xMgMEiqjzvAeVf4bIqCHZw4eafhCdWqLYamnXHpA==
X-Google-Smtp-Source: ABdhPJy4xEyJ5m2fUmRBORoeE9LrHENymGsIUrRlGBwpVlG/kqo3yXMLOarkqOZjH4gsYIaW6KAky53598Wj6bobri8=
X-Received: by 2002:a25:60d5:: with SMTP id u204mr755449ybb.243.1638990833700;
 Wed, 08 Dec 2021 11:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20211207215031.2251719-1-surenb@google.com> <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
 <YbDIxA92ln+RTbUK@casper.infradead.org> <YbDUnkmQP3nxd5bv@dhcp22.suse.cz>
 <YbDXuegc6BtRzs/5@casper.infradead.org> <CAJuCfpFbF4C8q=40aXcbverm3QFoPzuLgfSU0eT2e7imgp2YfQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFbF4C8q=40aXcbverm3QFoPzuLgfSU0eT2e7imgp2YfQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 8 Dec 2021 11:13:42 -0800
Message-ID: <CAJuCfpF0HHXGotVF7Sjo-b4raQcf8a4ckBto8-EE18n1ovmtXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
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

On Wed, Dec 8, 2021 at 8:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Dec 8, 2021 at 8:05 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 08, 2021 at 04:51:58PM +0100, Michal Hocko wrote:
> > > On Wed 08-12-21 15:01:24, Matthew Wilcox wrote:
> > > > On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > > > > > >         /**
> > > > > > >          * @close: Called when the VMA is being removed from the MM.
> > > > > > >          * Context: Caller holds mmap_lock.
> > > > >
> > > > > BTW, is the caller always required to hold mmap_lock for write or it
> > > > > *might* hold it?
> > > >
> > > > __do_munmap() might hold it for read, thanks to:
> > > >
> > > >         if (downgrade)
> > > >                 mmap_write_downgrade(mm);
> > > >
> > > > Should probably say:
> > > >
> > > >     * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > >
> > > > I don't think we should burden the implementor of the vm_ops with the
> > > > knowledge that the VM chooses to not hold the mmap_lock under certain
> > > > circumstances when it doesn't matter whether it's holding the mmap_lock
> > > > or not.
> > >
> > > If we document it like that some code might depend on that lock to be
> > > held. I think we only want to document that the holder itself is not
> > > allowed to take mmap sem or a depending lock.
> >
> > The only place where we're not currently holding the mmap_lock is at
> > task exit, where the mmap_lock is effectively held because nobody else
> > can modify the task's mm.  Besides, Suren is changing that in this patch
> > series anyway, so it will be always true.
>
> Ok, I'll make it a separate patch after the patch that changes
> exit_mmap and this statement will become always true. Sounds
> reasonable?

Actually, while today vma_ops->close is called with mmap_lock held, I
believe we want this comment to reflect the restrictions on the
callback itself, not on the user. IOW, we want to say that the
callback should not take mmap_lock while the caller might or might not
hold it. If so, I think *might* would make more sense here, like this:

* Context: User context.  May sleep.  Caller might hold mmap_lock.

WDYT?
