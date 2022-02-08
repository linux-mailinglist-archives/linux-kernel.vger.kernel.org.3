Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE34ADA41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359692AbiBHNmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiBHNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:42:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF8C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:42:32 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JtPLH49hJzccnp;
        Tue,  8 Feb 2022 21:41:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 21:42:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <kirill.shutemov@linux.intel.com>, <hannes@cmpxchg.org>,
        <agruenba@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] filemap: remove find_get_pages()
Date:   Tue, 8 Feb 2022 21:41:49 +0800
Message-ID: <20220208134149.47299-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

It's unused now. Remove it and clean up the relevant comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/pagemap.h |  7 -------
 mm/filemap.c            | 11 ++++++-----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 270bf5136c34..dc31eb981ea2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -594,13 +594,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
-static inline unsigned find_get_pages(struct address_space *mapping,
-			pgoff_t *start, unsigned int nr_pages,
-			struct page **pages)
-{
-	return find_get_pages_range(mapping, start, (pgoff_t)-1, nr_pages,
-				    pages);
-}
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d90bf9..90afe301cd52 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2229,8 +2229,9 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
  * @nr_pages:	The maximum number of pages
  * @pages:	Where the resulting pages are placed
  *
- * find_get_pages_contig() works exactly like find_get_pages(), except
- * that the returned number of pages are guaranteed to be contiguous.
+ * find_get_pages_contig() works exactly like find_get_pages_range(),
+ * except that the returned number of pages are guaranteed to be
+ * contiguous.
  *
  * Return: the number of pages which were found.
  */
@@ -2290,9 +2291,9 @@ EXPORT_SYMBOL(find_get_pages_contig);
  * @nr_pages:	the maximum number of pages
  * @pages:	where the resulting pages are placed
  *
- * Like find_get_pages(), except we only return head pages which are tagged
- * with @tag.  @index is updated to the index immediately after the last
- * page we return, ready for the next iteration.
+ * Like find_get_pages_range(), except we only return head pages which are
+ * tagged with @tag.  @index is updated to the index immediately after the
+ * last page we return, ready for the next iteration.
  *
  * Return: the number of pages which were found.
  */
-- 
2.23.0

