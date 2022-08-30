Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D25A6937
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiH3RES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiH3REL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:04:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56FAE4D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:04:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so11952915pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tQO12dYvngC9mNaN/BZ42zvmagfuPG4RYzzydLVE+lE=;
        b=V6vkSWMOYajqU3Mfcq2Pmad8Akaj2ymSrKpUstf2pgt/0ju/pSwfcJKg0LuTKJKeNL
         qfOMS50qg0qRi3eMNIBZrJjssZ6FkrzRq6PZ1Ndl5pDrlPI0meb0aztqL/+jON6YhoeZ
         MOnn8x6Jk16ZR2fZiceKysykZhJabWRl285AcQOT8gG8oT2qtLwjq8Bb6IfAeHQI04c+
         +piAjsjrY9r175gR4M2K9sXPzC/hW7V8GTiI9MD5tFdb7WbsG2/8E9lPWKibcoKQkQQK
         HmBZqxk2VvybVCvOXbukhy1DHoMC7rMvDeULnnG/HD196fVwGmXY+9psZEWPLHSYhrM0
         SyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tQO12dYvngC9mNaN/BZ42zvmagfuPG4RYzzydLVE+lE=;
        b=eOoI4Z7AEbzzEPyQqk0lF+1LZppXC5SHK4mKVVUFbmAUN1DhO+3Sh4O7qGZ+Izbiks
         xVxSMwvx1RY85qtOZ57a/aXxN4WvrhfdCx9m85SLF86HzXV9TObGkCp2/iPg0i1+tok7
         s0BiC5mzQgYcYebzFnWp0WLvjfbeL9Lpjj+3zXPI9wsuPpgJkxNgoUxv2V9jWLGIteUx
         Vx1q9nWCivy/B+UkgTdNqo6CZXpFyHyf9dN5n2ZZCy7+sT96DvdaTQJV3BMfNeKQLBMc
         890w4zMmJlXw/o4LtnMl6aMmvKpefJAgyGcWwsZdMqxA7tPsvaBy+/R7vtBsDLnbYkqn
         jZXw==
X-Gm-Message-State: ACgBeo2nlpEw6p85Bm0XN6EYWxbd8CQDjpaNnE9iYtvZZ215DDGZiPxf
        kL5E1toYuHslJdqHCkZGgoD1qH4Fox8fD4qRSJM=
X-Google-Smtp-Source: AA6agR4nBOdPWpI0F2tJveHx7dhr+fc4LiC9EapLKBjLe9N+2Ni2DumkG3Dzc/yqbSy1WKIMzy8dgidXDiF0n+qk4eg=
X-Received: by 2002:a65:6a05:0:b0:42c:87a0:ea77 with SMTP id
 m5-20020a656a05000000b0042c87a0ea77mr4463421pgu.75.1661879049643; Tue, 30 Aug
 2022 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
 <20220829143055.41201-2-zhengqi.arch@bytedance.com> <20220829125134.9b05f9b8caf5da4bec8f31e8@linux-foundation.org>
In-Reply-To: <20220829125134.9b05f9b8caf5da4bec8f31e8@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 30 Aug 2022 10:03:57 -0700
Message-ID: <CAHbLzkrP7Ce7iTKQHvZQ-s3NMs1mhzjkNs8XMF_iOtbgJuJDUQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm: introduce common struct mm_slot
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, willy@infradead.org,
        vbabka@suse.cz, hannes@cmpxchg.org, minchan@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:51 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 29 Aug 2022 22:30:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> > At present, both THP and KSM module have similar structures
> > mm_slot for organizing and recording the information required
> > for scanning mm, and each defines the following exactly the
> > same operation functions:
> >
> >  - alloc_mm_slot
> >  - free_mm_slot
> >  - get_mm_slot
> >  - insert_to_mm_slots_hash
> >
> > In order to de-duplicate these codes, this patch introduces a
> > common struct mm_slot, and subsequent patches will let THP and
> > KSM to use it.
>
> Seems like a good idea.
>
> > --- /dev/null
> > +++ b/mm/mm_slot.h
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#ifndef _LINUX_MM_SLOT_H
> > +#define _LINUX_MM_SLOT_H
> > +
> > +#include <linux/hashtable.h>
> > +#include <linux/slab.h>
> > +
> > +/*
> > + * struct mm_slot - hash lookup from mm to mm_slot
> > + * @hash: link to the mm_slots hash list
> > + * @mm_node: link into the mm_slots list
> > + * @mm: the mm that this information is valid for
> > + */
> > +struct mm_slot {
> > +     struct hlist_node hash;
> > +     struct list_head mm_node;
> > +     struct mm_struct *mm;
> > +};
>
> It appears that the presence of an mm_struct in the hash list does not
> contribute to the mm_struct's refcount?  That's somewhat unexpected.

I didn't find time to look into the series yet, but when the
mm/mm_slot was added to the list, mmgrab() was definitely called if
this was not changed by the series.

>
> It would be helpful to add some words here describing the means by
> which a user of mm_slot would prevent the mm_struct from getting freed
> while on the list.  I assume "caller must maintain a reference on the
> mm_struct while it remains on an mm_slot hash list"?
>
> > +#define mm_slot_entry(ptr, type, member) \
> > +     container_of(ptr, type, member)
> > +
> > +static inline void *alloc_mm_slot(struct kmem_cache *cache)
> > +{
> > +     if (!cache)     /* initialization failed */
> > +             return NULL;
> > +     return kmem_cache_zalloc(cache, GFP_KERNEL);
> > +}
> > +
> > +static inline void free_mm_slot(struct kmem_cache *cache, void *objp)
> > +{
> > +     kmem_cache_free(cache, objp);
> > +}
> > +
> > +#define get_mm_slot(_hashtable, _mm)                                        \
> > +({                                                                          \
> > +     struct mm_slot *tmp_slot, *mm_slot = NULL;                             \
> > +                                                                            \
> > +     hash_for_each_possible(_hashtable, tmp_slot, hash, (unsigned long)_mm) \
> > +             if (_mm == tmp_slot->mm) {                                     \
> > +                     mm_slot = tmp_slot;                                    \
> > +                     break;                                                 \
> > +             }                                                              \
> > +                                                                            \
> > +     mm_slot;                                                               \
> > +})
>
> Is there a reason why this must be implemented as a macro?  That's
> preferable, although this may be overly large for inlining.  mm/util.c
> might suit.
>
> > +#define insert_to_mm_slots_hash(_hashtable, _mm, _mm_slot)                  \
> > +({                                                                          \
> > +     _mm_slot->mm = _mm;                                                    \
> > +     hash_add(_hashtable, &_mm_slot->hash, (unsigned long)_mm);             \
> > +})
>
> Does this need to be a macro?
>
>
> And the naming.  Can we please have
>
> mm_slot_entry
> mm_slot_alloc
> mm_slot_free
> mm_slot_get
> mm_slot_insert
>
> Also, "get" usually implies that a refcout is taken on the obtained
> object, so mm_slot_lookup() would be more appropriate.
>
