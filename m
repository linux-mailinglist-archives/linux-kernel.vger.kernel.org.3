Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9125A1B14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiHYVb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiHYVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:31:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB737BFC4D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:14 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27PGTgSq002655
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9DPrzYrz2ApMv9d/YtcvsPxJgEcSgr70NKz9SIPKQFs=;
 b=VfFYqmH5VkpGvcPLc9kFrRchkSGlhJnEnIchiO6+dt9RQQAzldX/sqXUQE9fytqpZFD0
 yzu1nGBzjzAjRo4eTHj95am/we5mpiGTvlKM68erwBYON/tpBRFCODUV/dVMvk4lfWPT
 8yISMAN/VHFjGKoqks2I7HUmhv40/oFUCWk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j5xcgq03x-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:13 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 14:31:09 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 14:31:02 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id 1E8372DC95FC; Thu, 25 Aug 2022 14:30:57 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <hannes@cmpxchg.org>,
        <akpm@linux-foundation.org>, <riel@surriel.com>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Alexander Zhu <alexlzhu@fb.com>
Subject: [RFC 3/3] mm: THP low utilization shrinker
Date:   Thu, 25 Aug 2022 14:30:54 -0700
Message-ID: <ba2dfb44f4d4ec099dec0ca83790f4fb9ee02e72.1661461643.git.alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1661461643.git.alexlzhu@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cXriGgGKK-afRldBPCAWJaidjuu19mth
X-Proofpoint-ORIG-GUID: cXriGgGKK-afRldBPCAWJaidjuu19mth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

This patch introduces a shrinker that will remove THPs in the lowest
utilization bucket. As previously mentioned, we have observed that
almost all of the memory waste when THPs are always enabled
is contained in the lowest utilization bucket. The shrinker will
add these THPs to a list_lru and split anonymous THPs based off
information from kswapd. It requires the changes from
thp_utilization to identify the least utilized THPs, and the
changes to split_huge_page to identify and free zero pages
within THPs.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
---
 include/linux/huge_mm.h  |  7 +++
 include/linux/list_lru.h | 24 +++++++++++
 include/linux/mm_types.h |  5 +++
 mm/huge_memory.c         | 92 ++++++++++++++++++++++++++++++++++++++--
 mm/list_lru.c            | 49 +++++++++++++++++++++
 mm/page_alloc.c          |  6 +++
 6 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c9086239deb7..13bd470173d2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -192,6 +192,8 @@ static inline int split_huge_page(struct page *page)
 }
 void deferred_split_huge_page(struct page *page);
=20
+void add_underutilized_thp(struct page *page);
+
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio);
=20
@@ -302,6 +304,11 @@ static inline struct list_head *page_deferred_list(s=
truct page *page)
 	return &page[2].deferred_list;
 }
=20
+static inline struct list_head *page_underutilized_thp_list(struct page =
*page)
+{
+	return &page[3].underutilized_thp_list;
+}
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index b35968ee9fb5..c2cf146ea880 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -89,6 +89,18 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg=
, struct mem_cgroup *paren
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item);
=20
+/**
+ * list_lru_add_page: add an element to the lru list's tail
+ * @list_lru: the lru pointer
+ * @page: the page containing the item
+ * @item: the item to be deleted.
+ *
+ * This function works the same as list_lru_add in terms of list
+ * manipulation. Used for non slab objects contained in the page.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool list_lru_add_page(struct list_lru *lru, struct page *page, struct l=
ist_head *item);
 /**
  * list_lru_del: delete an element to the lru list
  * @list_lru: the lru pointer
@@ -102,6 +114,18 @@ bool list_lru_add(struct list_lru *lru, struct list_=
head *item);
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
=20
+/**
+ * list_lru_del_page: delete an element to the lru list
+ * @list_lru: the lru pointer
+ * @page: the page containing the item
+ * @item: the item to be deleted.
+ *
+ * This function works the same as list_lru_del in terms of list
+ * manipulation. Used for non slab objects contained in the page.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool list_lru_del_page(struct list_lru *lru, struct page *page, struct l=
ist_head *item);
 /**
  * list_lru_count_one: return the number of objects currently held by @l=
ru
  * @lru: the lru pointer.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf97f3884fda..05667a2030c0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -151,6 +151,11 @@ struct page {
 			/* For both global and memcg */
 			struct list_head deferred_list;
 		};
