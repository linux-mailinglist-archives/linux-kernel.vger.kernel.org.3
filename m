Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D163558D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiFXCxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFXCxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:53:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFE1AF3F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656039211; x=1687575211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KWYHMMJ0yn6bZ7P65pQMIF8OzewgLAhwV6RxkcUbBuE=;
  b=iaje5hzNmyPtuEDc/n8q75XLjuTjZLOZHalZsr8QT8pDtMoJTcbAdy7n
   bDVgxM5VwKRxBSWjpqW2PtLbenxhwDXrZ9NBwgHC4Kwt+Mqh7yzOJ2g5e
   Zb5Riokd57/zLWQzsSl6apGh2Aum7kaHrpNlG9V20TfKbkMNLLdp7rjka
   VIxpMIg1QmDKeDItJiV0pYuvvMX3DhcxuM6l74J0z/KKSuiOoTRlw7NI+
   178u3Xzi+4pMnUAYZbDfWam7CnczIqEN4VgjV2dSFrfBSZLytfnSIRIo2
   2EdY4HyNrAepjhZjzBngui5Ffji4BBw/wZ2RcAUfo4zxfizzKGaS5pr0z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279672706"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="279672706"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="593018057"
Received: from yxia2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:28 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH 0/7] migrate_pages(): fix several bugs in error path
Date:   Fri, 24 Jun 2022 10:53:02 +0800
Message-Id: <20220624025309.1033400-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Huang, Ying" <ying.huang@intel.com>

During review the code of migrate_pages() and build a test program for
it.  Several bugs in error path are identified and fixed in this
series.

Most patches are tested via

- Apply error-inject.patch in Linux kernel
- Compile test-migrate.c (with -lnuma)
- Test with test-migrate.sh

error-inject.patch, test-migrate.c, and test-migrate.sh are as below.
It turns out that error injection is an important tool to fix bugs in
error path.

Best Regards,
Huang, Ying

------------------------- error-inject.patch -------------------------
From 295ea21204f3f025a041fe39c68a2eaec8313c68 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Tue, 21 Jun 2022 11:08:30 +0800
Subject: [PATCH] migrate_pages: error inject

---
 mm/migrate.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 399904015d23..87d47064ec6c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -337,6 +337,42 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
