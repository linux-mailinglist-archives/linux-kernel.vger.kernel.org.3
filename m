Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB85432C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiFHOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbiFHOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:40:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5E14AF66
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:40:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJ8vH0Sv7zRjBF;
        Wed,  8 Jun 2022 22:37:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 22:40:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm() work as expected
Date:   Wed, 8 Jun 2022 22:40:29 +0800
Message-ID: <20220608144031.829-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220608144031.829-1-linmiaohe@huawei.com>
References: <20220608144031.829-1-linmiaohe@huawei.com>
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

security_vm_enough_memory_mm() checks whether a process has enough memory
to allocate a new virtual mapping. And total_swap_pages is considered as
available memory while swapoff tries to make sure there's enough memory
that can hold the swapped out memory. But total_swap_pages contains the
swap space that is being swapoff. So security_vm_enough_memory_mm() will
success even if there's no memory to hold the swapped out memory because
total_swap_pages always greater than or equal to p->pages.

In order to fix it, p->pages should be retracted from total_swap_pages
first and then check whether there's enough memory for inuse swap pages.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ec4c1b276691..d2bead7b8b70 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2398,6 +2398,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct filename *pathname;
 	int err, found = 0;
 	unsigned int old_block_size;
+	unsigned int inuse_pages;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2428,9 +2429,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
-	if (!security_vm_enough_memory_mm(current->mm, p->pages))
-		vm_unacct_memory(p->pages);
+
+	total_swap_pages -= p->pages;
+	inuse_pages = READ_ONCE(p->inuse_pages);
+	if (!security_vm_enough_memory_mm(current->mm, inuse_pages))
+		vm_unacct_memory(inuse_pages);
 	else {
+		total_swap_pages += p->pages;
 		err = -ENOMEM;
 		spin_unlock(&swap_lock);
 		goto out_dput;
@@ -2453,7 +2458,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	}
 	plist_del(&p->list, &swap_active_head);
 	atomic_long_sub(p->pages, &nr_swap_pages);
-	total_swap_pages -= p->pages;
 	p->flags &= ~SWP_WRITEOK;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
-- 
2.23.0

