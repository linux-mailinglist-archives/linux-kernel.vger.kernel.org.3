Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250674C1B61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiBWTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiBWTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:06:43 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199F93EF00
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:06:15 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j12so49998265ybh.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uyB8qTyiqJA+8KT+MhYk3e+WJLsuNUugcYRMD4HHtc=;
        b=XTcWUGqndSazCKYxvr5wfdVygp3PD8Q+5T/UmHtdzhxxiTh5N0vinkFlZN7MwnJGpP
         PU/JSqVsObIVHE4Z/SRkI8lffvP1P9yocTbN/3F92cqvJYJsyiKWKImrpxxGoSZjr4Ie
         DUK217WdtiEiy9Nj4AoJKGq1X+z0e4+9Tt3tL6dmFhfYS1kjuCuGA/Ug/xbccbpC6vrA
         Z53QhfSqKz3YXtd70RcRkvZ8Y55npfAz2z5C5JqthTUdPFibChxuIHynA7xg/4pvipww
         BNZheB27YegwfPK8nG3lG4IprMGjj/5oHGx8knm/KwgJ4Pc6Kob30ACxLMw1M3CHIagD
         0uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uyB8qTyiqJA+8KT+MhYk3e+WJLsuNUugcYRMD4HHtc=;
        b=dOsPzNfQVUl0tl+29F4cW4DM4vM0L6JMN3PEIE35DLvPXqo6GK9GxRtl23ct0D6bGS
         6WezwuvUA9aRPBPKfQXQA4xk7+muvxVmo5gNKqCKX4+lK+m2T3f+LQy/L1Cg62VW3FoL
         /Kl+6Es7KU/h6CTS/S+GRKGomMqYHLgI7IT5KtIdBg46YJ7XE7a8Uwi/K7GssuLcwlt1
         OPJORdC0lsDY3ixTjEJ1s/bAyBD/iMBaLA+1eN5r4JwNgjK6tgZY175C6MlODYb365Gu
         aLWNvMcPnV7Z6Y4t/TYm1b4U2tP6seWQtkT4FKQCod5oPl5cPdKP3mTudjeY5jSrblez
         MBUw==
X-Gm-Message-State: AOAM531TALvXZBMymI4mGtbanM4ta/NXBCCpyT7+SvE2Uk4zxZgnQ7+z
        KRITQL9+Uyzy2tgZ98i7pL6VSFPqeFvxAqwispl/5g==
X-Google-Smtp-Source: ABdhPJzG+wZcj7IS5on1+GCgo2bfFUsCtjBnQs0QuELu2SkLfouEYImHnsLEqFHCrRSqVeoTZx4SqMYfZAhMCx7LVsU=
X-Received: by 2002:a25:a4e8:0:b0:61e:1eb6:19bd with SMTP id
 g95-20020a25a4e8000000b0061e1eb619bdmr1094373ybi.168.1645643174054; Wed, 23
 Feb 2022 11:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20220221105336.522086-1-42.hyeyoo@gmail.com> <20220221105336.522086-2-42.hyeyoo@gmail.com>
 <4d42fcec-ff59-2e37-4d8f-a58e641d03c8@suse.cz>
In-Reply-To: <4d42fcec-ff59-2e37-4d8f-a58e641d03c8@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Wed, 23 Feb 2022 20:06:02 +0100
Message-ID: <CANpmjNMjgSKommNCrfyFuaz+3HQdW92ZSF_p26LQdmS0o3L98Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/sl[au]b: Unify __ksize()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 at 19:39, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 2/21/22 11:53, Hyeonggon Yoo wrote:
> > Only SLOB need to implement __ksize() separately because SLOB records
> > size in object header for kmalloc objects. Unify SLAB/SLUB's __ksize().
> >
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  mm/slab.c        | 23 -----------------------
> >  mm/slab_common.c | 29 +++++++++++++++++++++++++++++
> >  mm/slub.c        | 16 ----------------
> >  3 files changed, 29 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/slab.c b/mm/slab.c
> > index ddf5737c63d9..eb73d2499480 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -4199,27 +4199,4 @@ void __check_heap_object(const void *ptr, unsigned long n,
> >  }
> >  #endif /* CONFIG_HARDENED_USERCOPY */
> >
> > -/**
> > - * __ksize -- Uninstrumented ksize.
> > - * @objp: pointer to the object
> > - *
> > - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> > - * safety checks as ksize() with KASAN instrumentation enabled.
> > - *
> > - * Return: size of the actual memory used by @objp in bytes
> > - */
> > -size_t __ksize(const void *objp)
> > -{
> > -     struct kmem_cache *c;
> > -     size_t size;
> >
> > -     BUG_ON(!objp);
> > -     if (unlikely(objp == ZERO_SIZE_PTR))
> > -             return 0;
> > -
> > -     c = virt_to_cache(objp);
> > -     size = c ? c->object_size : 0;
>
> This comes from commit a64b53780ec3 ("mm/slab: sanity-check page type when
> looking up cache") by Kees and virt_to_cache() is an implicit check for
> folio slab flag ...
>
> > -
> > -     return size;
> > -}
> > -EXPORT_SYMBOL(__ksize);
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 23f2ab0713b7..488997db0d97 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1245,6 +1245,35 @@ void kfree_sensitive(const void *p)
> >  }
> >  EXPORT_SYMBOL(kfree_sensitive);
> >
> > +#ifndef CONFIG_SLOB
> > +/**
> > + * __ksize -- Uninstrumented ksize.
> > + * @objp: pointer to the object
> > + *
> > + * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> > + * safety checks as ksize() with KASAN instrumentation enabled.
> > + *
> > + * Return: size of the actual memory used by @objp in bytes
> > + */
> > +size_t __ksize(const void *object)
> > +{
> > +     struct folio *folio;
> > +
> > +     if (unlikely(object == ZERO_SIZE_PTR))
> > +             return 0;
> > +
> > +     folio = virt_to_folio(object);
> > +
> > +#ifdef CONFIG_SLUB
> > +     if (unlikely(!folio_test_slab(folio)))
> > +             return folio_size(folio);
> > +#endif
> > +
> > +     return slab_ksize(folio_slab(folio)->slab_cache);
>
> ... and here in the common version you now for SLAB trust that the folio
> will be a slab folio, thus undoing the intention of that commit. Maybe
> that's not good and we should keep the folio_test_slab() for both cases?
> Although maybe it's also strange that prior this patch, SLAB would return 0
> if the test fails, and SLUB would return folio_size(). Probably because with
> SLUB this can be a large kmalloc here and with SLAB not. So we could keep
> doing that in the unified version, or KASAN devs (CC'd) could advise
> something better?

Is this a definitive failure case? My opinion here is that returning 0
from ksize() in case of failure will a) provide a way to check for
error, and b) if the size is used unconditionally to compute an
address may be the more graceful failure mode (see comment added in
0d4ca4c9bab39 for what happens if we see invalid memory per KASAN
being accessed).
