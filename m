Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8350341A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiDPBKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDPBKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 21:10:18 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B39516665B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:07:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650069678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C5nkTrq4xMgYIDmhUhVhC2Dq7TG9dRaDSUT0wVRb144=;
        b=Jo2/gZ05dZmfC/MFjPD+Ds9RazbpGZ3I7R9PcnlMSTwT7x2TY0Hg3IsG8oiZff1gW75ZYv
        tfWe7WPDHcAf/j2xhHdyc+Jg5hRoAz9OgqZlsX81+XLBSBBRonAbTz29hjw51prfNIvNSN
        ei8ecQgEloMgkibAiWOgzN6iNK2LOsA=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH] mm: do not call add_nr_deferred() with zero deferred
Date:   Fri, 15 Apr 2022 17:41:04 -0700
Message-Id: <20220416004104.4089743-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_nr_deferred() is often called with next_deferred equal to 0.
For instance, it's happening under low memory pressure for any
shrinkers with a low number of cached objects. A corresponding trace
looks like:
  <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
  super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
  unused scan count 0 new scan count 0 total_scan 0	     \
  last shrinker return val 0

  <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
  super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
  unused scan count 0 new scan count 0 total_scan 0	     \
  last shrinker return val 0

  <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
  super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
  scan count 0 new scan count 0 total_scan 0	             \
  last shrinker return val 0

This lead to unnecessary checks and atomic operations, which can be
avoided by checking next_deferred for not being zero before calling
add_nr_deferred(). In this case the mm_shrink_slab_end trace point
will get a potentially slightly outdated "new scan count" value, but
it's totally fine.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4a7d2bd276d..19d3d4fa1aad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -808,7 +808,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * move the unused scan count back into the shrinker in a
 	 * manner that handles concurrent updates.
 	 */
-	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
+	if (next_deferred)
+		new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
+	else
+		new_nr = nr;
 
 	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
-- 
2.35.1

