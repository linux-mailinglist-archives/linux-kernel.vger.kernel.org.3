Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E184758803B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiHBQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHBQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:28:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7211EADC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:28:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e16so11000218qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2DU8LSMpwhI42VEzkmQDivhyfVLUKtdex6r6frtpBtk=;
        b=Hz4tGLPdmHI5Ynw233elpIWwl+IpLPuYjEvvnz6WSDcQf/94BXv1qgzKy6MtcKo+HZ
         eNS8xFEqLWEuuwbCRwG2IeGzNAFntMpC9A0GN+YBE5W7rNHzxYS6ZDJBfGrcS8NXYJUM
         SFDA7qBUDy6tHx/JcMqsgK8Ow06+7TBgxtqXINm/IZlQ67HmYMjUtNXfySPL+uYqXTpd
         EWn4IsyAIpub0d1CdHY2kLyluZ0t0ycl1OBkIRjRLY69ysaAufC1IeKQR4a4S/87JLEL
         ygLw7I5gpuioDUuEWc+vZZk/20Ybjbv2kXGva9wdJHBp867smljqHOYLC72XM3Ejgp/s
         c2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2DU8LSMpwhI42VEzkmQDivhyfVLUKtdex6r6frtpBtk=;
        b=JzyIoRP07GiP03rWwGa6Mr+25ON1ZEw0rQ6RPltvGEEIzQU6liqrPUQpZY3qik5SCJ
         906sPwCcbMW6SxvpaY+Fp99AFuQaMxQsw7tmkhzRygZ5qNdKEmEI1FbQrbBi9UCtHfdM
         dOxhyNTWt1s60SZYge1ouDRC67jg9bgWe7IhDwj0HIX+9F5vzZHNGmfne/NAcxEDPQxM
         FsmNeI+o5gppvb58wzkU9GTYDrcW++Abf9UWuMa8MAANFHrMaSGq+Ww8lX7U4e8NsYBU
         f91XW6wdh6uh0oYBGuFsKz3XFcGoGRI7UT4lf5YDbWi8aeNNkk/wgkfWQEvSaa4CriQG
         nqBA==
X-Gm-Message-State: AJIora9dwlAtTzhohstmw9GDc6NULhO9n1Gty5vjjr55kp91dTTKYW/E
        F5YbQTcRv94SQyd7Uo4eA9oY1A==
X-Google-Smtp-Source: AGRyM1vX3o1EcrOzawr4QvYYmJcA8+LAKFnQxVBxckSLXHI9X12qP84pcIaArycJDHZVaP7nIPdUIQ==
X-Received: by 2002:a05:620a:143c:b0:6b8:8d43:5581 with SMTP id k28-20020a05620a143c00b006b88d435581mr10928966qkj.179.1659457692698;
        Tue, 02 Aug 2022 09:28:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ad0f])
        by smtp.gmail.com with ESMTPSA id b23-20020ac86797000000b0031ee34ca176sm9394404qtp.59.2022.08.02.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:28:12 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
Date:   Tue,  2 Aug 2022 12:28:11 -0400
Message-Id: <20220802162811.39216-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During proactive reclaim, we sometimes observe severe overreclaim,
with several thousand times more pages reclaimed than requested.

This trace was obtained from shrink_lruvec() during such an instance:

    prio:0 anon_cost:1141521 file_cost:7767
    nr_reclaimed:4387406 nr_to_reclaim:1047 (or_factor:4190)
    nr=[7161123 345 578 1111]

While he reclaimer requested 4M, vmscan reclaimed close to 16G, most
of it by swapping. These requests take over a minute, during which the
write() to memory.reclaim is unkillably stuck inside the kernel.

Digging into the source, this is caused by the proportional reclaim
bailout logic. This code tries to resolve a fundamental conflict: to
reclaim roughly what was requested, while also aging all LRUs fairly
and in accordance to their size, swappiness, refault rates etc. The
way it attempts fairness is that once the reclaim goal has been
reached, it stops scanning the LRUs with the smaller remaining scan
targets, and adjusts the remainder of the bigger LRUs according to how
much of the smaller LRUs was scanned. It then finishes scanning that
remainder regardless of the reclaim goal.

