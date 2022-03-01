Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61BA4C832F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiCAFfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiCAFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:35:13 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E770CF3;
        Mon, 28 Feb 2022 21:34:31 -0800 (PST)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 1 Mar 2022
 13:34:28 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH V3] tty: serial: meson: Fix the compile link error reported by kernel test robot
Date:   Tue, 1 Mar 2022 13:33:44 +0800
Message-ID: <20220301053344.29171-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describes the calculation of the UART baud rate clock using a clock
frame. Forgot to add in Kconfig kernel test Robot compilation error
due to COMMON_CLK dependency.

Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/Kconfig      |  1 +
 drivers/tty/serial/meson_uart.c | 37 +++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..a0f2b82fc18b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
 config SERIAL_MESON
 	tristate "Meson serial port support"
 	depends on ARCH_MESON || COMPILE_TEST
+	depends on COMMON_CLK
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Amlogic
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index bf6be5468aaf..972f210f3492 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -780,28 +780,37 @@ static int meson_uart_probe(struct platform_device *pdev)
 		return ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_out_clk_disable;
+	}
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
 
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err_out_clk_disable;
 	}
 
 	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
+	if (!port) {
+		ret = -ENOMEM;
+		goto err_out_clk_disable;
+	}
 
 	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
-	if (IS_ERR(port->membase))
-		return PTR_ERR(port->membase);
+	if (IS_ERR(port->membase)) {
+		ret = PTR_ERR(port->membase);
+		goto err_out_clk_disable;
+	}
 
 	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
 				    GFP_KERNEL);
-	if (!private_data)
-		return -ENOMEM;
+	if (!private_data) {
+		ret = -ENOMEM;
+		goto err_out_clk_disable;
+	}
 
 	if (device_get_match_data(&pdev->dev))
 		private_data->use_xtal_clk = true;
@@ -822,7 +831,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 
 	ret = meson_uart_probe_clocks(port);
 	if (ret)
-		return ret;
+		goto err_out_clk_disable;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
@@ -831,9 +840,15 @@ static int meson_uart_probe(struct platform_device *pdev)
 	meson_uart_reset(port);
 
 	ret = uart_add_one_port(&meson_uart_driver, port);
-	if (ret)
+	if (ret) {
 		meson_ports[pdev->id] = NULL;
+		goto err_out_clk_disable;
+	}
+
+	return 0;
 
+err_out_clk_disable:
+	clk_disable_unprepare(pclk);
 	return ret;
 }
 

base-commit: c2faf737abfb10f88f2d2612d573e9edc3c42c37
-- 
2.33.1

