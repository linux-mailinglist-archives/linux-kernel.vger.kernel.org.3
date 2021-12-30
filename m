Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54688481B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhL3KXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:23:01 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:36405 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbhL3KXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:23:00 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 30 Dec 2021
 18:22:56 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V3 6/6] tty: serial: meson: Change request_irq to devm_request_irq and move devm_request_irq to meson_uart_probe()
Date:   Thu, 30 Dec 2021 18:21:10 +0800
Message-ID: <20211230102110.3861-7-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211230102110.3861-1-yu.tu@amlogic.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because an interrupt error occurs when the user opens /dev/ttyAML* but
don't close it, and then opens the same port again. This problem is
encountered in actual projects.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 45e41f20cba3..0dd3f5b35768 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -135,8 +135,6 @@ static void meson_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 	u32 val;
 
-	free_irq(port->irq, port);
-
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = readl(port->membase + AML_UART_CONTROL);
@@ -284,7 +282,6 @@ static void meson_uart_reset(struct uart_port *port)
 static int meson_uart_startup(struct uart_port *port)
 {
 	u32 val;
-	int ret;
 
 	meson_uart_reset(port);
 
@@ -298,10 +295,7 @@ static int meson_uart_startup(struct uart_port *port)
 	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
 	writel(val, port->membase + AML_UART_MISC);
 
-	ret = request_irq(port->irq, meson_uart_interrupt, 0,
-			  port->name, port);
-
-	return ret;
+	return 0;
 }
 
 static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
@@ -908,6 +902,14 @@ static int meson_uart_probe(struct platform_device *pdev)
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
 
+	ret = devm_request_irq(&pdev->dev, port->irq, meson_uart_interrupt,
+			       0, dev_name(&pdev->dev), port);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request uart irq: %d\n",
+			ret);
+		return ret;
+	}
+
 	/* reset port before registering (and possibly registering console) */
 	meson_uart_reset(port);
 
-- 
2.33.1

