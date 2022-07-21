Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD457CBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiGUNRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiGUNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:16:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E57658
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:16:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LpY1v10yQzkXGY;
        Thu, 21 Jul 2022 21:14:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Jul
 2022 21:16:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] hugetlbfs: cleanup some comments in inode.c
Date:   Thu, 21 Jul 2022 21:16:36 +0800
Message-ID: <20220721131637.6306-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220721131637.6306-1-linmiaohe@huawei.com>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
---
 fs/hugetlbfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index aa7a5b8fc724..19fc62a9c2fe 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -313,8 +313,8 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
 
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
- * data. Its *very* similar to generic_file_buffered_read(), we can't use that
- * since it has PAGE_SIZE assumptions.
+ * data. Its *very* similar to filemap_read(), we can't use that since it has
+ * PAGE_SIZE assumptions.
  */
 static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -1383,7 +1383,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
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

