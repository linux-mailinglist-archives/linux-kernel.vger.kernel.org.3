Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B974D2781
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiCICOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCICOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:14:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D9921E2C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:13:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d81518795fso6741047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 18:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=JjJoog8wmqrSC1z8TX3DLEa+2E2CmPZpjHsohOjt7WM=;
        b=lCilK8OAV0OcLh+DfrJELI/tdbYYSzXnynYKz9E+tV0zA20V8xUe9/14/pDupS329B
         3rjlcevbqna2k9CbVHkIOyUYsSKT3xuGmjKopzVzy0rWJ8JI96f3n65tybS2WmVY2K9e
         U9CFs6vlEaqA0R0sHjnyfKfYlurYGXuWc05roYO62ZTd7wrRKG1Z9NsoMz2GXW8X/9Mw
         IwcnYVqYYVWOldL8LKdWM6BMyAGvpKQechrvSJMNZWO3GxXE5ZU1f60sPD8gKmu7CSaS
         kfmca2MeT0hPIFAB7JIGUPer/moxFnQbG94wrPyJ89XS8bJ1DuVM9FCYSdIWkHR3pVGm
         r5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=JjJoog8wmqrSC1z8TX3DLEa+2E2CmPZpjHsohOjt7WM=;
        b=f5TBfts3Row40tCnqesuqpdq54KK32V4tFtI8A5jPQG7wC64diFgQiGXriU4/xNPud
         xjUB+L4Iw51GCyg89hbKMFr0YaGWh7BDUY+H3xQljfEp7SM6WJmNEAnqQYvQA2rjyUHc
         7hA3XKhcUhoLiovi2+5FyCy6ysx6lPJ/Dax6CQXKDqpd02i4VSWHEX1COL/0PnIodtM8
         e/5/woCOrFEfQxQV3L40TaGwo8JAHW5H8ncfq4YdZfFwCwmOtxT/lFt5fSepvwIEQIgp
         3KB4Cmbzf9bsiBatsIrSLQDJs0JIbf3wjWsRtvB6MH7qUWhs50ZtQOuLSVtfxwwYncNc
         LvEw==
X-Gm-Message-State: AOAM5323hMHaaMln8pn7jqv8Jn3DDeGNG3HjV9T6JchGUjR01GkNbM0g
        jWZteOTmtEbQw1xWB9EYzDD26KoUYLs=
X-Google-Smtp-Source: ABdhPJzBZ2rhPH9fmzUHC/rDCcKchGNth/1G3u3vpJI/VvMs56izu249FAQeqiRdsrzNIV/Cac+jNnTzHyY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a81:80c3:0:b0:2db:1efc:f4fe with SMTP id
 q186-20020a8180c3000000b002db1efcf4femr14568365ywf.459.1646792010408; Tue, 08
 Mar 2022 18:13:30 -0800 (PST)
Date:   Tue,  8 Mar 2022 19:12:22 -0700
In-Reply-To: <20220309021230.721028-1-yuzhao@google.com>
Message-Id: <20220309021230.721028-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Evictable pages are divided into multiple generations for each lruvec.
The youngest generation number is stored in lrugen->max_seq for both
anon and file types as they are aged on an equal footing. The oldest
generation numbers are stored in lrugen->min_seq[] separately for anon
and file types as clean file pages can be evicted regardless of swap
constraints. These three variables are monotonically increasing.

Generation numbers are truncated into order_base_2(MAX_NR_GENS+1) bits
in order to fit into the gen counter in folio->flags. Each truncated
generation number is an index to lrugen->lists[]. The sliding window
technique is used to track at least MIN_NR_GENS and at most
MAX_NR_GENS generations. The gen counter stores a value within [1,
MAX_NR_GENS] while a page is on one of lrugen->lists[]. Otherwise it
stores 0.

There are two conceptually independent procedures: "the aging", which
produces young generations, and "the eviction", which consumes old
generations. They form a closed-loop system, i.e., "the page reclaim".
Both procedures can be invoked from userspace for the purposes of
working set estimation and proactive reclaim. These features are
required to optimize job scheduling (bin packing) in data centers. The
variable size of the sliding window is designed for such use cases
[1][2].

To avoid confusion, the terms "hot" and "cold" will be applied to the
multi-gen LRU, as a new convention; the terms "active" and "inactive"
will be applied to the active/inactive LRU, as usual.

