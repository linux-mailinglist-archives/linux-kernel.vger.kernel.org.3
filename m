Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5804B9C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiBQJq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbiBQJqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:46:45 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261B62EF;
        Thu, 17 Feb 2022 01:46:31 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3513622205;
        Thu, 17 Feb 2022 10:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645091188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uMIY4q1dw2g0DupncXTpW6aZDCSYaQ0ItOC+2/6KcXc=;
        b=bea5cxY1s+igLLttFbfWazshFuoO8SPXLgg3V6oVbn8Mazj+rV3b3D/bmuCxFiqYSkGzXD
        +7AHgj2bvdEQh78V5Ge0Q5ltrCRXl8ongEHltbH9s7g7iYL++5SMO02GwYB5hvn372Mqu7
        OaO0Y0uUHxIX4rUo6oPxxb3Lb/mUv5A=
From:   Michael Walle <michael@walle.cc>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v2] tty: serial: atmel: add earlycon support
Date:   Thu, 17 Feb 2022 10:46:20 +0100
Message-Id: <20220217094620.1148571-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early console support which relies on the bootloader for the
initialization of the UART.
Please note, that the compatibles are taken from at91-usart MFD
driver.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/Kconfig        |  1 +
 drivers/tty/serial/atmel_serial.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0e5ccb25bdb1..407a98ec0791 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -139,6 +139,7 @@ config SERIAL_ATMEL_CONSOLE
 	bool "Support for console on AT91 serial port"
 	depends on SERIAL_ATMEL=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Say Y here if you wish to use an on-chip UART on a Atmel
 	  AT91 processor as the system console (the system
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2d09a89974a2..73d43919898d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2673,6 +2673,30 @@ static struct console atmel_console = {
 	.data		= &atmel_uart,
 };
 
+static void atmel_serial_early_write(struct console *con, const char *s,
+				     unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, atmel_console_putchar);
+}
+
+static int __init atmel_early_console_setup(struct earlycon_device *device,
+					    const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = atmel_serial_early_write;
+
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(atmel_serial, "atmel,at91rm9200-usart",
+		    atmel_early_console_setup);
+OF_EARLYCON_DECLARE(atmel_serial, "atmel,at91sam9260-usart",
+		    atmel_early_console_setup);
+
 #define ATMEL_CONSOLE_DEVICE	(&atmel_console)
 
 #else
-- 
2.30.2

