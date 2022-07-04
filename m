Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24D565427
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiGDLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGDLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:53:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186EDF33;
        Mon,  4 Jul 2022 04:53:55 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lc4025HqDzhYgg;
        Mon,  4 Jul 2022 19:51:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 19:53:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 19:53:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>
CC:     <mcgrof@kernel.org>
Subject: [PATCH -next] module: Use vzalloc() instead of vmalloc()/memset(0)
Date:   Mon, 4 Jul 2022 20:03:37 +0800
Message-ID: <20220704120337.4119910-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc() instead of vmalloc() and memset(0) to simpify the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/module/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..02b67abc448f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2138,7 +2138,7 @@ static int move_module(struct module *mod, struct load_info *info)
 
 #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 	/* Do the allocs. */
-	ptr = vmalloc(mod->data_layout.size);
+	ptr = vzalloc(mod->data_layout.size);
 	/*
 	 * The pointer to this block is stored in the module structure
 	 * which is inside the block. Just mark it as not being a
@@ -2151,7 +2151,6 @@ static int move_module(struct module *mod, struct load_info *info)
 		return -ENOMEM;
 	}
 
-	memset(ptr, 0, mod->data_layout.size);
 	mod->data_layout.base = ptr;
 #endif
 	/* Transfer each section which specifies SHF_ALLOC */
-- 
2.25.1

