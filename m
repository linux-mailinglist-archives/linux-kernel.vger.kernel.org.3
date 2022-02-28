Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DB4C6ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiB1OE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiB1OEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:04:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FB49F31
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:03:35 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K6hs526PWzdfkJ;
        Mon, 28 Feb 2022 22:02:17 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 22:03:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in split_huge_page_to_list
Date:   Mon, 28 Feb 2022 22:02:45 +0800
Message-ID: <20220228140245.24552-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220228140245.24552-1-linmiaohe@huawei.com>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The huge zero page could reach here and if we ever try to split it, the
VM_BUG_ON_PAGE will be triggered in split_huge_page_to_list(). Also the
non-lru compound movable pages could be taken for transhuge pages. Skip
these pages by checking PageLRU because huge zero page isn't lru page as
non-lru compound movable pages.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 23bfd809dc8c..ac6492e36978 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1792,6 +1792,20 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
+		/*
+		 * The non-lru compound movable pages could be taken for
+		 * transhuge pages. Also huge zero page could reach here
+		 * and if we ever try to split it, the VM_BUG_ON_PAGE will
+		 * be triggered in split_huge_page_to_list(). Skip these
+		 * pages by checking PageLRU because huge zero page isn't
+		 * lru page as non-lru compound movable pages.
+		 */
+		if (!PageLRU(hpage)) {
+			put_page(p);
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+			res = -EBUSY;
+			goto unlock_mutex;
+		}
 		/*
 		 * The flag must be set after the refcount is bumped
 		 * otherwise it may race with THP split.
-- 
2.23.0

