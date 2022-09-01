Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2625A9565
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiIALHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiIALHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:07:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494CD1321E8;
        Thu,  1 Sep 2022 04:07:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB7D61FF4B;
        Thu,  1 Sep 2022 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662030429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TR522oSc/XjpQrSgmlSIskBoUD5syTk9/HGQdD+o0EU=;
        b=Kj7Fcq8MxlElz3VODQ5zo0Kag+gsc3vIsKQD3k8IBCBVwh23zBJNfmHXXtuQzcNcDg9mTE
        pJt6Z9bg6U8taR1KPVjeZ6ie8kyPDgCPef9F14S6Mlc762cQJmo/GMLahVPCvnWe+HO0S9
        2aWzJeD2HaBAaIBbwheFBnNDxF0Q2Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662030429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TR522oSc/XjpQrSgmlSIskBoUD5syTk9/HGQdD+o0EU=;
        b=D8MTX+4alvundHuvcXlwd2iIMKgjesM6x1qH9a3dEFd8pXynFkpwwNIj7GF8Ug2e9sRQI8
        78fjPvMa7bhCrqDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5284D2C142;
        Thu,  1 Sep 2022 11:07:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH v2 3/3] tty: serial: use DEFINE_UART_PORT_TX_HELPER_LIMITED()
Date:   Thu,  1 Sep 2022 13:06:57 +0200
Message-Id: <20220901110657.3305-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901110657.3305-1-jslaby@suse.cz>
References: <20220901110657.3305-1-jslaby@suse.cz>
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

DEFINE_UART_PORT_TX_HELPER_LIMITED() is a new helper to send characters
to the device. Use it in these drivers.

