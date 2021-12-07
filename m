Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314B346B076
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhLGCLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhLGCLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:11:24 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B133C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:07:54 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t6so13251320qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 18:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3E3HUdI+eXkJ2DLGNVHT3aFUXd0oRXFnf4vYNBfb/7s=;
        b=GyZhu9pq5QcuvZaHzOGbHc9lzxal1FXx6GqwCZgiy/sbOkDR2CVFKWLItdgXaAWpNM
         nmwzwCIMlcYSAQ/EIFU2qIhPgo6ZLMY9cS0d1ann1v0ogRpek3gxwEu4MR22TSX9fHAn
         qbZCJgE0GFdfVevjWc9GRBdzmHl/TQmbxPu/yAP8Kf8+dSE39SgEm1htWZYmEYNTuReY
         8dD2+cd7Mv09QgbHG1kx6K4oYeeS7hZ//L/dKaWy3dvrfz0sHuZmbYKq85HpkkKQhrFb
         l2kgzoy+sgP9xFeIR/qhWd9+300LvFtbpPOp7mmCKT7TQukrt61qKtzi2XPljBVIEbEs
         KFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3E3HUdI+eXkJ2DLGNVHT3aFUXd0oRXFnf4vYNBfb/7s=;
        b=B/UzuRrgfoRZLPAEfOGJ8QmZUL7U5S/b4Ms/Cq3QhMByDs45lEycHeaSSVhB39wBtm
         e3Qtigihl+DWZr3wESdTCk3Ge/AAkDGBFLJ1h6PPdmMsjSTKqrGl91r0IrgZ4J40g6JA
         37OsuwXehpn1CEjbKZ1nw8kf20rIL5EaC930Up5a2nrwQ7U4DC+h7F7GJ3psn/aG5K4p
         5UZFoz3mPEEXN2qlf9eI3vkx1/o1uFN+Y/Pat5ioLVhZDgqIGCmhI3RIao6vZp3PB27H
         RwV1/VEwngV5Z6/N8KiEQxW6CGYm9/PWRjZDBgbMdJv0yUg4UOqR0L+AWam+67vME1Fx
         qbaQ==
X-Gm-Message-State: AOAM5303IHGJsbjcuFcnVIEFzNBoDLzTUIcDMsRN02hOVtFHuAoatUtT
        HVSqt+V6fcfi8NCooKXesdyUhOrKXdf1IrcnQnA=
X-Google-Smtp-Source: ABdhPJyGZ1bIQPiE34mfKYdkDQyZmrkn/MwXL/bBP+fIXydIUNUUerJ1PnqtJGfXgs9FZi2JwwlcjAst7cN98GjrmG8=
X-Received: by 2002:a05:620a:752:: with SMTP id i18mr37590574qki.453.1638842873721;
 Mon, 06 Dec 2021 18:07:53 -0800 (PST)
MIME-Version: 1.0
References: <1638760762-27239-1-git-send-email-huangzhaoyang@gmail.com> <20211206172340.fded3873aed7e853b54ab276@linux-foundation.org>
In-Reply-To: <20211206172340.fded3873aed7e853b54ab276@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 7 Dec 2021 10:07:33 +0800
Message-ID: <CAGWkznGP1_Ycin+KRsY44XesFDuvZA9rCFnc6pd9VJf-AMj9Eg@mail.gmail.com>
Subject: Re: [PATCH] mm: mask DIRECT_RECLAIM in kswapd
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 9:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon,  6 Dec 2021 11:19:22 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > As the eg bellowing, using GFP_KERNEL could confuse the registered .releasepage
> > or .shrinker functions when called in kswapd and have them acting wrongly.Mask
> > __GFP_DIRECT_RECLAIM in kswapd.
> >
> > eg,
> > kswapd
> >   shrink_page_list
> >     try_to_release_page
> >       __fscache_maybe_release_page
> >       ...
> >          if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
> >                  fscache_stat(&fscache_n_store_vmscan_busy);
> >                  return false;
> >          }
>
> Well, we have thus far been permitting kswapd's memory allocations to
> enter direct reclaim.  Forbidding that kernel-wide might be the right
> thing to do, or might not be.  But disabling it kernel-wide because of
> a peculiar hack in fscache is not good justification.
By checking the whole path of kswapd reclaiming, I don't find any
steps need __GFP_DIRECT_RECLAIM but the hooked slab shrinker and fs's
releasepage functions. It doesn't make sense for kswapd be aware of
there is a concurrent direct reclaim.

>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4083,7 +4083,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >       bool boosted;
> >       struct zone *zone;
> >       struct scan_control sc = {
> > -             .gfp_mask = GFP_KERNEL,
> > +             .gfp_mask = GFP_KERNEL & ~__GFP_DIRECT_RECLAIM,
> >               .order = order,
> >               .may_unmap = 1,
> >       };
>
> Maybe hack the hack like this?
>
> --- a/fs/fscache/page.c~a
> +++ a/fs/fscache/page.c
> @@ -126,8 +126,10 @@ page_busy:
>          * sleeping on memory allocation, so we may need to impose a timeout
>          * too. */
>         if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
> -               fscache_stat(&fscache_n_store_vmscan_busy);
> -               return false;
> +               if (!current_is_kswapd()) {
> +                       fscache_stat(&fscache_n_store_vmscan_busy);
> +                       return false;
> +               }
>         }
>
>         fscache_stat(&fscache_n_store_vmscan_wait);
This method works. However, there are several other hook functions as
below using this flag for judging the context. IMHO,
__GFP_DIRECT_RECLAIM just only takes affection for two points. Have
page_alloc_slow_path judging if enter direct_reclaim and the reclaimer
tell the context.

eg.
 xfs_qm_shrink_scan(
...
        if ((sc->gfp_mask & (__GFP_FS|__GFP_DIRECT_RECLAIM)) !=
(__GFP_FS|__GFP_DIRECT_RECLAIM))
                 return 0;

 static int ceph_releasepage(struct page *page, gfp_t gfp)
...
          if (PageFsCache(page)) {
                  if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
                          return 0;

static int afs_releasepage(struct page *page, gfp_t gfp_flags)
...
         if (PageFsCache(page)) {
                 if (!(gfp_flags & __GFP_DIRECT_RECLAIM) ||
!(gfp_flags & __GFP_FS))
                         return false;


> _
>
> But please, do cc the fscache mailing list and maintainer when mucking
> with these things.
