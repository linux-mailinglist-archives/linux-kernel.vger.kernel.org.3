Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B677E561E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiF3O4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiF3O4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:56:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9DC1BEAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:56:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s10so23433472ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipNBTkHp2jS0+JttebnQfFLWG27OJJNBttsPzJH3qb0=;
        b=pgF8MbXGCCzbjeNDnKq+15lZDcZpjlPbZ133zcnyP2hhvSfUAm6yVILAKDi0XiiMcI
         yCFUl0kRtXWtS3przUPtG5c3sWlxKkM63L5r3UEA0VKoNsXCjfTR/HULCXz8K4OkMvnd
         tJFt94a2qUqPLZ5CpF60K5NrAp+5bTlP/gZkh8ub4itlVXmihRdUYhnTtvY8AGiQdbY/
         lF0XeNS2A/mxvuwTNT/2zZcfYVZiZiuYeYFRczsjPquKw/KMMjYZiiD3sI1pFg+Wi68M
         RKRtDhM93zoHtABy8UsTOs32gguu+E/BaH8wy/56KtZBpYBFfdQ3LEyM6U52wT+lHLIp
         r3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipNBTkHp2jS0+JttebnQfFLWG27OJJNBttsPzJH3qb0=;
        b=ZQKOhiszvfHk0WplQBsnGuRttyMp4sLioZ5vIl+0EK2ZtA1KR/mg7fnRWLRRnq2uS6
         /aPuMpOy0Le6NEIRt5Ua7aWhvVd2sUUZX+sOXfuAVJSjf38Z+flU+t1WqFeMTHo7mRCu
         zycKqIxClHHExJunbKDeYgnTa9zl3awJ4ad/QHWpcE83oQR5KizHXjGUy9jGgSMk083p
         9Y6waRkSF1PmXJfO7hEUcJ3ntHUpOta5Zk/6zG1wZnSCpEVY5Ifgt7vGfhc/6P2tydm+
         cGo0ooTQvO6tw31wYPYw1V84ND5JuoevZl99Y5ZF+IFjI/21XEi0yp8zsIykeusecCsZ
         6D3w==
X-Gm-Message-State: AJIora+RE4MW0evSVAzXLDJSqsNKLSkspGNgsaj0G+jYyaw6JOjO7TeA
        BYrI7STv7zljUmCdi3oXnJgKK/Pq46YsBBYJZdA=
X-Google-Smtp-Source: AGRyM1vxz4+4rQNp1pA9fie+azvy7uthbp37IA/SFg0MMtMDSSosZP+hMp47O1t6HsCrfg9y0DOhPh2xDOKHRWHXWCw=
X-Received: by 2002:a2e:804b:0:b0:25a:7502:6bd3 with SMTP id
 p11-20020a2e804b000000b0025a75026bd3mr5428568ljg.455.1656600980868; Thu, 30
 Jun 2022 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220630014715.73330-1-feng.tang@intel.com> <Yr21Ymj5uZfFearE@hyeyoo>
In-Reply-To: <Yr21Ymj5uZfFearE@hyeyoo>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Thu, 30 Jun 2022 23:55:59 +0900
Message-ID: <CAB=+i9RhuAi-w3XbXO5236WFeg04A6ra_xG9o_-DkMaRBFMKGw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:38 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
[...]
> > @@ -5138,11 +5146,12 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >               if (pos == end)
> >                       break;
> >
> > -             caddr = t->loc[pos].addr;
> > -             chandle = t->loc[pos].handle;
> > -             if ((track->addr == caddr) && (handle == chandle)) {
> > +             l = &t->loc[pos];
> > +             caddr = l->addr;
> > +             chandle = l->handle;
> > +             if ((track->addr == caddr) && (handle == chandle) &&
> > +                     (track->waste == l->waste)) {
> >
> > -                     l = &t->loc[pos];
> >                       l->count++;
> >                       if (track->when) {
> >                               l->sum_time += age;
> > @@ -5190,6 +5199,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >       l->min_pid = track->pid;
> >       l->max_pid = track->pid;
> >       l->handle = handle;
> > +     l->waste = track->waste;
>
> I think this may be fooled when there are different wastes values
> from same caller (i.e. when a kmalloc_track_caller() is used.)
> because the array is sorted by caller address, but not sorted by waste.
>
> And writing this I noticed that it already can be fooled now :)
> It's also not sorted by handle.

I misread the code. it's not fooled now. the array is also sorted by handle.
But will be fooled after this patch.

> --
> Thanks,
> Hyeonggon
