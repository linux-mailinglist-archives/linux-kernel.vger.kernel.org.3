Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DE4AD310
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349281AbiBHIUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349059AbiBHITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:19:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6332C03FEC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:19:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso34094414ybr.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Qy/jG63Z/HNwxweC2LEWg9GcwwRdrJKnRVS+XoInOik=;
        b=qpWPzAtI+Lh2V4y6mtn3SWiFQ2Uq5tGeu8mzKoodNF38MqP5TvGw+ouAfOdjW0zItu
         HkKfgMYmd/lq/49tidKMscnAFHiANf3rXb8NcqiI+/aRIKx2pH4WkZkNE1mFVtsVfnoI
         6ePYBz51kU52Ch++O8PbIujICPODj9c0ed6ABcONk0O9313T1LBEyJCpvVRmPgeB0jzK
         OdH9LFAHi63lofDFL0L7pMlXK31UtH1Qi5L9DCM+i7ANHOE14ZCSUWcqitXtTofrUFhl
         W0UaBZUdkuNlTtgNydMRyjaHlhqtXc4i39kSJi2pWNDi9RzhM/llXfAUEvWOICpSsd2A
         7H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Qy/jG63Z/HNwxweC2LEWg9GcwwRdrJKnRVS+XoInOik=;
        b=1i6i7VVA70UXgkF5RDVCPftB+Qvdl/c9msohRdL3GrffhMX/CbTKf03DR2j1d1epb/
         R2DQwcrgBgpPnVKu/sn7vvePxQ88QQ1EWz6esA5Xxd41/rYUQW+YTMq6VP1bg+eBTAuJ
         t8Ee/RLecs1xnLjMq/8jdDrqe1lvQDQK7U8NR/ZinYlogg8PCFzlUax2/pW9TRz8RmZ1
         0kcdjEOhX5t7jazZsaWCXbzruYDSEu1BWDcdKLiKa5fROckX3+tGfy1hSvI08rzcNrPL
         Nhsw8VUmLg98lWlgXItkGelBXhlIYMs+puET0WiXIYvD1RL2U2CWcVCYBt2Hr4cH8xNS
         G9Eg==
X-Gm-Message-State: AOAM532drNtgNgioQW4RYg2a2RWGQDj/HilmozsZgAt61FPxJG+t7zsC
        cy8FYXUqY/Nv8HxbWVcGM3noemitSHI=
X-Google-Smtp-Source: ABdhPJw9T4ScbAOd16782C2gEYqqYuQMupTU1Yf6CmIJLtOeMwLlgSKgG1ridxnKqPIZ2c+e4Sj7ugetd0A=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
 (user=yuzhao job=sendgmr) by 2002:a81:8d07:: with SMTP id d7mr1305983ywg.212.1644308374011;
 Tue, 08 Feb 2022 00:19:34 -0800 (PST)
Date:   Tue,  8 Feb 2022 01:18:55 -0700
In-Reply-To: <20220208081902.3550911-1-yuzhao@google.com>
Message-Id: <20220208081902.3550911-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 05/12] mm: multigenerational LRU: minimal implementation
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

To avoid confusions, the terms "promotion" and "demotion" will be
applied to the multigenerational LRU, as a new convention; the terms
"activation" and "deactivation" will be applied to the active/inactive
LRU, as usual.

The aging produces young generations. Given an lruvec, it increments
max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
promotes hot pages to the youngest generation when it finds them
accessed through page tables; the demotion of cold pages happens
consequently when it increments max_seq. Since the aging is only
interested in hot pages, its complexity is O(nr_hot_pages). Promotion
in the aging path doesn't require any LRU list operations, only the
updates of the gen counter and lrugen->nr_pages[]; demotion, unless
as the result of the increment of max_seq, requires LRU list
operations, e.g., lru_deactivate_fn().

The eviction consumes old generations. Given an lruvec, it increments
min_seq when the list indexed by min_seq%MAX_NR_GENS becomes empty. A
feedback loop modeled after the PID controller monitors refaults over
anon and file types and decides which type to evict when both are
available from the same generation.

Each generation is divided into multiple tiers. Tiers represent
different ranges of numbers of accesses through file descriptors. A
page accessed N times through file descriptors is in tier
order_base_2(N). Tiers don't have dedicated lrugen->lists[], only bits
in folio->flags.  In contrast to moving across generations which
requires the LRU lock, moving between tiers only involves operations
on folio->flags. The feedback loop also monitors refaults over all
tiers and decides when to promote pages in which tiers (N>1), using
the first tier (N=3D0,1) as a baseline. The first tier contains
single-use unmapped clean pages, which are most likely the best
choices. The eviction promotes a page to the next generation, i.e.,
min_seq+1 rather than max_seq, if the feedback loop decides so. This
approach has the following advantages:
1) It removes the cost of activation in the buffered access path by
   inferring whether pages accessed multiple times through file
   descriptors are statistically hot and thus worth promoting in the
   eviction path.
2) It takes pages accessed through page tables into account and avoids
   overprotecting pages accessed multiple times through file
   descriptors. (Pages accessed through page tables are in the first
   tier since N=3D0.)
3) More tiers provide better protection for pages accessed more than
   twice through file descriptors, when under heavy buffered I/O
   workloads.

Server benchmark results:
  Single workload:
    fio (buffered I/O): +[47, 49]%
                IOPS         BW
      5.17-rc2: 2242k        8759MiB/s
      patch1-5: 3321k        12.7GiB/s

  Single workload:
    memcached (anon): +[101, 105]%
                Ops/sec      KB/sec
      5.17-rc2: 476771.79    18544.31
      patch1-5: 972526.07    37826.95

  Configurations:
    CPU: two Xeon 6154
    Mem: total 256G

    Node 1 was used as a ram disk only to reduce the variance in the
    results.

    patch drivers/block/brd.c <<EOF
    99,100c99,100
    < 	gfp_flags =3D GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
    < 	page =3D alloc_page(gfp_flags);
    ---
    > 	gfp_flags =3D GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM | __GFP_THISNODE=
