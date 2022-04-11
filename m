Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF95E4FBA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiDKK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbiDKK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:56:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76622AC;
        Mon, 11 Apr 2022 03:54:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 75C121F869;
        Mon, 11 Apr 2022 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1HTUCDH/I7AdHfJWQKvZtJQceA0xseIrR/PE8DjHZU=;
        b=2VnB/hDWkowu7nj7vMEO8eE3w9keVWuwYedOEMBJEuv1OK2RK2thdzVo2dgLNbqo+CbAQk
        zcgphM44+VnRr8fjCFjLgx4phE38/igemOx2C4Px49BqUxDLgsKOvFuuZknO1/NuYkAmj1
        mMhNTQTowdptIRInNoRnmPzSQH6Ae9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1HTUCDH/I7AdHfJWQKvZtJQceA0xseIrR/PE8DjHZU=;
        b=mnoA4qL8Zb6BlVSU98GjH5V8+y7NcVAk322QNSjnuOYer0KCaf1fC9GxR4p0W0e21ze5sR
        TE1QHLdDuRyRWlAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D5EE8A3B8A;
        Mon, 11 Apr 2022 10:54:07 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 2/3] tty: serial: use uart_port_tx() helper
Date:   Mon, 11 Apr 2022 12:54:04 +0200
Message-Id: <20220411105405.9519-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411105405.9519-1-jslaby@suse.cz>
References: <20220411105405.9519-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_port_tx() is a new helper to send characters to the device. Use
it in these drivers.

It means we have to define two new uart hooks: tx_ready() and put_char()
to do the real job now.

Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/altera_uart.c   | 47 ++++++++------------------
 drivers/tty/serial/atmel_serial.c  | 37 +++++++++-----------
 drivers/tty/serial/fsl_lpuart.c    | 49 ++++++++++-----------------
 drivers/tty/serial/lantiq.c        | 50 ++++++++++-----------------
 drivers/tty/serial/lpc32xx_hs.c    | 53 +++++++++--------------------
 drivers/tty/serial/mcf.c           | 35 +++++++------------
 drivers/tty/serial/mpc52xx_uart.c  | 54 +++++++++---------------------
 drivers/tty/serial/mps2-uart.c     | 44 ++++++++----------------
 drivers/tty/serial/mxs-auart.c     | 43 +++++++++++-------------
 drivers/tty/serial/owl-uart.c      | 47 +++++++-------------------
 drivers/tty/serial/sa1100.c        | 50 +++++++++++----------------
 drivers/tty/serial/vt8500_serial.c | 47 ++++++++------------------
 12 files changed, 187 insertions(+), 369 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 8b749ed557c6..bfbfcafff4cc 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -97,6 +97,17 @@ static unsigned int altera_uart_tx_empty(struct uart_port *port)
 		ALTERA_UART_STATUS_TMT_MSK) ? TIOCSER_TEMT : 0;
 }
 
