Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9647B1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbhLTRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhLTRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:16:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:16:07 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p23so14211290iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5//0K87lk7Jc0WpZqUISoaFtZRXpKHfv2jyt4Plt/w=;
        b=Za2uc0ZjTJ3p7WVdGb4nQkLZieOH7j/VDhp98Z9W+IYUofMP1w/JsWzlLKdizHQnGm
         gUirx1Y05APskSBSeXCdqF5VSvcenrw31YK6F4yr5VBtvfZTezZHObxyLbAdF0EsCPVi
         WrYh4uFoQr7T9bgwA928tLKaHMp2wOCGdDY4da8TJ6EM2tliWSSTPv/Nl1v2MTID7JJh
         u7hwIzAxpmfcSAK2+lmGInyVDf9COj71UBT30VYGVJ2ZbJmwg3cbLCmDhQMIRODY4JZH
         WvKNsLsNAwof/cm38B7oepvXWXJNxl+2rDIG4/RONshtwQ+v8iR8cJYejQ4cbBAU4Lw3
         Bwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5//0K87lk7Jc0WpZqUISoaFtZRXpKHfv2jyt4Plt/w=;
        b=2Jcv7SdossO3A2O9yOHCK0gZCK+9jba+3yqLExE2xdMn75ZFG8zhH5MbseNVwbGno/
         KPZI4HRmm1oRSVLHv4jnt4zyWafhYlKyXNFz4eSU58Az6NZVhK1ZpW19dqNg85EN7mH4
         CWcdvW6fJn88PaBmV6VemmYTGyoRzLencty4FnR+hbhV35IwRLx/zuDzL9yCocqQgFDV
         R0QNQYDm/KTlLSWjmi8LDzsyrpVa+yQMho0Accl4lP/8Dxsq/ECWpo3kD+YyGbI+Hwch
         0M66meaIovnYC5JtGsrECoENl8NKrf4TMAapV92CFpeRj4baja+cOxt8rh5L/Mqxqh7m
         UB5g==
X-Gm-Message-State: AOAM532BZE4do/+HWZQDnfwlQHsPw+9uR4PKpIQ3WwxRQ4fiQPqCK3gj
        qA+Re1z4jw56djUTHVO292ENixgY/PYDGQIgEZ8=
X-Google-Smtp-Source: ABdhPJzYaK1o82lVW6qc2Ewtyf3k01M4kblzuMz0WaRPqu4xRADToqCEQ3NmL5KgB9B9vJw2gUnJ9Z7VCUm+dC7xsv0=
X-Received: by 2002:a02:864b:: with SMTP id e69mr11110608jai.9.1640020566762;
 Mon, 20 Dec 2021 09:16:06 -0800 (PST)
MIME-Version: 1.0
References: <a746b5baebbf79f8160c1fe09d6f8a5ab7bde1d7.1640017993.git.andreyknvl@google.com>
 <CANpmjNP11JKCEE328XomcReP7uBwZ=da=SD5OS09N4co-WPhMQ@mail.gmail.com>
In-Reply-To: <CANpmjNP11JKCEE328XomcReP7uBwZ=da=SD5OS09N4co-WPhMQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 20 Dec 2021 18:15:56 +0100
Message-ID: <CA+fCnZcMWA_VT83dXqD-bFJGG073KWPnULAPYK1=BhQkGsHzUQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix quarantine conflicting with init_on_free
To:     Marco Elver <elver@google.com>
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

On Mon, Dec 20, 2021 at 6:07 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 20 Dec 2021 at 17:37, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > KASAN's quarantine might save its metadata inside freed objects. As
> > this happens after the memory is zeroed by the slab allocator when
> > init_on_free is enabled, the memory coming out of quarantine is not
> > properly zeroed.
> >
> > This causes lib/test_meminit.c tests to fail with Generic KASAN.
> >
> > Zero the metadata when the object is removed from quarantine.
> >
> > Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/kasan/quarantine.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> > index 587da8995f2d..2e50869fd8e2 100644
> > --- a/mm/kasan/quarantine.c
> > +++ b/mm/kasan/quarantine.c
> > @@ -132,11 +132,22 @@ static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
> >  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
> >  {
> >         void *object = qlink_to_object(qlink, cache);
> > +       struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> >         unsigned long flags;
> >
> >         if (IS_ENABLED(CONFIG_SLAB))
> >                 local_irq_save(flags);
> >
> > +       /*
> > +        * If init_on_free is enabled and KASAN's free metadata is stored in
> > +        * the object, zero the metadata. Otherwise, the object's memory will
> > +        * not be properly zeroed, as KASAN saves the metadata after the slab
> > +        * allocator zeroes the object.
> > +        */
> > +       if (slab_want_init_on_free(cache) &&
> > +           cache->kasan_info.free_meta_offset == 0)
> > +               memset(meta, 0, sizeof(*meta));
>
> memzero_explicit()
>
> although in this case it probably doesn't matter much, because AFAIK
> memzero_explicit() only exists to prevent the compiler from eliding
> the zeroing. Up to you.

I've thought about using memzero_explicit(), but the rest of
init_on_alloc/free code uses memset(0) so I decided to use it as well.
If we decide to switch to memzero_explicit(), it makes sense to do it
everywhere.

Thanks!
