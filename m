Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54054E2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377434AbiFPN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377439AbiFPN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:58:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6B237E8;
        Thu, 16 Jun 2022 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655387888; x=1686923888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iIYJWJmShwNGkYNuXD5wNnHd+SQL3c/U0f/z+4+WjXc=;
  b=sf6LgQMW6DVvKIeoBPM59bZh2GEOR3UmG2kzWZEy7vXxQMtH5g/1bVCB
   uYgoYSZlbKJRYaYeGaGLPJMmv8k5gEO+pfQTg1U0MCAKYY69hdeyyckKi
   Ym36ZdzNjKqvftNuGrrNwJFVWF/OI5p/7+n0sj7mVb/cw7Mx0V634244J
   z0D0+EOTl7jgQ7q2iWIO0u8JU1Cc1/neAr8+9kbuoimAKllyfzsJdCHal
   CBavh4O6DsRwgVQN4njLs6XVChrOq+aY0N1IXyNokCNubMGN/xfHnTEuh
   W7kAM2Z3b4LMfXRQK1ne/k178v+Lis9E76u2aCf2ivUuXDmezXFkaAY8I
   g==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="100340842"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 06:58:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 06:58:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 06:58:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/4] tty: serial: atmel: remove enable/disable clock due to atmel_console_setup()
Date:   Thu, 16 Jun 2022 17:00:23 +0300
Message-ID: <20220616140024.2081238-4-claudiu.beznea@microchip.com>
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

There is no need for clk_prepare_enable() at the beginning of
atmel_console_setup() and clk_disable_unprepare() at the end of
atmel_console_setup() as the clock is already enabled when calling
atmel_console_setup() and its disablement is done at the end
of probe.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4cec97fd7241..3a94c2bdda72 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2617,7 +2617,6 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
 
 static int __init atmel_console_setup(struct console *co, char *options)
 {
-	int ret;
 	struct uart_port *port = &atmel_ports[co->index].uart;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	int baud = 115200;
@@ -2630,10 +2629,6 @@ static int __init atmel_console_setup(struct console *co, char *options)
 		return -ENODEV;
 	}
 
-	ret = clk_prepare_enable(atmel_ports[co->index].clk);
-	if (ret)
-		return ret;
-
 	atmel_uart_writel(port, ATMEL_US_IDR, -1);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
@@ -2914,17 +2909,6 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
 
-- 
2.34.1

