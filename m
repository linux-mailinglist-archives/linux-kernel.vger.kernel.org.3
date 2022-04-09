Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084514FA687
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiDIJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiDIJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:36:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5457ABBE29
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:34:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb8zd0hbwzgYKZ;
        Sat,  9 Apr 2022 17:32:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 17:34:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <hch@infradead.org>, <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 5/9] mm/vmscan: activate swap-backed executable folios after first usage
Date:   Sat, 9 Apr 2022 17:34:56 +0800
Message-ID: <20220409093500.10329-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220409093500.10329-1-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

We should activate swap-backed executable folios (e.g. tmpfs) after first
usage so that executable code gets yet better chance to stay in memory.

Suggested-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0e5818970998..cc1193e320c2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1412,9 +1412,9 @@ static enum page_references folio_check_references(struct folio *folio,
 			return PAGEREF_ACTIVATE;
 
 		/*
-		 * Activate file-backed executable folios after first usage.
+		 * Activate executable folios after first usage.
 		 */
-		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
+		if (vm_flags & VM_EXEC)
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
-- 
2.23.0

