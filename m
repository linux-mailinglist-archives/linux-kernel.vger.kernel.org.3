Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0995A365C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiH0Je2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiH0Je0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:34:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EF8305A;
        Sat, 27 Aug 2022 02:34:25 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MFBHt5QQ6zYcn5;
        Sat, 27 Aug 2022 17:30:02 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 17:34:15 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 17:34:15 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>
Subject: [PATCH -next 1/3] clk: sunxi-ng: sun8i-de2: Use dev_err_probe() helper
Date:   Sat, 27 Aug 2022 17:41:49 +0800
Message-ID: <20220827094151.3323450-1-yangyingliang@huawei.com>
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

dev_err() can be replace with dev_err_probe() which will check if error
code is -EPROBE_DEFER.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 2f6f02f00be2..b70b312e7483 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -256,29 +256,19 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(reg);
 
 	bus_clk = devm_clk_get(&pdev->dev, "bus");
-	if (IS_ERR(bus_clk)) {
-		ret = PTR_ERR(bus_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(bus_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(bus_clk),
+				     "Couldn't get bus clk\n");
 
 	mod_clk = devm_clk_get(&pdev->dev, "mod");
-	if (IS_ERR(mod_clk)) {
-		ret = PTR_ERR(mod_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Couldn't get mod clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mod_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mod_clk),
+				     "Couldn't get mod clk\n");
 
 	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"Couldn't get reset control: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
+				     "Couldn't get reset control\n");
 
 	/* The clocks need to be enabled for us to access the registers */
 	ret = clk_prepare_enable(bus_clk);
-- 
2.25.1

