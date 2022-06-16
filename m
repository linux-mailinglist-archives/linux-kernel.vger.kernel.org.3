Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0254E2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbiFPN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377431AbiFPN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:58:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439791A81B;
        Thu, 16 Jun 2022 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655387886; x=1686923886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ju4A9HIwXXampZCizRhHHBmfACjludeE+ouDKRJsveQ=;
  b=L2mdiMoi44VapIQqeGimbbor/bY1Uu82U9tEzG7dExVVcEzMUiUWFB/b
   uAZZZKWdp/AdTbAoZYK2z0ESUIjvMqV4k+2JzfpABPrDw/f3joIZr6NLY
   L07BX2jWuwHV8+p7Irn8CBIkcCon/ui8B/OBTt53YD5BAAWvTrfueweZo
   Q/+8WYw8xvGob0Ebg3wSQd3n4dyl3YXlWWxYxlNhQjSY/MdSST2hcoIW6
   BDP1bC18a6XwjkGsgkmw82EeAFT94QFbFO7KKJKEq0zCNcLVQAeBWpoUq
   JYqsky4/cZhHDV221+p/PM7WRT5Nw3/Olepaoy5jIFqbDrh+L94hZEHXJ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="168390679"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 06:58:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 06:58:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 06:58:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/4] tty: serial: atmel: use devm_clk_get()
Date:   Thu, 16 Jun 2022 17:00:22 +0300
Message-ID: <20220616140024.2081238-3-claudiu.beznea@microchip.com>
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

Use devm_clk_get() for serial clock instead of clk_get()/clk_put().
With this move the clk_get in driver's probe function.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 50 ++++++++++---------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c618d7e93058..4cec97fd7241 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2508,24 +2508,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
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
@@ -2896,14 +2879,23 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
@@ -2912,7 +2904,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 				     sizeof(struct atmel_uart_char),
 				     GFP_KERNEL);
 		if (!data)
-			goto err_alloc_ring;
+			goto err_clk_disable_unprepare;
 		atmel_port->rx_ring.buf = data;
 	}
 
@@ -2936,12 +2928,6 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
@@ -2965,12 +2951,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
@@ -3004,8 +2986,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	clear_bit(port->line, atmel_ports_in_use);
 
-	clk_put(atmel_port->clk);
-	atmel_port->clk = NULL;
 	pdev->dev.of_node = NULL;
 
 	return ret;
-- 
2.34.1

