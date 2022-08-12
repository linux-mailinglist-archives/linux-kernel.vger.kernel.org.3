Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660BC590A11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiHLB72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiHLB7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:59:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14291A1D75
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:59:24 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q124so16085837iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=oSw6WlkAUxMLovhbR4EwtYSMttJVtZ2/Z19F1mzc4wA=;
        b=dMk83l+cUE/hNYsU2SQ5z6Q76Ir72gp7RFBEUWTd11108O0TSD/hOdf7ZK0+rBumXh
         IAqBOdbqkss4QfBReDVKkgqM+ayhNtB2hjIbdp9p1ZCVwozhu1EC5a5ACGNXbKbefNLU
         d/Iy146noeefl/taolaSMO9iqgzrFDXEw6ekbH42BWfRQbV2+4EUMD4gnq5/ZNvvIBGo
         V/7VSn33EFsZS2Gk730iq+Pwco2bTRKjHYMi2R3F2Em4rHud2lTFlCOM2ou2wJqx4CEG
         r5qiSNLWY+fwXn6saE1eKATTgZNQi9IyIE2veAmYestQ7i9aA5DHX31C0jpFawTNIokD
         IQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=oSw6WlkAUxMLovhbR4EwtYSMttJVtZ2/Z19F1mzc4wA=;
        b=pYBwc32/VqyFICc1za0RK3fOd8WPTVdOyUECTz+cpDPzwaV9a7g5qo/ICpiODfBdbG
         1LQV55Z7FAF2aB46yWVcLQGaxkc2kV/tchsSWZqWg1ZHv46ON4dp6uSCLnupFTIqO94D
         GKrRQoRRPISMzXyq0WK74VJ80ZJAqMH9mKSTWrHB+ihU+t8mvAPRHRk6XxppMYqSDJad
         MekUeJwcK0G3q4EvbvrRCtMC6RevqxtpN3/jHcKJTtiycd98ECvYHA3EtTKThKcYhr7u
         2XiW8HkRnkImCA0QUbY3rpFvdilSuZ6yjg/dCzlmpXu2C3AzH+eiR8g9FQVtmVO2eLzW
         H0vQ==
X-Gm-Message-State: ACgBeo0PJUAcwmbRSOzXZ5165pUEdTWCVU/0SGF13/jrWWUZXGZIdK7G
        pq93ZLfs+IZYxlCxrXZMbse0hKh79cG7jU2Wt6k=
X-Google-Smtp-Source: AA6agR7B6GY6uGxR1IXliaW/sUKLDnfQFmwi1TY2Ai9+pOraXtlKOt/0Ihs19vP+xwlpLB4bISp0mAu7aXxkh/5hPMU=
X-Received: by 2002:a05:6638:5a4:b0:342:7040:9a04 with SMTP id
 b4-20020a05663805a400b0034270409a04mr990124jar.196.1660269563347; Thu, 11 Aug
 2022 18:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220802162811.39216-1-hannes@cmpxchg.org>
In-Reply-To: <20220802162811.39216-1-hannes@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 12 Aug 2022 10:59:12 +0900
Message-ID: <CAAmzW4OBYPkjPBdhV5H-yhsmzisw8ZdTTsj=QzbW8grY8RqkJQ@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:28, Jo=
hannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> During proactive reclaim, we sometimes observe severe overreclaim,
> with several thousand times more pages reclaimed than requested.
>
> This trace was obtained from shrink_lruvec() during such an instance:
>
>     prio:0 anon_cost:1141521 file_cost:7767
>     nr_reclaimed:4387406 nr_to_reclaim:1047 (or_factor:4190)
>     nr=3D[7161123 345 578 1111]
>
> While he reclaimer requested 4M, vmscan reclaimed close to 16G, most
> of it by swapping. These requests take over a minute, during which the
> write() to memory.reclaim is unkillably stuck inside the kernel.
>
> Digging into the source, this is caused by the proportional reclaim
> bailout logic. This code tries to resolve a fundamental conflict: to
> reclaim roughly what was requested, while also aging all LRUs fairly
> and in accordance to their size, swappiness, refault rates etc. The
> way it attempts fairness is that once the reclaim goal has been
> reached, it stops scanning the LRUs with the smaller remaining scan
> targets, and adjusts the remainder of the bigger LRUs according to how
> much of the smaller LRUs was scanned. It then finishes scanning that
> remainder regardless of the reclaim goal.
>
> This works fine if priority levels are low and the LRU lists are
> comparable in size. However, in this instance, the cgroup that is
> targeted by proactive reclaim has almost no files left - they've
> already been squeezed out by proactive reclaim earlier - and the
> remaining anon pages are hot. Anon rotations cause the priority level
> to drop to 0, which results in reclaim targeting all of anon (a lot)
> and all of file (almost nothing). By the time reclaim decides to bail,
> it has scanned most or all of the file target, and therefor must also
> scan most or all of the enormous anon target. This target is thousands
> of times larger than the reclaim goal, thus causing the overreclaim.
>
> The bailout code hasn't changed in years, why is this failing now?
> The most likely explanations are two other recent changes in anon
> reclaim:
>
> 1. Before the series starting with commit 5df741963d52 ("mm: fix LRU
>    balancing effect of new transparent huge pages"), the VM was
>    overall relatively reluctant to swap at all, even if swap was
>    configured. This means the LRU balancing code didn't come into play
>    as often as it does now, and mostly in high pressure situations
>    where pronounced swap activity wouldn't be as surprising.
>
> 2. For historic reasons, shrink_lruvec() loops on the scan targets of
>    all LRU lists except the active anon one, meaning it would bail if
>    the only remaining pages to scan were active anon - even if there
>    were a lot of them.
>
>    Before the series starting with commit ccc5dc67340c ("mm/vmscan:
>    make active/inactive ratio as 1:1 for anon lru"), most anon pages
>    would live on the active LRU; the inactive one would contain only a
>    handful of preselected reclaim candidates. After the series, anon
>    gets aged similarly to file, and the inactive list is the default
>    for new anon pages as well, making it often the much bigger list.
>
>    As a result, the VM is now more likely to actually finish large
>    anon targets than before.
>
> Change the code such that only one SWAP_CLUSTER_MAX-sized nudge toward
> the larger LRU lists is made before bailing out on a met reclaim goal.
>
> This fixes the extreme overreclaim problem.

I think that we can fix the issue without breaking the fairness.
Key idea is that doing scan based on the lru having max scan count.
(aka max-lru)
As scan is doing on max-lru, do scan the proportional number of
pages on other lru.

Pseudo code is here.

1. find the lru having max scan count
2. calculate nr_to_scan_max for max-lru
3. prop =3D (scanned[max-lru] + nr_to_scan_max) / targets[max-lru]
3. for_each_lru()
3-1. nr_to_scan =3D (targets[lru] * prop) - scanned[lru]
3-2. shrink_list(nr_to_scan)

With this approach, we can minimize reclaim without breaking the
fairness.

Note that actual code needs to handle some corner cases, one of it is
a low-nr_to_scan case to improve performance.

Thanks.
