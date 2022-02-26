Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07144C54F1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiBZJl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 04:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 04:41:57 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485228860E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 01:41:21 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K5M3d3Fy3z1FDWQ;
        Sat, 26 Feb 2022 17:36:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 26 Feb
 2022 17:41:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <david@redhat.com>, <osalvador@suse.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH RFC] mm/memory-failure.c: fix memory failure race with memory offline
Date:   Sat, 26 Feb 2022 17:40:34 +0800
Message-ID: <20220226094034.23938-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a theoretical race window between memory failure and memory
offline. Think about the below scene:

  CPU A					  CPU B
memory_failure				offline_pages
  mutex_lock(&mf_mutex);
  TestSetPageHWPoison(p)
					  start_isolate_page_range
					    has_unmovable_pages
					      --PageHWPoison is movable
					  do {
					    scan_movable_pages
					    do_migrate_range
					      --PageHWPoison isn't migrated
					  }
					  test_pages_isolated
					    --PageHWPoison is isolated
					remove_memory
  access page... bang
  ...

When PageHWPoison is set, the page could be offlined anytime regardless
of the page refcnt. It's bacause start_isolate_page_range treats HWPoison
page as movable and already isolated, so the page range can be successfully
isolated. soft_offline_page and unpoison_memory have the similar race. Fix
this by using get_online_mems + put_online_mems pair to guard aginst memory
offline when doing memory failure.

There is a even worse race window. If the page refcnt is held, then memory
failure happens, the page could be offlined while it's still in use. So The
assumption that a page can not be offlined when the page refcnt is held is
now broken. This theoretical race window could happen in every vm activity.
But this race window might be too small to fix.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5444a8ef4867..b85232a64104 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1702,6 +1702,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
+	get_online_mems();
 	mutex_lock(&mf_mutex);
 
 	p = pfn_to_online_page(pfn);
@@ -1894,11 +1895,13 @@ int memory_failure(unsigned long pfn, int flags)
 identify_page_state:
 	res = identify_page_state(pfn, p, page_flags);
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 	return res;
 unlock_page:
 	unlock_page(p);
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 	return res;
 }
 EXPORT_SYMBOL_GPL(memory_failure);
@@ -2058,6 +2061,7 @@ int unpoison_memory(unsigned long pfn)
 	if (!pfn_valid(pfn))
 		return -ENXIO;
 
+	get_online_mems();
 	p = pfn_to_page(pfn);
 	page = compound_head(p);
 
@@ -2114,6 +2118,7 @@ int unpoison_memory(unsigned long pfn)
 
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 	return ret;
 }
 EXPORT_SYMBOL(unpoison_memory);
@@ -2278,10 +2283,12 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (flags & MF_COUNT_INCREASED)
 		ref_page = pfn_to_page(pfn);
 
+	get_online_mems();
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	page = pfn_to_online_page(pfn);
 	if (!page) {
 		put_ref_page(ref_page);
+		put_online_mems();
 		return -EIO;
 	}
 
@@ -2291,13 +2298,12 @@ int soft_offline_page(unsigned long pfn, int flags)
 		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
 		put_ref_page(ref_page);
 		mutex_unlock(&mf_mutex);
+		put_online_mems();
 		return 0;
 	}
 
 retry:
-	get_online_mems();
 	ret = get_hwpoison_page(page, flags);
-	put_online_mems();
 
 	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
@@ -2310,6 +2316,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	}
 
 	mutex_unlock(&mf_mutex);
+	put_online_mems();
 
 	return ret;
 }
-- 
2.23.0

