Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1654C5AE5E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbiIFKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiIFKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:49:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD5696D4;
        Tue,  6 Sep 2022 03:48:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EBE6D1F9C1;
        Tue,  6 Sep 2022 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662461292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HU30k5UvFS9BQ/Sn58l9HDiAqA+o9I58KKZ5gwBcI1o=;
        b=b7bQrcMjiHmUXvujcRQ2s1Q869Fkpr2RjLsIOgxTuOTkBgkqWj9BRofL2igKC+4hEBIjJb
        jJ47M2/3T8mOMvD2AxEA4SUhwKjLSqAtxUegR8bi749/SLR8TdU6VsgmTuwpJIEnWoKuzG
        5UEA0hOXkI0nBCKd+dd7tmaPH2fJFik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662461292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HU30k5UvFS9BQ/Sn58l9HDiAqA+o9I58KKZ5gwBcI1o=;
        b=mnuyLBzvcQikzfZVePWxQvI+rePfwQgYPE4P2M/Ggx9eDR5c072tbeLnV9/wYkCPBPuug5
        SLS5xBWc0aswE+Aw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 406DF2C142;
        Tue,  6 Sep 2022 10:48:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH v3 3/4] tty: serial: use DEFINE_UART_PORT_TX_HELPER()
Date:   Tue,  6 Sep 2022 12:48:04 +0200
Message-Id: <20220906104805.23211-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906104805.23211-1-jslaby@suse.cz>
References: <20220906104805.23211-1-jslaby@suse.cz>
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

DEFINE_UART_PORT_TX_HELPER() is a new helper to send characters to the
device. Use it in these drivers.

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

Notes:
    [v3] remove stray \n removal (Ilpo)

 drivers/tty/serial/altera_uart.c   | 37 +++-------------------
 drivers/tty/serial/atmel_serial.c  | 29 +++++-------------
 drivers/tty/serial/fsl_lpuart.c    | 38 ++++++-----------------
 drivers/tty/serial/lantiq.c        | 44 ++++++++-------------------
 drivers/tty/serial/lpc32xx_hs.c    | 38 +++++------------------
 drivers/tty/serial/mcf.c           | 27 +++-------------
 drivers/tty/serial/mpc52xx_uart.c  | 43 ++------------------------
 drivers/tty/serial/mps2-uart.c     | 29 ++----------------
 drivers/tty/serial/mxs-auart.c     | 31 +++++--------------
 drivers/tty/serial/owl-uart.c      | 35 ++-------------------
 drivers/tty/serial/sa1100.c        | 49 ++++++++++++------------------
 drivers/tty/serial/vt8500_serial.c | 33 ++------------------
 12 files changed, 84 insertions(+), 349 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 8b749ed557c6..70c0ad431cf9 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -246,37 +246,10 @@ static void altera_uart_rx_chars(struct altera_uart *pp)
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
+static DEFINE_UART_PORT_TX_HELPER(altera_uart_tx_chars,
+		altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
+		                ALTERA_UART_STATUS_TRDY_MSK,
+		altera_uart_writel(port, ch, ALTERA_UART_TXDATA_REG));
 
 static irqreturn_t altera_uart_interrupt(int irq, void *data)
 {
@@ -290,7 +263,7 @@ static irqreturn_t altera_uart_interrupt(int irq, void *data)
 	if (isr & ALTERA_UART_STATUS_RRDY_MSK)
 		altera_uart_rx_chars(pp);
 	if (isr & ALTERA_UART_STATUS_TRDY_MSK)
-		altera_uart_tx_chars(pp);
+		altera_uart_tx_chars(&pp->port);
 	spin_unlock(&port->lock);
 
 	return IRQ_RETVAL(isr);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 30ba9eef7b39..98c338df1e99 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -812,36 +812,21 @@ static void atmel_rx_chars(struct uart_port *port)
 	atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
 }
 
