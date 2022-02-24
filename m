Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416364C2A85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiBXLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiBXLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:11:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581412905A3;
        Thu, 24 Feb 2022 03:10:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 143FB212B6;
        Thu, 24 Feb 2022 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645701030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pj/WASmNBm2vKpc65J25SbBeZFSQJGul5ARSkIkJDv0=;
        b=gJKTei/XJeCxWpQ5CTIdU4f5+07KecfrBaV9WWtx8HG+s3KjI3xgF0ojI9ojnls4DHW9fT
        iwOGGUilr+MZjm2JpcUofv3clOON7el0asK24sA1tAgnT0sohBjRzLgkN0Lt8FHo0RZ1yg
        7T3ofkt78rpJXMHzHKzM8Uw76XskCrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645701030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pj/WASmNBm2vKpc65J25SbBeZFSQJGul5ARSkIkJDv0=;
        b=GODSpm1hsQofHgi/GBOH/hIKi9KS/V8q7aYNaOXJFTepmayUTY4MV5OOl1mYbRihf4Kpk3
        pKwFnmEPdrvOJOAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D56A1A3B85;
        Thu, 24 Feb 2022 11:10:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 4/5] tty: serial: amba-pl010: use more uart_port pointers
Date:   Thu, 24 Feb 2022 12:10:27 +0100
Message-Id: <20220224111028.20917-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224111028.20917-1-jslaby@suse.cz>
References: <20220224111028.20917-1-jslaby@suse.cz>
MIME-Version: 1.0
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

The code uses uart_amba_port::port on many places. Sometimes it even
needs not uart_amba_port itself. So simplify the code on many places
and remove the need of uart_amba_port on some places completely.

No functional changes intended. The objdump -d output shows only a code
move in pl010_rx_chars().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/tty/serial/amba-pl010.c | 174 +++++++++++++++-----------------
 1 file changed, 84 insertions(+), 90 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 896f66cacf8b..fae0b581ff42 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -110,38 +110,38 @@ static void pl010_enable_ms(struct uart_port *port)
 	writel(cr, uap->port.membase + UART010_CR);
 }
 
-static void pl010_rx_chars(struct uart_amba_port *uap)
+static void pl010_rx_chars(struct uart_port *port)
 {
 	unsigned int status, ch, flag, rsr, max_count = 256;
 
-	status = readb(uap->port.membase + UART01x_FR);
+	status = readb(port->membase + UART01x_FR);
 	while (UART_RX_DATA(status) && max_count--) {
-		ch = readb(uap->port.membase + UART01x_DR);
+		ch = readb(port->membase + UART01x_DR);
 		flag = TTY_NORMAL;
 
-		uap->port.icount.rx++;
+		port->icount.rx++;
 
 		/*
 		 * Note that the error handling code is
 		 * out of the main execution path
 		 */
-		rsr = readb(uap->port.membase + UART01x_RSR) | UART_DUMMY_RSR_RX;
+		rsr = readb(port->membase + UART01x_RSR) | UART_DUMMY_RSR_RX;
 		if (unlikely(rsr & UART01x_RSR_ANY)) {
-			writel(0, uap->port.membase + UART01x_ECR);
+			writel(0, port->membase + UART01x_ECR);
 
 			if (rsr & UART01x_RSR_BE) {
 				rsr &= ~(UART01x_RSR_FE | UART01x_RSR_PE);
-				uap->port.icount.brk++;
-				if (uart_handle_break(&uap->port))
+				port->icount.brk++;
+				if (uart_handle_break(port))
 					goto ignore_char;
 			} else if (rsr & UART01x_RSR_PE)
-				uap->port.icount.parity++;
+				port->icount.parity++;
 			else if (rsr & UART01x_RSR_FE)
-				uap->port.icount.frame++;
+				port->icount.frame++;
 			if (rsr & UART01x_RSR_OE)
-				uap->port.icount.overrun++;
+				port->icount.overrun++;
 
-			rsr &= uap->port.read_status_mask;
+			rsr &= port->read_status_mask;
 
 			if (rsr & UART01x_RSR_BE)
 				flag = TTY_BREAK;
@@ -151,56 +151,57 @@ static void pl010_rx_chars(struct uart_amba_port *uap)
 				flag = TTY_FRAME;
 		}
 
-		if (uart_handle_sysrq_char(&uap->port, ch))
+		if (uart_handle_sysrq_char(port, ch))
 			goto ignore_char;
 
-		uart_insert_char(&uap->port, rsr, UART01x_RSR_OE, ch, flag);
+		uart_insert_char(port, rsr, UART01x_RSR_OE, ch, flag);
 
 	ignore_char:
-		status = readb(uap->port.membase + UART01x_FR);
+		status = readb(port->membase + UART01x_FR);
 	}
-	tty_flip_buffer_push(&uap->port.state->port);
+	tty_flip_buffer_push(&port->state->port);
 }
 