;
    > 	page =3D alloc_pages_node(1, gfp_flags, 0);
    EOF

    cat >>/etc/systemd/system.conf <<OEF
    CPUAffinity=3Dnuma
    NUMAPolicy=3Dbind
    NUMAMask=3D0
    OEF

    cat >>/etc/memcached.conf <<OEF
    -m 184320
    -s /var/run/memcached/memcached.sock
    -a 0766
    -t 36
    -B binary
    OEF

    cat fio.sh
    modprobe brd rd_nr=3D1 rd_size=3D113246208
    mkfs.ext4 /dev/ram0
    mount -t ext4 /dev/ram0 /mnt

    mkdir /sys/fs/cgroup/user.slice/test
    echo 38654705664 >/sys/fs/cgroup/user.slice/test/memory.max
    echo $$ >/sys/fs/cgroup/user.slice/test/cgroup.procs
    fio -name=3Dmglru --numjobs=3D72 --directory=3D/mnt --size=3D1408m \
      --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
      --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
      --rw=3Drandread --random_distribution=3Drandom --norandommap \
      --time_based --ramp_time=3D10m --runtime=3D5m --group_reporting

    cat memcached.sh
    modprobe brd rd_nr=3D1 rd_size=3D113246208
    swapoff -a
    mkswap /dev/ram0
    swapon /dev/ram0

    memtier_benchmark -S /var/run/memcached/memcached.sock \
      -P memcache_binary -n allkeys --key-minimum=3D1 \
      --key-maximum=3D65000000 --key-pattern=3DP:P -c 1 -t 36 \
      --ratio 1:0 --pipeline 8 -d 2000

    memtier_benchmark -S /var/run/memcached/memcached.sock \
      -P memcache_binary -n allkeys --key-minimum=3D1 \
      --key-maximum=3D65000000 --key-pattern=3DR:R -c 1 -t 36 \
      --ratio 0:1 --pipeline 8 --randomize --distinct-client-seed

Client benchmark results:
  kswapd profiles:
    5.17-rc2
      38.05%  page_vma_mapped_walk
      20.86%  lzo1x_1_do_compress (real work)
       6.16%  do_raw_spin_lock
       4.61%  _raw_spin_unlock_irq
       2.20%  vma_interval_tree_iter_next
       2.19%  vma_interval_tree_subtree_search
       2.15%  page_referenced_one
       1.93%  anon_vma_interval_tree_iter_first
       1.65%  ptep_clear_flush
       1.00%  __zram_bvec_write

    patch1-5
      39.73%  lzo1x_1_do_compress (real work)
      14.96%  page_vma_mapped_walk
       6.97%  _raw_spin_unlock_irq
       3.07%  do_raw_spin_lock
       2.53%  anon_vma_interval_tree_iter_first
       2.04%  ptep_clear_flush
       1.82%  __zram_bvec_write
       1.76%  __anon_vma_interval_tree_subtree_search
       1.57%  memmove
       1.45%  free_unref_page_list

  Configurations:
    CPU: single Snapdragon 7c
    Mem: total 4G

    Chrome OS MemoryPressure [1]

[1] https://chromium.googlesource.com/chromiumos/platform/tast-tests/

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
 include/linux/mm.h        |   1 +
 include/linux/mm_inline.h |  15 +
 include/linux/mmzone.h    |  35 ++
 mm/Kconfig                |  44 +++
 mm/swap.c                 |  46 ++-
 mm/vmscan.c               | 784 +++++++++++++++++++++++++++++++++++++-
 mm/workingset.c           | 119 +++++-
 7 files changed, 1039 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 05dd33265740..b4b9886ba277 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -227,6 +227,7 @@ int overcommit_policy_handler(struct ctl_table *, int, =
void *, size_t *,
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
=20
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define lru_to_folio(head) (list_entry((head)->prev, struct folio, lru))
=20
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk);
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 46f4fde0299f..37c8a0ede4ff 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -109,6 +109,19 @@ static inline int lru_gen_from_seq(unsigned long seq)
 	return seq % MAX_NR_GENS;
 }
