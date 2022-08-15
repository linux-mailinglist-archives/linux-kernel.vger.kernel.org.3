Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB4592A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiHOHP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbiHOHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:15:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B81A1CB30
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-329dc6c0d21so51416897b3.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=E6RW7oExGDwF9qsN/IMyA2O3bSn0ZQGVotoxDxLsnOA=;
        b=EAoao/xiYuQhEEfvMwyWTmDwi7CyT7eRtED7HARIe05oU0QCvqQY1y0ZagTplcpN+8
         jGgsL0sY0/j0nPAdkREVlfXKPxs38EIIpJBZyPgYE+VMbu1z0pRW/yCn+H/gStXjTghN
         NIvW4VBaTZUy6s+XqTiGydV7DO0LJhip5wkoUG+NmqjYUdzc9OqEdVpjo2UIiczRji0o
         IHkFoJ+oWlNxroBSmKbeSK4LfXYQ6MolnSVYH3nqjm/ZDCSgUAfEwVZj+px0keXEJauv
         SRrg6XM7JQaEfqby3QoVS7VFEQRD5RiPJ9MpIc9WheYRVlZzTOB/YVldGJlufKfXelVI
         wvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=E6RW7oExGDwF9qsN/IMyA2O3bSn0ZQGVotoxDxLsnOA=;
        b=ifHHI3FLyRfPdwMOUm8z/qyeWd3V8q0ZCQ3qZz16eeAxS53O5rKrwYhx0tK48voXf8
         0PiP84hQ2M95TS5/HsuEN5zM36v11QdgrhzUYmBJe9CLNHMoxTyQHb1N8J2CAENhTPnt
         kzfiTMQVEEDX3fb42ycuormA2Ma7AUCcu+VyfO+W9QpDJbDE325WsDgH4OyuI/c14Boq
         pZHMkWU5zxI2/oCtz1Yqu60E3t0cTdTtKfZjH1AdEVHFOjCBkeuhMjbnh+l33WZPjzsK
         c7NF3pBI45d7DHPPy12m6t8VN9eOMXh9PY1yKpt0g6/iXqUT12zcJrXGZmE0oKP94YMW
         uoIQ==
X-Gm-Message-State: ACgBeo3zGbmJ6mEGxTFUZX08H5RlSPK5YxzYKzTJWNX5y6wIYYuVRtJh
        1ZxxaruAYyjruFBVoQ5T+KFaIa8WUAU=
X-Google-Smtp-Source: AA6agR7+d8Kb/hCTsCDjdKuRWJVf09bOPnmzn8wnPv7wrzNnwxK+iIIunRoxV0JTcgoy0aFK27VDGlyvexg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:d91:5887:ac93:ddf0])
 (user=yuzhao job=sendgmr) by 2002:a25:b686:0:b0:670:ae47:72f1 with SMTP id
 s6-20020a25b686000000b00670ae4772f1mr10937147ybj.255.1660547668212; Mon, 15
 Aug 2022 00:14:28 -0700 (PDT)
Date:   Mon, 15 Aug 2022 01:13:29 -0600
In-Reply-To: <20220815071332.627393-1-yuzhao@google.com>
Message-Id: <20220815071332.627393-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v14 10/14] mm: multi-gen LRU: kill switch
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
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

Add /sys/kernel/mm/lru_gen/enabled as a kill switch. Components that
can be disabled include:
  0x0001: the multi-gen LRU core
  0x0002: walking page table, when arch_has_hw_pte_young() returns
          true
  0x0004: clearing the accessed bit in non-leaf PMD entries, when
          CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy
  [yYnN]: apply to all the components above
E.g.,
  echo y >/sys/kernel/mm/lru_gen/enabled
  cat /sys/kernel/mm/lru_gen/enabled
  0x0007
  echo 5 >/sys/kernel/mm/lru_gen/enabled
  cat /sys/kernel/mm/lru_gen/enabled
  0x0005

NB: the page table walks happen on the scale of seconds under heavy
memory pressure, in which case the mmap_lock contention is a lesser
concern, compared with the LRU lock contention and the I/O congestion.
So far the only well-known case of the mmap_lock contention happens on
Android, due to Scudo [1] which allocates several thousand VMAs for
merely a few hundred MBs. The SPF and the Maple Tree also have
provided their own assessments [2][3]. However, if walking page tables
does worsen the mmap_lock contention, the kill switch can be used to
disable it. In this case the multi-gen LRU will suffer a minor
performance degradation, as shown previously.

