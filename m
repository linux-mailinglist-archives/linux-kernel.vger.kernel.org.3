Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F4535D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbiE0J0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbiE0J0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:26:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B960E0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:26:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8fXB4Q2Kz1JByS;
        Fri, 27 May 2022 17:24:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 27 May
 2022 17:26:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/3] mm/swapfile: avoid confusing swap cache statistics
Date:   Fri, 27 May 2022 17:26:25 +0800
Message-ID: <20220527092626.31883-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220527092626.31883-1-linmiaohe@huawei.com>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

At swapoff time, we're going to swap in the pages continuously. So calling
lookup_swap_cache would confuse statistics. We should use find_get_page
directly here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 960d14a4b19e..e033a53a99df 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1865,7 +1865,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		offset = swp_offset(entry);
 		pte_unmap(pte);
 		swap_map = &si->swap_map[offset];
-		page = lookup_swap_cache(entry, vma, addr);
+		/*
+		 * Since we're going to swap in the pages continuously,
+		 * calling lookup_swap_cache() would confuse statistics.
+		 */
+		page = find_get_page(swap_address_space(entry),
+				     swp_offset(entry));
 		if (!page) {
 			struct vm_fault vmf = {
 				.vma = vma,
-- 
2.23.0

