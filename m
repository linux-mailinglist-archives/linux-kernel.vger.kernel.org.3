Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A24E2E19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbiCUQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351165AbiCUQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C16F957F;
        Mon, 21 Mar 2022 09:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0EE5612F5;
        Mon, 21 Mar 2022 16:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6539C340F9;
        Mon, 21 Mar 2022 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647880270;
        bh=oLh0/VBSUCblDOhHVjzy1tQ+2cNVbgrdWCBKnnqb0CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ydb+/oIJa5h1SawT5gGwwGDXMJkjDhxO2MexA84GMrIXHOEzS9u42UOjShgm41ucT
         aODIvGXw4SgXQ0lomAIL/BCqJybUUPfCaZmTR4bHXHFQliNF8teUPltpHuREG2ET4k
         TKJXWXbGnVihiSMS6XFHdlGWCWkNnodHHz6/KJaI0Kvv4aMcy8QoxKROpKqR2B8zLI
         zblcWL5X/4CapDP65ycLpZapJ5GQi7QKTLBWbRAjZ8ZeNQSBRVTjMhKPuCHz3RWXBr
         bkG1sEMLCMXy2ZwP91SBbYyPWR14Q7dAoHK8WjfKunp3icTWSQmK8kfo+3m6JBmI+R
         PcL2FI0MbxxFQ==
Received: by pali.im (Postfix)
        id 46142EF8; Mon, 21 Mar 2022 17:31:07 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] serial: Fix support for UPF_SPD_* flags in serial drivers
Date:   Mon, 21 Mar 2022 17:30:55 +0100
Message-Id: <20220321163055.4058-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220321163055.4058-1-pali@kernel.org>
References: <20220321163055.4058-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most serial drivers do not handle UPF_SPD_* flags correctly. They use
uart_get_baud_rate() and uart_get_divisor() functions for retrieving baud
rate and divisor which correctly handle UPF_SPD_* flags and set correct
value to HW. But drivers do not propagate correct value to termios
structure as they call just tty_termios_encode_baud_rate() function which
completely ignores these UPF_SPD_* flags. So termios structure reported to
userspace does not match to UPF_SPD_* flags which were used for configuring
HW and also does not match ASYNC_SDP_* flags stored in serial_struct which
are reported to userspace.

Fix this issue by introducing a new function uart_set_baud_rate() which is
wrapper around tty_termios_encode_baud_rate() and which handles those
UPF_SPD_* flags correctly.

Replace all calls of tty_termios_encode_baud_rate() function which take an
argument from uart_get_baud_rate() function by this new function
uart_set_baud_rate().

This ensures that serial drivers which are using uart_get_baud_rate() will
correctly handle UPF_SPD_* flags.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/21285.c          |  2 +-
 drivers/tty/serial/8250/8250_mtk.c  |  2 +-
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c |  2 +-
 drivers/tty/serial/altera_uart.c    |  2 +-
 drivers/tty/serial/ar933x_uart.c    |  2 +-
 drivers/tty/serial/arc_uart.c       |  2 +-
 drivers/tty/serial/dz.c             |  2 +-
 drivers/tty/serial/imx.c            |  3 +-
 drivers/tty/serial/lantiq.c         |  2 +-
 drivers/tty/serial/lpc32xx_hs.c     |  2 +-
 drivers/tty/serial/men_z135_uart.c  |  2 +-
 drivers/tty/serial/mps2-uart.c      |  2 +-
 drivers/tty/serial/msm_serial.c     |  2 +-
 drivers/tty/serial/mvebu-uart.c     |  2 +-
 drivers/tty/serial/owl-uart.c       |  2 +-
 drivers/tty/serial/pch_uart.c       |  2 +-
 drivers/tty/serial/pic32_uart.c     |  2 +-
 drivers/tty/serial/rda-uart.c       |  2 +-
 drivers/tty/serial/rp2.c            |  2 +-
 drivers/tty/serial/sccnxp.c         |  2 +-
 drivers/tty/serial/serial-tegra.c   |  2 +-
 drivers/tty/serial/serial_core.c    | 51 +++++++++++++++++++++++++++++
 drivers/tty/serial/sprd_serial.c    |  2 +-
 drivers/tty/serial/timbuart.c       |  2 +-
 drivers/tty/serial/vt8500_serial.c  |  2 +-
 drivers/tty/serial/xilinx_uartps.c  |  2 +-
 include/linux/serial_core.h         |  2 ++
 28 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 09baef4ccc39..4e4dbd58c581 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -265,7 +265,7 @@ serial21285_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
 	quot = uart_get_divisor(port, baud);
 	b = port->uartclk / (16 * quot);
