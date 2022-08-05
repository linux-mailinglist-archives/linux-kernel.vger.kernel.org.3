Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6C58AFF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiHESk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiHESk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:40:26 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197171BEA3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:40:24 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275HHCBj030971
        for <linux-kernel@vger.kernel.org>; Fri, 5 Aug 2022 11:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=7/KTaCk6Lpnptvzm8Dj0BsrblvI3uzsejEMBE+hscjU=;
 b=oDFWvSEw/xcuicnyWHd3S/4P38mcy4qBEqEM8cS+w7hPSSrGcw8lalel6dm38Ld2iwC7
 IymKh/G2fpkmoma/wnNh8dC/cEbFNwS83BXb6ivXJ3mJPChNfx9kM/YtAIkgm+hjhE47
 dRf6CgcV5cwNYClxr7S3BQG1D7H2bh02SSQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hs2qhagqf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:40:23 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub203.TheFacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 11:40:22 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 11:40:21 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id F3CFF1E40F1F; Fri,  5 Aug 2022 11:40:17 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
CC:     Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
Date:   Fri, 5 Aug 2022 11:40:16 -0700
Message-ID: <20220805184016.2926168-1-alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IJzr76VmfUjM7fDcydAU1fmWPHUWe88U
X-Proofpoint-ORIG-GUID: IJzr76VmfUjM7fDcydAU1fmWPHUWe88U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_09,2022-08-05_01,2022-06-22_01
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
/proc/thp_utilization.

Utilization of a THP is defined as the percentage of nonzero
pages in the THP. The worker thread will scan through all
of physical memory and obtain utilization of all anonymous
THPs. It will gather this information by periodically scanning
through all of physical memory for anonymous THPs, group them
into buckets based on utilization, and report utilization
information through /proc/thp_utilization.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
---
 Documentation/admin-guide/mm/transhuge.rst |   5 +
 Documentation/filesystems/proc.rst         |  30 ++++
 include/linux/huge_mm.h                    |   2 +
 mm/huge_memory.c                           | 167 +++++++++++++++++++++
 4 files changed, 204 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
index c9c37f16eef8..46ebdd8ea0d1 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -297,6 +297,11 @@ To identify what applications are mapping file trans=
parent huge pages, it
 is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped fi=
elds
 for each mapping.
=20
+The utilization of transparent hugepages can be viewed by reading
+``/proc/thp_utilization``. This shows the number of THPs per
+utilization bucket and the number of zero pages in each bucket. The
+last two lines show the time and the duration of the last scan.
+
 Note that reading the smaps file is expensive and reading it
 frequently will incur overhead.
=20
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
index 1bc91fb8c321..bb49e97cc469 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -720,6 +720,7 @@ files are there, and which are missing.
  sys          See chapter 2
  sysvipc      Info of SysVIPC Resources (msg, sem, shm)		(2.4)
  tty 	      Info of tty drivers
+ thp_utilization 	      Info on thp utilization
  uptime       Wall clock since boot, combined idle time of all cpus
  version      Kernel version
  video 	      bttv info of video resources			(2.4)
@@ -1158,6 +1159,35 @@ DirectMap4k, DirectMap2M, DirectMap1G
               Breakdown of page table sizes used in the kernel's
               identity mapping of RAM
=20
+thp_utilization
+~~~~~~~~~~~~~~~
+
+Provides information on the utilization of Transparent Hugepages. The
+utilization of a THP is defined as the ratio of non zero filled 4kb
+pages to the total number of pages in a THP. The buckets are labelled
+by the range of total utilized 4kb pages with one line per utilization
+bucket. Each line contains the total number of THPs in that bucket
+and the total number of zero filled 4kb pages summed over all THPs
+in that bucket. The last two lines show the timestamp and duration
+respectively of the most recent scan over all of physical memory.
+
+::
+
+    > cat /proc/thp_utilization
+    Utilized[0-50]: 435 217667
+    Utilized[51-101]: 58 25394
+    Utilized[102-152]: 51 19605
+    Utilized[153-203]: 43 14169
+    Utilized[204-255]: 54 15300
+    Utilized[256-306]: 55 12537
+    Utilized[307-357]: 49 8675
+    Utilized[358-408]: 67 8601
+    Utilized[409-459]: 82 6259
+    Utilized[460-512]: 189 2613
+    Last Scan Time: 1202.83
+    Last Scan Duration: 70.72
+
+
 vmallocinfo
 ~~~~~~~~~~~
