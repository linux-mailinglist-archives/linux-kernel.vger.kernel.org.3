Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE94D2553
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiCIBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiCIBIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:08:10 -0500
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27111143444
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:49:31 -0800 (PST)
Received: by mail-oo1-xc49.google.com with SMTP id e202-20020a4a55d3000000b00320d9789237so669321oob.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=tbwoXRX83Ugtjl0wsQRtV4AtFgtOhQymRgtKRped+Rs=;
        b=FaHiZcuF5xHCxl1JT9lspxdQ44aNXFbG8iBLVDLx9zy3OitvnFV+Beb47RdADmJ0ph
         xYy6lsAlSr9BWwlnVzkuz1SM/BVDabqDEX2XK3dIr0CzY+6aeZpITbCKIMsvmKJ7eprO
         I+2QhJk61V37v5LblBvEUsEKH9wqFnw4w2PFjWiOBkxRVrqkwsXxZHmRsoJGm9jgBb9M
         eJ2qTYihkXABkg+8U7t2qvSmSIwgHZDbaqh8STwFhGV91MkK8Oi0vQ4oRE/flp5a4aFk
         oX4DWBRca7tDjRhwRx1tfU08oCH+/jaT9QEImhy/iyaI1jZlRQUStRzUetyAiO6pWDK3
         ZzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=tbwoXRX83Ugtjl0wsQRtV4AtFgtOhQymRgtKRped+Rs=;
        b=vnq4R8qeGfh2EId64m7K5voGkFa9s3RTUaizeN04IOXOCGWBn+T4JPDJ6FaDhjWko8
         JyxdRnZpVW3yn5carw8WRt6OKpEiLy3BP3VA5d8Dd9vwFK/CcDnjMwK9kemkAa94+R+U
         1IyESWmlE57W1p1EVrQek4JMD5viPbGLn/FayUi2pShgPSxfxvyYSjMpmXK1xVgLnk8X
         Npj9LLlI5uldt7Di2z7/6vbmyvN6LOM4sZmdA+VX676tC7y91xoyaWpHBjAqvgH4Vs77
         nezu5lVdqxmfhJkU5I9Nab3pnZue6teS3zQrTw2IdZlCqshAi848pD8luCSi24e2rGFp
         TGwQ==
X-Gm-Message-State: AOAM532bfrctlpaDqfalwUH1jy4BrbO4UsCAeJNRQK/T0zxVPe9wBZis
        gZ4H+Yy7YrZV4QSdWxlFioueDjSYNeM=
X-Google-Smtp-Source: ABdhPJxbxr2M2FgKvqrmMwr9hhXO1sb7omSdq8pRxdDgBlhGgpeldIKXyVByveaf8aIhgXPx8+tQRzGQLBw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a25:d60b:0:b0:628:9442:3e71 with SMTP id
 n11-20020a25d60b000000b0062894423e71mr14292277ybg.362.1646783308306; Tue, 08
 Mar 2022 15:48:28 -0800 (PST)
Date:   Tue,  8 Mar 2022 16:47:13 -0700
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
Message-Id: <20220308234723.3834941-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v8 03/14] mm/vmscan.c: refactor shrink_node()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors shrink_node() to improve readability for the
upcoming changes to mm/vmscan.c.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 mm/vmscan.c | 198 +++++++++++++++++++++++++++-------------------------
 1 file changed, 104 insertions(+), 94 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59b14e0d696c..8e744cdf802f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2718,6 +2718,109 @@ enum scan_balance {
 	SCAN_FILE,
 };
