Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1144E2547
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiCULfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiCULfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:35:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B036168
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:33:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KMXXT2HJwzfZN2;
        Mon, 21 Mar 2022 19:32:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 19:33:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        <hughd@google.com>
CC:     <legion@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3] mm/mlock: fix two bugs in user_shm_lock()
Date:   Tue, 22 Mar 2022 16:09:18 +0800
Message-ID: <20220322080918.59861-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So the
later user_shm_unlock might do the extra dec_rlimit_ucounts. Also in the
RLIM_INFINITY case, user_shm_lock will success regardless of the value of
memlock where memblock == LONG_MAX && !capable(CAP_IPC_LOCK) should fail.
Fix all of these by changing the code to leave lock_limit at ULONG_MAX aka
RLIM_INFINITY, leave "allowed" initialized to 0 and remove the special case
of RLIM_INFINITY as nothing can be greater than ULONG_MAX.

Credit goes to Eric W. Biederman for proposing simplifying the code and
thus catching the later bug.

Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2->v3:
  simplify the code and fix another bug per Eric. Thanks Eric for discussion.
  drop Acked-by tag as the code changes. Sorry Hugh.
v1->v2:
  correct Fixes tag and collect Acked-by tag.
  Thanks Hugh for review!
---
 mm/mlock.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 25934e7db3e1..37f969ec68fa 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -827,13 +827,12 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 
 	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
-	if (lock_limit == RLIM_INFINITY)
-		allowed = 1;
-	lock_limit >>= PAGE_SHIFT;
+	if (lock_limit != RLIM_INFINITY)
+		lock_limit >>= PAGE_SHIFT;
 	spin_lock(&shmlock_user_lock);
 	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 
-	if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
+	if ((memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}
-- 
2.23.0

