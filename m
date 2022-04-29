Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEA5143D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355554AbiD2ITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355551AbiD2ISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:18:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9DC3E0E;
        Fri, 29 Apr 2022 01:14:55 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqQHS6JzgzfbJv;
        Fri, 29 Apr 2022 16:13:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:14:50 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 16:14:49 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <geert+renesas@glider.be>
Subject: [PATCH 2/2] pinctrl: renesas: rzn1: fix possible null-ptr-deref in sh_pfc_map_resources()
Date:   Fri, 29 Apr 2022 16:26:37 +0800
Message-ID: <20220429082637.1308182-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429082637.1308182-1-yangyingliang@huawei.com>
References: <20220429082637.1308182-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pinctrl/renesas/pinctrl-rzn1.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index ef5fb25b6016..cddb7804e9e0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -865,17 +865,15 @@ static int rzn1_pinctrl_probe(struct platform_device *pdev)
 	ipctl->mdio_func[0] = -1;
 	ipctl->mdio_func[1] = -1;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ipctl->lev1_protect_phys = (u32)res->start + 0x400;
-	ipctl->lev1 = devm_ioremap_resource(&pdev->dev, res);
+	ipctl->lev1 = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ipctl->lev1))
 		return PTR_ERR(ipctl->lev1);
+	ipctl->lev1_protect_phys = (u32)res->start + 0x400;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ipctl->lev2_protect_phys = (u32)res->start + 0x400;
-	ipctl->lev2 = devm_ioremap_resource(&pdev->dev, res);
+	ipctl->lev2 = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ipctl->lev2))
 		return PTR_ERR(ipctl->lev2);
+	ipctl->lev2_protect_phys = (u32)res->start + 0x400;
 
 	ipctl->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ipctl->clk))
-- 
2.25.1

