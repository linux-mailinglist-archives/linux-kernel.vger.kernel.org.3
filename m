Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373FE51FDD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiEINTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiEINSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D72A83DD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxhSn6vskzhZ1x;
        Mon,  9 May 2022 21:13:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 14/15] mm/swap: fix the comment of get_kernel_pages
Date:   Mon, 9 May 2022 21:14:15 +0800
Message-ID: <20220509131416.17553-15-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

If no pages were pinned, 0 is returned in fact. Fix the corresponding
comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 6d2c37f781f8..236b37663a1a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -168,8 +168,8 @@ EXPORT_SYMBOL(put_pages_list);
  *
  * Returns number of pages pinned. This may be fewer than the number
  * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno. Each page returned must be released
- * with a put_page() call when it is finished with.
+ * were pinned, returns 0. Each page returned must be released with
+ * a put_page() call when it is finished with.
  */
 int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
 		struct page **pages)
-- 
2.23.0

