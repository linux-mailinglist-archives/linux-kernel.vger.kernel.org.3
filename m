Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50B4FAED2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiDJQPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiDJQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:15:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB45E77F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:13:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so14282558pjk.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QPhopgx/tgVvIztmP4VR/uXXXoVW1IfZx4Olt9pjko=;
        b=LIEb0aa1C5AYGxvqnI4eGbxRFwdHsQXgihBa/z7HEdPflb2+iivTS/Zlm2VuZ6Ib6U
         aqy7mVQy3o8Khe/ieIsgwbrjzF8CaSxZaVRQEcZ5Yc4jHgQQDCbDNkQTSLi7hnqOgegg
         Zurdmqo7e8QXOyXAhZw53isHJuC9QtT1kXbTSzhXaL1zzZBLDJDuQf0dU73wT5b8yUq8
         MNWQPpsD+4tRBhEEGQrgA0K4bRXxqpF4+QFPiqMLCGEumjYwhK0EagFi5WAG5FsopgTW
         kdPi2ZImksJ400qth9VAYLO+ytJmnu+u8kE3JPdMxYwuwFYGvWvqNroyh7JzhOg5gb2w
         4/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QPhopgx/tgVvIztmP4VR/uXXXoVW1IfZx4Olt9pjko=;
        b=JTcbNMby5QkVKA4tTjD4fuZO0chIf1AiMM8Vfpe0Lojr5WcpJ7fPIdPuovDaPELiDh
         UnU65CILiSarR88YUYJ4Wswnzr6O9NbU1KS2RAkn1rBzKjN6F5OllXq47kvplWDoSedL
         UrS9jazTG7GPLh7q6m8yFUnnUUKcJsddYEKJaPTNyJ7vD1PTZg8pYcBzs9uB5USkXuj+
         vgQdUeS+TOI+a/8wuE9Rtv6JCn7vTvHUbiTlORQYnCE0ADG257OFiphpTgdKImJyAgOl
         56HwN+EXiTjvpCzx21Z6PDS/Fh0pkp39XRXPhFVDrEZTALlaYlFY2M4Et5nIQgA8gNQQ
         iSpQ==
X-Gm-Message-State: AOAM532Sg9c1gsWcGh4jT4YJLbRnX5BR6GRHRwbvr9nPm0bsJqhnFHaT
        YU/myx3MDOZ+3wVW2SXy9byTwn09YrgQudXCfjU=
X-Google-Smtp-Source: ABdhPJzD3gJbuLzZNIgI7Ru3HsLucGoYjKVnoSM9Eu/kkUVtUjPT68ZJHRo6V9ckdIv7BAa3ny8JuMiqB/U/CsGFsoc=
X-Received: by 2002:a17:902:ce04:b0:156:3be:8a86 with SMTP id
 k4-20020a170902ce0400b0015603be8a86mr29417688plg.152.1649607202565; Sun, 10
 Apr 2022 09:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220409160224.611353-1-ohkwon1043@gmail.com> <YlKRVOgAFqdgtxDu@hyeyoo>
In-Reply-To: <YlKRVOgAFqdgtxDu@hyeyoo>
From:   Ohoon Kwon <ohkwon1043@gmail.com>
Date:   Mon, 11 Apr 2022 01:13:11 +0900
Message-ID: <CAE_YftXpxco35Z2GNq=-DCtwzoq8dq_z7qrp8vCdrs7ePY3gLw@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: check pfmemalloc_match in slab_alloc_node fastpath
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

Oh I was not aware of those histories.
I checked the commits, and it seems it is better to leave it
optimized(as it is now).

Thanks for your help.
Ohhoon Kwon.



On Sun, Apr 10, 2022 at 5:12 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Sun, Apr 10, 2022 at 01:02:23AM +0900, Ohhoon Kwon wrote:
> > If current alloc context does not have __GFP_MEMALLOC in its gfpflags,
> > then slab objects that were previously created with __GFP_MEMALLOC
> > should not be given.
> >
> > This criteria is well kept in slab alloc slowpath:
> > When gfpflags does not contain __GFP_MEMALLOC but if per-cpu slab page
> > was allocated with __GFP_MEMALLOC, then allocator first deactivates
> > per-cpu slab page and then again allocates new slab page with the
> > current context's gfpflags.
> >
> > However, this criteria is not checked in fastpath.
> > It should also be checked in the fastpath, too.
> >
> > Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> > ---
> >  mm/slub.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 74d92aa4a3a2..c77cd548e106 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3179,7 +3179,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
> >        * there is a suitable cpu freelist.
> >        */
> >       if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
> > -         unlikely(!object || !slab || !node_match(slab, node))) {
> > +         unlikely(!object || !slab || !node_match(slab, node) ||
> > +                     !pfmemalloc_match(slab, gfpflags))) {
> >               object = __slab_alloc(s, gfpflags, node, addr, c);
> >       } else {
> >               void *next_object = get_freepointer_safe(s, object);
>
> The missing pfmemalloc check in fastpath was intended.
>
> pfmemalloc check in fast did exist in Mel's commit 072bb0aa5e0629 ("mm:
> sl[au]b: add knowledge of PFMEMALLOC reserve pages").
>
> But later removed by Christoph's commit 5091b74a95d4 ("mm: slub: optimise
> the SLUB fast path to avoid pfmemalloc checks").
>
> Any thoughts?
>
> Thanks!
>
> --
> Thanks,
> Hyeonggon