+static DEFINE_UART_PORT_TX_HELPER(atmel_do_tx_chars,
+		atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY,
+		atmel_uart_write_char(port, ch));
+
 /*
  * Transmit characters (called from tasklet with TXRDY interrupt
  * disabled)
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
+	pending = atmel_do_tx_chars(port);
+	if (pending) {
 		/* we still have characters to transmit, so we should continue
 		 * transmitting them when TX is ready, regardless of
 		 * mode or duplexity
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6c33cd228c8..7c64cadcfbf3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -740,36 +740,18 @@ static int lpuart32_poll_get_char(struct uart_port *port)
 }
 #endif
 
-static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
+static bool lpuart_tx_ready(struct uart_port *port)
 {
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
+	struct lpuart_port *sport = container_of(port, struct lpuart_port,
+			port);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
-	if (uart_circ_empty(xmit))
-		lpuart_stop_tx(&sport->port);
+	return readb(port->membase + UARTTCFIFO) < sport->txfifo_size;
 }
 
+static DEFINE_UART_PORT_TX_HELPER(lpuart_transmit_buffer,
+		lpuart_tx_ready(port),
+		writeb(ch, port->membase + UARTDR));
+
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct circ_buf *xmit = &sport->port.state->xmit;
@@ -820,7 +802,7 @@ static void lpuart_start_tx(struct uart_port *port)
 			lpuart_dma_tx(sport);
 	} else {
 		if (readb(port->membase + UARTSR1) & UARTSR1_TDRE)
-			lpuart_transmit_buffer(sport);
+			lpuart_transmit_buffer(&sport->port);
 	}
 }
 
@@ -877,7 +859,7 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 static void lpuart_txint(struct lpuart_port *sport)
 {
 	spin_lock(&sport->port.lock);
-	lpuart_transmit_buffer(sport);
+	lpuart_transmit_buffer(&sport->port);
 	spin_unlock(&sport->port.lock);
 }
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index a3120c3347dd..874568f417bf 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -95,7 +95,6 @@
 #define ASCFSTAT_TXFREEMASK	0x3F000000
 #define ASCFSTAT_TXFREEOFF	24
 
-static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
 
@@ -139,6 +138,18 @@ lqasc_stop_tx(struct uart_port *port)
 	return;
 }
 
+static bool
+lqasc_tx_ready(struct uart_port *port)
+{
+	u32 fstat = __raw_readl(port->membase + LTQ_ASC_FSTAT);
+
+	return (fstat & ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
+}
+
+static DEFINE_UART_PORT_TX_HELPER(lqasc_tx_chars,
+		lqasc_tx_ready(port),
+		writeb(ch, port->membase + LTQ_ASC_TBUF));
+
 static void
 lqasc_start_tx(struct uart_port *port)
 {
@@ -219,37 +230,6 @@ lqasc_rx_chars(struct uart_port *port)
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
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 93140cac1ca1..f0693e591864 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -276,41 +276,17 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
-static void serial_lpc32xx_stop_tx(struct uart_port *port);
-
-static void __serial_lpc32xx_tx(struct uart_port *port)
+static bool serial_lpc32xx_tx_ready(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
+	u32 level = readl(LPC32XX_HSUART_LEVEL(port->membase));
 
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
+	return LPC32XX_HSU_TX_LEV(level) < 64;
 }
 
+static DEFINE_UART_PORT_TX_HELPER(__serial_lpc32xx_tx,
+		serial_lpc32xx_tx_ready(port),
+		writel(ch, LPC32XX_HSUART_FIFO(port->membase)));
+
 static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index f4aaaadd0742..735e6f261b64 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -324,32 +324,15 @@ static void mcf_rx_chars(struct mcf_uart *pp)
 
 /****************************************************************************/
 
