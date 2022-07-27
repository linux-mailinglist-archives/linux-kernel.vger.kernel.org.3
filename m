Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2103F58206B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiG0GuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiG0Gth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:49:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C6481DC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:46:46 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lt46H2WnTz9sy9;
        Wed, 27 Jul 2022 14:45:27 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:46:36 +0800
Received: from huawei.com (10.175.112.125) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 14:46:35 +0800
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
To:     <willy@infradead.org>, <dhowells@redhat.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhangxiaoxu5@huawei.com>, <liuyongqiang13@huawei.com>,
        <yanaijie@huawei.com>, <vbabka@suse.cz>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/folio-compact: fix potential NULL pointer in pagecache_get_page
Date:   Wed, 27 Jul 2022 06:46:21 +0000
Message-ID: <20220727064621.534528-1-liuyongqiang13@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __filemap_get_folio() failed and returned NULL, we would
get a NULL pointer dereference in pagecache_get_page.

Fixes: 3f0c6a07fee6 ("mm/filemap: Add filemap_get_folio")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: <stable@vger.kernel.org> # 5.16
---
 mm/folio-compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 20bc15b57d93..7b21393480e0 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -124,7 +124,9 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
-	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+	if (!folio)
+		return NULL;
+	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
 		return &folio->page;
 	return folio_file_page(folio, index);
 }
-- 
2.25.1

