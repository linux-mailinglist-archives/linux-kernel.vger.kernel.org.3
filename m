Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9751BBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352699AbiEEJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353176AbiEEJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:29:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD08C1AF1B;
        Thu,  5 May 2022 02:25:41 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kv7b201PbzfYv7;
        Thu,  5 May 2022 17:25:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 17:25:37 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 17:25:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <digetx@gmail.com>, <jonathanh@nvidia.com>, <treding@nvidia.com>
Subject: [PATCH] soc/tegra: fuse: fix possible null-ptr-deref in tegra_fuse_probe()
Date:   Thu, 5 May 2022 17:37:20 +0800
Message-ID: <20220505093720.1283942-1-yangyingliang@huawei.com>
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

It will cause null-ptr-deref when using 'res', if platform_get_resource()
returns NULL, so move using 'res' after devm_ioremap_resource() that
will check it to avoid null-ptr-deref.
And use devm_platform_get_and_ioremap_resource() to simplify code.

Fixes: 55a042b3f68f ("soc/tegra: fuse: Fix reading registers using DMA on Tegra20")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index aa94fda282f4..e85a78a80c48 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -218,13 +218,12 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		return err;
 
 	/* take over the memory region from the early initialization */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fuse->phys = res->start;
-	fuse->base = devm_ioremap_resource(&pdev->dev, res);
+	fuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(fuse->base)) {
 		err = PTR_ERR(fuse->base);
 		return err;
 	}
+	fuse->phys = res->start;
 
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->clk)) {
-- 
2.25.1

