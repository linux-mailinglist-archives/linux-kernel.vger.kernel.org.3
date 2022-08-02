Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1503587882
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiHBH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiHBH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:59:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB330F5E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:59:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x39so11235433lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8MAHi8SKNFAO7ew3d8bZkDJYG24nzfwsdp/alQmmw3o=;
        b=TLafKFi1j6ZG5abx+POI4UU6hvMztSn/a+xozHm8riAtwenoS3L3B8TyEVomx2OnRV
         V60soV+nP4oSzV8Pndt7ujTkQgC9lpM/kBnq12lPXVBvMdSA5rXphd72pWYpf7XlQuNQ
         SW0N2c/sS9mxIeCpJP17Z8Yl9ZMJrUpzk0L+hOc8W+cgXQY3UFqdZDwX7nqTFWk9u4Fl
         lRd1p0S1iNtCMsY8sx9MLevRvCBhSbJdMdPSekygk1BqSkXQoT8+fpNeotnQ4qoMl0LY
         f3P3tvugIE2HDDthiFDRQYOO3HUjJu3JwUS/4WZfUfSen3nWrJAyOSwfYtDykBtuTCax
         JVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8MAHi8SKNFAO7ew3d8bZkDJYG24nzfwsdp/alQmmw3o=;
        b=QEVcJwwZQ3l43OjwijRt4nAPpo/LRZ9fIW3KZdnXhlr2dQNENxuaMqU0IKWQ8j2Ptx
         To9RVT+xUuDpS0CSG9KGscNLrJoEdde/l+BYzRc6FFAFiU1TrkUXfXGr5QfrGu9eOkFP
         lLZxRt1zqlXNg21wfh2SoGyscicJXhtu4t47K4P2qxDIGBrB7QT6n/7p9h2S8Z5gBJP4
         h9Acj8EcXFpU998Gg6mNKOlJlbKzUnx0YS/azNlv/y6Xx+MpQS0LIxuXQA4W1/zEX6kR
         K1XDmz3Puy11RUYTzd45JwM9qNcP5YBLXVmmMwo94YI9r+nrp/fdBiopOWjkpvTojdne
         BNWw==
X-Gm-Message-State: AJIora+5htRw7VARlmC7XLyQWfASnIW1ZqGI/+nqn0ENrkCC9mDy25R3
        Knm+Zw7HO5LpomBystobpa2J/LqTZ/hI2prj9f9i1w==
X-Google-Smtp-Source: AGRyM1u+VI9qRU/DeBhoYuEDm2nN5f2HcRBCLO8lLc3v8j2+ER+Y/OKxkiJIqSFzydlTBN3Tk5nYnlh5RzRwuohL+zE=
X-Received: by 2002:a19:710b:0:b0:48a:cf83:7551 with SMTP id
 m11-20020a19710b000000b0048acf837551mr7412233lfc.137.1659427152271; Tue, 02
 Aug 2022 00:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220727071042.8796-4-feng.tang@intel.com> <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl> <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl> <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <YujWZzctbp1Bq25N@feng-skl>
In-Reply-To: <YujWZzctbp1Bq25N@feng-skl>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Aug 2022 09:59:00 +0200
Message-ID: <CACT4Y+YEtmvR2KOW5P0VtbHatxdY7MT22hp9FrUOyjZiKR+BJw@mail.gmail.com>
Subject: Re: [mm/slub] 3616799128: BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 at 09:47, Feng Tang <feng.tang@intel.com> wrote:
> > > On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > > > On 8/1/22 08:21, Feng Tang wrote:
> > > [snip]
> > > > > Cc kansan  mail list.
> > > > >
> > > > > This is really related with KASAN debug, that in free path, some
> > > > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > > > > kasan to save free meta info.
> > > > >
> > > > > The callstack is:
> > > > >
> > > > >   kfree
> > > > >     slab_free
> > > > >       slab_free_freelist_hook
> > > > >           slab_free_hook
> > > > >             __kasan_slab_free
> > > > >               ____kasan_slab_free
> > > > >                 kasan_set_free_info
> > > > >                   kasan_set_track
> > > > >
> > > > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > > > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > > > > of the slabs will reserve space for alloc_track, and reuse the
> > > > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > > > > large, that it will occupy the whole 'kmalloc-16's object area,
> > > > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > > > > error is triggered.
> > > > >
> > > > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > > > > conflict with kmalloc-redzone which stay in the latter part of
> > > > > kmalloc area.
> > > > >
> > > > > So the solution I can think of is:
> > > > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > > > > * skip kmalloc-redzone if kasan is enabled, or
> > > > > * let kasan reserve the free meta (16 bytes) outside of object
> > > > >   just like for alloc meta
> > > >
> > > > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > > > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > > > __ksize() does.
> > >
> > > How about the following patch:
> > >
> > > ---
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index added2653bb0..33bbac2afaef 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> > >         if (!slub_debug_orig_size(s))
> > >                 return;
> > >
> > > +#ifdef CONFIG_KASAN
> > > +       /*
> > > +        * When kasan is enabled, it could save its free meta data in the
> > > +        * start part of object area, so skip the kmalloc redzone check
> > > +        * for small kmalloc slabs to avoid the data conflict.
> > > +        */
> > > +       if (s->object_size <= 32)
> > > +               orig_size = s->object_size;
> > > +#endif

I think this can be done only when CONFIG_KASAN_GENERIC.
Only CONFIG_KASAN_GENERIC stores free meta info in objects:
https://elixir.bootlin.com/linux/latest/source/mm/kasan/common.c#L176

And KASAN_HW_TAGS has chances of being enabled with DEBUG_SLUB in
real-world uses (with Arm MTE).


> > > +
> > >         p += get_info_end(s);
> > >         p += sizeof(struct track) * 2;
> > >
> > > I extend the size to 32 for potential's kasan meta data size increase.
> > > This is tested locally, if people are OK with it, I can ask for 0Day's
> > > help to verify this.
> >
> > Where is set_orig_size() function defined? Don't see it upstream nor
> > in linux-next.
> > This looks fine but my only concern is that this should not increase
> > memory consumption when slub debug tracking is not enabled, which
> > should be the main operation mode when KASAN is enabled. But I can't
> > figure this out w/o context.
>
> Yes, the patchset was only posted on LKML, and not in any tree now.
> The link to the original patches is:
>
> https://lore.kernel.org/lkml/20220727071042.8796-1-feng.tang@intel.com/t/

Lots of code...

This SLAB_STORE_USER seems to be set on all kmalloc slabs by default
when CONFIG_SLUB_DEBUG is enabled, right?
And KASAN enables CONFIG_SLUB_DEBUG, this means that this is stored
always when KASAN is enabled? Looks wrong.
