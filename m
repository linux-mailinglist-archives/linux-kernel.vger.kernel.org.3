Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B435751428E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354662AbiD2Gnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354650AbiD2Gnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D045B9F1B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqNCP0CRZzhYq6;
        Fri, 29 Apr 2022 14:40:17 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/9] mm/z3fold: fix possible null pointer dereferencing
Date:   Fri, 29 Apr 2022 14:40:44 +0800
Message-ID: <20220429064051.61552-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220429064051.61552-1-linmiaohe@huawei.com>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_slots could fail to allocate memory under heavy memory pressure. So
we should check zhdr->slots against NULL to avoid future null pointer
dereferencing.

Fixes: fc5488651c7d ("z3fold: simplify freeing slots")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index c2260f5a5885..5d8c21f2bc59 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -940,9 +940,19 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		}
 	}
 
-	if (zhdr && !zhdr->slots)
+	if (zhdr && !zhdr->slots) {
 		zhdr->slots = alloc_slots(pool, GFP_ATOMIC);
+		if (!zhdr->slots)
+			goto out_fail;
+	}
 	return zhdr;
+
+out_fail:
+	if (!kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
+		add_to_unbuddied(pool, zhdr);
+		z3fold_page_unlock(zhdr);
+	}
+	return NULL;
 }
 
 /*
-- 
2.23.0

