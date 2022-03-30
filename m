Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D414EBAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbiC3GlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiC3Gky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:40:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826BE21267
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:39:08 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2e592e700acso207650237b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jpIraTYVy4+KW5tVKFlrsJ4TJFxRhQCZzwCcMrDysQ=;
        b=MEWKTEvCsDle3dITB/iGqmG2nuVbFY4r/X0tW7OvlvsFQBtdzGiCXPUGGGi44lgkSG
         gwBxZJiKD3ibwUHdcdWOoBGjtSk+1IvNkRvPgX/cBIU2ZHktfy3qksn80JuQxFXjbAVz
         6oueOewMLxUJcQwQpz8VZ5Cdo4lJMtA7Z6FnvvppcNb8xtaoXpkjHyzZxKIPyAJIgTrb
         POFS5tYdMogwTcND4whrMguNp1FuZ29UKcLkklEG/QM/Ypyx+jevZ3G5znphjgvAFO75
         GiMR2gj09qMPA30TrN4oz/dUw9hVAlOUei7RzwpHDuHZZoWFdUpnmNdKhHAMOIeECO0Z
         l/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jpIraTYVy4+KW5tVKFlrsJ4TJFxRhQCZzwCcMrDysQ=;
        b=QifDReleayV5UiZbbxTCQ3kUXEMTHS2QebctlWSRK+S54rjkItTZyjSyG8hbMSuq9v
         ZDyMTs/Pu6DmNPE/5ZfxDFLYBZChxDbmJg7iZt/Q+3CKjX0Pu00WVI3Q1xrkQ19wdjna
         V6JjImLGaTM47PRyDPJKDKoPmDVplgUR1MviF2sy5/EwGLn78WanZ4UYggtgnlPJS4k5
         S8G9EA7GqBgEsnay4H1Q2Fob/PUdnxqXXqw3TP/bu89MzIe+p1jW8IFsKZv0HbaULS3e
         8j2H34UShfaukuZbY6wnfXIMKUM+34UGkKJbGg7xZRawik/eleVSiKIv9aFBRgCCY9MW
         /SjA==
X-Gm-Message-State: AOAM533G7+JJ2CbcXtjVKpFG6ynYZpiA/IAy5SzI9Toy1BFkyQ6aVF3c
        8kD7boAAsimALPJZUi5MtAN0uHXSLPnXC62ktIXtDw==
X-Google-Smtp-Source: ABdhPJy3q4c0i4haH+2YtHMErDDuUpBmlm9A2lJLAWorkvOk6avqxhd4F1PThmNVEhAdzByl9EYgJKp6AkzQAFbciKM=
X-Received: by 2002:a0d:ccca:0:b0:2e6:2b53:3f16 with SMTP id
 o193-20020a0dccca000000b002e62b533f16mr35680433ywd.35.1648622347570; Tue, 29
 Mar 2022 23:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220309144000.1470138-1-longman@redhat.com> <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
 <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com> <CAMZfGtVG2YcmxY0fECkAYNb=sKXJQhWJqgtMTEpQwxXEXmSOLw@mail.gmail.com>
 <e93696b7-b678-6f41-9c1e-46aad447ce8d@redhat.com> <YkIIjGk5t4XorQXe@carbon.dhcp.thefacebook.com>
 <CAMZfGtXhoLso9FN_LwybqUHaZr28_hxmjeuA8T=zQdWWz=FDrA@mail.gmail.com> <07be89ad-e355-69b9-6e36-07beaebf2d8b@redhat.com>
In-Reply-To: <07be89ad-e355-69b9-6e36-07beaebf2d8b@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 30 Mar 2022 14:38:31 +0800
Message-ID: <CAMZfGtXYH8Lex3hZGW4V8AzmqR03uzJnrBz8z7_1FD_P3Lgk-A@mail.gmail.com>
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize memcg_reparent_list_lru_node()
To:     Waiman Long <longman@redhat.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
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

