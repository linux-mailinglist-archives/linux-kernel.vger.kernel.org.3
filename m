Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3758153D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiGZO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbiGZO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:29:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D3624E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:29:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsfNy0G3Sz1M89Z;
        Tue, 26 Jul 2022 22:26:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 22:29:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 4/5] hugetlbfs: cleanup some comments in inode.c
Date:   Tue, 26 Jul 2022 22:29:17 +0800
Message-ID: <20220726142918.51693-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220726142918.51693-1-linmiaohe@huawei.com>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
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

The function generic_file_buffered_read has been renamed to filemap_read
since commit 87fa0f3eb267 ("mm/filemap: rename generic_file_buffered_read
to filemap_read"). Update the corresponding comment. And duplicated taken
in hugetlbfs_fill_super is removed.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index aa7a5b8fc724..96c60aa3ab47 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -313,8 +313,7 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
 
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
- * data. Its *very* similar to generic_file_buffered_read(), we can't use that
- * since it has PAGE_SIZE assumptions.
+ * data. This provides functionality similar to filemap_read().
  */
 static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -1383,7 +1382,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/*
 	 * Allocate and initialize subpool if maximum or minimum size is
 	 * specified.  Any needed reservations (for minimum size) are taken
-	 * taken when the subpool is created.
+	 * when the subpool is created.
 	 */
 	if (ctx->max_hpages != -1 || ctx->min_hpages != -1) {
 		sbinfo->spool = hugepage_new_subpool(ctx->hstate,
-- 
2.23.0

