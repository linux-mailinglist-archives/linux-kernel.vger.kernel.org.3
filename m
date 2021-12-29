Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258D74813AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhL2Ny0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:54:26 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:37701 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhL2NyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:54:25 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Wed, 29 Dec 2021
 21:54:16 +0800
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
Subject: [PATCH V2 1/6] tty: serial: meson: Drop the legacy compatible strings and clock code
Date:   Wed, 29 Dec 2021 21:53:45 +0800
Message-ID: <20211229135350.9659-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211229135350.9659-1-yu.tu@amlogic.com>
References: <20211229135350.9659-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All mainline .dts files have been using the stable UART since Linux
4.16. Drop the legacy compatible strings and related clock code.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 34 ++-------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d2c08b760f83..c9a37602ffd0 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -625,10 +625,7 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 	device->con->write = meson_serial_early_console_write;
 	return 0;
 }
-/* Legacy bindings, should be removed when no more used */
-OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
-		    meson_serial_early_console_setup);
-/* Stable bindings */
+
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
 
@@ -668,25 +665,6 @@ static inline struct clk *meson_uart_probe_clock(struct device *dev,
 	return clk;
 }
 
-/*
- * This function gets clocks in the legacy non-stable DT bindings.
- * This code will be remove once all the platforms switch to the
- * new DT bindings.
- */
-static int meson_uart_probe_clocks_legacy(struct platform_device *pdev,
-					  struct uart_port *port)
-{
-	struct clk *clk = NULL;
-
-	clk = meson_uart_probe_clock(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	port->uartclk = clk_get_rate(clk);
-
-	return 0;
-}
-
 static int meson_uart_probe_clocks(struct platform_device *pdev,
 				   struct uart_port *port)
 {
@@ -750,12 +728,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	/* Use legacy way until all platforms switch to new bindings */
-	if (of_device_is_compatible(pdev->dev.of_node, "amlogic,meson-uart"))
-		ret = meson_uart_probe_clocks_legacy(pdev, port);
-	else
-		ret = meson_uart_probe_clocks(pdev, port);
-
+	ret = meson_uart_probe_clocks(pdev, port);
 	if (ret)
 		return ret;
 
@@ -800,9 +773,6 @@ static int meson_uart_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id meson_uart_dt_match[] = {
-	/* Legacy bindings, should be removed when no more used */
-	{ .compatible = "amlogic,meson-uart" },
-	/* Stable bindings */
 	{ .compatible = "amlogic,meson6-uart" },
 	{ .compatible = "amlogic,meson8-uart" },
 	{ .compatible = "amlogic,meson8b-uart" },
-- 
2.33.1

