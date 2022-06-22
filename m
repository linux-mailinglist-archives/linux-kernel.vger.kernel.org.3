Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1016A5551F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377122AbiFVRHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377037AbiFVRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED03F307
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSqWk2dxzzkWhM;
        Thu, 23 Jun 2022 01:05:22 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 16/16] mm/huge_memory: comment the subtle logic in __split_huge_pmd
Date:   Thu, 23 Jun 2022 01:06:27 +0800
Message-ID: <20220622170627.19786-17-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220622170627.19786-1-linmiaohe@huawei.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

It's dangerous and wrong to call page_folio(pmd_page(*pmd)) when pmd isn't
present. But the caller guarantees pmd is present when folio is set. So we
should be safe here. Add comment to make it clear.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8bd937cc1f74..b98b97592bd3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2234,6 +2234,10 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
 	    is_pmd_migration_entry(*pmd)) {
+		/*
+		 * It's safe to call pmd_page when folio is set because it's
+		 * guaranteed that pmd is present.
+		 */
 		if (folio && folio != page_folio(pmd_page(*pmd)))
 			goto out;
 		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
-- 
2.23.0

