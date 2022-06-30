Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6A561D83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiF3OOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiF3ONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:13:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29FB3BBEF;
        Thu, 30 Jun 2022 06:59:31 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYfyt48lDzhYq0;
        Thu, 30 Jun 2022 21:57:10 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 21:59:28 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 21:59:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <geert+renesas@glider.be>,
        <peter@hurleysoftware.com>, <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 1/2] serial: sh-sci: fix missing sci_cleanup_single() in sci_probe_single()
Date:   Thu, 30 Jun 2022 22:09:18 +0800
Message-ID: <20220630140919.3857698-1-yangyingliang@huawei.com>
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

Add missing sci_cleanup_single() in error case in sci_probe_single()

Fixes: f907c9ea8835 ("serial: sh-sci: Add support for GPIO-controlled modem lines")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/sh-sci.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0075a1420005..ca5a58f01aff 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3283,25 +3283,31 @@ static int sci_probe_single(struct platform_device *dev,
 		return ret;
 
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
-	if (IS_ERR(sciport->gpios))
-		return PTR_ERR(sciport->gpios);
+	if (IS_ERR(sciport->gpios)) {
+		ret = PTR_ERR(sciport->gpios);
+		goto err_cleanup_single;
+	}
 
 	if (sciport->has_rtscts) {
 		if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
 		    mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
 			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_cleanup_single;
 		}
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
-	}
+	if (ret)
+		goto err_cleanup_single;
 
 	return 0;
+
+err_cleanup_single:
+	sci_cleanup_single(sciport);
+
+	return ret;
 }
 
 static int sci_probe(struct platform_device *dev)
-- 
2.25.1

