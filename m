Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D865A58F35C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiHJT6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiHJT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:58:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F25832DC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:57:59 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuPrE003027
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:57:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XDxeXuDboKdINjQri1bKZgYJiOQSeIPX+ZMOopIfn38=;
 b=EPdMJ1iXPdG6onhQLKPz9b9ef1wL/rA9ZiL78BcnmPX4Crk9x+rhy2gG3iAewQ5cw1QA
 98aYocr6ZhVDbw+TOV2VVIqOjwmjuWLJIuhALHV6BohhZwAZbu2Tz0bgzRPbpCXXbq3P
 WK/gfPMK2dy1SjXKUauEdmUEszc+5E8Dbvo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6bexr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:57:58 -0700
Received: from twshared33626.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 12:57:57 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id F1AB12289C1A; Wed, 10 Aug 2022 12:57:51 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
CC:     Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH v3] mm: add thp_utilization metrics to debugfs
Date:   Wed, 10 Aug 2022 12:57:50 -0700
Message-ID: <20220810195750.1813446-1-alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6NgP_OJW0CYNuigK_9mT8bi_4BcVw5Av
X-Proofpoint-GUID: 6NgP_OJW0CYNuigK_9mT8bi_4BcVw5Av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_13,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

THPs have historically been enabled on a per application basis due to
performance increase or decrease depending on how the particular
application uses physical memory. When THPs are heavily utilized,
application performance improves due to fewer TLB cache misses.
It has long been suspected that performance regressions when THP
is enabled happens due to heavily underutilized anonymous THPs.

Previously there was no way to track how much of a THP is
actually being used. With this change, we seek to gain visibility
into the utilization of THPs in order to make more intelligent
decisions regarding paging.

This change introduces a tool that scans through all of physical
memory for anonymous THPs and groups them into buckets based
on utilization. It also includes an interface under
/sys/kernel/debug/thp_utilization.

Utilization of a THP is defined as the percentage of nonzero
pages in the THP. The worker thread will scan through all
of physical memory and obtain utilization of all anonymous
THPs. It will gather this information by periodically scanning
through all of physical memory for anonymous THPs, group them
into buckets based on utilization, and report utilization
information through debugfs under /sys/kernel/debug/thp_utilization.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>

Changes in v3:
-changed to use folio instead of page in thp_number_utilized_pages
method
-changed thp_number_utilized_pages to work on 32 bit architectures
with HIGHMEM.

Changes in v2:
-moved thp_utilization metrics from /proc to /sys/kernel/debug
-adjusted documentation to reflect that thp_utilization is no longer
in /proc
-changed is_anon_transparent_hugepage method to be static inline to
fix warning.
-removed unused *head pointer based on warning.
-adjust to use compound_head(page) instead of page in
thp_number_utilized_pages. There are rare instances where they
are not equivalent.
-fixed header to be v2. Previous v1 had v3 in the header by mistake.
---
 Documentation/admin-guide/mm/transhuge.rst |   9 ++
 include/linux/huge_mm.h                    |   2 +
 mm/huge_memory.c                           | 176 +++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
index c9c37f16eef8..d883ff9fddc7 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -297,6 +297,15 @@ To identify what applications are mapping file trans=
parent huge pages, it
 is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped fi=
elds
 for each mapping.
=20
+The utilization of transparent hugepages can be viewed by reading
+``/sys/kernel/debug/thp_utilization``. The utilization of a THP is defin=
ed
+as the ratio of non zero filled 4kb pages to the total number of pages i=
n a
+THP. The buckets are labelled by the range of total utilized 4kb pages w=
ith
+one line per utilization bucket. Each line contains the total number of
+THPs in that bucket and the total number of zero filled 4kb pages summed
+over all THPs in that bucket. The last two lines show the timestamp and
+duration respectively of the most recent scan over all of physical memor=
y.
+
 Note that reading the smaps file is expensive and reading it
 frequently will incur overhead.