+static DEFINE_UART_PORT_TX_HELPER(mcf_do_tx_chars,
+		readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY,
+		writeb(ch, port->membase + MCFUART_UTB));
+
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
+	if (!mcf_do_tx_chars(port)) {
 		/* Disable TX to negate RTS automatically */
 		if (port->rs485.flags & SER_RS485_ENABLED)
 			writeb(MCFUART_UCR_TXDISABLE,
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3f1986c89694..16edf80284bd 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1425,46 +1425,9 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 	return psc_ops->raw_rx_rdy(port);
 }
 
-static inline int
-mpc52xx_uart_int_tx_chars(struct uart_port *port)
-{
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
-}
+static DEFINE_UART_PORT_TX_HELPER(mpc52xx_uart_int_tx_chars,
+		psc_ops->raw_tx_rdy(port),
+		psc_ops->write_char(port, ch));
 
 static irqreturn_t
 mpc5xxx_uart_process_int(struct uart_port *port)
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 5e9429dcc51f..771598bf5b38 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -127,32 +127,9 @@ static void mps2_uart_stop_tx(struct uart_port *port)
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
+static DEFINE_UART_PORT_TX_HELPER(mps2_uart_tx_chars,
+		mps2_uart_tx_empty(port),
+		mps2_uart_write8(port, ch, UARTn_DATA));
 
 static void mps2_uart_start_tx(struct uart_port *port)
 {
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 1944daf8593a..063c50090d13 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -566,6 +566,10 @@ static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
 	return 0;
 }
 
+static DEFINE_UART_PORT_TX_HELPER(mxs_auart_do_tx_chars,
+		!(mxs_read(to_auart_port(port), REG_STAT) & AUART_STAT_TXFF),
+		mxs_write(ch, to_auart_port(port), REG_DATA));
+
 static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 {
 	struct circ_buf *xmit = &s->port.state->xmit;
@@ -603,31 +607,10 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
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
+	if (mxs_auart_do_tx_chars(&s->port))
 		mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
-
-	if (uart_tx_stopped(&s->port))
-		mxs_auart_stop_tx(&s->port);
+	else
+		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
 }
 
 static void mxs_auart_rx_char(struct mxs_auart_port *s)
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 888e17e3f25f..cc3abdc02f19 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -179,38 +179,9 @@ static void owl_uart_start_tx(struct uart_port *port)
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
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		owl_uart_stop_tx(port);
-}
+static DEFINE_UART_PORT_TX_HELPER(owl_uart_send_chars,
+		!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU),
+		owl_uart_write(port, ch, OWL_UART_TXDAT));
 
 static void owl_uart_receive_chars(struct uart_port *port)
 {
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index e64e42a19d1a..66ff452700e5 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -226,45 +226,34 @@ sa1100_rx_chars(struct sa1100_port *sport)
 	tty_flip_buffer_push(&sport->port.state->port);
 }
 
-static void sa1100_tx_chars(struct sa1100_port *sport)
+static bool sa1100_tx_ready(struct uart_port *port)
 {
-	struct circ_buf *xmit = &sport->port.state->xmit;
+	struct sa1100_port *sport =
+		container_of(port, struct sa1100_port, port);
 
-	if (sport->port.x_char) {
-		UART_PUT_CHAR(sport, sport->port.x_char);
-		sport->port.icount.tx++;
-		sport->port.x_char = 0;
-		return;
-	}
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
 
+static DEFINE_UART_PORT_TX_HELPER(sa1100_do_tx_chars,
+		sa1100_tx_ready(port), sa1100_put_char(port, ch));
+
+static void sa1100_tx_chars(struct sa1100_port *sport)
+{
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
+	sa1100_do_tx_chars(&sport->port);
 }
 
 static irqreturn_t sa1100_int(int irq, void *dev_id)
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 9e2c745b4535..bd755254d59d 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -194,36 +194,9 @@ static unsigned int vt8500_tx_empty(struct uart_port *port)
 	return idx < 16 ? TIOCSER_TEMT : 0;
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
-	while (vt8500_tx_empty(port)) {
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
+static DEFINE_UART_PORT_TX_HELPER(handle_tx,
+		vt8500_tx_empty(port),
+		writeb(ch, port->membase + VT8500_TXFIFO));
 
 static void vt8500_start_tx(struct uart_port *port)
 {
-- 
2.37.3

