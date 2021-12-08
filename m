Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299546D8E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhLHQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbhLHQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:53:56 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC73C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:50:24 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d10so7532468ybn.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ve3H3qYXxbFpvH5KxZ/byzkUd87jGsC+/Ar5Ml7q30=;
        b=sj7Az99CmVQ4DUjCRt9g+rHD+buRiC6O0WVNPTxVKcsSrw+mBcnKNjBiEP56c+H64j
         XnIJL1jcW5EGxbZhdyStOauRkj7tB1xyNn80RIzKZztPHrd0TU1u1qJLeGf+XI/0+m2E
         NCzjoVGdV4h+PAN6zIUlL3AkYbh6Zkv2Rg5ytnohaMY+P3Y9TOJx0i9q47CAdL/oXw+o
         8kR2dXWx+s3PwuPsEn02++uvvN9lqhgR+RzI92H/RMZNxTBK0OvIg5Zn3YbeKL++13tK
         d9wvXjq3jctGPapogmqM0Pqy2NwQbr24DKwOLoiOV4Rdtq8jMj8Aw3hWjZizGFHwr4fp
         W9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ve3H3qYXxbFpvH5KxZ/byzkUd87jGsC+/Ar5Ml7q30=;
        b=xAmy6LAHA6WSnRcmZQ5yZnhd8jK6AUR2Eow5/JSv7oVZKAeMs/e7J/UDZa+ANi1Nec
         IAgmTC22oGHnMbZU5aX0br/tbBbiI30SQyuErcfONaQp6vw4hDKm2fZgDsHynDDZAxG8
         vcITX+ZhKevo98A8D1WF4/Th0OT1L/vzDpGPta8L/pRXTXeL0F/XnDu5hjqYbM4RRExK
         DQr2z5N/OgZkJPI+PY8j2Rl7udmDJ4xrnKlYoFBy0M59X1QBOiJp8yMeveo2DUj1NCr+
         yGTSlkXt3f+GB6FcF5ao4ahaNyt38zV6W7KvndFP99cAc2ei6uOO68uSeMAFlPSm18jE
         xc2A==
X-Gm-Message-State: AOAM532P2p8o0NK0J7qxS4oOhRr92vegkLisJv2JRMBWcB39iiG1KTHM
        0r1XqBGmxreAyz7+IiFsssUwWw5bfV8b+i3vb6wt9A==
X-Google-Smtp-Source: ABdhPJyzJkw8GbWYdBBxspECp6hxchfurugjZFKEPQaJO73WxSEvj4d2AGV+oaceIRhKYHACXjAn/c3wmZqqo/hetdU=
X-Received: by 2002:a25:6ec5:: with SMTP id j188mr60198733ybc.602.1638982223412;
 Wed, 08 Dec 2021 08:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20211207215031.2251719-1-surenb@google.com> <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
 <YbDIxA92ln+RTbUK@casper.infradead.org> <YbDUnkmQP3nxd5bv@dhcp22.suse.cz> <YbDXuegc6BtRzs/5@casper.infradead.org>
In-Reply-To: <YbDXuegc6BtRzs/5@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 8 Dec 2021 08:50:12 -0800
Message-ID: <CAJuCfpFbF4C8q=40aXcbverm3QFoPzuLgfSU0eT2e7imgp2YfQ@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 8:05 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 08, 2021 at 04:51:58PM +0100, Michal Hocko wrote:
> > On Wed 08-12-21 15:01:24, Matthew Wilcox wrote:
> > > On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > > > > >         /**
> > > > > >          * @close: Called when the VMA is being removed from the MM.
> > > > > >          * Context: Caller holds mmap_lock.
> > > >
> > > > BTW, is the caller always required to hold mmap_lock for write or it
> > > > *might* hold it?
> > >
> > > __do_munmap() might hold it for read, thanks to:
> > >
> > >         if (downgrade)
> > >                 mmap_write_downgrade(mm);
> > >
> > > Should probably say:
> > >
> > >     * Context: User context.  May sleep.  Caller holds mmap_lock.
> > >
> > > I don't think we should burden the implementor of the vm_ops with the
> > > knowledge that the VM chooses to not hold the mmap_lock under certain
> > > circumstances when it doesn't matter whether it's holding the mmap_lock
> > > or not.
> >
> > If we document it like that some code might depend on that lock to be
> > held. I think we only want to document that the holder itself is not
> > allowed to take mmap sem or a depending lock.
>
> The only place where we're not currently holding the mmap_lock is at
> task exit, where the mmap_lock is effectively held because nobody else
> can modify the task's mm.  Besides, Suren is changing that in this patch
> series anyway, so it will be always true.

Ok, I'll make it a separate patch after the patch that changes
exit_mmap and this statement will become always true. Sounds
reasonable?
