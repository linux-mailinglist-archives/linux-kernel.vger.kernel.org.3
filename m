Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77EA5143C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355611AbiD2ISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355527AbiD2ISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:18:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E6C1C9C;
        Fri, 29 Apr 2022 01:14:52 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqQHQ3NmtzfbHJ;
        Fri, 29 Apr 2022 16:13:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:14:49 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 16:14:49 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <geert+renesas@glider.be>
Subject: [PATCH 1/2] pinctrl: renesas: fix possible null-ptr-deref in sh_pfc_map_resources()
Date:   Fri, 29 Apr 2022 16:26:36 +0800
Message-ID: <20220429082637.1308182-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Fixes: c7977ec4a336 ("pinctrl: sh-pfc: Convert to platform_get_*()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pinctrl/renesas/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index d0d4714731c1..3d8bf521c3e7 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -71,12 +71,11 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
 
 	/* Fill them. */
 	for (i = 0; i < num_windows; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		windows->phys = res->start;
-		windows->size = resource_size(res);
-		windows->virt = devm_ioremap_resource(pfc->dev, res);
+		windows->virt = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (IS_ERR(windows->virt))
 			return -ENOMEM;
+		windows->phys = res->start;
+		windows->size = resource_size(res);
 		windows++;
 	}
 	for (i = 0; i < num_irqs; i++)
-- 
2.25.1

