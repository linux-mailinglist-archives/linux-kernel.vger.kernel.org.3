Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDFD596B22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiHQIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiHQIOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B1558E8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724063; x=1692260063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjmwUhmqYGhaMRwm5D3DkxjF2iYcxiuJ/Jn14RhEMRc=;
  b=CAgM6qiw97wkkpa2+tT9IHbirCHBIDRDaEMrHkr1QJ8VmfsgFJ8me2xX
   ALmD8OfNC3NNRewGTCmXp9CeOm0qI3fiK8cvEVnQ6yK7za9KPkogr5evV
   X4EsMobRqCre9rnrMV3k/gFtoXdBwAMjBs9RoNtV0aKI4zEPR9jH/FurC
   8U0KrCmiP6kUQ0jDNBv/cbC+6WiKZKyOcElbwUJ0YV4dj49wfe6PmVojr
   oKO02xSaG9ti+K9TVZBcCvFznJ9VzXPNtMlfiH+HH8+BEFSTZ+wkVYANH
   jMCC44usjWe7ob5NW8+/Z+5BLZmvL0nal0sKceDDFSTYpfRMyK/V+Hz12
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228781"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668075"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:21 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 1/8] migrate: fix syscall move_pages() return value for failure
Date:   Wed, 17 Aug 2022 16:14:01 +0800
Message-Id: <20220817081408.513338-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817081408.513338-1-ying.huang@intel.com>
References: <20220817081408.513338-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of move_pages() syscall is incorrect when counting
the remaining pages to be migrated.  For example, for the following
test program,

"
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

 int page_size;

 bool do_vmsplice;
 bool do_thp;

 static int pipe_fds[2];
 void *addr;
 char *pn;
 char *pn1;
 void *pages[2];
 int status[2];

 void prepare()
 {
	 int ret;
	 struct iovec iov;

	 if (addr) {
		 munmap(addr, MAP_SIZE);
		 close(pipe_fds[0]);
		 close(pipe_fds[1]);
	 }

	 ret = pipe(pipe_fds);
	 ERR_EXIT_ON(ret, "pipe");

	 addr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	 ERR_EXIT_ON(addr == MAP_FAILED, "mmap");
	 if (do_thp) {
		 ret = madvise(addr, MAP_SIZE, MADV_HUGEPAGE);
		 ERR_EXIT_ON(ret, "advise hugepage");
	 }

	 pn = (char *)(((unsigned long)addr + THP_SIZE) & ~THP_MASK);
	 pn1 = pn + THP_SIZE;
	 pages[0] = pn;
	 pages[1] = pn1;
	 *pn = 1;

	 if (do_vmsplice) {
		 iov.iov_base = pn;
		 iov.iov_len = page_size;
		 ret = vmsplice(pipe_fds[1], &iov, 1, 0);
		 ERR_EXIT_ON(ret < 0, "vmsplice");
	 }

	 status[0] = status[1] = 1024;
 }

 void test_migrate()
 {
	 int ret;
	 int nodes[2] = { 1, 1 };
	 pid_t pid = getpid();

	 prepare();
	 ret = move_pages(pid, 1, pages, nodes, status, MPOL_MF_MOVE_ALL);
	 error_msg(ret, 1, status, "move 1 page");

	 prepare();
	 ret = move_pages(pid, 2, pages, nodes, status, MPOL_MF_MOVE_ALL);
	 error_msg(ret, 2, status, "move 2 pages, page 1 not mapped");

	 prepare();
	 *pn1 = 1;
	 ret = move_pages(pid, 2, pages, nodes, status, MPOL_MF_MOVE_ALL);
	 error_msg(ret, 2, status, "move 2 pages");

	 prepare();
	 *pn1 = 1;
	 nodes[1] = 0;
	 ret = move_pages(pid, 2, pages, nodes, status, MPOL_MF_MOVE_ALL);
	 error_msg(ret, 2, status, "move 2 pages, page 1 to node 0");
 }

 int main(int argc, char *argv[])
 {
	 numa_run_on_node(0);
	 page_size = getpagesize();

	 test_migrate();

	 fprintf(stderr, "\nMake page 0 cannot be migrated:\n");
	 do_vmsplice = true;
	 test_migrate();

	 fprintf(stderr, "\nTest THP:\n");
	 do_thp = true;
	 do_vmsplice = false;
	 test_migrate();

	 fprintf(stderr, "\nTHP: make page 0 cannot be migrated:\n");
	 do_vmsplice = true;
	 test_migrate();

	 return 0;
 }
"

The output of the current kernel is,

"
Error: move 1 page, ret : 0, error: Success
status: 1
Error: move 2 pages, page 1 not mapped, ret : 0, error: Success
status: 1 -14
Error: move 2 pages, ret : 0, error: Success
status: 1 1
Error: move 2 pages, page 1 to node 0, ret : 0, error: Success
status: 1 0

Make page 0 cannot be migrated:
Error: move 1 page, ret : 0, error: Success
status: 1024
Error: move 2 pages, page 1 not mapped, ret : 1, error: Success
status: 1024 -14
Error: move 2 pages, ret : 0, error: Success
status: 1024 1024
Error: move 2 pages, page 1 to node 0, ret : 1, error: Success
status: 1024 1024
"

While the expected output is,

"
Error: move 1 page, ret : 0, error: Success
status: 1
Error: move 2 pages, page 1 not mapped, ret : 0, error: Success
status: 1 -14
Error: move 2 pages, ret : 0, error: Success
status: 1 1
Error: move 2 pages, page 1 to node 0, ret : 0, error: Success
status: 1 0

Make page 0 cannot be migrated:
Error: move 1 page, ret : 1, error: Success
status: 1024
Error: move 2 pages, page 1 not mapped, ret : 1, error: Success
status: 1024 -14
Error: move 2 pages, ret : 1, error: Success
status: 1024 1024
Error: move 2 pages, page 1 to node 0, ret : 2, error: Success
status: 1024 1024
"

Fix this via correcting the remaining pages counting.  With the fix,
the output for the test program as above is expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a35eba462e61..1758fd215c0a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1751,7 +1751,7 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
 		 * well.
 		 */
 		if (err > 0)
-			err += nr_pages - i - 1;
+			err += nr_pages - i;
 		return err;
 	}
 	return store_status(status, start, node, i - start);
@@ -1837,8 +1837,12 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
 		err = move_pages_and_store_status(mm, current_node, &pagelist,
 				status, start, i, nr_pages);
-		if (err)
+		if (err) {
+			/* We have accounted for page i */
+			if (err > 0)
+				err--;
 			goto out;
+		}
 		current_node = NUMA_NO_NODE;
 	}
 out_flush:
-- 
2.30.2

