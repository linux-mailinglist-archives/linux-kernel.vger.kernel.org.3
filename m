Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2B53E007
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352362AbiFFDZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352307AbiFFDY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:24:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA634FC56
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:24:56 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LGf2N6NZ1z1K9GX;
        Mon,  6 Jun 2022 11:23:08 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 11:24:54 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 11:24:54 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v3 2/3] mm/shmem: return error code directly for invalid addr
Date:   Mon, 6 Jun 2022 11:45:29 +0800
Message-ID: <20220606034530.153505-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606034530.153505-1-chenwandun@huawei.com>
References: <20220606034530.153505-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error code directly for addr is not PAGE_SIZE aligned or
beyond TASK_SIZE, no need to check these cases in caller.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7419ab219b97..48b7172f81d6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2142,10 +2142,10 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		return addr;
 	if (IS_ERR_VALUE(addr))
 		return addr;
-	if (addr & ~PAGE_MASK)
-		return addr;
+	if (offset_in_page(addr))
+		return -EINVAL;
 	if (addr > TASK_SIZE - len)
-		return addr;
+		return -ENOMEM;
 
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return addr;
@@ -2196,7 +2196,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	inflated_addr = get_area(NULL, uaddr, inflated_len, 0, flags);
 	if (IS_ERR_VALUE(inflated_addr))
 		return addr;
-	if (inflated_addr & ~PAGE_MASK)
+	if (offset_in_page(inflated_addr))
 		return addr;
 
 	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
-- 
2.25.1

