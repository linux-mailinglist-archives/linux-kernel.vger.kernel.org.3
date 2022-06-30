Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A20561CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiF3OOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiF3ONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:13:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB013EAB8;
        Thu, 30 Jun 2022 06:59:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LYfyv32NDz1L8fD;
        Thu, 30 Jun 2022 21:57:11 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 21:59:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 21:59:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <geert+renesas@glider.be>,
        <peter@hurleysoftware.com>, <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 2/2] serial: sh-sci: fix missing uart_unregister_driver() in sci_probe_single()
Date:   Thu, 30 Jun 2022 22:09:19 +0800
Message-ID: <20220630140919.3857698-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630140919.3857698-1-yangyingliang@huawei.com>
References: <20220630140919.3857698-1-yangyingliang@huawei.com>
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

Add missing uart_unregister_driver() in error case in sci_probe_single().

Fixes: 352b92664549 ("serial: sh-sci: Move uart_register_driver call to device probe")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/sh-sci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ca5a58f01aff..08a249eaaa8c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3280,7 +3280,7 @@ static int sci_probe_single(struct platform_device *dev,
 
 	ret = sci_init_single(dev, sciport, index, p, false);
 	if (ret)
-		return ret;
+		goto err_unregister;
 
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios)) {
@@ -3306,6 +3306,10 @@ static int sci_probe_single(struct platform_device *dev,
 
 err_cleanup_single:
 	sci_cleanup_single(sciport);
+err_unregister:
+	mutex_lock(&sci_uart_registration_lock);
+	uart_unregister_driver(&sci_uart_driver);
+	mutex_unlock(&sci_uart_registration_lock);
 
 	return ret;
 }
-- 
2.25.1

