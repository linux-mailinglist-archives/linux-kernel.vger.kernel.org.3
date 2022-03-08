Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA84D0D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbiCHBlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiCHBl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:41:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0139176
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:40:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n15so5695943plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In56Q2F318ovMwvLgvHjGx4bpPv8YUwX7l8iUmQKcxs=;
        b=A7qhRMNJ7VrqboeRiCx1fb62NhPps/u3YBRgBaB9fMhtrO8KvpSSBDpnKLHEw5FGQe
         1B8KgGnuSC6/lhvXTnEIJsnAu19kTuFtkvUus7hqgU9QquaSpCGtksYUTjK6wK6zp2LH
         YbL5cHGTAVY7kp1jAiAHlPH9l/VQkbjI7NvnJc6h5MqP8QFrtI8smOO3w8VfuBRJa60E
         XHhGbEgET/XQAmJqvWXuREDMVljKNTz2K0vQ7xioG8qJU4A6rKvUTe7w33ngEoGSjHL9
         lbRvs2DDiCfW9nJigQhYvtOX0RtOZ44lWeOmEQfrxf6GA00YxahHXLrSaCkRvTm27Ysg
         dIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In56Q2F318ovMwvLgvHjGx4bpPv8YUwX7l8iUmQKcxs=;
        b=1SkfngXMhfL1Q24UeaKTCt0QNH6yzU47aFF0wXcoy8HSwOwLzSSIP00jgR+MQxA/3U
         c8e6sveZBHUFkbJcSErwg/5Z6kQb4FCzj+EfuucdrgkCBejPblV+qgHqjmnjhG9qQZnu
         lugR6smzhumHcN3qolvPQBenxQf/HUM1ozpG/tvXocqsIC8hbz0bIrciD8udY6hmYf06
         gGxxfO3zhlGUBgnnW9AYXPL2Fk/oI9m6sjl2TSWNwcWRvKYer5ediKZWsXK1gHugrC6B
         pBoYycxP964WSsb9JA8FXTNguymfDQ9dzaB5ljxuxtbgSzu1q3cKYTqxT0BjxbpEQI4E
         ha1Q==
X-Gm-Message-State: AOAM531rXWAQu045bMCr3FPR4w1uTv1fYbLQyGLTfeXsxlu0ecpQOy+6
        IOTdbRLqlkVLmymMf3saR0VBwwZWsrbXQz2ekx8=
X-Google-Smtp-Source: ABdhPJwNvQPh6ByDLUBeKqCDF+ZHTYDXopMivvlSv3PaXHLzWnSNJbjYX84JgxUIZjdZZagfs/PXgU8QjoUcamcWD/E=
X-Received: by 2002:a17:90a:4411:b0:1bc:99b0:acad with SMTP id
 s17-20020a17090a441100b001bc99b0acadmr2027583pjg.25.1646703633757; Mon, 07
 Mar 2022 17:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20220307074057.902222-1-42.hyeyoo@gmail.com> <20220307074057.902222-3-42.hyeyoo@gmail.com>
