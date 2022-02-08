Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38C14AD30F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349316AbiBHIUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349177AbiBHITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:19:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7A1C03FEDA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:19:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t8-20020a259ac8000000b00619a3b5977fso34149245ybo.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=0BXyO0PKK7CUSbeV+6Qnj8UbyGthBxtpCJsNt1soUUg=;
        b=KAx/iZ9svyK4ObUuX8iuJmFV3DiPdun9klzyG5ld1dYnzaBrkASTVzQxY84IbSKHzr
         4xxKGTr2M2y0Mfkw+1VlzsT9YDQQE82VA1lRjpiZF1cHgCjyeiY18kxA0jDugTYpznp7
         LnewJWKHsv/5TAO10lfqEGyj10AIzXBYZE16i9eN2RLjXdVjMJ9tXVbtLIfDtbxFV/Jo
         TNoU9JOxwZtsVRF1gcI8WMGFpn+RpNgS7n4HKOblWKkymgC4O3UqvcHnaqz/mN3jQ94F
         ArYg8fhyNRBNzb5Pzk6w2gskCSclECA9FkpOMpQHgn3qbNJ7oRsA8sqqiIaS0jarHPe+
         m5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=0BXyO0PKK7CUSbeV+6Qnj8UbyGthBxtpCJsNt1soUUg=;
        b=vsQpQlsctsMb69OiRyyn1te0G7g1IGEKE9x9Y/KijUDC3JIvGmYOogZCQjzOwW0+8W
         XwKmP408XeWa+tT+YD/mcIkrorfhnvGbnnWFJ4pJBju+id9J4XJWV3Oecoa9HmRo1tpG
         4WSOStJ0hjUNRToK0xEuQS/nqU9Mn1CqUOS+JzjFqBMc/6L25UP6nGA81J49hNl6KF13
         +xYQ4dZx2NH7t0p2LA4qyGiO0HGn0zpFVy8ouvf9uBknmyPvSF+NtdPur0lPzJQwkW73
         WbVyS17A9NhKPdmNDsKh5YWHcM9fFU9B0jfAm7/2H0H3GVBqLN8sCZRsyQDtUBzwqURy
         dnhg==
X-Gm-Message-State: AOAM532EUxQ5QQ13WsKqB14B0zQk7c6fxNdbazDJFnmu1te+LJyDiJQJ
        7QDObDXrOA41teR5i9NAuQkpqMGxrlw=
X-Google-Smtp-Source: ABdhPJyfRNtK8fQEnpFOFnjoUd54PtiPMNuR17kYMjb9Xjj4M6nkXaP0KwGeiWwcMRE8Var+bOeyh57f1jQ=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
 (user=yuzhao job=sendgmr) by 2002:a81:ce0b:: with SMTP id t11mr3946599ywi.421.1644308379615;
 Tue, 08 Feb 2022 00:19:39 -0800 (PST)
Date:   Tue,  8 Feb 2022 01:18:59 -0700
In-Reply-To: <20220208081902.3550911-1-yuzhao@google.com>
Message-Id: <20220208081902.3550911-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 09/12] mm: multigenerational LRU: runtime switch
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
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
        Sofia Trinh <sofia.trinh@edi.works>
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

Add /sys/kernel/mm/lru_gen/enabled as a runtime switch. Features that
can be enabled or disabled include:
  0x0001: the multigenerational LRU
  0x0002: the page table walks, when arch_has_hw_pte_young() returns
          true
  0x0004: the use of the accessed bit in non-leaf PMD entries, when
          CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy
  [yYnN]: apply to all the features above
E.g.,
  echo y >/sys/kernel/mm/lru_gen/enabled
  cat /sys/kernel/mm/lru_gen/enabled
  0x0007
  echo 5 >/sys/kernel/mm/lru_gen/enabled
  cat /sys/kernel/mm/lru_gen/enabled
  0x0005

