Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC14FBA34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiDKK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345758AbiDKK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:56:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D82C79;
        Mon, 11 Apr 2022 03:54:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21ED0215FD;
        Mon, 11 Apr 2022 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r49EueKp2Br8vDmcdTb/MEqeUHETgXaKsz+9XB5AYis=;
        b=1rqsZFfK3No3fmZqQiaAOHqUkKubSrXN+R9BZLf2QB7iTkcHXVOc+Du1Zx9CgSUAbBI31c
        dxL2joIscXLjkj2NCfHU+b0lCDavkI9dUy7Wd8riU9PsPLPKpSi9UeDfs50Fi1GLI6Sgys
        R+h2xWrTU0Sm0S8TkyF5oyKNYpe1uw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r49EueKp2Br8vDmcdTb/MEqeUHETgXaKsz+9XB5AYis=;
        b=+9UGdV6/Obkk/sp514m0mryoV6fFb/rJytQNc3etkkrOok/mDC1AYpHErvGI3CEaEat8xK
        mXTHkPua1zekONAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E034A3B89;
        Mon, 11 Apr 2022 10:54:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] tty: serial: use uart_port_tx_limit() helper
Date:   Mon, 11 Apr 2022 12:54:05 +0200
Message-Id: <20220411105405.9519-4-jslaby@suse.cz>
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

uart_port_tx_limit() is a new helper to send characters to the device.
Use it in these drivers.

It means we have to define two new uart hooks: tx_ready() and put_char()
to do the real job now.

And mux.c also needs to define tx_done(). But I'm not sure if the driver
really wants to wait for all the characters to dismiss from the HW fifo
at this code point. Hence I marked this as FIXME.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-riscv@lists.infradead.org
---
 drivers/tty/serial/21285.c           | 40 +++++++--------------
 drivers/tty/serial/altera_jtaguart.c | 43 ++++++----------------
 drivers/tty/serial/amba-pl010.c      | 40 ++++-----------------
 drivers/tty/serial/apbuart.c         | 37 ++++---------------
 drivers/tty/serial/bcm63xx_uart.c    | 48 ++++++-------------------
 drivers/tty/serial/mux.c             | 48 ++++++++-----------------
 drivers/tty/serial/mvebu-uart.c      | 47 +++++++-----------------
 drivers/tty/serial/omap-serial.c     | 53 +++++++---------------------
 drivers/tty/serial/pxa.c             | 43 +++++-----------------
 drivers/tty/serial/rp2.c             | 36 ++++++-------------
 drivers/tty/serial/serial_txx9.c     | 40 ++++-----------------
 drivers/tty/serial/sifive.c          | 48 ++++---------------------
 drivers/tty/serial/sprd_serial.c     | 41 ++++-----------------
 drivers/tty/serial/st-asc.c          | 51 ++++----------------------
 drivers/tty/serial/vr41xx_siu.c      | 42 ++++------------------
 15 files changed, 143 insertions(+), 514 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 7520cc02fd4d..12d9bdcd67b8 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -154,35 +154,9 @@ static irqreturn_t serial21285_rx_chars(int irq, void *dev_id)
 static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct circ_buf *xmit = &port->state->xmit;
-	int count = 256;
-
-	if (port->x_char) {
-		*CSR_UARTDR = port->x_char;
-		port->icount.tx++;
-		port->x_char = 0;
-		goto out;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		serial21285_stop_tx(port);
-		goto out;
-	}
-
-	do {
-		*CSR_UARTDR = xmit->buf[xmit->tail];
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0 && !(*CSR_UARTFLG & 0x20));
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
 
-	if (uart_circ_empty(xmit))
-		serial21285_stop_tx(port);
+	uart_port_tx_limit(port, 256);
 
- out:
 	return IRQ_HANDLED;
 }
 
@@ -191,6 +165,16 @@ static unsigned int serial21285_tx_empty(struct uart_port *port)
 	return (*CSR_UARTFLG & 8) ? 0 : TIOCSER_TEMT;
 }
 
