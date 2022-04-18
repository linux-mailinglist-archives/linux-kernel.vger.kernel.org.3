Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA237504C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiDRFgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiDRFgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:36:03 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D9B13E22;
        Sun, 17 Apr 2022 22:33:25 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 18 Apr 2022
 13:33:23 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock rate to calculate baud rate in order to meet the baud rate requirements of special BT modules
Date:   Mon, 18 Apr 2022 13:32:01 +0800
Message-ID: <20220418053202.24528-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220418053202.24528-1-yu.tu@amlogic.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A /2 divider over XTAL was introduced since G12A, and is preferred
to be used over the still present /3 divider since it provides much
closer frequencies vs the request baudrate.Especially the BT module
uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
causing some problems.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8e59624935af..58bd2723c004 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -68,6 +68,7 @@
 #define AML_UART_BAUD_MASK		0x7fffff
 #define AML_UART_BAUD_USE		BIT(23)
 #define AML_UART_BAUD_XTAL		BIT(24)
+#define AML_UART_BAUD_XTAL_DIV2		BIT(27)
 
 #define AML_UART_PORT_NUM		12
 #define AML_UART_PORT_OFFSET		6
@@ -80,6 +81,10 @@ static struct uart_driver meson_uart_driver;
 
 static struct uart_port *meson_ports[AML_UART_PORT_NUM];
 
+struct meson_uart_data {
+	bool has_xtal_div2;
+};
+
 static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 }
@@ -293,13 +298,20 @@ static int meson_uart_startup(struct uart_port *port)
 
 static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
 {
-	u32 val;
+	const struct meson_uart_data *private_data = port->private_data;
+	u32 val = 0;
 
 	while (!meson_uart_tx_empty(port))
 		cpu_relax();
 
 	if (port->uartclk == 24000000) {
-		val = DIV_ROUND_CLOSEST(port->uartclk / 3, baud) - 1;
+		unsigned int xtal_div = 3;
+
+		if (private_data && private_data->has_xtal_div2) {
+			xtal_div = 2;
+			val |= AML_UART_BAUD_XTAL_DIV2;
+		}
+		val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, baud) - 1;
 		val |= AML_UART_BAUD_XTAL;
 	} else {
 		val =  DIV_ROUND_CLOSEST(port->uartclk / 4, baud) - 1;
@@ -749,6 +761,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
 	port->fifosize = fifosize;
+	port->private_data = (void *)device_get_match_data(&pdev->dev);
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
-- 
2.33.1

