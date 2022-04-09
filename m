Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C594FA59F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiDIHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiDIHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:40:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05C14016
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:38:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb6P45dZyzDq5x;
        Sat,  9 Apr 2022 15:36:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 15:38:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <dave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/4] mm/migration: reduce the rcu lock duration
Date:   Sat, 9 Apr 2022 15:38:43 +0800
Message-ID: <20220409073846.22286-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220409073846.22286-1-linmiaohe@huawei.com>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
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

rcu_read_lock is required by grabbing the task refcount but it's not
needed for ptrace_may_access. So we could release the rcu lock after
task refcount is successfully grabbed to reduce the rcu holding time.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a3d8c2be2631..d8aae6c75990 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1907,17 +1907,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 		return ERR_PTR(-ESRCH);
 	}
 	get_task_struct(task);
+	rcu_read_unlock();
 
 	/*
 	 * Check if this process has the right to modify the specified
 	 * process. Use the regular "ptrace_may_access()" checks.
 	 */
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
-		rcu_read_unlock();
 		mm = ERR_PTR(-EPERM);
 		goto out;
 	}
-	rcu_read_unlock();
 
 	mm = ERR_PTR(security_task_movememory(task));
 	if (IS_ERR(mm))
-- 
2.23.0

