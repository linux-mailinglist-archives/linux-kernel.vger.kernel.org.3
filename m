Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595B4B9BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiBQJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiBQJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:17:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93F1592AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:16:53 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jzpxm1jKrzZfgW;
        Thu, 17 Feb 2022 17:12:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 17:16:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/slab_common: use helper function is_power_of_2()
Date:   Thu, 17 Feb 2022 17:16:09 +0800
Message-ID: <20220217091609.8214-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Use helper function is_power_of_2() to check if KMALLOC_MIN_SIZE is power
of two. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23f2ab0713b7..6ee64d6208b3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -807,7 +807,7 @@ void __init setup_kmalloc_cache_index_table(void)
 	unsigned int i;
 
 	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 256 ||
-		(KMALLOC_MIN_SIZE & (KMALLOC_MIN_SIZE - 1)));
+		!is_power_of_2(KMALLOC_MIN_SIZE));
 
 	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
 		unsigned int elem = size_index_elem(i);
-- 
2.23.0

