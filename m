Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1059CF17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbiHWDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiHWDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:04:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D43F5D0E5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:02:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBYq04wSszlWRv;
        Tue, 23 Aug 2022 10:59:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 11:02:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <lukas.bulwahn@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 3/6] mm/hugetlb: fix missing call to restore_reserve_on_error()
Date:   Tue, 23 Aug 2022 11:02:06 +0800
Message-ID: <20220823030209.57434-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220823030209.57434-1-linmiaohe@huawei.com>
References: <20220823030209.57434-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When huge_add_to_page_cache() fails, the page is freed directly without
calling restore_reserve_on_error() to restore reserve for newly allocated
pages not in page cache. Fix this by calling restore_reserve_on_error()
when huge_add_to_page_cache fails.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d46dfe5ba62c..8e62da153c64 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5576,7 +5576,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (idx >= size)
 		goto out;
 
-retry:
 	new_page = false;
 	page = find_lock_page(mapping, idx);
 	if (!page) {
@@ -5616,9 +5615,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
 			if (err) {
+				/*
+				 * err can't be -EEXIST which implies someone
+				 * else consumed the reservation since hugetlb
+				 * fault mutex is held when add a hugetlb page
+				 * to the page cache. So it's safe to call
+				 * restore_reserve_on_error() here.
+				 */
+				restore_reserve_on_error(h, vma, haddr, page);
 				put_page(page);
-				if (err == -EEXIST)
-					goto retry;
 				goto out;
 			}
 			new_pagecache_page = true;
-- 
2.23.0

