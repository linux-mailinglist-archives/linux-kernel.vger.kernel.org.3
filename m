Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712385551EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377091AbiFVRHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376945AbiFVRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A573EF28
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LSqVc34nyz1KC7g;
        Thu, 23 Jun 2022 01:04:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 09/16] mm/huge_memory: fix comment in zap_huge_pud
Date:   Thu, 23 Jun 2022 01:06:20 +0800
Message-ID: <20220622170627.19786-10-linmiaohe@huawei.com>
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

The comment about deposited pgtable is borrowed from zap_huge_pmd but
there's no deposited pgtable stuff for huge pud in zap_huge_pud. Remove
it to avoid confusion.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b42c8fa51e46..fd12fa930937 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1914,12 +1914,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
-	/*
-	 * For architectures like ppc64 we look at deposited pgtable
-	 * when calling pudp_huge_get_and_clear. So do the
-	 * pgtable_trans_huge_withdraw after finishing pudp related
-	 * operations.
-	 */
+
 	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_special_huge(vma)) {
-- 
2.23.0

