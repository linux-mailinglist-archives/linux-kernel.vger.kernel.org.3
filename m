Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608F48934F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiAJI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:28:29 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:10511 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiAJI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:27:53 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 10 Jan 2022
 16:26:48 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH] tty: serial: meson: meson_uart_shutdown omit clear AML_UART_TX_EN bit
Date:   Mon, 10 Jan 2022 16:26:12 +0800
Message-ID: <20220110082616.13474-4-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110082616.13474-1-yu.tu@amlogic.com>
References: <20220110082616.13474-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is an improvement. The meson_uart_shutdown function
should have the opposite operation to the meson_uart_startup
function, but the meson_uart_shutdown of AML_UART_TX_EN is logically
missing.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 9b07e3534969..c17109d6d441 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -140,7 +140,7 @@ static void meson_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	val &= ~AML_UART_RX_EN;
+	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
 	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
 	writel(val, port->membase + AML_UART_CONTROL);
 

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
prerequisite-patch-id: 97a514f3447511cb204179ce03ae99dc1d5902d9
prerequisite-patch-id: a2e4756ff85f0df0efe111d7e2cb51b8e26e226f
prerequisite-patch-id: af9e3acc8f6ff7602d3a68a57c008e5ec362b353
prerequisite-patch-id: a44e5da7009d9b815eb87395cbd7d14e7d953a09
-- 
2.33.1

