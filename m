Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830864F72DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbiDGDSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiDGDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:18:00 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5256209
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:16:02 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id y3-20020a056602178300b00645d25c30c1so2865893iox.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HWUMxX2GHTS2sU7fxsre8OtJa702AlX1YTnPsDpNr8g=;
        b=kEWUDg82syhNmhp0q7HqjSi4vFJg5Mty4gsGp6NRMkxh+MCtLCXh7q7Rzwxf2Q2REl
         ie+GOC4+EdvR+L9kohnAjyipDQ1jAgxBdI+KbUWtBeOKN/TMwA497dxdq13ArcbYq9Q7
         W+Uajrf4CuwPO0Tefvr9x6hpDeHQ4xF7duBX/Ak4bMe8ruBSOYuFmkrdeLOdWHywfsrA
         u1VIEVtXVvsW0hcmdR4mReTX5fvzmpEntQ7R9rbWadDXQSb54Htj4pdZnz/GSF0QGbMr
         mbTw93nrTfhV2KtfABiIqkWfWYlW8Nqm+WXEoxuRbsznMiKgezd1gYQEwzgM021DZhOE
         ySCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HWUMxX2GHTS2sU7fxsre8OtJa702AlX1YTnPsDpNr8g=;
        b=5TKMdz1nBriQH4zOwQ8p5WYhaflv6w2R4t5pK1Iuhl3Y753Cgs3CmOCdkuaJv2FFtv
         rBi9nMVVY7qhB0GEI9oyp0Gebhf0uP2naPCY1QXe4ugNLDtfWiPCPTuRhm+SDGvKwYKy
         jZ79C8KBjpnAgaDIr5zsaic2jPFYIfhkww691MHYOY8sfD3Uek7iyovWyB66tM26ps2q
         vDKR66+8fua7OD5xbTn0zAsXBp7rM2bzk9jZhG3/8E0UNSqz5OAyMgT4QpFOeL1qVIuE
         iJjZQivu9tWceo36nqeeetOOYLVHcjLAb8tWGg92Bub2nNejjr3WTRoTzirldCGZL4k1
         qJ7g==
X-Gm-Message-State: AOAM532tG3TEEasQtMT7L5fUZSBJ0bA/ZpG7o1clco9Oo5+/yvSDw39G
        nyM8AEFwcVGR6Lx8Ia7WIMpWqSiaAXs=
X-Google-Smtp-Source: ABdhPJwb4wEQfjqHqohpxKj+YJeCn5tBx/D54ak9fb5cGlgOENd8TrZRM2TWzSCsc2kdIv61Clqndub2Zyc=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:9ea2:c755:ae22:6862])
 (user=yuzhao job=sendgmr) by 2002:a92:cac3:0:b0:2c9:a265:4cab with SMTP id
 m3-20020a92cac3000000b002c9a2654cabmr5577295ilq.241.1649301361611; Wed, 06
 Apr 2022 20:16:01 -0700 (PDT)
Date:   Wed,  6 Apr 2022 21:15:15 -0600
In-Reply-To: <20220407031525.2368067-1-yuzhao@google.com>
Message-Id: <20220407031525.2368067-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v10 03/14] mm/vmscan.c: refactor shrink_node()
From:   Yu Zhao <yuzhao@google.com>
To:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
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
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Yu Zhao <yuzhao@google.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
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
Reviewed-by: Barry Song <baohua@kernel.org>
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
index 1678802e03e7..2232cb55af41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2644,6 +2644,109 @@ enum scan_balance {
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
@@ -3114,109 +3217,16 @@ static void shrink_node(pg_data_t *pgdat, struct s=
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
2.35.1.1094.g7c7d902a7c-goog

