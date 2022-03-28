Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB94E8BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiC1BzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiC1By6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:54:58 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E664FC52
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:53:18 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e6650cde1bso132932437b3.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld6gg90UxBewd5EuGKuXKzT3kPcWyc890roNOgvWpfk=;
        b=5h4Rr7Cxj8cXXW8wb+j0jqJ/+Tk37Wv78eprkSxBXIZ5n57eqyJPv6fvnWo0y+kDq9
         yFFV1uIFMQmTsZczXyoU3t/U0n2UDVBaAtW5ZBltiQ+KDK1mp6RiTy1BSCN9Hlwke1MG
         Xed05ry/fZyrvE6Wpzkn7WqLi9SZAB7jOdx/cWbSP84BP2+UWis0XNYchFwFGLTRJgZZ
         QwXNexHoVXd+3DjEio4oPOVYbLFAfOlOjfqHc+BpE2H4lzKPJKINjHhZhe/4s+vLPeRP
         pYfwlVKvDmow3zL0HveL743Xxm4bhwPuFlk9fWPq+61gdMGzbmA1JGQNnD2+ofRU67ZR
         gKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld6gg90UxBewd5EuGKuXKzT3kPcWyc890roNOgvWpfk=;
        b=U1mQUPwSOvlleZIhF97uweoW/Cb3+xRSsO9pxm9SsS4ewkGTf+Defp++CCpVXnOkoB
         NInp2D8RW5P6E3CN3Mz66GttqXDALhbY6wuw3zZPBTnpDo6jeoFceyP+AmI4XGXJC2EH
         tO/srvPF9UVBdvGdqAA3Q2T7iUNA/VSmkvsF0zVy245ZJBWlCJF9sTJLu+RCrQ7IUlOm
         43MztfpnH72lh+WwSRcifMvzzTfy7moUJhDZMg/+wPEJZeupIyGepV4pNaW3HdKikwaw
         GTDqm+gC866JJM4Lp/mfdyCrRAnhtSM6ltLcP6A3pZ/+4F1clyV85Si4JSHk3ALJlmN6
         C10Q==
X-Gm-Message-State: AOAM53215usaC/2TI2qgJlGiMAVMtZv3rGvfc6YhkA6Mj53OTUdjt/Mz
        K8mfAlRlRZ+0x6wqLoAkAG1/zUujYzM4N8ee5W77iA==
X-Google-Smtp-Source: ABdhPJxYugzqwYygfRvHynhLC1/y3UEtpQG+g+Vx00P+G+LPRSrHTxtSoTXnS8V1aBHStCTQzJ52zfmvBCz0y9N1JKA=
X-Received: by 2002:a81:897:0:b0:2e5:f3b2:f6de with SMTP id
 145-20020a810897000000b002e5f3b2f6demr23165273ywi.141.1648432398131; Sun, 27
 Mar 2022 18:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220327051853.57647-1-songmuchun@bytedance.com>
 <20220327051853.57647-2-songmuchun@bytedance.com> <CANpmjNPA71CyZefox1rb_f8HqEM_R70EgZCX8fHeeAnDyujO8w@mail.gmail.com>
In-Reply-To: <CANpmjNPA71CyZefox1rb_f8HqEM_R70EgZCX8fHeeAnDyujO8w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Mar 2022 09:52:40 +0800
Message-ID: <CAMZfGtXt9xWnVv8hav+zWHYRmOqBGu3WPaasYwGxCb1-MDDwgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: kfence: fix objcgs vector allocation
To:     Marco Elver <elver@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 1:31 AM Marco Elver <elver@google.com> wrote:
>
> On Sun, 27 Mar 2022 at 07:19, Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > If the kfence object is allocated to be used for objects vector, then
> > this slot of the pool eventually being occupied permanently since
> > the vector is never freed.  The solutions could be 1) freeing vector
> > when the kfence object is freed or 2) allocating all vectors statically.
> > Since the memory consumption of object vectors is low, it is better to
> > chose 2) to fix the issue and it is also can reduce overhead of vectors
> > allocating in the future.
> >
> > Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/kfence/core.c   | 3 +++
> >  mm/kfence/kfence.h | 1 +
> >  2 files changed, 4 insertions(+)
>
> Thanks for this -- mostly looks good. Minor comments below + also
> please fix what the test robot reported.

Will do.

>
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 13128fa13062..9976b3f0d097 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -579,9 +579,11 @@ static bool __init kfence_init_pool(void)
> >         }
> >
> >         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> > +               struct slab *slab = virt_to_slab(addr);
> >                 struct kfence_metadata *meta = &kfence_metadata[i];
> >
> >                 /* Initialize metadata. */
> > +               slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
>
> Maybe just move it to kfence_guarded_alloc(), see "/* Set required
> slab fields */", where similar initialization on slab is done.

But slab->memcg_data is special since it is only needed to be
initialized once.  I think it is better move it to the place where
__SetPageSlab(&pages[i]) is.  What do you think?

>
> >                 INIT_LIST_HEAD(&meta->list);
> >                 raw_spin_lock_init(&meta->lock);
> >                 meta->state = KFENCE_OBJECT_UNUSED;
> > @@ -938,6 +940,7 @@ void __kfence_free(void *addr)
> >  {
> >         struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> >
> > +       KFENCE_WARN_ON(meta->objcg);
>
> This holds true for both SLAB and SLUB, right? (I think it does, but
> just double-checking.)

Right.

Thanks.
