Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8354C378
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiFOI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbiFOI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:29:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85B33890;
        Wed, 15 Jun 2022 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655281767; x=1686817767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s2w3cZlQKmR9BHINpZiLGIOhcN/Hegit5K57L5jWoHw=;
  b=TwI7J4P071lI25QoVlsJr+jxcPyjsqx5hBWMfdjD8VKj6hlpN3BAlejC
   XAhWSrSh/ezujWWXtc8yGqvogTDrpmtdULNjsq/4t7K2+T/Q15k6nFS80
   vDrrIueNi45fQwyC92ZwBwhnzHXkdS5sqOWzgtTBxJZzONapcQUGEX5Yi
   b3RMoHps3K2c0RUvbB6CNv5Vi79BP2i0QfM0RtvxSGwVTnJxoQBKe2o59
   MNVJvBq0GyOaL/Y35XTVsDP+7/npwhdcZIJ2R966zEYurfriuERr1BeaP
   nZ2rGrmG+5f0aNXxMA67kU7A5Qeu/QHXXGBrz5TSyhPa1o/Po57xhb29f
   w==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="168487083"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 01:29:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 01:29:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 01:29:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/4] tty: serial: atmel: remove enable/disable clock due to atmel_console_setup()
Date:   Wed, 15 Jun 2022 11:31:43 +0300
Message-ID: <20220615083144.1882142-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220615083144.1882142-1-claudiu.beznea@microchip.com>
References: <20220615083144.1882142-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/tty/serial/atmel_serial.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4cec97fd7241..51835c7ce827 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2630,10 +2630,6 @@ static int __init atmel_console_setup(struct console *co, char *options)
 		return -ENODEV;
 	}
 
-	ret = clk_prepare_enable(atmel_ports[co->index].clk);
-	if (ret)
-		return ret;
-
 	atmel_uart_writel(port, ATMEL_US_IDR, -1);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
@@ -2914,17 +2910,6 @@ static int atmel_serial_probe(struct platform_device *pdev)
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

