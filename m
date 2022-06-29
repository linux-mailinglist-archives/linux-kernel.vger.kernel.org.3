Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3481A560009
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiF2Mey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiF2Mew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:34:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72311255A0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:34:46 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LY16B6BK8zTgCQ;
        Wed, 29 Jun 2022 20:31:14 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 20:34:45 +0800
Received: from huawei.com (10.175.101.6) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 20:34:44 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next,v2] tmpfs: Fix the issue that the mount and remount results are inconsistent.
Date:   Wed, 29 Jun 2022 20:43:24 +0800
Message-ID: <20220629124324.1640807-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An undefined-behavior issue has not been completely fixed since commit
d14f5efadd84 ("tmpfs: fix undefined-behaviour in shmem_reconfigure()").
In the commit, check in the shmem_reconfigure() is added in remount
process to avoid the Ubsan problem. However, the check is not added to
the mount process.It cause the inconsistent results between mount
and remount. The operations to reproduce the problem in user mode
as follow:

If nr_blocks is set to 0x8000000000000000, the mounting is successful.

  # mount tmpfs /dev/shm/ -t tmpfs -o nr_blocks=0x8000000000000000

However, when -o remount is used, the mount fails because of the
check in the shmem_reconfigure()

  # mount tmpfs /dev/shm/ -t tmpfs -o remount,nr_blocks=0x8000000000000000
  mount: /dev/shm: mount point not mounted or bad option.

Therefore, add checks in the shmem_parse_one() function and remove the
check in shmem_reconfigure() to avoid this problem.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 mm/shmem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..b7f2d4a56867 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3392,7 +3392,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_nr_blocks:
 		ctx->blocks = memparse(param->string, &rest);
-		if (*rest)
+		if (*rest || ctx->blocks > S64_MAX)
 			goto bad_value;
 		ctx->seen |= SHMEM_SEEN_BLOCKS;
 		break;
@@ -3514,10 +3514,7 @@ static int shmem_reconfigure(struct fs_context *fc)
 
 	raw_spin_lock(&sbinfo->stat_lock);
 	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
-	if (ctx->blocks > S64_MAX) {
-		err = "Number of blocks too large";
-		goto out;
-	}
+
 	if ((ctx->seen & SHMEM_SEEN_BLOCKS) && ctx->blocks) {
 		if (!sbinfo->max_blocks) {
 			err = "Cannot retroactively limit size";
-- 
2.31.1