The protection of hot pages and the selection of cold pages are based
on page access channels and patterns. There are two access channels:
one through page tables and the other through file descriptors. The
protection of the former channel is by design stronger because:
1. The uncertainty in determining the access patterns of the former
   channel is higher due to the approximation of the accessed bit.
2. The cost of evicting the former channel is higher due to the TLB
   flushes required and the likelihood of encountering the dirty bit.
3. The penalty of underprotecting the former channel is higher because
   applications usually do not prepare themselves for major page
   faults like they do for blocked I/O. E.g., GUI applications
   commonly use dedicated I/O threads to avoid blocking the rendering
   threads.
There are also two access patterns: one with temporal locality and the
other without. For the reasons listed above, the former channel is
assumed to follow the former pattern unless VM_SEQ_READ or
VM_RAND_READ is present; the latter channel is assumed to follow the
latter pattern unless outlying refaults have been observed.

The next patch will address the "outlying refaults". A few macros,
i.e., LRU_REFS_*, used later are added in this patch to make the
patchset less diffy.

A page is added to the youngest generation on faulting. The aging
needs to check the accessed bit at least twice before handing this
page over to the eviction. The first check takes care of the accessed
bit set on the initial fault; the second check makes sure this page
has not been used since then. This protocol, AKA second chance,
requires a minimum of two generations, hence MIN_NR_GENS.

[1] https://dl.acm.org/doi/10.1145/3297858.3304053
[2] https://dl.acm.org/doi/10.1145/3503222.3507731

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
 fs/fuse/dev.c                     |   3 +-
 include/linux/mm.h                |   2 +
 include/linux/mm_inline.h         | 176 ++++++++++++++++++++++++++++++
 include/linux/mmzone.h            |  94 ++++++++++++++++
 include/linux/page-flags-layout.h |  11 +-
 include/linux/page-flags.h        |   4 +-
 include/linux/sched.h             |   4 +
 kernel/bounds.c                   |   7 ++
 mm/Kconfig                        |  10 ++
 mm/huge_memory.c                  |   3 +-
 mm/memcontrol.c                   |   2 +
 mm/memory.c                       |  25 +++++
 mm/mm_init.c                      |   6 +-
 mm/mmzone.c                       |   2 +
 mm/swap.c                         |   9 +-
 mm/vmscan.c                       |  73 +++++++++++++
 16 files changed, 418 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 592730fd6e42..e7c0aa6d61ce 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -785,7 +785,8 @@ static int fuse_check_page(struct page *page)
 	       1 << PG_active |
 	       1 << PG_workingset |
 	       1 << PG_reclaim |
-	       1 << PG_waiters))) {
+	       1 << PG_waiters |
+	       LRU_GEN_MASK | LRU_REFS_MASK))) {
 		dump_page(page, "fuse: trying to steal weird page");
 		return 1;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5744a3fc4716..c1162659d824 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1032,6 +1032,8 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)=
;
 #define ZONES_PGOFF		(NODES_PGOFF - ZONES_WIDTH)
 #define LAST_CPUPID_PGOFF	(ZONES_PGOFF - LAST_CPUPID_WIDTH)
 #define KASAN_TAG_PGOFF		(LAST_CPUPID_PGOFF - KASAN_TAG_WIDTH)
+#define LRU_GEN_PGOFF		(KASAN_TAG_PGOFF - LRU_GEN_WIDTH)
+#define LRU_REFS_PGOFF		(LRU_GEN_PGOFF - LRU_REFS_WIDTH)
=20
 /*
  * Define the bit shifts to access each section.  For non-existent
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 2c24f5ac3e2a..e3594171b421 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -38,6 +38,9 @@ static __always_inline void __update_lru_size(struct lruv=
ec *lruvec,
 {
 	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
=20
+	lockdep_assert_held(&lruvec->lru_lock);
+	WARN_ON_ONCE(nr_pages !=3D (int)nr_pages);
+
 	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
@@ -99,11 +102,178 @@ static __always_inline enum lru_list folio_lru_list(s=
truct folio *folio)
 	return lru;
 }
=20
+#ifdef CONFIG_LRU_GEN
+
+static inline bool lru_gen_enabled(void)
+{
+	return true;
+}
+
+static inline bool lru_gen_in_fault(void)
+{
+	return current->in_lru_fault;
+}
+
+static inline int lru_gen_from_seq(unsigned long seq)
+{
+	return seq % MAX_NR_GENS;
+}
+
+static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
+{
+	unsigned long max_seq =3D lruvec->lrugen.max_seq;
+
+	VM_BUG_ON(gen >=3D MAX_NR_GENS);
+
+	/* see the comment on MIN_NR_GENS */
+	return gen =3D=3D lru_gen_from_seq(max_seq) || gen =3D=3D lru_gen_from_se=
q(max_seq - 1);
+}
+
+static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio=
 *folio,