This works fine if priority levels are low and the LRU lists are
comparable in size. However, in this instance, the cgroup that is
targeted by proactive reclaim has almost no files left - they've
already been squeezed out by proactive reclaim earlier - and the
remaining anon pages are hot. Anon rotations cause the priority level
to drop to 0, which results in reclaim targeting all of anon (a lot)
and all of file (almost nothing). By the time reclaim decides to bail,
it has scanned most or all of the file target, and therefor must also
scan most or all of the enormous anon target. This target is thousands
of times larger than the reclaim goal, thus causing the overreclaim.

The bailout code hasn't changed in years, why is this failing now?
The most likely explanations are two other recent changes in anon
reclaim:

1. Before the series starting with commit 5df741963d52 ("mm: fix LRU
   balancing effect of new transparent huge pages"), the VM was
   overall relatively reluctant to swap at all, even if swap was
   configured. This means the LRU balancing code didn't come into play
   as often as it does now, and mostly in high pressure situations
   where pronounced swap activity wouldn't be as surprising.

2. For historic reasons, shrink_lruvec() loops on the scan targets of
   all LRU lists except the active anon one, meaning it would bail if
   the only remaining pages to scan were active anon - even if there
   were a lot of them.

   Before the series starting with commit ccc5dc67340c ("mm/vmscan:
   make active/inactive ratio as 1:1 for anon lru"), most anon pages
   would live on the active LRU; the inactive one would contain only a
   handful of preselected reclaim candidates. After the series, anon
   gets aged similarly to file, and the inactive list is the default
   for new anon pages as well, making it often the much bigger list.

   As a result, the VM is now more likely to actually finish large
   anon targets than before.

Change the code such that only one SWAP_CLUSTER_MAX-sized nudge toward
the larger LRU lists is made before bailing out on a met reclaim goal.

This fixes the extreme overreclaim problem.

Fairness is more subtle and harder to evaluate. No obvious misbehavior
was observed on the test workload, in any case. Conceptually, fairness
should primarily be a cumulative effect from regular, lower priority
scans. Once the VM is in trouble and needs to escalate scan targets to
make forward progress, fairness needs to take a backseat. This is also
acknowledged by the myriad exceptions in get_scan_count(). This patch
makes fairness decrease gradually, as it keeps fairness work static
over increasing priority levels with growing scan targets. This should
make more sense - although we may have to re-visit the exact values.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..1cc0c6666787 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2897,8 +2897,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	enum lru_list lru;
 	unsigned long nr_reclaimed = 0;
 	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
+	bool proportional_reclaim;
 	struct blk_plug plug;
-	bool scan_adjusted;
 
 	get_scan_count(lruvec, sc, nr);
 
@@ -2916,8 +2916,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	 * abort proportional reclaim if either the file or anon lru has already
 	 * dropped to zero at the first pass.
 	 */
-	scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
-			 sc->priority == DEF_PRIORITY);
+	proportional_reclaim = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
+				sc->priority == DEF_PRIORITY);
 
 	blk_start_plug(&plug);
 	while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
@@ -2937,7 +2937,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 
 		cond_resched();
 
-		if (nr_reclaimed < nr_to_reclaim || scan_adjusted)
+		if (nr_reclaimed < nr_to_reclaim || proportional_reclaim)
 			continue;
 
 		/*
@@ -2988,8 +2988,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		nr_scanned = targets[lru] - nr[lru];
 		nr[lru] = targets[lru] * (100 - percentage) / 100;
 		nr[lru] -= min(nr[lru], nr_scanned);
-
-		scan_adjusted = true;
 	}
 	blk_finish_plug(&plug);
 	sc->nr_reclaimed += nr_reclaimed;
-- 
2.37.1

