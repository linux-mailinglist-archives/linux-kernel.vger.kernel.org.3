Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69355A2149
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiHZG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbiHZG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:57:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC462D2760
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:57:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q6ZoNf032328;
        Fri, 26 Aug 2022 06:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=sSItjYJZAw8u6sBqb/MKieSjGLh8he3yIHEyPqbvI2Y=;
 b=LrRNoRD1qx1fFaYsi2yJHVsLdvoZosQ4xv/aESGk2D0jnIEwkQTCbf++CkKQHMrgeNug
 uHyP7rbOyqAY0zHJBJUff7n+gN7PQwtEGf7KBreYQPCnV+q02uPzv/cGzFqSwIjk+udd
 g9luVABpvcwK0HrPJa98SuvB+1cKzWhTYebGHdxsGUSfPoofTgJpZ/Ayvs8X2TZNtmjD
 t97qe8ykARuXx7Qsr0JR/C6LdRCpV5XsTSu35SM78grE1yl7xsskrXeBhbsQdztBPahU
 JxUcd2ev3f0omW9BTB7NoAdPMg6NlsU/l7wVEQfaVpkLyaoZ0ow55Krg+vxdk2FFIVJ8 +A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j63v3mge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 06:57:08 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q6plmY009726;
        Fri, 26 Aug 2022 06:57:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3j60etwfhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 06:57:07 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27Q6tHLD012816;
        Fri, 26 Aug 2022 06:57:07 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 27Q6v6sJ014738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 06:57:07 +0000
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 25 Aug 2022 23:57:01 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <pasha.tatashin@soleen.com>,
        <shakeelb@google.com>, <sieberf@amazon.com>, <sjpark@amazon.de>,
        <william.kucharski@oracle.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <minchan@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V5] mm: fix use-after free of page_ext after race with memory-offline
Date:   Fri, 26 Aug 2022 12:26:33 +0530
Message-ID: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9iwuLI555xjuK2IhzpOF49mVzSpLMWaG
X-Proofpoint-GUID: 9iwuLI555xjuK2IhzpOF49mVzSpLMWaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260024
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below is one path where race between page_ext and  offline of the
respective memory blocks will cause use-after-free on the access of
page_ext structure.

process1		              process2
---------                             ---------
a)doing /proc/page_owner           doing memory offline
			           through offline_pages.

b)PageBuddy check is failed
thus proceed to get the
page_owner information
through page_ext access.
page_ext = lookup_page_ext(page);

				    migrate_pages();
				    .................
				Since all pages are successfully
				migrated as part of the offline
				operation,send MEM_OFFLINE notification
				where for page_ext it calls:
				offline_page_ext()-->
				__free_page_ext()-->
				   free_page_ext()-->
				     vfree(ms->page_ext)
			           mem_section->page_ext = NULL

c) Check for the PAGE_EXT flags
in the page_ext->flags access
results into the use-after-free(leading
to the translation faults).

As mentioned above, there is really no synchronization between page_ext
access and its freeing in the memory_offline.

The memory offline steps(roughly) on a memory block is as below:
1) Isolate all the pages
2) while(1)
  try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
3) delete the pages from this buddy list.
4) Then free page_ext.(Note: The struct page is still alive as it is
freed only during hot remove of the memory which frees the memmap, which
steps the user might not perform).

This design leads to the state where struct page is alive but the struct
page_ext is freed, where the later is ideally part of the former which
just representing the page_flags (check [3] for why this design is
chosen).

The above mentioned race is just one example __but the problem persists
in the other paths too involving page_ext->flags access(eg:
page_is_idle())__.

Fix all the paths where offline races with page_ext access by
maintaining synchronization with rcu lock and is achieved in 3 steps:
1) Invalidate all the page_ext's of the sections of a memory block by
storing a flag in the LSB of mem_section->page_ext.

2) Wait till all the existing readers to finish working with the
->page_ext's with synchronize_rcu(). Any parallel process that starts
after this call will not get page_ext, through lookup_page_ext(), for
the block parallel offline operation is being performed.

3) Now safely free all sections ->page_ext's of the block on which
offline operation is being performed.

Note: If synchronize_rcu() takes time then optimizations can be done in
this path through call_rcu()[2].

Thanks to David Hildenbrand for his views/suggestions on the initial
discussion[1] and Pavan kondeti for various inputs on this patch.

