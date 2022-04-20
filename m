Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6336850939E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383229AbiDTXdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDTXdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:33:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BB2ED42
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:30:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q1so2032212plx.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLshpcQDnpXfKVw8FlVeldYYjsS62gfK++RoyzE7fzI=;
        b=oN1RALoxj7uG5b822TkWSWP45NtB+Ln9k0aoSR3WnyYaApx1+JSppvo2ykhYM//PRc
         IN/5wlSvS2z2LAZkQ0diIyFPVUDxVUFtQBLURIZkvPbc7vELcQIxPiEEfjFMQ8UaHW/e
         lJXAfSbLS/qXG0XbLR8IGzvW5hdJ3jp3U8WYLfNWCll3eryaibcxuaZk+9cx2YtDGF67
         Q8qqx4JyiXCv6/ReHHFjKo1mog3EnbwYvdv4EXin04QCPlsXvw6+pZekC9jpOZQ51V+s
         p1WLH0nBkaZaBXW+UKvJrB28hqIYVFXxZK6LaQeuuYDLxdD8Ngo2cOEnYwVr2d9nfkHE
         a4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLshpcQDnpXfKVw8FlVeldYYjsS62gfK++RoyzE7fzI=;
        b=bYEKbP0+FyOVub1AXeGmzQvNk9Soo8O9f9wJ2MYgF7qK2vvC2feZ4RihXL5CHsWFLF
         myHudzhxi3wwLRZdtbECqlSCC8F6o3LeBXn0U1bXMmaF5zi93QglcVTf/ySxyR4bJiq+
         Y4HRwE7zd6yssVJb+zXknbnb1vPg3nk5Xuh4gOVtE+bWburfbivlnp4MEc/I6wnrQwHu
         VZucF9X6GC4w5uVPQq3Eu+KgFdP++0OL/dXfSEUYZzp8zajKv6/KU3yTVrIB8TRk25NO
         Vpew0lITpF2E3AXLo7DH3Fcjkf58ct7Sd5Voe+trqCRxdTW51x0+mg6XcWjmBQhxl02Y
         L0Jg==
X-Gm-Message-State: AOAM533yN1YwDVHb1kpWnPZw+FagVB0x8uQ3lmGqlZOpDv893gJzzFj5
        x4g6+2cXr7cxhGdw7IFVCAUthwK2GxwLstTWh+U=
X-Google-Smtp-Source: ABdhPJyWXDZORaeQ0qCu3csj9OQySHeqsHkp4w1tIylPxsLUuQagD/rZ3vVbcJzMbMl/q6KmzPH3s0pezJ5GqBbh1mo=
X-Received: by 2002:a17:90b:4a85:b0:1d2:aee9:23ce with SMTP id
 lp5-20020a17090b4a8500b001d2aee923cemr7161666pjb.99.1650497445807; Wed, 20
 Apr 2022 16:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220416004104.4089743-1-roman.gushchin@linux.dev>
 <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com> <Yl7mdguNR3CabMAN@carbon> <fc8161c7-61a5-d4c2-ae78-15deddfd9916@redhat.com>
In-Reply-To: <fc8161c7-61a5-d4c2-ae78-15deddfd9916@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Apr 2022 16:30:33 -0700
Message-ID: <CAHbLzkqCxFAbOPtyWOapSdPQ=hYewhr0insxi7G4fjwmC4H-Uw@mail.gmail.com>
Subject: Re: [PATCH] mm: do not call add_nr_deferred() with zero deferred
To:     David Hildenbrand <david@redhat.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 9:57 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.04.22 18:42, Roman Gushchin wrote:
> > On Tue, Apr 19, 2022 at 02:56:06PM +0200, David Hildenbrand wrote:
> >> On 16.04.22 02:41, Roman Gushchin wrote:
> >>> add_nr_deferred() is often called with next_deferred equal to 0.
> >>> For instance, it's happening under low memory pressure for any
> >>> shrinkers with a low number of cached objects. A corresponding trace
> >>> looks like:
> >>>   <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
> >>>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1            \
> >>>   unused scan count 0 new scan count 0 total_scan 0      \
> >>>   last shrinker return val 0
> >>>
> >>>   <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
> >>>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1            \
> >>>   unused scan count 0 new scan count 0 total_scan 0      \
> >>>   last shrinker return val 0
> >>>
> >>>   <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
> >>>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
> >>>   scan count 0 new scan count 0 total_scan 0                     \
> >>>   last shrinker return val 0
> >>>
> >>> This lead to unnecessary checks and atomic operations, which can be
> >>> avoided by checking next_deferred for not being zero before calling
> >>> add_nr_deferred(). In this case the mm_shrink_slab_end trace point
> >>> will get a potentially slightly outdated "new scan count" value, but
> >>> it's totally fine.
> >>
> >> Sufficient improvement to justify added complexity for anybody reading
> >> that code?
> >
> > I don't have any numbers and really doubt the difference is significant,
> > however the added complexity is also small: one "if" statement.
> > Anyway, if you feel strongly against this change, I'm fine with dropping it.
> >
>
> No strong opinion, naturally, more conditions make the code harder to
> read -- that's why I'm asking.

This is why that "if" was removed by commit 867508304685 ("mm: vmscan:
use per memcg nr_deferred of shrinker") since it didn't bring in
measurable performance improvement.

TBH I'm not sure whether it is worth it with no measurable performance
boost but harder to read code and potential outdated "new scan count".

>
> >>
> >>>
> >>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >>> ---
> >>>  mm/vmscan.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index d4a7d2bd276d..19d3d4fa1aad 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -808,7 +808,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>>      * move the unused scan count back into the shrinker in a
> >>>      * manner that handles concurrent updates.
> >>>      */
> >>> -   new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
> >>> +   if (next_deferred)
> >>> +           new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
> >>> +   else
> >>> +           new_nr = nr;
> >>>
> >>>     trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
> >>>     return freed;
> >>
> >> And if we still want to do this optimization, why not put it into
> >> add_nr_deferred()?
> >
> > Because of the semantics of add_nr_deferred(), which returns the deferred value.
> > It's not used for anything except tracing, so maybe it's a place for another
> > change.
>
> Skimming over the code I somehow missed that add_nr_deferred() doesn't
> have "nr" naturally available.
>
> LGTM
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
>
> --
> Thanks,
>
> David / dhildenb
>
