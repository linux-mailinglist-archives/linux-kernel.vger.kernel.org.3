Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68357CBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiGUNRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiGUNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:16:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79457E005
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:16:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LpY2h2cDfzmV8l;
        Thu, 21 Jul 2022 21:15:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Jul
 2022 21:16:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] hugetlbfs: fix confusing hugetlbfs stat
Date:   Thu, 21 Jul 2022 21:16:37 +0800
Message-ID: <20220721131637.6306-6-linmiaohe@huawei.com>
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

When size option is not specified, f_blocks, f_bavail and f_bfree will be
set to -1 instead of 0. Likewise, when nr_inodes is not specified, f_files
and f_ffree will be set to -1 too. Check max_hpages and max_inodes against
-1 first to make sure 0 is reported for max/free/used when no limit is set
as the comment states.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 19fc62a9c2fe..44da9828e171 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1083,16 +1083,20 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		/* If no limits set, just report 0 for max/free/used
 		 * blocks, like simple_statfs() */
 		if (sbinfo->spool) {
-			long free_pages;
-
 			spin_lock_irq(&sbinfo->spool->lock);
-			buf->f_blocks = sbinfo->spool->max_hpages;
-			free_pages = sbinfo->spool->max_hpages
-				- sbinfo->spool->used_hpages;
-			buf->f_bavail = buf->f_bfree = free_pages;
+			if (sbinfo->spool->max_hpages != -1) {
+				long free_pages;
+
+				buf->f_blocks = sbinfo->spool->max_hpages;
+				free_pages = sbinfo->spool->max_hpages
+					     - sbinfo->spool->used_hpages;
+				buf->f_bavail = buf->f_bfree = free_pages;
+			}
 			spin_unlock_irq(&sbinfo->spool->lock);
-			buf->f_files = sbinfo->max_inodes;
-			buf->f_ffree = sbinfo->free_inodes;
+			if (sbinfo->max_inodes != -1) {
+				buf->f_files = sbinfo->max_inodes;
+				buf->f_ffree = sbinfo->free_inodes;
+			}
 		}
 		spin_unlock(&sbinfo->stat_lock);
 	}
-- 
2.23.0