[1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
[2] https://lore.kernel.org/all/a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com/T/#u
[3] https://lore.kernel.org/all/6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com/

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
Changes in V5:
   o Used the loop variable name as ext_put_continue -- David

Changes in V4:
   o Updated the documentation for page_ext_get/put() -- Matthew/Michal
   o Changed the page_ext_put() interface -- Michal
   o page_ext_get/put() is called only once in set_page_owner -- vlastimil/Michal
   o Updated the commit text
   o https://lore.kernel.org/all/1660830600-9068-1-git-send-email-quic_charante@quicinc.com/

Changes in V3:
   o Exposed page_ext_get/put() and hid lookup_page_ext to get page_ext information.
   o Converted the call sites to use single interface i.e.page_ext_get/put().
   o Placed rcu_lock held checks where required.
   o Improved the commit message.
   o https://lore.kernel.org/all/1660056403-20894-1-git-send-email-quic_charante@quicinc.com/

Changes in V2:
   o Use only page_ext_get/put() to get the page_ext in the
     required paths. Add proper comments for them.
   o Use synchronize_rcu() only once instead of calling it for
     every mem_section::page_ext of a memory block.
   o Free'd page_ext in 3 steps of invalidate, wait till all the
     users are finished using and then finally free page_ext.
   o https://lore.kernel.org/all/1658931303-17024-1-git-send-email-quic_charante@quicinc.com/

Changes in V1:
   o Used the RCU lock while accessing the page_ext in the paths that
     can race with the memory offline operation.
   o Introduced (get|put)_page_ext() function to get the page_ext of page.
   o https://lore.kernel.org/all/1657810063-28938-1-git-send-email-quic_charante@quicinc.com/

 include/linux/page_ext.h  |  17 +++++---
 include/linux/page_idle.h |  34 ++++++++++-----
 mm/page_ext.c             | 103 +++++++++++++++++++++++++++++++++++++++++++---
 mm/page_owner.c           |  73 +++++++++++++++++++++++---------
 mm/page_table_check.c     |  10 +++--
 5 files changed, 192 insertions(+), 45 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index fabb2e1..ed27198 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -55,7 +55,8 @@ static inline void page_ext_init(void)
 }
 #endif
 
-struct page_ext *lookup_page_ext(const struct page *page);
+extern struct page_ext *page_ext_get(struct page *page);
+extern void page_ext_put(struct page_ext *page_ext);
 
 static inline struct page_ext *page_ext_next(struct page_ext *curr)
 {
@@ -71,11 +72,6 @@ static inline void pgdat_page_ext_init(struct pglist_data *pgdat)
 {
 }
 
-static inline struct page_ext *lookup_page_ext(const struct page *page)
-{
-	return NULL;
-}
-
 static inline void page_ext_init(void)
 {
 }
@@ -87,5 +83,14 @@ static inline void page_ext_init_flatmem_late(void)
 static inline void page_ext_init_flatmem(void)
 {
 }
+
+static inline struct page_ext *page_ext_get(struct page *page)
+{
+	return NULL;
+}
+
+static inline void page_ext_put(struct page_ext *page_ext)
+{
+}
 #endif /* CONFIG_PAGE_EXTENSION */
 #endif /* __LINUX_PAGE_EXT_H */
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 4663dfe..5cb7bd2 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -13,65 +13,79 @@
  * If there is not enough space to store Idle and Young bits in page flags, use
  * page ext flags instead.
  */
-
 static inline bool folio_test_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
+	bool page_young;
 
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_young = test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_ext_put(page_ext);
+
+	return page_young;
 }
 
 static inline void folio_set_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
 
 	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_ext_put(page_ext);
 }
 
 static inline bool folio_test_clear_young(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
+	bool page_young;
 
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_young = test_and_clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
+	page_ext_put(page_ext);
+
+	return page_young;
 }
 
 static inline bool folio_test_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
+	bool page_idle;
 
 	if (unlikely(!page_ext))
 		return false;
 
