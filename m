Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4402C47BB22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhLUHcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:32:16 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:61697 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhLUHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:32:15 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 02:32:04 EST
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 21 Dec 2021
 15:17:03 +0800
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
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH 3/3] tty: serial: meson: add UART driver compatible with S4 SoC on-chip
Date:   Tue, 21 Dec 2021 15:16:34 +0800
Message-ID: <20211221071634.25980-4-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221071634.25980-1-yu.tu@amlogic.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S4 SoC on-chip UART uses a 12M clock as the clock source for
calculating the baud rate of the UART. But previously, chips used 24M or
other clock sources. So add this change. The specific clock source is
determined by chip design.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 62 +++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 69450a461c48..557c24d954a2 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -19,6 +19,7 @@
 #include <linux/serial_core.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/of_device.h>
 
 /* Register offsets */
 #define AML_UART_WFIFO			0x00
@@ -68,6 +69,8 @@
 #define AML_UART_BAUD_MASK		0x7fffff
 #define AML_UART_BAUD_USE		BIT(23)
 #define AML_UART_BAUD_XTAL		BIT(24)
+#define AML_UART_BAUD_XTAL_TICK		BIT(26)
+#define AML_UART_BAUD_XTAL_DIV2		BIT(27)
 
 #define AML_UART_PORT_NUM		12
 #define AML_UART_PORT_OFFSET		6
@@ -80,6 +83,11 @@ static struct uart_driver meson_uart_driver;
 
 static struct uart_port *meson_ports[AML_UART_PORT_NUM];
 
+struct meson_uart_data {
+	/*A clock source that calculates baud rates*/
+	unsigned int xtal_tick_en;
+};
+
 static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 }
@@ -294,16 +302,29 @@ static int meson_uart_startup(struct uart_port *port)
 
 static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
 {
+	struct meson_uart_data *uart_data = port->private_data;
 	u32 val;
 
 	while (!meson_uart_tx_empty(port))
 		cpu_relax();
 
+	val = readl_relaxed(port->membase + AML_UART_REG5);
+	val &= ~AML_UART_BAUD_MASK;
+
 	if (port->uartclk == 24000000) {
-		val = ((port->uartclk / 3) / baud) - 1;
-		val |= AML_UART_BAUD_XTAL;
+		if (uart_data->xtal_tick_en) {
+			val = (port->uartclk / 2 + baud / 2) / baud  - 1;
+			val |= (AML_UART_BAUD_XTAL | AML_UART_BAUD_XTAL_DIV2);
+		} else {
+			val = ((port->uartclk / 3) + baud / 2) / baud  - 1;
+			val &= (~(AML_UART_BAUD_XTAL_TICK |
+				AML_UART_BAUD_XTAL_DIV2));
+			val |= AML_UART_BAUD_XTAL;
+		}
 	} else {
 		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+		val &= (~(AML_UART_BAUD_XTAL | AML_UART_BAUD_XTAL_TICK |
+			AML_UART_BAUD_XTAL_DIV2));
 	}
 	val |= AML_UART_BAUD_USE;
 	writel(val, port->membase + AML_UART_REG5);
@@ -714,6 +735,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
+	struct meson_uart_data *uart_data;
 	int ret = 0;
 	int id = -1;
 
@@ -729,6 +751,10 @@ static int meson_uart_probe(struct platform_device *pdev)
 		}
 	}
 
+	uart_data = of_device_get_match_data(&pdev->dev);
+	if (!uart_data)
+		return  -EINVAL;
+
 	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
 		return -EINVAL;
 
@@ -770,6 +796,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
 	port->fifosize = 64;
+	port->private_data = uart_data;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
@@ -798,14 +825,35 @@ static int meson_uart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct meson_uart_data meson_uart_data = {
+	.xtal_tick_en = 0,
+};
+
+static const struct meson_uart_data s4_meson_uart_data = {
+	.xtal_tick_en = 1,
+};
+
 static const struct of_device_id meson_uart_dt_match[] = {
 	/* Legacy bindings, should be removed when no more used */
-	{ .compatible = "amlogic,meson-uart" },
+	{	.compatible = "amlogic,meson-uart",
+		.data = &meson_uart_data
+	},
 	/* Stable bindings */
-	{ .compatible = "amlogic,meson6-uart" },
-	{ .compatible = "amlogic,meson8-uart" },
-	{ .compatible = "amlogic,meson8b-uart" },
-	{ .compatible = "amlogic,meson-gx-uart" },
+	{	.compatible = "amlogic,meson6-uart",
+		.data = &meson_uart_data
+	},
+	{	.compatible = "amlogic,meson8-uart",
+		.data = &meson_uart_data
+	},
+	{	.compatible = "amlogic,meson8b-uart",
+		.data = &meson_uart_data
+	},
+	{	.compatible = "amlogic,meson-gx-uart",
+		.data = &meson_uart_data
+	},
+	{	.compatible = "amlogic,meson-s4-uart",
+		.data = &s4_meson_uart_data
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
-- 
2.33.1

