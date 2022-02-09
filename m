Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32A4AFEA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiBIUnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:43:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBIUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:43:29 -0500
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 12:43:31 PST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1939FC1036AE;
        Wed,  9 Feb 2022 12:43:31 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 081C4E7;
        Wed,  9 Feb 2022 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1644438874;
        bh=xE/LvTNyhwNJCroq7k9cSKt0G7CO52BHT1A3bAqw3HI=;
        h=From:To:Cc:Subject:Date:From;
        b=I9a0CB7t3VKZNlAvKdLA7wqeT9JYHstpYUBNabqWD6G9upEcS1nUSd3/PfmMGdSmm
         V/4/CXtmPZfjfARD8CHibpB8pAR9WZ4ci+9/KMY1ne4R+eRuOGDwbqZsWsr6TxQZJb
         Av8t9ADBSpP1f3uOFQphQBVu92EKqGIdbYlK/bP8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Aladyshev <aladyshev22@gmail.com>,
        Oskar Senft <osk@google.com>, openbmc@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port type
Date:   Wed,  9 Feb 2022 12:34:14 -0800
Message-Id: <20220209203414.23491-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
set up register mapping") fixed a bug that had, as a side-effect,
prevented the 8250_aspeed_vuart driver from enabling the VUART's
FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
turn revealed what appears to be a hardware bug in the ASPEED VUART in
which the host-side THRE bit doesn't get if the BMC-side receive FIFO
trigger level is set to anything but one byte.  This causes problems
for polled-mode writes from the host -- for example, Linux kernel
console writes proceed at a glacial pace (less than 100 bytes per
second) because the write path waits for a 10ms timeout to expire
after every character instead of being able to continue on to the next
character upon seeing THRE asserted.  (GRUB behaves similarly.)

As a workaround, introduce a new port type for the ASPEED VUART that's
identical to PORT_16550A as it had previously been using, but with
UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
one byte, which (experimentally) seems to avoid the problematic THRE
behavior.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Tested-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 +-
 drivers/tty/serial/8250/8250_port.c         | 8 ++++++++
 include/uapi/linux/serial_core.h            | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 2350fb3bb5e4..c2cecc6f47db 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -487,7 +487,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.irq = irq_of_parse_and_map(np, 0);
 	port.port.handle_irq = aspeed_vuart_handle_irq;
 	port.port.iotype = UPIO_MEM;
-	port.port.type = PORT_16550A;
+	port.port.type = PORT_ASPEED_VUART;
 	port.port.uartclk = clk;
 	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b12bfc1ed67..973870ebff69 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -307,6 +307,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 32, 64, 112},
 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
 	},
+	[PORT_ASPEED_VUART] = {
+		.name		= "ASPEED VUART",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index c4042dcfdc0c..cd11748833e6 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -274,4 +274,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
+/* ASPEED AST2x00 virtual UART */
+#define PORT_ASPEED_VUART	123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.35.1

