Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBAF54C72E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352756AbiFOLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243002AbiFOLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:10:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27273700D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:10:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k7so758266plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUJvI2mIr0H2JT9klD7hj8v0XWBj/xmpouDexRiutpo=;
        b=OV4LbbvNTOubDxSR19tlDR0mEttMuH5P4gikDuK2pS/QDLgBmAheHCN7uEq/l64G52
         uDODflgmce8H7AwH9CPZ3+TtpLNxB7+djP3CwLZIeX665l8xf1S5v3750tZ+DCkQNYL0
         RYemDfImpY+bTbuO1hkowkRgJAHgFJHOa8cp3h27zJ2hZLbMbkBH8MYfoKXceOLUuz3d
         hwkZvQU9ciMB39aztUHTUAAIfgi8GDCoeUajKSoPZBnOpCLiV3dD0uoouavxQMILNTpZ
         YNXoXYfeig/0CUWZLzE5GiOEPjH2E2ZPNr28EBGPUm0omWoXlxAhulUUCiUVMfXdHZG1
         MOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUJvI2mIr0H2JT9klD7hj8v0XWBj/xmpouDexRiutpo=;
        b=IllGJeGuB/RJVso6Qzd/6kpPrdnDl2ulz1VSGDKDccvHmYPvCSmMaPKhIC8hZW5ui3
         mXEb9CMgBH89q7qlmi/CORMvSKp1ygaQp8DZnljIqwAFhuvq4Z6GYTePs9Bd2iDPhOGP
         zy0SLAv7x4vde0yWa+EZCj0QAguNcmBeB5D/PIatJluyjrbq3yD7UoDwCOgrfJrGBTLA
         RVKVKKxlHdpvtlU0NfjSPHBvMZUhWLG4hjx94qZ1i7dSimjaKnZmTaPj4FL2GdjjXf94
         OhZwus5NRD45alBOsMHZp9Qfk/2xUQvwmXZLKKKdsdTf35SLtmVU7rX7mem8h+uJ67IE
         1dBg==
X-Gm-Message-State: AJIora+3BSb1MDofQYpXdeB2qjAGDHFyOFvYignezlgub67zGXRAXMPO
        TTOB6ska47jQrvgF94YnHidOvik1cB1RD1lvCjw=
X-Google-Smtp-Source: AGRyM1vaEEy9OdnuCJeSwh9Eq+nU4S/rlxRNs8UiJJ5SLzphXZKdVr4TdMlMfALolZK1gUaADJBFIvt4+uC/qCigmhY=
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59c2 with SMTP id
 q6-20020a17090311c600b0016790e559c2mr9048263plh.50.1655291405303; Wed, 15 Jun
 2022 04:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220603143555.41914-1-sxwjean@me.com> <YpspHqZM27DeEhNR@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <CAEVVKH_WM321zQPC-xjchqjySi4kngo6CFz-A6HY2tCjNCZ3SA@mail.gmail.com> <e5ebc952-af17-321f-5343-bc914d47c931@suse.cz>
In-Reply-To: <e5ebc952-af17-321f-5343-bc914d47c931@suse.cz>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Wed, 15 Jun 2022 19:09:38 +0800
Message-ID: <CAEVVKH8ZEeZY4dbfn6HKFBeb=hGSRuUn3DNPM72Sv0gKFqTdBw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/slub: Simplify __kmem_cache_alias()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Xiongwei Song <sxwjean@me.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>
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

On Wed, Jun 15, 2022 at 4:37 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 6/5/22 09:04, Xiongwei Song wrote:
> > On Sat, Jun 4, 2022 at 5:43 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >>
> >> On Fri, Jun 03, 2022 at 10:35:55PM +0800, sxwjean@me.com wrote:
> >> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >> >
> >> > There is no need to do anything if sysfs_slab_alias() return nonzero
> >> > value after getting a mergeable cache.
> >> >
> >> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> >> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> >> > ---
> >> > v2: Collect Reviewed-by tag from Muchun.
>
> Hmm I added v1 (with the Reviewed tag) before getting to the v2 thread. But
> I think it's fine, see below.
>
> >> > ---
> >> >  mm/slub.c | 8 +++-----
> >> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/mm/slub.c b/mm/slub.c
> >> > index d8d5abf49f5f..9444277d669a 100644
> >> > --- a/mm/slub.c
> >> > +++ b/mm/slub.c
> >> > @@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> >> >
> >> >       s = find_mergeable(size, align, flags, name, ctor);
> >> >       if (s) {
> >> > +             if (sysfs_slab_alias(s, name))
> >> > +                     return NULL;
> >> > +
> >> >               s->refcount++;
> >> >
> >>
> >> I think we should not expose sysfs attributes before initializing
> >> what can be read via sysfs attribute (object_size).
>
> Hmm I don't think they are unitialized. They have an old value from the
> cache we are merging with, which is updated if the new aliased cache has a
> larger one.
> So yeah we might briefly during creation expose an alias that will have an
> incorrect value, but I doubt anything will break. The values are not stable
> anyway as new aliases are added, as we are bumping them for the 'root' cache
> and all aliases that share it already.
>
> >> >               /*
> >> > @@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> >> >                */
> >> >               s->object_size = max(s->object_size, size);
> >>
> >> this calculation should be done before sysfs_slab_alias().
> >
> > Yeah, understood. Should we restore s->object_size and s->inuse if
> > sysfs_slab_alias() returns non zero value?
>
> And by bailing out early this patch effectively achieves that, so I'd say
> it's a better state than before the patch so I'll keep it unless proven
> otherwise. Thanks!

Thank you for your comments Vlastimil and Hyeonggon.

Regards,
Xiongwei

>
> > Regards,
> > Xiongwwei
> >
> >>
> >> Thanks,
> >> Hyeonggon
> >>
> >> >               s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
> >> > -
> >> > -             if (sysfs_slab_alias(s, name)) {
> >> > -                     s->refcount--;
> >> > -                     s = NULL;
> >> > -             }
> >> >       }
> >> >
> >> >       return s;
> >> > --
> >> > 2.30.2
> >> >
> >>
>
