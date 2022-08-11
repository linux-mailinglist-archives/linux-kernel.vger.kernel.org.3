Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECF58FA48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiHKJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiHKJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:52:46 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FABC90C4C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:52:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-32a09b909f6so63499917b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4TbeJ47O6jDOlyunrlIhv/Q2h3DuJDhmv18eJjgF8uk=;
        b=VqdDDiDVHcxv6/cEuhOklTEy9FLcPOTEGIa+/IKsk/LCZuQT53AAYIS3TWyda4qA/M
         HIRespjKzhhqI4dej17TtLo9CCH0E9IAs82ruA1R5f9FCIPASKzhjYfoYc8x5XuelNaO
         EGJZ3XHXEWo+lEgf6GhypKG6MaQ01oQ1RTgRKH44VBOiUHr68bY5zHSdsvUuEWYR9ebd
         rD3kRc2xgqUXWY+COavJXo7GGOAmJ64ZsYOB/EVJuFEM9lwPSyKaowlw1Eo+w+vy/gGB
         Vd2R96hWdkyxoaosIUt9JYyC6t1v9Ec0FxCw3CJaMbippAvQTq4ukFLdRLpCGiXEPTwM
         UnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4TbeJ47O6jDOlyunrlIhv/Q2h3DuJDhmv18eJjgF8uk=;
        b=nZMatvtcLD1A3pobTw7qJRDG3ify+grnmGTB9voK8NcjJOL7jN4RaDuh8GvPqID74p
         dDhWCPwtnwU52QPhhA2emT78YbsjEHVau8/O7rI36NW7/cvH+bAo6Lm2/P3vtFhK4PD3
         AldSyzGgOfa1OWU+Zk9SV8HfS4gCvpauHbd9BKTLXspeyw2SnZmX328s7yqk7yS4zFom
         Lu1s8hVnPnqSUU4rc0GRybnQJEa3FF2uGQr9UeTWhhBSzwhWp/slw9W2gu1gdFCSG5xM
         kE5xDNE/d7DfJGmLXCTVNN3Ftx0sAHC0fs7m2tphskRLUXJAn7dEYwo3mHit7xmkF+Df
         /r5A==
X-Gm-Message-State: ACgBeo1QhOWIZiNDfbL4sPtCvbtt8UCcvljGcUjBpAZAdwotKcpzR9RF
        3Xxl/oB9Om1NyXpRwynFpHFgzYt8TAzTqF/y4vnaJg==
X-Google-Smtp-Source: AA6agR56CRCkZYeujOwS+/1v6+eUavc5Etxu+OvLhG2v0yg+u+A2XCKfi0i7a3lhzzI1WG6XP60jOMyM4rsL0fPIbes=
X-Received: by 2002:a0d:eb12:0:b0:31f:38af:6ff with SMTP id
 u18-20020a0deb12000000b0031f38af06ffmr31250407ywe.4.1660211564413; Thu, 11
 Aug 2022 02:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220811085938.2506536-1-imran.f.khan@oracle.com> <d3cd0f34-b30b-9a1d-8715-439ffb818539@suse.cz>
In-Reply-To: <d3cd0f34-b30b-9a1d-8715-439ffb818539@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 11 Aug 2022 11:52:07 +0200
Message-ID: <CANpmjNMYwxbkOc+LxLfZ--163yfXpQj69oOfEFkSwq7JZurbdA@mail.gmail.com>
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
To:     vbabka@suse.cz
Cc:     Imran Khan <imran.f.khan@oracle.com>, glider@google.com,
        dvyukov@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
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

On Thu, 11 Aug 2022 at 11:31, <vbabka@suse.cz> wrote:
>
> On 8/11/22 10:59, Imran Khan wrote:
> > By default kfence allocation can happen for any slab object, whose size
> > is up to PAGE_SIZE, as long as that allocation is the first allocation
> > after expiration of kfence sample interval. But in certain debugging
> > scenarios we may be interested in debugging corruptions involving
> > some specific slub objects like dentry or ext4_* etc. In such cases
> > limiting kfence for allocations involving only specific slub objects
> > will increase the probablity of catching the issue since kfence pool
> > will not be consumed by other slab objects.
>
> So you want to enable specific caches for kfence.
>
> > This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
> > to disable kfence for specific slabs. Having the interface work in this
> > way does not impact current/default behavior of kfence and allows us to
> > use kfence for specific slabs (when needed) as well. The decision to
> > skip/use kfence is taken depending on whether kmem_cache.flags has
> > (newly introduced) SLAB_SKIP_KFENCE flag set or not.
>
> But this seems everything is still enabled and you can selectively disable.
> Isn't that rather impractical?

