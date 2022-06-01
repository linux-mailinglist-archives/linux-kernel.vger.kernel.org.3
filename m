Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9253A4D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350120AbiFAMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiFAMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:23:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD53B571
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:23:26 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LCpFs2319zDqWt;
        Wed,  1 Jun 2022 20:23:13 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 20:23:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 20:23:24 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH 2/4] mm/shmem: return -EINVAL for addr not PAGE_SIZE aligned
Date:   Wed, 1 Jun 2022 20:44:15 +0800
Message-ID: <20220601124417.2872001-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601124417.2872001-1-chenwandun@huawei.com>
References: <20220601124417.2872001-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

If addr is not PAGE_SIZE aligned, return -EINVAL directly.
Besides, use macro offset_in_page to check addr is not
PAGE_SIZE aligned case.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 80c361c3d82c..1136dd7da9e5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2143,8 +2143,8 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		return addr;
 	if (IS_ERR_VALUE(addr))
 		return addr;
-	if (addr & ~PAGE_MASK)
-		return addr;
+	if (offset_in_page(addr))
+		return -EINVAL;
 	if (addr > TASK_SIZE - len)
 		return addr;
 
@@ -2197,7 +2197,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	inflated_addr = get_area(NULL, uaddr, inflated_len, 0, flags);
 	if (IS_ERR_VALUE(inflated_addr))
 		return addr;
-	if (inflated_addr & ~PAGE_MASK)
+	if (offset_in_page(inflated_addr))
 		return addr;
 
 	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
-- 
2.25.1

