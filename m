Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D64EA48A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiC2BSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiC2BSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:18:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8E158549
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:16:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id u103so29043436ybi.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zwu3XKULS8U30OwraF1iiw389ON7pbWs5Vs9uX3Un3w=;
        b=NXRYDMqq4mPKUo/RpS2FpW8SNSB+THVkJiR1Mv5X4wGnqJ4ICvgSbAUh98hyO0HhGG
         XkZ48q2S6FM3QmbuztO6R6EViL+75bmfN1QD/hW6z6U+QkoZOWpz4j9lEjQuSFcwfJG6
         YC3yeQI0D8Ws6UvLPMFr+ptGKsHoO8OfIr5OfcCrdWRjQOu4eiKyPOZxKimduOrI7YAN
         t6wPDpEiPJzH5pvpbHZwX/IavvzDl9lO1eNY7JfOZ3w8toiq8WycHvr02MWGVGPwvQzl
         gWmXA/6pBoeg3GTslEySL77AklUCT1Ah51TwlnUGilO1x73gXeaUcqCmiQ/JIwrDagsg
         HL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zwu3XKULS8U30OwraF1iiw389ON7pbWs5Vs9uX3Un3w=;
        b=qGd9TbM7awciR9IgFlPW1jV3FjN5R3K0B+3v0h28gRMt/5j0pVw/N7u8Yl2J8ZolYq
         yGlqeiYdchW0cyt0wvdlhRNhKzpu+X6pftIGPWpgyEgi3UA98CC5MH7CJO0Uzbbknz43
         1U8fay7flqNsDJE9y0QBQSrIlAWvoZ0nvqrmHqlov7S14Lg1UthQ7KhjPPUYDIDB6Vvk
         4MWZkuMG+Bwcv9jPbEKrfiOYFDX8fhTrnN/DuJ7f9S8ptHiQrBpF/LkBkP93Xy7NB5zb
         MieqqIdYU2BQ3A9ISjqnVjvVg9LLM2dixLSbjwBWswSmKHrjVPWM3nn6SRlPY632q1nN
         bCrw==
X-Gm-Message-State: AOAM533QAfpjUd9NUZcuf08bUgVtwJeN4mVyRT3L1RdyW2ifM8YaJu9C
        9Qk9lI9AZrwB89trkTO7aETBnZBNUqsKLOcPRrfUC4kgWY89qA==
X-Google-Smtp-Source: ABdhPJz4seBVkr/ttrdizTfYtE+XP5Gc9E/tANr44pvUPauLkUitraxMu7t8Je0S5i7qXGy+zGH+LAJYPRj28AWXTLU=
X-Received: by 2002:a05:6902:70c:b0:634:73ef:e663 with SMTP id
 k12-20020a056902070c00b0063473efe663mr27115081ybt.246.1648516582878; Mon, 28
 Mar 2022 18:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220309144000.1470138-1-longman@redhat.com> <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
 <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com> <CAMZfGtVG2YcmxY0fECkAYNb=sKXJQhWJqgtMTEpQwxXEXmSOLw@mail.gmail.com>
 <e93696b7-b678-6f41-9c1e-46aad447ce8d@redhat.com> <YkIIjGk5t4XorQXe@carbon.dhcp.thefacebook.com>
In-Reply-To: <YkIIjGk5t4XorQXe@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 29 Mar 2022 09:15:46 +0800
Message-ID: <CAMZfGtXhoLso9FN_LwybqUHaZr28_hxmjeuA8T=zQdWWz=FDrA@mail.gmail.com>
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize memcg_reparent_list_lru_node()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 3:12 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Sun, Mar 27, 2022 at 08:57:15PM -0400, Waiman Long wrote:
> > On 3/22/22 22:12, Muchun Song wrote:
> > > On Wed, Mar 23, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
> > > > On 3/22/22 21:06, Muchun Song wrote:
> > > > > On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
> > > > > > Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> > > > > > to be race free"), we are tracking the total number of lru
> > > > > > entries in a list_lru_node in its nr_items field.  In the case of
> > > > > > memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> > > > > > is 0.  We don't even need to take the nlru->lock as no new lru entry
> > > > > > could be added by a racing list_lru_add() to the draining src_idx memcg
> > > > > > at this point.
> > > > > Hi Waiman,
> > > > >
> > > > > Sorry for the late reply.  Quick question: what if there is an inflight
> > > > > list_lru_add()?  How about the following race?
> > > > >
> > > > > CPU0:                               CPU1:
> > > > > list_lru_add()
> > > > >       spin_lock(&nlru->lock)
> > > > >       l = list_lru_from_kmem(memcg)
> > > > >                                       memcg_reparent_objcgs(memcg)
> > > > >                                       memcg_reparent_list_lrus(memcg)
> > > > >                                           memcg_reparent_list_lru()
> > > > >                                               memcg_reparent_list_lru_node()
> > > > >                                                   if (!READ_ONCE(nlru->nr_items))
> > > > >                                                       // Miss reparenting
> > > > >                                                       return
> > > > >       // Assume 0->1
> > > > >       l->nr_items++
> > > > >       // Assume 0->1
> > > > >       nlru->nr_items++
> > > > >
> > > > > IIUC, we use nlru->lock to serialise this scenario.
> > > > I guess this race is theoretically possible but very unlikely since it
> > > > means a very long pause between list_lru_from_kmem() and the increment
> > > > of nr_items.
> > > It is more possible in a VM.
> > >
> > > > How about the following changes to make sure that this race can't happen?
> > > >
> > > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > > index c669d87001a6..c31a0a8ad4e7 100644
> > > > --- a/mm/list_lru.c
> > > > +++ b/mm/list_lru.c
> > > > @@ -395,9 +395,10 @@ static void memcg_reparent_list_lru_node(struct
> > > > list_lru *lru, int nid,
> > > >           struct list_lru_one *src, *dst;
> > > >
> > > >           /*
> > > > -        * If there is no lru entry in this nlru, we can skip it
> > > > immediately.
> > > > +        * If there is no lru entry in this nlru and the nlru->lock is free,
> > > > +        * we can skip it immediately.
> > > >            */
> > > > -       if (!READ_ONCE(nlru->nr_items))
> > > > +       if (!READ_ONCE(nlru->nr_items) && !spin_is_locked(&nlru->lock))
> > > I think we also should insert a smp_rmb() between those two loads.
> >
> > Thinking about this some more, I believe that adding spin_is_locked() check
> > will be enough for x86. However, that will likely not be enough for arches
> > with a more relaxed memory semantics. So the safest way to avoid this
> > possible race is to move the check to within the lock critical section,
> > though that comes with a slightly higher overhead for the 0 nr_items case. I
> > will send out a patch to correct that. Thanks for bring this possible race
> > to my attention.
>
> Yes, I think it's not enough:

I think it may be enough if we insert a smp_rmb() between those two loads.

> CPU0                                       CPU1
> READ_ONCE(&nlru->nr_items) -> 0
>                                            spin_lock(&nlru->lock);
>                                            nlru->nr_items++;
                                             ^^^
                                             |||
                                             The nlr here is not the
same as the one in CPU0,
                                             since CPU0 have done the
memcg reparting. Then
                                             CPU0 will not miss nlru
reparting.  If I am wrong, please
                                             correct me.  Thanks.
>                                            spin_unlock(&nlru->lock);
> && !spin_is_locked(&nlru->lock) -> 0
