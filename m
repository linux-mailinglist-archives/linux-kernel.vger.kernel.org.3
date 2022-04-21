Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2E50A018
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386151AbiDUM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385925AbiDUM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:56:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743D32ED1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:53:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkcsR4zytzhXqs;
        Thu, 21 Apr 2022 20:53:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 20:53:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <david@redhat.com>, <apopple@nvidia.com>,
        <surenb@google.com>, <minchan@kernel.org>, <peterx@redhat.com>,
        <sfr@canb.auug.org.au>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/3] mm/madvise: free hwpoison and swapin error entry in madvise_free_pte_range
Date:   Thu, 21 Apr 2022 20:53:48 +0800
Message-ID: <20220421125348.62483-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220421125348.62483-1-linmiaohe@huawei.com>
References: <20220421125348.62483-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the MADV_FREE operation has succeeded, callers can expect they might
get zero-fill pages if accessing the memory again. Therefore it should be
safe to delete the hwpoison entry and swapin error entry. There is no
reason to kill the process if it has called MADV_FREE on the range.

Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/madvise.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4d6592488b51..5f4537511532 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -624,11 +624,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			swp_entry_t entry;
 
 			entry = pte_to_swp_entry(ptent);
-			if (non_swap_entry(entry))
-				continue;
-			nr_swap--;
-			free_swap_and_cache(entry);
-			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			if (!non_swap_entry(entry)) {
+				nr_swap--;
+				free_swap_and_cache(entry);
+				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			} else if (is_hwpoison_entry(entry) ||
+				   is_swapin_error_entry(entry)) {
+				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			}
 			continue;
 		}
 
-- 
2.23.0

