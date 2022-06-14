Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CCF54B528
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344453AbiFNPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbiFNPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:55:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151791AD98
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:55:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l18so10213983lje.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tdwDOTcXF1J86aFeVAQ1bLCziuFw6qe8M9l3cjjghc=;
        b=QHO8Y5kQknEqWXCUS3+9/ppmF1lVb3XWX26U60n3metMU7uBiMJxDZEqrp4EiGsX4J
         LpCTPvrO11mqmBSSBPbmWU8pJqjdqYvAypYLphvvxHfbTEaYd1Y2TpLXcxyJ0LcyACIJ
         PrKwsu8jeaJ4R9Tl09RgsPhwjAxDTRBx7PkzFQKrZ8cV/Y+cArY5moM3XjW+N8ZvDuKV
         POWdK+Xc21eVKjYPkLHPTfrESauHXjXfayJBxpbVQmpJZG0mHe/I3tRZE22x7o58RT2h
         ufFGan7qh/7sYPgANT5+lh3//nNJL6IjGDiD7Dt3qJsScBFqCVZZHqTez+9BScDVgasu
         d11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tdwDOTcXF1J86aFeVAQ1bLCziuFw6qe8M9l3cjjghc=;
        b=Bx6r/W9uDD8i8ncIXv/1xd1fkA3QlrSq+QEE0hyrvFjelohMQ/HxfvRTvqQK3QzZyZ
         F6No3K8+v6lTwIEcoTqdDUk2Wt9BuWPs5dsurYpvgu2MneDOqQWVQkpBT2cUR5ravgPY
         BH1wfJlA3sO0amuSx7jiyjZjv3Wmxu58vPdhITIjG7vHgZecBUPP6caRvS9oXltk/Lhu
         wehbR2z9l0B5aHLYQ0ajhzPkWA/o/bohYMmVPRzBR82UjdjDJGYl6SKjgeuLaGSZhuAH
         ZW+6Osbztn6ifb0V7E4ATH6pv2g+YshEN0fgqWx766It6JqMpU8ymcbLb+Q2e935R1FB
         lITg==
X-Gm-Message-State: AJIora/GLArxzwPTHt2S1B5dqGWOxwGmic3e9+IM3f+fSbuqMu4zMmJ3
        D3Sc6QTMSeq2mc9riIRLm8dW6A3ODPsSziJHxQtKKQ==
X-Google-Smtp-Source: AGRyM1tNsurC9JadtJ1iKgohdzsrA+F7tv8I3bFp/RtXaVg4DBkc1AjBH1m86u8yzocFpD4/y+mKLzzWVMRTa0ocx3M=
X-Received: by 2002:a2e:a225:0:b0:255:81e3:dc48 with SMTP id
 i5-20020a2ea225000000b0025581e3dc48mr2898624ljm.375.1655222101114; Tue, 14
 Jun 2022 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220608182205.2945720-1-jannh@google.com> <95a9f679-93d9-548a-fc26-985ec605e7f8@suse.cz>
In-Reply-To: <95a9f679-93d9-548a-fc26-985ec605e7f8@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 14 Jun 2022 17:54:24 +0200
Message-ID: <CAG48ez2grcFO9FUApstmmr6QcVxbx=68MDXRtP_hQqAmYWn17w@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 14, 2022 at 10:23 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 6/8/22 20:22, Jann Horn wrote:
> > The fastpath in slab_alloc_node() assumes that c->slab is stable as long as
> > the TID stays the same. However, two places in __slab_alloc() currently
> > don't update the TID when deactivating the CPU slab.
> >
> > If multiple operations race the right way, this could lead to an object
> > getting lost; or, in an even more unlikely situation, it could even lead to
> > an object being freed onto the wrong slab's freelist, messing up the
> > `inuse` counter and eventually causing a page to be freed to the page
> > allocator while it still contains slab objects.
[...]
> > Fixes: c17dda40a6a4e ("slub: Separate out kmem_cache_cpu processing from deactivate_slab")
> > Fixes: 03e404af26dc2 ("slub: fast release on full slab")
> > Cc: stable@vger.kernel.org
>
> Hmm these are old commits, and currently oldest LTS is 4.9, so this will be
> fun. Worth doublechecking if it's not recent changes that actually
> introduced the bug... but seems not, AFAICS.
[...]
> > @@ -2936,6 +2936,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >
> >       if (!freelist) {
> >               c->slab = NULL;
> > +             c->tid = next_tid(c->tid);
> >               local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>
> So this immediate unlock after setting NULL is new from the 5.15 preempt-rt
> changes. However even in older versions we could goto new_slab,
> new_slab_objects(), new_slab(), allocate_slab(), where if
> (gfpflags_allow_blocking()) local_irq_enable(); (there's no extra disabled
> preemption besides the irq disable) so I'd say the bug was possible before
> too, but less often?

Yeah, I think so too.

> >               stat(s, DEACTIVATE_BYPASS);
> >               goto new_slab;
> > @@ -2968,6 +2969,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >       freelist = c->freelist;
> >       c->slab = NULL;
> >       c->freelist = NULL;
>
> Previously these were part of deactivate_slab(), which does that at the very
> end, but also without bumping tid.
> I just wonder if it's necessary too, because IIUC the scenario you described
> relies on the missing bump above. This alone doesn't cause the c->slab vs
> c->freelist mismatch?

It's a different scenario, but at least in the current version, the
ALLOC_NODE_MISMATCH case jumps straight to the deactivate_slab label,
which takes the local_lock, grabs the old c->freelist, NULLs out
->slab and ->freelist, then drops the local_lock again. If the
c->freelist was non-NULL, then this will prevent concurrent cmpxchg
success; but there is no reason why c->freelist has to be non-NULL
here. So if c->freelist is already NULL, we basically just take the
local_lock, set c->slab to NULL, and drop the local_lock. And IIUC the
local_lock is the only protection we have here against concurrency,
since the slub_get_cpu_ptr() in __slab_alloc() only disables
migration? So again a concurrent fastpath free should be able to set
c->freelist to non-NULL after c->slab has been set to NULL.

So I think this TID bump is also necessary for correctness in the
current version.

And looking back at older kernels, back to at least 4.9, the
ALLOC_NODE_MISMATCH case looks similarly broken - except that again,
as you pointed out, we don't have the fine-grained locking, so it only
becomes racy if we hit new_slab_objects() -> new_slab() ->
allocate_slab() and then either we do local_irq_enable() or the
allocation fails.

> Thanks. Applying to slab/for-5.19-rc3/fixes branch.

Thanks!
