Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC95425B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiFHF2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiFHF1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:27:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D917A898;
        Tue,  7 Jun 2022 19:42:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHs1v036wzjcMK;
        Wed,  8 Jun 2022 10:41:55 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 10:42:52 +0800
Received: from huawei.com (10.174.176.88) by kwepemm600018.china.huawei.com
 (7.193.23.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 10:42:51 +0800
From:   gaochao <gaochao49@huawei.com>
To:     <alexs@kernel.org>, <sre@kernel.org>, <linus.walleij@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>
Subject: [PATCH v2 -next] power: supply: ab8500_fg: add missing destroy_workqueue in ab8500_fg_probe
Date:   Wed, 8 Jun 2022 10:42:49 +0800
Message-ID: <20220608024249.1075-1-gaochao49@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220607033328.1846-1-gaochao49@huawei.com>
References: <20220607033328.1846-1-gaochao49@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Chao <gaochao49@huawei.com>

In ab8500_fg_probe,  misses destroy_workqueue in error path,
this patch fixes that.

Fixes: 010ddb813f35 ("power: supply: ab8500_fg: Allocate wq in probe")
Signed-off-by: Gao Chao <gaochao49@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

v1->v2: add Reviewed-by Linus Walleij
---
 drivers/power/supply/ab8500_fg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index ec8a404d71b4..4339fa9ff009 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3148,6 +3148,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ret = ab8500_fg_init_hw_registers(di);
 	if (ret) {
 		dev_err(dev, "failed to initialize registers\n");
+		destroy_workqueue(di->fg_wq);
 		return ret;
 	}

@@ -3159,6 +3160,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	di->fg_psy = devm_power_supply_register(dev, &ab8500_fg_desc, &psy_cfg);
 	if (IS_ERR(di->fg_psy)) {
 		dev_err(dev, "failed to register FG psy\n");
+		destroy_workqueue(di->fg_wq);
 		return PTR_ERR(di->fg_psy);
 	}

@@ -3174,8 +3176,10 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* Register primary interrupt handlers */
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
-		if (irq < 0)
+		if (irq < 0) {
+			destroy_workqueue(di->fg_wq);
 			return irq;
+		}

 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				  ab8500_fg_irq[i].isr,
@@ -3185,6 +3189,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		if (ret != 0) {
 			dev_err(dev, "failed to request %s IRQ %d: %d\n",
 				ab8500_fg_irq[i].name, irq, ret);
+			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
 		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
@@ -3200,6 +3205,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ret = ab8500_fg_sysfs_init(di);
 	if (ret) {
 		dev_err(dev, "failed to create sysfs entry\n");
+		destroy_workqueue(di->fg_wq);
 		return ret;
 	}

@@ -3207,6 +3213,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to create FG psy\n");
 		ab8500_fg_sysfs_exit(di);
+		destroy_workqueue(di->fg_wq);
 		return ret;
 	}

--
2.17.1

