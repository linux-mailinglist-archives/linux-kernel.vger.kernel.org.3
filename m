Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B75551EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376276AbiFVRG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376949AbiFVRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE93EF30
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LSqVc69q5z1KC7l;
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
Subject: [PATCH 10/16] mm/huge_memory: check pmd_present first in is_huge_zero_pmd
Date:   Thu, 23 Jun 2022 01:06:21 +0800
Message-ID: <20220622170627.19786-11-linmiaohe@huawei.com>
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

When pmd is non-present, pmd_pfn returns an insane value. So we should
check pmd_present first to avoid acquiring such insane value and also
avoid touching possible cold huge_zero_pfn cache line when pmd isn't
present.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/huge_mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ae3d8e2fd9e2..12b297f9951d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -273,7 +273,7 @@ static inline bool is_huge_zero_page(struct page *page)
 
 static inline bool is_huge_zero_pmd(pmd_t pmd)
 {
-	return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
+	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
 static inline bool is_huge_zero_pud(pud_t pud)
-- 
2.23.0

