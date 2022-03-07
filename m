Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EA4CF143
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiCGFor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiCGFop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:44:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3844833F;
        Sun,  6 Mar 2022 21:43:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B3A721F38E;
        Mon,  7 Mar 2022 05:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646631828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tpfmKTzb1TS4ibKod5dS7j2wDj6jXJVeIHxCmP1QH38=;
        b=F2U0brGfik8obdrPew6PdGT3JrrlONKud8NVV9QHC0VDut2LIvEvkMAboyE85bJBP28Ht7
        pbK7/m5V/y72aS/VxejguY9evQUb4C5/pWDg9t/V/pzCF1bbKMNoTF3NEpCtR3zkNnnfeF
        gLjlqZI6S8SFBEqy2e5vOPRSZWfBu/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646631828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tpfmKTzb1TS4ibKod5dS7j2wDj6jXJVeIHxCmP1QH38=;
        b=QRIEgfn3hXgAczpc/UMWb2BSXO5VJNUp6FRg520QnEvivz7UZDdhfAblqG4Ka92bP/2NnJ
        KneSuG0N0VJZNzBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86B57A3B81;
        Mon,  7 Mar 2022 05:43:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2] tty: serial: serial_txx9: remove struct uart_txx9_port
Date:   Mon,  7 Mar 2022 06:43:47 +0100
Message-Id: <20220307054348.31748-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
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

It's only a wrapper to struct uart_port, so unwrap the whole code.

No change in functionality is intended.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
[v2] nothing changed, this is just a resend -- this patch depended on
"serial: make uart_console_write->putchar()'s character an unsigned
char" which was not applied yet last time I submitted this.

 drivers/tty/serial/serial_txx9.c | 364 ++++++++++++++-----------------
 1 file changed, 167 insertions(+), 197 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index a695e9c1a06a..2213e6b841d3 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -54,11 +54,6 @@
  */
 #define UART_NR  CONFIG_SERIAL_TXX9_NR_UARTS
 
-struct uart_txx9_port {
-	struct uart_port	port;
-	/* No additional info for now */
-};
-
 #define TXX9_REGION_SIZE	0x24
 
 /* TXX9 Serial Registers */