+#define EI_MP_ENOSYS		0x0001
+#define EI_MP_THP_ENOMEM	0x0002
+#define EI_MP_NP_ENOMEM		0x0004
+#define EI_MP_EAGAIN		0x0008
+#define EI_MP_EOTHER		0x0010
+#define EI_MP_NOSPLIT		0x0020
+#define EI_MP_SPLIT_FAIL	0x0040
+#define EI_MP_EAGAIN_PERM	0x0080
+#define EI_MP_EBUSY		0x0100
+
+static unsigned int ei_migrate_pages;
+
+module_param(ei_migrate_pages, uint, 0644);
+
+static bool ei_thp_migration_supported(void)
+{
+	if (ei_migrate_pages & EI_MP_ENOSYS)
+		return false;
+	else
+		return thp_migration_supported();
+}
+
+static int ei_trylock_page(struct page *page)
+{
+	if (ei_migrate_pages & EI_MP_EAGAIN)
+		return 0;
+	return trylock_page(page);
+}
+
+static int ei_split_huge_page_to_list(struct page *page, struct list_head *list)
+{
+	if (ei_migrate_pages & EI_MP_SPLIT_FAIL)
+		return -EBUSY;
+	return split_huge_page_to_list(page, list);
+}
+
 static int expected_page_refs(struct address_space *mapping, struct page *page)
 {
 	int expected_count = 1;
@@ -368,6 +404,9 @@ int folio_migrate_mapping(struct address_space *mapping,
 		if (folio_ref_count(folio) != expected_count)
 			return -EAGAIN;
 
+		if (ei_migrate_pages & EI_MP_EAGAIN_PERM)
+			return -EAGAIN;
+
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
@@ -929,7 +968,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
 
-	if (!trylock_page(page)) {
+	if (!ei_trylock_page(page)) {
 		if (!force || mode == MIGRATE_ASYNC)
 			goto out;
 
@@ -952,6 +991,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		lock_page(page);
 	}
 
+	if (ei_migrate_pages & EI_MP_EBUSY) {
+		rc = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (PageWriteback(page)) {
 		/*
 		 * Only in the case of a full synchronous migration is it
@@ -1086,7 +1130,7 @@ static int unmap_and_move(new_page_t get_new_page,
 	int rc = MIGRATEPAGE_SUCCESS;
 	struct page *newpage = NULL;
 
-	if (!thp_migration_supported() && PageTransHuge(page))
+	if (!ei_thp_migration_supported() && PageTransHuge(page))
 		return -ENOSYS;
 
 	if (page_count(page) == 1) {
@@ -1102,6 +1146,11 @@ static int unmap_and_move(new_page_t get_new_page,
 		goto out;
 	}
 
+	if ((ei_migrate_pages & EI_MP_THP_ENOMEM) && PageTransHuge(page))
+		return -ENOMEM;
+	if ((ei_migrate_pages & EI_MP_NP_ENOMEM) && !PageTransHuge(page))
+		return -ENOMEM;
+
 	newpage = get_new_page(page, private);
 	if (!newpage)
 		return -ENOMEM;
@@ -1305,7 +1354,7 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
 	int rc;
 
 	lock_page(page);
-	rc = split_huge_page_to_list(page, split_pages);
+	rc = ei_split_huge_page_to_list(page, split_pages);
 	unlock_page(page);
 
 	return rc;
@@ -1358,6 +1407,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_subpage_counting = false;
 
+	if (ei_migrate_pages & EI_MP_NOSPLIT)
+		nosplit = true;
+
 	trace_mm_migrate_pages_start(mode, reason);
 
 thp_subpage_migration:
-- 
2.30.2

------------------------- test-migrate.c -------------------------------------
 #define _GNU_SOURCE

 #include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>

 #include <fcntl.h>
 #include <sys/uio.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <numaif.h>
 #include <numa.h>

 #ifndef MADV_FREE
 #define MADV_FREE	8		/* free pages only if memory pressure */
 #endif

 #define ONE_MB		(1024 * 1024)
 #define MAP_SIZE	(16 * ONE_MB)
 #define THP_SIZE	(2 * ONE_MB)
 #define THP_MASK	(THP_SIZE - 1)

 #define ERR_EXIT_ON(cond, msg)					\
	 do {							\
		 int __cond_in_macro = (cond);			\
		 if (__cond_in_macro)				\
			 error_exit(__cond_in_macro, (msg));	\
	 } while (0)

 void error_msg(int ret, int nr, int *status, const char *msg)
 {
	 int i;

	 fprintf(stderr, "Error: %s, ret : %d, error: %s\n",
		 msg, ret, strerror(errno));

	 if (!nr)
		 return;
	 fprintf(stderr, "status: ");
	 for (i = 0; i < nr; i++)
		 fprintf(stderr, "%d ", status[i]);
	 fprintf(stderr, "\n");
 }

 void error_exit(int ret, const char *msg)
 {
	 error_msg(ret, 0, NULL, msg);
	 exit(1);
 }

 void *addr_thp;
 void *addr;
 char *pn;
 char *pn1;
 char *pn2;
 char *pn3;
 void *pages[4];
 int status[4];

 void create_map(bool thp)
 {
	 int ret;
	 void *p;

	 p = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
		  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	 ERR_EXIT_ON(p == MAP_FAILED, "mmap");
	 if (thp) {
		 ret = madvise(p, MAP_SIZE, MADV_HUGEPAGE);
		 ERR_EXIT_ON(ret, "advise hugepage");
		 addr_thp = p;
	 } else {
		 addr = p;
	 }
 }

 void prepare()
 {
	 int ret;
	 struct iovec iov;

	 if (addr) {
		 munmap(addr_thp, MAP_SIZE);
		 munmap(addr, MAP_SIZE);
	 }

	 create_map(true);
	 create_map(false);

	 pn = (char *)(((unsigned long)addr_thp + THP_SIZE) & ~THP_MASK);
	 pn1 = pn + THP_SIZE;
	 pages[0] = pn;
	 pages[1] = pn1;
	 *pn = 1;

	 pn2 = (char *)(((unsigned long)addr + THP_SIZE) & ~THP_MASK);
	 pn3 = pn2 + THP_SIZE;
	 pages[2] = pn2;
	 pages[3] = pn3;

	 status[0] = status[1] = status[2] = status[3] = 1024;
 }

 void test_migrate()
 {
	 int ret;
	 int nodes[4] = { 1, 1, 1, 1 };
	 pid_t pid = getpid();

	 prepare();
	 *pn1 = 1;
	 *pn2 = 1;
	 *pn3 = 1;
	 ret = move_pages(pid, 4, pages, nodes, status, MPOL_MF_MOVE_ALL);
	 error_msg(ret, 4, status, "move 4 pages");
 }

 int main(int argc, char *argv[])
 {
	 numa_run_on_node(0);

	 test_migrate();

	 return 0;
 }
--------------------- test-migrate.sh ----------------------------
 #!/bin/bash

 PARAM=/sys/module/migrate/parameters/ei_migrate_pages

 get_vmstat()
 {
	 echo ================= $* ================
	 cat /proc/vmstat | grep -e '\(pgmigrate\|thp_migration\)'
 }

 simple_test()
 {
	 echo $1 > $PARAM
	 shift
	 get_vmstat before $*
	 ./test-migrate
	 get_vmstat after $*
 }

 #define EI_MP_ENOSYS		0x0001
 #define EI_MP_THP_ENOMEM	0x0002
 #define EI_MP_NP_ENOMEM		0x0004
 #define EI_MP_EAGAIN		0x0008
 #define EI_MP_EOTHER		0x0010
 #define EI_MP_NOSPLIT		0x0020
 #define EI_MP_SPLIT_FAIL	0x0040
 #define EI_MP_EAGAIN_PERM	0x0080
 #define EI_MP_EBUSY		0x0100

 simple_test 0x26 ENOMEM
 simple_test 0x81 retry THP subpages
 simple_test 0xc1 ENOSYS
 simple_test 0x101 ENOSYS
