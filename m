Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094D0533832
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiEYISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEYISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:18:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5371D21E26
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:18:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7P4x2CjJzQkMh;
        Wed, 25 May 2022 16:15:13 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 16:18:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <songmuchun@bytedance.com>, <hch@lst.de>,
        <dhowells@redhat.com>, <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 1/4] mm: reduce the rcu lock duration
Date:   Wed, 25 May 2022 16:18:19 +0800
Message-ID: <20220525081822.53547-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220525081822.53547-1-linmiaohe@huawei.com>
References: <20220525081822.53547-1-linmiaohe@huawei.com>
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

Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
extends the period of the rcu_read_lock until after the permissions checks
are done to prevent the task pointed to from changing from under us. But
the task_struct refcount is also taken at that time, the reference to task
is guaranteed to be stable. So it's unnecessary to extend the period of
the rcu_read_lock. Release the rcu lock after task refcount is successfully
grabbed to reduce the rcu holding time.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
---
 mm/mempolicy.c | 3 +--
 mm/migrate.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0b4ba3ee810e..2dad094177bf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1609,6 +1609,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 		goto out;
 	}
 	get_task_struct(task);
+	rcu_read_unlock();
 
 	err = -EINVAL;
 
@@ -1617,11 +1618,9 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 	 * Use the regular "ptrace_may_access()" checks.
 	 */
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
-		rcu_read_unlock();
 		err = -EPERM;
 		goto out_put;
 	}
-	rcu_read_unlock();
 
 	task_nodes = cpuset_mems_allowed(task);
 	/* Is the user allowed to access the target nodes? */
diff --git a/mm/migrate.c b/mm/migrate.c
index e51588e95f57..e88ebb88fa6f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
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