Clearing the accessed bit in non-leaf PMD entries can also be
disabled, since this behavior was not tested on x86 varieties other
than Intel and AMD.

[1] https://source.android.com/devices/tech/debug/scudo
[2] https://lore.kernel.org/r/20220128131006.67712-1-michel@lespinasse.org/
[3] https://lore.kernel.org/r/20220426150616.3937571-1-Liam.Howlett@oracle.=
com/

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
 include/linux/cgroup.h          |  15 ++-
 include/linux/mm_inline.h       |  15 ++-
 include/linux/mmzone.h          |   9 ++
 kernel/cgroup/cgroup-internal.h |   1 -
 mm/Kconfig                      |   6 +
 mm/vmscan.c                     | 231 +++++++++++++++++++++++++++++++-
 6 files changed, 268 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed53bfe7c46c..dee80e670291 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -432,6 +432,18 @@ static inline void cgroup_put(struct cgroup *cgrp)
 	css_put(&cgrp->self);
 }
=20
+extern struct mutex cgroup_mutex;
+
+static inline void cgroup_lock(void)
+{
+	mutex_lock(&cgroup_mutex);
+}
+
+static inline void cgroup_unlock(void)
+{
+	mutex_unlock(&cgroup_mutex);
+}
+
 /**
  * task_css_set_check - obtain a task's css_set with extra access conditio=
ns
  * @task: the task to obtain css_set for
@@ -446,7 +458,6 @@ static inline void cgroup_put(struct cgroup *cgrp)
  * as locks used during the cgroup_subsys::attach() methods.
  */
 #ifdef CONFIG_PROVE_RCU
-extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
@@ -708,6 +719,8 @@ struct cgroup;
 static inline u64 cgroup_id(const struct cgroup *cgrp) { return 1; }
 static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
+static inline void cgroup_lock(void) {}
+static inline void cgroup_unlock(void) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
 					 struct task_struct *t) { return 0; }
 static inline int cgroupstats_build(struct cgroupstats *stats,
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f2b2296a42f9..4949eda9a9a2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -106,10 +106,21 @@ static __always_inline enum lru_list folio_lru_list(s=
truct folio *folio)
=20
 #ifdef CONFIG_LRU_GEN
=20
+#ifdef CONFIG_LRU_GEN_ENABLED
 static inline bool lru_gen_enabled(void)
 {
-	return true;
+	DECLARE_STATIC_KEY_TRUE(lru_gen_caps[NR_LRU_GEN_CAPS]);
+
+	return static_branch_likely(&lru_gen_caps[LRU_GEN_CORE]);
 }
+#else
+static inline bool lru_gen_enabled(void)
+{
+	DECLARE_STATIC_KEY_FALSE(lru_gen_caps[NR_LRU_GEN_CAPS]);
+
+	return static_branch_unlikely(&lru_gen_caps[LRU_GEN_CORE]);
+}
+#endif
=20
 static inline bool lru_gen_in_fault(void)
 {
@@ -222,7 +233,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lru=
vec, struct folio *folio,
=20
 	VM_WARN_ON_ONCE_FOLIO(gen !=3D -1, folio);
=20
-	if (folio_test_unevictable(folio))
+	if (folio_test_unevictable(folio) || !lrugen->enabled)
 		return false;
 	/*
 	 * There are three common cases for this page:
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 51e521465742..7f8c529b46ad 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -387,6 +387,13 @@ enum {
 	LRU_GEN_FILE,
 };
=20
+enum {
+	LRU_GEN_CORE,
+	LRU_GEN_MM_WALK,
+	LRU_GEN_NONLEAF_YOUNG,
+	NR_LRU_GEN_CAPS
+};
+
 #define MIN_LRU_BATCH		BITS_PER_LONG
 #define MAX_LRU_BATCH		(MIN_LRU_BATCH * 128)
=20
@@ -428,6 +435,8 @@ struct lru_gen_struct {
 	/* can be modified without holding the LRU lock */
 	atomic_long_t evicted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	atomic_long_t refaulted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
+	/* whether the multi-gen LRU is enabled */
+	bool enabled;
 };
=20
 enum {
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-interna=
l.h
index 36b740cb3d59..63dc3e82be4f 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -164,7 +164,6 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name =3D CGROUP_MGCTX_INIT(name)
=20
-extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
diff --git a/mm/Kconfig b/mm/Kconfig
index 5101dca8f21c..6c86849c4db9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1133,6 +1133,12 @@ config LRU_GEN
 	help
 	  A high performance LRU implementation to overcommit memory.
=20
+config LRU_GEN_ENABLED
+	bool "Enable by default"
+	depends on LRU_GEN
+	help
+	  This option enables the multi-gen LRU by default.
+
 config LRU_GEN_STATS
 	bool "Full stats for debugging"
 	depends on LRU_GEN
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee51c752a3af..5502c553e32e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -51,6 +51,7 @@
 #include <linux/psi.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
+#include <linux/ctype.h>
=20
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -3071,6 +3072,14 @@ static bool can_age_anon_pages(struct pglist_data *p=
gdat,
=20
 #ifdef CONFIG_LRU_GEN
=20
+#ifdef CONFIG_LRU_GEN_ENABLED
+DEFINE_STATIC_KEY_ARRAY_TRUE(lru_gen_caps, NR_LRU_GEN_CAPS);
+#define get_cap(cap)	static_branch_likely(&lru_gen_caps[cap])
+#else
+DEFINE_STATIC_KEY_ARRAY_FALSE(lru_gen_caps, NR_LRU_GEN_CAPS);
+#define get_cap(cap)	static_branch_unlikely(&lru_gen_caps[cap])
+#endif
+
 /*************************************************************************=
*****
  *                          shorthand helpers
  *************************************************************************=
*****/
@@ -3948,7 +3957,8 @@ static void walk_pmd_range_locked(pud_t *pud, unsigne=
d long next, struct vm_area
 			goto next;
=20
 		if (!pmd_trans_huge(pmd[i])) {
-			if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG))
+			if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) &&
+			    get_cap(LRU_GEN_NONLEAF_YOUNG))
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
 		}
