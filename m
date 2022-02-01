Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923C94A63EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiBASdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiBASdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:33:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317E2C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:33:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k25so56529000ejp.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+g6PLOYAprOC0tmznRa4CnfNMzJ64s7o3yrfJR0yNSo=;
        b=HS44/SRDY7S67H6RxAurzppCSFvIh0Osj71xUDW2a5zZUyI5Hcu08OsL0ROVxDaIB3
         Sfqt9b5AE5h9hppkg5CmuzzEkx+Wf2grMT6XsKliabH+p53VeF6sVdYNS0JOPBLQ26G/
         wWv2S3lsXFtbMYZ2ZFM4w85Q59DHtNkZZxKMBQtfEcrn0SWNTugEqY0TXt9/dnYTwcuR
         z8vxI34y9D5oTEiEKfata5fIFYH77RnP02mG0y0UXWvZnbuWDbfy2rFVIFrp97Wj4hGa
         wcXICDS6MN4vWR54c+Ebj1a7awVUnC9FJp8mZlV4Foyv0oCqSnSsY2mGvFUDX7i9gbc5
         2yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+g6PLOYAprOC0tmznRa4CnfNMzJ64s7o3yrfJR0yNSo=;
        b=veMKhCpGi2hLCN6dARCuteGQiHNtiwHl6hmf+CLee+a3jWKGpqpz8VvZ70303SoPBP
         6KWNnLCM1HERrC7dZ1+CcHFVR0C7Uyw49g1dZ5wKv/TMCk1Yj0e8T09GZ2U91AC695Gj
         rCok3Sv90j71r1sbJL4YESe1TM06z8jSrOJlTrrypKzA31mBQdGK5+7dpPBhztykEQ44
         K8r8Gf1IoGxsgj2x4tLd0pcYpcxQV2peL59+0dR3CMFExT1sMidHtk37+OPwNRAXKSGl
         QPSUl+SCMTJxoGXhNG6zVJH8U4cBQXPpQ8EGna9LEk2Q058Y374kFpFWJFf+oBGuX3kg
         rP8w==
X-Gm-Message-State: AOAM530h/2WR4tsoh6EMNKgn+6TdV2g9YjjDTvmnKeHAfTKfsGJf1a9V
        FY9s5tiK/BTyjJ4EwEAk+azVFy6n3XANgDXJy/qtdw==
X-Google-Smtp-Source: ABdhPJx+rHqFGXeIOt8FzMC764v1w59ZK9SMShq4PJIyAXqvaJPsA/e6WPlsIzYqkh1l4VHGFdMUShMVBihsVo6Z5og=
X-Received: by 2002:a17:907:9689:: with SMTP id hd9mr13302667ejc.240.1643740393524;
 Tue, 01 Feb 2022 10:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20220201092927.242254-1-jhubbard@nvidia.com> <CABYd82biLQ7x1zD0MibXMrMHD9Y-cejitbNo=M2=tPNfUMTePA@mail.gmail.com>
In-Reply-To: <CABYd82biLQ7x1zD0MibXMrMHD9Y-cejitbNo=M2=tPNfUMTePA@mail.gmail.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Tue, 1 Feb 2022 10:32:57 -0800
Message-ID: <CABYd82Y3rFUpCpoudxuYHL6YfuXM19hO1g1FWFCQpSZWMo9p8w@mail.gmail.com>
Subject: Re: [PATCH] Revert mm/gup: small refactoring: simplify try_grab_page()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Minchan Kim <minchan@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:00 AM Will McVicker <willmcvicker@google.com> wrote:
>
> On Tue, Feb 1, 2022 at 1:29 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > This reverts commit 54d516b1d62ff8f17cee2da06e5e4706a0d00b8a
> >
> > That commit did a refactoring that effectively combined fast and slow
> > gup paths (again). And that was again incorrect, for two reasons:
> >
> > a) Fast gup and slow gup get reference counts on pages in different ways
> > and with different goals: see Linus' writeup in commit cd1adf1b63a1
> > ("Revert "mm/gup: remove try_get_page(), call try_get_compound_head()
> > directly""), and
> >
> > b) try_grab_compound_head() also has a specific check for "FOLL_LONGTERM
> > && !is_pinned(page)", that assumes that the caller can fall back to slow
> > gup. This resulted in new failures, as recently report by Will McVicker
> > [1].
> >
> > But (a) has problems too, even though they may not have been reported
> > yet. So just revert this.
> >
> > [1] https://lore.kernel.org/r/20220131203504.3458775-1-willmcvicker@google.com
> >
> > Fixes: 54d516b1d62f ("mm/gup: small refactoring: simplify try_grab_page()")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Will McVicker <willmcvicker@google.com>
> > Cc: Minchan Kim <minchan@google.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  mm/gup.c | 35 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 30 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index f0af462ac1e2..a9d4d724aef7 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -124,8 +124,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
> >   * considered failure, and furthermore, a likely bug in the caller, so a warning
> >   * is also emitted.
> >   */
> > -struct page *try_grab_compound_head(struct page *page,
> > -                                   int refs, unsigned int flags)
> > +__maybe_unused struct page *try_grab_compound_head(struct page *page,
> > +                                                  int refs, unsigned int flags)
> >  {
> >         if (flags & FOLL_GET)
> >                 return try_get_compound_head(page, refs);
> > @@ -208,10 +208,35 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
> >   */
> >  bool __must_check try_grab_page(struct page *page, unsigned int flags)
> >  {
> > -       if (!(flags & (FOLL_GET | FOLL_PIN)))
> > -               return true;
> > +       WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
> >
> > -       return try_grab_compound_head(page, 1, flags);
> > +       if (flags & FOLL_GET)
> > +               return try_get_page(page);
> > +       else if (flags & FOLL_PIN) {
> > +               int refs = 1;
> > +
> > +               page = compound_head(page);
> > +
> > +               if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> > +                       return false;
> > +
> > +               if (hpage_pincount_available(page))
> > +                       hpage_pincount_add(page, 1);
> > +               else
> > +                       refs = GUP_PIN_COUNTING_BIAS;
> > +
> > +               /*
> > +                * Similar to try_grab_compound_head(): even if using the
> > +                * hpage_pincount_add/_sub() routines, be sure to
> > +                * *also* increment the normal page refcount field at least
> > +                * once, so that the page really is pinned.
> > +                */
> > +               page_ref_add(page, refs);
> > +
> > +               mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
> > +       }
> > +
> > +       return true;
> >  }
> >
> >  /**
> >
> > base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
> > --
> > 2.35.1
> >
>
> Thanks John! I verified this works on the Pixel 6 with the 5.15 kernel
> for my camera use-case. Free free to include:
>
> Tested-by: Will McVicker <willmcvicker@google.com>
>
> Thanks,
> Will

And just so we don't miss this, I'd also like to request this be
pulled into the 5.15 stable branch please.

Cc: stable@vger.kernel.org # 5.15

Thanks,
Will