+				       int old_gen, int new_gen)
+{
+	int type =3D folio_is_file_lru(folio);
+	int zone =3D folio_zonenum(folio);
+	int delta =3D folio_nr_pages(folio);
+	enum lru_list lru =3D type * LRU_INACTIVE_FILE;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	VM_BUG_ON(old_gen !=3D -1 && old_gen >=3D MAX_NR_GENS);
+	VM_BUG_ON(new_gen !=3D -1 && new_gen >=3D MAX_NR_GENS);
+	VM_BUG_ON(old_gen =3D=3D -1 && new_gen =3D=3D -1);
+
+	if (old_gen >=3D 0)
+		WRITE_ONCE(lrugen->nr_pages[old_gen][type][zone],
+			   lrugen->nr_pages[old_gen][type][zone] - delta);
+	if (new_gen >=3D 0)
+		WRITE_ONCE(lrugen->nr_pages[new_gen][type][zone],
+			   lrugen->nr_pages[new_gen][type][zone] + delta);
+
+	/* addition */
+	if (old_gen < 0) {
+		if (lru_gen_is_active(lruvec, new_gen))
+			lru +=3D LRU_ACTIVE;
+		__update_lru_size(lruvec, lru, zone, delta);
+		return;
+	}
+
+	/* deletion */
+	if (new_gen < 0) {
+		if (lru_gen_is_active(lruvec, old_gen))
+			lru +=3D LRU_ACTIVE;
+		__update_lru_size(lruvec, lru, zone, -delta);
+		return;
+	}
+}
+
+static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *=
folio, bool reclaiming)
+{
+	int gen;
+	unsigned long old_flags, new_flags;
+	int type =3D folio_is_file_lru(folio);
+	int zone =3D folio_zonenum(folio);
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	if (folio_test_unevictable(folio))
+		return false;
+	/*
+	 * There are three common cases for this page:
+	 * 1. If it's hot, e.g., freshly faulted in or previously hot and
+	 *    migrated, add it to the youngest generation.
+	 * 2. If it's cold but can't be evicted immediately, i.e., an anon page
+	 *    not in swapcache or a dirty page pending writeback, add it to the
+	 *    second oldest generation.
+	 * 3. Everything else (clean, cold) is added to the oldest generation.
+	 */
+	if (folio_test_active(folio))
+		gen =3D lru_gen_from_seq(lrugen->max_seq);
+	else if ((type =3D=3D LRU_GEN_ANON && !folio_test_swapcache(folio)) ||
+		 (folio_test_reclaim(folio) &&
+		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
+		gen =3D lru_gen_from_seq(lrugen->min_seq[type] + 1);
+	else
+		gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
+
+	do {
+		new_flags =3D old_flags =3D READ_ONCE(folio->flags);
+		VM_BUG_ON_FOLIO(new_flags & LRU_GEN_MASK, folio);
+
+		/* see the comment on MIN_NR_GENS */
+		new_flags &=3D ~(LRU_GEN_MASK | BIT(PG_active));
+		new_flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
+	} while (cmpxchg(&folio->flags, old_flags, new_flags) !=3D old_flags);
+
+	lru_gen_update_size(lruvec, folio, -1, gen);
+	/* for folio_rotate_reclaimable() */
+	if (reclaiming)
+		list_add_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+	else
+		list_add(&folio->lru, &lrugen->lists[gen][type][zone]);
+
+	return true;
+}
+
+static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *=
folio, bool reclaiming)
+{
+	int gen;
+	unsigned long old_flags, new_flags;
+
+	do {
+		new_flags =3D old_flags =3D READ_ONCE(folio->flags);
+		if (!(new_flags & LRU_GEN_MASK))
+			return false;
+
+		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
+		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
+
+		gen =3D ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+
+		new_flags &=3D ~LRU_GEN_MASK;
+		/* for shrink_page_list() */
+		if (reclaiming)
+			new_flags &=3D ~(BIT(PG_referenced) | BIT(PG_reclaim));
+		else if (lru_gen_is_active(lruvec, gen))
+			new_flags |=3D BIT(PG_active);
+	} while (cmpxchg(&folio->flags, old_flags, new_flags) !=3D old_flags);
+
+	lru_gen_update_size(lruvec, folio, gen, -1);
+	list_del(&folio->lru);
+
+	return true;
+}
+
+#else
+
+static inline bool lru_gen_enabled(void)
+{
+	return false;
+}
+
+static inline bool lru_gen_in_fault(void)
+{
+	return false;
+}
+
+static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *=
folio, bool reclaiming)
+{
+	return false;
+}
+
+static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *=
folio, bool reclaiming)
+{
+	return false;
+}
+
+#endif /* CONFIG_LRU_GEN */
+
 static __always_inline
 void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru =3D folio_lru_list(folio);
