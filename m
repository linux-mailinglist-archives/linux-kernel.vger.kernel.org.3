Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265DD48D8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiAMNZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:25:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34906 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAMNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:25:33 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZQC74vn1zccTr;
        Thu, 13 Jan 2022 21:24:51 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 21:25:31 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500003.china.huawei.com
 (7.185.36.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 13 Jan
 2022 21:25:31 +0800
From:   Liang Zhang <zhangliang5@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangzhigang17@huawei.com>, <zhangliang5@huawei.com>
Subject: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Date:   Thu, 13 Jan 2022 22:03:18 +0800
Message-ID: <20220113140318.11117-1-zhangliang5@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current implementation, process's read requestions will fault in pages
with WP flags in PTEs. Next, if process emit a write requestion will go
into do_wp_page() and copy data to a new allocated page from the old one
due to refcount > 1 (page table mapped and swapcache), which could be
result in performance degradation. In fact, this page is exclusively owned
by this process and the duplication from old to a new allocated page is
really unnecessary.

So In this situation, these unshared pages can be reused by its process.

Signed-off-by: Liang Zhang <zhangliang5@huawei.com>
---
This patch has been tested with redis benchmark. Here is the test
result.

Hardware
========
Memory (GB): 512G
CPU (total #): 88
NVMe SSD (GB): 1024

OS
==
kernel 5.10.0

Testcase
========
step 1:
  Run 16 VMs (4U8G), each running with redis-server, in a cgroup 
  limiting memory.limit_in_bytes to 100G. 
step 2:
  Run memtier_bemchmark in host with params "--threads=1 --clients=1 \
--pipeline=256 --data-size=2048 --requests=allkeys --key-minimum=1 \
--key-maximum=30000000 --key-prefix=memtier-benchmark-prefix-redistests"
  to test every VM concurrently.

Workset size
============
cat memory.memsw.usage_in_bytes
125403303936

Result
======
Comparing with Baseline, this patch can achieved 41% more Ops/sec, 
41% more Hits/sec, 41% more Misses/sec, 30% less Latency and 
41% more KB/sec. 

  Index(average)        Baseline kernel        Patched kernel
  Ops/sec               109497                 155428
  Hits/sec              8653                   12283
  Misses/sec            90889                  129014
  Latency               2.297                  1.603
  KB/sec                44569                  63186


 mm/memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 23f2f1300d42..fd4d868b1c2d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3291,10 +3291,16 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		struct page *page = vmf->page;
 
 		/* PageKsm() doesn't necessarily raise the page refcount */
-		if (PageKsm(page) || page_count(page) != 1)
+		if (PageKsm(page))
 			goto copy;
 		if (!trylock_page(page))
 			goto copy;
+
+		/* reuse the unshared swapcache page */
+		if (PageSwapCache(page) && reuse_swap_page(page, NULL)) {
+			goto reuse;
+		}
+
 		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
 			unlock_page(page);
 			goto copy;
@@ -3304,6 +3310,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * page count reference, and the page is locked,
 		 * it's dark out, and we're wearing sunglasses. Hit it.
 		 */
+reuse:
 		unlock_page(page);
 		wp_page_reuse(vmf);
 		return VM_FAULT_WRITE;
-- 
2.30.0