-	return test_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_idle =  test_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_ext_put(page_ext);
+
+	return page_idle;
 }
 
 static inline void folio_set_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
 
 	set_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_ext_put(page_ext);
 }
 
 static inline void folio_clear_idle(struct folio *folio)
 {
-	struct page_ext *page_ext = lookup_page_ext(&folio->page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
 
 	if (unlikely(!page_ext))
 		return;
 
 	clear_bit(PAGE_EXT_IDLE, &page_ext->flags);
+	page_ext_put(page_ext);
 }
 #endif /* !CONFIG_64BIT */
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d..6246f19 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -9,6 +9,7 @@
 #include <linux/page_owner.h>
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
+#include <linux/rcupdate.h>
 
 /*
  * struct page extension
@@ -59,6 +60,10 @@
  * can utilize this callback to initialize the state of it correctly.
  */
 
+#ifdef CONFIG_SPARSEMEM
+#define PAGE_EXT_INVALID       (0x1)
+#endif
+
 #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 static bool need_page_idle(void)
 {
@@ -84,6 +89,7 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 unsigned long page_ext_size = sizeof(struct page_ext);
 
 static unsigned long total_usage;
+static struct page_ext *lookup_page_ext(const struct page *page);
 
 static bool __init invoke_need_callbacks(void)
 {
@@ -125,6 +131,48 @@ static inline struct page_ext *get_entry(void *base, unsigned long index)
 	return base + page_ext_size * index;
 }
 
+/**
+ * page_ext_get() - Get the extended information for a page.
+ * @page: The page we're interested in.
+ *
+ * Ensures that the page_ext will remain valid until page_ext_put()
+ * is called.
+ *
+ * Return: NULL if no page_ext exists for this page.
+ * Context: Any context.  Caller may not sleep until they have called
+ * page_ext_put().
+ */
+struct page_ext *page_ext_get(struct page *page)
+{
+	struct page_ext *page_ext;
+
+	rcu_read_lock();
+	page_ext = lookup_page_ext(page);
+	if (!page_ext) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	return page_ext;
+}
+
+/**
+ * page_ext_put() - Working with page extended information is done.
+ * @page_ext - Page extended information received from page_ext_get().
+ *
+ * The page extended information of the page may not be valid after this
+ * function is called.
+ *
+ * Return: None.
+ * Context: Any context with corresponding page_ext_get() is called.
+ */
+void page_ext_put(struct page_ext *page_ext)
+{
+	if (unlikely(!page_ext))
+		return;
+
+	rcu_read_unlock();
+}
 #ifndef CONFIG_SPARSEMEM
 
 
@@ -133,12 +181,13 @@ void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
 	pgdat->node_page_ext = NULL;
 }
 
-struct page_ext *lookup_page_ext(const struct page *page)
+static struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long index;
 	struct page_ext *base;
 
+	WARN_ON_ONCE(!rcu_read_lock_held());
 	base = NODE_DATA(page_to_nid(page))->node_page_ext;
 	/*
 	 * The sanity checks the page allocator does upon freeing a
@@ -206,20 +255,27 @@ void __init page_ext_init_flatmem(void)
 }
 
 #else /* CONFIG_SPARSEMEM */
+static bool page_ext_invalid(struct page_ext *page_ext)
+{
+	return !page_ext || (((unsigned long)page_ext & PAGE_EXT_INVALID) == PAGE_EXT_INVALID);
+}
 
-struct page_ext *lookup_page_ext(const struct page *page)
+static struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct mem_section *section = __pfn_to_section(pfn);
+	struct page_ext *page_ext = READ_ONCE(section->page_ext);
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
 	/*
 	 * The sanity checks the page allocator does upon freeing a
 	 * page can reach here before the page_ext arrays are
 	 * allocated when feeding a range of pages to the allocator
 	 * for the first time during bootup or memory hotplug.
 	 */
-	if (!section->page_ext)
+	if (page_ext_invalid(page_ext))
 		return NULL;
-	return get_entry(section->page_ext, pfn);
+	return get_entry(page_ext, pfn);
 }
 
 static void *__meminit alloc_page_ext(size_t size, int nid)
@@ -298,9 +354,30 @@ static void __free_page_ext(unsigned long pfn)
 	ms = __pfn_to_section(pfn);
 	if (!ms || !ms->page_ext)
 		return;