-static void pl010_tx_chars(struct uart_amba_port *uap)
+static void pl010_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &uap->port.state->xmit;
+	struct circ_buf *xmit = &port->state->xmit;
 	int count;
 
-	if (uap->port.x_char) {
-		writel(uap->port.x_char, uap->port.membase + UART01x_DR);
-		uap->port.icount.tx++;
-		uap->port.x_char = 0;
+	if (port->x_char) {
+		writel(port->x_char, port->membase + UART01x_DR);
+		port->icount.tx++;
+		port->x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
-		pl010_stop_tx(&uap->port);
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		pl010_stop_tx(port);
 		return;
 	}
 
-	count = uap->port.fifosize >> 1;
+	count = port->fifosize >> 1;
 	do {
-		writel(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
+		writel(xmit->buf[xmit->tail], port->membase + UART01x_DR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		uap->port.icount.tx++;
+		port->icount.tx++;
 		if (uart_circ_empty(xmit))
 			break;
 	} while (--count > 0);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&uap->port);
+		uart_write_wakeup(port);
 
 	if (uart_circ_empty(xmit))
-		pl010_stop_tx(&uap->port);
+		pl010_stop_tx(port);
 }
 
 static void pl010_modem_status(struct uart_amba_port *uap)
 {
+	struct uart_port *port = &uap->port;
 	unsigned int status, delta;
 
-	writel(0, uap->port.membase + UART010_ICR);
+	writel(0, port->membase + UART010_ICR);
 
-	status = readb(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
+	status = readb(port->membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
 
 	delta = status ^ uap->old_status;
 	uap->old_status = status;
@@ -209,65 +210,63 @@ static void pl010_modem_status(struct uart_amba_port *uap)
 		return;
 
 	if (delta & UART01x_FR_DCD)
-		uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
+		uart_handle_dcd_change(port, status & UART01x_FR_DCD);
 
 	if (delta & UART01x_FR_DSR)
-		uap->port.icount.dsr++;
+		port->icount.dsr++;
 
 	if (delta & UART01x_FR_CTS)
-		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
+		uart_handle_cts_change(port, status & UART01x_FR_CTS);
 
-	wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
+	wake_up_interruptible(&port->state->port.delta_msr_wait);
 }
 
 static irqreturn_t pl010_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
+	struct uart_port *port = &uap->port;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
 
-	spin_lock(&uap->port.lock);
+	spin_lock(&port->lock);
 
-	status = readb(uap->port.membase + UART010_IIR);
+	status = readb(port->membase + UART010_IIR);
 	if (status) {
 		do {
 			if (status & (UART010_IIR_RTIS | UART010_IIR_RIS))
-				pl010_rx_chars(uap);
+				pl010_rx_chars(port);
 			if (status & UART010_IIR_MIS)
 				pl010_modem_status(uap);
 			if (status & UART010_IIR_TIS)
-				pl010_tx_chars(uap);
+				pl010_tx_chars(port);
 
 			if (pass_counter-- == 0)
 				break;
 
-			status = readb(uap->port.membase + UART010_IIR);
+			status = readb(port->membase + UART010_IIR);
 		} while (status & (UART010_IIR_RTIS | UART010_IIR_RIS |
 				   UART010_IIR_TIS));
 		handled = 1;
 	}
 
-	spin_unlock(&uap->port.lock);
+	spin_unlock(&port->lock);
 
 	return IRQ_RETVAL(handled);
 }
 
 static unsigned int pl010_tx_empty(struct uart_port *port)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
-	unsigned int status = readb(uap->port.membase + UART01x_FR);
+	unsigned int status = readb(port->membase + UART01x_FR);
+
 	return status & UART01x_FR_BUSY ? 0 : TIOCSER_TEMT;
 }
 
 static unsigned int pl010_get_mctrl(struct uart_port *port)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
 	unsigned int result = 0;
 	unsigned int status;
 
-	status = readb(uap->port.membase + UART01x_FR);
+	status = readb(port->membase + UART01x_FR);
 	if (status & UART01x_FR_DCD)
 		result |= TIOCM_CAR;
 	if (status & UART01x_FR_DSR)
@@ -284,24 +283,22 @@ static void pl010_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		container_of(port, struct uart_amba_port, port);
 
 	if (uap->data)
-		uap->data->set_mctrl(uap->dev, uap->port.membase, mctrl);
+		uap->data->set_mctrl(uap->dev, port->membase, mctrl);
 }
 
 static void pl010_break_ctl(struct uart_port *port, int break_state)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
 	unsigned long flags;
 	unsigned int lcr_h;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
