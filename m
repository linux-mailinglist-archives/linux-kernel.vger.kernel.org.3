Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AAE46C801
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbhLGXMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhLGXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:12:02 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD450C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:08:31 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id f9so1553837ybq.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRGAev7E9rKsBfzE8rVm/cgWBvl8Wsl3a2S3zf5VBy8=;
        b=PPRJZURpqVRgSTfc7Nr8cFealNWVTbNpUySCqBM3oRRkKcetpG7iiI0K+M8+mjImhX
         pKwU1baysS3T+YERbd4QWVcOzuxXYZVvhlkKpvpiCUBh70uNfNZXNembGCh7Sb/lfWZk
         p/V6bPhCsWli62X6CvipyjsvTcNrH/j7tFhpP5ab0i0Y9VzjMDvArx0SOQF/rXVihgtg
         Iw6uoNqJaw+7hJaTGCBktS7PFfHaycv053JtM9c6Trkrw5RaBbnQf7Ssk5fiySnxRe5p
         x4vU9RWx3tvrEhPFChpDWZuTesmwul3bYhwW2m1M6Y10aUGkmSDlJ0Lf2XDkY01aQWYk
         ZisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRGAev7E9rKsBfzE8rVm/cgWBvl8Wsl3a2S3zf5VBy8=;
        b=vFB+Mh57Rj0vQ4Cb+QptTYgJcRRo1ZAFGtFaB3L8YOq4OYTDWKNM7X8HvdzwxkE9s3
         24AurN/fum3mTFf4p9zdddN7QjOC719VFWh9yhh4toLdfzhwr9D+Jg4/pz27XUjZlwjS
         8Ifp3qwvFED2Zp4dqqchABYyRDFzMjWbz+HH5wPen+yhW71TU60bv+cEaFdwQ6azMCSI
         mBiIJRjLV6oOTG7uuFjdxWfa+alnKut35E8V8Zvr+ayH399YNxIHNa9RGQQFDeKUSh2c
         TP5CtknTiWlQo9KTLlJ37ilJsXZzDostLM9N5LTffbcsB93TjW8sQs9zjsVyj1fiyfaB
         LUGg==
X-Gm-Message-State: AOAM530cuOgOfg0H8DB6mpNdP6wgosc5mDq6eBiGQgdsMvflLttzUOJ4
        Z20JMZ9c8lzZJZ371nQZTOofhEoqg0SsIwYVwEwAIA==
X-Google-Smtp-Source: ABdhPJwjSdFUsVfx4V7nDizmuk5wveIpt2khnP4YDL+B5L668iwYp4izqrQpnK2K1m9hL8AMW8lzgybGsJybQpjQsfw=
X-Received: by 2002:a25:6ec5:: with SMTP id j188mr54674582ybc.602.1638918510741;
 Tue, 07 Dec 2021 15:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20211207215031.2251719-1-surenb@google.com> <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
In-Reply-To: <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 Dec 2021 15:08:19 -0800
Message-ID: <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
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

On Tue, Dec 7, 2021 at 2:47 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Dec 7, 2021 at 2:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Dec 07, 2021 at 01:50:30PM -0800, Suren Baghdasaryan wrote:
> > > - Added a comment for vm_operations_struct::close, documenting restriction for
> > > taking mmap_lock in the callback, per Michal Hocko and Matthew Wilcox
> >
> > This should be a separate patch because it stands alone, but ...
>
> I thought about it and since it was relevant to the change in
> remove_vma locking, I thought it would fit here. However, if you
> insist on splitting it, I'll post it as a separate patch. Please let
> me know.
>
> >
> > >  struct vm_operations_struct {
> > >       void (*open)(struct vm_area_struct * area);
> > > +    /*
> > > +     * Called with mmap_lock lock held for write from __split_vma and
> > > +     * remove_vma, therefore should never take that lock.
> > > +     */
> >
> > Your whitespace indentation is weird.  And it'd be nice to make this a
> > kernel-doc comment (I know none of the others are, but that should be
> > fixed too).  And naming the functions that call it is wrong too.
> >
> >         /**
> >          * @close: Called when the VMA is being removed from the MM.
> >          * Context: Caller holds mmap_lock.

BTW, is the caller always required to hold mmap_lock for write or it
*might* hold it?

> >          */
>
> Ack. Will change and include in the next respin once I hear from you
> on the preference for a separate patch.
> Thanks!