@@ -4046,10 +4056,12 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
=20
 #ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
-		if (!pmd_young(val))
-			continue;
+		if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
+			if (!pmd_young(val))
+				continue;
=20
-		walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
+			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
+		}
 #endif
 		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq,=
 pmd + i))
 			continue;
@@ -4314,7 +4326,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec,=
 unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!arch_has_hw_pte_young()) {
+	if (!(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))) {
 		success =3D iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
@@ -5050,6 +5062,211 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
=20
+/*************************************************************************=
*****
+ *                          state change
+ *************************************************************************=
*****/
+
+static bool __maybe_unused state_is_valid(struct lruvec *lruvec)
+{
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	if (lrugen->enabled) {
+		enum lru_list lru;
+
+		for_each_evictable_lru(lru) {
+			if (!list_empty(&lruvec->lists[lru]))
+				return false;
+		}
+	} else {
+		int gen, type, zone;
+
+		for_each_gen_type_zone(gen, type, zone) {
+			if (!list_empty(&lrugen->lists[gen][type][zone]))
+				return false;
+
+			/* unlikely but not a bug when reset_batch_size() is pending */
+			VM_WARN_ON_ONCE(lrugen->nr_pages[gen][type][zone]);
+		}
+	}
+
+	return true;
+}
+
+static bool fill_evictable(struct lruvec *lruvec)
+{
+	enum lru_list lru;
+	int remaining =3D MAX_LRU_BATCH;
+
+	for_each_evictable_lru(lru) {
+		int type =3D is_file_lru(lru);
+		bool active =3D is_active_lru(lru);
+		struct list_head *head =3D &lruvec->lists[lru];
+
+		while (!list_empty(head)) {
+			bool success;
+			struct folio *folio =3D lru_to_folio(head);
+
+			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio) !=3D active, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=3D type, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_lru_gen(folio) !=3D -1, folio);
+
+			lruvec_del_folio(lruvec, folio);
+			success =3D lru_gen_add_folio(lruvec, folio, false);
+			VM_WARN_ON_ONCE(!success);
+
+			if (!--remaining)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static bool drain_evictable(struct lruvec *lruvec)
+{
+	int gen, type, zone;
+	int remaining =3D MAX_LRU_BATCH;
+
+	for_each_gen_type_zone(gen, type, zone) {
+		struct list_head *head =3D &lruvec->lrugen.lists[gen][type][zone];
+
+		while (!list_empty(head)) {
+			bool success;
+			struct folio *folio =3D lru_to_folio(head);
+
+			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=3D type, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D zone, folio);
+
+			success =3D lru_gen_del_folio(lruvec, folio, false);
+			VM_WARN_ON_ONCE(!success);
+			lruvec_add_folio(lruvec, folio);
+
+			if (!--remaining)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static void lru_gen_change_state(bool enabled)
+{
+	static DEFINE_MUTEX(state_mutex);
+
+	struct mem_cgroup *memcg;
+
+	cgroup_lock();
+	cpus_read_lock();
+	get_online_mems();
+	mutex_lock(&state_mutex);
+
+	if (enabled =3D=3D lru_gen_enabled())
+		goto unlock;
+
+	if (enabled)
+		static_branch_enable_cpuslocked(&lru_gen_caps[LRU_GEN_CORE]);
+	else
+		static_branch_disable_cpuslocked(&lru_gen_caps[LRU_GEN_CORE]);
+
+	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		int nid;
+
+		for_each_node(nid) {
+			struct lruvec *lruvec =3D get_lruvec(memcg, nid);
+
+			if (!lruvec)
+				continue;
+
+			spin_lock_irq(&lruvec->lru_lock);
+
+			VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
+			VM_WARN_ON_ONCE(!state_is_valid(lruvec));
+
+			lruvec->lrugen.enabled =3D enabled;
+
+			while (!(enabled ? fill_evictable(lruvec) : drain_evictable(lruvec))) {
+				spin_unlock_irq(&lruvec->lru_lock);
+				cond_resched();
+				spin_lock_irq(&lruvec->lru_lock);
+			}
+
+			spin_unlock_irq(&lruvec->lru_lock);
+		}
+
+		cond_resched();
+	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
+unlock:
+	mutex_unlock(&state_mutex);
+	put_online_mems();
+	cpus_read_unlock();
+	cgroup_unlock();
+}
+
+/*************************************************************************=
*****
+ *                          sysfs interface
+ *************************************************************************=
*****/
+
+static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *a=
ttr, char *buf)
+{
+	unsigned int caps =3D 0;
+
+	if (get_cap(LRU_GEN_CORE))
+		caps |=3D BIT(LRU_GEN_CORE);
+
+	if (arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))
+		caps |=3D BIT(LRU_GEN_MM_WALK);
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) && get_cap(LRU_GEN_NONL=
EAF_YOUNG))
+		caps |=3D BIT(LRU_GEN_NONLEAF_YOUNG);
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);
+}
+
+static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *=
attr,
+			     const char *buf, size_t len)
+{
+	int i;
+	unsigned int caps;
+
+	if (tolower(*buf) =3D=3D 'n')
+		caps =3D 0;
+	else if (tolower(*buf) =3D=3D 'y')
+		caps =3D -1;
+	else if (kstrtouint(buf, 0, &caps))
+		return -EINVAL;
+
+	for (i =3D 0; i < NR_LRU_GEN_CAPS; i++) {
+		bool enabled =3D caps & BIT(i);
+
+		if (i =3D=3D LRU_GEN_CORE)
+			lru_gen_change_state(enabled);
+		else if (enabled)
+			static_branch_enable(&lru_gen_caps[i]);
+		else
+			static_branch_disable(&lru_gen_caps[i]);
+	}
+
+	return len;
+}
+
+static struct kobj_attribute lru_gen_enabled_attr =3D __ATTR(
+	enabled, 0644, show_enabled, store_enabled
+);
+
+static struct attribute *lru_gen_attrs[] =3D {
+	&lru_gen_enabled_attr.attr,
+	NULL
+};
+
+static struct attribute_group lru_gen_attr_group =3D {
+	.name =3D "lru_gen",
+	.attrs =3D lru_gen_attrs,
+};
+
 /*************************************************************************=
*****
  *                          initialization
  *************************************************************************=
*****/
@@ -5060,6 +5277,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
=20
 	lrugen->max_seq =3D MIN_NR_GENS + 1;
+	lrugen->enabled =3D lru_gen_enabled();
=20
 	for_each_gen_type_zone(gen, type, zone)
 		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
@@ -5099,6 +5317,9 @@ static int __init init_lru_gen(void)
 	BUILD_BUG_ON(MIN_NR_GENS + 1 >=3D MAX_NR_GENS);
 	BUILD_BUG_ON(BIT(LRU_GEN_WIDTH) <=3D MAX_NR_GENS);
=20
+	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
+		pr_err("lru_gen: failed to create sysfs group\n");
+
 	return 0;
 };
 late_initcall(init_lru_gen);
--=20
2.37.1.595.g718a3a8f04-goog

