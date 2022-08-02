Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B62587AC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiHBKcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHBKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:32:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FBB7F8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:31:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y11so21278468lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RK5pl1uOPXDiR845YvQnUJkdblCt/aXef4YDWk2HeBk=;
        b=o4RrJRr+Z0jIzZctF2ECoxc11CfkNv1Y8zs7NQzU1+hgHcqRXLDuZYZmqMDvZyUiMg
         TzveH8iptIT0viRfIq43c2rckHoMtr+GedEHil0bl6khFHuyKGojuUk1TCI/Yva9w2Sv
         o+x5ogr792yGen/pdhDNSn3zhmIBTUS22+1oXvV1sbLDhk92Mq5xISAnjjZCHWlteCjm
         8TeoYkJfqz2Si9ndvlXt+3gPSfN5P4myJThxPia1Swna3B4HC8CPHxYnLrtIMe/ep33p
         oM0wHB8LVtqQ1/UNp0TCHG4bM4FD8m0K8TWsrS2qN6UB9fB9Ftpx2r/9SmOl6uxR0sit
         qJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RK5pl1uOPXDiR845YvQnUJkdblCt/aXef4YDWk2HeBk=;
        b=fvBortLcnfXhB9wOjHxsegu+XxDP8n6D1l/X0+YOTwpJWjizPZ2fMriBOhMTku0CVM
         41H4yqSTR8NjPWehWj4AS0qROKJfUfiekFxxywrBNQG0hNtBkzb2mUt8m2fpHs8mYY8K
         x2etkbo+SMV6K4oRqbQlenNWrM10PFgVdkoMks/B+fT2NG0gQH6xHrAAQHbwhnHuE140
         DPw8kPj9ZzFv1QRWlVT63IMZ5lM8c71pVboVlIccWzEtVDZcjp1zEJ4aHwp+xFycM3ds
         lZlC6nk+EPP2bC6UO9h/P/ApTkgFuDufchZ9JDCflZdIR3Bn/leIBpQLKfy7TtpYswRF
         UrBQ==
X-Gm-Message-State: ACgBeo0a4ntpCMV7RgCgFQjPQTU/Al+SCWRQqE7EHwmKIPrMxJeZ9x1X
        Vdxy0UknEwNUPaA3iCFKIbrRZTACKRoafpUyrh4JCg==
X-Google-Smtp-Source: AA6agR4JTi1SGOCRCQBlGoHqwl+CtgH81YnRiaG0Rdref3rfjrKkl7QMXeQprYAUNPAz3oPSUq6idzM/e98+6vEkwLU=
X-Received: by 2002:a05:6512:1095:b0:48a:f9b5:a566 with SMTP id
 j21-20020a056512109500b0048af9b5a566mr2864785lfg.540.1659436314088; Tue, 02
 Aug 2022 03:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220727071042.8796-4-feng.tang@intel.com> <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl> <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl> <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
In-Reply-To: <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Aug 2022 12:31:42 +0200
Message-ID: <CACT4Y+aJOLZpdHhYLQEwzmUkLTCDSQWDqs3wN_J_ZcTouGqO=A@mail.gmail.com>
Subject: Re: [mm/slub] 3616799128: BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Feng Tang <feng.tang@intel.com>,
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

On Tue, 2 Aug 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 8/2/22 09:06, Dmitry Vyukov wrote:
> > On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
> >>
> >> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> >> > On 8/1/22 08:21, Feng Tang wrote:
> >> [snip]
> >> > > Cc kansan  mail list.
> >> > >
> >> > > This is really related with KASAN debug, that in free path, some
> >> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> >> > > kasan to save free meta info.
> >> > >
> >> > > The callstack is:
> >> > >
> >> > >   kfree
> >> > >     slab_free
> >> > >       slab_free_freelist_hook
> >> > >           slab_free_hook
> >> > >             __kasan_slab_free
> >> > >               ____kasan_slab_free
> >> > >                 kasan_set_free_info
> >> > >                   kasan_set_track
> >> > >
> >> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> >> > > tracks: alloc_track and free_track, for x86_64 test platform, most
> >> > > of the slabs will reserve space for alloc_track, and reuse the
> >> > > 'object' area for free_track.  The kasan free_track is 16 bytes
> >> > > large, that it will occupy the whole 'kmalloc-16's object area,
> >> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> >> > > error is triggered.
> >> > >
> >> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> >> > > conflict with kmalloc-redzone which stay in the latter part of
> >> > > kmalloc area.
> >> > >
> >> > > So the solution I can think of is:
> >> > > * skip the kmalloc-redzone for kmalloc-16 only, or
> >> > > * skip kmalloc-redzone if kasan is enabled, or
> >> > > * let kasan reserve the free meta (16 bytes) outside of object
> >> > >   just like for alloc meta
> >> >
> >> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> >> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> >> > __ksize() does.
> >>
> >> How about the following patch:
> >>
> >> ---
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index added2653bb0..33bbac2afaef 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> >>         if (!slub_debug_orig_size(s))
> >>                 return;
> >>
> >> +#ifdef CONFIG_KASAN
> >> +       /*
> >> +        * When kasan is enabled, it could save its free meta data in the
> >> +        * start part of object area, so skip the kmalloc redzone check
> >> +        * for small kmalloc slabs to avoid the data conflict.
> >> +        */
> >> +       if (s->object_size <= 32)
> >> +               orig_size = s->object_size;
> >> +#endif
> >> +
> >>         p += get_info_end(s);
> >>         p += sizeof(struct track) * 2;
> >>
> >> I extend the size to 32 for potential's kasan meta data size increase.
> >> This is tested locally, if people are OK with it, I can ask for 0Day's
> >> help to verify this.
>
> Is there maybe some KASAN macro we can use instead of hardcoding 32?
>
> >
> > Where is set_orig_size() function defined? Don't see it upstream nor
> > in linux-next.
> > This looks fine but my only concern is that this should not increase
> > memory consumption when slub debug tracking is not enabled, which
> > should be the main operation mode when KASAN is enabled. But I can't
> > figure this out w/o context.
>
> It won't increase memory consumption even if slub_debug tracking is enabled.
> It just fakes a bit the size that was passed to kmalloc() and which we newly
> store (thanks to Feng's patches) for statistics and debugging purposes.

Then it looks good to me. Thanks for double checking.


> >> Thanks,
> >> Feng
> >>
> >> >
> >> > > I don't have way to test kasan's SW/HW tag configuration, which
> >> > > is only enabled on arm64 now. And I don't know if there will
> >> > > also be some conflict.
> >> > >
> >> > > Thanks,
> >> > > Feng
> >> > >
> >> >
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/YujKCxu2lJJFm73P%40feng-skl.
>
