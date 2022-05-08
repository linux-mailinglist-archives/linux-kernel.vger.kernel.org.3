Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0452451ECEB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiEHKjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiEHKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:39:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF59E0AE;
        Sun,  8 May 2022 03:35:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652006148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wg5rgmNfLBMFs6+g076Tc69lJyydQy68rcQ9tdaUcOE=;
        b=d8FMbrH+ZnIzNn38VNXgyx0rlmVihz2sgmBykxM1ijuFHr/encYlNAO/FYu+00jN5IaBPf
        nuT70471orDPF3hqmVgafDF+6S44F0DBmgHNcDDXybOzpk2dytgoLzeWg35VQJW5rLBx+2
        CO2hxm90hqJoqW+/c+6edL583AnVr+IvIHWQl7KMaT+LqnoP5+WhaqKm/i2FZMcKyqtQON
        2lu8+YOHSNxdzeYuGUZ+9xA9ZPKMGN9VYjrNAhLH9k9izTmalcjST1YecYH4ZRm3Vc9+47
        wCZrxf+vm13kfAZMwgZoV/uSs3Lp8leLOcTpXlMrXKVYhTN2d9FgXEY0t6sXpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652006148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wg5rgmNfLBMFs6+g076Tc69lJyydQy68rcQ9tdaUcOE=;
        b=jbctOsS1Qy4kMsGrmyICmp7zgkryPYX6MCehq3ekzyo01N9EyO256vJmZBPTyf8dl2IGuw
        1Usb4/w4051eRfBg==
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v1] serial: meson: acquire port->lock in startup()
Date:   Sun,  8 May 2022 12:41:47 +0206
Message-Id: <20220508103547.626355-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uart_ops startup() callback is called without interrupts
disabled and without port->lock locked, relatively late during the
boot process (from the call path of console_on_rootfs()). If the
device is a console, it was already previously registered and could
be actively printing messages.

Since the startup() callback is reading/writing registers used by
the console write() callback (AML_UART_CONTROL), its access must
be synchronized using the port->lock. Currently it is not.

The startup() callback is the only function that explicitly enables
interrupts. Without the synchronization, it is possible that
interrupts become accidentally permanently disabled.

CPU0                           CPU1
meson_serial_console_write     meson_uart_startup
--------------------------     ------------------
spin_lock(port->lock)
val = readl(AML_UART_CONTROL)
uart_console_write()
                               writel(INT_EN, AML_UART_CONTROL)
writel(val, AML_UART_CONTROL)
spin_unlock(port->lock)

Add port->lock synchronization to meson_uart_startup() to avoid
racing with meson_serial_console_write().

Also add detailed comments to meson_uart_reset() explaining why it
is *not* using port->lock synchronization.

Link: https://lore.kernel.org/lkml/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/meson_uart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2bf1c57e0981..39021dac09cc 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -253,6 +253,14 @@ static const char *meson_uart_type(struct uart_port *port)
 	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
 }
 
+/*
+ * This function is called only from probe() using a temporary io mapping
+ * in order to perform a reset before setting up the device. Since the
+ * temporarily mapped region was successfully requested, there can be no
+ * console on this port at this time. Hence it is not necessary for this
+ * function to acquire the port->lock. (Since there is no console on this
+ * port at this time, the port->lock is not initialized yet.)
+ */
 static void meson_uart_reset(struct uart_port *port)
 {
 	u32 val;
@@ -267,9 +275,12 @@ static void meson_uart_reset(struct uart_port *port)
 
 static int meson_uart_startup(struct uart_port *port)
 {
+	unsigned long flags;
 	u32 val;
 	int ret = 0;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	val = readl(port->membase + AML_UART_CONTROL);
 	val |= AML_UART_CLEAR_ERR;
 	writel(val, port->membase + AML_UART_CONTROL);
@@ -285,6 +296,8 @@ static int meson_uart_startup(struct uart_port *port)
 	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
 	writel(val, port->membase + AML_UART_MISC);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	ret = request_irq(port->irq, meson_uart_interrupt, 0,
 			  port->name, port);
 

base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
-- 
2.30.2