-	base = get_entry(ms->page_ext, pfn);
+
+	base = READ_ONCE(ms->page_ext);
+	/*
+	 * page_ext here can be valid while doing the roll back
+	 * operation in online_page_ext().
+	 */
+	if (page_ext_invalid(base))
+		base = (void *)base - PAGE_EXT_INVALID;
+	WRITE_ONCE(ms->page_ext, NULL);
+
+	base = get_entry(base, pfn);
 	free_page_ext(base);
-	ms->page_ext = NULL;
+}
+
+static void __invalidate_page_ext(unsigned long pfn)
+{
+	struct mem_section *ms;
+	void *val;
+
+	ms = __pfn_to_section(pfn);
+	if (!ms || !ms->page_ext)
+		return;
+	val = (void *)ms->page_ext + PAGE_EXT_INVALID;
+	WRITE_ONCE(ms->page_ext, val);
 }
 
 static int __meminit online_page_ext(unsigned long start_pfn,
@@ -343,6 +420,20 @@ static int __meminit offline_page_ext(unsigned long start_pfn,
 	start = SECTION_ALIGN_DOWN(start_pfn);
 	end = SECTION_ALIGN_UP(start_pfn + nr_pages);
 
+	/*
+	 * Freeing of page_ext is done in 3 steps to avoid
+	 * use-after-free of it:
+	 * 1) Traverse all the sections and mark their page_ext
+	 *    as invalid.
+	 * 2) Wait for all the existing users of page_ext who
+	 *    started before invalidation to finish.
+	 * 3) Free the page_ext.
+	 */
+	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
+		__invalidate_page_ext(pfn);
+
+	synchronize_rcu();
+
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
 		__free_page_ext(pfn);
 	return 0;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f..72839a6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -141,7 +141,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
-	page_ext = lookup_page_ext(page);
+	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
 
@@ -153,6 +153,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner->free_ts_nsec = free_ts_nsec;
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put(page_ext);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -183,19 +184,21 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 noinline void __set_page_owner(struct page *page, unsigned short order,
 					gfp_t gfp_mask)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
 
+	handle = save_stack(gfp_mask);
+
+	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
-
-	handle = save_stack(gfp_mask);
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	page_ext_put(page_ext);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = page_ext_get(page);
 	struct page_owner *page_owner;
 
 	if (unlikely(!page_ext))
@@ -203,12 +206,13 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
 
 	page_owner = get_page_owner(page_ext);
 	page_owner->last_migrate_reason = reason;
+	page_ext_put(page_ext);
 }
 
 void __split_page_owner(struct page *page, unsigned int nr)
 {
 	int i;
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = page_ext_get(page);
 	struct page_owner *page_owner;
 
 	if (unlikely(!page_ext))
@@ -219,17 +223,25 @@ void __split_page_owner(struct page *page, unsigned int nr)
 		page_owner->order = 0;
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put(page_ext);
 }
 
 void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
-	struct page_ext *old_ext = lookup_page_ext(&old->page);
-	struct page_ext *new_ext = lookup_page_ext(&newfolio->page);
+	struct page_ext *old_ext;
+	struct page_ext *new_ext;
 	struct page_owner *old_page_owner, *new_page_owner;
 
-	if (unlikely(!old_ext || !new_ext))
+	old_ext = page_ext_get(&old->page);
+	if (unlikely(!old_ext))
 		return;
 
+	new_ext = page_ext_get(&newfolio->page);
+	if (unlikely(!new_ext)) {
+		page_ext_put(old_ext);
+		return;
+	}
+
 	old_page_owner = get_page_owner(old_ext);
 	new_page_owner = get_page_owner(new_ext);
 	new_page_owner->order = old_page_owner->order;
@@ -254,6 +266,8 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	 */
 	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
 	__set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
+	page_ext_put(new_ext);
+	page_ext_put(old_ext);
 }
 
 void pagetypeinfo_showmixedcount_print(struct seq_file *m,
@@ -307,12 +321,12 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			if (PageReserved(page))
 				continue;
 
-			page_ext = lookup_page_ext(page);
+			page_ext = page_ext_get(page);
 			if (unlikely(!page_ext))
 				continue;
 
 			if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-				continue;
+				goto ext_put_continue;
 
 			page_owner = get_page_owner(page_ext);
 			page_mt = gfp_migratetype(page_owner->gfp_mask);
@@ -323,9 +337,12 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					count[pageblock_mt]++;
 
 				pfn = block_end_pfn;
+				page_ext_put(page_ext);
 				break;
 			}
 			pfn += (1UL << page_owner->order) - 1;
