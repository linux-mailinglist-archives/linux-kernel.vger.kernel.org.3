Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60C49C646
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiAZJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:26:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16740 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiAZJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:26:45 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JkJCr5n5GzZfJv;
        Wed, 26 Jan 2022 17:22:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 17:26:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/memremap: avoid calling kasan_remove_zero_shadow() for device private memory
Date:   Wed, 26 Jan 2022 17:26:02 +0800
Message-ID: <20220126092602.1425-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For device private memory, we do not create a linear mapping for the memory
because the device memory is un-accessible. Thus we do not add kasan zero
shadow for it. So it's unnecessary to do kasan_remove_zero_shadow() for it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index d2a72cf2ff83..d9e05952fff6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -302,7 +302,8 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	return 0;
 
 err_add_memory:
-	kasan_remove_zero_shadow(__va(range->start), range_len(range));
+	if (!is_private)
+		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 err_kasan:
 	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range));
 err_pfn_remap:
-- 
2.23.0

