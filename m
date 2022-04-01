Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9634EE8D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiDAHK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiDAHKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:10:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80740103D9C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:08:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KVB6z1pghzgY7f;
        Fri,  1 Apr 2022 15:06:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:08:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <mel@csn.ul.ie>, <akpm@linux-foundation.org>,
        <minchan.kim@gmail.com>, <kamezawa.hiroyu@jp.fujitsu.com>,
        <kosaki.motohiro@jp.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] drivers/base/node.c: fix compaction sysfs file leak
Date:   Fri, 1 Apr 2022 15:09:05 +0800
Message-ID: <20220401070905.43679-1-linmiaohe@huawei.com>
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

Compaction sysfs file is created via compaction_register_node in
register_node. But we forgot to remove it in unregister_node. Thus
compaction sysfs file is leaked. Using compaction_unregister_node
to fix this issue.

Fixes: ed4a6d7f0676 ("mm: compaction: add /sys trigger for per-node memory compaction")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/base/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..0ac6376ef7a1 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -682,6 +682,7 @@ static int register_node(struct node *node, int num)
  */
 void unregister_node(struct node *node)
 {
+	compaction_unregister_node(node);
 	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
 	node_remove_accesses(node);
 	node_remove_caches(node);
-- 
2.23.0