=20
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de29821231c9..0ece9d53ab48 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -196,6 +196,8 @@ bool transparent_hugepage_active(struct vm_area_struc=
t *vma);
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
index 834f288b3769..a393fa491632 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/page_idle.h>
+#include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
@@ -44,6 +45,16 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
=20
+/*
+ * The number of utilization buckets THPs will be grouped in
+ * under /proc/thp_utilization.
+ */
+#define THP_UTIL_BUCKET_NR 10
+/*
+ * The number of addresses to scan through on each periodic
+ * run of the scanner that generates /proc/thp_utilization.
+ */
+#define THP_UTIL_SCAN_SIZE 256
 /*
  * By default, transparent hugepage support is disabled in order to avoi=
d
  * risking an increased memory footprint for applications that are not
@@ -69,6 +80,52 @@ static atomic_t huge_zero_refcount;
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
+static struct thp_scan_info thp_scan_proc;
+static struct thp_scan_info thp_scan;
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
+			   thp_scan_proc.buckets[i].nr_thps,
+			   thp_scan_proc.buckets[i].nr_zero_pages);
+	}
+	seq_printf(seqf, "Last Scan Time: %lu.%02lu\n",
+		   (unsigned long)thp_scan_proc.last_scan_time.tv_sec,
+		   (thp_scan_proc.last_scan_time.tv_nsec / (NSEC_PER_SEC / 100)));
+
+	seq_printf(seqf, "Last Scan Duration: %lu.%02lu\n",
+		   (unsigned long)thp_scan_proc.last_scan_duration.tv_sec,
+		   (thp_scan_proc.last_scan_duration.tv_nsec / (NSEC_PER_SEC / 100)));
+
+	return 0;
+}
+
 bool transparent_hugepage_active(struct vm_area_struct *vma)
 {
 	/* The addr is used to check if the vma size fits */
@@ -423,6 +480,9 @@ static int __init hugepage_init(void)
 	if (err)
 		goto err_slab;
=20
+	proc_create_single("thp_utilization", 0, NULL, &thp_utilization_show);
+	schedule_delayed_work(&thp_utilization_work, HZ);
+
 	err =3D register_shrinker(&huge_zero_page_shrinker);
 	if (err)
 		goto err_hzp_shrinker;
@@ -537,6 +597,12 @@ static inline bool is_transparent_hugepage(struct pa=
ge *page)
 	       page[1].compound_dtor =3D=3D TRANSHUGE_PAGE_DTOR;
 }
=20
+bool is_anon_transparent_hugepage(struct page *page)
+{
+	return PageAnon(page) && is_transparent_hugepage(page);
+}
+EXPORT_SYMBOL_GPL(is_anon_transparent_hugepage);
+
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
@@ -587,6 +653,34 @@ unsigned long thp_get_unmapped_area(struct file *fil=
p, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
=20
+int thp_number_utilized_pages(struct page *page)
+{
+	unsigned long page_index, page_offset, value;
+	int thp_nr_utilized_pages =3D HPAGE_PMD_NR;
+	int step_size =3D sizeof(unsigned long);
+	bool is_all_zeroes;
+	void *kaddr;
+
+	if (!page || !is_anon_transparent_hugepage(page))
+		return -1;
+
+	kaddr =3D kmap_local_page(page);
+	for (page_index =3D 0; page_index < HPAGE_PMD_NR; page_index++) {
+		is_all_zeroes =3D true;
+		for (page_offset =3D 0; page_offset < PAGE_SIZE; page_offset +=3D step=
_size) {
+			value =3D *(unsigned long *)(kaddr + page_index * PAGE_SIZE + page_of=
fset);
+			if (value !=3D 0) {
+				is_all_zeroes =3D false;
+				break;
+			}
+		}
+		if (is_all_zeroes)
+			thp_nr_utilized_pages--;
+	}
+	kunmap_local(kaddr);
+	return thp_nr_utilized_pages;
+}
+
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
@@ -3167,3 +3261,76 @@ void remove_migration_pmd(struct page_vma_mapped_w=
alk *pvmw, struct page *new)
 	trace_remove_migration_pmd(address, pmd_val(pmde));
 }
 #endif
+
+static void thp_scan_next_zone(void)
+{
+	struct timespec64 current_time;
+	int i;
+	bool update_proc;
+
+	thp_scan.scan_zone =3D next_zone(thp_scan.scan_zone);
+	update_proc =3D !thp_scan.scan_zone;
+	thp_scan.scan_zone =3D update_proc ? (first_online_pgdat())->node_zones
+			: thp_scan.scan_zone;
+	thp_scan.pfn =3D (thp_scan.scan_zone->zone_start_pfn + HPAGE_PMD_NR - 1=
)
+			& ~(HPAGE_PMD_SIZE - 1);
+	if (!update_proc)
+		return;
+
+	ktime_get_ts64(&current_time);
+	thp_scan_proc.last_scan_duration =3D timespec64_sub(current_time,
+							  thp_scan_proc.last_scan_time);
+	thp_scan_proc.last_scan_time =3D current_time;
+
+	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
+		thp_scan_proc.buckets[i].nr_thps =3D thp_scan.buckets[i].nr_thps;
+		thp_scan_proc.buckets[i].nr_zero_pages =3D thp_scan.buckets[i].nr_zero=
_pages;
+		thp_scan.buckets[i].nr_thps =3D 0;
+		thp_scan.buckets[i].nr_zero_pages =3D 0;
+	}
+}
+
+static void thp_util_scan(unsigned long pfn_end)
+{
+	struct page *page, *head =3D NULL;
+	int bucket, num_utilized_pages, current_pfn;
+	int i;
+
+	for (i =3D 0; i < THP_UTIL_SCAN_SIZE; i++) {
+		current_pfn =3D thp_scan.pfn;
+		thp_scan.pfn +=3D HPAGE_PMD_NR;
+		if (current_pfn >=3D pfn_end)
+			return;
+		if (!pfn_valid(current_pfn))
+			continue;
+
+		page =3D pfn_to_page(current_pfn);
+		num_utilized_pages =3D thp_number_utilized_pages(page);
+		if (num_utilized_pages < 0)
+			continue;
+
+		head =3D compound_head(page);
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

