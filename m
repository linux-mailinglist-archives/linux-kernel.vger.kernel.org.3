Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D957589A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiHDKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:48:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9211D3DF2D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:48:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x39so20633710lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eegZBp28eQmH3OhuZfCVY16Y84OTpGQZtSHItuJdUI0=;
        b=LBXwMho0naCRAn0uLfy0/shvSkniUOYXZOse7ecIpBosuFqQK30HwYCSpjmed5m1Pk
         Beav35IYNT0r0MaaEh2ir6p3mNW6An4tqXR2sHJRK3H08h8vmfVuWqUvxjLUX/9k86ot
         kGq34sHJN/VRKF/73MVN+s1qgZrppUjyfw1yURt2rMc4BiiWNLgF6Z7RkKK7gLXEprwm
         RuXbEOsS+Q/ZAtzLeNAs4BRCcynwrYWZl8c1lzRBg+SVa4aoV8mecs4nC9pALmcnWRnk
         poVgCteiyEPAnaAUPBjznLxxQF/eLppVvXHF5Vi+kEARnKrwsil3QpqXTrykjI9V6KZB
         usnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eegZBp28eQmH3OhuZfCVY16Y84OTpGQZtSHItuJdUI0=;
        b=C1iew6188m0lzN71XVqspbGElYGKsE/xXV9Ui9D0vmjHNrpfr9m7QMuQ8DqryA9GY1
         IkD4Brz1s5OgYZLc5CCxvG+VTVCbza96+tWw3sOrRXfZiUCOxF+CiJ+WewaIL+Oo5Hb4
         Lkd6vnnPS/RhihJTaTQLKFXdaOeR16XPi+Z3Uf2vmXkqMGu7ZaxWHTIV7zD+tqxTRAFT
         WJ4H+Bw53nOEqedpI2Xu2GzYUuu4pdtDyO2lYo6iKyVwJphkBFpAxzWXFo7v3s3Ijzth
         srk/qFtIBjPUDFUwTRSYW6H0nXoIXcki4BI2zVmWKASf1InF8PbxKciYowpmzr18iIjQ
         zgqg==
X-Gm-Message-State: ACgBeo36A6s0gZBuhjwlbutgGdcmAXstlwQCPZR1MshYlhUfRPJAmsqY
        7SLUCJ0bjwD0CKvqO6FLTszCmxrMwNsmyNgYaGnJYA==
X-Google-Smtp-Source: AA6agR4sbvFnha5ksT3ZlL3sUCWj6dLhquYwtG8AA19v9az2AcMHq+TuC0J8RgPecOYrD2Xa9R5XGidkqyspyIZE0PM=
X-Received: by 2002:a05:6512:1086:b0:48b:27a4:5059 with SMTP id
 j6-20020a056512108600b0048b27a45059mr492779lfg.540.1659610090741; Thu, 04 Aug
 2022 03:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020> <YuY6Wc39DbL3YmGi@feng-skl>
 <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl> <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz> <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
 <YukoZEm4Q6CSEKKj@feng-skl> <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
 <YutnCD5dPie/yoIk@feng-clx>
In-Reply-To: <YutnCD5dPie/yoIk@feng-clx>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Aug 2022 12:47:58 +0200
Message-ID: <CACT4Y+Zzzj7+LwUwyMoBketXFBHRksnx148B1aLATZ48AU9o3w@mail.gmail.com>
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

 On Thu, 4 Aug 2022 at 08:29, Feng Tang <feng.tang@intel.com> wrote:
