Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931D7575C25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiGOHLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiGOHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:11:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF4213
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:11:08 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LkjDK08K1zFpxR;
        Fri, 15 Jul 2022 15:10:08 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 15:11:06 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <cuigaosheng1@huawei.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <gongruiqi1@huawei.com>, <wangweiyang2@huawei.com>
Subject: [PATCH -next] mtd/ftl: Fix memleak in ftl_add_mtd()
Date:   Fri, 15 Jul 2022 15:11:05 +0800
Message-ID: <20220715071105.2321311-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add_mtd_blktrans_dev failed, partition's memory will be freed
by kfree, but there are some structure members that are allocated
for memory independently, such as partition->VirtualBlockMap,
partition->EUNInfo, partition->ZferInfo, and partition->bam_cache,
so kfree(partition) may cause memory leaks, using ftl_freepart(partition)
will fix it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/mtd/ftl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index f655d2905270..200271bdc7aa 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -1031,6 +1031,7 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 		partition->mbd.devnum = -1;
 		if (!add_mtd_blktrans_dev(&partition->mbd))
 			return;
+		ftl_freepart(partition);
 	}
 
 	kfree(partition);
-- 
2.25.1