-	lcr_h = readb(uap->port.membase + UART010_LCRH);
+	spin_lock_irqsave(&port->lock, flags);
+	lcr_h = readb(port->membase + UART010_LCRH);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
-	writel(lcr_h, uap->port.membase + UART010_LCRH);
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	writel(lcr_h, port->membase + UART010_LCRH);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int pl010_startup(struct uart_port *port)
@@ -317,25 +314,25 @@ static int pl010_startup(struct uart_port *port)
 	if (retval)
 		goto out;
 
-	uap->port.uartclk = clk_get_rate(uap->clk);
+	port->uartclk = clk_get_rate(uap->clk);
 
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(uap->port.irq, pl010_int, 0, "uart-pl010", uap);
+	retval = request_irq(port->irq, pl010_int, 0, "uart-pl010", uap);
 	if (retval)
 		goto clk_dis;
 
 	/*
 	 * initialise the old status of the modem signals
 	 */
-	uap->old_status = readb(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
+	uap->old_status = readb(port->membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
 
 	/*
 	 * Finally, enable interrupts
 	 */
 	writel(UART01x_CR_UARTEN | UART010_CR_RIE | UART010_CR_RTIE,
-	       uap->port.membase + UART010_CR);
+	       port->membase + UART010_CR);
 
 	return 0;
 
@@ -353,17 +350,17 @@ static void pl010_shutdown(struct uart_port *port)
 	/*
 	 * Free the interrupt
 	 */
-	free_irq(uap->port.irq, uap);
+	free_irq(port->irq, uap);
 
 	/*
 	 * disable all interrupts, disable the port
 	 */
-	writel(0, uap->port.membase + UART010_CR);
+	writel(0, port->membase + UART010_CR);
 
 	/* disable break condition and fifos */
-	writel(readb(uap->port.membase + UART010_LCRH) &
+	writel(readb(port->membase + UART010_LCRH) &
 		~(UART01x_LCRH_BRK | UART01x_LCRH_FEN),
-	       uap->port.membase + UART010_LCRH);
+	       port->membase + UART010_LCRH);
 
 	/*
 	 * Shut down the clock producer
@@ -375,8 +372,6 @@ static void
 pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 		     struct ktermios *old)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
 	unsigned int lcr_h, old_cr;
 	unsigned long flags;
 	unsigned int baud, quot;
@@ -384,7 +379,7 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, uap->port.uartclk/16); 
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
 	quot = uart_get_divisor(port, baud);
 
 	switch (termios->c_cflag & CSIZE) {
@@ -408,63 +403,63 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (!(termios->c_cflag & PARODD))
 			lcr_h |= UART01x_LCRH_EPS;
 	}
-	if (uap->port.fifosize > 1)
+	if (port->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/*
 	 * Update the per-port timeout.
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	uap->port.read_status_mask = UART01x_RSR_OE;
+	port->read_status_mask = UART01x_RSR_OE;
 	if (termios->c_iflag & INPCK)
-		uap->port.read_status_mask |= UART01x_RSR_FE | UART01x_RSR_PE;
+		port->read_status_mask |= UART01x_RSR_FE | UART01x_RSR_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		uap->port.read_status_mask |= UART01x_RSR_BE;
+		port->read_status_mask |= UART01x_RSR_BE;
 
 	/*
 	 * Characters to ignore
 	 */
-	uap->port.ignore_status_mask = 0;
+	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		uap->port.ignore_status_mask |= UART01x_RSR_FE | UART01x_RSR_PE;
+		port->ignore_status_mask |= UART01x_RSR_FE | UART01x_RSR_PE;
 	if (termios->c_iflag & IGNBRK) {
-		uap->port.ignore_status_mask |= UART01x_RSR_BE;
+		port->ignore_status_mask |= UART01x_RSR_BE;
 		/*
 		 * If we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			uap->port.ignore_status_mask |= UART01x_RSR_OE;
+			port->ignore_status_mask |= UART01x_RSR_OE;
 	}
 
 	/*
 	 * Ignore all characters if CREAD is not set.
 	 */
 	if ((termios->c_cflag & CREAD) == 0)
-		uap->port.ignore_status_mask |= UART_DUMMY_RSR_RX;
+		port->ignore_status_mask |= UART_DUMMY_RSR_RX;
 
-	old_cr = readb(uap->port.membase + UART010_CR) & ~UART010_CR_MSIE;
+	old_cr = readb(port->membase + UART010_CR) & ~UART010_CR_MSIE;
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
 		old_cr |= UART010_CR_MSIE;
 
 	/* Set baud rate */
 	quot -= 1;
-	writel((quot & 0xf00) >> 8, uap->port.membase + UART010_LCRM);
-	writel(quot & 0xff, uap->port.membase + UART010_LCRL);
+	writel((quot & 0xf00) >> 8, port->membase + UART010_LCRM);
+	writel(quot & 0xff, port->membase + UART010_LCRL);
 
 	/*
 	 * ----------v----------v----------v----------v-----
 	 * NOTE: MUST BE WRITTEN AFTER UARTLCR_M & UARTLCR_L
 	 * ----------^----------^----------^----------^-----
 	 */
-	writel(lcr_h, uap->port.membase + UART010_LCRH);
-	writel(old_cr, uap->port.membase + UART010_CR);
+	writel(lcr_h, port->membase + UART010_LCRH);
+	writel(old_cr, port->membase + UART010_CR);
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void pl010_set_ldisc(struct uart_port *port, struct ktermios *termios)
@@ -558,21 +553,20 @@ static struct uart_amba_port *amba_ports[UART_NR];
 
 static void pl010_console_putchar(struct uart_port *port, unsigned char ch)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
 	unsigned int status;
 
 	do {
-		status = readb(uap->port.membase + UART01x_FR);
+		status = readb(port->membase + UART01x_FR);
 		barrier();
 	} while (!UART_TX_READY(status));
-	writel(ch, uap->port.membase + UART01x_DR);
+	writel(ch, port->membase + UART01x_DR);
 }
 
 static void
 pl010_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
+	struct uart_port *port = &uap->port;
 	unsigned int status, old_cr;
 
 	clk_enable(uap->clk);
@@ -580,20 +574,20 @@ pl010_console_write(struct console *co, const char *s, unsigned int count)
 	/*
 	 *	First save the CR then disable the interrupts
 	 */
-	old_cr = readb(uap->port.membase + UART010_CR);
-	writel(UART01x_CR_UARTEN, uap->port.membase + UART010_CR);
+	old_cr = readb(port->membase + UART010_CR);
+	writel(UART01x_CR_UARTEN, port->membase + UART010_CR);
 
-	uart_console_write(&uap->port, s, count, pl010_console_putchar);
+	uart_console_write(port, s, count, pl010_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the TCR
 	 */
 	do {
-		status = readb(uap->port.membase + UART01x_FR);
+		status = readb(port->membase + UART01x_FR);
 		barrier();
 	} while (status & UART01x_FR_BUSY);
-	writel(old_cr, uap->port.membase + UART010_CR);
+	writel(old_cr, port->membase + UART010_CR);
 
 	clk_disable(uap->clk);
 }
-- 
2.35.1

