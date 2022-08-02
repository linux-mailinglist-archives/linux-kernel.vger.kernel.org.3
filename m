Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B90587513
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiHBBdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHBBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:33:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78118EE0B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:33:19 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lxcpj4d2SzWf48;
        Tue,  2 Aug 2022 09:29:17 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 09:33:16 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 09:33:15 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <rppt@linux.vnet.ibm.com>, <hughd@google.com>,
        <aarcange@redhat.com>, <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <willy@infradead.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH stable 4.14,4.19 1/1] mm: Fix page counter mismatch in shmem_mfill_atomic_pte
Date:   Tue, 2 Aug 2022 09:32:51 +0800
Message-ID: <20220802013251.3022141-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

shmem_mfill_atomic_pte() wrongly called mem_cgroup_cancel_charge() in "success"
path, it should mem_cgroup_uncharge() to dec memory counter instead.
mem_cgroup_cancel_charge() should only be used if this transaction is
unsuccessful and mem_cgroup_uncharge() is used to do this if this transaction
succeed.

This will lead to page->memcg not null and will uncharge one more in put_page().
The page counter will underflow to maximum value and trigger oom to kill all
process include sshd and leave system unaccessible.

page->memcg is set in the following path:
mem_cgroup_commit_charge
	commit_charge
		page->mem_cgroup = memcg;

extra uncharge will be done in the following path:
put_page
	__put_page
		__put_single_page
			mem_cgroup_uncharge
				if (!page->mem_cgroup) <-- should return here
					return
				uncharge_page
				uncharge_batch

To fix this, call mem_cgroup_commit_charge() at the end of this transaction to
make sure this transaction is really finished.

Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0788616696dc..0b06724c189e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2339,8 +2339,6 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (ret)
 		goto out_release_uncharge;
 
-	mem_cgroup_commit_charge(page, memcg, false, false);
-
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
@@ -2366,6 +2364,8 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (!pte_none(*dst_pte))
 		goto out_release_uncharge_unlock;
 
+	mem_cgroup_commit_charge(page, memcg, false, false);
+
 	lru_cache_add_anon(page);
 
 	spin_lock_irq(&info->lock);
-- 
2.25.1