=20
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 768e5261fdae..c9086239deb7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -179,6 +179,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long add=
r,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
=20
+int thp_number_utilized_pages(struct page *page);
+
 void prep_transhuge_page(struct page *page);
 void free_transhuge_page(struct page *page);
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a7c1b344abe..7f75cd3d553c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -45,6 +45,16 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
=20
+/*
+ * The number of utilization buckets THPs will be grouped in
+ * under /sys/kernel/debug/thp_utilization.
+ */
+#define THP_UTIL_BUCKET_NR 10
+/*
+ * The number of addresses to scan through on each periodic
+ * run of the scanner that generates /sys/kernel/debug/thp_utilization.
+ */
+#define THP_UTIL_SCAN_SIZE 256
 /*
  * By default, transparent hugepage support is disabled in order to avoi=
d
  * risking an increased memory footprint for applications that are not
@@ -70,6 +80,25 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
=20
+static void thp_utilization_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(thp_utilization_work, thp_utilization_workfn=
);
+
+struct thp_scan_info_bucket {
+	int nr_thps;
+	int nr_zero_pages;
+};
+
+struct thp_scan_info {
+	struct thp_scan_info_bucket buckets[THP_UTIL_BUCKET_NR];
+	struct zone *scan_zone;
+	struct timespec64 last_scan_duration;
+	struct timespec64 last_scan_time;
+	unsigned long pfn;
+};
+
+static struct thp_scan_info thp_scan_debugfs;
+static struct thp_scan_info thp_scan;
+
 bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
 			bool smaps, bool in_pf)
@@ -486,6 +515,7 @@ static int __init hugepage_init(void)
 	if (err)
 		goto err_slab;
=20
+	schedule_delayed_work(&thp_utilization_work, HZ);
 	err =3D register_shrinker(&huge_zero_page_shrinker, "thp-zero");
 	if (err)
 		goto err_hzp_shrinker;
@@ -600,6 +630,11 @@ static inline bool is_transparent_hugepage(struct pa=
ge *page)
 	       page[1].compound_dtor =3D=3D TRANSHUGE_PAGE_DTOR;
 }
=20
+static inline bool is_anon_transparent_hugepage(struct page *page)
+{
+	return PageAnon(page) && is_transparent_hugepage(page);
+}
+
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
@@ -650,6 +685,38 @@ unsigned long thp_get_unmapped_area(struct file *fil=
p, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
=20
+int thp_number_utilized_pages(struct page *page)
+{
+	struct folio *folio;
+	unsigned long page_offset, value;
+	int thp_nr_utilized_pages =3D HPAGE_PMD_NR;
+	int step_size =3D sizeof(unsigned long);
+	bool is_all_zeroes;
+	void *kaddr;
+	int i;
+
+	if (!page || !is_anon_transparent_hugepage(page))
+		return -1;
+
+	folio =3D page_folio(page);
+	for (i =3D 0; i < folio_nr_pages(folio); i++) {
+		kaddr =3D kmap_local_folio(folio, i);
+		is_all_zeroes =3D true;
+		for (page_offset =3D 0; page_offset < PAGE_SIZE; page_offset +=3D step=
_size) {
+			value =3D *(unsigned long *)(kaddr + page_offset);
+			if (value !=3D 0) {
+				is_all_zeroes =3D false;
+				break;
+			}
+		}
+		if (is_all_zeroes)
+			thp_nr_utilized_pages--;
+
+		kunmap_local(kaddr);
+	}
+	return thp_nr_utilized_pages;
+}
+
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
@@ -3135,6 +3202,42 @@ static int __init split_huge_pages_debugfs(void)
 	return 0;
 }
 late_initcall(split_huge_pages_debugfs);
+
+static int thp_utilization_show(struct seq_file *seqf, void *pos)
+{
+	int i;
+	int start;
+	int end;
+
+	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
+		start =3D i * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR;
+		end =3D (i + 1 =3D=3D THP_UTIL_BUCKET_NR)
+			   ? HPAGE_PMD_NR
+			   : ((i + 1) * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR - 1);
+		/* The last bucket will need to contain 100 */
+		seq_printf(seqf, "Utilized[%d-%d]: %d %d\n", start, end,
+			   thp_scan_debugfs.buckets[i].nr_thps,
+			   thp_scan_debugfs.buckets[i].nr_zero_pages);
+	}
+	seq_printf(seqf, "Last Scan Time: %lu.%02lu\n",
+		   (unsigned long)thp_scan_debugfs.last_scan_time.tv_sec,
+		   (thp_scan_debugfs.last_scan_time.tv_nsec / (NSEC_PER_SEC / 100)));
+
+	seq_printf(seqf, "Last Scan Duration: %lu.%02lu\n",
+		   (unsigned long)thp_scan_debugfs.last_scan_duration.tv_sec,
+		   (thp_scan_debugfs.last_scan_duration.tv_nsec / (NSEC_PER_SEC / 100)=
));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(thp_utilization);
+
+static int __init thp_utilization_debugfs(void)
+{
+	debugfs_create_file("thp_utilization", 0200, NULL, NULL,
+			    &thp_utilization_fops);
+	return 0;
+}
+late_initcall(thp_utilization_debugfs);
 #endif
