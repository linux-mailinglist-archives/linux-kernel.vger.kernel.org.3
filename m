Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB14D0E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbiCHDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiCHDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:51:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DFA33EBA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:50:25 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z11so15905843pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 19:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+FbtEzsXP5hE8EAUQthB5GAKqhagUByhfPOsMxtU+ww=;
        b=l1oULlMBZFb6w5EcDS0lb00lyNs86v4Dp2IKRQR3tRFNEaAn170AakDTfhZ1gNBzu3
         1rr0qp/+v/TNtjd3dW5w7L3p6sxj/idSD7suk30ZZ1SEoWBRS5KhP5TMZ+gHAlo/zdwA
         hQPKjV21FKmb+pD9PUHP38tW2eSYCeAVjKhMirqCsoGngCjpJn4i+PSuHTGF9ttsH1V1
         KKsxQoT7toB7MJA2EVuDW+Zc6mBg4BLqdNr3OfneK8nLb6Eww5x+hFDr48pzeg/dDY9D
         P+maYr7imscETdMCTJNE+2OIhXgsXBZweWTRLfDNBHzgbNR2YJSXUVyOKa02azCWSUbG
         M2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+FbtEzsXP5hE8EAUQthB5GAKqhagUByhfPOsMxtU+ww=;
        b=jgnT21bRnzfdcs9WyzhSWY+Nvm5EJrv1ToBY2SDfH62yWc3StKoRRulmmc4wPE0gw3
         2GlgOhIEUvC+U1cw/I0welMwrQkbAdfntZIkaSW4bWkxRYMeNWuSXizMLWERna64EEA2
         oC2QhT5ukca1D3k7f0oXlRL0GAF/wIoxqAbiExpplRBn0LsXxTQ2QN80K49KCLKNRPVB
         n50PAjKPQQ4HKfR2LFVp+eSBfgzJlFYf21cRePi1/ApboF6Y/KTBL3B4idxmrkDg3FY4
         epfIHnKnuvaHDEuyQdGUY2xDIP6RhlqmgXCbfWtfECBUzq+mQ/Nr12O/wPKGAS/caFKX
         WxVw==
X-Gm-Message-State: AOAM530CZoMGEId3f25eGQnuj//vlNwnsuNk9zzxcBuqPbCeksTCIaJ9
        vJ/tJoI5QyjuVD0PlB4nsM8c2orWm853Tg==
X-Google-Smtp-Source: ABdhPJxzCemp2YVUBo1TSwelmmOCCtlEF+pjAE3Shx0l9SI1uZJ6cKNuaV84VeSvdh/bq/Lc9sGtbg==
X-Received: by 2002:a17:90a:ad88:b0:1be:ec99:a695 with SMTP id s8-20020a17090aad8800b001beec99a695mr2486249pjq.119.1646711425019;
        Mon, 07 Mar 2022 19:50:25 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b004e15a113300sm18875495pfu.198.2022.03.07.19.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 19:50:24 -0800 (PST)
Date:   Tue, 8 Mar 2022 03:50:19 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm/slub: refactor deactivate_slab()
Message-ID: <YibSe/txAsubzqUw@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
 <20220307074057.902222-3-42.hyeyoo@gmail.com>
 <CAEVVKH-zYxn62wd8CzZx5Sw=6wTe2ZBMUyTSv8V2PR5bRoW-tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH-zYxn62wd8CzZx5Sw=6wTe2ZBMUyTSv8V2PR5bRoW-tA@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:40:07AM +0800, Xiongwei Song wrote:
> Hello,
> 
> On Mon, Mar 7, 2022 at 3:41 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > Simplify deactivate_slab() by unlocking n->list_lock and retrying
> > cmpxchg_double() when cmpxchg_double() fails, and perform
> > add_{partial,full} only when it succeed.
> >
> > Releasing and taking n->list_lock again here is not harmful as SLUB
> > avoids deactivating slabs as much as possible.
> >
> > [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
> >   succeed.
> >
> >   count deactivating full slabs even if debugging flag is not set. ]
> >
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  mm/slub.c | 91 +++++++++++++++++++++++--------------------------------
> >  1 file changed, 38 insertions(+), 53 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1ce09b0347ad..f0cb9d0443ac 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2348,10 +2348,10 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
> >  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >                             void *freelist)
> >  {
> > -       enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
> > +       enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE, M_FULL_NOLIST };
> >         struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> > -       int lock = 0, free_delta = 0;
> > -       enum slab_modes l = M_NONE, m = M_NONE;
> > +       int free_delta = 0;
> > +       enum slab_modes mode = M_NONE;
> >         void *nextfree, *freelist_iter, *freelist_tail;
> >         int tail = DEACTIVATE_TO_HEAD;
> >         unsigned long flags = 0;
> > @@ -2393,14 +2393,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >          * Ensure that the slab is unfrozen while the list presence
> >          * reflects the actual number of objects during unfreeze.
> >          *
> > -        * We setup the list membership and then perform a cmpxchg
> > -        * with the count. If there is a mismatch then the slab
> > -        * is not unfrozen but the slab is on the wrong list.
> > -        *
> > -        * Then we restart the process which may have to remove
> > -        * the slab from the list that we just put it on again
> > -        * because the number of objects in the slab may have
> > -        * changed.
> > +        * We first perform cmpxchg holding lock and insert to list
> > +        * when it succeed. If there is mismatch then the slab is not
> > +        * unfrozen and number of objects in the slab may have changed.
> > +        * Then release lock and retry cmpxchg again.
> >          */
> >  redo:
> >
> > @@ -2420,61 +2416,50 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >         new.frozen = 0;
> >
> >         if (!new.inuse && n->nr_partial >= s->min_partial)
> > -               m = M_FREE;
> > +               mode = M_FREE;
> >         else if (new.freelist) {
> > -               m = M_PARTIAL;
> > -               if (!lock) {
> > -                       lock = 1;
> > -                       /*
> > -                        * Taking the spinlock removes the possibility that
> > -                        * acquire_slab() will see a slab that is frozen
> > -                        */
> > -                       spin_lock_irqsave(&n->list_lock, flags);
> > -               }
> > -       } else {
> > -               m = M_FULL;
> > -               if (kmem_cache_debug_flags(s, SLAB_STORE_USER) && !lock) {
> > -                       lock = 1;
> > -                       /*
> > -                        * This also ensures that the scanning of full
> > -                        * slabs from diagnostic functions will not see
> > -                        * any frozen slabs.
> > -                        */
> > -                       spin_lock_irqsave(&n->list_lock, flags);
> > -               }
> > -       }
> > -
> > -       if (l != m) {
> > -               if (l == M_PARTIAL)
> > -                       remove_partial(n, slab);
> > -               else if (l == M_FULL)
> > -                       remove_full(s, n, slab);
> > +               mode = M_PARTIAL;
> > +               /*
> > +                * Taking the spinlock removes the possibility that
> > +                * acquire_slab() will see a slab that is frozen
> > +                */
> > +               spin_lock_irqsave(&n->list_lock, flags);
> > +       } else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> > +               mode = M_FULL;
> > +               /*
> > +                * This also ensures that the scanning of full
> > +                * slabs from diagnostic functions will not see
> > +                * any frozen slabs.
> > +                */
> > +               spin_lock_irqsave(&n->list_lock, flags);
> > +       } else
> > +               mode = M_FULL_NOLIST;
> >
> > -               if (m == M_PARTIAL)
> > -                       add_partial(n, slab, tail);
> > -               else if (m == M_FULL)
i> > -                       add_full(s, n, slab);
> > -       }
> >
> > -       l = m;
> >         if (!cmpxchg_double_slab(s, slab,
> >                                 old.freelist, old.counters,
> >                                 new.freelist, new.counters,
> > -                               "unfreezing slab"))
> > +                               "unfreezing slab")) {
> > +               if (mode == M_PARTIAL || mode == M_FULL)
> > +                       spin_unlock_irqrestore(&n->list_lock, flags);
> 
> The slab doesn't belong to any node here, should we remove locking/unlocking
> spin for cmpxchg_double_slab() call? Just calling spin_lock_irqsave() before
> add_partial()/add_full call is fine?
>

I thought about that, and tested, but that is not okay.

taking spinlock around cmpxchg prevents race between __slab_free() and
deactivate_slab(). list can be corrupted without spinlock.


think about case below: (when SLAB_STORE_USER is set)

__slab_free()			deactivate_slab()
=================		=================
				(deactivating full slab)
				cmpxchg_double()


spin_lock_irqsave()
cmpxchg_double()		

/* not in full list yet */
remove_full()
add_partial()
spin_unlock_irqrestore()
				spin_lock_irqsave()
				add_full()			
				spin_unlock_irqrestore()



> >                 goto redo;
> 
> How about do {...} while(!cmpxchg_double_slab())? The readability looks better?
>

This will be:

do {
	if (mode == M_PARTIAL || mode == M_FULL)
		spin_unlock_irqrestore();

	[...]

} while (!cmpxchg_double_slab());

I think goto version is better for reading?

Thanks!

> Regards,
> Xiongwei
> 
> > +       }
> >
> > -       if (lock)
> > -               spin_unlock_irqrestore(&n->list_lock, flags);
> >
> > -       if (m == M_PARTIAL)
> > +       if (mode == M_PARTIAL) {
> > +               add_partial(n, slab, tail);
> > +               spin_unlock_irqrestore(&n->list_lock, flags);
> >                 stat(s, tail);
> > -       else if (m == M_FULL)
> > -               stat(s, DEACTIVATE_FULL);
> > -       else if (m == M_FREE) {
> > +       } else if (mode == M_FREE) {
> >                 stat(s, DEACTIVATE_EMPTY);
> >                 discard_slab(s, slab);
> >                 stat(s, FREE_SLAB);
> > -       }
> > +       } else if (mode == M_FULL) {
> > +               add_full(s, n, slab);
> > +               spin_unlock_irqrestore(&n->list_lock, flags);y
> > +               stat(s, DEACTIVATE_FULL);
> > +       } else if (mode == M_FULL_NOLIST)
> > +               stat(s, DEACTIVATE_FULL);
> >  }
> >
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> > --
> > 2.33.1
> >
> >

-- 
Thank you, You are awesome!
Hyeonggon :-)