=20
+	if (lru_gen_add_folio(lruvec, folio, false))
+		return;
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	list_add(&folio->lru, &lruvec->lists[lru]);
@@ -120,6 +290,9 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struc=
t folio *folio)
 {
 	enum lru_list lru =3D folio_lru_list(folio);
=20
+	if (lru_gen_add_folio(lruvec, folio, true))
+		return;
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	list_add_tail(&folio->lru, &lruvec->lists[lru]);
@@ -134,6 +307,9 @@ static __always_inline void add_page_to_lru_list_tail(s=
truct page *page,
 static __always_inline
 void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
+	if (lru_gen_del_folio(lruvec, folio, false))
+		return;
+
 	list_del(&folio->lru);
 	update_lru_size(lruvec, folio_lru_list(folio), folio_zonenum(folio),
 			-folio_nr_pages(folio));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..a88e27d85693 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -303,6 +303,96 @@ enum lruvec_flags {
 					 */
 };
=20
+#endif /* !__GENERATING_BOUNDS_H */
+
+/*
+ * Evictable pages are divided into multiple generations. The youngest and=
 the
+ * oldest generation numbers, max_seq and min_seq, are monotonically incre=
asing.
+ * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS=
]. An
+ * offset within MAX_NR_GENS, gen, indexes the LRU list of the correspondi=
ng
+ * generation. The gen counter in folio->flags stores gen+1 while a page i=
s on
+ * one of lrugen->lists[]. Otherwise it stores 0.
+ *
+ * A page is added to the youngest generation on faulting. The aging needs=
 to
+ * check the accessed bit at least twice before handing this page over to =
the
+ * eviction. The first check takes care of the accessed bit set on the ini=
tial
+ * fault; the second check makes sure this page hasn't been used since the=
n.
+ * This process, AKA second chance, requires a minimum of two generations,
+ * hence MIN_NR_GENS. And to maintain ABI compatibility with the active/in=
active
+ * LRU, these two generations are considered active; the rest of generatio=
ns, if
+ * they exist, are considered inactive. See lru_gen_is_active(). PG_active=
 is
+ * always cleared while a page is on one of lrugen->lists[] so that the ag=
ing
+ * needs not to worry about it. And it's set again when a page considered =
active
+ * is isolated for non-reclaiming purposes, e.g., migration. See
+ * lru_gen_add_folio() and lru_gen_del_folio().
+ *
+ * MAX_NR_GENS is set to 4 so that the multi-gen LRU has twice of the cate=
gories
+ * of the active/inactive LRU.
+ *
+ */
+#define MIN_NR_GENS		2U
+#define MAX_NR_GENS		4U
+
+#ifndef __GENERATING_BOUNDS_H
+
+struct lruvec;
+
+#define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
+#define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
+
+#ifdef CONFIG_LRU_GEN
+
+enum {
+	LRU_GEN_ANON,
+	LRU_GEN_FILE,
+};
+
+/*
+ * The youngest generation number is stored in max_seq for both anon and f=
ile
+ * types as they are aged on an equal footing. The oldest generation numbe=
rs are
+ * stored in min_seq[] separately for anon and file types as clean file pa=
ges
+ * can be evicted regardless of swap constraints.
+ *
+ * Normally anon and file min_seq are in sync. But if swapping is constrai=
ned,
+ * e.g., out of swap space, file min_seq is allowed to advance and leave a=
non
+ * min_seq behind.
+ */
+struct lru_gen_struct {
+	/* the aging increments the youngest generation number */
+	unsigned long max_seq;
+	/* the eviction increments the oldest generation numbers */
+	unsigned long min_seq[ANON_AND_FILE];
+	/* the multi-gen LRU lists */
+	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	/* the sizes of the above lists */
+	unsigned long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+};
+
+void lru_gen_init_lruvec(struct lruvec *lruvec);
+
+#ifdef CONFIG_MEMCG
+void lru_gen_init_memcg(struct mem_cgroup *memcg);
+void lru_gen_exit_memcg(struct mem_cgroup *memcg);
+#endif
+
+#else /* !CONFIG_LRU_GEN */
+
+static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
+{
+}
+
+#ifdef CONFIG_MEMCG
+static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
+{
+}
+
+static inline void lru_gen_exit_memcg(struct mem_cgroup *memcg)
+{
+}
+#endif
+
+#endif /* CONFIG_LRU_GEN */
+
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
 	/* per lruvec lru_lock for memcg */
@@ -320,6 +410,10 @@ struct lruvec {
 	unsigned long			refaults[ANON_AND_FILE];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
+#ifdef CONFIG_LRU_GEN
+	/* evictable pages divided into generations */
+	struct lru_gen_struct		lrugen;
+#endif
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-l=
ayout.h
index ef1e3e736e14..c1946cdb845f 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -55,7 +55,8 @@
 #define SECTIONS_WIDTH		0
 #endif
=20
-#if ZONES_WIDTH + SECTIONS_WIDTH + NODES_SHIFT <=3D BITS_PER_LONG - NR_PAG=
EFLAGS
+#if ZONES_WIDTH + LRU_GEN_WIDTH + LRU_REFS_WIDTH + SECTIONS_WIDTH + NODES_=
SHIFT \
+	<=3D BITS_PER_LONG - NR_PAGEFLAGS
 #define NODES_WIDTH		NODES_SHIFT
 #elif defined(CONFIG_SPARSEMEM_VMEMMAP)
 #error "Vmemmap: No space for nodes field in page flags"
@@ -89,8 +90,8 @@
 #define LAST_CPUPID_SHIFT 0
 #endif
=20
-#if ZONES_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + KASAN_TAG_WIDTH + LAST_CP=
UPID_SHIFT \
-	<=3D BITS_PER_LONG - NR_PAGEFLAGS
+#if ZONES_WIDTH + LRU_GEN_WIDTH + LRU_REFS_WIDTH + SECTIONS_WIDTH + NODES_=
WIDTH + \
+	KASAN_TAG_WIDTH + LAST_CPUPID_SHIFT <=3D BITS_PER_LONG - NR_PAGEFLAGS
 #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
 #else
 #define LAST_CPUPID_WIDTH 0
@@ -100,8 +101,8 @@
 #define LAST_CPUPID_NOT_IN_PAGE_FLAGS
 #endif
=20
-#if ZONES_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + KASAN_TAG_WIDTH + LAST_CP=
UPID_WIDTH \
-	> BITS_PER_LONG - NR_PAGEFLAGS
+#if ZONES_WIDTH + LRU_GEN_WIDTH + LRU_REFS_WIDTH + SECTIONS_WIDTH + NODES_=
WIDTH + \
+	KASAN_TAG_WIDTH + LAST_CPUPID_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
 #error "Not enough bits in page flags"
 #endif
=20
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..a95518ca98eb 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -935,7 +935,7 @@ __PAGEFLAG(Isolated, isolated, PF_ANY);
 	 1UL << PG_private	| 1UL << PG_private_2	|	\
 	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
 	 1UL << PG_slab		| 1UL << PG_active 	|	\
-	 1UL << PG_unevictable	| __PG_MLOCKED)
+	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)
=20
 /*
  * Flags checked when a page is prepped for return by the page allocator.
@@ -946,7 +946,7 @@ __PAGEFLAG(Isolated, isolated, PF_ANY);
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(PAGEFLAGS_MASK & ~__PG_HWPOISON)
+	((PAGEFLAGS_MASK & ~__PG_HWPOISON) | LRU_GEN_MASK | LRU_REFS_MASK)
=20
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..e7fe784b11aa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -914,6 +914,10 @@ struct task_struct {
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
 #endif
+#ifdef CONFIG_LRU_GEN
+	/* whether the LRU algorithm may apply to this access */
+	unsigned			in_lru_fault:1;
+#endif
 #ifdef CONFIG_COMPAT_BRK
 	unsigned			brk_randomized:1;
 #endif
diff --git a/kernel/bounds.c b/kernel/bounds.c
index 9795d75b09b2..e08fb89f87f4 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -22,6 +22,13 @@ int main(void)
 	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
+#ifdef CONFIG_LRU_GEN
+	DEFINE(LRU_GEN_WIDTH, order_base_2(MAX_NR_GENS + 1));
+	DEFINE(LRU_REFS_WIDTH, 0);
+#else
+	DEFINE(LRU_GEN_WIDTH, 0);
+	DEFINE(LRU_REFS_WIDTH, 0);
+#endif
 	/* End of constants */
=20
 	return 0;
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..747ab1690bcf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -892,6 +892,16 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
=20
+# the multi-gen LRU {
+config LRU_GEN
+	bool "Multi-Gen LRU"
+	depends on MMU
+	# the following options can use up the spare bits in page flags
+	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
+	help
+	  A high performance LRU implementation for memory overcommit.
+# }
+
 source "mm/damon/Kconfig"
=20
 endmenu
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..3df389fd307f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2364,7 +2364,8 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 #ifdef CONFIG_64BIT
 			 (1L << PG_arch_2) |
 #endif
-			 (1L << PG_dirty)));
+			 (1L << PG_dirty) |
+			 LRU_GEN_MASK | LRU_REFS_MASK));
=20
 	/* ->mapping in first tail page is compound_mapcount */
 	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping !=3D TAIL_MAPPING,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36e9f38c919d..3fcbfeda259b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5121,6 +5121,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memc=
