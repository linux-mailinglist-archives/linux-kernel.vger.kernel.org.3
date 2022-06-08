Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F410054324C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiFHOOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiFHOOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:14:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D6713D38
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:14:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJ8MP3Cz8zQjBn;
        Wed,  8 Jun 2022 22:13:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 22:14:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/vmscan: don't try to reclaim freed folios
Date:   Wed, 8 Jun 2022 22:14:32 +0800
Message-ID: <20220608141432.23258-1-linmiaohe@huawei.com>
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
disk I/O.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2:
  use folio_ref_freeze to guard against race with GUP (fast). Many thanks
  Matthew for pointing this out.
---
 mm/vmscan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 13d34d9593bb..547ae7ae6ab1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1610,13 +1610,19 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		folio = lru_to_folio(page_list);
 		list_del(&folio->lru);
 
+		nr_pages = folio_nr_pages(folio);
+
+		if (folio_ref_count(folio) == 1 &&
+		    folio_ref_freeze(folio, 1)) {
+			/* folio was freed from under us. So we are done. */
+			goto free_it;
+		}
+
 		if (!folio_trylock(folio))
 			goto keep;
 
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
 
-		nr_pages = folio_nr_pages(folio);
-
 		/* Account the number of base pages */
 		sc->nr_scanned += nr_pages;
 
-- 
2.23.0