=20
+static inline int lru_hist_from_seq(unsigned long seq)
+{
+	return seq % NR_HIST_GENS;
+}
+
+static inline int lru_tier_from_refs(int refs)
+{
+	VM_BUG_ON(refs > BIT(LRU_REFS_WIDTH));
+
+	/* see the comment on MAX_NR_TIERS */
+	return order_base_2(refs + 1);
+}
+
 static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
 {
 	unsigned long max_seq =3D lruvec->lrugen.max_seq;
@@ -237,6 +250,8 @@ static inline bool lru_gen_del_folio(struct lruvec *lru=
vec, struct folio *folio,
 		gen =3D ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
=20
 		new_flags &=3D ~LRU_GEN_MASK;
+		if ((new_flags & LRU_REFS_FLAGS) !=3D LRU_REFS_FLAGS)
+			new_flags &=3D ~(LRU_REFS_MASK | LRU_REFS_FLAGS);
 		/* for shrink_page_list() */
 		if (reclaiming)
 			new_flags &=3D ~(BIT(PG_referenced) | BIT(PG_reclaim));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0f5e8a995781..3870dd9246a2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -335,6 +335,32 @@ struct lruvec;
 #define MIN_NR_GENS		2U
 #define MAX_NR_GENS		((unsigned int)CONFIG_NR_LRU_GENS)
=20
+/*
+ * Each generation is divided into multiple tiers. Tiers represent differe=
nt
+ * ranges of numbers of accesses through file descriptors. A page accessed=
 N
+ * times through file descriptors is in tier order_base_2(N). A page in th=
e
+ * first tier (N=3D0,1) is marked by PG_referenced unless it was faulted i=
n
+ * though page tables or read ahead. A page in any other tier (N>1) is mar=
ked
+ * by PG_referenced and PG_workingset. Additional bits in folio->flags are
+ * required to support more than two tiers.
+ *
+ * In contrast to moving across generations which requires the LRU lock, m=
oving
+ * across tiers only requires operations on folio->flags and therefore has=
 a
+ * negligible cost in the buffered access path. In the eviction path,
+ * comparisons of refaulted/(evicted+promoted) from the first tier and the=
 rest
+ * infer whether pages accessed multiple times through file descriptors ar=
e
+ * statistically hot and thus worth promoting.
+ */
+#define MAX_NR_TIERS		((unsigned int)CONFIG_TIERS_PER_GEN)
+#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
+
+/* whether to keep historical stats from evicted generations */
+#ifdef CONFIG_LRU_GEN_STATS
+#define NR_HIST_GENS		((unsigned int)CONFIG_NR_LRU_GENS)
+#else
+#define NR_HIST_GENS		1U
+#endif
+
 struct lru_gen_struct {
 	/* the aging increments the youngest generation number */
 	unsigned long max_seq;
@@ -346,6 +372,15 @@ struct lru_gen_struct {
 	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the sizes of the above lists */
 	unsigned long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	/* the exponential moving average of refaulted */
+	unsigned long avg_refaulted[ANON_AND_FILE][MAX_NR_TIERS];
+	/* the exponential moving average of evicted+promoted */
+	unsigned long avg_total[ANON_AND_FILE][MAX_NR_TIERS];
+	/* the first tier doesn't need promotion, hence the minus one */
+	unsigned long promoted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS - 1];
+	/* can be modified without holding the LRU lock */
+	atomic_long_t evicted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
+	atomic_long_t refaulted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	/* whether the multigenerational LRU is enabled */
 	bool enabled;
 };
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..e899623d5df0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -892,6 +892,50 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
=20
+# multigenerational LRU {
+config LRU_GEN
+	bool "Multigenerational LRU"
+	depends on MMU
+	# the following options can use up the spare bits in page flags
+	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
+	help
+	  A high performance LRU implementation for memory overcommit. See
+	  Documentation/admin-guide/mm/multigen_lru.rst and
+	  Documentation/vm/multigen_lru.rst for details.
+
+config NR_LRU_GENS
+	int "Max number of generations"
+	depends on LRU_GEN
+	range 4 31
+	default 4
+	help
+	  Do not increase this value unless you plan to use working set
+	  estimation and proactive reclaim to optimize job scheduling in data
+	  centers.
+
+	  This option uses order_base_2(N+1) bits in page flags.
+
+config TIERS_PER_GEN
+	int "Number of tiers per generation"
+	depends on LRU_GEN
+	range 2 4
+	default 4
+	help
+	  Do not decrease this value unless you run out of spare bits in page
+	  flags, i.e., you see the "Not enough bits in page flags" build error.
+
+	  This option uses N-2 bits in page flags.
+
+config LRU_GEN_STATS
+	bool "Full stats for debugging"
+	depends on LRU_GEN
+	help
+	  Do not enable this option unless you plan to look at historical stats
+	  from evicted generations for debugging purpose.
+
+	  This option has a per-memcg and per-node memory overhead.
+# }
+
 source "mm/damon/Kconfig"
=20
 endmenu
diff --git a/mm/swap.c b/mm/swap.c
index e2ef2acccc74..f5c0bcac8dcd 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -407,6 +407,43 @@ static void __lru_cache_activate_folio(struct folio *f=
olio)
 	local_unlock(&lru_pvecs.lock);
 }
=20
+#ifdef CONFIG_LRU_GEN
+static void folio_inc_refs(struct folio *folio)
+{
+	unsigned long refs;
+	unsigned long old_flags, new_flags;
+
+	if (folio_test_unevictable(folio))
+		return;
+
+	/* see the comment on MAX_NR_TIERS */
+	do {
+		new_flags =3D old_flags =3D READ_ONCE(folio->flags);
+
+		if (!(new_flags & BIT(PG_referenced))) {
+			new_flags |=3D BIT(PG_referenced);
+			continue;
+		}
+
+		if (!(new_flags & BIT(PG_workingset))) {
+			new_flags |=3D BIT(PG_workingset);
+			continue;
+		}
+
+		refs =3D new_flags & LRU_REFS_MASK;
+		refs =3D min(refs + BIT(LRU_REFS_PGOFF), LRU_REFS_MASK);
+
+		new_flags &=3D ~LRU_REFS_MASK;
+		new_flags |=3D refs;
+	} while (new_flags !=3D old_flags &&
+		 cmpxchg(&folio->flags, old_flags, new_flags) !=3D old_flags);
+}
+#else
+static void folio_inc_refs(struct folio *folio)
+{
+}
+#endif /* CONFIG_LRU_GEN */
+
 /*
  * Mark a page as having seen activity.
  *
@@ -419,6 +456,11 @@ static void __lru_cache_activate_folio(struct folio *f=
olio)
  */
 void folio_mark_accessed(struct folio *folio)
 {
+	if (lru_gen_enabled()) {
+		folio_inc_refs(folio);
+		return;
+	}
+
 	if (!folio_test_referenced(folio)) {
 		folio_set_referenced(folio);
 	} else if (folio_test_unevictable(folio)) {
@@ -568,7 +610,7 @@ static void lru_deactivate_file_fn(struct page *page, s=
truct lruvec *lruvec)
=20
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageActive(page) && !PageUnevictable(page)) {
+	if (!PageUnevictable(page) && (PageActive(page) || lru_gen_enabled())) {
 		int nr_pages =3D thp_nr_pages(page);
=20
 		del_page_from_lru_list(page, lruvec);
@@ -682,7 +724,7 @@ void deactivate_file_page(struct page *page)
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
index d75a5738d1dc..5f0d92838712 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1285,9 +1285,11 @@ static int __remove_mapping(struct address_space *ma=
pping, struct page *page,
=20
 	if (PageSwapCache(page)) {
 		swp_entry_t swap =3D { .val =3D page_private(page) };
-		mem_cgroup_swapout(page, swap);
+
+		/* get a shadow entry before mem_cgroup_swapout() clears folio_memcg() *=
/
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow =3D workingset_eviction(page, target_memcg);
+		mem_cgroup_swapout(page, swap);
 		__delete_from_swap_cache(page, swap, shadow);
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_page(page, swap);
@@ -2721,6 +2723,9 @@ static void prepare_scan_count(pg_data_t *pgdat, stru=
ct scan_control *sc)
 	unsigned long file;
 	struct lruvec *target_lruvec;
=20
+	if (lru_gen_enabled())
+		return;
+
 	target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
=20
 	/*
@@ -3042,15 +3047,47 @@ static bool can_age_anon_pages(struct pglist_data *=
pgdat,
=20
 #ifdef CONFIG_LRU_GEN
=20
+enum {
+	TYPE_ANON,
+	TYPE_FILE,
+};
+
 /*************************************************************************=
*****
  *                          shorthand helpers
  *************************************************************************=
*****/
=20
+#define DEFINE_MAX_SEQ(lruvec)						\
+	unsigned long max_seq =3D READ_ONCE((lruvec)->lrugen.max_seq)
+
+#define DEFINE_MIN_SEQ(lruvec)						\
+	unsigned long min_seq[ANON_AND_FILE] =3D {			\
+		READ_ONCE((lruvec)->lrugen.min_seq[TYPE_ANON]),		\
+		READ_ONCE((lruvec)->lrugen.min_seq[TYPE_FILE]),		\
+	}
+
 #define for_each_gen_type_zone(gen, type, zone)				\
 	for ((gen) =3D 0; (gen) < MAX_NR_GENS; (gen)++)			\
 		for ((type) =3D 0; (type) < ANON_AND_FILE; (type)++)	\
 			for ((zone) =3D 0; (zone) < MAX_NR_ZONES; (zone)++)
=20
+static int folio_lru_gen(struct folio *folio)
+{
+	unsigned long flags =3D READ_ONCE(folio->flags);
+
+	return ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+}
+
+static int folio_lru_tier(struct folio *folio)
+{
+	int refs;
+	unsigned long flags =3D READ_ONCE(folio->flags);
+
+	refs =3D (flags & LRU_REFS_FLAGS) =3D=3D LRU_REFS_FLAGS ?
+	       ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + 1 : 0;
+
+	return lru_tier_from_refs(refs);
+}
+
 static struct lruvec *get_lruvec(struct mem_cgroup *memcg, int nid)
 {
 	struct pglist_data *pgdat =3D NODE_DATA(nid);
@@ -3069,6 +3106,728 @@ static struct lruvec *get_lruvec(struct mem_cgroup =
*memcg, int nid)
 	return pgdat ? &pgdat->__lruvec : NULL;
 }
=20
+static int get_swappiness(struct mem_cgroup *memcg)
+{
+	return mem_cgroup_get_nr_swap_pages(memcg) >=3D MIN_LRU_BATCH ?
+	       mem_cgroup_swappiness(memcg) : 0;
+}
+
+static int get_nr_gens(struct lruvec *lruvec, int type)
+{
+	return lruvec->lrugen.max_seq - lruvec->lrugen.min_seq[type] + 1;
+}
+
+static bool __maybe_unused seq_is_valid(struct lruvec *lruvec)
+{
+	/*
+	 * Ideally anon and file min_seq should be in sync. But swapping isn't
+	 * as reliable as dropping clean file pages, e.g., out of swap space. So
+	 * allow file min_seq to advance and leave anon min_seq behind, but not
+	 * the other way around.
+	 */
+	return get_nr_gens(lruvec, TYPE_FILE) >=3D MIN_NR_GENS &&
+	       get_nr_gens(lruvec, TYPE_FILE) <=3D get_nr_gens(lruvec, TYPE_ANON)=
 &&
+	       get_nr_gens(lruvec, TYPE_ANON) <=3D MAX_NR_GENS;
+}
+
+/*************************************************************************=
*****
+ *                          refault feedback loop
+ *************************************************************************=
*****/
+
+/*
+ * A feedback loop based on Proportional-Integral-Derivative (PID) control=
ler.
+ *
+ * The P term is refaulted/(evicted+promoted) from a tier in the generatio=
n
+ * currently being evicted; the I term is the exponential moving average o=
f the
+ * P term over the generations previously evicted, using the smoothing fac=
tor
+ * 1/2; the D term isn't supported.
+ *
+ * The setpoint (SP) is always the first tier of one type; the process var=
iable
+ * (PV) is either any tier of the other type or any other tier of the same
+ * type.
+ *
+ * The error is the difference between the SP and the PV; the correction i=
s
+ * turn off promotion when SP>PV or turn on promotion when SP<PV.
+ *
+ * For future optimizations:
+ * 1) The D term may discount the other two terms over time so that long-l=
ived
+ *    generations can resist stale information.
+ */
+struct ctrl_pos {
+	unsigned long refaulted;
+	unsigned long total;
+	int gain;
+};
+
+static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int g=
ain,
+			  struct ctrl_pos *pos)
+{
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
+
+	pos->refaulted =3D lrugen->avg_refaulted[type][tier] +
+			 atomic_long_read(&lrugen->refaulted[hist][type][tier]);
+	pos->total =3D lrugen->avg_total[type][tier] +
+		     atomic_long_read(&lrugen->evicted[hist][type][tier]);
+	if (tier)
+		pos->total +=3D lrugen->promoted[hist][type][tier - 1];
+	pos->gain =3D gain;
+}
+
+static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover=
)
+{
+	int hist, tier;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	bool clear =3D carryover ? NR_HIST_GENS =3D=3D 1 : NR_HIST_GENS > 1;
+	unsigned long seq =3D carryover ? lrugen->min_seq[type] : lrugen->max_seq=
 + 1;
+
+	lockdep_assert_held(&lruvec->lru_lock);
+
+	if (!carryover && !clear)
+		return;
+
+	hist =3D lru_hist_from_seq(seq);
+
+	for (tier =3D 0; tier < MAX_NR_TIERS; tier++) {
+		if (carryover) {
+			unsigned long sum;
+
+			sum =3D lrugen->avg_refaulted[type][tier] +
+			      atomic_long_read(&lrugen->refaulted[hist][type][tier]);
+			WRITE_ONCE(lrugen->avg_refaulted[type][tier], sum / 2);
+
+			sum =3D lrugen->avg_total[type][tier] +
+			      atomic_long_read(&lrugen->evicted[hist][type][tier]);
+			if (tier)
+				sum +=3D lrugen->promoted[hist][type][tier - 1];
+			WRITE_ONCE(lrugen->avg_total[type][tier], sum / 2);
+		}
+
+		if (clear) {
+			atomic_long_set(&lrugen->refaulted[hist][type][tier], 0);
+			atomic_long_set(&lrugen->evicted[hist][type][tier], 0);
+			if (tier)
+				WRITE_ONCE(lrugen->promoted[hist][type][tier - 1], 0);
+		}
+	}
+}
+
+static bool positive_ctrl_err(struct ctrl_pos *sp, struct ctrl_pos *pv)
+{
+	/*
+	 * Return true if the PV has a limited number of refaults or a lower
+	 * refaulted/total than the SP.
+	 */
+	return pv->refaulted < MIN_LRU_BATCH ||
+	       pv->refaulted * (sp->total + MIN_LRU_BATCH) * sp->gain <=3D
+	       (sp->refaulted + 1) * pv->total * pv->gain;
+}
+
+/*************************************************************************=
*****
+ *                          the aging
+ *************************************************************************=
*****/
+
+static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool =
reclaiming)
+{
+	unsigned long old_flags, new_flags;
+	int type =3D folio_is_file_lru(folio);
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
+
+	do {
+		new_flags =3D old_flags =3D READ_ONCE(folio->flags);
+		VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
+
+		new_gen =3D ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+		new_gen =3D (old_gen + 1) % MAX_NR_GENS;
+
+		new_flags &=3D ~LRU_GEN_MASK;
+		new_flags |=3D (new_gen + 1UL) << LRU_GEN_PGOFF;
+		new_flags &=3D ~(LRU_REFS_MASK | LRU_REFS_FLAGS);
+		/* for folio_end_writeback() */
+		if (reclaiming)
+			new_flags |=3D BIT(PG_reclaim);
+	} while (cmpxchg(&folio->flags, old_flags, new_flags) !=3D old_flags);
+
+	lru_gen_balance_size(lruvec, folio, old_gen, new_gen);
+
+	return new_gen;
+}
+
+static void inc_min_seq(struct lruvec *lruvec)
+{
+	int type;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	VM_BUG_ON(!seq_is_valid(lruvec));
+
+	for (type =3D 0; type < ANON_AND_FILE; type++) {
+		if (get_nr_gens(lruvec, type) !=3D MAX_NR_GENS)
+			continue;
+
+		reset_ctrl_pos(lruvec, type, true);
+		WRITE_ONCE(lrugen->min_seq[type], lrugen->min_seq[type] + 1);
+	}
+}
+
+static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
+{
+	int gen, type, zone;
+	bool success =3D false;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	DEFINE_MIN_SEQ(lruvec);
+
+	VM_BUG_ON(!seq_is_valid(lruvec));
+
+	for (type =3D !can_swap; type < ANON_AND_FILE; type++) {
+		while (lrugen->max_seq >=3D min_seq[type] + MIN_NR_GENS) {
+			gen =3D lru_gen_from_seq(min_seq[type]);
+
+			for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
+				if (!list_empty(&lrugen->lists[gen][type][zone]))
+					goto next;
+			}
+
+			min_seq[type]++;
+		}
+next:
+		;
+	}
+
+	/* see the comment in seq_is_valid() */
+	if (can_swap) {
+		min_seq[TYPE_ANON] =3D min(min_seq[TYPE_ANON], min_seq[TYPE_FILE]);
+		min_seq[TYPE_FILE] =3D max(min_seq[TYPE_ANON], lrugen->min_seq[TYPE_FILE=
]);
+	}
+
+	for (type =3D !can_swap; type < ANON_AND_FILE; type++) {
+		if (min_seq[type] =3D=3D lrugen->min_seq[type])
+			continue;
+
+		reset_ctrl_pos(lruvec, type, true);
+		WRITE_ONCE(lrugen->min_seq[type], min_seq[type]);
+		success =3D true;
+	}
+
+	return success;
+}
+
+static void inc_max_seq(struct lruvec *lruvec, unsigned long max_seq)
+{
+	int prev, next;
+	int type, zone;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	spin_lock_irq(&lruvec->lru_lock);
+
+	VM_BUG_ON(!seq_is_valid(lruvec));
+
+	if (max_seq !=3D lrugen->max_seq)
+		goto unlock;
+
+	inc_min_seq(lruvec);
+
+	/* update the active/inactive LRU sizes for compatibility */
+	prev =3D lru_gen_from_seq(lrugen->max_seq - 1);
+	next =3D lru_gen_from_seq(lrugen->max_seq + 1);
+
+	for (type =3D 0; type < ANON_AND_FILE; type++) {
+		for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
+			enum lru_list lru =3D type * LRU_INACTIVE_FILE;
+			long delta =3D lrugen->nr_pages[prev][type][zone] -
+				     lrugen->nr_pages[next][type][zone];
+
+			if (!delta)
+				continue;
+
+			lru_gen_update_size(lruvec, lru, zone, delta);
+			lru_gen_update_size(lruvec, lru + LRU_ACTIVE, zone, -delta);
+		}
+	}
+
+	for (type =3D 0; type < ANON_AND_FILE; type++)
+		reset_ctrl_pos(lruvec, type, false);
+
+	WRITE_ONCE(lrugen->timestamps[next], jiffies);
+	/* make sure preceding modifications appear */
+	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+unlock:
+	spin_unlock_irq(&lruvec->lru_lock);
+}
+
+static long get_nr_evictable(struct lruvec *lruvec, unsigned long max_seq,
+			     unsigned long *min_seq, bool can_swap, bool *need_aging)
+{
+	int gen, type, zone;
+	long total =3D 0;
+	long young =3D 0;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	for (type =3D !can_swap; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+
+		for (seq =3D min_seq[type]; seq <=3D max_seq; seq++) {
+			long size =3D 0;
+
+			gen =3D lru_gen_from_seq(seq);
+
+			for (zone =3D 0; zone < MAX_NR_ZONES; zone++)
+				size +=3D READ_ONCE(lrugen->nr_pages[gen][type][zone]);
+
+			total +=3D size;
+			if (seq =3D=3D max_seq)
+				young +=3D size;
+		}
+	}
+
+	/* try to spread pages out across MIN_NR_GENS+1 generations */
+	if (max_seq < min_seq[TYPE_FILE] + MIN_NR_GENS)
+		*need_aging =3D true;
+	else if (max_seq > min_seq[TYPE_FILE] + MIN_NR_GENS)
+		*need_aging =3D false;
+	else
+		*need_aging =3D young * MIN_NR_GENS > total;
+
+	return total > 0 ? total : 0;
+}
+
+static void age_lruvec(struct lruvec *lruvec, struct scan_control *sc)
+{
+	bool need_aging;
+	long nr_to_scan;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
+	int swappiness =3D get_swappiness(memcg);
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	mem_cgroup_calculate_protection(NULL, memcg);
+
+	if (mem_cgroup_below_min(memcg))
+		return;
+
+	nr_to_scan =3D get_nr_evictable(lruvec, max_seq, min_seq, swappiness, &ne=
ed_aging);
+	if (!nr_to_scan)
+		return;
+
+	nr_to_scan >>=3D sc->priority;
+
+	if (!mem_cgroup_online(memcg))
+		nr_to_scan++;
+
+	if (nr_to_scan && need_aging && (!mem_cgroup_below_low(memcg) || sc->memc=
g_low_reclaim))
+		inc_max_seq(lruvec, max_seq);
+}
+
+static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_contro=
l *sc)
+{
+	struct mem_cgroup *memcg;
+
+	VM_BUG_ON(!current_is_kswapd());
+
+	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+
+		age_lruvec(lruvec, sc);
+
+		cond_resched();
+	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
+}
+
+/*************************************************************************=
*****
+ *                          the eviction
+ *************************************************************************=
*****/
+
+static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tie=
r_idx)
+{
+	bool success;
+	int gen =3D folio_lru_gen(folio);
+	int type =3D folio_is_file_lru(folio);
+	int zone =3D folio_zonenum(folio);
+	int tier =3D folio_lru_tier(folio);
+	int delta =3D folio_nr_pages(folio);
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	VM_BUG_ON_FOLIO(gen >=3D MAX_NR_GENS, folio);
+
+	if (!folio_evictable(folio)) {
+		success =3D lru_gen_del_folio(lruvec, folio, true);
+		VM_BUG_ON_FOLIO(!success, folio);
+		folio_set_unevictable(folio);
+		lruvec_add_folio(lruvec, folio);
+		__count_vm_events(UNEVICTABLE_PGCULLED, delta);
+		return true;
+	}
+
+	if (type && folio_test_anon(folio) && folio_test_dirty(folio)) {
+		success =3D lru_gen_del_folio(lruvec, folio, true);
+		VM_BUG_ON_FOLIO(!success, folio);
+		folio_set_swapbacked(folio);
+		lruvec_add_folio_tail(lruvec, folio);
+		return true;
+	}
+
+	if (tier > tier_idx) {
+		int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
+
+		gen =3D folio_inc_gen(lruvec, folio, false);
+		list_move_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+
+		WRITE_ONCE(lrugen->promoted[hist][type][tier - 1],
+			   lrugen->promoted[hist][type][tier - 1] + delta);
+		__mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
+		return true;
+	}
+
+	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
+	    (type && folio_test_dirty(folio))) {
+		gen =3D folio_inc_gen(lruvec, folio, true);
+		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		return true;
+	}
+
+	return false;
+}
+
+static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, stru=
ct scan_control *sc)
+{
+	bool success;
+
+	if (!sc->may_unmap && folio_mapped(folio))
+		return false;
+
+	if (!(sc->may_writepage && (sc->gfp_mask & __GFP_IO)) &&
+	    (folio_test_dirty(folio) ||
+	     (folio_test_anon(folio) && !folio_test_swapcache(folio))))
+		return false;
+
+	if (!folio_try_get(folio))
+		return false;
+
+	if (!folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return false;
+	}
+
+	success =3D lru_gen_del_folio(lruvec, folio, true);
+	VM_BUG_ON_FOLIO(!success, folio);
+
+	return true;
+}
+
+static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
+		       int type, int tier, struct list_head *list)
+{
+	int gen, zone;
+	enum vm_event_item item;
+	int sorted =3D 0;
+	int scanned =3D 0;
+	int isolated =3D 0;
+	int remaining =3D MAX_LRU_BATCH;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
+
+	VM_BUG_ON(!list_empty(list));
+
+	if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS)
+		return 0;
+
+	gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
+
+	for (zone =3D sc->reclaim_idx; zone >=3D 0; zone--) {
+		LIST_HEAD(moved);
+		int skipped =3D 0;
+		struct list_head *head =3D &lrugen->lists[gen][type][zone];
+
+		while (!list_empty(head)) {
+			struct folio *folio =3D lru_to_folio(head);
+			int delta =3D folio_nr_pages(folio);
+
+			VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
+			VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
+			VM_BUG_ON_FOLIO(folio_is_file_lru(folio) !=3D type, folio);
+			VM_BUG_ON_FOLIO(folio_zonenum(folio) !=3D zone, folio);
+
+			scanned +=3D delta;
+
+			if (sort_folio(lruvec, folio, tier))
+				sorted +=3D delta;
+			else if (isolate_folio(lruvec, folio, sc)) {
+				list_add(&folio->lru, list);
+				isolated +=3D delta;
+			} else {
+				list_move(&folio->lru, &moved);
+				skipped +=3D delta;
+			}
+
+			if (!--remaining || max(isolated, skipped) >=3D MIN_LRU_BATCH)
+				break;
+		}
+
+		if (skipped) {
+			list_splice(&moved, head);
+			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
+		}
+
+		if (!remaining || isolated >=3D MIN_LRU_BATCH)
+			break;
+	}
+
+	item =3D current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
+	if (!cgroup_reclaim(sc)) {
+		__count_vm_events(item, isolated);
+		__count_vm_events(PGREFILL, sorted);
+	}
+	__count_memcg_events(memcg, item, isolated);
+	__count_memcg_events(memcg, PGREFILL, sorted);
+	__count_vm_events(PGSCAN_ANON + type, isolated);
+
+	/*
+	 * There might not be eligible pages due to reclaim_idx, may_unmap and
+	 * may_writepage. Check the remaining to prevent livelock if there is no
+	 * progress.
+	 */
+	return isolated || !remaining ? scanned : 0;
+}
+
+static int get_tier_idx(struct lruvec *lruvec, int type)
+{
+	int tier;
+	struct ctrl_pos sp, pv;
+
+	/*
+	 * To leave a margin for fluctuations, use a larger gain factor (1:2).
+	 * This value is chosen because any other tier would have at least twice
+	 * as many refaults as the first tier.
+	 */
+	read_ctrl_pos(lruvec, type, 0, 1, &sp);
+	for (tier =3D 1; tier < MAX_NR_TIERS; tier++) {
+		read_ctrl_pos(lruvec, type, tier, 2, &pv);
+		if (!positive_ctrl_err(&sp, &pv))
+			break;
+	}
+
+	return tier - 1;
+}
+
+static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int *ti=
er_idx)
+{
+	int type, tier;
+	struct ctrl_pos sp, pv;
+	int gain[ANON_AND_FILE] =3D { swappiness, 200 - swappiness };
+
+	/*
+	 * Compare the first tier of anon with that of file to determine which
+	 * type to scan. Also need to compare other tiers of the selected type
+	 * with the first tier of the other type to determine the last tier (of
+	 * the selected type) to evict.
+	 */
+	read_ctrl_pos(lruvec, TYPE_ANON, 0, gain[TYPE_ANON], &sp);
+	read_ctrl_pos(lruvec, TYPE_FILE, 0, gain[TYPE_FILE], &pv);
+	type =3D positive_ctrl_err(&sp, &pv);
+
+	read_ctrl_pos(lruvec, !type, 0, gain[!type], &sp);
+	for (tier =3D 1; tier < MAX_NR_TIERS; tier++) {
+		read_ctrl_pos(lruvec, type, tier, gain[type], &pv);
+		if (!positive_ctrl_err(&sp, &pv))
+			break;
+	}
+
+	*tier_idx =3D tier - 1;
+
+	return type;
+}
+
+static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, =
int swappiness,
+			  int *type_scanned, struct list_head *list)
+{
+	int i;
+	int type;
+	int scanned;
+	int tier =3D -1;
+	DEFINE_MIN_SEQ(lruvec);
+
+	VM_BUG_ON(!seq_is_valid(lruvec));
+
+	/*
+	 * Try to make the obvious choice first. When anon and file are both
+	 * available from the same generation, interpret swappiness 1 as file
+	 * first and 200 as anon first.
+	 */
+	if (!swappiness)
+		type =3D TYPE_FILE;
+	else if (min_seq[TYPE_ANON] < min_seq[TYPE_FILE])
+		type =3D TYPE_ANON;
+	else if (swappiness =3D=3D 1)
+		type =3D TYPE_FILE;
+	else if (swappiness =3D=3D 200)
+		type =3D TYPE_ANON;
+	else
+		type =3D get_type_to_scan(lruvec, swappiness, &tier);
+
+	for (i =3D !swappiness; i < ANON_AND_FILE; i++) {
+		if (tier < 0)
+			tier =3D get_tier_idx(lruvec, type);
+
+		scanned =3D scan_folios(lruvec, sc, type, tier, list);
+		if (scanned)
+			break;
+
+		type =3D !type;
+		tier =3D -1;
+	}
+
+	*type_scanned =3D type;
+
+	return scanned;
+}
+
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness)
+{
+	int type;
+	int scanned;
+	int reclaimed;
+	LIST_HEAD(list);
+	struct folio *folio;
+	enum vm_event_item item;
+	struct reclaim_stat stat;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
+	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
+
+	spin_lock_irq(&lruvec->lru_lock);
+
+	scanned =3D isolate_folios(lruvec, sc, swappiness, &type, &list);
+
+	if (try_to_inc_min_seq(lruvec, swappiness))
+		scanned++;
+
+	if (get_nr_gens(lruvec, TYPE_FILE) =3D=3D MIN_NR_GENS)
+		scanned =3D 0;
+
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	if (list_empty(&list))
+		return scanned;
+
+	reclaimed =3D shrink_page_list(&list, pgdat, sc, &stat, false);
+
+	/*
+	 * To avoid livelock, don't add rejected pages back to the same lists
+	 * they were isolated from.
+	 */
+	list_for_each_entry(folio, &list, lru) {
+		if ((folio_is_file_lru(folio) || folio_test_swapcache(folio)) &&
+		    (!folio_test_reclaim(folio) ||
+		     !(folio_test_dirty(folio) || folio_test_writeback(folio))))
+			folio_set_active(folio);
+
+		folio_clear_referenced(folio);
+		folio_clear_workingset(folio);
+	}
+
+	spin_lock_irq(&lruvec->lru_lock);
+
+	move_pages_to_lru(lruvec, &list);
+
+	item =3D current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
+	if (!cgroup_reclaim(sc))
+		__count_vm_events(item, reclaimed);
+	__count_memcg_events(memcg, item, reclaimed);
+	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
+
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	mem_cgroup_uncharge_list(&list);
+	free_unref_page_list(&list);
+
+	sc->nr_reclaimed +=3D reclaimed;
+
+	return scanned;
+}
+
+static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc,=
 bool can_swap)