g)
=20
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
 }
@@ -5180,6 +5181,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->deferred_split_queue.split_queue_len =3D 0;
 #endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
 	mem_cgroup_id_remove(memcg);
diff --git a/mm/memory.c b/mm/memory.c
index a7379196a47e..d27e5f1a2533 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4754,6 +4754,27 @@ static inline void mm_account_fault(struct pt_regs *=
regs,
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
 }
=20
+#ifdef CONFIG_LRU_GEN
+static void lru_gen_enter_fault(struct vm_area_struct *vma)
+{
+	/* the LRU algorithm doesn't apply to sequential or random reads */
+	current->in_lru_fault =3D !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))=
;
+}
+
+static void lru_gen_exit_fault(void)
+{
+	current->in_lru_fault =3D false;
+}
+#else
+static void lru_gen_enter_fault(struct vm_area_struct *vma)
+{
+}
+
+static void lru_gen_exit_fault(void)
+{
+}
+#endif /* CONFIG_LRU_GEN */
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -4785,11 +4806,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *v=
ma, unsigned long address,
 	if (flags & FAULT_FLAG_USER)
 		mem_cgroup_enter_user_fault();
=20
+	lru_gen_enter_fault(vma);
+
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret =3D hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
 		ret =3D __handle_mm_fault(vma, address, flags);
