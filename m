Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581F450FBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbiDZLaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiDZLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:30:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A242A2D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:27:15 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Knfcd2GYgzCs0Z;
        Tue, 26 Apr 2022 19:22:41 +0800 (CST)
Received: from linux-suspe12sp5.huawei.com (10.67.133.42) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:27:12 +0800
From:   liusongtang <liusongtang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <liusongtang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <young.liuyang@huawei.com>, <wangkefeng@huawei.com>
Subject: [PATCH] mm/mprotect: reduce Committed_AS if memory protection is changed to PROT_NONE
Date:   Tue, 26 Apr 2022 19:27:05 +0800
Message-ID: <20220426112705.3323-1-liusongtang@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.42]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PROT_WRITE is set, the size of vm area will be added to Committed_AS.
However, if memory protection is changed to PROT_NONE,
the corresponding physical memory will not be used, but Committed_AS still
count the size of the PROT_NONE memory.

This patch reduce Committed_AS and free the corresponding memory if
memory protection is changed to PROT_NONE.

Signed-off-by: liusongtang <liusongtang@huawei.com>
---
 mm/mprotect.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a..c3121e6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -497,6 +497,12 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	}
 
 success:
+	if ((newflags & (VM_READ | VM_WRITE | VM_EXEC | VM_LOCKED | VM_ACCOUNT)) == VM_ACCOUNT) {
+		zap_page_range(vma, start, end - start);
+		newflags &= ~VM_ACCOUNT;
+		vm_unacct_memory((end - start) >> PAGE_SHIFT);
+	}
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
-- 
2.12.3

