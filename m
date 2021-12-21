Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8236347BB20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhLUHcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:32:14 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:61697 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbhLUHcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:32:11 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 02:32:04 EST
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 21 Dec 2021
 15:17:02 +0800
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
Subject: [PATCH 2/3] tty: serial: meson: meson_uart_shutdown omit clear AML_UART_TX_EN bit
Date:   Tue, 21 Dec 2021 15:16:33 +0800
Message-ID: <20211221071634.25980-3-yu.tu@amlogic.com>
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

The meson_uart_shutdown function should have the opposite operation to
the meson_uart_startup function, so the shutdown of AML_UART_TX_EN is
logically missing.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 02fafb8229d2..69450a461c48 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -126,8 +126,7 @@ static void meson_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	val &= ~AML_UART_RX_EN;
-	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
+	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
 	writel(val, port->membase + AML_UART_CONTROL);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.33.1