+{
+	bool need_aging;
+	long nr_to_scan;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	if (mem_cgroup_below_min(memcg) ||
+	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
+		return 0;
+
+	nr_to_scan =3D get_nr_evictable(lruvec, max_seq, min_seq, can_swap, &need=
_aging);
+	if (!nr_to_scan)
+		return 0;
+
+	/* reset the priority if the target has been met */
+	nr_to_scan >>=3D sc->nr_reclaimed < sc->nr_to_reclaim ? sc->priority : DE=
F_PRIORITY;
+
+	if (!mem_cgroup_online(memcg))
+		nr_to_scan++;
+
+	if (!nr_to_scan)
+		return 0;
+
+	if (!need_aging)
+		return nr_to_scan;
+
+	/* leave the work to lru_gen_age_node() */
+	if (current_is_kswapd())
+		return 0;
+
+	/* try other memcgs before going to the aging path */
+	if (!cgroup_reclaim(sc) && !sc->force_deactivate) {
+		sc->skipped_deactivate =3D true;
+		return 0;
+	}
+
+	inc_max_seq(lruvec, max_seq);
+
+	return nr_to_scan;
+}
+
+static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_contr=
ol *sc)
+{
+	struct blk_plug plug;
+	long scanned =3D 0;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
+
+	lru_add_drain();
+
+	blk_start_plug(&plug);
+
+	while (true) {
+		int delta;
+		int swappiness;
+		long nr_to_scan;
+
+		if (sc->may_swap)
+			swappiness =3D get_swappiness(memcg);
+		else if (!cgroup_reclaim(sc) && get_swappiness(memcg))
+			swappiness =3D 1;
+		else
+			swappiness =3D 0;
+
+		nr_to_scan =3D get_nr_to_scan(lruvec, sc, swappiness);
+		if (!nr_to_scan)
+			break;
+
+		delta =3D evict_folios(lruvec, sc, swappiness);
+		if (!delta)
+			break;
+
+		scanned +=3D delta;
+		if (scanned >=3D nr_to_scan)
+			break;
+
+		cond_resched();
+	}
+
+	blk_finish_plug(&plug);
+}
+
 /*************************************************************************=
*****
  *                          initialization
  *************************************************************************=
*****/
@@ -3123,6 +3882,16 @@ static int __init init_lru_gen(void)
 };
 late_initcall(init_lru_gen);
