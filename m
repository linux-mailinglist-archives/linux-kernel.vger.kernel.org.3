Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1674C1C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbiBWTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiBWTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:48:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B718A40A10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:48:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso28588644ybs.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MM6VpwEuHyZ5v5v0jkqjjMY1tkkmV3hr/n/VQS94jks=;
        b=lkZO2GjNLpY1p8wRTYMQKCURny9OLBoayJa+FZ5zbPz4LDZBvHCV06L73NHFu0MIMQ
         HszNdU6gZ84ueetyuYOMK9iZV4Qt2rHE0DRYDYunAcDMevcqAYdOuKRQcA7vEUyxT0ut
         7iXcnr6wxHDVbUA6H7XMhS6qFii6FoVrP3V/rdcGkfwACofFURhVkxkPYKR2FEOTXszY
         2j8jLTCyQeMpEBdkXgjM5p+Dqc5WPFuKFxi20BM2YbI981ObaFLYYEThPGfMuDLx/mPs
         QkKqjSo3yYluG9yStCtfgBj6VbLorXXj+4rsOhkgD5EnJwS3N4w0Cb1QoAf/0efvPuL9
         9Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MM6VpwEuHyZ5v5v0jkqjjMY1tkkmV3hr/n/VQS94jks=;
        b=BoEpgQgQgDBUfBOc4pcAnmQKA0bFvWrI+oI9zjQ2otnsAXXdL9v/qMdmD1X6fDl39P
         dcLos6Cc5ocrfQ3RtN0P3BQ6fCckdupTCR4TNbVgi0g0yhurTp9bC3YTQQJXi0aQN5Sh
         LhQ1IdWhcgArg5beLIjN3J69Il9ptKYizmtiC6E3/KZKZHj1peGKqIIDjRPy1+TosO75
         lGMnO7We0864mZXqup1KqSma70BDTh6dfZV5U1JpRHina6SATfhFfJvKlCnS6XVZtiOH
         NPHIpWF+Eun6rS6pdhJG0hf7CjaH5haOvwvNTnq+ioCUbiWJLSqmPQ/7nVuMSaBkgHBo
         XNkw==
X-Gm-Message-State: AOAM532U0Y1/Er9rvsbHnVMo61cCLAiKcAzRkS4DIxthyERF3zsBCxnr
        KToK3liFyByQS7Vjtr2aMs0pnwmm1ZI=
X-Google-Smtp-Source: ABdhPJzOMSgn9uDD/a4pJaJMz6d/iPAqkjY23/RUpGkAAjMqcefD2ddyVi/6WU6MFC3BPviettcstjqE6tU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5093:9fb5:d0ba:a5f])
 (user=surenb job=sendgmr) by 2002:a25:b18e:0:b0:624:62c1:be56 with SMTP id
 h14-20020a25b18e000000b0062462c1be56mr1167372ybj.624.1645645695981; Wed, 23
 Feb 2022 11:48:15 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:48:12 -0800
Message-Id: <20220223194812.1299646-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 1/1] mm: count time in drain_all_pages during direct
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
changes in v3:
- Moved psi_memstall_leave after the "out" label

 mm/page_alloc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..029bceb79861 100644
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
@@ -4644,6 +4644,8 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 		drained = true;
 		goto retry;
 	}
+out:
+	psi_memstall_leave(&pflags);
 
 	return page;
 }
-- 
2.35.1.473.g83b2b277ed-goog

