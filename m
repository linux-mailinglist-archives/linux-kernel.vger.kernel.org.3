Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42B53E00B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352325AbiFFDZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352317AbiFFDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:24:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD81C102
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:24:57 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LGf2z0V6bzjXDJ;
        Mon,  6 Jun 2022 11:23:39 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 11:24:56 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 11:24:55 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v3 3/3] mm/shmem: rework calculation of inflated_addr in shmem_get_unmapped_area
Date:   Mon, 6 Jun 2022 11:45:30 +0800
Message-ID: <20220606034530.153505-4-chenwandun@huawei.com>
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

In function shmem_get_unmapped_area, inflated_offset and offset
are unsigned long, it will result in underflow when offset below
inflated_offset, a little confusing, no functional change.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 48b7172f81d6..ac277b11bdfa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2200,9 +2200,12 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		return addr;
 
 	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
-	inflated_addr += offset - inflated_offset;
-	if (inflated_offset > offset)
+	if (offset > inflated_offset)
+		inflated_addr += offset - inflated_offset;
+	else if (offset < inflated_offset) {
+		inflated_addr -= inflated_offset - offset;
 		inflated_addr += HPAGE_PMD_SIZE;
+	}
 
 	if (inflated_addr > TASK_SIZE - len)
 		return addr;
-- 
2.25.1