NB: the page table walks happen on the scale of seconds under heavy
memory pressure. Under such a condition, the mmap_lock contention is a
lesser concern, compared with the LRU lock contention and the I/O
congestion. So far the only well-known case of the mmap_lock
contention is Android, due to Scudo [1] which allocates several
thousand VMAs for merely a few hundred MBs. The SPF and the Maple Tree
also have provided their own assessments [2][3]. However, if the page
table walks do worsen the mmap_lock contention, the runtime switch can
be used to disable this feature. In this case the multigenerational
LRU will suffer a minor performance degradation, as shown previously.

The use of the accessed bit in non-leaf PMD entries can also be
disabled, since this feature wasn't tested on x86 varieties other than
Intel and AMD.

[1] https://source.android.com/devices/tech/debug/scudo
[2] https://lore.kernel.org/lkml/20220128131006.67712-1-michel@lespinasse.o=
rg/
[3] https://lore.kernel.org/lkml/20220202024137.2516438-1-Liam.Howlett@orac=
le.com/

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
---
 include/linux/cgroup.h          |  15 +-
 include/linux/mm_inline.h       |  10 +-
 include/linux/mmzone.h          |   7 +
 kernel/cgroup/cgroup-internal.h |   1 -
 mm/Kconfig                      |   6 +
 mm/vmscan.c                     | 236 +++++++++++++++++++++++++++++++-
 6 files changed, 267 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c151413fda..b145025f3eac 100644
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
@@ -707,6 +718,8 @@ struct cgroup;
 static inline u64 cgroup_id(const struct cgroup *cgrp) { return 1; }
 static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
+static inline void cgroup_lock(void) {}
+static inline void cgroup_unlock(void) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
 					 struct task_struct *t) { return 0; }
 static inline int cgroupstats_build(struct cgroupstats *stats,
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 37c8a0ede4ff..130d62751e05 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -96,7 +96,15 @@ static __always_inline enum lru_list folio_lru_list(stru=
ct folio *folio)
=20
 static inline bool lru_gen_enabled(void)
 {
-	return true;
+#ifdef CONFIG_LRU_GEN_ENABLED
+	DECLARE_STATIC_KEY_TRUE(lru_gen_caps[NR_LRU_GEN_CAPS]);
+
+	return static_branch_likely(&lru_gen_caps[LRU_GEN_CORE]);
+#else
+	DECLARE_STATIC_KEY_FALSE(lru_gen_caps[NR_LRU_GEN_CAPS]);
+
+	return static_branch_unlikely(&lru_gen_caps[LRU_GEN_CORE]);
+#endif
 }
=20
 static inline bool lru_gen_in_fault(void)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fa0a7a84ee58..4ecec9152761 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -311,6 +311,13 @@ struct page_vma_mapped_walk;
=20
 #ifdef CONFIG_LRU_GEN
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
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-interna=
l.h
index 6e36e854b512..929ed3bf1a7c 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -165,7 +165,6 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name =3D CGROUP_MGCTX_INIT(name)
=20
-extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
diff --git a/mm/Kconfig b/mm/Kconfig
index e899623d5df0..aae72b740d8a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -903,6 +903,12 @@ config LRU_GEN
 	  Documentation/admin-guide/mm/multigen_lru.rst and
 	  Documentation/vm/multigen_lru.rst for details.
=20
+config LRU_GEN_ENABLED
+	bool "Enable by default"
+	depends on LRU_GEN
+	help
+	  This option enables the multigenerational LRU by default.
+
 config NR_LRU_GENS
 	int "Max number of generations"
 	depends on LRU_GEN
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fc09b6c10624..700c35f2a030 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3066,6 +3066,12 @@ enum {
 	TYPE_FILE,
 };
=20
+#ifdef CONFIG_LRU_GEN_ENABLED
+DEFINE_STATIC_KEY_ARRAY_TRUE(lru_gen_caps, NR_LRU_GEN_CAPS);
+#else
+DEFINE_STATIC_KEY_ARRAY_FALSE(lru_gen_caps, NR_LRU_GEN_CAPS);
+#endif
+
 /*************************************************************************=
*****
  *                          shorthand helpers
  *************************************************************************=
*****/
@@ -3102,6 +3108,15 @@ static int folio_lru_tier(struct folio *folio)
 	return lru_tier_from_refs(refs);
 }