-	tty_termios_encode_baud_rate(termios, b, b);
+	uart_set_baud_rate(port, termios, b);
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fb65dc601b23..4a46a7f039d0 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -406,7 +406,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 }
 
 static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 73e5f1dbd075..96c1df9ffd25 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -510,7 +510,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 }
 
 /* same as 8250 except that we may have extra flow bits set in EFR */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5775cbff8f6e..05ca0152b932 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2878,7 +2878,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 }
 EXPORT_SYMBOL(serial8250_do_set_termios);
 
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 7c5f4e966b59..ec352d53662a 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -185,7 +185,7 @@ static void altera_uart_set_termios(struct uart_port *port,
 
 	if (old)
 		tty_termios_copy_hw(termios, old);
-	tty_termios_encode_baud_rate(termios, baud, baud);
+	uart_set_baud_rate(port, termios, baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 	uart_update_timeout(port, termios->c_cflag, baud);
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 4379ca4842ae..48e8127d0e9d 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -355,7 +355,7 @@ static void ar933x_uart_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	if (tty_termios_baud_rate(new))
-		tty_termios_encode_baud_rate(new, baud, baud);
+		uart_set_baud_rate(port, new, baud);
 }
 
 static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 596217d10d5c..cc2a06832699 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -391,7 +391,7 @@ arc_serial_set_termios(struct uart_port *port, struct ktermios *new,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(new))
-		tty_termios_encode_baud_rate(new, baud, baud);
+		uart_set_baud_rate(port, new, baud);
 
 	uart_update_timeout(port, new->c_cflag, baud);
 
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index e9edabc5a211..8084966ba9f9 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -599,7 +599,7 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 			baud = 9600;
 			bflag = DZ_B9600;
 		}
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(uport, termios, baud);
 	}
 	cflag |= bflag;
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90f82e6c54e4..b56344b46459 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1729,8 +1729,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	tdiv64 = sport->port.uartclk;
 	tdiv64 *= num;
 	do_div(tdiv64, denom * 16 * div);
