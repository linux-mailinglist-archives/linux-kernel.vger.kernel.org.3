Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755D254E254
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377096AbiFPNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiFPNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:46:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7365A37A2C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:46:25 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LP3K23sMNzSgvN;
        Thu, 16 Jun 2022 21:43:02 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 21:46:21 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 21:46:21 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <will@kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH 1/1] lockdep: pass curr_inner to print_lock_invalid_wait_context
Date:   Thu, 16 Jun 2022 13:40:42 +0000
Message-ID: <20220616134042.130002-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same information (task_wait_context(curr)) is printed twice.
curr_inner in check_wait_context is what we need.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 kernel/locking/lockdep.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 81e87280513e..2eb9802df7b9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4676,10 +4676,8 @@ static inline short task_wait_context(struct task_struct *curr)
 
 static int
 print_lock_invalid_wait_context(struct task_struct *curr,
-				struct held_lock *hlock)
+				struct held_lock *hlock, short curr_inner)
 {
-	short curr_inner;
-
 	if (!debug_locks_off())
 		return 0;
 	if (debug_locks_silent)
@@ -4695,9 +4693,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	print_lock(hlock);
 
 	pr_warn("other info that might help us debug this:\n");
-
-	curr_inner = task_wait_context(curr);
-	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
+	pr_warn("context-{%d:%d}\n", curr_inner, task_wait_context(curr));
 
 	lockdep_print_held_locks(curr);
 
@@ -4763,7 +4759,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	}
 
 	if (next_outer > curr_inner)
-		return print_lock_invalid_wait_context(curr, next);
+		return print_lock_invalid_wait_context(curr, next, curr_inner);
 
 	return 0;
 }
-- 
2.17.1

