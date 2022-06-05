Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFA53DAA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiFEHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbiFEHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:05:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB211479
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:05:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so12210011pjm.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QI71ASgHrH+xXBDqvl4/z0d7wX86KydJWhZhtOf7+s8=;
        b=hjCPrftMwZz7tPzPMmyaoQIMbhhvFyTpqdG73CkJFmPSSnenqOPIhLrvna4ocmSQkI
         OkWJiIOVGjdEOXi7Muns+4StR/b9INtt51NmGm0fNIf/hnXRjcn7HU8cSR+3UZz6g1Yb
         YtKWhJ2ySst5PFYVqXGCMjl09K544KbbElnHGlheJPe8grHqmNbPMIOq8MP/JZb3fDs/
         7aMbvVwOdvEQiuFEpsZKM0K2JzTgbG0sqoucZyDSgepMDYjbUkKi5FOPH3rbzyE73rUQ
         Dr9Acq+mttFYO/clykkuFPzEtmKjI2hdDtxs0ZfkuivtbUyL9+ShGTlToHX3alY3dLCB
         roWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI71ASgHrH+xXBDqvl4/z0d7wX86KydJWhZhtOf7+s8=;
        b=p9ts/6pW8Z/TxB0z5uwb7amzDdI2v++GpYeuZd5U52OIR1e4BqCEL+njC6D2izVFsN
         nmA1V9N7iAA3siO4klNF2HbB5RL4fDos13/W0HRKSnIIocaF2RJPAcMwBA+luOoK5z+B
         iHLYD2KefePQjDNrASxgfhDUwc9Msd4hC7T0ptf8Zhu7rXjkbWaTgoi1EGg4ZGMvL8jG
         zErkDrrfu4PV2wTF3euqWin28ddLh6P8aFNCX9h+PwoAaBEvuY2dOv6PuhWAQDBA2mNT
         qj9dfpEchiX406XHFgAKt4DlqFX6Hn5gkQodZmVLf8Qqfz2Zd4s3dTQyVkozTO+ybcdp
         gz7Q==
X-Gm-Message-State: AOAM532NZmmYPLjxsmrgenMG/MpGt2O+7myOpfhNuECcT/IudrA4PE/q
        i6HDwTDJvC/j7+ctbxBD6y7Z1kurUH7kb9fvbh4=
X-Google-Smtp-Source: ABdhPJzj+sKYJR4wvxS1V3YubQ8xaEs4HOXSB9v3jUv5Yc4rFP1Lx912AbuXy3hpx2Eb1Pw3058rUhjBxAA6yASQERk=
X-Received: by 2002:a17:90b:1194:b0:1e2:d261:202b with SMTP id
 gk20-20020a17090b119400b001e2d261202bmr40852106pjb.25.1654412713030; Sun, 05
 Jun 2022 00:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220603143555.41914-1-sxwjean@me.com> <YpspHqZM27DeEhNR@n2.us-central1-a.c.spheric-algebra-350919.internal>
In-Reply-To: <YpspHqZM27DeEhNR@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Sun, 5 Jun 2022 15:04:44 +0800
Message-ID: <CAEVVKH_WM321zQPC-xjchqjySi4kngo6CFz-A6HY2tCjNCZ3SA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/slub: Simplify __kmem_cache_alias()
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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

On Sat, Jun 4, 2022 at 5:43 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Fri, Jun 03, 2022 at 10:35:55PM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > There is no need to do anything if sysfs_slab_alias() return nonzero
> > value after getting a mergeable cache.
> >
> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> > v2: Collect Reviewed-by tag from Muchun.
> > ---
> >  mm/slub.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index d8d5abf49f5f..9444277d669a 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> >
> >       s = find_mergeable(size, align, flags, name, ctor);
> >       if (s) {
> > +             if (sysfs_slab_alias(s, name))
> > +                     return NULL;
> > +
> >               s->refcount++;
> >
>
> I think we should not expose sysfs attributes before initializing
> what can be read via sysfs attribute (object_size).
>
> >               /*
> > @@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> >                */
> >               s->object_size = max(s->object_size, size);
>
> this calculation should be done before sysfs_slab_alias().

Yeah, understood. Should we restore s->object_size and s->inuse if
sysfs_slab_alias() returns non zero value?

Regards,
Xiongwwei

>
> Thanks,
> Hyeonggon
>
> >               s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
> > -
> > -             if (sysfs_slab_alias(s, name)) {
> > -                     s->refcount--;
> > -                     s = NULL;
> > -             }
> >       }
> >
> >       return s;
> > --
> > 2.30.2
> >
>