=20
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -3220,3 +3323,76 @@ void remove_migration_pmd(struct page_vma_mapped_w=
alk *pvmw, struct page *new)
 	trace_remove_migration_pmd(address, pmd_val(pmde));
 }
 #endif
+
+static void thp_scan_next_zone(void)
+{
+	struct timespec64 current_time;
+	int i;
+	bool update_debugfs;
+
+	thp_scan.scan_zone =3D next_zone(thp_scan.scan_zone);
+	update_debugfs =3D !thp_scan.scan_zone;
+	thp_scan.scan_zone =3D update_debugfs ? (first_online_pgdat())->node_zo=
nes
+			: thp_scan.scan_zone;
+	thp_scan.pfn =3D (thp_scan.scan_zone->zone_start_pfn + HPAGE_PMD_NR - 1=
)
+			& ~(HPAGE_PMD_SIZE - 1);
+	if (!update_debugfs)
+		return;
+
+	ktime_get_ts64(&current_time);
+	thp_scan_debugfs.last_scan_duration =3D timespec64_sub(current_time,
+							     thp_scan_debugfs.last_scan_time);
+	thp_scan_debugfs.last_scan_time =3D current_time;
+
+	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
+		thp_scan_debugfs.buckets[i].nr_thps =3D thp_scan.buckets[i].nr_thps;
+		thp_scan_debugfs.buckets[i].nr_zero_pages =3D thp_scan.buckets[i].nr_z=
ero_pages;
+		thp_scan.buckets[i].nr_thps =3D 0;
+		thp_scan.buckets[i].nr_zero_pages =3D 0;
+	}
+}
+
+static void thp_util_scan(unsigned long pfn_end)
+{
+	struct page *page =3D NULL;
+	int bucket, num_utilized_pages, current_pfn;
+	int i;
+
+	for (i =3D 0; i < THP_UTIL_SCAN_SIZE; i++) {
+		current_pfn =3D thp_scan.pfn;
+		thp_scan.pfn +=3D HPAGE_PMD_NR;
+		if (current_pfn >=3D pfn_end)
+			return;
+
+		if (!pfn_valid(current_pfn))
+			continue;
+
+		page =3D pfn_to_page(current_pfn);
+		num_utilized_pages =3D thp_number_utilized_pages(page);
+		if (num_utilized_pages < 0)
+			continue;
+
+		bucket =3D num_utilized_pages * THP_UTIL_BUCKET_NR / HPAGE_PMD_NR;
+		bucket =3D min(bucket, THP_UTIL_BUCKET_NR - 1);
+		thp_scan.buckets[bucket].nr_thps++;
+		thp_scan.buckets[bucket].nr_zero_pages +=3D (HPAGE_PMD_NR - num_utiliz=
ed_pages);
+	}
+}
+
+static void thp_utilization_workfn(struct work_struct *work)
+{
+	unsigned long pfn_end;
+
+	if (!thp_scan.scan_zone)
+		thp_scan.scan_zone =3D (first_online_pgdat())->node_zones;
+
+	pfn_end =3D (thp_scan.scan_zone->zone_start_pfn +
+			thp_scan.scan_zone->spanned_pages + HPAGE_PMD_NR - 1)
+			& ~(HPAGE_PMD_SIZE - 1);
+	if (!populated_zone(thp_scan.scan_zone) || thp_scan.pfn >=3D pfn_end)
+		thp_scan_next_zone();
+	else
+		thp_util_scan(pfn_end);
+
+	schedule_delayed_work(&thp_utilization_work, HZ);
+}
--=20
2.30.2

