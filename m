Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04065533DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbiEYNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244410AbiEYNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:35:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D9560056;
        Wed, 25 May 2022 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653485715; x=1685021715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLgZ0yB06QQZ2lI3Zt3B2VoPF15ZFHz0VMP9TLdbSQg=;
  b=RpQnwQz4i7OTcH5hK+Tr7VVI0mWBvj4W/pdDPDCVaqvm0xP+iCQhfJ07
   W0jfsX43HAH+K0+1r3lwpnuXHmduvTmK1PBDQdx91SADCraGsPL67Bliq
   ak4lyV72FwMEqMW0WS6nCCYqR7qE/+DIBA1DS+6uMeG+pdkgP3DChitLo
   hIRbslEu+1o/SnZEfKcwcjq93IXF/4hODMZyakpS+Yh5OsJwQLac/G8OG
   1bYLdHbr36vzqB9LdGCb0LCzmN1Zko6MvrtMyp5ybCvvyUGd7L1wvhu8J
   ZLLVpDuo6F5mN9b+nayXahAHB8/tS6TdOAThahXqwf39xDoCXMBv+hHUx
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="165289161"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2022 06:35:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 25 May 2022 06:35:13 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 25 May 2022 06:35:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] tty: serial: atmel: improve clock management
Date:   Wed, 25 May 2022 16:37:32 +0300
Message-ID: <20220525133733.1051714-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel_port->clk was requested in atmel_init_port() (which is called only
on probe path) only if atmel_port->clk was NULL. But atmel_port->clk is
NULL on probing path. Thus don't check this. Along with this the clock is
now requested with devm_clk_get() and the clock request has been moved in
atmel_serial_probe() function to avoid disabling/re-enabling it on probe
path for multiple times. All the checks of atmel_port->clk were removed
along with clk_put() and atmel_port->clk = NULL. Now, on probing time the
clock is enabled at the beginning and disabled at the end of probe. As
atmel_console_setup() is called in the middle of probe and clock is
already enabled at that time the clk_prepare_enable() in
atmel_console_setup() has also been removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 65 +++++++------------------------
 1 file changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5c793a23dc54..2955b1012014 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2501,24 +2501,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	if (ret)
 		return ret;
 
-	/* for console, the clock could already be configured */
-	if (!atmel_port->clk) {
-		atmel_port->clk = clk_get(&mpdev->dev, "usart");
-		if (IS_ERR(atmel_port->clk)) {
-			ret = PTR_ERR(atmel_port->clk);
-			atmel_port->clk = NULL;
-			return ret;
-		}
-		ret = clk_prepare_enable(atmel_port->clk);
-		if (ret) {
-			clk_put(atmel_port->clk);
-			atmel_port->clk = NULL;
-			return ret;
-		}
-		port->uartclk = clk_get_rate(atmel_port->clk);
-		clk_disable_unprepare(atmel_port->clk);
-		/* only enable clock when USART is in use */
-	}
+	port->uartclk = clk_get_rate(atmel_port->clk);
 
 	/*
 	 * Use TXEMPTY for interrupt when rs485 or ISO7816 else TXRDY or
@@ -2640,10 +2623,6 @@ static int __init atmel_console_setup(struct console *co, char *options)
 		return -ENODEV;
 	}
 
-	ret = clk_prepare_enable(atmel_ports[co->index].clk);
-	if (ret)
-		return ret;
-
 	atmel_uart_writel(port, ATMEL_US_IDR, -1);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
@@ -2889,14 +2868,23 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	atomic_set(&atmel_port->tasklet_shutdown, 0);
 	spin_lock_init(&atmel_port->lock_suspended);
 
+	atmel_port->clk = devm_clk_get(&pdev->dev, "usart");
+	if (IS_ERR(atmel_port->clk)) {
+		ret = PTR_ERR(atmel_port->clk);
+		goto err;
+	}
+	ret = clk_prepare_enable(atmel_port->clk);
+	if (ret)
+		goto err;
+
 	ret = atmel_init_port(atmel_port, pdev);
 	if (ret)
-		goto err_clear_bit;
+		goto err_clk_disable_unprepare;
 
 	atmel_port->gpios = mctrl_gpio_init(&atmel_port->uart, 0);
 	if (IS_ERR(atmel_port->gpios)) {
 		ret = PTR_ERR(atmel_port->gpios);
-		goto err_clear_bit;
+		goto err_clk_disable_unprepare;
 	}
 
 	if (!atmel_use_pdc_rx(&atmel_port->uart)) {
@@ -2905,7 +2893,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 				     sizeof(struct atmel_uart_char),
 				     GFP_KERNEL);
 		if (!data)
-			goto err_alloc_ring;
+			goto err_clk_disable_unprepare;
 		atmel_port->rx_ring.buf = data;
 	}
 
@@ -2915,26 +2903,9 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_port;
 
-#ifdef CONFIG_SERIAL_ATMEL_CONSOLE
-	if (uart_console(&atmel_port->uart)
-			&& ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
-		/*
-		 * The serial core enabled the clock for us, so undo
-		 * the clk_prepare_enable() in atmel_console_setup()
-		 */
-		clk_disable_unprepare(atmel_port->clk);
-	}
-#endif
-
 	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, atmel_port);
 
-	/*
-	 * The peripheral clock has been disabled by atmel_init_port():
-	 * enable it before accessing I/O registers
-	 */
-	clk_prepare_enable(atmel_port->clk);
-
 	if (rs485_enabled) {
 		atmel_uart_writel(&atmel_port->uart, ATMEL_US_MR,
 				  ATMEL_US_USMODE_NORMAL);
@@ -2958,12 +2929,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 err_add_port:
 	kfree(atmel_port->rx_ring.buf);
 	atmel_port->rx_ring.buf = NULL;
-err_alloc_ring:
-	if (!uart_console(&atmel_port->uart)) {
-		clk_put(atmel_port->clk);
-		atmel_port->clk = NULL;
-	}
-err_clear_bit:
+err_clk_disable_unprepare:
+	clk_disable_unprepare(atmel_port->clk);
 	clear_bit(atmel_port->uart.line, atmel_ports_in_use);
 err:
 	return ret;
@@ -2997,8 +2964,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	clear_bit(port->line, atmel_ports_in_use);
 
-	clk_put(atmel_port->clk);
-	atmel_port->clk = NULL;
 	pdev->dev.of_node = NULL;
 
 	return ret;
-- 
2.34.1