> > > > .On Tue, 2 Aug 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > >
> > > > > On 8/2/22 09:06, Dmitry Vyukov wrote:
> > > > > > On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
> > > > > >>
> > > > > >> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > > > > >> > On 8/1/22 08:21, Feng Tang wrote:
> > > > > >> [snip]
> > > > > >> > > Cc kansan  mail list.
> > > > > >> > >
> > > > > >> > > This is really related with KASAN debug, that in free path, some
> > > > > >> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > > > > >> > > kasan to save free meta info.
> > > > > >> > >
> > > > > >> > > The callstack is:
> > > > > >> > >
> > > > > >> > >   kfree
> > > > > >> > >     slab_free
> > > > > >> > >       slab_free_freelist_hook
> > > > > >> > >           slab_free_hook
> > > > > >> > >             __kasan_slab_free
> > > > > >> > >               ____kasan_slab_free
> > > > > >> > >                 kasan_set_free_info
> > > > > >> > >                   kasan_set_track
> > > > > >> > >
> > > > > >> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > > > > >> > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > > > > >> > > of the slabs will reserve space for alloc_track, and reuse the
> > > > > >> > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > > > > >> > > large, that it will occupy the whole 'kmalloc-16's object area,
> > > > > >> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > > > > >> > > error is triggered.
> > > > > >> > >
> > > > > >> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > > > > >> > > conflict with kmalloc-redzone which stay in the latter part of
> > > > > >> > > kmalloc area.
> > > > > >> > >
> > > > > >> > > So the solution I can think of is:
> > > > > >> > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > > > > >> > > * skip kmalloc-redzone if kasan is enabled, or
> > > > > >> > > * let kasan reserve the free meta (16 bytes) outside of object
> > > > > >> > >   just like for alloc meta
> > > > > >> >
> > > > > >> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > > > > >> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > > > > >> > __ksize() does.
> > > > > >>
> > > > > >> How about the following patch:
> > > > > >>
> > > > > >> ---
> > > > > >> diff --git a/mm/slub.c b/mm/slub.c
> > > > > >> index added2653bb0..33bbac2afaef 100644
> > > > > >> --- a/mm/slub.c
> > > > > >> +++ b/mm/slub.c
> > > > > >> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> > > > > >>         if (!slub_debug_orig_size(s))
> > > > > >>                 return;
> > > > > >>
> > > > > >> +#ifdef CONFIG_KASAN
> > > > > >> +       /*
> > > > > >> +        * When kasan is enabled, it could save its free meta data in the
> > > > > >> +        * start part of object area, so skip the kmalloc redzone check
> > > > > >> +        * for small kmalloc slabs to avoid the data conflict.
> > > > > >> +        */
> > > > > >> +       if (s->object_size <= 32)
> > > > > >> +               orig_size = s->object_size;
> > > > > >> +#endif
> > > > > >> +
> > > > > >>         p += get_info_end(s);
> > > > > >>         p += sizeof(struct track) * 2;
> > > > > >>
> > > > > >> I extend the size to 32 for potential's kasan meta data size increase.
> > > > > >> This is tested locally, if people are OK with it, I can ask for 0Day's
> > > > > >> help to verify this.
> > > > >
> > > > > Is there maybe some KASAN macro we can use instead of hardcoding 32?
> > > >
> > > > kasan_free_meta is placed in the object data after freeing, so it can
> > > > be sizeof(kasan_free_meta)
> > >
> > > 'kasan_free_meta' is defined in mm/kasan/kasan.h, to use it we need to
> > > include "../kasan/kasan.h" in slub.c, or move its definition to
> > > "include/linux/kasan.h"
> > >
> > > Another idea is to save the info in kasan_info, like:
> > >
> > > ---
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index b092277bf48d..97e899948d0b 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -100,6 +100,7 @@ static inline bool kasan_has_integrated_init(void)
> > >  struct kasan_cache {
> > >         int alloc_meta_offset;
> > >         int free_meta_offset;
> > > +       int free_meta_size;
> >
> > Storing it here looks fine to me.
> > But I would name it based on the meaning for external users (i.e. that
> > many bytes are occupied by kasan in freed objects). For some caches
> > KASAN does not store anything in freed objects at all.
>
> OK, please review the below patch, thanks!
>
> - Feng
>
> ---8<---
> From c4fc739ea4d5222f0aba4b42b59668d64a010082 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Thu, 4 Aug 2022 13:25:35 +0800
> Subject: [PATCH] mm: kasan: Add free_meta size info in struct kasan_cache
>
> When kasan is enabled for slab/slub, it may save kasan' free_meta
> data in the former part of slab object data area in slab object
> free path, which works fine.
>
> There is ongoing effort to extend slub's debug function which will
> redzone the latter part of kmalloc object area, and when both of
> the debug are enabled, there is possible conflict, especially when
> the kmalloc object has small size, as caught by 0Day bot [1]
>
> For better information for slab/slub, add free_meta's data size
> info 'kasan_cache', so that its users can take right action to
> avoid data conflict.
>
> [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

I assume there will be a second patch that uses
free_meta_size_in_object  in slub debug code.

> ---
>  include/linux/kasan.h | 2 ++
>  mm/kasan/common.c     | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b092277bf48d..293bdaa0ba09 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
>  struct kasan_cache {
>         int alloc_meta_offset;
>         int free_meta_offset;
> +       /* size of free_meta data saved in object's data area */
> +       int free_meta_size_in_object;
>         bool is_kmalloc;
>  };
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 78be2beb7453..a627efa267d1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
>                         *size = ok_size;
>                 }
> +       } else {
> +               cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
>         }
>
>         /* Calculate size with optimal redzone. */
> --
> 2.27.0