=20
+static bool get_cap(int cap)
+{
+#ifdef CONFIG_LRU_GEN_ENABLED
+	return static_branch_likely(&lru_gen_caps[cap]);
+#else
+	return static_branch_unlikely(&lru_gen_caps[cap]);
+#endif
+}
+
 static struct lruvec *get_lruvec(struct mem_cgroup *memcg, int nid)
 {
 	struct pglist_data *pgdat =3D NODE_DATA(nid);
@@ -3893,7 +3908,8 @@ static void walk_pmd_range_locked(pud_t *pud, unsigne=
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
@@ -4000,10 +4016,12 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
 		priv->mm_stats[MM_PMD_TOTAL]++;
=20
 #ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
-		if (!pmd_young(val))
-			continue;
+		if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
+			if (!pmd_young(val))
+				continue;
=20
-		walk_pmd_range_locked(pud, addr, vma, walk, &pos);
+			walk_pmd_range_locked(pud, addr, vma, walk, &pos);
+		}
 #endif
 		if (!priv->full_scan && !test_bloom_filter(priv->lruvec, priv->max_seq, =
pmd + i))
 			continue;
@@ -4235,7 +4253,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec,=
 unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!full_scan && !arch_has_hw_pte_young()) {
+	if (!full_scan && (!arch_has_hw_pte_young() || !get_cap(LRU_GEN_MM_WALK))=
) {
 		success =3D iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
@@ -4941,6 +4959,211 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc
 		current->reclaim_state->mm_walk =3D NULL;
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
+			VM_WARN_ON(lrugen->nr_pages[gen][type][zone]);
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
+			VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
+			VM_BUG_ON_FOLIO(folio_test_active(folio) !=3D active, folio);
+			VM_BUG_ON_FOLIO(folio_is_file_lru(folio) !=3D type, folio);
+			VM_BUG_ON_FOLIO(folio_lru_gen(folio) < MAX_NR_GENS, folio);
+
+			lruvec_del_folio(lruvec, folio);
+			success =3D lru_gen_add_folio(lruvec, folio, false);
+			VM_BUG_ON(!success);
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
+			VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
+			VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
+			VM_BUG_ON_FOLIO(folio_is_file_lru(folio) !=3D type, folio);
+			VM_BUG_ON_FOLIO(folio_zonenum(folio) !=3D zone, folio);
+
+			success =3D lru_gen_del_folio(lruvec, folio, false);
+			VM_BUG_ON(!success);
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
+static void lru_gen_change_state(bool enable)
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
+	if (enable =3D=3D lru_gen_enabled())
+		goto unlock;
+
+	if (enable)
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
+			VM_BUG_ON(!seq_is_valid(lruvec));
+			VM_BUG_ON(!state_is_valid(lruvec));
+
+			lruvec->lrugen.enabled =3D enable;
+
+			while (!(enable ? fill_evictable(lruvec) : drain_evictable(lruvec))) {
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
+static ssize_t show_enable(struct kobject *kobj, struct kobj_attribute *at=
tr, char *buf)
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
+static ssize_t store_enable(struct kobject *kobj, struct kobj_attribute *a=
ttr,
+			    const char *buf, size_t len)
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
+		bool enable =3D caps & BIT(i);
+
+		if (i =3D=3D LRU_GEN_CORE)
+			lru_gen_change_state(enable);
+		else if (enable)
+			static_branch_enable(&lru_gen_caps[i]);
+		else
+			static_branch_disable(&lru_gen_caps[i]);
+	}
+
+	return len;
+}
+
+static struct kobj_attribute lru_gen_enabled_attr =3D __ATTR(
+	enabled, 0644, show_enable, store_enable
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
@@ -5007,6 +5230,9 @@ static int __init init_lru_gen(void)
 	BUILD_BUG_ON(BIT(LRU_GEN_WIDTH) <=3D MAX_NR_GENS);
 	BUILD_BUG_ON(sizeof(MM_STAT_CODES) !=3D NR_MM_STATS + 1);
=20
+	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
+		pr_err("lru_gen: failed to create sysfs group\n");
+
 	return 0;
 };
 late_initcall(init_lru_gen);
--=20
2.35.0.263.gb82422642f-goog

