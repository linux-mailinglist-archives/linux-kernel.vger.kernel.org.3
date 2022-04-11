Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A614FBA30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbiDKK4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242944AbiDKK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:56:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF3B66;
        Mon, 11 Apr 2022 03:54:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BEF7B1F864;
        Mon, 11 Apr 2022 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZerlGPbUKJimvy/JfSiMdoliwsvNPzbIyI2d3xS2sA=;
        b=jKBS1gxFjFS2L0lvZzwY6/8PWeEDtzFPqsSoA/sSJRLhmm3LZKwfn9h98EPnyksH4dlSF2
        pm6h40ZPgCrKAHSE13RUKIQz5TmdIjQYv0s5XmUsBw8F9qXLzquINCgFKhgypojuymh8IR
        aVsfuqj2affL7TBZ1eUsdYq2AOV035A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZerlGPbUKJimvy/JfSiMdoliwsvNPzbIyI2d3xS2sA=;
        b=YR5Zisd7n9pGM438Ki4ZAqEkMxG6YsgxDj+bmS9on50uiNSzp5XRkMA9D+SfvBVNyUA0t5
        fBHa60OaCK4dl3DQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 96A1EA3B83;
        Mon, 11 Apr 2022 10:54:07 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] tty: serial: introduce uart_port_tx{,_limit}() helpers
Date:   Mon, 11 Apr 2022 12:54:03 +0200
Message-Id: <20220411105405.9519-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411105405.9519-1-jslaby@suse.cz>
References: <20220411105405.9519-1-jslaby@suse.cz>
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

Many serial drivers do the same thing:
* send x_char if set
* keep sending from the xmit circular buffer until either
  - the loop reaches the end of the xmit buffer
  - TX is stopped
  - HW fifo is full
* check for pending characters and:
  - wake up tty writers to fill for more data into xmit buffer
  - stop TX if there is nothing in the xmit buffer

The only differences are:
* how to write the character to the HW fifo
* the check of the end condition:
  - is the HW fifo full?
  - is limit of the written characters reached?

So unify the above into two helpers:
* uart_port_tx_limit() -- the generic one, it performs the above taking
  into account the written characters limit
* uart_port_tx() -- calls the above with ~0 as the limit. So it only
  checks the HW fullness.

We need three more hooks in struct uart_ops for all this to work:
* tx_ready() -- returns true if HW can accept more data.
* put_char() -- write a character to the device.
* tx_done() -- when the write loop is done, perform arbitrary action
  before potential invocation of ops->stop_tx() happens.

NOTE1: Maybe the three hooks in uart_ops above are overkill. We can
instead pass pointers to the three functions directly to the new helpers
as they are not used elsewhere. Similar to uart_console_write() and its
putchar().

NOTE2: These two new helper functions call the hooks per every character
processed. I was unable to measure any difference, provided most time is
spent by readb (or alike) in the hooks themselves.  First, LTO might
help to eliminate these explicit calls (we might need NOTE1 to be
implemented for this to be true). Second, if this turns out to be a
problem, we can introduce a macro to build the helper in the driver's
code instead of serial_core. That is, similar to wait_event().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst | 28 ++++++++++++
 drivers/tty/serial/serial_core.c           | 53 ++++++++++++++++++++++
 include/linux/serial_core.h                |  9 ++++
 3 files changed, 90 insertions(+)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 06ec04ba086f..7dc3791addeb 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -80,6 +80,34 @@ hardware.
 
 	This call must not sleep
 
+  tx_ready(port)
+	The driver returns true if the HW can accept more data to be sent.
+
+	Locking: port->lock taken.
+
+	Interrupts: locally disabled.
+
+	This call must not sleep.
+
+  put_char(port, ch)
+	The driver is asked to write ch to the device.
+
+	Locking: port->lock taken.
+
+	Interrupts: locally disabled.
+
+	This call must not sleep.
+
+  tx_done(port)
+	When the write loop is done, the driver can perform arbitrary action
+	here before potential invocation of ops->stop_tx() happens.
+
+	Locking: port->lock taken.
+
+	Interrupts: locally disabled.
+
+	This call must not sleep.
+
   set_mctrl(port, mctrl)
 	This function sets the modem control lines for port described
 	by 'port' to the state described by mctrl.  The relevant bits
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6a8963caf954..1be14e90066c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -107,6 +107,59 @@ void uart_write_wakeup(struct uart_port *port)
 }
 EXPORT_SYMBOL(uart_write_wakeup);
 
+static bool uart_port_tx_always_ready(struct uart_port *port)
+{
+	return true;
+}
+
+/**
+ * uart_port_tx_limit -- transmit helper for uart_port
+ * @port: from which port to transmit
+ * @count: limit count
+ *
+ * uart_port_tx_limit() transmits characters from the xmit buffer to the
+ * hardware using @uart_port::ops::put_char(). It does so until @count
+ * characters are sent and while @uart_port::ops::tx_ready() still returns
+ * non-zero (if non-NULL).
+ *
+ * Return: number of characters in the xmit buffer when done.
+ */
+unsigned int uart_port_tx_limit(struct uart_port *port, unsigned int count)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	bool (*tx_ready)(struct uart_port *) = port->ops->tx_ready ? :
+		uart_port_tx_always_ready;
+	unsigned int pending;
+
+	for (; count && tx_ready(port); count--, port->icount.tx++) {
+		if (port->x_char) {
+			port->ops->put_char(port, port->x_char);
+			port->x_char = 0;
+			continue;
+		}
+
+		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+			break;
+
+		port->ops->put_char(port, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;
+	}
+
+	if (port->ops->tx_done)
+		port->ops->tx_done(port);
+
+	pending = uart_circ_chars_pending(xmit);
+	if (pending < WAKEUP_CHARS) {
+		uart_write_wakeup(port);
+
+		if (pending == 0)
+			port->ops->stop_tx(port);
+	}
+
+	return pending;
+}
+EXPORT_SYMBOL(uart_port_tx_limit);
+
 static void uart_stop(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d4828e69087a..c990a20b9989 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -37,6 +37,9 @@ struct gpio_desc;
  */
 struct uart_ops {
 	unsigned int	(*tx_empty)(struct uart_port *);
+	bool		(*tx_ready)(struct uart_port *);
+	void		(*put_char)(struct uart_port *, unsigned char ch);
+	void		(*tx_done)(struct uart_port *);
 	void		(*set_mctrl)(struct uart_port *, unsigned int mctrl);
 	unsigned int	(*get_mctrl)(struct uart_port *);
 	void		(*stop_tx)(struct uart_port *);
@@ -321,6 +324,12 @@ struct uart_driver {
 };
 
 void uart_write_wakeup(struct uart_port *port);
+unsigned int uart_port_tx_limit(struct uart_port *port, unsigned int count);
+
+static inline unsigned int uart_port_tx(struct uart_port *port)
+{
+	return uart_port_tx_limit(port, ~0U);
+}
 
 /*
  * Baud rate helpers.
-- 
2.35.1