+static bool serial21285_uart_tx_ready(struct uart_port *port)
+{
+	return !(*CSR_UARTFLG & 0x20);
+}
+
+static void serial21285_put_char(struct uart_port *port, unsigned char ch)
+{
+	*CSR_UARTDR = ch;
+}
+
 /* no modem control lines */
 static unsigned int serial21285_get_mctrl(struct uart_port *port)
 {
@@ -372,6 +356,8 @@ static int serial21285_verify_port(struct uart_port *port, struct serial_struct
 
 static const struct uart_ops serial21285_ops = {
 	.tx_empty	= serial21285_tx_empty,
+	.tx_ready	= serial21285_uart_tx_ready,
+	.put_char	= serial21285_put_char,
 	.get_mctrl	= serial21285_get_mctrl,
 	.set_mctrl	= serial21285_set_mctrl,
 	.stop_tx	= serial21285_stop_tx,
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index cb791c5149a3..144cb4ab337b 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -65,6 +65,11 @@ static unsigned int altera_jtaguart_tx_empty(struct uart_port *port)
 		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) ? TIOCSER_TEMT : 0;
 }
 
+static void altera_jtaguart_put_char(struct uart_port *port, unsigned char ch)
+{
+	writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG);
+}
+
 static unsigned int altera_jtaguart_get_mctrl(struct uart_port *port)
 {
 	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -137,39 +142,12 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
 {
 	struct uart_port *port = &pp->port;
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int pending, count;
-
-	if (port->x_char) {
-		/* Send special char - probably flow control */
-		writel(port->x_char, port->membase + ALTERA_JTAGUART_DATA_REG);
-		port->x_char = 0;
-		port->icount.tx++;
-		return;
-	}
-
-	pending = uart_circ_chars_pending(xmit);
-	if (pending > 0) {
-		count = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
-				ALTERA_JTAGUART_CONTROL_WSPACE_MSK) >>
-			ALTERA_JTAGUART_CONTROL_WSPACE_OFF;
-		if (count > pending)
-			count = pending;
-		if (count > 0) {
-			pending -= count;
-			while (count--) {
-				writel(xmit->buf[xmit->tail],
-				       port->membase + ALTERA_JTAGUART_DATA_REG);
-				xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-				port->icount.tx++;
-			}
-			if (pending < WAKEUP_CHARS)
-				uart_write_wakeup(port);
-		}
-	}
+	unsigned int space;
 
-	if (pending == 0)
-		altera_jtaguart_stop_tx(port);
+	space = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
+			ALTERA_JTAGUART_CONTROL_WSPACE_MSK) >>
+		ALTERA_JTAGUART_CONTROL_WSPACE_OFF;
+	uart_port_tx_limit(port, space);
 }
 
 static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
