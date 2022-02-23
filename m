Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80D4C1C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiBWTkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiBWTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:40:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE79849248
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:40:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d17-20020a253611000000b006244e94b7b4so16142380yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3O2OEu4eUhR3YtOUni3RQudnfEWV+vLSeR/9NTfWNyU=;
        b=jzC9fz4TzuA54IP+E5K9YaKUQaPNmQ/lvm3NX2pb3OKYpT8t0JaPn6bAt2BddJkswc
         CaDH8o0HuYAtisKR5ccNJFhqnT9crftdUBByiSgZ28y3XbzO3EdQaGScOTjoQ8alXMwB
         JBrL6fQH+JWTaChQwvObiF7Wze08of9eeQzNJBGqa58pXjb8fI0wFM01INm2APxTcq6d
         0/z1QuNzzNqvlMbZmvPurZn/8lu9y9/XNtMjiBk+FAPQ0V4eXsbYDNvjkoDuhePHNvGO
         UffScw890HXGZdnsEUbyecWHYB9Sntgl8fkx0DrcJkg0q5QFExj/O81celFzUTPqIBKJ
         3tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3O2OEu4eUhR3YtOUni3RQudnfEWV+vLSeR/9NTfWNyU=;
        b=Qs3UFNxASB0IAFea75PGUrg4t44rHb4mjtoygzOrALru1oo78UpVC46oruumwSfcRf
         44VeoA9KI1WUP0AZzVcOLUv3kTRTqpKdq2XTn4Ax5yYxtc9tnzhpPa/hjMHqxVED615G
         BiIJwOH1ZGVFbLaUccYbWAWtOGwf3xT2YcDolrL+u2lH1Ig1YLUPHrlrY9UdabZ+zsQr
         aW5FCsFmDOaSRAA1On3+iK8mAD4qFarxKhElnrDmCkA+UJUmlxe6we2FzH1+vjvzGx04
         zi6GmiLmL/3J+24v9GzsZ07xgdkMSwqVdUyKYhoMnkKy1POcM80VcFW8/E2n+1liKcqS
         0pjA==
X-Gm-Message-State: AOAM531yP53Bgcnisjhz+dOlpnKnkjmbhl4MhmDg62MF2wAqjfJNTJe1
        Ew+LQAm2EMGBMwoAYAEIpNX6OEk1/A0=
X-Google-Smtp-Source: ABdhPJw7+FhbLt4ftGqCh3/S46XA43RnDHK0Jo9UuVmyeO3SvFEivpVsPC0K8bjqax6iJuYtGWwMzLT1f5k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5093:9fb5:d0ba:a5f])
 (user=surenb job=sendgmr) by 2002:a25:db8d:0:b0:624:5e99:1665 with SMTP id
 g135-20020a25db8d000000b006245e991665mr1151004ybf.524.1645645223005; Wed, 23
 Feb 2022 11:40:23 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:40:18 -0800
Message-Id: <20220223194018.1296629-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@suse.com, pmladek@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page allocation in direct reclaim path fails, the system will
make one attempt to shrink per-cpu page lists and free pages from
high alloc reserves. Draining per-cpu pages into buddy allocator can
be a very slow operation because it's done using workqueues and the
task in direct reclaim waits for all of them to finish before
proceeding. Currently this time is not accounted as psi memory stall.

While testing mobile devices under extreme memory pressure, when
allocations are failing during direct reclaim, we notices that psi
events which would be expected in such conditions were not triggered.
After profiling these cases it was determined that the reason for
missing psi events was that a big chunk of time spent in direct
reclaim is not accounted as memory stall, therefore psi would not
reach the levels at which an event is generated. Further investigation
revealed that the bulk of that unaccounted time was spent inside
drain_all_pages call.

A typical captured case when drain_all_pages path gets activated:

__alloc_pages_slowpath  took 44.644.613ns
    __perform_reclaim   took    751.668ns (1.7%)
    drain_all_pages     took 43.887.167ns (98.3%)

PSI in this case records the time spent in __perform_reclaim but
ignores drain_all_pages, IOW it misses 98.3% of the time spent in
__alloc_pages_slowpath.

Annotate __alloc_pages_direct_reclaim in its entirety so that delays
from handling page allocation failure in the direct reclaim path are
accounted as memory stall.

Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
changes in v2:
- Added captured sample case to show the delay numbers, per Michal Hocko
- Moved annotation from __perform_reclaim into __alloc_pages_direct_reclaim,
per Minchan Kim

 mm/page_alloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..2e9fbf28938f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4595,13 +4595,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 					const struct alloc_context *ac)
 {
 	unsigned int noreclaim_flag;
-	unsigned long pflags, progress;
+	unsigned long progress;
 
 	cond_resched();
 
 	/* We now go into synchronous reclaim */
 	cpuset_memory_pressure_bump();
-	psi_memstall_enter(&pflags);
 	fs_reclaim_acquire(gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -4610,7 +4609,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(gfp_mask);
-	psi_memstall_leave(&pflags);
 
 	cond_resched();
 
@@ -4624,11 +4622,13 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 		unsigned long *did_some_progress)
 {
 	struct page *page = NULL;
+	unsigned long pflags;
 	bool drained = false;
 
+	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, order, ac);
 	if (unlikely(!(*did_some_progress)))
-		return NULL;
+		goto out;
 
 retry:
 	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
@@ -4644,7 +4644,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 		drained = true;
 		goto retry;
 	}
-
+	psi_memstall_leave(&pflags);
+out:
 	return page;
 }
 
-- 
2.35.1.473.g83b2b277ed-goog

