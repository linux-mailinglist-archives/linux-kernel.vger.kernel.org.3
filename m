Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43B535B22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiE0IFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbiE0IEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD8243EDE
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8ck25QBbzbbqP;
        Fri, 27 May 2022 16:03:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 27 May
 2022 16:04:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/vmscan: don't try to reclaim freed folios
Date:   Fri, 27 May 2022 16:04:51 +0800
Message-ID: <20220527080451.48549-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

If folios were freed from under us, there's no need to reclaim them. Skip
these folios to save lots of cpu cycles and avoid possible unnecessary
disk IO.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..646dd1efad32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1556,12 +1556,18 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		folio = lru_to_folio(page_list);
 		list_del(&folio->lru);
 
+		nr_pages = folio_nr_pages(folio);
+		if (folio_ref_count(folio) == 1) {
+			/* folio was freed from under us. So we are done. */
+			WARN_ON(!folio_put_testzero(folio));
+			goto free_it;
+		}
+
 		if (!folio_trylock(folio))
 			goto keep;
 
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
 
-		nr_pages = folio_nr_pages(folio);
 
 		/* Account the number of base pages */
 		sc->nr_scanned += nr_pages;
-- 
2.23.0