-	tty_termios_encode_baud_rate(termios,
-				(speed_t)tdiv64, (speed_t)tdiv64);
+	uart_set_baud_rate(port, termios, (speed_t)tdiv64);
 
 	num -= 1;
 	denom -= 1;
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 497b334bc845..38b2f7fa80ff 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -502,7 +502,7 @@ lqasc_set_termios(struct uart_port *port,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(new))
-		tty_termios_encode_baud_rate(new, baud, baud);
+		uart_set_baud_rate(port, new, baud);
 
 	uart_update_timeout(port, cflag, baud);
 }
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index b199d7859961..e6f9166be0c7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -530,7 +530,7 @@ static void serial_lpc32xx_set_termios(struct uart_port *port,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 }
 
 static const char *serial_lpc32xx_type(struct uart_port *port)
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 9acae5f8fc32..e3a83bca9991 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -713,7 +713,7 @@ static void men_z135_set_termios(struct uart_port *port,
 
 	spin_lock_irq(&port->lock);
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	bd_reg = uart_freq / (4 * baud);
 	iowrite32(bd_reg, port->membase + MEN_Z135_BAUD_REG);
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 587b42f754cb..117a7afcd088 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -383,7 +383,7 @@ mps2_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 }
 
 static const char *mps2_uart_type(struct uart_port *port)
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index fcef7a961430..789dfeb286bf 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1262,7 +1262,7 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 300, 4000000);
 	baud = msm_set_baud_rate(port, baud, &flags);
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	/* calculate parity */
 	mr = msm_read(port, UART_MR2);
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ab226da75f7b..7bd9579855fa 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -515,7 +515,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 			baud = uart_get_baud_rate(port, old, NULL,
 						  min_baud, max_baud);
 	} else {
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 		uart_update_timeout(port, termios->c_cflag, baud);
 	}
 
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 91f1eb0058d7..8d70cdbd4a73 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -387,7 +387,7 @@ static void owl_uart_set_termios(struct uart_port *port,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	port->read_status_mask |= OWL_UART_STAT_RXER;
 	if (termios->c_iflag & INPCK)
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index f0351e6f0ef6..53f2e9c09d8d 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1412,7 +1412,7 @@ static void pch_uart_set_termios(struct uart_port *port,
 	pch_uart_set_mctrl(&priv->port, priv->port.mctrl);
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 out:
 	spin_unlock(&port->lock);
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0a12fb11e698..286045456a1c 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -596,7 +596,7 @@ static void pic32_uart_set_termios(struct uart_port *port,
 	uart_update_timeout(port, new->c_cflag, baud);
 
 	if (tty_termios_baud_rate(new))
-		tty_termios_encode_baud_rate(new, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	/* enable uart */
 	pic32_uart_en_and_unmask(port);
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index d550d8fa2fab..c08c597cda86 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -318,7 +318,7 @@ static void rda_uart_set_termios(struct uart_port *port,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 6689d8add8f7..a12e9a97905b 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -382,7 +382,7 @@ static void rp2_uart_set_termios(struct uart_port *port,
 	baud_div = uart_get_divisor(port, baud);
 
 	if (tty_termios_baud_rate(new))
-		tty_termios_encode_baud_rate(new, baud, baud);
+		uart_set_baud_rate(port, new, baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 10cc16a71f26..141dc0ebb688 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -714,7 +714,7 @@ static void sccnxp_set_termios(struct uart_port *port,
 
 	/* Report actual baudrate back to core */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	/* Enable RX & TX */
 	sccnxp_port_write(port, SCCNXP_CR_REG, CR_RX_ENABLE | CR_TX_ENABLE);
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 45e2e4109acd..876aa57dbcd0 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1360,7 +1360,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 		return;
 	}
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(u, termios, baud);
 	spin_lock_irqsave(&u->lock, flags);
 
 	/* Flow control */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 34e085a038fe..113db02be87e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -477,6 +477,57 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 
 EXPORT_SYMBOL(uart_get_baud_rate);
 
+void
+uart_set_baud_rate(struct uart_port *port, struct ktermios *termios, unsigned int baud)
+{
+	upf_t flags = port->flags & UPF_SPD_MASK;
+	unsigned int close = baud / 50;
+	unsigned int altbaud = 0;
+
+	switch (flags) {
+	case UPF_SPD_HI:
+		altbaud = 57600;
+		break;
+	case UPF_SPD_VHI:
+		altbaud = 115200;
+		break;
+	case UPF_SPD_SHI:
+		altbaud = 230400;
+		break;
+	case UPF_SPD_WARP:
+		altbaud = 460800;
+		break;
+	}
+
+	/*
+	 * UPF_SPD_* port flags are in use when B38400 is set in termios.
+	 * Let termios baudrate set to B38400 value when new baudrate is
+	 * in 2% tolerance (same tolerance as in tty_termios_encode_baud_rate).
+	 * For UPF_SPD_CUST flag it is required to be this function called with
+	 * baud = 38400 and then real baudrate depends only on custom_divisor.
+	 */
+	if (tty_termios_baud_rate(termios) == 38400) {
+		if (altbaud && baud - close >= altbaud && baud + close <= altbaud) {
+			altbaud = baud;
+			baud = 38400;
+		} else if (flags == UPF_SPD_CUST && baud == 38400) {
+			/* See uart_update_timeout() about this calculation */
+			altbaud = DIV_ROUND_CLOSEST(port->uartclk, 16 * port->custom_divisor);
+		}
+	}
+
+	tty_termios_encode_baud_rate(termios, baud, baud);
+
+	/*
+	 * If UPF_SPD_* port flags are active and in use then store into
+	 * TCGETS2 c_*speed fields real baudrate.
+	 */
+	if (baud == 38400 && altbaud)
+		termios->c_ispeed = termios->c_ospeed = altbaud;
+}
+
+EXPORT_SYMBOL(uart_set_baud_rate);
+
 /**
  *	uart_get_divisor - return uart clock divisor
  *	@port: uart_port structure describing the port.
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 9a7ae6384edf..17b0cadd31e6 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -867,7 +867,7 @@ static void sprd_set_termios(struct uart_port *port,
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 }
 
 static const char *sprd_type(struct uart_port *port)
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 08941eabe7b1..c41377d218e7 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -294,7 +294,7 @@ static void timbuart_set_termios(struct uart_port *port,
 	   up initially */
 	if (old)
 		tty_termios_copy_hw(termios, old);
-	tty_termios_encode_baud_rate(termios, baud, baud);
+	uart_set_baud_rate(port, termios, baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 	iowrite8((u8)bindex, port->membase + TIMBUART_BAUDRATE);
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index e15b2bf69904..2e5d9b52e478 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -369,7 +369,7 @@ static void vt8500_set_termios(struct uart_port *port,
 	baud = uart_get_baud_rate(port, termios, old, 900, 921600);
 	baud = vt8500_set_baud_rate(port, baud);
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	/* calculate parity */
 	lcr = vt8500_read(&vt8500_port->uart, VT8500_URLCR);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d5e243908d9f..300108c9ba7e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -714,7 +714,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	baud = uart_get_baud_rate(port, termios, old, minbaud, maxbaud);
 	baud = cdns_uart_set_baud_rate(port, baud);
 	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_set_baud_rate(port, termios, baud);
 
 	/* Update the per-port timeout. */
 	uart_update_timeout(port, termios->c_cflag, baud);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c58cc142d23f..a0f736be5645 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -330,6 +330,8 @@ void uart_update_timeout(struct uart_port *port, unsigned int cflag,
 unsigned int uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 				struct ktermios *old, unsigned int min,
 				unsigned int max);
+void uart_set_baud_rate(struct uart_port *port, struct ktermios *termios,
+			unsigned int baud);
 unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
 
 /* Base timer interval for polling */
-- 
2.20.1

