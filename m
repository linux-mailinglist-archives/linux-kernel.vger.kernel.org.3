Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D6587784
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiHBHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiHBHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:06:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E20449B40
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:06:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a13so14628637ljr.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6vKqhsUzixhYOBMktOXVTY43Yh0tm2BA/2sZ3OGVl9Q=;
        b=gHKO1or5+vev0QVbmdNrUU3OWjemyPo5ATbnfrhdrg+z5WzYXVlmiVbesXNNH9cm6J
         oNQ0nQJ91NrjdrfG4mTjQZfZtTdkI7nb9GgSwltsvT5oz8ze9yT/3DmZ4xieCeJXG9CK
         OvNJ1ftbi7solG2Uvq2i/Ri3u9Fg4PMurXlf8KJjTxy4s82f1tEX5aNn0CMyLa2mLmdF
         2tbopaFMnfsa8CrGZCURw14BDYsYhJfID/wJdg8PK93GnS6VtfumI3FynONlX8rsbVkU
         mws4og1LhI8BgJO53mu0BDE5wXmqJhgy922KcysQlLcDfVXw8fXiFWgac9U74xKr+Tqi
         5xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6vKqhsUzixhYOBMktOXVTY43Yh0tm2BA/2sZ3OGVl9Q=;
        b=mlvQu/9+YyXxQuZOx7hcgp85LDzT6TKNTlPUNrE/EvvhraozyRRxu9OFeR0ue47vcg
         tODoBCE2IQPnouHxKXI9nHYa1wkD82RPwkkPI9xBStKhkA8LlwCjfdS6U3mJbh6ZtZCZ
         s8xFYct98yI0v8lHI5KoG7ZTkHQbyAp1zkpScWptWm1RkRCbC1wLEIgq6GP1ewTNfG+G
         9ayaRXTTgW7qhEmEWejjxSJLrQBfHX9/+cc3XZAWh7Z3awiA5LqWB1nYa4AricuTJJZQ
         2eTAHUf7kO4MfIr2Mn0iO8+j9jVAADUOCBRvWaxIuOBCAgK7pZmqSUs1edGpH+T56x+4
         9+Xw==
X-Gm-Message-State: AJIora9V2drgQ0oN7xzeEG9oqC7Uj80jpmqzfRx1Z0wwpRcr6OmCyJX1
        axof83NJ1gQwT/t9FuU7nO+mreZxuKC5XCwA/sWrhQ==
X-Google-Smtp-Source: AGRyM1uu3u/qpdrNyzjyshWfnEcQZbwqrLkjhmgmxi3K7JdPl+gexE02YnhZrUSSE34pQK8U85LL+xKybJ55P/G/FpQ=
X-Received: by 2002:a2e:bd0e:0:b0:25a:88b3:9af6 with SMTP id
 n14-20020a2ebd0e000000b0025a88b39af6mr6507869ljq.363.1659424012668; Tue, 02
 Aug 2022 00:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220727071042.8796-4-feng.tang@intel.com> <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl> <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
In-Reply-To: <YujKCxu2lJJFm73P@feng-skl>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Aug 2022 09:06:41 +0200
Message-ID: <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
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

On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
>
> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > On 8/1/22 08:21, Feng Tang wrote:
> [snip]
> > > Cc kansan  mail list.
> > >
> > > This is really related with KASAN debug, that in free path, some
> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > > kasan to save free meta info.
> > >
> > > The callstack is:
> > >
> > >   kfree
> > >     slab_free
> > >       slab_free_freelist_hook
> > >           slab_free_hook
> > >             __kasan_slab_free
> > >               ____kasan_slab_free
> > >                 kasan_set_free_info
> > >                   kasan_set_track
> > >
> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > > of the slabs will reserve space for alloc_track, and reuse the
> > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > > large, that it will occupy the whole 'kmalloc-16's object area,
> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > > error is triggered.
> > >
> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > > conflict with kmalloc-redzone which stay in the latter part of
> > > kmalloc area.
> > >
> > > So the solution I can think of is:
> > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > > * skip kmalloc-redzone if kasan is enabled, or
> > > * let kasan reserve the free meta (16 bytes) outside of object
> > >   just like for alloc meta
> >
> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > __ksize() does.
>
> How about the following patch:
>
> ---
> diff --git a/mm/slub.c b/mm/slub.c
> index added2653bb0..33bbac2afaef 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
>         if (!slub_debug_orig_size(s))
>                 return;
>
> +#ifdef CONFIG_KASAN
> +       /*
> +        * When kasan is enabled, it could save its free meta data in the
> +        * start part of object area, so skip the kmalloc redzone check
> +        * for small kmalloc slabs to avoid the data conflict.
> +        */
> +       if (s->object_size <= 32)
> +               orig_size = s->object_size;
> +#endif
> +
>         p += get_info_end(s);
>         p += sizeof(struct track) * 2;
>
> I extend the size to 32 for potential's kasan meta data size increase.
> This is tested locally, if people are OK with it, I can ask for 0Day's
> help to verify this.

Where is set_orig_size() function defined? Don't see it upstream nor
in linux-next.
This looks fine but my only concern is that this should not increase
memory consumption when slub debug tracking is not enabled, which
should be the main operation mode when KASAN is enabled. But I can't
figure this out w/o context.


> Thanks,
> Feng
>
> >
> > > I don't have way to test kasan's SW/HW tag configuration, which
> > > is only enabled on arm64 now. And I don't know if there will
> > > also be some conflict.
> > >
> > > Thanks,
> > > Feng
> > >
> >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/YujKCxu2lJJFm73P%40feng-skl.
