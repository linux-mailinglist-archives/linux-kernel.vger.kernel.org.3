Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C154E2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377419AbiFPN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377379AbiFPN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:58:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D119C1B;
        Thu, 16 Jun 2022 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655387886; x=1686923886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfZ5DFdJl8ReyHkeNxi8ArYfDV2QwPpoPQqNBUZe2G0=;
  b=NYVfEeAmg+jP6Nz3z/nlX7uXgQu9bzfTRaW2jqji24c8SmjLL1Rv+aWc
   YmqORh113ihdZfLCtURRjBDxR/327Iq+W7F18qRu4ZYnSZTepomwPw4T2
   lNpBciLdmEbiCBWyI8U1vIYkr/1WuQXcZgQ05I7KVcrNGc4YdC1aywb7U
   xZ9AWOTcQV1sKF3gn1X5Hv0V3f3tnxRmw76TN6Wq79A8nZmm5bgvH9gGd
   AftK+mHSB8onp/q0QjVl8iidVyCMvcg6qF5c4Gxu9MRHalhdyxC+CHLAq
   wIuzIh9MIHrmdvbzNdgJTGgpzw7AoMAxZkaCTZRBslfg9080WsyFlIEEU
   A==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="100340829"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 06:58:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 06:58:01 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 06:57:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/4] tty: serial: atmel: stop using legacy pm ops
Date:   Thu, 16 Jun 2022 17:00:21 +0300
Message-ID: <20220616140024.2081238-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
References: <20220616140024.2081238-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using legacy PM ops and switch using dev_pm_ops. Along with
it #ifdef CONFIG_PM are removed and __maybe_unused and pm_ptr() used
instead. Coding style recommends (at chapter Conditional Compilation)
to avoid using preprocessor conditional and use __maybe_unused
instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 74dd1d3ac46f..c618d7e93058 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -166,7 +166,6 @@ struct atmel_uart_port {
 	unsigned int		fidi_min;
 	unsigned int		fidi_max;
 
-#ifdef CONFIG_PM
 	struct {
 		u32		cr;
 		u32		mr;
@@ -177,7 +176,6 @@ struct atmel_uart_port {
 		u32		fmr;
 		u32		fimr;
 	} cache;
-#endif
 
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
@@ -2718,7 +2716,6 @@ static struct uart_driver atmel_uart = {
 	.cons		= ATMEL_CONSOLE_DEVICE,
 };
 
-#ifdef CONFIG_PM
 static bool atmel_serial_clk_will_stop(void)
 {
 #ifdef CONFIG_ARCH_AT91
@@ -2728,10 +2725,9 @@ static bool atmel_serial_clk_will_stop(void)
 #endif
 }
 
-static int atmel_serial_suspend(struct platform_device *pdev,
-				pm_message_t state)
+static int __maybe_unused atmel_serial_suspend(struct device *dev)
 {
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
 	if (uart_console(port) && console_suspend_enabled) {
@@ -2756,14 +2752,14 @@ static int atmel_serial_suspend(struct platform_device *pdev,
 	}
 
 	/* we can not wake up if we're running on slow clock */
-	atmel_port->may_wakeup = device_may_wakeup(&pdev->dev);
+	atmel_port->may_wakeup = device_may_wakeup(dev);
 	if (atmel_serial_clk_will_stop()) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atmel_port->lock_suspended, flags);
 		atmel_port->suspended = true;
 		spin_unlock_irqrestore(&atmel_port->lock_suspended, flags);
-		device_set_wakeup_enable(&pdev->dev, 0);
+		device_set_wakeup_enable(dev, 0);
 	}
 
 	uart_suspend_port(&atmel_uart, port);
@@ -2771,9 +2767,9 @@ static int atmel_serial_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int atmel_serial_resume(struct platform_device *pdev)
+static int __maybe_unused atmel_serial_resume(struct device *dev)
 {
-	struct uart_port *port = platform_get_drvdata(pdev);
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
 
@@ -2808,14 +2804,10 @@ static int atmel_serial_resume(struct platform_device *pdev)
 	spin_unlock_irqrestore(&atmel_port->lock_suspended, flags);
 
 	uart_resume_port(&atmel_uart, port);
-	device_set_wakeup_enable(&pdev->dev, atmel_port->may_wakeup);
+	device_set_wakeup_enable(dev, atmel_port->may_wakeup);
 
 	return 0;
 }
-#else
-#define atmel_serial_suspend NULL
-#define atmel_serial_resume NULL
-#endif
 
 static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
 				     struct platform_device *pdev)
@@ -3019,14 +3011,16 @@ static int atmel_serial_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
+			 atmel_serial_resume);
+
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
 	.remove		= atmel_serial_remove,
-	.suspend	= atmel_serial_suspend,
-	.resume		= atmel_serial_resume,
 	.driver		= {
 		.name			= "atmel_usart_serial",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
+		.pm			= pm_ptr(&atmel_serial_pm_ops),
 	},
 };
 
-- 
2.34.1

