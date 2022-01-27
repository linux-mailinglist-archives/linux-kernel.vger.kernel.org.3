Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD22C49DE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiA0JdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:33:05 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35878 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiA0JdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:33:04 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JkwNC6ctgzccHr;
        Thu, 27 Jan 2022 17:32:11 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 17:33:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/sparse: make mminit_validate_memmodel_limits() static
Date:   Thu, 27 Jan 2022 17:32:21 +0800
Message-ID: <20220127093221.63524-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used in the sparse.c now. So we can make it static and further
clean up the relevant code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/internal.h | 11 -----------
 mm/sparse.c   |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4c2d06a2f50b..927dfba5111f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -572,17 +572,6 @@ static inline void mminit_verify_zonelist(void)
 }
 #endif /* CONFIG_DEBUG_MEMORY_INIT */
 
-/* mminit_validate_memmodel_limits is independent of CONFIG_DEBUG_MEMORY_INIT */
-#if defined(CONFIG_SPARSEMEM)
-extern void mminit_validate_memmodel_limits(unsigned long *start_pfn,
-				unsigned long *end_pfn);
-#else
-static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
-				unsigned long *end_pfn)
-{
-}
-#endif /* CONFIG_SPARSEMEM */
-
 #define NODE_RECLAIM_NOSCAN	-2
 #define NODE_RECLAIM_FULL	-1
 #define NODE_RECLAIM_SOME	0
diff --git a/mm/sparse.c b/mm/sparse.c
index d21c6e5910d0..952f06d8f373 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -126,7 +126,7 @@ static inline int sparse_early_nid(struct mem_section *section)
 }
 
 /* Validate the physical addressing limitations of the model */
-void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
+static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
 	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
-- 
2.23.0

