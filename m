Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6658C9D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbiHHNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243026AbiHHNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:55:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5B29F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:55:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso4529816wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSs1PwxK1pFEMPJMNC1f1b9KRjUrh6GnbVlzvd33lyE=;
        b=pr6raZNP0Wn3nSNWGMk+k/3sDBTd7KCY1cHNEnAnHGNGINF7WSen8W0MftMI68LJuj
         lMKThulhxZQZSK4hgS1QhXp+W/8IupTMBV2GcRXJXZSku8z6sLBkkGZmv6WAoif8SLQQ
         tMq2Za1hfylV+k7Z+wXmLzeUWxTMtch3aBRtD3JPdUVwQHZ/XwEhAMr656djEYOXhDvv
         DTY1x6s+0stEi154v2lGH31u86rwoNT/c4BhdA31BfF1+U1Gj40LCVF7/MZ1pfriuGfC
         hn8WpCAHApLW50MRXEKYYgQuY04MDMEwZIg4SfRVT+LYDthQrV9DysAevLSCcAgw6Fi1
         R5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSs1PwxK1pFEMPJMNC1f1b9KRjUrh6GnbVlzvd33lyE=;
        b=ZCKcY55RolT6kH43rftBw20ZNJjDAthkLArWSecTOsldHUuXP65MJxujpHsFWNpWMv
         JrSLsfiutoyXCbrSLs4wt+yY/xxQmNsnoYniOeGkZmQuMjDiVldb6UN/ASNuYvZkUrw+
         lZI7fkyTNiHvnpwsgieiiztbfhn1x0bz2Bf4AJ1nW01tz+mt65QLojfwZ/rrCQUgrHw2
         0Elj6aKpEvBa4cEsQXatmAXkdTJbsYeeS+kS6lCkkIzACjKgByBJzYvSvNHjH57502Yh
         /1u3ytUM9DKf1Z0eFMYlF7xm9DXPAFvsmP0ZV5wHU1Hyzg0mxMa6Fk15344DzGgAEsXp
         vnOA==
X-Gm-Message-State: ACgBeo0O5QmuQqJfnLXUXKX4VqTga5aoiegDE6iR/ZjoY6APFscHvpgk
        uCw3wVDj7mI/HQRmZgIXmOZMbItNHuOwQfcaww0l6Q==
X-Google-Smtp-Source: AA6agR4U5Cagc6pIRcc9v0pP5PrNdd6RKzAGHaRuoWXKlx3TxcMAAlwcDwpDuma61NIzgXkXM4sbNfJcGqXfRyMuFE0=
X-Received: by 2002:a05:600c:3d17:b0:3a3:2bc8:6132 with SMTP id
 bh23-20020a05600c3d1700b003a32bc86132mr12749249wmb.24.1659966922907; Mon, 08
 Aug 2022 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220802162811.39216-1-hannes@cmpxchg.org>
In-Reply-To: <20220802162811.39216-1-hannes@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 8 Aug 2022 06:54:46 -0700
Message-ID: <CAJD7tkYv3XohX6gpuwU64wh1pedrr+uFSUAD14sftThbZ1Vsuw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 9:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> During proactive reclaim, we sometimes observe severe overreclaim,
> with several thousand times more pages reclaimed than requested.
>
> This trace was obtained from shrink_lruvec() during such an instance:
>
>     prio:0 anon_cost:1141521 file_cost:7767
>     nr_reclaimed:4387406 nr_to_reclaim:1047 (or_factor:4190)
>     nr=[7161123 345 578 1111]
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
>
> Fairness is more subtle and harder to evaluate. No obvious misbehavior
> was observed on the test workload, in any case. Conceptually, fairness
> should primarily be a cumulative effect from regular, lower priority
> scans. Once the VM is in trouble and needs to escalate scan targets to
> make forward progress, fairness needs to take a backseat. This is also
> acknowledged by the myriad exceptions in get_scan_count(). This patch
> makes fairness decrease gradually, as it keeps fairness work static
> over increasing priority levels with growing scan targets. This should
> make more sense - although we may have to re-visit the exact values.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..1cc0c6666787 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2897,8 +2897,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>         enum lru_list lru;
>         unsigned long nr_reclaimed = 0;
>         unsigned long nr_to_reclaim = sc->nr_to_reclaim;
> +       bool proportional_reclaim;
>         struct blk_plug plug;
> -       bool scan_adjusted;
>
>         get_scan_count(lruvec, sc, nr);
>
> @@ -2916,8 +2916,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>          * abort proportional reclaim if either the file or anon lru has already
>          * dropped to zero at the first pass.
>          */
> -       scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
> -                        sc->priority == DEF_PRIORITY);
> +       proportional_reclaim = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
> +                               sc->priority == DEF_PRIORITY);
>
>         blk_start_plug(&plug);
>         while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
> @@ -2937,7 +2937,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>
>                 cond_resched();
>
> -               if (nr_reclaimed < nr_to_reclaim || scan_adjusted)
> +               if (nr_reclaimed < nr_to_reclaim || proportional_reclaim)
>                         continue;
>
>                 /*
> @@ -2988,8 +2988,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>                 nr_scanned = targets[lru] - nr[lru];
>                 nr[lru] = targets[lru] * (100 - percentage) / 100;
>                 nr[lru] -= min(nr[lru], nr_scanned);
> -
> -               scan_adjusted = true;

Thanks for the great analysis of the problem!

I have a question here. This fixes the overreclaim problem for
proactive reclaim (and most other scenarios), but what about the case
where proportional_reclaim (aka scan_adjusted) is set before we start
shrinking lrus: global direct reclaim on DEF_PRIORITY? If we hit a
memcg that has very few file pages and a ton of anon pages in this
scenario (or vice versa), wouldn't we still overreclaim and possibly
stall unnecessarily? or am I missing something here?

>         }
>         blk_finish_plug(&plug);
>         sc->nr_reclaimed += nr_reclaimed;
> --
> 2.37.1
>
>
