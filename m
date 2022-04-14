Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95B500C65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiDNLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiDNLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:51:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5320C86E01
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:49:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KfHkh1pZJzgYhR;
        Thu, 14 Apr 2022 19:47:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 19:49:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <shy828301@gmail.com>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 2/2] mm/memory-failure.c: dissolve truncated hugetlb page
Date:   Thu, 14 Apr 2022 19:49:41 +0800
Message-ID: <20220414114941.11223-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220414114941.11223-1-linmiaohe@huawei.com>
References: <20220414114941.11223-1-linmiaohe@huawei.com>
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

If me_huge_page meets a truncated but not yet freed hugepage, it won't be
dissolved even if we hold the last refcnt. It's because the hugepage has
NULL page_mapping while it's not anonymous hugepage too. Thus we lose the
last chance to dissolve it into buddy to save healthy subpages. Remove
PageAnon check to handle these hugepages too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 488aaca72340..1d64bfff339d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1041,12 +1041,11 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		res = MF_FAILED;
 		unlock_page(hpage);
 		/*
-		 * migration entry prevents later access on error anonymous
-		 * hugepage, so we can free and dissolve it into buddy to
-		 * save healthy subpages.
+		 * migration entry prevents later access on error hugepage,
+		 * so we can free and dissolve it into buddy to save healthy
+		 * subpages.
 		 */
-		if (PageAnon(hpage))
-			put_page(hpage);
+		put_page(hpage);
 		if (__page_handle_poison(p)) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
-- 
2.23.0

