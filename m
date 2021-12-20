Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2F47B202
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhLTRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhLTRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:19:49 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A79C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:19:49 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id t19so16812263oij.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilrvhX4adeXJIaCdTInuQBtNPjTZg76k+bbb32ZDvfA=;
        b=oVrue8OuxpTW/U9MiEZXd206fFvNx2LFKTdAoPLpR04XIqpoRSOCQBDhBDBFg3UTt2
         LP0voOok9+a4GuL3lnP5oOWkacYA1uiCt5ognuYsA47nsQrIGh9ks/+8HshfmQQdU80Y
         KYeX2tZygCz1P7LLQb7wYbcWZGzk53UoHaKda3ZUUIvD8YrEnntY1MZZb4yhHzTwaEvU
         kDFBVffdzS/N12ZkQDfwURwQOPcSKqPwVjpiOrjGzAU9sXSf76qiAjg5ITaDy5gafYyf
         MM/2lYC+JLHSblgK7p2up7gDBiYxxezefd4TXxht7FUgmSLYI/wYmsC/5Wly6J3eTEKK
         vdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilrvhX4adeXJIaCdTInuQBtNPjTZg76k+bbb32ZDvfA=;
        b=w4Uw2YjuxX82FgavoAKq8dSkJqRA8JQVQLdBPlZBLZeMl2NZKm2qzGZQFOdKvVfSJc
         XXNz/3NmlfsG8r6rY925k+Ecy3xW7E92UupFrHfrC5U+MzbdsfblYccT7wpSIDRjNENz
         l/NPievZPQSTWI7zTFxgVdp0tLXxMxHvS/uwbCMFuFaEtRHLwBF8UueO1NG6RyR9t5gG
         fVcs/78Sf6OLcJi3u6Ktvs+GcGW7sPDOB2CwczBTrH6qbBVQ8PvZ8IAtU1jWYIlpd6c2
         f37DgpI5EGb/vp/CQ16PJ/nh67ldeo9ENF+U0PaVN0wmQuAUVvBSixFjCaCzjXO9Pv/s
         WFYA==
X-Gm-Message-State: AOAM532qgNujz8BFmMet4Y4zVIbqjtFuASoaI6Mdkk0la4c48rrDQP4r
        vN2vV9JMszOR8QTK/sJCvqvUFKkY8CKRqeuF8xsQpg==
X-Google-Smtp-Source: ABdhPJzVPHQTSd85vReZAhk5/xhn8anCH0sWrUGKxyOTm4NJlj66RiGLv/9Ir2GntQIPKa0bOfugKOf4tiMhXK9mc8Y=
X-Received: by 2002:aca:af50:: with SMTP id y77mr13111576oie.134.1640020788502;
 Mon, 20 Dec 2021 09:19:48 -0800 (PST)
MIME-Version: 1.0
References: <a746b5baebbf79f8160c1fe09d6f8a5ab7bde1d7.1640017993.git.andreyknvl@google.com>
 <CANpmjNP11JKCEE328XomcReP7uBwZ=da=SD5OS09N4co-WPhMQ@mail.gmail.com> <CA+fCnZcMWA_VT83dXqD-bFJGG073KWPnULAPYK1=BhQkGsHzUQ@mail.gmail.com>
In-Reply-To: <CA+fCnZcMWA_VT83dXqD-bFJGG073KWPnULAPYK1=BhQkGsHzUQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Dec 2021 18:19:37 +0100
Message-ID: <CANpmjNOgBVoUiqK809CsUzo_eb_04+Vh3w1GWxS+VLAh7JBk9w@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix quarantine conflicting with init_on_free
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 18:16, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Dec 20, 2021 at 6:07 PM Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 20 Dec 2021 at 17:37, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > KASAN's quarantine might save its metadata inside freed objects. As
> > > this happens after the memory is zeroed by the slab allocator when
> > > init_on_free is enabled, the memory coming out of quarantine is not
> > > properly zeroed.
> > >
> > > This causes lib/test_meminit.c tests to fail with Generic KASAN.
> > >
> > > Zero the metadata when the object is removed from quarantine.
> > >
> > > Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  mm/kasan/quarantine.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> > > index 587da8995f2d..2e50869fd8e2 100644
> > > --- a/mm/kasan/quarantine.c
> > > +++ b/mm/kasan/quarantine.c
> > > @@ -132,11 +132,22 @@ static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
> > >  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
> > >  {
> > >         void *object = qlink_to_object(qlink, cache);
> > > +       struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> > >         unsigned long flags;
> > >
> > >         if (IS_ENABLED(CONFIG_SLAB))
> > >                 local_irq_save(flags);
> > >
> > > +       /*
> > > +        * If init_on_free is enabled and KASAN's free metadata is stored in
> > > +        * the object, zero the metadata. Otherwise, the object's memory will
> > > +        * not be properly zeroed, as KASAN saves the metadata after the slab
> > > +        * allocator zeroes the object.
> > > +        */
> > > +       if (slab_want_init_on_free(cache) &&
> > > +           cache->kasan_info.free_meta_offset == 0)
> > > +               memset(meta, 0, sizeof(*meta));
> >
> > memzero_explicit()
> >
> > although in this case it probably doesn't matter much, because AFAIK
> > memzero_explicit() only exists to prevent the compiler from eliding
> > the zeroing. Up to you.
>
> I've thought about using memzero_explicit(), but the rest of
> init_on_alloc/free code uses memset(0) so I decided to use it as well.
> If we decide to switch to memzero_explicit(), it makes sense to do it
> everywhere.

memzero_explicit() is newer than those existing memset(0) -- new code
should probably start using it.

So I'd opt for just using it here. Who knows what other optimizations
future compilers may come up with.
