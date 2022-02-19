Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1F4BC723
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiBSJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:27:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbiBSJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:26:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20DD24CCE1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:26:23 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K133m30jLzbbb9;
        Sat, 19 Feb 2022 17:21:56 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Feb
 2022 17:26:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 7/9] mm/z3fold: remove redundant list_del_init of zhdr->buddy in z3fold_free
Date:   Sat, 19 Feb 2022 17:25:31 +0800
Message-ID: <20220219092533.12596-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220219092533.12596-1-linmiaohe@huawei.com>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The do_compact_page will do list_del_init(&zhdr->buddy) for us. Remove this
extra one to save some possible cpu cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/z3fold.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 18a697f6fe32..867c590df027 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1244,9 +1244,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		return;
 	}
 	if (zhdr->cpu < 0 || !cpu_online(zhdr->cpu)) {
-		spin_lock(&pool->lock);
-		list_del_init(&zhdr->buddy);
-		spin_unlock(&pool->lock);
 		zhdr->cpu = -1;
 		kref_get(&zhdr->refcount);
 		clear_bit(PAGE_CLAIMED, &page->private);
-- 
2.23.0