On Wed, Mar 30, 2022 at 5:53 AM Waiman Long <longman@redhat.com> wrote:
>
> On 3/28/22 21:15, Muchun Song wrote:
> > On Tue, Mar 29, 2022 at 3:12 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >> On Sun, Mar 27, 2022 at 08:57:15PM -0400, Waiman Long wrote:
> >>> On 3/22/22 22:12, Muchun Song wrote:
> >>>> On Wed, Mar 23, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
> >>>>> On 3/22/22 21:06, Muchun Song wrote:
> >>>>>> On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
> >>>>>>> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> >>>>>>> to be race free"), we are tracking the total number of lru
> >>>>>>> entries in a list_lru_node in its nr_items field.  In the case of
> >>>>>>> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> >>>>>>> is 0.  We don't even need to take the nlru->lock as no new lru entry
> >>>>>>> could be added by a racing list_lru_add() to the draining src_idx memcg
> >>>>>>> at this point.
> >>>>>> Hi Waiman,
> >>>>>>
> >>>>>> Sorry for the late reply.  Quick question: what if there is an inflight
> >>>>>> list_lru_add()?  How about the following race?
> >>>>>>
> >>>>>> CPU0:                               CPU1:
> >>>>>> list_lru_add()
> >>>>>>        spin_lock(&nlru->lock)
> >>>>>>        l = list_lru_from_kmem(memcg)
> >>>>>>                                        memcg_reparent_objcgs(memcg)
> >>>>>>                                        memcg_reparent_list_lrus(memcg)
> >>>>>>                                            memcg_reparent_list_lru()
> >>>>>>                                                memcg_reparent_list_lru_node()
> >>>>>>                                                    if (!READ_ONCE(nlru->nr_items))
> >>>>>>                                                        // Miss reparenting
> >>>>>>                                                        return
> >>>>>>        // Assume 0->1
> >>>>>>        l->nr_items++
> >>>>>>        // Assume 0->1
> >>>>>>        nlru->nr_items++
> >>>>>>
> >>>>>> IIUC, we use nlru->lock to serialise this scenario.
> >>>>> I guess this race is theoretically possible but very unlikely since it
> >>>>> means a very long pause between list_lru_from_kmem() and the increment
> >>>>> of nr_items.
> >>>> It is more possible in a VM.
> >>>>
> >>>>> How about the following changes to make sure that this race can't happen?
> >>>>>
> >>>>> diff --git a/mm/list_lru.c b/mm/list_lru.c
> >>>>> index c669d87001a6..c31a0a8ad4e7 100644
> >>>>> --- a/mm/list_lru.c
> >>>>> +++ b/mm/list_lru.c
> >>>>> @@ -395,9 +395,10 @@ static void memcg_reparent_list_lru_node(struct
> >>>>> list_lru *lru, int nid,
> >>>>>            struct list_lru_one *src, *dst;
> >>>>>
> >>>>>            /*
> >>>>> -        * If there is no lru entry in this nlru, we can skip it
> >>>>> immediately.
> >>>>> +        * If there is no lru entry in this nlru and the nlru->lock is free,
> >>>>> +        * we can skip it immediately.
> >>>>>             */
> >>>>> -       if (!READ_ONCE(nlru->nr_items))
> >>>>> +       if (!READ_ONCE(nlru->nr_items) && !spin_is_locked(&nlru->lock))
> >>>> I think we also should insert a smp_rmb() between those two loads.
> >>> Thinking about this some more, I believe that adding spin_is_locked() check
> >>> will be enough for x86. However, that will likely not be enough for arches
> >>> with a more relaxed memory semantics. So the safest way to avoid this
> >>> possible race is to move the check to within the lock critical section,
> >>> though that comes with a slightly higher overhead for the 0 nr_items case. I
> >>> will send out a patch to correct that. Thanks for bring this possible race
> >>> to my attention.
> >> Yes, I think it's not enough:
> > I think it may be enough if we insert a smp_rmb() between those two loads.
> >
> >> CPU0                                       CPU1
> >> READ_ONCE(&nlru->nr_items) -> 0
> >>                                             spin_lock(&nlru->lock);
> >>                                             nlru->nr_items++;
> >                                               ^^^
> >                                               |||
> >                                               The nlr here is not the
> > same as the one in CPU0,
> >                                               since CPU0 have done the
> > memcg reparting. Then
> >                                               CPU0 will not miss nlru
> > reparting.  If I am wrong, please
> >                                               correct me.  Thanks.
> >>                                             spin_unlock(&nlru->lock);
> >> && !spin_is_locked(&nlru->lock) -> 0
>
> I just realize that there is another lock/unlock pair in
> memcg_reparent_objcgs():
>
> memcg_reparent_objcgs()
>      spin_lock_irq()
>      memcg reparenting
>      spin_unlock_irq()
>      percpu_ref_kill()
>          spin_lock_irqsave()
>          ...
>          spin_unlock_irqrestore()
>
> This lock/unlock pair in percpu_ref_kill() will stop the reordering of
> read/write before the memcg reparenting. Now I think just adding a
> spin_is_locked() check with smp_rmb() should be enough. However, I would
> like to change the ordering like that:
>
> if (!spin_is_locked(&nlru->lock)) {
>          smp_rmb();
>          if (!READ_ONCE(nlru->nr_items))
>                  return;
> }

Does the following race still exist?

 CPU0:                               CPU1:
                                        spin_is_locked(&nlru->lock)
 list_lru_add()
        spin_lock(&nlru->lock)
        l = list_lru_from_kmem(memcg)
                                        memcg_reparent_objcgs(memcg)
                                        memcg_reparent_list_lrus(memcg)
                                            memcg_reparent_list_lru()
                                                memcg_reparent_list_lru_node()
                                                    if
(!READ_ONCE(nlru->nr_items))
                                                        // Miss reparenting
                                                        return
        // Assume 0->1
        l->nr_items++
        // Assume 0->1
        nlru->nr_items++

>
> Otherwise, we will have the problem
>
> list_lru_add()
>        spin_lock(&nlru->lock)
>        l = list_lru_from_kmem(memcg)
> READ_ONCE(nlru->nr_items);
>        // Assume 0->1
>        l->nr_items++
>        // Assume 0->1
>        nlru->nr_items++
>        spin_unlock(&nlru->lock)
>                                        spin_is_locked()

You are right.

>
> If spin_is_locked() is before spin_lock() in list_lru_add(),
> list_lru_from_kmem() is guarantee to get the reparented memcg and so
> won't added to the reparented lru.
>