In-Reply-To: <20220307074057.902222-3-42.hyeyoo@gmail.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 8 Mar 2022 09:40:07 +0800
Message-ID: <CAEVVKH-zYxn62wd8CzZx5Sw=6wTe2ZBMUyTSv8V2PR5bRoW-tA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/slub: refactor deactivate_slab()
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 7, 2022 at 3:41 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> Simplify deactivate_slab() by unlocking n->list_lock and retrying
> cmpxchg_double() when cmpxchg_double() fails, and perform
> add_{partial,full} only when it succeed.
>
> Releasing and taking n->list_lock again here is not harmful as SLUB
> avoids deactivating slabs as much as possible.
>
> [ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
>   succeed.
>
>   count deactivating full slabs even if debugging flag is not set. ]
>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 91 +++++++++++++++++++++++--------------------------------
>  1 file changed, 38 insertions(+), 53 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 1ce09b0347ad..f0cb9d0443ac 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2348,10 +2348,10 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>                             void *freelist)
>  {
> -       enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
> +       enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE, M_FULL_NOLIST };
>         struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> -       int lock = 0, free_delta = 0;
> -       enum slab_modes l = M_NONE, m = M_NONE;
> +       int free_delta = 0;
> +       enum slab_modes mode = M_NONE;
>         void *nextfree, *freelist_iter, *freelist_tail;
>         int tail = DEACTIVATE_TO_HEAD;
>         unsigned long flags = 0;
> @@ -2393,14 +2393,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>          * Ensure that the slab is unfrozen while the list presence
>          * reflects the actual number of objects during unfreeze.
>          *
> -        * We setup the list membership and then perform a cmpxchg
> -        * with the count. If there is a mismatch then the slab
> -        * is not unfrozen but the slab is on the wrong list.
> -        *
> -        * Then we restart the process which may have to remove
> -        * the slab from the list that we just put it on again
> -        * because the number of objects in the slab may have
> -        * changed.
> +        * We first perform cmpxchg holding lock and insert to list
> +        * when it succeed. If there is mismatch then the slab is not
> +        * unfrozen and number of objects in the slab may have changed.
> +        * Then release lock and retry cmpxchg again.
>          */
>  redo:
>
> @@ -2420,61 +2416,50 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>         new.frozen = 0;
>
>         if (!new.inuse && n->nr_partial >= s->min_partial)
> -               m = M_FREE;
> +               mode = M_FREE;
>         else if (new.freelist) {
> -               m = M_PARTIAL;
> -               if (!lock) {
> -                       lock = 1;
> -                       /*
> -                        * Taking the spinlock removes the possibility that
> -                        * acquire_slab() will see a slab that is frozen
> -                        */
> -                       spin_lock_irqsave(&n->list_lock, flags);
> -               }
> -       } else {
> -               m = M_FULL;
> -               if (kmem_cache_debug_flags(s, SLAB_STORE_USER) && !lock) {
> -                       lock = 1;
> -                       /*
> -                        * This also ensures that the scanning of full
> -                        * slabs from diagnostic functions will not see
> -                        * any frozen slabs.
> -                        */
> -                       spin_lock_irqsave(&n->list_lock, flags);
> -               }
> -       }
> -
> -       if (l != m) {
> -               if (l == M_PARTIAL)
> -                       remove_partial(n, slab);
> -               else if (l == M_FULL)
> -                       remove_full(s, n, slab);
> +               mode = M_PARTIAL;
> +               /*
> +                * Taking the spinlock removes the possibility that
> +                * acquire_slab() will see a slab that is frozen
> +                */
> +               spin_lock_irqsave(&n->list_lock, flags);
> +       } else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
> +               mode = M_FULL;
> +               /*
> +                * This also ensures that the scanning of full
> +                * slabs from diagnostic functions will not see
> +                * any frozen slabs.
> +                */
> +               spin_lock_irqsave(&n->list_lock, flags);
> +       } else
> +               mode = M_FULL_NOLIST;
>
> -               if (m == M_PARTIAL)
> -                       add_partial(n, slab, tail);
> -               else if (m == M_FULL)
> -                       add_full(s, n, slab);
> -       }
>
> -       l = m;
>         if (!cmpxchg_double_slab(s, slab,
>                                 old.freelist, old.counters,
>                                 new.freelist, new.counters,
> -                               "unfreezing slab"))
> +                               "unfreezing slab")) {
> +               if (mode == M_PARTIAL || mode == M_FULL)
> +                       spin_unlock_irqrestore(&n->list_lock, flags);

The slab doesn't belong to any node here, should we remove locking/unlocking
spin for cmpxchg_double_slab() call? Just calling spin_lock_irqsave() before
add_partial()/add_full call is fine?

>                 goto redo;

How about do {...} while(!cmpxchg_double_slab())? The readability looks better?

Regards,
Xiongwei

> +       }
>
> -       if (lock)
> -               spin_unlock_irqrestore(&n->list_lock, flags);
>
> -       if (m == M_PARTIAL)
> +       if (mode == M_PARTIAL) {
> +               add_partial(n, slab, tail);
> +               spin_unlock_irqrestore(&n->list_lock, flags);
>                 stat(s, tail);
> -       else if (m == M_FULL)
> -               stat(s, DEACTIVATE_FULL);
> -       else if (m == M_FREE) {
> +       } else if (mode == M_FREE) {
>                 stat(s, DEACTIVATE_EMPTY);
>                 discard_slab(s, slab);
>                 stat(s, FREE_SLAB);
> -       }
> +       } else if (mode == M_FULL) {
> +               add_full(s, n, slab);
> +               spin_unlock_irqrestore(&n->list_lock, flags);
> +               stat(s, DEACTIVATE_FULL);
> +       } else if (mode == M_FULL_NOLIST)
> +               stat(s, DEACTIVATE_FULL);
>  }
>
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> --
> 2.33.1
>
>