=20
+#else
+
+static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_contro=
l *sc)
+{
+}
+
+static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_contr=
ol *sc)
+{
+}
+
 #endif /* CONFIG_LRU_GEN */
=20
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
@@ -3136,6 +3905,11 @@ static void shrink_lruvec(struct lruvec *lruvec, str=
uct scan_control *sc)
 	struct blk_plug plug;
 	bool scan_adjusted;
=20
+	if (lru_gen_enabled()) {
+		lru_gen_shrink_lruvec(lruvec, sc);
+		return;
+	}
+
 	get_scan_count(lruvec, sc, nr);
=20
 	/* Record the original scan target for proportional adjustments later */
@@ -3640,6 +4414,9 @@ static void snapshot_refaults(struct mem_cgroup *targ=
et_memcg, pg_data_t *pgdat)
 	struct lruvec *target_lruvec;
 	unsigned long refaults;
=20
+	if (lru_gen_enabled())
+		return;
+
 	target_lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
 	refaults =3D lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
 	target_lruvec->refaults[0] =3D refaults;
@@ -4010,6 +4787,11 @@ static void age_active_anon(struct pglist_data *pgda=
t,
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
=20
+	if (lru_gen_enabled()) {
+		lru_gen_age_node(pgdat, sc);
+		return;
+	}
+
 	if (!can_age_anon_pages(pgdat, sc))
 		return;
=20
diff --git a/mm/workingset.c b/mm/workingset.c
index 8c03afe1d67c..443343a3f3e3 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -187,7 +187,6 @@ static unsigned int bucket_order __read_mostly;
 static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long evic=
tion,
 			 bool workingset)
 {
-	eviction >>=3D bucket_order;
 	eviction &=3D EVICTION_MASK;
 	eviction =3D (eviction << MEM_CGROUP_ID_SHIFT) | memcgid;
 	eviction =3D (eviction << NODES_SHIFT) | pgdat->node_id;
@@ -212,10 +211,116 @@ static void unpack_shadow(void *shadow, int *memcgid=
p, pg_data_t **pgdat,
=20
 	*memcgidp =3D memcgid;
 	*pgdat =3D NODE_DATA(nid);
-	*evictionp =3D entry << bucket_order;
+	*evictionp =3D entry;
 	*workingsetp =3D workingset;
 }
=20
+#ifdef CONFIG_LRU_GEN
+
+static int folio_lru_refs(struct folio *folio)
+{
+	unsigned long flags =3D READ_ONCE(folio->flags);
+
+	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SH=
IFT);
+
+	/* see the comment on MAX_NR_TIERS */
+	return flags & BIT(PG_workingset) ? (flags & LRU_REFS_MASK) >> LRU_REFS_P=
GOFF : 0;
+}
+
+static void *lru_gen_eviction(struct folio *folio)
+{
+	int hist, tier;
+	unsigned long token;
+	unsigned long min_seq;
+	struct lruvec *lruvec;
+	struct lru_gen_struct *lrugen;
+	int type =3D folio_is_file_lru(folio);
+	int refs =3D folio_lru_refs(folio);
+	int delta =3D folio_nr_pages(folio);
+	bool workingset =3D folio_test_workingset(folio);
+	struct mem_cgroup *memcg =3D folio_memcg(folio);
+	struct pglist_data *pgdat =3D folio_pgdat(folio);
+
+	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+	lrugen =3D &lruvec->lrugen;
+	min_seq =3D READ_ONCE(lrugen->min_seq[type]);
+	token =3D (min_seq << LRU_REFS_WIDTH) | refs;
+
+	hist =3D lru_hist_from_seq(min_seq);
+	tier =3D lru_tier_from_refs(refs + workingset);
+	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
+
+	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
+}
+
+static void lru_gen_refault(struct folio *folio, void *shadow)
+{
+	int hist, tier, refs;
+	int memcg_id;
+	bool workingset;
+	unsigned long token;
+	unsigned long min_seq;
+	struct lruvec *lruvec;
+	struct lru_gen_struct *lrugen;
+	struct mem_cgroup *memcg;
+	struct pglist_data *pgdat;
+	int type =3D folio_is_file_lru(folio);
+	int delta =3D folio_nr_pages(folio);
+
+	unpack_shadow(shadow, &memcg_id, &pgdat, &token, &workingset);
+
+	refs =3D token & (BIT(LRU_REFS_WIDTH) - 1);
+	if (refs && !workingset)
+		return;
+
+	if (folio_pgdat(folio) !=3D pgdat)
+		return;
+
+	rcu_read_lock();
+	memcg =3D folio_memcg_rcu(folio);
+	if (mem_cgroup_id(memcg) !=3D memcg_id)
+		goto unlock;
+
+	token >>=3D LRU_REFS_WIDTH;
+	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+	lrugen =3D &lruvec->lrugen;
+	min_seq =3D READ_ONCE(lrugen->min_seq[type]);
+	if (token !=3D (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)))
+		goto unlock;
+
+	hist =3D lru_hist_from_seq(min_seq);
+	tier =3D lru_tier_from_refs(refs + workingset);
+	atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
+	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
+
+	/*
+	 * Count the following two cases as stalls:
+	 * 1) For pages accessed through page tables, hotter pages pushed out
+	 *    hot pages which refaulted immediately.
+	 * 2) For pages accessed through file descriptors, numbers of accesses
+	 *    might have been beyond the limit.
+	 */
+	if (lru_gen_in_fault() || refs + workingset =3D=3D BIT(LRU_REFS_WIDTH)) {
+		folio_set_workingset(folio);
+		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, delta);
+	}
+unlock:
+	rcu_read_unlock();
+}
+
+#else
+
+static void *lru_gen_eviction(struct folio *folio)
+{
+	return NULL;
+}
+
+static void lru_gen_refault(struct folio *folio, void *shadow)
+{
+}
+
+#endif /* CONFIG_LRU_GEN */
+
 /**
  * workingset_age_nonresident - age non-resident entries as LRU ages
  * @lruvec: the lruvec that was aged
@@ -264,10 +369,14 @@ void *workingset_eviction(struct page *page, struct m=
em_cgroup *target_memcg)
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
=20
+	if (lru_gen_enabled())
+		return lru_gen_eviction(page_folio(page));
+
 	lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid =3D mem_cgroup_id(lruvec_memcg(lruvec));
 	eviction =3D atomic_long_read(&lruvec->nonresident_age);
+	eviction >>=3D bucket_order;
 	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
 }
@@ -297,7 +406,13 @@ void workingset_refault(struct folio *folio, void *sha=
dow)
 	int memcgid;
 	long nr;
=20
+	if (lru_gen_enabled()) {
+		lru_gen_refault(folio, shadow);
+		return;
+	}
+
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
+	eviction <<=3D bucket_order;
=20
 	rcu_read_lock();
 	/*
--=20
2.35.0.263.gb82422642f-goog

