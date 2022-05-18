Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF80B52B028
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiERBsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiERBrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:47:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989554BE6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:47:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s196-20020a252ccd000000b0064ea2e6bcb7so229133ybs.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NTA14FnCNnSPTudLkNszGIL3HdbMAT4nMBCkNLY5YRU=;
        b=dj/NUzQ7pldQ5p6qQOOz1M0rA++R2i0rkuA/pdh7gKHKfecCVVJbxlcKWafSRzT+io
         P2/TwGHl8GyP+Mg5hb/SV8E48PYJa7SyPhOeCh2WtveDGvIqR63kJBDvMBRon9bfxFwc
         cb+4Ti+w2hCv3EbKxHhCjMCuicPeQiavbDKafGr2N+HvVGBiBGlMin4TBHAZPvg5HWiV
         fsxaCDJXxWjs84OmU9+hKlIJ1ZEGHcKvSILfuBZ+lCwaenIW0SoaNOUqcU3H99tZA0Pp
         OpihneRVY05VI5/nix7QlSlUnp7oGxB689r8rUG7RiYvAjaJUxEm2rPSva5gOkSmMRqe
         EN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NTA14FnCNnSPTudLkNszGIL3HdbMAT4nMBCkNLY5YRU=;
        b=FPq1AiYyVsKTPOEn16VwWiUTZb0Jbiga3lDiv+eNINBk2hV3aZpaioYknsPzco6oq8
         3JVFlQszcxusqV5TEUmxikpICBnb+hh70bgDa9VevJC6r9neqfmcaMftt39KlR+3sQiX
         eqr+OlpcER6Y/b9uTzMfqzP5S7oOeX4BoQhC7LR2w/GaHvvs9NSaNeH0e2zGKILLGlSy
         pb3zqPB5+H503gX37lgH0xSk/gzXjNbQ1BdL0TCe0f+Lsmeu0oaGkEeKdMtEIbR/rjLu
         LnUZJxuhNfQy26/d5od03JDZy1CGVzk5OeXNCp9ejEkgzMAv3DTpf1iczFc2J+acO0iC
         PyiQ==
X-Gm-Message-State: AOAM531KhJGP4phWQQt0aY9y82aaZubL2vzWv52PPio6V1pHoWNjTIeC
        Clil4jWJZWW2DAWWzBEHvRLHRMv4vlo=
X-Google-Smtp-Source: ABdhPJwTsKX58YMZjZU473qHcm2WfVL2bwxTclJIx+w2+3BMEn4WcPcuNwyIzbAE4LxodKTFVAQMvubt74g=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:f7bc:90c9:d86e:4ea8])
 (user=yuzhao job=sendgmr) by 2002:a81:ac11:0:b0:2fe:ee45:c6bb with SMTP id
 k17-20020a81ac11000000b002feee45c6bbmr15371827ywh.427.1652838428578; Tue, 17
 May 2022 18:47:08 -0700 (PDT)
Date:   Tue, 17 May 2022 19:46:29 -0600
In-Reply-To: <20220518014632.922072-1-yuzhao@google.com>
Message-Id: <20220518014632.922072-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v11 10/14] mm: multi-gen LRU: kill switch
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/cgroup.h          |  15 +-
 include/linux/mm_inline.h       |  12 +-
 include/linux/mmzone.h          |   9 ++
 kernel/cgroup/cgroup-internal.h |   1 -
 mm/Kconfig                      |   6 +
 mm/vmscan.c                     | 238 +++++++++++++++++++++++++++++++-
 6 files changed, 272 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0d1ada8968d7..1bc0cabf993f 100644
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
index 85fe78832436..d3d7b7bb297d 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -106,7 +106,15 @@ static __always_inline enum lru_list folio_lru_list(st=
ruct folio *folio)
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
@@ -219,7 +227,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lru=
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
index 6aa715a2fea1..372a7f5a6829 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -386,6 +386,13 @@ enum {
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
@@ -427,6 +434,8 @@ struct lru_gen_struct {
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
index 0aeacbd3361c..426ea5f57d88 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -918,6 +918,12 @@ config LRU_GEN
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
index a7e768675707..09e2c3e6f2be 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -52,6 +52,7 @@
 #include <linux/psi.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
+#include <linux/ctype.h>
=20
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -2989,6 +2990,12 @@ static bool can_age_anon_pages(struct pglist_data *p=
gdat,
=20
 #ifdef CONFIG_LRU_GEN
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
@@ -3009,6 +3016,15 @@ static bool can_age_anon_pages(struct pglist_data *p=
gdat,
 		for ((type) =3D 0; (type) < ANON_AND_FILE; (type)++)	\
 			for ((zone) =3D 0; (zone) < MAX_NR_ZONES; (zone)++)
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
@@ -3816,7 +3832,8 @@ static void walk_pmd_range_locked(pud_t *pud, unsigne=
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
@@ -3926,10 +3943,12 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
 		walk->mm_stats[MM_PMD_TOTAL]++;
=20
 #ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
-		if (!pmd_young(val))
-			continue;
+		if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
+			if (!pmd_young(val))
+				continue;
=20
-		walk_pmd_range_locked(pud, addr, vma, args, &pos);
+			walk_pmd_range_locked(pud, addr, vma, args, &pos);
+		}
 #endif
 		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq,=
 pmd + i))
 			continue;
@@ -4162,7 +4181,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec,=
 unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!arch_has_hw_pte_young()) {
+	if (!(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))) {
 		success =3D iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
@@ -4895,6 +4914,211 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
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
+			VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
+			VM_WARN_ON_ONCE(!state_is_valid(lruvec));
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
@@ -4905,6 +5129,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
=20
 	lrugen->max_seq =3D MIN_NR_GENS + 1;
+	lrugen->enabled =3D lru_gen_enabled();
=20
 	for_each_gen_type_zone(gen, type, zone)
 		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
@@ -4945,6 +5170,9 @@ static int __init init_lru_gen(void)
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
2.36.0.550.gb090851708-goog

