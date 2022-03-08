Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885904D197E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347254AbiCHNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiCHNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:45:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE649CA6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:44:07 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCc2r2LyJzdb1B;
        Tue,  8 Mar 2022 21:42:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:44:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 7/8] mm/z3fold: remove redundant list_del_init of zhdr->buddy in z3fold_free
Date:   Tue, 8 Mar 2022 21:43:10 +0800
Message-ID: <20220308134311.59086-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220308134311.59086-1-linmiaohe@huawei.com>
References: <20220308134311.59086-1-linmiaohe@huawei.com>
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

The do_compact_page will do list_del_init(&zhdr->buddy) for us. Remove this
extra one to save some possible cpu cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
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