=20
+	lru_gen_exit_fault();
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9ddaf0e1b0ab..0d7b2bd2454a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -65,14 +65,16 @@ void __init mminit_verify_pageflags_layout(void)
=20
 	shift =3D 8 * sizeof(unsigned long);
 	width =3D shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
-		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH;
+		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
-		"Section %d Node %d Zone %d Lastcpupid %d Kasantag %d Flags %d\n",
+		"Section %d Node %d Zone %d Lastcpupid %d Kasantag %d Gen %d Tier %d Fla=
gs %d\n",
 		SECTIONS_WIDTH,
 		NODES_WIDTH,
 		ZONES_WIDTH,
 		LAST_CPUPID_WIDTH,
 		KASAN_TAG_WIDTH,
+		LRU_GEN_WIDTH,
+		LRU_REFS_WIDTH,
 		NR_PAGEFLAGS);
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_shifts",
 		"Section %d Node %d Zone %d Lastcpupid %d Kasantag %d\n",
diff --git a/mm/mmzone.c b/mm/mmzone.c
index eb89d6e018e2..2ec0d7793424 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -81,6 +81,8 @@ void lruvec_init(struct lruvec *lruvec)
=20
 	for_each_lru(lru)
 		INIT_LIST_HEAD(&lruvec->lists[lru]);