+static bool altera_uart_tx_ready(struct uart_port *port)
+{
+	return altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
+		ALTERA_UART_STATUS_TRDY_MSK;
+}
+
+static void altera_uart_put_char(struct uart_port *port, unsigned char ch)
+{
+	altera_uart_writel(port, ch, ALTERA_UART_TXDATA_REG);
+}
+
 static unsigned int altera_uart_get_mctrl(struct uart_port *port)
 {
 	struct altera_uart *pp = container_of(port, struct altera_uart, port);
@@ -246,38 +257,6 @@ static void altera_uart_rx_chars(struct altera_uart *pp)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static void altera_uart_tx_chars(struct altera_uart *pp)
-{
-	struct uart_port *port = &pp->port;
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		/* Send special char - probably flow control */
-		altera_uart_writel(port, port->x_char, ALTERA_UART_TXDATA_REG);
-		port->x_char = 0;
-		port->icount.tx++;
-		return;
-	}
-
-	while (altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
-	       ALTERA_UART_STATUS_TRDY_MSK) {
-		if (xmit->head == xmit->tail)
-			break;
-		altera_uart_writel(port, xmit->buf[xmit->tail],
-		       ALTERA_UART_TXDATA_REG);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (xmit->head == xmit->tail) {
-		pp->imr &= ~ALTERA_UART_CONTROL_TRDY_MSK;
-		altera_uart_update_ctrl_reg(pp);
-	}
-}
-
 static irqreturn_t altera_uart_interrupt(int irq, void *data)
 {
 	struct uart_port *port = data;
@@ -290,7 +269,7 @@ static irqreturn_t altera_uart_interrupt(int irq, void *data)
 	if (isr & ALTERA_UART_STATUS_RRDY_MSK)
 		altera_uart_rx_chars(pp);
 	if (isr & ALTERA_UART_STATUS_TRDY_MSK)
-		altera_uart_tx_chars(pp);
+		uart_port_tx(&pp->port);
 	spin_unlock(&port->lock);
 
 	return IRQ_RETVAL(isr);
@@ -414,6 +393,8 @@ static void altera_uart_poll_put_char(struct uart_port *port, unsigned char c)
  */
 static const struct uart_ops altera_uart_ops = {
 	.tx_empty	= altera_uart_tx_empty,
+	.tx_ready	= altera_uart_tx_ready,
+	.put_char	= altera_uart_put_char,
 	.get_mctrl	= altera_uart_get_mctrl,
 	.set_mctrl	= altera_uart_set_mctrl,
 	.start_tx	= altera_uart_start_tx,
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3a45e4fc7993..bf4c3892bbbc 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -462,6 +462,16 @@ static u_int atmel_tx_empty(struct uart_port *port)
 		0;
 }
 
+static bool atmel_uart_tx_ready(struct uart_port *port)
+{
+	return atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY;
+}
+
+static void atmel_put_char(struct uart_port *port, unsigned char ch)
+{
+	atmel_uart_write_char(port, ch);
+}
+
 /*
  * Set state of the modem control output lines
  */
@@ -822,30 +832,11 @@ static void atmel_rx_chars(struct uart_port *port)
  */
 static void atmel_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int pending;
 
-	if (port->x_char &&
-	    (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY)) {
-		atmel_uart_write_char(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-		return;
-
-	while (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY) {
-		atmel_uart_write_char(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (!uart_circ_empty(xmit)) {
+	pending = uart_port_tx(port);
+	if (pending) {
 		/* we still have characters to transmit, so we should continue
 		 * transmitting them when TX is ready, regardless of
 		 * mode or duplexity
@@ -2451,6 +2442,8 @@ static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
 
 static const struct uart_ops atmel_pops = {
 	.tx_empty	= atmel_tx_empty,
+	.tx_ready	= atmel_uart_tx_ready,
+	.put_char	= atmel_put_char,
 	.set_mctrl	= atmel_set_mctrl,
 	.get_mctrl	= atmel_get_mctrl,
 	.stop_tx	= atmel_stop_tx,
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 87789872f400..a696fc4a5968 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -741,36 +741,6 @@ static int lpuart32_poll_get_char(struct uart_port *port)
 }
 #endif
 
-static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
-{
-	struct circ_buf *xmit = &sport->port.state->xmit;
-
-	if (sport->port.x_char) {
-		writeb(sport->port.x_char, sport->port.membase + UARTDR);
-		sport->port.icount.tx++;
-		sport->port.x_char = 0;
-		return;
-	}
-
-	if (lpuart_stopped_or_empty(&sport->port)) {
-		lpuart_stop_tx(&sport->port);
-		return;
-	}
-
-	while (!uart_circ_empty(xmit) &&
-		(readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size)) {
-		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
-	if (uart_circ_empty(xmit))
-		lpuart_stop_tx(&sport->port);
-}
-
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
@@ -821,7 +791,7 @@ static void lpuart_start_tx(struct uart_port *port)
 			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
-			lpuart_transmit_buffer(sport);
+			uart_port_tx(&sport->port);
 	}
 }
 
@@ -875,10 +845,23 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 	return 0;
 }
 
+static bool lpuart_tx_ready(struct uart_port *port)
+{
+	struct lpuart_port *sport = container_of(port, struct lpuart_port,
+			port);
+
+	return readb(port->membase + UARTTCFIFO) < sport->txfifo_size;
+}
+
+static void lpuart_put_char(struct uart_port *port, unsigned char ch)
+{
+	writeb(ch, port->membase + UARTDR);
+}
+
 static void lpuart_txint(struct lpuart_port *sport)
 {
 	spin_lock(&sport->port.lock);
-	lpuart_transmit_buffer(sport);
+	uart_port_tx(&sport->port);
 	spin_unlock(&sport->port.lock);
 }
 
@@ -2284,6 +2267,8 @@ static int lpuart_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 static const struct uart_ops lpuart_pops = {
 	.tx_empty	= lpuart_tx_empty,
+	.tx_ready	= lpuart_tx_ready,
+	.put_char	= lpuart_put_char,
 	.set_mctrl	= lpuart_set_mctrl,
 	.get_mctrl	= lpuart_get_mctrl,
 	.stop_tx	= lpuart_stop_tx,
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index a3120c3347dd..11d2519ce231 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -95,7 +95,6 @@
 #define ASCFSTAT_TXFREEMASK	0x3F000000
 #define ASCFSTAT_TXFREEOFF	24
 
-static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
 
@@ -146,7 +145,7 @@ lqasc_start_tx(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
-	lqasc_tx_chars(port);
+	uart_port_tx(port);
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
 	return;
 }
@@ -219,37 +218,6 @@ lqasc_rx_chars(struct uart_port *port)
 	return 0;
 }
 
-static void
-lqasc_tx_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	if (uart_tx_stopped(port)) {
-		lqasc_stop_tx(port);
-		return;
-	}
-
-	while (((__raw_readl(port->membase + LTQ_ASC_FSTAT) &
-		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
-		if (port->x_char) {
-			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
-			port->icount.tx++;
-			port->x_char = 0;
-			continue;
-		}
-
-		if (uart_circ_empty(xmit))
-			break;
-
-		writeb(port->state->xmit.buf[port->state->xmit.tail],
-			port->membase + LTQ_ASC_TBUF);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-}
-
 static irqreturn_t
 lqasc_tx_int(int irq, void *_port)
 {
@@ -327,6 +295,20 @@ lqasc_tx_empty(struct uart_port *port)
 	return status ? 0 : TIOCSER_TEMT;
 }
 
+static bool
+lqasc_tx_ready(struct uart_port *port)
+{
+	u32 fstat = __raw_readl(port->membase + LTQ_ASC_FSTAT);
+
+	return (fstat & ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
+}
+
+static void
+lqasc_put_char(struct uart_port *port, unsigned char ch)
+{
+	writeb(ch, port->membase + LTQ_ASC_TBUF);
+}
+
 static unsigned int
 lqasc_get_mctrl(struct uart_port *port)
 {
@@ -580,6 +562,8 @@ lqasc_verify_port(struct uart_port *port,
 
 static const struct uart_ops lqasc_pops = {
 	.tx_empty =	lqasc_tx_empty,
+	.tx_ready =	lqasc_tx_ready,
+	.put_char =	lqasc_put_char,
 	.set_mctrl =	lqasc_set_mctrl,
 	.get_mctrl =	lqasc_get_mctrl,
 	.stop_tx =	lqasc_stop_tx,
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 93140cac1ca1..0bcd4a43b746 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -276,41 +276,6 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
-static void serial_lpc32xx_stop_tx(struct uart_port *port);
-
-static void __serial_lpc32xx_tx(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		writel((u32)port->x_char, LPC32XX_HSUART_FIFO(port->membase));
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-		goto exit_tx;
-
-	/* Transfer data */
-	while (LPC32XX_HSU_TX_LEV(readl(
-		LPC32XX_HSUART_LEVEL(port->membase))) < 64) {
-		writel((u32) xmit->buf[xmit->tail],
-		       LPC32XX_HSUART_FIFO(port->membase));
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-exit_tx:
-	if (uart_circ_empty(xmit))
-		serial_lpc32xx_stop_tx(port);
-}
-
 static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
@@ -349,7 +314,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 	/* Transmit data request? */
 	if ((status & LPC32XX_HSU_TX_INT) && (!uart_tx_stopped(port))) {
 		writel(LPC32XX_HSU_TX_INT, LPC32XX_HSUART_IIR(port->membase));
-		__serial_lpc32xx_tx(port);
+		uart_port_tx(port);
 	}
 
 	spin_unlock(&port->lock);
@@ -368,6 +333,18 @@ static unsigned int serial_lpc32xx_tx_empty(struct uart_port *port)
 	return ret;
 }
 
+static bool serial_lpc32xx_tx_ready(struct uart_port *port)
+{
+	u32 level = readl(LPC32XX_HSUART_LEVEL(port->membase));
+
+	return LPC32XX_HSU_TX_LEV(level) < 64;
+}
+
+static void serial_lpc32xx_put_char(struct uart_port *port, unsigned char ch)
+{
+	writel(ch, LPC32XX_HSUART_FIFO(port->membase));
+}
+
 /* port->lock held by caller.  */
 static void serial_lpc32xx_set_mctrl(struct uart_port *port,
 				     unsigned int mctrl)
@@ -397,7 +374,7 @@ static void serial_lpc32xx_start_tx(struct uart_port *port)
 {
 	u32 tmp;
 
-	__serial_lpc32xx_tx(port);
+	uart_port_tx(port);
 	tmp = readl(LPC32XX_HSUART_CTRL(port->membase));
 	tmp |= LPC32XX_HSU_TX_INT_EN;
 	writel(tmp, LPC32XX_HSUART_CTRL(port->membase));
@@ -607,6 +584,8 @@ static int serial_lpc32xx_verify_port(struct uart_port *port,
 
 static const struct uart_ops serial_lpc32xx_pops = {
 	.tx_empty	= serial_lpc32xx_tx_empty,
+	.tx_ready	= serial_lpc32xx_tx_ready,
+	.put_char	= serial_lpc32xx_put_char,
 	.set_mctrl	= serial_lpc32xx_set_mctrl,
 	.get_mctrl	= serial_lpc32xx_get_mctrl,
 	.stop_tx	= serial_lpc32xx_stop_tx,
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 2aec62b5d6c4..f2c3a9586bc5 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -63,6 +63,16 @@ static unsigned int mcf_tx_empty(struct uart_port *port)
 		TIOCSER_TEMT : 0;
 }
 
+static bool mcf_tx_ready(struct uart_port *port)
+{
+	return readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY;
+}
+
+static void mcf_put_char(struct uart_port *port, unsigned char ch)
+{
+	writeb(ch, port->membase + MCFUART_UTB);
+}
+
 /****************************************************************************/
 
 static unsigned int mcf_get_mctrl(struct uart_port *port)
@@ -327,29 +337,8 @@ static void mcf_rx_chars(struct mcf_uart *pp)
 static void mcf_tx_chars(struct mcf_uart *pp)
 {
 	struct uart_port *port = &pp->port;
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		/* Send special char - probably flow control */
-		writeb(port->x_char, port->membase + MCFUART_UTB);
-		port->x_char = 0;
-		port->icount.tx++;
-		return;
-	}
-
-	while (readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY) {
-		if (uart_circ_empty(xmit))
-			break;
-		writeb(xmit->buf[xmit->tail], port->membase + MCFUART_UTB);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE -1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
 
-	if (uart_circ_empty(xmit)) {
-		mcf_stop_tx(port);
+	if (!uart_port_tx(port)) {
 		/* Disable TX to negate RTS automatically */
 		if (port->rs485.flags & SER_RS485_ENABLED)
 			writeb(MCFUART_UCR_TXDISABLE,
@@ -460,6 +449,8 @@ static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
  */
 static const struct uart_ops mcf_uart_ops = {
 	.tx_empty	= mcf_tx_empty,
+	.tx_ready	= mcf_tx_ready,
+	.put_char	= mcf_put_char,
 	.get_mctrl	= mcf_get_mctrl,
 	.set_mctrl	= mcf_set_mctrl,
 	.start_tx	= mcf_start_tx,
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index c4b590dd6f23..1073164d1b01 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1043,6 +1043,18 @@ mpc52xx_uart_tx_empty(struct uart_port *port)
 	return psc_ops->tx_empty(port) ? TIOCSER_TEMT : 0;
 }
 
+static bool
+mpc52xx_uart_tx_ready(struct uart_port *port)
+{
+	return psc_ops->raw_tx_rdy(port);
+}
+
+static void
+mpc52xx_uart_put_char(struct uart_port *port, unsigned char ch)
+{
+	psc_ops->write_char(port, ch);
+}
+
 static void
 mpc52xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
@@ -1336,9 +1348,10 @@ mpc52xx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
-
 static const struct uart_ops mpc52xx_uart_ops = {
 	.tx_empty	= mpc52xx_uart_tx_empty,
+	.tx_ready	= mpc52xx_uart_tx_ready,
+	.put_char	= mpc52xx_uart_put_char,
 	.set_mctrl	= mpc52xx_uart_set_mctrl,
 	.get_mctrl	= mpc52xx_uart_get_mctrl,
 	.stop_tx	= mpc52xx_uart_stop_tx,
@@ -1423,45 +1436,10 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 	return psc_ops->raw_rx_rdy(port);
 }
 
-static inline int
+static inline unsigned int
 mpc52xx_uart_int_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-
-	/* Process out of band chars */
-	if (port->x_char) {
-		psc_ops->write_char(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return 1;
-	}
-
-	/* Nothing to do ? */
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		mpc52xx_uart_stop_tx(port);
-		return 0;
-	}
-
-	/* Send chars */
-	while (psc_ops->raw_tx_rdy(port)) {
-		psc_ops->write_char(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	/* Wake up */
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	/* Maybe we're done after all */
-	if (uart_circ_empty(xmit)) {
-		mpc52xx_uart_stop_tx(port);
-		return 0;
-	}
-
-	return 1;
+	return uart_port_tx(port);
 }
 
 static irqreturn_t
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 5e9429dcc51f..bbb2000032da 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -109,6 +109,16 @@ static unsigned int mps2_uart_tx_empty(struct uart_port *port)
 	return (status & UARTn_STATE_TX_FULL) ? 0 : TIOCSER_TEMT;
 }
 
+static bool mps2_uart_tx_ready(struct uart_port *port)
+{
+	return mps2_uart_tx_empty(port);
+}
+
+static void mps2_uart_put_char(struct uart_port *port, unsigned char ch)
+{
+	mps2_uart_write8(port, ch, UARTn_DATA);
+}
+
 static void mps2_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 }
@@ -127,33 +137,6 @@ static void mps2_uart_stop_tx(struct uart_port *port)
 	mps2_uart_write8(port, control, UARTn_CTRL);
 }
 
-static void mps2_uart_tx_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-
-	while (!(mps2_uart_read8(port, UARTn_STATE) & UARTn_STATE_TX_FULL)) {
-		if (port->x_char) {
-			mps2_uart_write8(port, port->x_char, UARTn_DATA);
-			port->x_char = 0;
-			port->icount.tx++;
-			continue;
-		}
-
-		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-			break;
-
-		mps2_uart_write8(port, xmit->buf[xmit->tail], UARTn_DATA);
-		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		mps2_uart_stop_tx(port);
-}
-
 static void mps2_uart_start_tx(struct uart_port *port)
 {
 	u8 control = mps2_uart_read8(port, UARTn_CTRL);
@@ -168,8 +151,7 @@ static void mps2_uart_start_tx(struct uart_port *port)
 	 * write buffer in one go, the TX IRQ should assert, at which
 	 * point we switch to fully interrupt-driven TX.
 	 */
-
-	mps2_uart_tx_chars(port);
+	uart_port_tx(port);
 }
 
 static void mps2_uart_stop_rx(struct uart_port *port)
@@ -228,7 +210,7 @@ static irqreturn_t mps2_uart_txirq(int irq, void *data)
 	spin_lock(&port->lock);
 
 	mps2_uart_write8(port, UARTn_INT_TX, UARTn_INT);
-	mps2_uart_tx_chars(port);
+	uart_port_tx(port);
 
 	spin_unlock(&port->lock);
 
@@ -413,6 +395,8 @@ static int mps2_uart_verify_port(struct uart_port *port, struct serial_struct *s
 
 static const struct uart_ops mps2_uart_pops = {
 	.tx_empty = mps2_uart_tx_empty,
+	.tx_ready = mps2_uart_tx_ready,
+	.put_char = mps2_uart_put_char,
 	.set_mctrl = mps2_uart_set_mctrl,
 	.get_mctrl = mps2_uart_get_mctrl,
 	.stop_tx = mps2_uart_stop_tx,
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 1944daf8593a..884c47db3e50 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -603,31 +603,10 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 		return;
 	}
 
-
-	while (!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF)) {
-		if (s->port.x_char) {
-			s->port.icount.tx++;
-			mxs_write(s->port.x_char, s, REG_DATA);
-			s->port.x_char = 0;
-			continue;
-		}
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
-			s->port.icount.tx++;
-			mxs_write(xmit->buf[xmit->tail], s, REG_DATA);
-			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		} else
-			break;
-	}
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&s->port);
-
-	if (uart_circ_empty(&(s->port.state->xmit)))
-		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
-	else
+	if (uart_port_tx(&s->port))
 		mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
-
-	if (uart_tx_stopped(&s->port))
-		mxs_auart_stop_tx(&s->port);
+	else
+		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
 }
 
 static void mxs_auart_rx_char(struct mxs_auart_port *s)
@@ -1248,6 +1227,20 @@ static unsigned int mxs_auart_tx_empty(struct uart_port *u)
 	return 0;
 }
 
+static bool mxs_auart_tx_ready(struct uart_port *u)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	return !(mxs_read(s, REG_STAT) & AUART_STAT_TXFF);
+}
+
+static void mxs_auart_put_char(struct uart_port *u, unsigned char ch)
+{
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	mxs_write(ch, s, REG_DATA);
+}
+
 static void mxs_auart_start_tx(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
@@ -1284,6 +1277,8 @@ static void mxs_auart_break_ctl(struct uart_port *u, int ctl)
 
 static const struct uart_ops mxs_auart_ops = {
 	.tx_empty       = mxs_auart_tx_empty,
+	.tx_ready	= mxs_auart_tx_ready,
+	.put_char	= mxs_auart_put_char,
 	.start_tx       = mxs_auart_start_tx,
 	.stop_tx	= mxs_auart_stop_tx,
 	.stop_rx	= mxs_auart_stop_rx,
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 5ff7c89aeb06..0d584b528ee0 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -135,6 +135,16 @@ static unsigned int owl_uart_tx_empty(struct uart_port *port)
 	return ret;
 }
 
+static bool owl_uart_tx_ready(struct uart_port *port)
+{
+	return !(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU);
+}
+
+static void owl_uart_put_char(struct uart_port *port, unsigned char ch)
+{
+	owl_uart_write(port, ch, OWL_UART_TXDAT);
+}
+
 static void owl_uart_stop_rx(struct uart_port *port)
 {
 	u32 val;
@@ -179,39 +189,6 @@ static void owl_uart_start_tx(struct uart_port *port)
 	owl_uart_write(port, val, OWL_UART_CTL);
 }
 
-static void owl_uart_send_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int ch;
-
-	if (port->x_char) {
-		while (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU))
-			cpu_relax();
-		owl_uart_write(port, port->x_char, OWL_UART_TXDAT);
-		port->icount.tx++;
-		port->x_char = 0;
-	}
-
-	if (uart_tx_stopped(port))
-		return;
-
-	while (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)) {
-		if (uart_circ_empty(xmit))
-			break;
-
-		ch = xmit->buf[xmit->tail];
-		owl_uart_write(port, ch, OWL_UART_TXDAT);
-		xmit->tail = (xmit->tail + 1) & (SERIAL_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		owl_uart_stop_tx(port);
-}
-
 static void owl_uart_receive_chars(struct uart_port *port)
 {
 	u32 stat, val;
@@ -264,7 +241,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 		owl_uart_receive_chars(port);
 
 	if (stat & OWL_UART_STAT_TIP)
-		owl_uart_send_chars(port);
+		uart_port_tx(port);
 
 	stat = owl_uart_read(port, OWL_UART_STAT);
 	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
@@ -497,6 +474,8 @@ static const struct uart_ops owl_uart_ops = {
 	.set_mctrl = owl_uart_set_mctrl,
 	.get_mctrl = owl_uart_get_mctrl,
 	.tx_empty = owl_uart_tx_empty,
+	.tx_ready = owl_uart_tx_ready,
+	.put_char = owl_uart_put_char,
 	.start_tx = owl_uart_start_tx,
 	.stop_rx = owl_uart_stop_rx,
 	.stop_tx = owl_uart_stop_tx,
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 5fe6cccfc1ae..ac26ff4358b6 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -228,43 +228,13 @@ sa1100_rx_chars(struct sa1100_port *sport)
 
 static void sa1100_tx_chars(struct sa1100_port *sport)
 {
-	struct circ_buf *xmit = &sport->port.state->xmit;
-
-	if (sport->port.x_char) {
-		UART_PUT_CHAR(sport, sport->port.x_char);
-		sport->port.icount.tx++;
-		sport->port.x_char = 0;
-		return;
-	}
-
 	/*
 	 * Check the modem control lines before
 	 * transmitting anything.
 	 */
 	sa1100_mctrl_check(sport);
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		sa1100_stop_tx(&sport->port);
-		return;
-	}
-
-	/*
-	 * Tried using FIFO (not checking TNF) for fifo fill:
-	 * still had the '4 bytes repeated' problem.
-	 */
-	while (UART_GET_UTSR1(sport) & UTSR1_TNF) {
-		UART_PUT_CHAR(sport, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
-	if (uart_circ_empty(xmit))
-		sa1100_stop_tx(&sport->port);
+	uart_port_tx(&sport->port);
 }
 
 static irqreturn_t sa1100_int(int irq, void *dev_id)
@@ -317,6 +287,22 @@ static unsigned int sa1100_tx_empty(struct uart_port *port)
 	return UART_GET_UTSR1(sport) & UTSR1_TBY ? 0 : TIOCSER_TEMT;
 }
 
+static bool sa1100_tx_ready(struct uart_port *port)
+{
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
+
+	return UART_GET_UTSR1(sport) & UTSR1_TNF;
+}
+
+static void sa1100_put_char(struct uart_port *port, unsigned char ch)
+{
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
+
+	UART_PUT_CHAR(sport, ch);
+}
+
 static unsigned int sa1100_get_mctrl(struct uart_port *port)
 {
 	struct sa1100_port *sport =
@@ -588,6 +574,8 @@ sa1100_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 static struct uart_ops sa1100_pops = {
 	.tx_empty	= sa1100_tx_empty,
+	.tx_ready	= sa1100_tx_ready,
+	.put_char	= sa1100_put_char,
 	.set_mctrl	= sa1100_set_mctrl,
 	.get_mctrl	= sa1100_get_mctrl,
 	.stop_tx	= sa1100_stop_tx,
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 6f08136ce78a..c4cbf6e3b247 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -187,37 +187,6 @@ static void handle_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
-static void handle_tx(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		writeb(port->x_char, port->membase + VT8500_TXFIFO);
-		port->icount.tx++;
-		port->x_char = 0;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		vt8500_stop_tx(port);
-		return;
-	}
-
-	while ((vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16) {
-		if (uart_circ_empty(xmit))
-			break;
-
-		writeb(xmit->buf[xmit->tail], port->membase + VT8500_TXFIFO);
-
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		vt8500_stop_tx(port);
-}
-
 static void vt8500_start_tx(struct uart_port *port)
 {
 	struct vt8500_port *vt8500_port = container_of(port,
@@ -226,7 +195,7 @@ static void vt8500_start_tx(struct uart_port *port)
 
 	vt8500_port->ier &= ~TX_FIFO_INTS;
 	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
-	handle_tx(port);
+	uart_port_tx(port);
 	vt8500_port->ier |= TX_FIFO_INTS;
 	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
 }
@@ -251,7 +220,7 @@ static irqreturn_t vt8500_irq(int irq, void *dev_id)
 	if (isr & RX_FIFO_INTS)
 		handle_rx(port);
 	if (isr & TX_FIFO_INTS)
-		handle_tx(port);
+		uart_port_tx(port);
 	if (isr & TCTS)
 		handle_delta_cts(port);
 
@@ -266,6 +235,16 @@ static unsigned int vt8500_tx_empty(struct uart_port *port)
 						TIOCSER_TEMT : 0;
 }
 
+static bool vt8500_tx_ready(struct uart_port *port)
+{
+	return vt8500_tx_empty(port);
+}
+
+static void vt8500_put_char(struct uart_port *port, unsigned char ch)
+{
+	writeb(ch, port->membase + VT8500_TXFIFO);
+}
+
 static unsigned int vt8500_get_mctrl(struct uart_port *port)
 {
 	unsigned int usr;
@@ -580,6 +559,8 @@ static void vt8500_put_poll_char(struct uart_port *port, unsigned char c)
 
 static const struct uart_ops vt8500_uart_pops = {
 	.tx_empty	= vt8500_tx_empty,
+	.tx_ready	= vt8500_tx_ready,
+	.put_char	= vt8500_put_char,
 	.set_mctrl	= vt8500_set_mctrl,
 	.get_mctrl	= vt8500_get_mctrl,
 	.stop_tx	= vt8500_stop_tx,
-- 
2.35.1

