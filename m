Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7C4C3F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiBYHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiBYHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:40:30 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75E177764;
        Thu, 24 Feb 2022 23:39:58 -0800 (PST)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 25 Feb 2022
 15:39:55 +0800
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
Subject: [PATCH V7 1/6] tty: serial: meson: Move request the register region to probe
Date:   Fri, 25 Feb 2022 15:39:17 +0800
Message-ID: <20220225073922.3947-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220225073922.3947-1-yu.tu@amlogic.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
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

This simplifies resetting the UART controller during probe
and will make it easier to integrate the common clock code
which will require the registers at probe time as well.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/meson_uart.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 45e00d928253..6b80e41b4cc1 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -395,24 +395,11 @@ static int meson_uart_verify_port(struct uart_port *port,
 
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
 
@@ -733,6 +720,18 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
+				     resource_size(res_mem),
+				     dev_name(&pdev->dev))) {
+		dev_err(&pdev->dev, "Memory region busy\n");
+		return -EBUSY;
+	}
+
+	port->membase = devm_ioremap(&pdev->dev, res_mem->start,
+				     resource_size(res_mem));
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
 	ret = meson_uart_probe_clocks(pdev, port);
 	if (ret)
 		return ret;
@@ -754,10 +753,7 @@ static int meson_uart_probe(struct platform_device *pdev)
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

