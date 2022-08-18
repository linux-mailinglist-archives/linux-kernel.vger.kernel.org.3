Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE359839D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244858AbiHRNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbiHRNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:00:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1303659C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:00:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M7lKC5p4Zz1N7NB;
        Thu, 18 Aug 2022 20:57:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 21:00:41 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/6] mm, hwpoison: fix page refcnt leaking in unpoison_memory()
Date:   Thu, 18 Aug 2022 21:00:12 +0800
Message-ID: <20220818130016.45313-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220818130016.45313-1-linmiaohe@huawei.com>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

When free_raw_hwp_pages() fails its work, the refcnt of the hugetlb page
would have been incremented if ret > 0. Using put_page() to fix refcnt
leaking in this case.

Fixes: debb6b9c3fdd ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 22840cd5fe59..0c5ad7505b99 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2378,6 +2378,7 @@ int unpoison_memory(unsigned long pfn)
 			count = free_raw_hwp_pages(page, false);
 			if (count == 0) {
 				ret = -EBUSY;
+				put_page(page);
 				goto unlock_mutex;
 			}
 		}
-- 
2.23.0

