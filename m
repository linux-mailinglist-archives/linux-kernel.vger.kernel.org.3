Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4501E4E3D62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiCVLVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiCVLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:20:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A726DB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:19:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KN89F3CX6zfZ6x;
        Tue, 22 Mar 2022 19:17:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 19:19:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mremap: use helper mlock_future_check
Date:   Tue, 22 Mar 2022 19:20:04 +0800
Message-ID: <20220322112004.27380-1-linmiaohe@huawei.com>
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

Use helper mlock_future_check to check whether it's safe to resize the
locked_vm to simplify the code. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mremap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9d76da79594d..e776d4c2345c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -763,14 +763,8 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return ERR_PTR(-EFAULT);
 
-	if (vma->vm_flags & VM_LOCKED) {
-		unsigned long locked, lock_limit;
-		locked = mm->locked_vm << PAGE_SHIFT;
-		lock_limit = rlimit(RLIMIT_MEMLOCK);
-		locked += new_len - old_len;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
-			return ERR_PTR(-EAGAIN);
-	}
+	if (mlock_future_check(mm, vma->vm_flags, new_len - old_len))
+		return ERR_PTR(-EAGAIN);
 
 	if (!may_expand_vm(mm, vma->vm_flags,
 				(new_len - old_len) >> PAGE_SHIFT))
-- 
2.23.0

