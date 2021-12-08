Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333D046DD94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhLHV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhLHV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:28:22 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0395FC0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 13:24:49 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f186so9117516ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRcltKRSwj8+Hgiab/NXzKkZSTBvpT+uIZzu90VYzUw=;
        b=MHF8oRkDq7MqMwxef+hlrBfoz7ap+nBunJamOo5PGHFD7hAgEtZEhAnGR2ebrGetCm
         /q24FogDE3nWhGCpbNoiJaLOFDSKFUZaEOEtKvXnYs9LnBz9T7Fm9CN3N/J+ObsbIejW
         bFpSuDHsda5BcnePrAdJ+mm4yAUEQd+XjiKuh/25PZaQwJm7GVOj97C1JhJN5o9f0wFQ
         TPsYGnyDcs/xStKdBQPleuya2PZufte4MaAZvs0ccTt21IMKMaIYsnYsaqt9HfttRNTj
         HUVhGlxR0mJKThSWjiRpWA5w2fOmtajbN5xvIkpIG1NbSTrzsVzmhkc0Uqii0lbOTqQs
         EYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRcltKRSwj8+Hgiab/NXzKkZSTBvpT+uIZzu90VYzUw=;
        b=BT7Ts3ElOSxNWvIcuxbFhLzhSjkgT3BpH7yO5fqRPoI83pCnYH7milhx07gW9lhb9s
         jjzzQLx1+URr/4DlXEz4c0qptyHRluv1nFo9OST0x147GNd+FJuXRDCLxBfDj2vAwJVI
         C8amGt6Itv/DItvtq9C9KJHVJu9bP60eLtM59VJfJpl1B3Uf/9xzkp0pmYvGjzZFVrC+
         C0DYZouLaFhjeH8xRIOHCci5SBDE7Ba1Se2s6ah/MZ4z2Wfj8/xbq9GCFKyDQFXGc2Og
         NiiodYsAjuBg//aRjp+gytWlYBzJy89s+8QeaAvrd+tbEpvYfgmTu7Uv2jFMWDP7cffL
         ZXeQ==
X-Gm-Message-State: AOAM531OK9UlL527R2ybCXzpNWpeG9rsibAvDzHCFhkmThGyXLBQ0m3U
        lvTuZh8twZmyCxWY6CCf8qJKWJCitSYwShUWlWPo9A==
X-Google-Smtp-Source: ABdhPJz365JNROmBZQA3G3UsxqPz1n97Ni+IbdZ1ejWMPWjxWv5B3WyjoYwLQbBHKhZXF2ghfMxDWPO3TvgEjgAKtLs=
X-Received: by 2002:a25:8052:: with SMTP id a18mr1388004ybn.634.1638998688726;
 Wed, 08 Dec 2021 13:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20211207215031.2251719-1-surenb@google.com> <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
 <YbDIxA92ln+RTbUK@casper.infradead.org> <YbDUnkmQP3nxd5bv@dhcp22.suse.cz>
 <YbDXuegc6BtRzs/5@casper.infradead.org> <CAJuCfpFbF4C8q=40aXcbverm3QFoPzuLgfSU0eT2e7imgp2YfQ@mail.gmail.com>
 <CAJuCfpF0HHXGotVF7Sjo-b4raQcf8a4ckBto8-EE18n1ovmtXQ@mail.gmail.com> <YbEF3mvk3SUr6WHp@casper.infradead.org>
In-Reply-To: <YbEF3mvk3SUr6WHp@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 8 Dec 2021 13:24:37 -0800
Message-ID: <CAJuCfpFeKV5Kz-ssEcqDQm_omJz2Q1+Shcpkcbg0vshAha4CAQ@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 11:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 08, 2021 at 11:13:42AM -0800, Suren Baghdasaryan wrote:
> > On Wed, Dec 8, 2021 at 8:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Wed, Dec 8, 2021 at 8:05 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Dec 08, 2021 at 04:51:58PM +0100, Michal Hocko wrote:
> > > > > On Wed 08-12-21 15:01:24, Matthew Wilcox wrote:
> > > > > > On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > > > > > > > >         /**
> > > > > > > > >          * @close: Called when the VMA is being removed from the MM.
> > > > > > > > >          * Context: Caller holds mmap_lock.
> > > > > > >
> > > > > > > BTW, is the caller always required to hold mmap_lock for write or it
> > > > > > > *might* hold it?
> > > > > >
> > > > > > __do_munmap() might hold it for read, thanks to:
> > > > > >
> > > > > >         if (downgrade)
> > > > > >                 mmap_write_downgrade(mm);
> > > > > >
> > > > > > Should probably say:
> > > > > >
> > > > > >     * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > > > >
> > > > > > I don't think we should burden the implementor of the vm_ops with the
> > > > > > knowledge that the VM chooses to not hold the mmap_lock under certain
> > > > > > circumstances when it doesn't matter whether it's holding the mmap_lock
> > > > > > or not.
> > > > >
> > > > > If we document it like that some code might depend on that lock to be
> > > > > held. I think we only want to document that the holder itself is not
> > > > > allowed to take mmap sem or a depending lock.
> > > >
> > > > The only place where we're not currently holding the mmap_lock is at
> > > > task exit, where the mmap_lock is effectively held because nobody else
> > > > can modify the task's mm.  Besides, Suren is changing that in this patch
> > > > series anyway, so it will be always true.
> > >
> > > Ok, I'll make it a separate patch after the patch that changes
> > > exit_mmap and this statement will become always true. Sounds
> > > reasonable?
> >
> > Actually, while today vma_ops->close is called with mmap_lock held, I
> > believe we want this comment to reflect the restrictions on the
> > callback itself, not on the user. IOW, we want to say that the
> > callback should not take mmap_lock while the caller might or might not
> > hold it. If so, I think *might* would make more sense here, like this:
> >
> > * Context: User context.  May sleep.  Caller might hold mmap_lock.
> >
> > WDYT?
>
> We're documenting the contract between the caller and the callee.
> That implies responsibilities on both sides.  For example, we're
> placing requirements on the caller that they're not going to tear
> down the VMA in interrupt context.  So I preferred what previous-Suren
> said to current-Suren, "this statement will become always true".
>

previous-Suren posted v4 at
https://lore.kernel.org/all/20211208212211.2860249-1-surenb@google.com
Thanks!
