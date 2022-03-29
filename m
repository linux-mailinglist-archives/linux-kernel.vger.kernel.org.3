Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD74EA52B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiC2Cbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiC2Cbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:31:53 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE35243157
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:30:10 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:30:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648521008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLiZvfd0yntjpbK73RdD1dXH9eR5mDVIWo3N/ABg1M4=;
        b=uorpXYMJCZEdAyjI2ACmKLidQgvGNErgN940Cnd6pnnQdX6NhxiiFbU9N97BhIatQQhc32
        L5XlSHebtPX2h9Mql57GtMadHOkqhFXocUMKO1BGMb0s+3KlJag5yC+ZGsGp53hdDyqi+v
        5W3RUjE5sarmYMHeNjU5z+1KqNtjyU8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Message-ID: <YkJvLAeNXOXd1gk2@carbon.dhcp.thefacebook.com>
References: <20220309144000.1470138-1-longman@redhat.com>
 <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
 <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com>
 <CAMZfGtVG2YcmxY0fECkAYNb=sKXJQhWJqgtMTEpQwxXEXmSOLw@mail.gmail.com>
 <e93696b7-b678-6f41-9c1e-46aad447ce8d@redhat.com>
 <YkIIjGk5t4XorQXe@carbon.dhcp.thefacebook.com>
 <CAMZfGtXhoLso9FN_LwybqUHaZr28_hxmjeuA8T=zQdWWz=FDrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXhoLso9FN_LwybqUHaZr28_hxmjeuA8T=zQdWWz=FDrA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:15:46AM +0800, Muchun Song wrote:
> On Tue, Mar 29, 2022 at 3:12 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Sun, Mar 27, 2022 at 08:57:15PM -0400, Waiman Long wrote:
> > > On 3/22/22 22:12, Muchun Song wrote:
> > > > On Wed, Mar 23, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
> > > > > On 3/22/22 21:06, Muchun Song wrote:
> > > > > > On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
> > > > > > > Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> > > > > > > to be race free"), we are tracking the total number of lru
> > > > > > > entries in a list_lru_node in its nr_items field.  In the case of
> > > > > > > memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> > > > > > > is 0.  We don't even need to take the nlru->lock as no new lru entry
> > > > > > > could be added by a racing list_lru_add() to the draining src_idx memcg
> > > > > > > at this point.
> > > > > > Hi Waiman,
> > > > > >
> > > > > > Sorry for the late reply.  Quick question: what if there is an inflight
> > > > > > list_lru_add()?  How about the following race?
> > > > > >
> > > > > > CPU0:                               CPU1:
> > > > > > list_lru_add()
> > > > > >       spin_lock(&nlru->lock)
> > > > > >       l = list_lru_from_kmem(memcg)
> > > > > >                                       memcg_reparent_objcgs(memcg)
> > > > > >                                       memcg_reparent_list_lrus(memcg)
> > > > > >                                           memcg_reparent_list_lru()
> > > > > >                                               memcg_reparent_list_lru_node()
> > > > > >                                                   if (!READ_ONCE(nlru->nr_items))
> > > > > >                                                       // Miss reparenting
> > > > > >                                                       return
> > > > > >       // Assume 0->1
> > > > > >       l->nr_items++
> > > > > >       // Assume 0->1
> > > > > >       nlru->nr_items++
> > > > > >
> > > > > > IIUC, we use nlru->lock to serialise this scenario.
> > > > > I guess this race is theoretically possible but very unlikely since it
> > > > > means a very long pause between list_lru_from_kmem() and the increment
> > > > > of nr_items.
> > > > It is more possible in a VM.
> > > >
> > > > > How about the following changes to make sure that this race can't happen?
> > > > >
> > > > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > > > index c669d87001a6..c31a0a8ad4e7 100644
> > > > > --- a/mm/list_lru.c
> > > > > +++ b/mm/list_lru.c
> > > > > @@ -395,9 +395,10 @@ static void memcg_reparent_list_lru_node(struct
> > > > > list_lru *lru, int nid,
> > > > >           struct list_lru_one *src, *dst;
> > > > >
> > > > >           /*
> > > > > -        * If there is no lru entry in this nlru, we can skip it
> > > > > immediately.
> > > > > +        * If there is no lru entry in this nlru and the nlru->lock is free,
> > > > > +        * we can skip it immediately.
> > > > >            */
> > > > > -       if (!READ_ONCE(nlru->nr_items))
> > > > > +       if (!READ_ONCE(nlru->nr_items) && !spin_is_locked(&nlru->lock))
> > > > I think we also should insert a smp_rmb() between those two loads.
> > >
> > > Thinking about this some more, I believe that adding spin_is_locked() check
> > > will be enough for x86. However, that will likely not be enough for arches
> > > with a more relaxed memory semantics. So the safest way to avoid this
> > > possible race is to move the check to within the lock critical section,
> > > though that comes with a slightly higher overhead for the 0 nr_items case. I
> > > will send out a patch to correct that. Thanks for bring this possible race
> > > to my attention.
> >
> > Yes, I think it's not enough:
> 
> I think it may be enough if we insert a smp_rmb() between those two loads.
> 
> > CPU0                                       CPU1
> > READ_ONCE(&nlru->nr_items) -> 0
> >                                            spin_lock(&nlru->lock);
> >                                            nlru->nr_items++;
>                                              ^^^
>                                              |||
>                                              The nlr here is not the
> same as the one in CPU0,
>                                              since CPU0 have done the
> memcg reparting. Then
>                                              CPU0 will not miss nlru
> reparting.  If I am wrong, please
>                                              correct me.  Thanks.
> >                                            spin_unlock(&nlru->lock);
> > && !spin_is_locked(&nlru->lock) -> 0

Indeed, you're right.

Thanks!
