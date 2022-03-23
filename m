Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0684E4AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiCWCQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiCWCP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:15:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B18F70056
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:14:29 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2e64a6b20eeso2556427b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI0F2AuD6/hdoLjdWqIEQmO22+3iFJMOWkqzpVEzI/Q=;
        b=MZI37+o9fpZSLZbbVV1mjmO7ePcLcIW/aGJK1t/5qc24QTQ6Nl9cwOFGGTbuV8+DDn
         dbPjcoiFCZlgEnx4rE003FDhDlxTDe5XtIvbst5iaaxZEaZ9OJTZA+miiI32wSD/ANv/
         8jSYj3ue4jMAL9ImwFMwhqQQyHXAEW7i3Z7oqT+JyQg+wNa9GAH2CSp2OukSON2ehUQq
         XW3Os0ClM1GAeYXw4G6VePWwd43j/4BQTRHojzXIiKK/IdlpR+b2jV1psoJRaFfgN54i
         fZEP3aNmzuMW6ObDL0NkXMi3rhq9T3K1ire9AwY+u+datYf/mFK1u8V0WNNni523LXQI
         +keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI0F2AuD6/hdoLjdWqIEQmO22+3iFJMOWkqzpVEzI/Q=;
        b=yGN5TUyedCQCsJ7/+B3pxzDP514CctytNTpBIA7jzqihBOsajmUX5CPA5Mm50I2ktZ
         eTwiZV+w5jMhT9IKn6QKFwiqSwc3/tWAMsVCToPq8d7P3lsCDZC0JNc9oAIhB3mtY78Y
         g8V9Rv1+p23eE+zURSJ94u07OwhN4WVHE5aYs12nmH00j3IqUHDCrmOgxRyHHvgRIxbp
         PnKYzBRPDHeeb3CjEXko+cVYDOUHiKmVRH1Nk9fE4BWMJdUCi/JyTntJAun18uAnxtKN
         zMnM/VOoYcgp1MSxcY9EbB5XZLzw1LKLzvJP7yT3jP5ejzz9aJAmNzrhl16cbfbNGgMQ
         5ELA==
X-Gm-Message-State: AOAM531A7OLNEJYoyZoSvVj0quG2hp/feWqBLHOnnsBD4r1eEetXIZ40
        ijWk3ZcdHRGgzaM3rpO1SiLAO1NTjqeuMDKV21OUGA==
X-Google-Smtp-Source: ABdhPJwZhduYtEgTd/LkiHt2OKyrlVJ9+49tpctzXbSOr3Bagl4Oo2yWk04BtfW/xhTTdHfexyqoJ4IPeHc876MoEQk=
X-Received: by 2002:a05:690c:827:b0:2e5:a53b:cffc with SMTP id
 by7-20020a05690c082700b002e5a53bcffcmr31806260ywb.31.1648001668809; Tue, 22
 Mar 2022 19:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220309144000.1470138-1-longman@redhat.com> <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
 <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com>
In-Reply-To: <2263666d-5eef-b1fe-d5e3-b166a3185263@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 23 Mar 2022 10:12:32 +0800
Message-ID: <CAMZfGtVG2YcmxY0fECkAYNb=sKXJQhWJqgtMTEpQwxXEXmSOLw@mail.gmail.com>
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize memcg_reparent_list_lru_node()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 9:55 AM Waiman Long <longman@redhat.com> wrote:
>
> On 3/22/22 21:06, Muchun Song wrote:
> > On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
> >> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> >> to be race free"), we are tracking the total number of lru
> >> entries in a list_lru_node in its nr_items field.  In the case of
> >> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> >> is 0.  We don't even need to take the nlru->lock as no new lru entry
> >> could be added by a racing list_lru_add() to the draining src_idx memcg
> >> at this point.
> > Hi Waiman,
> >
> > Sorry for the late reply.  Quick question: what if there is an inflight
> > list_lru_add()?  How about the following race?
> >
> > CPU0:                               CPU1:
> > list_lru_add()
> >      spin_lock(&nlru->lock)
> >      l = list_lru_from_kmem(memcg)
> >                                      memcg_reparent_objcgs(memcg)
> >                                      memcg_reparent_list_lrus(memcg)
> >                                          memcg_reparent_list_lru()
> >                                              memcg_reparent_list_lru_node()
> >                                                  if (!READ_ONCE(nlru->nr_items))
> >                                                      // Miss reparenting
> >                                                      return
> >      // Assume 0->1
> >      l->nr_items++
> >      // Assume 0->1
> >      nlru->nr_items++
> >
> > IIUC, we use nlru->lock to serialise this scenario.
>
> I guess this race is theoretically possible but very unlikely since it
> means a very long pause between list_lru_from_kmem() and the increment
> of nr_items.

It is more possible in a VM.

>
> How about the following changes to make sure that this race can't happen?
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index c669d87001a6..c31a0a8ad4e7 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -395,9 +395,10 @@ static void memcg_reparent_list_lru_node(struct
> list_lru *lru, int nid,
>          struct list_lru_one *src, *dst;
>
>          /*
> -        * If there is no lru entry in this nlru, we can skip it
> immediately.
> +        * If there is no lru entry in this nlru and the nlru->lock is free,
> +        * we can skip it immediately.
>           */
> -       if (!READ_ONCE(nlru->nr_items))
> +       if (!READ_ONCE(nlru->nr_items) && !spin_is_locked(&nlru->lock))

I think we also should insert a smp_rmb() between those two loads.

Thanks.