+		struct { /* Third tail page of compound page */
+			unsigned long _compound_pad_3; /* compound_head */
+			unsigned long _compound_pad_4;
+			struct list_head underutilized_thp_list;
+		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0f774a7c0727..03dc42eba0ba 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/highmem.h>
@@ -85,6 +86,8 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
=20
+struct list_lru huge_low_util_page_lru;
+
 static void thp_utilization_workfn(struct work_struct *work);
 static DECLARE_DELAYED_WORK(thp_utilization_work, thp_utilization_workfn=
);
=20
@@ -269,6 +272,46 @@ static struct shrinker huge_zero_page_shrinker =3D {
 	.seeks =3D DEFAULT_SEEKS,
 };
=20
+static enum lru_status low_util_free_page(struct list_head *item,
+					  struct list_lru_one *lru,
+					  spinlock_t *lock,
+					  void *cb_arg)
+{
+	struct page *head =3D compound_head(list_entry(item,
+									struct page,
+									underutilized_thp_list));
+
+	if (get_page_unless_zero(head)) {
+		lock_page(head);
+		list_lru_isolate(lru, item);
+		split_huge_page(head);
+		unlock_page(head);
+		put_page(head);
+	}
+
+	return LRU_REMOVED_RETRY;
+}
+
+static unsigned long shrink_huge_low_util_page_count(struct shrinker *sh=
rink,
+						     struct shrink_control *sc)
+{
+	return list_lru_shrink_count(&huge_low_util_page_lru, sc);
+}
+
+static unsigned long shrink_huge_low_util_page_scan(struct shrinker *shr=
ink,
+						    struct shrink_control *sc)
+{
+	return list_lru_shrink_walk(&huge_low_util_page_lru, sc, low_util_free_=
page, NULL);
+}
+
+static struct shrinker huge_low_util_page_shrinker =3D {
+	.count_objects =3D shrink_huge_low_util_page_count,
+	.scan_objects =3D shrink_huge_low_util_page_scan,
+	.seeks =3D DEFAULT_SEEKS,
+	.flags =3D SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
+		SHRINKER_NONSLAB,
+};
+
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
@@ -521,13 +564,18 @@ static int __init hugepage_init(void)
 		goto err_slab;
=20
 	schedule_delayed_work(&thp_utilization_work, HZ);
+	err =3D register_shrinker(&huge_low_util_page_shrinker, "thp-low-util")=
;
+	if (err)
+		goto err_low_util_shrinker;
 	err =3D register_shrinker(&huge_zero_page_shrinker, "thp-zero");
 	if (err)
 		goto err_hzp_shrinker;
 	err =3D register_shrinker(&deferred_split_shrinker, "thp-deferred_split=
");
 	if (err)
 		goto err_split_shrinker;
-
+	err =3D list_lru_init_memcg(&huge_low_util_page_lru, &huge_low_util_pag=
e_shrinker);
+	if (err)
+		goto err_low_util_list_lru;
 	/*
 	 * By default disable transparent hugepages on smaller systems,
 	 * where the extra memory used could hurt more than TLB overhead
@@ -543,11 +591,16 @@ static int __init hugepage_init(void)
 		goto err_khugepaged;
=20
 	return 0;
+
 err_khugepaged:
+	list_lru_destroy(&huge_low_util_page_lru);
+err_low_util_list_lru:
 	unregister_shrinker(&deferred_split_shrinker);
 err_split_shrinker:
 	unregister_shrinker(&huge_zero_page_shrinker);
 err_hzp_shrinker:
+	unregister_shrinker(&huge_low_util_page_shrinker);
+err_low_util_shrinker:
 	khugepaged_destroy();
 err_slab:
 	hugepage_exit_sysfs(hugepage_kobj);
@@ -622,6 +675,7 @@ void prep_transhuge_page(struct page *page)
 	 */
=20
 	INIT_LIST_HEAD(page_deferred_list(page));
+	INIT_LIST_HEAD(page_underutilized_thp_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
=20
@@ -2491,8 +2545,7 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
 			 (1L << PG_dirty)));
=20
 	/* ->mapping in first tail page is compound_mapcount */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping !=3D TAIL_MAPPING,
-			page_tail);
+	VM_BUG_ON_PAGE(tail > 3 && page_tail->mapping !=3D TAIL_MAPPING, page_t=
ail);
 	page_tail->mapping =3D head->mapping;
 	page_tail->index =3D head->index + tail;
 	page_tail->private =3D 0;
@@ -2698,6 +2751,7 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 	struct folio *folio =3D page_folio(page);
 	struct page *head =3D &folio->page;
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
+	struct list_head *underutilized_thp_list =3D page_underutilized_thp_lis=
t(head);
 	XA_STATE(xas, &head->mapping->i_pages, head->index);
 	struct anon_vma *anon_vma =3D NULL;
 	struct address_space *mapping =3D NULL;