@@ -160,42 +155,42 @@ struct uart_txx9_port {
 #define TXX9_SIBGR_BCLK_T6	0x00000300
 #define TXX9_SIBGR_BRD_MASK	0x000000ff
 
-static inline unsigned int sio_in(struct uart_txx9_port *up, int offset)
+static inline unsigned int sio_in(struct uart_port *up, int offset)
 {
-	switch (up->port.iotype) {
+	switch (up->iotype) {
 	default:
-		return __raw_readl(up->port.membase + offset);
+		return __raw_readl(up->membase + offset);
 	case UPIO_PORT:
-		return inl(up->port.iobase + offset);
+		return inl(up->iobase + offset);
 	}
 }
 
 static inline void
-sio_out(struct uart_txx9_port *up, int offset, int value)
+sio_out(struct uart_port *up, int offset, int value)
 {
-	switch (up->port.iotype) {
+	switch (up->iotype) {
 	default:
-		__raw_writel(value, up->port.membase + offset);
+		__raw_writel(value, up->membase + offset);
 		break;
 	case UPIO_PORT:
-		outl(value, up->port.iobase + offset);
+		outl(value, up->iobase + offset);
 		break;
 	}
 }
 
 static inline void
-sio_mask(struct uart_txx9_port *up, int offset, unsigned int value)
+sio_mask(struct uart_port *up, int offset, unsigned int value)
 {
 	sio_out(up, offset, sio_in(up, offset) & ~value);
 }
 static inline void
-sio_set(struct uart_txx9_port *up, int offset, unsigned int value)
+sio_set(struct uart_port *up, int offset, unsigned int value)
 {
 	sio_out(up, offset, sio_in(up, offset) | value);
 }
 
 static inline void
-sio_quot_set(struct uart_txx9_port *up, int quot)
+sio_quot_set(struct uart_port *up, int quot)
 {
 	quot >>= 1;
 	if (quot < 256)
@@ -210,32 +205,23 @@ sio_quot_set(struct uart_txx9_port *up, int quot)
 		sio_out(up, TXX9_SIBGR, 0xff | TXX9_SIBGR_BCLK_T6);
 }
 
-static struct uart_txx9_port *to_uart_txx9_port(struct uart_port *port)
-{
-	return container_of(port, struct uart_txx9_port, port);
-}
-
-static void serial_txx9_stop_tx(struct uart_port *port)
+static void serial_txx9_stop_tx(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	sio_mask(up, TXX9_SIDICR, TXX9_SIDICR_TIE);
 }
 
-static void serial_txx9_start_tx(struct uart_port *port)
+static void serial_txx9_start_tx(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	sio_set(up, TXX9_SIDICR, TXX9_SIDICR_TIE);
 }
 
-static void serial_txx9_stop_rx(struct uart_port *port)
+static void serial_txx9_stop_rx(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
-	up->port.read_status_mask &= ~TXX9_SIDISR_RDIS;
+	up->read_status_mask &= ~TXX9_SIDISR_RDIS;
 }
 
-static void serial_txx9_initialize(struct uart_port *port)
+static void serial_txx9_initialize(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned int tmout = 10000;
 
 	sio_out(up, TXX9_SIFCR, TXX9_SIFCR_SWRST);
@@ -250,15 +236,15 @@ static void serial_txx9_initialize(struct uart_port *port)
 	/* initial settings */
 	sio_out(up, TXX9_SILCR,
 		TXX9_SILCR_UMODE_8BIT | TXX9_SILCR_USBL_1BIT |
-		((up->port.flags & UPF_TXX9_USE_SCLK) ?
+		((up->flags & UPF_TXX9_USE_SCLK) ?
 		 TXX9_SILCR_SCS_SCLK_BG : TXX9_SILCR_SCS_IMCLK_BG));
-	sio_quot_set(up, uart_get_divisor(port, 9600));
+	sio_quot_set(up, uart_get_divisor(up, 9600));
 	sio_out(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSTL_MAX /* 15 */);
 	sio_out(up, TXX9_SIDICR, 0);
 }
 
 static inline void
-receive_chars(struct uart_txx9_port *up, unsigned int *status)
+receive_chars(struct uart_port *up, unsigned int *status)
 {
 	unsigned char ch;
 	unsigned int disr = *status;
@@ -269,11 +255,11 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 	do {
 		ch = sio_in(up, TXX9_SIRFIFO);
 		flag = TTY_NORMAL;
-		up->port.icount.rx++;
+		up->icount.rx++;
 
 		/* mask out RFDN_MASK bit added by previous overrun */
 		next_ignore_status_mask =
-			up->port.ignore_status_mask & ~TXX9_SIDISR_RFDN_MASK;
+			up->ignore_status_mask & ~TXX9_SIDISR_RFDN_MASK;
 		if (unlikely(disr & (TXX9_SIDISR_UBRK | TXX9_SIDISR_UPER |
 				     TXX9_SIDISR_UFER | TXX9_SIDISR_UOER))) {
 			/*
@@ -281,21 +267,21 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 			 */
 			if (disr & TXX9_SIDISR_UBRK) {
 				disr &= ~(TXX9_SIDISR_UFER | TXX9_SIDISR_UPER);
-				up->port.icount.brk++;
+				up->icount.brk++;
 				/*
 				 * We do the SysRQ and SAK checking
 				 * here because otherwise the break
 				 * may get masked by ignore_status_mask
 				 * or read_status_mask.
 				 */
-				if (uart_handle_break(&up->port))
+				if (uart_handle_break(up))
 					goto ignore_char;
 			} else if (disr & TXX9_SIDISR_UPER)
-				up->port.icount.parity++;
+				up->icount.parity++;
 			else if (disr & TXX9_SIDISR_UFER)
-				up->port.icount.frame++;
+				up->icount.frame++;
 			if (disr & TXX9_SIDISR_UOER) {
-				up->port.icount.overrun++;
+				up->icount.overrun++;
 				/*
 				 * The receiver read buffer still hold
 				 * a char which caused overrun.
@@ -309,7 +295,7 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 			/*
 			 * Mask off conditions which should be ingored.
 			 */
-			disr &= up->port.read_status_mask;
+			disr &= up->read_status_mask;
 
 			if (disr & TXX9_SIDISR_UBRK) {
 				flag = TTY_BREAK;
@@ -318,34 +304,34 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 			else if (disr & TXX9_SIDISR_UFER)
 				flag = TTY_FRAME;
 		}
-		if (uart_handle_sysrq_char(&up->port, ch))
+		if (uart_handle_sysrq_char(up, ch))
 			goto ignore_char;
 
-		uart_insert_char(&up->port, disr, TXX9_SIDISR_UOER, ch, flag);
+		uart_insert_char(up, disr, TXX9_SIDISR_UOER, ch, flag);
 
 	ignore_char:
-		up->port.ignore_status_mask = next_ignore_status_mask;
+		up->ignore_status_mask = next_ignore_status_mask;
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
 
-	tty_flip_buffer_push(&up->port.state->port);
+	tty_flip_buffer_push(&up->state->port);
 
 	*status = disr;
 }
 
-static inline void transmit_chars(struct uart_txx9_port *up)
+static inline void transmit_chars(struct uart_port *up)
 {
-	struct circ_buf *xmit = &up->port.state->xmit;
+	struct circ_buf *xmit = &up->state->xmit;
 	int count;
 
-	if (up->port.x_char) {
-		sio_out(up, TXX9_SITFIFO, up->port.x_char);
-		up->port.icount.tx++;
-		up->port.x_char = 0;
+	if (up->x_char) {
+		sio_out(up, TXX9_SITFIFO, up->x_char);
+		up->icount.tx++;
+		up->x_char = 0;
 		return;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial_txx9_stop_tx(&up->port);
+	if (uart_circ_empty(xmit) || uart_tx_stopped(up)) {
+		serial_txx9_stop_tx(up);
 		return;
 	}
 
@@ -353,32 +339,32 @@ static inline void transmit_chars(struct uart_txx9_port *up)
 	do {
 		sio_out(up, TXX9_SITFIFO, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
+		up->icount.tx++;
 		if (uart_circ_empty(xmit))
 			break;
 	} while (--count > 0);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
+		uart_write_wakeup(up);
 
 	if (uart_circ_empty(xmit))
-		serial_txx9_stop_tx(&up->port);
+		serial_txx9_stop_tx(up);
 }
 
 static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 {
 	int pass_counter = 0;
-	struct uart_txx9_port *up = dev_id;
+	struct uart_port *up = dev_id;
 	unsigned int status;
 
 	while (1) {
-		spin_lock(&up->port.lock);
+		spin_lock(&up->lock);
 		status = sio_in(up, TXX9_SIDISR);
 		if (!(sio_in(up, TXX9_SIDICR) & TXX9_SIDICR_TIE))
 			status &= ~TXX9_SIDISR_TDIS;
 		if (!(status & (TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS |
 				TXX9_SIDISR_TOUT))) {
-			spin_unlock(&up->port.lock);
+			spin_unlock(&up->lock);
 			break;
 		}
 
@@ -390,7 +376,7 @@ static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 		sio_mask(up, TXX9_SIDISR,
 			 TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS |
 			 TXX9_SIDISR_TOUT);
-		spin_unlock(&up->port.lock);
+		spin_unlock(&up->lock);
 
 		if (pass_counter++ > PASS_LIMIT)
 			break;
@@ -399,22 +385,20 @@ static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 	return pass_counter ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static unsigned int serial_txx9_tx_empty(struct uart_port *port)
+static unsigned int serial_txx9_tx_empty(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned long flags;
 	unsigned int ret;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock_irqsave(&up->lock, flags);
 	ret = (sio_in(up, TXX9_SICISR) & TXX9_SICISR_TXALS) ? TIOCSER_TEMT : 0;
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_unlock_irqrestore(&up->lock, flags);
 
 	return ret;
 }
 
-static unsigned int serial_txx9_get_mctrl(struct uart_port *port)
+static unsigned int serial_txx9_get_mctrl(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned int ret;
 
 	/* no modem control lines */
@@ -425,9 +409,8 @@ static unsigned int serial_txx9_get_mctrl(struct uart_port *port)
 	return ret;
 }
 
-static void serial_txx9_set_mctrl(struct uart_port *port, unsigned int mctrl)
+static void serial_txx9_set_mctrl(struct uart_port *up, unsigned int mctrl)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 
 	if (mctrl & TIOCM_RTS)
 		sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSSC);
@@ -435,24 +418,23 @@ static void serial_txx9_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		sio_set(up, TXX9_SIFLCR, TXX9_SIFLCR_RTSSC);
 }
 
-static void serial_txx9_break_ctl(struct uart_port *port, int break_state)
+static void serial_txx9_break_ctl(struct uart_port *up, int break_state)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock_irqsave(&up->lock, flags);
 	if (break_state == -1)
 		sio_set(up, TXX9_SIFLCR, TXX9_SIFLCR_TBRK);
 	else
 		sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_TBRK);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_unlock_irqrestore(&up->lock, flags);
 }
 
 #if defined(CONFIG_SERIAL_TXX9_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 /*
  *	Wait for transmitter & holding register to empty
  */
-static void wait_for_xmitr(struct uart_txx9_port *up)
+static void wait_for_xmitr(struct uart_port *up)
 {
 	unsigned int tmout = 10000;
 
@@ -462,7 +444,7 @@ static void wait_for_xmitr(struct uart_txx9_port *up)
 		udelay(1);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (up->flags & UPF_CONS_FLOW) {
 		tmout = 1000000;
 		while (--tmout &&
 		       (sio_in(up, TXX9_SICISR) & TXX9_SICISR_CTSS))
@@ -477,11 +459,10 @@ static void wait_for_xmitr(struct uart_txx9_port *up)
  * in an interrupt or debug context.
  */
 
-static int serial_txx9_get_poll_char(struct uart_port *port)
+static int serial_txx9_get_poll_char(struct uart_port *up)
 {
 	unsigned int ier;
 	unsigned char c;
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -504,10 +485,9 @@ static int serial_txx9_get_poll_char(struct uart_port *port)
 }
 
 
-static void serial_txx9_put_poll_char(struct uart_port *port, unsigned char c)
+static void serial_txx9_put_poll_char(struct uart_port *up, unsigned char c)
 {
 	unsigned int ier;
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -531,9 +511,8 @@ static void serial_txx9_put_poll_char(struct uart_port *port, unsigned char c)
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int serial_txx9_startup(struct uart_port *port)
+static int serial_txx9_startup(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned long flags;
 	int retval;
 
@@ -553,7 +532,7 @@ static int serial_txx9_startup(struct uart_port *port)
 	 */
 	sio_out(up, TXX9_SIDISR, 0);
 
-	retval = request_irq(up->port.irq, serial_txx9_interrupt,
+	retval = request_irq(up->irq, serial_txx9_interrupt,
 			     IRQF_SHARED, "serial_txx9", up);
 	if (retval)
 		return retval;
@@ -561,9 +540,9 @@ static int serial_txx9_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	spin_lock_irqsave(&up->port.lock, flags);
-	serial_txx9_set_mctrl(&up->port, up->port.mctrl);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_lock_irqsave(&up->lock, flags);
+	serial_txx9_set_mctrl(up, up->mctrl);
+	spin_unlock_irqrestore(&up->lock, flags);
 
 	/* Enable RX/TX */
 	sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_RSDE | TXX9_SIFLCR_TSDE);
@@ -576,9 +555,8 @@ static int serial_txx9_startup(struct uart_port *port)
 	return 0;
 }
 
-static void serial_txx9_shutdown(struct uart_port *port)
+static void serial_txx9_shutdown(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned long flags;
 
 	/*
@@ -586,9 +564,9 @@ static void serial_txx9_shutdown(struct uart_port *port)
 	 */
 	sio_out(up, TXX9_SIDICR, 0);	/* disable all intrs */
 
-	spin_lock_irqsave(&up->port.lock, flags);
-	serial_txx9_set_mctrl(&up->port, up->port.mctrl);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_lock_irqsave(&up->lock, flags);
+	serial_txx9_set_mctrl(up, up->mctrl);
+	spin_unlock_irqrestore(&up->lock, flags);
 
 	/*
 	 * Disable break condition
@@ -596,8 +574,8 @@ static void serial_txx9_shutdown(struct uart_port *port)
 	sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_TBRK);
 
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	if (up->port.cons && up->port.line == up->port.cons->index) {
-		free_irq(up->port.irq, up);
+	if (up->cons && up->line == up->cons->index) {
+		free_irq(up->irq, up);
 		return;
 	}
 #endif
@@ -611,14 +589,13 @@ static void serial_txx9_shutdown(struct uart_port *port)
 	/* Disable RX/TX */
 	sio_set(up, TXX9_SIFLCR, TXX9_SIFLCR_RSDE | TXX9_SIFLCR_TSDE);
 
-	free_irq(up->port.irq, up);
+	free_irq(up->irq, up);
 }
 
 static void
-serial_txx9_set_termios(struct uart_port *port, struct ktermios *termios,
+serial_txx9_set_termios(struct uart_port *up, struct ktermios *termios,
 		       struct ktermios *old)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	unsigned int cval, fcr = 0;
 	unsigned long flags;
 	unsigned int baud, quot;
@@ -658,8 +635,8 @@ serial_txx9_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16/2);
-	quot = uart_get_divisor(port, baud);
+	baud = uart_get_baud_rate(up, termios, old, 0, up->uartclk/16/2);
+	quot = uart_get_divisor(up, baud);
 
 	/* Set up FIFOs */
 	/* TX Int by FIFO Empty, RX Int by Receiving 1 char. */
@@ -669,45 +646,45 @@ serial_txx9_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Ok, we're now changing the port state.  Do it with
 	 * interrupts disabled.
 	 */
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock_irqsave(&up->lock, flags);
 
 	/*
 	 * Update the per-port timeout.
 	 */
-	uart_update_timeout(port, termios->c_cflag, baud);
+	uart_update_timeout(up, termios->c_cflag, baud);
 
-	up->port.read_status_mask = TXX9_SIDISR_UOER |
+	up->read_status_mask = TXX9_SIDISR_UOER |
 		TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS;
 	if (termios->c_iflag & INPCK)
-		up->port.read_status_mask |= TXX9_SIDISR_UFER | TXX9_SIDISR_UPER;
+		up->read_status_mask |= TXX9_SIDISR_UFER | TXX9_SIDISR_UPER;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		up->port.read_status_mask |= TXX9_SIDISR_UBRK;
+		up->read_status_mask |= TXX9_SIDISR_UBRK;
 
 	/*
 	 * Characteres to ignore
 	 */
-	up->port.ignore_status_mask = 0;
+	up->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		up->port.ignore_status_mask |= TXX9_SIDISR_UPER | TXX9_SIDISR_UFER;
+		up->ignore_status_mask |= TXX9_SIDISR_UPER | TXX9_SIDISR_UFER;
 	if (termios->c_iflag & IGNBRK) {
-		up->port.ignore_status_mask |= TXX9_SIDISR_UBRK;
+		up->ignore_status_mask |= TXX9_SIDISR_UBRK;
 		/*
 		 * If we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			up->port.ignore_status_mask |= TXX9_SIDISR_UOER;
+			up->ignore_status_mask |= TXX9_SIDISR_UOER;
 	}
 
 	/*
 	 * ignore all characters if CREAD is not set
 	 */
 	if ((termios->c_cflag & CREAD) == 0)
-		up->port.ignore_status_mask |= TXX9_SIDISR_RDIS;
+		up->ignore_status_mask |= TXX9_SIDISR_RDIS;
 
 	/* CTS flow control flag */
 	if ((termios->c_cflag & CRTSCTS) &&
-	    (up->port.flags & UPF_TXX9_HAVE_CTS_LINE)) {
+	    (up->flags & UPF_TXX9_HAVE_CTS_LINE)) {
 		sio_set(up, TXX9_SIFLCR,
 			TXX9_SIFLCR_RCS | TXX9_SIFLCR_TES);
 	} else {
@@ -719,8 +696,8 @@ serial_txx9_set_termios(struct uart_port *port, struct ktermios *termios,
 	sio_quot_set(up, quot);
 	sio_out(up, TXX9_SIFCR, fcr);
 
-	serial_txx9_set_mctrl(&up->port, up->port.mctrl);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	serial_txx9_set_mctrl(up, up->mctrl);
+	spin_unlock_irqrestore(&up->lock, flags);
 }
 
 static void
@@ -739,76 +716,73 @@ serial_txx9_pm(struct uart_port *port, unsigned int state,
 		serial_txx9_initialize(port);
 }
 
-static int serial_txx9_request_resource(struct uart_txx9_port *up)
+static int serial_txx9_request_resource(struct uart_port *up)
 {
 	unsigned int size = TXX9_REGION_SIZE;
 	int ret = 0;
 
-	switch (up->port.iotype) {
+	switch (up->iotype) {
 	default:
-		if (!up->port.mapbase)
+		if (!up->mapbase)
 			break;
 
-		if (!request_mem_region(up->port.mapbase, size, "serial_txx9")) {
+		if (!request_mem_region(up->mapbase, size, "serial_txx9")) {
 			ret = -EBUSY;
 			break;
 		}
 
-		if (up->port.flags & UPF_IOREMAP) {
-			up->port.membase = ioremap(up->port.mapbase, size);
-			if (!up->port.membase) {
-				release_mem_region(up->port.mapbase, size);
+		if (up->flags & UPF_IOREMAP) {
+			up->membase = ioremap(up->mapbase, size);
+			if (!up->membase) {
+				release_mem_region(up->mapbase, size);
 				ret = -ENOMEM;
 			}
 		}
 		break;
 
 	case UPIO_PORT:
-		if (!request_region(up->port.iobase, size, "serial_txx9"))
+		if (!request_region(up->iobase, size, "serial_txx9"))
 			ret = -EBUSY;
 		break;
 	}
 	return ret;
 }
 
-static void serial_txx9_release_resource(struct uart_txx9_port *up)
+static void serial_txx9_release_resource(struct uart_port *up)
 {
 	unsigned int size = TXX9_REGION_SIZE;
 
-	switch (up->port.iotype) {
+	switch (up->iotype) {
 	default:
-		if (!up->port.mapbase)
+		if (!up->mapbase)
 			break;
 
-		if (up->port.flags & UPF_IOREMAP) {
-			iounmap(up->port.membase);
-			up->port.membase = NULL;
+		if (up->flags & UPF_IOREMAP) {
+			iounmap(up->membase);
+			up->membase = NULL;
 		}
 
-		release_mem_region(up->port.mapbase, size);
+		release_mem_region(up->mapbase, size);
 		break;
 
 	case UPIO_PORT:
-		release_region(up->port.iobase, size);
+		release_region(up->iobase, size);
 		break;
 	}
 }
 
-static void serial_txx9_release_port(struct uart_port *port)
+static void serial_txx9_release_port(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	serial_txx9_release_resource(up);
 }
 
-static int serial_txx9_request_port(struct uart_port *port)
+static int serial_txx9_request_port(struct uart_port *up)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	return serial_txx9_request_resource(up);
 }
 
-static void serial_txx9_config_port(struct uart_port *port, int uflags)
+static void serial_txx9_config_port(struct uart_port *up, int uflags)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
 	int ret;
 
 	/*
@@ -818,14 +792,14 @@ static void serial_txx9_config_port(struct uart_port *port, int uflags)
 	ret = serial_txx9_request_resource(up);
 	if (ret < 0)
 		return;
-	port->type = PORT_TXX9;
-	up->port.fifosize = TXX9_SIO_TX_FIFO;
+	up->type = PORT_TXX9;
+	up->fifosize = TXX9_SIO_TX_FIFO;
 
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	if (up->port.line == up->port.cons->index)
+	if (up->line == up->cons->index)
 		return;
 #endif
-	serial_txx9_initialize(port);
+	serial_txx9_initialize(up);
 }
 
 static const char *
@@ -856,7 +830,7 @@ static const struct uart_ops serial_txx9_pops = {
 #endif
 };
 
-static struct uart_txx9_port serial_txx9_ports[UART_NR];
+static struct uart_port serial_txx9_ports[UART_NR];
 
 static void __init serial_txx9_register_ports(struct uart_driver *drv,
 					      struct device *dev)
@@ -864,22 +838,20 @@ static void __init serial_txx9_register_ports(struct uart_driver *drv,
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_txx9_port *up = &serial_txx9_ports[i];
+		struct uart_port *up = &serial_txx9_ports[i];
 
-		up->port.line = i;
-		up->port.ops = &serial_txx9_pops;
-		up->port.dev = dev;
-		if (up->port.iobase || up->port.mapbase)
-			uart_add_one_port(drv, &up->port);
+		up->line = i;
+		up->ops = &serial_txx9_pops;
+		up->dev = dev;
+		if (up->iobase || up->mapbase)
+			uart_add_one_port(drv, up);
 	}
 }
 
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 
-static void serial_txx9_console_putchar(struct uart_port *port, unsigned char ch)
+static void serial_txx9_console_putchar(struct uart_port *up, unsigned char ch)
 {
-	struct uart_txx9_port *up = to_uart_txx9_port(port);
-
 	wait_for_xmitr(up);
 	sio_out(up, TXX9_SITFIFO, ch);
 }
@@ -893,7 +865,7 @@ static void serial_txx9_console_putchar(struct uart_port *port, unsigned char ch
 static void
 serial_txx9_console_write(struct console *co, const char *s, unsigned int count)
 {
-	struct uart_txx9_port *up = &serial_txx9_ports[co->index];
+	struct uart_port *up = &serial_txx9_ports[co->index];
 	unsigned int ier, flcr;
 
 	/*
@@ -905,10 +877,10 @@ serial_txx9_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Disable flow-control if enabled (and unnecessary)
 	 */
 	flcr = sio_in(up, TXX9_SIFLCR);
-	if (!(up->port.flags & UPF_CONS_FLOW) && (flcr & TXX9_SIFLCR_TES))
+	if (!(up->flags & UPF_CONS_FLOW) && (flcr & TXX9_SIFLCR_TES))
 		sio_out(up, TXX9_SIFLCR, flcr & ~TXX9_SIFLCR_TES);
 
-	uart_console_write(&up->port, s, count, serial_txx9_console_putchar);
+	uart_console_write(up, s, count, serial_txx9_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -921,8 +893,7 @@ serial_txx9_console_write(struct console *co, const char *s, unsigned int count)
 
 static int __init serial_txx9_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port;
-	struct uart_txx9_port *up;
+	struct uart_port *up;
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -936,16 +907,15 @@ static int __init serial_txx9_console_setup(struct console *co, char *options)
 	if (co->index >= UART_NR)
 		co->index = 0;
 	up = &serial_txx9_ports[co->index];
-	port = &up->port;
-	if (!port->ops)
+	if (!up->ops)
 		return -ENODEV;
 
-	serial_txx9_initialize(&up->port);
+	serial_txx9_initialize(up);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
-	return uart_set_options(port, co, baud, parity, bits, flow);
+	return uart_set_options(up, co, baud, parity, bits, flow);
 }
 
 static struct uart_driver serial_txx9_reg;
@@ -986,9 +956,9 @@ int __init early_serial_txx9_setup(struct uart_port *port)
 	if (port->line >= ARRAY_SIZE(serial_txx9_ports))
 		return -ENODEV;
 
-	serial_txx9_ports[port->line].port = *port;
-	serial_txx9_ports[port->line].port.ops = &serial_txx9_pops;
-	serial_txx9_ports[port->line].port.flags |=
+	serial_txx9_ports[port->line] = *port;
+	serial_txx9_ports[port->line].ops = &serial_txx9_pops;
+	serial_txx9_ports[port->line].flags |=
 		UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
 	return 0;
 }
@@ -1009,14 +979,14 @@ static DEFINE_MUTEX(serial_txx9_mutex);
 static int serial_txx9_register_port(struct uart_port *port)
 {
 	int i;
-	struct uart_txx9_port *uart;
+	struct uart_port *uart;
 	int ret = -ENOSPC;
 
 	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
-		if (uart_match_port(&uart->port, port)) {
-			uart_remove_one_port(&serial_txx9_reg, &uart->port);
+		if (uart_match_port(uart, port)) {
+			uart_remove_one_port(&serial_txx9_reg, uart);
 			break;
 		}
 	}
@@ -1024,24 +994,24 @@ static int serial_txx9_register_port(struct uart_port *port)
 		/* Find unused port */
 		for (i = 0; i < UART_NR; i++) {
 			uart = &serial_txx9_ports[i];
-			if (!(uart->port.iobase || uart->port.mapbase))
+			if (!(uart->iobase || uart->mapbase))
 				break;
 		}
 	}
 	if (i < UART_NR) {
-		uart->port.iobase = port->iobase;
-		uart->port.membase = port->membase;
-		uart->port.irq      = port->irq;
-		uart->port.uartclk  = port->uartclk;
-		uart->port.iotype   = port->iotype;
-		uart->port.flags    = port->flags
+		uart->iobase = port->iobase;
+		uart->membase = port->membase;
+		uart->irq      = port->irq;
+		uart->uartclk  = port->uartclk;
+		uart->iotype   = port->iotype;
+		uart->flags    = port->flags
 			| UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
-		uart->port.mapbase  = port->mapbase;
+		uart->mapbase  = port->mapbase;
 		if (port->dev)
-			uart->port.dev = port->dev;
-		ret = uart_add_one_port(&serial_txx9_reg, &uart->port);
+			uart->dev = port->dev;
+		ret = uart_add_one_port(&serial_txx9_reg, uart);
 		if (ret == 0)
-			ret = uart->port.line;
+			ret = uart->line;
 	}
 	mutex_unlock(&serial_txx9_mutex);
 	return ret;
@@ -1056,16 +1026,16 @@ static int serial_txx9_register_port(struct uart_port *port)
  */
 static void serial_txx9_unregister_port(int line)
 {
-	struct uart_txx9_port *uart = &serial_txx9_ports[line];
+	struct uart_port *uart = &serial_txx9_ports[line];
 
 	mutex_lock(&serial_txx9_mutex);
-	uart_remove_one_port(&serial_txx9_reg, &uart->port);
-	uart->port.flags = 0;
-	uart->port.type = PORT_UNKNOWN;
-	uart->port.iobase = 0;
-	uart->port.mapbase = 0;
-	uart->port.membase = NULL;
-	uart->port.dev = NULL;
+	uart_remove_one_port(&serial_txx9_reg, uart);
+	uart->flags = 0;
+	uart->type = PORT_UNKNOWN;
+	uart->iobase = 0;
+	uart->mapbase = 0;
+	uart->membase = NULL;
+	uart->dev = NULL;
 	mutex_unlock(&serial_txx9_mutex);
 }
 
@@ -1108,9 +1078,9 @@ static int serial_txx9_remove(struct platform_device *dev)
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_txx9_port *up = &serial_txx9_ports[i];
+		struct uart_port *up = &serial_txx9_ports[i];
 
-		if (up->port.dev == &dev->dev)
+		if (up->dev == &dev->dev)
 			serial_txx9_unregister_port(i);
 	}
 	return 0;
@@ -1122,10 +1092,10 @@ static int serial_txx9_suspend(struct platform_device *dev, pm_message_t state)
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_txx9_port *up = &serial_txx9_ports[i];
+		struct uart_port *up = &serial_txx9_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			uart_suspend_port(&serial_txx9_reg, &up->port);
+		if (up->type != PORT_UNKNOWN && up->dev == &dev->dev)
+			uart_suspend_port(&serial_txx9_reg, up);
 	}
 
 	return 0;
@@ -1136,10 +1106,10 @@ static int serial_txx9_resume(struct platform_device *dev)
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_txx9_port *up = &serial_txx9_ports[i];
+		struct uart_port *up = &serial_txx9_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			uart_resume_port(&serial_txx9_reg, &up->port);
+		if (up->type != PORT_UNKNOWN && up->dev == &dev->dev)
+			uart_resume_port(&serial_txx9_reg, up);
 	}
 
 	return 0;
@@ -1195,10 +1165,10 @@ pciserial_txx9_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 
 static void pciserial_txx9_remove_one(struct pci_dev *dev)
 {
-	struct uart_txx9_port *up = pci_get_drvdata(dev);
+	struct uart_port *up = pci_get_drvdata(dev);
 
 	if (up) {
-		serial_txx9_unregister_port(up->port.line);
+		serial_txx9_unregister_port(up->line);
 		pci_disable_device(dev);
 	}
 }
@@ -1206,10 +1176,10 @@ static void pciserial_txx9_remove_one(struct pci_dev *dev)
 #ifdef CONFIG_PM
 static int pciserial_txx9_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
-	struct uart_txx9_port *up = pci_get_drvdata(dev);
+	struct uart_port *up = pci_get_drvdata(dev);
 
 	if (up)
-		uart_suspend_port(&serial_txx9_reg, &up->port);
+		uart_suspend_port(&serial_txx9_reg, up);
 	pci_save_state(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, state));
 	return 0;
@@ -1217,12 +1187,12 @@ static int pciserial_txx9_suspend_one(struct pci_dev *dev, pm_message_t state)
 
 static int pciserial_txx9_resume_one(struct pci_dev *dev)
 {
-	struct uart_txx9_port *up = pci_get_drvdata(dev);
+	struct uart_port *up = pci_get_drvdata(dev);
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
 	if (up)
-		uart_resume_port(&serial_txx9_reg, &up->port);
+		uart_resume_port(&serial_txx9_reg, up);
 	return 0;
 }
 #endif
@@ -1302,9 +1272,9 @@ static void __exit serial_txx9_exit(void)
 	platform_driver_unregister(&serial_txx9_plat_driver);
 	platform_device_unregister(serial_txx9_plat_devs);
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_txx9_port *up = &serial_txx9_ports[i];
-		if (up->port.iobase || up->port.mapbase)
-			uart_remove_one_port(&serial_txx9_reg, &up->port);
+		struct uart_port *up = &serial_txx9_ports[i];
+		if (up->iobase || up->mapbase)
+			uart_remove_one_port(&serial_txx9_reg, up);
 	}
 
 	uart_unregister_driver(&serial_txx9_reg);
-- 
2.35.1

