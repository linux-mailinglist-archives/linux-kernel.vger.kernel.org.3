Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA95899FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiHDJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiHDJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:39:11 -0400
Received: from outbound-smtp63.blacknight.com (outbound-smtp63.blacknight.com [46.22.136.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BD4199C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:39:09 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id D6225FAC38
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:39:07 +0100 (IST)
Received: (qmail 5340 invoked from network); 4 Aug 2022 09:39:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2022 09:39:07 -0000
Date:   Thu, 4 Aug 2022 10:38:00 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
Message-ID: <20220804093800.yrmkcspzb35gvnfp@techsingularity.net>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220802162811.39216-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 12:28:11PM -0400, Johannes Weiner wrote:
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

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
