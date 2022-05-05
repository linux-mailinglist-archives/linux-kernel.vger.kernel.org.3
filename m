Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756751BF85
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbiEEMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbiEEMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:38:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05BC5520D;
        Thu,  5 May 2022 05:34:39 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KvCh50J3ZzHnV3;
        Thu,  5 May 2022 20:29:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 20:34:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 20:34:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <baruch@tkos.co.il>
Subject: [PATCH] tty/serial: digicolor: fix possible null-ptr-deref in digicolor_uart_probe()
Date:   Thu, 5 May 2022 20:46:21 +0800
Message-ID: <20220505124621.1592697-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Fixes: 5930cb3511df ("serial: driver for Conexant Digicolor USART")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/digicolor-usart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 6d70fea76bb3..e37a917b9dbb 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -471,11 +471,10 @@ static int digicolor_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(uart_clk))
 		return PTR_ERR(uart_clk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dp->port.mapbase = res->start;
-	dp->port.membase = devm_ioremap_resource(&pdev->dev, res);
+	dp->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(dp->port.membase))
 		return PTR_ERR(dp->port.membase);
+	dp->port.mapbase = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.25.1

