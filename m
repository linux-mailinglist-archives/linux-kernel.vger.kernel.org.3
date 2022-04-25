Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5D50DBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiDYI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiDYI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:59:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95C13D61
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:56:27 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmzQ66fxwzhYjN;
        Mon, 25 Apr 2022 16:56:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 16:56:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 16:56:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <will@kernel.org>, <joro@8bytes.org>, <alyssa@rosenzweig.io>,
        <sven@svenpeter.dev>
Subject: [PATCH] iommu/dart: check return value after calling platform_get_resource()
Date:   Mon, 25 Apr 2022 17:08:26 +0800
Message-ID: <20220425090826.2532165-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will cause null-ptr-deref in resource_size(), if platform_get_resource()
returns NULL, move calling resource_size() after devm_ioremap_resource() that
will check 'res' to avoid null-ptr-deref.
And use devm_platform_get_and_ioremap_resource() to simplify code.

Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/apple-dart.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad08..15b77f16cfa3 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -859,16 +859,15 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart->dev = dev;
 	spin_lock_init(&dart->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dart->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(dart->regs))
+		return PTR_ERR(dart->regs);
+
 	if (resource_size(res) < 0x4000) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
 
-	dart->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(dart->regs))
-		return PTR_ERR(dart->regs);
-
 	dart->irq = platform_get_irq(pdev, 0);
 	if (dart->irq < 0)
 		return -ENODEV;
-- 
2.25.1

