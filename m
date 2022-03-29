Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD3B4EABFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiC2LPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiC2LPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:15:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761B3CFD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:13:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSRkw57JZzcZyX;
        Tue, 29 Mar 2022 19:13:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 19:13:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>
CC:     <kosaki.motohiro@jp.fujitsu.com>, <mgorman@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v4] mm/mempolicy: fix mpol_new leak in shared_policy_replace
Date:   Tue, 29 Mar 2022 19:14:16 +0800
Message-ID: <20220329111416.27954-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mpol_new is allocated but not used in restart loop, mpol_new will be
freed via mpol_put before returning to the caller.  But refcnt is not
initialized yet, so mpol_put could not do the right things and might leak
the unused mpol_new. This would happen if mempolicy was updated on the
shared shmem file while the sp->lock has been dropped during the memory
allocation.

This issue could be triggered easily with the below code snippet if there
are many processes doing the below work at the same time:

  shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
  shm = shmat(shmid, 0, 0);
  loop many times {
    mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
    mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
          maxnode, 0);
  }

Fixes: 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org> # 3.8
---
v3->v4:
  rebase on mainline.
v2->v3:
  enhance commit log and collect Acked-by tag per Michal Hocko. Thanks!
v1->v2:
  Add reproducer snippet and Cc stable.
  Thanks Michal Hocko for review and comment!
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a2516d31db6c..6b34c5d5e65a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
 	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
 	if (!mpol_new)
 		goto err_out;
+	atomic_set(&mpol_new->refcnt, 1);
 	goto restart;
 }
 
-- 
2.23.0