@@ -274,6 +252,7 @@ static int altera_jtaguart_verify_port(struct uart_port *port,
  */
 static const struct uart_ops altera_jtaguart_ops = {
 	.tx_empty	= altera_jtaguart_tx_empty,
+	.put_char       = altera_jtaguart_put_char,
 	.get_mctrl	= altera_jtaguart_get_mctrl,
 	.set_mctrl	= altera_jtaguart_set_mctrl,
 	.start_tx	= altera_jtaguart_start_tx,
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index fae0b581ff42..1d73e1ba318b 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -162,38 +162,6 @@ static void pl010_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static void pl010_tx_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	int count;
-
-	if (port->x_char) {
-		writel(port->x_char, port->membase + UART01x_DR);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		pl010_stop_tx(port);
-		return;
-	}
-
-	count = port->fifosize >> 1;
-	do {
-		writel(xmit->buf[xmit->tail], port->membase + UART01x_DR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		pl010_stop_tx(port);
-}
-
 static void pl010_modem_status(struct uart_amba_port *uap)
 {
 	struct uart_port *port = &uap->port;
@@ -238,7 +206,7 @@ static irqreturn_t pl010_int(int irq, void *dev_id)
 			if (status & UART010_IIR_MIS)
 				pl010_modem_status(uap);
 			if (status & UART010_IIR_TIS)
-				pl010_tx_chars(port);
+				uart_port_tx_limit(port, port->fifosize >> 1);
 
 			if (pass_counter-- == 0)
 				break;
@@ -261,6 +229,11 @@ static unsigned int pl010_tx_empty(struct uart_port *port)
 	return status & UART01x_FR_BUSY ? 0 : TIOCSER_TEMT;
 }
 
+static void pl010_put_char(struct uart_port *port, unsigned char ch)
+{
+	writel(ch, port->membase + UART01x_DR);
+}
+
 static unsigned int pl010_get_mctrl(struct uart_port *port)
 {
 	unsigned int result = 0;
@@ -529,6 +502,7 @@ static int pl010_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 static const struct uart_ops amba_pl010_pops = {
 	.tx_empty	= pl010_tx_empty,
+	.put_char	= pl010_put_char,
 	.set_mctrl	= pl010_set_mctrl,
 	.get_mctrl	= pl010_get_mctrl,
 	.stop_tx	= pl010_stop_tx,
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 9ef82d870ff2..a31bd5849c76 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -122,36 +122,7 @@ static void apbuart_rx_chars(struct uart_port *port)
 
 static void apbuart_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	int count;
-
-	if (port->x_char) {
-		UART_PUT_CHAR(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		apbuart_stop_tx(port);
-		return;
-	}
-
-	/* amba: fill FIFO */
-	count = port->fifosize >> 1;
-	do {
-		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		apbuart_stop_tx(port);
+	uart_port_tx_limit(port, port->fifosize >> 1);
 }
 
 static irqreturn_t apbuart_int(int irq, void *dev_id)
@@ -178,6 +149,11 @@ static unsigned int apbuart_tx_empty(struct uart_port *port)
 	return status & UART_STATUS_THE ? TIOCSER_TEMT : 0;
 }
 
+static void apbuart_put_char(struct uart_port *port, unsigned char ch)
+{
+	UART_PUT_CHAR(port, ch);
+}
+
 static unsigned int apbuart_get_mctrl(struct uart_port *port)
 {
 	/* The GRLIB APBUART handles flow control in hardware */
@@ -322,6 +298,7 @@ static int apbuart_verify_port(struct uart_port *port,
 
 static const struct uart_ops grlib_apbuart_ops = {
 	.tx_empty = apbuart_tx_empty,
+	.put_char = apbuart_put_char,
 	.set_mctrl = apbuart_set_mctrl,
 	.get_mctrl = apbuart_get_mctrl,
 	.stop_tx = apbuart_stop_tx,
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 53b43174aa40..29f31286ff54 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -93,6 +93,11 @@ static unsigned int bcm_uart_tx_empty(struct uart_port *port)
 	return (val & UART_IR_STAT(UART_IR_TXEMPTY)) ? 1 : 0;
 }
 
+static void bcm_uart_put_char(struct uart_port *port, unsigned char ch)
+{
+	bcm_uart_writel(port, ch, UART_FIFO_REG);
+}
+
 /*
  * serial core request to set RTS and DTR pin state and loopback mode
  */
@@ -303,53 +308,19 @@ static void bcm_uart_do_rx(struct uart_port *port)
  */
 static void bcm_uart_do_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit;
-	unsigned int val, max_count;
-
-	if (port->x_char) {
-		bcm_uart_writel(port, port->x_char, UART_FIFO_REG);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_tx_stopped(port)) {
-		bcm_uart_stop_tx(port);
-		return;
-	}
-
-	xmit = &port->state->xmit;
-	if (uart_circ_empty(xmit))
-		goto txq_empty;
+	unsigned int val, pending;
 
 	val = bcm_uart_readl(port, UART_MCTL_REG);
 	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
-	max_count = port->fifosize - val;
-
-	while (max_count--) {
-		unsigned int c;
-
-		c = xmit->buf[xmit->tail];
-		bcm_uart_writel(port, c, UART_FIFO_REG);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		goto txq_empty;
-	return;
+	pending = uart_port_tx_limit(port, port->fifosize - val);
+	if (pending)
+		return;
 
-txq_empty:
 	/* nothing to send, disable transmit interrupt */
 	val = bcm_uart_readl(port, UART_IR_REG);
 	val &= ~UART_TX_INT_MASK;
 	bcm_uart_writel(port, val, UART_IR_REG);
-	return;
 }
 
 /*
@@ -629,6 +600,7 @@ static int bcm_uart_verify_port(struct uart_port *port,
 /* serial core callbacks */
 static const struct uart_ops bcm_uart_ops = {
 	.tx_empty	= bcm_uart_tx_empty,
+	.put_char	= bcm_uart_put_char,
 	.get_mctrl	= bcm_uart_get_mctrl,
 	.set_mctrl	= bcm_uart_set_mctrl,
 	.start_tx	= bcm_uart_start_tx,
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 643dfbcc43f9..e86718788b49 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -106,6 +106,18 @@ static unsigned int mux_tx_empty(struct uart_port *port)
 	return UART_GET_FIFO_CNT(port) ? 0 : TIOCSER_TEMT;
 } 
 
+static void mux_put_char(struct uart_port *port, unsigned char ch)
+{
+	UART_PUT_CHAR(port, ch);
+}
+
+static void mux_tx_done(struct uart_port *port)
+{
+	/* FIXME js: really needs to wait? */
+	while (UART_GET_FIFO_CNT(port))
+		udelay(1);
+}
+
 /**
  * mux_set_mctrl - Set the current state of the modem control inputs.
  * @ports: Ptr to the uart_port.
@@ -180,39 +192,7 @@ static void mux_break_ctl(struct uart_port *port, int break_state)
  */
 static void mux_write(struct uart_port *port)
 {
-	int count;
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if(port->x_char) {
-		UART_PUT_CHAR(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if(uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		mux_stop_tx(port);
-		return;
-	}
-
-	count = (port->fifosize) - UART_GET_FIFO_CNT(port);
-	do {
-		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if(uart_circ_empty(xmit))
-			break;
-
-	} while(--count > 0);
-
-	while(UART_GET_FIFO_CNT(port)) 
-		udelay(1);
-
-	if(uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		mux_stop_tx(port);
+	uart_port_tx_limit(port, port->fifosize - UART_GET_FIFO_CNT(port));
 }
 
 /**
@@ -421,6 +401,8 @@ static struct console mux_console = {
 
 static const struct uart_ops mux_pops = {
 	.tx_empty =		mux_tx_empty,
+	.put_char =		mux_put_char,
+	.tx_done =		mux_tx_done,
 	.set_mctrl =		mux_set_mctrl,
 	.get_mctrl =		mux_get_mctrl,
 	.stop_tx =		mux_stop_tx,
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 0429c2a54290..3d07ab9eb15e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -194,6 +194,16 @@ static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
 	return (st & STAT_TX_EMP) ? TIOCSER_TEMT : 0;
 }
 
+static bool mvebu_uart_tx_ready(struct uart_port *port)
+{
+	return !(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL);
+}
+
+static void mvebu_uart_put_char(struct uart_port *port, unsigned char ch)
+{
+	writel(ch, port->membase + UART_TSH(port));
+}
+
 static unsigned int mvebu_uart_get_mctrl(struct uart_port *port)
 {
 	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
@@ -324,40 +334,7 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
 
 static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int count;
-	unsigned int st;
-
-	if (port->x_char) {
-		writel(port->x_char, port->membase + UART_TSH(port));
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		mvebu_uart_stop_tx(port);
-		return;
-	}
-
-	for (count = 0; count < port->fifosize; count++) {
-		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-
-		if (uart_circ_empty(xmit))
-			break;
-
-		st = readl(port->membase + UART_STAT);
-		if (st & STAT_TX_FIFO_FUL)
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		mvebu_uart_stop_tx(port);
+	uart_port_tx_limit(port, port->fifosize);
 }
 
 static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
@@ -654,6 +631,8 @@ static void mvebu_uart_put_poll_char(struct uart_port *port, unsigned char c)
 
 static const struct uart_ops mvebu_uart_ops = {
 	.tx_empty	= mvebu_uart_tx_empty,
+	.tx_ready	= mvebu_uart_tx_ready,
+	.put_char	= mvebu_uart_put_char,
 	.set_mctrl	= mvebu_uart_set_mctrl,
 	.get_mctrl	= mvebu_uart_get_mctrl,
 	.stop_tx	= mvebu_uart_stop_tx,
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 8d5ffa196097..a6446bef49f1 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -336,45 +336,6 @@ static void serial_omap_stop_rx(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
-static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
-{
-	struct circ_buf *xmit = &up->port.state->xmit;
-	int count;
-
-	if (up->port.x_char) {
-		serial_out(up, UART_TX, up->port.x_char);
-		up->port.icount.tx++;
-		up->port.x_char = 0;
-		if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
-		    !(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			up->rs485_tx_filter_count++;
-
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial_omap_stop_tx(&up->port);
-		return;
-	}
-	count = up->port.fifosize / 4;
-	do {
-		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
-		if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
-		    !(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			up->rs485_tx_filter_count++;
-
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
-
-	if (uart_circ_empty(xmit))
-		serial_omap_stop_tx(&up->port);
-}
-
 static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
 {
 	if (!(up->ier & UART_IER_THRI)) {
@@ -572,7 +533,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 			check_modem_status(up);
 			break;
 		case UART_IIR_THRI:
-			transmit_chars(up, lsr);
+			uart_port_tx_limit(&up->port, up->port.fifosize / 4);
 			break;
 		case UART_IIR_RX_TIMEOUT:
 		case UART_IIR_RDI:
@@ -613,6 +574,17 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	return ret;
 }
 
+static void serial_omap_put_char(struct uart_port *port, unsigned char ch)
+{
+	struct uart_omap_port *up = to_uart_omap_port(port);
+
+	serial_out(up, UART_TX, ch);
+
+	if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
+	    !(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		up->rs485_tx_filter_count++;
+}
+
 static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
@@ -1369,6 +1341,7 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 
 static const struct uart_ops serial_omap_pops = {
 	.tx_empty	= serial_omap_tx_empty,
+	.put_char	= serial_omap_put_char,
 	.set_mctrl	= serial_omap_set_mctrl,
 	.get_mctrl	= serial_omap_get_mctrl,
 	.stop_tx	= serial_omap_stop_tx,
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index e80ba8e10407..182bf2de5e29 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -171,39 +171,6 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 	serial_out(up, UART_IER, up->ier);
 }
 
-static void transmit_chars(struct uart_pxa_port *up)
-{
-	struct circ_buf *xmit = &up->port.state->xmit;
-	int count;
-
-	if (up->port.x_char) {
-		serial_out(up, UART_TX, up->port.x_char);
-		up->port.icount.tx++;
-		up->port.x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial_pxa_stop_tx(&up->port);
-		return;
-	}
-
-	count = up->port.fifosize / 2;
-	do {
-		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
-
-
-	if (uart_circ_empty(xmit))
-		serial_pxa_stop_tx(&up->port);
-}
-
 static void serial_pxa_start_tx(struct uart_port *port)
 {
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
@@ -253,7 +220,7 @@ static inline irqreturn_t serial_pxa_irq(int irq, void *dev_id)
 		receive_chars(up, &lsr);
 	check_modem_status(up);
 	if (lsr & UART_LSR_THRE)
-		transmit_chars(up);
+		uart_port_tx_limit(&up->port, up->port.fifosize / 2);
 	spin_unlock(&up->port.lock);
 	return IRQ_HANDLED;
 }
@@ -271,6 +238,13 @@ static unsigned int serial_pxa_tx_empty(struct uart_port *port)
 	return ret;
 }
 
+static void serial_pxa_put_char(struct uart_port *port, unsigned char ch)
+{
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+
+	serial_out(up, UART_TX, ch);
+}
+
 static unsigned int serial_pxa_get_mctrl(struct uart_port *port)
 {
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
@@ -742,6 +716,7 @@ static struct console serial_pxa_console = {
 
 static const struct uart_ops serial_pxa_pops = {
 	.tx_empty	= serial_pxa_tx_empty,
+	.put_char	= serial_pxa_put_char,
 	.set_mctrl	= serial_pxa_set_mctrl,
 	.get_mctrl	= serial_pxa_get_mctrl,
 	.stop_tx	= serial_pxa_stop_tx,
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 6689d8add8f7..18725fe9028c 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -283,6 +283,13 @@ static unsigned int rp2_uart_tx_empty(struct uart_port *port)
 	return tx_fifo_bytes ? 0 : TIOCSER_TEMT;
 }
 
+static void rp2_put_char(struct uart_port *port, unsigned char ch)
+{
+	struct rp2_uart_port *up = port_to_up(port);
+
+	writeb(ch, up->base + RP2_DATA_BYTE);
+}
+
 static unsigned int rp2_uart_get_mctrl(struct uart_port *port)
 {
 	struct rp2_uart_port *up = port_to_up(port);
@@ -428,32 +435,8 @@ static void rp2_rx_chars(struct rp2_uart_port *up)
 
 static void rp2_tx_chars(struct rp2_uart_port *up)
 {
-	u16 max_tx = FIFO_SIZE - readw(up->base + RP2_TX_FIFO_COUNT);
-	struct circ_buf *xmit = &up->port.state->xmit;
-
-	if (uart_tx_stopped(&up->port)) {
-		rp2_uart_stop_tx(&up->port);
-		return;
-	}
-
-	for (; max_tx != 0; max_tx--) {
-		if (up->port.x_char) {
-			writeb(up->port.x_char, up->base + RP2_DATA_BYTE);
-			up->port.x_char = 0;
-			up->port.icount.tx++;
-			continue;
-		}
-		if (uart_circ_empty(xmit)) {
-			rp2_uart_stop_tx(&up->port);
-			break;
-		}
-		writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
+	uart_port_tx_limit(&up->port,
+			FIFO_SIZE - readw(up->base + RP2_TX_FIFO_COUNT));
 }
 
 static void rp2_ch_interrupt(struct rp2_uart_port *up)
@@ -575,6 +558,7 @@ static int rp2_uart_verify_port(struct uart_port *port,
 
 static const struct uart_ops rp2_uart_ops = {
 	.tx_empty	= rp2_uart_tx_empty,
+	.put_char	= rp2_put_char,
 	.set_mctrl	= rp2_uart_set_mctrl,
 	.get_mctrl	= rp2_uart_get_mctrl,
 	.stop_tx	= rp2_uart_stop_tx,
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 2213e6b841d3..41b4b33b110e 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -319,38 +319,6 @@ receive_chars(struct uart_port *up, unsigned int *status)
 	*status = disr;
 }
 
-static inline void transmit_chars(struct uart_port *up)
-{
-	struct circ_buf *xmit = &up->state->xmit;
-	int count;
-
-	if (up->x_char) {
-		sio_out(up, TXX9_SITFIFO, up->x_char);
-		up->icount.tx++;
-		up->x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(up)) {
-		serial_txx9_stop_tx(up);
-		return;
-	}
-
-	count = TXX9_SIO_TX_FIFO;
-	do {
-		sio_out(up, TXX9_SITFIFO, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(up);
-
-	if (uart_circ_empty(xmit))
-		serial_txx9_stop_tx(up);
-}
-
 static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 {
 	int pass_counter = 0;
@@ -371,7 +339,7 @@ static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 		if (status & TXX9_SIDISR_RDIS)
 			receive_chars(up, &status);
 		if (status & TXX9_SIDISR_TDIS)
-			transmit_chars(up);
+			uart_port_tx_limit(up, TXX9_SIO_TX_FIFO);
 		/* Clear TX/RX Int. Status */
 		sio_mask(up, TXX9_SIDISR,
 			 TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS |
@@ -397,6 +365,11 @@ static unsigned int serial_txx9_tx_empty(struct uart_port *up)
 	return ret;
 }
 
+static void serial_txx9_put_char(struct uart_port *up, unsigned char ch)
+{
+	sio_out(up, TXX9_SITFIFO, ch);
+}
+
 static unsigned int serial_txx9_get_mctrl(struct uart_port *up)
 {
 	unsigned int ret;
@@ -810,6 +783,7 @@ serial_txx9_type(struct uart_port *port)
 
 static const struct uart_ops serial_txx9_pops = {
 	.tx_empty	= serial_txx9_tx_empty,
+	.put_char	= serial_txx9_put_char,
 	.set_mctrl	= serial_txx9_set_mctrl,
 	.get_mctrl	= serial_txx9_get_mctrl,
 	.stop_tx	= serial_txx9_stop_tx,
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index f5ac14c384c4..7ec9ef732eb8 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -289,46 +289,6 @@ static void __ssp_transmit_char(struct sifive_serial_port *ssp, int ch)
 	__ssp_writel(ch, SIFIVE_SERIAL_TXDATA_OFFS, ssp);
 }
 
-/**
- * __ssp_transmit_chars() - enqueue multiple bytes onto the TX FIFO
- * @ssp: pointer to a struct sifive_serial_port
- *
- * Transfer up to a TX FIFO size's worth of characters from the Linux serial
- * transmit buffer to the SiFive UART TX FIFO.
- *
- * Context: Any context.  Expects @ssp->port.lock to be held by caller.
- */
-static void __ssp_transmit_chars(struct sifive_serial_port *ssp)
-{
-	struct circ_buf *xmit = &ssp->port.state->xmit;
-	int count;
-
-	if (ssp->port.x_char) {
-		__ssp_transmit_char(ssp, ssp->port.x_char);
-		ssp->port.icount.tx++;
-		ssp->port.x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&ssp->port)) {
-		sifive_serial_stop_tx(&ssp->port);
-		return;
-	}
-	count = SIFIVE_TX_FIFO_DEPTH;
-	do {
-		__ssp_transmit_char(ssp, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		ssp->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&ssp->port);
-
-	if (uart_circ_empty(xmit))
-		sifive_serial_stop_tx(&ssp->port);
-}
-
 /**
  * __ssp_enable_txwm() - enable transmit watermark interrupts
  * @ssp: pointer to a struct sifive_serial_port
@@ -565,7 +525,7 @@ static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
 	if (ip & SIFIVE_SERIAL_IP_RXWM_MASK)
 		__ssp_receive_chars(ssp);
 	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
-		__ssp_transmit_chars(ssp);
+		uart_port_tx_limit(&ssp->port, SIFIVE_TX_FIFO_DEPTH);
 
 	spin_unlock(&ssp->port.lock);
 
@@ -577,6 +537,11 @@ static unsigned int sifive_serial_tx_empty(struct uart_port *port)
 	return TIOCSER_TEMT;
 }
 
+static void sifive_serial_put_char(struct uart_port *port, unsigned char ch)
+{
+	__ssp_transmit_char(port_to_sifive_serial_port(port), ch);
+}
+
 static unsigned int sifive_serial_get_mctrl(struct uart_port *port)
 {
 	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
@@ -905,6 +870,7 @@ static void __ssp_remove_console_port(struct sifive_serial_port *ssp)
 
 static const struct uart_ops sifive_serial_uops = {
 	.tx_empty	= sifive_serial_tx_empty,
+	.put_char	= sifive_serial_put_char,
 	.set_mctrl	= sifive_serial_set_mctrl,
 	.get_mctrl	= sifive_serial_get_mctrl,
 	.stop_tx	= sifive_serial_stop_tx,
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 4329b9c9cbf0..d92dc07f0ebb 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -154,6 +154,11 @@ static unsigned int sprd_tx_empty(struct uart_port *port)
 		return TIOCSER_TEMT;
 }
 
+static void sprd_put_char(struct uart_port *port, unsigned char ch)
+{
+	serial_out(port, SPRD_TXD, ch);
+}
+
 static unsigned int sprd_get_mctrl(struct uart_port *port)
 {
 	return TIOCM_DSR | TIOCM_CTS;
@@ -624,39 +629,6 @@ static inline void sprd_rx(struct uart_port *port)
 	tty_flip_buffer_push(tty);
 }
 
-static inline void sprd_tx(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	int count;
-
-	if (port->x_char) {
-		serial_out(port, SPRD_TXD, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		sprd_stop_tx(port);
-		return;
-	}
-
-	count = THLD_TX_EMPTY;
-	do {
-		serial_out(port, SPRD_TXD, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		sprd_stop_tx(port);
-}
-
 /* this handles the interrupt from one port */
 static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 {
@@ -683,7 +655,7 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 		sprd_rx(port);
 
 	if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
-		sprd_tx(port);
+		uart_port_tx_limit(port, THLD_TX_EMPTY);
 
 	spin_unlock(&port->lock);
 
@@ -948,6 +920,7 @@ static void sprd_poll_put_char(struct uart_port *port, unsigned char ch)
 
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
+	.put_char = sprd_put_char,
 	.get_mctrl = sprd_get_mctrl,
 	.set_mctrl = sprd_set_mctrl,
 	.stop_tx = sprd_stop_tx,
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index d7fd692286cf..e9bb977da576 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -238,50 +238,7 @@ static inline unsigned asc_hw_txroom(struct uart_port *port)
  */
 static void asc_transmit_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	int txroom;
-	unsigned char c;
-
-	txroom = asc_hw_txroom(port);
-
-	if ((txroom != 0) && port->x_char) {
-		c = port->x_char;
-		port->x_char = 0;
-		asc_out(port, ASC_TXBUF, c);
-		port->icount.tx++;
-		txroom = asc_hw_txroom(port);
-	}
-
-	if (uart_tx_stopped(port)) {
-		/*
-		 * We should try and stop the hardware here, but I
-		 * don't think the ASC has any way to do that.
-		 */
-		asc_disable_tx_interrupts(port);
-		return;
-	}
-
-	if (uart_circ_empty(xmit)) {
-		asc_disable_tx_interrupts(port);
-		return;
-	}
-
-	if (txroom == 0)
-		return;
-
-	do {
-		c = xmit->buf[xmit->tail];
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		asc_out(port, ASC_TXBUF, c);
-		port->icount.tx++;
-		txroom--;
-	} while ((txroom > 0) && (!uart_circ_empty(xmit)));
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		asc_disable_tx_interrupts(port);
+	uart_port_tx_limit(port, asc_hw_txroom(port));
 }
 
 static void asc_receive_chars(struct uart_port *port)
@@ -389,6 +346,11 @@ static unsigned int asc_tx_empty(struct uart_port *port)
 	return asc_txfifo_is_empty(port) ? TIOCSER_TEMT : 0;
 }
 
+static void asc_put_char(struct uart_port *port, unsigned char ch)
+{
+	asc_out(port, ASC_TXBUF, ch);
+}
+
 static void asc_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct asc_port *ascport = to_asc_port(port);
@@ -690,6 +652,7 @@ static void asc_put_poll_char(struct uart_port *port, unsigned char c)
 
 static const struct uart_ops asc_uart_ops = {
 	.tx_empty	= asc_tx_empty,
+	.put_char	= asc_put_char,
 	.set_mctrl	= asc_set_mctrl,
 	.get_mctrl	= asc_get_mctrl,
 	.start_tx	= asc_start_tx,
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index e0bf003ca3a1..83c28288dfe1 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -183,6 +183,11 @@ static unsigned int siu_tx_empty(struct uart_port *port)
 	return 0;
 }
 
+static void siu_put_char(struct uart_port *port, unsigned char ch)
+{
+	siu_write(port, UART_TX, ch);
+}
+
 static void siu_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	uint8_t mcr = 0;
@@ -370,40 +375,6 @@ static inline void check_modem_status(struct uart_port *port)
 	wake_up_interruptible(&port->state->port.delta_msr_wait);
 }
 
-static inline void transmit_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit;
-	int max_count = TX_MAX_COUNT;
-
-	xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		siu_write(port, UART_TX, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		siu_stop_tx(port);
-		return;
-	}
-
-	do {
-		siu_write(port, UART_TX, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (max_count-- > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		siu_stop_tx(port);
-}
-
 static irqreturn_t siu_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port;
@@ -422,7 +393,7 @@ static irqreturn_t siu_interrupt(int irq, void *dev_id)
 	check_modem_status(port);
 
 	if (lsr & UART_LSR_THRE)
-		transmit_chars(port);
+		uart_port_tx_limit(port, TX_MAX_COUNT);
 
 	return IRQ_HANDLED;
 }
@@ -653,6 +624,7 @@ static int siu_verify_port(struct uart_port *port, struct serial_struct *serial)
 
 static const struct uart_ops siu_uart_ops = {
 	.tx_empty	= siu_tx_empty,
+	.put_char	= siu_put_char,
 	.set_mctrl	= siu_set_mctrl,
 	.get_mctrl	= siu_get_mctrl,
 	.stop_tx	= siu_stop_tx,
-- 
2.35.1

