Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B446C7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbhLGWvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbhLGWvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:51:21 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F81C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:47:50 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y68so1574054ybe.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NAkzEae8rEjb3+qLzjOqDzzWbipCWVNMZSADlSEB3Q=;
        b=S04noigKvm8Bjv2Uuade/bYbL4T/MVHndJwYOjZ3diQDchiFeIXkh/Iv2Z1VZlOuvZ
         RWj5PYIBWCKL6LHqeqTdlvxYS22x+umwjKY9t4bJOB/W0wItoZFsFyzmfr18B0e8A/IN
         WdPsNY1kVGF9BdFgrqEFLFehj2kpwpv4O/iCTeCppXEzMaq8J0gSyKP+WYGoa55yp5xC
         D0tsGee/O+QhIqKBcc+odXWzIkI27p/d4q662FazlTrTvDyISuaEWdGHpjDQQCzjxE2a
         D3u+qDxoHRpTw/44WHLSpKXzFYIXcsC0AQ7cCZoSS2XvbDXbYRExGIjDpRNzDrhnloip
         ixWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NAkzEae8rEjb3+qLzjOqDzzWbipCWVNMZSADlSEB3Q=;
        b=uRBnppupEOkZXFEioqSHvJJODNnEoVptA8VeJYPsgNEAVZHhjyMxGAuByJ3I7j6rwH
         sK5nKeZlP0OKQheCXO5O8OKLLODPkc+p4WzRaiz+bMdu9JkTtGEfJh3f7BPjYkOKSPK6
         +TIGJf9pgJXrlXUfZvf/5sNHmKXFvhM+dT/c2ShN9lg5VJwUxM/U56yv9vaBPfNSmjKM
         YtmiScVKPgqn6F2gUi8PDHW2uRF2P30OIEM+iqx5WigJRf0KwNaHwzHoUhUw4jwz4qAH
         N66IVimEPNeMHaKbnZa0EdZwC865nJtoTvHkxuY9IleU7WZ3QwfOLBQRvUFwWoZnxmHo
         vPGQ==
X-Gm-Message-State: AOAM5301/KZCfUcnCec4al9t8LiEoSGUTStirKMqKn8fXxUB4xh5V6Ck
        OxMjoLqCvJYkDuU3PBtXOq1CHvPgI8AnO0Bsk08TwA==
X-Google-Smtp-Source: ABdhPJwHXgvCbDWxObMUDnD4Qr1CbTS9DPYT7YO9TngI6OrrX3PAZgBH08VONCFBFB/9/m7DVGqVCEGiJV9S2IF2MEw=
X-Received: by 2002:a25:60d5:: with SMTP id u204mr58688606ybb.243.1638917269910;
 Tue, 07 Dec 2021 14:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20211207215031.2251719-1-surenb@google.com> <Ya/bFLcnqyvlVzuO@casper.infradead.org>
In-Reply-To: <Ya/bFLcnqyvlVzuO@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 Dec 2021 14:47:38 -0800
Message-ID: <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 2:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 07, 2021 at 01:50:30PM -0800, Suren Baghdasaryan wrote:
> > - Added a comment for vm_operations_struct::close, documenting restriction for
> > taking mmap_lock in the callback, per Michal Hocko and Matthew Wilcox
>
> This should be a separate patch because it stands alone, but ...

I thought about it and since it was relevant to the change in
remove_vma locking, I thought it would fit here. However, if you
insist on splitting it, I'll post it as a separate patch. Please let
me know.

>
> >  struct vm_operations_struct {
> >       void (*open)(struct vm_area_struct * area);
> > +    /*
> > +     * Called with mmap_lock lock held for write from __split_vma and
> > +     * remove_vma, therefore should never take that lock.
> > +     */
>
> Your whitespace indentation is weird.  And it'd be nice to make this a
> kernel-doc comment (I know none of the others are, but that should be
> fixed too).  And naming the functions that call it is wrong too.
>
>         /**
>          * @close: Called when the VMA is being removed from the MM.
>          * Context: Caller holds mmap_lock.
>          */

Ack. Will change and include in the next respin once I hear from you
on the preference for a separate patch.
Thanks!
