Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53461481B52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhL3KVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:21:46 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:34421 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhL3KVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:21:44 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 30 Dec 2021
 18:21:42 +0800
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
Subject: [PATCH V3 2/6] tty: serial: meson: Request the register region in meson_uart_probe()
Date:   Thu, 30 Dec 2021 18:21:06 +0800
Message-ID: <20211230102110.3861-3-yu.tu@amlogic.com>
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

This simplifies resetting the UART controller during probe and will make
it easier to integrate the common clock code which will require the
registers at probe time as well.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index c9a37602ffd0..99efe62a1507 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -397,24 +397,11 @@ static int meson_uart_verify_port(struct uart_port *port,
 
 static void meson_uart_release_port(struct uart_port *port)
 {
-	devm_iounmap(port->dev, port->membase);
-	port->membase = NULL;
-	devm_release_mem_region(port->dev, port->mapbase, port->mapsize);
+	/* nothing to do */
 }
 
 static int meson_uart_request_port(struct uart_port *port)
 {
-	if (!devm_request_mem_region(port->dev, port->mapbase, port->mapsize,
-				     dev_name(port->dev))) {
-		dev_err(port->dev, "Memory region busy\n");
-		return -EBUSY;
-	}
-
-	port->membase = devm_ioremap(port->dev, port->mapbase,
-					     port->mapsize);
-	if (!port->membase)
-		return -ENOMEM;
-
 	return 0;
 }
 
@@ -728,6 +715,10 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
 	ret = meson_uart_probe_clocks(pdev, port);
 	if (ret)
 		return ret;
@@ -749,10 +740,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, port);
 
 	/* reset port before registering (and possibly registering console) */
-	if (meson_uart_request_port(port) >= 0) {
-		meson_uart_reset(port);
-		meson_uart_release_port(port);
-	}
+	meson_uart_reset(port);
 
 	ret = uart_add_one_port(&meson_uart_driver, port);
 	if (ret)
-- 
2.33.1