@@ -2796,6 +2850,8 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 			list_del(page_deferred_list(head));
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
+		if (!list_empty(underutilized_thp_list))
+			list_lru_del_page(&huge_low_util_page_lru, head, underutilized_thp_li=
st);
 		if (mapping) {
 			int nr =3D thp_nr_pages(head);
=20
@@ -2838,6 +2894,7 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 void free_transhuge_page(struct page *page)
 {
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(page);
+	struct list_head *underutilized_thp_list =3D page_underutilized_thp_lis=
t(page);
 	unsigned long flags;
=20
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
@@ -2846,6 +2903,12 @@ void free_transhuge_page(struct page *page)
 		list_del(page_deferred_list(page));
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	if (!list_empty(underutilized_thp_list))
+		list_lru_del_page(&huge_low_util_page_lru, page, underutilized_thp_lis=
t);
+
+	if (PageLRU(page))
+		__clear_page_lru_flags(page);
+
 	free_compound_page(page);
 }
=20
@@ -2886,6 +2949,26 @@ void deferred_split_huge_page(struct page *page)
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
=20
+void add_underutilized_thp(struct page *page)
+{
+	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
+
+	if (PageSwapCache(page))
+		return;
+
+	/*
+	 * Need to take a reference on the page to prevent the page from gettin=
g free'd from
+	 * under us while we are adding the THP to the shrinker.
+	 */
+	if (!get_page_unless_zero(page))
+		return;
+
+	if (!is_huge_zero_page(page) && is_anon_transparent_hugepage(page))
+		list_lru_add_page(&huge_low_util_page_lru, page, page_underutilized_th=
p_list(page));
+
+	put_page(page);
+}
+
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
@@ -3424,6 +3507,9 @@ static void thp_util_scan(unsigned long pfn_end)
 		/* Group THPs into utilization buckets */
 		bucket =3D num_utilized_pages * THP_UTIL_BUCKET_NR / HPAGE_PMD_NR;
 		bucket =3D min(bucket, THP_UTIL_BUCKET_NR - 1);
+		if (bucket =3D=3D 0)
+			add_underutilized_thp(page);
+
 		thp_scan.buckets[bucket].nr_thps++;
 		thp_scan.buckets[bucket].nr_zero_pages +=3D (HPAGE_PMD_NR - num_utiliz=
ed_pages);
 	}
diff --git a/mm/list_lru.c b/mm/list_lru.c
index a05e5bef3b40..7e8b324cc840 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -140,6 +140,32 @@ bool list_lru_add(struct list_lru *lru, struct list_=
head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_add);
=20
+bool list_lru_add_page(struct list_lru *lru, struct page *page, struct l=
ist_head *item)
+{
+	int nid =3D page_to_nid(page);
+	struct list_lru_node *nlru =3D &lru->node[nid];
+	struct list_lru_one *l;
+	struct mem_cgroup *memcg;
+
+	spin_lock(&nlru->lock);
+	if (list_empty(item)) {
+		memcg =3D page_memcg(page);
+		memcg_list_lru_alloc(memcg, lru, GFP_KERNEL);
+		l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+		list_add_tail(item, &l->list);
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			set_shrinker_bit(memcg, nid,
+					 lru_shrinker_id(lru));
+		nlru->nr_items++;
+		spin_unlock(&nlru->lock);
+		return true;
+	}
+	spin_unlock(&nlru->lock);
+	return false;
+}
+EXPORT_SYMBOL_GPL(list_lru_add_page);
+
 bool list_lru_del(struct list_lru *lru, struct list_head *item)
 {
 	int nid =3D page_to_nid(virt_to_page(item));
@@ -160,6 +186,29 @@ bool list_lru_del(struct list_lru *lru, struct list_=
head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_del);
=20
+bool list_lru_del_page(struct list_lru *lru, struct page *page, struct l=
ist_head *item)
+{
+	int nid =3D page_to_nid(page);
+	struct list_lru_node *nlru =3D &lru->node[nid];
+	struct list_lru_one *l;
+	struct mem_cgroup *memcg;
+
+	spin_lock(&nlru->lock);
+	if (!list_empty(item)) {
+		memcg =3D page_memcg(page);
+		memcg_list_lru_alloc(memcg, lru, GFP_KERNEL);
+		l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+		list_del_init(item);
+		l->nr_items--;
+		nlru->nr_items--;
+		spin_unlock(&nlru->lock);
+		return true;
+	}
+	spin_unlock(&nlru->lock);
+	return false;
+}
+EXPORT_SYMBOL_GPL(list_lru_del_page);
+
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
 	list_del_init(item);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..a2a33b4d71db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1327,6 +1327,12 @@ static int free_tail_pages_check(struct page *head=
_page, struct page *page)
 		 * deferred_list.next -- ignore value.
 		 */
 		break;
+	case 3:
+		/*
+		 * the third tail page: ->mapping is
+		 * underutilized_thp_list.next -- ignore value.
+		 */
+		break;
 	default:
 		if (page->mapping !=3D TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
--=20
2.30.2