+
+	lru_gen_init_lruvec(lruvec);
 }
=20
 #if defined(CONFIG_NUMA_BALANCING) && !defined(LAST_CPUPID_NOT_IN_PAGE_FLA=
GS)
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56..e5f2ab3dab4a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -462,6 +462,11 @@ void folio_add_lru(struct folio *folio)
 	VM_BUG_ON_FOLIO(folio_test_active(folio) && folio_test_unevictable(folio)=
, folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
=20
+	/* see the comment in lru_gen_add_folio() */
+	if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
+	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
+		folio_set_active(folio);
+
 	folio_get(folio);
 	local_lock(&lru_pvecs.lock);
 	pvec =3D this_cpu_ptr(&lru_pvecs.lru_add);
@@ -563,7 +568,7 @@ static void lru_deactivate_file_fn(struct page *page, s=
truct lruvec *lruvec)
=20
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageActive(page) && !PageUnevictable(page)) {
+	if (!PageUnevictable(page) && (PageActive(page) || lru_gen_enabled())) {
 		int nr_pages =3D thp_nr_pages(page);
=20
 		del_page_from_lru_list(page, lruvec);
@@ -677,7 +682,7 @@ void deactivate_file_page(struct page *page)
  */
 void deactivate_page(struct page *page)
 {
-	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && !PageUnevictable(page) && (PageActive(page) || lru_g=
en_enabled())) {
 		struct pagevec *pvec;
=20
 		local_lock(&lru_pvecs.lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8e744cdf802f..65eb668abf2d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3042,6 +3042,79 @@ static bool can_age_anon_pages(struct pglist_data *p=
gdat,
 	return can_demote(pgdat->node_id, sc);
 }
=20
+#ifdef CONFIG_LRU_GEN
+
+/*************************************************************************=
*****
+ *                          shorthand helpers
+ *************************************************************************=
*****/
+
+#define for_each_gen_type_zone(gen, type, zone)				\
+	for ((gen) =3D 0; (gen) < MAX_NR_GENS; (gen)++)			\
+		for ((type) =3D 0; (type) < ANON_AND_FILE; (type)++)	\
+			for ((zone) =3D 0; (zone) < MAX_NR_ZONES; (zone)++)
+
+static struct lruvec *get_lruvec(struct mem_cgroup *memcg, int nid)
+{
+	struct pglist_data *pgdat =3D NODE_DATA(nid);
+
+#ifdef CONFIG_MEMCG
+	if (memcg) {
+		struct lruvec *lruvec =3D &memcg->nodeinfo[nid]->lruvec;
+
+		/* for hotadd_new_pgdat() */
+		if (!lruvec->pgdat)
+			lruvec->pgdat =3D pgdat;
+
+		return lruvec;
+	}
+#endif
+	return pgdat ? &pgdat->__lruvec : NULL;
+}
+
+/*************************************************************************=
*****
+ *                          initialization
+ *************************************************************************=
*****/
+
+void lru_gen_init_lruvec(struct lruvec *lruvec)
+{
+	int gen, type, zone;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	lrugen->max_seq =3D MIN_NR_GENS + 1;
+
+	for_each_gen_type_zone(gen, type, zone)
+		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
+}
+
+#ifdef CONFIG_MEMCG
+void lru_gen_init_memcg(struct mem_cgroup *memcg)
+{
+}
+
+void lru_gen_exit_memcg(struct mem_cgroup *memcg)
+{
+	int nid;
+
+	for_each_node(nid) {
+		struct lruvec *lruvec =3D get_lruvec(memcg, nid);
+
+		VM_BUG_ON(memchr_inv(lruvec->lrugen.nr_pages, 0,
+				     sizeof(lruvec->lrugen.nr_pages)));
+	}
+}
+#endif
+
+static int __init init_lru_gen(void)
+{
+	BUILD_BUG_ON(MIN_NR_GENS + 1 >=3D MAX_NR_GENS);
+	BUILD_BUG_ON(BIT(LRU_GEN_WIDTH) <=3D MAX_NR_GENS);
+
+	return 0;
+};
+late_initcall(init_lru_gen);
+
+#endif /* CONFIG_LRU_GEN */
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
--=20
2.35.1.616.g0bdcbb4464-goog