+ext_put_continue:
+			page_ext_put(page_ext);
 		}
 	}
 
@@ -435,7 +452,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 
 void __dump_page_owner(const struct page *page)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext = page_ext_get((void *)page);
 	struct page_owner *page_owner;
 	depot_stack_handle_t handle;
 	gfp_t gfp_mask;
@@ -452,6 +469,7 @@ void __dump_page_owner(const struct page *page)
 
 	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
 		pr_alert("page_owner info is not present (never set?)\n");
+		page_ext_put(page_ext);
 		return;
 	}
 
@@ -482,6 +500,7 @@ void __dump_page_owner(const struct page *page)
 	if (page_owner->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_owner->last_migrate_reason]);
+	page_ext_put(page_ext);
 }
 
 static ssize_t
@@ -508,6 +527,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	/* Find an allocated page */
 	for (; pfn < max_pfn; pfn++) {
 		/*
+		 * This temporary page_owner is required so
+		 * that we can avoid the context switches while holding
+		 * the rcu lock and copying the page owner information to
+		 * user through copy_to_user() or GFP_KERNEL allocations.
+		 */
+		struct page_owner page_owner_tmp;
+
+		/*
 		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
 		 * validate the area as existing, skip it if not
 		 */
@@ -525,7 +552,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 		}
 
-		page_ext = lookup_page_ext(page);
+		page_ext = page_ext_get(page);
 		if (unlikely(!page_ext))
 			continue;
 
@@ -534,14 +561,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * because we don't hold the zone lock.
 		 */
 		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
-			continue;
+			goto ext_put_continue;
 
 		/*
 		 * Although we do have the info about past allocation of free
 		 * pages, it's not relevant for current memory usage.
 		 */
 		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
-			continue;
+			goto ext_put_continue;
 
 		page_owner = get_page_owner(page_ext);
 
@@ -550,7 +577,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * would inflate the stats.
 		 */
 		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
-			continue;
+			goto ext_put_continue;
 
 		/*
 		 * Access to page_ext->handle isn't synchronous so we should
@@ -558,13 +585,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 */
 		handle = READ_ONCE(page_owner->handle);
 		if (!handle)
-			continue;
+			goto ext_put_continue;
 
 		/* Record the next PFN to read in the file offset */
 		*ppos = (pfn - min_low_pfn) + 1;
 
+		page_owner_tmp = *page_owner;
+		page_ext_put(page_ext);
 		return print_page_owner(buf, count, pfn, page,
-				page_owner, handle);
+				&page_owner_tmp, handle);
+ext_put_continue:
+		page_ext_put(page_ext);
 	}
 
 	return 0;
@@ -617,18 +648,20 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 			if (PageReserved(page))
 				continue;
 
-			page_ext = lookup_page_ext(page);
+			page_ext = page_ext_get(page);
 			if (unlikely(!page_ext))
 				continue;
 
 			/* Maybe overlapping zone */
 			if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
-				continue;
+				goto ext_put_continue;
 
 			/* Found early allocated page */
 			__set_page_owner_handle(page_ext, early_handle,
 						0, 0);
 			count++;
+ext_put_continue:
+			page_ext_put(page_ext);
 		}
 		cond_resched();
 	}
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index e206274..903db62 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -68,7 +68,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = lookup_page_ext(page);
+	page_ext = page_ext_get(page);
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -83,6 +83,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 		}
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put(page_ext);
 }
 
 /*
@@ -103,7 +104,7 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = lookup_page_ext(page);
+	page_ext = page_ext_get(page);
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -118,6 +119,7 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 		}
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put(page_ext);
 }
 
 /*
@@ -126,9 +128,10 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
  */
 void __page_table_check_zero(struct page *page, unsigned int order)
 {
-	struct page_ext *page_ext = lookup_page_ext(page);
+	struct page_ext *page_ext;
 	unsigned long i;
 
+	page_ext = page_ext_get(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
@@ -137,6 +140,7 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 		BUG_ON(atomic_read(&ptc->file_map_count));
 		page_ext = page_ext_next(page_ext);
 	}
+	page_ext_put(page_ext);
 }
 
 void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
-- 
2.7.4

