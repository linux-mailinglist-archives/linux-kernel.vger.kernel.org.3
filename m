Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4A50EEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbiDZDAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiDZDAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:00:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36E3B017
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:56:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnRNr12hFzhYhx;
        Tue, 26 Apr 2022 10:56:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 10:56:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 10:56:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <nsekhar@ti.com>, <arnd@arndb.de>
Subject: [PATCH] mfd: davinci_voicecodec: fix possible null-ptr-deref davinci_vc_probe()
Date:   Tue, 26 Apr 2022 11:08:57 +0800
Message-ID: <20220426030857.3539336-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will cause null-ptr-deref when using 'res', if platform_get_resource()
returns NULL, so move using 'res' after devm_ioremap_resource() that
will check it to avoid null-ptr-deref.
And use devm_platform_get_and_ioremap_resource() to simplify code.

Fixes: b5e29aa880be ("mfd: davinci_voicecodec: Remove pointless #include")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mfd/davinci_voicecodec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index e5c8bc998eb4..965820481f1e 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -46,14 +46,12 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	}
 	clk_enable(davinci_vc->clk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	fifo_base = (dma_addr_t)res->start;
-	davinci_vc->base = devm_ioremap_resource(&pdev->dev, res);
+	davinci_vc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(davinci_vc->base)) {
 		ret = PTR_ERR(davinci_vc->base);
 		goto fail;
 	}
+	fifo_base = (dma_addr_t)res->start;
 
 	davinci_vc->regmap = devm_regmap_init_mmio(&pdev->dev,
 						   davinci_vc->base,
-- 
2.25.1