=20
+static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
+{
+	unsigned long file;
+	struct lruvec *target_lruvec;
+
+	target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+
+	/*
+	 * Flush the memory cgroup stats, so that we read accurate per-memcg
+	 * lruvec stats for heuristics.
+	 */
+	mem_cgroup_flush_stats();
+
+	/*
+	 * Determine the scan balance between anon and file LRUs.
+	 */
+	spin_lock_irq(&target_lruvec->lru_lock);
+	sc->anon_cost =3D target_lruvec->anon_cost;
+	sc->file_cost =3D target_lruvec->file_cost;
+	spin_unlock_irq(&target_lruvec->lru_lock);
+
+	/*
+	 * Target desirable inactive:active list ratios for the anon
+	 * and file LRU lists.
+	 */
+	if (!sc->force_deactivate) {
+		unsigned long refaults;
+
+		refaults =3D lruvec_page_state(target_lruvec,
+				WORKINGSET_ACTIVATE_ANON);
+		if (refaults !=3D target_lruvec->refaults[0] ||
+			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+			sc->may_deactivate |=3D DEACTIVATE_ANON;
+		else
+			sc->may_deactivate &=3D ~DEACTIVATE_ANON;
+
+		/*
+		 * When refaults are being observed, it means a new
+		 * workingset is being established. Deactivate to get
+		 * rid of any stale active pages quickly.
+		 */
+		refaults =3D lruvec_page_state(target_lruvec,
+				WORKINGSET_ACTIVATE_FILE);
+		if (refaults !=3D target_lruvec->refaults[1] ||
+		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
+			sc->may_deactivate |=3D DEACTIVATE_FILE;
+		else
+			sc->may_deactivate &=3D ~DEACTIVATE_FILE;
+	} else
+		sc->may_deactivate =3D DEACTIVATE_ANON | DEACTIVATE_FILE;
+
+	/*
+	 * If we have plenty of inactive file pages that aren't
+	 * thrashing, try to reclaim those first before touching
+	 * anonymous pages.
+	 */
+	file =3D lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
+	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+		sc->cache_trim_mode =3D 1;
+	else
+		sc->cache_trim_mode =3D 0;
+
+	/*
+	 * Prevent the reclaimer from falling into the cache trap: as
+	 * cache pages start out inactive, every cache fault will tip
+	 * the scan balance towards the file LRU.  And as the file LRU
+	 * shrinks, so does the window for rotation from references.
+	 * This means we have a runaway feedback loop where a tiny
+	 * thrashing file LRU becomes infinitely more attractive than
+	 * anon pages.  Try to detect this based on file LRU size.
+	 */
+	if (!cgroup_reclaim(sc)) {
+		unsigned long total_high_wmark =3D 0;
+		unsigned long free, anon;
+		int z;
+
+		free =3D sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
+		file =3D node_page_state(pgdat, NR_ACTIVE_FILE) +
+			   node_page_state(pgdat, NR_INACTIVE_FILE);
+
+		for (z =3D 0; z < MAX_NR_ZONES; z++) {
+			struct zone *zone =3D &pgdat->node_zones[z];
+
+			if (!managed_zone(zone))
+				continue;
+
+			total_high_wmark +=3D high_wmark_pages(zone);
+		}
+
+		/*
+		 * Consider anon: if that's low too, this isn't a
+		 * runaway file reclaim problem, but rather just
+		 * extreme pressure. Reclaim as per usual then.
+		 */
+		anon =3D node_page_state(pgdat, NR_INACTIVE_ANON);
+
+		sc->file_is_tiny =3D
+			file + free <=3D total_high_wmark &&
+			!(sc->may_deactivate & DEACTIVATE_ANON) &&
+			anon >> sc->priority;
+	}
+}
+
 /*
  * Determine how aggressively the anon and file LRU lists should be
  * scanned.  The relative value of each set of LRU lists is determined
@@ -3188,109 +3291,16 @@ static void shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
 	unsigned long nr_reclaimed, nr_scanned;
 	struct lruvec *target_lruvec;
 	bool reclaimable =3D false;
-	unsigned long file;
=20
 	target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
=20
 again:
-	/*
-	 * Flush the memory cgroup stats, so that we read accurate per-memcg
-	 * lruvec stats for heuristics.
-	 */
-	mem_cgroup_flush_stats();
-
 	memset(&sc->nr, 0, sizeof(sc->nr));
=20
 	nr_reclaimed =3D sc->nr_reclaimed;
 	nr_scanned =3D sc->nr_scanned;
=20
-	/*
-	 * Determine the scan balance between anon and file LRUs.
-	 */
-	spin_lock_irq(&target_lruvec->lru_lock);
-	sc->anon_cost =3D target_lruvec->anon_cost;
-	sc->file_cost =3D target_lruvec->file_cost;
-	spin_unlock_irq(&target_lruvec->lru_lock);
-
-	/*
-	 * Target desirable inactive:active list ratios for the anon
-	 * and file LRU lists.
-	 */
-	if (!sc->force_deactivate) {
-		unsigned long refaults;
-
-		refaults =3D lruvec_page_state(target_lruvec,
-				WORKINGSET_ACTIVATE_ANON);
-		if (refaults !=3D target_lruvec->refaults[0] ||
-			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
-			sc->may_deactivate |=3D DEACTIVATE_ANON;
-		else
-			sc->may_deactivate &=3D ~DEACTIVATE_ANON;
-
-		/*
-		 * When refaults are being observed, it means a new
-		 * workingset is being established. Deactivate to get
-		 * rid of any stale active pages quickly.
-		 */
-		refaults =3D lruvec_page_state(target_lruvec,
-				WORKINGSET_ACTIVATE_FILE);
-		if (refaults !=3D target_lruvec->refaults[1] ||
-		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
-			sc->may_deactivate |=3D DEACTIVATE_FILE;
-		else
-			sc->may_deactivate &=3D ~DEACTIVATE_FILE;
-	} else
-		sc->may_deactivate =3D DEACTIVATE_ANON | DEACTIVATE_FILE;
-
-	/*
-	 * If we have plenty of inactive file pages that aren't
-	 * thrashing, try to reclaim those first before touching
-	 * anonymous pages.
-	 */
-	file =3D lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
-		sc->cache_trim_mode =3D 1;
-	else
-		sc->cache_trim_mode =3D 0;
-
-	/*
-	 * Prevent the reclaimer from falling into the cache trap: as
-	 * cache pages start out inactive, every cache fault will tip
-	 * the scan balance towards the file LRU.  And as the file LRU
-	 * shrinks, so does the window for rotation from references.
-	 * This means we have a runaway feedback loop where a tiny
-	 * thrashing file LRU becomes infinitely more attractive than
-	 * anon pages.  Try to detect this based on file LRU size.
-	 */
-	if (!cgroup_reclaim(sc)) {
-		unsigned long total_high_wmark =3D 0;
-		unsigned long free, anon;
-		int z;
-
-		free =3D sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
-		file =3D node_page_state(pgdat, NR_ACTIVE_FILE) +
-			   node_page_state(pgdat, NR_INACTIVE_FILE);
-
-		for (z =3D 0; z < MAX_NR_ZONES; z++) {
-			struct zone *zone =3D &pgdat->node_zones[z];
-			if (!managed_zone(zone))
-				continue;
-
-			total_high_wmark +=3D high_wmark_pages(zone);
-		}
-
-		/*
-		 * Consider anon: if that's low too, this isn't a
-		 * runaway file reclaim problem, but rather just
-		 * extreme pressure. Reclaim as per usual then.
-		 */
-		anon =3D node_page_state(pgdat, NR_INACTIVE_ANON);
-
-		sc->file_is_tiny =3D
-			file + free <=3D total_high_wmark &&
-			!(sc->may_deactivate & DEACTIVATE_ANON) &&
-			anon >> sc->priority;
-	}
+	prepare_scan_count(pgdat, sc);
=20
 	shrink_node_memcgs(pgdat, sc);
=20
--=20
2.35.1.616.g0bdcbb4464-goog

