Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC25131E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiD1LBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbiD1LA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:00:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF272954B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:57:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kpsxm6d1Pz1JBKf;
        Thu, 28 Apr 2022 18:56:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 18:57:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/vmscan: use helper folio_is_file_lru()
Date:   Thu, 28 Apr 2022 18:58:02 +0800
Message-ID: <20220428105802.21389-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Use helper folio_is_file_lru() to check whether folio is file lru.  Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
Hi Andrew,
Please feel free to squash this into below patch:
https://lore.kernel.org/all/20220425111232.23182-7-linmiaohe@huawei.com/T/#u
Thanks!
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ecd74858b8d7..9ff3cc2a941a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1414,7 +1414,7 @@ static enum page_references folio_check_references(struct folio *folio,
 		/*
 		 * Activate file-backed executable folios after first usage.
 		 */
-		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
+		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
-- 
2.23.0

