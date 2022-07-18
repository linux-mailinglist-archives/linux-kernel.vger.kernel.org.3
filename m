Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAA578327
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiGRNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiGRNGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:06:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43FB27B29
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:06:14 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lmhx53Cc0zkWwB;
        Mon, 18 Jul 2022 21:03:53 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 21:06:12 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <cuigaosheng1@huawei.com>, <srinivas.kandagatla@linaro.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next] nvmem: node: using put_device to replace kfree_const
Date:   Mon, 18 Jul 2022 21:06:12 +0800
Message-ID: <20220718130612.3122982-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should never be touching the name pointer of a kobject
directly like this, the device structure itself should be
cleaning up the memory, not a kfree_const, so using put_device
to replace kfree_const.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/base/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..dd2c6089bed1 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -154,7 +154,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
 free_name:
-	kfree_const(dev->kobj.name);
+	put_device(&access_node->dev);
 free:
 	kfree(access_node);
 	return NULL;
-- 
2.25.1