A script just iterates through all the caches that they don't want,
and sets skip_kfence? It doesn't look more complicated.

> How about making this cache flag rather denote that KFENCE is enabled (not
> skipped), set it by default only for for caches with size <= 1024, then you

Where does 1024 come from? PAGE_SIZE?

The problem with that opt-in vs. opt-out is that it becomes more
complex to maintain opt-in (as the first RFC of this did). With the
new flag SLAB_SKIP_KFENCE, it also can serve a dual purpose, where
someone might want to explicitly opt out by default and pass it to
kmem_cache_create() (for whatever reason; not that we'd encourage
that).

I feel that the real use cases for selectively enabling caches for
KFENCE are very narrow, and a design that introduces lots of
complexity elsewhere, just to support this feature cannot be justified
(which is why I suggested the simpler design here back in
https://lore.kernel.org/lkml/CANpmjNNmD9z7oRqSaP72m90kWL7jYH+cxNAZEGpJP8oLrDV-vw@mail.gmail.com/
)

> can drop the size check in __kfence_alloc and rely only on the flag? And if
> you need, you can also enable a cache with size > 1024 with the sysfs
> interface, to override the limit, which isn't possible now.
> (I don't think changing the limit to always act on s->object_size instead of
> e.g. size passed to kmalloc() that it can pick up now, will change anything
> in practice)
> Then you can also have a kernel boot param that tells kfence to set the flag
> on no cache at all, and you can easily enable just the specific caches you
> want. Or make a parameter that lets you override the 1024 size limit
> globally, and if you set it to 0, it means no cache is enabled for kfence?
>
> > Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> > ---
> >
> > Changes since v1:
> >  - Remove RFC tag
> >
> >  include/linux/slab.h |  6 ++++++
> >  mm/kfence/core.c     |  7 +++++++
> >  mm/slub.c            | 27 +++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 0fefdf528e0d..947d912fd08c 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -119,6 +119,12 @@
> >   */
> >  #define SLAB_NO_USER_FLAGS   ((slab_flags_t __force)0x10000000U)
> >
> > +#ifdef CONFIG_KFENCE
> > +#define SLAB_SKIP_KFENCE            ((slab_flags_t __force)0x20000000U)
> > +#else
> > +#define SLAB_SKIP_KFENCE            0
> > +#endif
> > +
> >  /* The following flags affect the page allocator grouping pages by mobility */
> >  /* Objects are reclaimable */
> >  #define SLAB_RECLAIM_ACCOUNT ((slab_flags_t __force)0x00020000U)
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index c252081b11df..8c08ae2101d7 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -1003,6 +1003,13 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> >               return NULL;
> >       }
> >
> > +     /*
> > +      * Skip allocations for this slab, if KFENCE has been disabled for
> > +      * this slab.
> > +      */
> > +     if (s->flags & SLAB_SKIP_KFENCE)
> > +             return NULL;
> > +
> >       if (atomic_inc_return(&kfence_allocation_gate) > 1)
> >               return NULL;
> >  #ifdef CONFIG_KFENCE_STATIC_KEYS
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 862dbd9af4f5..ee8b48327536 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5745,6 +5745,30 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> >  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
> >  #endif       /* CONFIG_SLUB_STATS */
> >
> > +#ifdef CONFIG_KFENCE
> > +static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
> > +{
> > +     return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
> > +}
> > +
> > +static ssize_t skip_kfence_store(struct kmem_cache *s,
> > +                     const char *buf, size_t length)
> > +{
> > +     int ret = length;
> > +
> > +     if (buf[0] == '0')
> > +             s->flags &= ~SLAB_SKIP_KFENCE;
> > +     else if (buf[0] == '1')
> > +             s->flags |= SLAB_SKIP_KFENCE;
> > +     else
> > +             ret = -EINVAL;
> > +
> > +     return ret;
> > +}
> > +SLAB_ATTR(skip_kfence);
> > +
> > +#endif
> > +
> >  static struct attribute *slab_attrs[] = {
> >       &slab_size_attr.attr,
> >       &object_size_attr.attr,
> > @@ -5812,6 +5836,9 @@ static struct attribute *slab_attrs[] = {
> >       &failslab_attr.attr,
> >  #endif
> >       &usersize_attr.attr,
> > +#ifdef CONFIG_KFENCE
> > +     &skip_kfence_attr.attr,
> > +#endif
> >
> >       NULL
> >  };
> >
> > base-commit: 40d43a7507e1547dd45cb02af2e40d897c591870
>
