Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539D84B9E61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiBQLLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiBQLLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:11:04 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9258929691E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:10:42 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JzsT561Ycz1FDG5;
        Thu, 17 Feb 2022 19:06:17 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 19:10:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mmu_notifiers: use helper function mmu_notifier_synchronize()
Date:   Thu, 17 Feb 2022 19:09:48 +0800
Message-ID: <20220217110948.35477-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Use helper function mmu_notifier_synchronize() to ensure all mmu_notifiers
are freed. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mmu_notifier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 459d195d2ff6..159f70c20236 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -334,15 +334,15 @@ static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
 	srcu_read_unlock(&srcu, id);
 
 	/*
-	 * synchronize_srcu here prevents mmu_notifier_release from returning to
-	 * exit_mmap (which would proceed with freeing all pages in the mm)
-	 * until the ->release method returns, if it was invoked by
-	 * mmu_notifier_unregister.
+	 * mmu_notifier_synchronize here prevents mmu_notifier_release from
+	 * returning to exit_mmap (which would proceed with freeing all pages
+	 * in the mm) until the ->release method returns, if it was invoked
+	 * by mmu_notifier_unregister.
 	 *
 	 * The notifier_subscriptions can't go away from under us because
 	 * one mm_count is held by exit_mmap.
 	 */
-	synchronize_srcu(&srcu);
+	mmu_notifier_synchronize();
 }
 
 void __mmu_notifier_release(struct mm_struct *mm)
@@ -851,7 +851,7 @@ void mmu_notifier_unregister(struct mmu_notifier *subscription,
 	 * Wait for any running method to finish, of course including
 	 * ->release if it was run by mmu_notifier_release instead of us.
 	 */
-	synchronize_srcu(&srcu);
+	mmu_notifier_synchronize();
 
 	BUG_ON(atomic_read(&mm->mm_count) <= 0);
 
-- 
2.23.0

