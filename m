Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C086047BB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhLUHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:32:11 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:61697 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhLUHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:32:07 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 02:32:04 EST
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 21 Dec 2021
 15:17:01 +0800
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
Subject: [PATCH 1/3] tty: serial: meson: modify request_irq and free_irq
Date:   Tue, 21 Dec 2021 15:16:32 +0800
Message-ID: <20211221071634.25980-2-yu.tu@amlogic.com>
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

Change request_irq to devm_request_irq and free_irq to devm_free_irq.
It's better to change the code this way.

The IRQF_SHARED interrupt flag was added because an interrupt error was
detected when the serial port was opened twice in a row on the project.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d2c08b760f83..02fafb8229d2 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -121,7 +121,7 @@ static void meson_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 	u32 val;
 
-	free_irq(port->irq, port);
+	devm_free_irq(port->dev, port->irq, port);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -287,8 +287,8 @@ static int meson_uart_startup(struct uart_port *port)
 	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
 	writel(val, port->membase + AML_UART_MISC);
 
-	ret = request_irq(port->irq, meson_uart_interrupt, 0,
-			  port->name, port);
+	ret = devm_request_irq(port->dev, port->irq, meson_uart_interrupt,
+			       IRQF_SHARED, port->name, port);
 
 	return ret;
 }
-- 
2.33.1

