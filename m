Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB439537A41
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiE3L6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiE3L6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:58:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD27CB2F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:58:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBYkk5XHjzRhVk;
        Mon, 30 May 2022 19:55:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 19:58:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/shmem.c: clean up comment of shmem_swapin_folio
Date:   Mon, 30 May 2022 19:58:41 +0800
Message-ID: <20220530115841.4348-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

shmem_swapin_folio has changed to use folio but comment still mentions
page. Update the relevant comment accordingly as suggested by Naoya.

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..12d45a03f7fc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1706,10 +1706,10 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 }
 
 /*
- * Swap in the page pointed to by *pagep.
- * Caller has to make sure that *pagep contains a valid swapped page.
- * Returns 0 and the page in pagep if success. On failure, returns the
- * error code and NULL in *pagep.
+ * Swap in the folio pointed to by *foliop.
+ * Caller has to make sure that *foliop contains a valid swapped folio.
+ * Returns 0 and the folio in foliop if success. On failure, returns the
+ * error code and NULL in *foliop.
  */
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			     struct folio **foliop, enum sgp_type sgp,
@@ -1749,7 +1749,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 	folio = page_folio(page);
 
-	/* We have to do this with page locked to prevent races */
+	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
 	    folio_swap_entry(folio).val != swap.val ||
-- 
2.23.0