mux.c also needs to define tx_done(). But I'm not sure if the driver
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
 drivers/tty/serial/21285.c           | 33 ++++--------------
 drivers/tty/serial/altera_jtaguart.c | 42 ++++++-----------------
 drivers/tty/serial/amba-pl010.c      | 37 +++-----------------
 drivers/tty/serial/apbuart.c         | 36 ++++----------------
 drivers/tty/serial/bcm63xx_uart.c    | 47 +++++---------------------
 drivers/tty/serial/mux.c             | 46 ++++++++-----------------
 drivers/tty/serial/mvebu-uart.c      | 40 ++++------------------
 drivers/tty/serial/omap-serial.c     | 47 +++++++-------------------
 drivers/tty/serial/pxa.c             | 39 +++++-----------------
 drivers/tty/serial/rp2.c             | 36 ++++----------------
 drivers/tty/serial/serial_txx9.c     | 37 +++-----------------
 drivers/tty/serial/sifive.c          | 45 +++----------------------
 drivers/tty/serial/sprd_serial.c     | 38 +++------------------
 drivers/tty/serial/st-asc.c          | 50 ++++------------------------
 14 files changed, 103 insertions(+), 470 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 7520cc02fd4d..a23401aa0847 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -151,38 +151,17 @@ static irqreturn_t serial21285_rx_chars(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(serial21285_do_tx_chars, port, ch,
+		!(*CSR_UARTFLG & 0x20),
+		*CSR_UARTDR = ch,
+		({}));
+
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
+	serial21285_do_tx_chars(port, 256);
 
- out:
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index cb791c5149a3..928ed419e969 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -134,42 +134,20 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(altera_jtaguart_do_tx_chars, port, ch,
+		true,
+		writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
+		({}));
+
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
+	altera_jtaguart_do_tx_chars(port, space);
 }
 
 static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index fae0b581ff42..cc95e5546b79 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -162,37 +162,10 @@ static void pl010_rx_chars(struct uart_port *port)
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
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(pl010_tx_chars, port, ch,
+		true,
+		writel(ch, port->membase + UART01x_DR),
+		({}));
 
 static void pl010_modem_status(struct uart_amba_port *uap)
 {
@@ -238,7 +211,7 @@ static irqreturn_t pl010_int(int irq, void *dev_id)
 			if (status & UART010_IIR_MIS)
 				pl010_modem_status(uap);
 			if (status & UART010_IIR_TIS)
-				pl010_tx_chars(port);
+				pl010_tx_chars(port, port->fifosize >> 1);
 
 			if (pass_counter-- == 0)
 				break;
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 9ef82d870ff2..06c880ed7036 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -120,38 +120,14 @@ static void apbuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(apbuart_do_tx_chars, port, ch,
+		true,
+		UART_PUT_CHAR(port, ch),
+		({}));
+
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
+	apbuart_do_tx_chars(port, port->fifosize >> 1);
 }
 
 static irqreturn_t apbuart_int(int irq, void *dev_id)
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 53b43174aa40..1b9f0cec3aa1 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -297,59 +297,30 @@ static void bcm_uart_do_rx(struct uart_port *port)
 	tty_flip_buffer_push(tty_port);
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(bcm_uart_tx, port, ch,
+		true,
+		bcm_uart_writel(port, ch, UART_FIFO_REG),
+		({}));
+
 /*
  * fill tx fifo with chars to send, stop when fifo is about to be full
  * or when all chars have been sent.
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
 
-		c = xmit->buf[xmit->tail];
-		bcm_uart_writel(port, c, UART_FIFO_REG);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		goto txq_empty;
-	return;
+	pending = bcm_uart_tx(port, port->fifosize - val);
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
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 0ba0f4d9459d..f65f694fdecd 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -171,6 +171,18 @@ static void mux_break_ctl(struct uart_port *port, int break_state)
 {
 }
 
+static void mux_tx_done(struct uart_port *port)
+{
+	/* FIXME js: really needs to wait? */
+	while (UART_GET_FIFO_CNT(port))
+		udelay(1);
+}
+
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(mux_transmit, port, ch,
+		true,
+		UART_PUT_CHAR(port, ch),
+		mux_tx_done(port));
+
 /**
  * mux_write - Write chars to the mux fifo.
  * @port: Ptr to the uart_port.
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
+	mux_transmit(port, port->fifosize - UART_GET_FIFO_CNT(port));
 }
 
 /**
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 65eaecd10b7c..1dc0d9bcf797 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -333,42 +333,14 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
 	tty_flip_buffer_push(tport);
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(mvebu_uart_do_tx_chars, port, ch,
+		!(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL),
+		writel(ch, port->membase + UART_TSH(port)),
+		({}));
+
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
+	mvebu_uart_do_tx_chars(port, port->fifosize);
 }
 
 static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0aa666e247d5..a0ccde3b33e3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -337,45 +337,22 @@ static void serial_omap_stop_rx(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
-static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
+static void serial_omap_put_char(struct uart_port *port, unsigned char ch)
 {
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
+	struct uart_omap_port *up = to_uart_omap_port(port);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
+	serial_out(up, UART_TX, ch);
 
-	if (uart_circ_empty(xmit))
-		serial_omap_stop_tx(&up->port);
+	if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
+	    !(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		up->rs485_tx_filter_count++;
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(transmit_chars, port, ch,
+		true,
+		serial_omap_put_char(port, ch),
+		({}));
+
 static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
 {
 	if (!(up->ier & UART_IER_THRI)) {
@@ -573,7 +550,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 			check_modem_status(up);
 			break;
 		case UART_IIR_THRI:
-			transmit_chars(up, lsr);
+			transmit_chars(&up->port, up->port.fifosize / 4);
 			break;
 		case UART_IIR_RX_TIMEOUT:
 		case UART_IIR_RDI:
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 9309ffd87c8e..c1376e8adbf4 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -172,39 +172,18 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 	serial_out(up, UART_IER, up->ier);
 }
 
-static void transmit_chars(struct uart_pxa_port *up)
+static void serial_pxa_put_char(struct uart_port *port, u8 ch)
 {
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
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
 
-	if (uart_circ_empty(xmit))
-		serial_pxa_stop_tx(&up->port);
+	serial_out(up, UART_TX, ch);
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(transmit_chars, port, ch,
+		true,
+		serial_pxa_put_char(port, ch),
+		({}));
+
 static void serial_pxa_start_tx(struct uart_port *port)
 {
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
@@ -254,7 +233,7 @@ static inline irqreturn_t serial_pxa_irq(int irq, void *dev_id)
 		receive_chars(up, &lsr);
 	check_modem_status(up);
 	if (lsr & UART_LSR_THRE)
-		transmit_chars(up);
+		transmit_chars(&up->port, up->port.fifosize / 2);
 	spin_unlock(&up->port.lock);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 6689d8add8f7..8719022b189d 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -426,35 +426,10 @@ static void rp2_rx_chars(struct rp2_uart_port *up)
 	tty_flip_buffer_push(port);
 }
 
-static void rp2_tx_chars(struct rp2_uart_port *up)
-{
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
-}
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(rp2_tx_chars, port, ch,
+		true,
+		writeb(ch, port_to_up(port)->base + RP2_DATA_BYTE),
+		({}));
 
 static void rp2_ch_interrupt(struct rp2_uart_port *up)
 {
@@ -472,7 +447,8 @@ static void rp2_ch_interrupt(struct rp2_uart_port *up)
 	if (status & RP2_CHAN_STAT_RXDATA_m)
 		rp2_rx_chars(up);
 	if (status & RP2_CHAN_STAT_TXEMPTY_m)
-		rp2_tx_chars(up);
+		rp2_tx_chars(&up->port,
+			FIFO_SIZE - readw(up->base + RP2_TX_FIFO_COUNT));
 	if (status & RP2_CHAN_STAT_MS_CHANGED_MASK)
 		wake_up_interruptible(&up->port.state->port.delta_msr_wait);
 
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 228e380db080..855ad3b457f7 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -319,37 +319,10 @@ receive_chars(struct uart_port *up, unsigned int *status)
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
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(transmit_chars, port, ch,
+		true,
+		sio_out(port, TXX9_SITFIFO, ch),
+		({}));
 
 static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 {
@@ -371,7 +344,7 @@ static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 		if (status & TXX9_SIDISR_RDIS)
 			receive_chars(up, &status);
 		if (status & TXX9_SIDISR_TDIS)
-			transmit_chars(up);
+			transmit_chars(up, TXX9_SIO_TX_FIFO);
 		/* Clear TX/RX Int. Status */
 		sio_mask(up, TXX9_SIDISR,
 			 TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS |
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5c3a07546a58..78180f936bf3 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -277,45 +277,10 @@ static void __ssp_transmit_char(struct sifive_serial_port *ssp, int ch)
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
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(__ssp_transmit_chars, port, ch,
+		true,
+		__ssp_transmit_char(port_to_sifive_serial_port(port), ch),
+		({}));
 
 /**
  * __ssp_enable_txwm() - enable transmit watermark interrupts
@@ -553,7 +518,7 @@ static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
 	if (ip & SIFIVE_SERIAL_IP_RXWM_MASK)
 		__ssp_receive_chars(ssp);
 	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
-		__ssp_transmit_chars(ssp);
+		__ssp_transmit_chars(&ssp->port, SIFIVE_TX_FIFO_DEPTH);
 
 	spin_unlock(&ssp->port.lock);
 
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 4329b9c9cbf0..e217b7ab69af 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -624,38 +624,10 @@ static inline void sprd_rx(struct uart_port *port)
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
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(sprd_tx, port, ch,
+		true,
+		serial_out(port, SPRD_TXD, ch),
+		({}));
 
 /* this handles the interrupt from one port */
 static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
@@ -683,7 +655,7 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 		sprd_rx(port);
 
 	if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
-		sprd_tx(port);
+		sprd_tx(port, THLD_TX_EMPTY);
 
 	spin_unlock(&port->lock);
 
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index cce42f4c9bc2..f5dd3fa4bf26 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -230,6 +230,11 @@ static inline unsigned asc_hw_txroom(struct uart_port *port)
 	return 0;
 }
 
+static DEFINE_UART_PORT_TX_HELPER_LIMITED(asc_do_transmit_chars, port, ch,
+		true,
+		asc_out(port, ASC_TXBUF, ch),
+		({}));
+
 /*
  * Start transmitting chars.
  * This is called from both interrupt and task level.
@@ -237,50 +242,7 @@ static inline unsigned asc_hw_txroom(struct uart_port *port)
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
+	asc_do_transmit_chars(port, asc_hw_txroom(port));
 }
 
 static void asc_receive_chars(struct uart_port *port)
-- 
2.37.2

